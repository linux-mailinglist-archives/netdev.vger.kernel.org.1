Return-Path: <netdev+bounces-123455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DC3964ECF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B11C22DBE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF821B86FA;
	Thu, 29 Aug 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVmbsWvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D347A76
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959765; cv=none; b=FFLc3014WyOIQ2uzFrt9rMXWD0paZcnR9yetkxThlQMYw7zq2HQv5y/BokBqswVOyKP+iynoLMHwqElIqhUTal7Y5kXNkFBx5pb8Bj3aPN+/rQ7RdwZNhlJsDktgiD3Ir1vnXnDMJMLxGlOyZplOeVknVGjQLLVq/WIKenX2sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959765; c=relaxed/simple;
	bh=ov47JCh6mm+d/mFxsDbqJXMyoA4R7QdeEicLHAI3LYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Elqe80Ek2An0wsg7lbkSofLsm66O1JOE/Pa1h/lwUOW1onJEGk2/qhWOs9bCElPpMiSTvvVcjZqsxwH+RxNdIh+HHYEyhf4qmtDpqNrYdqR8Vq6d0L4WDopN/+9yzaRBjfkr6j/Anwx2Vn9BWcGKlZ/XfdLRin9y3wFQkeaf4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVmbsWvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF67C4CEC1;
	Thu, 29 Aug 2024 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959765;
	bh=ov47JCh6mm+d/mFxsDbqJXMyoA4R7QdeEicLHAI3LYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVmbsWvFWle2ph3jJBkGuXd1CkhYCNzA1BaDwYXPy5CVrsEIjgP+92Es9zqyASUL/
	 4zeJz/4OICH92Z/EtLLR3eT42Q9DhtKlRqXKie4hI4TbgDOC6BIyU25M9ZICdnQW+T
	 bUgd8oioZ5Snr1rYJW9SdYuYvIDqGSlnR4BTpQq1cx50/G4t4Xp1swM1GsJtpuSXgt
	 w4+Ldj5uvsvsSc2M1x0j3fO5z6vRedeWL7oX9tGOS+g09j3m4/WUnNB3iffUdmooPd
	 0kJyyKUoyzqV5S0Ff4lA/SCFhPSbVeMlZaGCNkMSDxsGdRsDGG2rGhxqICAt7JVR5o
	 PdudxMvAYTkCA==
Date: Thu, 29 Aug 2024 12:29:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Message-ID: <20240829122923.33b93bad@kernel.org>
In-Reply-To: <20240828160145.68805-3-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
	<20240828160145.68805-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 00:01:45 +0800 Jason Xing wrote:
> One more important and special thing is that we should take care of
> errqueue recv path because we rely on errqueue to get our timestamps
> for sendmsg(). Or else, If the user wants to read when setting
> SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
> for example, in TCP case. So we should consider those
> SOF_TIMESTAMPING_TX_* flags.

I read this 3 times, I don't know what you're trying to say.

