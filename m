Return-Path: <netdev+bounces-173625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7055A5A31B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24ADA3AFB96
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18423BCFC;
	Mon, 10 Mar 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQtXK5Hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913323BD05
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631643; cv=none; b=YZzq5QUG17pQMauTkweaXt4YmjcmSU1fOpiIe2YqUjEa7gCpSe61xSgB4+A3k4filkFyOwZkduMlm/zgmx6/RUvS7O4X36+CCQ4VroVbJyQlmhNE5YU0zBnzNugsBm2m5kX/q/2nGQ6p8WupSHqTn9WcI36ttIwlS8zMPEmMv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631643; c=relaxed/simple;
	bh=A3h8VYx0d/F+VLCppQZP/8i8AVfkHr3Fb9BJPJ4tgQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfbdrQz5GPPVsaOXaT85UTg/RUD25Ug5pvpZ41WarSvU3KlL9rfpvNaS3YA9d8wIcaMLRGjlAiUfzygkeF95rnPrb4kPIdk12C0HfYzWRmd9EPGNFXIaOHLXf7qkat/nWwUMuB/L00JVfOSUkRMMSzN4uOFxhsaaFsmXbqtD1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQtXK5Hd; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f6b65c89c4so1709713eaf.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631641; x=1742236441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftmC6JdK+jUUqh+xRDOpYb+MLAyNI1G8N8x1Wd+2C3A=;
        b=WQtXK5HdagjzATSTvwRV5mMZmN8pMu2CxoJX5BxKx6AiP1KbXX+VUAUfpCqDBADoph
         p3WmZFJISua1ybZiUNAdZTx/GcP3rSmy1qBH9geerG63mhfqlyWR5ZaLGmONgJhGP8aX
         oFPkdvYm3aHcCUJhlStNBaJtmx6+el6z6gKdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631641; x=1742236441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftmC6JdK+jUUqh+xRDOpYb+MLAyNI1G8N8x1Wd+2C3A=;
        b=IZJNNwFHulrbHJ/ckHh1MLwVokf6EcmdMFanb2byWzFgVTyTRDMJfxFCLTPW6wXleI
         qz/Ack5lBf6LB1zfh3CInO/KlCaCl53uVIbBIH/P+8OKClpIztUZiQ/I6PGYGiLohrgK
         z8lTjiJSZUnDAphjkSTlK94SoPTiSIW9gFKm7R+ZMmpHje8iyc9yBv5gy+70GjnP/WKv
         wHJ0kUv68fWHBcNtRyjdRMYKmeEWjgMYtHqyKmpi0cjjj7oTkwMhcC8hDBjkO5UHilWW
         owZcMj2FZWo3XFQFuL+KYMXxODo7bvm94BHDEKDJgoQ5EmKTJRXFSXbBT/QSdg3incDm
         /FOQ==
X-Gm-Message-State: AOJu0YzXumcsKrtIc5true2c0S5mZ+lj30IYFNX9I5ctfOBg/rm9hBYc
	i4pYFPEHQTPIDkPz8hGuEGA9GvmOsqbEPXTOqo3t+VG6QfhV7oPiCb3waHm6UQ==
X-Gm-Gg: ASbGncvVL+Evv8xv1KtphyFlOkgEetTX2hdiTah8TKwOt9QlPp61mBvuD8M2RdVVisV
	RNISVcEKizhYCzTOqp/1QffBpV2eWDgsglYuywGMVW1m8/llBnEvwp6ru/mTE3+HQN6nyx7WSpf
	nJ9/R2z/4loX8IqmWiG11fP6fqDFjxBdcjuxYNty+lxrfPNR3WnTohyx01cdjTeNb3Bf3It/sQD
	FuqWj+QFQVBhcgSY+6UpIviD/RMe5HsoltVE1G/FDcoi1TY6eNB2qoZHNFfJWyc11UOxdQ/uBIh
	ybhHnm/Blkh8sB5258/i+DdRb9E4Q07NkYxPF1vI9skmeZFf7p9k+mEi4PZxbEfEqT8iWQ19i9z
	B0m5VXfzxbyVsNV1fdION
X-Google-Smtp-Source: AGHT+IHMGRQ/NhjuwuP0pMQPYPKmJEjaaKg/yfeONSU5IFQeIz4G49UETE3DtmkpEfK3ifZSdw6utw==
X-Received: by 2002:a05:6808:2006:b0:3f4:12a8:b4f6 with SMTP id 5614622812f47-3f697b5761amr8693167b6e.10.1741631641004;
        Mon, 10 Mar 2025 11:34:01 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:34:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 6/7] bnxt_en: Refactor bnxt_get_module_eeprom_by_page()
Date: Mon, 10 Mar 2025 11:31:28 -0700
Message-ID: <20250310183129.3154117-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding .set_module_eeprom_by_page(), extract the
common error checking done in bnxt_get_module_eeprom_by_page() into
a new common function that can be re-used for
.set_module_eeprom_by_page().

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index e031340bdce2..c0de8f0e722d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4541,11 +4541,11 @@ static int bnxt_get_module_status(struct bnxt *bp, struct netlink_ext_ack *extac
 	return -EINVAL;
 }
 
-static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
-					  const struct ethtool_module_eeprom *page_data,
-					  struct netlink_ext_ack *extack)
+static int
+bnxt_mod_eeprom_by_page_precheck(struct bnxt *bp,
+				 const struct ethtool_module_eeprom *page_data,
+				 struct netlink_ext_ack *extack)
 {
-	struct bnxt *bp = netdev_priv(dev);
 	int rc;
 
 	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
@@ -4567,6 +4567,19 @@ static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Firmware not capable for bank selection");
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
+					  const struct ethtool_module_eeprom *page_data,
+					  struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	int rc;
+
+	rc = bnxt_mod_eeprom_by_page_precheck(bp, page_data, extack);
+	if (rc)
+		return rc;
 
 	rc = bnxt_read_sfp_module_eeprom_info(bp, page_data->i2c_address << 1,
 					      page_data->page, page_data->bank,
-- 
2.30.1


