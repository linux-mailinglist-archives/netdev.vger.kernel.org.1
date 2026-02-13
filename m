Return-Path: <netdev+bounces-258641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK+5JQhOj2nnPgEAu9opvQ
	(envelope-from <netdev+bounces-258641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:15:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C60137DE0
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C99E307F02F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B6C364E90;
	Fri, 13 Feb 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dghY7PcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A0364059
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999256; cv=none; b=OkPGe+b5TkRwhRYVXlShB6iSS5rkwkj2WvW19C1ZzF2GCHHkIH6+f1QiNLn3WrqVhnFwXWbv11BEiU8Fmk4fVw9H6b62malciy3YGM1LNzItp973PXDWw8lVab130UW14bo39CjZYLmKlKsXIiRNWft2kZ6Qxq31DPuDpqLcG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999256; c=relaxed/simple;
	bh=gYOA7Jd2sD+F4AI6OhnO4bQgKhYCRfntgN+Nceji7DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lETgm8h/YNtc0f5jg+FevBkfeDFN/fFxSaVwMDpJBNled2iX8ObcK6JtJ51J8l4YVbxPb39QLneEEoAnrsTYsjIkEW0w93f/pnCyF27l+5xktkGazh5TbwZmtGwqFjMkn3qDGim9v2p4JulhR/PjDpQiyBDHI5/SMgj4D4zgXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dghY7PcD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c70ab3b5fcso163379585a.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999254; x=1771604054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgbJ2hZD9atfYQt5BUJcJLNlHTxXKvF+WEu0/IJVXc4=;
        b=dghY7PcDu4mhNNln83RJ8sCUeLOZeMXaL++PIS2JAbS1FgOv85lf4FnJrwG/FAH8bT
         5gGKG9xcs1sM5hiClFHDRU+/zgkclZxm7gcWdFrFftlgMIzMBtifE4fYU6NoHgkudjcJ
         HCPP+QRIcvxPRL0BNJwCslhbbhSjShnD1uDbnKIgIrKil5wb5Uj5njK3St9aBP1mTyWd
         TUcJAOe+rX7JOjvU/2Lk9wR7wa+xRr7wmPHXlzub/zntQ+te58tShzWIKyf/6UatLGu0
         Tf7jSnNxrdhQhXJEWI0te3JVvGt/bZaWGoPrsm4uzy8G5Chg0UtJkQxgmLPceZzoacf/
         2DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999254; x=1771604054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgbJ2hZD9atfYQt5BUJcJLNlHTxXKvF+WEu0/IJVXc4=;
        b=iQg1wwNc/lhJgBwfpxu8EwjReRalirAOT7cFYy+bA+O4laSSLb61TLGlzPYUNYM8OP
         uhpSwl6KXwRASrfEkfPoCvQvSCjl7bDNieDg1pzwaWsxDbf2WWjr6LHgC7XxgSYCflaN
         eD6UresjKUFjEeTtQEkIqjILMOsPw4k1k3zA7riO69tv1/GHeo9jCMuXu1AKl96uSrjW
         RrzZ0nB+BrrA2HPCPKSBgE1aDrzz48Kq1YrLC+d4s/nm7P1cNwCrYWQBzI0lykWshBr3
         nNU/EZMQpGPQ/cpkbtpbZSf5N0/Jq2FrNlgKMctxgxCsCqfSQdg8Onf533RMUL1ybTHw
         4kDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPx6nj6S4jESA21pin6sVeRJmSL17E2aYjphVSHYtijZKgtg+VmSd2GofGzo5HB01WrMSxszs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rjm9wJgBKpwqDXBQvhJPJIpFAcRsAj4UR1pOmeTiwkIdjBTK
	uhgbwExVdY1YdXgP/O7seRN4i8ysMJSeM2v2vtTZnJRj4Lmr0oZzyw5KbH9G8G1CSfE=
X-Gm-Gg: AZuq6aJTC+/4yGhFFdD4D0UJKDi7m725HHyLrXboyMdcPqx9eF6SYZCqOuTRsp7np3B
	LE8Qcb1mmqiHRFBrn4JN0onswjO4RaweVMhhOZNF19eIusKeuLULsdCzyMxCAh6/SWu15D9cIOC
	rqb8X/L0tTI+Pgbg/5BoZ0jaAfZ7aa0FmIUOM/tyYyyLBxStC7y0l0v1u8nKurpZUUJFtFx+ObV
	lKdQv8rl2kO61Rp1Vo74eD/VjECQ49teqVSjeRtAPFZk7XEK2srZS9k7X0iqPPlS7LMSB4gBFQW
	0OoO5R1zdDgN94FupInGooKd0zftsGkqR1cmTp38TmzJ7Mk8Dm4Vf06XIaU+T2GySlq61uONaXA
	+KpqDL0EWzRFNvAfX3lf3aR18jfPI3dpFkl3J9ealaY9OJZt8saw1oS2hMmVa5q6Ut4eVeG9PFR
	Z7QeZiC5noA8jLd3XFb0wAYtpHacnA9UYqWpt8D4nj2yUlS4vQhJblxJTwxQ8VXiF5wsb6TUCNg
	s5EicwpLcPipYU=
X-Received: by 2002:a05:620a:3188:b0:8c6:af59:5e2c with SMTP id af79cd13be357-8cb4bf6a3cbmr8015185a.18.1770999253839;
        Fri, 13 Feb 2026 08:14:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:13 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] sfc: support pio mapping based on cxl
