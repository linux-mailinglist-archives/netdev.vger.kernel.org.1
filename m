Return-Path: <netdev+bounces-43135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5927D1813
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628B928270C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18962B74C;
	Fri, 20 Oct 2023 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M7OwMT5T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A602B747
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:25 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806BD70
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27db9fdec0dso1110080a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837299; x=1698442099; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=geC6aHvoms4kqZI3gxeWulzdM+Ltt3rYvOMxNTCjvUw=;
        b=M7OwMT5TPlH0PlL1f0ieghhRWwtFBYS1aanosmqC2eacvMO2lSfYlS/X1NhSPyjPAK
         UQCio3rCvDq8+X+uOg7tRwciInMyNuxQRWgsKdnxUescSHVDJNK6Vu5PfYy99H4gkM+c
         RrYw9APeTf1xYFlaUPQbTr74paxCU+nWG/wfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837299; x=1698442099;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geC6aHvoms4kqZI3gxeWulzdM+Ltt3rYvOMxNTCjvUw=;
        b=VLdi2kk1kxlGIOWMaeDCUD88D1Om8YaQI2GNPi/9S2R3JnHmDaOrs1uD+/1nO0UF4O
         hyhrw1x9YLkjGdfaF2pklUpIbbkmuYd/rsfb3COkVZIjqszXt32B2wiKH70DWylNfUeM
         HUs7rwm8mG0jRJAEE8bl6zEBx+q7aR0+x0WaQjGT8hJd5CR08IkPD9d1mf4LDejRNC3e
         1PZXPg6Tn0xhBs4gnbs49/dmIj/9nY30x66JFBpUtXHcmGHQnj++AW1HHigNbhTjRYLA
         jZydua0+wkj/5P0R6GEitqH4WXCI+RwlJf2Z7MB906c8Wc26qdeCtj9eenfQNSt0FZgi
         zUUA==
X-Gm-Message-State: AOJu0Yzz3b7m5Gu1DYYALC6QOq8dJfe5Z2gXNWZYt2Uiv/uGYkVywT8D
	k9xPi1vzeTcbVjEa9KMvDSMg8pVjKItm5ee8dhE=
X-Google-Smtp-Source: AGHT+IEoFTQOneTfo/XakO0RinBHabW0vSMuhVkqaSj1fKTWg47b5ZxZz5E9bdt/XMZy6MVvXdfrVQ==
X-Received: by 2002:a17:90b:19c5:b0:27c:e062:c464 with SMTP id nm5-20020a17090b19c500b0027ce062c464mr3542096pjb.37.1697837299122;
        Fri, 20 Oct 2023 14:28:19 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next 8/8] bnxt_en: extend media types to supported and autoneg modes
Date: Fri, 20 Oct 2023 14:27:57 -0700
Message-Id: <20231020212757.173551-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231020212757.173551-1-michael.chan@broadcom.com>
References: <20231020212757.173551-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000026b2a306082c8d29"

--00000000000026b2a306082c8d29
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

The current driver code does not accurately report the supported and
advertised link modes.  It basically always assumes the media type
is copper for any particular speed.  Utilize the recently added link
mode mappings to accurately report fully qualified ethtool link modes for
advertised and supported speeds.

If the media type is known, we will report the supported link modes for
that media only.  If the media is not known, we will report all possible
supported link modes.  The user can now specify any supported link modes
(including NRZ and PAM4) to advertise for autoneg.  It used to only accept
copper NRZ modes.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 273 ++++++++++--------
 1 file changed, 153 insertions(+), 120 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index c72dfa0708e5..53442aaabe5e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -8,6 +8,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/stringify.h>
 #include <linux/ethtool.h>
@@ -1730,86 +1731,6 @@ bnxt_get_link_mode(struct bnxt_link_info *link_info)
 	return link_mode;
 }
 
