Return-Path: <netdev+bounces-300888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yYelGW8fOGqEYQcAu9opvQ
	(envelope-from <netdev+bounces-300888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C96AB57A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="I/6q6Y7p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300888-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300888-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D02B3015465
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4382DECBA;
	Sun, 21 Jun 2026 17:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95117299A82
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 17:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062953; cv=none; b=kYkHDYJbZJmO0OzpthksR/Lcql0S2HtGVJ9rlylAF+T9egdiEa6MlX9SegLRJOFDNsdn3G/ozHqvdrDgjH4yCLItmx09SLliTKPI7N35dFxls6y8TdT8ifdg9g6cD7W2YItxO0P3+tovN/IyZTayAT6Pmk4JBGVQEBIAwyXRm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062953; c=relaxed/simple;
	bh=ooKs+tObdJQYcUiMrUCinsxvErsdtsBaWgUuYc7y9dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxcGIFWcGNij+diSG4U0KMorNyBip8NdgjjeaGYiPAocIiTZwExLgcN05Z2TIv4V31nDkTw3ZmkdmOpcQ3mTx6T9r0fouQvqkS0ziXc2BSiK65Nn5JRhMiZ0PUz+Iuz+WZgtWM+inzwLnzy0bsqsf6TVDn4ZKominjElUq/9qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/6q6Y7p; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1397e093f90so9521820c88.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782062951; x=1782667751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odj0L/R/VEGOCXSJvy9yUhx0KC/Mishkz8wmOHK4I/M=;
        b=I/6q6Y7p86wki6uXqclxNjIklFd359yXbffckpDH0NwIi/rMhDKZPT4126VGs4IXoR
         SB0aoPlQkUAlpLK5CPWx2AM8pI8WhfOFDbHaQ+BX6O95fjjXGBAGuqDWfq6fnZa9jIT/
         8YAyk0ly2RXUwjKd/nHSR6cN8viVgOt286ZCQT7j950fAlkfGI+NjhhNnl81+bzJQbu1
         ogESh1YLo72lye8cLERcet4Zzp1cRGDBnPQaVN73Z5qzCl6qSye4Wft4B4dlsAtnq7QG
         gHEaA90O1Shh1RicXnPFiT65sO8DZYo8tz7v7bKnppI7F/ClOrFcPA9bqFl49OA7WpEL
         2YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782062951; x=1782667751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odj0L/R/VEGOCXSJvy9yUhx0KC/Mishkz8wmOHK4I/M=;
        b=KBeN9idquTJFbc4gdHRTDQP5wsBNsWu0BNezr2ZEnbVgibgZpewzyTvDE1bsRYfBWL
         yWcBOUEHVXY4uf7yQD3JuwZrcZJy2mvft/LZ42gNjwxd+ngwBmDL9ESrtYnldupI5Xnr
         sIx08gBGqK0F8mqIjP96pcMgytj1vpWBZmyvLDPbpAMDCEY+PcNHjCPOOZsLuyze2Sqq
         n8S3OeWIOdjUlvKbsN1fUxdBZEh3kDM/XNBeLOo7LFQNGw1hEd/7SpMvPKhfVguPBUUM
         7Vf9c7qZdzDKCBzB6ga/z8mIz3t0DMoS4Tfm02B1Ivvh+ovEY0fv/qi9/FB6Zu5Yjh/G
         fAXQ==
X-Gm-Message-State: AOJu0Yz5mBLbN7VCA9tZdk3Uc+n2MUsBplxQJfj218Xfgdm3O4HkU1S/
	6lkSRGJwDE9zQ9+VP3IAZEzAtnZH55qaDfkuiYaUrFg531ULuCVf7l1n
X-Gm-Gg: AfdE7cl+vWauwL2Hc+2IKXsbYUFpZ/Ohgyy0SsWpJ6kgAndlu/9VS0g1+89CSKcQlF7
	5JveHtZiTPOGy7TsW9xONPywIZEESS7dB6MebY2xlZkeUP2CdUEOwgTKBba3rsY0//GWzM67zTL
	Dr2/j1HuOpUcuxVjPdtbebZhKO4XtpKcaKiKDciPrny/8KWKGw2eNWlqt11fH9bG2QJy+3g3uV6
	rIzMEOyqmWEUWjF/lhM1/jc8WSP8GXY/oJdLfWHMeL5/cGw+bkpcBzAhzkFxLP1Ki4XXeWQKn/t
	AAqJEjipe7k5Wm11vTIeIr7p8SsXXAmwjVHGCo8Nz7s2zFc7bpKp4hXXPfc/n9JrrsU1F3LJLmS
	uN0SMSIEvb4ZKOAShwTzGNCeb2GY8J/ooCE5wafgADAai84qDSPlf1kq2bbQUhDD1h3tXIQ/9/N
	kbwKQLT06Pc8/F21pWQRoc+wA=
X-Received: by 2002:a05:7022:6988:b0:136:e42d:2c2b with SMTP id a92af1059eb24-139a36740femr6948564c88.17.1782062950394;
        Sun, 21 Jun 2026 10:29:10 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:29:09 -0700 (PDT)
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
Subject: [PATCH stable 6.6.y v4 0/4] bpf: linked scalar precision fixes
Date: Mon, 22 Jun 2026 01:27:31 +0800
Message-ID: <20260621172735.409355-1-jt26wzz@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	TAGGED_FROM(0.00)[bounces-300888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE1C96AB57A

Hi,

This v4 targets 6.6.y and keeps the v3 backport strategy: use the full
upstream linked-scalar precision-tracking series, instead of the earlier
d028f87517d6/9e314f5d8682 not-equal refinement backport path.

The original observed failure was found in Rust/Aya-generated eBPF
around helper calls. Rust match lowering can keep a helper return value
and a scalar filled through a by-reference helper argument in the same
enum-style control flow. That makes it easy for the verifier-visible
scalar values to become linked by scalar id.

The relevant verifier-log bytecode from the original reproducer is
below. The later instructions only store r7 into a map so user space can
observe which branch the verifier kept.

  15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
  16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
  17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
  18: (bf) r7 = r0                    ; R0=scalar(id=1) R7=scalar(id=1)
  19: (55) if r0 != 0x0 goto pc+6       ; R0=0
  20: (67) r7 <<= 32                    ; R7_w=0
  21: (77) r7 >>= 32                    ; R7_w=0
  22: (b7) r1 = 1                       ; R1_w=1
  23: (55) if r7 != 0xf goto pc+1

The important verifier state shape is:

  1. The program checks "if r0 == 0". The jump target is the success
     path, and the fallthrough path is the failure path.

  2. On the failure path, "r7 = r0" gives r0 and r7 the same scalar id.
     The real success path skips that assignment, so r7 is independent
     there.

  3. At the later "if r0 != 0" check, an affected verifier can explore
     an impossible continuation where r0 is zero and r7 is narrowed
     through the shared scalar id as well.

  4. That impossible continuation reaches the return-value comparison
     with the wrong r7 value. When the real success path is analyzed
     later, state pruning can consider it safe against the earlier
     cached verifier state and skip the real continuation.

The root cause is verifier scalar state tracking, not helper-specific
behavior. A helper return value in r0 and another scalar can become
linked by scalar id on one branch. The real success path can skip that
assignment, so the two verifier states are not equivalent.

The relevant pruning point is that regsafe()/states_equal() accepted
the real success-path state against an earlier cached state where r0 was
an imprecise scalar and r7 constraints were loose enough to cover the
current r7. In the impossible path, r0 and r7 are linked by scalar id
after instruction 18. In the real success path, instruction 18 is
skipped and that scalar-id relationship does not exist. These states
should therefore not be treated as equivalent for pruning.

The upstream linked-scalar precision series fixes that root cause by
recording, in jmp_history, which linked registers were synchronized at
each conditional jump and by using that per-instruction history during
precision backtracking. This covers both the original r0 == 0 /
r0 != 0 shape and the r0 == 1 / r0 != 1 shape used by the separate
runtime selftest.

A Rust/Aya-specific runtime reproducer/selftest discussed in the v2
thread has been submitted separately to bpf-next for review:

  https://lore.kernel.org/bpf/20260611160749.391279-1-jt26wzz@gmail.com/

That reproducer keeps the same helper-return/control-flow shape but
shifts the success value to 1 before branching. This avoids depending
on the not-equal-zero refinement and exercises linked scalar precision
during state pruning directly. It uses bpf_skb_load_bytes() in the
normal tc test-run path and does not require fexit attach or
bpf_get_func_ret(). It is not included in this stable series because
per review feedback it should go through bpf-next first before being
considered for stable.

Targeted results for that separate helper-status runtime reproducer are:

  v6.6.142 + reproducer:                                  FAIL
  v6.6.142 + v2 d028/9e backport path + reproducer:      FAIL
  v6.6.142 + this linked-scalars series + reproducer:    PASS
  bpf-next + reproducer:                                  PASS

Changes since v3:
  - add the tools/testing/selftests/bpf/verifier/precise.c expected-log
    update for "precise: test 1";
  - drop the v3-only collect_linked_regs() singleton cleanup and use
    the final upstream linked_regs.cnt > 1 history-recording check in
    patch 1.

v3:
  https://lore.kernel.org/r/cover.1781194510.git.jt26wzz@gmail.com/

v2:
  https://lore.kernel.org/r/20260607170959.823755-1-jt26wzz@gmail.com/

RFC v1:
  https://lore.kernel.org/r/20260601180400.1381736-1-jt26wzz@gmail.com/

Backport details:

This series is based on v6.6.142 / stable/linux-6.6.y commit
924b4a879cbb ("Linux 6.6.142"). I would like it applied to 6.6.y first.
The same issue is reproducible on 6.1.y, 5.15.y, and 5.10.y, but those
trees need separate older-layout adaptations.

Instead of backporting the d028f87517d6 not-equal refinement plus the
9e314f5d8682 range-combining prerequisite, this series backports the
full upstream linked-scalar precision-tracking series:

  4bf79f9be434
    bpf: Track equal scalars history on per-instruction level
  842edb5507a1
    bpf: Remove mark_precise_scalar_ids()
  bebc17b1c03b
    selftests/bpf: Tests for per-insn sync_linked_regs() precision
    tracking
  cfbf25481d6d
    selftests/bpf: Update comments find_equal_scalars->sync_linked_regs

Upstream series:
  https://lore.kernel.org/r/20240718202357.1746514-1-eddyz87@gmail.com/

Patches 1 and 2 are the verifier changes from that upstream series. The
main 6.6.y-specific verifier adaptation is in patch 1: 6.6.y does not
yet have the newer BPF_ADD_CONST scalar-id representation, so
sync_linked_regs() is adapted to the older scalar-id layout. Patch 1
otherwise keeps the upstream linked_regs.cnt > 1 history-recording
condition.

Patch 1 also carries the matching upstream test_verifier expected-log
change for tools/testing/selftests/bpf/verifier/precise.c that v3
missed. On 6.6.y this is a one-line update to the "precise: test 1"
parent-state log, from regs=r2 to regs=r2,r9. Patch 2 then follows on
top of the adapted layout.

Patches 3 and 4 bring the upstream verifier selftests and comment
updates. Patch 3 has one 6.6.y-specific log adaptation:
linked_regs_broken_link_2 keeps the "div by zero" reject check, but
drops the upstream mark_precise log expectations because 6.6.y does not
derive the scalar-vs-scalar range for that non-constant JMP_X
comparison. Patch 4 only updates the two pre-existing comments that are
present in 6.6.y.

Relevant selftest results on 6.6.y with this v4 backport:

  test_verifier:
    788 PASSED, 0 SKIPPED, 0 FAILED

  test_progs -t verifier_scalar_ids:
    all 18 verifier_scalar_ids subtests passed

Thanks to Shung-Hsi Yu for reviewing v2/v3 and suggesting the upstream
linked-scalar precision series as the preferred backport direction.

Eduard Zingerman (4):
  bpf: Track equal scalars history on per-instruction level
  bpf: Remove mark_precise_scalar_ids()
  selftests/bpf: Tests for per-insn sync_linked_regs() precision
    tracking
  selftests/bpf: Update comments find_equal_scalars->sync_linked_regs

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/verifier.c                         | 364 +++++++++++-------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 253 ++++++++----
 .../selftests/bpf/progs/verifier_spill_fill.c |   4 +-
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |   4 +-
 6 files changed, 415 insertions(+), 216 deletions(-)


base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
-- 
2.43.0

