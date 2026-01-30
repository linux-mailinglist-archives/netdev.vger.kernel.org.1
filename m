Return-Path: <netdev+bounces-255155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cESJHOm7fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:10:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312DBB771
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031EB300B3C8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB2131A069;
	Fri, 30 Jan 2026 14:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0127AC31
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782246; cv=none; b=Jrlf4xw3B/mDL5aCbYYZ7DdLoxzVzlROBQfM/htlPls2Jzp/nAfrs/5m0gtnSMnSpfZU2kiCbgNRmKCWxjUq63CTmaDsP1ZvPqLU4mNEE+fkmSJBrs1TP0Ja9YRsBD2luCV7R2QDwXb3m4pglZP6VeA3r+2rxyardSr7z+cZcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782246; c=relaxed/simple;
	bh=0W27QFew4CaxE2Y8p24O0EQN+GgOlw15dThWBwgPflA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NSGn7Ap4+8a2RlOCuphUVM2aA8vFvizBuwhuh9sknDaKwlCISW5BRR2gLUOiMwyo7kLf84oHvwSRYK13v6/STYXs5BUlXarDISufd1uRcmPObm4WomUitVZQojgghFWP1QoLNLUffSvVUDUT+ymDpirqZC91cRMIa6QKcFs6nqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D9A71A071F;
	Fri, 30 Jan 2026 15:10:38 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 919641A071E;
	Fri, 30 Jan 2026 15:10:38 +0100 (CET)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 34473203AA;
	Fri, 30 Jan 2026 15:10:37 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 0/4] ENETC v4 hardware integration fixes
Date: Fri, 30 Jan 2026 16:10:31 +0200
Message-Id: <20260130141035.272471-1-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255155-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid]
X-Rspamd-Queue-Id: 1312DBB771
X-Rspamd-Action: no action

ENETC v4 targeted fixes addressing SoC level integration issues
regarding AXI settings and register access width.

Claudiu Manoil (4):
  net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
  net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
  net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
  net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4

 drivers/net/ethernet/freescale/enetc/enetc.c    | 11 +++++++----
 .../net/ethernet/freescale/enetc/enetc4_pf.c    |  6 +++---
 .../net/ethernet/freescale/enetc/enetc_cbdr.c   |  4 ----
 drivers/net/ethernet/freescale/enetc/enetc_hw.h | 17 ++++++++++++++---
 4 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.34.1