-#define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, name)		\
-{									\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_1GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     1000baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_10GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     10000baseT_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_25GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     25000baseCR_Full);	\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_40GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     40000baseCR4_Full);\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_50GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     50000baseCR2_Full);\
-	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100GB)			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100000baseCR4_Full);\
-}
-
-#define BNXT_ETHTOOL_TO_FW_SPDS(fw_speeds, lk_ksettings, name)		\
-{									\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100baseT_Half))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_100MB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Full) ||	\
-	    ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  1000baseT_Half))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_1GB;			\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  10000baseT_Full))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_10GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  25000baseCR_Full))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_25GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  40000baseCR4_Full))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_40GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  50000baseCR2_Full))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_50GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100000baseCR4_Full))	\
-		(fw_speeds) |= BNXT_LINK_SPEED_MSK_100GB;		\
-}
-
-#define BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, name)	\
-{									\
-	if ((fw_speeds) & BNXT_LINK_PAM4_SPEED_MSK_50GB)		\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     50000baseCR_Full);	\
-	if ((fw_speeds) & BNXT_LINK_PAM4_SPEED_MSK_100GB)		\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     100000baseCR2_Full);\
-	if ((fw_speeds) & BNXT_LINK_PAM4_SPEED_MSK_200GB)		\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     200000baseCR4_Full);\
-}
-
-#define BNXT_ETHTOOL_TO_FW_PAM4_SPDS(fw_speeds, lk_ksettings, name)	\
-{									\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  50000baseCR_Full))	\
-		(fw_speeds) |= BNXT_LINK_PAM4_SPEED_MSK_50GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  100000baseCR2_Full))	\
-		(fw_speeds) |= BNXT_LINK_PAM4_SPEED_MSK_100GB;		\
-	if (ethtool_link_ksettings_test_link_mode(lk_ksettings, name,	\
-						  200000baseCR4_Full))	\
-		(fw_speeds) |= BNXT_LINK_PAM4_SPEED_MSK_200GB;		\
-}
-
 static void bnxt_get_ethtool_modes(struct bnxt_link_info *link_info,
 				   struct ethtool_link_ksettings *lk_ksettings)
 {
@@ -1843,6 +1764,133 @@ static void bnxt_get_ethtool_modes(struct bnxt_link_info *link_info,
 				 lk_ksettings->link_modes.lp_advertising);
 }
 
