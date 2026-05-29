Return-Path: <netdev+bounces-292931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBOVHeTwGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:50:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B85FC207
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62B66307AF1E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66873624A8;
	Fri, 29 May 2026 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvqiVAcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD91A0712
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019383; cv=none; b=QszNzcgbD8AN0DvycWWXhy0oK7mjz/GtasCgWBbvOCotQaId90KJGeSgErNJyzCozYuHF5y1CHd3Pjk5Jhp1FhVB7hYgWY1TF4pDLobgt8SXmzbXTF3rVPv9a2aW0Kua3BRI6n7o04nXc0x0xSL0elKkb/6WanDfbqF/2baB4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019383; c=relaxed/simple;
	bh=f8KHuGNNgO2I+ez61YKt2byzdx8tpUjBMscRbR1O3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOu6tupgthQlicp1PFb75erDKuqQbcYlXU9bHpdJWh21tyyYCnwzacYFGlZc6GSwMm1j8nB1quBsU7JM7cTMUmNZjP3m5RfCg5UjFymALLFeLDz5b/tEzAfLGIzwbXGd2NRkfSAmDZMlYVOnTsRypn+KegAqc8FEu6R+3GsooeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvqiVAcv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b9e9a6802aso58601435ad.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019380; x=1780624180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hemm8Nk4PZULEKMxRgq8H7U7kWa4a+noxPwigCabVD0=;
        b=AvqiVAcvHvmp+2b8ZMcfUSQSD1rR/Y2IIuBfn3wyZ7JHlO+nx7n3nQGHt85voTvZCU
         6CefOmpG7zW9fcfBGw3S1mV89zTg7QV/mX15MMRSXr9RRk51MIHvw87auCbdE+bYKZ/D
         id35iUBU26NQxh3wS/bhSZK0R7FGAnjbc+Fkxluj3RViEhAOgLidFEQDs1efw/Ux6kVw
         RhVTJ5WDjquZvWakgY6COtNiPSe8o0jDafqSvjoAFcoYJ0jt+7fXCQcsUO93meR9mwO3
         Y13Pea4td/kNNeRW6u1bXxX7A5454vVHj3iSARbDWDicr67OhDzXZaXbYNq6TxpK6RlC
         YC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019380; x=1780624180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hemm8Nk4PZULEKMxRgq8H7U7kWa4a+noxPwigCabVD0=;
        b=pICCaOUVB3TsROdy+vmlWqShX8dfVwKtoJtzzXp+E7Q6Jpixz9x2bTvu/KZdEYCB9u
         H08dxSdDcLZ6yFv7i74exHfQ3xga02tJ3LdoaIMEhVB0rQFlujNPETvW1Q3Oq2METeom
         2ST2ez2jq9M+QfXiZB0p0NDHim7SYBVIC3r6y155eUoWcw/CpCwBrJobo0SqTrozs86l
         MkoXZUA1GN6p2cPeE5Y39dd0fE4ig5rZFKkZgvM6DtjqDhpxUQjZQwoY+Nx1ZV9HT9Hp
         DPFf9j2EW8bBzKr18LatYP0V1juTeURMSEKhaj/LceknN1pFf5ZvHA2q/pHvxND2qfLk
         SDxA==
X-Gm-Message-State: AOJu0Yw00ES4KEQLsr5R9HGb9ievVTcOcyQcCcr/T1ue0P/qL20cUYmQ
	DwPRNrbZjruhI+9XYutYOSJEoPTmSfsjHB7Ve2h+whFY6shKyCi8Cbfp
