Return-Path: <netdev+bounces-290000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNO0AgHkDWpN4gUAu9opvQ
	(envelope-from <netdev+bounces-290000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:40:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491159234B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE13630834E2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8883F23C5;
	Wed, 20 May 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgo6JmeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8D3E9C0C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291732; cv=none; b=rVcIAg3XWifoaV9hmxJNYX5bXyU8DSVySoumzOxlhMi3fgEKbiT5oqtDIN8k6+my/r48d534ErTSR4zd4lqg1/YZ+bO9aIabm6MgzkuY1h3dBJf4Emnx7jgsSoZYjOB8wWWKf7YB27Ckd03IYBU7UXNtOT8ckXQrBUV1+0/1itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291732; c=relaxed/simple;
	bh=37tRhAbzNX+kAG/Kxdlit0C6n0x+AotN1s2VBCP2iIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpmX3ScNJyCLDq1Ph1OYHqYYMV9XRaAPon1Kvlgy7qji+h/7qk2VQZFBw7iPHFBYFZ0N/Be0xdVVLaPk3nn3xzMqvj+IJa9mdoj0rj4om9AaZl0s4SJLhAl8b3BaoLydN9seTTp97gt8fAPyHl921J3/X9/WK6Wf90FCYLBX+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgo6JmeZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9125d2a4d36so344616885a.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291729; x=1779896529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeZT6mkI2EJo8NQ3oGxuCkgFQyJx2pM/KNG1eLQDLLA=;
        b=Rgo6JmeZd8INqzx00YGbSmeYGls7JesTG3H5b48qm/qk+R3O53sjDenC+nxHpqu/w6
         5zw/i594zdMb/o6PJV9RjJaMGidPsiA8qs0aEAhO1Om8QwUZ4JAjuvemx3SQFt1EYugX
         A56kuU9fzmeSnITOGDTuJL1wePHu5DZbz5F2wgBGqtIxRNKJEfDtZqqjJuB5jrAI46qD
         4B4+PpGoPIxW3PiyYwQfkbLW0n1hR8BDNqm49dvQLG2OaWujMXgj2KC9IPDyWxM4FwmN
         np8dCDS2XqUN2xICrYcHgwk5FmNa7bQh0KLjzplFw7Qlp0bOCo22NTHl5y+bOPgF++xZ
         SxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291729; x=1779896529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeZT6mkI2EJo8NQ3oGxuCkgFQyJx2pM/KNG1eLQDLLA=;
        b=MrLp9Lj+5Xgo49J1bCipwfcWE/Ne9vPVv4JeiWZ/7ztkqLkdbuvKlx4+Mkm6lYCzyu
         f4j3AbBBvFKAvWJxguJfSwH61W9jjJW4iEHeioTeU5GndE4R5yz2yI3NKi0po/7eCguS
         jAXrRpz3kivJJax+onRmuK56LCjXU+3cnNoG4QuwOEkv59xcOOLN39dRFCHyzm8k0or2
         2cb3puEgiK/i5EAM4UfNnIJlXx7kHm4W8xHQ6mIInu0mjQpXWfK8wqa6GqvTtsbw8k0C
         0WIZ4VT69Qj0K9DJFzYtFWjXJjiPapMdo9FUILOCBW6k7shROh0dv+0tkrzXPW6sfNc/
         634Q==
X-Gm-Message-State: AOJu0YzoYUWOAmbmtaec5OHNTcDV3p5YnToyJDSdaC7xgp4yDdCG1oRP
	ppaNC25xCsMyl7WL6Xi9knSJ7RO0ilxXwAb6ljJk31TKWxGWWD40Kcyu
X-Gm-Gg: Acq92OHJpGu1VVR/VstA079NxSNJW4f/JbB71iFzI3u258gYChU3aaXL3AXIr8BKCiS
	QfbNEMKeR/s5SIVBacYW1GgwGEUCR/zEB2T6+FlwfDWdG+ixDDU7ecK+CJZISYrosk0wIyHZAUg
	3g5290RsqOOCXmPraCJvZdGH72l2mBh2ZnRvr58a14XMIoS4duy2cCm/q60+ZwHuontPF0EEI2t
	pHUVQRq8R02EAkSwkZYh6xCNaDsUy8SY58nw+s/AGnwSu4tMbSSbREcvXPco8KmIWpQMf32VQNH
	Quwqds85z357C4dlLv6xbrkNyTdBW6dZkXTayPrzJ4+ZIKSyp3l7yHWlgjsGe+KfZq5ByGZU16d
	7kFYZN8Nol6TMkn/p3/vnl50cxHkfBrmhB8KlGHv37mP93SZvECIKDhnLnXzhSjHLi52US4WRvh
	3kfAe+mdLVp41L3tVGWeGWN6TLg1J+sHexZs+6CMrdNCK++Br/1uC1L7DvoDapQyPAIwS0uUOMh
	LEiU9bM4yPCSGT7hmH1
X-Received: by 2002:a05:620a:c43:b0:90f:624d:70d3 with SMTP id af79cd13be357-911cdd41abcmr3774519585a.23.1779291729177;
        Wed, 20 May 2026 08:42:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b85asm2167221685a.25.2026.05.20.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:42:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] octeontx2-af: validate body pcifunc in rvu_mbox_handler_rep_event_notify
