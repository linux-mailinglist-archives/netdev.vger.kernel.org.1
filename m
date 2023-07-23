Return-Path: <netdev+bounces-20183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93175E2CE
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F64B1C209AA
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27311187A;
	Sun, 23 Jul 2023 15:07:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E91879
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 15:07:32 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1AFB
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 08:07:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991f956fb5aso524631366b.0
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690124849; x=1690729649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDolbZwxUR1dqTmWKJPBm9xAZkcLiWXKL3X8juy54I0=;
        b=G6bs2fRMfT6ujw8OncRCMOdr7CkPpsTMMUo/s1LpqPgEyiaht3HCUR5FOc5ss+cfSH
         SzWlRWgtuzH0saw/tqot72woRLLXpM7YXLDAcTo7QwZk29dS8WJUE71Oj5TsGig5vPI+
         jVwRwk2vupVgX7iDng1XkDd8VTTJ30gM/ZdnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124849; x=1690729649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDolbZwxUR1dqTmWKJPBm9xAZkcLiWXKL3X8juy54I0=;
        b=f6ivMXlsk309xndkJN2D30E+P99jyHdY47pyTDiuVOfD9et89V777Up1SHKUWqynak
         X/pLQuI6lTFEfVZbxvaseeJcEO0l+LqkMiaqa+Ug/qI2sjS/O6M4aeMUiAtHFD9/0yPA
         15FwlcJZl9wEcL4MhA0jHae14B2WICznne+LN41JLhKuEAcGvOSifg1CkcnfOP+C/W++
         D5bc3ykPoVcWa8K+QR1+hWFG7RTBfDCniUD4yLSHcoaud42eCaESXOrOxFAZCZCmFfK2
         yzWtf5BNBbsG29ItapGGiz+i316ZtdHk0hCaczKzWuGyFvThdI1MWcdPCdeNIHlqQTNe
         Q+eg==
X-Gm-Message-State: ABy/qLbwZHm7rRfXXH0RCA/t0O+oPe0ZsfLYlkHHu826OuytkYKJFfBl
	i1EoFX44Ks5hrWS9lCZikX+nbTwG1iAdId5ExPvMCPY6L1kpXBDYyyHtt9D68qUS7932Zz8Rt0M
	NiRADzX1lqTe734tvTcRbjK/d1ArHx7WEBLKj8Sw1jhc5G6WtbzDpk7DojZumZefFCKqr4rbD5w
	vv
X-Google-Smtp-Source: APBJJlH4j2EBHuP2dwPwVY7QUDlOn2Aqu+8+9EXAcQe+eR8i5HPWOTYC3BzksTCU+N9cZ3h0t3dGpQ==
X-Received: by 2002:a17:906:768f:b0:993:d8a2:385 with SMTP id o15-20020a170906768f00b00993d8a20385mr7300555ejm.22.1690124848600;
        Sun, 23 Jul 2023 08:07:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm5227691eju.209.2023.07.23.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:07:28 -0700 (PDT)
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
	bhutchings@solarflare.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net 1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
Date: Sun, 23 Jul 2023 15:06:57 +0000
Message-Id: <20230723150658.241597-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723150658.241597-1-jdamato@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ETHTOOL_GRXFH correctly copies in the full struct ethtool_rxnfc when
FLOW_RSS is set; ETHTOOL_SRXFH needs a similar code path to handle the
FLOW_RSS case so that ethtool can set the flow hash for custom RSS
contexts (if supported by the driver).

The copy code from ETHTOOL_GRXFH has been pulled out in to a helper so
that it can be called in both ETHTOOL_{G,S}RXFH code paths.

Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
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


