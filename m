Return-Path: <netdev+bounces-293876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OJ8NTPMHWrXegkAu9opvQ
	(envelope-from <netdev+bounces-293876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41281623D2D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A634830376B7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9203E3179;
	Mon,  1 Jun 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW5F+J+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2F3E316D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337262; cv=none; b=DY1IMCGUdcTTw3Oy3+qswQ6MTaVeJPVczia+HeOOBw8c27pvIwts8V0Juw02pfR8gn+OY2XiaYdSrkvNKHoSLxgPbskL/5/5Rfseuw+tyOslufn0gh1PVr5IVfAGs4tk+8ZPYvMx5rPbPykJCpw1N13GjI1UGHx4BLqaLPsKLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337262; c=relaxed/simple;
	bh=H7aNs2wN7213ow2RavgerurEBbg+1krK7dr1GtyEYHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3f0j7JVNQ1eLX5w16/+RGPPlyVqvyGkX0CjlRwseWyIE9IocWCypznMzqnu011BkPWmwHz9QtJsopycDVo9/lHM0WoVnUmPB6NsNjYTfoSgk7dICSM8Ykd1tOIElItOQNPIyjEpthunaIIjwVS/lNCajVoq0v22CdQq1h23wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW5F+J+T; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f53332aso583069b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337261; x=1780942061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gQie9R+iM/u9UZvBcBXG8EPU7/7n/2I9ejVDjywMwo=;
        b=jW5F+J+TyrN96HRTzBWrQQyi2zSJboGAl+6aCz+tF8pVGD8gE7C/dqRULuH5bLGu36
         JK+rUN1mndevMSRCPbkSDswq33QPwtWCKBbjSFEZ06U/AyqI2f7k8VpxBMLXCUJPDpSl
         zpBrehEtB03atguovHG2tI6Y/NErn1L7ZZTHngTPLAdVg0jw406PQXGAITUv9crLrsoy
         tGGflFosTTYQex/+4ahvkDqQ5jdlSgnbbMSzz/IweGqZLu+v73qFo3U+Kv6DEGAl634U
         XzFbnMGJHcsMQ1EA6GAG9G8Le+edD+7igJ/P/f4uBIICw+uZjln/lDylVwv7abS+PWCU
         rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337261; x=1780942061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gQie9R+iM/u9UZvBcBXG8EPU7/7n/2I9ejVDjywMwo=;
        b=QSGhy2WNFjd2+MFAA5NUVjvnOKI0pxi5Nuf8syEiI0L6HOfeW567SgbW71fyEqUYUW
         sSyGT8FLVirB1BHB+65uIwV7yGE76GONwFySmPZ6eQYpQNREyrUM9Zf6FAcZDtiCq5yM
         xzOzysy6aGAgVxlpJYNngo3J+SAWg2oML6FqmUuJDdkuD8U2D3YTvhEB2bqYCVBC6qxY
         hEyP/8lWHcOlMuxjVoGu2N+TYxPxI4L4V/pEJg34CWTQFWYD3E102QE1fRLeNyqpzKEN
         6aN4g4LrDuJzOAlM5jzjaCWjp4Y8jFWiJzDjaK9NPRWn3Vlyt41lxn5sCzcFivYCWMh9
         E1Aw==
X-Gm-Message-State: AOJu0YyIEUFOeoEZD4zK6tOyeLh9MiGeFqJHR/gbK40EQV+XGAr9Xbsd
	bnvKiFNjRo9eZHoxQgjAUDX/caf2fJNUrKTNSonZD26eu3nIB/vN13bv
X-Gm-Gg: Acq92OEx3QafD7sn/1i5IuccLMqJuXdHurAR7J422FrtIDZJCKwEsQQ0wxkkN6qBoJI
	G4HzTLoVAivht+cqjlTanNytlUOg6VoX+VmbOyfMbS3+eDPSmO/coIaW4Z7wi3QzTAmnmLG/5UA
	6MgnwSFx08mM8DzfPOTEo1N6AqpSl6AxOJbNzHjuBQBinOacoEjZgy4DVjK1TytI0P70H4oKbkH
	o31bA3DCDGDG+hihM+okfIc93L4y10Bu3hHuAfuJaD69G8GxEkaLOIk2gykI4rNkw79cRvq6bx/
	Rt12ybZ2ltc8XLo2uQF1l0ROhTI8Vi3YLEiTw2UtvY0gM2dBBCJ31ggMMpS0PUKHWp99gk7S/Ny
	7mkQdgJHD1S4AJCON4JnuEkFhcdLQ6ceDRfFYoTTNL6B3o/Leam820qob4nrcmxFKdmkD+Q/XzI
	WH7dkCSCP4c8KU/9I11CqZPE6tMEJcuSotHLjOR8lQH6g=
X-Received: by 2002:a05:6a00:7599:b0:842:3373:f66e with SMTP id d2e1a72fcca58-84233741059mr7935773b3a.28.1780337260635;
        Mon, 01 Jun 2026 11:07:40 -0700 (PDT)
Received: from localhost.localdomain ([212.107.31.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm7389702b3a.22.2026.06.01.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:07:40 -0700 (PDT)
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
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	tamird@kernel.org
Subject: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking fixes
Date: Tue,  2 Jun 2026 02:03:58 +0800
Message-ID: <20260601180400.1381736-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293876-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41281623D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi BPF maintainers,

This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
The series is intended to fix a verifier state-pruning issue where an
impossible scalar path can be kept while the real success path is pruned.

This is a verifier scalar range-tracking issue, not a helper-specific
issue.
The visible failure is that the verifier can prune the real success
continuation, which should not be skipped, and keep only an impossible one.
In the reproducer, the traced function returns 15 at runtime, but the
verifier keeps the path where r7 is treated as 0, hard-wires the opposite
branch, and the program reports the error branch.

The minimized reproducer uses fexit/bpf_get_func_ret only because it
provides a compact way to create the interesting register flow: one scalar
in r0 for the helper status, and another scalar loaded from the stack for
the traced function return value. The issue is not specific to
bpf_get_func_ret itself.
Because bpf_get_func_ret() was added in v5.17, this particular reproducer
directly applies to 6.1.y. I have not built a 5.15.y-compatible reproducer.

The relevant verifier-log bytecode from the reproducer is below. The later
instructions only store r7 into a map so user space can observe which
branch the verifier kept.

  15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
  16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
  17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
  18: (bf) r7 = r0                      ; R0=scalar(id=1) R7=scalar(id=1)
  19: (55) if r0 != 0x0 goto pc+6       ; R0=0
  20: (67) r7 <<= 32                    ; R7_w=0
  21: (77) r7 >>= 32                    ; R7_w=0
  22: (b7) r1 = 1                       ; R1_w=1
  23: (55) if r7 != 0xf goto pc+1

The failure mechanism is:

  1. The program checks "if r0 == 0". The jump target is the success path,
     and the fallthrough path is the failure path and should imply r0 != 0.

  2. On v6.1.91, the verifier does not record that r0 != 0 fact for the
     fallthrough path. The following "r7 = r0" then gives r0 and r7 the
     same scalar id while both are still treated as possibly zero.

  3. At the later "if r0 != 0" check, the verifier still thinks r0 may be
     zero, so it explores the fallthrough path of that JNE. That path means
     r0 == 0, and because r7 shares the same scalar id, r7 is narrowed to
     zero as well. This is an impossible path: it came from the earlier
     failure path that should have implied r0 != 0.

  4. That impossible continuation reaches the return-value comparison with
     r7 == 0 and can make the verifier keep only the wrong branch. When the
     real success path is analyzed later, state pruning considers it safe
     against the earlier cached verifier state, so the real continuation is
     not explored.

The relevant pruning point is that regsafe()/states_equal() accepted the
real success-path state against an earlier cached state where r0 was an
imprecise scalar and r7 constraints were loose enough to cover the current
r7.

After confirming the mechanism, I ran git bisect with this minimized C
reproducer as the test case. The bisect started from the affected 6.7.y
behavior and the fixed v6.8 behavior, and narrowed the fix to the
v6.7..v6.8 window:

  https://gist.github.com/swananan/165cca6008f6c81870a28aa7a445d5ea

The bisect identified the upstream fix as:

  d028f87517d6775dccff4ddbca2740826f9e53f1
  bpf: make the verifier tracks the "not equal" for regs

For 6.1.y, applying d028f87517d6 alone is not sufficient. The older
verifier code also needs the range-preservation semantics from:

  9e314f5d8682e1fe6ac214fb34580a238b6fd3c4
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic

Without that semantic prerequisite, the old range-combining logic can still
discard the refined bounds after the verifier learns them.

The 6.1.y adaptation is split as follows:

  - patch 1 carries the 6.1.y-relevant part of 9e314f5d8682 by removing the
    knowledge-losing __reg_combine_{32,64}_into_{64,32} paths and using
    reg_bounds_sync() after conditional refinement;
  - patch 2 carries d028f87517d6 in the older reg_set_min_max() layout. In
    newer kernels, reg_set_min_max() refines the fallthrough branch through
    rev_opcode(opcode), so the fallthrough branch of BPF_JEQ is handled by
    the BPF_JNE refinement. In 6.1.y that split does not exist, so the same
    not-equal fact is expressed directly on BPF_JEQ's false_reg and
    BPF_JNE's true_reg.

Observed results with that reproducer:

  v6.1.91:               REPRO: BAD  (ran=1 error=1)
  v6.7.12:               REPRO: BAD  (ran=1 error=1)
  v6.8:                  REPRO: GOOD (ran=1 error=0)
  v6.1.91 + this series: REPRO: GOOD (ran=1 error=0)

Because this touches shared verifier scalar range logic, I am sending it as
RFC and would appreciate BPF maintainer guidance on whether this 6.1.y
semantic backport should be carried and whether the split in this series is
reasonable. The same issue should also be relevant to 6.6.y, which still
has the older verifier logic and predates the v6.8 fix, but this RFC only
includes the 6.1.y backport.

Zhenzhong Wu (2):
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  bpf: make the verifier tracks the "not equal" for regs

 kernel/bpf/verifier.c | 92 +++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 52 deletions(-)

base-commit: 228da13e907e2b46b7222cfc35290fbfad920bef
-- 
2.43.0

