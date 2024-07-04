Return-Path: <netdev+bounces-109256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECFB927955
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B18B22EDB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64E1B0102;
	Thu,  4 Jul 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vinth+Bw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CA1A0721;
	Thu,  4 Jul 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104863; cv=none; b=Y0zI5792M1InBX/j0r3jwOoMSOR/Lbijc6rYMCj80Wcq7dAtMUWQe+ZLYZBgNdaxuIOeCZIFuAmVKbWSf3FlJNEf9gOymFPnbxYuz3ervGMSMcMUruRIsnEUMsmWjL+JSAGe16/QjLbKN2oK9HZUqAVUkJjgap+RhwoojsfvtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104863; c=relaxed/simple;
	bh=RBsIdMB94i1smMD7GeEfV0cjO5WwY9sCGUBRtXlEYm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGqSg/DH9LS+mb0FilsUno+nFTP7HfLuMYEXdQTDiJy8I94YSeRz099Bmj7N/3s1H6dIux0WEJkRfmQOKOekM/XNgq49Q2+B8RfyYuamZJTpM417Q+1K5HU59kF5HBQKCD7cMDU2QecXB+bfVV0zBJ/jrkmWebj0Bp2ueBMX9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vinth+Bw; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-701fcdff10fso335774a34.3;
        Thu, 04 Jul 2024 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104861; x=1720709661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z80RMyfkSC9GLCOYGUpg/OE+zKV6FgJptOKxg2l0ayw=;
        b=Vinth+BwWas7JuP9UVG7IR9dKbjZEkwuylfZHm5A8C6QtXbg8NLqoTBA+eR7uW1HPE
         HzbcGYrEUz9TTVbyfJutbtGyzc0RO1J/4Az883F7phAwTbzBgCsT2vHS7a13rDU+/aHw
         HLcPxpvkl9iXcZDn3EAkpL0vyeHLqejScjuc27EQgaLxb3i8CAs/r6NV87VVfWEGCA7/
         836/DSDmUdInIiIpTdwH+i1Jhc1Dx7Mq3jS8ELHZ7Dd0WpsBxZd3CLxzEdEv2pmwmC8o
         ffzU+JA/Pzi/Vn3t3gEpVC01TT6GnDpdvuMnSQOCNV2D8euVIUYu3sExHhbaDldpmYV+
         Wrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104861; x=1720709661;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z80RMyfkSC9GLCOYGUpg/OE+zKV6FgJptOKxg2l0ayw=;
        b=s/OQ0lkHEDthzyY/OzMWXaYYYD47/gTuDrgu+lsg3r11fBaRkjy87/sFWeuefc9oHD
         +J+gekioKWadnZWJs5X91p5IlzplqiIsptkW6A/0rG7FWG1k9DmaRDZas3fGxOB2rcv+
         GjX6y2bgqTpsi7nWkVbckl3puDvNxQgOw8evvix+yA4vf4V5YWU4Hzbk3DcYrThendZe
         8HF8qklVuE1jlrmIlE3iVJJ8lq2EH7lxgHAsShvt+v3akWoC3ksevbIjD34xyI1od6Ld
         jQA6Vpje6c5xc/Dz6rc8WR3gy/leuySPLz6CO9dzr6MUQyJWuNY2vuiprdo03T13VSVv
         fbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGGQpVs+o/Tu04A/9Hlj2t21LaLUeuFLcBA/DWfhRn2sBECd92qvRLRY0/6pf6s/FYcQuBPx2ovJA8UmF3WbT8EbN+IznOIpwKVnblVCd4/koV7wabjfDSPpTRevR6enPSyKvs
X-Gm-Message-State: AOJu0YyMFO3uvhGIQ58H8Uas296PaHZYtRks89titFwK0H1V3s2DUk4C
	1A45XsFW1WpaTgDSwnWywPbzsDMVx5bWvjwt0t741RlTC+YNrV+f
X-Google-Smtp-Source: AGHT+IGqqZvklxgDE9gXO6iXuh3jGn3rB86oZf01E/8h19+KJxl50dfS8QgX9E2kpB25n1JzMpxnQQ==
X-Received: by 2002:a05:6830:164a:b0:701:ffd5:9186 with SMTP id 46e09a7af769-7034a75bd53mr2514006a34.18.1720104860774;
        Thu, 04 Jul 2024 07:54:20 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6925ebbfsm683834485a.13.2024.07.04.07.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:54:20 -0700 (PDT)
Message-ID: <e2f49aa7-e049-42e9-ac1f-5f187453a4b0@gmail.com>
Date: Thu, 4 Jul 2024 16:54:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: microchip: lan87xx: reinit PHY after
 cable test
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240703132801.623218-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2024 2:28 PM, Oleksij Rempel wrote:
> Reinit PHY after cable test, otherwise link can't be established on
> tested port. This issue is reproducible on LAN9372 switches with
> integrated 100BaseT1 PHYs.
> 
> Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

