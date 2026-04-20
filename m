Return-Path: <netdev+bounces-279842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAXxEHtK5mnSuAEAu9opvQ
	(envelope-from <netdev+bounces-279842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:47:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4D42E93B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2B13408761
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35E32E137;
	Mon, 20 Apr 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="KQJX//ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50B32D0CC;
	Mon, 20 Apr 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696972; cv=none; b=Y8skR3CTXbowEkrfClTYA5pNvDjUaCSTq6p3T2epu8enBt0RvJcQg1Yxkgh7b65jPey8Z8GLtBG/0zx0Yp3oj5EFwhwcUj+iZiYtFZSpldf5pbN5+B5/NYk5LKLCjJGittFSpOA8jowWlg/W0F30Nnshf/SePA1VhaNyqgxwUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696972; c=relaxed/simple;
	bh=W3Ademaxen8c5af2e5ytDiNGEPnepJMp1zk69Ol564E=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=SKTG90Sb2FssGEHjCWWDCApYzZtuRE/5w/bA7gE9cx/Kv1Mh12niMNRJPO5uO4MZPO4ak5nzRAOkKAv0XmtF3KotuIcik+3CpK1AhvJrbT4KoDE3Y3ZLd7T1ZnqHTbxlL7uhwH0G8nJX5JqL7LW2FmxooveCAKkG4eoUsTr9th8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=KQJX//ou; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1776696058; h=from:subject:to:date:message-id;
	bh=W3Ademaxen8c5af2e5ytDiNGEPnepJMp1zk69Ol564E=;
	b=KQJX//ouTYPJwVUbewhzHpFEQEjY6gRvu5XJUMBawMfpr9/3qTdo4IGALb593JfeXBxWUhNz+wB
	9PbhIRKg6I6H9O1Sb1VUSJoRzkuDDTybcYiqZgRzsBgGl9xcXxXvQxtAWCLudU5ZJdWm+XhQQOBQQ
	PShU88H8t64dwLFYWhJ40WCrkAQ9a5CbVzYIDuu3MvINdk9IZIOX+en8O8/VbtH8F/9ub7CKl6GbA
	Ur3eEKaTuYr/g00eWQGQ8CCArMSg2Twonky1o8gPPZljGoJjBYpwjd/SKoRfR9Xv8X0MrE2J7ddvx
	KZclQrrcuRcCoouPIIEYzKtb/+0jFQVHgA6w==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 20 Apr
 2026 17:40:57 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Jian Shen <shenjian15@huawei.com>
CC: Agalakov Daniil <ade@amicon.ru>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next] net: hns: use u32 for register offset in RCB TX coalescing
Date: Mon, 20 Apr 2026 17:40:19 +0300
Message-ID: <20260420144047.2846673-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amicon.ru,quarantine];
	R_DKIM_ALLOW(-0.20)[amicon.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-279842-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ade@amicon.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amicon.ru:+];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amicon.ru:email,amicon.ru:dkim,amicon.ru:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 9DB4D42E93B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The local variable reg in hns_rcb_get_tx_coalesced_frames() and
hns_rcb_set_tx_coalesced_frames() holds a register offset passed to
dsaf_read_dev()/dsaf_write_dev(). Register offsets on this hardware
are 32-bit values; using u64 was misleading.

Change the type to u32, consistent with the hardware.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 635b3a95dd82..3c4e4e8ca140 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -563,7 +563,7 @@ u32 hns_rcb_get_rx_coalesced_frames(
 u32 hns_rcb_get_tx_coalesced_frames(
 	struct rcb_common_cb *rcb_common, u32 port_idx)
 {
-	u64 reg;
+	u32 reg;
 
 	reg = RCB_CFG_PKTLINE_REG + (port_idx + HNS_RCB_TX_PKTLINE_OFFSET) * 4;
 	return dsaf_read_dev(rcb_common, reg);
@@ -634,7 +634,7 @@ int hns_rcb_set_tx_coalesced_frames(
 {
 	u32 old_waterline =
 		hns_rcb_get_tx_coalesced_frames(rcb_common, port_idx);
-	u64 reg;
+	u32 reg;
 
 	if (coalesced_frames == old_waterline)
 		return 0;
-- 
2.51.0


