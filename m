Return-Path: <netdev+bounces-106254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED96915816
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 22:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8976D1F214A1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC319E7F8;
	Mon, 24 Jun 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQnYGa0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2C2233B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261401; cv=none; b=mC29Syl9s8Xd/ge2i3pGAPXakpz54HaULcF1utoEe0qXJmt6ElFkvbkLY67SvdRUwZ9hKF6iyzCv3ETQBAU/ybOQI/eYdrAY7bi0uHiKCOByEpd73Ryg59rsqOae8b4blpyc3chc0lPp+0RbyRO4xNrjxIcAo4kku7cVHtM/JiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261401; c=relaxed/simple;
	bh=9JcB/UlfmzSFlgZ8SGRdc8N49x2elSQ7DhhtYnyw+LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q8TKynv9p87H5miRPq5bC8qlpVy4W6ydQL935QAy9JrFSLPt9jUwVbJXF6uEqsIuLEGiOTLys3qekgeERjeoog0LU6DbjFempNt63irtBe/xGXZHB0L0quUZ9LCeDLXFRqiA/h/ObmINlFJz6FXtXZO4djVhpgO7TeP6q4nfmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQnYGa0p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso5681929a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719261398; x=1719866198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JFVNsc3VI4FCuAom0duDpsy4UnX8qE/2Xi6YRCDhywA=;
        b=QQnYGa0pJj6J6yaoDVmkK0G+dAK869duhlzW8a62SdfqNwaQ3xRuKvRFxCN/O6V9qj
         9sPDsIXka+iwdvJRD+1JPSZwfsCk0qwpxWlA+XJzuE4VyKXE5qxiBPGF+/SRt17CsDdF
         mJYxHy+V7wbXckLahB80xSiVVXAX2cIGLudZUGASsNl6WzCPtcSJWusX3U1ROneaE5dV
         17ovj78uMC+73+dQ5PzqpLkoaG18ri/rEdi+5uzsqLDQx86qjDq4AK1p6fCRp2PVARDF
         NSz6viwqR9y/uPRSy/CaVekjtZboBC7gBq7gm2y5mGiyElwQDldZwUY99d/peAKMSpDQ
         TMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261398; x=1719866198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFVNsc3VI4FCuAom0duDpsy4UnX8qE/2Xi6YRCDhywA=;
        b=lL6H9y2OgBHYS9hHxhTIPyfK7/eeOcT2PAemmFlsGLl0Jdbxb+1BDSpJ3SemCh9P0g
         EaDTOh0C/+t7373/wLCGmm0rKZVabsjAEGL/gYgvc/T+mcDY/6qh9/N6Ae/RIjbPzfv/
         6DRL7L9FhB7+E62jkkWhBMN9uFzQnWoIr4nsyDUL1+HH1zGVEoZSXC5mmV/D/sVMNvC0
         RNteBvnRvygKK5MwISuUFtDE6tWSrn8LGmie8BQOz56z3f8Socbgghb5VOwf1O1cFzD0
         6jxgIDBx/Mf/NXZ4mX3pKt3DiP0H+9Ng45rwAo7wz+trqua6oMo+sOFXACmUMsfFucw9
         Nw2w==
X-Gm-Message-State: AOJu0Ywt/O1zBcLpO7CxvwNrGZ3AeAh0enxR2v5bHR79cbpFdfyyHAJa
	69DdZm6q6huK8th00hl5w3RVsAxsV+O6rcwZSvHuhBEcUaHdcFmJ
X-Google-Smtp-Source: AGHT+IFJePoTLrumYDrdsgSmNLkDnVLkiEMpE8RD1U90Zhlhh+WlLlPYI4E0+KKrSNfBx4DA336sDA==
X-Received: by 2002:a50:c359:0:b0:57c:a886:c402 with SMTP id 4fb4d7f45d1cf-57d45791c04mr5176379a12.12.1719261398320;
        Mon, 24 Jun 2024 13:36:38 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c07d:2d00:ad78:a407:846a:969b? (dynamic-2a01-0c23-c07d-2d00-ad78-a407-846a-969b.c23.pool.telefonica.de. [2a01:c23:c07d:2d00:ad78:a407:846a:969b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042e407sm5128002a12.46.2024.06.24.13.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:36:38 -0700 (PDT)
Message-ID: <4c2534fc-8a54-4acf-8736-a165e8e1d88d@gmail.com>
Date: Mon, 24 Jun 2024 22:37:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RV: r8169: issues with RTL8125BG on Raspberry Pi 5 + OpenWrt
To: noltari@gmail.com, Ken Milmore <ken.milmore@gmail.com>
References: <00eb01dac57e$272fdbd0$758f9370$@gmail.com>
 <00ed01dac57e$d4d7e200$7e87a600$@gmail.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <00ed01dac57e$d4d7e200$7e87a600$@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> -----Mensaje original-----
> De: noltari@gmail.com <noltari@gmail.com> 
> Enviado el: domingo, 23 de junio de 2024 17:01
> Para: netdev@vger.kernel.org
> CC: g, hkallweit1@gmail.com; ken.milmore@gmail.com
> Asunto: r8169: issues with RTL8125BG on Raspberry Pi 5 + OpenWrt
> 
> Hello all,
> 
> I'm having some issues with r8169 on a Raspberry Pi 5 running OpenWrt
> (kernel v6.6.34) + RTL8125BG (MCUZone MP2.5G).
> 
> As you can see in the following logs, it crashes with " transmit queue 0
> timed out".
> It works perfectly fine for about less than 1 minute and then it crashes.
> The crash appearance can be sped up by running a speed test or anything that
> increases the network load.
> 
> Maybe it's a HW issue since the official r8125 driver crashes too...
> 
Thanks for the report and this relevant information. If the vendor driver fails
too, this indeed makes is likely that the root cause is not with the r8169 driver.
According to your logs the NIC's even come w/o a pre-programmed MAC address.

> In the following links you can find the logs from the different tests that I
> carried out with both r8169 and r8125 drivers.
> 
> 1. OpenWrt + kernel v6.6.34 + r8169 + ASPM Disabled
> https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-openwr
> t-6-6-r8169-aspm-disabled-txt
> 
> 2. OpenWrt + kernel v6.6.34 + r8169 + ASPM Enabled
> https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-openwr
> t-6-6-r8169-aspm-enabled-txt
> 
> 3. OpenWrt + kernel v6.6.34 + r8125 v9.012.04
> https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-openwr
> t-6-6-r8125-9-012-04-txt
> 
> 4. OpenWrt + kernel v6.6.34 + r8125 v9.013.02
> https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-openwr
> t-6-6-r8125-9-013-02-txt
> 
> BTW, the same device (RPi 5) is running perfectly fine with a USB3 ethernet
> adapter (RTL8165B + r8152 driver).
> 
> I've ordered another board based on the RTL8111H so I can check if that
> works with r8169 or not.
> https://www.waveshare.com/pcie-to-gigabit-eth-board-c.htm
> 
> Best regards,
> Álvaro.
> 
> 
Heiner

