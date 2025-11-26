Return-Path: <netdev+bounces-242023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D4C8BBF9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 442CD3568DF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005E3446B8;
	Wed, 26 Nov 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T1OmJ+F9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294553446A8
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186638; cv=none; b=pV99yNTnK5k9MsD9vIbtdw7WKTIpJFaFYHew/Y9f0DLyIezLixBbLlgPo52Oy58wz8dyTy0zZkdyE7/AbYOeWSLYTYE9hwL6ss7z55Ty/oU5g4SbuwkRMGEA5bxH11xyzD0PKumlKVpQBmJTE9eCiCm60QMNEjJl0TanLjTVDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186638; c=relaxed/simple;
	bh=/HZVNW5OxxlVlNIfHE3ChDv8GsF61qcpxO2JLVI3zN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnwNRXnjtf372A9P8bhKDaGV2oTNfYdLJaXsL5M2E3hk4KIfz7LUWqurccEXKt4sWbkp0V7AuYXKx1l/6cRfg5BCwRMpttrBNJcmFgwCHMBwt+WWBYQPbuoegd4Bmcs0zID9c8RzNiK3CA0czO25dlRXk9v8jmkMZ1rFyHCWs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T1OmJ+F9; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso4960439f.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186635; x=1764791435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqSX51l+/a982PibrmJNbpoAtL6ZxZDmwPfrfWLGeh4=;
        b=RLA45fK/GiaZFv70g0h9ZsPtJv0m0gxOdDo1TsyllyOH68z/LfcsKvu9HeMXVEan7g
         r6bsY8ZgeY/OQAF/Qt9D4ERkosX0ZuCodZ545DVGKS7vawzgz4imv9JxYGeAe6ctjxDw
         M440Zrb2Z80MucSjwM2CW7ele0cUwJpP2vZeWB8K+z/I2Ngs1OBSCPgiM2becrTe+ZXc
         izuf8JIqnpbnk97jCtVCZIGuh8oaout88q1KfRLaY/AOCYiYHLJ41IJbZKI+K05tm8/s
         crbBzrTC3nlDhLk+CXlHtnSkx1dSQRcgDNb63Llje7rM/GzqVmdiJJb6ObFBrt7A+ynO
         rFEA==
X-Gm-Message-State: AOJu0YyEX6VMImMiVLYUEH0CvF4rzTfA4MjafPR0LqQpP1KEOT2GYanD
	nYm8TDoAl8g4OefPre72z7CAm2PUOgmEIAIVXtkPD2I+28DGFYD8dSW3VWA+8GxLAzBvYTbh4y+
	NG8pwgDQyEftFCWlBqjwrAKTNKZYHhNRKXWCO3JRGGlahU3qrvykR45HoMv4nLG9kdS91qruZa7
	eEjC3/vgDT2+Y4GpbPv1Il9ZfOlxQP3p76D+S0/wH8N+0DUi5VVQcNo2jwyHx41ndMDPE2JfgP7
	7O2BhP6f51OWZl3r+or
X-Gm-Gg: ASbGnctBHyDaX5Tk6tomJ402ikkh0Dq9vm4bHZrw0s+HdUTSmEnM3NykjtG/Mb9AA2P
	FG9KzTtzqOwYVpaQfn/ebgfnamrAkLleDL31PwWxONAm2s7xfxmSJg4aUB5zsO6rn/x7UGPrJIr
	51S6SahPhs+aFTB7rx64r7uqWjIybna/cEDq980LyOCyM5aJwccI73EyeUH56gQmobNLfMD0xX1
	N1TnCAZmscrOEzPFmnFlJ3v6i6D7NmSNzux/az1tJGokJ1BtYrV4vclu8Q+L4S/W1xU20yC/8t1
	hTtB7fJijrn/XVwaOTDWGcWnGADAShQ9ZNhKklTEMYUi1zvGtqwtQqdmkQRa97nTxJ1fDngHLsk
	0VpM1JGeII3Tjd7R2eZH6vOHGvTuuTG9CpCV5YpJZ0wHW6frTL4OxNU7ZlNvX2m7Y8rwRGhKnmf
	AGiFEKpc5KOw2IzHFkByPnLPg5YPgWxBayTgUw1olh+wKK78vYs6c=
