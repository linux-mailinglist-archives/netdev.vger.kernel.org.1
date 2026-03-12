Return-Path: <netdev+bounces-266934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JY0HrJosmlkMQAAu9opvQ
	(envelope-from <netdev+bounces-266934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:18:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A244326E42E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3CC3305324F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5403AE1B1;
	Thu, 12 Mar 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NrNGj9pO"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759A3AD52C;
	Thu, 12 Mar 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299649; cv=none; b=f4BqKJ88Oba40OBkhWEkVhvbNMBoCw7dF+q6Byl7Ejcs00X+lIvmYynmoSku9C36/jeUZ2tv5inY0lb+xCFdd7sEqlmEn6QDfDIbJI6RT4E2/cmdAyluRAKLLmaMS8RtgaEoCpkF2XVrOCOWpuRcJZ9ANrxq29eUT8Wz0pLGlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299649; c=relaxed/simple;
	bh=kAJYmrVEls0YoZt9UzkBYBbNgxbN7kMV09xJ/w6q5+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0E702hYTHrQBiiUjgxesOEG+zfuCU9ca2NWSkPlgjR/WvUQjlLn1GJB0oZLVENzWp2/rsVXJLQoUUluUGwxm2VW0NvgBPaI5yB7hNNUx1DhkF3HmIwZ/mX9Hi2yudTdiZvBb4RSTBEUMokqwzMppaOJEKSZv+wl18JwH612nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NrNGj9pO; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XJSc5762LvYR3kRqzDFmENjhsjllF9/2iRjn3DqfmGQ=;
	b=NrNGj9pOIL57+pNJbuSRPM6KhRTZL/HE6zLNVrMOK6v+17wCzR9bsV6RtQpWFHWfflfFUInVx
	lZ+jPfRZChdztongCaYBQ0BUrNWVJsO6UCsXu1MShbJn3i4ZAys0KmPQ4jKEtctX79NLVOetjDZ
	ZDlCh22VBq7Pgacc6xlX+w4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fWdyR2HTpzRhQX;
	Thu, 12 Mar 2026 15:09:03 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 70C1F4056D;
	Thu, 12 Mar 2026 15:13:58 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Mar 2026 15:13:56 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Mar 2026 15:13:56 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<caixinchen1@huawei.com>
Subject: [PATCH v3 -next 0/2] dpaa2: fix config relation with FSL_DPAA2_SWITCH
Date: Thu, 12 Mar 2026 06:59:05 +0000
Message-ID: <20260312065907.476663-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-266934-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A244326E42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When compile FSL_DPAA2_SWITCH, it needs to set CONFIG_FSL_DPAA2_ETH=y,
otherwise it cannot be compiled.
And as Ioana Ciornei sugggested, FSL_DPAA2_SWITCH included dpaa2-mac.o in
the driver, but it does not select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO.
And FSL_DPAA2_SWITCH depends on FSL_MC_BUS && FSL_MC_DPIO becuase it uses
fsl_mc_driver APIs.

v2->v3
Add depends on FSL_MC_BUS && FSL_MC_DPIO for FSL_DPAA2_SWITCH which also
satisfy FSL_XGMAC_MDIO's OF requirement.

v1->v2
There is no code dependency between the dpaa2-switch driver and the
dpaa2-eth, so use Makefile to control dpaa2-eth instead of using depending
on in Kconfig.
And add select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO for FSL_DPAA2_SWITCH.

Cai Xinchen (2):
  dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
  dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

 drivers/net/ethernet/freescale/Makefile      | 3 +--
 drivers/net/ethernet/freescale/dpaa2/Kconfig | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1


