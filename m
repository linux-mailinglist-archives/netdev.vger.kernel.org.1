Return-Path: <netdev+bounces-269458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOx4NEUHvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3692CCBC2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACE123076796
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BCD3081D6;
	Thu, 19 Mar 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoyyoVzv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D535C19B
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929941; cv=none; b=gzkt+/0suA/kBTRSnZ6w2rytnBvs2Iu0B9/YPXF9KKL/AboCQAuvn/QSQDNuOzkKtkBzlm95Tnc+Auv51vmY9LBReBNZ5fYDXmHJJgGMhr2LX+Jt3lk8jKsU3ttBDBivLxX6ESlwWbqf49HdqlGFuuZYU8FEM5orofFeL1s7Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929941; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJfMXgKohE4cnephKU+BpNL3cz5f0vKS7XZCe2R9FGlSwB8rvu4xFmArBxZORe1pDK0+aktNmXG9IYxoGgvt0e20BVtFA8dvsQSyVL3EOXByA8QgoEXkyUfnsoSvFmOe3/m1wrXvl7xJxAYcmkoQZhCi2B0Q5aSAJgcpFSNW5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoyyoVzv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so673231a91.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929939; x=1774534739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=IoyyoVzvsECxsP3yv/jixu1xEUc/cgocezdoKmVWuXp0Z5rRzv3o/JxdFV4Xq4m266
         prQFtBludIfcXysyglZ8iVOoBZorKAtZoCRwi2Z23hljNc+Otx1X+ylZCvCjNCtqy3Fk
         43fNNyX0gI7suCp4B/C+YwEMuApLmBnC69qjNTCBELC+2GY8l/nxUuW73Ikub1faFbEN
         nzQOAjYlJ0Oc+XzXaVegPy3Bf7KTWMzqfuI15pgql2/lymvShhG5pBTs9vmzPwJh0EIG
         rsghQiht5C9TziQNoIcuUk/9RAxk/h+PCgTUsFW1P8OIolNs2jjv6wRLcyTafp56uMWx
         HfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929939; x=1774534739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=Zb+cdZZMGJYLa50Lm1mJg/nhbhYu95LoIH8zWVgYs+cXs0SrIQawvl2u6+XylMBxuB
         b5vkFAtCRlknR8FxUq5HCkeaUnolGErVsruEjOEeLaO98wdVACw0e4P4BsYXqYc8x0j6
         BKb5bOGzYPrBrhMkxwcGfqHL1C18XpDLUCjQzO6SN0hvZ6YCNI93y+5Ab//fjrd4OX3c
         iZC7izdroouAGA0/c/nQZYdX8+TzG4lFUoKXnBrwt3VdQd/hvsTcHpyz8ThQqXLhr6Ho
         PH4qX8GSC1hOnRJq3QZNbK+bUR7tONGr9fqJnrg+eZxuuNSYbI4lkA1CJZ6Lxl55X+yn
         KXog==
X-Gm-Message-State: AOJu0YwC91mKRf6BGCNKKLJINF6NnehyaYc1HSkGpsLHZNAMdUtvSgob
	D4YLDlsAKOBF9QilJb9QBISsO4AkaQdr74Yqru8b4Uxlze3K2g6xPEyq1dSRcg==
X-Gm-Gg: ATEYQzyEhowWGszNxno6YQcFDy2UdCHAWzqeahE55qk5F+YWaTkgYu6/tyxOlSCRqYc
	4vyCK0t+30lfTjVnHwkcPAry6o05Xfsp+Iood1cXhYBXtaAlEjK8qHkWKcDT3j6YdkPL6EV95Id
	59BN7ZL31b1ihZdzARp+R3O7o4PwzhJfjSejhPhFSuwcb580p5TjHLRPSr3DlztQRbCAtVCrI0Y
	whJLY3vsuMIG8kXv0YZCso6w3cs7W+Nqdf1CpIov9ihoESFPZ9eAglITDqHrpmuYb+Bg7Fnxtnp
	xq20zZgDhyC7o+TAlBXQRHCtUvbp9cfUlLkJt5JRFIm7vQfQ5opI/fxhw1r/39zBRYPEhKls9du
	feVRJnKMX3N/abVh4XvAXBzk4OWByVkss+Ah4jC7OylfwPjgEEbNzkcqYBu1q2Cxdk7aXXP5Phs
	72fKxuuH0Yw1OWzHH1PmiXp42WsvrLgE8HTW3pbB5OxPW0AmPeW+ytuNrjbGek21hKaMNNL5w/F
	80xZpGouQ==
X-Received: by 2002:a17:90b:35c2:b0:35a:3e2:7cbb with SMTP id 98e67ed59e1d1-35bb9f2bf01mr6280190a91.29.1773929939183;
        Thu, 19 Mar 2026 07:18:59 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:18:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] nfsd/lockd: Remove redundant debug checks
Date: Thu, 19 Mar 2026 22:18:44 +0800
Message-Id: <20260319141846.78222-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319141846.78222-1-seanwascoding@gmail.com>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-269458-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.823];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A3692CCBC2
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


