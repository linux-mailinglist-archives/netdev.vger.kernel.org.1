Return-Path: <netdev+bounces-293759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEjCNRmEHWqjbQkAu9opvQ
	(envelope-from <netdev+bounces-293759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:07:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE261FD2C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2AF6300370E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346837FF43;
	Mon,  1 Jun 2026 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wGKhpHtC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJgh7YJt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E581E9B37
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319251; cv=none; b=NxT5e60kIBH83KMrDPInXbVsvsy2brqK8go2qbxDM8Cixpdd/TE7+er1axU65bmkM4Q+LKDV/TMBBDsyXv3sllezDglcOaD3ONwCqI88u3OUj8xv0SDTeSblnLzBo3otV3xGLUolDIwqPy3YjtCcrwmBMRGfsK+WB5kXLbQ/bOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319251; c=relaxed/simple;
	bh=DH/45/sC6f6WBjk4ao0C5FOYi+UdbU6Tr8e0s3Aqs7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUlXOZgkV/WapWJOcEAfRQajuZ5oHG/LhcK8I2sVzI1P1qXH6Egw+BL8SBgFNzhSdl6iy1JNKQsDw74lSP+SMXVOpe50x+LYmz+cZ3F/srWpUuR4YpRyjSgbTwrg65QIEDjgZmWNTbkdZ5Jd1PtAgxG6GtwUzmOz0v7NFwMqWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wGKhpHtC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJgh7YJt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8026EEC00FD;
	Mon,  1 Jun 2026 09:07:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 09:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780319247; x=
	1780405647; bh=YMyHJUAiK8w1XjWy97bO5vhhLAp2ANtSrep9zMDx/kM=; b=w
	GKhpHtCj3awSX1LPqTn1njTi37ALL9GFBkkPO7DvPmD5k7GVdWkPTjm4NVRPHxdm
	OyA+a+kq2MX5SKTPGyZxrjdfws3y7sSrS5dQizUusIIaiiZhncT5S/b2V8Wobjll
	uDza4Jk4M+SkvovMCDT1rUc/eka+/xPgTYJMkCtDMa/Qk4jHCkr7hJ00Ef/8Y0te
	2zyDKYpXiaeRePct8QIghq/s6K5FFr2Rrtr5+M0SwDfNVrqVHTLCr6/9doOryqlY
	kxBXjP7g2SDbS/w8x+oG4FC52p5GaPbZVr5G2DLE7i9CbQyE1AHjLrSRtjNT6sjN
	1wAXkjsah7b1yrQuGeSgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780319247; x=1780405647; bh=YMyHJUAiK8w1XjWy97bO5vhhLAp2ANtSrep
	9zMDx/kM=; b=jJgh7YJtTHlfpqzh4jstS6wTA2lE1WVrAgS7aeyEpS8qFZhWvJk
	Br1sQNgTjiVSPEKCY3MgNyEZHu9eGDP/BjSThD+cFMkZ84RXrk4UuJEv+gzjQT0p
	EkfUOdb/Miw5DBg0AyJ/8U9kYw9hqA3+5p2l1enkmPQPC3BodaJipWF6Muy3d46E
	2OKGE170uqDGhnTBomOLwpjGBdEtrois5939l8KKJk2cCnic2jubfPtaLWV9ho7U
	VVc5LbU0Bw3K57KdBolaAzVMo5ZdPu3k8QbJSnFWY4KNm42guDv2wLcnn5NdBWp4
	Dqz4XFCEkq7zCrj+ONwbx9KY+IoylxNw6Vw==
X-ME-Sender: <xms:DYQdasOkTI4Snb4Bwl0xlTO-Ygk16b5d3Nrzw38OCV938oT8cG8-ZA>
    <xme:DYQdakiWG6OZWvfjDtVWxwKvds0uEth-6DNOo2qYYj13PjnO8bSQprWIpiGbyVM6d
    GhhcJohYzfydh8SrO6h5DFyQ5a7WE42a1hXFHGcedTB5KgqMyyzvg>
X-ME-Received: <xmr:DYQdaihDrnwBHMYVvN7I_veFQmdpDxnzPgWEMYIAaC7yfxXro7Lim8jcvnqDg61reoNCxC3l74dD89LGk4b6Eeo>
X-ME-Proxy-Cause: dmFkZTEK+G0kWJwmFwLE8aLtI0HX6X/jyeVFh5T+bcvnKO0bhIPR31sZWVXShYrhD8F4y7
    lYyy+UQiBhpaYqwYuGYsWx83QNYgOJ6F0y7zWczRI1V2+JnSkYLPaqCoohfnVbGDzUh/Wn
    t/4D5XHO/YoWIhRGUhbnXCZay0FxkRSS8P9q3kgAWkExjbDiItD8hR59two6GX4JjUDQpl
    jzwtjjv7kBmxissmpF86efRHHwDLm+GudxpEZgNB9aukN0k/d4g9BTp/tIG2Aj3hO9lP42
    dj5b2mguU5Llv78DFddj3uVwUqn5fE+4VvIzx+ZeoPVvGQov1Zr7AoORSXjpI22I4e3mFB
    UbxsF/a0g+RRFsKU+gi0a3Bd3AsmOZVjHVfPD9zlZKaf10mYimZAaHsdvUomtBvCRwkw19
    m7/UadGIImrqpciXfS6Yt42h9rkuZurTg1+4hbwaTtq6G9ILO9U+9xkqmBT8S+m0/Yuuwx
    WzftuA2Cr/Bgp406QW9kT5N02XmaLsWfJtmBzn0LN/iL3xDs0fTBYk6dnUmajmqkyk2RTk
    5EnvRDx+TFQbqgBJ06g1Mo5991ve3W7VrRg6di06/AzA9d9kvAZLEAsT3wmirmc9Q+7uTr
    zHEo/5EC8/5pWlPpiSH9nhfxS/9rcnARwukcfIp4v5L9pN5/Wea1X6iHm3pQ
X-ME-Proxy: <xmx:DYQdarJZZ2o095-EHFaWaRvnQv8BVBU1mTRYx9teHsUSCxeNkVTTkA>
    <xmx:DYQdapkqSP7J6j0XhTGNaMOaftRvLBq4xx4K-ijyfCRwAQypTpK61Q>
    <xmx:DYQdarMXdmDX-cAr0cf7JiuFPnkOON9YllalDJXSi_vX8ISrY-Fydg>
    <xmx:DYQdar4Kh7uch4dNokS_PsIVS9n19KemojDiDy0vdvcxnMNJOV1WoQ>
    <xmx:D4QdaswWeq-rH7Y6kIWtLGAcslWVIGpcVDE4rO5Ez22epDFbGyz7Mn0l>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:07:25 -0400 (EDT)
Date: Mon, 1 Jun 2026 15:07:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH ipsec 1/1] xfrm: espintcp: wait for pending partial send
 before reuse
