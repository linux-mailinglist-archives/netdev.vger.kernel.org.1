Return-Path: <netdev+bounces-243356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF188C9DBCA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 05:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AE3A5296
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 04:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A823D294;
	Wed,  3 Dec 2025 04:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B32A1BB
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735401; cv=none; b=N4KNYy5W5PlFhBbswgl3JO4MIX0f9BCjP+TDUCnVFfQBX+9S1P7PomqvlE4VCftarVj5VLNLDqVr6GGanH+3lUuZ5VeDj9YPPNkshg0L15qKD0Px1rusc8WvWGq301aJNwrCS01qnWGBXcUdO+n8jPnQ8+HwN4v/KpZd/34p5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735401; c=relaxed/simple;
	bh=vlILOzbZNY3COdT0kEPHK07pGdodIaGsMkBzzQC1QLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANOwe3sq3L8+TtqMW1c2y3L+Qn5RWogY1afzrl/9fmKZ1py7wxxuCV8UnYZ10ap2QbI5fWCc7EFZSKduL88Ta2SzOsYj1wOpVzOYiDWSC8tQc6CKLVMqvE6pLh6HRMLPuypIyIpCwhj1sUKCqAYA1S7QRIgtAJMUPxQ/lIosgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3692fb8e2921-6a238;
	Wed, 03 Dec 2025 12:13:29 +0800 (CST)
X-RM-TRANSID:2ee3692fb8e2921-6a238
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4692fb8e7e6e-98573;
	Wed, 03 Dec 2025 12:13:29 +0800 (CST)
X-RM-TRANSID:2ee4692fb8e7e6e-98573
From: caoping <caoping@cmss.chinamobile.com>
To: chuck.lever@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	caoping <caoping@cmss.chinamobile.com>
Subject: [PATCH] net/handshake: restore destructor on submit failure
Date: Tue,  2 Dec 2025 20:12:49 -0800
Message-ID: <20251203041250.967606-1-caoping@cmss.chinamobile.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handshake_req_submit() replaces sk->sk_destruct but never restores it when
submission fails before the request is hashed. handshake_sk_destruct() then
returns early and the original destructor never runs, leaking the socket.
Restore sk_destruct on the error path.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")

Signed-off-by: caoping <caoping@cmss.chinamobile.com>
---
 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..89435ed755cd 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -276,6 +276,8 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 out_unlock:
 	spin_unlock(&hn->hn_lock);
 out_err:
+	/* Restore original destructor so socket teardown still runs on failure */
+	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
 	handshake_req_destroy(req);
 	return ret;

base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
-- 
2.47.3




