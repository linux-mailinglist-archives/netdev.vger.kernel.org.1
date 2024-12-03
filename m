Return-Path: <netdev+bounces-148444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398849E1A33
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20BC2855AF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D231E3799;
	Tue,  3 Dec 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="DftX99mk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CB1E32CC
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223723; cv=none; b=ZRXQ9TbCt+dE+zA4JfHBzlkC++tvV9Rxfsryr2eGvDcKYKaPVVB/zyjnFCopDrpWl9deNXxn9G8Hyl55fprjonVrax0UYtFMhTuplKe0sg6OuEf5aDDsRB97AdOP3Z63+yDdCakTfJTBCbmVHyeJvCe7wXx53XtZefxgVC9JZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223723; c=relaxed/simple;
	bh=fl/jjt8B3Y5c8ftzhZ3EbC8pUQ9jZIM3s420nl7R1OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvo9yDVtDpIRPyueQmQSBSZ1r89kjgthLB/081fKZNH68BsqMWdJkFXeW6At6dPiopMyOdxREgQB1QGpbdQ5dIWPjmv/C65lxTuaFscxKIUm1lwrs9ggRiB02xIMgI/S9R7KuOWSWZPRImQu/RzPhA11KJAdysxlxtWHoOMQs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=DftX99mk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df1d1b6e8so5509622e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733223719; x=1733828519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkfRDwLNElVEohls3fZ8jYZMP3zjOs98ZJxmQX82x2w=;
        b=DftX99mkF3zwF2uemf/8EA4psKLuyrbRpot1beNbWd4nliz03HVuicmIsx7WC2KNHR
         CE1HxDB98xT7pCFVE7mlCW0BebwIahxUAsZ6anNLlo/pfqT1PdsG8NleXvRSBS3ctHiJ
         La31yi2Jiik88zkvaNW4ilLD6UuN7UeRWhtvgodGNg0UnRMymuMulXlaIv/MonCKsBDI
         F64cL6mhiiwY8GCk6G8QOZDbIFLMpT8VNPlMe/kXIDk9tS6jtwbmOUVp4F2833ue8yOg
         rzIg3wFEQPFodMJRLJl/K5kxUvsexsyuZqcPgGWVuiJBk/CMkOriDMqx3MxX+Ic3Cuz2
         ur3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223719; x=1733828519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkfRDwLNElVEohls3fZ8jYZMP3zjOs98ZJxmQX82x2w=;
        b=bStFlxbZEACuh189czfvxqdO6Pku/pOg42oTHy8dLihkump33iD9B4vK5MaGj4eJtw
         3XQObEBwi/6nRNB4nn4ymBrXWBMWuPpPLqQIYXw2PciJRWfHxOV+v4lGz8+l5d4m6lN0
         2xv5nImfhSJaaVXr5Cjug82TXNeYnkI9+5LBqYqGWRlKq209cCuCajY27SpzQq+bYJpN
         HGZ+K9K/MjrgEURmH6t5X18SAysQmvhtdejpn8zdQ1E8b8ijw4Sfrsou+Qp10k9dMRKa
         bpVz1P1jm1EHlTsnoQO+3bXZQNxws71NLyc+cw5tGToHeJnYBeqVCVH3WwfJ1OjNYjBH
         aUqA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RvAPw2DNeWfUlCKOO0NnYVltv/RzAoTv/fQCFJ9c1unlWf0V0xuxLxZRB+2UZRPIZSpFds0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/KcszqqF0JqBJ+v4ilx/yc0DZgCtcJqDNgv/OVhNdsfK3Nuk
	vG7JJmsI2PBn0AoCB+vx3l0BTGwMv5FSoeYLu29o4RMYqYC+W0DrLqYZVQGlpVY=
X-Gm-Gg: ASbGncuR7mPxlTbrw/mEiRDdpi/PFB0QHzjA4KRnjkkzPDDu6xlACMJZMJS+xA2nu36
	CVcnTPSb9nAAk5zx88ph1gMYXNrmPAtXJri+TOOXcXOPhkbdPEqzqQE0djm60WcpvH2RtiRKNKL
	jkCrE1Ve6QN2tTzPFnHeVNww+Yrrs2h4xWzyUYPCeLhe9TesZrApNG07zzD/QSCUp822rFJWwQ6
	OHtSCTD1wmxLWZMTH7Le0cRZAK8a8ngPzW/TqEFDACz6YRNgS3cGlhG2aTobL9LWfh8EQ==
X-Google-Smtp-Source: AGHT+IHem3Ue+RglvZ1YfQRNySVN7U9r/Ly1NJZ0174YWN+P0LBRHTYGbG0LFxzanq20fmr2QPSrGQ==
X-Received: by 2002:a05:6512:280b:b0:53d:cb7e:225a with SMTP id 2adb3069b0e04-53e129ff454mr794482e87.24.1733223719329;
        Tue, 03 Dec 2024 03:01:59 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e14f97649sm139843e87.146.2024.12.03.03.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:01:59 -0800 (PST)
Message-ID: <2836f456-aac4-4925-97d6-25f6613fe998@cogentembedded.com>
Date: Tue, 3 Dec 2024 16:01:56 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> As I say, need to see the code. Otherwise... sorry, I'm no longer
> interested in your problem.

We already got valuable information.

I agree that the patch I tried to submit is a wrong way to handle the issue we have. Instead, need to 
improve the PHY driver stub, such that it does not declare no autoneg support for 2.5G Base-T1 PHY.

(creating a real driver for the PHY is not possible at this time due to lack of technical information)

Thank you.

Nikita

