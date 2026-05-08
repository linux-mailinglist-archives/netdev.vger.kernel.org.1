Return-Path: <netdev+bounces-285671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHw3Mb6E/WmefQAAu9opvQ
	(envelope-from <netdev+bounces-285671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:37:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8524F283D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B77843002D16
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2335836E;
	Fri,  8 May 2026 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vXGQWRFM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFB36605D;
	Fri,  8 May 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222261; cv=none; b=IHz6nnkUyMsQRccP1iIwGg/8+s7p0I2rxCVdlCO6m09nLRRh0ueRJPXQg18YCY/y0wYZETGez/Fll1dAblfPPc0T3Ac3bcDx5yMCovY5E4FJPVPdH0we7DGkp9pwHD0SwlQ2c1vCZWlJ1MIACSFZeFv4lf8ixv3XrZ/wUp7DM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222261; c=relaxed/simple;
	bh=kILxozLP+dJEj9t9l8R2ZH0ViiSI2+DrRDrStPIeXxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSFupjdopsdUVf4+S/AteDz9ABZALzJYkYTkem85IQl5i3P7Mc6zwZjmoDDHA/hs1mVs0xqXbpszCkP/eMi4MCruhdt9s2vFpUfYNzxkuZ8Afer2JG/oij9DfLHz+TL01QTMu5Lr7ubuXKCGtLozWhAe7SMjRkTO3EXExd4X7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vXGQWRFM; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778222247; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tjGgmjermday5b3veHqFYVSslxKKd4svOW5ucg2u88o=;
	b=vXGQWRFM9j0QEbpa73V5DbjsFtlMy1QmsUm+g8DlyUBoC05uYFV6GuaF5/Ekvj2VNoODo77EUpcYEq6rVhY9720AbT0ypeJwc3UzVpkmNisaxd+PGHmk5umGPdiglcSiYGmUHNWYzxAJbUZzb+s51kv+T9F1MxDZM5kU6CpN0Oo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X2WYxae_1778222239;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X2WYxae_1778222239 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 14:37:27 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: [PATCH net-next 0/2] net/smc: transition to RDMA core CQ pooling
Date: Fri,  8 May 2026 14:37:16 +0800
Message-ID: <20260508063718.101622-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA8524F283D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285671-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series transitions SMC-R completion handling to RDMA core CQ pooling
via the ib_cqe API. The new completion model improves scalability by
allowing per-link completion processing across multiple cores and enables
DIM-based interrupt moderation.

As a side effect, the increased concurrency can amplify contention for TX
slots on the shared wait queue. Patch 2 addresses this by switching TX slot
allocation from non-exclusive wait_event() to prepare_to_wait_exclusive(),
which avoids thundering-herd wakeups under contention.

Patch 1 replaces the global per-device CQ and manual tasklet polling model
with RDMA core CQ pooling.
Patch 2 reduces TX slot contention by using exclusive wait queue entries
during allocation.

Link: https://lore.kernel.org/netdev/20260305022323.96125-1-alibuda@linux.alibaba.com/

D. Wythe (2):
  net/smc: transition to RDMA core CQ pooling
  net/smc: reduce TX slot contention with exclusive wait

 net/smc/smc_core.c |   9 +-
 net/smc/smc_core.h |  28 ++--
 net/smc/smc_ib.c   | 113 +++++----------
 net/smc/smc_ib.h   |   7 -
 net/smc/smc_tx.c   |   1 -
 net/smc/smc_wr.c   | 344 ++++++++++++++++++++-------------------------
 net/smc/smc_wr.h   |  40 ++----
 7 files changed, 215 insertions(+), 327 deletions(-)

-- 
2.45.0