+static const u16 bnxt_nrz_speed_masks[] = {
+	[BNXT_LINK_SPEED_100MB_IDX] = BNXT_LINK_SPEED_MSK_100MB,
+	[BNXT_LINK_SPEED_1GB_IDX] = BNXT_LINK_SPEED_MSK_1GB,
+	[BNXT_LINK_SPEED_10GB_IDX] = BNXT_LINK_SPEED_MSK_10GB,
+	[BNXT_LINK_SPEED_25GB_IDX] = BNXT_LINK_SPEED_MSK_25GB,
+	[BNXT_LINK_SPEED_40GB_IDX] = BNXT_LINK_SPEED_MSK_40GB,
+	[BNXT_LINK_SPEED_50GB_IDX] = BNXT_LINK_SPEED_MSK_50GB,
+	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_SPEED_MSK_100GB,
+	[__BNXT_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnxt_pam4_speed_masks[] = {
+	[BNXT_LINK_SPEED_50GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_50GB,
+	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_100GB,
+	[BNXT_LINK_SPEED_200GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_200GB,
+};
+
+static enum bnxt_link_speed_indices
+bnxt_encoding_speed_idx(u8 sig_mode, u16 speed_msk)
+{
+	const u16 *speeds;
+	int idx, len;
+
+	switch (sig_mode) {
+	case BNXT_SIG_MODE_NRZ:
+		speeds = bnxt_nrz_speed_masks;
+		len = ARRAY_SIZE(bnxt_nrz_speed_masks);
+		break;
+	case BNXT_SIG_MODE_PAM4:
+		speeds = bnxt_pam4_speed_masks;
+		len = ARRAY_SIZE(bnxt_pam4_speed_masks);
+		break;
+	default:
+		return BNXT_LINK_SPEED_UNKNOWN;
+	}
+
+	for (idx = 0; idx < len; idx++) {
+		if (speeds[idx] == speed_msk)
+			return idx;
+	}
+
+	return BNXT_LINK_SPEED_UNKNOWN;
+}
+
+#define BNXT_FW_SPEED_MSK_BITS 16
+
+static void
+__bnxt_get_ethtool_speeds(unsigned long fw_mask, enum bnxt_media_type media,
+			  u8 sig_mode, unsigned long *et_mask)
+{
+	enum ethtool_link_mode_bit_indices link_mode;
+	enum bnxt_link_speed_indices speed;
+	u8 bit;
+
+	for_each_set_bit(bit, &fw_mask, BNXT_FW_SPEED_MSK_BITS) {
+		speed = bnxt_encoding_speed_idx(sig_mode, 1 << bit);
+		if (!speed)
+			continue;
+
+		link_mode = bnxt_link_modes[speed][sig_mode][media];
+		if (!link_mode)
+			continue;
+
+		linkmode_set_bit(link_mode, et_mask);
+	}
+}
+
+static void
+bnxt_get_ethtool_speeds(unsigned long fw_mask, enum bnxt_media_type media,
+			u8 sig_mode, unsigned long *et_mask)
+{
+	if (media) {
+		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, et_mask);
+		return;
+	}
+
+	/* list speeds for all media if unknown */
+	for (media = 1; media < __BNXT_MEDIA_END; media++)
+		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, et_mask);
+}
+
+static void bnxt_update_speed(u32 *delta, bool installed_media, u16 *speeds,
+			      u16 speed_msk, const unsigned long *et_mask,
+			      enum ethtool_link_mode_bit_indices mode)
+{
+	bool mode_desired = linkmode_test_bit(mode, et_mask);
+
+	if (!mode)
+		return;
+
+	/* enabled speeds for installed media should override */
+	if (installed_media && mode_desired) {
+		*speeds |= speed_msk;
+		*delta |= speed_msk;
+		return;
+	}
+
+	/* many to one mapping, only allow one change per fw_speed bit */
+	if (!(*delta & speed_msk) && (mode_desired == !(*speeds & speed_msk))) {
+		*speeds ^= speed_msk;
+		*delta |= speed_msk;
+	}
+}
+
+static void bnxt_set_ethtool_speeds(struct bnxt_link_info *link_info,
+				    const unsigned long *et_mask)
+{
+	enum bnxt_media_type media = bnxt_get_media(link_info);
+	u32 delta_pam4 = 0;
+	u32 delta_nrz = 0;
+	int i, m;
+
+	for (i = 1; i < __BNXT_LINK_SPEED_END; i++) {
+		/* accept any legal media from user */
+		for (m = 1; m < __BNXT_MEDIA_END; m++) {
+			bnxt_update_speed(&delta_nrz, m == media,
+					  &link_info->advertising,
+					  bnxt_nrz_speed_masks[i], et_mask,
+					  bnxt_link_modes[i][BNXT_SIG_MODE_NRZ][m]);
+			bnxt_update_speed(&delta_pam4, m == media,
+					  &link_info->advertising_pam4,
+					  bnxt_pam4_speed_masks[i], et_mask,
+					  bnxt_link_modes[i][BNXT_SIG_MODE_PAM4][m]);
+		}
+	}
+}
+
 static void bnxt_fw_to_ethtool_advertised_fec(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
@@ -1864,26 +1912,6 @@ static void bnxt_fw_to_ethtool_advertised_fec(struct bnxt_link_info *link_info,
 				 lk_ksettings->link_modes.advertising);
 }
 
-static void bnxt_fw_to_ethtool_advertised_spds(struct bnxt_link_info *link_info,
-				struct ethtool_link_ksettings *lk_ksettings)
-{
-	u16 fw_speeds = link_info->advertising;
-
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, advertising);
-	fw_speeds = link_info->advertising_pam4;
-	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, advertising);
-}
-
-static void bnxt_fw_to_ethtool_lp_adv(struct bnxt_link_info *link_info,
-				struct ethtool_link_ksettings *lk_ksettings)
-{
-	u16 fw_speeds = link_info->lp_auto_link_speeds;
-
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, lp_advertising);
-	fw_speeds = link_info->lp_auto_pam4_link_speeds;
-	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, lp_advertising);
-}
-
 static void bnxt_fw_to_ethtool_support_fec(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
@@ -1905,16 +1933,6 @@ static void bnxt_fw_to_ethtool_support_fec(struct bnxt_link_info *link_info,
 				 lk_ksettings->link_modes.supported);
 }
 
