Return-Path: <netdev+bounces-271817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKrSFramxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:23:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB932EC15
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEBF6309F4B1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591439281E;
	Thu, 26 Mar 2026 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hY5czpNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67E379EE0
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495210; cv=none; b=ZPXR1eAq0QwIbYEGpp2TSRVYsT8o/0BPrd68kLz/BML92NOOjzf5DO08luUgpITCPrkfllln11Xx25IEFG4qoHtZdemyawcNcmtj9YYqWwE9oS0ZHD+YNHbftQMUanUSsQqbCNQa7p2xMkl8LQAOjoCD7xJQSTzK9k8Wh5X7nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495210; c=relaxed/simple;
	bh=B35YZXWqdn9rlMfOAKXbsgwqM7a0SmTIdv6Czba7vgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0dhuVmG8BvBPUc/CYIUJ9OrZ6/KGsLscm8jiEHxD/KEyaOi5ps30yafsA/LLu+D5GLH3dWeI0udtJZDPz3tMHsDRB/1c14mcs/f/ucXCunaWDMMQF6vRJfSqpkD8F1ZG98g/uOimYBSWykw87yOM6Y9mmXV8R1ZxTiOFE5wsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hY5czpNS; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso630979c88.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774495207; x=1775100007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35y3hEVWje9ry/w7SYsqM4jky9SpkQNVHtjEAbg4o2k=;
        b=hY5czpNSSra5c88+Ndn8mt6yI0aSQrh0RPTS0Sqa37otLx2sVch0xIiJ3eRp/5hlPb
         tbWwyqcJIEAS4z1To05ksmXeGHaWW/38VXP0q6MANG6JIyO4hHzr4ufNGn2AM1teM9Nc
         6lGku1DCjA3yYFlp8NjIx45TDzeZfuhs23s/QFl+GutnCk2PxFKR1GRz03ewM3k133xx
         rIV+uh9cPUXbO94rdjw+9l/r124VAtS1fa2gOpZWv3CfUi0N1chQirTvDpWBWx0eKtKT
         JOJqn2PP7bpgFNd4P81spp6xAXM0r9mw5YFk9qv5UMEBazld443nmDoXRkuD7DS+WLxN
         cZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495207; x=1775100007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35y3hEVWje9ry/w7SYsqM4jky9SpkQNVHtjEAbg4o2k=;
        b=FAuFa4Kxrnv5RhADC9lmEXzPfiC2W/g8BPVyd8ToeA5lD6cGalpAwObc5+PylKb0fz
         py9PTWD70Axugn6xH58qdGpFvUhHbKgHHMUTlKwKaNvXbTGDf+QMeDI6ym/4ZfggsMmz
         f7Um79rb/6TH4lJXNn07h50yCJXDNVaKZX+GO5A/lf+nmj3vs8nrUCI2f2TJOu7mctMt
         KZlp/68/s4TNxvPJ7ReRG4roZnCQJd9ggtPAg94CFcdHf5zALF6NTRlx7j0wEVqYEgGV
         ihUFRM78K6JAlKlWKa40no7fOzXIyH+vvGjnfrhqti4PpiJN3gM+8f+vN0VL+vQwmUN5
         iVeg==
X-Gm-Message-State: AOJu0Yypl5hub6qj2yKk0f3M0po/CDOJD8TLFdKokDrSxdenT43ctYHV
	X9cCRl6r2nz8P4GKZJCkkG1cp6WiQZzxzDEqJ8NHdgqNxDzMVvBrryV/aMrtVl/tgti88Mekoyw
	/SgyBPQ==
X-Gm-Gg: ATEYQzzCuA7jTZwMdcTQxyUpO0m69ED7yFBGCgFpbnIbfzXDa4lZtmPdqsnsMGyOt0G
	0KNX11oPd/n3bTqmTL66z3C6da87EHeDRxo1Fu3zNTYUBotGdrFZL7LNOJeIICUg4ggC/etsArD
	cxkA/bpN0vbBq+E9MvHTjbGPMDm1kZ71KdC8S3CzEQBLGjLUBur3YsPHKgXMRJUJDO7nmU8ZCAS
	JJ1TuoccSYBND4CTUG9FZetEKwx2dvzJPud560oUE7uaI3uH1Z8blfeY1CXWBY33XpVdEmZaqA1
	8pvl2YAtei4V22mT5hXBlhuQb2s7FAAO7tJrDK/9QRmj4cXaE+rl9uOtDg4whe9gj/dVt9c2j33
	L15AdLD5QNVyr7wpKphwByzm2FnlE6NY8hL46N9rQ+tJNdE1fEl0446xqVl0uscX+bTe6p7niCi
	atrYKilH2nqNFhSEm2IRepbad7F6GrC2QOimSmOAVppSXox4xoqSypbw==
X-Received: by 2002:a05:7022:6b8f:b0:11a:6424:f40f with SMTP id a92af1059eb24-12a96ef7784mr2934877c88.36.1774495206713;
        Wed, 25 Mar 2026 20:20:06 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7827e02sm2561787c88.12.2026.03.25.20.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:20:06 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] bridge: cfm: do not reschedule TX work when interval is zero
Date: Wed, 25 Mar 2026 20:19:57 -0700
Message-ID: <20260326031957.3299500-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271817-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: C6EB932EC15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ccm_tx_work_expired() uses interval_to_us() to convert the configured
exp_interval enum into a microsecond delay, then passes it to
queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
callback re-arms the same delayed_work struct at the end of each
invocation, forming a repeating timer.

interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
out-of-range enum value. When this 0 is passed to queue_delayed_work()
as the delay, the work item fires immediately and re-arms itself with
zero delay again, creating an infinite tight loop. Each iteration
allocates an skb via ccm_frame_build() and queues it for transmission.
The skbs pile up faster than the network stack can free them because the
worker never yields the CPU, rapidly exhausting all kernel memory until
OOM deadlock panic.

Since CC config and CCM TX are independent netlink commands that can be
issued in any order, there is no single configuration entry point where
rejecting interval=0 would cover all cases.

Fix this by checking the interval at the start of ccm_tx_work_expired()
and stopping transmission immediately if it is zero. Set period to 0 so
that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
restart it later if a valid interval is configured. This also avoids
transmitting a CCM frame with an invalid interval value.

Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/br_cfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 118c7ea48c35..688c51250630 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -274,6 +274,13 @@ static void ccm_tx_work_expired(struct work_struct *work)
 	del_work = to_delayed_work(work);
 	mep = container_of(del_work, struct br_cfm_mep, ccm_tx_dwork);
 
+	interval_us = interval_to_us(mep->cc_config.exp_interval);
+	if (!interval_us) {
+		/* No valid interval - stop transmission */
+		mep->cc_ccm_tx_info.period = 0;
+		return;
+	}
+
 	if (time_before_eq(mep->ccm_tx_end, jiffies)) {
 		/* Transmission period has ended */
 		mep->cc_ccm_tx_info.period = 0;
@@ -284,7 +291,6 @@ static void ccm_tx_work_expired(struct work_struct *work)
 	if (skb)
 		ccm_frame_tx(skb);
 
-	interval_us = interval_to_us(mep->cc_config.exp_interval);
 	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork,
 			   usecs_to_jiffies(interval_us));
 }
-- 
2.43.0


