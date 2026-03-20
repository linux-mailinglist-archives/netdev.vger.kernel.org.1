Return-Path: <netdev+bounces-270014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUCMo+QvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D952DF54B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C353325FDD9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B913E121D;
	Fri, 20 Mar 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni3iMJzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0A3E3C63
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030252; cv=none; b=h6jMbkEHV+ax8jNLByK2UfrZTGTwAJvJGVWPvlaAuBvgHh4D3T6yAqL+5HkjIxbUZYF74+XQluxxjvbxFoZkIw/7w0xnFBfa760d6sYWce2WLUm2/0ZYupGY15LN0tWuCsIzpWQxSbkiYPDHfBShehW4bU/RVFC/0LjRIsMKZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030252; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+xyLZhQYQMLE7pJR7HcYr1hkcGL9bixESyDdTx+QJHkXhZxMJMzyAwUlvsu25S5d+879FU8cABGIXcxT/Q01yS0dR0o2eiyFLRucJAQAdnv9/K+uNZDo/yFJxTClQQW5nJ7O4ycTUqye8Vz3SFG8O8vcRY28jwfZKQq81r0/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni3iMJzu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35ba2ae4df3so648380a91.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030247; x=1774635047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=Ni3iMJzuv0zm9JIPpIqMAullCODUQPmcGAII9eD/pBg2BXI9he9MfyDLut/faWLMSh
         iO9w2tQHrORgyVCVkMvtulxwAJR29BAox7alDfH4vxpdyu+wv5tx5jFBHnTLRwy3jJK/
         Fw/lKwkWd6kQj4kyxaiINcsQ+L4cZXWw3BWIR4dilJVsQX3AdQd0WbINLU3MGALY6VIH
         DgdUxhfntXlvvNWI107p3qQklMogB4h2VEc45yIigU3oMnIus/IaFhhbLUVwrs//4FnS
         HFbxfpeyaRjgXJsVXjyPbZL00GlsOXjFfyxfMNUmf6aLbMIP+3O7aY+D+FU7k5tM3i3f
         lQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030247; x=1774635047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=eMdEDRy0NRj3pJcNcjOnOSvInp5L8pGL1Z1xIBKtFmCRkfbkmIZ1dm+V7hdo/beBnI
         OtZeF3NFMorTSR87wEDLRMrkEyR9PmOGhYmllfjEddmvfwc8fgT55BbkjEpxlWxwMsEP
         +CgwYllybd0y1LVeFjuzNElsFYWghFimkLuGtNNEEGECPW0GJ2CuJ7Xmd+akWpT0QX37
         m3bQs4v28Iul1wZB8LOwtKeHqNj8jPNsO7N0CiMzgp7SEjZyEbKkAIlCnyVZSz1lNmjl
         nw+N9Quon2xXhIbCFTTy7LD3iiv2xepxv5GGQwjvm/YprQbZlkPRyr2AA67xHbkvo71h
         w3uA==
X-Gm-Message-State: AOJu0YwadIUakmcDdPp+wWhc8R5DdsMBtmOi+oLeOyOvp3pK+rkUMtNT
	PXOlTo/BbVu8o2DTvuTvrWMLA6yszhFEu2uYF4uMNDXZDfRzjLfiUR5A
X-Gm-Gg: ATEYQzz4acrpU7pwdMiCNxhfzyhWtW26IMf3Zsd0qvTC5YyhX/zZk1Qb0ZSB+A9gzQa
	sfBet7S77wvtEHND8GqX4flazVjU93xsFvdVD0fN6qUpXCUf+9WG4kDU7xeyIWppThTrvnYGPRU
	UrR/l1QVWD1wfB5vaR4KJogRkzC1XVp9gptsOZPTPaOp0CDQAnv32wiK2hNGIaA9u3EY1ndPWuP
	YUG4UBJK+7Idz4v8YwOlD71xlzW/JzGGGXHzSHOm0AaO0HcdUO9ZF/tzlW4EkO+x+nlN0p7GBgm
	VBjYIsNDMR4haNyxQbTCrKpA47Gs8lUX900YRd6K8C2gugtiUnWyPu6BN68K2mKgoMmduAwNJEb
	rNFngf6fUHzm+gv+MxXVKAdHE9ES7UHnrqLxOpn7cw4B0qyVdpvSP+84FCJFQ6kXgxGf1TBAzOp
	eMhmVgI8CzU38190FKrrb7ZRNU6ABDND0dc4uynZmuMtDLZqOwNWo+/IZjy6CnAI+rv7y94zU=
X-Received: by 2002:a17:90b:3e45:b0:35b:a1b6:5bf5 with SMTP id 98e67ed59e1d1-35bd2d79c38mr3132080a91.31.1774030246724;
        Fri, 20 Mar 2026 11:10:46 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:46 -0700 (PDT)
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
Subject: [PATCH v4 2/5] nfsd/lockd: Remove redundant debug checks
Date: Sat, 21 Mar 2026 02:09:52 +0800
Message-Id: <20260320180955.150696-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320180955.150696-1-seanwascoding@gmail.com>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270014-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.864];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12D952DF54B
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


