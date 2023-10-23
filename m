Return-Path: <netdev+bounces-43433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFA7D309D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EAC281373
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B641C35;
	Mon, 23 Oct 2023 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3L73ra8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C7125CA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:00:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FA10C7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698058826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Da6pkJhRBkjuIiEbnBGvJD8KVGzcpPqXspbLjyfu7Dg=;
	b=B3L73ra8a6yk/9FH3rHpQcm0+hy26l/StYpls0770UkfXYpxZ6KeT4UVh3fGwyF1rJbnAC
	WfxzG4ZQ4f+hs0oFarqQIdc0XV1mJK3axoIhLd6ZraveDom99gX8CwQEtlgFR7/WdOk9O0
	f5qI74p7CE+bSM+yUIzJALxycW+mHs4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-3SiTYdThMmCpfI7IPxkf8Q-1; Mon, 23 Oct 2023 07:00:14 -0400
X-MC-Unique: 3SiTYdThMmCpfI7IPxkf8Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EB0D857D07;
	Mon, 23 Oct 2023 11:00:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 640C7492BFB;
	Mon, 23 Oct 2023 11:00:12 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net] ice: lag: in RCU, use atomic allocation
Date: Mon, 23 Oct 2023 12:59:53 +0200
Message-ID: <20231023105953.89368-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Sleeping is not allowed in RCU read-side critical sections.
Use atomic allocations under rcu_read_lock.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Fixes: 41ccedf5ca8f ("ice: implement lag netdev event handler")
Fixes: 3579aa86fb40 ("ice: update reset path for SRIOV LAG support")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 7b1256992dcf..33f01420eece 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -595,7 +595,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
 		INIT_LIST_HEAD(&ndlist.node);
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_KERNEL);
+			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
 			if (!nl)
 				break;
 
@@ -1672,7 +1672,7 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(upper_netdev, tmp_nd) {
-			nd_list = kzalloc(sizeof(*nd_list), GFP_KERNEL);
+			nd_list = kzalloc(sizeof(*nd_list), GFP_ATOMIC);
 			if (!nd_list)
 				break;
 
@@ -2046,7 +2046,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 		INIT_LIST_HEAD(&ndlist.node);
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_KERNEL);
+			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
 			if (!nl)
 				break;
 
-- 
2.41.0


