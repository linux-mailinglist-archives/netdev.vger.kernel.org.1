Return-Path: <netdev+bounces-152015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E299F2624
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A097C1652E5
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024211C3BE3;
	Sun, 15 Dec 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CG+CJ7Jm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE901C1F19
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296429; cv=none; b=Svq1FUxFEURHIcuUfHJH7DwGlUQWICpMDemd8Xjs4Ps6nJBFWqsNpdxRQ1bOxcJte0HCWi8Ro8Gz6nwNcuocqZzhgsTK0BGZnTCmv5Z+K/we97fN63IoSajpAEYKyUvPE0QyxcT7PqGaL4VTDd5YbfrWLSIptLDlrx/Z+/INIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296429; c=relaxed/simple;
	bh=TsE49MQKH9LMpkIh5fd0uIcRUvFTdo0jt4FZ4sXWCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/96PSnWgg9uDfzXgnAZzSurjEuNEbm9XOk3lvvBV7pwXS/PyCAGiT2upCfvgyWci/nghFAjMYgeRnCEPdjJeBgY7R5L/JSwEDHOpeaZzOEbIUwLNJv4bxT8hSFSl5tgyUDBusySRIKM6bIwonJQQ3gJko3PAoi60AOKcTrsShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CG+CJ7Jm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso2320118a91.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296428; x=1734901228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Wgsu8bH9hhUwPwCdrKUfUHQQvkPWquuVqolAt8+uI=;
        b=CG+CJ7JmcY2SXqodaKzMCEthhxfOww+PROkLclC9MGpxFB4UI0oegUwD3iGegOnM9M
         6+xxZKk1M/x2w3p6q5kcJNVUDreOZIgXKnPq9VxcIRpeLbXO4HhsdadZ2GID0Fh/0Dnr
         QELbZ9GVlp8+ruxdfI0oitY9rtEJfKk7zUVlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296428; x=1734901228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Wgsu8bH9hhUwPwCdrKUfUHQQvkPWquuVqolAt8+uI=;
        b=U2/iXi9Wmr0fgom9JlQANsHX9Db/dFkyRPiRhOxyD5ABlGIdvN6eGC79PDpKK2lgBK
         mLkZtFUf1qHIw5ylqyttoJGXa+d1OVpq8rOt6rWNJMAlBxaH9Nn/60lZ662CDCwNBL4Q
         yf1E+AO4Wf8684x0z64tcP+8dRFhY0MBmDz2nubu9C5zomPDFTWVTtpoRbiopV/ut/cf
         yvbdMWe+IyRtQLw5go6ezVzXYnSjTibzfVKYCXvldcXXJSqFJw65HQRBjodA/jdlWFRh
         /x9eTnwGlCC4iFc3ggE17j2mm1ax5Lcn7DLe9Sf6i1k0mYZeOna1bsupjlRyMxf+jL6X
         /oaQ==
X-Gm-Message-State: AOJu0YzMlwK2ZdZUrSjxCn18ZjeBwtGVi2CTt9MoaRLBt9wt08ck9JWR
	MGOXDttJKaE9VOCkOMq0Xb2BOyPeRAuFimGxwzGqPAZmYiIHzEcVae4ANwxdHQ==
X-Gm-Gg: ASbGncv4QYDgYSVD7vj0UiEeCeZYTnzvRp2IYl27aUPCOj7WMO6d8MSOMWKH9Ik7AwS
	LNj58gFl8HqT1+5p+1Nnn3k1VmICXyu9TjvrZq9vosYQlAPdzGE9828+uvP09OArG1PANByiPyM
	fc2XeTBdRNoikZDJgHWQlosOySa5fqq4mXUNatlqLlvs7Szvmd0KMv2Cc6TqEMjZuiibMxRGSpJ
	qYjiEK46RvJjp5Oy8Chlulg0OY3AnJi3Th5KaCGnqx7/1bUUwT/fkyHJyy/63HT0RqOSbpnUcM0
	CH6ZkzgniUDLjhVOugz/XGSpFIhFj3lL
X-Google-Smtp-Source: AGHT+IEqpUfpK5mHK94OA8+2lJyrZ4kK572YZa3GYlTeMhb/feF6+fgk3KoK7J82AVzQETyaMa3G2g==
X-Received: by 2002:a17:90b:3512:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f290dbcbddmr13119522a91.31.1734296426557;
        Sun, 15 Dec 2024 13:00:26 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:26 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 2/6] bnxt_en: Do not allow ethtool -m on an untrusted VF
Date: Sun, 15 Dec 2024 12:59:39 -0800
Message-ID: <20241215205943.2341612-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241215205943.2341612-1-michael.chan@broadcom.com>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block all ethtool module operations on an untrusted VF.  The firmware
won't allow it and will return error.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 469352ac1f7e..631dbda725ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8284,6 +8284,10 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 		struct bnxt_vf_info *vf = &bp->vf;
 
 		vf->vlan = le16_to_cpu(resp->vlan) & VLAN_VID_MASK;
+		if (flags & FUNC_QCFG_RESP_FLAGS_TRUSTED_VF)
+			vf->flags |= BNXT_VF_TRUST;
+		else
+			vf->flags &= ~BNXT_VF_TRUST;
 	} else {
 		bp->pf.registered_vfs = le16_to_cpu(resp->registered_vfs);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3e20d200da62..d5e81e008ab5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2270,6 +2270,11 @@ struct bnxt {
 
 #define BNXT_PF(bp)		(!((bp)->flags & BNXT_FLAG_VF))
 #define BNXT_VF(bp)		((bp)->flags & BNXT_FLAG_VF)
+#ifdef CONFIG_BNXT_SRIOV
+#define	BNXT_VF_IS_TRUSTED(bp)	((bp)->vf.flags & BNXT_VF_TRUST)
+#else
+#define	BNXT_VF_IS_TRUSTED(bp)	0
+#endif
 #define BNXT_NPAR(bp)		((bp)->port_partition_type)
 #define BNXT_MH(bp)		((bp)->flags & BNXT_FLAG_MULTI_HOST)
 #define BNXT_SINGLE_PF(bp)	(BNXT_PF(bp) && !BNXT_NPAR(bp) && !BNXT_MH(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index d87681d71106..8de488f7cb6b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4375,6 +4375,9 @@ static int bnxt_get_module_info(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int rc;
 
+	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
+		return -EPERM;
+
 	/* No point in going further if phy status indicates
 	 * module is not inserted or if it is powered down or
 	 * if it is of type 10GBase-T
@@ -4426,6 +4429,9 @@ static int bnxt_get_module_eeprom(struct net_device *dev,
 	u16  start = eeprom->offset, length = eeprom->len;
 	int rc = 0;
 
+	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
+		return -EPERM;
+
 	memset(data, 0, eeprom->len);
 
 	/* Read A0 portion of the EEPROM */
@@ -4480,6 +4486,9 @@ static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int rc;
 
+	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
+		return -EPERM;
+
 	rc = bnxt_get_module_status(bp, extack);
 	if (rc)
 		return rc;
-- 
2.30.1