Date: Fri, 13 Feb 2026 11:14:07 -0500
Message-ID: <20260213161410.2945294-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18C60137DE0
X-Rspamd-Action: no action

This review was generated by kreview-0811365ff2. =0D
=0D
This is not an automated email, the reviewer though this report=0D
looked valid enough to consider discussion.=0D
=0D
----=0D
I am completely unfamiliar with this code, but the question it poses=0D
at least seems reasonable.=0D
=0D
~Gregory=0D
----=0D
=0D
On Sat, Feb 01, 2026, Alejandro Lucero wrote:=0D
=0D
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/e=
f10.c=0D
> index fcec81f862ec..2bb6d3136c7c 100644=0D
> --- a/drivers/net/ethernet/sfc/ef10.c=0D
> +++ b/drivers/net/ethernet/sfc/ef10.c=0D
=0D
[ ... ]=0D
=0D
> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx=
_nic *efx)=0D
>  	iounmap(efx->membase);=0D
>  	efx->membase =3D membase;=0D
>=0D
> -	/* Set up the WC mapping if needed */=0D
> -	if (wc_mem_map_size) {=0D
> +	if (!wc_mem_map_size)=0D
> +		goto skip_pio;=0D
> +=0D
> +	/* Set up the WC mapping */=0D
> +=0D
> +#ifdef CONFIG_SFC_CXL=0D
> +	probe_data =3D container_of(efx, struct efx_probe_data, efx);=0D
> +	if ((nic_data->datapath_caps3 &=0D
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&=0D
> +	    probe_data->cxl_pio_initialised) {=0D
> +		/* Using PIO through CXL mapping? */=0D
> +		nic_data->pio_write_base =3D probe_data->cxl->ctpio_cxl +=0D
> +					   (pio_write_vi_base * efx->vi_stride +=0D
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);=0D
> +		probe_data->cxl_pio_in_use =3D true;=0D
> +	} else=0D
> +#endif=0D
> +	{=0D
> +		/* Using legacy PIO BAR mapping */=0D
>  		nic_data->wc_membase =3D ioremap_wc(efx->membase_phys +=0D
>  						  uc_mem_map_size,=0D
>  						  wc_mem_map_size);=0D
> @@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct ef=
x_nic *efx)=0D
>  			nic_data->wc_membase +=0D
>  			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -=0D
>  			 uc_mem_map_size);=0D
> -=0D
> -		rc =3D efx_ef10_link_piobufs(efx);=0D
> -		if (rc)=0D
> -			efx_ef10_free_piobufs(efx);=0D
>  	}=0D
=0D
The CXL path sets nic_data->pio_write_base but does not set=0D
nic_data->pio_write_vi_base, while the legacy path does:=0D
=0D
    nic_data->pio_write_vi_base =3D pio_write_vi_base;=0D
=0D
Since nic_data is kzalloc'd, pio_write_vi_base stays at 0 in the CXL=0D
path.  efx_ef10_link_piobufs() then uses nic_data->pio_write_vi_base=0D
to issue MC_CMD_LINK_PIOBUF commands:=0D
=0D
    MCDI_SET_DWORD(inbuf, LINK_PIOBUF_IN_TXQ_INSTANCE,=0D
                   nic_data->pio_write_vi_base + index);=0D
=0D
and also for the special-case check:=0D
=0D
    if (tx_queue->queue =3D=3D nic_data->pio_write_vi_base) {=0D
=0D
Wouldn't this link PIO buffers to incorrect VI instances when using=0D
CXL, since the local variable pio_write_vi_base has the correct=0D
non-zero value but the struct field was never updated?=0D

