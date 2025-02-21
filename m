Return-Path: <netdev+bounces-168626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF22A3FD8E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8233A8E20
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381A2505C9;
	Fri, 21 Feb 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hliA8+pr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE02505C5;
	Fri, 21 Feb 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159019; cv=none; b=k0Jy1bfkDjXnTIQ3gzBXY+xorpPkrMSL1192r2zNq2gGYDB/3kka6pzvmpKSWmEqvmXLo4pYdRp63jqnDhPk24NFPR6o3b62bJqIAYopooLweHjyZPwUKReALB6F9kPAzuGE7kgZ6mWx8l+DwIuL3GfBhVIDg0fnHoZqYbPFsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159019; c=relaxed/simple;
	bh=3hzIHxpLAXRjJOwPpv+sAwNNZc4CuFrSRwM4bdc+CPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZKdHkiUWAjfl3YpwUX+5VI8Naq5MAKUfYs11MfCONleWqAXsGY25ctW5KWGOLJ682gZkbJfVO2UIx0oA9qb/pnmj6lCbGoJN71ZCSZfvEiP41Nl10+6z34bK+6IXLAVz9CGj11B/76V2+i7R89KbQPn8Sem+qxrFVwJrftylLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hliA8+pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C41C4CEE9;
	Fri, 21 Feb 2025 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159018;
	bh=3hzIHxpLAXRjJOwPpv+sAwNNZc4CuFrSRwM4bdc+CPQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hliA8+prjN8M41oRF1yA2qmapNOQCIZLNBAZ4qHQlwVcz8oRhPyjtXw33VHvTNHxg
	 3arCkvWZvuF+g+ACndGa4Yfg2AUvq3qaaAE0OQuX8ORyXi7z4JC6kL77mck7uAp3yz
	 p61wSWYpp7ImXiY/NW3TxXYBXxhQhEFNqLqST+ziERg8Ui/iaouhltgx2yMJBZDycY
	 zVlL+M273idh0s2h1rbhtz6w97RfZlXPYRiXs1YUl6p7b5zHZzqnUYjfklyvrFvjEP
	 qEHIMYuRlr6D66+w49FrjplWAROE2129sOk3l7Yf/jE51FR1NDoSXkgBk+sNdgwdzk
	 UUe7ozwOuPiCg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] net: Handle napi_schedule() calls from non-interrupt
Date: Fri, 21 Feb 2025 18:30:09 +0100
Message-ID: <20250221173009.21742-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* From a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

Other bare tasks context may end up ignoring the raised NET_RX vector
until the next random softirq handling opportunity, which may not
happen before a while if the CPU goes idle afterwards with the tick
stopped.

Such "misuses" have been detected on several places thanks to messages
of the kind:

	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"

Chasing each and every misuse can be a long journey given the amount of
existing callers. Fixing them can also prove challenging if the caller
may be called from different kind of context.

Therefore fix this from napi_schedule() itself with waking up ksoftirqd
when softirqs are raised from task contexts.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: 354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..2419cc558a64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4692,7 +4692,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	 * we have to raise NET_RX_SOFTIRQ.
 	 */
 	if (!sd->in_net_rx_action)
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
-- 
2.48.1


