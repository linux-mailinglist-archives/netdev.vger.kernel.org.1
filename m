Return-Path: <netdev+bounces-132976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C899401D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D3E289A09
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD71EABC4;
	Tue,  8 Oct 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NjPvVRKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8101EABB6
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370524; cv=none; b=ipKYiKO88fGknyTEzm/ucy3N3Y+4PGxdofXT82HL7IVKZFkUShW+Fo3ZdtmnhZd5wtA+m5isMADX/afR/8Bum/+aRLietNSwryRrZ36y/iNFKP55Mix2gsIxxSWn0sJFa37WFHbMnWLpvdXLZP8P7iHbhkDjtq3Jg5f1wQy+64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370524; c=relaxed/simple;
	bh=aMMcGMlIvM+5vysEFQY82Ld7Vd0lkGqNTVfE62GAxgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rZF7GMldOO19NhQkhUFTvwQUGLPSXlEVEH588YHwNXTFlVRNYT25hBDsx26DW6fIL0Ya4HePgOHqhdxzyxEAKQdcAewnqQB9RWHnwY8T9eF5C07fLW1m2Ls7e9SMjPQNIKmwEXslpcgziKL8hJlo5CP9mbrUp8fNL214PdUHdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NjPvVRKC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e038f3835so1535469b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370522; x=1728975322; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=NjPvVRKCUMKmtijp5aTQtZxfAxbPT0v+EX5xlri2uVDsgwqFNWrluIKDuoveCu5Kyj
         9FNaVU6NcOx6XN+frNm0RFCd5qbiyujwbKXHg4G5q+0YI0nsRZ2CoerJg8FV9Mg3riC0
         o8gh8xoSdhAP9BLSAksXIhyt9aaIzYKH5J7ysWaj3Kim+iII4HpnZhLiRGf/p+1U0Ycg
         XB/Zf2kqQ7m6GWTqX4OozHr50QV2n0oKEQTyLWeb3flRtJsx3DAOYYn8/dR5Smtm7lJc
         MuCtT+IXMkTWGdVFu3p1+vvVBI208p/qecd/ElYDB/8oqwgx4FcEBfQGv1gNflAcBH5e
         yQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370522; x=1728975322;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=HAqMs4GiPt2fAVkJXV7L3a4IRSOZj3P37L03zYnX+Aqp4vntToWdaSN2dKpD84xqFt
         EdFBn81JDuUA4NXHGnDm7L2ojr2jXt1/8+XqbeSQ1kWYlwR8fU0z7ItcQvhN6TjDxVQW
         lLI78NA63jr3QQyE8TYraaejTWaOvd7dyIeUrNHLwGklb5VAxIDu2ntXdSXW6/Rb1+ly
         5pMWE5rQ+xHcNGBI3mp73F7aYCdFeG6G5sxigabTm5rqxDgCOV59cA6a1BTbKCBby0aB
         cph6y5j647ywuiLvxMUX19CIOo/NX3zZEeOYXK8VoYy30ccm2tCU7sU0IByHFCDfBXSt
         TL4g==
X-Forwarded-Encrypted: i=1; AJvYcCVP7kXeK87A4DL1XuvagNz+YdTULybkgvI/ywE1YibiTIxT+iEa1ZeswiQg0YXT05o7OOAADYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cgB0Szw/ANZivfaeApINmjQHXW8rh6XBPQgMj3zu4zlF6yNo
	z5nI2KGXyglJzkBvf0zKs79ttRXqe47urIIIBXD0+aEnIEggXAmelXPCYUUmEqg=
X-Google-Smtp-Source: AGHT+IHpl6coI+ZO3xm7Go5SLIOAf4hTK2yXXSof1uFkX8umSQONLP1U9ZQGcbX4LKYOwCaQ5jp55w==
X-Received: by 2002:a05:6a00:84b:b0:71e:183d:6e74 with SMTP id d2e1a72fcca58-71e183d789bmr246332b3a.4.1728370522610;
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d65246sm5463299b3a.169.2024.10.07.23.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:28 +0900
Subject: [PATCH RFC v5 08/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-8-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..463dd98f2b80 100644
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
2.46.2


