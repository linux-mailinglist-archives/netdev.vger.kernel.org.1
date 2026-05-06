Return-Path: <netdev+bounces-284873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOYPBWlT+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B074DC716
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 811FA30F648D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE799480955;
	Wed,  6 May 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oak+p9A9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299E47F2C4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077638; cv=none; b=ZZ5ufXvghGVGy1hLZHoCIE4UNhJjyzKrnP7qr5Ci2MZsto6tXE7ij9YL7XOlHZ50b4sIh9yzx4wOh+4wGo3nH2zzFSK6Nn871C4dOaPqWzOfQ1gjirpBZ80shqVbhb2AkxpV8q0egGkS2EjLyeKoiYcdwyBaVQHguRsBEyWdx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077638; c=relaxed/simple;
	bh=RPBln5U/Q71F6shqVvnQ3IVc+7MvX408yI08BJr8vZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGr+0vcoMyugVX0tWn4Yc51cRQXPu7RWmvZKDks+l7crLVt421FEvUx16UGZLDNeUZgll4HM4FoGiVsdDAuj69HuQZ0Qz1mNds3Vx5meskURfbc1PBTASavTn+cCL6nwIDljtDfLbFCNFyp75ksad3zxplNT23WIWeun92qEYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oak+p9A9; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a9076813bso2909689e0c.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077631; x=1778682431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8dRHXuxQLdGNyONSZpBxIdjK67Uqhqozqa6A02mLbU=;
        b=oak+p9A9+JrAshUD3+g4VngJmOhtopXd/ofOvOCLFZzl4qVWDbQgR+UBu3CGuBED3C
         knaESoniWuV5QESouHITE5VZmI8I9XQc9sxAtSBd4XTD9S//NfjRiAhtl4KwIiZFD4xf
         J+zKz6G/hoFpaXWSn3FyqXG6Y7u1Pk4GzncwD7tUszDUTsUQI6bRYiEmikDEtEWoNjFV
         DRVI9w0kVfDf3hCPhu8kdeTOmj9jnXC9mOCWtLPK0Xk165oGiBYZO0iN7g9JEcQ2BH8J
         H24hC3aO7lrY/MU24gZHGXl7kllVBLS947jir3BgcqaBVN0P+zVox+LRCgLGwLtY1sow
         BO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077631; x=1778682431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8dRHXuxQLdGNyONSZpBxIdjK67Uqhqozqa6A02mLbU=;
        b=Y01g0740uigIsxEtdCYBtvLla4qN/WxOuTX4rk/iZu6oxbFX7yNuExNfFfIkGG2bwX
         58YR4S4QBaBLsz8nodLdqmvNKqs3zh/9EUrN7t3kJwT03Iob3oPnnC1o5/L50VPeIYxE
         U+/tidncTnR5/fHHWKqBK9AyPTXpPCUe9h5Wgn6ptHOXGBZpSV/7cDB/o0vD1y7ZWfb7
         X/+IVxkTALYsxVzRMvf2SZ76kt9ciS1J8nLh5HBcUD004A9YuG1XxMTemmzyMYRpGlyq
         P15dMyrTDKdPDbg9fs6bw7ItARcr6Z60nn3jUWIJu5AzLowDDviNY0/jBN7Dzsn8Jzne
         WoQg==
X-Gm-Message-State: AOJu0YxXgfIt2w1dz6GGxlUF3eMweu0/ZpnO9CN5BWPmOCbCbWVZnLOA
	RKfq/FiLQlKD05NX+YzievsZPKFGcNV3Wi+X5pbs0sSiMYWuF8wKs6hT
