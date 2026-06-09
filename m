Return-Path: <netdev+bounces-297127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U25FDoI9KGplAwMAu9opvQ
	(envelope-from <netdev+bounces-297127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DED6624CA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="FOc/sQJR";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297127-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40C130EB31C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7748BD52;
	Tue,  9 Jun 2026 15:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4492421F0D;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018889; cv=none; b=fBSihGzlUJxy8PWn5Hiwl4GEqK2MycWsgZwtX9cnU86rRM3oXc7ZwJ2mkKV+FLFOC/csDdc0TRUOa2iZTUNVwwTPTsj0FBCY5emFB5CoZ7ipOcw5oaeNIWozPsDbNi2NgMIySmqFLRi1ldFFAVn290kkSoZIbhw1CYMiYJHPEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018889; c=relaxed/simple;
	bh=FiKRCMy7nRNDSSCXUQkrQkas/Owj/jenoKfYpyZZa/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoRdzzqOH/2+8ylD2nclBx+Gb1kHrbTP2OHginY4Z7MB5u5e9/p8Udku/hDII2mkwNjYRlC4hbWF3piICB8X3lwmDJYzYmKitqrNOuSqdzVjeSkEB83ASoSze8mNvWo9/PoqGOCamtCWtdJTng8Ki1OixWenas/FwxHyH9mWzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOc/sQJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A07D6C4AF11;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=FiKRCMy7nRNDSSCXUQkrQkas/Owj/jenoKfYpyZZa/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FOc/sQJRcy9WZtRP5wDcctu31TuisHBntJOWXQ+Xk4b1pDDQu0ghR/yw9jNF8AbKj
	 SBLzlDzyK8Ai3nPe8PFAKOrfMS8n9ejU04gMQM+x0HgY0JK575YtlKHptWuGdPwFu2
	 qeR1FETuA2+ya10bGN4HuUmCAGwQWdexCG9V7Ifwkz2lGv/KCnPET+OVQEBS3Nz+Qt
	 ArBB1Vm6f89BxlFxglNbWouIScdSKNz9BeW12etAz+1hzUDvriMnpS6zUfg8VSIk8K
	 cAkf9SOhOsQsI7z4aXq+1AOMUj1PPeKn7POEXvhbYHM0FnxylwMy2BDCWf3woVgAx/
	 ia1l/a8gfkIzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819CCD98C6;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:06 +0300
Subject: [PATCH net-next v4 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-7-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=4103;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=dVadBcbUmfh+DDH1tHXXzeNT96VpgE0AeeH0K1v9cWM=;
 b=7Pyk/2jhpqw3yGe0i/28KLThXyEXaYQfRSlWhbL1vlcTP5a5oz6nN4/wKzfqs8TLdaDgFQdyP
 rNAv8E0UiU2CFDzc9zm6NEwAaKyRUoC5nWAUXJsguCAHh9Z3j9j/oOq
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297127-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53DED6624CA

From: Ciprian Regus <ciprian.regus@analog.com>

The Open Alliance TC6 standard defines multiple memory maps for the
MAC-PHY's register space. These are used to separate standard, vendor
and PHY MMD specific registers. Define register access functions that
allow the caller to specify the MMS.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v4 changelog:
 - changed the address parameter type to u16 from u32.
 - reworded the kdoc header for the new {read,write}_register_mms
   functions to better explain their use case.
v3 changelog:
 - replace the OA_TC6_MMS_REG() macro with the register access functions
   that allow passing an mms parameter.
v2 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/oa_tc6.h        |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 92da5bb74cc7..d32a1a323d48 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -61,6 +61,8 @@
 #define STATUS0_RESETC_POLL_DELAY		1000
 #define STATUS0_RESETC_POLL_TIMEOUT		1000000
 
+#define OA_TC6_REG_MMS_MASK		GENMASK(19, 16)
+
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
 	struct device *dev;
@@ -344,6 +346,27 @@ int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_read_register);
 
+/**
+ * oa_tc6_read_register_mms - function for reading a MAC-PHY register in a
+ * specified memory map.
+ * @tc6: oa_tc6 struct.
+ * @mms: Memory map selector for the register.
+ * @address: register address of the MAC-PHY to be read.
+ * @value: value read from the @address register address of the MAC-PHY.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int oa_tc6_read_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
+			     u32 *value)
+{
+	u32 mms_reg;
+
+	mms_reg = FIELD_PREP(OA_TC6_REG_MMS_MASK, mms) | address;
+
+	return oa_tc6_read_registers(tc6, mms_reg, value, 1);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_read_register_mms);
+
 /**
  * oa_tc6_write_registers - function for writing multiple consecutive registers.
  * @tc6: oa_tc6 struct.
@@ -388,6 +411,27 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 
+/**
+ * oa_tc6_write_register_mms - function for writing a MAC-PHY register in a
+ * specified memory map.
+ * @tc6: oa_tc6 struct.
+ * @mms: Memory map selector for the register.
+ * @address: register address of the MAC-PHY to be written.
+ * @value: value to be written in the @address register address of the MAC-PHY.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
+			      u32 value)
+{
+	u32 mms_reg;
+
+	mms_reg = FIELD_PREP(OA_TC6_REG_MMS_MASK, mms) | address;
+
+	return oa_tc6_write_registers(tc6, mms_reg, &value, 1);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_write_register_mms);
+
 static int oa_tc6_check_phy_reg_direct_access_capability(struct oa_tc6 *tc6)
 {
 	u32 regval;
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index bd369aac9c3b..cace67cfc709 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -72,9 +72,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 			   struct oa_tc6_quirks *quirks);
 void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
+int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
+			      u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			   u8 length);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value);
+int oa_tc6_read_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
+			     u32 *value);
 int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);

-- 
2.43.0



