Return-Path: <netdev+bounces-276093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKP9DFY21WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A233B2163
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C5C130104A4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08263CFF4F;
	Tue,  7 Apr 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2OMn/mH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994263126AD
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580755; cv=none; b=VF4Zft4KHZpPmOGrkd5MccohmKI2Qxi7552iOD9yCaPhcM/yoLgol1zj1wRZbfDc04Mjeshf/S4hMdw0HJ/8usZDThZsjMZoj8q8flD+e8hUMVy4Om/X0Gdy3Vv2qVYFhUlDAFzq/TC6GWV8KrdLHMajP/6+mEVfMv0UPdaC+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580755; c=relaxed/simple;
	bh=0fUm6908+W9cT8z+XcqPIKHmSYzk4BsY8F87v/5UkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5ZXRIA1Nu2azHSlkIZ5eK4Zmubtl4Y2KzMIz5lIJ57em9uqtYkeVf2ZlFHWAaDM936Yeg3TvDJI6ZTn4pdtjT9Hyd4m7V19SLuaBr32WOUlkA2XlPWkdQ0kJCuqxM45dwoilHh7h3kQkpshMNlw9QAKxI9FMJ2eWBxgAINNWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2OMn/mH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775580753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMW1K0k5DSlaEN/CIk7IBlqfQZ29jzCb5HSkcB6MGtE=;
	b=X2OMn/mHjbL2guxldqdL1ISD7TSrayPQU+sYBWfP6lHtP4gdjNgvTlVuay/BmdfOVufrAR
	5XyvbBEnhGBCMHX8pTgNTvRmfngwREpGswZZTh/2M0pcLUAW/GmDLVCFFhoNAsJ8Ovf8aD
	++2yaLHTpsw0F06EBEeXLIerceSHF38=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-WdLq4SPjNy-xk08-LUO3VQ-1; Tue,
 07 Apr 2026 12:52:31 -0400
X-MC-Unique: WdLq4SPjNy-xk08-LUO3VQ-1
X-Mimecast-MFC-AGG-ID: WdLq4SPjNy-xk08-LUO3VQ_1775580750
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21BF2195608C;
	Tue,  7 Apr 2026 16:52:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A0E4300019F;
	Tue,  7 Apr 2026 16:52:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net v2 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Tue,  7 Apr 2026 18:52:03 +0200
Message-ID: <20260407165206.1121317-2-jtornosm@redhat.com>
In-Reply-To: <20260407165206.1121317-1-jtornosm@redhat.com>
References: <20260407165206.1121317-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6A233B2163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a MAC address change is requested while the VF is resetting or still
initializing, return -EBUSY immediately instead of attempting the
operation.

Additionally, during early initialization states (before __IAVF_DOWN),
the PF may be slow to respond to MAC change requests, causing long
delays. Only allow MAC changes once the VF reaches __IAVF_DOWN state or
later, when the watchdog is running and the VF is ready for operations.

After commit ad7c7b2172c3 ("net: hold netdev instance lock
during sysfs operations"), MAC changes are called with the netdev lock
held, so we should not wait with the lock held during reset or
initialization. This allows the caller to retry or handle the busy state
appropriately without blocking other operations.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: Add state check to prevent MAC changes during early initialization
    states (before __IAVF_DOWN). In v1 this patch only checked for reset
    in progress.
v1: https://lore.kernel.org/netdev/20260406112057.906685-2-jtornosm@redhat.com/

 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..67aa14350b1b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1060,6 +1060,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
+		return -EBUSY;
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-- 
2.53.0


