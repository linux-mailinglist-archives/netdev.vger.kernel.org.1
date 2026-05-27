Return-Path: <netdev+bounces-292426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P1yN/Y9F2qg9wcAu9opvQ
	(envelope-from <netdev+bounces-292426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:54:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64145E9414
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69B8E3007B33
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785563C37BA;
	Wed, 27 May 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SIJWy7Cj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Te0+YoKX"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD563F58D9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907326; cv=none; b=nhWnRSuExu5vxoEBGIvB4xadjyXhCCRtgjWPtgExBT9nNIgDWrh+mUyJ3/prdfemW/gOI9cbMvmJB5xqjIR4wNFgGfzp8tOrKqNiQJCzO5Z7P5MKGapF+LXhvXMFyECQDnW6PfGZ7LyAYfdAApxMtG/j1T4vSpYWCQAjUTGhkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907326; c=relaxed/simple;
	bh=1BYY0kaMZ0mypdIHaZf51jeoffCHdk+Myxs0sT/aEmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV5HzYFbg5XK64vucxoVtqSqzqWazH/p/zFmK1sKAG+qBMBzvt+cG4BulLjejUKjSrcZXjtabtiCI9CeDFeRO/lwhbKEtt8tiiA8kKCjrLVy7TtUzb8AY/Rwciq/Yfp1H7nh9B3/zX17OTN5JCzHWt/m3uCuAa5JL8s3TpTQz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SIJWy7Cj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Te0+YoKX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E9747A00FA;
	Wed, 27 May 2026 14:42:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 27 May 2026 14:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1779907322; x=1779993722; bh=1MI3yuwkL1mDBPmawBBgvjLsbtFcjkyw
	t0Xvx5lL4i8=; b=SIJWy7Cj+EEO2XPLzFXqFrkjEACjIMFiNReaE36ZY+qaCUde
	NjYMorcOgjR9O5MdUAkpaFBijotMBS0KeaV3BaxpWixAYhWWDSN72aTxnvTSmxiC
	aeVzHgrFHCWqLmdQFapHLODttrnFyn5ysVeN10XTCLXuiL7jGGPo1auEf/Sz2TKu
	yugNf6xi58vD+LKoyW5Sloouzldj/bnTKyXN9G8FttnoSXp94NbNs/EH9EAd3pf2
	cGAoe1xZqwNXjSGBC22ztGDhVRLx/GVpdh6IIo+L5QTAoaYbluRUgr7EcVQjezN8
	BxH7t3Duzs0WDc+/uVjWzdIuZgqSq0RESRwLZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779907322; x=
	1779993722; bh=1MI3yuwkL1mDBPmawBBgvjLsbtFcjkywt0Xvx5lL4i8=; b=T
	e0+YoKXlmrm+2wZqgw/SN85nsxbI+UMWvnl2MMW8NBiRFWGyiZd2isSorU07vbPP
	Z3+euMBcSKgVvAcNs2aT/hJKDwrSH/mAX+SZYFAh3lxZwwqeZnQEt8pfjdj5QStT
	yC+fZF0uulXoJM0ZWviYL921OamD7JnVMJOuRs6RMRJDNGQgJXxv5Kf7Z1K6RFn2
	lvhLJgcWKZ26XxWkqbUitq70WbsCBniM9gXHuNMfgAt9kd0RuvnBUWmAv7Bg+ktN
	a6VDqipaxhYiYtgvqAoX6sM3jvuxXu1HoL7uBQMcrsHXBHNzORenR6KPQArqT9C5
	f3aLug+VUEs/eJo7Uka8A==
X-ME-Sender: <xms:-ToXapaoUozxCGQoAghv27XZFi_yaS9srzzjyq9jyDqMIGbCJoQYfg>
    <xme:-ToXapXl7IT_kfL-lKL6vO75lnFqiQLrUK3SoIls58_kAHk84ZWBjiWMw5rva0252
    BUITYyrJSkWhT37uIy_zs14O13sPBhrBn2fGR1ku2PVV3VcGb_QoUc>
X-ME-Received: <xmr:-ToXanjmtqCjI4Jzq6gxnqF1HxVpBtmj1xUB6RigRF3OuwTM87NdIK3Ymu_70K3RlumdLUGwX351FknWAade-OE>
X-ME-Proxy-Cause: dmFkZTEENjsluLuzQzvLLSoQ/TvipRS1x1Vv+E1k9UFqb8/7KhxV7BWpDI6lQC9FcKg42n
    h2Qz7y0P9CO5yyJcqUMa8IVxPwRZ0rA47vzxX3aFiktJvsxY+RGDCHmlwD8NnpwRh0rsbG
    zkOaAFJFez//+5yUdW9DVOWeVqWwBSascRgGCE5Hg78ed25hWZz3a5Qszy9l5THp0PSXPE
    V1kt6NJOgROQCVwE9uKkg0swQk/slVaFAt2uN+00vYWcLWY8dYiK8Dvj2dMN7lYyJwM9FU
    83mcJPRk0TgA6eHG5ktqBOQN4dx5PX2RT0BUeROQRpK/ZBhGdNbr/NhvcAxZTDS7p8aKNs
    4IqQ+xr/yuHptaEQ2OUs0xmz3wxgY4CPARN/MmY7PLhBQyZ+xZJQbiPJDD73/KyIMY4STe
    SIVN6PFXlOIvV7+hRRICPt03FzKYiPiwZrHeApBTeZ5FGqHo7npxfM6aF69ozpWsyS93fr
    po5U76hi1bfcDFKcpDAMpLJo4Z+lbjRLuvwIE+dX8ipFW0wr8vLiYpgo09izE9hgL4ymLZ
    /qxy/gChBxHvzNmcZzG83I7PhA1DJfyyHrTRgBvnZphBlGLX347tAZv0Mi9Hoa9XZaWAe0
    6hCHCQMHR6pObE7D376SFjd+CibuYrM7EulK5L3KovMQYL4k24/1OImHB2Lw
X-ME-Proxy: <xmx:-ToXansyAT-HbTXw4ayJZEj3DSA5JRKY3fpyOir9ywufrK4-_MxQWw>
    <xmx:-ToXag5bBGN7J5FPjKNS5LVDwdA2yHZNiadrbs54O5MG2m8Vu46rCg>
    <xmx:-ToXarPIfgtV1fehW736Quo4-AjAqo0v0XOYilKCuKXfIL9bpc7WuA>
    <xmx:-ToXamsVxnJwN8-WYbJD5pnOIR0ogSWsIGQ5NyRhPh_Qob3-ZgKL_g>
    <xmx:-joXahZ8QDZ4VSYErTafM_sZkCNP1ZCBdYu5NpZPc_qxh_cPUQ8PjqaI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 14:42:00 -0400 (EDT)
Date: Wed, 27 May 2026 20:41:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH net-next] xfrm: fix xfrm_dev_offload_ok() returning true
 for software SAs
