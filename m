Return-Path: <netdev+bounces-268317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH5pEAiIuGksfgEAu9opvQ
	(envelope-from <netdev+bounces-268317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FAC2A1AA4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4990C30333F8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3863377EDC;
	Mon, 16 Mar 2026 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY6qKU6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9B370D55;
	Mon, 16 Mar 2026 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701114; cv=none; b=tlOkhG2I1mCFOv+YJiXUZ1V6GE1swYWYCyRC8LJ75ukrR2AvJEkzfFl3naX95Fz0W+ysufWZq18lfe9HFlm3u064E41xQgikwNQibkwkrOGdNO/sMC0yZtOSZ1F9snH943I5ibLwC6l4xQ5tHYUJC4mPGgb24N/vwof1ctp7g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701114; c=relaxed/simple;
	bh=C8i7l0DSbqE1tF4lx+Rsiu+cCgRxyKdIiVFUyi3jQDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwLSfp5DQerMnH3DXprXNn7uUb4MLvCGQBOQNKXCYTM/2wjaNvlvZmvTnOAWTlTXM7dS/2DI8tLL+jDZtYbKl9nNKjDUSNEhhcC3NMe5iQCL4hb5sPeSx8bF4c2Gi+SNQMZ4jE3oPemlRMibWBKD6d+e69UxTHCumHM4D8lzudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY6qKU6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE5C2BCB1;
	Mon, 16 Mar 2026 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773701114;
	bh=C8i7l0DSbqE1tF4lx+Rsiu+cCgRxyKdIiVFUyi3jQDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY6qKU6hBBfj7mI0SXSZu4yI4wHxA7htPsnam277P907l9/eKTcwW4Ksl4W45yEzT
	 WA+HI4epwJSOtOcFpNJYbHJnlQjHwpxwnR3zcXDt/bRzzMSdVzT2vpT4WdAQ7+qQtX
	 HrPH/S4o5rbCpyEpql+CvMHOq2pLf///+eKwmZuvABTUTnv383PlhBQiY188U6Rzz6
	 /LUQ6FISP6h8gK5mJK1eYuGND73EMb6k3spTSocXzbdTx5yoNgo1uTemBuZvJIbyyh
	 pzoPAkl+qwr9uLA5EuAyloLYj+VOhEJhiWHi2IPI5wWRbCQPfsy7FrEygAB9zjIM3o
	 5AF1bikec8ZLQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	mst@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/6] selftests: drv-net: give HW stats sync time extra 25% of margin
Date: Mon, 16 Mar 2026 15:45:01 -0700
Message-ID: <20260316224505.279672-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316224505.279672-1-kuba@kernel.org>
References: <20260316224505.279672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-268317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5FAC2A1AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are transient failures for devices which update stats
periodically, especially if it's the FW DMA'ing the stats
rather than host periodic work querying the FW. Wait 25%
longer than strictly necessary.

For devices which don't report stats-block-usecs we retain
25 msec as the default wait time (0.025sec == 20,000usec * 1.25).

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ccff345fe1c1..6a71c7e7f136 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -288,8 +288,8 @@ from . import bpftool, RtnlFamily, Netlink
                 if "Operation not supported" not in e.cmd.stderr:
                     raise
 
-            self._stats_settle_time = 0.025 + \
-                data.get('stats-block-usecs', 0) / 1000 / 1000
+            self._stats_settle_time = \
+                1.25 * data.get('stats-block-usecs', 20000) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
 
-- 
2.53.0


