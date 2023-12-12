Return-Path: <netdev+bounces-56315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D1080E7D7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680551F21505
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BA58AA0;
	Tue, 12 Dec 2023 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjeH5HZ1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191EE3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702373781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulgkJkr2BclVGQijX69+Fcom9572Ad68+KiNZiUrm/4=;
	b=UjeH5HZ1xjmHSat+vpF/hNmr3l0plQpjbNQKSL5zHeiqzLUhc8XmmynY6hACmxqgmP5NWm
	i2k7FM+bZQLLTlLqGnGdc5hEqrP/ybW9QlM+UFy36QW+Jribnp1bjiTP04/RPibQMfo6tV
	tNFqFHrb6Obh37zKeFaeLWe3JKIL2bw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-nh2NXXt2NxO3sgWhjwFMww-1; Tue, 12 Dec 2023 04:36:19 -0500
X-MC-Unique: nh2NXXt2NxO3sgWhjwFMww-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1df644f6a8so88629266b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373778; x=1702978578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulgkJkr2BclVGQijX69+Fcom9572Ad68+KiNZiUrm/4=;
        b=ZK5FXufv2M91HAUFs/CwSX2e4Fmj0tK+94Bq+di0NEMx5xggOInYafxDT2PLrXOU37
         DZfM/Cewu75gQRRrid2UOSwMd0HhqFtLhrw/OiSDXO14JavvNB3GNRVwYSS5ML7KMTPp
         klHPupAj7o6/ggU3y1B55ol2BP8Tffh3NxdxXZbXmndi6zW0ow9Z19kufqcbJY4PaYtR
         domVJtwnWFcUfoTRr/HCkxwOeFsp7vCkd0zQ2J3JJThmWS4Fn4TroMVxLIBAXxK/A0e5
         hIg+vCbUepWhp5q//zzdSZojXTx0w4bdWNGDAyxK36eH3bdUvhxvsdrqalPCVQ2rI1bQ
         PtQg==
X-Gm-Message-State: AOJu0YxbGtnRvaLkkdGqULVkNz/YsygErPwtJJgIuX9x65w55+2avofV
	6FtcFR+ImoSAVrwB4VNhGF2JzjlOrsXylavK/QORzieapPufylphQqQaUxsdYWUrb121MakGXJp
	uUtou7siiR7+Ah616
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr6789058ejc.7.1702373778332;
        Tue, 12 Dec 2023 01:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbuVLhoXZUdea1M2y0EVwc4fJ8d5/0C1C7ra1R7UrRKoLwIRKUzJcxxASM0USMbsrFs/Q4+Q==
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr6789042ejc.7.1702373777970;
        Tue, 12 Dec 2023 01:36:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906530700b00a1b32663d7csm5987635ejo.102.2023.12.12.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:36:17 -0800 (PST)
Message-ID: <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
Subject: Re: [PATCH net-next v14 01/13] rtase: Add pci table supported in
 this module
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
 larry.chiu@realtek.com
Date: Tue, 12 Dec 2023 10:36:16 +0100
In-Reply-To: <20231208094733.1671296-2-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	 <20231208094733.1671296-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
[...]
> +static void rtase_remove_one(struct pci_dev *pdev)
> +{
> +	struct net_device *dev =3D pci_get_drvdata(pdev);
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	struct rtase_int_vector *ivec;
> +	u32 i;
> +
> +	for (i =3D 0; i < tp->int_nums; i++) {
> +		ivec =3D &tp->int_vector[i];
> +		netif_napi_del(&ivec->napi);
> +	}

You must unregister the netdev before napi_del or you will risk races.

Cheers,

Paolo


