Return-Path: <netdev+bounces-77390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F842871855
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16171C21422
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39414C63A;
	Tue,  5 Mar 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTg1KDcu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1D2E40B;
	Tue,  5 Mar 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627966; cv=none; b=Y4j2Aum7jdbZFcsbkkXNovdpOYhZmIVbpWv8o3wEYt92S3QNdzA4+OJrH6MBxCIdP47ai/cakWv70hIEh5vhAJ2beuvvgIuZkx9zlbmq18GMS92ES3OvB4CPfrWU8a8ffIm5LJ09K3Q4GRjzE/HQhN10or2WCljol8SsIg+WeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627966; c=relaxed/simple;
	bh=ae9g2zG4V0WPNaPZPaB1ZQcqzF10SrO8I9NMmT5TJwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAJBDL9xnTQpxXtXdZZYqwM1Vzhs5h9p/ZBrIcJR2Y3Ea4d6PiYyOK6PYCPmpj/24utHvuD1VsJHILCgY+zWGYs4/nsKANq/XnRQVtJJVLZ1ihBtfZpkY00TTu9jV3N9I0SJyCBMgI3OXALXsAPEW5EypoAKoxkdsKsZenCT2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTg1KDcu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so439679a12.1;
        Tue, 05 Mar 2024 00:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627963; x=1710232763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhbsAtULiyOJSylOkxYo7fP2Od8sQLqI7F7lk7BwLe0=;
        b=RTg1KDcudRBqA0AnHhteJQZebucpZCj3z4CpT2YP/zdYbKTryjtnI2ZS27ftoNurpu
         7hdLOYXRVcwzWsZSXIdkUHDc+axzV+lcwOUM+qt0kuNsu+2KU+s9hKl+8WDtKdRjrwHJ
         2ohntRQnBlLptvAAXrk4n55tXHshw4Rq2k47wEsSAc3dRHXmbumF9/AuEvZpSVX6jybV
         jfZ4CXjesmNU7X9CPaIBHMC+PedUvl8RVDypxVMLC80AhJKn8d4cBu4lXzIerKW6eaob
         1O0ojz3XI+e4OP9Ppk7dgOWak+DBQuFiplqIf59fYszUcLHESnC3iT0E5ESyJm3SDjxG
         nu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627963; x=1710232763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhbsAtULiyOJSylOkxYo7fP2Od8sQLqI7F7lk7BwLe0=;
        b=g/suMmpXxOyzyFbu2VynC5Z4Hc5aitpP8QO+YgB9ohFuuxbEoe/YQd3XiqTfGvXww2
         obdbzmGPEq9WenMJMABWF3RULSCjXMxiR4ZXK1XQjDDtHPJ3pHq4pgBuEx/T9HhZMPkE
         RNUzabiUSOKXCiRn/SrB5rzm43OFWmiv9IFTDMj6GQUP8CCIFx0g3z1ZRY+UMLOIWgeB
         hYRSSruucZTUVU9nqBgjdEgySB2CVfVXh4D15uqMd90MmmosA2N9QnTjgfuNczEZ3CR7
         PVKRFs7eKk4IEW4tki6p8mT8aR5DWN+9ilJ5jWQI7WH+jRprXFPKNy+4Hulr9SMxqJVa
         nG7w==
X-Forwarded-Encrypted: i=1; AJvYcCWoWs8CQJ7HlsOSR5bbODDsEuBnE63VtaMl1Im67IsLMr4mTQr3WQqaGnY77I8C+swSI1bmpF6GbCmThl7CDGdnXCHXoKuBBQ8HmmDgLvXUTmBEKcnHNLxpmGFjqArgGd8kVw==
X-Gm-Message-State: AOJu0Yzpu45AhVm7QXJoV2cRJhM17nslMhcL3mZ2AKrZv+kIFY2VPsVQ
	DPFPGQzAl6+nqTO/Pe+mlXemuFqXe3gCOltjRq9yG5UM/D8DnYXR
X-Google-Smtp-Source: AGHT+IHWWDGiPtYmviwwvBUosV+VegjUi/c0iWDc64GJAwydpSl/cD7WYyqC8qT7YOUVViKAKjZYHw==
X-Received: by 2002:a17:906:a454:b0:a45:7f60:a724 with SMTP id cb20-20020a170906a45400b00a457f60a724mr2196977ejb.72.1709627963473;
        Tue, 05 Mar 2024 00:39:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00a42f6d17123sm5702878eji.46.2024.03.05.00.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:39:23 -0800 (PST)
Message-ID: <fb6c2253-18a3-40ed-a204-5c8bf0959efb@gmail.com>
Date: Tue, 5 Mar 2024 09:39:21 +0100
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
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <20240304180523.GR403078@kernel.org>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20240304180523.GR403078@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Simon,

> I think val needs to be initialised before it is used below.
> 
> Flagged by clang-17 W=1 build.
Thanks. I had changed building to using W=1 after the last message from
robot. But now it seems I've lost these warnings. I definitely will look
into this.

Best regards,

Eric Woudstra

