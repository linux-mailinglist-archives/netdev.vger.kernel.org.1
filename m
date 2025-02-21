Return-Path: <netdev+bounces-168400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA993A3ED34
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EB118913CC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8851FECD1;
	Fri, 21 Feb 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ef1DVhpa"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B41FE443;
	Fri, 21 Feb 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122364; cv=none; b=P/f1H04coL5mI9IMyDPFpz5VHiluq8lRoTIj+BtjLT4ebR4L95ZlUxur6EkgG7+2AkWSzBquRyBdcvX/5KIjLFdeZCyKxEXDYSG9PPAT1CCj60PUvAZPw2HtomfWSd+juvIr55gM3Za+EdgDEtIdVCTX2nT5vYN88UNqV/ULfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122364; c=relaxed/simple;
	bh=PztQzWtJ2SLBJTPpC8NuKA2Zrl1gqV/FzrKY5msalnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYq357aBIgyC7yqTYoRT0cVhrQEzRLmZ5t7+3mWq8+Ezab90S5hdhOxGMx2qqhhKYkHIE51gAu9hK7PY3KpBVYSFAXtU5NvIhqesvSqM3CPoB0MnMrtnM9TW3hP5QNW7ZeBInVKkTT9GCysLzvwA1RsBGr/7CLiGVYgWXWQZGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ef1DVhpa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L7IejyE1489827, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740122320; bh=PztQzWtJ2SLBJTPpC8NuKA2Zrl1gqV/FzrKY5msalnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ef1DVhpa+tzCWpLe6Qteda0fhx5lzXJtxOz9KNvsASnvwVMKfNGxnrogW/9J91Xer
	 XWO6mK8HS7thRvpkLttFJXAj/5xlY2D5izQJrPEuATNWzeZqhdyh28XJknkk9Dy2p4
	 WHkpQJHTSvuOA64DYcjs8A2AMX12qCoaAkmAixsTgF+l2qdW/86Wfl8ginke1+tqKu
	 YwbmeYCWgr7aPYfg/NcQrEhSltSJBekzpeX0wL1fFLIn/QKrm5XsQej2BwQ8ACgTPi
	 /Dofu6jDCCy1/t+IE+3130XD1a9xP0U0cswIGOb6pRJzhJhoU3Hq0IoSVcHvpSO8aQ
	 5MtvhWftKeeZA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L7IejyE1489827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:18:40 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 15:18:40 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Feb 2025 15:18:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 15:18:37 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 1/3] r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
Date: Fri, 21 Feb 2025 15:18:26 +0800
Message-ID: <20250221071828.12323-440-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221071828.12323-439-nic_swsd@realtek.com>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
the platforms that have tested with ASPM enabled.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fa339bd8c775..731302361989 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5394,7 +5394,7 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
-- 
2.43.0


