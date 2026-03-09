Return-Path: <netdev+bounces-265527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD5tH/K8rmn6IQIAu9opvQ
	(envelope-from <netdev+bounces-265527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:28:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD807238D38
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02EC230E34E8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBD3A6419;
	Mon,  9 Mar 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImDKAILR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D1394462
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058866; cv=none; b=j9f2KyAt55dTf/Y9vgHtF23vIV0ueyB3d3+ZLFCWtiyYulehdkjDqMoYuxpR7Hqa8kTQRuOOHpETJrmJb1k2bbyGzfnC9iXs/P71q0dbWigiN44iV+wNeHYrD8zID74a9o9/ny81giIX2GmmOPr44dBWVdwqvaeix8L1GkFJF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058866; c=relaxed/simple;
	bh=IXJ56yPXbvL2wW+2gxV0vy87UMfMk13puqoL7+gO+5I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RzerlKtc0CVFvOdf4S/8cvkIc2yTqo8eCUMSUE5Ph5IcwGUjkWVudYPjbk7McR/ogLCYX9v20lzyUW+ABNAeE5TRQuePyn12DG56H6jqCK2nizOQ8Yskgo87Rww7iVHfSYHGNIRF6U7vER6Dcy7aMq0AEmfrdOvnN3XOnRJ5Fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImDKAILR; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd81506677so739081685a.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773058863; x=1773663663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3t3G3LLvnJvm54uG+Cb7TCQpAwcUxU8pPUqv0rVI43I=;
        b=ImDKAILR2dGqPvEbDcVnPAEAk+AJC5WH2NPIpitKzNpcvRzl/pzcRkXRwUIze+Z0BO
         kjT9egjxDFK7ZngALH67vQXHffLdDBJRhiMRWEx9tcE6LQlsOaXbiEeKu0JVkVj/jwe9
         r7ZC27Qe3log08gxipebwr7OwNx0u+BeGV3hgPuLY2HYfYphTw583Ln/nR7IaDUApsnb
         rdojSfdI7TI+zfUSnBobgJswlfwH3p437bmbztIEZJGfptyfTEkMz0mwB/gG7X5TFcl+
         923HWK72FRvrAff44J3aAZAut9XOuLa8QCZwI4rM0f8UDpFnn0QldUGDZS/FqbPeHqCm
         3krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058863; x=1773663663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t3G3LLvnJvm54uG+Cb7TCQpAwcUxU8pPUqv0rVI43I=;
        b=ftYCY8U9V113SFBiKQa7/3NeH0sWSLK8GzgVPVIqx8p4TS4ddXCImJW+wr5AphLpNK
         MX14qDlwW7jvhexz4d8OKC3kQcVEzijOo9ylYhM6Cj7YqYsVE3G+9N1LLbilYkENqVxw
         GOc3BjjrMKZ1CHxPRepOlni71Umn7KWjwDRMTppmIH7FZ9QTI7Mv1LQoH2I5TmVUV+rj
         KezxLRI2Kf0Bq3VixrvB+0WZql0E4DG2hZXvF/9iW5Fq5KqUi4XstEB0NLb/kF4FAahN
         jZL2YLd63zkPpT20OiFQDIM5JCi3I8osC5Q7IhXTMSJ0W4/mNidWfXTgo0T0x/+7sIHB
         P1/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2DmB9FkKWeun0w1ueDK8eUAvjbbq6sd5KHIwU5EuOhxuP2XYRMlAjSqvHP2LDkdoQB6ze1hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRQGYic6SwpYR0qf940dtFWlYPRQvAqoF2XvJzck9qoY9gPfP
	xGbZ7AtL/JZQUB+DxaBHv6g8B1A6sDMQKWzgrSrzsp53ziJo3cUj6ehvKiDTTpoFwCGeXJPOmbX
	stt3Iw+IcS0snnA==
X-Received: from qknvj10.prod.google.com ([2002:a05:620a:708a:b0:8cd:8684:7bbf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:480c:b0:8cb:4d05:aa43 with SMTP id af79cd13be357-8cd6d52bb78mr1252756285a.59.1773058862989;
 Mon, 09 Mar 2026 05:21:02 -0700 (PDT)
Date: Mon,  9 Mar 2026 12:20:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309122055.1226507-1-edumazet@google.com>
Subject: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
From: Eric Dumazet <edumazet@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DD807238D38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com,linutronix.de,infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On !PREEMPT_RT and !LOCKDEP kernels, local_[un]lock_nested_bh()
are supposed to be NOP.

This is not exactly true after 7ff495e26a39 ("local_lock: Move
this_cpu_ptr() notation from internal to main header") due to
this_cpu_ptr() being evaluated even if its result it not used.

This prevents some tail call optimizations.

After this patch we have gains in networking fast paths:

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 0/36 up/down: 0/-644 (-644)
Function                                     old     new   delta
tcp_sigpool_end                               79      71      -8
skb_attempt_defer_free                       457     449      -8
ppp_xmit_process                             179     171      -8
ppp_write                                    411     403      -8
ppp_output_wakeup                            135     127      -8
napi_skb_cache_get_bulk                      440     432      -8
napi_consume_skb                             409     401      -8
dst_cache_set_ip6                            203     195      -8
dst_cache_set_ip4                            135     127      -8
cpu_map_enqueue                              193     185      -8
bq_enqueue                                   263     255      -8
__netdev_alloc_skb                           377     369      -8
__netdev_alloc_frag_align                    155     147      -8
__napi_kfree_skb                             136     128      -8
napi_skb_free_stolen_head                    199     190      -9
input_action_end_bpf                        1083    1072     -11
napi_alloc_skb                               275     263     -12
__napi_alloc_frag_align                       59      45     -14
xdp_build_skb_from_zc                        590     574     -16
tcp_v4_send_ack                             1129    1113     -16
sch_frag_xmit_hook                          1260    1244     -16
flush_backlog                                507     491     -16
dst_cache_get_ip6                             99      83     -16
dst_cache_get_ip4                             90      74     -16
do_xdp_generic                               932     916     -16
__napi_build_skb                             591     575     -16
__dev_flush                                  115      99     -16
__cpu_map_flush                               85      69     -16
dst_cache_get                                 55      38     -17
tcp_v4_send_reset                           2682    2658     -24
mptcp_subflow_delegate                       955     931     -24
__alloc_skb                                  988     964     -24
mptcp_napi_poll                              310     281     -29
nat_keepalive_work_single                   1385    1335     -50
gro_cells_receive                            320     244     -76
process_backlog                              486     404     -82
Total: Before=25812320, After=25811676, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
---
 include/linux/local_lock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be7b6327e0922a49befd8fc 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) || \
+    defined(CONFIG_DEBUG_LOCK_ALLOC)
 #define local_lock_nested_bh(_lock)				\
 	__local_lock_nested_bh(__this_cpu_local_lock(_lock))
 
 #define local_unlock_nested_bh(_lock)				\
 	__local_unlock_nested_bh(__this_cpu_local_lock(_lock))
 
+#else
+static inline void local_lock_nested_bh(local_lock_t *_lock) {}
+static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
+#endif
+
 DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __percpu,
 		    local_lock_nested_bh(_T->lock),
 		    local_unlock_nested_bh(_T->lock))

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
prerequisite-patch-id: f6002c357582927a383603a22e69bc0d7a5b9528
-- 
2.53.0.473.g4a7958ca14-goog


