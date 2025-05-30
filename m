Return-Path: <netdev+bounces-194314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BBDAC8792
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 06:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924DB1BC3AC2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 04:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBB821FF28;
	Fri, 30 May 2025 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HBii2iHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B781459F6
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580658; cv=none; b=HbCaF0bxznL0NWy0RCL8+J3jVRFi+VLurZCtZBzGRa49efqR8qt0pyuNmdbJMbamoClyXVujyd8QVcimnb32jYC1CVBk4DluDFRcmAIJuWbQ9u5GKp+m1gT4nagHffZ2NwDky2h72kHGO6oB6hYr7dvrF/zkYRh60A7BB8RHACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580658; c=relaxed/simple;
	bh=Y+hugblmAxgmRkyn2fxyuMLaQgzvEXZBlnk8Jh/v8UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=uxIPub2mS82pOK7X7USSK59LMJ4eBgsX+KESszeEJoyaeTbjv6WO1lT8xdxYqh7AN2D2C0O18gdN2Cgu8XGnSL7ODW+X3yrbC+RNPKu/FAfr3pkI6d5n9ECskoZeutVQAnfoIQXvW/dNRK/AbFctTe9SaxuWnzrC13q3FbIsdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=HBii2iHP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1189928a12.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580656; x=1749185456; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/6gL7uu88i7p+1Fmf1z5Sh293hU0sJzRplicMeiOvs=;
        b=HBii2iHPzoj9jJ/IffKhV0roKmT29z+48zVvaXIBgN+JH0g/9B8VdOlUXh0CcHBWgV
         fNbChmEtmX0xPgGFoDX+th4mj21BdMXBc7o11Uyi+Rk30i54khWidHIk5Sg4/C4Kr1xG
         fuCIXBdMx0LmdeSRs1HLQjY67prBjyMOpReJ9PsPO/+UJjyRRowIzbLzb0cYtHLLgf4E
         H2J7MC3Cz4cjzR7Squ3QiLiMjw20Z03sTa7aCO8b5T/3IHoj9YHpE/2ZAd/XtLFi9FOX
         WSQ7ZdKIi7HZN5YALumYb6Kwh8+UIcrxmFazHhR4XP0R41rKbWWgjQshZl2KZ+iK3+zw
         Kacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580656; x=1749185456;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/6gL7uu88i7p+1Fmf1z5Sh293hU0sJzRplicMeiOvs=;
        b=DHjEpcEhQmkCCZy58MM9QYhqX/XEEfYbK16c11VKtd4Ha+U78UQan6fn7nmrDkcR1v
         EtYdRltJl/fCo+EiEf50BsAmwhp21wdIrPgJzI2JZ7Q/KqSuTj58kB4tudhxiIJgI0Y/
         erpyjCKj4VKWNSybe2TDZK6AWwXPkdVntyhN+T1gUiOIDSZJx37Fz7nG0+kRdo2zmpli
         9QtGryMy/jAw5jZJz0u+k+sOSG7rreyeXL+w/KENXaOcKYoqrYALKCT8WsxJhRVyTKIT
         lPYBG8p3OGnbGzW4al3H7DAhQHmgcjaQfCpfMaAXOxfG9Ka/b4ldDO8xDVypxts/u+HB
         xbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBUXUtkrcZGToVdZdrRbj5IssL1tKbMmby+fhMQxce9p2lYBsxUHnVGtP16PQyKgCBitHOnp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclVONcdq/LCSUcZGd5dSvF6DHVqjh8SKkRcLConrdP0lyBieD
	sIiPqFc7O7DPs03yhpJharbZGPCEH6lQSz8aJlfRXz75lBf8cRrrUcGet9D7Eba4VUE=
X-Gm-Gg: ASbGncvCDz7OV0bPzjbWxNe46o568LDZwFu6eoHEQk3l7CmCGTtHgjMc79Op8cV7Tw2
	fIJpRlS5Ru1BBfjP9WWioh1t0Ep/pGcQkgxQsnTPZqhQf3/fcKFP+csBKfiCVyfJxKBwQbl6CcH
	aCH2D5ggfQFQxr0E5Y2BcTqlOUIAc5z/rPZYQIk9Nnae8MruVVCBb3V7IhbRfsN/zzkmkJVtuy3
	dwHKhGc2haLZRSs7lqQbTl7sLctQw0WgdCe6q/mJDnH7yuO6hl8YHlQR8EV+4iwx2FWW7H+IQ8U
	hilR42kAqLXuAucFn4sYP2xCe380IXBldyQBMrSrju7CQ9PIrfzw
X-Google-Smtp-Source: AGHT+IEvyG17b9tHV2YruoiWIXuiS1hBS4XsYuWorEH+zYiLpcrIZIgqXit2l5cDU5DJsN67WvzC9g==
X-Received: by 2002:a17:90b:17c8:b0:311:c939:c848 with SMTP id 98e67ed59e1d1-3123efae69fmr3575677a91.0.1748580656408;
        Thu, 29 May 2025 21:50:56 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e2b67ffsm426290a91.5.2025.05.29.21.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:11 +0900
Subject: [PATCH net-next v12 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-7-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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
X-Mailer: b4 0.15-dev-edae6

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..41747e1728a6 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -12,6 +12,7 @@
 #include <linux/if_tun.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/virtio_net.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -159,4 +160,42 @@ TEST_F(tun, reattach_close_delete) {
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
+TEST_F(tun_deleted, getvnethashtypes)
+{
+	uint32_t hash_types;
+	int ret = ioctl(self->fd, TUNGETVNETHASHTYPES, &hash_types);
+
+	if (ret == -1 && errno == EBADFD)
+		SKIP(return, "TUNGETVNETHASHTYPES not supported");
+
+	EXPECT_FALSE(ret);
+}
+
 TEST_HARNESS_MAIN

-- 
2.49.0


