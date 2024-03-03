Return-Path: <netdev+bounces-76903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C986F587
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06125281733
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B166B5F;
	Sun,  3 Mar 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfCXDPdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10E3EA68
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709476418; cv=none; b=LHy36xhGFQ9mtTG/IRTrZ0hWqDtxBR+JrpBFtscr1pNJju3irm/dHjxjJki3W5IG/A1BuYbOKdi+0j/av1SzUQaONGP33WPFZ7gsCIIt98ltxCBOwS6mPvwPH/mrchCzXiZFlf1L6n6Z4S1SYTIyOZTUQKd1QkUz6+7nkbNT9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709476418; c=relaxed/simple;
	bh=MlredJzGlSKF4+t4LdnWrIVSOJ/rnD1IODaAWRuip6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMuMGst+IMSf6fXNIAl9N5opV67WdCs0fN9xKquF1C25XbCGf9PtXyQWK1UTsM3UJXW/PiQEjPVbxgv5bd4ll3UYVUuSX099Jol+IvUkicfp2ZOLl/YrEo8Qh8xEJZa/6p1WRU89/cgx8SMCSzCEdnULYGfpdi69J+1LSigNvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfCXDPdj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so6073422a12.0
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709476415; x=1710081215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZM96sY+GWG6sHv9ROrgNJq0nit09goqTRZIr3uxP76Q=;
        b=SfCXDPdjbICTg1MramCxMwhSgcptW2nI02xRzh8V7THdeBzcpuFV5ioIGzQbNeGpu4
         40JlTvbhJ+cb9Avw1qrSnxCCsuUkCWIBhZEsJlcgBj/KtQgfejzCVjl/7l/qwFbneLoH
         ouhbHH1f+hpzZgrwkeeBZc/YXWpeMEr5tp53uD8f3jzl6/Hizuo8fY1G+93SgZ/XRaso
         yWqi8qK5R0UYeFselFq+BkPaI2DckqztMzXbAYwrgvWEdp3Km6MuzY/sN63S8fWofOhM
         BtXHLvJSbGyajDShVN9oFQi2YwN+4TAkjO7KhMf2uVDdVYaghdJTlLyd9qIMzxMADkEA
         XbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709476415; x=1710081215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM96sY+GWG6sHv9ROrgNJq0nit09goqTRZIr3uxP76Q=;
        b=qc4cBWYP9ZOSYOfVow30JEUHyUPHEdnTV1325FCtYanaWIaEYwYYW8d93CPQcLI8Rj
         Yw1LS9E2/ChdxSrixN2Q90aUh+F44uSNmze6OZxWh6LCvEtQbP6Y+iqTeD39ymkDpf9E
         6NAfspua5w/9fJuln/St8YVL2Fv4N9WAaBvyzHVX73xOL0lqm57yU7HrJbJhvNq8KFJ+
         fVywU601uDEx5uDVx9RGnZ09CmcWqezLoMkOtEg1Dh2DTsoN4SQwpxRYRQR8C6ZG5LjZ
         ejBjy+z2+8GVzO09wRVo3i+yUTiGCbJ/A4dQq7RVbrHfHHXMD1bisrqLXVBEbTBkBLLa
         nn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUD6aueY74XI3IV48f363DlPNBy1jNJIPNNPs08pdUgM87qfA0eRpnUKexMXwmagjIfDRBkgKdcQktwbYB/w7SKT1+povfL
X-Gm-Message-State: AOJu0Ywrald+cwIhjMePtYVjzrg5d/dV+WY2jBYb+7Evn9Zvs5lJ6Jiw
	7BOZw99zx75KcDTElt9BLyiYCS3k3EJOPDLKPDM8n5rh1QAlnQjq
X-Google-Smtp-Source: AGHT+IHgkUc2mX5b/QYFVFOnelRaj26cJ9fSzsdoHt7vg09Fbi4sVKn9sAkqPVwKucfz1XIQiajStA==
X-Received: by 2002:a50:c8cb:0:b0:561:3b53:d0af with SMTP id k11-20020a50c8cb000000b005613b53d0afmr5078323edh.12.1709476415108;
        Sun, 03 Mar 2024 06:33:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id er8-20020a056402448800b00566d7e27dccsm2435315edb.0.2024.03.03.06.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 06:33:34 -0800 (PST)
Message-ID: <3a11e745-f2ec-4c94-a847-c0627a68a166@gmail.com>
Date: Sun, 3 Mar 2024 15:33:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 Alexander Couzens <lynxis@fe80.eu>
References: <20240303102848.164108-1-ericwouds@gmail.com>
 <20240303102848.164108-2-ericwouds@gmail.com>
 <ZeR7Vs8als7yaWax@makrotopia.org>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZeR7Vs8als7yaWax@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 14:29, Daniel Golle wrote:

>> There is an additional datasheet for RTL8226B/RTL8221B called
>> "SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
>> setup interface and rate adapter mode.
> 
> Gramar doesn't parse, missing verb.

Thanks, I'll correct it.

>> +		.config_init    = rtl822x_config_init,
> 
> Have you tested this on RTL8251B?
> This PHY usually uses 5GBase-R link mode with rate-adapter mode for
> lower speeds. Hence I'm pretty sure that also setting up SerDes mode
> register will be a bit different.

Thanks, I'd better not add following lines for the rtl8251b (2x):

	.config_init    = rtl822x_config_init,
	.get_rate_matching = rtl822x_get_rate_matching,

Until someone with the hardware can test it.

Perhaps we can find a RollBall sfp module that has one on it and use it
on a BPI-R4...

