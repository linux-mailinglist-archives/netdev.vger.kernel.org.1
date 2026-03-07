Return-Path: <netdev+bounces-265093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HPLB6XKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:50:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE322A7C8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E91D3061512
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8E374753;
	Sat,  7 Mar 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs1blK3P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87113016FC
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865883; cv=none; b=kiUB4HrcVO54opkmxzcztxb3CyUxpazJn/ptAL0Lrqtj0Xybjh/YVdf03z0QWBQvoYpy3dsPSskdV7I1l9UW4DaSwJH8GiEnzxQjwwRPIE8E8HpI2YU/uUau+9pGXiDLJ10YtjDcP8cV0gIrdaycsBT0KEU+9lkyCBDAKUbssfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865883; c=relaxed/simple;
	bh=I0tzPL0aFeMS2WWrGqYaGnXOAI66uZHw3bD/yJmzb4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lauOTUUXJ55HZrd4WhAcLGDt5+PnGG0x7xQ7JKzC5S1Ed3Cb9g4LqevU8rvR5dQxd6eNjQXp1ITz0NNQg+RsXq1eXzVFVwO0y52Z4dN6cgn9FMQThji0g1OOVYvyKxueTzBhoJN2LP3uj28SvfS8TFnpw/2WhbKA9NiiZV5UPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs1blK3P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4988e039so44569695ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865881; x=1773470681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpZf5Rj08FR646dOpjG3VqxqgOpKghxdnT1y4De/qHk=;
        b=fs1blK3PU6okBMId/nzw2yXSH6HXh84Mqq59IEEYzPJ95aPgFrxXPqA/5E2nKuCENh
         KfIAMarr/sR3sxHYzHz+Z56+FwetElU1bQ7DJcsAeo85v12HeVoSfjA8FPKuRctCw91n
         /R0qg4MyDoRsh0B0xoNq6M6RPoW8KBHOoKTss6iELiOE6Yqq3AqHHfvmHhc/xF897fIC
         RdZPBs4rv+LYN924ZzL766nYvAnyJFAOHahpsArrtQnirblUmaRbS0DrJGMjJmjN71wC
         BH37HWbiJak2pXz39Dg5xNY5HTHcv6d//bpDWLOGPeI+x3rn6dkI/RVTuZ9k7BfFqY7n
         IIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865881; x=1773470681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpZf5Rj08FR646dOpjG3VqxqgOpKghxdnT1y4De/qHk=;
        b=FgqQMNJc1DdQSO6AZlDCfJhMhdGGn/JdtYJORcv/fyfGT1TdOF+WSk5ogvAEtgRiaf
         tV/gbtei4SGJYFsGzCHr+KcCTIGpLMwsKvmnFKzZtXJrLzmmSM2m/g5KOizGe1PdP5Uy
         vRriwax/0K9Jnz3+2o8GXxy2zRH9sifzEpKbKMBIH+7Iqow9aMIQ2DdJiDqzo0NAXhan
         RkisRymGN0Os8bFAri76D/jTbp+rDdCgCVUPGdUGuT5O5RhpsxPjDr69Ko1WHfH8PLb5
         IXAzIHRuQ7UyiF2NVF7RDmuh13OWhVHrzbcFNEUnLs84o72SfWRw6jXEU/6vPR7GbKsp
         Vg0g==
X-Gm-Message-State: AOJu0YxFnasRGv6P7TiT7kReKJvofmTNgXBoXdI/nda0AiC4C+Eqq1UM
	ODvfJY9H4DpN4G+WGRF+5n35rtaWOVsqK7klDi/xA8wgXC0ezCyNxbrF
X-Gm-Gg: ATEYQzyYz9DVkbB/7yKTZIyKO12PMRbQbgxYlVafZmlUwdlMcm0Altfo0WyJ4+aCETG
	nkETerCy7mPZaieSn8ew+IAqnOUFHFiE17mb5mlptecELlEDXoYX2KU5VqN2TyLO9mt17eG/VUC
	o967Gmbrgpf1g2JSnIfdsNYqfwuDMZhWehZx8bS6lvGugo62vf+al4OttG1OVNzjUb6KRRLJKKI
	oPMSokyP3rzEg0APiPMpUmzi5+X+9RBd3hUAmqQ1oXIx7IMODt4/9dUO6DScKD5VmzA+jBEY0iq
	ZjsOv2zBtN6e1D9/2VcvsGMws+b9KxZVUBIJWE07bpf03MRP5d5H8pz4nOQwMxJ9EnVLybAe5IJ
	aH8unHNPsBcTH8If63G7/Ky2i3T4RVIdZ8N0vA9pQUnjV3bYeWBN1ty0V4eSTHZxGRhZW0KssGE
	fylx3ARlqYuZFY