X-Gm-Gg: AeBDievkN5XrbOAjDcvRkAOp50M2Yd/oPGbRC6lhxLhw0xpJN46mbPSs258o0yfoLHT
	4rlWZAVU/qucH8ZBhEn3qvC0WM/g2AesMGRAs873HPaxND2z6zSTC180D6mojA6RvZpnA8re9bm
	UBJq/qZGwAPNVwotJkvcl7iH5zyNAggUJl9CkjwjWdEkpnrmpcPm7FibRwRxrcroVBJA5QE1lDJ
	WY8SrbYBG3qCSkuzfBf+7Xv3UopVVPBpVJt2dfhyKQxIScvq3ff28ieCCA1+C6tDkXbdjuI0vdx
	dEBUwvVKHG/rAtaI13YAF4flggTE/vClnUW10fTCZwEvNdPYIyolPcuJgLCHyPRtV/dettBnTTE
	wubRUzIk1jvJtFN9zB8RVWNQ08VeIZe0e5EX09lmPS2wkn9R27k7DD4UxDL5he2z9ENkQXWoEJg
	W+ZRlYV4P74W+FaFFwUpNLxX8pXw==
X-Received: by 2002:a05:6122:e16b:b0:56c:db8b:504e with SMTP id 71dfb90a1353d-575596f4c6amr2087707e0c.13.1778077630712;
        Wed, 06 May 2026 07:27:10 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:b::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dceddsm178059266d6.30.2026.05.06.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 00/12] Refactor verifier object relationship tracking
Date: Wed,  6 May 2026 07:26:56 -0700
Message-ID: <20260506142709.2298255-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60B074DC716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284873-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]

Hi all,

This patchset cleans up dynptr handling, refactors object relationship
tracking in the verifier by introducing parent_id, and fixes dynptr
use-after-free bugs where file/skb dynptrs are not invalidated when
the parent referenced object is freed.


* Motivation *

In BPF qdisc programs, an skb can be freed through kfuncs. However,
since dynptr does not track the parent referenced object (e.g., skb),
the verifier does not invalidate the dynptr after the skb is freed,
resulting in use-after-free. The same issue also affects file dynptr.

The figure below shows the current state of object tracking. The
verifier tracks objects using three fields: id for nullness tracking,
ref_obj_id for lifetime tracking, and dynptr_id for tracking the parent
dynptr of a slice (PTR_TO_MEM only). While dynptr_id links slices to
their parent dynptr, there is no field that links a dynptr back to its
parent skb. When the skb is freed via release_reference(ref_obj_id=1),
only objects with ref_obj_id=1 are invalidated. Since skb dynptr is
non-referenced (ref_obj_id=0), the dynptr and its derived slices remain
accessible.

Current: object (id, ref_obj_id, dynptr_id)
  id         = unique id of the object (for nullness tracking)
  ref_obj_id = id of the referenced object (for lifetime tracking)
  dynptr_id  = id of the parent dynptr (only for PTR_TO_MEM slices)

                      skb (0,1,0)
                             ^
                             ! No link from dynptr to skb
                             +-------------------------------+
                             |           bpf_dynptr_clone    |
                 dynptr A (2,0,0)                dynptr C (4,0,0)
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
              slice B (3,0,2)                 slice D (5,0,4)


* Why not simply use ref_obj_id to track the parent? *

A natural first approach is to link dynptr to its parent by sharing
the parent's ref_obj_id and propagating it to slices. Now, releasing
the skb via release_reference(ref_obj_id=1) correctly invalidates all
derived objects.

Attempted fix: share parent's ref_obj_id

                      skb (0,1,0)
                             ^
                             +-------------------------------+
                             |           bpf_dynptr_clone    |
                 dynptr A (2,1,0)                dynptr C (4,1,0)
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
              slice B (3,1,2)                 slice D (5,1,4)


However, this approach does not generalize to all dynptr types.
Referenced dynptrs such as file dynptr acquire their own ref_obj_id to
track the dynptr's lifetime. Since ref_obj_id is already
used for the dynptr's own reference, it cannot also be used to point to
the parent file object. While it is possible to add specialized handling
for individual dynptr types [0], it adds complexity and does not
generalize.

An alternative approach is to avoid introducing a new field and instead
repurpose ref_obj_id as parent_id by folding lifetime tracking into id
[1]. In this design, each object is represented as (id, ref_obj_id)
where id is used for both nullness and lifetime tracking, and ref_obj_id
tracks the parent object's id.