X-Google-Smtp-Source: AGHT+IF2eWGr3F/aukS8n+1+18qQ8fX4P22a0ZJaiGl0Y1KyMTkpbA//o0hPMyoz7ANl5s0eMdMEPY95a+pj
X-Received: by 2002:a05:6638:aad0:20b0:5b7:33c6:917b with SMTP id 8926c6da1cb9f-5b99963d07fmr5030780173.14.1764186635237;
        Wed, 26 Nov 2025 11:50:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-94938505893sm86153939f.0.2025.11.26.11.50.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-298535ef0ccso1174535ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186634; x=1764791434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqSX51l+/a982PibrmJNbpoAtL6ZxZDmwPfrfWLGeh4=;
        b=T1OmJ+F9zVN6m0kv0AFPYovDzsmIV19mjTFWZL01LBkpnuXv9C/AljSezmWupCtWPN
         55Kph2IjxBfBbdhZouAD0KW/zUlE2dK8r3wGq8RofGH0dhRDcOFmitZ5mcLsmu1L3jBE
         aK/eqTSV7OvF+wsIcVP81hdNIYWarOrfF7qwo=
X-Received: by 2002:a17:903:2c0e:b0:297:ef11:b504 with SMTP id d9443c01a7336-29baafcc2e8mr91392355ad.24.1764186633571;
        Wed, 26 Nov 2025 11:50:33 -0800 (PST)
X-Received: by 2002:a17:903:2c0e:b0:297:ef11:b504 with SMTP id d9443c01a7336-29baafcc2e8mr91392125ad.24.1764186633084;
        Wed, 26 Nov 2025 11:50:33 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:32 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v3, net-next 07/12] bng_en: Add TPA related functions
