Return-Path: <netdev+bounces-209576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA926B0FE59
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6743B1A0B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08454262;
	Thu, 24 Jul 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pZBAooeN"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E628E0F;
	Thu, 24 Jul 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753320727; cv=none; b=mtIm9HofyFCBXraDfbA3enf8zrEREgM6o++wUGHdeCQ+PdwY1htKvbHuHBvIwp9ap6lca1EhMNnebGCC78BuI9iPhhUYsc9WEVqyjF9Y6oH/ktoEQhReuxgbmDtq4URms4lOmQ3KjdeqNY4owyVuOQHi1mXHjCwbDyj11rSVLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753320727; c=relaxed/simple;
	bh=eMCaAMgToeHTEFdiJ3MiKleOXM/l+gUrFlLQgweUVOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsJummtTuzgNJ4UPNZjYIU4ZvQZjeSe9BlH2siTfPNYP9IdJPf8htdyxxiBPcqLfnEw18tvWWfu419YQepui35eHMZEf4uTq2/Ij7meHxLvhZ3Bx2wAkjQcwAktKzMMkKU9sdB1YRRx95rgTN9/5+bGFYaPiC+bqpS7MUcQ3f3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pZBAooeN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bI
	GWBSCbr5xCslura3QUWceaRXrDNmQ1wuyKrSAX7bE=; b=pZBAooeNCloY9lpQsx
	udlDCzremMw/Nfm/RFmWfuHNXobGme6sSl9UodHhhKtDtqJf0sZ8/VM5Owg16FzU
	treDMbo8B655K7HX/cQPgNcKPbqS02t2mbJsDRUUhb9bQUL6C8PS0Mdmnw/a6x6Q
	immJPxJ+eiZFvKpprNqRnAQfc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnL5H3jIFoQZMcAQ--.40865S2;
	Thu, 24 Jul 2025 09:31:36 +0800 (CST)
From: yicongsrfy@163.com
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	oneukum@suse.com
Cc: davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: [PATCH v2] usbnet: Set duplex status to unknown in the absence of MII
Date: Thu, 24 Jul 2025 09:31:33 +0800
Message-Id: <20250724013133.1645142-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723152151.70a8034b@kernel.org>
References: <20250723152151.70a8034b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnL5H3jIFoQZMcAQ--.40865S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1xZry8ZrWkuw1rCr1xKrg_yoW8Gr45pF
	WDAr4kAw1j93y8Zw4xZay09a4Yg3Wvqry7WFy7u398WFZxA3ZIqr18Ka42k34kKrW8GFya
	vF4qgryav3Z093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiZ2fUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLByU22iBg-T7UgAAsI

From: Yi Cong <yicong@kylinos.cn>

Currently, USB CDC devices that do not use MDIO to get link status have
their duplex mode set to half-duplex by default. However, since the CDC
specification does not define a duplex status, this can be misleading.

This patch changes the default to DUPLEX_UNKNOWN in the absence of MII,
which more accurately reflects the state of the link and avoids implying
an incorrect or error state.

v2: rewrote commmit messages and code comments

Link: https://lore.kernel.org/all/20250723152151.70a8034b@kernel.org/
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/usbnet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 6a3cca104af9..b870e7c6d6a0 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1013,6 +1013,13 @@ int usbnet_get_link_ksettings_internal(struct net_device *net,
 	else
 		cmd->base.speed = SPEED_UNKNOWN;
 
+	/* The standard "Universal Serial Bus Class Definitions
+	 * for Communications Devices v1.2" does not specify
+	 * anything about duplex status.
+	 * So set it DUPLEX_UNKNOWN instead of default DUPLEX_HALF.
+	 */
+	cmd->base.duplex = DUPLEX_UNKNOWN;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings_internal);
-- 
2.25.1


