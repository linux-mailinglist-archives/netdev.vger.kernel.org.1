Return-Path: <netdev+bounces-280080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEktBc9b52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DFE439F6F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0CDA303429B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C83BD64D;
	Tue, 21 Apr 2026 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/tZ3WDe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D03AD52D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769965; cv=none; b=NLXIOnnCfrhrk5uShtX18oMKOsZTbUxG+SMEhlzjVwe3C7/T1SHVBUkhnvgYqcOWzsX3FIfPRpvvhq2XosXnawjIcVLDe1QuV4JQ4w2aipse1fY8e8alAOfTtNtre+oCw93iZ9rWTjwIctKkkiEXY/RqbNnuSIxRhpK4HHUYPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769965; c=relaxed/simple;
	bh=v1CKD6MJLRYIxsG+hMrychYrnD7rUK0JgZNM9solLq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxQgRA5RwsvDuEGBFufWU54esADAxk/MOAfteNzx0KFmsIFijHH0FbOSH5GSqSAPhOJRPtXEHq6d1P+EOrP1ZnDFDKcvl0ygxeI1B3vch8QT8Q6K81kT98rDctxCflI1jGthyExbMCD541WHlwsFdcjeNh7eI2Aq01KR2+r48A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/tZ3WDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776769963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEkfECukKbV80ZZBX+sDP9TLbBqsQA+hSKML9YufPe0=;
	b=Q/tZ3WDe6voQxQyE3MlmrG31kQedkm44EhtOk4v/wDA4TVm5UdSU3stKJ+qjZHoeIoSRUb
	xWhSuP49Rp7VtttkuqXqAoR48HwRdKzODBHVdG52NQkpHbMdOydhFPEOf0uQ1+GGIDr9va
	OPmIjWUC8wD4PDwexlHEGpuJ6GbQOFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-syRl3_z_M6yGUyI_u16pAw-1; Tue,
 21 Apr 2026 07:12:39 -0400
X-MC-Unique: syRl3_z_M6yGUyI_u16pAw-1
X-Mimecast-MFC-AGG-ID: syRl3_z_M6yGUyI_u16pAw_1776769959
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF5AC1800473;
	Tue, 21 Apr 2026 11:12:38 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D216195608E;
	Tue, 21 Apr 2026 11:12:38 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1DFEAA80C56; Tue, 21 Apr 2026 13:12:36 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: intel-wired-lan@osuosl.org,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Corinna Vinschen <vinschen@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test
Date: Tue, 21 Apr 2026 13:12:36 +0200
Message-ID: <20260421111236.875379-1-vinschen@redhat.com>
In-Reply-To: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280080-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinschen@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4DFE439F6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
waiting for response from PF in set mac") introduced a duplicate
ether_addr_equal() check, so the current code tests the new MAC twice
against the former MAC.

Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
("iavf: fix MAC address setting for VFs when filter is rejected")

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Added CC: stable@vger.kernel.org

 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..9b8e7e4376c2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2579,13 +2579,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
-- 
2.53.0