Date: Thu, 27 Nov 2025 01:19:26 +0530
Message-ID: <20251126194931.455830-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add the functions to handle TPA events in RX path.
This helps the next patch enable TPA functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 248 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 123 +++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  47 ++++
 3 files changed, 418 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index cfc888a7f9e..a824e0566be 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -208,4 +208,252 @@ struct rx_cmp_ext {
 #define HWRM_RING_ALLOC_AGG	0x4
 #define HWRM_RING_ALLOC_CMPL	0x8
 #define HWRM_RING_ALLOC_NQ	0x10
+
+#define TPA_AGG_AGG_ID(rx_agg)				\
+	((le32_to_cpu((rx_agg)->rx_agg_cmp_v) &		\
+	 RX_AGG_CMP_AGG_ID) >> RX_AGG_CMP_AGG_ID_SHIFT)
+
+struct rx_tpa_start_cmp {
+	__le32 rx_tpa_start_cmp_len_flags_type;
+	#define RX_TPA_START_CMP_TYPE				(0x3f << 0)
+	#define RX_TPA_START_CMP_FLAGS				(0x3ff << 6)
+	 #define RX_TPA_START_CMP_FLAGS_SHIFT			 6
+	#define RX_TPA_START_CMP_FLAGS_ERROR			(0x1 << 6)
+	#define RX_TPA_START_CMP_FLAGS_PLACEMENT		(0x7 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_SHIFT		 7
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_JUMBO		 (0x1 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_HDS		 (0x2 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_JUMBO	 (0x5 << 7)
+	 #define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_HDS	 (0x6 << 7)
+	#define RX_TPA_START_CMP_FLAGS_RSS_VALID		(0x1 << 10)
+	#define RX_TPA_START_CMP_FLAGS_TIMESTAMP		(0x1 << 11)
+	#define RX_TPA_START_CMP_FLAGS_ITYPES			(0xf << 12)
+	 #define RX_TPA_START_CMP_FLAGS_ITYPES_SHIFT		 12
+	 #define RX_TPA_START_CMP_FLAGS_ITYPE_TCP		 (0x2 << 12)
+	#define RX_TPA_START_CMP_LEN				(0xffff << 16)
+	 #define RX_TPA_START_CMP_LEN_SHIFT			 16
+
+	u32 rx_tpa_start_cmp_opaque;
+	__le32 rx_tpa_start_cmp_misc_v1;
+	#define RX_TPA_START_CMP_V1				(0x1 << 0)
+	#define RX_TPA_START_CMP_RSS_HASH_TYPE			(0x7f << 9)
+	 #define RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT		 9
+	#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE		(0x1ff << 7)
+	 #define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT	 7
+	#define RX_TPA_START_CMP_AGG_ID				(0x7f << 25)
+	 #define RX_TPA_START_CMP_AGG_ID_SHIFT			 25
+	#define RX_TPA_START_CMP_AGG_ID_P5			(0xffff << 16)
+	 #define RX_TPA_START_CMP_AGG_ID_SHIFT_P5		 16
+	#define RX_TPA_START_CMP_METADATA1			(0xf << 28)
+	 #define RX_TPA_START_CMP_METADATA1_SHIFT		 28
+	#define RX_TPA_START_METADATA1_TPID_SEL			(0x7 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021Q		(0x1 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021AD		(0x0 << 28)
+	#define RX_TPA_START_METADATA1_VALID			(0x8 << 28)
+
+	__le32 rx_tpa_start_cmp_rss_hash;
+};
+
+#define TPA_START_HASH_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_RSS_VALID))
+
+#define TPA_START_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_RSS_HASH_TYPE) >>				\
+	  RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_V3_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_V3_RSS_HASH_TYPE) >>			\
+	  RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_AGG_ID(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_CMP_AGG_ID_P5) >> RX_TPA_START_CMP_AGG_ID_SHIFT_P5)
+
+#define TPA_START_ERROR(rx_tpa_start)					\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_ERROR))
+
+#define TPA_START_VLAN_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_misc_v1 &			\
+	 cpu_to_le32(RX_TPA_START_METADATA1_VALID))
+
+#define TPA_START_VLAN_TPID_SEL(rx_tpa_start)				\
+	(le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_METADATA1_TPID_SEL)
+
+struct rx_tpa_start_cmp_ext {
+	__le32 rx_tpa_start_cmp_flags2;
+	#define RX_TPA_START_CMP_FLAGS2_IP_CS_CALC		(0x1 << 0)
+	#define RX_TPA_START_CMP_FLAGS2_L4_CS_CALC		(0x1 << 1)
+	#define RX_TPA_START_CMP_FLAGS2_T_IP_CS_CALC		(0x1 << 2)
+	#define RX_TPA_START_CMP_FLAGS2_T_L4_CS_CALC		(0x1 << 3)
+	#define RX_TPA_START_CMP_FLAGS2_IP_TYPE			(0x1 << 8)
+	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_VALID		(0x1 << 9)
+	#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT		(0x3 << 10)
+	 #define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT_SHIFT	 10
+	#define RX_TPA_START_CMP_V3_FLAGS2_T_IP_TYPE		(0x1 << 10)
+	#define RX_TPA_START_CMP_V3_FLAGS2_AGG_GRO		(0x1 << 11)
+	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL		(0xffff << 16)
+	 #define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_SHIFT	 16
+
+	__le32 rx_tpa_start_cmp_metadata;
+	__le32 rx_tpa_start_cmp_cfa_code_v2;
+	#define RX_TPA_START_CMP_V2				(0x1 << 0)
+	#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK	(0x7 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT	 1
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	 (0x0 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT (0x3 << 1)
+	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_FLUSH	 (0x5 << 1)
+	#define RX_TPA_START_CMP_CFA_CODE			(0xffff << 16)
+	 #define RX_TPA_START_CMPL_CFA_CODE_SHIFT		 16
+	#define RX_TPA_START_CMP_METADATA0_TCI_MASK		(0xffff << 16)
+	#define RX_TPA_START_CMP_METADATA0_VID_MASK		(0x0fff << 16)
+	 #define RX_TPA_START_CMP_METADATA0_SFT			 16
+	__le32 rx_tpa_start_cmp_hdr_info;
+};
+
+#define TPA_START_CFA_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	 RX_TPA_START_CMP_CFA_CODE) >> RX_TPA_START_CMPL_CFA_CODE_SHIFT)
+
+#define TPA_START_IS_IPV6(rx_tpa_start)				\
+	(!!((rx_tpa_start)->rx_tpa_start_cmp_flags2 &		\
+	    cpu_to_le32(RX_TPA_START_CMP_FLAGS2_IP_TYPE)))
+
+#define TPA_START_ERROR_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK) >>			\
+	 RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT)
+
+#define TPA_START_METADATA0_TCI(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_METADATA0_TCI_MASK) >>			\
+	 RX_TPA_START_CMP_METADATA0_SFT)
+
+struct rx_tpa_end_cmp {
+	__le32 rx_tpa_end_cmp_len_flags_type;
+	#define RX_TPA_END_CMP_TYPE				(0x3f << 0)
+	#define RX_TPA_END_CMP_FLAGS				(0x3ff << 6)
+	 #define RX_TPA_END_CMP_FLAGS_SHIFT			 6
+	#define RX_TPA_END_CMP_FLAGS_PLACEMENT			(0x7 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_SHIFT		 7
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_JUMBO		 (0x1 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_HDS		 (0x2 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO	 (0x5 << 7)
+	 #define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS		 (0x6 << 7)
+	#define RX_TPA_END_CMP_FLAGS_RSS_VALID			(0x1 << 10)
+	#define RX_TPA_END_CMP_FLAGS_ITYPES			(0xf << 12)
+	 #define RX_TPA_END_CMP_FLAGS_ITYPES_SHIFT		 12
+	 #define RX_TPA_END_CMP_FLAGS_ITYPE_TCP			 (0x2 << 12)
+	#define RX_TPA_END_CMP_LEN				(0xffff << 16)
+	 #define RX_TPA_END_CMP_LEN_SHIFT			 16
+
+	u32 rx_tpa_end_cmp_opaque;
+	__le32 rx_tpa_end_cmp_misc_v1;
+	#define RX_TPA_END_CMP_V1				(0x1 << 0)
+	#define RX_TPA_END_CMP_AGG_BUFS				(0x3f << 1)
+	 #define RX_TPA_END_CMP_AGG_BUFS_SHIFT			 1
+	#define RX_TPA_END_CMP_TPA_SEGS				(0xff << 8)
+	 #define RX_TPA_END_CMP_TPA_SEGS_SHIFT			 8
+	#define RX_TPA_END_CMP_PAYLOAD_OFFSET			(0xff << 16)
+	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		 16
+	#define RX_TPA_END_CMP_AGG_ID				(0xffff << 16)
+	 #define RX_TPA_END_CMP_AGG_ID_SHIFT			 16
+
+	__le32 rx_tpa_end_cmp_tsdelta;
+	#define RX_TPA_END_GRO_TS				(0x1 << 31)
+};
+
+#define TPA_END_AGG_ID(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
+
+#define TPA_END_TPA_SEGS(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
+
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO				\
+	cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &		\
+		    RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)
+
+#define TPA_END_GRO(rx_tpa_end)						\
+	((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &			\
+	 RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
+
+#define TPA_END_GRO_TS(rx_tpa_end)					\
+	(!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &			\
+	    cpu_to_le32(RX_TPA_END_GRO_TS)))
+
+struct rx_tpa_end_cmp_ext {
+	__le32 rx_tpa_end_cmp_dup_acks;
+	#define RX_TPA_END_CMP_TPA_DUP_ACKS			(0xf << 0)
+	#define RX_TPA_END_CMP_PAYLOAD_OFFSET_P5		(0xff << 16)
+	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5		 16
+	#define RX_TPA_END_CMP_AGG_BUFS_P5			(0xff << 24)
+	 #define RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5		 24
+
+	__le32 rx_tpa_end_cmp_seg_len;
+	#define RX_TPA_END_CMP_TPA_SEG_LEN			(0xffff << 0)
+
+	__le32 rx_tpa_end_cmp_errors_v2;
+	#define RX_TPA_END_CMP_V2				(0x1 << 0)
+	#define RX_TPA_END_CMP_ERRORS				(0x3 << 1)
+	#define RX_TPA_END_CMP_ERRORS_P5			(0x7 << 1)
+	#define RX_TPA_END_CMPL_ERRORS_SHIFT			 1
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	 (0x0 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	 (0x2 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	 (0x3 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_RSV_ERROR	 (0x4 << 1)
+	 #define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_FLUSH	 (0x5 << 1)
+
+	u32 rx_tpa_end_cmp_start_opaque;
+};
+
+#define TPA_END_ERRORS(rx_tpa_end_ext)					\
+	((rx_tpa_end_ext)->rx_tpa_end_cmp_errors_v2 &			\
+	 cpu_to_le32(RX_TPA_END_CMP_ERRORS))
+
+#define TPA_END_PAYLOAD_OFF(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_PAYLOAD_OFFSET_P5) >>				\
+	RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5)
+
+#define TPA_END_AGG_BUFS(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_AGG_BUFS_P5) >> RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5)
+
+#define EVENT_DATA1_RESET_NOTIFY_FATAL(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	 ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL)
+
+#define EVENT_DATA1_RESET_NOTIFY_FW_ACTIVATION(data1)			\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION)
+
+#define EVENT_DATA2_RESET_NOTIFY_FW_STATUS_CODE(data2)			\
+	((data2) &							\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_MASK)
+
+#define EVENT_DATA1_RECOVERY_MASTER_FUNC(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASTER_FUNC))
+
+#define EVENT_DATA1_RECOVERY_ENABLED(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_RECOVERY_ENABLED))
+
+#define BNGE_EVENT_ERROR_REPORT_TYPE(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT)
+
+#define BNGE_EVENT_INVALID_SIGNAL_DATA(data2)				\
+	(((data2) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_SFT)
 #endif /* _BNGE_HW_DEF_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9c827afb131..f1c79906110 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -378,11 +378,37 @@ static void bnge_free_one_agg_ring_bufs(struct bnge_net *bn,
 	}
 }
 
+static void bnge_free_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[i];
+		u8 *data = tpa_info->data;
+
+		if (!data)
+			continue;
+
+		tpa_info->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, false);
+	}
+}
+
 static void bnge_free_one_rx_ring_pair_bufs(struct bnge_net *bn,
 					    struct bnge_rx_ring_info *rxr)
 {
+	struct bnge_tpa_idx_map *map;
+
+	if (rxr->rx_tpa)
+		bnge_free_one_tpa_info_data(bn, rxr);
+
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	bnge_free_one_agg_ring_bufs(bn, rxr);
+
+	map = rxr->rx_tpa_idx_map;
+	if (map)
+		memset(map->agg_idx_bmap, 0, sizeof(map->agg_idx_bmap));
 }
 
 static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
