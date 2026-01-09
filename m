Return-Path: <netdev+bounces-248388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D3D07B9D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B2E3036990
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A22F7449;
	Fri,  9 Jan 2026 08:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038552EC55D;
	Fri,  9 Jan 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946108; cv=none; b=riQNmcSeHkZYVJrd3W3P9TGlwjU2kdUltiOoEl+hBUVmlBYgDk0l2lFD1AShteDl2cgH1VZv9M2Wl2D73OhQD2cDKG+Sj5IJa5egIYwGeNXkFiJZgULZ3jeyiYcXa2qMdgem4PMhKBpvyeCqt/NZJVHCFEm19m11zhALl7HF4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946108; c=relaxed/simple;
	bh=e4DiX3enHXW60ZSu6JRZuyUKHV/HpC3TnO3ONWwHlOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTIOUVMZd+WTmbSLix/r2JDQP0y0hjBJILBapX0Uk41Kacw1FHNv+sZ+9Don3jFgSs0soEUfQrRYPbBBMWYRu1mi2XAszvd2c++zAVVsvRuaTK7OiuhmLZ9WetOajzpqppIoq3TMHVgwKDWMvoFmEyZr5qlw/iTLdgJuhsYezFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgB3fmtOt2Bp+ImSAA--.13189S2;
	Fri, 09 Jan 2026 16:07:43 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH v1 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX sampling timing
Date: Fri,  9 Jan 2026 16:06:01 +0800
Message-ID: <20260109080601.1262-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3fmtOt2Bp+ImSAA--.13189S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fZw15XryfAw1xuF1fXrb_yoW5Gry5pF
	WrGry3tr4qgw1ftwn2vr40gFyrXan5tF47uF1rJwn0vwn8CF1Fqr43tan5XFyDGrs3u3Wj
	9r1jqr4DCayq9FJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/

From: Zhi Li <lizhi2@eswincomputing.com>

This series addresses an RX data sampling timing issue observed on the
second Ethernet controller (eth1) of the Eswin EIC7700 SoC.

On the EIC7700 SoC, the hardware introduces a receive clock to data skew
on eth1 that is not strictly fixed, but remains within a bounded range
under normal operating conditions. At Gigabit speed, this skew causes
the receive clock edge to occur later than the corresponding RX data at
the MAC input, which can result in incorrect RX data sampling.

The existing internal RX delay mechanisms, including the use of rgmii-id
mode and rx-internal-delay-ps adjustment, provide only a limited amount
of additional delay on the receive path, which does not offer sufficient
adjustment range to compensate for this condition. To address this, the
EIC7700 MAC provides an EIC7700-specific clock sampling inversion control,
which effectively shifts the sampling edge earlier and restores a valid
RX sampling window for Gigabit operation.

In addition, this series updates the enum values of the
rx-internal-delay-ps and tx-internal-delay-ps properties in the device
tree binding to reflect the actual delay step resolution implemented by
the EIC7700 hardware. The hardware applies delay in 20 ps increments,
while the previous enum values were based on an incorrect 100 ps per
step mapping.

The binding enum values and the driver conversion logic are updated
together so that the specified delay in picoseconds maps correctly to
the underlying hardware delay steps. This change corrects the DT-to-
hardware mapping and does not change the meaning or intended usage of
the delay properties.

The first patch updates the device tree binding to describe optional
clock sampling inversion control and the required HSP CSR registers.

The second patch updates the EIC7700 DWMAC glue driver to apply the
sampling correction at Gigabit speed, clear residual delay settings
left by the bootloader, and ensure all register accesses are performed
only after clocks are enabled.

These changes restore reliable RX operation on eth1 and ensure the
hardware is initialized into a known and consistent state.

Zhi Li (2):
  dt-bindings: ethernet: eswin: add clock sampling control
  net: stmmac: eic7700: enable clocks before syscon access and correct
    RX sampling timing

 .../bindings/net/eswin,eic7700-eth.yaml       |  57 +++++++-
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 132 +++++++++++++-----
 2 files changed, 148 insertions(+), 41 deletions(-)

-- 
2.25.1


