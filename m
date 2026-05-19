Return-Path: <netdev+bounces-289563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILkBKqqoDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F17583812
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 681023027947
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750B33F8AA;
	Tue, 19 May 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWwRyBDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67565328255
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214400; cv=none; b=N7jD0iIztFiJFA4MJv2HnGYg+JrBgMoDISAFWbDjZ75LdyirhnJOBq9oxddN5A3akGtVZlp7w0XSHpLbNiSCl8Nxsgm5Bc9FhdgXgqLWe7LWuKUPAFvRRY6ddGJz0DHYcgztN8251C4uNU7nonduGOmcOuOuW8S5qM4uZJSMNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214400; c=relaxed/simple;
	bh=Ccshfcl36uT0rJr0Fn+M952Skdi14uo0zlvsnbzu4aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OS9zDqhutbnj/8dNHym18YUGRhll3ZOlNBk98usMR6JHr5OLiCCYBOHvOudSuYqR9vAGpZRFAWxr+ub41X2rgyEKUXKLA0bCl5UZ+FfpPKd06AqyPpSqJF6S+8tKH4yX3zCTVhQprvFMQfHcwU0XHwnXDfXCBYTs9Zwe3uFzIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWwRyBDr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651d6347a69so5360448d50.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214396; x=1779819196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kqqCkOPxmxgNy+xtOK/4EfC6KYZJw/+NQcop67xM2c=;
        b=IWwRyBDrXzEYEz4eZT2yqkQMjEuf6XN96ZkQEesCsuVWQ+gldgoesyp8Jx3NsL55Qx
         wfZbTqHUn5Wp9Qy2pRMO8XJB7yj/KSwXuFMJtNqUZid9ULt1tnxSy7CVX3v4dzxh84CU
         WyglRGEv9J1hHW9M/9TVY7y8ThS3vb/xtAnRK/Q6lLBuY2yxNjcj0RLWvnbUJXkSXRo8
         wKqQ8Vh8Dj3pgXPqTN8X2cljT5/D2+OEGElGfA/VerinBEMklAbOGvZsKyBtJmn/3ezY
         8zLnlfHIS0OvWUgpnY2QKYfyHEA4dfeRVNxtuzAEkIPIjU28DapR4r1b+lc1HKei0+qB
         HZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214396; x=1779819196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kqqCkOPxmxgNy+xtOK/4EfC6KYZJw/+NQcop67xM2c=;
        b=SyoZRfTq1Z5sx8cjW4NWH/B8OIFNidGrwANFm/TtICalLvlDntMndLG9gusDdzpPgC
         8dHyy8wRTBCf5bVrFSQH4bGLmGT6PSo1VzuryGOAthXp4GzeTwpgO4QHiOS6a4EQ3Hot
         V4TRG9vpNYU9cj7Fq33edbM2KZGhN2gtrrc4t21POuZMoFVAVMznPH/B+bKn9yHd1ply
         7KtY1N5PQRwgbTeXM6hracQb/Itkz4WH9a1rT64AzL3u/9NZyUkQp5t7dlVaLEdv+0ro
         qGebHDMKqwrLJB2yIm4h9A4EvTzXv3iwnhsqIkBNxNpSC9GJPvaO9zN0XabvOm3EERb+
         PYRQ==
X-Gm-Message-State: AOJu0Yzzj0i17v1DLptGHppklIWLr3x83f/3ptGSAhusMP8yyj1aCOX1
	cCQLhEEFCFjjfFvJ4cMiH+sad/tdmHy2jV4hXI5N4l88TcuPDiSy57CU
X-Gm-Gg: Acq92OEOL2mIq+9WJ+f5zom/yqjmsGM5kWCl89FKQWLfPYcCu7GGt+I04C6xB6YDcfW
	NXIPS+fV5QuqSkuGGHGfM3jXPCSG7Qo2INwNpYbmRooA+OmYibhCZqHzhy25mOlHLQA1FbiLvMK
	eowjYd6iCrNieytjLratZEh6spe7/DrT98uvQQm3Ufw76niGdQKN1NiwanzPyhZ1n4K8xaWJAi0
	DBOe65rQKjDfDssTPr0hJS8nCVlt0Kn8VqXCYAqr5gIuV4ISh2YJ4XFhaWhFJgOrDZnCEVobc2i
	E5Qh4UXwkkUOpO/6xKOQXMoy1+3DhejT4JqJQD0UeOgvShUQLPxsF0zdRKqAroHU+QaaGSXJghN
	zO0XVUBvWzztrz6tY8/mN8M8uulWV1igi68rvnY0GL0smZYeJr8ZSDYDYWsxsCwEDYXihpyHjas
	uFqkvzeg705R+zMudd
