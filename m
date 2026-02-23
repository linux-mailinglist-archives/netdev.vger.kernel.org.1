Return-Path: <netdev+bounces-260154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/eH8qdnGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:34:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FD17B951
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F5030B8265
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628F368262;
	Mon, 23 Feb 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VL36tq+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5A3612D6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871465; cv=none; b=QvAaHklIB1JeLDrGbK/IBMppWjmztJNPmtL2r6ggTFghSgaus+oWYp8EIH3JOqgqxaX1bghqJCyX1cAPDeTeUMEbSWitbjnzwYAXWdGrC/hPHT7VNMDHRRG7JhXI16eUf+nc+CCI/2AxyFajwXGa4WuUIgJLSF/kOKGUaK80qrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871465; c=relaxed/simple;
	bh=Kdu1cMXgA2XqjBYc7dvRjH7dxfg9Vy4WuG4CB6nfJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5+4WCdJhcOuARlxfTw1Gpt3WfFnW6GzAVFzcwlFkQAk+n7h1EEWhlK4f6A2MfgrWFByYUO07ly5pFqEBVVA0IKjqlMeEBVe8D7DQEAxDdiK71S02/WmS/T5ZA+LUU7H8tM/qz2I4thsvNiM9DAgPVcl9ukOiKS5cRrzCXh+cM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VL36tq+Y; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2157729eec.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771871462; x=1772476262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNnIbQepM7OsxG8YtXelmWTZHGkDq1OrrS+VLi1UfmQ=;
        b=VL36tq+YYHcnLb2Pj+T4XlYEo3uzETDIKhaWyb6z5S6lIveu+xKuGB467pJcnNuBFf
         LIYeFMlH5/GsbZ/A8e03iPAPqwLNtVPiPEQDHqRhrCEJ0+OG61j7YNWT5hZhlXHgjg3P
         v1Dm5EY0EVpxiS80akpdro7fktC4ufNKnCT7A+Qfdtos/WP4sU8b3wHJN00pIjD/XsS/
         KhsaJJJ4uBytQaagJD/abcGH1U1lj0MbJCCf2Nc/tFByl1JiCypHWvAJLR2FGvV6qgZy
         /9LaFbbKzu0LE5V1u7q27fbJuyR5LJkyXGkWiy98X4AQkEn1JxmfV3/LCr9kU1pX7To2
         nIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871462; x=1772476262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNnIbQepM7OsxG8YtXelmWTZHGkDq1OrrS+VLi1UfmQ=;
        b=b5vSpfSs4+o4RGVdov44cvqaQCd33EqZ79OuM2Tf8FGemRAPyZG0fKZvHxy03J0CfV
         MM83CrnOD4MCVxWMiFKlsCsbNssHZ5GycNccqnfIQ2bjhMK3U/KbKXhH25MCdE28rGCk
         msM7y9Ng2iqvaAy+9fOoMWkCUk3HFpWye34Ly3TgCvvYLiyNkV6vXCT1laLW5xXv4t4y
         GxcW6tTUybjSoZdE8sh8ylWfRUC0IeL39QDimQCkXCDkHFcm3Wy6Ep8NkP8VOX8fk9lP
         8L7lpKNbZieH/5yDlMLVu+fXX5Qh8yIkjsbQ1WyRLgz9xBdgyRPT81R6/dCYjoiV5unE
         FS8A==
X-Forwarded-Encrypted: i=1; AJvYcCV6EonOOJvwHJnL2Feh4lWaluRE68VhoyMQYwF232h7eUX1OsOKupvLS41LBtx1o6g+KnF5S8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPJjKC4FcM8sKJjhcI645lp3KQFDaUOh8KfmYkYj3ZJCpy1AX
	3HC2lGjgrriYXLvSg1UFErPw5pJV3SX0OxKOfHKPejAdUWB+f0Yvt6YOr6/E5h65Ou4=
