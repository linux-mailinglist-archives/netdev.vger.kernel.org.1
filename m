Return-Path: <netdev+bounces-43842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423D7D5017
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD030B20D02
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385F26295;
	Tue, 24 Oct 2023 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faCPFAaj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD914F82
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:42:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C2CC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698151375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQvIAHxlIRsODDQvHhHg2yEUAX99/4EQzAeL/zSIx6I=;
	b=faCPFAajcP3J0fjOZaTCFsM3uMCsVG+NHlk3hxIqh4385dij07fYWfN9dIIhHhXuAXaHtb
	qyPlFD6HeBZcaoul4Lqf//jmTiwoYYE5vKYtVrYmOY2FuDD/ggt+GJB+b3oyCDOFLOgZDZ
	ki8BhWXn5LlhMzmjf4etO9NP6/Djnl0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-14QY-GXoMf2RcfJKXAovzg-1; Tue, 24 Oct 2023 08:42:51 -0400
X-MC-Unique: 14QY-GXoMf2RcfJKXAovzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61162811E7E;
	Tue, 24 Oct 2023 12:42:51 +0000 (UTC)
Received: from p1.luc.com (unknown [10.43.2.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DFFE32166B26;
	Tue, 24 Oct 2023 12:42:49 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/2] i40e: Fix devlink port unregistering
Date: Tue, 24 Oct 2023 14:42:45 +0200
Message-ID: <20231024124245.837908-2-ivecera@redhat.com>
In-Reply-To: <20231024124245.837908-1-ivecera@redhat.com>
References: <20231024124245.837908-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Ensure that devlink port is unregistered after unregistering
of net device.

Reproducer:
[root@host ~]# rmmod i40e
[ 4742.939386] i40e 0000:02:00.1: i40e_ptp_stop: removed PHC on enp2s0f1np1
[ 4743.059269] ------------[ cut here ]------------
[ 4743.063900] WARNING: CPU: 21 PID: 10766 at net/devlink/port.c:1078 devl_port_unregister+0x69/0x80
...

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index df058540d277..3f396c100835 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14181,8 +14181,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 	}
 	set_bit(__I40E_VSI_RELEASING, vsi->state);
 	uplink_seid = vsi->uplink_seid;
-	if (vsi->type == I40E_VSI_MAIN)
-		i40e_devlink_destroy_port(pf);
+
 	if (vsi->type != I40E_VSI_SRIOV) {
 		if (vsi->netdev_registered) {
 			vsi->netdev_registered = false;
@@ -14196,6 +14195,9 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		i40e_vsi_disable_irq(vsi);
 	}
 
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
+
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
 	/* clear the sync flag on all filters */
@@ -14370,14 +14372,14 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
-	if (vsi->type == I40E_VSI_MAIN)
-		i40e_devlink_destroy_port(pf);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.41.0


