Return-Path: <netdev+bounces-270217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNwdDkOovmlkVwMAu9opvQ
	(envelope-from <netdev+bounces-270217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:16:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDF2E5BAD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7AD3024951
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BAA38BF6C;
	Sat, 21 Mar 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElvlnFZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5D38C42E
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102532; cv=none; b=CVzRxrJNmrEMt2lELZvJ+CKNN46YXjRyot4J8N2P2UHKgW8IpTwn5GEyOZmJUoNO/nRT65xBkvw95r/mAc/B1YLfH2TV8ZLrVDTRAUi1S643/b6natBVAa8RyWUh3Ro9KtbOz5MrrtX31m3J+wmS7LP3yn+GnYYmY2u20rPoG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102532; c=relaxed/simple;
	bh=su0qCKHnq3PtTnb31b3a9kZUX/DqBj3yiDnEaH4YW+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZC8Nl3cM5k6+anzB9aIPN09zH2YLuW7+n7rIHvw1Iyo0OX/y0N5glcKPXuIxbKfZiZ8qbKBNdml2XS8FxbHPCtUpow2v0vjoP8S7+xNhnAxA/QrcJpKWPh9sCvOEk0xYcTivg5bHW5vZC4OnAExpj9s6rOqmh++JIIXL6+iaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElvlnFZx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so9662755ad.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102530; x=1774707330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=ElvlnFZxfHz5IsE+NIiieqyp1y4CUanqpL/+VmxRX6OTwgIjWefOg0hW5NAactrtJF
         T8IdcqwpM/8BksWKAkKgyruUo2emVsOxzYlqsJ3DT9r5u2hYhbgqG7nbfFRYMP3NoOtD
         v8rYJxbTDqGhduY0z3pwsBTG5svvZMxjMQ3yOYFp4aDzElyuiKDvnbj2tjOw1XVzj6tJ
         qK4hWYEMQbL49rP81NKLLdgZVoWZHwl4BerJDNxXN1j3cypmiBZro0f+t2XiHHf5Gkh5
         1leArEHlElBEFf0jJNgsnUSqYnLO1IVbQp1QSKiI3vsXK35MJojhQ/aWXocuND4a69Yr
         nsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102530; x=1774707330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=dgWFpRyj/OcC51b9S7m1KILcBcg5RA/KRFDZuUzMOxHQen6R5U7zgwtQxZfNQV3cLZ
         Fy0vewocfiqHILG/pEudU9wOHsHJUqIq57vSjqIOIWoJAt38EboWdk1VkXQbhNG2/8Xw
         PltbyjeqazjKXvT3m+BEI95JYHhSUdarErecC0fgV6jhPKMVuSYGbkTxt3dBVoT47pdj
         N5j/7ns3d7jjm9agIrmon7LXGe/wGB0R8hmLgbFTFg+AEeq8p/97XQR98JHbSn4viBu1
         qIZ5Jl/bUJ3J9XQq1LZklPy6+y5605ubZCpCayE527hhnIePFbq+waRW1DxX+Qneba3Y
         Ozig==
X-Gm-Message-State: AOJu0YwAHUlhuf3xkQeKRSqDSDaozp+2NV+O1BvZcm9h9ijqz8XZ/eh4
	OftyoeFmnOPsSEk1E8K/+mSlenLStPLcIQH/4gb9TMn/+QTyZiVelxbh
X-Gm-Gg: ATEYQzy/tIlxj9ZEYMnvaGeAZxAW/Bq9z5CdbLgq61Ae5A8buGuFBQ3Qzvi/OxA+fuF
	a264DMjCG3ACOE/+oLtJ5FCAyaYwS2Ob0KPWO9xGM6elp8L/D6FyVzqzf6yVJzkivLSXMycg5xI
	BkJ3o+at95hM+CDQpAWw/xMHrM12v9pYeOG7fhy9gisBuL3hOfW2zIUsYRlMjp5EaQu/dH4OeQy
	d1lSiKM2XoTbzH0+JMOAJn71E3E9zhoUHzkDOP6x2ib1GkWtWPn9VNuTQoCuKX/6HhsUc56VQc6
	bFX1xOrIMEyHFq0ZiwzH20jHaFac3M6VGlzxiMWZCoUkZPvqhqgZJvRxr2FvkgAnmySfHcCaGRc
	3w4ySWCrODrNgaE4UpMMrhhfoEYfWTY3wzTy1vstnDE6baUgGQ74k0QI+XVX/lhtABEUFJDf747
	3ue4Hbin1zflEnqJzIuRbM7cngktip/aSZw1nW/wqo91l8W6qMYARgGfwhEJRpCYwmNPZLWQ0=
X-Received: by 2002:a17:902:d412:b0:2b0:5fbe:130b with SMTP id d9443c01a7336-2b08271d707mr36438375ad.19.1774102530024;
        Sat, 21 Mar 2026 07:15:30 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:29 -0700 (PDT)
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
Subject: [PATCH v5 1/5] sunrpc: Fix dprintk type mismatch using do-while(0)
Date: Sat, 21 Mar 2026 22:15:06 +0800
Message-Id: <20260321141510.68214-2-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270217-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6BDF2E5BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following David Laight's suggestion, simplify the macro definitions by removing
the unnecessary 'fmt' argument and using no_printk(VA_ARGS) directly.

To resolve a Sparse warning (void vs int mismatch) when dfprintk is used in
conditional statements, wrap the non-debug definition in a do-while(0) block.
This ensures the macro always evaluates to a void expression.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 include/linux/sunrpc/debug.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index ab61bed2f7af..f6f2a106eeaf 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -38,8 +38,6 @@ extern unsigned int		nlm_debug;
 do {									\
 	ifdebug(fac)							\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
-	else								\
-		no_printk(fmt, ##__VA_ARGS__);				\
 } while (0)
 
 # define dfprintk_rcu(fac, fmt, ...)					\
@@ -48,15 +46,13 @@ do {									\
 		rcu_read_lock();					\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
 		rcu_read_unlock();					\
-	} else {							\
-		no_printk(fmt, ##__VA_ARGS__);				\
 	}								\
 } while (0)
 
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
-# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
 #endif
 
 /*
-- 
2.34.1


