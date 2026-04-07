Return-Path: <netdev+bounces-276181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOgSMp161Wke6wcAu9opvQ
	(envelope-from <netdev+bounces-276181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7E3B51AA
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99683025D32
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25637DE9A;
	Tue,  7 Apr 2026 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6jriN2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9637BE81
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598193; cv=none; b=bpedKroLxmEmPjE70KtIPmI8P1gzICafU+0yl8wBGhPIX9xRCXU1tT3FOZV4NZFFsHRaCByPNosiOlmwl6ji8p3HzKMRu2by5N7f/W6Xaf5tWgd11JZzU1KxE3RVrwXkAD/7J2kG7bOBYg6duTNIErcQkT3v37ZKdI7BWWVG9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598193; c=relaxed/simple;
	bh=1jil3495Ac657oDKO3UxPnXFJo8x8UsQ0bcwvxPXTPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ex72jsGaW1wRI30a0jta1wselAg3oSx8kDUfMvQBqAR6hDhx1aH++TB4Zr/eQHieqvNyU39eNWUCwX4qRD9K/0xr7r+LZSe+XubkmLD3sY7NTHAe+hgGRNW09x/ioMfZ/x5vk+Mv5Uqo6+3b3OpeGw0uvTh1q/qDfPKCf1QExXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6jriN2z; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501725d888so4444755d50.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598191; x=1776202991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4ecHoQGaYGZcautM7p7Xt/zTL27vruT+bMK7B+9dpU=;
        b=n6jriN2zUdFimJ5dxCubOXbPb14iK5TwXVzKQCG/tq/ldWZfO0wsvH2Z7kQjhxlr0T
         CuD0MdrqOA/DrMQ9Qrjlf/7WupOHC67xcnnQTwA24u/H3TuHKIzCRDT2YHkJvPGvIYGI
         sOVbGMOCFwTfYRw5Y3N/Z+EYB44HXxw+nkNgsidADUlTC2hyD0Xs2co4joatGEoIiMMe
         /63i8hpLiqwU89I5Vv9tWDAo3ZxzProvtizEgAREjBrh6/Ie81MDmaD6KNDR60wSLABF
         VO8kOQgSUcGQW/MBoI+31PaMyKdOEUl3yD5WYfYEmjzjI9f9NkMPeOsQgw1uh1DR1Xub
         4l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598191; x=1776202991;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4ecHoQGaYGZcautM7p7Xt/zTL27vruT+bMK7B+9dpU=;
        b=h8wr+GMxJmBBuy0dxMHnOVTe/rqd3JgAPFtHrRUcJJFvmSZSxRhg8mGfX+bdudK6jY
         5mEpDE03thqTplFA+obnewxSbwjWPUw/iH8dZ6FH9kY4vUa/7+a3i1gE4ijjJXau+tiR
         LLi1oJeNSCt/6Pdpm+I+xGV9uD31a/18BO5U8N0ReZNZwsQG7fsKMKzFH8HF3epZ/Opu
         UfyZEJn3mc2GvZw1RmpGeZ5We1Lu+tMwq3F3sIFrgvFCNPIpn0zxWIgH3cSYQps1/EAN
         F3EjyW6AMAkot8AdN55V0C+BrA6uItZdiDuhIVGRLd4OMxLTd5l7pKXsu3G0+n+jilTs
         oiAw==
X-Gm-Message-State: AOJu0YzjULzHMVkvrSSYUTODgb3+vsXbFbk3jG7qPRKVOg5ny80jy5xx
	+iRBu550qbLux3F6tuhs1iFtx7G+TYC77jEmndEtsWROt1USnByadTcA
X-Gm-Gg: AeBDieuGXx3br72oR/hnjQTKCh8elUgGhPhBjBfJrqjE3zQvlJvBy6J6sD4up8WoZH7
	a2usBfotWKJ5geZN2RH7sjadfRZOCmdI/GYeTvgY5TlMU5aVKYPG+pRideDrMivBe4VwtHGzkyf
	SfIv4Suk232FFHUsY6c9B+VKubOeu3dHHFCTGyXU7eayMFhGAni6FhRTvpoPdM7cMey8+39In0p
	PYIgN+IPwYBr0ztFBibBpvnPC8j/Wo6BmEOecMe9rWTxRT7YOjHszzQHMF3uOeUizIY8BOCSVYh
	YMb8nA4sxi0d2CobBLEKCeLKyqC+977VusCTvY6+4A84o+Wug8F9uD6dKMewqJoOqcd1Vd6E4uy
	EAu6iHaeOPtF5INeItY2u/6phzWxLPr1S2iI4mZ3DDP1zgCXICj8B3KpD7pBpsEht8JcGwMb3/S
	W6cj1x/4JCuAWls7WavLWypwHwr55QyfJnsHO2UJYvbvY0eHQZoYOeTWOXSQdz7XM7/TXj8frqF
	LAw
X-Received: by 2002:a05:690e:130c:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-65048814920mr17876659d50.47.1775598190758;
        Tue, 07 Apr 2026 14:43:10 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6506afc39basm3813583d50.8.2026.04.07.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:43:10 -0700 (PDT)
Date: Tue, 07 Apr 2026 17:43:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 akhilesh.samineni@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.2484afecaca4d@gmail.com>
In-Reply-To: <20260406222305.4111170-3-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-3-akhilesh.samineni@broadcom.com>
Subject: Re: [PATCH net-next 2/3] netdevsim: psp: handle the new crypt-offset
 and spi-threshold get/set operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276181-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[broadcom.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D7E3B51AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Akhilesh Samineni wrote:
> Implement the crypt-offset and spi-threshold get/set in netdevsim PSP.
> 
> Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> ---
>  drivers/net/netdevsim/netdevsim.h | 2 ++
>  drivers/net/netdevsim/psp.c       | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index c904e14f6b3f..3ad7d42391c0 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -117,6 +117,8 @@ struct netdevsim {
>  		struct psp_dev *dev;
>  		u32 spi;
>  		u32 assoc_cnt;
> +		u8  crypt_offset;

Minor: variable names are already not aligned. No need for two spaces.

> +		u32 spi_threshold;
>  	} psp;
>  
>  	struct nsim_bus_dev *nsim_bus_dev;
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> index 0b4d717253b0..9098edf00c5c 100644
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -122,6 +122,11 @@ static int
>  nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
>  		    struct netlink_ext_ack *extack)
>  {
> +	struct netdevsim *ns = psd->drv_priv;
> +
> +	ns->psp.crypt_offset = conf->crypt_offset;
> +	ns->psp.spi_threshold = conf->spi_threshold;
> +
>  	return 0;
>  }
>  
> @@ -249,6 +254,7 @@ int nsim_psp_init(struct netdevsim *ns)
>  	if (err)
>  		return err;
>  
> +	ns->psp.spi_threshold = PSP_SPI_THRESHOLD_DEFAULT;
>  	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
>  	return 0;
>  }
> -- 
> 2.45.4
> 



