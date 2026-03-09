Return-Path: <netdev+bounces-265417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNQ0JCyNrmnlFwIAu9opvQ
	(envelope-from <netdev+bounces-265417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:04:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EF235DAA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B18D30440BA
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F5374176;
	Mon,  9 Mar 2026 09:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FD374194;
	Mon,  9 Mar 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046987; cv=none; b=XAZNXjCBQAOuozKWXBClivahB5lNDaMcfpYCpPbWocAxtYDn1JryNnK47x25x8Bu77NGdTIeYRg6PBml2AWP/5o9zf0rtKQhuYrpj46Yz3DHCy4/7r0SzsuoFjoHYkgH/Jy8Udh4ft2tXVXM0da68OhePtKQenlMv7qaQdP1/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046987; c=relaxed/simple;
	bh=pBdLTrtwUzVYFA9w1OGA6k2+fdXxmfG+7rq34JocsuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OivxL9xORSKqXsm14URR5abhQ5Jhe4A9QSGsgpGUmhHKMUD5RZ3n2w755XvnVulWXXXKjW0ZXJMJHSfZfSUPA2ujWtVazD5jIalvec6ZsQnmmAfrkOH0C2KKWgB8PyHT2HqXBMGXt5cRzj0AN3u3OLWjVxKPgUat+53G7Oe0Tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACnOQ2wjK5pE7jxCQ--.45897S2;
	Mon, 09 Mar 2026 17:02:41 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: rafal@milecki.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] net: bgmac: scope bgmac_enet_suspend() and bgmac_enet_resume() to CONFIG_PM
Date: Mon,  9 Mar 2026 09:02:38 +0000
Message-Id: <20260309090238.719428-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnOQ2wjK5pE7jxCQ--.45897S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfCFWDWrWUKw45trW7CFg_yoW8Zw1Up3
	yUJrWUCw48Jr1jga18JFW8CF15twn3t34DWa43J3yrZ3Z8tw17JF48Ka1fXrsYyrW8Gr4a
	yF1jy3s3ua98GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe2-eDUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: E86EF235DAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265417-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.626];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isrc.iscas.ac.cn:mid]
X-Rspamd-Action: no action

In current linux.git (1954c4f01220), bgmac_enet_suspend() and
bgmac_enet_resume() are defined and declared unconditionally. However,
their only in-tree callers are within the platform driver's PM callbacks
in bgmac-platform.c, which are already guarded by #ifdef CONFIG_PM.

Match the helper scope to their callers by wrapping the definitions in
CONFIG_PM and providing no-op stubs in the header. This fixes the
config-scope mismatch and avoids unnecessary code inclusion when
power management is disabled.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@
 EXPORT_SYMBOL_GPL(bgmac_enet_remove);
 
+#ifdef CONFIG_PM
 int bgmac_enet_suspend(struct bgmac *bgmac)
 {
 	if (!netif_running(bgmac->net_dev))
 		return 0;
@@
 }
 EXPORT_SYMBOL_GPL(bgmac_enet_suspend);
 
 int bgmac_enet_resume(struct bgmac *bgmac)
 {
 	int rc;
@@
 }
 EXPORT_SYMBOL_GPL(bgmac_enet_resume);
+#endif
diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@
 struct bgmac *bgmac_alloc(struct device *dev);
 int bgmac_enet_probe(struct bgmac *bgmac);
 void bgmac_enet_remove(struct bgmac *bgmac);
 void bgmac_adjust_link(struct net_device *net_dev);
 int bgmac_phy_connect_direct(struct bgmac *bgmac);
+#ifdef CONFIG_PM
 int bgmac_enet_suspend(struct bgmac *bgmac);
 int bgmac_enet_resume(struct bgmac *bgmac);
+#else
+static inline int bgmac_enet_suspend(struct bgmac *bgmac)
+{
+	return 0;
+}
+
+static inline int bgmac_enet_resume(struct bgmac *bgmac)
+{
+	return 0;
+}
+#endif
 
 struct mii_bus *bcma_mdio_mii_register(struct bgmac *bgmac);
 void bcma_mdio_mii_unregister(struct mii_bus *mii_bus);


