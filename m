Return-Path: <netdev+bounces-173626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C035A5A31D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D223A1965
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127A236457;
	Mon, 10 Mar 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fsm2g6dB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D823BD13
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631645; cv=none; b=k8iPVxmhhL+lZPf+wPh5tsTDYQznqvWcsvcDiTLx4Og3ndhH/Hrwft15cGUkaM+d98DB5RNx4pzT3j+wmzMb8zRHTs+Jld/6BQmTO4/Tk4eOw8SysbqL8pOneMcyCyrVEw/DPOahwH713dWuAtaVbZixz4VUNxOH45+fQNrsceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631645; c=relaxed/simple;
	bh=ApLxMBlDKa2oB40fZ930jjwtrde0r6F/yeLzPf41NSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc/CDJwwimUuRV7bGthRSkmoZIUv9gu13pUGQZAr42hE1ySuFCUKYd9JD1jY8jFd+dO7d+PKbrn3hhHRPlOrKtbYuslTn6Ugi/TqwDUixDQD+6PHT8vcyfmpBwmDi6XKRgabOite4rRWLQ5Ae+XuoO6kC/0UDQ6b7oQngyxqBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fsm2g6dB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f8ae3ed8adso660721b6e.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631643; x=1742236443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBfLs/7nowYRESP3/EIAM0PKgelT57wMHlVJgIo+q8s=;
        b=Fsm2g6dBRcPCO/FrDvQU2X2etbeoZNOKSApbVehyxQKqdL1GY3GW1eciMqhxkvSG1a
         RRYzWF6aOqwhIKGs2kXSwSOyeXU6Y0ynGuIOcvMb3Jg1mi1ShcNGH1QebZdtPNuIkPLn
         4Ehi2AGXYKMkTegnJhDm4yT8KlpxcGDrMS8Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631643; x=1742236443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBfLs/7nowYRESP3/EIAM0PKgelT57wMHlVJgIo+q8s=;
        b=fIyyw3MrrnacwkSKQQpCAVdHjU5a/7cCT6OV5mxJHBnlB9r5QAi+GPS4cOb+tObc+b
         gr0Uv7O4bO+P1Wb+Qr4KBmPYnDrywqzsX4IA449tt890EaqDnNCg6ZCf9s760XlvuWmD
         jCe2sYwrTdZfEGYfrqaHk7sxV+8L7VrFGgcH0ZZkde1p3VXTS4OBuP+7rdYM3earN1Jj
         w/n1PJkrKm40Mi84FQtVDao9KkhoFVPf2ebZHlFfxImk6raX062Xf6TWkPKzSpdO3bhi
         7OerkIedCXoh///5eJo1f7laG2t270f6ZROs45KxjhjJwbndANjNvsy1d0rMMJJP8y5D
         xv1w==
X-Gm-Message-State: AOJu0YxcYLN5tQEp9ximMmosAjgeRKNSwDgsWgWxptQNEWcaJrU7zefj
	kEbLTZ2n2r004oT/ZTQWoqQM6awBqA2lkSVJ8gYjBVHuT/C521oakzzMSGQtdHW+NfBHDQECZFE
	=
X-Gm-Gg: ASbGncu0Sjwj6Y9nLQK1DeKiLClW/Wzy8fNevDrHy6TaldO/gDavDYPch0Q1JQ9kr1P
	hl0L0zhaJKpZs3ZD0ljVb79SUKVW9PVNF+9LJXcgCDtP+gqJEVTGyq0oOQVf3M+ZfsgEjNptc8N
	RkpadXCKNlPyO6B0AFfo4FaX9e9N3BfiUObjkq54HwqcJd0ORvhzpA6WLAXQ0zDYT9aV+2Vy2ga
	By87FFM4DIXqxTXqqdIpnIbFylEj+iZhaB8V2pmPd6ePrAHZqcmk4ZUJFu21i3NA2ezXdzpkWd4
	hEGQ06kEazTBNsjuVp8qve+2h/zMYtBXEcRKvjHY9E+SYyDXGVUgEenLFaBl0BiUrn4TAfBCOUh
	836JwDQ6jqpPytS8dnS56wgMEccTAlgw=
