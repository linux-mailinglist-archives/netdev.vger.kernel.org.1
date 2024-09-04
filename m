Return-Path: <netdev+bounces-124766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369896AD64
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED48F1F2588F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9563D;
	Wed,  4 Sep 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj6+Qr4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D6646
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410118; cv=none; b=CVcpJauRPtqd08ErV+qHvtX9gbaFvci8ED51+/mXQyup+WpiKJN1oAbkI2gY3gVnu8TMiZHnhUYfQDuw9Hp7w0z47DhLqo4uhXHPRobB/21s2cbRKsHyQmhnyw3qnQZ5CHT8SIznNzFDGSxlV4xHhDjwd++8bjJa4f3GMaa8h50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410118; c=relaxed/simple;
	bh=Ilk/r3EqQMJreOmj91JPQuwrxQIJ/C1rFi8Z1C5hXug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Trbvm7SlxwNr0dKSYPBgp2AL6EgYiyltB+MqRPvj4GProgr297bfoh8aNSbrVF3fGX0rL1OxkAB/IqjuMMk6J04E7Uey9czFtpvHU5I7WwwkFoLJtTXxu6mk6lpItsFkd0GPOK8WGDeS7tkp+j3l0DHmXlQDkzvWcUyZzk64yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj6+Qr4a; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5dca9cc71b2so175844eaf.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 17:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410115; x=1726014915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP+kyHfxNs79ILywdhtEjvX/1fKjka7Zb78lPonahLs=;
        b=Pj6+Qr4an4ceHaYg+nYI5cO9M6JinM4AGrhEvjDNESN27OTQFN/Fm3CgCBndO6AUfb
         G4fP+bczFARCe99+kZleviM/6AATulk3EI6AW8NmY9odyB6XcYPKdV40VUfLhCxKSq3F
         TKEfHxlBHikuktURaGsM93s7ivEtBGrNAKr6uLrB19tsGgP5pk/QKaGRlPouzu+lGTUU
         HqUC6QAsa4eGmFarGFl5sOlskrc9a6dnctRN1PDnqVLYsHbX+TXF993cNB38avxfMRFX
         wUe3hQiYAbLWaLvH7XzWkecFG45bXcbBs5wORtgN3yUILYsqk4ZdlTO697I0Cz4ZYTcy
         Yn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410115; x=1726014915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP+kyHfxNs79ILywdhtEjvX/1fKjka7Zb78lPonahLs=;
        b=XPSRdo78UzbL0yWhttqam4+uDz847bn13QqEup1L2AxkpjYh8OL4DbZLdiJgS0hQb4
         XYRCQXDMicqUaRrYkWlKs0PmQu0bIsbv08vPHNxwdOngCjY796ohn8ejsqSDdWBjoDqA
         N19bl+KQIBDj740FU1Jzg2O4RtMCxy6SNDXfWV56/PStqeAElP/Xvp6bkjYl1hG292bk
         RoW161ugV57hcwSfdnStsvEJJ2iQsMiIu/jtH+PSqWariTXH4xplAoHSIugHYlZ2+Kru
         gGEJIF+6/L/N+/e3eHDH0pEm0NZGUNqzhR3XmlfY6FaNGnm+dU4WfbTiOQwX9YMm1y4n
         Nz4g==
X-Gm-Message-State: AOJu0YzV9NX+87cgxpCGMM5pKQa2rQ850ttjdw2xg7zEIsQw33ZKUIv5
	sNwMntNm7lXIV2SJ+IkEoPqxk67Dw8CZ7YBrHL8UPfIU6lk75d78awhokeoJ04P/3Q==
X-Google-Smtp-Source: AGHT+IFNn2EceYt6pq6dnoO3LsKl/54/jki6skUFoG4ewHvjc22dQFTBWIXXcxEoFN+YivIL4A4mPQ==
X-Received: by 2002:a05:6870:961d:b0:278:2316:8422 with SMTP id 586e51a60fabf-2782316dc23mr3645919fac.27.1725410115267;
        Tue, 03 Sep 2024 17:35:15 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778589133sm444218b3a.109.2024.09.03.17.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:35:14 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv7 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Wed,  4 Sep 2024 08:34:56 +0800
Message-ID: <20240904003457.3847086-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904003457.3847086-1-liuhangbin@gmail.com>
References: <20240904003457.3847086-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 46f46fea9152..a6628b1f33a7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -694,11 +694,36 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return ok;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


