Return-Path: <netdev+bounces-265546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENhnHq7Frmn2IgIAu9opvQ
	(envelope-from <netdev+bounces-265546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:05:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DE239668
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0A5B30036F4
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57A3AE6EB;
	Mon,  9 Mar 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qoIwvQJr"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB43B8D77;
	Mon,  9 Mar 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061506; cv=none; b=qd1KeBWqvfuA3vnX1iLsugzBVs5bY2BahezPkqAScv0loHIrOI/W6/8S/mf2dW8nsTWX3jn9avadkL6XNYlN7frl4T4Vmdragn/ozaqWD5HPQnBtqdXCj3+IWc+In+EsXiPWrob/VszLC2Ifldfsw2XNqRsp7K/S8wQOpkpcaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061506; c=relaxed/simple;
	bh=3BqK4NbkS4UtLSRjb5O2E8a6AA1I/A8gtoeFUsqYAzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CutekkFYYvNy+Zer8jJYIh61bMgMxsJlTjC9G+u96ZEqgFPydZGM84o6Zxqg00aoJNa785KGEltO0drA0NNXXtufHpYdpYdx+Ah91TC07Ip4QPK66gfTJtYDZbZJ3oYag3a0+fbmWv8WXUBsFYhy8KH5nP251roAP9OrPgsdt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qoIwvQJr; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oO3rBud1F2dgDaGKtGe3yujiTHNv0HSqnCS75d/8fyg=;
	b=qoIwvQJruiFFJxZyf7xiaki+I6UvZShCjNDPZWgGxxrWiF16fiwqFCmPsr36g89ZNqPBhDWQq
	+VEMu0s+H1xj0ckMGdxgTyBSB8JJSLZvPzfRkFtWbf+Pj+zf891YPi4XbEktsaLf0pyfnENI5Uk
	ZBpMZ6VcHnKWUPBdwHxz5RI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fTxtb4VbdzpT0w;
	Mon,  9 Mar 2026 20:59:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 046F240561;
	Mon,  9 Mar 2026 21:05:00 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 21:04:59 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 21:04:59 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<caixinchen1@huawei.com>
Subject: [PATCH v2 -next 0/2] dpaa2: fix config relation with FSL_DPAA2_SWITCH
Date: Mon, 9 Mar 2026 12:50:16 +0000
Message-ID: <20260309125018.420275-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Queue-Id: E45DE239668
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

When compile FSL_DPAA2_SWITCH, it needs to set CONFIG_FSL_DPAA2_ETH=y,
otherwise it cannot be compiled.
And as Ioana Ciornei sugggested, FSL_DPAA2_SWITCH included dpaa2-mac.o in
the driver, but it does not select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO

v1->v2
There is no code dependency between the dpaa2-switch driver and the
dpaa2-eth, so use Makefile to control dpaa2-eth instead of using depending
on in Kconfig.
And add select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO for FSL_DPAA2_SWITCH.

Cai Xinchen (2):
  dpaa2: add select config for FSL_DPAA2_SWITCH
  dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

 drivers/net/ethernet/freescale/Makefile      | 3 +--
 drivers/net/ethernet/freescale/dpaa2/Kconfig | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1


