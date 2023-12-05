Return-Path: <netdev+bounces-53806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17F804B1F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25D3B20BF1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8317727;
	Tue,  5 Dec 2023 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Cxx/1+51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DEC9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 23:31:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso19602671fa.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 23:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701761496; x=1702366296; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SepWLPTpZWep0dny9zoJICu02H+raP6JV2Ac9O/sL1M=;
        b=Cxx/1+51uTKWzFD8FYC9ZmP4bg78PFcjC1GQwUIeG1VEPq8dKOCCki+H8eK+YR2mh3
         hANYoiSZmbYlk2aar5/sJbbLw22a8lmWWY4J/zuuStNBECGxETvNM8dFJFfUILhaQ1le
         fGNa0cpefEO2OO1yvfHmuLgqBjZhbUQAPuQSFnUkNmtEbWt+WRrZzDcaR6NH1DSll4SB
         NEmjt+Fdqy7EMzOnfPdkKn5W8hin2AEkWoofvgV18SlIYPSHSoXD5eyA/RUMM/ii6aEd
         CbHUNXM49T8XurwxhPE2zeSyriBMM21FHePMjJ6QqQFW/+579sYtCnOqgLq190ABzfhC
         zJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761497; x=1702366297;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SepWLPTpZWep0dny9zoJICu02H+raP6JV2Ac9O/sL1M=;
        b=PDxrfx6Fog8Ak1aVtCeaT4H7GQgXbnrdHEkMXbbJZ7lZl6KhNK9XfBWeY2HCFAgNaS
         wpDIs0Ik0SVKM1TnHndMd32OLM6Q6JEynDEM8tgnpfpnEYd6zVtVcL9Dk+bPLMpvlceS
         KTjC+LgQjbdg0g600sWTEFAo9+1UGHNxZj5SKKjNxr/oPh7fXmIvyi8UaelS0lLuqMit
         7OXMJ/4p31X7MHm/xRrNgiYh9B76SDGxf1Ek95ZRxzQWP4PPrjctkeqwcy3nsgcFF1eX
         HXWvuzAx4nBGXLE9A0FiTPg9FXTEg00fGa5bSwi5n+gBvfRFrUeUqCiD6eu4E+SA9sr7
         O6UQ==
X-Gm-Message-State: AOJu0YyQ1136pTcObx53bLGWwARb4LZ1oB/UG6Y88dLx4YCztKqqw+rb
	+st7dwlxppDWwmT1Ofs1Scd6m/M6U6Z5YP+LWiI=
X-Google-Smtp-Source: AGHT+IGDBNzs9WpDpgpRmO39EQ5eFxMKjQplV3/PeUg4z8a1nip69vt1nQjmh0uY8VkW2QqfwYuwIw==
X-Received: by 2002:a2e:9c8c:0:b0:2ca:5d4:c172 with SMTP id x12-20020a2e9c8c000000b002ca05d4c172mr589223lji.23.1701761496568;
        Mon, 04 Dec 2023 23:31:36 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h20-20020a2e5314000000b002c9bb53ee68sm798454ljb.136.2023.12.04.23.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:31:35 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] net: mvmdio: Performance related
 improvements
In-Reply-To: <584efde2-d3f3-4318-ab3c-6011719d5c68@lunn.ch>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
 <584efde2-d3f3-4318-ab3c-6011719d5c68@lunn.ch>
Date: Tue, 05 Dec 2023 08:31:33 +0100
Message-ID: <874jgx9kbu.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, dec 05, 2023 at 04:47, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Dec 04, 2023 at 11:08:08AM +0100, Tobias Waldekranz wrote:
>> Observations of the XMDIO bus on a CN9130-based system during a
>> firmware download showed a very low bus utilization, which stemmed
>> from the 150us (10x the average access time) sleep which would take
>> place when the first poll did not succeed.
>> 
>> With this series in place, bus throughput increases by about 10x,
>> multiplied by whatever gain you are able to extract from running the
>> MDC at a higher frequency (hardware dependent).
>> 
>> I would really appreciate it if someone with access to hardware using
>> the IRQ driven path could test that out, since I have not been able to
>> figure out how to set this up on CN9130.
>
> Hi Tobias
>
> I tested on Kirkwood:
>
>                mdio: mdio-bus@72004 {
>                         compatible = "marvell,orion-mdio";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         reg = <0x72004 0x84>;
>                         interrupts = <46>;
>
> The link is reported as up, ethtool shows the expected link mode
> capabilities, mii-tool dumps look O.K.
>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Very much appreciated Andrew, thank you!

