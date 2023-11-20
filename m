Return-Path: <netdev+bounces-49236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E327F149A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99931C2164C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB341B270;
	Mon, 20 Nov 2023 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCG0phmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5603EE
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 05:48:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso6054781a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488101; x=1701092901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJEcPrftOCQiwoBUv/LVvltgaVFjTmTbPTakja1VzxI=;
        b=XCG0phmkBQn81qZ1K6KIzf642ydtOphGXC9nrC1NnNXuq16i4g/Pmc4+aH9/sa/NTU
         veJoPJRwfJJZM3A8GX/h/oZL/dyBTBH3i4VdEjEcV08TaSrrEhjLmR9b0p2zZtuV/FhW
         czV0qrjNQHLLLN23wqjbPvx23xcGe5zmnNDk+s4uAeg9ZEWCf/RgAUizRecn0i3MeYxS
         oHBlwzY4e1BVZcgY0zAdWUkfxTXVUTKTAEjYrApBi9jVZWIwn9CYIR51IgsqGQR1T3zo
         XDqmsJljLcMLrSJ8DUzyfDIBn8JALcLm30oHEFxgz9nL9MWMGVBxdVh5fhUFSEIVwSBM
         ZyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488101; x=1701092901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJEcPrftOCQiwoBUv/LVvltgaVFjTmTbPTakja1VzxI=;
        b=DBeR967tmZ0xC12HGHLvJvISmZ5/I4WrpWd5TlogAV524MIg9Htkml7oX3TEwkWmUL
         MfgmJrZAz0yVGttuu2+1SFzkQ3Cow+w3iRMM/cO1LhWjhwjuJcEYaqCbuwsUjh6kJHtT
         UwjYf097bMCNNBdu3iViN0qXCIJxcekGCTHSO4MmASYRGcXJfIrviG5bEZ2k2FWSOfib
         +GcBXXLLvxOhlcwfH1bpc842Faz+bGGp5yjBI7yS1xKopW7nO/Kvq2uQLFm3kVHIv91l
         J4HoZDsrtiR8MedArNBedOY8m+bz5GOZHDnm6xIWBJcVb9NCtgOvFejT80AAyMxtagLu
         65dg==
X-Gm-Message-State: AOJu0YyDUj9Vv6/2g6Pz5VcyWdirsDhQ55ODfOI9w1oeqNYjbJi95n7Q
	TqZYe61RXZJirPFUSmWABAw=
X-Google-Smtp-Source: AGHT+IGm1XZhsFHXBEo+khoKSlVIdMKuhetC8vQj+pXdFLMi17zNCnlOmZl7LGdiknsW9mDTt1X28g==
X-Received: by 2002:a17:907:c007:b0:9d3:f436:61e5 with SMTP id ss7-20020a170907c00700b009d3f43661e5mr7011101ejc.29.1700488100907;
        Mon, 20 Nov 2023 05:48:20 -0800 (PST)
Received: from skbuf ([188.26.184.68])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm3880566ejg.151.2023.11.20.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:48:20 -0800 (PST)
Date: Mon, 20 Nov 2023 15:48:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231120134818.e2k673xsjec5scy5@skbuf>
References: <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>

Hi Krzysztof,

On Mon, Nov 20, 2023 at 10:20:13AM +0100, Krzysztof Kozlowski wrote:
> No, why do you need it? You should not need MODULE_ALIAS() in normal
> cases. If you need it, usually it means your device ID table is wrong
> (e.g. misses either entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is
> not a substitute for incomplete ID table.
> 
> Entire abstraction/macro is pointless and make the code less readable.

Are you saying that the line

MODULE_DEVICE_TABLE(of, realtek_common_of_match);

should be put in all of realtek-mdio.c, realtek-smi.c, rtl8365mb.c and
rtl8366rb.c, but not in realtek-common.c?

There are 5 kernel modules involved, 2 for interfaces and 2 for switches.

Even if the same OF device ID table could be used to load multiple
modules, I'm not sure
(a) how to avoid loading the interface driver which will not be used
    (SMI if it's a MDIO-connected switch, or MDIO if it's an SMI
    connected switch)
(b) how to ensure that the drivers are loaded in the right order, i.e.
    the switch drivers are loaded before the interface drivers

