Return-Path: <netdev+bounces-156045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8AA04BDF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092F23A56A6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236481E04B8;
	Tue,  7 Jan 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VBChtz52"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8C1F669F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286130; cv=none; b=D3J9TNlRfus3WaEk3IR2/U6Aw8hF5eKBd9fwhFL1XZ1EsOtdw9069cS8ZfoT959u8RW9JnXwHFIxrhRP+P3BQ7FkZO30wv8bjTtNUA7EElRCL2XJU0+OQo66nDzBWkLD/oe8qbsEoD6w0sf7ShEmOmw8N8R+ZfPm0MnMW4Z9/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286130; c=relaxed/simple;
	bh=iUoY58RIZOVQIqAdegml532MWvAllJjGVn9/uqyXzIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2nBTBqcmAUdFAlgMch2X43LvAggCRUlOV07Yy7DgGp/nwZc3yf6zSP3Lik2htHDUOWawhkKscj6RKDfVAOKutQh5Ao7rSCkpHab0FAX/ItBcXgm6cHaiM6OCqBrpnm2P/JN5FiaB00e3k6E7Ddi7WXFgWlreybNSOMdeZSM7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=VBChtz52; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1327; q=dns/txt; s=iport;
  t=1736286128; x=1737495728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMtPWGchlyzSh7QvtH9Gz7IG8sSoEu3RpF2lBteCrX4=;
  b=VBChtz52OUfpzihVuwunGRQUVL5v5i7hZevESRXxJSvU05H8uItJBfMW
   R0PfQdW3vswiY/WqgCzkcJ0wgPeWF4ZupvbP6GrwweN0LxFa/EdHHntLN
   oR+nX2oNMrKsA1eZ+zpETnh34UMH4qIrn9JsBRjaAQWQQVtGSLLgGnHv5
   k=;
X-CSE-ConnectionGUID: Fg90ojD6QYuLsE5NYHjrdg==
X-CSE-MsgGUID: /3/rTzHRQC+9cY9d6q1bOA==
X-IPAS-Result: =?us-ascii?q?A0CDAACVnn1n/4oQJK1aHQEBAQEJARIBBQUBggEGAQsBg?=
 =?us-ascii?q?kqBT0NIjVGnDYElA1YPAQEBD0QEAQGFBwKKdAImNgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAgEDMgFGEFErKwcSgwGCZQOxQ?=
 =?us-ascii?q?oIsgQHeM4FtgUgBhWqHX3CEdycbgUlEglCBPm+ECoEGhXcEh2meCUiBIQNZL?=
 =?us-ascii?q?AFVEw0KCwcFgTk6AyILCwwLFBwVAhUeARIGEQRuRDeCRmlLNwINAjWCHiRYg?=
 =?us-ascii?q?iuEXIRHhFiCS1WCSIIXfIEdgxZAAwsYDUgRLDcGDhsGPm4HmnU8g2+BDnynN?=
 =?us-ascii?q?KEDhCWBY59jGjOqU5h8IqQlhGaBbgUwgVkzGggbFYMiUhkPji0WuSclMjwCB?=
 =?us-ascii?q?wsBAQMJj1iBfQEB?=
IronPort-Data: A9a23:nz476qiXBbgb8/ctkZJGPShqX161QxEKZh0ujC45NGQN5FlHY01je
 htvCGqOa/ncMWX2Lo92bo+w8R8BusPUxtcyS1A6pX8wQyljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD9Msvrc8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU29bcvBmNiq
 8UpNRQWQ02ltsK02r60H7wEasQLdKEHPasWvnVmiDWcBvE8TNWbGuPB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQUaj/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJIIDWG50Fzx7wS
 mTuuD++GC0IFOam4nnU+UP9irHWxCnccddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhCE6g7NWiYsA0L+2uAiexTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxaoowFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:57rYEavWoTr4tt/ibOSGMtYM7skDcdV00zEX/kB9WHVpmwKj+P
 xG+85rsiMc5wxxZJhNo7290ey7MBHhHP1OkO0s1MmZPDUO0VHAROoJ0WKh+UyEJ8SUzIBgPM
 lbH5SWcOeAbmSTSa3BkXCF+xFK+qjgzJyV
X-Talos-CUID: 9a23:EzMwDG1urXytoR+2a2nzsLxfNM90Knrf4CnpElKcEks0boy1S0Wc9/Yx
X-Talos-MUID: 9a23:6RYvRATW/v9J9kFHRXSr33Z4CNVI2Z2FSxEGoMQK5dDdPwtZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="424460890"
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 21:42:05 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-01.cisco.com (Postfix) with ESMTP id 6666C1800019A;
	Tue,  7 Jan 2025 21:42:05 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 3EC8B20F2006; Tue,  7 Jan 2025 13:42:05 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 3/3] enic: Fix typo in comment in table indexed by link speed
Date: Tue,  7 Jan 2025 13:41:59 -0800
Message-Id: <20250107214159.18807-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107214159.18807-1-johndale@cisco.com>
References: <20250107214159.18807-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

The RX adaptive interrupt moderation table is indexed by link speed
range, where the last row of the table is the catch-all for all link
speeds greater than 10Gbps. The comment said 10 - 40Gbps, but since
there are now adapters with link speeds than 40Gbps, the comment is now
wrong and should indicate it applies to all speeds greater than 10Gbps.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 8109e9c484f6..49f6cab01ed5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
 static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{0,  0}, /* 0  - 4  Gbps */
 	{0,  3}, /* 4  - 10 Gbps */
-	{3,  6}, /* 10 - 40 Gbps */
+	{3,  6}, /* 10+ Gbps */
 };
 
 static void enic_init_affinity_hint(struct enic *enic)
-- 
2.35.2


