Return-Path: <netdev+bounces-144850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6B9C88D7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10D4283F3D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4061F8937;
	Thu, 14 Nov 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MgECouAX"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7ED18BBBD;
	Thu, 14 Nov 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583581; cv=none; b=ilioetuyGl+FjlLNnw5d0seNiP/gtKsysPya7LzwQErkeE/FMb0WtpP756Wt+uwu0PpPD5vChBXNiZm/KOkRCmDa7CZDZu7Vzgbqi24YVhJ7g4k3Rx998lwKZlJN/ImYkF4LNalUUNb08fqScdkWODw7nyemoTVDnNjtjfC7xrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583581; c=relaxed/simple;
	bh=yYmcYH8qpWh05/Qw6Z3HQUiJvoECLABGTyU4XG71RlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEi1/NUe1RFU7qfez8gZ8O7WMWgIK9SiT+Sbe6P0sYM6yGKBPYN8PFrfjGQjv2QuwCfrDrvmczyJ2BmkLv/E3vwRJmIW3TC1KblqkraEk5c+UiyMxuzygDtp/bzsw+IQcz56fNoPiZN2Pa6jCasIuQ3sKLFV40R/LK3FYc55b8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MgECouAX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBPxA622914424, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731583559; bh=yYmcYH8qpWh05/Qw6Z3HQUiJvoECLABGTyU4XG71RlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=MgECouAXueZbhUWayXPq3Vilg0m/lenQikEKxhULJfgIE2zMrnHpGT3mrP21uXpPV
	 F6klxwuA139jOaw44nR/tT+r3DiQloWHuNhsT/VgkjgOeVmtCLv/Xn+NuE5zsm6YLx
	 ysC8KZR0ydnkYtwIyLic4RM/iuGcu1IIhMF1pm7ab1gDaIN+2UMrtHj+uMJr33v4yr
	 Ykf+A6zF8PfwNaOLmZJrXLpnt2CZUfZyZKfzdncJ44233TtRWHY13at2cyKgAu315L
	 ZV5Gqcs2Mz+8HQNsfGHo8Pq/rwqZQnJ28utMDnFUpw/PRypMvMl4HPMT/PM+7uJUJ/
	 Sj9OcUyPKu7Pg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBPxA622914424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:25:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:26:00 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:25:59 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 0/2] Modifying format and renaming goto labels
Date: Thu, 14 Nov 2024 19:25:47 +0800
Message-ID: <20241114112549.376101-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set primarily involves modifying the enum rtase_registers
format and renaming the goto labels in rtase_init_one.

Justin Lai (2):
  rtase: Modify the name of the goto label
  rtase: Modify the content format of the enum rtase_registers

 drivers/net/ethernet/realtek/rtase/rtase.h      |  2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


