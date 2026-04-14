Return-Path: <netdev+bounces-278396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NIHHUke3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:00:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC63F909C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFAF8300B19C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A93D6698;
	Tue, 14 Apr 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEixv3nj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735E3D8125
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164422; cv=none; b=mVs9TlBW86FBh/wEn3fKfaVnyJFWjAzf0JbxVYJQDbKwqYbcLUqsJchpls72f2l2+ExltN8c1GIOPlzXLRzh4F/dm5yJamqvhPsZsTD13JJWBIl5wx3dU7+3Qy/NGBEE4Z6J46Er3sF362qFUyHCH8R/HlR2wOsRNPo5X0eF8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164422; c=relaxed/simple;
	bh=PMJE3LaugAARradNjh4X3EqV9kwqcYBP7TuuI1ozcIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtnxOl0DJ9VWz8uHRRdZjs+MUTA8vCkxQKY5ZT4Wb5W5A1XBL6LIWYezNhsClwkqAwGoyhAwYxWPIz+mHB3sFpAz1IRHVC6OV77xLTp5tj9UgvMQDKWhHG/+ScTiKLG7sKwsB9pFIoyLZbz5ILw/kR0Ns+rbpO9p+63vqtv5LBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEixv3nj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776164419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emzWbgDp3sl38KudWkGi0QqDELafGTENdfL9dcFHDWg=;
	b=CEixv3nj61o/zma8JIxeP07WD+m6qKHkwkdY3GmleQr437kjFWX5dHWUKZjw5T6s9kJHGt
	A5OwkvVGo7hTpqOOjYBw4zllemaLPCxcVv/zaUb4NyXloyyYgT9RkljEdRzzKuVtJoxjVF
	Y74WbuhUGCfPXLoNOdZZd5urv5ZPuWI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-RTSsLGbwPiSxHh2TbH7NIw-1; Tue,
 14 Apr 2026 07:00:16 -0400
X-MC-Unique: RTSsLGbwPiSxHh2TbH7NIw-1
X-Mimecast-MFC-AGG-ID: RTSsLGbwPiSxHh2TbH7NIw_1776164415
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A63C41800365;
	Tue, 14 Apr 2026 11:00:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED6863000C16;
	Tue, 14 Apr 2026 11:00:10 +0000 (UTC)
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
Subject: [PATCH net v3 0/5] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Tue, 14 Apr 2026 13:00:01 +0200
Message-ID: <20260414110006.124286-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278396-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79AC63F909C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes VF bonding failures introduced by commit ad7c7b2172c3
("net: hold netdev instance lock during sysfs operations").

When adding VFs to a bond immediately after setting trust mode, MAC
address changes fail with -EAGAIN, preventing bonding setup. This
affects both i40e (700-series) and ice (800-series) Intel NICs.

The core issue is lock contention: iavf_set_mac() is now called with the
netdev lock held and waits for MAC change completion while holding it.
However, both the watchdog task that sends the request and the adminq_task
that processes PF responses also need this lock, creating a deadlock where
neither can run, causing timeouts.

Additionally, setting VF trust triggers an unnecessary ~10 second VF reset
in i40e driver that delays bonding setup, even though filter
synchronization happens naturally during normal VF operation. For ice
driver, the delay is not so big, but in the same way the operation is not
necessary.

This series:
1. Adds safety guard to prevent MAC changes during reset or early
   initialization (before VF is ready)
2. Eliminates unnecessary VF reset when setting trust in i40e
3. Fixes lock contention by polling admin queue synchronously
4. Eliminates unnecessary VF reset when setting trust in ice
5. Refactors virtchnl polling to unify init-time and runtime code paths

The key fix (patch 3/5) implements a synchronous MAC change operation
similar to the approach used for ndo_change_mtu deadlock fix:
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/ 
Instead of scheduling work and waiting, it:

- Sends the virtchnl message directly (not via watchdog)
- Polls the admin queue hardware directly for responses
- Processes all messages inline (including non-MAC messages)
- Returns when complete or times out

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task. A new generic
iavf_poll_virtchnl_response() function was introduced for this.

Patch 5 refactors the polling implementation based on Przemek Kitszel
feedback, unifying in a centralized polling way, the previously (with
patch 3) separate init-time (avf_poll_virtchnl_msg()) and runtime polling
(iavf_poll_virtchnl_response()) into the original polling function 
(iavf_poll_virtchnl_msg()) allowing both behaviors.
I have preferred to create a separate patch for the refactoring for the
sake of clarity in the solution, and I would prefer to include in the net
series because it is tightly coupled with patch 3.

The function can sleep for up to 2.5 seconds polling hardware, but this
is acceptable since netdev_lock is per-device and only serializes
operations on the same interface.

Testing shows VF bonding now works reliably in ~5 seconds vs 15+ seconds
before (i40e), without timeouts or errors (i40e and ice).

Tested on Intel 700-series (i40e) and 800-series (ice) dual-port NICs
with iavf driver.

Thanks to Jan Tluka <jtluka@redhat.com> and Yuying Ma <yuma@redhat.com> for
reporting the issues.

Jose Ignacio Tornos Martinez (5):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust
  iavf: refactor virtchnl polling to unify init and runtime paths

---
v3:
  - Complete patch 3 with the comments from Przemek Kitszel
  - Added patch 5: Refactor to unify polling into iavf_poll_virtchnl_msg()
    function (Przemek Kitszel suggestion). It processes messages through
    iavf_virtchnl_completion() when appropriate (runtime operations with
    timeout; init-time operations continue to return raw messages without
    completion processing).
  - No changes to patch 1,2 and 4 from v2
v2: https://lore.kernel.org/netdev/20260407165206.1121317-1-jtornosm@redhat.com/

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   7 ++++++-
 drivers/net/ethernet/intel/iavf/iavf.h             |   6 +++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  13 +++++++++----
 5 files changed, 193 insertions(+), 64 deletions(-)
--
2.43.0


