Return-Path: <netdev+bounces-291653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL7NMBx6FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:46:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD35D45A7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0343A304C7DF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915843DD877;
	Tue, 26 May 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reJXFF/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEA3DD856
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792269; cv=none; b=U9CeN3ollPSRb8RNq6d9xPhXQeRjGzXX0C21+2xSs+MXCUagm6GNKcAOOQAAX1xnuaNsnBaaOOTkad9im1SuhJoRbFAU3n6vLLdFIecIa2of/9sHRBwA6UNz+vEDvdvKM5L3T+5YezY0N1WTFSkXV6HzJWPVhXD+xuhE0gXVMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792269; c=relaxed/simple;
	bh=mRpirCObCLZqN6l4iv03pml9AZxIqV3ehKRFmi90YGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ8/TeeDlRnMjHNv+rLUqQ7JPV1diMEDY7a4a0owK+9QAjm7QSQdWGxMzyZKBrklDU/aFIpbmVWTwTCRBMCwp/dWU11yHC7kU7e23TPl3n0/RIgyVks3sw4ODcHLKuR8L/rxsXRS7bNqe2W+AQ0FZZTScdJjE77YBpsgXDRf9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reJXFF/c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8379e010b01so4474797b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792267; x=1780397067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=reJXFF/c78UJzqnKBd0YF1788g8Aq4MTuEdjHKYodYH8J6siskR9kZmN1tT86MG08t
         BBk2yttOebGV87gYtvtQcuhcj8dEKDN7Bq/k6/f65h7pXcydDNTUBcguyTfydAcrCqCd
         QOzS33DpQCzHl5l9k76Q/4SjeSBqMyqOjW/4DbfiAbAmuNXWaEKax7uzJnynUDowOx8B
         p8b4JFP78Gz/CBk0kd3QJ8YErdgYvP7re2Z7Ffz8w3pZncDRwV2lvIsaOBHpQL/7qkHa
         zn2OrPEYYAcvpCxUAD2sTG2RpP9r7qzoeLRMX+46XvNIpqymTtRofJbNMJdIKoC2LvBN
         YpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792267; x=1780397067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=opJenKaWUeIaTFAL8Boerlyv9Te9SHzLWH1bJi4NSvKH2abGtsDh63rChpququXDBQ
         0zilxM7pIK8dRx02nLM8cziWRQJeMhQAhqrunf4deXjCr9DHxLGm9xcYrgAn+5mh3HON
         OUVB8nXivhcN4pjVgW01g2fgoQ24KmNE1h/3hNzxAzTmtXL10uiku2ERwRcifT9FGCgh
         YxleOQeklirO6cHZo2GBLDkd7ywuT/vHrpjnv9+9pRHpwW6UIyDLJWOgRIUusgd/aLPk
         4QkVs5PYPgqnfIuQCiIbSCQ9CfnhwMPH1kx35IImq+dsunTMBV2hJlCWQuR3wyf0Y4Nf
         5OOQ==
X-Gm-Message-State: AOJu0YxqOvJyHBd9++xNITqSf/UOnSkP2J2wQUba60ssRGPD8QX1c+eE
	0JALgvyQOIZ9JD6OyPp2ZzdQFy2xMEhPeRkHvnisNlTGYLFSZYq1Up4gnInGjdtWXjK8qu0=
X-Gm-Gg: Acq92OGRGgJBnzBMRXkzfjw/BQKQInauw5nhJSM09hEKderBpXWkywRBFdccTKgC994
	aneyPzRsdv3G3wuK+Kt8+bhwbTQ9dIkuw/kxkoNtv79soLF+UsZb9r623sgBPpKES7ewjOjWDhc
	3HKeY3pa3Yn9JQdLVkGSXqDh0ZSZn6bG5AdDvB0NXy63HJ8btYqMDSu/rXRr3gZ0PmuW9Dcikwq
	cFaqPke4d8fLeMW9FCW8LjqtQ0kgycA5/aiEWzQOIwum83jeCD2Uq/NjiaABVjErG3Ph3EByIkb
	y5TcC1DBhPfAmPc5LcojoNmRoFFWFjaNHWbTA6if9Wp5tFo0uUhLqCPxk5h5uBknOIxkalbIpaO
	yfEU53G9GEjXlltK/3bcmU8RoyeRRX1ez9Z8YZ/z2LUw199SpuR9GlPpN7Ag6WuSK6c+8DaOfYS
	w+una7X6PerYc8UdNXYDYhZzcal79Z19KPXbgTa6IB1BqSAaRQyQESni6AJOAlAfEtq0c=
X-Received: by 2002:a05:6a00:4c07:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-8415f580e58mr17482367b3a.3.1779792267413;
        Tue, 26 May 2026 03:44:27 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164affc22sm12235270b3a.21.2026.05.26.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:44:26 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Tue, 26 May 2026 10:43:56 +0000
Message-ID: <20260526104356.469928-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291653-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 67BD35D45A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When vmci_transport_recv_connecting_server() returns an error,
vmci_transport_recv_listen() calls vsock_remove_pending() but never
calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
permanently.

Repeated handshake failures (malformed packets, queue pair alloc
failure, event subscribe failure) cause sk_ack_backlog to climb
toward sk_max_ack_backlog. Once it reaches the limit the listener
permanently refuses all new connections with -ECONNREFUSED, a
silent denial of service requiring a process restart to recover.

The two existing sk_acceptq_removed() calls in af_vsock.c do not
cover this path: line 764 checks vsock_is_pending() which returns
false after vsock_remove_pending(), and line 1889 is only reached
on successful accept().

Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
the error path.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index d2579380f5..88ccc55455 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0)
+		if (err < 0) {
 			vsock_remove_pending(sk, pending);
+			sk_acceptq_removed(sk);
+		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
-- 
2.54.0


