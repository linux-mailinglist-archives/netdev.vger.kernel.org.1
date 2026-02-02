Return-Path: <netdev+bounces-255824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI8yBwB7gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:22:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E4CACFE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E0E3031804
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975A357735;
	Mon,  2 Feb 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGVvg6mf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859372E92BC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027508; cv=none; b=UG6g8mxSkvsxTEg6kkBBTzBgcLqOWmoAzO8LlAJrMKl3/a8l7eybEmXh6Ykd9Z7if4AxPbViFyQgFLvYkuRQrurf4TzYin5EEaS81B9O60bEZIOYAgiwddL0fB/bttQfIlzevH7pGJ5N1JpEZXoJjrUeniE4p/DmB30KRRnlM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027508; c=relaxed/simple;
	bh=2mSffkAlx2LWmOLKktkDUc/RWeoA2F8mcxyQ4brpPo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYWJZrkrTiULSOfSK1qs/udV5/c2oIiHs6O7W0eFXL8gn9WISYNZ2lg6Or1DCR0IuU6SeqZZlZQqOYjQq2jr0aaMqXefhdpCPvovY31G6YxA1nSAZhqrPqzT9nlYXkeizkbLpfSkL6CwSBTc+RdRVJp9pmhVz7r6lROXHdobmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGVvg6mf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770027505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QwkSiX1Hp8rIk3qxgAOsnlMj5FGX8DKdzbss4//3U/M=;
	b=hGVvg6mfegE18J5Ko4QN9+KNPbG5IJ8qJoNHThgqTjJ0vAYVFP4t6V6Z76uSExfgfZ77dI
	6FiQRrysPeo7KL1+8hzb+ldxpdkomT5bk+Fb61c1b8SlM1yAAAyLkjYynY2Eyt8iURC0eS
	4/Y8F41NjTy2nxCJtamIO1yWgUmZNIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-EV51GaeONfiBLUq-hmGr9A-1; Mon,
 02 Feb 2026 05:18:22 -0500
X-MC-Unique: EV51GaeONfiBLUq-hmGr9A-1
X-Mimecast-MFC-AGG-ID: EV51GaeONfiBLUq-hmGr9A_1770027499
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77DC2195606F;
	Mon,  2 Feb 2026 10:18:19 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.43.3.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37F9D19560A2;
	Mon,  2 Feb 2026 10:18:16 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ice: fix crash in ethtool offline loopback test
Date: Mon,  2 Feb 2026 11:17:54 +0100
Message-ID: <20260202101755.315528-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255824-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A32E4CACFE
X-Rspamd-Action: no action

Since the conversion of ice to page pool, the ethtool loopback test
crashes:

 BUG: kernel NULL pointer dereference, address: 000000000000000c
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 1100f1067 P4D 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 23 UID: 0 PID: 5904 Comm: ethtool Kdump: loaded Not tainted 6.19.0-0.rc7.260128g1f97d9dcf5364.49.eln154.x86_64 #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:ice_alloc_rx_bufs+0x1cd/0x310 [ice]
 Code: 83 6c 24 30 01 66 41 89 47 08 0f 84 c0 00 00 00 41 0f b7 dc 48 8b 44 24 18 48 c1 e3 04 41 bb 00 10 00 00 48 8d 2c 18 8b 04 24 <89> 45 0c 41 8b 4d 00 49 d3 e3 44 3b 5c 24 24 0f 83 ac fe ff ff 44
 RSP: 0018:ff7894738aa1f768 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000700 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ff16dcae79880200 R09: 0000000000000019
 R10: 0000000000000001 R11: 0000000000001000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff16dcae6c670000
 FS:  00007fcf428850c0(0000) GS:ff16dcb149710000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000000c CR3: 0000000121227005 CR4: 0000000000773ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ice_vsi_cfg_rxq+0xca/0x460 [ice]
  ice_vsi_cfg_rxqs+0x54/0x70 [ice]
  ice_loopback_test+0xa9/0x520 [ice]
  ice_self_test+0x1b9/0x280 [ice]
  ethtool_self_test+0xe5/0x200
  __dev_ethtool+0x1106/0x1a90
  dev_ethtool+0xbe/0x1a0
  dev_ioctl+0x258/0x4c0
  sock_do_ioctl+0xe3/0x130
  __x64_sys_ioctl+0xb9/0x100
  do_syscall_64+0x7c/0x700
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]

It crashes because we have not initialized libeth for the rx ring.

Fix it by treating ICE_VSI_LB VSIs slightly more like normal PF VSIs and
letting them have a q_vector. It's just a dummy, because the loopback
test does not use interrupts, but it contains a napi struct that can be
passed to libeth_rx_fq_create() called from ice_vsi_cfg_rxq() ->
ice_rxq_pp_create().

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 15 ++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index eadb1e3d12b3..f0da50df6791 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -124,6 +124,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	if (vsi->type == ICE_VSI_VF) {
 		ice_calc_vf_reg_idx(vsi->vf, q_vector);
 		goto out;
+	} else if (vsi->type == ICE_VSI_LB) {
+		goto skip_alloc;
 	} else if (vsi->type == ICE_VSI_CTRL && vsi->vf) {
 		struct ice_vsi *ctrl_vsi = ice_get_vf_ctrl_vsi(pf, vsi);
 
@@ -662,7 +664,8 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	u32 rx_buf_len;
 	int err;
 
-	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
+	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
+	    ring->vsi->type == ICE_VSI_LB) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3565a5d96c6d..e9f2618950c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1289,6 +1289,10 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	test_vsi->netdev = netdev;
 	tx_ring = test_vsi->tx_rings[0];
 	rx_ring = test_vsi->rx_rings[0];
+	/* Dummy q_vector and napi. Fill the minimum required for
+	 * ice_rxq_pp_create().
+	 */
+	rx_ring->q_vector->napi.dev = netdev;
 
 	if (ice_lbtest_prepare_rings(test_vsi)) {
 		ret = 2;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d47af94f31a9..bad67e4dc044 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -107,10 +107,6 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->rxq_map)
 		goto err_rxq_map;
 
-	/* There is no need to allocate q_vectors for a loopback VSI. */
-	if (vsi->type == ICE_VSI_LB)
-		return 0;
-
 	/* allocate memory for q_vector pointers */
 	vsi->q_vectors = devm_kcalloc(dev, vsi->num_q_vectors,
 				      sizeof(*vsi->q_vectors), GFP_KERNEL);
@@ -239,6 +235,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	case ICE_VSI_LB:
 		vsi->alloc_txq = 1;
 		vsi->alloc_rxq = 1;
+		/* A dummy q_vector, no actual IRQ. */
+		vsi->num_q_vectors = 1;
 		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
@@ -2424,14 +2422,21 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		}
 		break;
 	case ICE_VSI_LB:
-		ret = ice_vsi_alloc_rings(vsi);
+		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
+		ret = ice_vsi_alloc_rings(vsi);
+		if (ret)
+			goto unroll_alloc_q_vector;
+
 		ret = ice_vsi_alloc_ring_stats(vsi);
 		if (ret)
 			goto unroll_vector_base;
 
+		/* Simply map the dummy q_vector to the only rx_ring */
+		vsi->rx_rings[0]->q_vector = vsi->q_vectors[0];
+
 		break;
 	default:
 		/* clean up the resources and exit */
-- 
2.52.0


