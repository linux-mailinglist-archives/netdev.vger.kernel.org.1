Return-Path: <netdev+bounces-185861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1783A9BEBA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EDE4A1DD4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209722ACDC;
	Fri, 25 Apr 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="e4QzR/2y"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B980197A76;
	Fri, 25 Apr 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562984; cv=none; b=TSFcjQPqr352juK12SuZWnK1wlAgOii0Idu6deNXNGMhFrwmLZH2bZCu8+jDrincHgg4hOQG7T9YMdl+yq6TEAJ9g5e88CYs28hxquUWe50733b7N6tbuBJK4RfrE9nGGfjmbAtXT0zDjbyJ72hImeoUcaNjdyBD8zsg0U+5dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562984; c=relaxed/simple;
	bh=KwyTNtiZvo/Ja9Uvj/tLMwjGchEpTO819iVwCPQUPzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QT1A5dmoVDoDxmnChlheohho0NZPzjdkrZwB4nf2YT7tP4SSOdlD8K73ydbM0h3hogu+ZoMauaE34AOVL8w/7VWMw1YPJd+6xJH0H/sCmDDmVUSeb+muQlZEMJkX8B9uni3KL+jPLv679wgGbrHyow5rXZYvV/dvJmgqmf5LwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=e4QzR/2y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53P6YbYsA2526006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745562877; bh=KwyTNtiZvo/Ja9Uvj/tLMwjGchEpTO819iVwCPQUPzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=e4QzR/2y3k1FbMi44dDAbvqc2tyAaiuAXiIb84QxIuqBKQ30PLplUEWyKrQjF9x1/
	 6IUSMgP9YK8XL7vFQylW9KgzKzPke5cx0xnT0jO+I1wmEFmpNPdiGfA7sJ0mibYVd2
	 fIBrGrp1dNaucTQ8Qw/pFIpx+XEjwNLR7cjgI6NLrkcWXsMikLBcI38Pns8ydUZk1N
	 +/2Zmbb+HFf7smVCLSbPBW0VV9mrt3WOsIgpjKoTUiVcVXN6vsIGDEQ6hoILtYe+GI
	 /qLzo2OPlIHMnopptZeP7zQKrWE71ZCIS+igzSQsSghD6a8uc1rJh+Jf9OOI/1CBL+
	 uNJi8Vz6hmTWA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53P6YbYsA2526006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:34:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Apr 2025 14:34:37 +0800
Received: from RTDOMAIN (172.21.210.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Apr
 2025 14:34:37 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        Joe Damato
	<jdamato@fastly.com>
Subject: [PATCH net-next v2] rtase: Use min() instead of min_t()
Date: Fri, 25 Apr 2025 14:34:29 +0800
Message-ID: <20250425063429.29742-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Use min() instead of min_t() to avoid the possibility of casting to the
wrong type.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
v1 -> v2:
- Remove the Fixes tag.
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 6251548d50ff..8c902eaeb5ec 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1983,7 +1983,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 	u8 msb, time_count, time_unit;
 	u16 int_miti;
 
-	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+	time_us = min(time_us, RTASE_MITI_MAX_TIME);
 
 	msb = fls(time_us);
 	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
@@ -2005,7 +2005,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
 	u8 msb, pkt_num_count, pkt_num_unit;
 	u16 int_miti;
 
-	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+	pkt_num = min(pkt_num, RTASE_MITI_MAX_PKT_NUM);
 
 	if (pkt_num > 60) {
 		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
-- 
2.34.1