X-Received: by 2002:a17:903:1d0:b0:2a7:aac1:7201 with SMTP id d9443c01a7336-2ae75b09c8fmr84034725ad.3.1772865881101;
        Fri, 06 Mar 2026 22:44:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57af3sm55536105ad.13.2026.03.06.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:40 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 00/11] Dynptr cleanup and bugfixes
Date: Fri,  6 Mar 2026 22:44:28 -0800
Message-ID: <20260307064439.3247440-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87EE322A7C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265093-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patchset (1) cleans up dynptr handling (2) refactors object parent-
child relationship tracking to make it more precise and (3) fixes dynptr
UAF bug due to a missing link between dynptr and the parent referenced
object in the verifier.

This patchset will make dynptr tracks its parent object. In bpf qdisc
programs, an skb may be freed through kfuncs. However, since dynptr
currently does not track the parent referenced object (e.g., skb), the
verifier will not invalidate the dynptr after the skb is freed,
resulting in use-after-free. The similar issue also affects file dynptr.
To solve the issue, we need to track the parent skb in the derived
dynptr and slices.

However, we need to refactor the verifier's object tracking mechanism
first because id and ref_obj_id cannot easily express more than simple
object relationship. To illustrate this, we use an example as shown in
the figure below.

Before: object (id,ref_obj_id,dynptr_id)
  id         = id of the object (used for nullness tracking)
  ref_obj_id = id of the underlying referenced object (used for lifetime
               tracking)
  dynptr_id  = id of the parent dynptr of the slice (used for tracking
               parent dynptr, only for PTR_TO_MEM)

                      skb (0,1,0)
                             ^ (try to link dynptr to parent ref_obj_id)
                             +-------------------------------+
                             |           bpf_dynptr_clone    |
                 dynptr A (2,1,0)                dynptr C (4,1,0)
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
              slice B (3,1,2)                 slice D (5,1,4)
                         ^
    bpf_dynptr_from_mem  |
    (NOT allowed yet)    |
             dynptr E (6,1,0)

Lets first try to fix the bug by letting dynptr track the parent skb
using ref_obj_id and propagating the ref_obj_id to slices so that when
the skb goes away the derived dynptrs and slices will also be
invalidated. However, if dynptr A is destroyed by overwriting the stack
slot, release_reference(ref_obj_id=1) would be called and all nodes will
be invaldiated. The correct handling should leave skb, dynptr C, and
slice D intact since non-referenced dynptr clone's lifetime does not
need to tie to the original dynptr. This is not a problem before since
dynptr created from skb has ref_obj_id = 0. In the future if we start
allowing creating dynptr from slice, the current design also cannot
correctly handle the removal of dynptr E. All objects will be
incorrectly invalidated instead of only invalidating childrens of
dynptr E. While it is possible to solve the issue by adding more
specialized handling in the dynptr paths [0], it creates more complexity.

To track precise object relationship in a simpler way, u32 parent_id is
added to bpf_reg_state to track parent object. This replaces the
PTR_TO_MEM specific dynptr_id. Therefore, for dynptr A, since it is a
non-referenced dynptr, its ref_obj_id is set to 0. The parent_id will be
set to 1 to track the id of the skb. Note that, this will not grow
bpf_reg_state on 64 byte machine as there is a 7-byte padding.

After: object (id,ref_obj_id,parent_id)
  id         = id of the object (used for nullness tracking)
  ref_obj_id = id of the referenced object; objects with same ref_obj_id
               have the same lifetime (used for lifetime tracking)
  parent_id  = id of the parent object; points to id (used for object
               relationship tracking)

(1) Non-referenced dynptr with referenced parent (e.g., skb in Qdisc):

                          skb (1,1,0)
                               ^
          bpf_dynptr_from_skb  +-------------------------------+
                               |      bpf_dynptr_clone(A, C)   |
                 dynptr A (2,0,1)               dynptr C (4,0,1)
                           ^                              ^
        bpf_dynptr_slice   |                              |
                           |                              |
              slice B (3,0,2)                slice D (5,0,4)
                       ^
  bpf_dynptr_from_mem  |
  (NOT allowed yet)    |
         dynptr E (6,0,3)

