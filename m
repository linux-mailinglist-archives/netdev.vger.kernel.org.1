Return-Path: <netdev+bounces-236976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0CC42AFD
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E45F4E66BF
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90D272805;
	Sat,  8 Nov 2025 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rmMD8KVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pd4G8Aug"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29C26F2AA;
	Sat,  8 Nov 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596504; cv=none; b=mIKWNilhQ6agMoWKgjTAHrxUVKq8ugF6vYAgIu7G9C6s9NmbN3FQidj7ibd2rSyXgarsyuLD4SKVdvEeYDF/rd2VH+BAQyCO+sszkT9f46Q51gAFdROJle/WFpUQZC07Skfh4b6B3mUBRBe2mJs0du65g2+5SckTSRIVGx3ILRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596504; c=relaxed/simple;
	bh=7XTBW1cMN2DnA23mi7M7tJKsAuYq7pI390aPWV9JIB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ0fKiQB0APME0E0dLWJt3IsOmNdQ/9NhB57yqnFG22P/eJrOMbw93a3PVaIR0kLcY3x0qZIfK68ZUffjZf4iti3YtB1y1tnx4C+ow1HRBqpJAV5d5HICYROmcpiFxfFdLgF+UYvFtCwIvzgB1rMEER4gIwAoEtnxEUW+L/qXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rmMD8KVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pd4G8Aug; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C0C0AEC0490;
	Sat,  8 Nov 2025 05:08:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 08 Nov 2025 05:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762596499; x=
	1762682899; bh=oIoG5ASLAVQqVOFUnI0HkMIBK4OvJbAUneHj7kVv+e4=; b=r
	mMD8KVx4nfMmG95ymK+ThqzxB7vnFhDWKnZOFJoOy1EGx0n76tHXvXp1Ri9bBcVj
	++396hHv7ioqlkiUSQf3RP/8RMrM1NhA5miku5R8GKq4q3xAPSFB8CGaKWyleuxD
	3QwPDoHYNiAtI9QEO1JIhxkrRpSr4uMdcljEgPyfN5XIN7fme4axQjG+hRvVBAoH
	+XHqMjGjyPzFUYITnmxoaGBE7XfPXhFzaF11Jk0HpfRV+IuB6caZRaVIO4HjrRDY
	DU0uo+RCFUOpFWvjnwrHda8RQHru1tGqC++14KfLdFv/9RWvDPkuRz/AbPxnmZ/q
	73/MYfw6ehppl0IMpDqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762596499; x=1762682899; bh=oIoG5ASLAVQqVOFUnI0HkMIBK4OvJbAUneH
	j7kVv+e4=; b=Pd4G8AugeGqD+MgphDrYA2b+j1sB1sP+SeLp7ojK2++1tx9IbXu
	6zTnE1RioK9B/kbCzzy1TStJgZ1TBMm2U9ihsWA00KuArWHPIEWSbzAZdZ5Ry/m1
	MNdlH5h8LhcI4zzOauSDEC2Llvr80D1DfuoafrslKlFcDRWkaiCpMoUUYwejbaS0
	iUoqNiEZEEjwC2rDqntHBS+U/HYaJI/peOTnKBqqcRotGrvlVY23HmqeLlGKEytq
	pEqfNZ+5VPQkQ0bfzGzYBFYlAA6W9TblBu0kjJNDOdlmXjngzkuqtK2xFzrRe4PD
	QthY1RQIAMD/t1q74dYA9iCwSX/6xOk4GJw==
X-ME-Sender: <xms:kRYPaasVpPffTPp5hftuTNOzdWcNcoT5ZHIsK0bioiC_RDsMZNQHVg>
    <xme:kRYPaZ7pkekd7Nk8JA2uqpnK6Q8XXz2P_NIlNcAZx9ahP39DFG4YUWrie7qOEaUi_
    adb9IQzRSTKpXU7_hReZYOs7_SpRLDK69gJwRe-DWMS7T6UEjRKKcC0>
X-ME-Received: <xmr:kRYPadTqFj_w16WbI8g8zrmVeR03Fl4TUriNJ2SKKN1HJT5pjIixGiVMW-bG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepiihilhhinhesshgvuhdrvgguuhdrtghnpd
    hrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhm
    pdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kRYPacuVHESezjIIMM7AUhynI4h6mSwpxo9sD3kEsv-EORf044yKbA>
    <xmx:kRYPaf_IUTXbEi4P6z3q_72NHwX0Nh23k2HEMl15aGNgXXRD7bE4rA>
    <xmx:kRYPaVy5ZTRS9mXmdZhMha1ZVupAdHfqC4BgfsLLQ-Oo1MjZc-EIDg>
    <xmx:kRYPaR_gUmp8iIzMJAT4otHNDzALKTyXlMnbZFsc1szZ99au7oXdMA>
    <xmx:kxYPaWiAiVVmg2OhoE5C0cy7Rs_SfNth159WLFk6hz_VBocbrZjZumgC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Nov 2025 05:08:17 -0500 (EST)
Date: Sat, 8 Nov 2025 11:08:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_acquire()
Message-ID: <aQ8Wj0fIH9KSEKg7@krikkit>
References: <20251108051054.1259265-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108051054.1259265-1-zilin@seu.edu.cn>

2025-11-08, 05:10:54 +0000, Zilin Guan wrote:
> xfrm_add_acquire() constructs an xfrm_policy by calling
> xfrm_policy_construct(), which allocates the policy structure via
> xfrm_policy_alloc() and initializes its security context.
> 
> However, xfrm_add_acquire() currently releases the policy with kfree(),
> which skips the proper cleanup and causes a memory leak.
> 
> Fix this by calling xfrm_policy_destroy() instead of kfree() to
> properly release the policy and its associated resources, consistent
> with the cleanup path in xfrm_policy_construct().
> 
> Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  net/xfrm/xfrm_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 010c9e6638c0..23c9bb42bb2a 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3035,7 +3035,7 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	}
>  
>  	xfrm_state_free(x);
> -	kfree(xp);
> +	xfrm_policy_destroy(xp);

I agree there's something missing here, but that's not the right way
to fix this. You're calling this function:

void xfrm_policy_destroy(struct xfrm_policy *policy)
{
	BUG_ON(!policy->walk.dead);
[...]


And xfrm_add_acquire is not setting walk.dead. Have you tested your
patch?

Even if we did set walk.dead before calling xfrm_policy_destroy, we
would still be missing the xfrm_dev_policy_delete call that is done in
xfrm_policy_kill for the normal policy cleanup path.

I think we want something more like what xfrm_add_policy does if
insertion fails. In xfrm_policy_construct (which you mention in the
commit message), we don't have to worry about xfrm_dev_policy_delete
because xfrm_dev_policy_add has either not been called at all, or has
failed and does not need extra cleanup.

-- 
Sabrina