X-Gm-Gg: Acq92OEGerYLB50XNzKlfHumZ163eXynZ/RepEDFHin3FSy64w8NzvghRjV09zW2PIo
	0skwE0/iBUrl9GF+3loBf24alc/CNWhRJc+P14mJqYP0vdNUcyETKUhLlBc7Q2y90Gma8FQzYal
	/fDYnMOqfwvjM+ZF3U1Q5KgaTH6oABcc40GyOw2YH2Yr9LuL12PD1tyXLmkp6D5dKThIuED1clF
	P/XLv/Ek8D81ojO746xj+Pi9OTI+kxIBM1bnnr7V8Ey9Iav01YIIl5LlFD2czyfVWGqKYGzlWI3
	2nlHNlnrFk884tlZaqaoiZDx9bArBxbgEhQouLmZCHhwubxegCG45FQsP3An2W8r1zS5gsQpgaq
	9g+1L2zhbjYoAKwLKWwZR32eKs6UyWbBL6t1NZlm9mlCwXysJ5am25Gt5rQok6QcFRU9oMO7M/w
	cjS74BJ4e3GIhZldNvs60ETPnx
X-Received: by 2002:a17:902:fc48:b0:2bd:8822:d8cb with SMTP id d9443c01a7336-2bf209b0cf6mr11090945ad.23.1780019379915;
        Thu, 28 May 2026 18:49:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011ecsm660935ad.39.2026.05.28.18.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 00/13] Refactor verifier object relationship tracking
Date: Thu, 28 May 2026 18:49:23 -0700
Message-ID: <20260529014936.2811085-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292931-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC5B85FC207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This patchset cleans up dynptr handling, refactors object relationship
tracking in the verifier by introducing parent_id and folding ref_obj_id
into id, and fixes dynptr use-after-free bugs where file/skb dynptrs
are not invalidated when the parent referenced object is freed.


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
                             ^^
                          ! No link from dynptr to skb !
                             |+------------------------------+
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
                             ^^
                             ||
                             |+------------------------------+
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
                             ^^
                             ||
        bpf_dynptr_from_skb  |+------------------------------+
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


* New Design: parent_id with branch splitting and intermediate reference *

The patchset folds ref_obj_id into id and adds parent_id to
bpf_reg_state (patch 5). A child object's parent_id points to the
parent object's id. This replaces the PTR_TO_MEM-specific dynptr_id.
Whether a register is referenced is determined by checking if its id
appears in the reference array via reg_is_referenced() rather than
reading a dedicated ref_obj_id field.

Pointer casting:

The challenge with pointer casting is that a cast result may be NULL
even when the source is valid, requiring distinct identity but shared
lifetime. This is solved using branch splitting: when a helper like
bpf_sk_fullsock() is called with a referenced pointer, the verifier
pushes an explicit NULL branch and assigns the cast result the same id
as the source. Since the cast may return NULL for a non-NULL input, the
NULL case is explored as a separate verifier branch. This allows
releasing any of the original or cast pointers to invalidate all others,
while avoiding the need for a separate tracking mechanism.

Referenced dynptrs:

The challenge with referenced dynptrs is that clones of a referenced
dynptr have the same lifetime but different identities. When a
referenced dynptr is overwritten, only slices derived from it will be
invalidated. To solve this, the verifier creates an intermediate
reference. This reference serves as a shared lifetime anchor for the
dynptr and all its clones. All clones share the same parent_id but get
unique ids for independent slice tracking. Releasing a referenced dynptr
releases the intermediate reference, which in turn invalidates all
clones and their derived slices. If the parent object is released while
the intermediate reference still exists, it is reported as a leaked
reference.

Release cascading:

When releasing an object, release_reference() performs a stack-based DFS
to invalidate all descendants. It walks the object tree via parent_id
links, invalidating registers and dynptr stack slots. Child references
encountered during traversal are reported as leaked references.

