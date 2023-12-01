Return-Path: <netdev+bounces-53124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF58016A4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0525B211B4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503393F8EA;
	Fri,  1 Dec 2023 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gS9016uM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C232CD54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:58 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a51ad638eso32220316d6.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470398; x=1702075198; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=34Sfld6H4RDoMozY8if/8OEhAL+u+aqVOMy47PhNcAE=;
        b=gS9016uMvqTohIe2lkgG5sxyN4wToqUXaiDX21jhlrUgsUMJV0mqVXYXFI5M48EZf1
         NaXPVpzsyjzXv0cA8dx4jA/Z9V1j39PnzuLAFnySo1j/lOtrWrVEwrf0wCFA430leQHL
         YWYUCkJWwa8SgKEx6JUruyZeOb8VEffQfjtGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470398; x=1702075198;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34Sfld6H4RDoMozY8if/8OEhAL+u+aqVOMy47PhNcAE=;
        b=GU13Psv+itnbmNPxbMZ7jMyPCz+hvC3TtqzfvdOCOVkU4kpnFjQI8DDr5ak0+YyiXC
         U78ItPgvohf1aBAa2fvziv9UobfrIEScvS4DCB/TGVnXi8/dp40cdZekD/uUuTNYkg8D
         aypX6+UY/Q8NZpGSNv6nJPvcpOdVV3GpAlRvtifXT2SNjwyCgdAAzWPHXS/c2mvlbeER
         AWYjky1fJGry24FoGSN1QXiT8WcjWcJ3dAKRUDt4GbwHEjMIfTyGclNiTaQeyUPl82+/
         b5Uh6OahY0FbufckohiVRUvCWwEPsG+zoNKt6xFZn9gtJ4x/Jarl46C/Jj/pO/61pt5N
         Xfqg==
X-Gm-Message-State: AOJu0YyDZqXV6qf+jJWCK0kYwYMu5UUgfz3VVO2TXOyY77g7xdmA95hU
	KAuq5usID0p6EXz6kjQYJY78BA==
X-Google-Smtp-Source: AGHT+IHXyITZdMN4GYKWBNhN7ftPo/sPhgCTvyUnm636az7XyiklMYNa4kJLSS5H0aZagC95aiHKLQ==
X-Received: by 2002:a05:6214:dce:b0:67a:a72d:fbb8 with SMTP id 14-20020a0562140dce00b0067aa72dfbb8mr314220qvt.54.1701470397691;
        Fri, 01 Dec 2023 14:39:57 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:57 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 07/15] bnxt_en: Add new P7 hardware interface definitions
Date: Fri,  1 Dec 2023 14:39:16 -0800
Message-Id: <20231201223924.26955-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000acda3b060b7a72a7"

--000000000000acda3b060b7a72a7
Content-Transfer-Encoding: 8bit

