Return-Path: <netdev+bounces-135830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B035499F515
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664A41F23C2A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159961FC7CB;
	Tue, 15 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Akl35Y1N"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4F1F9EA8;
	Tue, 15 Oct 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016426; cv=none; b=Dhib6LN4U1T5SKPdbE5o+M6tQ/cRdX3MtNukTTp9aXWkYXOod5V6YyNIvZ0y2dDbLOGUpxaYEmTqeBqJAFT5+lw4IrA1XBN3/fqitU4z4qMjjQFk/mI0cNpGKasT/tW+UVbeifSQyW+TKMDl/DPO3B4Aa7dJs8s24HRydWNkOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016426; c=relaxed/simple;
	bh=xlJulwgFadsww1fxuY/kdqupOC+XrWysfnSRy7xGE1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gwaZBxRDNPAatMbty44qAWO217sYDJWkNhq/uwkYGLlW6gqz5sH7qs2NL0BPFSiKP2/AQMKS5OvyY3lTfiwHr8Hx9itONUSGGqeYT5uz4RUn5o/ewOVd/qSqf8ILHR8MxIICd4YYSmJ2uSLc36Zf1vfGYXVE+k1fxvPuWd0O/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Akl35Y1N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729016421;
	bh=xlJulwgFadsww1fxuY/kdqupOC+XrWysfnSRy7xGE1Q=;
	h=From:Subject:Date:To:Cc:From;
	b=Akl35Y1Nf6JAV23EHQ1lKZaz2LzFQPmujxrUcTdcGTTOaBPjJ8YCMZcR+C5u+ccCQ
	 pta/nIQ+eJPSQPO03pogjoFtXgeO7S5rStsaS+F4gu0BosaQp9iZAMLVh9Vb72NzOE
	 fx4sJ/G97bpMsQgchqabMQkeCDoThib27vDXb/IhacuIo07CLOa6tZo1MVIwewk5pV
	 RHAj/IKzk12H/0h2inkDyCQpPdH9S61r+OXw3l0IWs+filtdSLUAOZ6gUj3tZ6K4mi
	 nGIBf3Dwefwn+oCkzJI53nPKmoStF8h+LpjZ6tYKCiJubkwvRDWeCL5qfWA650pcZz
	 O3MWQ2fo6LomQ==
Received: from [192.168.1.206] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DAFC417E3687;
	Tue, 15 Oct 2024 20:20:19 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/2] Enable Ethernet on the Genio 700 EVK board
Date: Tue, 15 Oct 2024 14:15:00 -0400
Message-Id: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACSxDmcC/x3MQQqAIBBA0avIrBNGK4WuEi3EJp2NhkYE4d2Tl
 m/x/wuVClOFRbxQ6ObKOXWoQYCPLgWSvHeDRj0pVLMMlDhbRElXlHrWI067s8Z46MlZ6ODn361
 bax/KJmqpXgAAAA==
X-Change-ID: 20241015-genio700-eth-252304da766c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>
X-Mailer: b4 0.14.2

The patches in this series add the ethernet node on mt8188 and enable it
on the Genio 700 EVK board.

The changes were picked up from the downstream branch at
https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-mtk/+git/jammy,
cleaned up and split into two commits.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8188: Add ethernet node
      arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet

 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 95 ++++++++++++++++++++++
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 25 ++++++
 2 files changed, 120 insertions(+)
---
base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c
change-id: 20241015-genio700-eth-252304da766c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


