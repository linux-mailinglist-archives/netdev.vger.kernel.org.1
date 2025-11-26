Return-Path: <netdev+bounces-241781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370CC88316
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F923B3EAA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F824A046;
	Wed, 26 Nov 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="vNeaCok7"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915743595D;
	Wed, 26 Nov 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136832; cv=none; b=gXIQr4riHWB0RHEeJwfQJ1CMFL44u8f2lp8x6+/8rq9NoD6v9OQTWIc4O81zuuwIbjwWw+s2ToIGcZcCP8l6/O7zBs/424G6HHlKNNmzWGlrzTrWrpRg9FVFgY3qZxnmP/Stz360K9kxGuAfazgzjBrOBa6RmIRcvX+CO65wy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136832; c=relaxed/simple;
	bh=frpd4jST4Cgi/Keop8SCmlUAiS3ScvovHYwk8fM1nFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BBWtpXwomHCtjM257O+o9RiP9wmOsIrnLLmQOIsWEDxPJ+uw2B++TL83i/wDaxMp+UctBAIPb52O70RPGF31hiiuOtukyMaYGs/1j9tBwSGoeyCNaiMepSDaSRrONY3Khnv30N4VkvGI6ZtH91+C6XEEHLTifUD2MYlhoVO8h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vNeaCok7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ5xqAM3313632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1764136793;
	bh=LWAQ3WuLZP4sZDRYNHk0cM7mYP8Sy8PO2GCdwhy6juI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vNeaCok7hxbuzsYXtElpoW4sm6KM+Mm19Czkg3X2N08uNpp/Qc7mCLgZTTcRV6DWm
	 UNeB+ZkpPBhnkbxVa1P8zruZwAiu+VeSZ5zkuuikPtslgpqdbHp6tpj9mg4xOQhSPi
	 a4k/2Ig2FAv2fzxfOTc5HRZBXjtlrqWigegCnXH0NUjmtgQjmtM5uJ7DMBbykgSy+/
	 Q3aTbJEWJHXtiG7vEpdV/64dklLv/1e7D2jdVVQUrOLDPXfueAPazm4l65qG5kXgVs
	 AWAQyFk4VWLUN734K/v6YFma2+sCa8wjo0GeS+O6HMFSxer72NqPcZPmfIbHXaDdwn
	 8ke7bbx8eoyWg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ5xqAM3313632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 13:59:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 26 Nov 2025 13:59:52 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 26 Nov 2025 13:59:52 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1] r8169: add DASH support for RTL8127AP
Date: Wed, 26 Nov 2025 13:59:50 +0800
Message-ID: <20251126055950.2050-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This adds DASH support for chip RTL8127AP. Its mac version is
RTL_GIGA_MAC_VER_80. DASH is a standard for remote management of network
device, allowing out-of-band control.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3f5ffaa55c85..68e84462216c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1512,6 +1512,7 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_52:
 		return RTL_DASH_EP;
 	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_80:
 		return RTL_DASH_25_BP;
 	default:
 		return RTL_DASH_NONE;
-- 
2.43.0


