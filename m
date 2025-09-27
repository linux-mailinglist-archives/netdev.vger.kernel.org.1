Return-Path: <netdev+bounces-226853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F5BA5A6D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EED53202C9
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E02D2483;
	Sat, 27 Sep 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="oQ5Z0JXc"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750422D24B8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959360; cv=none; b=Z2Ju92ZpYiW8aXH+YMVOkO8Y35quoF0ex8cnfF+Ukdfv0LW/7wLvTM9MDiJDxbltJSA3ZNksRz5s+8ltVM6HvNhyiBF+p9Ab36PHoDejJm72oTvINoPHdBJxy3wtzKtTAZt0hKlTiK/CLD/3FCMHynrDYP0r4AY4fmdPzO2BBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959360; c=relaxed/simple;
	bh=r/RKy1liWLMlrvDiduqUPVA9PZ8bfzJImvA7GnpU6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4Nev3Ox+CpzI44ZAg5Q3K3/3rFa8UCqBeBLisFxo5Jill83qNNA26AipCLV99gfy4iLqelGVdhf2p5IohmxND5zKofH6PRsppu52O79aeWIjVy0IhHmjA+J9u/M1YRal9jx9+2346IOXYe6giRho5J5cfGu6+tEMhFnbDuQnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=oQ5Z0JXc; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w8A026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:15 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w8A026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956897; bh=89gE+o5dhkce669wmF0Yqu/gqVCnuNv8vKdWcuDzAZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQ5Z0JXcre8DApNk9qwF5YGg3z+LHC+a6sjrnlwTwlDjaYaYHfg8Z/PxqkS9pGmEr
	 3MB+Tzm/+EFmtlZKIVsfYE6Y0q5saBmAJJWoePvLxcVgz7XunW+4jqnz/5FO+OYyyG
	 U/CemsBTS4usl/igivhSHUqSlLUiwEOvryOF9vV7ATyAykFVhRVF0o+eodn9QlOS4j
	 gj+/BNs3hTvK1mmsreoZW7FjCceVjCL/yGzi092KcQgEOwUFfByafDoK4fpBdNs6fr
	 dG7FxEOwHf8vMExHoiW8QoEFP4w2kL2U8rhTFNRqbA4a7185rNKZ+n4e43EqiFmr0f
	 J6rHQubKkJvig==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 2/5] net: dsa: mv88e6xxx: add MV88E6XXX_G1_ATU_CTL_MAC_AVB setter
Date: Sat, 27 Sep 2025 17:07:05 +1000
Message-ID: <20250927070724.734933-3-lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927070724.734933-1-lukeh@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add accessors for the MACAVB bit, which controls whether certain ATU bits cause
the entry to be interpreted as AVB or NRL (non-rate-limiting) entries. This is
necessary on switches such as the 88E6352 and 88E6240 that support both AVB and
NRL ATU entries.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/global1.h     |  2 ++
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..74be4c485ab10 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -112,6 +112,7 @@
 /* Offset 0x0A: ATU Control Register */
 #define MV88E6XXX_G1_ATU_CTL		0x0a
 #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
+#define MV88E6XXX_G1_ATU_CTL_MAC_AVB	0x8000
 #define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003
 
 /* Offset 0x0B: ATU Operation Register */
@@ -322,6 +323,7 @@ int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index);
 
 int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all);
+int mv88e6xxx_g1_atu_set_mac_avb(struct mv88e6xxx_chip *chip, bool mac_avb);
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs);
 int mv88e6xxx_g1_atu_getnext(struct mv88e6xxx_chip *chip, u16 fid,
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index c47f068f56b32..429a1ee44e47d 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -41,6 +41,23 @@ int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all)
 	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_CTL, val);
 }
 
+int mv88e6xxx_g1_atu_set_mac_avb(struct mv88e6xxx_chip *chip, bool mac_avb)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_CTL, &val);
+	if (err)
+		return err;
+
+	if (mac_avb)
+		val |= MV88E6XXX_G1_ATU_CTL_MAC_AVB;
+	else
+		val &= ~MV88E6XXX_G1_ATU_CTL_MAC_AVB;
+
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_CTL, val);
+}
+
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs)
 {
-- 
2.43.0


