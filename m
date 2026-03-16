Return-Path: <netdev+bounces-268105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKS1AHXft2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:46:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C82982C0
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882E7303980C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70EF38E5C5;
	Mon, 16 Mar 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKpYU/jG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DB352FB0
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657743; cv=none; b=XZPRZVldBXUBp/oOdRIIx6b2uOcumyDPzj+zYVqL/OFDvu/Nlq0Bu9U6m3n0MG4RbjoQIupCqjRmGBy48fIv5XMSAfBF3d421mwr5NI5AVCKZ5cnfhtZMQjdlK9wEvz0F5pGTDC7C0XAG1ey9aVZHXKsPWDLNYm9Nu5s/1+KTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657743; c=relaxed/simple;
	bh=8Qy1DBIxqkYwn2wXhlkbjB394PF3wV9MJQ2OC1yioog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBkgxa9L9Xpi3j5adjYYzgUvbsKooH1aSX8eqMGWWPZxpJoIYBlRfGLe9G88ZTxHaP8VhGjGKGLCvQ/ELWn2bwGCoZS70Fqdc/RLaaJdqGgrC/6A4ZHqIl7L+vV2zHmLLpJpVgTTFhLbeUBRDcxyn4EwV0Q+hfI3R8CJvbnZG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKpYU/jG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773657741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iwCjK/8BbuVWkdj/Kq+vjZgwo9eNY1olqWaI6BrfiNo=;
	b=OKpYU/jGHsdTIwkP9bnEAEyceP5aWi9nC5mPn1l1UoQ3boJgQEkPqHIaGwnkjbNgPkkV44
	mvNfmRHNzF2qe20kCatv6piTVoX4bw0Orv7v4ZMtqdRiQd5VKpMT4+LuHDkznCriabyCMV
	7t6blMg+Za652u4IpWSGWblp02IlqsU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-bDlMZFYfOuW7prj0v2ZDtg-1; Mon,
 16 Mar 2026 06:42:17 -0400
X-MC-Unique: bDlMZFYfOuW7prj0v2ZDtg-1
X-Mimecast-MFC-AGG-ID: bDlMZFYfOuW7prj0v2ZDtg_1773657736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A148195609D;
	Mon, 16 Mar 2026 10:42:16 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.235])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6E57180035F;
	Mon, 16 Mar 2026 10:42:11 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 0/4] iavf: fix VLAN filter state machine races
Date: Mon, 16 Mar 2026 11:42:05 +0100
Message-ID: <20260316104209.1285962-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268105-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D8C82982C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The iavf VLAN filter state machine has several design issues that lead
to race conditions between userspace add/del calls and the watchdog
task's virtchnl processing.  Filters can get lost or leak HW resources,
especially during interface down/up cycles and namespace moves.

The root problems:

1) On interface down, all VLAN filters are sent as DEL to PF and
   re-added on interface up.  This is unnecessary and creates multiple
   race windows (details below).

2) The DELETE path immediately frees the filter struct after sending
   the DEL message, without waiting for PF confirmation.  If the PF
   rejects the DEL, the filter remains in HW but the driver lost its
   tracking structure.  Race conditions between a pending DEL and
   add/reset operations cannot be resolved because the struct is gone.

3) VIRTCHNL_OP_ADD_VLAN (V1) had no success completion handler, so
   filters stayed in IS_NEW state permanently.


Why removing VLAN filters on down/up is unnecessary:

Unlike MAC filters, which need to be re-evaluated on up because the
PF can administratively change the MAC address during down, VLAN
filters are purely user-controlled.  The PF cannot change them while
the VF is down.  When the VF goes down, VIRTCHNL_OP_DISABLE_QUEUES
stops all traffic -- VLAN filters sitting in PF HW are harmless
because no packets flow through the disabled queues.

Compare with other filter types in iavf_down():
- MAC filters: only the current MAC is removed (it gets re-read from
  PF on up in case it was administratively changed)
- Cloud filters: left as-is across down/up
- FDIR filters: left as-is across down/up

VLAN filters were the only type going through a full DEL+ADD cycle,
and this caused real problems:

- With spoofcheck enabled, the PF activates TX VLAN anti-spoof on
  the first non-zero VLAN ADD.  During the re-add phase after up,
  the filter list is transiently incomplete -- traffic for VLANs not
  yet re-added gets dropped by anti-spoof.

- Rapid down/up can overlap with pending DEL messages.  The old code
  used DISABLE/INACTIVE states to track this, but the DISABLE state
  could overwrite a concurrent REMOVE from userspace, causing the
  filter to be restored instead of deleted.

- Namespace moves trigger implicit ndo_vlan_rx_kill_vid() calls
  concurrent with the down/up sequence.  The DEL from the namespace
  teardown races with the DISABLE from iavf_down(), and the filter
  can end up leaked in num_vlan_filters with no associated netdev.

After reset, VF-configured VLAN filters are properly re-added via
the VIRTCHNL_OP_GET_VF_RESOURCES / GET_OFFLOAD_VLAN_V2_CAPS response
handlers, which unconditionally set all filters to ADD state.  This
path is unaffected by these changes.


This series addresses all three issues:

Patch 1 renames IS_NEW to ADDING for clarity.

Patch 2 removes the DISABLE/INACTIVE state machinery so VLAN filters
stay ACTIVE across down/up cycles.  This is the core behavioral
change -- VLAN filters are no longer sent as DEL to PF on interface
down, and iavf_restore_filters() is removed since there is nothing
to restore.

Patch 3 adds a REMOVING state to make the DELETE path symmetric with
ADD -- filters are only freed after PF confirms the deletion.  If the
PF rejects the DEL, the filter reverts to ACTIVE instead of being
lost.

Patch 4 hardens the remaining race windows: adds V1 ADD success
handler and prevents redundant DEL on filters already in REMOVING
state.

Petr Oros (4):
  iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
  iavf: stop removing VLAN filters from PF on interface down
  iavf: wait for PF confirmation before removing VLAN filters
  iavf: harden VLAN filter state machine race handling

 drivers/net/ethernet/intel/iavf/iavf.h        |  9 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 53 ++++---------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 76 +++++++++----------
 3 files changed, 54 insertions(+), 84 deletions(-)

-- 
2.52.0


