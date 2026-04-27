Return-Path: <netdev+bounces-281395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIURA06B72nmBwEAu9opvQ
	(envelope-from <netdev+bounces-281395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B5475358
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72BFF3042809
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70000330B22;
	Mon, 27 Apr 2026 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei/P92ia"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B232D7D9
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303130; cv=none; b=W0Uzfvq2ipboYTlKwymECVbwAbz7I1MGX2rrFxIKQRZ3FjBEHlga/FBcweyxIdvw2MnYkwjuJVG4Cnfr+TlbXaD923jhctNGsoW4/CGKdNjd5g7KR0UiBmfB5YgVSFOYcKr1le9PRTFnZlHWuZu6gzvxZOQRZ9Ln+cfQWTSXTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303130; c=relaxed/simple;
	bh=6Jdv3cqBkQD//yDzmKZiisg1VQ1oAmgqLU48pGDosGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuhJebOFnbNonPFkhw/pAF9Qyp1w2E9XcLyUEZjZ2nnpmYxqn4ob93bHTwJCwmQdhphIouSwwYtPBvH/E0LWS2f+KAKDCWu1O5mYR1gZlTbuhrzwXqGXyEDIerJ8EcR5mL7tj/86+wQXrYYm4ZclNGPLf9FhmTiSCWgHDXOprn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei/P92ia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777303128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eP255AJKi20CdWJSLl90PUo6dc/xnZcS6fxVydD/CJk=;
	b=Ei/P92iaF7jS50llvw7T5MI2TfAZk27M7ELho574O1VI+8g9N1G74nGmdR1cPeOoeNq2US
	8Llq2iIy1gtQaxcK5tOe6+C9Ffhaf7gvrpvLU0oUlXgoA6iAAOkZdPgbn3kViEH8rkY+Ti
	txF2i65nDQoVuA0rCf6+Tef6pIl0gS4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-fctzMtMrNLG8LE1L4Putxw-1; Mon,
 27 Apr 2026 11:18:41 -0400
X-MC-Unique: fctzMtMrNLG8LE1L4Putxw-1
X-Mimecast-MFC-AGG-ID: fctzMtMrNLG8LE1L4Putxw_1777303120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4DA01956059;
	Mon, 27 Apr 2026 15:18:39 +0000 (UTC)
Received: from mschmidt-thinkpadp1gen4i.tpbc.com (unknown [10.44.34.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9401195608E;
	Mon, 27 Apr 2026 15:18:35 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Petr Oros <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ice: fix stats array overflow when VF requests more queues
Date: Mon, 27 Apr 2026 17:18:26 +0200
Message-ID: <20260427151827.43342-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 087B5475358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281395-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,atlassian.net:url]

When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
alloc_txq/alloc_rxq to the new larger value, but
ice_vsi_alloc_stat_arrays() returns early because the stats already
exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
alloc_txq and writes beyond the bounds of the old, smaller
tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
metadata.

KASAN detects the bug:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221

 CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
 ...
 Workqueue: ice ice_service_task [ice]
 Call Trace:
  <TASK>
  ...
  kasan_report+0xd7/0x120
  ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
  ice_vsi_cfg_def+0x12e2/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_reset_vf+0x858/0xf80 [ice]
  ice_vc_request_qs_msg+0x1da/0x290 [ice]
  ice_vc_process_vf_msg+0xb15/0x1430 [ice]
  __ice_clean_ctrlq+0x70d/0x9d0 [ice]
  ice_service_task+0x840/0xf20 [ice]
  process_one_work+0x690/0xff0
  worker_thread+0x4d9/0xd20
  kthread+0x322/0x410
  ret_from_fork+0x332/0x660
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2439:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x96/0xb0
  __kmalloc_noprof+0x1d8/0x580
  ice_vsi_cfg_def+0x115c/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_vsi_setup+0x180/0x320 [ice]
  ice_start_vfs+0x1f3/0x590 [ice]
  ice_ena_vfs+0x66d/0x798 [ice]
  ice_sriov_configure.cold+0xe4/0x121 [ice]
  sriov_numvfs_store+0x279/0x480
  kernfs_fop_write_iter+0x331/0x4f0
  vfs_write+0x4c4/0xe40
  ksys_write+0x10c/0x240
  do_syscall_64+0xd9/0x650
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff88810affea40
                which belongs to the cache kmalloc-32 of size 32
 The buggy address is located 0 bytes to the right of
                allocated 32-byte region [ffff88810affea40, ffff88810affea60)
 ...
 ==================================================================

ice_vsi_rebuild() handles this correctly by calling
ice_vsi_realloc_stat_arrays() before reconfiguration, but
ice_vf_reconfig_vsi() was missing this call.

Fix by calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi()
before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. Set
vsi->req_txq/req_rxq from vf->num_req_qs so the realloc function knows
the target array size.

See the linked RHEL Jira item for a reproducer.

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Assisted-by: Claude:claude-opus-4-6 semcode
---
 drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..fc78176a2a8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
  * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
  * @vsi: VSI pointer
  */
-static int
+int
 ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 {
 	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..6f7da84384e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
 void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
+int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 772f6b07340d..9edb2c14f553 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
 
 	vsi->flags = ICE_VSI_FLAG_NO_INIT;
 
+	vsi->req_txq = vf->num_req_qs;
+	vsi->req_rxq = vf->num_req_qs;
+
+	err = ice_vsi_realloc_stat_arrays(vsi);
+	if (err)
+		return err;
+
 	ice_vsi_decfg(vsi);
 	ice_fltr_remove_all(vsi);
 
-- 
2.54.0


