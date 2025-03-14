Return-Path: <netdev+bounces-174813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1EBA60A59
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A580B7A9189
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0221714D7;
	Fri, 14 Mar 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fzl6oKE6"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6813C689;
	Fri, 14 Mar 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938639; cv=none; b=phwQNi2Dl/WkhN91JTrAyVcbCzn8ZxAA47naWNVsst+l9xNoQGu4KYNBAyU4KWGwYM5uJpDui2K1oGzevf7eGxRnRWzQ2P9JLeA13IKnUKIPgGQmaiSf0KikO+8kNaLJSX+0sWzLMnNqJkLwVg38l5hswmrXIT6o/iZFAGLLRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938639; c=relaxed/simple;
	bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KltbTRruzP+gQMnFN32Iokf6ydjfadQjo9LRdNcgeE0r2CeowC98WxCY/2Lq5Q2sL2+QcWr+zE3EvS7Oq1PiHti2Kf8NpNe0vUHIf0nvvKvHp+V/h3hqyW9cbWzCf6GhgfhqGOLVABcGxSeC6qJf5399l5r1i/o2pKjqfYmd9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fzl6oKE6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7oKD012715783, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741938620; bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Fzl6oKE6mbJoxnwhJqdEDlNOoYrSpi9nwhIaiuGJjlzXz8n6MBCoYnw/+qwkAp4yK
	 q+gQqEvUaHTD0Wgkkz4KS4mQD2FBkbMJ6Lz95duH4kmRuYluOILTffQhGlcQXNu2LM
	 Lr2FVq0cj2b5/q9GsebCLkfNBXkGWy7QdBbNmfBA7rB0lhzQA39Mw9QG4wPLcwdH+P
	 y8IMdTbvjAR91IhnMegnanaglU9U3jkgU4muOoQ9BYNDicYZxGeONakY9Q99KDiQUX
	 TgW5h0+r8IYZFRqMNg52DvnaLMTXmK6rb+T9wpYB6Fq22TSYrGD8PiVLenLG1MdbJB
	 /rBX9Lr/XlV+A==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7oKD012715783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 15:50:20 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 14 Mar 2025 15:50:19 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Mar 2025 15:50:19 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:50:19 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
Date: Fri, 14 Mar 2025 15:50:12 +0800
Message-ID: <20250314075013.3391-2-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314075013.3391-1-hau@realtek.com>
References: <20250314075013.3391-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
the platforms that have tested with ASPM enabled.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b18daeeda40d..3c663fca07d3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5398,7 +5398,7 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
-- 
2.43.0