@@ -453,11 +479,70 @@ static void bnge_free_all_rings_bufs(struct bnge_net *bn)
 	bnge_free_tx_skbs(bn);
 }
 
+static void bnge_free_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		kfree(rxr->rx_tpa_idx_map);
+		rxr->rx_tpa_idx_map = NULL;
+		if (rxr->rx_tpa) {
+			for (j = 0; j < bn->max_tpa; j++) {
+				kfree(rxr->rx_tpa[j].agg_arr);
+				rxr->rx_tpa[j].agg_arr = NULL;
+			}
+		}
+		kfree(rxr->rx_tpa);
+		rxr->rx_tpa = NULL;
+	}
+}
+
+static int bnge_alloc_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	if (!bd->max_tpa_v2)
+		return 0;
+
+	bn->max_tpa = max_t(u16, bd->max_tpa_v2, MAX_TPA);
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		rxr->rx_tpa = kcalloc(bn->max_tpa, sizeof(struct bnge_tpa_info),
+				      GFP_KERNEL);
+		if (!rxr->rx_tpa)
+			goto err_free_tpa_info;
+
+		for (j = 0; j < bn->max_tpa; j++) {
+			struct rx_agg_cmp *agg;
+
+			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+			if (!agg)
+				goto err_free_tpa_info;
+			rxr->rx_tpa[j].agg_arr = agg;
+		}
+		rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+					      GFP_KERNEL);
+		if (!rxr->rx_tpa_idx_map)
+			goto err_free_tpa_info;
+	}
+	return 0;
+
+err_free_tpa_info:
+	bnge_free_tpa_info(bn);
+	return -ENOMEM;
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	bnge_free_tpa_info(bn);
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
 		struct bnge_ring_struct *ring;
