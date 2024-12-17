Return-Path: <netdev+bounces-152682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FE9F561D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E631E188B572
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB91F8ADD;
	Tue, 17 Dec 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="faOryjcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235F1F8AC5
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460026; cv=none; b=Bu83VRhq53y/T7gHhyUvt8VjnDEdlfULCdjJdZG4tV6O8CM2F+m9BKX1h2feZrcPLJ2E5hzB/YbAYwt2L2SCrNooAxVByS7sJtUExZLow4EC3ORj/cH1bLcf1fw9b9hRyM2LZSxe6Z18fgPzNQfmBsUrRgH9EhC5w8wZz8dK7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460026; c=relaxed/simple;
	bh=ZweGCXd1EW/GWmNtMTzljVNuUYIEcIpE8pHAdMMLNNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjpgkUEFYcIvrRUVYV3Ro+XqMU0IBv/hzBVc4mt8TMY3I2+IC4WI9fsXb74FgiojFIxaOolvhEBUTqzul3RnwLj8EB4ttcEIr66SeFGgUkQk0D8ypLqtPMfDyhJf6yn3PAZg9i321v/6qHvi639dWqU13ZU5l/iXuw9+J4Ar+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=faOryjcK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so68820895ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460024; x=1735064824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs8h2SRGuE94I7/xtRIDkh4BWKrr3OhS0L8bXxaxNvk=;
        b=faOryjcKUgL5+1sR+orYQDLucRZOZDu56X1kEzCGSLYbTgkh7H/QgOODBrSzu0Hnz0
         TJ0TVEV2UH7/d5Km1SzgZQ+Q8hX1P7XspUcPDOik9Cjn2Gnl9z1LN6COri2DOs2c6EtU
         +NI90FxXq/fqoKTe0A/By9zmKVoeQd7D/y+Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460024; x=1735064824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs8h2SRGuE94I7/xtRIDkh4BWKrr3OhS0L8bXxaxNvk=;
        b=Y67UkwZnTPtxMW3GNyHh+v22a14rP+E8Xbs47O5zCY83RJa111+GVdDr3r5WtGC+dr
         LiDRWHj5bueElTXk/V0B+1AKVOJFLHpU1/6IeQfTLCSOQWZ+hwsX25QtgKNn/N8GJXsO
         Sgeuz6hX6muRpniGgNaEUMaCOL02V0pLaSf8F327s9+LmxK0aZQINe736KYkB/aHgf77
         ysbwzfzgRUNEsg6DKD1MnJP396hZmRCi4vHVRifUJviJeVc/o0QlFEerlYN8icnfoyE+
         yGb3DqQUe8AC3u24ZWoLe/IRC/aFw8mhplOeQhWv0yPVrFl1S88V6zJ9BXAQj9tcj3qO
         PsaA==
X-Gm-Message-State: AOJu0Yw8kXiOHHubaV19xFBdePLiq+FmShzmXbJl+Vo5gXyx061P3opv
	1B+DfxeKP1JwDAQaPtAh6cJt4vhR6XpUXNvgIWZFrk7ABJKafIPseLOmDMcU0w==
X-Gm-Gg: ASbGnctKKRZ0PJnO4qHAmAz8bWSwNDCMguPxou9Hnkp0ZLnkrMfrKtw40NGjXzrgtpX
	fvrRRvf1Xtt3RIZUabjBIbL4xkJ+Fe+eDut1/XZirWKyMUWz7fVj5if30XvQCo6CZONTuSGO3Ye
	bOCUS/of5kR5dCAvwwu4jnH8mtb2hh1QO7v6WtMTMEzTWlLh4JrnezP3kJtLuRUlOSd33ssudIi
	JXbKF1l5ElcYEn75+IE/tpy9Vt1wAHdhrhVxLkANPlJJTr/CwrGTxRwrEAh3gmuprw1AfjPoZPk
	/tj3RxB1DLqD1OApHS5niMPblQCfr+EK
X-Google-Smtp-Source: AGHT+IHuk7tQnXeI4AfH0FCV530BwwXzNYSR97SnritcqEB7Ur7Pr13WIZYPmSXu1a0igmZnZnpFYg==
X-Received: by 2002:a17:902:e5c2:b0:216:2d42:2e05 with SMTP id d9443c01a7336-218929c34a2mr274988145ad.22.1734460023931;
        Tue, 17 Dec 2024 10:27:03 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:03 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next v2 2/6] bnxt_en: Do not allow ethtool -m on an untrusted VF
Date: Tue, 17 Dec 2024 10:26:16 -0800
Message-ID: <20241217182620.2454075-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
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
v2: Use extack for bnxt_get_module_eeprom_by_page()
    Fix uninitialized variable
Cc: Ido Schimmel <idosch@idosch.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  6 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 469352ac1f7e..c0728d5ff8bc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8279,16 +8279,20 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 	if (rc)
 		goto func_qcfg_exit;
 
+	flags = le16_to_cpu(resp->flags);
 #ifdef CONFIG_BNXT_SRIOV
 	if (BNXT_VF(bp)) {
 		struct bnxt_vf_info *vf = &bp->vf;
 
 		vf->vlan = le16_to_cpu(resp->vlan) & VLAN_VID_MASK;
+		if (flags & FUNC_QCFG_RESP_FLAGS_TRUSTED_VF)
+			vf->flags |= BNXT_VF_TRUST;
+		else
+			vf->flags &= ~BNXT_VF_TRUST;
 	} else {
 		bp->pf.registered_vfs = le16_to_cpu(resp->registered_vfs);
 	}
 #endif
-	flags = le16_to_cpu(resp->flags);
 	if (flags & (FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED |
 		     FUNC_QCFG_RESP_FLAGS_FW_LLDP_AGENT_ENABLED)) {
 		bp->fw_cap |= BNXT_FW_CAP_LLDP_AGENT;
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
index d87681d71106..28f2c471652c 100644
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
@@ -4480,6 +4486,12 @@ static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int rc;
 
+	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Module read not permitted on untrusted VF");
+		return -EPERM;
+	}
+
 	rc = bnxt_get_module_status(bp, extack);
 	if (rc)
 		return rc;
-- 
2.30.1


