Return-Path: <netdev+bounces-281215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJZLRLU7mkKyQAAu9opvQ
	(envelope-from <netdev+bounces-281215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D546C493
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF84D3007F79
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 03:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09F3537E8;
	Mon, 27 Apr 2026 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PelqiZiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC0175A81
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259535; cv=none; b=mEETTBHZDo+rd/QRxqnji+VN3bOE0kRdP2TN/KHv7pGXargwmRS1EXcne/9eUXpx4eV7Bcq8drvdBr5Nae0YQ3qNtDXJQzj0jKlSBV7J1ArCHwxO1hBQBGq35HTk3vrKD1lAiuYuy81DfKY4d//FxUA87V7knyF+vFzVQplLv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259535; c=relaxed/simple;
	bh=cYkl63PY+PKcOSXlRPyJDqFn/wbURdC2SyDMzwX4eCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfMw7nRj63b1AkzoZh0NhNln+CL/slyIJYMRtTYXVGM8/+WDSHTEN3pfHhypzencPUq2Qu2IKAEQ5EEynZaLeYB1D2eFp2z9Hre+940u6A6KzWWwPQcXt/bk58GJiM7/LpGIu4PDshtvSn4wberPGjsZHkJ+L9gSApoDeMMpu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PelqiZiQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c797d5ad36bso3104265a12.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777259533; x=1777864333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gp1K2EXsXJjLmVYIVoTLMJ2MCl9E+BqqW584mODwD4o=;
        b=PelqiZiQUVbzeZaSOlZDZUeDHEJZ9uFIgYJu90MiN369RCp2pY4CHFk5+NSUZ/h7Ij
         0h0GnQ0Zb7rOZ2EsD+PTOnzSHnEd5jhZqVtjrMUHx3i0AkAB2LCXga6Wv02jnGrNkeKw
         cDelNRoKFl5C/YT/XKez10O4TF38M7mp/EOUVEegqrgM6SpIjHgB9fnfc6hTtdIieNQt
         jPZOz4zLWwlH/WrwKS61MaYHMO8k2WUYylKe9lPECwc4Gv9To8OCZ0ZdcignYAAXuH/C
         PnWSHNz2rwhDnGMkyqQquhxHmP+3YmielcFMkV77KN0B7gOG51Xkq2/EIaqvT0DaEppg
         69Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777259533; x=1777864333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp1K2EXsXJjLmVYIVoTLMJ2MCl9E+BqqW584mODwD4o=;
        b=E8GBuc6RB6MC22TB11ROYtRDbhXH+8zLCZNM5/sH1IIbBZBf12U/jMbZl1bx30Cnrp
         CQ151MVgXoKVebYWcyEwS20z9KGnWEztp4sTgmzIyeOUm3IlW/MTzDVfBszI/r7uBm2i
         JIAf7AZutZ3oCfoEkpvgS6SxqKWP55YOcNhl3ddjb4vFREkDGFEmxmyOX7HxC5wvqtrX
         T/Rw3S+7pcZ+/NUAch8brw/0VQQMJ48a2sW3sc5aW0Bpa8cselna/Te0P8IaUszEs9s0
         3V3UApBvCxevB170qC0kDVdq11F/Z8lHI5WHy2KIrebnNYE592LiUsbO4Br4QMy+Z/0j
         UJbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FJmfjQIpNv7Bbs+WlDtKOzbUfrb67ELDujoZtSNspSzji594dXCuRoeaNl9I4KYcfivh7F/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQ8d6vVJTPb7ZwvYiOK39FFlpkzL3y5i5JkdUdHjseYKyDG5L
	XNoTQAvZnvUV1UdaQFH8cFqrq5qweUVhUssEfeqG+7yaevcvraSJwn/JnPUMYBI4I5IbQ6Ne+2h
	Gr+ivAkc=
X-Gm-Gg: AeBDiev6QFbTGx+chsMqo3kGEDjpry3zwWSL/baxSo9yDL5JRCnaZe/mjtEGKoqvnOG
	oG8yrOTx7Vg/4siqZJrpm3gfU3iheq5OTZAvcah4Gor4ArrKC2lSNZ8FEgq//ODRKa+SQvhNsKA
	/VCNAxlqTDAqUSWa4StLNDHXK5P6Qr+ZZ7lAcVzo6CfD6LfXEkd6FlMmyPE7717XqiwrST4OV1I
	er1b0RdlOPbs0+bAm5NdlrgBZty2yMTOT8kjf9I/JsFLLeVkTw0HbPIlzXPwYt+PFubu1raN34y
	WPZ0tJyJb0NJZj2ePMLXb/7e8pPRvMGw++qIeLUPw4o8ekLJQuXBMHP7fiRM/ISYPBiP/fHORNy
	X+qbLinx/RHfh/AXfYi62r2X+Smr1mmDEu2SOyuSRoiHirLzbQc94SfLnieR9ylnGxGzV/P8Pmj
	e5NxHPUTRvFJ7UhFZGsoBo0bsJ/m+B241PiOLbFo6pIdBM50TpUV3F482SMFj7DGMuikjZSPdAK
	yTa
X-Received: by 2002:a05:6a20:2590:b0:3a2:e8f1:b873 with SMTP id adf61e73a8af0-3a2e8f1c216mr27643860637.36.1777259533362;
        Sun, 26 Apr 2026 20:12:13 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([210.176.154.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702fbfcsm23211560a12.22.2026.04.26.20.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 20:12:13 -0700 (PDT)
From: Vincent Chen <vincent.chen@sifive.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	vincent.chen@sifive.com
Subject: [RFC PATCH] ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
Date: Mon, 27 Apr 2026 11:11:58 +0800
Message-Id: <20260427031158.2665916-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 156D546C493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[sifive.com:+];
	TAGGED_FROM(0.00)[bounces-281215-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.chen@sifive.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:email,sifive.com:dkim,sifive.com:mid]

Currently ice_eswitch_attach_vf() is called unconditionally in
ice_start_vfs() and ice_reset_all_vfs(), which causes VF creation
to fail when CONFIG_ICE_SWITCHDEV is not defined or switchdev mode
is not enabled at runtime.
Fix this by adding switchdev mode checks at the call sites before
calling ice_eswitch_attach_vf(), consistent with how
ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
Also remove the redundant check inside ice_eswitch_attach_vf() itself.
This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
!CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
ice_eswitch_configure() API.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
 drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..c709decb26d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	struct ice_repr *repr;
 	int err;
 
-	if (!ice_is_eswitch_mode_switchdev(pf))
-		return 0;
-
 	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 843e82fd3bf9..6a0b724e46f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
 			goto teardown;
 		}
 
-		retval = ice_eswitch_attach_vf(pf, vf);
-		if (retval) {
-			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
-				vf->vf_id, retval);
-			ice_vf_vsi_release(vf);
-			goto teardown;
+		if (ice_is_eswitch_mode_switchdev(pf)) {
+			retval = ice_eswitch_attach_vf(pf, vf);
+			if (retval) {
+				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
+					vf->vf_id, retval);
+				ice_vf_vsi_release(vf);
+				goto teardown;
+			}
 		}
 
 		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index de9e81ccee66..71595410174c 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		ice_vf_rebuild_vsi(vf);
 		ice_vf_post_vsi_rebuild(vf);
 
-		ice_eswitch_attach_vf(pf, vf);
+		if (ice_is_eswitch_mode_switchdev(pf))
+			ice_eswitch_attach_vf(pf, vf);
 
 		mutex_unlock(&vf->cfg_lock);
 	}
-- 
2.34.1


