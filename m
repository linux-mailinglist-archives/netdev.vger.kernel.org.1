Return-Path: <netdev+bounces-300252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jszItEYM2q+9QUAu9opvQ
	(envelope-from <netdev+bounces-300252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1F69C9AC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:59:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C+ieOzui;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300252-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 659ED304E403
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B13B95EB;
	Wed, 17 Jun 2026 21:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432403B38AE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 21:58:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733482; cv=none; b=gKHso6HBz0VktqikiAWwSs7jCf/RZE/NTWbR0p+fMixx1hbHr79ZZpGiI8qWakBsmV4ul8ix+9r0vuZZ+oz1CfmGOU+YGo7625RDsXkEbH5Glut0bhnbU45YKK1lAtikH8h6Wrr5o8f5zhgoVLemxIe3tpptHv6Hd4+doSB7l+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733482; c=relaxed/simple;
	bh=MDOjwqEMH+Skm5Qaq0VBBAfXxH9Ei2PYJ9ybyfg3uQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YH6Pt/vgGPlOXsVgWRzMRule5xJXQU+bBKfF8hCArvLyqdoDcpQLr4PKLha59ld8/oo4p2+saxeS6b5b4J2a6/27vF2wc7OyKI0gz5cG/9T/0G73utvgi3X9N3SQRy7PyYfahxGDnxevNP2WEGYBgKNUsgWGe1s+gyQaF0+9KSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+ieOzui; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9157ec935c5so41543285a.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733479; x=1782338279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMonf+rXiG8HrnRO3rIefxf82NtLEt6HiAMh+pfQIFY=;
        b=C+ieOzuirb7tuBd5Mtqzz9090aEjUFo+VIwxC1oPwG3G9x+pfgRdRDWLgSub66uSiR
         XQcgriD0xnbaa4IYm6uIiUnS/lVMzEccNokcj80SBKUQdCq+lDyQ0JU+ROdj6+iA5Xkm
         R+3ZdyKQphJPzAg+Wl3VuUknmVFGWNUqBZYlDKPzC71+cftMDUknkuuZBl0Lq2tdlJVi
         KYqrtsWjdkohOwLrE8g5jbQUxp8H0gRlNHTCkCBDLzdEQ13t187GnUneZLHgLX2katsb
         SaUyHG1iTKVAUrqkdvuDwZ3p0NBhu/VrrjfxEX5vFgduNI1IeWtI6DqQZ7TsBHcjLCsu
         Zy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733479; x=1782338279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMonf+rXiG8HrnRO3rIefxf82NtLEt6HiAMh+pfQIFY=;
        b=IvJEwJfcaqJCsZTyQYV5/t0v0rxpPtCLUhzyMaGO5nQ18h2Quv1g7SI+LzVb3xKl0K
         EU7K7Tj9RGH495F7GciR310QmPpZckwyQcBAiBUZdx5Y3zDpa9zUC5vXqybVhMUYFo6p
         Eq/r8j3sGPl+vGaRzuw+v6Yh7uw20noUonPBYCEGWLqjToRvIq+JvpvbAVDiTkCQ6zMk
         aopMR3sR8Ec6r3nKg+ImkoQUb61tJP9eOlgmDEDblDpzmdbjvSh5gGx0MbE/Ozxsh0/P
         8krFWo1uhHh+yIOzlr4hqrb96WpKeBzZoSXiEvsqQm+U/4QP3yQVcRjAO4vQY1mhVrGd
         EmQg==
X-Forwarded-Encrypted: i=1; AFNElJ9PQhXVApjTi4SPaFnu8wJufAgrglQjd1k+1qonfPd5fq0qNdeP4MEP9bvREp9Q/jyOchovddA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAjp1A+hfNgeUD+3ey7Br8snwJ2+Cm4ffTycvfici5Rkob6Pj
	Q0vStIRb4XQteVlyG2QB4SHE86YoJ5npI2H1lhrSWD2Q10okNKZg4lfn
X-Gm-Gg: Acq92OHvl+5CX7+xiKhsVmWY3Wr48bG6vS5+6T6sZqdC6S6vHPZDrp0vWBF4P/uv2C7
	YHYBuYAhnSG1WB4TGJjf/uQykNLokBJ150kZTuMxLRAec+HIkxOaAfhCHEaZT0bOuWWifECchCx
	5lQY70+pnPgj3SS0evJ2z0Am/12VvIPDJ390te8loPZC0EArVdu438J7/JV/qkQsp4P+OyWSxV8
	73mWw0jLaUxMYuq7wb7rJDqgbrzB2siG3dgA6nSZxkoqLjk1yH9XVdCXnmNrZlZJie9k3ipeYYD
	RbWFrB65XHAMgU8fDPs2YydV6aT818CkbhwTe5Q6cbNqYwiD3f2YzoKT/nR4cwo3S6mJCAtxilb
	N3Me1eILmoHsK1jNp3fFbd7ArWF5WPmO96fiZXESEXWZE8MJWbdyfeeDNhFRS8UXQ8R/3mWA4On
	ApKkuQdRv1iGW8rdZ203sI+1LmO+Z38WFMRmJazuH2Ol4rnCXXq4u4jz+J8W0Ed2vRf7buvT/iG
	jhe4KFqfVtpztkoq2oco1de1jTORt7q
X-Received: by 2002:a05:620a:4390:b0:914:cb07:447e with SMTP id af79cd13be357-91f25ca3283mr148838785a.5.1781733479183;
        Wed, 17 Jun 2026 14:57:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1c851sm1874547085a.16.2026.06.17.14.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:57:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] idpf: bound interrupt-vector register fill to the allocated array
