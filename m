Return-Path: <netdev+bounces-300603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GcAfFhTeNGqbiwYAu9opvQ
	(envelope-from <netdev+bounces-300603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:13:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A12D66A40D8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:13:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ONq5lGO1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300603-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300603-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8573038F54
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D0934A3C9;
	Fri, 19 Jun 2026 06:13:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962C3148C5
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:13:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849618; cv=none; b=b2NhFsqUqp5/E2gxmC+JfrSK16Dv/dXEZgqnFGaPBkB2DrOhr6pXXhtlv5AumHYeKWFbB0BLlNtkwWRyMx1BdZ1vzocIpTMnIil8Cbo4xKr4Zh6RrbTOC6Oo/3Kk0KKMckqKE90fYYRuKDGEsU8v3tfbKu72M3OymJp1qiFWNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849618; c=relaxed/simple;
	bh=XcCkrPI2UC0mseAuv67Yj4yhkt2h1uRyEvK+wlUX+SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5Twd5cCgehomFb8DzA49Y9tBKtNgdm6t3tqyezfHAgc+7nDC2EY4h8qpbrHDtuDDV5UCC2cwXSlck5Z7CV9Xv45frjo4+a1pIBp/P+sUQBAUjNALdgvmRHpq7EpZr52tdOoLNXpIRQAR5XZt9O++Dw1SXsW++xsi7yziF1aFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONq5lGO1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781849615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=09Af/p941u9vuXloa/4AdqYAv0ET6ySs46OyBq8hbRk=;
	b=ONq5lGO1uLge2xwSpLQJU+6k2p9IZC3kQpLOLi6hWOl6f43FTBQdXdl5y4Y5cvTe8almJv
	y2LZ1ZgyxTQaT6p0a+Lb6a3R003/s9qx+DHGXSEU732xKwnXZP0gCfNYI0wXb7nXz7B4Ko
	6Zjq20ckBxkuQhCEPVDGNWxeMeqz+u0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-a99EL2bdNLOUgcN9FN3MHA-1; Fri,
 19 Jun 2026 02:13:32 -0400
X-MC-Unique: a99EL2bdNLOUgcN9FN3MHA-1
X-Mimecast-MFC-AGG-ID: a99EL2bdNLOUgcN9FN3MHA_1781849610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A911805A10;
	Fri, 19 Jun 2026 06:13:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 003D81956088;
	Fri, 19 Jun 2026 06:13:24 +0000 (UTC)
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
Subject: [PATCH net v6 0/4] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Fri, 19 Jun 2026 08:13:15 +0200
Message-ID: <20260619061321.8554-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-300603-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:horms@kernel.org,m:jesse.brandeburg@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A12D66A40D8

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
2. Eliminates unnecessary VF reset when setting trust in i40e (reset only
   if revoking trust and VF has advanced features configured).
3. Fixes lock contention by polling admin queue synchronously
4. Eliminates unnecessary VF reset when setting trust in ice, (reset only
   if revoking trust and VF has advanced features configured).

The key fix (patch 3/4) implements a synchronous MAC change operation
similar to the approach used for ndo_change_mtu deadlock fix:
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/
Instead of scheduling work and waiting, it:

- Sends the virtchnl message directly (not via watchdog)
- Polls the admin queue hardware directly for responses
- Processes all messages inline (including non-MAC messages)
- Returns when complete or times out

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task.

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
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

All patches tested successfully with bonding setup.
---
v6:
  - Patch 1/4 (iavf EBUSY): No changes from v5
  - Patch 2/4 (i40e trust): No code changes from v5. AI review comments covered
    design decisions and pre-existing issues, no bugs found in new code.
  - Patch 3/4 (iavf sync MAC): Address edge cases from AI review (Jakub Kicinski)
    - Allocate event buffer before sending to avoid state mismatch if allocation
      fails after message is sent to PF
    - Add loop to send all batches before polling (rare multi-batch scenario)
    - Conditional rollback: only rollback on send failure (ret != -EAGAIN), not on
      timeout where PF will eventually respond
  - Patch 4/4 (ice trust): Revert to original reset pattern based on AI review
    - AI review identified issues with v5's reset-before-cleanup approach
      (privilege bit not cleared, LLDP cleanup loop became dead code)
    - Restore proven cleanup → set trust → reset pattern from original code
    - Simpler implementation, no save/restore complexity
    - Maintains same goal: skip reset when VF has no advanced features
v5: https://lore.kernel.org/all/20260429102426.210750-1-jtornosm@redhat.com/

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 ++++++++++++++++++++++++++++----------
 drivers/net/ethernet/intel/iavf/iavf.h             |  10 ++++++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  33 +++++++++++++++++++++++++++++----
 5 files changed, 220 insertions(+), 35 deletions(-)
--
2.43.0