Message-ID: <ahc69uCgXxxzuoJh@krikkit>
References: <ahcVbeG79PibbM3M@krikkit>
 <20260527164717.23624-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527164717.23624-1-petr.wozniak@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292426-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E64145E9414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-27, 18:47:17 +0200, Petr Wozniak wrote:
> 2026-05-27, Sabrina Dubroca wrote:
> > Incorrectly? IPsec in SW with GSO is a valid setup. I think you're
> > breaking that with your patch.
> 
> Fair point — SW IPsec with GSO is intentional and the patch is too broad.

(this whole email looks like direct c/p from an LLM...)

> The actual observable bug on this platform (MT7988A, EIP-197 async crypto):
> 
>   xfrm_dev_offload_ok() → true (SW SA, dev == NULL)
>   → esp4_gso_encap() marks the skb
>   → validate_xmit_xfrm() → esp_xmit() → async crypto → -EINPROGRESS
>   → validate_xmit_xfrm() returns NULL
> 
> On bridge interfaces (noqueue qdisc), __dev_queue_xmit() takes the
> direct branch, initialises rc = -ENOMEM and never overwrites it
> when skb is NULL → ENOMEM on every packet.
> 
> On real netdevs with a qdisc, sch_direct_xmit() handles NULL
> gracefully and async completion via xfrm_dev_resume() delivers
> the packet correctly.

But the packet is delivered correctly also in the bridge case, right?
Once we enter async crypto, the original datapath becomes irrelevant.

> Where would you suggest the actual fix should go — in the
> bridge/noqueue path, or in validate_xmit_xfrm() / sch_direct_xmit()?

It looks like commit f53c723902d1 ("net: Add asynchronous callbacks
for xfrm on layer 2.") updated the meaning of validate_xmit_xfrm()
returning NULL from "packet was dropped" to "packet was stolen (maybe
dropped, maybe still going)" and this isn't handled well.

I guess validate_xmit_xfrm() could propagate -EINPROGRESS via
ERR_PTR(), and validate_xmit_skb() could return that to its callers.
validate_xmit_skb_list() would need to check IS_ERR_OR_NULL(skb)
instead of !skb, and __dev_queue_xmit() could now differentiate the
EINPROGRESS case from a drop.

-- 
Sabrina

