Return-Path: <netdev+bounces-70409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212C84EEDE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F33D1F236B4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787FE1865;
	Fri,  9 Feb 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOzQW0r/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFF184F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446249; cv=none; b=cnwll1tZrstmnellogOtmEPVa1D8OeVr2Fo1JBrMRaiFP7FHKjyI82FRXGQyz4rw4de5QjV2bZb/pCkyENIXqJxQA6hAw7ZhVKLA/ynAnES4te3k2f9WqVSSNo7BoofaGjeJFRO3WhYC5KrHkT5v2o4e4/wOVTk3QiLih6VvU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446249; c=relaxed/simple;
	bh=X5W6TH4RWlsI7gBPfFZEJTK64lhmAijtvtcRP0/xSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA97R6vt5pPgkSxKEJrnW7Dl/cbQcJtnamNaLIjUiGs010yDi1r5cDgdYmfQh2g+SWWyERwqJmS9upfxw/Aeb7ovvydrFKGO/hiQcy7M3UJUWdA1Tg+cGFuC2+Wv2jZgLay5Q6Tz0k6hWre4LTCVl7NlCm3KKiGY2sGuhpfNoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOzQW0r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA7CC433F1;
	Fri,  9 Feb 2024 02:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446248;
	bh=X5W6TH4RWlsI7gBPfFZEJTK64lhmAijtvtcRP0/xSqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lOzQW0r/5p96lOh5U9x7SM9m+A6ifiCoafs2izG0BArideKmc91ldHf1qSn7xn5ym
	 /uk2GYMKTrRUXjdfTlsT2pHULUX702EcGmoLhMjfk0T4+NrdUH1fBaxq2SKIla7blp
	 MWZJr3S3uNOYzuw245UJ6xgxVg7ORMRUiuIoT1GHnDF9vf2P4O5POglStmCMgXcRN0
	 W+N2hrIk16BAY6DXjX3ARfI9xXNpM/Uc4B2OMnaT2nPwA71rIVcqDRLZTC78lgO+LN
	 MNapkdov4QOAkpcjpialjrl2fmdrubestb+Ug7Tnc9LWrVfEmzCt6j+Bvmg36+Zy6V
	 fMQAb575rwkiw==
Date: Thu, 8 Feb 2024 18:37:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/2] net/sched: act_api: speed up netns
 dismantles
Message-ID: <20240208183727.6149cc6f@kernel.org>
In-Reply-To: <20240208102508.262907-1-edumazet@google.com>
References: <20240208102508.262907-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 10:25:06 +0000 Eric Dumazet wrote:
> Adopt the new exit_batch_rtnl() method to avoid extra
> rtnl_lock()//rtnl_unlock() pairs.

Hi Eric! I think these were exploding selftests:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-02-08--18-00&executor=vmksft-net&pw-n=0&pass=0

not 100% sure, but they fit the bill, and once I dropped them the next
branch went thru cleanly.

