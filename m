Return-Path: <netdev+bounces-251057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156AD3A778
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D4F930CDD5B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4C318ED8;
	Mon, 19 Jan 2026 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F23Wo5fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BA318EDD
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823572; cv=none; b=mK+Q8rEwCx0jicNuPJbMZLsayaiqkq2XTz+HN1t5NH4FBc1XHCHUQJn//XPKr0zUZlRu975xMhL5oDqgFKYPGIVFgAvG0WhL8aMph4CTiqYBwWZHxwQwb+q4OIM3w9xCBPltylQsCIcsXcrqdmzLRGooqqP1eydXeqPrzu3S/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823572; c=relaxed/simple;
	bh=XjmEkDhy70C9BPaUIKs8e1nglyFuMhkb7Yn1iqBTdVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFbEF24jSu6Z6dYhoTjYo+g+Dw4SO452JaC9u6Uql9/Hl0j9pkEKU3L42if5NAWnOoS/QH7CnOqWvj6ThRjz4wQG7Snvl3GT+lj0vGyno1m1GYzDFfaw27h3WHLEuXyMY/96sFV5mgdj2oX+GsY1eM1fSZvzJ0dsmHM9EFfF2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F23Wo5fw; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a2bff5f774so13476125ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823563; x=1769428363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=JZzUP4MqqxRud+7BJeAMvljmJVqrRUVzeP5H2WQmSMN+MiQSb7N1lnhH741mbk3GEK
         VYHfSU7UutrBReHBdQjTttdPgs5Gi40hvChjRiee3fA1HYLNbFSwbd843UsP4IEYjNxx
         bcwU5Yfh2xp4nMRv0T4k0bTnhQBFlA3IxKbSbgz2Sxzt0UTKq+DA5WmUzqRkq7kDTIIZ
         t6AyXcOtdPylrpRKT07kO7j2INwGhOWupBp+ZVIntHVZMvhLVLtkqZkhW2l3igOR8+Mc
         mQ7A/3/kH/gVo/Dl48Xeaw9HkaWJPOuv56K7VhM2C6uvPhr5nU8TkietEo5nedjShTKV
         BKjg==
X-Forwarded-Encrypted: i=1; AJvYcCXMTkxQ8Pb1Z2qIN1qaar0/WChZlzSnkpxrcW4xyW8CivyVC1hgU+a2IZva/K8NE4G7ilB5LmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XpSrleKtuSLXyWAYgNwTcrZvQvPvAAibVVoMxK9QDwRRRD//
	tiYOEnLgBXjLsWaJMg6iklcUjZXB6yc64HrZ5iwlnqVs12FIYAX/G4jDjKqWcowZuRdtOG+gr5t
	X6N+bcKsVOysfpMC9Oc1eE9QDINP7Wf81wwyfW2SGA69iN6DXhO2Ge76OS1MF3HXwJhEhGUuJGY
	hZaF5tzsn5TAdQsiSzQ0fYYsstM8vUpFxEepQATMY21Fu+voro+6ne4MxajwJWf0kvbDZ09PdSY
	Az6+8xZaaEflRiNuJsDrUFCtBRaYns=
X-Gm-Gg: AZuq6aLbibJkGQ3HAnPPwdBCCgCply/K1uYnWuFWaEXMlNryI8w6JJw+8M8+eR+8UiX
	UyoN4eHSJ5RBZ+PI2zT1Cr1hKzxR9ZxVrgh7TrS5y98ZrFkydd7Te/s5Kvk0rWO2NhbKN0yI3mG
	583LbLfxvO1WsbfxjqBlgA25moU2tjNILCV6+iMLMXXtjD8D5GWE0De+Sa9PSjuF2ilN9vXeYYk
	pg/U+4Fh1ZmkgN91ORhe0DEN4IKvfXooPuKvyHwAZ3EQhfdRuF9UHMwNZW9USBF5mleUHraHqKD
	mpdztpPhHSZktMME1z3p26/tosn8HvYFv57oKUKvoklgZruxz76jVsv4a0V7k8TCQXUPnpel3sR
	23RNK5JjxlVrGLDrhMeQm3UBbsOeZFCzBj8oo7+04emNzAyKV8c/7np6AK2rqVHn4aFJ4F0t0Yu
	PvW9gZMbVAza7DeX+mjxFg4lJg5jI8JZUBZ6YULo3wJq9BCXKUHQed3dDVE4ZvgA==
X-Received: by 2002:a17:902:d492:b0:295:745a:800a with SMTP id d9443c01a7336-2a717525512mr75002785ad.2.1768823563179;
        Mon, 19 Jan 2026 03:52:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a719395eb2sm14677815ad.41.2026.01.19.03.52.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52de12a65so116378885a.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823562; x=1769428362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=F23Wo5fwQvVFRkHhHhqcR9lpNJ6LF7PVZdTf/zH3ptgW5YVd6leI4om435lU4ELIdJ
         lazrLlWh3eyOPOy3JU0J5PevpR5f/HBipLDIARwNQSKLi2edMrSgvmjdPc7Wddpc4fNC
         S1U+5QiGeyxjqYcJulwxt1bv7VRqYvEi3zsps=
X-Forwarded-Encrypted: i=1; AJvYcCWmsrqRA/makCHKV3mqj1eprz7bbrvSFNKSCuDImMUSD0+em9xsFzKrAR0Z2KlqisTBpJev29g=@vger.kernel.org
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083870085a.9.1768823561512;
        Mon, 19 Jan 2026 03:52:41 -0800 (PST)
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083863185a.9.1768823559509;
        Mon, 19 Jan 2026 03:52:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 11:49:10 +0000
Message-ID: <20260119114910.1414976-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backport to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c51377a15..e79bce6db 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


