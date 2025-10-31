Return-Path: <netdev+bounces-234630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF4C24CC1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B01A650D6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1A346E5B;
	Fri, 31 Oct 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FSsGn6O0"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67814345CCC;
	Fri, 31 Oct 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910356; cv=none; b=PDx76LJYm1BXE0pPREvP0/2y5ZejTwK1nPlRB40SNzDBUGAsHpB2SJ0FvDpfbwLVNLh4EZYGLguY9yFQkXmZSaUmzN/xMZCwFElUzWphY2bcuIC0F/KQtHQfp9/I6uAvIlMrfZ5wgL5MxXFagjnMByCwaM3EUJ2PxbdHpCP/VfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910356; c=relaxed/simple;
	bh=mVdS29UjqWzYR1IlN5m+Wl9jK4cj+2iDhcBcstIIX6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNei4mG57NzzsxZNsbIrCOTc5huUp8/5B+DceayTveqQMRWgbqD0sj5YeiISpxDt2TDG132auNmDNOmlZKKqCCSDW0q8IEYfe6Rk/9cqzBm4EpDzjDOQ0+KkSPjEPCnpQav46A2ywl9ild7UQWjh2YjX5/0qaxTT954G1kT9MBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FSsGn6O0; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B2251A05F6;
	Fri, 31 Oct 2025 12:32:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=T6GAuWPvlYyAu1pNjUnBBtP7kNooiRsf2mOkJEA1f4A=; b=
	FSsGn6O0yF92a+NQlCa8mtQtAmGZWxY8Ao9UbHI5L0SlqEv90RYYL1sb0xW6et0F
	l97aovr90oajThJ00W7afL1BcWog9FUemcOF/o5wJsdmT1jM1rz286BaPzRflV9S
	3mqpAGYUXga1Ijt8OziQD+PP1+jwVHAPodW0DWy7ve93XMK19NeyQauGXf54AeVW
	GUUz4vuDdxXhAyK1sgfrv8VmRfb4aUPpClCcQTuI7dINxPjUWJJlnNx4aSPsMOJj
	AiPQslSYLGv6VUcR6uDdulQc6Ez+YSkx3sXysyUwx+8npbDa+7qdsF0Qpfzdn4la
	2CXoTxbFrWjklgZl8jZnz9sxnDNZGcT1nXfBNx6fxLZEq9tM2IgaqUZo3H3a6FEk
	4xis4jOvRo50rtCXmgU5QbTn2pz5LIjpQA5QedRwjCCX3Og1i0lomEH8LZNNGdyR
	AskQcMBFEgtdq+kzJTkyCaAmYHTMhE68VZ7at4irnZjy1aBZjL4NoViWIVdKw4TB
	j5xiYwbzOKWKu1AHHAOmwb/JoVJdvDw4aNI2fe7efoCYH0Zkq/RlubNrd6mn+MQw
	KR/y/K7200gJo0NOf8/Wl8g1E0Fho2jAiIwF+x2MnO42dAs1kJh+rygjZFpzh5gH
	cOub/xu8RbKG7pVQBIPGROvQdYvGHKrMglz7XWPS3ck=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 0/3] net: mdio: improve reset handling of mdio devices
Date: Fri, 31 Oct 2025 12:32:25 +0100
Message-ID: <cover.1761909948.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761910350;VERSION=8001;MC=4041627775;ID=195341;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677D60

This patchset refactors and slightly improves the reset handling of
`mdio_device`. 

The patches were split from a larger series, dicussed previously in the
link below.

Link: https://lore.kernel.org/all/cover.1761732347.git.buday.csaba@prolan.hu/

Buday Csaba (3):
  net: mdio: move device reset functions to mdio_device.c
  net: mdio: common handling of phy device reset properties
  net: mdio: improve reset handling in mdio_device.c

 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio_bus.c     | 36 ++---------------------
 drivers/net/phy/mdio_device.c  | 53 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  2 ++
 4 files changed, 57 insertions(+), 39 deletions(-)


base-commit: 0d0eb186421d0886ac466008235f6d9eedaf918e
-- 
2.39.5