The figures below show how the new design works in different 
referenced/non-referenced dynptr + referenced/non-referenced parent
combinations. The relationship between slices and dynptrs is ignored
as they are still the same. The main difference is how clone dynptrs
are represented. Since bpf_dynptr_clone() does not initializes a new
dynptr, the clone of referenced dynptr cannot function when the
original or any of the clone is invalidated. To represent this,
they will share the same ref_obj_id. For non-referenced dynptr, the
original and the clones will be able live independently.


(2) Non-referenced dynptr with non-referenced parent (e.g., skb in TC,
    always valid):

      bpf_dynptr_from_skb
                                  bpf_dynptr_clone(A, C)
             dynptr A (1,0,0)                  dynptr C (2,0,0)

                         dynptr A and C live independently

(3) Referenced dynptr with referenced parent:

                     file (1,1,0)
                           ^ ^
     bpf_dynptr_from_file  | +-------------------------------+
                           |       bpf_dynptr_clone(A, C)    |
             dynptr A (2,3,1)                  dynptr C (4,3,1)
                         ^                                 ^
                         |                                 |
                         dynptr A and C have the same lifetime


(4) Referenced dynptr with non-referenced parent:

 bpf_ringbuf_reserve_dynptr  
                                  bpf_dynptr_clone(A, C)
             dynptr A (1,1,0)                  dynptr C (2,1,0)
                         ^                                 ^
                         |                                 |
                         dynptr A and C have the same lifetime


I also tried folding id and ref_obj_id into id and using ref_obj_id to
track parent [1]. This design was not able to express the relationship
of referenced sk pointer and casted referenced sk pointer. The two
objects needs two id to express that they have the same lifetime but
different nullness.

Referenced socket pointer:

                                C = ptr_casting_function(A)
                ptr A (1,1,0)                     ptr C (2,1,0)
                         ^                                 ^
                         |                                 |
                        ptr C may be NULL even if ptr A is valid
			but they have the same lifetime


To avoid recursive call chain of release_reference() ->
unmark_stack_slots_dynptr(), release_reference() now uses
stacked-based DFS to find and invalidate registers and stack slots
containing the to-be-released id/ref_obj_id and all dependant ids
whose parent_id matches the id. Currently, it skips id == 0, which
however maybe a valid id e.g., pkt pointer by reading ctx. Future work
may start giving them > 0 id. This should not affect the current usecase
where skb and file are both given > 0 id.

[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
[1] https://github.com/ameryhung/bpf/commits/obj_relationship_v2_no_parent_id/ 


Changelog:

v1 -> v2
  - Redesign: Use object (id, ref_obj_id, parent_id) instead of 
    (id, ref_obj_id) as it cannot express ptr casting without
    introduing specialized code to handle the case
  - Use stack-based DFS to release objects to avoid recursion (Andrii)
  - Keep reg->id after null check
  - Add dynptr cleanup
  - Fix dynptr kfunc arg type determination
  - Add a file dynptr UAF selftest
  Link: https://lore.kernel.org/bpf/20260202214817.2853236-1-ameryhung@gmail.com/

---

Amery Hung (11):
  bpf: Set kfunc dynptr arg type flag based on prototype
  selftests/bpf: Test passing CONST_PTR_TO_DYNPTR to kfunc that may
    mutate dynptr
  bpf: Unify dynptr handling in the verifier
  bpf: Assign reg->id when getting referenced kptr from ctx
  bpf: Preserve reg->id of pointer objects after null-check
  bpf: Refactor object relationship tracking and fix dynptr UAF bug
  bpf: Remove redundant dynptr arg check for helper
  selftests/bpf: Test creating dynptr from dynptr data and slice
  selftests/bpf: Test using dynptr after freeing the underlying object
  selftests/bpf: Test using slice after invalidating dynptr clone
  selftests/bpf: Test using file dynptr after the reference on file is
    dropped

 fs/verity/measure.c                           |   2 +-
 include/linux/bpf.h                           |   8 +-
 include/linux/bpf_verifier.h                  |  14 +-
 kernel/bpf/helpers.c                          |  10 +-
 kernel/bpf/log.c                              |   4 +-
 kernel/bpf/verifier.c                         | 496 +++++++-----------
 kernel/trace/bpf_trace.c                      |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   6 +-
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  50 ++
 .../bpf/progs/bpf_qdisc_dynptr_clone.c        |  69 +++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    |  62 +++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |  68 +++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    |  64 +++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  85 ++-
 .../selftests/bpf/progs/dynptr_success.c      |   6 +-
 .../selftests/bpf/progs/file_reader_fail.c    |  60 +++
 .../bpf/progs/test_kfunc_dynptr_param.c       |   9 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   4 +-
 18 files changed, 684 insertions(+), 351 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

-- 
2.47.3


