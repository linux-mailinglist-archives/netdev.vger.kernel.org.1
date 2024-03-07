Return-Path: <netdev+bounces-78480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA1875482
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F54B1F238A2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C012FB0D;
	Thu,  7 Mar 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjXNF9eE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802312F393;
	Thu,  7 Mar 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830215; cv=none; b=TjXaSt5bq0RTKLFJHZWtnc34pXa9VSLGbLSESE3sfSMgivFI8AV56bvcTrhAA0wmLjpMH7ues7qJh4xV9fGCg+ePCkp3cslQmBFID78XBhMA2eJGxwmT6edHRqiDqmWjLuqa0nDNW4DlnVGHSlqesinT5siw17chAPDcFaYuRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830215; c=relaxed/simple;
	bh=CvAcob+7Pk9boKq7ZlSX4MkNBemZUhNAsJyEPgtNrIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZsRA4IZk7geBTsWabOttpy0DF4LLR59mO42dH5nVNntjgBLj6E7gmHTCykAfhRDCeeToP8R2FFVaHpFKDh10WuW9nDY+DaU3hzjVFnd72nhYKGzIzxKvwNgbmpkQNAssIxUz0FX0RUF6o26VvtEizgQ655c87Goy+tvUGNGGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjXNF9eE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso152873566b.2;
        Thu, 07 Mar 2024 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709830212; x=1710435012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NT/VOy+aRsDPVRaEqPCeisR++CzOY34r3g6Ighk1PRs=;
        b=WjXNF9eExM/u11ppPQsXHApsnav0ksF0ZF+GOLXFv/a9f4Joh9UPgZs7HEBRCEIt+5
         QooD02EJEYNTs8f26oWqHfADF9i1wnBDcXg2xsfFfPsoocmcTmVWSkNitimxZAUAfaV6
         CpBLlK1hHpJp+vTzb9/MyXoFW6uTRlYR7FABAiL/dBZX4er9JTzbOmT3k5UnibGduadY
         NJ92AnuYpmRxO63E2cvMrqVikekRXCGtDr2L3Oft5N4MhshnhUpa98lvixCrWYXkuzWT
         XYt5C2lGHfizNFzzzt99GlJjDd5UmR93RU2F8JAuDXdjWPssUNeJxblofYBlvpiayKN9
         NVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830212; x=1710435012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NT/VOy+aRsDPVRaEqPCeisR++CzOY34r3g6Ighk1PRs=;
        b=qFeJ7UB12wSoZ9FmyOq24aKPgo1gNdt3qfTTEDY0ATWH4iaYSGaXMkVpalVvjlQkMd
         jvVQbVLrztowa+z0PcxyTaMLB1Vl4EcBsYJub9I1BgqdN6u1ByRJx4cNfwPiyfA3VBGP
         IauUd2d/+rL1fwbgIWWbJ/FDxAbAaX/8nyu9DLMEv+L9L4nRa0LSu0gbGhMQvijAbzXg
         Ae7MCyhK6i7hqfCLzxSLirrK6JbNbZ5I7ZOIBgWnBITIU+Fu2/on5Pkk/iQIBskB7Puj
         jJpUHVN4R5AnrJKUWV3Yvs14UNRNtB0iM/RChHAWrOdvLJwhu9LrLIKZj392iOC+DAPb
         z3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUzf0HzkE0jOqNCjx3hGmIs+ydQBGNW11W5bgb/c0JuqfDrI/09i2dSPCgzX8dXstXmiwGCVgIAmOqscHsYX/zjzVooiBkdVyawmKDSvu21+kmB6nQKJBaosfBPoBS2eap5VA==
X-Gm-Message-State: AOJu0YzT6m4GsIbIeXmY/slct0Mnmla2v/d3fUKqGUmef1n/fwh9FkxR
	xzCYT4IpJ663pDTlJWQ4FpXkQX1OIEXB58+NIMWXjXAFoI0zr4Jb
X-Google-Smtp-Source: AGHT+IGXPi46bJDG29C4iIKa4gvtpe4Fj8xSI3og1Ulou8scbdB2zMQb+8sJ+gujXJEB9cqgH5maFg==
X-Received: by 2002:a17:906:7c8:b0:a3e:792f:3955 with SMTP id m8-20020a17090607c800b00a3e792f3955mr13153472ejc.62.1709830211680;
        Thu, 07 Mar 2024 08:50:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906b18800b00a43fe2d3062sm8457173ejy.158.2024.03.07.08.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 08:50:11 -0800 (PST)
Message-ID: <f483c036-3b35-46d1-830e-37741b32d7e1@gmail.com>
Date: Thu, 7 Mar 2024 17:50:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
 <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
 <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>
 <0184291e-a3c7-4e54-8c75-5b8654d582b4@lunn.ch>
 <ZecrGTsBZ9VgsGZ+@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZecrGTsBZ9VgsGZ+@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/24 15:24, Russell King (Oracle) wrote:
> On Tue, Mar 05, 2024 at 03:06:45PM +0100, Andrew Lunn wrote:
>>> The only way I can see around this problem would be to look up the
>>> PHY in order to get a pointer to the struct phy_device in the network
>>> device's probe function, and attach the PHY there _before_ you register
>>> the network device. You can then return EPROBE_DEFER and, because you
>>> are returning it in a .probe function, the probe will be retried once
>>> other probes in the system (such as your PHY driver) have finished.
>>> This also means that userspace doesn't see the appearance of the
>>> non-functional network device until it's ready, and thus can use
>>> normal hotplug mechanisms to notice the network device.
>>
>> What i'm thinking is we add another op to phy_driver dedicated to
>> firmware download. We let probe run as is, so the PHY is registered
>> and available. But if the firmware op is set, we start a thread and
>> call the op in it. Once the op exits, we signal a completion event.
>> phy_attach_direct() would then wait on the completion.
> 
> That's really not good, because phy_attach_direct() can be called
> from .ndo_open, which will result in the rtnl lock being held while
> we wait - so this is not much better than having the firmware load
> in .config_init.
> 
> If we drop the lock, then we need to audit what the effect of that
> would be - for example, if the nic is being opened, it may mean
> that another attempt to open the nic could be started. Or it may
> mean that an attempt to configure the nic down could be started.
> Then the original open proceeds and state is now messed up.
> 
> I do get the feeling that trying to work around "I don't want the
> firmware in the initramfs" is creating more problems and pain than
> it's worth.

Then I'll move it to .probe().

Best regards,

Eric Woudstra

