Return-Path: <netdev+bounces-178879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C8A79524
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FC81890B68
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512F1DC198;
	Wed,  2 Apr 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EBHURQ2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAE2E3374
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618716; cv=none; b=btoIVAra1DPZLmSnV7fTcWckoZIrWgS8tYaa1NFQiSkiVi2TJTUVqFk7v/On1/BfccFrICN5+xubjMRcJORqNgwdXZP0HAHFkr7UGTZnPvSwvVMGPzxKJK7jBoaoNm4lzP/JoVtNbVESbxJE3JjmyU90qYII6gQPTQYAjOdpQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618716; c=relaxed/simple;
	bh=o5ouQ47XIefZtNuo59b5RU7CJhoAR/EzlzhbUNAdDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3uGGY1Zoetx8jII2IkfdxHrcFeyRpJ+buhiWf2JHxF1s7dunVhlm8pCe7QW6Bf5FrpKR5vlWwj4BlRCHGBgImfmSk9mhLdt39wuq9Qlgln8IMYVEGyWazTqqpc3mC0zJ06gwBGVIgucQHTmzP3rYJCUzNKFvlTo3k2acCwajRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EBHURQ2C; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a01bcd0143so32056fac.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743618713; x=1744223513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWHOxVxf8+IcejOJg3ObVeF4Mqr2/CaNCjHZcGNxb5k=;
        b=EBHURQ2C4xO5GP0Z+rX0HzHs7xbycn+KPaLGLtmQe3EPZLVme0JLLrEwKU6yapBVv3
         +tGq9MJ/Ty8Fr722GWmsNAX2+wM52juanaNrpL8xrYN5FhB6u2diFvj2G20JDL0fl9La
         UFSqxP/w6H3nHf3Wc+8hA7i3pqz26C2puGr1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618713; x=1744223513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWHOxVxf8+IcejOJg3ObVeF4Mqr2/CaNCjHZcGNxb5k=;
        b=IINIW239ng5l7OreEk5koXD5/tjjNEkbdtw9TWqGzSFApPuNb3WLvXXwiHXuuieIKb
         yfPbt/ZcdDsfW2Bw+/6b04OG3EwA5JdgLI4xt3zI0FKa/moysBo8L9MKFttmOAd8PRp5
         T28Nwee3WmeW3GC9tdxl/onzL9sM6tGf/pSUxFDhe+JcKeEa4hbPYOgSCoql7Cis3lwh
         wsq5bcgPEh9wk7piyy9fDZpaq3nN1C/r2gLzbwAYVe4jmD+B+UpaUkS9QQqqcGEpB+7G
         9xhk0C18wKbawNa+IJvdZLcc2OLxLz1SqjXulAlm8GhuPoBPOpGmcIoY08hzrtO+HeT1
         c3xQ==
X-Gm-Message-State: AOJu0YzIpUn9Z3bSfd8EE9bn+7Vd+mzgUZeqG9e0X6IY5gYdpbKtfmcG
	s3T2vItPLsyjheU6Wyt+Wbllz4zj+8k8p4jZLx/DJ42nlGlEeZLG5vbkUSTAjw==
X-Gm-Gg: ASbGncs2eYsbjUtNG1UKANjzyiOJ5BsyjCdwDPs+C7Xu3vb+m7liITUIWwfklEBtKTt
	fuDbCv35AG/AR8rAclcQphebQVylv9aJiav0fevs2WeSsdJVDY01jivGR+zREy4uRMjN7TNAGtc
	mnhTtbKvnxnYIhbHg8fUeDhFli++ep7aMAMcYM+d3advtyw9xoRkWI5uPRh+pSSSHboK8eVZJxz
	xhVYR+YhTWmERvo5PhSHg6oNEDHgooaUBUbQlnXA2f/e5sj833hNaycR0x5R31M+857M1iE0mjO
	WZCNUfQYemQnvp2pKtooj5HDq85VPRwSRA/AfpQYjdkGE1/C8ALSarCsQTw7HbX3efV2U4YUmMK
	iVny/wpqF3dqa5FCgJ+Pe
