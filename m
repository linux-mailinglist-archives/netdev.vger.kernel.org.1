Return-Path: <netdev+bounces-82250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3CB88CF2D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644581F8461E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791B13D63A;
	Tue, 26 Mar 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqRdWdbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979113D60B;
	Tue, 26 Mar 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485714; cv=none; b=GQNFgFSibp8gI+vif/tB14D6nWDIHPjjhpboqTDgaCQ1EmbsCfm1W5hWXQfXilIdwx3F6g0Eaq7Y3BsiJeL5qjNWoQ6qSzLq9in+K0fl6kpHGn3YGlDEt+puxP5vN9h3eve5QZsKAKScmD1tyLtYcsZujs+DloJFB6hc4j0ECiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485714; c=relaxed/simple;
	bh=k8MNtG6ifWbsFm1GbSUjmweRqYhjjniRQH0dyLaVvds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLa35OF7Hf/ndIPyOnKBE22B44XUmVccbtUj9t9npVFluWA4PA7rSTanf66sBQZv5lE5QI0GyKFirmD8QnK1qPgsg5DN3c7GnG9QXPeWlUUiqlTHzJpXOjQsaH2gRB/pHD0xV4psjFwJK3fQtf0WSTEdBFk35yhnv7+IS0O47tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqRdWdbq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso768844866b.3;
        Tue, 26 Mar 2024 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711485711; x=1712090511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gG3X0DxMVLl9Vgs8T7manlOKIHoaQYQVBQdWIT6im8=;
        b=lqRdWdbqBZNZf7s5Xm8WCNbnDlUnGQP28Uu/VndO70GjilahD1Av1Teeo4rUt0LKQk
         sxUlCjStNx3w3ZgIHHxDoOCIfepBZs2qHTQQnlNA2v86o2FdpIravzhZq74vHi0a4hlB
         F96JXMKA3lKr7NKGtzQYW4+57o8HKnI/042anU9ehxMh2FdKFK8bqYBSbzZJWWCVqSng
         3dHH9Ob7M0B6cc7ikML/auL2+vaofTA8aD8l9M+k7wkXdW5ipfP7BLX5gdI8ZqTZl1Ql
         pwEqRaastLQx83pvwzN1F3CmC/M0rkzwk6i4AsSINaTuroc0xA+I+/bQGDENqSbaNdT5
         tbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485711; x=1712090511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gG3X0DxMVLl9Vgs8T7manlOKIHoaQYQVBQdWIT6im8=;
        b=sncSF8ITzf1fnkKSi3AdMg93auB/mZtwHFHpUBnG7PXWtxD86Sn3pB8Y3aVbHiRn40
         MuTKwUeaXqA/UwCwzZ0jSFum+29qa7BXAeNP3BW91ohZAL0K+E2Oc5QYIO/cgwLT91t5
         MqCkY1rOlYVa2WU+4XexQ2aSZisuIMFE/9dMTqekOobVkX9DM2Mr7Pscxp8sGSBpicM+
         +S0WIw0i65/XC+Uj8ay4Mg0T0/HiG/drZU0f2mV+wYxhCJdDTUcRY4EqxPzIBub3Ce60
         QCTn7tp8/LFaOlYCqCcqktMMy9yeVtPeNww5/Dc5vcfIHurEETZZ7L+PahwvYF4Az8OD
         mu1A==
X-Forwarded-Encrypted: i=1; AJvYcCW31lzl2bfazQJnX4f7JKD/okZc0Tebf3LWI0myelEwCfHUe0AfWzipb9JFs3OuWpY9IMHMXQ2FBqc5ohn577KXtTMfAD/hglsehSJ2W9tuTI2es9XVuCTWndafVFBaNJdIDQ==
X-Gm-Message-State: AOJu0YxpcI3k0SuYB7zOdzdpG8isdgJVm5m2654ZpSjV9Bb8333vhBCL
	XpYoW2RYLZnWLPJYMuIu+V3bVAf3owb79G4zibLYwjBtQNS9kvbR
X-Google-Smtp-Source: AGHT+IEypnlFtIG2kDP7N68pZyJIm8S0peBBXbq/Q4TOwOfi+eWCvYbwH3Du9xg+37pGSYuMsONMZw==
X-Received: by 2002:a17:906:275a:b0:a46:3785:4adc with SMTP id a26-20020a170906275a00b00a4637854adcmr7065781ejd.57.1711485710991;
        Tue, 26 Mar 2024 13:41:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id ae12-20020a17090725cc00b00a47522c193asm3282108ejc.196.2024.03.26.13.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:41:50 -0700 (PDT)
Message-ID: <9ea90a1a-37b2-4baf-94af-2b89276a625d@gmail.com>
Date: Tue, 26 Mar 2024 21:41:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240326162305.303598-1-ericwouds@gmail.com>
 <20240326162305.303598-2-ericwouds@gmail.com>
 <20240326192939.GA3250777-robh@kernel.org>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20240326192939.GA3250777-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rob,

On 3/26/24 20:29, Rob Herring wrote:
> On Tue, Mar 26, 2024 at 05:23:04PM +0100, Eric Woudstra wrote:
>> Add the Airoha EN8811H 2.5 Gigabit PHY.
>>
>> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
>>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> 
> Did you change something or forget to add Krzysztof's Reviewed-by?

Nothing has changed in this commit. I was wondering if I should do this,
so I should have added the Reviewed-by Krzysztof.

Best regards,

Eric Woudstra

