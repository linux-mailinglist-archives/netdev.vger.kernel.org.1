Return-Path: <netdev+bounces-124767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13396AD65
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ECB286ABA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E97F9;
	Wed,  4 Sep 2024 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkXSh5/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B8804
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410123; cv=none; b=Z20sItP5oSdxhTNzbIl9DEMNWjr114Dbm10ZC7tjviz9ufE9tZNgDRvJgXkHtllmYyrYbrJ2nzTmvye5ngu3h6LGowZlCTNDj+ZtEjAhZob0NJtbetFG32LOuf1LxI/TVZYKW1b5U2M6dYlshbR3NoSteQtdusX6aCanQcbU1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410123; c=relaxed/simple;
	bh=i/d40otUL9KwuiJ93P+2ZTlijq0lv1Unw/Tv+U8sYtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsWipeEIESesZYxUmAz8lxnH9shMA/Yg45D8sc2oEkQrqGG6icCF+Ml82nLW0grgtpddS4YrNozxQmv7UPACach5QFxTyvyrLlMzD3OZSgtyHnLKl9zMm41d3yxg7wSyLtDmpUoQvgw6yo4dcJtYDiIbfTS2lC1oQA/j1z9aT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkXSh5/n; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e172cc6d66so1435161eaf.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410120; x=1726014920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXpwzSuczk2LKlfBSBX+16h6YaFfQEhasngzGrGdCag=;
        b=DkXSh5/n81a5V9SOg0COwm2UR3DVt3ilA9Sl9flzNs0FGzrAPakCNL/LIf65+RKGnR
         RQa2FOZXpM5w4DJBN1Qu08tN/Va0qCDm2QgoJBR+hF5LcLvBq6SZVzakDAPhwkNKKzOd
         uFEfEDTCoEnmctdlmUZjLygg9wSjOfkfHEz65JmfA0WR4xoHSfDHsLVF/XaaAjv1cI0X
         kEWRjpVbV3GBvbsyV4kw9mdWv8xRXTgpY4BQPscP0PbSO0i00jp7SZ45dcCr4Yg9RoYW
         YzSKJ1T4GHQAeJWpKTV+nFybsPFQBPcEvSDakYw7gqYI1srxXv2zapvq+yT+te/Tk6ll
         uN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410120; x=1726014920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXpwzSuczk2LKlfBSBX+16h6YaFfQEhasngzGrGdCag=;
        b=PT9gdjzjrcmaG+Gr+Vidk2qi9Zr3xyppiMFa5dHRRayHbYba50Lj1cmbtKi3gDWHv2
         JO+dHwyU+IsEAYxFdu7F34GhEoQw2SpqJivzMNpMP5bqUmv6CkC2Ghgx4//DfTnC0jsM
         off4lEHHYuZGHmD+tzXHOIkMvIvZTIycr/RTkvdUZOsNYohEvxfnnjw7L8+4VjFASpkM
         axlllwCBLXfJ4JEa04+mE//lHysA/sYIqp/+gstKdaRu0l2FKdrC7Q4pMMHIAyDPBIWJ
         ZhZxj83y2YnZZZMcb5VzlCHpsTt/iGF/7siMIl0cWhZ/T5D9Sv/x4NSHJ7Ez1KVxzX23
         Qn5Q==
X-Gm-Message-State: AOJu0YxUHLO3/dPxVNIsK7I8O1oXkBjrn5kKEttMSpTWFJWSnOKP63nz
	54oItz0UQd6KdDqXQetA/NDu06yf4puIRlWwUQ/wGyFZkJEC4f95btmlUQTYQeG4HQ==
X-Google-Smtp-Source: AGHT+IHj2uEKKPbJ00Pvx+7wLRAtKRIM1omnqzkkhvqh5Y7Ph+MXI4EBmuZAw/hBSGcICdWeUu85LA==
X-Received: by 2002:a05:6871:3a09:b0:25e:1edb:5bcf with SMTP id 586e51a60fabf-2781a75e938mr4889775fac.6.1725410120248;
        Tue, 03 Sep 2024 17:35:20 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778589133sm444218b3a.109.2024.09.03.17.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:35:20 -0700 (PDT)
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
Subject: [PATCHv7 net-next 3/3] bonding: support xfrm state update
Date: Wed,  4 Sep 2024 08:34:57 +0800
Message-ID: <20240904003457.3847086-4-liuhangbin@gmail.com>
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

The patch add xfrm statistics update for bonding IPsec offload.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a6628b1f33a7..47ab4ccd6fc1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -718,12 +718,37 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
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
 	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
+	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


