Return-Path: <netdev+bounces-294213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sp0kI7bTHmouVgAAu9opvQ
	(envelope-from <netdev+bounces-294213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EB62E3AC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:59:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=moYIVScv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294213-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294213-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57B453020FF7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA13DA7C3;
	Tue,  2 Jun 2026 12:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E13126DA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:58:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405140; cv=none; b=bCdvc39+u5NX7hC9/CA+ov3/zcwaOeaYc7EvE+pjcYFLg9rIW4dbA3RgohyGGw3SZshT3DuMm1V7w3RycTZRlLHCWs+CJw/2/1zFg3/nZ3Otx8Cr9EiIwHP2ro5XiEMSxLbpY9RKigz/Br0dbSjtJ1RHeQ/xOWB2KulELhs/BcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405140; c=relaxed/simple;
	bh=KjFmdNHzoOXwt5tqyf0PhWE/7QYxAsDnyIENzYF/v3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOB0t1bqjGBWY+6bvZZUEBm6EXFEGSyvbMGoas1CKZ4q38V8YvsicpFwwS5YeYLS2bWuu+szUubXFDEJTnx8V3WZ7D+uSLwWeua3kXbLLEUE08MeUR5mg8bnYA+ynJyis6Yay1Dg5P/aKq7C47zOz0n5JpzACKPMHFi5uV3iK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moYIVScv; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso8145365e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405137; x=1781009937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7bRWpujkv4VvgAMdATj8kshXPGj41t4CDDKVHeGBhU=;
        b=moYIVScvED1EsBrXm4TZgppwX2RwcSd4/qem+djbf1OQsdkMMFY/Y2s3Dj++r1n/be
         oUI8BlvhvU6NFBRNttlDwmdq0vK/mreqcMRublmVHphZupdo3UDbiDfgSeKpBldMYZlL
         BjzkigSKF47XxQtxTnljwlPIPW/HfqxIGuVt/+zjnv5L4klp3zhiLtZTy4KmCi3/2uSw
         sGs9A6YXGtl9gnxlOeTf9f3sxQIpOQnAEuSk5tzRR8ESHFNsufASEt7UVXYZ3z2gobgm
         JeMk/pq7EegZdKYls8Z1IUJio40Hrj3rd89ygJ80/zBSPBbfZrJ0Gl5E+FQ7ebW3du55
         ONeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405137; x=1781009937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7bRWpujkv4VvgAMdATj8kshXPGj41t4CDDKVHeGBhU=;
        b=XHM58gkEw5Jyc9zr4fykoThXEUVzREH+1OMwBz6jwz8U/ZkENUNTLfrar6LunFpMlc
         rzLCtgnrWa5ik+Ql3Igznz4D/tSL/PkPQvP2SoP6tXao0iIpXZ8b7xTJoMpehGMNhMEq
         4fjYkyz2srAEen9RmQ6jGr48GrOMl+x//CCdeL026+/UkKiSCzGpBEr8V2rWzpdVjXiL
         92iynBCX3GvJrs5UCrcpmI/FIgILAzBVdqDogGqUUbj99ugP4FIjKfLgIgruuj9sgYvE
         SqUEVKaNsuvwQk/YdiEUR3h8C+JlOE2n9vQ3eyyGCT/d34Wq3Wl2v0gg3tNcnVY2HMp9
         zmKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N5U8I+kRoXecXMf/cJD8yPUJESPcu0Imhxi/hZXsnOXb4SEzkAzF6P6/vLtuX6lMZAklUNAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1tlw2j3JTag3buNULoZKauy44xhirgF2DAjNYAJ251fZpQ8l
	cP/FlSVXxg+jJi5e6dk/T7ABqsUHbLrOq+3XieCCDXdoxirHmgMyvyTs
X-Gm-Gg: Acq92OF8m35okidgZrirshJKHe4N9BmDp9YU8NuNPx+qyw3GZf/EBa/PsLNo+EF3ZPs
	nyfAvjxMbUgQ4wlO6+TDAkgu6GypEzoThaM1XGDFKeBH9VG4uAl3z7fG8E6fYcnqcNrDYrPnvCA
	qCiVqSo4u9RPP2GYS+/D2sccxSDiayh5RdSdqZW3rGhLh2+kY8HoqCQ+32YD8vNc3HneTMGewU9
	YAHXXXteRfRe8c+X0bfr4ev4/rh3+ASIi4XuFpzP9ZEDDo8ONdwKiA/Q60IbMFHCrliPHmDUqip
	8rCc5Bj4dB02kRyWgqhGE8NptccgBT7USZdlj6oxWX00bfd03mfWcaemqlxnPOvRGfBXHKqjARJ
	tIj61DzWwEFMunnjLfxSBoIxkVrptJScYr+17vL9EukZrejgxsnizupyL+LnQAiOtxC+qU4kPaw
	canas7DtC42cIOoYhGCtBSwHsbr2UV84TYyZGs4bDKbssoFanr3t1GOQCfTTKEofHM2xzTjeY=
X-Received: by 2002:a05:600c:c0d2:10b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-490a2938f7cmr205884365e9.25.1780405136821;
        Tue, 02 Jun 2026 05:58:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm112673735e9.0.2026.06.02.05.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:58:56 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:58:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: oe-linux-nfc@lists.linux.dev, david+nfc@ixit.cz, security@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix integer underflow and missing bounds
 checks in TLV parsing
Message-ID: <20260602135610.5f79ed10@pumpkin>
In-Reply-To: <20260525202427.67768-1-doruk@0sec.ai>
References: <20260525202427.67768-1-doruk@0sec.ai>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:oe-linux-nfc@lists.linux.dev,m:david+nfc@ixit.cz,m:security@kernel.org,m:netdev@vger.kernel.org,m:david@ixit.cz,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 160EB62E3AC

On Mon, 25 May 2026 22:24:27 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> Multiple out-of-bounds read vulnerabilities exist in the NFC LLCP TLV
> parsers:
> 
> 1. In nfc_llcp_recv_snl(), when an SDREQ TLV has length == 0,
>    service_name_len = length - 1 underflows to SIZE_MAX (size_t is
>    unsigned). The subsequent strncmp() and nfc_llcp_sock_from_sn()
>    calls then read unbounded kernel heap memory.
> 
> 2. All LLCP TLV parsing loops (nfc_llcp_recv_snl, nfc_llcp_connect_sn,
>    nfc_llcp_parse_gb_tlv, nfc_llcp_parse_connection_tlv) read tlv[0]
>    and tlv[1] without first verifying that at least 2 bytes remain in
>    the buffer.
> 
> A nearby malicious NFC device can trigger these without authentication --
> LLCP link activation happens automatically after NFC-DEP.
> 
> Fix by adding a minimum length check before the subtraction in the
> SDREQ case, and adding bounds validation at the top of each TLV loop
> iteration.

Why not fix it properly so that it doesn't read beyond the end of the skb.
1) Change offset and tlv_len to be 32bit - no point trying to do 16bit mathx.
2) Worry about non-linear skb - perhaps just process skb_header_len() bytes.
3) Allow for very short frames.
4) Don't read beyond the end of the skb data.

Something like:
	tlv = skb->data + LLCP_HEADER_SIZE;
	tlv_end = skb_tail_pointer(skb);
	for (; tlv + 2 < tlv_end; tlv += 2 + length) {
		type = tlv[0];
		length = tlv[1];
		if (tlv + 2 + length > tlv_end)
			break;

Then as well as the check for length >= 1 in SDREQ (even 1 doesn't make sense),
the SDRES path is missing a check for length >= 2.

-- David

> 
> Found by pwnkit (https://github.com/0sec-labs/pwnkit), an automated
> kernel source review tool by 0sec (https://0sec.ai).
> 
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  net/nfc/llcp_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index XXXXXXX..YYYYYYY 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1300,6 +1300,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  
>  	while (offset < tlv_len) {
> +		if (offset + 2 > tlv_len)
> +			break;
> +
>  		type = tlv[0];
>  		length = tlv[1];
>  
> @@ -1307,6 +1310,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  		switch (type) {
>  		case LLCP_TLV_SDREQ:
> +			if (length < 1)
> +				break;
> +
>  			tid = tlv[2];
>  			service_name = (char *) &tlv[3];
>  			service_name_len = length - 1;
> 


