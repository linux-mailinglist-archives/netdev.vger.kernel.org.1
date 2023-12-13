Return-Path: <netdev+bounces-56921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4E8115F8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42571C20CC5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDF30D16;
	Wed, 13 Dec 2023 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI9lozf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7AE4;
	Wed, 13 Dec 2023 07:19:15 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50d176eb382so7264344e87.2;
        Wed, 13 Dec 2023 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702480754; x=1703085554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3Uqu4NqQPNF2jh2eBUU6anJjJjGTOazrVfjBFPTbG0=;
        b=XI9lozf2RX8YnDbGI5W9ngJyvbRh2uhss+4lBa2wrkJ4/PYcKYeai/mQqtHEKo/I2z
         qGFkjzVStRHaP1gfRUVJyVEhr4DDJWodnvLOhOV58e6cnL+Jca65OvUG0mvhZ9b2uwg3
         PAJlBmOwjq27VtJONJ7hutj1pBwYVFZ4ze/DTf8Ap/EE/jvc8pr/tNplk/Qyu5/ezBEO
         OhWoQoF4+BSazDHXxQclmCglaCPmYs5+DxBInXaKcJ5dDLWXMbfglcEdvNee9dMBLVLS
         aWRN/d7fmrTeQdMH1mTaRQ04vpZr5w+w8h/RlnMmaRO50156tQV7STb4ZJA7WubnCm6Q
         A0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480754; x=1703085554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3Uqu4NqQPNF2jh2eBUU6anJjJjGTOazrVfjBFPTbG0=;
        b=vuW7GSggwWPVobI2O+ElvrpwM3SKlBhhloAz1ygOufuNMaxyXGIfF2tTIe6X3EMnSa
         LO6oEOCUcF26nlFTrRwSNqeoZ6P1C1IOk4Dhqt5mE0Nmgl8GcFlqO1tg9KCqEJ8k1SFe
         TR6J5lJuAeNTC6MVGhNoznMYfMAYFg75uIcmdmqczYI7jCUW52Zat3jm3WouHcYKIgdi
         qMgvl7HNoSCmquSoaU3PaD3ZYV46xpajcpm/B/FbZum/E945Cp53vtP0dC8ZC709eZgp
         fx0PfkjI5MPWdRZbRRcd4qIXhLk6Ui9BIg5xcojIZTVNfGnCxojTHImPt3AMoJ/0mcR7
         XuLQ==
X-Gm-Message-State: AOJu0Yw2bi4r45B0ERHSg0tR7PFJXqWP6IuUagtB8ioFCgEi6XUTGGUs
	iVxZiCCRJhet5Qixrwl4KbM=
X-Google-Smtp-Source: AGHT+IHBBJM+4Q8XpOLjZTdBo/0XImnsmqRu7N70vT9N0+U7CMD4rDwiruktU0T2IwTO4K1nhwfi+w==
X-Received: by 2002:a05:6512:2253:b0:50b:f776:1d63 with SMTP id i19-20020a056512225300b0050bf7761d63mr5029095lfu.44.1702480753667;
        Wed, 13 Dec 2023 07:19:13 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ul5-20020a170907ca8500b00a1f7b445f5dsm6673223ejc.124.2023.12.13.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:19:13 -0800 (PST)
Date: Wed, 13 Dec 2023 17:19:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Message-ID: <20231213151910.hr3n4px7a4upc372@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>

Hi Arınç,

On Sat, Dec 02, 2023 at 11:52:13AM +0300, Arınç ÜNAL wrote:
> Can I receive reviews for patches 6, 12, 13, 14, and 15?
> 
> Thanks.
> Arınç

Sorry, I don't have time to look at this old thread anymore.

Please repost the series with the feedback you got so far addressed.
Also, you can try to split into smaller, more cohesive groups of
patches, that have higher chances of getting merged.

