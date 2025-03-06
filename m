Return-Path: <netdev+bounces-172387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A6A5470F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5673A5CFA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBCB20D4EE;
	Thu,  6 Mar 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Hjzwn3Kj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B120CCDC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255047; cv=none; b=kTDRSgRpg8xPIv1057DiomB7kHoKLoaxtRt49URxqTI5urBbS0TCduvfJjg3bOfk2git0bf262kUSEUjj3UuFqnV9JLqttlPhr/k68b0xaGoRtmIdGIPwpL8vB1q3BXyNqwZv7lF3TxfL34qSN9AS2AoDTfdfh7HJ6bnLcqJKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255047; c=relaxed/simple;
	bh=nEE2/C77oF+j3LxMBPOVoqrwqXRBAnjdJN3gCt7XvfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=tKqwXGj4AoWY/KBp+ZdYOF5WJ8g7Zf9mZOeNy64aA5JxfT+Hg7XraerXiee8H+/+YqWz27TSWw/hnHpT5Mfg1HM7V0N6/XVuLzU/7xEkY8Uv74o4ehNmJPFkZ3JjLvxVkbHKWK/n9scZbTL3bYQH1QCbgo9ItVfuXauwIzihous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Hjzwn3Kj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235189adaeso7078985ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741255044; x=1741859844; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=Hjzwn3KjYw8Eou3QnNb6xowZIEmBUupqNIClkt/HBVzUdsnhmJnIXlyjcGNhs5m5Ga
         0I/Dfr7IKdHMR77f4VWw8qtuiYq7RW4WCqyeXMN/x1wt6CaYL2tWsn2FRV9uU2xbfLRG
         s6cN4pZwOF7NJZ90XsIGlOM5Xnhz5nbobFyrgtdbvPYb6T2nAwRELsJe85ksNGH057yD
         FY+FyHmlpWYnG0QxEDpECDbYnzZ1sdquLrRHTtbGu6VzCW+OB2ZaBlCh0LytB8+HOjOH
         OZzOpllSPib8iVsJKVmIEcZ4tQ+PHK9QLUpTXWShCbWYdSaJIYIQzimpxctJSjPoPlUD
         QlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255044; x=1741859844;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=m5Ztrmt59heV7+qD6zhN27I4CBYZP+T/S5jQh6ESaC9bp7oNmPcMhq9Qg6OqZdiRIy
         EPJEvX49IGYjhZNu8zvXp6GstAe8C/HKc9fSJKHQYe9/fAOISzQWpkgpYxmld3bwyihz
         6aYSwiY3kxOt2IoUaw3iV3iym0szf9U7SgvHE9oKkDrL0CUb2DgHmEtTtVwkTffcu4PO
         Hw/jFEwJnWaOfx9H7MKnv7rVc427Infu9w28Bjgo/Fx+CzqqBdrxu+zwj9pTB+BCwH2Y
         JiM8cRpt5WwMARTgjyU5kVqTmwr7g7O8wXbkB/q2Dk3AKnBbxeNm0GbGgBdQxro2yrSS
         xbRA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DW1eFaDOM5cJaeQTd7lD86UzstRBGBbxC7TYxnjTfK+tVeYDG3efmua7EBWig7bt1kWASs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRApXme9ZmuQMq7mYb7ywaSIz9jSuYLCz0M7shDYkZeqjHVTbq
	RXSUCuVNsl0ai7asCqekhu6rvqu/TZ9hIg+fN9glhI6+SCKPFIwFpabpSk06bBo=
X-Gm-Gg: ASbGncvDLH4TveGbkl5i/WA5ZlfHoPcInTbZD9Gyvj/jx4GawMjsAe/HDmnp5WCXBds
	W8Tx154lnNG2zZop1Wudwuf1BGSSmlHqjerkQzgkgv4i+6xKWDAN2bHVSTPunRNn6EBTUN0cmF6
	IHQD6yDGUpsLmrihDQ23wlQNBGRZr3bDApbUY21jP8CxCraEc8YM4jvua90Ue9tEklCzNMEyV/A
	5i4pIw5hDZkjcuOxg5iASiDhZgoQ9G+ulTVVXhWT1lr4j91IQ3uO2o3Wp6IPLLCMXBNhHPdMTid
	/ux/2hjai4mruBHG61vvNoJQAIP3uJ65/xsf+9AsIDCFUYem
X-Google-Smtp-Source: AGHT+IF8DbatJk1Q6ANosIF8NkNqX8HFE0PqKk+dfYmnjOrPC/QDLXisFNDJhmMcDSA8YlhDXsU1RQ==
X-Received: by 2002:a17:902:ea03:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22409426beemr42036455ad.14.1741255043950;
        Thu, 06 Mar 2025 01:57:23 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736985387d3sm943032b3a.172.2025.03.06.01.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:57:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 18:56:34 +0900
Subject: [PATCH net-next v8 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-rss-v8-4-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
In-Reply-To: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
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


