Return-Path: <netdev+bounces-270218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMSlFCGovmmKVwMAu9opvQ
	(envelope-from <netdev+bounces-270218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:16:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA12E5B88
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83E6A302DF81
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7966A38737F;
	Sat, 21 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmA1Qbi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3C38C420
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102534; cv=none; b=jmehHoZbOs8AlMHSrQ82V1wizylUu510573Vc7Lgh/Fso2k2ca90vVjxv2xYZ54h2lgCHq8DE1g5rCdaLz98m10xF7arx58+tOkgdPo9dacR7sAKLHrjFUs6Hgtyiw95g5eJQjRoTAaqVJ6WrfYu2e6HZkYJu+V/nTIOVp0anRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102534; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFAgmYA1cOIm9sjuPe6cmGP+/RzusDDQMNU3efwHOX+udBEaWFmph+SWXfc/TW7hfEHJ3N+bU2KdJH/K/+3U7jHytsL2sTe9fuDzMJOq92z8lJ4fa6EfL3WXc/3jSE9HbZY0FtkIetjdYU4YG/Do/UgtFfv3ir9+S7bmHhf32TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmA1Qbi7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b07069e2efso15966305ad.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102532; x=1774707332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=kmA1Qbi7DWrr9wl9XxgOyKJhSkA29clirNv3pc+8FNyfYWZfax1HO+vyQ6xk2LozBV
         FC4syXzVAN1JdWuKVr4x/PBBP6LyTIAUMeKX2xw3lnkZ2COVn6sFOKnzcggj93vn/NbW
         br+Qre60lyv4308OfJrpy2WbE7hMgkYHjpQ1sLWD0sciNCGijeth8itNh/kjuQtv56XJ
         roaGieRghEE+sF9bDYqeCGy0n6rbotEWX1fyaC9iyIE1rQPfJAhsqaUNRtTXJPKmQ7HD
         nTZzclu0tpZQ9wBDsPwgTQ2RdhFuFOhyU44Rx+NhFRAS5Rs387BC31Bv3PnRHbk/8iup
         XotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102532; x=1774707332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=mB752jzOWJaELN9fKErkUwmXsY+88tkmkq1IHdtZndpQTZ5fGp48q/KccH0VTTwtXW
         P6nKmQ915n04+g2alXKIL/eyDWzmzMe3T+t+NwsHvU2ZyEblsA9YjHrlt6ZIF2tAWZn1
         xEbUic/yWG1KOS6XD03bZKLxpfoDnoSG1nRHTkFuBhWmkOwlG+L2bDf6SQWuQVjjfQMf
         oqEnHy7CPteUbJEUztKrBNWgzcfCssapI4QKuz6K5yATeD/XjcTz0W0Ff7hoHtPByZwr
         fUPK65KkFdXXOOfO8lB0CP0MOL2YExT2FVALAJe8cWZj6NhyKMnPbn01IRetDqocjauY
         XHsQ==
X-Gm-Message-State: AOJu0YwH5rhHh6lrj28/jgpNP5nNvzovyfQkj5YX16otf+uYMAszsG9E
	xjwSCI5gfIuXTkzZLMZNlTETLFZv3yzaM9iIZK7qCtTDgG8A3l6fA+OL
X-Gm-Gg: ATEYQzzk+ynjVMJeErf7T993uXQYnrLHLyr3g1jyQVgD5anN+OI74B8dtzykDZ89jlr
	uBEoUDyjclU9se+meuvt1xCjkJ75+Driad+vn7c1qcRXWso6Nd9ilgJDb9dtD+t7o944ZRcoto/
	h0svYgDINzrHduosS0K7BWsRloi/DBlkgOEJuuLI4FodrjTchn7tfyPv8fuKW+VmkbhHPJ477W1
	XcTTieVSAu2VwWVA+l4Bk+pDLOM8PVQxPJ3ZI9fQFLz8FgDBURTOdgv6PIZcnRm0EqbBq3+iDdZ
	A54mliql8Nj9QPgL1fH/V63LNbh5rYSZoliqOfj0YDnIFEhm1R85foEIHdYOnY/LUS4Bmnx694N
	kBhpiJ0uoA/P9AXfDIyn9E2n6USgxi0vha12EkuvTGQyh8HRhriDet9qmwGkvohxkh7oByojmzJ
	pH0vGHeFYt64D1E3I2OiqtPafD0KEZE9yRsSbWnejX40hsFGuA4V8CbdYFSiAbb9CGxq1ALUc=
X-Received: by 2002:a17:902:ebc2:b0:2ae:a8a8:92f3 with SMTP id d9443c01a7336-2b0827de557mr70039135ad.44.1774102532655;
        Sat, 21 Mar 2026 07:15:32 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:32 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v5 2/5] nfsd/lockd: Remove redundant debug checks
Date: Sat, 21 Mar 2026 22:15:07 +0800
Message-Id: <20260321141510.68214-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321141510.68214-1-seanwascoding@gmail.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270218-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1BA12E5B88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unnecessary IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards and #ifdefs
in nfsfh.c and svclock.c.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like char buf[] in nfsfh.c) or static helper functions (like
nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
completely optimized out (no stack allocation, no symbol references in
the final executable) as they are only referenced within no_printk().

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/lockd/svclock.c | 7 -------
 fs/nfsd/nfsfh.c    | 8 +++-----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index ee23f5802af1..9b978a087b3c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -47,7 +47,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 {
 	/*
@@ -74,12 +73,6 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 
 	return buf;
 }
-#else
-static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
-{
-	return "???";
-}
-#endif
 
 /*
  * Insert a blocked lock into the global list
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..91514326d1b4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -105,12 +105,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 {
 	/* Check if the request originated from a secure port. */
 	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
-		if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
-			char buf[RPC_MAX_ADDRBUFLEN];
+		char buf[RPC_MAX_ADDRBUFLEN];
 
-			dprintk("nfsd: request from insecure port %s!\n",
-			        svc_print_addr(rqstp, buf, sizeof(buf)));
-		}
+		dprintk("nfsd: request from insecure port %s!\n",
+			svc_print_addr(rqstp, buf, sizeof(buf)));
 		return nfserr_perm;
 	}
 
-- 
2.34.1


