Return-Path: <netdev+bounces-212409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED5B2006A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD25189C72E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6A2DA763;
	Mon, 11 Aug 2025 07:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42B23B613;
	Mon, 11 Aug 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897733; cv=none; b=OX51DPEjNTQNFLtxWuIP/OxFlsmVlv+EgsKs6j7QGtHMeF3E4h2rN+3luuB2kJO2DcO0WdJMpG6NadLPUkZ+byk5fZh4ddO9U8PgFFc/r1nT0lOTf1MFeCL3+dwb1fvHV9ePxU5pjiyHRPQ55cIUozqnb3nsKcnUQM7ylFoS9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897733; c=relaxed/simple;
	bh=2Q9ZsC1HlA/lA6njVvReFZ0atkiHkIj+V8qk1kbzK/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uol5mFLgWUGzyehopdxuR5MOXE3BDl8/P5G05Ud1SyA5+4AhFf021uFcS5t2yDnjUvZ/WPMecxp981dejQMifWWdMtDSIItIlq5p0YM4v8ynWl/tS7QiWrKhJK9+1wRLm9LYvIWQbGHb8aGaIugUotwpCSetFEGPkl01wDNbbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxPuM6nZloHFQ+AQ--.17397S3;
	Mon, 11 Aug 2025 15:35:22 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQqnZloCJ9CAA--.53284S2;
	Mon, 11 Aug 2025 15:35:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] Refine stmmac code
Date: Mon, 11 Aug 2025 15:35:03 +0800
Message-ID: <20250811073506.27513-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQqnZloCJ9CAA--.53284S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF4UCw4kKF1fuFyxZFyruFX_yoWfKFg_WF
	W2vr98Xa1UXF4jkFW2grsxu34a9Fs8uw1FgFsrtayF93yrZr98XFn5ury8ZF1rWa4YyFn8
	JF1xtr1xAw17KosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==

Here are three small patches to refine stmmac code when debugging and
testing the problem "Failed to reset the dma".

v3:
  -- Add a new patch to change the first parameter of fix_soc_reset().
  -- Print an error message which gives a hint the PHY clock is missing.

v2:
  -- Update the commit message of patch #1 to explain the background.
  -- Add Reviewed-by tag for patch #2, no code changes.

Tiezhu Yang (3):
  net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
  net: stmmac: Change first parameter of fix_soc_reset()
  net: stmmac: Return early if invalid in loongson_dwmac_fix_reset()

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c      | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 7 ++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c           | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 9 ++++++++-
 include/linux/stmmac.h                               | 2 +-
 5 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.42.0


