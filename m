Return-Path: <netdev+bounces-280756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANh0OiAa6mmzuAIAu9opvQ
	(envelope-from <netdev+bounces-280756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4244452845
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F253020B91
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A53ED109;
	Thu, 23 Apr 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CepO0MaB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2D31D371
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949471; cv=none; b=KDf9bZ3kpETlvigvkocnQnI1QF4w6FGRjDgS5rHnPMvtdjwztRp91OwhEPPt5Wv0rnfTdoSsMIKle0Qkeb9u02Tm2FvxtLRWH5o31XPM9gMW346Af7fhKMkxS0ietzFnjVykyWaG9qb1XMa1Wh2WeuelZ5nmTh9TNFtNWpMgrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949471; c=relaxed/simple;
	bh=bsaRe2VJfMft+xWdYjROfW5RWZV/SvrwHTHMGQ0cBh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkNe95nkoHxz1uZdWxSRTyzFXpDvlAW7HU8FCyvogtBVDCnkT7SkXJtNbvJaUJU2ww+/WdxMg1RckK3fZ7prPzddWAoR3vVW9my9GMX+cmV1geiw/ceplZDQI4lzR3r0NXjh5fkjTnd30btS/KCQoNfgxvDOOC3t8vX299CY7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CepO0MaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhgnzxr2USauT+so51qgPqkRg1IpxkZTfPCpaVxsOzo=;
	b=CepO0MaBHVX3zIjlNOQdlzqAZmIZYBw/xiZosKoj7yjBpOZU5VFu4pRAvoomoPfI0Amwoo
	NuS5DkRtEMNDBVrPhgqYldYYuj7Ww65PR4hlyEIkhq5pWYfo6tu3HQ+AmpSYIhrK4QlBHJ
	DGCHkXzz3taH33o0WsSG4HCyR2ZlrU4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-elPlJOsUN--jaXjrIB0zJA-1; Thu,
 23 Apr 2026 09:04:25 -0400
X-MC-Unique: elPlJOsUN--jaXjrIB0zJA-1
X-Mimecast-MFC-AGG-ID: elPlJOsUN--jaXjrIB0zJA_1776949463
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 076C71800623;
	Thu, 23 Apr 2026 13:04:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 988C019560B6;
	Thu, 23 Apr 2026 13:04:18 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net v4 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Thu, 23 Apr 2026 15:04:02 +0200
Message-ID: <20260423130405.139568-2-jtornosm@redhat.com>
In-Reply-To: <20260423130405.139568-1-jtornosm@redhat.com>
References: <20260423130405.139568-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280756-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4244452845
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---

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


