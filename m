Return-Path: <netdev+bounces-172880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CAA56621
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED10318996FA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477A215168;
	Fri,  7 Mar 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="01NiY8mW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49B213222
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345318; cv=none; b=SqxCODCRqcjxZMsRRapMjAnfoFZ1D49K5naKABsz2RTn/SLK5RKvk+siXC7rx/aJaJEKmqAHVa1BJhrNf4u78Jf3Eg4oGbmhfWr51F2iFw7LOIXn05v1CTQPk/RWDhqVnE+dCI4iTXGbR0k93pkSLC5DxQm0pC3pTvxLDiu5+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345318; c=relaxed/simple;
	bh=l0j9792/xprRDyqQ5vGaOT0IcUNGmsCkmjGv84fkI2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=GT0ZHo4wQ3L6snhPK5tBSwGHSavwVivTev4HRBnX9oNnNZTRnWXwDG4k+LOh2V7rLB/WZZqT/0PMoLTxZXQ72ZQD4c4fMKR5k66KpbpXY9YqJOKuPJhU1GyrOTyRQz/3BoDVrrbDnTGLD0GVyVSPrlzKmimiGCrAsoHeabN4Y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=01NiY8mW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22401f4d35aso30788825ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345316; x=1741950116; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=01NiY8mWhLS2eGkrQ6ak0pBnnx9IIF8ckybg08PTUGVFM8Hslska7MyzZOHQlj1azp
         2AGtT+yvLeB1WaMeLy+l69hqQ2xX/9QXtDDm4YhCgRuasymHSrPzTUgIDy23NEXv0x7T
         Cd7UhdiWIGNxoX5ozwH18DwlMmPATDrI2VyiRErhkrU12QYisIJDFBjPhbrmqyog1U64
         OExlA/qTkALRtIR/GdrrZDDfNuBr8DnebwhzyzVWE29eH4kX2eNgehq/UJMB+8EIj+b7
         xQjeNBu4cxIJyBM1RC2PVoi62L1sHhJQVFD+nGr5KyWpc1NTzGudONKrbO8/qPD5Q2bZ
         3ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345316; x=1741950116;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=rCI/D50yG0Bse4lOnl2P98oNSBYgWW80OdM4h1KB0GRY6UZMvdnIiqBip4YPpamfYp
         DWd1FOZTmVXOYFH/1e1f4LrfLNgLQpo31NwM2EcB4sZpWMupZisdQItbnVcDG4eEqmNB
         w8J14RPkInSD4TANTmIY2H6w2D2hqAzzjazgCtERja6VA532Z7UvDy8LXZjVNJdg9muj
         Gcqm+vF4BPzu+/FmpwqRYBA9XtzKPx91gnCaE0FEzP0y9X5kO7f5EHk4YFVYfsCRkDbY
         VzRfnG90opRtOez+OqR9323m1RD4FcLpt+f1KCEb6YvTu5RZ5zeMXM/Grx06Zsgypfsc
         kNPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUXpstYemEbALZOTCGD+sy3pkNoMIHTFtOngPmIC6mlTplytek3I3hLu3sUQ+sZr1Gh6qLjK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMy8nTzLt6pflM+nfp480LKFG/ca7Db2U44Y6PjI0bhahFV/Jl
	aPdp0g7ZjfLWkXkx61Qxr/sQfMILzuT1mw/0CbeU3pgyRro1ncE+wWFuvfHDOW4=
X-Gm-Gg: ASbGncvznB1SM3NKh01Z9w2g/K3Q4bowcHUYoWMaCeypL6Bcy9e3AP+5iPzYtAfLl01
	PnmhiL+uVXEyXl+RziaaNDSUXzst3fFjIoazDalFvCeq+dxLzkj1mmei+jM/IiV8fAi61hySZlV
	WumFfdtvndZHSMHn7ECez1aDHoLFwda73kQyt9MTYY22fkTgOigzIZ6Fy5fgPewxjGgo/BlUj76
	mKbRWdLU5f0AoiEcVF883N+mvz/j6r65bErLc5GP3SFijkeJWbP4h0zV3Nyu+uze/Y9/7WxTuR5
	W/hHhRmaT1dxxUVyygG9HtZprl4BVib4ePrMycr/wG94EdzN
X-Google-Smtp-Source: AGHT+IH6Rro8mN+N9sKA5KMUIdPn0sx3wUoBP7bD6XVcDcfe1R7X1FzMRycZ2IlvjtAva2HNtTHX/A==
X-Received: by 2002:a17:902:cf01:b0:223:5645:8e26 with SMTP id d9443c01a7336-22428887bbdmr46153055ad.20.1741345316095;
        Fri, 07 Mar 2025 03:01:56 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109df225sm27431015ad.47.2025.03.07.03.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:20 +0900
Subject: [PATCH net-next v9 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-4-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1be1c93adcd6c2f07654893cf97f8..463dd98f2b80b1bdcb398cee43c834e7dc5cf784 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,78 @@ TEST_F(tun, reattach_close_delete) {
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_deleted)
+{
+	char ifname[IFNAMSIZ];
+	int fd;
+};
+
+FIXTURE_SETUP(tun_deleted)
+{
+	self->ifname[0] = 0;
+	self->fd = tun_alloc(self->ifname);
+	ASSERT_LE(0, self->fd);
+
+	ASSERT_EQ(0, tun_delete(self->ifname))
+		EXPECT_EQ(0, close(self->fd));
+}
+
+FIXTURE_TEARDOWN(tun_deleted)
+{
+	EXPECT_EQ(0, close(self->fd));
+}
+
+TEST_F(tun_deleted, getvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnethashcap)
+{
+	struct tun_vnet_hash cap;
+	int i = ioctl(self->fd, TUNGETVNETHASHCAP, &cap);
+
+	if (i == -1 && errno == EBADFD)
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+
+	EXPECT_EQ(0, i);
+}
+
+TEST_F(tun_deleted, setvnethash)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH));
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.48.1


