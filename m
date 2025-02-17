Return-Path: <netdev+bounces-166955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B9A381BD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A128116DE4F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0C219A70;
	Mon, 17 Feb 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsdmBp+F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP8TmQTW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5419F104
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791893; cv=none; b=bjFGQk5Qg+J6eH07YZrTH9/Uh5HlvnWN+8IliGjsPxg4j56DmpjhaPG6HqukXuY4AE5zEbj14noxSm2IxBjaF+NpxeZhJJKR6zGd3xxn7nMUGyCIFiwQsoqqpCLIKL+Jz+K2QkMqd5VNBDU/UKk3O37+q4qqUaAEqOd4CFT8t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791893; c=relaxed/simple;
	bh=TtZz99vKM9/8yQH1WXB2BwLLyCw8TnG96hXFTpksGGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nr2kSMYq5jyPkhyyDyp5OKEOJd8/Ow2uXnfxyPhli57VVs0w4niEhEl+Xg5gOiqhDh1FNBglXaseXr9+iAZCSk6WqFHVyeBH0JJsU57dOvXd3Od1m60CRPLAoMJ48GpBL3rFskUsqs/Ql/6eQGEia9XRwm1N5poAAHvldOIMMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsdmBp+F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QP8TmQTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739791889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVc9j7/qBgSV7wzxHD/CZaV50VjQdbtTLbLvXM1LLXk=;
	b=gsdmBp+FmA/4OS2k87WBj58dweO0+W1WGcsNpY/HudN3KImJollf0eK1ewglNoffGkfPFE
	C73JLa6TKw6fI47iEk2Yl78EISUAWFe4rHguMswG1Kvl30t/aDIRfzzBVtvQjW0HKlGZWZ
	6WdOw+VWINgmUkvP1HZWOlsusdFNXYyFATqR8NgV6IcBtSa3FdLjqzOQ2J+CufxkF5ge/k
	Yr1WVJXH3N684deBeTLsCulPJjG3sq55ennuZfNnmjOZf/T151aucrl/WHikDPm/p3k6Fe
	b3ZoTPgdUhS1ACaINagS0UrnrdHds3IbCBK80j1SeT8FeNnvMV7Mhw5bgzrj+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739791889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVc9j7/qBgSV7wzxHD/CZaV50VjQdbtTLbLvXM1LLXk=;
	b=QP8TmQTWbgUp9ELtDBTqt+yyQtLZws6E19zJHIXuWNUyK0f9IoB/TIxap2XbUTMMg6CmfE
	n1PdZ+gJ185GQbAw==
Date: Mon, 17 Feb 2025 12:31:21 +0100
Subject: [PATCH iwl-next v2 1/4] igb: Link IRQs to NAPI instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-igb_irq-v2-1-4cb502049ac2@linutronix.de>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
In-Reply-To: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=TtZz99vKM9/8yQH1WXB2BwLLyCw8TnG96hXFTpksGGA=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnsx4PWYhwX1ccbNCgJJX4M2gWcQnM6Bx5Ya6et
 JfJEl2OOh6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ7MeDwAKCRDBk9HyqkZz
 gittEACRAhFvRx79/IJ0oTIO5tk9AjgOOcpQqPMorxfyXTtCkLV6y7i0YFHIEVWoIkq/W4AZpFe
 5ui/kDvCPjOPzHPwuoWVOjfBZrBdIICjL0oh4MCY/gA6GU88SXLLRB+rhzcdveMPGGOd230Md6+
 WupXkcAKHk2gtaRLQQXKFXqfsBW2HVl87j5AOj8oge3wlb0Aw7L2sjlxwzIDoGnysEm+zSLc+Aj
 UFxbirB+8EcvFRHV0X47Z3h89nPWbPJ662XXmMvG011NI+jEXgLXUKosS6TFRQE6HWq+AuIIQPT
 3hilKY0RBhiQeKMxvx6QCgvHhDTMqHeACv4j+VEN99zeFIRurfvzg5QLFZEv2fFz0xpCccqFh+O
 7VbnJBYokNEwSqAB3iFFp6IgmlwRe6FuNOrYmy0n0YNqTcke68dIvV7yeL2T7aVCT4zINAeJQJ9
 9G8tVCH3M5/tsOZQa5Ln8lFvmp1I4RNIhIyqMLVu/YQzkBlm0QOMt+RZI+JPZpMy6ZBoh/a0UhB
 gmamiFPSeb4a1cbYyBtKq3wkvAj0CQJp21UDb82gWTXkT+P3kVViWNtb2VlYhXWmX+aapGC9C4S
 m5wny2EI02DC9OMrPgMoqWMdTG0GPT+qPAuCo1SOJ76QBFwneUbocrXH0HK3MnUcgKmi++83Ig4
 RqzTnC/xNueWIuw==
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


