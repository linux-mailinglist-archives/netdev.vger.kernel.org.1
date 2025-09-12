Return-Path: <netdev+bounces-222694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91DB55728
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80997568086
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A62338F3B;
	Fri, 12 Sep 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN5UiRR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88B285C82
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706844; cv=none; b=mH9i2q75s7iky6qjryySF83YrMNb704STlwB8NVVzlo19I1PZLouYopwuH94o8GE/KILXh7yOjXLQYAHKM/A/LsqQzxT1DDa+b2Uv8h8d3S1k4yfadTLVJ5JPtcncRuJMo2kl3/EyT1u5TQHjt3GO0KuhFI/fWrSKia/Qmfm30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706844; c=relaxed/simple;
	bh=+Boo+k0xYpHjL8WYaZHWRNLexzGpn7oUg7CNdHKj6jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dN37KAARKgUPwdGsUXLQPXZmGNswo/0oLvippFUG8BNMyjOQV7lQPPnebJAbsoVsZYLwh4cI1k5UimNkjuhk5E8/q2RrkfKy7k5P8y4m/Y1/j73+3DT1VOLl5mb/ZZF5JEaUUY/+59FWkvb/uUcbayK51luYTaws3I3/fYEp4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN5UiRR3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1278676f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706841; x=1758311641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO4u4FYaZSx4aTsmPIso/KYse1z5eIT4Ei8aQ7ydUzs=;
        b=FN5UiRR32UvorI6pLawMz/XKl8gYxeldbqK64GyxlGtQx/Cz2v0Y92yo4IGLOYsWlP
         BegDggNJyIeDo3bkZjEftz5o+IZSTKayHEgurqZDGGtjUsvnxgbA4QQnmJkOvammvJg6
         YHtd1PTmhEOI9WM+3RRKhe8g5Dvu8Mm1Ciwvxj2kX6OasOfG4Q7/Lij6kfKleCQtNZ0X
         Or/xRkNBE0p1lJt6QjGp7L9TOF4hYLvjtRJAxqZ4NCEF6jKjNHqgA5CvLnm4oIiiatNi
         mHtjy5ryPkvN7zDhCDYwVDpyFU28kIaLsvY/wqOyhI6/cTLNh69Da9/PMI8ID+WLGVSL
         H6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706841; x=1758311641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO4u4FYaZSx4aTsmPIso/KYse1z5eIT4Ei8aQ7ydUzs=;
        b=lJzQF6LKfJDKX8HqjBMi0l4GcwsdSUw6V2M4thNthvGaJbfSRYeyVBvl0jbaQkzIcj
         X0/9ft0VdfG6kFGTZn9RuwNxqbVTSXk6KacFiIL4sK/dJ3d36ov5tzYP/1UXF+LqDPby
         dO7FehuanULFBQ3ebDjWsOqcTJrjmvjHiicShaD0/UbbSnxn3sXGeBIeHQh3SKM8k73o
         73KPdmju3K8HVzx6lNsbJqLKaiFQ8lR5t18OQidaV0qcO1/F4kfXOnQJtE8CbvhIpkUe
         iuWViYV+B9wTn6wzGVDQ67RPq9eiMxgZKwznVpSUeuVXm/qw27fqDyBW9VOUeWY68wuI
         hjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX8drLvJ6+xSWLWPrMCHK+wKraX43t7PaeRxuif95JjUUfqkyS/g8blChxdJyvNu2pDUHQSzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKps6GYsmz5XOTIUZiAEDeY7tzF9OSH09gcrmKdpNM56XJISmx
	FBrhy2LlLbSKFNyaFvSoE95dQrx/slIVQ/KSgxLNhma4KgycG3il7dIs
X-Gm-Gg: ASbGncsuOb+QRhpBuK8DeKB6o/gUqRem4LQAbulZY+3eMkLaAt5syf4sBRSiqEDVsBs
	ROABAnW7XsYJQ+glJ9ha4Os+Kk03kQ614YVNLBz6zF0hPpYKn+ULSCbtLo02GeZRk/SpOrVH19t
	LIkkpPUXCv2+I4+1Q1MdfgGFZVSgU9laeY/6FluqzQ7/K47qRqbX8VsvQqwmDwT+6UW+JM0LJa8
	BQrAHWKC7JT/PyszYy0CRiJtAEmLEMmJWZ9Yyx3ewdYvg8sVI90PyCdI0XGttQyH1xuTr7q3apg
	OlOdlt5TQBlARsikhP/CnyeLeWhtZn0HUi5DsJWIatPUicuAJvgp2TWjlhm6P+NwyXUMYuacGja
	IDglurJIRcoMaLMmX/WKMFnm2IJU/QyP56y8hhzTmaYSb9FvdIsYn56uWhQ32JFS/hvuyr5dW
X-Google-Smtp-Source: AGHT+IGdFk9BCXQgcCSNLpqk6aqpiGjSFef9ADNz7e0+I/JWZ5lLT7g+GRXlT2NPW59FSecWmq1UlQ==
X-Received: by 2002:a05:6000:26c8:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3e765a140damr3473035f8f.31.1757706840813;
        Fri, 12 Sep 2025 12:54:00 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:00 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 06/15] genetlink: add netlink notifier support
Date: Fri, 12 Sep 2025 22:53:29 +0300
Message-Id: <20250912195339.20635-7-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic netlink notifier to monitor genetlink events:
- Simple ntf_genl_event() callback returning NOTIFY_OK
- Register/unregister in module init/exit
- Error handling for registration

Prepares infrastructure for tracking family registration events.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net-pf-16-proto-16-family-PARALLEL_GENL.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index 245f3b0f4fbb..cdedd77b2a1b 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1116,6 +1116,16 @@ static struct genl_family incorrect_ops_genl_family = {
 	.policy = my_genl_policy, // random policy
 };
 
+static int ntf_genl_event(struct notifier_block *nb, unsigned long state,
+			  void *_notify)
+{
+	return NOTIFY_OK;
+}
+
+static struct notifier_block genl_notifier = {
+	.notifier_call = ntf_genl_event,
+};
+
 static int __init init_netlink(void)
 {
 	int rc;
@@ -1291,8 +1301,16 @@ static int __init module_netlink_init(void)
 	if (ret)
 		pr_err("%s: Incorrect Generic Netlink family wasn't registered\n", __func__);
 
+	ret = netlink_register_notifier(&genl_notifier);
+	if (ret)
+		goto err_family;
+
 	return 0;
 
+	// netlink_unregister_notifier(&genl_notifier);
+err_family:
+	genl_unregister_family(&my_genl_family);
+	genl_unregister_family(&my_genl_family_parallel);
 err_sysfs:
 	sysfs_remove_file(kobj_genl_test, &my_attr_u32_genl_test.attr);
 	sysfs_remove_file(kobj_genl_test, &my_attr_str_genl_test.attr);
@@ -1309,6 +1327,7 @@ static int __init module_netlink_init(void)
 
 static void __exit module_netlink_exit(void)
 {
+	netlink_unregister_notifier(&genl_notifier);
 	genl_unregister_family(&my_genl_family);
 	genl_unregister_family(&my_genl_family_parallel);
 
-- 
2.34.1