Message-ID: <ah2ECw2hRsUEJULZ@krikkit>
References: <cover.1780040524.git.bronzed_45_vested@icloud.com>
 <b05daae0607621114d3818722a46c543ab6ec6fb.1780040524.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b05daae0607621114d3818722a46c543ab6ec6fb.1780040524.git.bronzed_45_vested@icloud.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,gmail.com,lzu.edu.cn,icloud.com];
	TAGGED_FROM(0.00)[bounces-293759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,icloud.com:email,messagingengine.com:dkim,lzu.edu.cn:email,queasysnail.net:dkim]
X-Rspamd-Queue-Id: A4BE261FD2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-30, 13:24:55 +0800, Ren Wei wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
> 
> espintcp keeps a single in-flight transmit in ctx->partial.  Before
> building a new sk_msg, espintcp_sendmsg() first tries to flush that
> state through espintcp_push_msgs().
> 
> For blocking callers, espintcp_push_msgs() may return success while the
> previous partial send is still pending.  espintcp_sendmsg() then
> reinitializes emsg->skmsg and reuses the same ctx->partial slot even
> though the old send has not completed yet.
> 
> Wait for the pending partial send to drain before reusing ctx->partial.
> Nonblocking callers keep the existing error handling, while blocking
> callers sleep until the partial send can make progress.
> 
> This preserves the one-message-at-a-time design already used by the
> espintcp transmit path and avoids overwriting an in-flight partial send.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/xfrm/espintcp.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index a2756186e13a..f8513a19a3c8 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -340,11 +340,20 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  
>  	lock_sock(sk);
>  
> -	err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
> -	if (err < 0) {
> -		if (err != -EAGAIN || !(msg->msg_flags & MSG_DONTWAIT))
> -			err = -ENOBUFS;
> -		goto unlock;
> +	while (emsg->len) {
> +		err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
> +		if (err < 0) {
> +			if (err != -EAGAIN || !(msg->msg_flags & MSG_DONTWAIT))
> +				err = -ENOBUFS;
> +			goto unlock;
> +		}
> +
> +		if (!emsg->len)
> +			break;
> +
> +		err = sk_stream_wait_memory(sk, &timeo);

Is this really useful? espintcp_push_msgs ends up in
tcp_sendmsg_locked, which already has a retry loop that calls
sk_stream_wait_memory. So we just need better handling of in-progress
transfer on return of espintcp_push_msgs (something like
espintcp_push_skb does)?

-- 
Sabrina