X-Gm-Gg: ATEYQzzbS1a0sA7yxgWEjVmJuhQdSAdd42QzaYJAZpXSOZx++GC0n4m8Zr9lTv/1BwH
	NPZ4a1+mQf+l68emi2BXaqHo/x/5xsThfMPDLPIQeYbhbZoIP90UbE5Gi+CUhn/JXBauLo/ivQk
	vg3lde5gPDC++5rCrLTYWV7VapPUBFeM2QUpBxzgvi5gFUGzFQUQzgX9RwgIRTh2Tdiv1aosOJa
	YMaHpbR0MSrVM9z0ojQWF/CAi9uE6me6GpbK1+vaKqvukhRNJCr0Ulv/Oz+kkpCuTVjp6WmhfKK
	qoMh6i39eruz91vIx5bv4Rg3E3QjcQRzP7+stF4fqb7weqXyDJKLXxPpCldAmq+AbDgxcvE9JPV
	waj2mBeU2GzFFCQMOd3ue1+2ZIkLqapGuaHn4Avkp2hnBGMqzZXpj8j6hxovlef9+fL4HCWU9fg
	2dGkzw1eFEa+NzBq4XPQJYusFFMYdnJmy+ntMJ7HE26d6cDbpPcQ==
X-Received: by 2002:a05:7301:9f18:b0:2ba:a098:ae64 with SMTP id 5a478bee46e88-2bd7bd58cf5mr3962238eec.34.1771871462146;
        Mon, 23 Feb 2026 10:31:02 -0800 (PST)
Received: from goldfish.dev.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2bd7dc169e2sm5814354eec.29.2026.02.23.10.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:31:01 -0800 (PST)
From: Eric Badger <ebadger@purestorage.com>
To: ebadger@purestorage.com
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xprtrdma: Decrement re_receiving on the early exit paths
Date: Mon, 23 Feb 2026 10:28:55 -0800
Message-ID: <20260223182858.1158739-1-ebadger@purestorage.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260154-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[ebadger@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:mid,purestorage.com:dkim,purestorage.com:email]
X-Rspamd-Queue-Id: CF8FD17B951
X-Rspamd-Action: no action

In the event that rpcrdma_post_recvs() fails to create a work request
(due to memory allocation failure, say) or otherwise exits early, we
should decrement ep->re_receiving before returning. Otherwise we will
hang in rpcrdma_xprt_drain() as re_receiving will never reach zero and
the completion will never be triggered.

On a system with high memory pressure, this can appear as the following
hung task:

    INFO: task kworker/u385:17:8393 blocked for more than 122 seconds.
          Tainted: G S          E       6.19.0 #3
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/u385:17 state:D stack:0     pid:8393  tgid:8393  ppid:2      task_flags:0x4248060 flags:0x00080000
    Workqueue: xprtiod xprt_autoclose [sunrpc]
    Call Trace:
     <TASK>
     __schedule+0x48b/0x18b0
     ? ib_post_send_mad+0x247/0xae0 [ib_core]
     schedule+0x27/0xf0
     schedule_timeout+0x104/0x110
     __wait_for_common+0x98/0x180
     ? __pfx_schedule_timeout+0x10/0x10
     wait_for_completion+0x24/0x40
     rpcrdma_xprt_disconnect+0x444/0x460 [rpcrdma]
     xprt_rdma_close+0x12/0x40 [rpcrdma]
     xprt_autoclose+0x5f/0x120 [sunrpc]
     process_one_work+0x191/0x3e0
     worker_thread+0x2e3/0x420
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x10d/0x230
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x273/0x2b0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30

Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it is draining")
Signed-off-by: Eric Badger <ebadger@purestorage.com>
---
 net/sunrpc/xprtrdma/verbs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 63262ef0c2e3..8abbd9c4045a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1362,7 +1362,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 	needed += RPCRDMA_MAX_RECV_BATCH;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
-		goto out;
+		goto out_dec;
 
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
@@ -1385,7 +1385,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 		++count;
 	}
 	if (!wr)
-		goto out;
+		goto out_dec;
 
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
@@ -1400,9 +1400,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 			--count;
 		}
 	}
+
+out_dec:
 	if (atomic_dec_return(&ep->re_receiving) > 0)
 		complete(&ep->re_done);
-
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count);
 	ep->re_receive_count += count;
-- 
2.43.0


