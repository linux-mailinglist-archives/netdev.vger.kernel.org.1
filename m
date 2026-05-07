Return-Path: <netdev+bounces-285322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE8uOI2N/GlhRQAAu9opvQ
	(envelope-from <netdev+bounces-285322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:03:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA64E8B75
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F224301530F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92503F23BE;
	Thu,  7 May 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a6m3YLsJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171A3EC2CF
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158892; cv=none; b=Fopl8Sp77AsKgScF/ons9AackTkYq1KVwHaQSlmbRH5blg5itei6vmLEzd+6ZABiD97borNFr/KCKs/SYOqR6lDXcDzWJsJGdNiMkbYP5bnHR5f8XXDAqA972FocmWcK2PrCm++swwRY7nyQS4caHzBcJ7tLaKxl/Px601H3fFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158892; c=relaxed/simple;
	bh=UTbyedDRTeUVV1pdrTTRSss/23YRKWL9BXtSBu7D7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aYVVtli4TBnh1qlQ3xK0JEMXWH3XFbIbGiUsdfYEpUV3Gz65ZKAkFfYBcRGv9ufiaU/aDMi1rUrUQxg4jE9nQMvlMsdYe+htfg+Awf3eoL79N3QL/gjLVKRXbI3ygpjdn+Z/rmVG8Zo6xtzBHZ+WNz1Z/WuHKzzzjoJ7MIdLr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a6m3YLsJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bc264a50e7fso158747266b.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778158889; x=1778763689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKh6RuNwI3PSAF3V5smXaq0tngEj6fdP/FsqX2SYb5o=;
        b=a6m3YLsJjdxCWHX3Ki7d8glV3hRZQWTA7eTekZojK133TGn8INupmrv+t6/VNIMea2
         p3DfmgtDVKZae5Xibjxl6eUstniZSzSSQThsNr5STVQRzLcZnI3OHVDOZ27+4wwDXUb4
         hImTUZJ3vcP9tAXOuy9tBMN7i2L8Klo2SUoTGU01imhiSok1ubkcrjTXLz+bCX2Hppbi
         /2m+O71H0ZnjVUtmRwybjzfNadEfhu/Lm+oF394f4M6arf+WKmz9FLwc7VbdeeD2fkVa
         BXUI5iSaGzy5UzEi5zgFrlXi0COEo1b7OsMVE/z3j41isKBogYVY3M54LDAtzO5+SSun
         LXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158889; x=1778763689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKh6RuNwI3PSAF3V5smXaq0tngEj6fdP/FsqX2SYb5o=;
        b=OlO5UOCFUPLego/pPHWD++lB51Pq0UtI9BvRg0QgJZaqCV1B2DXSfFmJ/8tdy+2Iio
         O5X+ImnvxQqT0fzoOh4P4ORXGURXFutQ0GNOe+XyVzfA3oqJFHcDgW3o/DCbS2Q+wa6c
         Nbo629jvEo9+0ueqO2XlLITK8VlHIKsPhSYwI99QV987p+sqkx5WpYd/13zhMjobCuIS
         2IPVDMOKeeFlqTVzm7Ux6bEilbfaftiqiMMVylCLW2OjwRqm5IKFYBQ+f8DlpJ3XhaHL
         AUvWjgkfYTZoamB+RJ83Gv3QUMJevW+TwF7xM+YellVDIGYLUXhN4UCVLWbB+yP36QeR
         JVVg==
X-Forwarded-Encrypted: i=1; AFNElJ/YBHH7+B+isoKF8t1jSVfRE8I9d7MkFfub40t/s8Y36s7ujbRpO77aqpW+g91ZilH40sMdVRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfnw3kLkKRW3NVuCPP1s590oMDCHJtFXMaCTyvvhErn0SeFmZt
	7bxDqvYPJ1QRsqKakC7Q0fywlSiJGcrDmXA+Pgx4/MctRcBfYPIpcXGIhkoPpzHVOpg=
X-Gm-Gg: AeBDietih4GRjkGL6G/SMni7BP3Xrj/U0LTSNDtjJEiaQ1MNwhWDHy6a0p6wyRn04yq
	9FnCFsW9yxzi8VlrN7cY/8Xxr9fydgwImE6cYKmJFcM/Xsxsg1VcTHUPSfTTsJpUKC5EEjfoCvV
	BaP2KC5EBOaJvVO3dE3LcvFk6FIL098B/vAIVbmI7Jy1VwcKGeeZn6/sSyaiWRVYeque4UlF/vq
	oDIgprLkY5ku9dv+x9QYciWouFzDbg9nLVkFcSBCM4zrHJ2QvOWvqFqPNXjzhZp6Sso1RrElxkM
	6c1dV60WPiy1qA1LNyAX6HXhX1LVzYBOzyDqtDWNsuN0A8sAgCSzYLGy1sjaOZ2qIfmfSi7zZLB
	Pysk8thvDlhJBY230i84lX8Pcqa4x0NGTmxwb+wYSICkVwHWzc6xwR1XN2VDKdUuaWNeUQJ4VGJ
	imukBo2F4pEU1kt+M4lFvL1AOB4Aww/uwOtE8zkITxU79kKrwWa1daDFKBVpr9QEfdABIA
X-Received: by 2002:a17:906:6296:b0:bc6:5f97:8f90 with SMTP id a640c23a62f3a-bc65f979012mr319165266b.3.1778158888881;
        Thu, 07 May 2026 06:01:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm19303795f8f.7.2026.05.07.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:01:28 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
Date: Thu,  7 May 2026 15:01:17 +0200
Message-ID: <20260507130117.252825-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADCA64E8B75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285322-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- Commit log improvements

- Rebase on v7.1-rc2

Link to v1: https://lore.kernel.org/all/20260430085412.96961-1-marco.crivellari@suse.com/

 net/sunrpc/xprtrdma/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 61706df5e485..1a54993f7ffb 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -484,7 +484,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
 	trace_xprtrdma_op_connect(r_xprt, delay);
-	queue_delayed_work(system_long_wq, &r_xprt->rx_connect_worker, delay);
+	queue_delayed_work(system_dfl_long_wq, &r_xprt->rx_connect_worker,
+			   delay);
 }
 
 /**
-- 
2.53.0


