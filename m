Return-Path: <netdev+bounces-111724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4409324A2
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486BA1C20B61
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681C198E85;
	Tue, 16 Jul 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA0mOHBt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30E450F2
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128226; cv=none; b=LNORWRS1FZTmbMg+uJwo/qjtczDfqFCY0UFtV2j+Cjodp9ER5Lub5ZlAIS89mqpLBnyYdP00VMJHJCWfM9Whhep9RAzkzxoZfFfcrCPQBb6JUayZ5coZRz5sJgdzP5bq4A7fpytRJfw3A16hAv75mH9oB0RDIgMhi4sEj+/CVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128226; c=relaxed/simple;
	bh=3PokAcAstQHfXj9R369skrziFNWmAmOW8gJjxL70kdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9cuOEZRK4+WlKQFGBDXqrgXMVomYH/MLjk0YgaMSG89m5hbqrqIpHAgUZCE/GF75EPBkboIGaVOMQsecwFqBOafemrBG1cM/NAd+3iRuQmzg3+a9+QJSuEDLJ+0UjMnfp3vDYGPvmNrazmiTalKPZHSyfSohI16WJYGXdakGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA0mOHBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB378C116B1;
	Tue, 16 Jul 2024 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128225;
	bh=3PokAcAstQHfXj9R369skrziFNWmAmOW8gJjxL70kdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JA0mOHBtYIqk4F5tPQT9DWKNA6vNKqz83EAqNc6JQB0yHM3D62+1eTDOnDLhm2CPS
	 PKi6q1ipy5BVFJg9UrFWaCT0dBPKmaex2ckY7+tlae6lp7wlRRzRGJC5QJF8U9s+pm
	 qS+qPQ52coZrQgzGdxsqLc5SgxZLFQJCHKrgn5U7304WeL/Jhdf2+YMHkWy5tg7//p
	 NQQT3sot84mVVjRzngWQ8Q1a1+lBLGga7dYHClDaidJPXEfaqH0rqOyknRXtNjf6By
	 paodVLOZdjuh2RHivUWiYpWG3G4BIRt4KET38tnPZefKzopJXvjK+499haHXveY5Rh
	 qgzB3MWZ54FkA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org,
	edumazet@google.com
Cc: davem@davemloft.net,
	eric.dumazet@gmail.com,
	jmaxwell37@gmail.com,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
Date: Tue, 16 Jul 2024 13:10:12 +0200
Message-ID: <20240716111012.143748-1-ojeda@kernel.org>
In-Reply-To: <20240716015401.2365503-5-edumazet@google.com>
References: <20240716015401.2365503-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Eric, all,

I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 and 6.6:

    net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is uninitialized when used here [-Werror,-Wuninitialized]
                    if (rtx_delta > user_timeout)
                        ^~~~~~~~~
    net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'rtx_delta' to silence this warning
            u32 rtx_delta;
                        ^
                        = 0

I hope that helps!

Cheers,
Miguel

