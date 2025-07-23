Return-Path: <netdev+bounces-209292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60855B0EF13
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32B31C816E5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82F28C5DC;
	Wed, 23 Jul 2025 10:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F428C029;
	Wed, 23 Jul 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264867; cv=none; b=OFjZw+AZa8Qp6TxSMeYOoArr0/TP+Krau+qHNHnZczqm4BtAbE2dXuOVD4prHyZ0Fo4lm3sVNN8d8fXaVIeQS/r5aBToRVQjtI723eQrvqPIZ8pIvijVzSdF7br3w7v0I0m0IHUMlDRss6bykMHeZ3Ulh0vIbzIh23JToZGFvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264867; c=relaxed/simple;
	bh=rRc7eKvHbFGcza3WOstM5gEoFED6LfK2Xd83nvCt4Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eArentE4trcg3vXED7nodt6h5o82wbn4SVgQsvB5s+k4ZAfp5sS+hAnplvGaDoYix4NkdPsSCZPPAmL0MFX4OHnLReILg1qst4uRbWx8VO9B8EKkHWgBkJr/uJ6+yNt1auVGJ6yNaUfSji5fsScGtrQR8TjqsF5MuT+KJmGN+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSWrcsoBoLzkwAQ--.62641S3;
	Wed, 23 Jul 2025 18:01:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsHYsoBo1AUjAA--.24129S2;
	Wed, 23 Jul 2025 18:00:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] Refine stmmac code
Date: Wed, 23 Jul 2025 18:00:54 +0800
Message-ID: <20250723100056.6651-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsHYsoBo1AUjAA--.24129S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxAqzxv262kKe7AKxVWUAVWUtwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ul4E_UUUUU=

Here are two small patches to refine stmmac code when debugging and
testing the problem "Failed to reset the dma".

v2:
  -- Update the commit message of patch #1 to explain the background.
  -- Add Reviewed-by tag for patch #2, no code changes.

Tiezhu Yang (2):
  net: stmmac: Return early if invalid in loongson_dwmac_fix_reset()
  net: stmmac: Check stmmac_hw_setup() in stmmac_resume()

 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.42.0