X-Google-Smtp-Source: AGHT+IEEUryZ4vixKrjelVVHURx1nclBUYK3xifh9hRybwzGHOdhAkS3iKDwLiaX3vEyrCoqMQjp6Q==
X-Received: by 2002:a05:6871:e787:b0:2a7:d856:94a with SMTP id 586e51a60fabf-2cbcf52fdd7mr10442833fac.22.1743618713526;
        Wed, 02 Apr 2025 11:31:53 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a856de7sm2917135fac.39.2025.04.02.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:31:53 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	horms@kernel.org,
	danieller@nvidia.com,
	damodharam.ammepalli@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 2/2] ethtool: cmis: use u16 for calculated read_write_len_ext
Date: Wed,  2 Apr 2025 11:31:23 -0700
Message-ID: <20250402183123.321036-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250402183123.321036-1-michael.chan@broadcom.com>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

For EPL (Extended Payload), the maximum calculated size returned by
ethtool_cmis_get_max_epl_size() is 2048, so the read_write_len_ext
field in struct ethtool_cmis_cdb_cmd_args needs to be changed to u16
to hold the value.

To avoid confusion with other u8 read_write_len_ext fields defined
by the CMIS spec, change the field name to calc_read_write_len_ext.

Without this change, module flashing can fail:

Transceiver module firmware flashing started for device enp177s0np0
Transceiver module firmware flashing in progress for device enp177s0np0
Progress: 0%
Transceiver module firmware flashing encountered an error for device enp177s0np0
Status message: Write FW block EPL command failed, LPL length is longer
	than CDB read write length extension allows.

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 net/ethtool/cmis.h     | 7 ++++---
 net/ethtool/cmis_cdb.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 1e790413db0e..51f5d5439e2a 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -63,8 +63,9 @@ struct ethtool_cmis_cdb_request {
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
  * @req: CDB command fields as described in the CMIS standard.
  * @max_duration: Maximum duration time for command completion in msec.
- * @read_write_len_ext: Allowable additional number of byte octets to the LPL
- *			in a READ or a WRITE commands.
+ * @calc_read_write_len_ext: Calculated allowable additional number of byte
+ *			     octets to the LPL or EPL in a READ or WRITE CDB
+ *			     command.
  * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @rpl_exp_len: Expected reply length in bytes.
  * @flags: Validation flags for CDB commands.
@@ -73,7 +74,7 @@ struct ethtool_cmis_cdb_request {
 struct ethtool_cmis_cdb_cmd_args {
 	struct ethtool_cmis_cdb_request req;
 	u16				max_duration;
-	u8				read_write_len_ext;
+	u16				calc_read_write_len_ext;
 	u8				msleep_pre_rpl;
 	u8                              rpl_exp_len;
 	u8				flags;
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index dba3aa909a95..1f487e1a6347 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -35,13 +35,13 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 	args->req.lpl_len = lpl_len;
 	if (lpl) {
 		memcpy(args->req.payload, lpl, args->req.lpl_len);
-		args->read_write_len_ext =
+		args->calc_read_write_len_ext =
 			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
 	}
 	if (epl) {
 		args->req.epl_len = cpu_to_be16(epl_len);
 		args->req.epl = epl;
-		args->read_write_len_ext =
+		args->calc_read_write_len_ext =
 			ethtool_cmis_get_max_epl_size(read_write_len_ext);
 	}
 
@@ -590,7 +590,7 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
 			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
 			bytes_to_write = min_t(u16, bytes_left,
 					       min_t(u16, space_left,
-						     args->read_write_len_ext));
+						     args->calc_read_write_len_ext));
 
 			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
 							     page, offset,
@@ -631,7 +631,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
 				       offsetof(struct ethtool_cmis_cdb_request,
 						epl));
 
-	if (args->req.lpl_len > args->read_write_len_ext) {
+	if (args->req.lpl_len > args->calc_read_write_len_ext) {
 		args->err_msg = "LPL length is longer than CDB read write length extension allows";
 		return -EINVAL;
 	}
-- 
2.30.1