X-Google-Smtp-Source: AGHT+IHokc5Vwvze4JoGtJEVrALcke5t1HGi6dt1hHmCVRtDMlb+2614lkIpsYDpAh/IQrd7J76QUw==
X-Received: by 2002:a05:6808:199d:b0:3f7:8f77:2a9e with SMTP id 5614622812f47-3fa2b11c797mr354268b6e.20.1741631643189;
        Mon, 10 Mar 2025 11:34:03 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:34:01 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next 7/7] bnxt_en: add .set_module_eeprom_by_page() support
Date: Mon, 10 Mar 2025 11:31:29 -0700
Message-ID: <20250310183129.3154117-8-michael.chan@broadcom.com>
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

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

Add support for .set_module_eeprom_by_page() callback
which implements generic solution for modules eeprom access.
This implementation also supports CMIS 5.0.3 compliant
eeprom FW download.

Sample Usage:
ethtool --flash-module-firmware enp177s0np0 file dummy.bin

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index c0de8f0e722d..48dd5922e4dd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4550,7 +4550,7 @@ bnxt_mod_eeprom_by_page_precheck(struct bnxt *bp,
 
 	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Module read not permitted on untrusted VF");
+				   "Module read/write not permitted on untrusted VF");
 		return -EPERM;
 	}
 
@@ -4593,6 +4593,62 @@ static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
 	return page_data->length;
 }
 
+static int bnxt_write_sfp_module_eeprom_info(struct bnxt *bp,
+					     const struct ethtool_module_eeprom *page)
+{
+	struct hwrm_port_phy_i2c_write_input *req;
+	int bytes_written = 0;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_PORT_PHY_I2C_WRITE);
+	if (rc)
+		return rc;
+
+	hwrm_req_hold(bp, req);
+	req->i2c_slave_addr = page->i2c_address << 1;
+	req->page_number = cpu_to_le16(page->page);
+	req->bank_number = page->bank;
+	req->port_id = cpu_to_le16(bp->pf.port_id);
+	req->enables = cpu_to_le32(PORT_PHY_I2C_WRITE_REQ_ENABLES_PAGE_OFFSET |
+				   PORT_PHY_I2C_WRITE_REQ_ENABLES_BANK_NUMBER);
+
+	while (bytes_written < page->length) {
+		u16 xfer_size;
+
+		xfer_size = min_t(u16, page->length - bytes_written,
+				  BNXT_MAX_PHY_I2C_RESP_SIZE);
+		req->page_offset = cpu_to_le16(page->offset + bytes_written);
+		req->data_length = xfer_size;
+		memcpy(req->data, page->data + bytes_written, xfer_size);
+		rc = hwrm_req_send(bp, req);
+		if (rc)
+			break;
+		bytes_written += xfer_size;
+	}
+
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
+static int bnxt_set_module_eeprom_by_page(struct net_device *dev,
+					  const struct ethtool_module_eeprom *page_data,
+					  struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	int rc;
+
+	rc = bnxt_mod_eeprom_by_page_precheck(bp, page_data, extack);
+	if (rc)
+		return rc;
+
+	rc = bnxt_write_sfp_module_eeprom_info(bp, page_data);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Module`s eeprom write failed");
+		return rc;
+	}
+	return page_data->length;
+}
+
 static int bnxt_nway_reset(struct net_device *dev)
 {
 	int rc = 0;
@@ -5455,6 +5511,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_module_info	= bnxt_get_module_info,
 	.get_module_eeprom	= bnxt_get_module_eeprom,
 	.get_module_eeprom_by_page = bnxt_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page = bnxt_set_module_eeprom_by_page,
 	.nway_reset		= bnxt_nway_reset,
 	.set_phys_id		= bnxt_set_phys_id,
 	.self_test		= bnxt_self_test,
-- 
2.30.1


