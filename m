Return-Path: <netdev+bounces-96389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E238C5939
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950BC281971
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7017EBAE;
	Tue, 14 May 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y58+Tbld"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79E1292D2;
	Tue, 14 May 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702628; cv=none; b=IB1H1Fxe/zKkCAFQddmpsntz2ZwnYLWxSmrWBJoAvLst8LxiJIXzfSAYBsDqiVJIyejDssCUxJLUw9yjdyjtL4+uvVdBIfz/I9SslnooAuqg2+OFVUAhK/unqIXBtWA05M/POTBLfK2ZBJqrwKYAUd2uCbeQD56w8h1jzOGmn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702628; c=relaxed/simple;
	bh=erlfeSPQ215DojD/j+9s4O7dQthfqXWRk2QkY2g/IpQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTdvHU2a53Qa0zzDxzMLUk+ytkzKyOYj1HDPpwa8OB/98pmNEs/5+Z1g79jAEpYoL81s8LkaBbqwdKu3kxM6E/4ZeIbvWDDXdVi63I5d7lmMQyXuoMccrO3UqnFXON1Aqh/bXH+96d/GCgEWeOkgTKdKSIq4UTa7886PDcxCQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y58+Tbld; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715702627; x=1747238627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=erlfeSPQ215DojD/j+9s4O7dQthfqXWRk2QkY2g/IpQ=;
  b=y58+Tbld2Hzc/waLjPwEctt+4qUAsjLo6JgGi/HCQ1Nt1v30XsmAVcK8
   SkHVSCWgUcdGSzKUJn2x0VBn/xkwyOID61SWGmCFUOeGp6cV6vJBQNKQR
   NqnO970Dmme7pHwjdTBRVeW20GQUwyCGIMtkFw5onE/F+117O/kse5rgA
   wvu0viQ0pC83Ynr8V1On9Wm29mrEd1OVSXtNIeEM9hIsSWYauK/vnmC/6
   zrpckvplBlwJvXDBqQW5YI96OaZxFigy+FJI1y2Y83svLsId7huzEa243
   OSmdAZun6rB0xtbVIAYME91fFE1rGm66JGM8LWoX8tsh88MinN2T6Cf77
   A==;
X-CSE-ConnectionGUID: bSBymiqCQ46eWrMZ2BeHHg==
X-CSE-MsgGUID: eAY51sFGQ5KNtZvWLWcRug==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="24701286"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 09:03:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 09:03:24 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 09:03:20 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v2 0/2] lan78xx: Enable 125 MHz CLK and Auto Speed configuration for LAN7801 if NO EEPROM is detected
Date: Tue, 14 May 2024 21:31:59 +0530
Message-ID: <20240514160201.1651627-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds the support for 125 MHz clock, Auto speed and
auto duplex configuration for LAN7801 in the absence of EEPROM.

Rengarajan S (2):
  lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is
    detected
  lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801
    if NO EEPROM is detected

v2
Split the patches into 125 MHz clock support and Auto speed config
support for LAN7801.
v1
Initial Commit.

 drivers/net/usb/lan78xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1


