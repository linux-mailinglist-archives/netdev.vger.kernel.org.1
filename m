Return-Path: <netdev+bounces-120505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5C959A07
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586A5B245F0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FA192D96;
	Wed, 21 Aug 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6Qnkxuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4B166F04
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237428; cv=none; b=VAXl5QbBRT3HuW2+s1GjgXiNBDjI++LqmN6+7vobomiVNuyL4xM3D8fJWEFCw31d9WDgCJy0GV657hM3B+McSDXiWTZuZ2o8kPyjy4UFeu5WvIR4enL9YJe/p25h4eU+Wnv8uxrVt293bE2ZB08hunKuF7yRXeWkqJ+kRu5grbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237428; c=relaxed/simple;
	bh=op/n4zpte/oz35ANwLNxWsnhnTE/6WXRxDYlxzLTbaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT8LPcV3NPMG9RjjkL/aBQzQLV5CTpM/8T+VcHvgGDgA/TFC0QjjfBWv8h9gM0mq5aivyyaQshMRYQUPTDE04yAF4hBoAKf8q6uSIHAi4wYWuGmyp+swVoGuecU40pS/+8ctddo+SRc9Kp+8A/I9MpSfTChndner7XaXAaMHHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6Qnkxuo; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5f24d9df8so3428937eaf.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237426; x=1724842226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMKxbS9x+mrBqvRfcgMerk1mhSE5hvUdcOBzhbHf9TI=;
        b=Q6QnkxuoVVye/cq8HpZA4wKNtNxS98pt6CoOmMxDE74By4NzwBRrIB0tnawh6WGUjc
         m31Iy6iTbf7k+uS67Qk7iZQuU/eNBnMSHOLO1OD1+2a/CYQ6/fxWpDTw/7FFkgJC5fgN
         iZdmnPpgGmiTwAmQG91r6R/Qhp+LVNomsa7H1NwPobmeTiEMfCAentczJzs3PHk8p1Mv
         PflJ4Ke+YHP2Zl6AlCBR4p2M5BmO62uRdP9s04o060EZw4i4PBujM68D7klYV1rnoBrO
         pemygJcEe5jLl8i5dqXMVs7i5dQF1tPnRuAJrfYAo4oNVuhBncNrnor+XWvW93fZchrx
         TuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237426; x=1724842226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMKxbS9x+mrBqvRfcgMerk1mhSE5hvUdcOBzhbHf9TI=;
        b=D4wqMg9XHd336W49jeqGRUniB8jtWX3a6UznpyB/MD+Ux6qo2BR+w3f7T9GWb1CufV
         HmaVIbBD5xDJFKBuVl+Chr4xH/gaY0lXs+rK6LmhyWQoZ7aLNkG4tgsoyHmhvZgoACe5
         zeXnByaamcctmzZX1t1HWdmkG6PVrsdF7apwfGO2c5DUWhRfzOsxYRV2UqUQkZSguG6U
         tV6pCcjuTBnZ3CMVvgtSPtH/9uS4B8fqzQ7RKZKu+8cQvwvL5+wLm6Ix7FsXO/Si6LuI
         dEJ4IILstCffpwsqCtxE+aWImIAiN+Rwpu/gsOfvsKKz/McXhk9WoBGz1MhK7H2Pmkq0
         cD0Q==
X-Gm-Message-State: AOJu0YyTI1T51KQom4M1anOU2RSRCH9nF0RVrONcg6ypxaPKENQJr3fF
	5Q+WQjqFmFXu0BXaSzRyOxmWMAlB6eOVD8dFhawpb6LlH9EzwQlTQowSoRI1nWk=
X-Google-Smtp-Source: AGHT+IFy9RpkzMPUkvpZyqWmjoc2nYZAKk7bXtz1vjTbLJveyZC3OyzBtXRjqkHWL7hOl1K87KO0EQ==
X-Received: by 2002:a05:6870:e9aa:b0:259:ae64:9234 with SMTP id 586e51a60fabf-2737eef29ccmr1787465fac.13.1724237425626;
        Wed, 21 Aug 2024 03:50:25 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm9652521b3a.20.2024.08.21.03.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:50:25 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 3/3] bonding: support xfrm state update
Date: Wed, 21 Aug 2024 18:50:03 +0800
Message-ID: <20240821105003.547460-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821105003.547460-1-liuhangbin@gmail.com>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add xfrm statistics update for bonding IPsec offload.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2fffc5956545..e4e73664cd35 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -674,11 +674,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_xfrm_update_stats - Update xfrm state
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_xfrm_update_stats(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
+	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


