Return-Path: <netdev+bounces-49136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE77F0E3E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1131C21435
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70A101EF;
	Mon, 20 Nov 2023 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SJexwnN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B43EB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:56:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507973f3b65so5753695e87.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700470601; x=1701075401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59pC2LHry6cb5cqfhMULcVrIqT91aTViztLNNnCSwLA=;
        b=SJexwnN9N8EtVhSOmDkJ7iuayuk/jKb9c+hTmYuFJdOLgRUwC0z1NMjytqjVMSn22t
         P80s2THPuHwmZ4AylvN0Buzo3ww9FTdHo4EdVuJRFUDYXcwLerhnF9BPraw/5+5wcDtz
         Qa9a8e+Zeifsb++AT64Nu1ShyqxcTLpniH0+m58ff3YSyZNnXMPAwHZzEO3bNRpuXwnD
         JZX4dEci0bba0m2pKB1L3eHA4WKPe7896e4cBf3H8kNnp4x8pw2g19mNjmjhadBkG4Iw
         cv35LqzWWS/X3EE5yfqiMl1yAs3zdKsqplF+xnARBl5+8tYAvpx5OJX1InLHuLzoUkY3
         /38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470601; x=1701075401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59pC2LHry6cb5cqfhMULcVrIqT91aTViztLNNnCSwLA=;
        b=MezFxUdaDKKIxx86PAylOefXbLnrZXj6v9Wsiquw+B1T5HrcNf+pPpIV3HKPUAN7n8
         ne6lacNxXm9+qC4N7ajo2C0X0zh6bvy2SHxxMCc/40Uk70NkwaV/SPnekZga1Ey8UBRG
         Y+yq1GBU2IBJAT+Kd9+0eJ8l5ttkKD3mGl7GGCWWwkwO2duc8PouAFC7wfFtrr25PmrL
         n8nFfU8yEWfd84kWZqk8oVbXT0Y1FSVoQQ8r969imdeiDAUxOQD+1ygqz0I3bm6EMPnS
         1ioOyQAWLERjnnCCV2wuttkrV4PF08ISLiSqO93DfGiE/GWnQd5j6Kyau7LFX6kBgufE
         8lsQ==
X-Gm-Message-State: AOJu0Ywh642dNunjhCArIbwUV4oGw1pO4vPx/192MJWSSW5N74n15ZWy
	lc6puss1zJ7SgY0OnVhkH2LfLg==
X-Google-Smtp-Source: AGHT+IHE45wQIbvUvBpnUSKuVGaK0HGXYQLdyDOslaoOuSDIijD+KTDxVgVYHkC9GH3JKKQYbqNBGQ==
X-Received: by 2002:ac2:532f:0:b0:50a:a337:1f42 with SMTP id f15-20020ac2532f000000b0050aa3371f42mr4869740lfh.36.1700470601250;
        Mon, 20 Nov 2023 00:56:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id f10-20020adfdb4a000000b0032da35baf7bsm10422832wrj.113.2023.11.20.00.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:56:40 -0800 (PST)
Message-ID: <0272299f-40b5-4840-887a-3d017e3f77bb@tuxon.dev>
Date: Mon, 20 Nov 2023 10:56:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm: multi_v7_defconfig: Enable CONFIG_RAVB
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Davis <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
 <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.11.2023 10:44, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 08:00, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> We have a mix of =y and =m for ethernet drivers, and usually
> only have drivers built-in when they are frequently tested
> with NFS root booting.
> 
> Do you need this as well, or could it be =m instead?

I would prefer to have it =y as internal testing infrastructure is using NFS.

Thank you,
Claudiu Beznea

> 
>     Arnd

