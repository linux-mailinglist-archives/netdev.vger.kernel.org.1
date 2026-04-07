Return-Path: <netdev+bounces-276092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KnOOE021WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 815423B2146
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B3D730104A4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1933CFF41;
	Tue,  7 Apr 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyOD170O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77303126AD
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580747; cv=none; b=HyMA1c0hagJelF/lu/0emHmgWAORFyzstrH06y3HSpN5rMEpZo4+sv56K5uSJp0ZPagd3FY508oaJnmadF3wss1YBJK1hrgwjUwKBfd9se5ZSLcC8ZOfKFE1sudno+2LvKBJOdRx6Ifnwwk0VAN6Sh2704IrM8lnvKXlAkbt/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580747; c=relaxed/simple;
	bh=gj8RqAAhiaVUvewsQS4TWjuxF250FDoMN9XQh05VKRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzxICzaSuiTssYiuYGKitwj6ZbcT77WTpdEUu9s/Ms2qpE7U/UeJ6w3FNL7BitaEkrMlKIg0vIbay00Cy7RB1RtFlIx27hh7J77PkDfaN82PeU0b4XI9HLx+Jy3moK5MiI/DgqZlWV+/ueaeONwepeznv2snye2mn74o0lztIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyOD170O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775580744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VeT8l2i6TVJAMB6JutKbZp1m2QbJomW0DqBNO06ssKM=;
	b=fyOD170OuzxL9NRuzlwYj4pEBJnZsHqv/fhiE3iIddjDS7XQPApVHZq6HS8bRABmcMj3W2
	Qbl/BctPyfgU9xlholYQENuKI8Bl7MrRdjua9E5pHY1a9o/m+4M1YaIuY24JWu/ahdmmnO
	OmOmC1Wtxqfl5zFNoL209UTAjK9KcOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-GUFDX4iwOiivGX4MLt0HAA-1; Tue,
 07 Apr 2026 12:52:21 -0400
X-MC-Unique: GUFDX4iwOiivGX4MLt0HAA-1
X-Mimecast-MFC-AGG-ID: GUFDX4iwOiivGX4MLt0HAA_1775580740
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 104111956094;
	Tue,  7 Apr 2026 16:52:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9242A300019F;
	Tue,  7 Apr 2026 16:52:16 +0000 (UTC)
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
Subject: [PATCH net v2 0/4] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Tue,  7 Apr 2026 18:52:02 +0200
Message-ID: <20260407165206.1121317-1-jtornosm@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-276092-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 815423B2146
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

The key fix (patch 3/4) implements a synchronous MAC change operation
similar to the approach used for ndo_change_mtu deadlock fix:
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/ 
Instead of scheduling work and waiting, it:

- Sends the virtchnl message directly (not via watchdog)
- Polls the admin queue hardware directly for responses
- Processes all messages inline (including non-MAC messages)
- Returns when complete or times out

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task. A new generic
iavf_poll_virtchnl_response() function is introduced that can be reused
for future synchronous virtchnl operations.

The function can sleep for up to 2.5 seconds polling hardware, but this
is acceptable since netdev_lock is per-device and only serializes
operations on the same interface.

Testing shows VF bonding now works reliably in ~5 seconds vs 15+ seconds
before (i40e), without timeouts or errors (i40e and ice).

Tested on Intel 700-series (i40e) and 800-series (ice) dual-port NICs
with iavf driver.

Thanks to Jan Tluka <jtluka@redhat.com> and Yuying Ma <yuma@redhat.com> for
reporting the issues.

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

---
v2:
  - Patch 1: Add state check to prevent MAC changes during early
    initialization (before __IAVF_DOWN state)
  - Patch 3: Use synchronous polling approach instead of dropping lock,
    following the pattern from ndo_change_mtu deadlock fix
  - Introduce generic iavf_poll_virtchnl_response() for code reuse
  - Add patch 4/4 to fix the same trust reset issue in ice driver
  - Add testing confirmation for both i40e and ice hardware
  - No changes to patch 2 from v1
v1: https://lore.kernel.org/netdev/20260406112057.906685-1-jtornosm@redhat.com/

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 17 ++-
 drivers/net/ethernet/intel/iavf/iavf.h             |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 98 +++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 15 +--
 drivers/net/ethernet/intel/ice/ice_sriov.c         | 15 ++-
 5 files changed, 123 insertions(+), 24 deletions(-)

--
2.43.0


