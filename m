Return-Path: <netdev+bounces-124137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FF96841E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E31C2244A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04C13CFA1;
	Mon,  2 Sep 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI+ZAvJJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942313BC26
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271639; cv=none; b=GUqeM1JovAfmNTejVhAyBX6C683ifEVDH7LjBRI2c/9nKVArPGNqcqUG896o51SyUUZqZj327WEqFp/R1nwLzyF6E+TsYEXHFB9fo19XKmyJTN+yuSmfjSMRf0hFIOkg/hPYzOQlJUFO1KvgjEKls4up8pP4ht8ckcFQfRNJr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271639; c=relaxed/simple;
	bh=UqY0ZOR4ZKOoHcoCsu6sP2jFHbPUIWb3im2waL5Wvvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pv8g10Nw2aXtXbRbyilCIHtwhzymYQUcLcMmmiqpchfmb+UgsCYRYlCgKM4dbS8qgnknGr4KRwbtOKaKLMxlqPoC81FGFtV4FqyrXR7svYhGR+BcXwW5Ib0NLJdDqDmTftH6wz7phbBo03u1jIpSUwgyPpgMYsuSUgB1EANKDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI+ZAvJJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VadJH2ms1q8EaPkqqjbRvlwSJ3NWMZzkQQ/DtM+kzTs=;
	b=ZI+ZAvJJhCXIGQgVlDcrmOX4lHh+P9nRluhXq5eXcqaiTyzfdLPFkRun+szh5tQY0g1MTE
	911cTFAmk9+BKYPRc11h5lX6rqvs46CynhCrMf5/Y+Cn42qX6GdTOq9E9rQ6ICHhbbh7q7
	BMjnlrINxBpuN8wDGm67MEA9NltkVzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-Um-XiOR0NliIVndgzN-xrw-1; Mon,
 02 Sep 2024 06:07:13 -0400
X-MC-Unique: Um-XiOR0NliIVndgzN-xrw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9BFF1954B00;
	Mon,  2 Sep 2024 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.191])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 044FA19560A3;
	Mon,  2 Sep 2024 10:07:04 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@intel.com>,
	Timothy Miskell <timothy.miskell@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: fix VSI lists confusion when adding VLANs
Date: Mon,  2 Sep 2024 12:06:52 +0200
Message-ID: <20240902100652.269398-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The description of function ice_find_vsi_list_entry says:
  Search VSI list map with VSI count 1

However, since the blamed commit (see Fixes below), the function no
longer checks vsi_count. This causes a problem in ice_add_vlan_internal,
where the decision to share VSI lists between filter rules relies on the
vsi_count of the found existing VSI list being 1.

The reproducing steps:
1. Have a PF and two VFs.
   There will be a filter rule for VLAN 0, refering to a VSI list
   containing VSIs: 0 (PF), 2 (VF#0), 3 (VF#1).
2. Add VLAN 1234 to VF#0.
   ice will make the wrong decision to share the VSI list with the new
   rule. The wrong behavior may not be immediately apparent, but it can
   be observed with debug prints.
3. Add VLAN 1234 to VF#1.
   ice will unshare the VSI list for the VLAN 1234 rule. Due to the
   earlier bad decision, the newly created VSI list will contain
   VSIs 0 (PF) and 3 (VF#1), instead of expected 2 (VF#0) and 3 (VF#1).
4. Try pinging a network peer over the VLAN interface on VF#0.
   This fails.

Reproducer script at:
https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/test-vlan-vsi-list-confusion.sh
Commented debug trace:
https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/ice-vlan-vsi-lists-debug.txt
Patch adding the debug prints:
https://gitlab.com/mschmidt2/linux/-/commit/f8a8814623944a45091a77c6094c40bfe726bfdb

One thing I'm not certain about is the implications for the LAG feature,
which is another caller of ice_find_vsi_list_entry. I don't have a
LAG-capable card at hand to test.

Fixes: 25746e4f06a5 ("ice: changes to the interface with the HW and FW for SRIOV_VF+LAG")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index fe8847184cb1..4e6e7af962bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3264,7 +3264,7 @@ ice_find_vsi_list_entry(struct ice_hw *hw, u8 recp_id, u16 vsi_handle,
 
 	list_head = &sw->recp_list[recp_id].filt_rules;
 	list_for_each_entry(list_itr, list_head, list_entry) {
-		if (list_itr->vsi_list_info) {
+		if (list_itr->vsi_count == 1 && list_itr->vsi_list_info) {
 			map_info = list_itr->vsi_list_info;
 			if (test_bit(vsi_handle, map_info->vsi_map)) {
 				*vsi_list_id = map_info->vsi_list_id;
-- 
2.45.2


