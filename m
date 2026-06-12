Return-Path: <netdev+bounces-298479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4vYpENmuK2pGBwQAu9opvQ
	(envelope-from <netdev+bounces-298479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87873677141
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=cD0ZdmCd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298479-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298479-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE3A33FB11B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F273D5C0B;
	Fri, 12 Jun 2026 06:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E63D16E7
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247522; cv=none; b=Hqlpg6MhqO4ygHEYpoJr6+FafZ+syZamGXZeG1M7ta3GsNIK8dYJzDQBh0Eb1Iins+7MCJPndBCTf5lliZ5+xawrYiIOmpzoB5Hxn9RKQrai+G5ZgdivIP9obOItFTmYiFx3lY6iIFO2LuUsUyApsQu3Y2DbNO4l1u9REfGF08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247522; c=relaxed/simple;
	bh=boNntkksPEPpDSHGCI04pFfe0O4q7/HlftzNbUjuQrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/PpnPzZfuhrLjS+YKggW6gFFkQK1aGXj9yzyqjRhyzCqPI0MZGF9HGuYxdsd8WDXU4tDa5vCfbDHjKzAzDkQVOddz0GJ4v84zARb8zgzK2X9nkcyFd5ETDa1VMrnQGZKC9xVlVqdpWMhIOarkJwCPY3FpgYjFbkF8Ccv4ilb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cD0ZdmCd; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H/
	nliJtWtNwZch0VlpQLVSC0aOaxk5YwhwB8CT+MxTY=; b=cD0ZdmCdNJ8Bya+UVR
	u9E5gl07a1FjWfpVvOhIFuFN7+F472bUOBwOrscojiPqAIqksEP1o+T98BlX6T5A
	eH+DWog7TCaQxX24QYAeeGmmw0OUo7i+F+ohm2qF7FvU/miZTQHSZis2d9XxFzmg
	UQlgHX3yd6nnm6gwHJsSUuolA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3Fh4BritqbAQcBw--.60401S2;
	Fri, 12 Jun 2026 14:58:09 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH net-next] ixgbevf: use vmalloc_array() replace vmalloc()
Date: Fri, 12 Jun 2026 14:58:09 +0800
Message-Id: <20260612065809.164623-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3Fh4BritqbAQcBw--.60401S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy7ZrWxWry3Gw4kXr48Crg_yoWfKFbEkr
	n3Xrn3trW3G3sY9w409w4fJa4j9FsxWa95ZFy7KrWfJ347Ww18Jr4vvrn5Xwsxurs8AF98
	Aw13Ga1xAa4fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREmLv3UUUUU==
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7wIRXmorrgJrbgAA3K
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298479-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:zhulei_szu@163.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87873677141

From: Lei Zhu <zhulei@kylinos.cn>

Replace vmalloc() with the equivalent and more readable
vmallc_array(). This change has no functional impact.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 537a60d5276f..72bdac8c0075 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -322,8 +322,9 @@ static int ixgbevf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (new_rx_count != adapter->rx_ring_count) {
-		rx_ring = vmalloc(array_size(sizeof(*rx_ring),
-					     adapter->num_rx_queues));
+		rx_ring = vmalloc_array(adapter->num_rx_queues,
+					sizeof(*rx_ring));
+
 		if (!rx_ring) {
 			err = -ENOMEM;
 			goto clear_reset;
-- 
2.25.1


