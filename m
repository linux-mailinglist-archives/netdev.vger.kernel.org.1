Return-Path: <netdev+bounces-297841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgoJCS3SKWp7dwMAu9opvQ
	(envelope-from <netdev+bounces-297841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3A66CF97
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:07:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="C DUmeZi";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Wy8DralP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 829E930799D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C03AC0C6;
	Wed, 10 Jun 2026 21:06:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A798332EBD;
	Wed, 10 Jun 2026 21:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125612; cv=none; b=bIaTVLVKQ44OLLhWhekZQ3F8o9Bw6TnwF5IdiO9PjpScPtnFDuVI+ZPoMdx9MZhlJmdLHr8A/iRN6WNk5eQrod2RuKib/LTzZwfOEcezVdtfEqR1/HaDFYcfO5/+hx6LCLSRhCbCHdBAbTjyBBlkPaA9dfzVNq5Bvj9su3780to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125612; c=relaxed/simple;
	bh=Gu8I7AZcu5Pqi7tAdy5uX9okFvOafv+/nm0muIbVN3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXKSd75tP0GeGleLjWR3mG9lEjtfkSsvQ8cMS3V+mpNcmXPW5tJAkcKybzJJh+ftmWSsAjIu7bFTTDwvXCX4UEqL9wM+hyKhrR1xyBRI/QZa55Y8ft1ObkyA3fJprVnK3mPAmdZk08vvlZG2DcHYf+ZOPMvLxUFnbB+8xoK5hXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CDUmeZiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wy8DralP; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 179BBEC0096;
	Wed, 10 Jun 2026 17:06:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 17:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781125608; x=
	1781212008; bh=7qBCh3gDl1ak4P0bVMUvL6VE/LLHT4oSo+lsPme6ySE=; b=C
	DUmeZiIbT2v8pWMHCJj2y0dMXIquf16glosar8hmpSPDXxkxZRsA4Y7AVot+fdbY
	idcaApzSSpxXfBOnwXKx/BbmhqHQQUBw5cQ7X9ZGZW7tZ7FJ4A2XkYLfvqMGb/92
	wP3X9WaoUwMtnwMxdAm+NXl9+hB3atYj7QfKDG2bZG7qo/5HZ96yf7tqKH7Br4iE
	ZlqPOFsK+jbh7W3sqQiKvCgeH8LDMWA3VM4o9kD+ZD+bLU99gkG3qBg8UF+WiP2Y
	sbQTUa2KjEw5I8L3Yqm/h9zm4a35O6CO3UXWSK9xD5YSwpsm6IvIaFVN03vk0cKy
	fF+9O/ZgBmF0BkwMikQyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781125608; x=1781212008; bh=7qBCh3gDl1ak4P0bVMUvL6VE/LLHT4oSo+l
	sPme6ySE=; b=Wy8DralPWjq7L4bD9RCgRBLnQFoUVa1dpbgjUgOWJWp4f6NKnZe
	C0bWwbiBrFpKXIqdJu00b1b7af2AXvBITc+dxoqDA13W1brc99a13Yb43T1Pr2bE
	hx8DKCAxRKpSukf5YDLowzPKIxCBVvYsARWBd/45Vl2KXiAsnlBFqEQMq/pAhsut
	6/svDbiNuBShvjh3Dj1ixLvcwNDhUECv9D2p5k93YBT3GnFDHMMb9M6rQIzBeF52
	vEZaQgadeHcdnDrJ0u56w0RAwdkMW/moETKHbiI9hWGz8eJOTMgpIkK4goWWtsDQ
	MOuCOAHK2lK1pTjYi/uzxHe5bWHEW31edBg==
X-ME-Sender: <xms:59Epap5mRk7KE72pwzapgFRZLvRvjvdL-XzhGpiEmUJ4IZSzFBQGsw>
    <xme:59EpavB20lxzhnT1ciqukzojNbtzGLgxo3wxuQxROHnFR5BMvX2g2tknVceeFzkH-
    JjEWoo-AL3oPGFK3VfEKhGzpt2qAgZjC85_6xLGkNFo-btWjls1a9I>
X-ME-Received: <xmr:59Epav9RUSu8OcyVVMjfNfGPzqnyTBh11ppxY9IoITeRYRkuiLBVMf7x_6aONHBKyLrru81avdbYWjsc8fqQLgQ>
X-ME-Proxy-Cause: dmFkZTGRWUTkdaP6/sQeM9MdhMG4Z8z+pJd6HMi4aa/ytvVDkQfsNFv4viq7LfTutpCmVm
    ov3s6z95Jsq61+6uuXDE29YvAFsiXElLt6jwI4G59I1UQBHHmHoi3EHHk2tDzgxMdekbMy
    ceMZMKHnjzJS/tVsbiPkKdXTLXCxnk+W96pcxVgJa9a9Gewq3phkNLDFs7UXvu5xZzyLxV
    87OYGb+8rc7VgwOOLlyLGaijNH/I7MvosqTaECmdIPFW/Dw2OUJ4EmkAF9kXZOBNY/FRKr
    46pTKg3ovzg4C223xZXv7szB+pG89u9RTpnaj9qaxfda1FnAvU9Y+3GHYcLY/N8cokgzWX
    krc/Uph/scbX5v3kUHSePaE/4iLx2tiOiEBzAVLXuUNqz2QyvlbIwO+hi4xyXcEum6hsX8
    hRDvtXYYhwJ2PZOQBywN8csunF3tJKGpgKIB8K4/ZeYsCBC81AEZMfHQZCWMfMM4S29QY/
    5wUFhK1oaONKU2DCbTJ5nD8cI3WgAsqNQK7cqq4Qr5nduxTd1xbHowmFFLtj2zvVLhhQ1W
    4wp2aJMlJwhzi9vvgaWL1fLDO+bv2rfsOmF/PWZ9/YeHBbcHfofIkZ/ka7I1W4FlCrjDWN
    0LudBaOBOi+gd6i0iFS+C8O0vTBZtJ2t50/h2gd4EeO0w10ZueUs9mgX+mhg
X-ME-Proxy: <xmx:59EpaiGCyYytw5irCRRyrGRxwdvzUZnfZeW81pnTuAMjDCOlum5eow>
    <xmx:59EpapQvEg6FYZQMvMLjH1LYFFSmFL5_bt7ygBwPbpPTsFJe_1lfWQ>
    <xmx:59EpapTZWu4FJWzSsXQF1Wmy5WSXUaegqpf4Smsgy08UtNgKhic-Sg>
    <xmx:59Epas2mg6Fg7BCNGFVHDo81Ot4kOr-TUb9BPoKFt8ID8PQzEM-wTA>
    <xmx:6NEpaj4KSDibTsYG8ypVPAjeNAI-v-6zoCZGdx58ZMDvIlxxtrHLVdZ0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:06:47 -0400 (EDT)
Date: Wed, 10 Jun 2026 23:06:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	john.fastabend@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next 2/3] docs: net: tls-offload: document
 tls_dev_del, tls_dev_resync, and rekey
