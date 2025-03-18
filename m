Return-Path: <netdev+bounces-175617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F8A66E68
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8D57A26C3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F91FA14B;
	Tue, 18 Mar 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PWPAQFT6"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC431FFC47;
	Tue, 18 Mar 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286964; cv=none; b=g0OM1Y+WTQM6HGBwKqcsnm9bXdk7O1VNRTkvnGg4IlpL2GzUBig0lQB/eSCoSs/RmqEcttVQ8ILhgM7pbgKIVztG5ydxNg8T7nWYs8b672DgQgLM3A5f63J3x1MgsMAc3V5v05rjV0sqCbbD+IRCjX8X9wVlI1PtvwaRIfpwNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286964; c=relaxed/simple;
	bh=iDHSJrRMpJCglksEroC9F2aKcUHY9EStjzQR8fDaTqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qcn9kGY3P5SAb8GwbEl5pkULMRITMuRyNsL22eaWpztd+m9NB1QjaZ6e0mX+Dp2ci3utjT9KjtDGvM1goOCZxswM1qS0+acX6NwF0pQNuK75nl0+5fsRUoQMIvYv5ZKz7aa+phWh33HHawrYK0UlhrsAu4jy8gvH5PizuHmOjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PWPAQFT6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52I8ZhIV22586472, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742286943; bh=iDHSJrRMpJCglksEroC9F2aKcUHY9EStjzQR8fDaTqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=PWPAQFT6nMWym/FmlgFkYMmXobRf8KlwFM9yl0XQzI8e/JRlWEG5rhKJFcoSUqrgp
	 knnBD5Ua1lKiNXITSg+3X9xSA1JPdjBGQ0+PzSIXfQKXk6+l1UU6Go+oeZcE7LnBCQ
	 FY8jqkBmL6O1QpEcFPmKj9FREgsDlzGNi9p9kWFTH74J+VUgB5sVFUfOK3GYoMPPc9
	 wPf4B4yurMu9TIPv9BXqB8Vmcpw1t3YFwFeVvi9JgrIp7UC8c67P2ZRr6eXtmYsbKQ
	 SqslVas2zONjLPSTLbb/zzv5c98eiMgr5ZselqbhCfiBpBEpjE+P63nn54imIBQRvi
	 OZPyae0BVLjnA==
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52I8ZhIV22586472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Tue, 18 Mar 2025 16:35:43 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Mar 2025 16:35:43 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Mar 2025 16:35:43 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v3 0/2] r8169: enable more devices ASPM support
Date: Tue, 18 Mar 2025 16:35:36 +0800
Message-ID: <20250318083538.65789-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches will enable more devices ASPM support.
It also fix a RTL8126 cannot enter L1 substate issue when ASPM is
enabled.


V2 -> V3: Fix code format issue.
V1 -> V2: Add name for pcie extended config space 0x890 and bit 0.

ChunHao Lin (2):
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
  r8169: disable RTL8126 ZRX-DC timeout

 drivers/net/ethernet/realtek/r8169_main.c | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--
2.43.0


