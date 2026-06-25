Return-Path: <netdev+bounces-301899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cp7SE7/oPGokuQgAu9opvQ
	(envelope-from <netdev+bounces-301899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318366C3E38
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SY8bp4vJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301899-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFBA3008D37
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E83812EB;
	Thu, 25 Jun 2026 08:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1C380FFA
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:37:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376634; cv=none; b=dvqGJMXG2TZvuCATQcjfbekJcevHvWodaq1mAR8FmPxlrhWGeNy62mnbxsVSVCuLatGvxR3MaoG55M+VkmzRNl5yN0MM3i4MYX6LlsFYWRsdncLco7PmZNhIzQU9tBNOtGlkrm5OhLQF1acS6XcrIXf9y9bzuMZH23DJRBC5Anw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376634; c=relaxed/simple;
	bh=vfuzqAAI4Z7JfbLKu/I0egbH5sPpHBKYRHIHNaxeamI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH2V9XLubOUg+nuO3F2zFAY7ah7/heLBmbRcr79Q19edh/Nyks+F1vyEkic8A+OXGpFk+1LEigoBNTgIGh1tdJVYdc8qRi1y7c+cIACRe38piOx8drngSe8obHywZN22f3lSrhICKVxLLt61iiKOCghv8el+m3eHjz6DtTjZ/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY8bp4vJ; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-462342ac290so2364336f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376632; x=1782981432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=SY8bp4vJ76cjT0gwKLLfSbNmYwKD0fXJ2UuZWI5dUi3h5u1WOMEJ4YDKo8cnZ6hGEJ
         cpQKdCndXE1AnzLlhE/8gKp7lenq/s9rx0RzLaVh2asZuPgWoVTZ1h6pAmLnhoYB9YDR
         Awtmr/mCJwudvY6e8qBjC390B4GH6a7K4UaUNaxu/gkzBGYlnJKYvL6f5LFhpxrcYx9W
         SasWkRH7b+KGkyy0Oc+3PGet2f2EzR3AasepQkvpKyMqFM3TTr9lihS+UhncODRCjpzd
         OhUARFvI4q+VmDPchhHBaNE1BkDcdJKC81n9QrRTZTVapEbzd/ffjeoqO32LOXnGojr/
         9K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376632; x=1782981432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=Vd9ukPZ+p44xrWRZMzb7bNlea1rjFwdin7u1SSgvFeYXOJ0Wi3NLhKM4V8UDMk2Iz5
         H/FtMOwVqKlXl1YiGBvQYiJa00fcvZelHvLk/u7qQqjuIhpVXi3qvCyFhp9sd2n4ZfV5
         BchYAi9Zoo048sGXz/yA+Ch94IAkc6iw/UKqfOmcgfV0RrvltxDLze6y6wXWUZQu59Is
         FNZx71tnoUxPbs9zEfsPjWtO5ajnMDD9fmFvZ8R1NVGgEHFp1aC9QAk46oVfcnPCUHB2
         WBlekafpfkM3yFnCiNeIWV/8OAcdwmWOK7BFQnVxxR8cVkbHw34Z2q/ZnVLgS4xitvd3
         1a5A==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Ivsdlgiu3RFFqOKgJeKfecvmXnlnQhXJ4MY/N54knTTdO/B4jL4IUoZ7w3fpuqJN31XavPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlSw98I5Qa32q5fOhvXYJLnuTqAu4piN6Pn3cc+ChjRaVm/GF
	i274fn5myHMsl7s2VlslhK8DLq7F51Vh+1mG5vQJUsMcuWUO0RRxQPwJ
X-Gm-Gg: AfdE7cmYlFIFGtDpTQG8kKNwlUSWsBV4RIHLmulAdfmX9zecmjiHro8r/UrXgL5aBQN
	vNch+BNpHa1t+e3AF/JW5+/tqgmP0YRwMwS/0i0QuGwMU+MT4K8kWVILARgoPvh1POGhT321rlQ
	OjmEbhiwBV4mt1LzFLQDki19ZP95DBVEYp6/50ACAJsQCo8radi638/K7r9/VhjxzrmHVo5lR4L
	85N6+i30mn9/tvoOdPEWWrblT8sDjArJ8EsmGikEqOEEtajGdauluNSlQkmRFSCe8dk9F4hqJDf
	VrUUHxD8htgm7SSCBJiXNJYfPsr8+t/nXGG2YDY078u1OiuCG1Za5hOpGPnjsu50FK8Br83f34m
	rrXVRY5g/5e0n0zg8oZijCNSiB74Ax5lIVWiHWw8BOcu/AaFcqWlHDSqPawe64x80HNhV0tnGOb
	mfCJWDBzY1
X-Received: by 2002:a5d:5e81:0:b0:468:4f81:5aa4 with SMTP id ffacd0b85a97d-46dc026de2bmr2181270f8f.10.1782376631864;
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c221d93eesm13786367f8f.20.2026.06.25.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 6/7] vmsplice: return -EINVAL for particular combination of flags
Date: Thu, 25 Jun 2026 08:34:08 +0000
Message-ID: <20260625083409.3769242-7-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301899-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:val@packett.cool,m:avagin@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,infinite-source.de,1wt.eu,packett.cool];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 318366C3E38

See comment for details.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index dbd0debc2..b1f71b142 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1258,6 +1258,16 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
 		ssize_t ret;
 
+		/*
+		 * libfuse relies on sharing vmsplice behavior.
+		 * So we detect particular combination of flags to
+		 * pipe2(2) and vmsplice(2) and return -EINVAL.
+		 * This forces libfuse to fail back to non-vmsplice
+		 * code path.
+		 */
+		if ((flags == SPLICE_F_NONBLOCK) && (fd_file(f)->f_flags & O_NONBLOCK))
+			return -EINVAL;
+
 		do {
 			pipe_lock(pipe);
 			ret = pipe_wait_for_space(pipe, non_block);
-- 
2.47.3


