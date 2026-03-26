Return-Path: <netdev+bounces-272230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIL/CbGVxWmq/gQAu9opvQ
	(envelope-from <netdev+bounces-272230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:23:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A533B60C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771AD30523C2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5663A3826;
	Thu, 26 Mar 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blqaZm56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDC376BC5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556304; cv=none; b=LKdwVn5lflzRvaAk7TYytk0IspUAGTdIAyKCsWgGZyOWQT6L+kpo9BZshX/rXoI63LPriA3DFjZIfi+PQnC6NRB5HfJTZUb5Zodrybx6VCfhjypYyc78w2O/ozfmAJ+JzzVE2RhtLuM9Dt/YQ45B6hTfTdl2lq/7fo7oWkgMdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556304; c=relaxed/simple;
	bh=JX4vHATIUFWQLbRlq7POOxtY7rKiXSnnAKpkp53Qk4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5tHleSRMEm4SDJ/zxPDamZpGmyG0KME0iTfLqLzAyTDq6YPIraDMlxkqlpMHwFFY9J3hKhZm8ImH366GizMwGTg5imYRMO5Tl7Vd539FVGi9EVVesVUTta51AyETFPuIPs/0V/LJi6et0sqHZtQztWjNoCH+fgivykRptnC0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blqaZm56; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b871dd06eso840496f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774556300; x=1775161100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTEKVcMeJ2+2gv4frZXSVscFWk19gO1Vh54Xj2RwYEY=;
        b=blqaZm56Pg7xovNIpmBVh3tAUfgT9Wqpu9MfcT0TYYjveYmsdY68H83Hs1z5mg4tQK
         OJuaro/JcZNe/jj/+68toggUdhKd0g7pC5rQAqWc0z+0vX+fuVOe+RSRFvEiLhH00Ko0
         HyFexecWi2FRWcC8DgXv1v+Pb3FrecjRVD4cFFhBqjCjgqxWTL2OqoXwA656nHlnfvEK
         p15Ic2U6J/tfIowzBMxw4hTMwYJMBfine093n1Jqk3Hjmljb7onQJ1ET4ftqCGffQ5wq
         dgaHVxOFHdd2Z3cL/NNkKZW3tB9+i5AXmNtgmnQ8aL9zSfYrc/YlR8YlY0pN6VsezPT4
         qifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556300; x=1775161100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTEKVcMeJ2+2gv4frZXSVscFWk19gO1Vh54Xj2RwYEY=;
        b=Y9e5+AHJAtmuHyK+cWA8qIRsbU0w9CQ8JNM6Zw2jGekm4m25wOlLjT7hDkp6OlDOAw
         Rtq2qWN4u0xqOInoHSEFLhWH8/kJzMdQj3QH3B1vhwuxe8x4smWDN+Y2FgwUqsA97wXV
         MU9090z/kk/phkfwBDUgKBk14z2SR39XGHaQf84eCelOwnklG5zJYoUVSkCdnN4HpU4y
         Y/ogcY4dMYSJ1ONuD1cP5d0I9yJI5nBr+NoLVvzG5+zTfxTDfqU9ry2Of4MbNYzVPOKN
         VPnQF7UxHAkMgcxqYHEe/PgUEcQfCZylKNhaZvcpeAZC7+umIaEHJDAXY3LgA9/OLps2
         p2yg==
X-Forwarded-Encrypted: i=1; AJvYcCWuuZlF2/zWYByNl0ouTGRglk7q36ysT40vEwSLI5s/zTy1spalwi+rZBVy0+u50iyaIefV4DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHBQ3J4AyjASoyafkF8GHG6LF/o0G5kpWyrmaY2wXFB9G5smM
	yjVVaoNXfZZm5QxmlaeY8IxLDPeXxHCZlwxqhExzIC5WhxJQtr6XpJ+i
X-Gm-Gg: ATEYQzyd7UagIvdVAb7R0pAqSRLsRAHYm0vDA0+iiUR1HyFOoAdQmyQ/yKW2Zj8mwFM
	D0ONnHzJLFf9LtAId4rE16TVBS+x8wWMFuRl3FBW8mMbtLkL9koGZlorbvzHoAIY7mvu1+a5sxb
	v06I3LkwXSeCrIaSxOTj6ecMeEHuINRAzS4al81RlPh5VJoumF1xL6agmymYhtVFXFSf1X++rCT
	GvZ9nGvtLick88qsHTpw0oqxiip07woMjDcf+C9SwvsBDvZy+s/KVqCjshV+kWEcKP+4wrMLNIi
	kolDthZmTZL23v8vz9eQKTL85bZlL4kOtUc/OJFE/TzSQP4utVDuqGFL7bGOFFy+3SOWOYFLFV9
	liCbM/6rU53fyOI2uAkE6QX/3R0+VOGebZc3WDAbCAu4hYLvxshfzOmuTfhgSertMM/hUT9vvHG
	lOo9A1g+1a4fy0/tNKeJXwY4ebQKia0ygkT2hugFkQWV9EX2JB8pNWvtAyGCm5HD2qGYJpjRhlm
	IvqEQRgT9gP
X-Received: by 2002:a05:6000:4287:b0:43b:634d:1a9e with SMTP id ffacd0b85a97d-43b889c505fmr14390229f8f.15.1774556300321;
        Thu, 26 Mar 2026 13:18:20 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm11693016f8f.5.2026.03.26.13.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:18:20 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation when H323_TRACE defined
Date: Thu, 26 Mar 2026 20:18:19 +0000
Message-Id: <20260326201819.3900-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.com,rasmusvillemoes.dk,linux.intel.com,goodmis.org,chromium.org,linux-foundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-272230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C12A533B60C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>

The trace lines are indented using PRINT("%*.s", xx, " ").
Userspace will treat this as "%*.0s" and will output no characters
when 'xx' is zero, the kernel treats it as "%*s" and will output
a single ' ' - which is probably what is intended.

Change all the formats to "%*s" removing the default precision.
This gives a single space indent when level is zero.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 7b1497ed97d2..287402428975 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -276,7 +276,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
 static int decode_nul(struct bitstr *bs, const struct field_t *f,
                       char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	return H323_ERROR_NONE;
 }
@@ -284,7 +284,7 @@ static int decode_nul(struct bitstr *bs, const struct field_t *f,
 static int decode_bool(struct bitstr *bs, const struct field_t *f,
                        char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	INC_BIT(bs);
 	if (nf_h323_error_boundary(bs, 0, 0))
@@ -297,7 +297,7 @@ static int decode_oid(struct bitstr *bs, const struct field_t *f,
 {
 	int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	BYTE_ALIGN(bs);
 	if (nf_h323_error_boundary(bs, 1, 0))
@@ -316,7 +316,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case BYTE:		/* Range == 256 */
@@ -363,7 +363,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 static int decode_enum(struct bitstr *bs, const struct field_t *f,
                        char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	if ((f->attr & EXT) && get_bit(bs)) {
 		INC_BITS(bs, 7);
@@ -381,7 +381,7 @@ static int decode_bitstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	BYTE_ALIGN(bs);
 	switch (f->sz) {
@@ -417,7 +417,7 @@ static int decode_numstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* 2 <= Range <= 255 */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
@@ -437,7 +437,7 @@ static int decode_octstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case FIXD:		/* Range == 1 */
@@ -490,7 +490,7 @@ static int decode_bmpstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case BYTE:		/* Range == 256 */
@@ -522,7 +522,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -544,7 +544,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Decode the root components */
 	for (i = opt = 0, son = f->fields; i < f->lb; i++, son++) {
 		if (son->attr & STOP) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			return H323_ERROR_STOP;
 		}
@@ -562,7 +562,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 			if (nf_h323_error_boundary(bs, len, 0))
 				return H323_ERROR_BOUND;
 			if (!base || !(son->attr & DECODE)) {
-				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
+				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
 				      " ", son->name);
 				bs->cur += len;
 				continue;
@@ -615,7 +615,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 		}
 
 		if (son->attr & STOP) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			return H323_ERROR_STOP;
 		}
@@ -629,7 +629,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, len, 0))
 			return H323_ERROR_BOUND;
 		if (!base || !(son->attr & DECODE)) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			bs->cur += len;
 			continue;
@@ -655,7 +655,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -710,7 +710,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
 			if (nf_h323_error_boundary(bs, len, 0))
 				return H323_ERROR_BOUND;
 			if (!base || !(son->attr & DECODE)) {
-				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
+				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
 				      " ", son->name);
 				bs->cur += len;
 				continue;
@@ -751,7 +751,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -792,7 +792,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 	/* Transfer to son level */
 	son = &f->fields[type];
 	if (son->attr & STOP) {
-		PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
+		PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
 		return H323_ERROR_STOP;
 	}
 
@@ -804,7 +804,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, len, 0))
 			return H323_ERROR_BOUND;
 		if (!base || !(son->attr & DECODE)) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			bs->cur += len;
 			return H323_ERROR_NONE;
-- 
2.39.5


