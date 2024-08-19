Return-Path: <netdev+bounces-119607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04ED95650A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845BA1F22B79
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8815AADA;
	Mon, 19 Aug 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V36x5+tt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375D15A87F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054036; cv=none; b=F5+bESmLtkTcgvj65C+8bO5aVYvpUA1c7+AfM4d1Qt7pbJRBj4q+vXIind0mdM6+I15JEbOVKYhbwhSNTBq/wmuEruafXGohb/LZ67rrfuHk5vRoC8s8jzH4dS62XuRZcmc1/xrV2CzElgCHl6pX8OlVAGq/RpgYyZ9/qQBZ5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054036; c=relaxed/simple;
	bh=WuQHL9vFk9C00Hka/NOaAJM8/avGJfAf8AAqdNbtL9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWHR0XYfhkHWyK0sIGpma0tPzMLTYKjbOYZTjgCgVKEp10L+VRxNMURlO0jXwSvwVy7ACOBgPIvBFRkb7Rrq02tlh+W8P0ZvmgbNWrGdpe3Zb/zCJIgic84D2IfBAoqBHQ+Z8s+15ELIZjSn3MOW5L+C77Ll/pqM6iIF+mQJweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V36x5+tt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d28023accso2884783b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724054034; x=1724658834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVycroMdds6D4oPSBhEK7xG3RafQTRbsAV69QyxbLqc=;
        b=V36x5+ttFGK2uggPtZg5WhWsCnFNv50Dq49Yyawn6/F5pe7CSwKsgpCvmqoBgEJhs4
         RcYr6m6fMO8sMNZx8ft4A1Y9Ch37koMOZRBffjvuh8HlrHHy6ehrAvQ8Ud2qzPwR9FPL
         onU3bAQTSmgObQrfNER96XCkImdpweF/y/nWJPKlQf1Bv5VDxlrWVjuyyZ++Uqwf75Vd
         MJCsvRuaTjpeiejy8klI6ntTIpnIkLraueMGCiwZdULMn9sHGO04I2I6lfIoY1hBjQM9
         Uh0NwjImeXHTrH9Il2fauHx9TTEdE4me53wkUFbzgscx6q0e24oLM/m3lEAs7eB5Jhf5
         zFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054034; x=1724658834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVycroMdds6D4oPSBhEK7xG3RafQTRbsAV69QyxbLqc=;
        b=U35Wsd+lbjI2YdC0/nRKq6gT1A2XHg+LFkhYsHQ5N5bYmY6gsiZ0hQSELAZgQcf5Wl
         UAf/IUgkgsetJ9zkSoeH4aILWoN9+LgIFsUxBzssB/ps1iJCOncAb1r+GUMpIEbI80I6
         F5r6gguUdOZ7td4C9z/tCtYqWerDtZvWs1Tcg4WDN0oBAy2XerdztAjR6ub/zS25WIv2
         DMhwm2MZjDvRee2asoDhg+4DJahU5NdelKY/4ziUh9YCU0Ve5uVi3Z/LnAtONWXH7IyU
         cTlzOKz5XmHaSe/sjMw1p8dsy+J7OKHJu8UscBTYtNyBzUMEnQmGCSvhu8UITwNT+tYy
         CqSA==
X-Gm-Message-State: AOJu0YzIWvTBg3AmYJD0SH8Jf/hpRPrzgHoAvIEn1OPjJ+q7BAxMikVf
	VgFmE4SBwJcuHMQ1tkyxa/hzfI4TtTFb4tbe0fRHrAZIAeJFgvuU0qBVuFbT6sRVPw==
X-Google-Smtp-Source: AGHT+IFLgxZY3Vt69re592/RBHfHPRMn0PO1CmKo27dkkDf56tcefUiCrIDw8MRSNNchVGWGMzMz0w==
X-Received: by 2002:a05:6a00:a8d:b0:70d:3777:da8e with SMTP id d2e1a72fcca58-713c4ecba62mr10191081b3a.18.1724054034129;
        Mon, 19 Aug 2024 00:53:54 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6eeesm6147151b3a.118.2024.08.19.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:53:53 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Mon, 19 Aug 2024 15:53:32 +0800
Message-ID: <20240819075334.236334-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240819075334.236334-1-liuhangbin@gmail.com>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 250a2717b4e9..3c04bdba17d4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -646,10 +646,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return err;
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
+		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	rhel_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


