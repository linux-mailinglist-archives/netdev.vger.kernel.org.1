Return-Path: <netdev+bounces-174450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92581A5EC72
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C823BC273
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6D204587;
	Thu, 13 Mar 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Sxrp6bG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5B203714
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849331; cv=none; b=C2sG6tz68qtJKZiEtoSJtRwgE4bZerZpp1X6pCnATj0+bPvC7kDlme84wtlHw4Xq1m6579QXgNPwAYzo+YlhQWLovXHRESqFa20s9NNnWQFs6LG3cxAXERZvbaN7o77/ra0lYRl0D63ur+hgbXJsV5jBnmxRxMoYBP0C8lrdxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849331; c=relaxed/simple;
	bh=GneHmk/qL//iBdk3HQU3hkToakkrBvwUGgglHdEvMAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Auod1L7BSSu7ZeyuAF8IzsFm7+OC3aVMhKQSv91bw0a3FqKk0fzxjeBiVLIHYr3Y0FllS5UbkrgrUnICNiFBm5aXB+t7YXMozyK0Ik3Qx3K306EjPSMJvvQeMbcCUFIHwuDvIj4f2utEjfwlkqEJYsYtSMs2u48j7lHMSGpynp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Sxrp6bG1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22403cbb47fso11884695ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849328; x=1742454128; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=Sxrp6bG1mxL6vWdR8RGIDQQkX9KNPZJ34DspQcOeO1giXocwQVlD/GaGu3NJAf+osn
         UqeKnrj8plUVma2iEDhpLchJNffFqCo5KlNnxuJMiFKyiStxgjUxTh53cO2dXn9d5GhZ
         di2J7oTFDn5lYbsM6ht5OsQ0YanuxIrU30hGkW2HPds9Qrw4v9/v0oB4Fv40HgXoJGPe
         0yqfo+ojJAPukwNDtR5sbpuxAcDtcvpGvyqPebYxcWQgPJvZYhwlG1/6bcoEqlKPsLWL
         mEeBSRWKXggnxvRM+JjJP8KvktZT3Wc7LrsK0+Zw6qea5qT5MknQdcqPzxkRthlHWAY9
         krEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849328; x=1742454128;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=w7zw4oa6Zjz3M7OUV5ZYYZCtlk4edzqMhSX2h4eCERBa6QkhPvnAuhfnEx20PGcerL
         v5rizFO0YTvoDvRcjXZaCanZpXXk13gj9g58Wl2Dx+3FZsRYGStlRkxULV4QpSNY1vs2
         xyZyoWyKFI3hU97YGRGUll7VTsgsQAiJmpmIM06rcPWrW9eQWhpQQu0n7oV4vBQHElc9
         f7L8j0bt7ustsbbTwZhR15vkMwTak4ikExjAV9/N1F6FJIWoGfOlVL/6+PIgqQgzZyfy
         5s5oJkCjQuUax4ZV0pw3zZBNVv2cpgvRKkME/QAr7LdqD9G/yJh2o4oHYixAMa+RvvDO
         oFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWH4s85hgv52Psk0uc2g4xSuaAuU9fb4ZJCWCNemLqa+fnhjS28x8hRB5J8cKSmgRfV4nnLtNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOBUkdcqOlCRrBERVljQhLoVnJHK2kxe2oyJ5l/LsP0B+TDcU
	8qiDGA3YqmZElWfSbYgNDwy0uT86TqDuDbRXXRIjLwF/QLTYPSiWbEy2Qh7dyBTmzToMsB/s8Mo
	9egM=
X-Gm-Gg: ASbGncvuEgCuooX7VxLPoaf4hMGndOQvCRxTQbdknvdRLr3aJ6lfYsn9nLP2k++R6Ev
	6SOHoF24cdyhsCu0p94RHcQDISTTlxo5ndB2a4H2eB1x8+QaziHah+6nNXTKGaepL37U9Q5wEpj
	SAixM/M/wqlDN+JFqDBGbJSITJei+caO4SFul1M0No1J4rP01EnnXovvUBJy0fh2BxSCGu0n7eY
	gwrHSDpKl3EvN2orEF2RLT4WTAfKiq84EA1Hk+6ygq9Q0VrlLcsT/sFMef5le34qtPq5AnTxFVf
	f6gJ36FUuGvvjQuPODzfk7Ro1XrZLZYlic+aYfrR8o4d85aI
X-Google-Smtp-Source: AGHT+IELBqab1Bv03Rmb+11tOmP6uVWtb9Wp6RhocPBZEFYo+tXlKUya4SfhZrxV9fTmHmtnOCET6w==
X-Received: by 2002:a05:6a00:27a0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-736aaae81dbmr33112877b3a.21.1741849327993;
        Thu, 13 Mar 2025 00:02:07 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293f6sm662442b3a.14.2025.03.13.00.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:10 +0900
Subject: [PATCH net-next v10 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-7-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
 tools/testing/selftests/net/tun.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..ad168c15c02d 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,42 @@ TEST_F(tun, reattach_close_delete) {
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
 TEST_HARNESS_MAIN

-- 
2.48.1


