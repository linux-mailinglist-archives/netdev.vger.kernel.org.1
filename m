Return-Path: <netdev+bounces-101809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57075900249
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541AD1C2268A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7218C326;
	Fri,  7 Jun 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6SBTTTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB518733D;
	Fri,  7 Jun 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760218; cv=none; b=F82eOKgm/kS1LvsfvgswjfcKhL2wFmYVPR+KT4aIEDZpOrpHJmvAC61/QiHYJkFQPePJ1QZ2xkfPZjjW1K7wQhsf2CRgv7XJ2dY6K2dWsiSBsZmTt600noY3vwArB02NqYMDGuLCWSQ/ltzfWPP2JOcwmQahWj5oRN5Z6di74NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760218; c=relaxed/simple;
	bh=rpzWODU2bT7sGpuoqGOokFp3uXQbFOAgqULxwSJrvh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvZe0+tJn3jW9WRqrUtFTzAP411wL5bzbMQj96ZajzE9cidCvV85KnIWGPailrknj6EEKRuyQV6Fgz1l+a+S1SvZPQs4O++ItOSNvdEheu86NVJNRGZftYGFMRDlCMxGF7SEBWJmL9BOXAtpRJ2WNl0N207IzXexfZr9gHUH0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6SBTTTb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so189499966b.3;
        Fri, 07 Jun 2024 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717760215; x=1718365015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GY/6FiPfv14GcfT0b89l65ZFho8Kww/IYVCcpvAJrKA=;
        b=c6SBTTTb/FIsaqeHZas2u/GyHFySVHO1oeDtkJxp06LDzXrElMmUo26qhKURgYOfOk
         zXK1B089cYGlNkkqeNHiK8hrb34a1VE5LFLTg4GAqAWxjtS+fJUNZKsq47GAoUnzF1MK
         FmXGx0i6urO+vGcnSrj+Y6G14jXtzrePuYc1aZZEesdMfnFsK6Bob+VjxHE7hxQAwcpo
         eyMa53FmTSx5bUCooaO90QdKPpPbaUnDx4FUakUnSSGY/9ndPtdNkj95j6RCm2HrExpX
         bI6kZDzpXXH7n+sZY41gZ3LZtXufS0scDEBxeLGSLTU0h1FekmjoBDj0xKKm0nSFEQzL
         i8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760216; x=1718365016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY/6FiPfv14GcfT0b89l65ZFho8Kww/IYVCcpvAJrKA=;
        b=i986Rs/bK5zKjgjXSRFhLz+6y2j81SM+MasDARgsLjUsQnGPKNGOK7K7UM6wL9O41j
         M8NDO76peXDDGVOs07Fn2R9V4cZ3fONnleu1kNOGHV/tc6hLWjIkm6VGiIqDNEnWDqTs
         66YrT+xjcpiSRw1h4eO9g8iYfeGcqWarDVnz0VcQX04/ueoK8ngrNVdQ0zZePNk6YthT
         OLXd5zZwd/k08vHHkAJBd5H5sV1lNK4ugcSOCTbPh5qfFKWrfcB8NeYWV5xcfwgDbxnf
         9jCzf69ey6FiqzbkMlv4eQuHnlhdff7wI7q8AxQKs+MgXL96rKo0QBQsGN1XH0G1okq7
         T6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9ANa4BhPpyknXtlvIw32fyCZNeri7o+LiT2/2FE1b0ugQr3NaFQOK3PX3cDpBkbF00f73ZShr/68nTrmQnTcj/ovF3HsAGyLb86AFhNhIpADt/Jc443QQqdchbpHMyY3zxlXH1bF9uQOpU568ybmjNQRtmD3WG/hJd4S+J0P3rA==
X-Gm-Message-State: AOJu0YxxSGWdLICMrlQ+cavbFZEX4jnx5HQl5Q8wF1RtNuV+86qA5UM6
	B3TvQ973SqxeNh7zz4vvIbo9ofkDslt1RSbHuOTH3S4xVu36oF3G
X-Google-Smtp-Source: AGHT+IEJ3QmW0Edfs+b86Z0zcgNfTh5o9Uuil8Nf9vIR8GRiQGZa0MYGATF+Eo0GdsJnYFZz7qh6OA==
X-Received: by 2002:a17:907:20ed:b0:a6c:8076:1a5e with SMTP id a640c23a62f3a-a6cd7a7e9b6mr191770566b.43.1717760215247;
        Fri, 07 Jun 2024 04:36:55 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e1c1sm230574666b.168.2024.06.07.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:36:54 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:36:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: dsa: lantiq_gswip: Add and use a
 GSWIP_TABLE_MAC_BRIDGE_FID macro
Message-ID: <20240607113652.6ryt5gg72he2madn@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-13-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-13-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:33AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Only bits [5:0] in mac_bridge.key[3] are reserved for the FID. Add a
> macro so this becomes obvious when reading the driver code.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index f2faee112e33..4bb894e75b81 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -238,6 +238,7 @@
>  #define GSWIP_TABLE_MAC_BRIDGE		0x0b
>  #define  GSWIP_TABLE_MAC_BRIDGE_STATIC	BIT(0)		/* Static not, aging entry */
>  #define  GSWIP_TABLE_MAC_BRIDGE_PORT	GENMASK(7, 4)	/* Port on learned entries */
> +#define  GSWIP_TABLE_MAC_BRIDGE_FID	GENMASK(5, 0)	/* Filtering identifier */
>  
>  #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
>  
> @@ -1385,7 +1386,7 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
>  	mac_bridge.key[0] = addr[5] | (addr[4] << 8);
>  	mac_bridge.key[1] = addr[3] | (addr[2] << 8);
>  	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
> -	mac_bridge.key[3] = fid;
> +	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_FID, fid);
>  	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
>  	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_STATIC;
>  	mac_bridge.valid = add;
> -- 
> 2.39.2

On second thought, I disagree with the naming scheme of the
GSWIP_TABLE_MAC_BRIDGE_* macros. It is completely non obvious that they
are non-overlapping, because they have the same name prefix, but:
_STATIC applies to gswip_pce_table_entry :: val[1]
_PORT applies to gswip_pce_table_entry :: val[0]
_FID applies to gswip_pce_table_entry :: key[3]

I think it's all too easy to use the wrong macro on the wrong register field.
If the macros incorporated names like VAL1, KEY3 etc, it would be much
more obvious. Could you please do that?