Attempted: object (id, ref_obj_id)
  id         = id of the object (for nullness and lifetime tracking)
  ref_obj_id = id of the parent object
  '          = id is referenced

                        skb (1',0)
                             ^
        bpf_dynptr_from_skb  +-------------------------------+
                             |      bpf_dynptr_clone(A, C)   |
                 dynptr A (2,1')                 dynptr C (4,1')
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
                slice B (3,2)                   slice D (5,4)

However, this design cannot express the relationship between referenced
socket pointers and their casted counterparts. After pointer casting,
the original and casted pointers need the same lifetime (same ref_obj_id
in the current design) but different nullness (different id). The casted
pointer may be NULL even if the original is valid. With id serving as
the only field for both nullness and lifetime, and ref_obj_id repurposed
as parent, there is no way to express "different identity, same
lifetime."

Referenced socket pointer (expressed using current design):

                                C = ptr_casting_function(A)
                ptr A (1,1,0)                     ptr C (2,1,0)
                         ^                                 ^
                         |                                 |
                        ptr C may be NULL even if ptr A is valid
                        but they have the same lifetime


* New Design: parent_id *

To track precise object relationships, u32 parent_id is added to
bpf_reg_state. A child object's parent_id points to the parent
object's id. This replaces the PTR_TO_MEM-specific dynptr_id, and
does not increase the size of bpf_reg_state on 64-bit machines as
there is existing padding.

After: object (id, ref_obj_id, parent_id)
  id         = unique id of the object (for nullness tracking)
  ref_obj_id = id of the referenced object; objects with the same
               ref_obj_id share the same lifetime
  parent_id  = id of the parent object; points to parent's id
               (for object relationship tracking)

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

With parent_id, the verifier can precisely track object trees. When the
skb is freed, the verifier traverses the tree rooted at skb (id=1) and
invalidates all descendants — dynptr A, dynptr C, and their slices.
When dynptr A is destroyed by overwriting the stack slot, only dynptr A
and its children (slice B, dynptr E) are invalidated; skb, dynptr C,
and slice D remain valid.

For referenced dynptr (e.g., file dynptr), the original and its clones
share the same ref_obj_id so they are all invalidated together when any
one of them is released. For non-referenced dynptr (e.g., skb dynptr),
clones live independently since they have ref_obj_id=0.

To avoid recursive call chains when releasing objects (e.g.,
release_reference() -> unmark_stack_slots_dynptr() ->
release_reference()), release_reference() now uses stack-based DFS to
find and invalidate all registers and stack slots with matching id or
ref_obj_id and all descendants whose parent_id matches. Currently, it
skips id == 0, which could be a valid id (e.g., pkt pointer by reading
ctx). Future work may start assigning > 0 id to them. This does not
affect the current use cases where skb and file parents are both given
id > 0.


* Preserving reg->id after null-check *

For parent_id tracking to work, child objects need to refer to the
parent's id. This requires two preparatory changes: assigning reg->id
when reading referenced kptrs from program context (patch 2), and
preserving reg->id of pointer objects after null-check (patch 3).
Previously, null-check would clear reg->id, making it impossible for
children to reference the parent afterward. The latter causes a slight
increase in verified states for some programs. One selftest object
sees +19 states (+5.01%). For Meta BPF objects, the increase is
also minor, with the largest being +34 states (+3.63%).


* Object relationship in different scenarios (for reference) *

The figures below show how the new design handles all four combinations
of referenced/non-referenced dynptr with referenced/non-referenced
parent. The relationship between slices and dynptrs is omitted as it
is the same across all cases. The main difference is how cloned dynptrs
are represented. Since bpf_dynptr_clone() does not initialize a new
reference, clones of referenced dynptrs share the same ref_obj_id and
must be invalidated together. For non-referenced dynptrs, the original
and clones live independently.

(1) Non-referenced dynptr with referenced parent (e.g., skb in Qdisc):

                          skb (1,1,0)
                               ^
          bpf_dynptr_from_skb  +-------------------------------+
                               |      bpf_dynptr_clone(A, C)   |
                 dynptr A (2,0,1)                dynptr C (4,0,1)

(2) Non-referenced dynptr with non-referenced parent (e.g., skb in TC,
    always valid):

      bpf_dynptr_from_skb
                                  bpf_dynptr_clone(A, C)
             dynptr A (1,0,0)                  dynptr C (2,0,0)

                         dynptr A and C live independently

(3) Referenced dynptr with referenced parent:

                     file (1,1,0)
                           ^ 
     bpf_dynptr_from_file  +---------------------------------+
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


[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
[1] https://github.com/ameryhung/bpf/commits/obj_relationship_v2_no_parent_id/


Changelog:

v3 -> v4
  - Add patch 1 clean up mark_stack_slot_obj_read() and callers
    (to address v3 ignoring err returned from mark_dynptr_read) (Andrii)
  - Fix release_reference() and move the logic allowing destroying a
    referenced object when refcnt > 1 from
    destroy_if_stack_slots_dynptr() to release_reference() (Mykyta)
  - Add patch 7 introducing ref_obj_desc and unifying ref_obj handling
    (to address Eduard's concern about unclear meta->{id,ref_obj_id}
    initialization/use and confusing function arguments of
    process_dynptr_func())
  - Add patch 7 unifying release_regno handling so that bpf_kptr_xchg
    also use release_reference()
  Link: https://lore.kernel.org/bpf/20260421221016.2967924-1-ameryhung@gmail.com/

v2 -> v3
  - Rebase to bpf-next/master
  - Update veristat numbers
  - Update commit msg to explain multiple dropped checks (Mykyta, Andrii)
  - Reuse idmap as idstack in release_reference() and check for
    duplicate id (Mykyta, Andrii)
  - Change to use RUN_TEST for qdisc dynptr selftest (Eduard) 
  Link: https://lore.kernel.org/bpf/20260307064439.3247440-1-ameryhung@gmail.com/  

v1 -> v2
  - Redesign: Use object (id, ref_obj_id, parent_id) instead of
    (id, ref_obj_id) as it cannot express ptr casting without
    introducing specialized code to handle the case
  - Use stack-based DFS to release objects to avoid recursion (Andrii)
  - Keep reg->id after null check
  - Add dynptr cleanup
  - Fix dynptr kfunc arg type determination
  - Add a file dynptr UAF selftest
  Link: https://lore.kernel.org/bpf/20260202214817.2853236-1-ameryhung@gmail.com/

---

Amery Hung (12):
  bpf: Simplify mark_stack_slot_obj_read() and callers
  bpf: Unify dynptr handling in the verifier
  bpf: Assign reg->id when getting referenced kptr from ctx
  bpf: Preserve reg->id of pointer objects after null-check
  bpf: Refactor object relationship tracking and fix dynptr UAF bug
  bpf: Remove redundant dynptr arg check for helper
  bpf: Unify referenced object tracking in verifier
  bpf: Unify release handling for helpers and kfuncs
  selftests/bpf: Test creating dynptr from dynptr data and slice
  selftests/bpf: Test using dynptr after freeing the underlying object
  selftests/bpf: Test using slice after invalidating dynptr clone
  selftests/bpf: Test using file dynptr after the reference on file is
    dropped

 include/linux/bpf_verifier.h                  |  49 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/log.c                              |   8 +-
 kernel/bpf/states.c                           |  10 +-
 kernel/bpf/verifier.c                         | 847 +++++++-----------
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |   8 +
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 ..._qdisc_dynptr_use_after_invalidate_clone.c |  74 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    |  68 ++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |  74 ++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    |  70 ++
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   6 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  66 +-
 .../selftests/bpf/progs/file_reader_fail.c    |  60 ++
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   6 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   4 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   2 +-
 .../bpf/progs/verifier_ref_tracking.c         |   2 +-
 .../selftests/bpf/progs/verifier_sock.c       |   6 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  24 -
 22 files changed, 819 insertions(+), 573 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

-- 
2.52.0


