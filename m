Return-Path: <netdev+bounces-298196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQdYH7fdKmqoyQMAu9opvQ
	(envelope-from <netdev+bounces-298196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:09:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D867353D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="rT/feOGW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298196-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02F763006985
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81769409631;
	Thu, 11 Jun 2026 16:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97E395AEE
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:08:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194137; cv=none; b=hyJXwzMCqkCyKMUAvjkCzcseT9ojQaKuVJya7WBsRG4dmphIOOdsIqUnQrDCGUnenBN308QxV5OXcu5oJl8OF2DXUPoBDhMtEOi5N5yA5VOkjSyak7m0CqVxG5pw7sBs7DmN6xVJzKVwCPhHh18DsFyNBjKhdMsv5IOE3qJ8YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194137; c=relaxed/simple;
	bh=BXF26WfspQD1f+THse2SOP2gHSc/2CF0BXE5D15lMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdC0374V/LFL03oAhmUp2ExqdrTHXUvErGGhkfX6Z5TjfXVpVIpTVzVd8ZJKMGYZfTNrvss51OEU8w2DcEjPcWIJ5jxjiZ5nzfwwUolA7QiG1KXIeqIA3skxkT2eVW6IuKK3xj3BOD0DEws8n5kszyhi18dIbY3TfeM+H46J3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT/feOGW; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8585cd8400so3214823a12.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194134; x=1781798934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=rT/feOGW6AYHMtF1IIshdESdaCVpcHWniXWeQ5zd+F1gGe/LSvkyfbGP9w9Xr4FlJc
         mZYs3iyAAwGV1k1u9xFFp4tezQRdrdnJkPt9mf1acOZfeo6B17P5L8WAIigwtJx28xI8
         YP/j6zgm67Icm/DUFA5QcMOTxgTcbNBLpoOnaS7WXMhuNOWjnzrb+Bdb/XDJbAigw3UV
         0PP/p9v5FT1s1HJkdi6KiNol7ceCpkvtHTRKENIlCuFXsKRsLi4qcMBxW48FDYZPJFTm
         HB8n09Vmf3VkJNfu/Iep/2wovIsxxwYo4PaP/gxLGrkQDA/qv3Sfbetz8sjZJqINvSTN
         QRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194134; x=1781798934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=A3JAPMh3z8xou4T3qeShhPwr5Um2A8RZ8Fnr6Fzxi+6bF7IvGJX0YpHHrZje2b9JOM
         BKoKg5U2gQFctY3UTfdFDrcp1nnNlyUmHVTS5udXhzcZI4rqtMGgl7hJQkgyjPvcH7LF
         cqgeqfF9F8VmOhIyx6ZmzwJirDDoTt8bb3eeRUNAJb9LNyV7rlH9nuOJh0dEeJ//DNZl
         cvx4Xuc0nrbHXw+CJa35GtVX3kzWZTBy11Fv7ulaWnnZdQqrI4yVy6LOR/M3Dz06ev+8
         ZxKVtlXgk3opRp07dXt3efQLFg7eoIMF6Ejoniw+EywBpUMfw8f80GXm2FsxvTbtd58U
         MO/g==
X-Gm-Message-State: AOJu0YxyjbzBi1bh04HLk+3arzX1TQHSwJJVcS+pEMIYCgpWWR+UeHge
	njr9AjCWSTefMA6MDCHm+Uiv0hY3Ij4AbqS1aiRYUMC1U43q56HXX8q+
X-Gm-Gg: Acq92OFnVVl7Wtus0/jCUFTLpNliPgUtIOftzDgzTJH7sdg5o8gaAPHUXpkimZTe+ix
	HU9gRjEwQJp1lnyogToPjeZ/4Jr6XMRy52Ygfge2qHIQoO1JyOBTAfAtc71HPvAhdDeigcnuvrQ
	IAOTxcH8sVQTfIO/m2cTAPhUXhPvFwkFRztctymck9I0sSxYqOoWv0oJLHiNh8vsjRQkxU7quTR
	6JO0O8m1R+zyD0Uh1qQpl0rdLcXQv/D8qoZV5kGNxj4dwKK0WljbLuTHN6h56gk97p3y19ya5R8
	pIyjI/BuZ4ZWIFemgh+3MA+4RKnHlWrGa+DCvPWAJU6WuJ9YouWK1uIAoS1CcE0PAL9I1b1W5A8
	u4phgWswoKBawBnRpA5wg/nMUCRB2jWL6R95wM8NVU2fQH9iczJMNRY2pV0Zunsbl/Leij0oWzq
	i4HWqh/mh/FZrPejPT8JPWEhB2ota8NHj5gA==
X-Received: by 2002:a05:6a00:9a6:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-843370762e7mr3967784b3a.23.1781194134186;
        Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e5788sm2274495b3a.43.2026.06.11.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:08:53 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar pruning selftest
Date: Fri, 12 Jun 2026 00:07:49 +0800
Message-ID: <20260611160749.391279-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298196-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C25D867353D

Add a verifier runtime test for a branch pattern where a helper return
value and a related scalar stay live across the same control-flow
sequence. Rust/Aya-generated eBPF can naturally produce this shape when
a match on a helper status keeps data derived before the helper call
live across the same branches. Such code commonly uses the helper return
value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
branch shape.

The test preserves that branch shape but shifts the success value to 1
before branching. Using r0 == 1 / r0 != 1 avoids depending on the
verifier's not-equal-zero refinement, so the test exercises linked
scalar precision and pruning behavior directly instead of being masked
by zero-specific range refinement.

On affected kernels the verifier can explore an impossible path where
r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
test return 1. With linked scalar precision tracked per instruction,
state pruning keeps the real success path, and the test returns 0.

Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 70ae14d60..de71d547f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -448,6 +448,41 @@ __naked void linked_regs_broken_link_2(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r7 -= r5;"
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 1;"
+	"call %[bpf_skb_load_bytes];"
+	"r0 += 1;"
+	"r6 = 1;"
+	/* success path keeps r7 independent; failure path links r7 to r0. */
+	"if r0 == 1 goto l0_%=;"
+	"r7 = r0;"
+"l0_%=: if r0 != 1 goto l1_%=;"
+	"r7 <<= 32;"
+	"r7 >>= 32;"
+	"if r7 != %[test_data_len] goto l1_%=;"
+	"r0 = 0;"
+	"exit;"
+"l1_%=: r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 /* Check that mark_chain_precision() for one of the conditional jump
  * operands does not trigger equal scalars precision propagation.
  */

base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.43.0


