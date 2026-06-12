Return-Path: <netdev+bounces-298510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7vSYCzK+K2q1EAQAu9opvQ
	(envelope-from <netdev+bounces-298510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:07:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CB677A3A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=BcVTPhiT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298510-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA0F4305739D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF593624CE;
	Fri, 12 Jun 2026 08:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E9368D40
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251448; cv=none; b=f4whv/2iblbRYcqDCa+NIjbEepIyUeauIyIVshag6ijSfCNe6kVj31CGHDx1ZGIjdP8syQrJBz+Fq7wRwAiOaLtriHO8QcY+k7QWhoosBoV2ogJnQSMS98Q+1KIoDsow7bIAQJ/fHJmBROzdIHXGGrhCfRMAdpQiCY63IRLPi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251448; c=relaxed/simple;
	bh=GX8390Tjt4aOpJ1YnfyhcmpOTXOvaxIZR204iXH2zYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ckXEEmUhiz3AGyXyr7qAOPO2wIXhcPxWZakdOED+Imi3Ep/wOtOzJI/4ZgFqyP4G9rgw6KxGT3D52/uPz++EC9FaDt3ImOh2pN1NaKoRV7M6C5ApymeNM2Av6SJrUGpps8EgyG7BRGwKt5aX12B9sEYg/lj5Kl2uyR2yMIFX6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BcVTPhiT; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Za
	Pg6v6b9//PiUwAnb+zRa25onPj2hKjdQbrL0q7VG0=; b=BcVTPhiTH0cS+S4z17
	CapnFI0j3x8Fw82FkRyWm/ois1Sev3nVsmafnq8t3KZv4BhEsCpKNpl00btSJgBh
	WpHpXaWYrjQVcIAgWZM3fOwLHd1MmGrhZp4NLfk9jko53Dv+8BCQaHay+GJ8AfyL
	eMTVyknqpzhWVy4zng2viGgkU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA32r1VvStq4Np5DA--.798S2;
	Fri, 12 Jun 2026 16:03:34 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net-next v1] e1000: Initialize phy_data to avoid unexpected values
Date: Fri, 12 Jun 2026 16:03:31 +0800
Message-Id: <20260612080331.120096-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA32r1VvStq4Np5DA--.798S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kJrW8XF1DAFW5KFWxWFg_yoWkWFg_Gr
	1Iqw1xAr15J3ZY9a1jvr4UZ34Igan0grWxCFWxt3s5X3yUWr4DJF4DWF18XF9xKrnxWFy7
	J343ta47A34jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8hjjDUUUUU==
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hbpVWorvVZMdQAA3b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-298510-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail,kylinos.cn:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clementwei90@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[kylinos.cn:query timed out,vger.kernel.org:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E86CB677A3A

From: Rongguang Wei <weirongguang@kylinos.cn>

The phy_data variable is not initialized. If e1000_read_phy_reg
returns an error, phy_data will not point to a valid value from
the PHY register, which may cause the regs_buff array to be populated
with unexpected values.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Change-Id: I46071b3b21a566f8da650168d38d6968251b077d
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 4dcbeabb3ad2..f068108c5004 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 *regs_buff = p;
-	u16 phy_data;
+	u16 phy_data = 0;
 
 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
 
-- 
2.25.1


