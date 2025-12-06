Return-Path: <netdev+bounces-243910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23361CAA87C
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11662301558B
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168432FC89F;
	Sat,  6 Dec 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qeu/TWd6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13D2EBDF2
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031414; cv=none; b=ATVsDQOJrhv12p9RV+4/K2ofyA23pzTxEVU3TdkRbTM8PH5bBrXD5pzyR3e9fiIZEgqmBMZhLkzVhrjoTdj+p9iDQ7KSj9Dg31CT120vQoD3y2txyZKxut6G/tZuMLqbrLHg+Jt1OUjBCtw+2hDpAooCanfSj4meccPGMK+5b2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031414; c=relaxed/simple;
	bh=CviAuRWnny1vn3NljzsJQZkwWC3z4hT2cAWdZtBKdH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3Lm+54+KqTQJk+nfEirq37zpaRkkj/KS6qL17XAa5jKYkpxuVQrO6rEGs0CD9PQUpF7nR/zOIpbJYOvqFKAGh/j5WcluE5++v0vjjN1ClEsKWtHeD88BEqlptkjIrJja6XvbLlqPvy0m1TY80Fizn5kGBz11H/dMV41qlXCY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qeu/TWd6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765031411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XDVqngqwDB0/FBtWqUXffjv+ziMrCmRCEuO7EkSzOv8=;
	b=Qeu/TWd6s45eBvtIyuhyy6WDCc3gD10gbBH9J0f0hTEkIudCU4sGRDj2Y5/CefYGdckvqF
	H+yczYkyDZhsPtE9mGZviqJy/IamFof/JFp1UWcOjPAxWHMpGKfMjN6kWIip+D14/BYblJ
	8uaEde0JNx0JHYE9cISQOLHIx9TGW/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-lj68S55VNkKO5um4hkRIUA-1; Sat,
 06 Dec 2025 09:30:10 -0500
X-MC-Unique: lj68S55VNkKO5um4hkRIUA-1
X-Mimecast-MFC-AGG-ID: lj68S55VNkKO5um4hkRIUA_1765031409
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1D161955F27;
	Sat,  6 Dec 2025 14:30:08 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C738180029A;
	Sat,  6 Dec 2025 14:30:08 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4A47F549C9F;
	Sat, 06 Dec 2025 09:30:06 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com
Cc: kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] net/handshake: a handshake can only be cancelled once
Date: Sat,  6 Dec 2025 09:30:06 -0500
Message-ID: <20251206143006.2493798-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When a handshake request is cancelled it is removed from the
handshake_net->hn_requests list, but it is still present in the
handshake_rhashtbl until it is destroyed.

If a second cancellation request arrives for the same handshake request,
then remove_pending() will return false... and assuming
HANDSHAKE_F_REQ_COMPLETED isn't set in req->hr_flags, we'll continue
processing through the out_true label, where we put another reference on
the sock and a refcount underflow occurs.

This can happen for example if a handshake times out - particularly if
the SUNRPC client sends the AUTH_TLS probe to the server but doesn't
follow it up with the ClientHello due to a problem with tlshd.  When the
timeout is hit on the server, the server will send a FIN, which triggers
a cancellation request via xs_reset_transport().  When the timeout is
hit on the client, another cancellation request happens via
xs_tls_handshake_sync().

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 net/handshake/request.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..c7b20d167a55 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -333,6 +333,10 @@ bool handshake_req_cancel(struct sock *sk)
 		return false;
 	}
 
+	/* Duplicate cancellation request */
+	trace_handshake_cancel_none(net, req, sk);
+	return false;
+
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-- 
2.51.0


