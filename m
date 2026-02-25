Return-Path: <netdev+bounces-260750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO5GC6VvnmkvVQQAu9opvQ
	(envelope-from <netdev+bounces-260750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:42:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BE191408
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2C630FBD8E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0D2BDC13;
	Wed, 25 Feb 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xek8m1Xp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66228C864
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990744; cv=none; b=nSpp8b36mxriOtpnkTxilLzWdl65ynZ7CL7ylnOk1JdEqLrOUcCjAFNJNL2XU3Mz812zutI3++CPCPul/WjECykci33WS1rAVK6DsHWizkNwnytbm6lQ1OuZbnDn6OVEya+Dd3fzoGIro+BZMBEH+rRCQH+P2fOeoBjPwHKnU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990744; c=relaxed/simple;
	bh=DIh8WtJKsYfFWmCLOMLa1uDVR3z6AtCB+KFcTxnsk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2MwDBB1h3mC7jB8LxrcfI5Wv3s4AqPzdk7eBmrxj2naZe0yP4yORdxL49OePNtCYRt+jNL8h9UcuKs40OrFt0HEAELVzWYpACtSQqrX0o1sjR+PzsbrSIgBY0Fq/T+pjSqanvUp7rZ6VL72Uvs7Zh40pE/uZTj4m2LFHCCt2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xek8m1Xp; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35621aa8c7fso3423278a91.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990743; x=1772595543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=Xek8m1XppizUUVgCLQ7ndGRly2a4A+0NvpyAiEUP0jKd2p4e8SvlLBHvlN68rq0HV5
         MnImVMdnCIZeM6AMSxi/HJ6Y1ZnCn7sW4X9vdhKdVCDGg8JNVBu5TqXjv/bJw7gg24i3
         wr0nIo4i2oSe2h3PBUfAyhqaOW8WUxnhfQpZtU0NHDN1zD2cDWGcMTS8dHleRO+1vEkR
         HFgBnJ5jFnozgWW78SHAeNOT/BZ77yTd1fhn0zcDtu42Lik5uSC4E/8RRumoO6K9+Y8W
         Fze2ffi0UoPftnSqwExjS0Q0qPtDHtLM7tHI8EZDWCECs17I/R8vSNRQZhp9HPmhaGxp
         Zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990743; x=1772595543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=KAvGDarL96C4/yTVlBJlLvH213+h2UynVygc//zZXun450M7HSI1sJbSCEPUQlxkfC
         fgYNL9kGYkktwfOsSS31ZdTXyXw8o/LkmoEGvSDN9stUj8A/69F4fnX6QkCtF98xI2wc
         XsEr/n74TKaZUTNTK5xBRPx8nLghIR05WVdxJBYs961gX4/Q9zX8VjnGzZTNCkGWDBEH
         sTYxwTQHEhjtEzpxIIo39xax29miYvOjiVtHjAPiVFoRyMcpZTSUG5rDJk1M8645q2vn
         xwZjoCuP95U8Ru0K47L8JpIUfkFrOrwUUVvYFb+UTQvFx/sIdgS2GjNZ7eY/wAb3UVqX
         sWZg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZL1DIdGCB5pbnYQUUmKigTZfYECgoRMIGfSEVjt07qzR8YdP6qjWGIn/kCoiGSpA7WQZago=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2q7jFEAH74O/HEWyr5BfbFdOne2mxuYPzI9KoDCydmjE/XTM
	wdK06eUnd0q0hT8LF9/zBp69F396TEH3x/vLujQ+7Jnc4i0kDipd9erc
X-Gm-Gg: ATEYQzyagrqjI9bEPdx8E+bL2g5yM71T4YlCMtTv8Hvg1fU+/p6mjc7C92ciKnl7kyg
	vIdw6PHoPs3luVQMIhy3UZ//7ya+wnUCXyNR8LYXjR7GrXQHG7dvKXJW5bSVuxd/GcwUBTq8YYh
	1pEEuHWOp8p7frTUp0opsSf0Y/ie62a89CQBYeUh3TkCm0k9FgfHchZKP/wOIGgPJ2/+jrBDPK6
	U19DwSK3DBFzhxX18rNYEIDKF9+ZRDTjrdODGwxh9cZwyJ3qMDCPnFxWQSjXHuVJmhrNtygNewz
	WvWUuvykO5cWQYp++aWlXTodHMCfGHG4tFJR2kbmkeuzb1nh9QDttkCSe/79sCTSmv3imBZJgd9
	EGy9Mldcal83BRXYDbwi3hue3kw2JJ/nnUCO2C5luG/HcweIBc/hONuiyRdaYvx96yYUF8h39p/
	nEMtC4GGPXqD0V4l4X3y1NvfXDbV1DD2PNdB1ABeQ/SEmSKdf5IwTOK/3Mx5Jd/UDHNwvz+Q==
X-Received: by 2002:a17:90b:3f90:b0:359:7eb:d922 with SMTP id 98e67ed59e1d1-3590f226ddcmr865260a91.30.1771990742896;
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 4/4] sunrpc: sysctl: replace simple_strtol with kstrtouint
Date: Wed, 25 Feb 2026 11:38:40 +0800
Message-ID: <20260225033840.33000-5-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=ericterminal@gmail.com; h=from:subject; bh=VO5IMzOC4K3hwnb1MwA7obneQq8hnuATlXNUArothF8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5NnFy7tzFYvrrwYZrvs0uTl0WyZgj17bh7bWXj9H ktUtqdnRykLgxgXg6yYIsvd//vm5nrdmnOd+3AuzBxWJpAhDFycAjCRB7cYGfYkbQsNc83T5D7V EcAdsUvkgG9N148DEm3V4R0XV915FMTwz9S6piw0ccG+fidP1kyRFuYGXW3ZZ3eK5hY4sX5+P2c LKwA=
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C4BE191408
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

Use kstrtouint() in proc_dodebug() after trimming trailing
whitespace. This keeps accepted whitespace behavior while enforcing
full-token parsing with standard errno returns.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/sunrpc/sysctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index bdb587a72..07072218b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
 
@@ -65,10 +66,11 @@ static int
 proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *lenp,
 	     loff_t *ppos)
 {
-	char		tmpbuf[20], *s = NULL;
+	char		tmpbuf[20];
 	char *p;
 	unsigned int	value;
 	size_t		left, len;
+	int		ret;
 
 	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
@@ -89,19 +91,17 @@ proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *len
 		if (left > sizeof(tmpbuf) - 1)
 			return -EINVAL;
 		memcpy(tmpbuf, p, left);
+
+		while (left && isspace(tmpbuf[left - 1]))
+			left--;
 		tmpbuf[left] = '\0';
+		if (!tmpbuf[0])
+			goto done;
 
-		value = simple_strtol(tmpbuf, &s, 0);
-		if (s) {
-			left -= (s - tmpbuf);
-			if (left && !isspace(*s))
-				return -EINVAL;
-			while (left && isspace(*s)) {
-				left--;
-				s++;
-			}
-		} else
-			left = 0;
+		ret = kstrtouint(tmpbuf, 0, &value);
+		if (ret)
+			return ret;
+		left = 0;
 		*(unsigned int *) table->data = value;
 		/* Display the RPC tasks on writing to rpc_debug */
 		if (strcmp(table->procname, "rpc_debug") == 0)
-- 
2.47.3


