Return-Path: <netdev+bounces-123549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4A9654F1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127761C22774
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439628248D;
	Fri, 30 Aug 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OouKwpdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6E28EC;
	Fri, 30 Aug 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983344; cv=none; b=uNdGTskEckMcIvKxqyHsvKLhFh/aNY/b7PimHM9tPhA7qB1W/wKk3fa2x/7RqQ0uZ69dfYPti7NvfUICbAR5dN8tthTMtrWZtzEd9MEJV0yBdU2eES7KGePjd8DsTUS18tyA1mVg3YtUWX1jKn0LOmrrDo6hdqcMYpQ/SDil+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983344; c=relaxed/simple;
	bh=2MsjVtpNSQ67FNJ4nyDqxQdzz20Ga+qv5kbPYvq6KC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXsDZGkZMB/22Gk4JfAeEu6jHHBGDYRe4tJV1cytHUFkhSoPAERlSR7orR57fzEOjiHNPgdhx8jK4MsNzf1Zts/6nZDRTCuTFi/Nf4UrU8AlEuxxH+/ERFetTEt3G04jRq1QKo8UL/G5DmYbGmNu8reTauKGMD2jo+Ya5aNDjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OouKwpdF; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-70df4b5cdd8so879114a34.1;
        Thu, 29 Aug 2024 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983341; x=1725588141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQccGzW41EWAydouAjp2fjLVFqqDcbdOnftN+S5EC4E=;
        b=OouKwpdFveX9956ajn+Hkjn3jBmGCzAGy3L7fIgfarAOv2BEQs42Fj1r5QxQsZ7/Sy
         RJU8vb/IK5l6+5X8CIV2FpH/ar3pAmgq9KSriV9gHyyKUqEJ/lgTRX5a1Xqnneeyxj+q
         TJzw90L5scsn4uiwcZx0KQH2OUOlad5wl/1udPH16QhOITGna7ARLHr0DP1U/NYbNk6L
         5FHggjsdMQMu1co/ETdd5bKFadqjE0yoV7dbFNp8QXVTAniFHfxPraOMQtFlHHm7R/ko
         datkcFeLY9MFYoalgcjbAk+wpfFhQF7UgWvZ19N+lzcN8wkCWL0cY/cT4JIifCzIJO+n
         GvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983341; x=1725588141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQccGzW41EWAydouAjp2fjLVFqqDcbdOnftN+S5EC4E=;
        b=gHsJEs4r3mQsofkKGlzh752dZpZR4km0wtP2g5NWLb5QT94jeK+CFCtTuZUY5ZUXl2
         SMI7fQ45EgioQz/WRA9gPM+egmxlVMSJRA9t8G+T4r8EykFyHoY0n73+Fy/e6gROcfyr
         iAVyYTOHeJYKE5p7VdDjgRUx3u+qUB2cxmYmlQMXGeJZuh39+brKMhHzZahrEciTskfZ
         fMQ9MqgrDGQ+je+x6dDkVc2bD17PkQ9T9tDTzbRfxI4IdkYn8cNiOdMPHt238CWCTdeh
         9kgx0aV79CN+CJZS7WOuvcyDfa4ic5lQYJ22nFu9Br0AkNkdW7uD0mFKcQwh1FwUfhgM
         gjyg==
X-Forwarded-Encrypted: i=1; AJvYcCWmObeYTemHs9vn5uZNaSSA7a0K9mcnsDZyrTA9NIUY1qXaBWN/k291YUZAQ8/GjnxkCQqlAagnaKS3aBY=@vger.kernel.org, AJvYcCXg+8KFBgFve7WAMfJbJVn4+cr7BAvYJPkNtVkBaJA04/ibs05z3pMU0Ttk2of+ft7s67yjtXAn@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFmI+GHQVWFZXKkRZy+JOHTS9bX4RDEjipY1qb/IDenfQUjHK
	lnzK99+GrbOChj0x/lmKaysa1QNa/GTQoJw7JdD2PtVboJtCo5AT
