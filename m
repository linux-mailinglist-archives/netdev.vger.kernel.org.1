Return-Path: <netdev+bounces-197314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0258AD80EB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213633B5D25
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329761FBEB3;
	Fri, 13 Jun 2025 02:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F291EFF81;
	Fri, 13 Jun 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781207; cv=none; b=iAqeuOWAtDM3DHP2YzeufMTDy2jfF0ydzM2GNXq8PFelmjwsaXFKoR1EXX1OUPmRVbzan5bZaXe1ABCIwxmOn4OXnKEWY7yUZJ1hL5s3A3L8w/3GXHRC7NfrZbS51p00hPAuhMh3+raD7JXAwcWwiWNHNcbZBUlnLbxgeKnsHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781207; c=relaxed/simple;
	bh=SVwINmzjWUlA0izmJZ5isREN6hUzd4XcsqhnL0edfCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sbkzy1ImCLlXybNeInOv9/eVVNQxMUYayqpt3lY8cpW36rRvi6E4kl4JD+sHmi7G2mDJ8xm5DuABpu7sa/jZ48zGYYEKeih5BmppiuJ/GS+swvk06g3S0HjJYZT8dOmYiYdQ2ci8eXlCjd1BIH+xayqJgA3ntBLmhQC6ppsu9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABXB9aviktoIvMtBg--.44541S2;
	Fri, 13 Jun 2025 10:19:27 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next 0/4] Add Ethernet MAC support for SpacemiT K1
Date: Fri, 13 Jun 2025 10:15:06 +0800
Message-Id: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqJS2gC/y2OQQ7CIBREr0L+Who+tVgbY7yH6QLpV4lCFdA0a
 Xp3aetyMjNvZoRIwVKEho0Q6Guj7X0WuGFg7trfiNsua5BCVkIJxT0l/kBOThteEtZYiZq02kJ
 uvAJd7bDQzjAHPQ0J2tUJ9P5kfPrbFx2Jm945mxr2VQUqHgzOFEcx6mW4YYd1F0uBiOW+QClwJ
 yTPB54dhVOw0cSkQ5FJR2in6QfrjN4y0QAAAA==
X-Change-ID: 20250606-net-k1-emac-3e181508ea64
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Russell King <linux@armlinux.org.uk>, Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Vivian Wang <uwu@dram.page>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABXB9aviktoIvMtBg--.44541S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fZr15Kr13tF13WrW3Jrb_yoW5AFy5pF
	W7ZrZI9wn3Jr47tws3uwsru3yfW3WvyFy5WF1jyr1rXr1q9a48Jr1SkFW5tw18ZrWfJ34Y
	qr4vvws3CFs8Ar7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r4UMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiMmh5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add a driver for them, as well as the supporting devicetree and bindings
updates.

Tested on BananaPi BPI-F3 (but see "Known issues").

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, but all other differences point to it
in fact being a custom design.

Based on SpacemiT drivers [1]. This series depends on reset controller
support for K1 [2]. These patches can also be pulled from:

https://github.com/dramforever/linux/tree/k1/ethernet/v1

Known issues:

- RX fails to achieve close-enough-to gigabit performance for unknown
  reasons. The 6.6-based Linux in the vendor distribution "Bianbu" can
  do over 900 Mbps, so this should be a software problem, but I haven't
  figured out why yet. A cursory look at "top" tells me that ksoftirqd
  takes up almost one entire core, which suggests that RX could be
  compute-bound.

  Tested with Banana Pi BPI-F3:

    # On the BPI-F3
    taskset -c 2 iperf3 -s

    # On the other side
    iperf3 --bitrate 0 --time 10 {--reverse,} {--udp,} -c [ip]

  Results (TX/RX from BPI-F3 perspective):

    TCP TX: 941 Mbits/sec
    UDP TX: 948 Mbits/sec
    TCP RX: 617 Mbits/sec
    UDP RX: 647 Mbits/sec

- No DT for Milk-V Jupiter. I do not have this hardware to test yet.
  If I get access to it later I will add its DT changes.

[1]: https://github.com/spacemit-com/linux-k1x
[2]: https://lore.kernel.org/all/20250613011139.1201702-1-elder@riscstar.com

---
Vivian Wang (4):
      dt-bindings: net: Add support for SpacemiT K1
      net: spacemit: Add K1 Ethernet MAC
      riscv: dts: spacemit: Add Ethernet support for K1
      riscv: dts: spacemit: Add Ethernet support for BPI-F3

 .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   46 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   22 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 2059 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  416 ++++
 10 files changed, 2709 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250606-net-k1-emac-3e181508ea64
prerequisite-message-id: <20250613011139.1201702-1-elder@riscstar.com>
prerequisite-patch-id: 2c73c63bef3640e63243ddcf3c07b108d45f6816
prerequisite-patch-id: 0faba75db33c96a588e722c4f2b3862c4cbdaeae
prerequisite-patch-id: 5db8688ef86188ec091145fae9e14b2211cd2b8c
prerequisite-patch-id: e0fe84381637dc888d996a79ea717ff0e3441bd1
prerequisite-patch-id: 2fc0ef1c2fcda92ad83400da5aadaf194fe78627
prerequisite-patch-id: bfa54447803e5642059c386e2bd96297e691d0bf

Best regards,
-- 
Vivian "dramforever" Wang


