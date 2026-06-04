Return-Path: <netdev+bounces-295435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lk7OIoL4IWqFRAEAu9opvQ
	(envelope-from <netdev+bounces-295435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE8643BFF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Mh+UK77U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295435-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295435-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A37306F9D3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB830D3F6;
	Thu,  4 Jun 2026 22:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831930D416
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:09:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610960; cv=none; b=rOYOsU6k4V3LzmVcFYoZQcMy4K0jCrLa9cYqXfquV7jhSOc/ayeJ6wpUrWDvtl52KLkYten9lH03XXF5a3mkBgOjxxLsY34WkX7tA+OeIelgqliiZ+9Wwv15PdQ0w+jpgtTG7vlu8NmP/xkAcagfmJEmCFBYUtmMMe3iOinI+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610960; c=relaxed/simple;
	bh=mEvyukhAhdQcXVildxDzfDWhPWDo3cluDvmrIumRn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFT1nazmaqfBPSKUKOelhmeaTifrSQraKKxlI9ysPCxSBIX1iq2jGIs2T78vt2b95BNeGB6sfr3VSaPjTg/y9XGFlmC44HrfsM6FuWl9UyZgOE6+pXCmeZ2FHlKOatSR5gaTshHwFUiAAK5mashiQ44po4dZri8yfHGqXA7nRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh+UK77U; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so8566575ad.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610949; x=1781215749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=Mh+UK77UV2a/xlyjl9xhuM/3TYq9Gk4J8HY45nIGfsCx3Dss6e5TpDtXFgUUHuh3O0
         jjNX6lWIvDXTUAEd5ln8+I+xTSlbUtv9GZLZRfam3CUIo/91SipSwYwyCXu4Yz/NkCrn
         sNJbt2qu7RrZjK6vN2uFxAanbGt7L2i02LpHXtsuvKRz6BGUtfup4tS+ZrJVvWNG0qph
         9q1wWTS0bJx7BNafUGUjbDTyLdFnlTDSJ0EVsdwmT7s7z1kPCRpfn5XrP9isEW1/DEL5
         1vruvK18qngje3EvCpQBDDKGeXzUg1Do99RM4gfm5LU81ZRfCkKnF2HP2mSNKDmI7SJL
         aO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610949; x=1781215749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=roCUstGeeIZ4Dl4VWFcjeeNkGA+aOIGhSy77S8N8FJ2TEb7S+MXSzf/PRmZd/tlqHd
         0+5MQLNHngUAjLizjZqwtrkPwEG2yH4FIURGU4SXni/I+CbkVUHgD8x9XqE0NO8UUcoL
         Hp5SFyaXEOL3kvEHwQ/yo60UljAMN8eBYeWxwAz89bVEfpjAw+pNvsGMRAEDFCsaYy/5
         KdofCfls/sy5yb2PaEkcAkylVa9d8B5IKa9Ggo5YffIgYw24CAZibjZxY8N4i5fpPAOR
         xaWKW+uKJLo/ohNFM4IsLE0Cu586IOOFwwo6IU062n6UWGwZtEv2SWpGCLneNH1S37ii
         PQxg==
X-Gm-Message-State: AOJu0YyV0tsURcS+PYCSZ52bUXUy0kf0iPD0P4PtdHy4OFaP9XcFQob/
	14YXp/XlKwCfL/uqBnGA8rU7ORrsYgEcK/PVsIKGvXSPrZWlVvFyLNme
X-Gm-Gg: Acq92OHtMXNp2AveI07DNMeo6iwE+dChdIbsoT9pAKk8pYBrSrGe6BuIsA6ZRYM+FRE
	CfcjlBJu1y7zKnpU9zr3wjLLH0eCJGWQxKqcFOtzgHlj2Af91eIVq/FeGbSySPISgxgS8BzsSmU
	GsZIs17BRxrmHhpGZiCWdqutIUVYRTrQttSgSn6DhOpFlXGdIuF5IYSHCau3XQAEApJlUgRb8n/
	Drdnh1OFO3/i1UnUdbBurJ16W8AddnMVDsKa9GgUqKJxh8FF5WSichDmXInEfkvWkEb/6BJhJOP
	ZvwxlK4DIez/3DNduvAHeZc71DDjaspmhMIJ/9CXJoW2Xa95ZDJLehFAuPr++4Ln22XNpDgUnW7
	6/Q9PKng01VIHGaTCPnnWrnVsI5wRg+lB0lMAUxhlq/OwLDGypdB6Q1huy6scdX+Ri//tFy53OY
	+5nmpo45SqnyRhp+2lo3UcqBE=
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id d9443c01a7336-2c1e77754d7mr4997365ad.0.1780610949014;
        Thu, 04 Jun 2026 15:09:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629c08bsm70177595ad.61.2026.06.04.15.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Thu,  4 Jun 2026 15:09:04 -0700
Message-ID: <20260604220904.1032145-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295435-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2CE8643BFF

use_file_dynptr_slice_after_put_file() reads the dynptr via
bpf_dynptr_data(), which always returns NULL for a read-only file
dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
correct read API for file dynptrs, and read (rather than write) the slice
since it is read-only. The test still fails as expected.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index d5fae5e4cf9a..3bb9e2612f8f 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	struct task_struct *task = bpf_get_current_task_btf();
 	struct file *file = bpf_get_task_exe_file(task);
 	struct bpf_dynptr dynptr;
-	char *data;
+	char buf[1];
+	const char *data;
 
 	if (!file)
 		return 0;
@@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	data = bpf_dynptr_data(&dynptr, 0, 1);
+	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));
 	if (!data)
 		goto out;
 
 	/* this should fail - file dynptr should be discarded first to prevent resource leak */
 	bpf_put_file(file);
 
-	*data = 'x';
-	return 0;
+	return data[0];
 
 out:
 	bpf_dynptr_file_discard(&dynptr);
-- 
2.53.0-Meta


