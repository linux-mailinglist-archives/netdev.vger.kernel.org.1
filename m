Return-Path: <netdev+bounces-21056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7F76241C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD52819E4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2026B73;
	Tue, 25 Jul 2023 21:07:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1625936
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:07:42 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82591736
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:57:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so89136551fa.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690318639; x=1690923439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXkXZVLYtvpmMK+N6m7lUYctgnQ+ZBph0K+CANbOOz0=;
        b=hSCX5EM9dinUO3WkWP7I0k1PfipLkOgtZdOvM87v8MFPaxkvNAb+B+8gn5DO4jvKRJ
         ODRuasphOFkJh3jnCUKQWJXhbWXS01Rm7+psWuaxhlx1yhxan8eWCbk99GFu2hLaC+Gp
         /ZaJeRc8/8J3FLzolhC3fsvMNEbToGm1gJOXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318639; x=1690923439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXkXZVLYtvpmMK+N6m7lUYctgnQ+ZBph0K+CANbOOz0=;
        b=HTrlZQNWxhbNSyKZnODY32HUeYU2iwf8W6BUNrPI6V70p0+CUYjeWMPx5w26RXuhkf
         tFRh2O1JYr7P9kaAvY7IDmYAhsFHTFTpy24UeDfrxQ9egUZFEKMRKaM+sVBcv06hUa0D
         SiMnUVshc6Bo8HHyAgLurOQee8+9wVbfu5uotv1YD9UwocQ8h8eqgjvgZAKVZcz7qgDd
         oaUMeDl96OZ/MVbSYDQL5joE+WIDUFdW2Gj0VSN2pvK1Y8o/1/UcDIKE6kvZQjJObd62
         C3VSaXce/8DKSwAoryINij4t4m5/M/s4yb0fS9ChqGOVPQcpW1FrSqGRK2uQrlMbog0h
         uZbQ==
X-Gm-Message-State: ABy/qLb+FjiwQds7kmgB5881Q4bnOM0BaaKQ+0YAUmZgpyZtGGMrh4la
	8p1OWXK7+RCx2iKJeCLCfu90xTyWRYuWL5LcETTBX8HrI4AZkpCs61XyV0bL2jZpTadntEz7Q7e
	PiKtfyJqQeRWbHuat6aO8Q9kBFUXYhZ0kmvVzb0sYPn8pdMKmME78XqsSG8qu7cJ3S5PM8BoVN3
	1H
X-Google-Smtp-Source: APBJJlE3Ft6buDSZqyIJN5yJdaEdHrqE2co25eo255yV7fRf7kv2L3jsIhlAtyVXuAl5eGeZkOXJtQ==
X-Received: by 2002:a2e:9047:0:b0:2b5:974f:385 with SMTP id n7-20020a2e9047000000b002b5974f0385mr9880351ljg.9.1690318638798;
        Tue, 25 Jul 2023 13:57:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709062dd300b0097073f1ed84sm8704186eji.4.2023.07.25.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:57:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	ecree@solarflare.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	leon@kernel.org,
	pabeni@redhat.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: [net-next v2 1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
Date: Tue, 25 Jul 2023 20:56:54 +0000
Message-Id: <20230725205655.310165-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725205655.310165-1-jdamato@fastly.com>
References: <20230725205655.310165-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ETHTOOL_GRXFH correctly copies in the full struct ethtool_rxnfc when
FLOW_RSS is set; ETHTOOL_SRXFH needs a similar code path to handle the
FLOW_RSS case so that ethtool can set the flow hash for custom RSS
contexts (if supported by the driver).

The copy code from ETHTOOL_GRXFH has been pulled out in to a helper so
that it can be called in both ETHTOOL_{G,S}RXFH code paths.

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/ethtool/ioctl.c | 75 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4a51e0ec295c..7d40e7913e76 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -907,6 +907,38 @@ static int ethtool_rxnfc_copy_to_compat(void __user *useraddr,
 	return 0;
 }
 
+static int ethtool_rxnfc_copy_struct(u32 cmd, struct ethtool_rxnfc *info,
+				     size_t *info_size, void __user *useraddr)
+{
+	/* struct ethtool_rxnfc was originally defined for
+	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
+	 * members.  User-space might still be using that
+	 * definition.
+	 */
+	if (cmd == ETHTOOL_GRXFH || cmd == ETHTOOL_SRXFH)
+		*info_size = (offsetof(struct ethtool_rxnfc, data) +
+			      sizeof(info->data));
+
+	if (ethtool_rxnfc_copy_from_user(info, useraddr, *info_size))
+		return -EFAULT;
+
+	if ((cmd == ETHTOOL_GRXFH || cmd == ETHTOOL_SRXFH) && info->flow_type & FLOW_RSS) {
+		*info_size = sizeof(*info);
+		if (ethtool_rxnfc_copy_from_user(info, useraddr, *info_size))
+			return -EFAULT;
+		/* Since malicious users may modify the original data,
+		 * we need to check whether FLOW_RSS is still requested.
+		 */
+		if (!(info->flow_type & FLOW_RSS))
+			return -EINVAL;
+	}
+
+	if (info->cmd != cmd)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 				      const struct ethtool_rxnfc *rxnfc,
 				      size_t size, const u32 *rule_buf)
@@ -944,16 +976,9 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (!dev->ethtool_ops->set_rxnfc)
 		return -EOPNOTSUPP;
 
-	/* struct ethtool_rxnfc was originally defined for
-	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
-	 * members.  User-space might still be using that
-	 * definition. */
-	if (cmd == ETHTOOL_SRXFH)
-		info_size = (offsetof(struct ethtool_rxnfc, data) +
-			     sizeof(info.data));
-
-	if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-		return -EFAULT;
+	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (rc)
+		return rc;
 
 	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
 	if (rc)
@@ -978,33 +1003,9 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
-	/* struct ethtool_rxnfc was originally defined for
-	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
-	 * members.  User-space might still be using that
-	 * definition. */
-	if (cmd == ETHTOOL_GRXFH)
-		info_size = (offsetof(struct ethtool_rxnfc, data) +
-			     sizeof(info.data));
-
-	if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-		return -EFAULT;
-
-	/* If FLOW_RSS was requested then user-space must be using the
-	 * new definition, as FLOW_RSS is newer.
-	 */
-	if (cmd == ETHTOOL_GRXFH && info.flow_type & FLOW_RSS) {
-		info_size = sizeof(info);
-		if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-			return -EFAULT;
-		/* Since malicious users may modify the original data,
-		 * we need to check whether FLOW_RSS is still requested.
-		 */
-		if (!(info.flow_type & FLOW_RSS))
-			return -EINVAL;
-	}
-
-	if (info.cmd != cmd)
-		return -EINVAL;
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
 
 	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
 		if (info.rule_cnt > 0) {
-- 
2.25.1