X-Received: by 2002:a05:690e:1187:b0:65e:8b30:8850 with SMTP id 956f58d0204a3-65e8b308b5dmr832737d50.22.1779214395844;
        Tue, 19 May 2026 11:13:15 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b124sm8218663d50.6.2026.05.19.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 00/14] Refactor verifier object relationship tracking
Date: Tue, 19 May 2026 11:12:58 -0700
Message-ID: <20260519181314.2731658-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289563-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54F17583812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This patchset cleans up dynptr handling, refactors object relationship
tracking in the verifier by introducing parent_id, folds ref_obj_id
into id with virtual references, and fixes dynptr use-after-free bugs
where file/skb dynptrs are not invalidated when the parent referenced
object is freed.


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
track the dynptr's lifetime. Since ref_obj_id is already used for the
dynptr's own reference, it cannot also be used to point to the parent
file object. While it is possible to add specialized handling for
individual dynptr types [0], it adds complexity and does not generalize.

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


* New Design: parent_id and virtual references *

The patchset takes a two-step approach. First, parent_id is added to
bpf_reg_state alongside the existing ref_obj_id (patch 5). A child
object's parent_id points to the parent object's id. This replaces
the PTR_TO_MEM-specific dynptr_id, and does not increase the size of
bpf_reg_state on 64-bit machines as there is existing padding. With
parent_id, the verifier can precisely track object trees using
stack-based DFS.

Then, ref_obj_id is folded into id with virtual references (patch 9).
In the new model, id serves both nullness and lifetime tracking.
Whether a register is referenced is determined by checking if its id
(or its parent_id if is virtual) appears in the reference table, rather
than reading a dedicated ref_obj_id field.

To handle cases where objects share the same lifetime but need distinct
identities, pointer casting and referenced dynptr clones, virtual
references are introduced. A virtual reference is a bpf_reference_state
entry with is_virtual=true that serves as a lifetime anchor. It has no
backing register or stack slot and exists only in acquired_refs. When
releasing a register derived from a virtual reference,
release_reference() will start the DFS from the virtual reference
instead of reg->id.

For pointer casting, the first cast from a referenced pointer creates a
virtual reference. The original pointer and all cast results get
parent_id pointing to the virtual ref. Each retains a unique id for
independent null-checking. Releasing any of them releases the virtual
ref, which cascades to invalidate all siblings. For chained casts
(sk -> fullsock -> tp), subsequent casts reuse the same virtual ref.

For referenced dynptrs, the constructor creates a virtual reference
instead of a regular one. All clones share the same parent_id (the
virtual ref) but get unique ids for independent slice tracking.
Releasing a referenced dynptr releases the virtual ref, which in turn
invalidates all clones and their derived slices.