@@ -582,6 +667,12 @@ static int bnge_alloc_rx_rings(struct bnge_net *bn)
 				goto err_free_rx_rings;
 		}
 	}
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_alloc_tpa_info(bn);
+		if (rc)
+			goto err_free_rx_rings;
+	}
 	return rc;
 
 err_free_rx_rings:
@@ -1127,6 +1218,29 @@ static int bnge_alloc_one_agg_ring_bufs(struct bnge_net *bn,
 	return -ENOMEM;
 }
 
+static int bnge_alloc_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	dma_addr_t mapping;
+	u8 *data;
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		data = __bnge_alloc_rx_frag(bn, &mapping, rxr,
+					    GFP_KERNEL);
+		if (!data)
+			goto err_free_tpa_info_data;
+
+		rxr->rx_tpa[i].data = data;
+		rxr->rx_tpa[i].data_ptr = data + bn->rx_offset;
+		rxr->rx_tpa[i].mapping = mapping;
+	}
+	return 0;
+err_free_tpa_info_data:
+	bnge_free_one_tpa_info_data(bn, rxr);
+	return -ENOMEM;
+}
+
 static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 {
 	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
@@ -1141,8 +1255,17 @@ static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 		if (rc)
 			goto err_free_one_rx_ring_bufs;
 	}
