Return-Path: <netdev+bounces-272250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJfuLbmexWlqAAUAu9opvQ
	(envelope-from <netdev+bounces-272250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:01:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640D33B9F4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65F463015A52
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D33A257E;
	Thu, 26 Mar 2026 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV5Z+9hy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E403A6EE5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558778; cv=none; b=cseS2L17m5hMY6RSRE2OETJVJ9AOaW+nPCo+tj2pkfR5ajXVVkkzYX/h0FKul0faQ3T2Rcm9OycU7xXLDSBvsNnArnidRJZYf+XiUbAtZxBH0tO1MEEdkxFqO1tIUkooUZ0+InoRli27jSloUMJNimYEmcmVPwXYw23AP8oMskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558778; c=relaxed/simple;
	bh=9CI3IyOmtBDo487mBoinvfXlrSwYYvLLukYprVQfHOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLL/aV2HDQCFOAm9TdIKsfodR35InsGyE68Qz03Hu9JwRt5wo2zQu0FBcpObFpOSB/ZkwP9HpRJt8INnqg4LiizdfnMcfQGqIZ59D+trZGCxjOYKfgS1qaHL6WD//mP77mqj0QkZg0odUX/pgcrdo7PXWR+k2Rj5N85+rQERlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV5Z+9hy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a283c44478so1612866e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558775; x=1775163575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbZS0juuOJoqAPsC+Ibd+2874q2p+fTbJaUXPGnWbZI=;
        b=KV5Z+9hyvKmMYAqXiLwaHcLLaiwo8seowrC5ZT4JqnfL0AvlsKtnykHQsL+5cbZWwV
         FUovELAN9siYbaNiGWVL0zMvS9NND6JXPCq558uSnsvn6JX2qsMB++sAo0vlWutLWnKj
         pr/Fn4AU5912KVelmE09KBPWhAzJk5vapE+AUhN8FxLLqdz9Ip+YvjDpDM3z81edcdNN
         q4hMH6U9jm6lKofFoibO9LhT5O2Ho7DRVQ18lYZabd81p/vt1UGO3KdWpMeSHXG4JB5/
         1QzzZ22QVO95dJIciuCtzJlUjbnGHi0lojnFlEfmeIji4ypLim+jjthHysGUDmN2Wlwv
         tmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558775; x=1775163575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbZS0juuOJoqAPsC+Ibd+2874q2p+fTbJaUXPGnWbZI=;
        b=BoDpMEGEwBw7HXunIJgaobwiMXaMuidpFpN05jYUYBgrrD29spMsDfnDGLQZ8ip+B3
         p3Gt64jwSyuUzui92uAW9umM3aTrTWmhytO6as754HYSkTxlBGqvQzVgoy5ubZ81ey5Q
         heTXsLMW/Q5+UPa5oBi/WDdm5syR7ZGNOMx5906KcRdZh7xMKruLT/YnRjV85D/AymMs
         yc0iw7Oab4Kbzzgcq6QIdKCGXs8492if/XFRxxaTjwYdBc8TB31w1d0PkDvo29+JfouS
         cI2JtGMNoSKpEv2dmxRyWiJEtxHvYI5uWxOPQj4jnFh0KFcCUNt1ixLfhbC/0y06Dj4G
         1chg==
X-Forwarded-Encrypted: i=1; AJvYcCV7TSfApEkMxFpkw7oSfPZfEUVhH/gNPNBPCcJvFI7YRxislQlWIr9VjwqGwwOAK4Kvc5VA2MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNIRhdb2C6HPGzqnY8D1IrwWGueXfB6ch4x62VBQUvLq4+EYv
	J3FC4rl3VrQpFto7X3zjnnvDOfhfD/3Ldgwhs3Ne6fCNJMie0+R3kKyO
X-Gm-Gg: ATEYQzxKvif5H7t/UfcVrzCICXts9U4z4ac3/Ywg0fCIH3oLkvX6O6ukgnpuAvVydEx
	I0CpfI6JanyIPYlB9nkvq3eNoqkCU5BGKmhpdnk+G3MTxRcvw7CEhEkIb1Vb3MDhjuhePKX48gb
	w3UK+9Yxoeud8K1oB/3vJ0Vm7fB9ekVjRswR1oG2PVn92S6DAgrvyz177tcxDDCz2DT0vamyVnY
	dQHXHkZQKg1SSH3sPO8swD4t1IBko7dDFUz5UlIreT6mKr2vtJ3m1e4v/JGNIPObTBEx0zGIWMq
	7XxcGNHsjMTRtdnUfPYtfJDxOWiNt0HJgxguw+48NbOt6DuyZtDBcsd9Tytu1g037D68XLh6FIP
	mif9fpx5PSjupLB8qHbVHoapo9xXoHyGGwrmFpxoP3eaB6ecLCX8UNW73JTljqaWKzZmtXbhSst
	uu4hc8PJTh2YybOm/ygY3cRelYR9WLv3f/HLC17tKLZcaHrDZHm0oqMsoOEHdIklNKA3hkapmMh
	HpMgskbLw6dqm4=
X-Received: by 2002:a05:6512:614:20b0:5a2:777e:3fd0 with SMTP id 2adb3069b0e04-5a2ab91ce28mr1552e87.25.1774558774757;
        Thu, 26 Mar 2026 13:59:34 -0700 (PDT)
Received: from localhost.localdomain (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f5f1sm842596e87.55.2026.03.26.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:59:34 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: saeedm@nvidia.com
Cc: tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH net 1/3] net/mlx5e: Add null check for flow namespace in mlx5e_tc_nic_create_miss_table
Date: Thu, 26 Mar 2026 21:58:22 +0100
Message-ID: <20260326205824.11749-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-272250-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6640D33B9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_get_flow_namespace() can return NULL if the namespace is not
available. Add a null check to prevent potential null pointer
dereference when accessing ns->node.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 1434b65d4746..503c9cc96a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
 	ft_attr.level = MLX5E_TC_MISS_LEVEL;
 	ft_attr.prio = 0;
 	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!ns) {
+		netdev_err(priv->netdev, "failed to get flow namespace\n");
+		return -EOPNOTSUPP;
+	}
 
 	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(*ft)) {
-- 
2.43.0


