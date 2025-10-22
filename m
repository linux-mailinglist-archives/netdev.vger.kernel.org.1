Return-Path: <netdev+bounces-231851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10EBFDFEA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F32C189E30C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FC341AAE;
	Wed, 22 Oct 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8dqIZZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB233C534
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160638; cv=none; b=jzCwkzp25623IeO/PoSZxcWzFYxuBLJDcz6egl45Uidfln148lpVu7NkD3yCQVLR3o0NolAvZvUtNGm9hFvuj8GVFLuBdlPQv/tr6yW75ThVV8q/+HHhfhVaaCXHrU2ULV/+ruGoXpTYHLJUQXrH4MqCfrxGxMPT8jD5KFurO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160638; c=relaxed/simple;
	bh=/J2RlkZdY2sF8Fh61PnJSmNy9Qg0Kawdy/hEgg1tHsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QR2cQDtTTG/Fo+BEMUHNukJWpLuzA6liTodvOtFfWgaKVE1HSVDAVbdW3UDkPd2/VN7O9YllyRzka3T+7whiiDwm2abqF98Gi8qKPliLFHmT71aMUXWgKf/XTOKi2BRjWqih+r/siUCgOacB1odSsRblnBB/lVBPdo70X+/zmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8dqIZZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AAEC4CEF7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160637;
	bh=/J2RlkZdY2sF8Fh61PnJSmNy9Qg0Kawdy/hEgg1tHsg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j8dqIZZd9QpsZnzk+lWBpvRjAs12juz9qUMmCJJxtiekm2RlixdWPA5sHQRqWsJpn
	 evudh1SMueBsN+lqhzNVUiFnXFAvqm1g/J1/79TYsl7ShR2xVhBjSJIv/HVQ7L66LV
	 efuha7LNvv6dGLd0zfJ2QiBjMFe2Fns81BT6pqdKSzkHWW/S9W6hphfqMEqlGWTNu0
	 hjlNIKrssXv9EBx5E3rwIAfl3+j1TnW8vOVsMb9Ttecvg70hgKo9wj0Z7dEbttG2VG
	 zI5IOfLwpHG4Vx3Xx4bE92vjGhWrPzFi8Y3oeSye1KD9v7NIFSXRvxgLle19gmoTNH
	 T7lMTFab9JLqg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 03/15] net/rds: Change return code from rds_send_xmit() when lock is taken
Date: Wed, 22 Oct 2025 12:17:03 -0700
Message-ID: <20251022191715.157755-4-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Håkon Bugge <haakon.bugge@oracle.com>

Change the return code from rds_send_xmit() when it is unable to
acquire the RDS_IN_XMIT lock-bit from -ENOMEM to -EBUSY.  This to
avoid re-queuing of the rds_send_worker() when someone else is
actually executing rds_send_xmit().

Performance is improved by 2% running rds-stress with the following
parameters: "-t 16 -d 32 -q 64 -a 64 -o". The test was run five times,
each time running for one minute, and the arithmetic average of the tx
IOPS was used as performance metric.

Send lock contention was reduced by 6.5% and the ib_tx_ring_full
condition was more than doubled, indicating better ability to send.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index ed8d84a74c34..0ff100dcc7f5 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -158,7 +158,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 	 */
 	if (!acquire_in_xmit(cp)) {
 		rds_stats_inc(s_send_lock_contention);
-		ret = -ENOMEM;
+		ret = -EBUSY;
 		goto out;
 	}
 
@@ -1374,7 +1374,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	rds_stats_inc(s_send_queued);
 
 	ret = rds_send_xmit(cpath);
-	if (ret == -ENOMEM || ret == -EAGAIN) {
+	if (ret == -ENOMEM || ret == -EAGAIN || ret == -EBUSY) {
 		ret = 0;
 		rcu_read_lock();
 		if (rds_destroy_pending(cpath->cp_conn))
-- 
2.43.0