+
+	if (rxr->rx_tpa) {
+		rc = bnge_alloc_one_tpa_info_data(bn, rxr);
+		if (rc)
+			goto err_free_one_agg_ring_bufs;
+	}
+
 	return 0;
 
+err_free_one_agg_ring_bufs:
+	bnge_free_one_agg_ring_bufs(bn, rxr);
 err_free_one_rx_ring_bufs:
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 9d49241d732..41e3ca671a7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -154,6 +154,46 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NO_FW_ACCESS(bd)	(pci_channel_offline((bd)->pdev))
+
+#define MAX_TPA		256
+#define MAX_TPA_MASK	(MAX_TPA - 1)
+#define MAX_TPA_SEGS	0x3f
+
+#define BNGE_AGG_IDX_BMAP_SIZE	(MAX_TPA / BITS_PER_LONG)
+struct bnge_tpa_idx_map {
+	u16		agg_id_tbl[1024];
+	unsigned long	agg_idx_bmap[BNGE_AGG_IDX_BMAP_SIZE];
+};
+
+struct bnge_tpa_info {
+	void			*data;
+	u8			*data_ptr;
+	dma_addr_t		mapping;
+	u16			len;
+	unsigned short		gso_type;
+	u32			flags2;
+	u32			metadata;
+	enum pkt_hash_types	hash_type;
+	u32			rss_hash;
+	u32			hdr_info;
+
+#define BNGE_TPA_INNER_L3_OFF(hdr_info)	\
+	(((hdr_info) >> 18) & 0x1ff)
+
+#define BNGE_TPA_INNER_L2_OFF(hdr_info)	\
+	(((hdr_info) >> 9) & 0x1ff)
+
+#define BNGE_TPA_OUTER_L3_OFF(hdr_info)	\
+	((hdr_info) & 0x1ff)
+
+	u16			cfa_code; /* cfa_code in TPA start compl */
+	u8			agg_count;
+	u8			vlan_valid:1;
+	u8			cfa_code_valid:1;
+	struct rx_agg_cmp	*agg_arr;
+};
+
 /* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
  * BD because the first TX BD is always a long BD.
  */
@@ -248,6 +288,10 @@ struct bnge_net {
 #define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
+	u16			max_tpa;
+	__be16			vxlan_port;
+	__be16			nge_port;
+	__be16			vxlan_gpe_port;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -393,6 +437,9 @@ struct bnge_rx_ring_info {
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
 
+	struct bnge_tpa_info	*rx_tpa;
+	struct bnge_tpa_idx_map *rx_tpa_idx_map;
+
 	struct bnge_ring_struct	rx_ring_struct;
 	struct bnge_ring_struct	rx_agg_ring_struct;
 	struct page_pool	*page_pool;
-- 
2.47.3


