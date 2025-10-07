Return-Path: <netdev+bounces-228052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C538BBFEDD
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31ADA3C4A87
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24971A314D;
	Tue,  7 Oct 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XncjnnSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AA27707
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800139; cv=none; b=GG2Xoi40SKrLC1hBQ6q3AJn/w9pqV3BuzazGnChfyE59/+k61GRGLr6LqRFYoaFPEO8HZxQ4anxGYawECGIoxc4iwOKv6mCAkTlLCSD53/GlSm3ANOVStjK09TfddI+BbVB8v9UbHct1Cq8GniqK8Cya/KgO51DGMGjkzd9ASDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800139; c=relaxed/simple;
	bh=H/Vde5fSyegTVrxDL779b0Ekl1TqghJb8VzoeMUW5sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q647wDsWNMc8QHyzDKXFmhGVhJAyjHmcA2FmsPlNsOy40iJrCUcYXHy37wcvAg6E//0I6zZvB0twcXgc+7HacBTWrL5kdLGlaY4TSWrFoa0UJ8pb34LmowZgFbtVvaXmuQ6lfby+mWJXNvkSJbiIAIEsXcNHu7+c+P6EINTJZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XncjnnSB; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso4080518241.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800137; x=1760404937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeZtd1lS2iAL5Eb5txNbBPZr6F+hk2iic2qSNfSBlxc=;
        b=XncjnnSB2+L1F4/tJ8mSC8SG4h/oSIvs7toO039nd5FdscCP2C/rDKR1v0tEB/O20y
         f2CjZ1M04v9k5A4pcEyHSWgtEfzTnJpaAmNI001gtaNQiPtq+I1WzaMPse6RtfkJLg+b
         RW0ac9W6hRUw/b54tpR6IsZ7THsw6ol/d+tfv8tH8aU1aicHprE8jc1QyRbXo6g3Xdu/
         3CcccBd+MVYtakcehaMCi0lBPSxHGBrd12eIfHwUc2+KtRXZlsXa4c5ceCGiphpe+mnT
         hmA2oLhZ3Au9c/lvTlzhkdEB5yCZ5Sr2I6Qca9I3c7MAsgfsrTyDuvfDDkrHa2++7YRi
         n3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800137; x=1760404937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeZtd1lS2iAL5Eb5txNbBPZr6F+hk2iic2qSNfSBlxc=;
        b=C4N39bjKpjgxOd/DSHV+rrlnNG/7HnVRrsbqbKim5R9W2rKO9SD+chX6aNqiplY9S2
         fLyhqrXqLe6cgaxQTCnRFaz8qEfLIpnCs6pVFQeiiL62KUFPAO9nBGNdWZ+bBkw9jQOp
         HWAQsZXyNreI+30pl8TBGPPt9pysBvU/EEb42ZWoWtUZnMnspNPm/7iUeUuZLWeltLiL
         IHVrh7z5GlPr++OyInjEB36j8vZ+ArkRRgGKWFFnLwVqlhiwt/6KU4bWPKHDFwhPaIp3
         b4rfJwaM2jgrg8Fg5P0z5Annq4qkQH47DQur4MzS90T2bD0l/aXjqRVtiUJhyXtujR7M
         rgAg==
X-Gm-Message-State: AOJu0YyCgHSkVHgSDEvjvsPqO60elSCrJHhqvicIa3VAhuRrXY+wymvs
	sDNGrUIlvz2tQG0a7qGrIj5V3UpEEMSstKocIkDFUTltLq/G1RrdYCja
X-Gm-Gg: ASbGncsYFrkIhsF7eMQ2rd0gVVBky/NJbhNSSaIZmNzF8W8jfL/akmozfW64gnHhdjO
	BauquwmfVl1s8uIQol/ikq1BkSvy52GCgACuJAL+s2bObW0NbTT/MI8gz2K9xkDG+DW4egIeslu
	AZVciMaUIXLpon+spQgSfmndppaMK8vbcXYkVh7YZqUUQZKtcfm8fEkl2vKWf90tJyU+3YZMEhs
	fObB1MraO+PG7eIo051hD50NS3xHgFPsBqwGQL4MpcjFmzu2hxnWL0e4tZtndImhgEqZE6NL8UV
	kwz2JJ0CiNLSH6YSUAigU2Ml4KtA/7XO+TMk6UepWiA4TJ2ICobw2k/s9C1noGiwi4fYaYm6miE
	9gPrsIu3aAwIdbpdKBl8cNr+Y6vkxT1i22PaJ9i57LWIoHLF/zdoD4hrmNMLa1Io=
X-Google-Smtp-Source: AGHT+IFmBzhKhtg5t4PSLIdciapJfvhjo0L3FJBJCxbNlT3KY5aZygpXM3hCFzRlcEVz+ZGVmyRtfQ==
X-Received: by 2002:a05:6122:514:b0:54b:bc60:93f8 with SMTP id 71dfb90a1353d-5524ea2517fmr5491547e0c.9.1759800137067;
        Mon, 06 Oct 2025 18:22:17 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf6558esm3444393e0c.22.2025.10.06.18.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:22:16 -0700 (PDT)
Message-ID: <4124e1a5-fcd9-4ce3-9d97-5ebe8018207e@gmail.com>
Date: Mon, 6 Oct 2025 21:22:12 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly initialized
 dev->chipid in lan78xx_reset
To: I Viswanath <viswanathiyyappan@gmail.com>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 09:14, I Viswanath wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>     lan78xx_init_mac_address()
>         lan78xx_read_eeprom()
>             lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
>     dev->chipid = ... <- dev->chipid is initialized correctly here
> }

Please describe the testing you performed.

