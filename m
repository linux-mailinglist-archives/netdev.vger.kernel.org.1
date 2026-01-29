Return-Path: <netdev+bounces-254679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JxFBCEve2mbCAIAu9opvQ
	(envelope-from <netdev+bounces-254679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:57:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D80AE4E8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D6430160CA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1B37FF7D;
	Thu, 29 Jan 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2hj6lOE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4D376BF9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680662; cv=none; b=FFv2RQpH6vL1u95EASDT6XmdtJkF/gfvAToxyUQSgMfS32pbPxvZW6G3ckRUBORhtahkjQKrHdA7uor0rg6QE3DwhdBIS318wIBREPhrUIG+XtXGtwyUIBCrFKGaFWxCSHuxgzvzlwuHst/6PMSAOaCuBo8MZcGbdiTvGz+JziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680662; c=relaxed/simple;
	bh=RQihqxsso+7xeMWjpGb9PL5gf8xIHK+tva93bT86+Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQXUB4cwiy3w7NYQc3FAWBQcSVzCMDlpiKzXl3YcCvkiqAqwFAyDx6UOTsnnnUHyezf74R83nfT39SvDV9FQDmGDLuVRYw+ZJ3sQK/GgY3QyqMveR4apM3FsZ3d7boSSe+BgAHqF0itSssj/2sBMJidE7pggGM1vbKH4o+t+Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2hj6lOE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769680659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Z7GQGT6PLKvmdoazn0BpeLlPo5mZl2/bnsp2MVA+EA=;
	b=c2hj6lOEJTfW75iRwrV8g3O2WeDvF/86gh6bf9+OYIKtBYNgh8cJRQIaksPUPHFc+288Za
	fELL8A0ild5YFHcGfF4I/kyCaHg/2QoZ1dkZjLn+Y7eNkOl+JebR1zrvVGOQOUJXo9blqs
	Qu6aCI9+ZE7HHr0qYwiPVjNbR950Qyc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-_Kn7WWcYPY6B2Aa8H1AueA-1; Thu,
 29 Jan 2026 04:57:36 -0500
X-MC-Unique: _Kn7WWcYPY6B2Aa8H1AueA-1
X-Mimecast-MFC-AGG-ID: _Kn7WWcYPY6B2Aa8H1AueA_1769680653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674371956096;
	Thu, 29 Jan 2026 09:57:33 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C837A1800109;
	Thu, 29 Jan 2026 09:57:28 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	mschmidt@redhat.com,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: fix PTP use-after-free during reset
Date: Thu, 29 Jan 2026 10:57:23 +0100
Message-ID: <20260129095723.7269-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254679-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3D80AE4E8
X-Rspamd-Action: no action

Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
worker to cache PHC time, but failed to stop it during reset or disable.

This creates a race condition where `iavf_reset_task()` or
`iavf_disable_vf()` free adapter resources (AQ) while the worker is still
running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
accesses freed memory/locks, leading to a crash.

Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
This ensures `ptp_clock_unregister()` synchronously cancels the worker and
cleans up the chardev before the backing resources are destroyed.

Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4b0fc8f354bc90..0dd58ce5a53ab1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3025,6 +3025,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 
 	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 
+	iavf_ptp_release(adapter);
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
@@ -3200,6 +3202,8 @@ static void iavf_reset_task(struct work_struct *work)
 	iavf_change_state(adapter, __IAVF_RESETTING);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 
+	iavf_ptp_release(adapter);
+
 	/* free the Tx/Rx rings and descriptors, might be better to just
 	 * re-use them sometime in the future
 	 */
-- 
2.52.0


