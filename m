Return-Path: <netdev+bounces-277606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLoTEx5+2WmjqAgAu9opvQ
	(envelope-from <netdev+bounces-277606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB413DD4D5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229CD300F9E8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7630F53C;
	Fri, 10 Apr 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Yagj6uHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82984317D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861275; cv=none; b=mcuEAuY76RUxEdDxZYNXCUpbnJAUawXaRQpYmvPiXdmvVheLj0ZNe11pn36yePlWmnTsW0ANrpzuPhif0WESzbvLoMNpJp8cb7hb0+EnVgsdAC0CXQi45dGArdWG4Mp4QE8bnE+HKAJ6W+FNL1l9EXa1ydGxvV5C8XXUeTfzQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861275; c=relaxed/simple;
	bh=lXD7vz8c+FIb4s7i07SO66oDZz2PyXUxHIaN70Bm2ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PA2QgPFnNDMX+fHHhyyOhFwQGR+jkBGgCdiiaJcu0C6/69Cl7npAIl4Xu4JcfM3rg4xz8yriykSgd2Y3/kQKZm1Ca9GCyk1fubg/MWT+QMZ1bw4HK5A3mNJPpW2zIevy55sO8y98lCu/xMWViQkdHy1sfV1nX/EDk5JNFBBHAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Yagj6uHu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-356337f058aso1900295a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775861273; x=1776466073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dryQjV5m7mfU0pMKRGttKSi9Jxplf9Zr3xOMLjCzxpM=;
        b=Yagj6uHuIejRyy44kJjAV5PHkguP1TtPRt7es6DgaXDIG6jM+eZxfUAGJORmVpHdS7
         cTTs1X4N1eO2pGbTJ4euhi3YZ7f3wIT5PysuyhxTn8pzVmouz9xFJi/hzNc9V4sghWaw
         pDJNii6GEcrayVPJn8aNK57cjva2kptaREtYuptoL1lYGSnwsWSx3bg7wDus3xGKq38u
         QapIZ2on95OiGtJBR0wg5nom0lkll3KGq4EAg2i7cp6a65zXaxh3xuYHLAPCj6GhLa7+
         KtWhyTMEYn2Zyg4C3ZjBdbs0dNtR+4/PJbWfJlevte6xwEPCFlKhe+h7vj/gNFr7tJNe
         YdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861273; x=1776466073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dryQjV5m7mfU0pMKRGttKSi9Jxplf9Zr3xOMLjCzxpM=;
        b=IHQ7qBSnZL8afIqdyGx5pUNw+KT5sEN+UIqBwwe2Zv5/kTzMmrw3up3c1/ztqLMHml
         byFHOQQc5vSWlI2tIQvCjgZZt9rD9KjU6oFzvFzk2hgwGrglhpmL0LOXby4VFXKtQqlP
         RMDBag3b+MOHRyjtIPQDfTvTRLe7gIxy3lDI5Xgut5W+O9B1fwNfLwLld6Kyxy37fVRX
         WUieteDsztLUB7f3POk9atX673cZ0ZUw0au5ao/LnVvFs5gGzJZ0vn7LzWpYHng9AYAo
         MvJvn+mUoNt5YD+QlqTCv8I/QNxvXAIwXRwhBvAStf4XmHPklDFQb8TJ3bKAKCRYTEYG
         q4ig==
X-Gm-Message-State: AOJu0Yzz+Wqny2nvV7x5PPjlWQs2PWN9QuJRPjYBKDCGA5/QYk68kZBW
	tM9CaXDOXy0DK/qFZWXtGOxzH3nfNXO1pznU/doQ5CmaZIzmPGhzQ/e+AqiknwXPLcAEVVgaBXG
	cGitC
X-Gm-Gg: AeBDiesRHQNn4xVFe2dXIVVqJ0vGwkTvCxtFYy02wLUki5nzdrzg2KshPjZM8AegQTx
	7g3/bJbURSuodAJl6Qq8iejJ+Srw729jLUzQMOD3g66GwtCTSO4aDiN6pLe0hU1IUVOn97X9Jdj
	RjtGoj1ZMvMqye4ZGAZpb8LRiEsb2xSAasatl106PYeI8szug+QwOELRQ4y+iy4PRRJnKuubGrM
	g5yB4cKEiX3Lkx6D7NNbW4Z/2nUXGqdLxbqvlgCjahzO+RQXiEnpWa6/mg8FOf2bMefA/wUNoLR
	V2SP52KxkJR4ZKqjgE9eLNgG3XpaAYWCbUvi0PBzAcqj4XMpvvci5Uw4NS8ah0v6q+kxWSY5abp
	pAIW5vEjhjXBKpiE/7yh9ZzH0PORpF9JrA4rXkpGPccLZWLAsmGwwQnLxjNjF+fPdSR/Y0tfZOy
	lp2XJdUOjgDIQHLpliJ5vbyTlVbUxgcMAa
X-Received: by 2002:a17:90b:4e86:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-35e4278074fmr5594127a91.9.1775861272813;
        Fri, 10 Apr 2026 15:47:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f099d6sm51025295ad.50.2026.04.10.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:47:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute 1/2] json_writer: support control character escaping
Date: Fri, 10 Apr 2026 15:47:44 -0700
Message-ID: <20260410224745.93416-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277606-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6BB413DD4D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Iproute2 never handled control characters in strings correctly.
There are some cases like where string is under user control
like paths in ss command. Make iproute2 json output conform
to RFC 8259.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/json_writer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/json_writer.c b/lib/json_writer.c
index 2f3936c2..7202621e 100644
--- a/lib/json_writer.c
+++ b/lib/json_writer.c
@@ -53,7 +53,7 @@ static void jsonw_eor(json_writer_t *self)
 
 
 /* Output JSON encoded string */
-/* Handles C escapes, does not do Unicode */
+/* Handles C escapes and control characters per RFC 8259 */
 static void jsonw_puts(json_writer_t *self, const char *str)
 {
 	putc('"', self->out);
@@ -81,7 +81,10 @@ static void jsonw_puts(json_writer_t *self, const char *str)
 			fputs("\\\"", self->out);
 			break;
 		default:
-			putc(*str, self->out);
+			if ((unsigned char)*str < 0x20 || *str == 0x7f)
+				fprintf(self->out, "\\u%04x", *str);
+			else
+				putc(*str, self->out);
 		}
 	putc('"', self->out);
 }
-- 
2.53.0


