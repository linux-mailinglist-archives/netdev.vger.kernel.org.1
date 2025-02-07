Return-Path: <netdev+bounces-163824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B3A2BB2E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88D53A7E4D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17B236A98;
	Fri,  7 Feb 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Z0GEn7oy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2F233D99
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908709; cv=none; b=FKcS8mIIGegjrLKISYw62zcShtVSplEOw6MoeauPU3vxtxN/7Npy+MGFwFCtf43F4UGPX8NtDSe75xkQOHBjIzR8uPxtsIaqKH5mH2BjaGXYsYGjCk11w7WCAEgFTFVpfHEGkHtQaTpRqM0h6Wb97fEgmVUCnYX7Vp6bs5xbQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908709; c=relaxed/simple;
	bh=nZIPHAA5zCJF7swo3jDQ5RjM5zm8qMnIWTvWpC5hGqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=STFyALnQS3jtumWf9jX+iBE8RX3gs0PuXcQ+Ut8rIoNphhw5JwTd0LPWnLREkN1rogVwCCjSH8eAFT4RG19rnQisrFt6DryP98GAGZwIW3xFAFkaeAyznOf1nSe9977ra5WFuY0cUfa+bi2fevvJslweMKQJI9o9npv54XeRGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Z0GEn7oy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f20666e72so35860825ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 22:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908706; x=1739513506; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=Z0GEn7oy7nAcn8Yimse7BALKQCW7fwCtEHPpVzB75/3hagaW8sbuotM6pf9VTPzKxm
         8YOh1fsHuReQ7Hg1hbHHZdmmxeBYSabo8pZIybqalOsotkukqeA+HdwBfLvsxHBdVDmE
         HyyNUrEXj9S23lDnsLWSVGx8ZiNlizamy2aimhQpG6N7KEV6823+Lv7a0CjdBU1qHGLz
         w5RuidjRpVdKKgUMSAFsqKdYK9d/rJ2Vip217r7XBVy/itv12JYi2fCbDAPM79/ca+oq
         gLRoHaB197upoPkuygc+o+3JjH7iiRT4nIk6BUatpgXEPg1nA93NfyW+gtONycwPfYTq
         LG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908706; x=1739513506;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4saBNfFGUdtw4heVChkMZd5FykA/GmW9Q/kNvdZqu3c=;
        b=iBvW1RzdLCM3nrEDUJmpYukHvdyp+YYzsOAUo9x/DUxC7QnfYysCE10xevXdmnQAXH
         eNZH8SFpjZ+u8rSjDWPY7+VqEzFujpqVRJ6sx9+2uXp4PqQ4EultLlF175503UF2yNVo
         iPQGpOlVnRku4rf2CUBSUDvAV1I2+tQS9VWYRKedYlSS7Fj3fHTEGaD9HnQQ0leGqYET
         IObE/AGBnfSWu2EMtBqYqKBbLCCev86CHhnv/jfefCOt5vfhZllPAsfgRkk9Tz1M9M+i
         1CIQhT1kbthD9ngwBIvpATmbo0B4eodT18TTZ8q1p/yf90HbjcrLAg+PANPRZPMFpiyh
         oBzw==
X-Forwarded-Encrypted: i=1; AJvYcCU3l0G7kZRcx7eoMGRsQvMRlrth5jDgMSn/x/edA8uKbZ1Y+oirFu1sKbgAzgZa0sLvu9plGCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFfeH9Mr7rpoptXtLlWNMfQIZj2drMBINWzxaYqhNf87XxHmg
	hADhnyvN6yeNoP05k/8XGAWLKz5xFM5dt9QAYSBtibQLFrUeGq7Pef2VvohTwR0=
X-Gm-Gg: ASbGnct3Zf6PI8yZNYkL23yZ3kdwohGGOdoOgWc3pUD1DXKfVZFR+b8gp8R1CGGbMCo
	4gmx1Wcjx+pZ33MS+liE+UCV8PCFIARnyRghLMHwK2BbzXcUBLQs9CtjiQnC3ekkjnd9vftym45
	cehLoUkoApr01JbKI4uFp9hJKHqM7QtSPYn1gEA4XxRo8ThSbxH76/JESGzWVmTaQr0x67zejsL
	nxDIQ6Q3IpAI2XtiQ4owHE6bu6oOFMXJWeP49JpNEk9mB5XmHezEMtwNBUqjL/WOUIofRpjZXhZ
	cOF1z4eckB/SKi5vo9g=
X-Google-Smtp-Source: AGHT+IES1fBH9Xm1hn7eMcWgU4qwNM0YJ/XgnSVms60Xt5aaLNJShgX4JEQoDPxBZLAVM7x/w27pJw==
X-Received: by 2002:a17:902:d502:b0:21c:15b3:e3a8 with SMTP id d9443c01a7336-21f4e7636d6mr31492145ad.37.1738908706650;
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3650cd10sm22742625ad.31.2025.02.06.22.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:56 +0900
Subject: [PATCH net-next v6 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..8cb002616a6143b54258b65b483fed0c3af2c7a0 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
+	int hdr_len = 0;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -663,13 +664,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
 			goto err;
 		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		     tap16_to_cpu(q, vnet_hdr.csum_start) +
-		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
-			     tap16_to_cpu(q, vnet_hdr.hdr_len))
-			vnet_hdr.hdr_len = cpu_to_tap16(q,
-				 tap16_to_cpu(q, vnet_hdr.csum_start) +
-				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		if (vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tap16_to_cpu(q, vnet_hdr.csum_start) +
+				      tap16_to_cpu(q, vnet_hdr.csum_offset) + 2,
+				      hdr_len);
+			vnet_hdr.hdr_len = cpu_to_tap16(q, hdr_len);
+		}
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
 			goto err;
@@ -682,12 +683,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
-			copylen = ETH_HLEN;
+		copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);
 		linear = copylen;
 		i = *from;
 		iov_iter_advance(&i, copylen);
@@ -697,11 +693,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = clamp(hdr_len, ETH_HLEN, good_linear);
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.48.1


