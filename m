Return-Path: <netdev+bounces-213226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B03B2426B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9392F3B2402
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951932D3ED5;
	Wed, 13 Aug 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PY+gNUSS"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC92D1F45;
	Wed, 13 Aug 2025 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069455; cv=none; b=u/tssT+8vafNIboXa90gZ/nAzOfiR45C0QVYTJH8Pamc1jOXLmBZoTcWxYv+ehFUxJvAeE7kwYDlgRjGHxjZFSpD5HddLWWdS303ukg/j4uUVZbamPpm4yc+v6VgCxW64042IfocMhXjwohiTTsmC6T0mBC+SPpd8f5MH2klHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069455; c=relaxed/simple;
	bh=jWPJiZ72aVkCo2RVQyT5TaPJ5/AEVxto4W7Wfn5PxFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLAI7LKn55XyGwBKS9gs2l0+jLPHPMvfYawoVise9BukspvfERhyDRxcKmA5jKXb/iHVwCB81w1vLQ7UKBXPf8/K672UNCuJ4jE3JQJqzuyhUVIJ82kFcqbw46LFnTi2Vt0l+q+6yOEc58jsLvSnZ2hpYNf62FsU04nBdRqZkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PY+gNUSS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57D7GoAD23929445, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755069411; bh=zpRUruYN6ddGnJbsWMXKQ0Zf4r1+BBPFfhWCX1pewVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=PY+gNUSSggMK/EJQcxxk+wPyuk7/4ade4PLMXRlizha7Qp/92rILbAWJGLn7L70K/
	 47Z6HrrGcx5SvIWNNhpi/YAz8hvgkn0pGJMlKK5ogELxw7YDi5jDpCqYeM8azKrRf4
	 vT8NTpK2f5dsPvIMo+r0mLLQqo+PZBvzp1139hTuTORBREorobjgkEos9j97u9f0+p
	 xDXpHNazUDICkV+fRgV95PBIcLgGIehLU7O7NBE2a/MKgGmZAjiVJJcyEqRDtyHG/4
	 BV/0MVEkuKv85WLMpRaNzCoyeKZLs+FajHmWqgm9gbGNDeboLdiNtpr4DatVE1Z7uN
	 49kY6tdQym2fw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57D7GoAD23929445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 15:16:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 15:16:50 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 13 Aug
 2025 15:16:49 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net] rtase: Fix Rx descriptor CRC error bit definition
Date: Wed, 13 Aug 2025 15:16:31 +0800
Message-ID: <20250813071631.7566-1-justinlai0215@realtek.com>
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

The CRC error bit is located at bit 17 in the Rx descriptor, but the
driver was incorrectly using bit 16. Fix it.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 20decdeb9fdb..b9209eb6ea73 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -241,7 +241,7 @@ union rtase_rx_desc {
 #define RTASE_RX_RES        BIT(20)
 #define RTASE_RX_RUNT       BIT(19)
 #define RTASE_RX_RWT        BIT(18)
-#define RTASE_RX_CRC        BIT(16)
+#define RTASE_RX_CRC        BIT(17)
 #define RTASE_RX_V6F        BIT(31)
 #define RTASE_RX_V4F        BIT(30)
 #define RTASE_RX_UDPT       BIT(29)
-- 
2.34.1


