Return-Path: <netdev+bounces-146242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCA9D26AC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D70280633
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C51C07EC;
	Tue, 19 Nov 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXnPCyPM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A701CACFE
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022115; cv=none; b=bAsjYq3m3tx2riMOwKpI1TH8jmaaoa640aIClPiBMHcXpMnvnZA0psZmxd1cTSMHDmS1S3HMa0CCvhm1pmXmBK3VIfGlzUe05OzSP1UguIQEvl4zUROzQ5GS3Bn/AHf5Dawh49Rr6Q4mG/bGCHQAH7r0YFpD4e9rJ2EAZqCq27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022115; c=relaxed/simple;
	bh=M5G5UTextI8QbNeVPUDyHyy55L0RD5RgFnNSJMphWfQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qfD4RjrU/pC1ppDhUF6o8i0CxuAXtCy74/h26UDRqHxtpvctCDKtB8LUegvGNqDaLz8NGPjEC9XTFKV9vPthu3IsZocoeufa4dgvHpo+B5oUtVFYsxml6avtFCEXqcCpDicP5zaxy1Qq2KPcKyLmpQvCPsqVNMl6KWSiFpAyPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXnPCyPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732022113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5G5UTextI8QbNeVPUDyHyy55L0RD5RgFnNSJMphWfQ=;
	b=IXnPCyPMAM6LoZ+M3RuqWt4bX0Rrw5Zp5ji3mi2QGZmMpqWFvcUFfY+zXuPNCwwS1Wp5Hm
	zQhiMdutx1GA9uqaldOuifiJYJGg24Me2dQwXH8ZKg9O5PO8ZV0KTLcmlwzaISSLVWrmJY
	ZAbV6HUuAiq94evYWZq9aEoLEcJGYdM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-I0njhTfZMwm--By3l6atAA-1; Tue, 19 Nov 2024 08:15:11 -0500
X-MC-Unique: I0njhTfZMwm--By3l6atAA-1
X-Mimecast-MFC-AGG-ID: I0njhTfZMwm--By3l6atAA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460b638b668so15615981cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 05:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732022110; x=1732626910;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5G5UTextI8QbNeVPUDyHyy55L0RD5RgFnNSJMphWfQ=;
        b=ccPcTS/MIRwmmw+v8X/faaQ6OSHSsvXH4HnjK3rMPzgNojRtESi2QxRJpRyh/SK2MN
         RzdCbhzJZgluWbDwG+a/SOZDl/8SjDg7vO4y1grmEs9rTnnnNN+R/IFKrQSLhFYjOzPi
         BElubz7Eur0zidzO3Htw+XOxZbXTxqPF5iAzVIAu9zIXeaKcKRMI/q9Zz+Sx2CJlgE48
         cgfTvVSHB/Kfe4Xxnk/AdX6d58hKIYuwlfs9Hsvsx5aWGIFjsQZre+YNmxdDzzfs+x3h
         HZq79RC1M3+1X7lhlkHg25CLlOcQ03lmXY4LMGrhk5luwSHnffFs40iM7U3Hc0cO+8Cs
         Y9Bw==
X-Gm-Message-State: AOJu0Yxk0GANblclgDrzJb3ZanXwyC2d3UD53/+zaJ2ot88Je35BB5ZL
	ZAXS7LM7YAO1csWykZA5ouB42bVBnDgRh0DGf2kEzL3DzwHT6TZ7cHSAOO1th0D2V80OK9OQniT
	EwMKyp4g5qROfnYfUhhV0MmGqLNZUIsDhjCgJbza5O+aDa/9Uj3ck7zmTqYDqOw==
X-Received: by 2002:a05:622a:15d0:b0:461:646c:b8fc with SMTP id d75a77b69052e-46363e397d7mr254313431cf.23.1732022110401;
        Tue, 19 Nov 2024 05:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIGK74cWDAmhNUwOt0VE9LpjG7zVz6hXYHiICaYeQ4nU5P3aZ4b6dUR+WM0kjwSDOtUV5IDA==
X-Received: by 2002:a05:622a:15d0:b0:461:646c:b8fc with SMTP id d75a77b69052e-46363e397d7mr254313151cf.23.1732022110126;
        Tue, 19 Nov 2024 05:15:10 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392b9b2besm10831431cf.10.2024.11.19.05.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 05:15:09 -0800 (PST)
Message-ID: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
Date: Tue, 19 Nov 2024 14:15:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King <linux@armlinux.org.uk>, Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: net vs net-next conflicts while cross merging
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I just cross-merged net into net-next for the 6.13 PR. There was 2
conflicts:

include/linux/phy.h
41ffcd95015f net: phy: fix phylib's dual eee_enabled
21aa69e708b net: phy: convert eee_broken_modes to a linkmode bitmap

drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
2160428bcb20 net: txgbe: fix null pointer to pcs
2160428bcb20 net: txgbe: remove GPIO interrupt controller

@Russel, @Jiawen: could you please double check that the resolution is
correct?

I solved the phy.h conflict as reported here:
https://lore.kernel.org/all/20241118135512.1039208b@canb.auug.org.au/

Thanks!

Paolo