Message-ID: <ainR5GAK8LaHJYMP@krikkit>
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609201224.1191391-3-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:email,messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,vger.kernel.org:from_smtp,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:from_mime,krikkit:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EE3A66CF97

2026-06-09, 13:12:23 -0700, Jakub Kicinski wrote:
> Fill in some gaps in the TLS offload doc:
> 
> - describe the tls_dev_del and tls_dev_resync callbacks
> - add a mention of rekeying being out of scope for now
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/tls-offload.rst | 29 ++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
> index c173f537bf4d..a41f46885e8c 100644
> --- a/Documentation/networking/tls-offload.rst
> +++ b/Documentation/networking/tls-offload.rst
> @@ -104,6 +104,29 @@ at the end of kernel structures (see :c:member:`driver_state` members
>  in ``include/net/tls.h``) to avoid additional allocations and pointer
>  dereferences.
>  
> +When the offloaded connection is destroyed the core calls
> +the :c:member:`tls_dev_del` callback so the driver can release per-direction
> +state:
> +
> +.. code-block:: c
> +
> +	void (*tls_dev_del)(struct net_device *netdev,
> +			    struct tls_context *ctx,
> +			    enum tls_offload_ctx_dir direction);
> +
> +``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is provided.
> +
> +The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
> +to synchronize the TCP stream with the record boundaries:
> +
> +.. code-block:: c
> +
> +	int (*tls_dev_resync)(struct net_device *netdev,
> +			      struct sock *sk, u32 seq, u8 *rcd_sn,
> +			      enum tls_offload_ctx_dir direction);
> +
> +See the `Resync handling`_ section for details.

Hmm, this callback is not mentioned at all in the "Resync handling"
section. I think it'd be good to add at least a quick note there about
how/when it's invoked, and what the arguments mean (at least the two
types of sequence numbers, since the rest is identical to the other
driver CBs).

-- 
Sabrina

