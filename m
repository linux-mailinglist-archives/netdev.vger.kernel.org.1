Return-Path: <netdev+bounces-118828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C858F952E73
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446B31F23887
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA0150997;
	Thu, 15 Aug 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3CM/Cqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132E1AC88C;
	Thu, 15 Aug 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725951; cv=none; b=ekK4UuypCueVr0ntFZwOfh8uwXrVJzFy9lvb6fOIzVEzEUFequlNERonmL5OBIlKVWWY/EZx6WANMWU2AscZQ3+Mn6K2wl49KanDycEe9IauU7Jpt93+sK8Y+gGqe/LKr2OHBtgykBM0cxxlXRhy3gfte88euWw0eWOEAc9XRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725951; c=relaxed/simple;
	bh=tL6JvbRjlWSlxR/d/T0eoTIwMHVhyn1u2kUnYN6CNX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I41LvMTfrrjs6TvvBsXvclT8JrkbEFyc73gSCy46unUk4gH2kI+jMdnx5RUqQTYrISy/UNP1W5oNLliS0tRs6bVx9ICMEW+mtz4IvAzNMgcDoUIahg91cETv4/BZqqT8Fe3dzTZXv0fIxT5jlajMR6grTCPUJRz46QFWDb3iBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3CM/Cqu; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so681998a12.3;
        Thu, 15 Aug 2024 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725947; x=1724330747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fta6JFeSB7c5lYbnKfFdO8GDsHLzjfZEltROIk0550=;
        b=g3CM/Cquv1Fa9NOTei3pjTrQ2LeAp1E7Ahc8Su7QKRc7Vu4F3uo+5++qUgeSR1z24q
         gmNvcozeksCJ8pMyHTFm5iFfJL+H0V3Gc+DnsYI8T/f6NWGxhrp8VW5sIImVMCzspDAZ
         SRENaXoOtCHETUiURnp/w4I1iP6CQv/VC8DzcaYasZVZcR9z3tzT5XIv9fskiBA1gg7h
         xqLmxz1GRuAA72dEfSYCyVdnqToLRA58VlGoF0kbXjZVIAnxqUe9jvswnU0q9S0Zj/vq
         BU7MVppt3oyBkr7OZOa7JeTlYTZTlD8Tn9948eVe/xgz7QDpFUVhwQYh43/BJzKlqEsh
         MNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725947; x=1724330747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fta6JFeSB7c5lYbnKfFdO8GDsHLzjfZEltROIk0550=;
        b=A97GMnIhysBMa2UA9jSuLDcfmG2jPzEp0sjXNqo+51tU4bQ2/X4Zt9A/mWSsMYyrR0
         F7XgFPXxxWHViiw6rXq9jRlsgsw9Usq0aqWbkztNHUCK7Fmkw397ysxcoSjkJ7h3aCN6
         mFaij+2pTYcKknBhKiZYFfrqRCBInpbtMprt/jjrizA+iSiGtBCor9SPdklIMPy1lLtN
         czYv87nOUOOMq5RXs7TCsX54I/VqWsx/d8ZigCuwjKjoplQNNaziS8u5cVbm0HOLHrct
         HFDz560h0+hjTVQRTVrushPIpHVQ+taQC1LQbkFlpoP9skK+qoVn5ilOw/tTb03jBHqs
         rkKg==
X-Forwarded-Encrypted: i=1; AJvYcCX69+cKG0W3u9q/7OD8ZwmUm45MEIjEcGyF2QkmXZMP6PpgoGWrukm86qEqq9PlGkqHpYECo+13Sg1XFPTaGI38WJ77Unedv4Y5D9sHal7cFdNPLykfCAcGjrzHJZRVMtdKiswh
X-Gm-Message-State: AOJu0YygU1TvIXMJQoqev5GHYRhYzB3QbpFRKnOngDOpfkvJxDlydBe2
	MFCxP6Tam/43f0DVB0TEVOnqquoDkag4J+P3UNJhsD8CEpubgQ29
X-Google-Smtp-Source: AGHT+IGzeTxcYDyToKt5s0HI8cdzCxZaGdO46vqfYjT8o0A7YZnjgjuqL7cbmf0urTwPOjFBFnsOFg==
X-Received: by 2002:a05:6a21:3483:b0:1c6:fbc8:670d with SMTP id adf61e73a8af0-1c8eaf63fc5mr6876058637.43.1723725946566;
        Thu, 15 Aug 2024 05:45:46 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:45:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 01/10] net: vxlan: add vxlan to the drop reason subsystem
Date: Thu, 15 Aug 2024 20:42:53 +0800
Message-Id: <20240815124302.982711-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we introduce the SKB_DROP_REASON_SUBSYS_VXLAN to make the
vxlan support skb drop reasons.

As the vxlan is a network protocol, maybe we can directly add it to the
enum skb_drop_reason instead of a subsystem?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h          | 30 ++++++++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_core.c    | 15 +++++++++++++++
 drivers/net/vxlan/vxlan_private.h |  1 +
 include/net/dropreason.h          |  6 ++++++
 4 files changed, 52 insertions(+)
 create mode 100644 drivers/net/vxlan/drop.h

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
new file mode 100644
index 000000000000..83e10550dd6a
--- /dev/null
+++ b/drivers/net/vxlan/drop.h
@@ -0,0 +1,30 @@
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
+#define ENUM(x) x,
+	VXLAN_DROP_REASONS(ENUM)
+#undef ENUM
+
+	VXLAN_DROP_MAX,
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
index 8983e75e9881..5785902e20ce 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4834,6 +4834,17 @@ static int vxlan_nexthop_event(struct notifier_block *nb,
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
@@ -4915,6 +4926,9 @@ static int __init vxlan_init_module(void)
 
 	vxlan_vnifilter_init();
 
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_VXLAN,
+				     &drop_reason_list_vxlan);
+
 	return 0;
 out4:
 	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
@@ -4929,6 +4943,7 @@ late_initcall(vxlan_init_module);
 
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


