Return-Path: <netdev+bounces-162887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC1A2846B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA70B16503F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425322ACCF;
	Wed,  5 Feb 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RhWE+Q9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93E22A81E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736599; cv=none; b=CzCURx0gsWKL6JjGFd269OsgnxTg6vQQxhvp3SEZ5jkSGMHLHeakoo9TnlHd4Gl5SACUiF9I9YxFpNLX3o9/FeZBj88j8FiFNcueIFhiVU1apwueFw2AqflinbmqlpgCl4aGxhgEUS3bqI5ozOl/YUg2vjLLKkVDaKkRSJLK2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736599; c=relaxed/simple;
	bh=a8oH3PNmwIVYj2tKdIrFjYF4Tj+2irxY4kfMh7WOKvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=lTxruTgQEp5JIybk0ci/FYHj7Oj7wKvqPZXNaFjccjbIlLX+v+xYSdYMx0FOT0PHsvmgFSbpqJhV6Qu1RaQnE5xI9l/OpUnTONC5xyvSYdhnTiXmXb3YZJWOvYpgBphIjphlGfoaRx5wz/QV/20jCcwYYUrkV0+mMk27tb6J3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=RhWE+Q9Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso152180975ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736597; x=1739341397; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8srIBeyhs4OWM9PodAkxe8Sc4dGj/gPqaYG7YjTXw0=;
        b=RhWE+Q9YEROWBWGUSsYw4nh41epxfN9ekdl/kBLgKyRwQ/XWMNxfvCWGeJBidggLOG
         twM0vPMHhK1Y8DeiC38RTqjBea6wvvmOJVW3RlkMBPs/u9tKbv5WfMExqbKBftGbyKg5
         er7LClnJskywKV3zwzNZpCkak5i8VF3KY2vlGOtEkEAQ9qtWBcRqVpYw/IVcq+ZcqiEx
         gtW1Iqi2IcPmtNBPB3Bs9Wi5QwCAf2IAiIvFgiJV3ns4SCSXOKZPYz9/SexaKIc9UC1Q
         OpLpLGkuyz6RNuxUg0iHOcQBDTz9i6KEfHZOoLCmb+l+FcInIRKEmK2hKERtEE53Es1I
         NsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736597; x=1739341397;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8srIBeyhs4OWM9PodAkxe8Sc4dGj/gPqaYG7YjTXw0=;
        b=Xu54/Udk8DJJ/Jr3287bTVGA7olL5pZltXn1QA49SLPr9upsV6bZf4kxM/mid9wsM+
         xvO/aluT14OT2xtXUDAC/ippP+kcLavjzWw7smmXlmFHcW+HgXtP9orPKbeSHtSzyolq
         VIVplVq438K3UonV0N9SU3TetkryMUFJUB994lzl3i3/vhWGLpGidlbtSZyCEzUobt6u
         TPTau9SNHn0tFgcifET5aUhmAbxcPG1Mc/gREhK1HGgVcDwQTqgZroKkFwJVnHhR+MGV
         LLuQNTATQqCiqUjsLpGG7Ks0KSnOjqfYPXfK7GX5AmY8+i7fh0+JKCKjXZB27v+lzAbN
         9Erw==
X-Forwarded-Encrypted: i=1; AJvYcCV00mjv/jkkkPtVxa12pdQyJK1obahXXze8TkbbYJSVTgxdNBcFXXP68i+C5hj5nlUoTCg5Y/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/5VzQHVQs5ZGQJelnorJ29bM5KH4LlVv8MNaSMEn3IDlX0pT
	PL178Iuiav71bGEnc0n2CRMZ8aKITfhgxWcieFQiL6xh9XmneVHacS/3FM4SLu4=
X-Gm-Gg: ASbGnctxlyuBtV6k03DA7nDh/JU/tAFGkiF3EJNvfozBq4WpKY7rG6yTTDk0OtS4UPU
	07bFirnCXXnDlQCUBjfq1dIOYm4h1zDjbdbfvxZuP2Smuk0Jf7dMYYI2n4w1OKYqagp6lqjKJ3I
	kHx8ckCegqHnseg8HnEwBPetKQ6UNIM18qWryfTcPzVEdYZQ5OqwTzlmJ6o5tnY75iyUv/T9SnZ
	TAq9Oj6J6HtymrK14Qukp2iU3hy0dJeyKM4r/SIJm4HO2UyDVFxJA9vR4MQNsFTYbpW+EXmpUjQ
	61wi5KE17MRaTNG0OHY=
X-Google-Smtp-Source: AGHT+IHg1+FvFT5HDL6SfSKULAJ1AqWAEtxmHva7Bnl4TG97CsA76lSGxTRKSfzGYdWpbEr3lj3N/w==
X-Received: by 2002:a05:6a00:2e14:b0:725:ffe:4dae with SMTP id d2e1a72fcca58-73035122ac9mr1991170b3a.10.1738736596777;
        Tue, 04 Feb 2025 22:23:16 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe631be56sm11600664b3a.4.2025.02.04.22.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:23:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:28 +0900
Subject: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
 drivers/net/tap.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..c55c432bac48d395aebc9ceeaa74f7d07e25af4c 100644
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
@@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
+		if (copylen < ETH_HLEN)
 			copylen = ETH_HLEN;
 		linear = copylen;
 		i = *from;
@@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = min(hdr_len, good_linear);
+		if (copylen < ETH_HLEN)
+			copylen = ETH_HLEN;
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.48.1


