Return-Path: <netdev+bounces-213388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CDB24D4B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C441A24A08
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CE22F77F;
	Wed, 13 Aug 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4PxIGkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6A1FECD8;
	Wed, 13 Aug 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098643; cv=none; b=pJwVlL47SKC2Br6Iq5b1RjcRuesKD8BkVpBo9iSngffmtGqlg3Vr1xmuLrzDHww3RXKnFfqSLdR6pR9LZVNwoWgOa9W12IGPCCZsQ5XrkLC+rOWav3USYXaw0S3DwYS1NuFtR7o9Y6dOBysljvHTZw036Cl2Wiy4aVqtdKxSetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098643; c=relaxed/simple;
	bh=UbhBnuInugUu2cTjmEDB4YCiAKRUPYCSJOrFRfqKV7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzCDU5JeTJPLAbbWXEwKC5s2X7saCniN0VYUZtFm0IJADQEPuRxGG44Y82pVC8LJQDQ7RoIqB8kP3onSrQHuSvkSSO8VzUqfs+o/QNJ5hUHZdIPmr2mqe4IHoKM8eWaXNL1BHEqYotdXFg7ehqeURe7rx1PVHadHSQU43xLB2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4PxIGkL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so4486391f8f.3;
        Wed, 13 Aug 2025 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098640; x=1755703440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al/qX1qt84RxLjmC8/RQc6iv8G0Q8rgfIYnhnorUlSI=;
        b=Y4PxIGkLzIt13ISWiN/QQQ3aZia6W+4aLb92UQFx5l9m5u3/qakVBGwZTI9J/k29MV
         3NFormTuObcAfZ+sjjuRmsKrxMW5UqdYCqMMwQpnJwqjxMJR0IxB0k8ObRSNOw/PWZTQ
         VDsLFwEubFd5FTAvW/T9BfaELV5iWUeMQu6KOxDNnYg3yrTW0XG8aRusrLA72Osv7IBs
         fiMudsJjf/FNC1ns6MnaAF0kC+Inr4WaXK/TbOFHiIOHBP7UPnUBbHSwgve0PtDU47De
         wF+7U+dZqZAweX5RuQP68/ri6E1SfEwtdk2RZUvIl2IInnQO4j91gI/eV+wwVfXxenSx
         ketw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098640; x=1755703440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al/qX1qt84RxLjmC8/RQc6iv8G0Q8rgfIYnhnorUlSI=;
        b=Zth0a7z9c1Jg9KvfoJCZghH3oBCtOTRpH60xj4ZYn6Q9G3JPA35m/S0mg8ARqmKMbs
         KLnNDHgEP4uE3LgUf9Iy4cdtBUf9e7DpbmK2102UKrB1GF+Qog562hWt+Q9+Ijqge3VD
         ToABe3jZNiBgf++n76CaFzFgDsoE/kLYlNASWuLcPC/DnmnX57XhFhehumq6mf+85aYd
         5BbhO38O3ib13oU2jrGdBjJOuJCp102MOkRAKSDzT9yeG/a2NiUgN4IPW+LclLMJW2Pe
         ULRLPHPU1CZtlD9GxbiQ0PbGvhxJR9RU8urNCwJTKuWJFbt5qlm9DaHW9tL1IrFX1wwm
         J3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZ0jS0zTr/GcVxHOhrwERYnCJ332z96h7s0kqlagHQekCv/Q3EbQcyI9j2wt9PGM1D7c0rqAF0iswg5bC@vger.kernel.org, AJvYcCXir8oyNNm6PxdeQb5M13NKop/ZzgaFkhruoSFqqNUt2K/9l+6r2WcB6DeHdUULtHb0dfKVQG1WfmKx@vger.kernel.org
X-Gm-Message-State: AOJu0YwfK7nWLgledg8yhpTMaR6+2vp+q1uTzLecxMBmGW6mxI9VH8PG
	V49fTfwlZoD6Ce18MnOZZgbUI4Hq4CcefrEXavbfvOk6btYiOqbOOCXi
X-Gm-Gg: ASbGncsC+LKzgWtVZxbc5TYgJGeU2h9lLD0OCtwKSwlyVlBIL+g7bx8OO4hr+wx2PSt
	e5rkBiATF1+vhmwf7TAgu/0qVabwLmeSO+lAjg9vDKOQSdLWF0gnezqDL27OmjtQZEHTZqlQkpE
	fhDrYkJH27XMatCWmVJUdf9hphUmm5pqYz2KWhDlrBMz0vZp9A7NSjen5lpXCEKVfbZ7732gR+y
	IV6tuH3bs9jqDIg4/M6IwXBLHu78v3v5KjdE3j8UHtoc2n4aw6uV5Xdpv65jaY++amTkrX+3oBC
	MTXMwVAUUTpVc9gCOSZfUhu1EB7L32cpFw0M6bNcENDZINNRHrtAiSVBsuzJYJZYU2Ifh/peGZb
	ApCz+PPR+KUc4ZOFZWQj3Fz9fB1WbeVUxfaXTo0sFFgGAnIwJf5lWBIhK6RFWKWHgSHAAQRLRQg
	qVbol0KCYY
X-Google-Smtp-Source: AGHT+IGYHFONNUotKor9AwdwBpAKxhh3g61crvlGCa5AwvCNjlgzokphZFqfiS3bpgh4iCtgc9HZ1Q==
X-Received: by 2002:a05:6000:1a8b:b0:3a5:39ee:2619 with SMTP id ffacd0b85a97d-3b917ebb5bamr2437420f8f.47.1755098640145;
        Wed, 13 Aug 2025 08:24:00 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8ff860acbsm21721544f8f.51.2025.08.13.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:23:59 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v2 03/10] soc: sunxi: sram: add entry for a523
Date: Wed, 13 Aug 2025 17:23:57 +0200
Message-ID: <2791868.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250813145540.2577789-4-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-4-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:33 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523 has two Ethernet controllers. So in the system controller
> address space, there are two registers for Ethernet clock delays,
> one for each controller.
>=20
> Add a new entry for the A523 system controller that allows access to
> the second register.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/soc/sunxi/sunxi_sram.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sra=
m.c
> index 08e264ea0697..4f8d510b7e1e 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -320,6 +320,10 @@ static const struct sunxi_sramc_variant sun50i_h616_=
sramc_variant =3D {
>  	.has_ths_offset =3D true,
>  };
> =20
> +static const struct sunxi_sramc_variant sun55i_a523_sramc_variant =3D {
> +	.num_emac_clocks =3D 2,
> +};
> +
>  #define SUNXI_SRAM_THS_OFFSET_REG	0x0
>  #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
>  #define SUNXI_SYS_LDO_CTRL_REG		0x150
> @@ -440,6 +444,10 @@ static const struct of_device_id sunxi_sram_dt_match=
[] =3D {
>  		.compatible =3D "allwinner,sun50i-h616-system-control",
>  		.data =3D &sun50i_h616_sramc_variant,
>  	},
> +	{
> +		.compatible =3D "allwinner,sun55i-a523-system-control",
> +		.data =3D &sun55i_a523_sramc_variant,
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
>=20





