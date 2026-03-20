Return-Path: <netdev+bounces-270013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHXeJWKOvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:13:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F22DF3CB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0B863049C88
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72E3E51FF;
	Fri, 20 Mar 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkDWpgXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834673E121D
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030249; cv=none; b=pCGnJQKyccg3nxds2u0MLucgvIKIREMJc6jhnYPNXOplctzIsuBKBtFeNn48mc0H2oFnu6q70KP5MHrJep951puF5Kcb6rtqy4/OH+Q+TLXeN51qVxXSQhKnxtzeUeiits4QmjbJcWtY9kjsobOhIfyO11a4gAGVSjwVVd7FB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030249; c=relaxed/simple;
	bh=su0qCKHnq3PtTnb31b3a9kZUX/DqBj3yiDnEaH4YW+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZROY7hnuSALQ4uAuS9tiI+HpHLc4KxYSwQ48zkrJg151qs5TBdji9FGMsiA/C0vjKSzPLVNwHoivVxTddPfEZI2qCVJBfeUbIofHzXNJQDvZ6AmFA5pVAVSG9Hue8Kg5p2BJsz3HHUFlIbSv9gqQC2nw2tjbTvp4J6t8Sh+mjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkDWpgXf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso457555a91.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030245; x=1774635045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=CkDWpgXfofYCcZUwyDcaJ5h7BJ9F9rPzEeN2VE2QiBsbQ+pkvNkvfPD+e6yHK+Pbyd
         ikwCe8KDI+cNEuEsEFrWwbS6pYsD16FkK00C+scdNXAJ0gIz65SNFVi+4bLRaEKxZQRq
         yBiRVagUQBdbvz0dtwBUITeRUeN1BASy66P9FTt/CJ+PHR2i8RIge8lElSJPOOPDR+ku
         M3kWanabV2SZdJOVBJyK8AWj/V59jGxPQ8DlakMIn1/IzMZ9vGt3iLKEFrfXTYdTq3Kh
         LCGg+X+d9tbDY/8JDHgsp7IjE80aS3x5jvRWyhP6R39B+ljYI8b5JfKfYAJlF/GewnVQ
         Kx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030245; x=1774635045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=RGStr7IAMHk0QT6stzLDsBybvFQ/jWRpzi/+MpwsWQS2MytCgSOvSJCTyzwdwBWmaS
         Q9vIi1PTyHL7tyGdNyauOalCXLPoa3IfEDWWbXHqnDGDYC8iXf0dJq1mw0O7Qzlb4vTn
         sgFm6vG59J03E1g+M7QsNmLianLRf1Itl53NZzpb2DnQzbA6+FgQl+1I+ykbFA8yh16u
         0Rhvc1PKVNnbbxjiwnKr7JpUMR/F2APTNVMdqQvcbDIjJXcKIcB+DUwrp735/RYlvI6j
         hmRPgKmKRNMR01Pz+/9ra5wQIgbxTEoxXKb0TpTM74KtX4z7hMKrArcb52TFXOny020w
         ROtQ==
X-Gm-Message-State: AOJu0YxA/TJ2kEyT/w9Hfjqz6xOgFi3YO82vKYe5eqEfsAxdFk6pvtNy
	ZlR7WCfcOkQstJ+OY79B14MJtrMsktqQvYTTqJOVthGcNXRspYq2iorA
X-Gm-Gg: ATEYQzzUj/R/5D6IDH3ObXT5hsTMr9piLH0XVfWrVNQbI+R/jsyZUGsSCn7MoxOwImb
	5fMN7JWOA9n1uxKzYXtDnUddmDZyGVGBt26+qZVwaDAyuk5GD0dFH0Un7+pMhqN/0pqkCsCwh/w
	SyVuLJ4ZDco8ATa0BqH0z6CZYMYI7d5DgDiJ0dMukc8fqi29GrnK41I7uyCKKjiYVsEtQjp971W
	IHUfvoONF7pVuQhoLev7KR1zj2hOoTzKwh8YR3HO4tdV0HA2VSxEMk79T410sXw8/w8Lu1stl6K
	rwLY8oyQ2jdOVETntOg5IGJAqWcMtH7xQhgh1mKtRBgKtExbZWItOSLFs1akh+r5n7y3Iz5UdGx
	6D8ceoMyRe0bn9x/0fTyYlf5p512i5CeqQQczORdOCLfk2IK3W1ULwuZJ8T7W+dKqPJhtJ5OWiy
	7gJBzXEkM6m/1rRPm2FxdHJdjdAadZjC1LhZ2SPE2eC/6jU9k6+8x6LrV/RGt/H7Go8aunwck=
X-Received: by 2002:a17:90b:3f8e:b0:35b:ccb2:9fad with SMTP id 98e67ed59e1d1-35bd2d1d572mr2544272a91.24.1774030244701;
        Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
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
Subject: [PATCH v4 1/5] sunrpc: Fix dprintk type mismatch using do-while(0)
Date: Sat, 21 Mar 2026 02:09:51 +0800
Message-Id: <20260320180955.150696-2-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270013-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.872];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E8F22DF3CB
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


