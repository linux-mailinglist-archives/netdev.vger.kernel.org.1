Return-Path: <netdev+bounces-143634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC139C36B8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1B92822EA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA713BAF1;
	Mon, 11 Nov 2024 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jjUll8Qh"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDE136E3F;
	Mon, 11 Nov 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293776; cv=none; b=F+TUU11IRvdHXY6vesbndiPirTuELNmmnQ/1ZPrryVVsFvKTx6RdkO2b+zIQ3Cq0xnXwKc+f4JkIjk12yItxtTPDUaEUwv6s+xCqS2HxH7mVwUC/bDeqJ8+qFD8+E8e3Fofd4cUaNnYpHcbnNWI3PzFSOAIqeeW1AYPJGv2NyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293776; c=relaxed/simple;
	bh=tivdGFRzWnPNSNUizSGzGAB5Gv0u3CDXEFZanAO+k+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvkpsYKMhdli19qwtlTiiCDW2qqATKGIzC6FfXFKpIp2pBE9JYnvl56pJENfdT17+7dcgR2t4csIDrvjL1Cm4PsQgLah1/0QNx/K1Ish1DkAw8BOF2nGTu07RT9jCwNsVE6lmB1ozbTNSyY+T/A6syAeAOqrijBor2dm1Y0+K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jjUll8Qh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB2thUjB1487418, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731293743; bh=tivdGFRzWnPNSNUizSGzGAB5Gv0u3CDXEFZanAO+k+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jjUll8Qh5ryl4yW3U+Dx4xv6meW/oIrnBzmc/rCl8ucM+YdhKIm/VC+ZdP5/o3umW
	 +dBAtYDCKW+vTgjUa5mAH2XM2t2lDuvOt0EORcUw9Oi+w0qDOCnFjK5MPtgLDjLugI
	 qqPL0wKtFDBsJoKYGHAG288kIWXY/pBuhzlDTbnvdtYVSH0csKaDJcucv/8jEeqdwq
	 FxcGOxFppxSN3LyivFOEH0i1e2Vxq4xqoKF9IaoXHWShhZD/HGYCVah0O3rxEVO06N
	 YG4GBEdUm+V47DScsWRDwPXYavKqXNwqfgkm2MQ9Jc+0vI8yh+9H/fxVnXaaCPRPeT
	 FKjmQKwJEik6A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB2thUjB1487418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:55:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 10:55:43 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 10:55:43 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 0/2] Add support for the RTL907XD-VA and fix a driver warning
Date: Mon, 11 Nov 2024 10:55:30 +0800
Message-ID: <20241111025532.291735-1-justinlai0215@realtek.com>
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

This patch set includes adding support for the RTL907XD-VA. Fixing the
warning raised by the reviewer, which points out that error handling
should be implemented when rtase_check_mac_version_valid() returns an
error.

Justin Lai (2):
  rtase: Add support for RTL907XD-VA PCIe port
  rtase: Fix error code in rtase_init_one()

 drivers/net/ethernet/realtek/rtase/rtase.h    | 10 +++-
 .../net/ethernet/realtek/rtase/rtase_main.c   | 54 ++++++++++++-------
 2 files changed, 44 insertions(+), 20 deletions(-)

-- 
2.34.1


