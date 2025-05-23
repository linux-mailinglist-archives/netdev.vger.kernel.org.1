Return-Path: <netdev+bounces-193071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D346AC264C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA64A7BE34E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D815922155B;
	Fri, 23 May 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqpwx6MB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A842063F0;
	Fri, 23 May 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013578; cv=none; b=JI74WI5l3ZJSZU6a7y9Rx+tPHaPnhzsbRbG6BiSkAmCL8ufC7iE/44zvj0pySl835ra0+MDoZ2F8gE0+XxNq8HTfiW9+XY/j1E5eLzCQDpszefHSUsBkNqtl1PLY9A17le12bPYaPBCTpm54c4HIe3MNUfeRRHebqEBp+NElBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013578; c=relaxed/simple;
	bh=MUTMUooBNBaxrKeDsBEQGZ8fMhQnRJ+zQunHq1x5RHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdTKGRRQrtlw4KIxaQGkGTbOSvmoRNUdycIfGwrQv9v+r+QdNsGCoZ9yJAOVETA4c1vzSQaHftauFJe9kHGBLZBV8kTMOtNjOc9kR9ZeHLmiex8X6RvwfOtv7iX/ymoGhZfSwhQnWRHqP0wzrAfSQ9PRznuATqAvHGkgF8k5Wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqpwx6MB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399838db7fso90505b3a.0;
        Fri, 23 May 2025 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748013576; x=1748618376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZn2WhBcVJxJnJwmfHWWP4xV00Tv1IIb5fekcEpd0lY=;
        b=aqpwx6MBJnrJevMsXJWcK9NLEnZHscAWkNcED8tCk79cDjE0ibAxRxbiHh6SXA5O+V
         azAi3VT9VPVwH5FvKyoJDH0/wpkEFMjRdEasv4J8xNa4DOVNNLi9nNN+RX516eSnAjL1
         O0/JWW/nnnbECm+oImrp0Q3KyA+dJJ32bDDMhjkvsSFbL7UYBQtSTGPjHhWFHpqWOeSZ
         zOM2Ezb7esH1Esb5c7y/IXH4adKD98JoRrPbosFRcc3E4gQGN9okTO3mEhG8bd5/Hd4X
         OczH+PU4yWByfMBEpdJZ2RYjSnzzLIGOqsbgt88Dw/zXXKM4eAn2Rxwsw0qPn+jfB+BM
         2fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013576; x=1748618376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZn2WhBcVJxJnJwmfHWWP4xV00Tv1IIb5fekcEpd0lY=;
        b=Qmp5QfpBTws9BHqND+7XL4Umryou7Xp9iVKMiTRJ37/WpaTQ722f0G4E4ihF9bo5fR
         jzk4XhVbniRBBoG1g1XfYxo1KeW1G9bFMEhgbEhN7oJVfPxEdaolLqlhMPm8O6n316f/
         emZ8VByxl7BUdc3VA0mn9rTaH9JfjFIhNRbXdp+BJwXLve7SvpFoIZ81QqzHgRzv4CVP
         xH030qZphSzKK1haGLu9qc/XEtWJMgy1hHPwziMqEwQPNPv9SEX+uYKHhNH2zzTWc4Mz
         Qkyb0ckh6bfUz4mzCsz/wcOLfjcNG7D2luZ+C7tzOnZtX0CtNitCmoUxI8VquP5NouOE
         Wa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkCVVUvJMv1e8l3ZmhqHRYutqli7D29he1EvopAtQdDrSdjMfv4f2tB4BGhvS26RII3Z9TWo2GNBXPIWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOiWGUwWF8EU6qGNTzjRufNfvXN4vSr805VJZO9J81Lt5kT83
	sVA9VlevV5vyJnUAGsQX/ZpSB7fKoMs8IGHxjxtMcD7pZ48fnq0vIK2e
X-Gm-Gg: ASbGncsHzxxLzhHTbZVwmTK5cChdQD0cnCn3c1vRXyj05Xh/hlOe04nE2Z98qtUXhri
	z6ARMtA2zfsm2yAQYuV72rPiqasDl/uzPbk43y5U0RjfREvKAexplAEyl4bqgBGw9GKGxQQXW4/
	ZV2bHBvsr7CCdKLiB4mv/jFSN3jWlYhA+/hiFS2QLhKEx0qchU8sqYHNXeV+KMMsfO6TMG/LBHT
	VeERMl2rbUoLld3W9FyHxJG/H8ZaVkq6/jKluZGLr05XKMf91hVx8AdtbYegU8KhT7ylFZF/5Gq
	tL0kR6D5PMFiI242AlBsN5urve9UqlJy4pactm7eiTUpE73VQrJajlnWU3Zlrw6KNZQ0FUsEvjE
	T5DRSjhUd7GDW1T1z/Q==
X-Google-Smtp-Source: AGHT+IGW4YpyOrbXdFzRI8ehOgJQVxA7rWxeNbBcE9/yoNUHql2pelOCquO+RTK4gZKp0hi8WD0Fiw==
X-Received: by 2002:a05:6a00:9294:b0:740:6f6:7338 with SMTP id d2e1a72fcca58-745ecdc83c5mr5195072b3a.3.1748013575968;
        Fri, 23 May 2025 08:19:35 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739906sm12904841b3a.80.2025.05.23.08.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 08:19:35 -0700 (PDT)
Message-ID: <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
Date: Fri, 23 May 2025 08:19:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiaolei.wang@windriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20250523083759.3741168-1-wei.fang@nxp.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250523083759.3741168-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/23/2025 1:37 AM, Wei Fang wrote:
> There is a potential crash issue when disabling and re-enabling the
> network port. When disabling the network port, phy_detach() calls
> device_link_del() to remove the device link, but it does not clear
> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
> network port is re-enabled, but if phy_attach_direct() fails before
> calling device_link_add(), the code jumps to the "error" label and
> calls phy_detach(). Since phydev->devlink retains the old value from
> the previous attach/detach cycle, device_link_del() uses the old value,
> which accesses a NULL pointer and causes a crash. The simplified crash
> log is as follows.
> 
> [   24.702421] Call trace:
> [   24.704856]  device_link_put_kref+0x20/0x120
> [   24.709124]  device_link_del+0x30/0x48
> [   24.712864]  phy_detach+0x24/0x168
> [   24.716261]  phy_attach_direct+0x168/0x3a4
> [   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
> [   24.725140]  phylink_of_phy_connect+0x1c/0x34
> 
> Therefore, phydev->devlink needs to be cleared when the device link is
> deleted.
> 
> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