parent_id is also added to bpf_reference_state to enable intermediate
reference. When acquiring a reference, a parent_id can be specified to
link the new reference to an existing one (e.g., file dynptr's
intermediate reference has parent_id linking to the file's reference).

Final: object (id, parent_id)
  id        = unique id of the object (for nullness and lifetime
              tracking)
  parent_id = id of the parent object (for object relationship
              tracking)
  I         = intermediate reference serving as lifetime anchor in
              acquired_refs
  '         = id is referenced (appears in reference array)

                          skb (1',0)
                               ^^
                               ||
          bpf_dynptr_from_skb  |+------------------------------+
                               |      bpf_dynptr_clone(A, C)   |
                   dynptr A (2,1')                 dynptr C (4,1')
                             ^                               ^
          bpf_dynptr_slice   |                               |
                             |                               |
                  slice B (3,2)                   slice D (5,4)


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
referenced/non-referenced parent.

(1) Non-referenced dynptr with referenced parent (e.g., skb in Qdisc):

                          skb (1',0)
                               ^^
                               ||
          bpf_dynptr_from_skb  |+------------------------------+
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
                     I (2',1')  <-- intermediate reference
                        ^^
                        ||
                        |+-------------------------------+
                        |       bpf_dynptr_clone(A, C)   |
            dynptr A (3,2')                  dynptr C (4,2')

                        dynptr A and C have the same lifetime

  Releasing either dynptr releases I, invalidating both.
  Releasing file (1') detects I as a leaked reference.

(4) Referenced dynptr with non-referenced parent:

 bpf_ringbuf_reserve_dynptr
                     I (1',0)  <-- intermediate reference
                        ^^
                        ||
                        |+--------------------------------+
                        |       bpf_dynptr_clone(A, C)    |
            dynptr A (2,1')                   dynptr C (3,1')

                      dynptr A and C have the same lifetime


[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
[1] https://github.com/ameryhung/bpf/commits/obj_relationship_v2_no_parent_id/


Changelog:

v5 -> v6
  - Squash "bpf: Fold ref_obj_id into id and introduce virtual references"
    (v5 patch 9) into "bpf: Refactor object relationship tracking and
    fix dynptr UAF bug" (now patch 5). ref_obj_id is removed in the same
    patch that introduces parent_id, eliminating the intermediate state
    where both coexist (Eduard)
  - Drop virtual references for pointer casting. Instead, cast results
    reuse the source pointer's id and use branch splitting to explore
    the NULL case as a separate verifier branch. This avoids adding
    virtual reference infrastructure for a case that can be handled more
    simply (Eduard, Andrii)
  - Address nit from Eduard
  Link: https://lore.kernel.org/bpf/20260519181314.2731658-1-ameryhung@gmail.com/

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

Amery Hung (13):
  bpf: Simplify mark_stack_slot_obj_read() and callers
  bpf: Unify dynptr handling in the verifier
  bpf: Assign reg->id when getting referenced kptr from ctx
  bpf: Preserve reg->id of pointer objects after null-check
  bpf: Refactor object relationship tracking and fix dynptr UAF bug
  bpf: Remove redundant dynptr arg check for helper
  bpf: Unify referenced object tracking in verifier
  bpf: Unify release handling for helpers and kfuncs
  bpf: Fix dynptr ref counting to scan all call frames
  selftests/bpf: Test creating dynptr from dynptr data and slice
  selftests/bpf: Test using slice after invalidating dynptr clone
  selftests/bpf: Test using file dynptr after the reference on file is
    dropped
  selftests/bpf: Test using dynptr after freeing the underlying object

 include/linux/bpf.h                           |    4 +-
 include/linux/bpf_verifier.h                  |  100 +-
 kernel/bpf/btf.c                              |    2 +-
 kernel/bpf/fixups.c                           |    2 +-
 kernel/bpf/helpers.c                          |    2 +-
 kernel/bpf/log.c                              |   18 +-
 kernel/bpf/states.c                           |   11 +-
 kernel/bpf/verifier.c                         | 1068 +++++++----------
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |    8 +
 .../selftests/bpf/prog_tests/cb_refs.c        |    2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |    4 +-
 ..._qdisc_dynptr_use_after_invalidate_clone.c |   74 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    |   68 ++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |   74 ++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    |   70 ++
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
 30 files changed, 957 insertions(+), 745 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

-- 
2.53.0-Meta


