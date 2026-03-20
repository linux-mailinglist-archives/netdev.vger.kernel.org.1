Return-Path: <netdev+bounces-270016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQsAamQvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:23:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6512C2DF563
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7632326E67E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7903E51EF;
	Fri, 20 Mar 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FclW1RY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D503E5EEC
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030257; cv=none; b=eEJ4uH1NaNV02Hg/bXm+8uOqv4gFiGVehWuEh4anK5mh7u4yCIFPqovV0fGx/Btr7GmiyK+Gbm+LuYfAChlafodoAhDVjSjB8/xc4BxADxo2ht9OChUyndSck2qEUB5bsiNk4kSCGffyDzOfs7DW9+pkgBeK4BxBNbu7lFQmwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030257; c=relaxed/simple;
	bh=sZ044YpPu4R5dXrNGbenZJqvSeauBzwp0RnljpfXqow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8IoZhRj1V+9vMoDCUvx/aS/rJQFv9iZIIhTk/14WfjcPJh6B3ZV4jOfJs//7AnfraSchFzF33YyocbgXCSkAe4UyFdKSRAsIB6fIZO1ZjyNVpiGnek9sfL3Pu8b1yDUf+DDGPz2XVGCE8uMD50ErpewU3z8tyDLi2dHTBMa9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FclW1RY1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so1580638a91.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030253; x=1774635053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISn/U3wnVX56vQY00IkkHQXLUWsuK0LhCSEUHY06MyE=;
        b=FclW1RY1IzKS2ohmjktg7a8TUhDqAQ3MwXtYQEzHo+PRzCm2NMXAI7Y93jT/IefNNp
         xXyRhb4+H0nW5fLbpxzM7YJ5W/7sCRaE7cZT/lvII+tdAvgAA9OauYGWUfFK7lWKvhd7
         L0qCNnLPk7co8nyMS7pyRAiu7F2pC4RsUflsAF+L1DrFSMu3HcCbODwlnB06R+McNjM1
         G4B//ZUPZKSrIvHIjj3PgyHaMSZ5UfaTDkR2hjdhWHtVHDjDunZ126urTbJKD6CJkKI9
         YqbhOrr43jpRlbx0ici5iu+kVyDkA+sKXqV4LPYP+f50Sb8qN+Su5qIhn7vef41UETvc
         n9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030253; x=1774635053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISn/U3wnVX56vQY00IkkHQXLUWsuK0LhCSEUHY06MyE=;
        b=RueTLtB6FLBH9cwhq/YwzSM+pKihdnOtMfqVaRI1cGr0iAakzEwfikEDKyf4svjQnR
         NeFi4Y8lslGfW/wysIZLzuFhrOFdJ0+P88RMbBeCoSwXdqPLGxKVrnW976NOFtp3MHhW
         xEl3WRHPY/3gVxOpAueFi6CCQLTWlQWM1CQtPlTbHPEedb+hEibvGB0CF5bw1z9xt+g7
         1JWO+q8kIpUY6BeMuPyuxHH8QsBiFljJp7dXRQrLO+Y7xOwtpbZs8GQp3qIo+YW1mTAc
         MGGXzcD6DeGNU/Xff61xBSMebu/zAsWQ8YVKX/STS0YUcQLXZSuJ5kx66MfSA/llj7xv
         oc2g==
X-Gm-Message-State: AOJu0Ywc4Qa1AZajIL+PKts1yjB9JYG7L2b+prq6KW8S0A+nNNJvAUTZ
	RU5bT6IgRy5TQIE9exaT+1XLjimP47f1MFmQw8iRaxP5IdFzAbA++FMw
X-Gm-Gg: ATEYQzyrJy6R+yRFaszq6O44D2a3UngWLgpdnXBYSxD4e8sCg6Pc/pSB5WJsFkoEvs/
	KOSWPFNDR21D57tZf0I/QnBZKQAROdhA/StrKC8BnGe2NWnHAjXeUaerQoPnb71AorZSeQNESID
	CtY/z/QQTV1uJXorKjEMaZT/LMVXTEC0o6+volMsIFggVFoR49jvh+Y4rsvTmhKHMl/qF9fTiMb
	puICuI9HK3KhEih0svdJctBNUljUKZFo3J8AlUOPs82uW0kbKS3kGkOypHJylplpBxzWL40N95M
	i/Q/jfCCjvlLGrG2TFtyvyqzcsxZScQQ2fj9UgxolCl/yX7l3ont1QUePCY/JWn34LT870/TEYd
	VD+KABuYhWUFKoL4n+SAVLKkuqf1W0jQRB1SGcNl58W4M0t9KS8E37GvE850w9nS/Q6yOkXadhb
	hPzdS5TywFg/H4t0jHbKlJ9rz0WCXj+JtYKI6+1kvpYBQQRho0VFE9vaoeTk5U/eMw9L8RB3Q=
X-Received: by 2002:a17:90b:2d8d:b0:359:fd9a:c506 with SMTP id 98e67ed59e1d1-35bd2d31502mr3244103a91.29.1774030252740;
        Fri, 20 Mar 2026 11:10:52 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:51 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 4/5] nfs: refactor nfs_errorf macros and remove unused ones
Date: Sat, 21 Mar 2026 02:09:54 +0800
Message-Id: <20260320180955.150696-5-seanwascoding@gmail.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270016-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.780];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6512C2DF563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
confirms they have no callers in the current tree.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/internal.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..59ab43542390 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -161,13 +161,19 @@ enum nfs_lock_status {
 	NFS_LOCK_NOLOCK		= 2,
 };
 
-#define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_ferrorf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
+#define nfs_errorf(fc, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dprintk(fmt "\n", ## __VA_ARGS__); \
+} while (0)
+
+#define nfs_ferrorf(fc, fac, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dfprintk(fac, fmt "\n", ## __VA_ARGS__); \
+} while (0)
 
 #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?		\
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
@@ -177,14 +183,6 @@ enum nfs_lock_status {
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
 
-#define nfs_warnf(fc, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_fwarnf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
-
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
-- 
2.34.1


