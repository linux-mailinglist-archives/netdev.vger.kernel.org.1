Return-Path: <netdev+bounces-159708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78BA168C2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5433AA99D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC61DF27A;
	Mon, 20 Jan 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FGFBhXFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568D1ADC7B
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363698; cv=none; b=O5Kz7XmBVN7lyt+dOQsavJIYyHjbs7P59fgNCmExeYi28jySe+8jC3fnkFxgBI061dM5NFRyoTGOLx7IRVsHnmGZPdm0FEA6FyV1TI6dHjvO6eef8xUpL+3a6X9JBGfq8inwuI3s1uiVWQssZWJaxVIe0yzF0INTkqbR5Spv/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363698; c=relaxed/simple;
	bh=tzwzEP03g8s7l3aneAZ0Ydoz3zLfOnTznPFsRRqr3Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=FE74jsk2tebWULLcLd2zstxNuCuepBetfRjS3AQldElztA+KxCoRIJoVrz35SkQ1QRMv+K05rkC0XNCrHPSmhlGr2M8imJk8lVS3KNRXHmAWzNOuG8GwNCHS2lABvGROSw6nxI5Ffd/pLuNbIAU+73xluL5Jel+OTIgFl+EMOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FGFBhXFR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166651f752so99357375ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363696; x=1737968496; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB97Bbr4B1xEv81orQhW1O95FjEA2Fdmfcgrx6OvObY=;
        b=FGFBhXFRD8twr3rnmLYJLg6sWURHzyDyWb1+IENvA+E6AkEiQtjUAHDL4PNMzuWVC0
         s6imSML9+IVAW/EtwMDImJlLhlAJviOCnO68cI92WYBqLASQU1CKvzqxNDLEyQf401S+
         Cx8vA+1k0HuLi9SNg+HdNeQIiiWOs9+zq1xUetaJMhnqVvsBbNAAggzWTIVS6XAvmyzp
         fV2FegcytoKvUIaexoKBc5I4bG1/89lRdI6rGYIlaK7+ZYNE7HN2Un8Ppr90CXVLk2z1
         bSnzTTmWbtk0UPz50RcsOIwIQEXkHK//ykBY1EZTz5REZ2s9xEd69UggJcQbIGfNfpXz
         OK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363696; x=1737968496;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB97Bbr4B1xEv81orQhW1O95FjEA2Fdmfcgrx6OvObY=;
        b=qaHkVwQrxjdkUBMinGbewRzBr9fioMFuhFro+5XURsvniBqy+kaitnyku6aPernJMw
         HzUc0BKJ6lbJYwA//cX2lhtz79J8OgN56ATnVTY/rmKDVgheVODVklgdPgbaq5yS2gUz
         kpqDfc3BNz5RF7DtNUGhc3CyvN30aYkxXYy/WDu8LYKHdAv/xwN/xGS1aZb1mQrHpGYN
         pA2+ekHpGLJNAOkueeF8URY59Qa8lv5gCg5Sui+1lMMU6lR+YXDhcpVdNWmTIn0VQQwb
         crKfyZBgXnuUiVlQhWiMJYsDB8VFmSCTajaUVsATVgHc9OO0aDPo2Q2FYnzrlLuKYT/d
         NqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeTttyCiUTP94zxzXOVRToEISX7iZ4tf7vvFtTiWoWYjZnyf1hzVCOtGQAqGSiqPR9cZzLAb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc4RZvHIpNLTZEzg86yJSTcTovkHWnuczwZlq+V87psy2DU+D
	NQ1uxxu11LH/FuAHHp14//bFtvRxqLqs4N5/lFdZbScE6g+SEwiLoVUQB+HUYbM=
X-Gm-Gg: ASbGnctexyYOka90uJek420266rlckl7Su1eXrEAqBK4SRCovoYTZhoIYXT5lN3LwRP
	DnIVWEY9ReqPI6OdQIMxIy8/JNkfb2oOBJIukMCE4QVsQu2bsI7rgZPUIhwmWn/x/8Ei/1tsn3T
	c+2BrTMdinEgzF/A5IimqXDuT39q2Liri9Kp5sZ8TJ6/UcnZ14oMU91b7Jl3bOsAV9UoygmZaal
	mE9BHioRyhIacgzm0Dm6ooltPXHj0x3bl/wWLCIxtJUZSzc8pI29ywF6PDzOIRpYQvIBvhc
X-Google-Smtp-Source: AGHT+IG+qd2PcvmwKJh5HwzId2IyxwMl0s+fSQcG6B72BSMW0ku0ylKyrlMqZ+pwpjyyUJ0B3fOsrQ==
X-Received: by 2002:a05:6a21:8192:b0:1eb:3414:5d18 with SMTP id adf61e73a8af0-1eb34146070mr8643406637.22.1737363694522;
        Mon, 20 Jan 2025 01:01:34 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aab358fc6d8sm3149440a12.51.2025.01.20.01.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:16 +0900
Subject: [PATCH net-next v4 7/9] tap: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

tap_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct sk_buff *skb;
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
-	unsigned long len = total_len;
+	unsigned long len;
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
@@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
 		err = -EINVAL;
-		if (len < vnet_hdr_len)
+		if (iov_iter_count(from) < vnet_hdr_len)
 			goto err;
-		len -= vnet_hdr_len;
 
 		err = -EFAULT;
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
@@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 				 tap16_to_cpu(q, vnet_hdr.csum_start) +
 				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
 		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
+		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
 	}
 
+	len = iov_iter_count(from);
+
 	err = -EINVAL;
 	if (unlikely(len < ETH_HLEN))
 		goto err;

-- 
2.47.1