Date: Wed, 17 Jun 2026 17:57:54 -0400
Message-ID: <20260617215754.1117178-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-300252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:joshua.a.hay@intel.com,m:pavan.kumar.linga@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B1F69C9AC

idpf_get_reg_intr_vecs() fills the caller-allocated reg_vals[] array from
the VIRTCHNL2_OP_ALLOC_VECTORS reply in adapter->req_vec_chunks, bounding
its inner loop only by the per-chunk num_vectors. The array is sized
separately: idpf_intr_reg_init() allocates
kzalloc_objs(struct idpf_vec_regs, total_vecs) from
caps.num_allocated_vectors and only checks the returned count after the
fill. The sum of per-chunk num_vectors is never reconciled against
total_vecs, so a reply with a small num_allocated_vectors but chunks
summing higher writes past the end of reg_vals[].

Impact: a control plane (a PF or hypervisor device model) that returns a
VIRTCHNL2_OP_ALLOC_VECTORS reply whose per-chunk num_vectors sum exceeds
num_allocated_vectors writes struct idpf_vec_regs entries past the end of
the reg_vals kmalloc allocation (KASAN slab-out-of-bounds write).

Bound the fill loop to the array capacity passed in by the callers,
mirroring the sibling idpf_vport_get_q_reg(). The existing
num_regs < num_vecs check then rejects an undersized reply without the
out-of-bounds write happening first.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
The reply originates from the control plane (a PF or hypervisor device
model), which is trusted in a standard deployment, so this is a
defense-in-depth / robustness fix: it bounds a malformed or internally
inconsistent ALLOC_VECTORS reply. It is a genuine trust-boundary crossing
only where the guest distrusts the control plane (a confidential VM or an
Intel IPU posture) or the control plane is simply buggy. It is not
remotely or unprivileged-reachable.

Reproduced with a KUnit harness that calls the unmodified
idpf_get_reg_intr_vecs() against a crafted req_vec_chunks reply
(num_allocated_vectors = 1, four chunks of sixteen vectors) under KASAN:
stock reports a slab-out-of-bounds write 0 bytes past a 12-byte kmalloc-16
object and the test fails; the patched build is KASAN-clean; a well-formed
64-vector reply still fills 64 entries on both. The KUnit wiring is
repro-only scaffolding, not part of this patch; harness on request.

 drivers/net/ethernet/intel/idpf/idpf_dev.c      | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 1a0c71c95ef12..4079a787657f1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -87,7 +87,7 @@ static int idpf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index a07d7e808ca9b..6726084f6cfa0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -86,7 +86,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101c..ec7330603ff84 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1318,11 +1318,12 @@ idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
  * idpf_get_reg_intr_vecs - Get vector queue register offset
  * @adapter: adapter structure to get the vector chunks
  * @reg_vals: Register offsets to store in
+ * @num_vecs: number of entries the @reg_vals array can hold
  *
  * Return: number of registers that got populated
  */
 int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals)
+			   struct idpf_vec_regs *reg_vals, int num_vecs)
 {
 	struct virtchnl2_vector_chunks *chunks;
 	struct idpf_vec_regs reg_val;
@@ -1346,7 +1347,7 @@ int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
 		dynctl_reg_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
 		itrn_reg_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
 
-		for (i = 0; i < num_vec; i++) {
+		for (i = 0; i < num_vec && num_regs < num_vecs; i++) {
 			reg_vals[num_regs].dyn_ctl_reg = reg_val.dyn_ctl_reg;
 			reg_vals[num_regs].itrn_reg = reg_val.itrn_reg;
 			reg_vals[num_regs].itrn_index_spacing =
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1be..9b1c9c86f6eac 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -104,7 +104,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter);
 void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 
 int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals);
+			   struct idpf_vec_regs *reg_vals, int num_vecs);
 int idpf_queue_reg_init(struct idpf_vport *vport,
 			struct idpf_q_vec_rsrc *rsrc,
 			struct idpf_queue_id_reg_info *chunks);
-- 
2.53.0


