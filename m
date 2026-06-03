Return-Path: <netdev+bounces-294921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6NqCnyYIGpD5gAAu9opvQ
	(envelope-from <netdev+bounces-294921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08563B54A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:11:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hgkAWal/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294921-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E707C30088AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452E4921B6;
	Wed,  3 Jun 2026 21:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57952492192
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521059; cv=none; b=CrOE3m6tU3Uij50x5wEbcWQA3xMoVQ/B5l2TrrWhOHncwQXlnxZJUdLPuuiHyWBbkt4FsuHHAEi5bSvIKj7UjQp+JYmVZOs48g1pMhciNEfoO1PNdPFc8x/Hc0akQq2CP1hQtLw9V3lPmudzhY2gjGirSAG2uhkPr7kJiCUMhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521059; c=relaxed/simple;
	bh=/MW/dfW1QSmsbNoYa2vK+Skz7iz1xYiFhdjNaclOh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sc4U/Rck9pHLk+MWFjovW2iS2bnFNsoh7xfft8gRKswGJbAeHok/AuDsH3DYAmxHPE3bGZsJN4uakb0pZZ4qsv/n07qpNzxZN6/0AIonYukhfDh5lSfersCmE9pWrb/7IqF1vi+456cwU3WiMh8ZZQDM8vlceCxQrRqkTelip5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgkAWal/; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so288145e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780521056; x=1781125856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld+uPuSR3PL9BaAhx0L74UA2kQhY22n7gtMWcYpbbc8=;
        b=hgkAWal/njG3Yw3PjMJtuSbdCyl4A1UayrdYCHs8uyNKO8meKXwdiV2v7jpQcABajx
         KAusJYvS+BogStH6qLYF1E23i2P/bFn1tc5aG3G4cHpD9SqvughbrWI7b8QWfTNN4aFr
         Jr6UQ3Wx2M16OQyG/9zXdxjTBxfWFlpkOh+8rd1OwCJ1k4kyNtn3hwXjTdTJaq056VKS
         e/PguH6gvaY4MJQ6HFYx9sPaqTKgi0sc7X7wXCDi0bHV+PLdO2hyjUdatzUYH7JHEZER
         d55Z7h9a0Fp1eVnJZOkMIj0Z1joTSSPFO4ftvSBk4PmOGgWC3XCIuK0dFBop6ld2rXIs
         UXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521056; x=1781125856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ld+uPuSR3PL9BaAhx0L74UA2kQhY22n7gtMWcYpbbc8=;
        b=BpW3H0pXXQTzxie8M1mbhEYnKFbFBUerGGTtW0fpuF3bNL/y35HBQdHdm5vzGJ54MT
         bwXwvOZjmWmZJjXRk1JyechRFETsEQvinLmOO5svcY9ym3lxB7T40tmXTQVJW5kSnyad
         crAtqA2WljWTVGgKQo08XwKUaZmHkxvOizjmHKANNQNdDOhWos9pIcmIq2RlzbyYN8vg
         4wO16tL+GqYQyLF690PG11WsllJ2DbVWSEAEPQFsPdXBlW5eDtC3rqo+ktYXv2zVSgVM
         SwJFPNIyZFoOyiE8e/XftjDgQpC9POx8CJZlA/OR15kGbEE/xBClTghg9SFuCt3gEO3H
         BrRw==
X-Forwarded-Encrypted: i=1; AFNElJ9ya1YY+Z5dyybOQgfl8Ht+utIQUcx53NhPndnJISAhutrFLieXbE7g+3QqepE+PDLgdVi6pWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8h914++rq2dmAx+dXrdooaV7c+wBKYTFi9JvB6ED+rFJPcsn0
	UJBjYUWSzg0utpKTish18Kn9AW0q7dzAIIUQX+nDisbhY3mxpFkJiJmk
X-Gm-Gg: Acq92OGxxeHrPfkR8EvPP8d91J2lsuV4kHvt5ojwebhhZZwN5Nj4fDDADL00ck8k7qe
	g7qyjXvGNluczT1hg/N3f/mXvUai5IP2RwSqHhvPf4GMPJY99GtB0KBJLGCyha1Wo4kkGIeYpdX
	1lGW7xI5HcfqC/NRg/Gv4IeHlBDe+oel+gGKgFGXFxQlAHCUiTQ1+CB84BpOWw+r6LPOusJ1B6+
	RpQtwALVs7Q6RTvjErOjjc0NOb2oAWgcmTz3axfVMXP03/Bm+Can0WkT8O/3PpYxfSXL8co0ZOI
	KLmfU3oRoKJ5CT0260i7f5yUEFyqDn+mIJz84423mwWATEZieZlkym7zaWWn3MV7dgURZWTDpXm
	NiCggW3g2qQ9XATOwrtQ2meYSB6Vx8t8R327R87x60jUAKd6pTvslM5lGjoesDyROdDrhrWx+NM
	5agmvLFCBTwO3rPqiWs75QFoBN5QppPdlBTGmdCKSWnMN34oKrdlqASmUDpHB+vMUuKicU4SI=
X-Received: by 2002:a05:600c:4e87:b0:490:3890:605b with SMTP id 5b1f17b1804b1-490b60de6d0mr84037795e9.31.1780521055640;
        Wed, 03 Jun 2026 14:10:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c6a4sm41801545e9.2.2026.06.03.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 14:10:55 -0700 (PDT)
Date: Wed, 3 Jun 2026 22:10:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: David Heidelberg <david@ixit.cz>, oe-linux-nfc@lists.linux.dev, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: bound SNL TLV parsing to the skb and
 add length checks
Message-ID: <20260603221054.316f15fa@pumpkin>
In-Reply-To: <20260603135935.62647-1-doruk@0sec.ai>
References: <20260603135935.62647-1-doruk@0sec.ai>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294921-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0sec.ai:url,0sec.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A08563B54A

On Wed,  3 Jun 2026 15:59:35 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
> pair derived from skb->len, without bounding reads to the actual skb
> data. Three problems followed:
> 
>   - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
>   - The per-TLV header (type, length) was read without checking that two
>     bytes remained.
>   - A declared TLV length could run past the end of the buffer, and an
>     SDREQ with length == 0 made "service_name_len = length - 1" underflow
>     to SIZE_MAX, driving an out-of-bounds read in the following strncmp()
>     / nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
>     without a length check.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Walk the TLV list by pointer, bounded by skb_tail_pointer(), and validate
> each TLV declared length before use. Add explicit length checks for
> SDREQ (>= 1) and SDRES (>= 2).
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2:
>  - Walk by pointer bounded on skb_tail_pointer(); drop the 16-bit
>    offset/tlv_len math and fix the short-frame underflow (David Laight).
>  - Add an SDRES length >= 2 check alongside SDREQ length >= 1 (David Laight).
>  - Bound the SDREQ service-name pr_debug to the field length (no over-read).
>  - Rebased onto linux-nfc for-next (David Heidelberg).
>  net/nfc/llcp_core.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index dc65c719f..d23ca815a 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1286,8 +1286,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  {
>  	struct nfc_llcp_sock *llcp_sock;
>  	u8 dsap, ssap, type, length, tid, sap;
> -	const u8 *tlv;
> -	u16 tlv_len, offset;
> +	const u8 *tlv, *tlv_end;
>  	const char *service_name;
>  	size_t service_name_len;
>  	struct nfc_llcp_sdp_tlv *sdp;
> @@ -1306,21 +1305,28 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  	}
>  
>  	tlv = &skb->data[LLCP_HEADER_SIZE];
> -	tlv_len = skb->len - LLCP_HEADER_SIZE;
> -	offset = 0;
> +	tlv_end = skb_tail_pointer(skb);

Only processing the linear part of the skb deserves a comment.

>  	sdres_tlvs_len = 0;
>  
> -	while (offset < tlv_len) {
> +	while (tlv + 2 < tlv_end) {
>  		type = tlv[0];
>  		length = tlv[1];
>  
> +		if (tlv + 2 + length > tlv_end)
> +			break;
> +
>  		switch (type) {
>  		case LLCP_TLV_SDREQ:
> +			if (length < 1)
> +				break;

I'm pretty sure a zero length 'service_name' makes no sense.

> +
>  			tid = tlv[2];
>  			service_name = (char *) &tlv[3];
>  			service_name_len = length - 1;
>  
> -			pr_debug("Looking for %.16s\n", service_name);
> +			pr_debug("Looking for %.*s\n",
> +				 (int)min_t(size_t, service_name_len, 16),
> +				 service_name);

I'm sure you don't need min_t() here.
In fact if you change the type of service_name_len to int you don't need
the outer cast either.
The domain of the value is [0..254] it isn't going to overflow.

>  
>  			if (service_name_len == strlen("urn:nfc:sn:sdp") &&
>  			    !strncmp(service_name, "urn:nfc:sn:sdp",
> @@ -1380,6 +1386,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  			break;
>  
>  		case LLCP_TLV_SDRES:
> +			if (length < 2)
> +				break;

Someone with knowledge of the protocol can probably tell you that the
length should be exactly 2.

-- David

> +
>  			mutex_lock(&local->sdreq_lock);
>  
>  			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
> @@ -1408,7 +1417,6 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  			break;
>  		}
>  
> -		offset += length + 2;
>  		tlv += length + 2;
>  	}
>  


