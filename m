Return-Path: <netdev+bounces-292016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E6zKVM+FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F15DE03C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6DE3013783
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71B27A10F;
	Wed, 27 May 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="jg7TUHV/"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241E138490;
	Wed, 27 May 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842640; cv=none; b=ShUIsFGrpCA1YPCh2KhQ99ScrOnCR2pZ5li9AhmReo64VuTChhOiA5FVTkO4eXKKyUM2wP2btaK1yPbKxzmdH4TwYMiq2WaS7K8AsmlTuIRg9XmYiyBtxnD6vcev9Br5IuVVwRtVIR9d8Kc3sd5lCK3EP0IDX6PKTIBL3ISoMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842640; c=relaxed/simple;
	bh=MANeQf5DBO8B+EXC4leH/ZAgEWQCLlOkfi/NH2cGCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFCM9Q1UddTCPE4VgV9YAyKdnnO10LqpMySYz5SivVwOZOw1Y3Hn04ySZE23tSIzxPpeZMFSrpVAm4ZB9Mm7IIJRFblAFhTnF3d4fapdUT0v9p9r2OnfnLHXhrzKfHljlT85G7n/QAiTNvTDkHVIyHZK7rNDS5VPJ3iO79WZ9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=jg7TUHV/; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tG030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:40 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tG030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842623; bh=+i36R5hVHV+32TxapqFpzJUVlOFyTq91TNYJLB6bwO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jg7TUHV/Ojcx4zr3S+1Rs4Aa1tLbmENu3AosxCzxVwvjbZv/PKbJVk73EjRGdpJdf
	 5Ary65ZtUy2JgPb0Q9wwTcmsocwt6tXMg3acehQn/yTtvSkYZWQHBkfyb6d8wVwrS+
	 NIkS8QUfLV5UDNor8prWXjkW3j2yzhnGrVhq8upe3ZBIiwchdvdtRkXdftpgcgx7e9
	 yNfmh5I6r6Cw5U8Do/1iQENHQe6kKnfMmZ79RrNMnm5iMIgOSogerJcc/OrsopELVo
	 zSmoOlTAg8yrj3D6vN6p/D1kPO0AhvQ/B1T7jlA1trwFq/ssTbSyeFgs3DRe6Td7Jl
	 jtCSuTxLGD31Q==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: dsa: mv88e6xxx: add MV88E6XXX_G1_ATU_CTL_MAC_AVB setter
Date: Wed, 27 May 2026 10:42:49 +1000
Message-ID: <7a9989858354f04bf918f4050c8f9a654998031f.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779841530.git.lukeh@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[padl.com,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292016-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F4F15DE03C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add accessors for the MACAVB bit, which controls whether certain ATU bits
cause the entry to be interpreted as AVB or NRL (non-rate-limiting)
entries. This is necessary on switches such as the 88E6352 and 88E6240
that support both AVB and NRL ATU entries.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/global1.h     |  2 ++
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..8204321502c1f 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -111,6 +111,7 @@
 
 /* Offset 0x0A: ATU Control Register */
 #define MV88E6XXX_G1_ATU_CTL		0x0a
+#define MV88E6XXX_G1_ATU_CTL_MAC_AVB	0x8000
 #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
 #define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003
 
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


