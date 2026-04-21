Return-Path: <netdev+bounces-280257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIkhHEz252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50944004D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2621F30712C1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57F38552F;
	Tue, 21 Apr 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xte5q1t2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3D2BE621
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809421; cv=none; b=TRJozVC7rZ2Rju//sIEj04yIRoY4ajvwqN7kIOag0uTj6VBsGqVwUHAaXJSy57AnOfx3vT6Z2h8Aa06o92RLhIBgo0YMURgIXzUaKNb3o1kUmnIepbhCNAIFsQ/bbhn7SfJd0vzepv6+/HilmwAR65K26hCtHtGlExOf6kGPLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809421; c=relaxed/simple;
	bh=A4EbM69PCzH98uK2YmSWNKgyHlc0RT50WZOWM0EMlyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omXXhSbWo+sHCfKDc0+uuuCXgFpHUP6kntugvGAhs4Z7Ogzs17F8uP6Y80O13jBTPaTC0AAlkBbvRg5UjC81JAEFhq+Rg2rIKHgv5m7JaDk/8H+IxX/mWoBX2fcKx2gzNtePomSQbbuh5WTrfV7JwhfkYWaWeO6RalAaN69kIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xte5q1t2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b23fcf90b2so46072625ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809419; x=1777414219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRFfJzI3mXxx5DYsy7GXSTL1HeC6NdyTi4+o9y/7gRs=;
        b=Xte5q1t2ouwGR46p3RZJQ2NtJFOGhhYmnRdXhIJZYAgwUp3dni9Ozg2/+EKBg7dYbt
         SGogh6b7pZd971Svjb2+7OaTnLkAB8x1DkhUlmZG1OlgJl0fVIhXG6rqvhrStyN3hEOg
         SnyZw31u0hw2JHndPo5tgVHa/qxQa8dAZmvw301e6SQgfJpRpIslRSM+z+dfp13yyhj1
         G0UbzmoqBHhha8WrgwVmeB0bMhP3M2mejzyLotRTKqazPdPyeaQmV4O9tK9KiBRt09uS
         BZzHpJeH5txV1abhqITm5VrB6hzLdDaGCA82h/stbihsrgf/icBBXZTrO6Kdr1WYLQBL
         a6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809419; x=1777414219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRFfJzI3mXxx5DYsy7GXSTL1HeC6NdyTi4+o9y/7gRs=;
        b=lAgU+8Is3JOunlHI/PRmEzfaQLXJgfv2C9Rs4lBHz1OG2PAGoCIWSmHkA31RfxdJdK
         YCmDKWHatsPqnueuUDgRVX7H2dWbqIZIrXl8X3EjcFY+CfMnFIhkCTouFwQenQNdjw1v
         ptNZIut5fS/K3JVVNTaymSbzdFre7mLsQXUWZTBjXTSWu6cJ3rb5wh+rEBXHQ1ui0NQy
         bmm3oviZIDZCO5gnlj4Iri7sQKZfJaqr5aTufIAz1QEKo4c2UWAAV4c9KECdxoCF/pc3
         yHJ5dESJl+rouiIxitzVNqkNiKdBfaP2OXvI5AXEfrsBCSk2ZIcp4/irasxIs4tz69Vo
         S5Dg==
X-Gm-Message-State: AOJu0YxjROXrKzVTr04sCarVMk8tVT4wplrkBx+WGCFiq4DX0oSHXfOz
	zZkYFrwOimHsaAIo1PICyvGSf1pwzo5n/pJ7i6SZYQ2gT8OcAsCdisQg
X-Gm-Gg: AeBDieu0GrvPsyVo6cTD6nVbTPoDz8GJ0j0DPY4Qv5fTpbrtjZRuWox+szkthhjDpRD
	cF9cMIccIj8DDqXrp+ZmsOrHtfc6jyx3egjfFvYoPflmz+XaosMw03vOWUCXSvyAjharokwsrm/
	XS9XhjNZgffxbriPpqY6PyyD23wALPv40nG28EXPCcoqq65wDK1wbpKrgjNXvAWBvNx/77CiURf
	iQtwmexBuNok8TaR/YCsjidZ96BKrXZV3lTA5yv9S0Uzv1klIipqMgzbbtcGMnYFopwJHbkGlON
	PXbMH2A4Ic0o4CL+tiDQZ7kE+cs10q+Txp6xaidLATM+n971JDHtXNVh4bdE6zuBhdXV8x3Mxfz
	C3EFor0otY2IkULWzOB/+/SXzcg8XrIfFQiq8meVAxvQBbb4pmqEYNwK2Zvz0cwWKfuByj4oNgd
	GcvOc+KrNGbxiUr9wxL3ldBxOP
X-Received: by 2002:a17:903:1ae5:b0:2b2:ec46:dfd4 with SMTP id d9443c01a7336-2b5f9f1eb04mr221342415ad.22.1776809418688;
        Tue, 21 Apr 2026 15:10:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cd18sm154433065ad.45.2026.04.21.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
Date: Tue, 21 Apr 2026 15:10:07 -0700
Message-ID: <20260421221016.2967924-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280257-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE50944004D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
[1] https://github.com/ameryhung/bpf/commits/obj_relationship_v2_no_parent_id/


Changelog:

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

Amery Hung (9):
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

 include/linux/bpf_verifier.h                  |  34 +-
 kernel/bpf/log.c                              |   4 +-
 kernel/bpf/states.c                           |   9 +-
 kernel/bpf/verifier.c                         | 461 ++++++------------
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |   8 +
 ..._qdisc_dynptr_use_after_invalidate_clone.c |  75 +++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    |  68 +++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |  74 +++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    |  70 +++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  48 +-
 .../selftests/bpf/progs/file_reader_fail.c    |  60 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   4 +-
 12 files changed, 593 insertions(+), 322 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

-- 
2.52.0


