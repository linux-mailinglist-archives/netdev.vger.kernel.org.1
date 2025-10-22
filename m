Return-Path: <netdev+bounces-231862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4FBFE005
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB7189D46F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D0351FC1;
	Wed, 22 Oct 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW0N37DG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DE351FB8
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160642; cv=none; b=uprKaPr6quU2/odtjuMcQoSgo7CgJasqcTVuo3ROioSjxlqDnFXJmBxAQJzPWh7tY5SCKb1MqdyyAGggN3EJ3iIAqwp4ekhKWPvggRUKf+lGZofr9YYPyYVoh5VigXA+x6WRysnuKZ1EMPEQzxC1P4c+y4mztys77PhW+vfsNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160642; c=relaxed/simple;
	bh=wZgkyP6uwuVcYDn8ubYgpRBva77PdbGATa3CZpOz9RQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2GR5Q544ABheH7A9q6Ok2LlA0sFfixd1UNaD7kyNk8GEYABqV2IxzCjujLPIEDPwM/ZxUwtFFsKKKHfmOM3OnR1qW+RwAtBV2OWIEEC0ovV7uzFb7GQC/Y6Duf6UorbKi7AvsFgSl67hWNHeWIgMNepkFtuWj1MNXguwo5JTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW0N37DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA67DC4CEE7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160642;
	bh=wZgkyP6uwuVcYDn8ubYgpRBva77PdbGATa3CZpOz9RQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BW0N37DG+8Ahnj+xAgAwUjCtWXgW1hSR1R47yjEPOaaa+PuOmBbLrsTDapu3jemPd
	 YKsZkpz0oAv4uINy86cofDVsNK3uNRAwMexvrbhNdkx1dJZx/k3KbPAyu8s3zsamv4
	 MRRBOm74/alNLE4KJ7+OPNrVVJEczJCuNYnYbMALhjTt6VFDnF4JLeIHwuaDVvgQsg
	 9a3T0wvIEakXtWXzKRzN/MzfWXahTTq2yq2EAVI+sMD7bAG5qqr6AD3oGFn/NahE5S
	 1lpKWom5irkFPnSd5BHOHefl43pgDrGVq3tb2mquO7N4iqACZYz9AWKxmZ19LAr+nY
	 m+9Yq0U9vt0iw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 15/15] net/rds: rds_sendmsg should not discard payload_len
Date: Wed, 22 Oct 2025 12:17:15 -0700
Message-ID: <20251022191715.157755-16-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
connection teardown") modifies rds_sendmsg to avoid enqueueing work
while a tear down is in progress. However, it also changed the return
value of rds_sendmsg to that of rds_send_xmit instead of the
payload_len. This means the user may incorrectly receive errno values
when it should have simply received a payload of 0 while the peer
attempts a reconnections.  So this patch corrects the teardown handling
code to only use the out error path in that case, thus restoring the
original payload_len return value.

Fixes: 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with connection teardown")
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 8b051f1dfc6a..3d0d914eb027 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1418,9 +1418,11 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		else
 			queue_delayed_work(cpath->cp_wq, &cpath->cp_send_w, 1);
 		rcu_read_unlock();
+
+		if (ret)
+			goto out;
 	}
-	if (ret)
-		goto out;
+
 	rds_message_put(rm);
 
 	for (ind = 0; ind < vct.indx; ind++)
-- 
2.43.0