-static void bnxt_fw_to_ethtool_support_spds(struct bnxt_link_info *link_info,
-				struct ethtool_link_ksettings *lk_ksettings)
-{
-	u16 fw_speeds = link_info->support_speeds;
-
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, supported);
-	fw_speeds = link_info->support_pam4_speeds;
-	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, supported);
-}
-
 u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
 {
 	switch (fw_link_speed) {
@@ -1968,7 +1986,9 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	enum ethtool_link_mode_bit_indices link_mode;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info;
+	enum bnxt_media_type media;
 
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, lp_advertising);
 	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
 	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
 	base->duplex = DUPLEX_UNKNOWN;
@@ -1977,7 +1997,13 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 
 	mutex_lock(&bp->link_lock);
 	bnxt_get_ethtool_modes(link_info, lk_ksettings);
-	bnxt_fw_to_ethtool_support_spds(link_info, lk_ksettings);
+	media = bnxt_get_media(link_info);
+	bnxt_get_ethtool_speeds(link_info->support_speeds,
+				media, BNXT_SIG_MODE_NRZ,
+				lk_ksettings->link_modes.supported);
+	bnxt_get_ethtool_speeds(link_info->support_pam4_speeds,
+				media, BNXT_SIG_MODE_PAM4,
+				lk_ksettings->link_modes.supported);
 	bnxt_fw_to_ethtool_support_fec(link_info, lk_ksettings);
 	link_mode = bnxt_get_link_mode(link_info);
 	if (link_mode != BNXT_LINK_MODE_UNKNOWN)
@@ -1986,13 +2012,24 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 		bnxt_get_default_speeds(lk_ksettings, link_info);
 
 	if (link_info->autoneg) {
-		bnxt_fw_to_ethtool_advertised_spds(link_info, lk_ksettings);
 		bnxt_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 lk_ksettings->link_modes.advertising);
 		base->autoneg = AUTONEG_ENABLE;
-		if (link_info->phy_link_status == BNXT_LINK_LINK)
-			bnxt_fw_to_ethtool_lp_adv(link_info, lk_ksettings);
+		bnxt_get_ethtool_speeds(link_info->advertising,
+					media, BNXT_SIG_MODE_NRZ,
+					lk_ksettings->link_modes.advertising);
+		bnxt_get_ethtool_speeds(link_info->advertising_pam4,
+					media, BNXT_SIG_MODE_PAM4,
+					lk_ksettings->link_modes.advertising);
+		if (link_info->phy_link_status == BNXT_LINK_LINK) {
+			bnxt_get_ethtool_speeds(link_info->lp_auto_link_speeds,
+						media, BNXT_SIG_MODE_NRZ,
+						lk_ksettings->link_modes.lp_advertising);
+			bnxt_get_ethtool_speeds(link_info->lp_auto_pam4_link_speeds,
+						media, BNXT_SIG_MODE_PAM4,
+						lk_ksettings->link_modes.lp_advertising);
+		}
 	} else {
 		base->autoneg = AUTONEG_DISABLE;
 	}
@@ -2156,12 +2193,8 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
 
 	mutex_lock(&bp->link_lock);
 	if (base->autoneg == AUTONEG_ENABLE) {
-		link_info->advertising = 0;
-		link_info->advertising_pam4 = 0;
-		BNXT_ETHTOOL_TO_FW_SPDS(link_info->advertising, lk_ksettings,
-					advertising);
-		BNXT_ETHTOOL_TO_FW_PAM4_SPDS(link_info->advertising_pam4,
-					     lk_ksettings, advertising);
+		bnxt_set_ethtool_speeds(link_info,
+					lk_ksettings->link_modes.advertising);
 		link_info->autoneg |= BNXT_AUTONEG_SPEED;
 		if (!link_info->advertising && !link_info->advertising_pam4) {
 			link_info->advertising = link_info->support_auto_speeds;
-- 
2.30.1


--00000000000026b2a306082c8d29
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBYJ+3RmM+F01Lc/tqkUtV1rgPYOMX2O
rjkVpeWqOmKpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAeAPr2T3N5NGG6U9I4gXGqLpE7WMfOxEfIS/NmsG7Mnzv+0FYz
Q5G0O02kml8KF03YmvPXec86gMmk4T4y2ANL/KN+0VbcyiY1DQYSrEFSvvesuqgU3wkdrQf4skyG
dEuxWGDget2iBOPNkmtst+ka3xVwrmFAIEKMswKiNRtcQEXx/BLaKQ2pYmhNwHTHliMNCesF7ZyZ
YKGwpK8Obu1ecwYulmhxU63meZgkK0dGUQrglsBzYcPt3gVXxBgnUjmzVpCIX/rfCrRSPfW/KIB9
afQ2GuIPuTVRMMJPJCGKZL32V27LvG4zjx0K6b43D+HzFrM2c9QKgvY30TvysrKe
--00000000000026b2a306082c8d29--