Final: object (id, parent_id)
  id        = unique id of the object (for nullness and lifetime
              tracking)
  parent_id = id of the parent object (for object relationship
              tracking)
  V         = virtual reference (lifetime anchor in acquired_refs)
  '         = id is referenced (appears in reference table)

                          skb (1',0)
                               ^
          bpf_dynptr_from_skb  +-------------------------------+
                               |      bpf_dynptr_clone(A, C)   |
                   dynptr A (2,1')                 dynptr C (4,1')
                             ^                               ^
          bpf_dynptr_slice   |                               |
                             |                               |
                  slice B (3,2)                   slice D (5,4)

  Pointer casting:

                                      V (2',0)  <-- virtual ref
                                         ^
             +---------------------------+---------------------+
             |                           |                     |    
     sk A (1,2')  cast ->  fullsock B (3,2')  cast ->  tp C (4,2')



* Preserving reg->id after null-check *

For parent_id tracking to work, child objects need to refer to the
parent's id. This requires two preparatory changes: assigning reg->id
when reading referenced kptrs from program context (patch 3), and
preserving reg->id of pointer objects after null-check (patch 4).
Previously, null-check would clear reg->id, making it impossible for
children to reference the parent afterward. The latter causes a slight
increase in verified states for some programs. One selftest object
sees +19 states (+5.01%). For Meta BPF objects, the increase is
also minor, with the largest being +34 states (+3.63%).


* Object relationship in different scenarios (for reference) *

The figures below show how the final design handles all four
combinations of referenced/non-referenced dynptr with
referenced/non-referenced parent. V denotes a virtual reference.

(1) Non-referenced dynptr with referenced parent (e.g., skb in Qdisc):

                          skb (1',0)
                               ^
          bpf_dynptr_from_skb  +-------------------------------+
                               |      bpf_dynptr_clone(A, C)   |
                   dynptr A (2,1')                 dynptr C (4,1')

                         dynptr A and C live independently

(2) Non-referenced dynptr with non-referenced parent (e.g., skb in TC,
    always valid):

      bpf_dynptr_from_skb
                                  bpf_dynptr_clone(A, C)
             dynptr A (1,0)                    dynptr C (2,0)

                         dynptr A and C live independently

(3) Referenced dynptr with referenced parent:

                     file (1',0)
                           ^
     bpf_dynptr_from_file  |
                     V (2',1')  <-- virtual ref representing freader
                        ^
                        +---------------------------------+
                        |       bpf_dynptr_clone(A, C)    |
            dynptr A (3,2')                  dynptr C (4,2')

                        dynptr A and C have the same lifetime
                        (both point to virtual ref V)

  Releasing either dynptr releases V, invalidating both.
  Releasing file (1') detects V as a leaked reference.

(4) Referenced dynptr with non-referenced parent:

 bpf_ringbuf_reserve_dynptr
                     V (1',0)  <-- virtual ref representing ringbuf record
                        ^
                        +---------------------------------+
                        |       bpf_dynptr_clone(A, C)    |
            dynptr A (2,1')                   dynptr C (3,1')

                      dynptr A and C have the same lifetime
                      (both point to virtual ref V)


[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
[1] https://github.com/ameryhung/bpf/commits/obj_relationship_v2_no_parent_id/


Changelog:

v4 -> v5
  - Add patch 9 folding ref_obj_id into id and introducing virtual
    references for pointer casting and referenced dynptr clones (Eduard, Andrii)
  - Add patch 10 fixing dynptr ref counting to scan all call frames
    instead of only the current frame (Eduard)
  - Add utility function validate_ref_obj() (Eduard)
  Link: https://lore.kernel.org/bpf/20260506142709.2298255-1-ameryhung@gmail.com/

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
  - Add patch 8 unifying release_regno handling so that bpf_kptr_xchg
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

Amery Hung (14):
  bpf: Simplify mark_stack_slot_obj_read() and callers
  bpf: Unify dynptr handling in the verifier
  bpf: Assign reg->id when getting referenced kptr from ctx
  bpf: Preserve reg->id of pointer objects after null-check
  bpf: Refactor object relationship tracking and fix dynptr UAF bug
  bpf: Remove redundant dynptr arg check for helper
  bpf: Unify referenced object tracking in verifier
  bpf: Unify release handling for helpers and kfuncs
  bpf: Fold ref_obj_id into id and introduce virtual references
  bpf: Fix dynptr ref counting to scan all call frames
  selftests/bpf: Test creating dynptr from dynptr data and slice
  selftests/bpf: Test using dynptr after freeing the underlying object
  selftests/bpf: Test using slice after invalidating dynptr clone
  selftests/bpf: Test using file dynptr after the reference on file is
    dropped

 include/linux/bpf.h                           |    4 +-
 include/linux/bpf_verifier.h                  |  102 +-
 kernel/bpf/btf.c                              |    2 +-
 kernel/bpf/fixups.c                           |    2 +-
 kernel/bpf/helpers.c                          |    2 +-
 kernel/bpf/log.c                              |   18 +-
 kernel/bpf/states.c                           |   11 +-
 kernel/bpf/verifier.c                         | 1141 ++++++++---------
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |    8 +
 .../selftests/bpf/prog_tests/cb_refs.c        |    2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |    4 +-
 ..._qdisc_dynptr_use_after_invalidate_clone.c |   74 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    |   68 +
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |   74 ++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    |   70 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |    6 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   52 +-
 .../selftests/bpf/progs/file_reader_fail.c    |   60 +
 .../selftests/bpf/progs/iters_state_safety.c  |    4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   12 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |    2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |    6 +-
 .../bpf/progs/test_ringbuf_map_key.c          |   11 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   |    4 +-
 .../bpf/progs/verifier_global_ptr_args.c      |    2 +-
 .../bpf/progs/verifier_ref_tracking.c         |    2 +-
 .../selftests/bpf/progs/verifier_sock.c       |    6 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |    2 +-
 .../selftests/bpf/progs/wakeup_source_fail.c  |    2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   24 -
 30 files changed, 1032 insertions(+), 745 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

-- 
2.53.0-Meta