X-Google-Smtp-Source: AGHT+IFtmKf1pY/c1Zqt1gsJnjZ6CBMnPaomHRo9QgpWAQw10PSevP0JfcBJ3F8Zd4RP0QRG/o7Ssw==
X-Received: by 2002:a05:6870:1d1:b0:261:7af:719c with SMTP id 586e51a60fabf-277902b2b13mr4875252fac.35.1724983341517;
        Thu, 29 Aug 2024 19:02:21 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 01/12] net: vxlan: add vxlan to the drop reason subsystem
Date: Fri, 30 Aug 2024 09:59:50 +0800
Message-Id: <20240830020001.79377-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we introduce the SKB_DROP_REASON_SUBSYS_VXLAN to make the
vxlan support skb drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h          | 25 +++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_core.c    | 15 +++++++++++++++
 drivers/net/vxlan/vxlan_private.h |  1 +
 include/net/dropreason.h          |  6 ++++++
 4 files changed, 47 insertions(+)
 create mode 100644 drivers/net/vxlan/drop.h

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
new file mode 100644
index 000000000000..6bcc6894fbbd
--- /dev/null
+++ b/drivers/net/vxlan/drop.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * VXLAN drop reason list.
+ */
+
+#ifndef VXLAN_DROP_H
+#define VXLAN_DROP_H
+#include <linux/skbuff.h>
+#include <net/dropreason.h>
+
+#define VXLAN_DROP_REASONS(R)			\
+	/* deliberate comment for trailing \ */
+
+enum vxlan_drop_reason {
+	__VXLAN_DROP_REASON = SKB_DROP_REASON_SUBSYS_VXLAN <<
+				SKB_DROP_REASON_SUBSYS_SHIFT,
+};
+
+static inline void
+vxlan_kfree_skb(struct sk_buff *skb, enum vxlan_drop_reason reason)
+{
+	kfree_skb_reason(skb, (u32)reason);
+}
+
+#endif /* VXLAN_DROP_H */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 34391c18bba7..fcd224a1d0c0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4833,6 +4833,17 @@ static int vxlan_nexthop_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static const char * const vxlan_drop_reasons[] = {
+#define S(x)	[(x) & ~SKB_DROP_REASON_SUBSYS_MASK] = (#x),
+	VXLAN_DROP_REASONS(S)
+#undef S
+};
+
+static struct drop_reason_list drop_reason_list_vxlan = {
+	.reasons = vxlan_drop_reasons,
+	.n_reasons = ARRAY_SIZE(vxlan_drop_reasons),
+};
+
 static __net_init int vxlan_init_net(struct net *net)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
@@ -4914,6 +4925,9 @@ static int __init vxlan_init_module(void)
 
 	vxlan_vnifilter_init();
 
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_VXLAN,
+				     &drop_reason_list_vxlan);
+
 	return 0;
 out4:
 	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
@@ -4928,6 +4942,7 @@ late_initcall(vxlan_init_module);
 
 static void __exit vxlan_cleanup_module(void)
 {
+	drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_VXLAN);
 	vxlan_vnifilter_uninit();
 	rtnl_link_unregister(&vxlan_link_ops);
 	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b35d96b78843..8720d7a1206f 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -8,6 +8,7 @@
 #define _VXLAN_PRIVATE_H
 
 #include <linux/rhashtable.h>
+#include "drop.h"
 
 extern unsigned int vxlan_net_id;
 extern const u8 all_zeros_mac[ETH_ALEN + 2];
diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 56cb7be92244..2e5d158d670e 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -29,6 +29,12 @@ enum skb_drop_reason_subsys {
 	 */
 	SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
 
+	/**
+	 * @SKB_DROP_REASON_SUBSYS_VXLAN: vxlan drop reason, see
+	 * drivers/net/vxlan/drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_VXLAN,
+
 	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
-- 
2.39.2