Add new RX, TX, and TPA hardware interface structures and macros for the
P7 chips.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 85 ++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d10811f4073b..ba9caae923f2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -139,11 +139,15 @@ struct tx_cmp {
 	__le32 tx_cmp_flags_type;
 	#define CMP_TYPE					(0x3f << 0)
 	 #define CMP_TYPE_TX_L2_CMP				 0
+	 #define CMP_TYPE_TX_L2_COAL_CMP			 2
+	 #define CMP_TYPE_TX_L2_PKT_TS_CMP			 4
 	 #define CMP_TYPE_RX_L2_CMP				 17
 	 #define CMP_TYPE_RX_AGG_CMP				 18
 	 #define CMP_TYPE_RX_L2_TPA_START_CMP			 19
 	 #define CMP_TYPE_RX_L2_TPA_END_CMP			 21
 	 #define CMP_TYPE_RX_TPA_AGG_CMP			 22
+	 #define CMP_TYPE_RX_L2_V3_CMP				 23
+	 #define CMP_TYPE_RX_L2_TPA_START_V3_CMP		 25
 	 #define CMP_TYPE_STATUS_CMP				 32
 	 #define CMP_TYPE_REMOTE_DRIVER_REQ			 34
 	 #define CMP_TYPE_REMOTE_DRIVER_RESP			 36
@@ -170,9 +174,13 @@ struct tx_cmp {
 	 #define TX_CMP_ERRORS_DMA_ERROR			 (1 << 6)
 	 #define TX_CMP_ERRORS_HINT_TOO_SHORT			 (1 << 7)
 
-	__le32 tx_cmp_unsed_3;
+	__le32 sq_cons_idx;
+	#define TX_CMP_SQ_CONS_IDX_MASK				0x00ffffff
 };
 
+#define TX_CMP_SQ_CONS_IDX(txcmp)					\
+	(le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
+
 struct rx_cmp {
 	__le32 rx_cmp_len_flags_type;
 	#define RX_CMP_CMP_TYPE					(0x3f << 0)
@@ -200,8 +208,20 @@ struct rx_cmp {
 	 #define RX_CMP_AGG_BUFS_SHIFT				 1
 	#define RX_CMP_RSS_HASH_TYPE				(0x7f << 9)
 	 #define RX_CMP_RSS_HASH_TYPE_SHIFT			 9
+	#define RX_CMP_V3_RSS_EXT_OP_LEGACY			(0xf << 12)
+	 #define RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT		 12
+	#define RX_CMP_V3_RSS_EXT_OP_NEW			(0xf << 8)
+	 #define RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT			 8
 	#define RX_CMP_PAYLOAD_OFFSET				(0xff << 16)
 	 #define RX_CMP_PAYLOAD_OFFSET_SHIFT			 16
+	#define RX_CMP_SUB_NS_TS				(0xf << 16)
+	 #define RX_CMP_SUB_NS_TS_SHIFT				 16
+	#define RX_CMP_METADATA1				(0xf << 28)
+	 #define RX_CMP_METADATA1_SHIFT				 28
+	#define RX_CMP_METADATA1_TPID_SEL			(0x7 << 28)
+	#define RX_CMP_METADATA1_TPID_8021Q			(0x1 << 28)
+	#define RX_CMP_METADATA1_TPID_8021AD			(0x0 << 28)
+	#define RX_CMP_METADATA1_VALID				(0x8 << 28)
 
 	__le32 rx_cmp_rss_hash;
 };
@@ -215,6 +235,30 @@ struct rx_cmp {
 	(((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_RSS_HASH_TYPE) >>\
 	  RX_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
 
+#define RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp)				\
+	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_V3_RSS_EXT_OP_LEGACY) >>\
+	 RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT)
+
+#define RX_CMP_V3_HASH_TYPE_NEW(rxcmp)				\
+	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_V3_RSS_EXT_OP_NEW) >>\
+	 RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT)
+
+#define RX_CMP_V3_HASH_TYPE(bp, rxcmp)				\
+	(((bp)->rss_cap & BNXT_RSS_CAP_RSS_TCAM) ?		\
+	  RX_CMP_V3_HASH_TYPE_NEW(rxcmp) :			\
+	  RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp))
+
+#define EXT_OP_INNER_4		0x0
+#define EXT_OP_OUTER_4		0x2
+#define EXT_OP_INNFL_3		0x8
+#define EXT_OP_OUTFL_3		0xa
+
+#define RX_CMP_VLAN_VALID(rxcmp)				\
+	((rxcmp)->rx_cmp_misc_v1 & cpu_to_le32(RX_CMP_METADATA1_VALID))
+
+#define RX_CMP_VLAN_TPID_SEL(rxcmp)				\
+	(le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_METADATA1_TPID_SEL)
+
 struct rx_cmp_ext {
 	__le32 rx_cmp_flags2;
 	#define RX_CMP_FLAGS2_IP_CS_CALC			0x1
@@ -262,6 +306,9 @@ struct rx_cmp_ext {
 
 	#define RX_CMPL_CFA_CODE_MASK				(0xffff << 16)
 	 #define RX_CMPL_CFA_CODE_SFT				 16
+	#define RX_CMPL_METADATA0_TCI_MASK			(0xffff << 16)
+	#define RX_CMPL_METADATA0_VID_MASK			(0x0fff << 16)
+	 #define RX_CMPL_METADATA0_SFT				 16
 
 	__le32 rx_cmp_timestamp;
 };
@@ -287,6 +334,10 @@ struct rx_cmp_ext {
 	((le32_to_cpu((rxcmpl1)->rx_cmp_cfa_code_errors_v2) &		\
 	  RX_CMPL_CFA_CODE_MASK) >> RX_CMPL_CFA_CODE_SFT)
 
+#define RX_CMP_METADATA0_TCI(rxcmp1)					\
+	((le32_to_cpu((rxcmp1)->rx_cmp_cfa_code_errors_v2) &		\
+	  RX_CMPL_METADATA0_TCI_MASK) >> RX_CMPL_METADATA0_SFT)
+
 struct rx_agg_cmp {
 	__le32 rx_agg_cmp_len_flags_type;
 	#define RX_AGG_CMP_TYPE					(0x3f << 0)
@@ -329,10 +380,18 @@ struct rx_tpa_start_cmp {
 	#define RX_TPA_START_CMP_V1				(0x1 << 0)
 	#define RX_TPA_START_CMP_RSS_HASH_TYPE			(0x7f << 9)
 	 #define RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT		 9
+	#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE		(0x1ff << 7)
+	 #define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT	 7
 	#define RX_TPA_START_CMP_AGG_ID				(0x7f << 25)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT			 25
 	#define RX_TPA_START_CMP_AGG_ID_P5			(0xffff << 16)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT_P5		 16
+	#define RX_TPA_START_CMP_METADATA1			(0xf << 28)
+	 #define RX_TPA_START_CMP_METADATA1_SHIFT		 28
+	#define RX_TPA_START_METADATA1_TPID_SEL			(0x7 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021Q		(0x1 << 28)
+	#define RX_TPA_START_METADATA1_TPID_8021AD		(0x0 << 28)
+	#define RX_TPA_START_METADATA1_VALID			(0x8 << 28)
 
 	__le32 rx_tpa_start_cmp_rss_hash;
 };
@@ -346,6 +405,11 @@ struct rx_tpa_start_cmp {
 	   RX_TPA_START_CMP_RSS_HASH_TYPE) >>				\
 	  RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
 
+#define TPA_START_V3_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_V3_RSS_HASH_TYPE) >>			\
+	  RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
 #define TPA_START_AGG_ID(rx_tpa_start)					\
 	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
 	 RX_TPA_START_CMP_AGG_ID) >> RX_TPA_START_CMP_AGG_ID_SHIFT)
@@ -358,6 +422,14 @@ struct rx_tpa_start_cmp {
 	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
 	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_ERROR))
 
+#define TPA_START_VLAN_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_misc_v1 &			\
+	 cpu_to_le32(RX_TPA_START_METADATA1_VALID))
+
+#define TPA_START_VLAN_TPID_SEL(rx_tpa_start)				\
+	(le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_METADATA1_TPID_SEL)
+
 struct rx_tpa_start_cmp_ext {
 	__le32 rx_tpa_start_cmp_flags2;
 	#define RX_TPA_START_CMP_FLAGS2_IP_CS_CALC		(0x1 << 0)
@@ -368,6 +440,8 @@ struct rx_tpa_start_cmp_ext {
 	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_VALID		(0x1 << 9)
 	#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT		(0x3 << 10)
 	 #define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT_SHIFT	 10
+	#define RX_TPA_START_CMP_V3_FLAGS2_T_IP_TYPE		(0x1 << 10)
+	#define RX_TPA_START_CMP_V3_FLAGS2_AGG_GRO		(0x1 << 11)
 	#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL		(0xffff << 16)
 	 #define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_SHIFT	 16
 
@@ -381,6 +455,9 @@ struct rx_tpa_start_cmp_ext {
 	 #define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_FLUSH	 (0x5 << 1)
 	#define RX_TPA_START_CMP_CFA_CODE			(0xffff << 16)
 	 #define RX_TPA_START_CMPL_CFA_CODE_SHIFT		 16
+	#define RX_TPA_START_CMP_METADATA0_TCI_MASK		(0xffff << 16)
+	#define RX_TPA_START_CMP_METADATA0_VID_MASK		(0x0fff << 16)
+	 #define RX_TPA_START_CMP_METADATA0_SFT			 16
 	__le32 rx_tpa_start_cmp_hdr_info;
 };
 
@@ -397,6 +474,11 @@ struct rx_tpa_start_cmp_ext {
 	  RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK) >>			\
 	 RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT)
 
+#define TPA_START_METADATA0_TCI(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_METADATA0_TCI_MASK) >>			\
+	 RX_TPA_START_CMP_METADATA0_SFT)
+
 struct rx_tpa_end_cmp {
 	__le32 rx_tpa_end_cmp_len_flags_type;
 	#define RX_TPA_END_CMP_TYPE				(0x3f << 0)
@@ -2023,6 +2105,7 @@ struct bnxt {
 #define BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA	BIT(0)
 #define BNXT_RSS_CAP_UDP_RSS_CAP		BIT(1)
 #define BNXT_RSS_CAP_NEW_RSS_CAP		BIT(2)
+#define BNXT_RSS_CAP_RSS_TCAM			BIT(3)
 
 	u16			max_mtu;
 	u8			max_tc;
-- 
2.30.1


--000000000000acda3b060b7a72a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPw51gTdQIayuAq6WdDATzp0pNA5HNLC
HzHFb4AqpVALMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBRqdNDoOs7RWINnyGejVuOvWErejgfitQfPtMmLHyJiSjD+l5S
176cbVF0Jjh+b6MzeIIy4s2w6Y+Ou3lo77CIAifPyqt5ZFATs6GXMzjRtwPWKkWrWShCt8OZkDjV
hqMmEQejQU2jI2zNJ8XM5psARBPfwKijs8lOGdyLRYNqfKACd9k49TmmGX/hEDPKJUTy4jkgg4M6
OAzv4ACCjogjMkhnEPVmp+xd0TyCWrqTw163ZSW66/GUHA8F/CV2pX7k2aXY8CTYIb5OPMviJOZL
eK91wIRCYrXYlSMkybK0La07aSMO/T2CxHpph2xb81hH5snLN1dTPfvnYMxn/kLf
--000000000000acda3b060b7a72a7--

