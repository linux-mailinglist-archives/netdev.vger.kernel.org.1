Return-Path: <netdev+bounces-295984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WRsiNBJGI2qjnAEAu9opvQ
	(envelope-from <netdev+bounces-295984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:56:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFCE64B7C0
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:56:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BUEYYH13;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295984-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D60300A387
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05337BE74;
	Fri,  5 Jun 2026 21:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082E3093B5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 21:48:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696093; cv=none; b=SVzcFa3Q98zdGqOihAqUDS7Cfbhj8XckVaP67S7CUPFBr4UxCLAXd5vH1k3SJoyipmyDtOhJ4KpgOOfxZc3kzPM9b1lFyFQHgurNfsB8o6zLlh2/TFvhwFMFz78H+65sUQbUxzI+0Vivzqz62xS6yXzmtebGHwqP4ZdMUOIYGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696093; c=relaxed/simple;
	bh=BYpjAtRPzh98AaTfkHIJzcuA4v1A26ns3/vqFvB0NdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONrYoFxjmp9G0CXWPeGKh++1CdkBmTc36X/+oLAaiAM7i4S5FnpP551erL0Ly2HWRygRyX+p9AaHznh/vWJI3McdIA7warHlbzLPTXeLLyQBnDx5qNDUoM7lIbuvycc8eZkGyriY/chTf3Kn8yoYdE+JmCzJJbbtkPF6hLJPNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUEYYH13; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso1746147a91.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696091; x=1781300891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hwfxyR3TaczFPiobb9s5yfYVHM9qFeamWh5WTd7gT4=;
        b=BUEYYH139wwSP/1wYU+S7tN2keLtQnPEasa/Xjz6RqwnJfLk/HArz3S8a1kQ/djXlH
         d/HaPJ6hk9h+7Q9G3MB82FuLoaYANABtPoXaTCNeP1mSSS+BmX0Q/zGaH3+4GwtvXmR7
         TKmxdltgZT78wTylRWfMvnZKE5sRC3kVbASujw31YZ/rJT45xEZXN+lP0MeIRyZtbsBW
         +gGctQ0/4ecSJtUnywFYKPjcgQYqJA6h9mgHmpeESmAHcVWUMhmJvJD1RiQlfSOkMIDO
         Ykk9RwFEKjLnkppbxnvFj30qTc4W6lGEFh1MamGURsAh2fe9ba1QN32fwXicYbuO4zSf
         ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696091; x=1781300891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hwfxyR3TaczFPiobb9s5yfYVHM9qFeamWh5WTd7gT4=;
        b=dCSASjdudYR1J3oOEJWxABEtmBIpbkou/EryyU4Q7JkgCX+T5RvFQ9Szv9ddEXZLmS
         krvJfC8NfZ8BR927Dw+G1VnbTSkqsml/kEpmtMsqPcAZx3Pfni969zSbqIlbArL22wfi
         QS4G3SQnbRezJMmi9YIxad9wAd6hpnfOYHIfikEOP1Uv3DI/SsUgOs10hdHi8lvejZUZ
         IAK12fhHxn77auzj9smC3w4vS5k56VGiEVN1OgEsf2LLAJTAsKF9tkx1u+gY75Rlz2Xm
         2sWAbuZwycH3bOmzgWbUWL6F7DTgaqTOGO3AgzJcZIiAEtAG2r1d8ahu90xDt1WH1NiR
         RcGQ==
X-Forwarded-Encrypted: i=1; AFNElJ81i43noQhfbvu+dgTMXroUQuacHXzXjrgG0ecIHG7SXUtFBObXcpG6DQmLgrP/ufZL5qJpuY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXQGFGYbEfixIhb9uaEFkBv2FUrmZ9ZnG7NpB3eNKGJHDxLy0
	9+CYIfqeHZ0/v/Kb6v9vW030pK/BqQuwcFwnk4JXr8DVjsyKSIRXwQeB
X-Gm-Gg: Acq92OF48u0X94I/ZavnCwz6iPeq3IT5vZDxvCyaSWVAfl1hfNp/b5W2tJZNOXpgQ+3
	57ZirLiEefbKTHwU8lrr8Yp/bK9JLyMeobh2L3T6c8wEXsk2rPEWsI1wgREInD9QFkjb1bVVZzM
	9F5Qb6FSY1SOOI8qr4b5sTnaH8xI7cyOwRTRrTtb/Cdw/VzWRk2FXXVtgUHCBYFiK3tdhHwVbgE
	CC13skjs2lCqDXDTJoNdBSaP5EXZNBSx+iYEc8/AArSRxl8wTMN3P8w/OcDCG6ZqO60CYdCGr02
	RqypRY4cEpeJql5qxYQymGuIDu6OtqfsALLr2ZlvUEGN3R5OiTE6N/gnPWz1wlLibmZcKFN+v0W
	LjmMij+UES+NFY3VNA1EX2OtqWUDE5nHsjYGxa8WbJPa6vOUHgHSPGxTl1tiDtSJhDwTq8If/fn
	TZkcjCoIHivOcy75RIC9E0zT/MnW3ITHHNfUZUjTG0VL79tSdJGagOC4SQ6Zpic9M5ThF0wDwA
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr63751155ad.24.1780696091201;
        Fri, 05 Jun 2026 14:48:11 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm101060345ad.20.2026.06.05.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:48:10 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork error path
Date: Fri,  5 Jun 2026 21:48:00 +0000
Message-ID: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295984-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DFCE64B7C0

tls_sw_sendmsg_locked() caches a pointer into the open record:

	rec    = ctx->open_rec;
	msg_pl = &rec->msg_plaintext;

and keeps using msg_pl after bpf_exec_tx_verdict(). When an attached
SK_MSG bpf program calls bpf_msg_apply_bytes(), tls_push_record() splits the
open record: the original record is encrypted, queued and freed by
tls_tx_records(), while ctx->open_rec is replaced by the split remainder.
If the bpf program also sets cork_bytes, bpf_exec_tx_verdict() then returns
-ENOSPC, and the error path dereferences the now-dangling msg_pl:

	else if (ctx->open_rec && ret == -ENOSPC) {
		if (msg_pl->cork_bytes) {	/* use-after-free */

  BUG: KASAN: slab-use-after-free in tls_sw_sendmsg+0x118d/0x16f0
  Read of size 4 at addr ffff88810a36f2ac by task syz.0.17/2056
  CPU: 1 UID: 0 PID: 2056 Comm: syz.0.17 Not tainted 7.1.0-rc6 #2
  Call Trace:
   tls_sw_sendmsg+0x118d/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0
   __x64_sys_sendto+0x7b/0x90
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 2056:
   tls_get_rec+0x7a/0x3d0
   tls_sw_sendmsg+0x3cd/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0

  Freed by task 2056:
   kfree+0x163/0x560
   tls_tx_records+0x2d6/0x380
   bpf_exec_tx_verdict+0x3de/0xd50
   tls_sw_sendmsg+0x10e9/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0

ctx->open_rec already points at the live record on this path, so re-fetch
msg_pl from it before use.

Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/tls/tls_sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..39dee66cc99b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1165,6 +1165,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
 				else if (ctx->open_rec && ret == -ENOSPC) {
+					msg_pl = &ctx->open_rec->msg_plaintext;
 					if (msg_pl->cork_bytes) {
 						ret = 0;
 						goto send_end;
-- 
2.43.0