Date: Wed, 20 May 2026 11:41:57 -0400
Message-ID: <20260520154157.1439319-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290000-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hdr.id:url]
X-Rspamd-Queue-Id: 7491159234B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rvu_mbox_handler_rep_event_notify() in drivers/net/ethernet/marvell/
octeontx2/af/rvu_rep.c queues a sender-controlled REP_EVENT_NOTIFY
request body verbatim, and rvu_rep_up_notify() then forwards
event->pcifunc (the nested body field, distinct from the
AF-normalised header pcifunc) into rvu_get_pfvf(), rvu_get_pf() and
the AF->PF mailbox device index without any bounds check.

A VF attached to a PF that has been put into switchdev
representor mode reaches this path: the VF mailbox handler
otx2_pfvf_mbox_handler() forwards every message id including
MBOX_MSG_REP_EVENT_NOTIFY to AF without an allowlist, and the AF
dispatcher rewrites only msg->pcifunc, leaving struct
rep_event::pcifunc attacker-controlled.  The sibling
rvu_mbox_handler_esw_cfg() refuses requests whose header pcifunc
is not rvu->rep_pcifunc; this handler has no equivalent gate.

An out-of-range body pcifunc selects an &rvu->pf[]/&rvu->hwvf[]
element past the allocated array and, for RVU_EVENT_MAC_ADDR_CHANGE,
turns into a six-byte attacker-chosen OOB ether_addr_copy() target
inside the queued worker; KASAN reports a slab-out-of-bounds write
in rvu_rep_wq_handler.

Reject malformed requests at the handler entry by gating on
is_pf_func_valid(), which is already the canonical PF/VF range check
in this driver; expose it via rvu.h so callers in rvu_rep.c can use
it instead of open-coding the same range arithmetic.

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Reproduction
============

Tree: net mainline at v7.1-rc4 (5200f5f493f7), x86_64 QEMU,
CONFIG_KASAN_GENERIC=y, CONFIG_KUNIT=y, CONFIG_OCTEONTX2_AF=y.

Conditions: rvu_af bound to RVU AF hardware in production, or a
synthetic struct rvu in the KUnit harness used for this report.
No sysctl, capability, or namespace gate on the VF mailbox side
once switchdev/SR-IOV is provisioned.

Harness: an out-of-tree KUnit module invokes
rvu_mbox_handler_rep_event_notify() directly on a synthetic struct
rvu allocated via kunit_kzalloc with a one-PF rvu->pf[] array and
rvu->hw->total_pfs == 1.  The crafted struct rep_event sets
hdr.sig = OTX2_MBOX_REQ_SIG, hdr.id = MBOX_MSG_REP_EVENT_NOTIFY,
header pcifunc 0, nested body pcifunc 2 << RVU_OTX2_PFVF_PF_SHIFT
(one PF past the synthetic array), event = RVU_EVENT_MAC_ADDR_CHANGE,
and a six-byte payload.  This matches the bytes a forwarded VF
mailbox message places at the AF mbox.

Stock:
  BUG: KASAN: slab-out-of-bounds in rvu_rep_wq_handler+0x100/0x280
  Write of size 4 at addr ffff8880022bff03 by task kworker/0:0/9
  Workqueue: rep_evt_kunit_wq rvu_rep_wq_handler
  allocated by kunit_kmalloc_array+0x1b/0x50 -> make_synth_rvu

Patched: same harness, KASAN silent, the handler returns -EINVAL
at the new gate and never queues the entry; KUnit reports
"ok 1 otx2_rep_event_pcifunc_oob_demux_mac".

Regression: legitimate body pcifunc inside [0, total_pfs) is
unchanged in behaviour and continues to queue and execute on the
same code path; the gate only fires on out-of-range selectors.

Mitigations: none on the VF mailbox path.  Operators who do not
provision SR-IOV VFs in switchdev representor mode are not
exposed.

The KUnit harness module is held off-list and is available on
maintainer request.

 drivers/net/ethernet/marvell/octeontx2/af/rvu.c     | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index e40b79076358d..3cf131508ecfe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -436,7 +436,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(rvu->pdev, pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf9082..de3fbd3d15d60 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -917,6 +917,7 @@ u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 901f6fd40fd49..a2781e0f504e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -97,6 +97,14 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 {
 	struct rep_evtq_ent *qentry;
 
+	/* The mailbox dispatcher normalises only the header pcifunc; the
+	 * nested struct rep_event::pcifunc body field is sender-controlled
+	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
+	 * rvu->hwvf[].  Reject out-of-range body selectors before queueing.
+	 */
+	if (!is_pf_func_valid(rvu, req->pcifunc))
+		return -EINVAL;
+
 	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


