Return-Path: <netdev+bounces-137049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E99A4222
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19951C226D9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0008200C83;
	Fri, 18 Oct 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BiQHe7Ip"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDD1F4264;
	Fri, 18 Oct 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264757; cv=none; b=rCNU7nxnSQk+jb12W1tBd3nQ2olWTxy51VdSACQZtYtPiFgJJ7zUF9NwQ0S2O8BBcs/G5M16YPU4Hr7WY7WQ1EI3gakDbqv45hDPLwzCYq5CWCXImD2R/ZzbFzNX0ntDpek0w6mNJL4nvRoajqg+7aFszqSYdfx3/mYHkrA8dJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264757; c=relaxed/simple;
	bh=UwPMKCaQO5+n3ciIjqo+WINUTZDFj4k3xLL2XjGRbos=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ihcF7CxjIfLCUrPPoqchg3ol4qK23heVzyR0ZQTDMB0qSNmC7u9W8ewgTs6Jx/qLbz+NiDyEc03MVqiw5PTmIxqNL8rW3+jKARp5FJuLVMXCPuKtTOAAREhA1dCHdd3QEUMG0+p7VVaI7u99CrSlxVdH8NjLWMDGpE2j8aTQyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BiQHe7Ip; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729264746;
	bh=UwPMKCaQO5+n3ciIjqo+WINUTZDFj4k3xLL2XjGRbos=;
	h=From:Subject:Date:To:Cc:From;
	b=BiQHe7IpC/W859WGSqcVMCN+JhALi2oC/xaRLcHyMyChZv/CZfybHqHs1NWRhtFVB
	 sGhV1+PFan29sig7N9qI9T+URF6PA3CVby+Po1CNB88AixI89bso8fR2gPsnnyAGAf
	 kyBYHiO5fu7c41By8SWRxnSMF7LPccxkz3sX+/Im/iArhNxYlU3q8vVVGzq2iyNqLA
	 nAmtD7TUSIsxPSwjg2s4/2ST1iFXAAWQ8j5RlVAfvcqLsAMOyeF8FWgVdOSEjYJzBQ
	 ERHksr5zQ/OJihw4ufVGFGO6n00bvhi87z3G2m/EOxsgggBDD2lwVr3OSExHHQ4DFF
	 /RuELhFsBc6Jw==
Received: from [192.168.1.218] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DF1117E361A;
	Fri, 18 Oct 2024 17:19:04 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] Enable Ethernet on the Genio 700 EVK board
Date: Fri, 18 Oct 2024 11:19:01 -0400
Message-Id: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGV8EmcC/3XMQQ7CIBCF4as0sxYDlIK68h6mC6TTMkmFBppG0
 3B3sXuX/0vet0PGRJjh1uyQcKNMMdSQpwact2FCRkNtkFwqwUXHJgwUDecMV89kJ1uuBmu0dlA
 vS8KR3gf36Gt7ymtMn0PfxG/9A22CcSa0Fe5q2osb1d3FebbPmOzZxRf0pZQviR7OJ6wAAAA=
X-Change-ID: 20241015-genio700-eth-252304da766c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
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
Changes in v2:
- Moved mdio bus to mt8188.dtsi
- Changed phy-mode: rgmii-rxid -> rgmii-id
- Removed mediatek,tx-delay-ps
- style: Reordered vendor properties alphabetically 
- style: Used fewer lines for clock-names
- Fixed typo in commit message: 1000 Gbps -> 1000 Mbps
- Link to v1: https://lore.kernel.org/r/20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com

---
Nícolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8188: Add ethernet node
      arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet

 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 97 ++++++++++++++++++++++
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 20 +++++
 2 files changed, 117 insertions(+)
---
base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c
change-id: 20241015-genio700-eth-252304da766c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


