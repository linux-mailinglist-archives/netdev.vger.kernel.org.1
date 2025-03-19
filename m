Return-Path: <netdev+bounces-176069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372CA68987
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7530F189F927
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC1253B52;
	Wed, 19 Mar 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05BnybXx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCzURz1U"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6221F585C
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380011; cv=none; b=uIZi6m4CdLLM+Nw7rA8euElBb5A3Rew8kRuMUpRtQBb360PH5JGAbRmPtJ36cCZQ0aSOnwTw7X4K6dyNDriGwjX0CTiyPGl7M0zjNuP6ZD99fMWGGsxPUrFpNuvqe6NRys+OTvymiDsIoO/2pb4fGifkrC7Wglaj57Wpx3p/a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380011; c=relaxed/simple;
	bh=6TzlgHY+MARSPZ19oPq2VR/on8+SB2WKhJ2qBOrffwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdJKaY9vvc9VDu91EXI7tp2djJOGQVU5otEzUmgKLSX8QpgZyibsv8w9tMRl1cIrG0PEVOyD13Z9CqE/J2s4LZMu/9CIhq2QxhlMweYJTjgEsekDIwJ31S8/7QisCAm4egqs5DHx/afwBXV90MAZz5snthpCEcF83IkCOItWgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05BnybXx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCzURz1U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742380008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+/sdmqfiD/3QPUgzCMR39Mkz8HctLQSqLONQ0HXPw=;
	b=05BnybXx8UcYEZq2c2Fqj1jmweMzT8dXQWfj8ZE/YYR7WZlgU14e6NONufswBIMTOEiGsy
	xgD9h7HX/zbsHGs/nZnlbaDS9o9C8DU12BOP2Rr+HsD0VNhYn7/Y7xN5ArR2rRcgJDWlI2
	oc+KzvTSxGSoyk6xE9qeqxOeT2GXmgYlfEqBog2FfabxCuUO8vgBpIncaJAKK4DN/k2fgZ
	yZpl1BDKVMfpPhSQSBQRm84UI0gxAcKdIsoCCa8Qvs4p3XtqHVHk/EsHjNkTwOR3xdamOB
	xgMlfc9q3/RfJ5HWJtHez+wUPUw+I+xgIfiJADmRppQJwmRQBGyOr8dpqUXuPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742380008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+/sdmqfiD/3QPUgzCMR39Mkz8HctLQSqLONQ0HXPw=;
	b=PCzURz1U5BuPd762fR1R73keKOwcACplnrIpBORBkXp2IV7ImUa427r7TCBc619/zd5e5d
	Tc57feOKxGF0iGCg==
Date: Wed, 19 Mar 2025 11:26:39 +0100
Subject: [PATCH iwl-next v3 1/4] igb: Link IRQs to NAPI instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igb_irq-v3-1-b9ee902143dd@linutronix.de>
References: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
In-Reply-To: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>, Rinitha S <sx.rinitha@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=6TzlgHY+MARSPZ19oPq2VR/on8+SB2WKhJ2qBOrffwY=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn2pvlPC00/+8lNaDwIeJJnwGTouW9qHVvam4nu
 jEWobjLEk+JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ9qb5QAKCRDBk9HyqkZz
 gvi7EACCNfucR34zTvcPkVCIyYkeUWJ3iMQzqmIMcQMy6dmrzB7StjmxO6euGQ57yyeNqZrYfiu
 P/tDLwf7EGCr7zcSiAXQxe50rlreus70PrMziv0EAFPTzYENevRtxEig5o4BxNFeC2wI3nHUiz/
 2iokfnhGj5ngU9WaPHRe+LwqybKHrYrCt7nS0MrXl/VJH4iz4ymW3dPbiKuNWjNOnrxisS3xlIZ
 e3aCtr19RFMWzx7y1vZRTBAJwCtEzwxC41wf7Cik4xjRQAWzazN8AMEU3CJ9dmY/JIvH2+BDBCD
 bvQTxKXbaZDFuqb1ps2lhid34w+vDiPHc3AJ13l1NaV/IR7snp4td6EWB6PGaCdzKcjDeb7Fn6F
 j+puR8JIcUMVxLzlAxHWLAf/Gd0i5m4gc9c9VKOT28LaJUPhyGN7PD0GxVnunoSFOx0CjLFBD1t
 MlcaLhLFXBAgKaiXQQj22F+M8MfsQutSww9VjM3nlknnpcpWSo7253ckUFZKSepUBuOEe+B6moR
 kxuQt00RH8dnpP115rU7jLYTm/ORx1Ms/HRo5uPY6rzULssGmikYig+BhCfoqszet66qrZUHGt5
 qcYjJgIpCOPLFARkFyYBQtKiL7mQGpJ5tkA/S9/5whzlA+ZtwKFsW08j0F8Vw2Om6jllaXopCLk
 208Nx1VVB+pk5ig==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Link IRQs to NAPI instances via netdev-genl API. This allows users to query
that information via netlink:

|$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
|                               --dump napi-get --json='{"ifindex": 2}'
|[{'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8204,
|  'ifindex': 2,
|  'irq': 127,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8203,
|  'ifindex': 2,
|  'irq': 126,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8202,
|  'ifindex': 2,
|  'irq': 125,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8201,
|  'ifindex': 2,
|  'irq': 124,
|  'irq-suspend-timeout': 0}]
|$ cat /proc/interrupts | grep enp2s0
|123:          0          1 IR-PCI-MSIX-0000:02:00.0   0-edge      enp2s0
|124:          0          7 IR-PCI-MSIX-0000:02:00.0   1-edge      enp2s0-TxRx-0
|125:          0          0 IR-PCI-MSIX-0000:02:00.0   2-edge      enp2s0-TxRx-1
|126:          0          5 IR-PCI-MSIX-0000:02:00.0   3-edge      enp2s0-TxRx-2
|127:          0          0 IR-PCI-MSIX-0000:02:00.0   4-edge      enp2s0-TxRx-3

Reviewed-by: Joe Damato <jdamato@fastly.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d368b753a4675d01b5dfa50dee4cd218e6a5e14b..d4128d19cc08f62f95682069bb5ed9b8bbbf10cb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -947,6 +947,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igb_configure_msix(adapter);

-- 
2.39.5


