Return-Path: <netdev+bounces-135118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A591E99C5ED
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AD4283F12
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405815687D;
	Mon, 14 Oct 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG7FsJrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34B156885;
	Mon, 14 Oct 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898771; cv=none; b=cUIW2h3VwbrkfzCafS8BSZV6Z/Dd/thkr/KximaVYts8o2SeufGbTkqF7PW7Z172ELEWHcRvqXFWD9xeCyhlEcjFMFzlAH1/wmhLaCurEAYBEht3F6Wb/tvIVPebHionMPRVQcIlPdCEfjic846eRMSP/cCnh5lYIa+trbOLOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898771; c=relaxed/simple;
	bh=hSExf4atp+U51gi7jYudiyiV0XJl/A3cSzCmKq/njJA=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=gtq3OP9D8rtNe86TUVzQWjifRxML9o48b8qYkIaU4WkLHnQS7+tRsp5jT0zSN+1sGMURj/NQjQgfSP1o5IsXbV0Cu32VXaAFQPYL/8JB9hLo2yhJN3Tbdlpb3eQWlFYIaMjI60cVlB0qq/5smDSNJ2+H2rrEHXQW0t4sz4Dlb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG7FsJrW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d461162b8so2703457f8f.1;
        Mon, 14 Oct 2024 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728898769; x=1729503569; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXvmuKgNurYfFmlWGhrBnQNjxraoDSU6b11R1GM4I2w=;
        b=iG7FsJrWynqLnJ/GHbsiySJGvi6nGoxkCFw4J7/pBCx39U8UanO7t/R/E40+pt1Jhj
         iU6f+APR9WX4Pyo5oNqQQUhdJ+YwANV5m69C4sR8ya9E/sWpxOQgLWMFD1ao7Yfh119D
         qknF5n87s8J6j3vvVAkA/uewTi9IgOJ4/lus7S2McGwh2WBsTmZ8kzXntaBKH0J3W4vc
         Dhw1mGFuyf+cxLSavNELtOAlr/BV4ROCwXpC8R3+RuqC37BSkSOIfY/j+qP/WOn5BdXZ
         iTEx0UV+rkuZX/O1qeeCzzS4fdzywZ/lVvw2cU92CfCqmm62r6bvfyeH6DxWR0Hdpczn
         uv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898769; x=1729503569;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXvmuKgNurYfFmlWGhrBnQNjxraoDSU6b11R1GM4I2w=;
        b=xUvdrOmeW6OCgFRGMoXp+0I8JANvfxs/n/rpbUJqfMu2+DwJ9xGj8P9KLAxcpO1lgn
         8905hvNVOQRP1wlyCC/Jp5pw+sB64hCSI6M8R5NdzLJqxSjUGrXUiZoCGpBDhwjsOFgu
         ZvzxXYGH1keRh9pQcwFRNLh2fB5pi7blWv0ksi62RXK21Hp6lqPMYC3TDvrwfITrri2l
         n/4F9p7aIpv3kZl7UevWb+XTqvhNhyFSGCGq2cFRKN414HV8En7cInNZ0htQtPsz8k1p
         wZ7K6/dXSK3CM642FSV+Yodrq4qr9IshXE7ivw19N4OHASvBwLE0JtUSV7OR6vFAtF8M
         hXZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKjLpXCuhGIld2ulRkfj6q9NwKFgTN159EG+wPpaoOol08yAybXlhIb7OR3v/Mu0GGp+DI3bzeVMyCxE=@vger.kernel.org, AJvYcCVqwN//vdVXnXGBMU4XdiZhWGJiYQ6Ghnirz8fFB54358hGhf5LvmxEzUaAdDpQ/Bs8lAipQWu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PUIuQRJIbW6HC3v190c/fuKT+Yr3otsD6EyAie+d/TVb282j
	NwvDyQYa5NytK/xfsp5oKJNqMGdWPD3b9NiGKkNxo5aESVVDKIht
X-Google-Smtp-Source: AGHT+IHvlPq8uXKsAnqFl6SXuA29bSIr6fSRIYWCunQYemcdhRdpsILntml+usT+l9Gmo3QcVnWMDw==
X-Received: by 2002:a5d:59a5:0:b0:37d:3973:cb8d with SMTP id ffacd0b85a97d-37d5feccac8mr6510785f8f.24.1728898768397;
        Mon, 14 Oct 2024 02:39:28 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-430d70b444csm149379745e9.33.2024.10.14.02.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:39:27 -0700 (PDT)
Message-ID: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>
Date: Mon, 14 Oct 2024 10:39:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin\"" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: virtio_net: support device stats
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Static analysis on Linux-next has detected a potential issue with the 
following commit:

commit 941168f8b40e50518a3bc6ce770a7062a5d99230
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Fri Apr 26 11:39:24 2024 +0800

     virtio_net: support device stats


The issue is in function virtnet_stats_ctx_init, in 
drivers/net/virtio_net.c as follows:

         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
                 queue_type = VIRTNET_Q_TYPE_CQ;

                 ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
                 ctx->desc_num[queue_type] += 
ARRAY_SIZE(virtnet_stats_cvq_desc);
                 ctx->size[queue_type]     += sizeof(struct 
virtio_net_stats_cvq);
         }


ctx->bitmap is declared as a u32 however it is being bit-wise or'd with 
VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:

include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ 
(1ULL << 32)

..and hence the bit-wise or operation won't set any bits in ctx->bitmap 
because 1ULL < 32 is too wide for a u32. I suspect ctx->bitmap should be 
declared as u64.

Colin





