Return-Path: <netdev+bounces-255202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGL8LQjtfGmdPQIAu9opvQ
	(envelope-from <netdev+bounces-255202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA2BD5F8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0E933001CDA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E48368283;
	Fri, 30 Jan 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="o0S4s5hl"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955C329E4F;
	Fri, 30 Jan 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794637; cv=none; b=PZNQK4PRcUbw0ARXBHvkQp6pTRxXlCdTUhwV0Z3VNyACDzyBksndsxVQ+ccb1pkBNx+9AOpsLt6nYzzZm0XKKdN4sN3iNDlEtwv8nuB8XQZzticScstudNE1u3Go7tPCJkgiCjsNf9Ooav8T18iDnpy/qIQ03bwpXGgSE9JwrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794637; c=relaxed/simple;
	bh=OzsHiGW7Hy3+AaOxBYkpu0JNpYgIrShTbo1QZZJpOeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bpVmZKV7DLwD72Xx+j5XjLZyko+DUV8m/uBVblE8Fe8pcPmDDGAmXRRqUX3LhsfyhfbyN+BzCCM/SmYaU7El830M7oEipsNVy0YoXNY3W/e9/4pcBpzwW0KCncvIHQkBhv83B5paTgp3HnlUHhW1bpV/g/K5SU+Tw3niYUjgQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=o0S4s5hl; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794636; x=1801330636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bSmUPkvI6yZc/EL+x6no1njSes3muZ6IEO/HHymzFD8=;
  b=o0S4s5hl9a73plcqxeH/dGTzRaaa0L7NAQAckjtNyUSwkYP0b40VWN6P
   DwgQPh+TZkUe7OSN+/DruVsA70t+Y712Od2cpn3SGODLQGjwL7/1lKWep
   gLFDFzCzjH0TmP5ZxBWOiBAMmphiGDmGoVZIp+wwPk9WDKAC0SnQA7Xn+
   hSRtjSTuwtH05KdUknL57Z+JdHUxa5V2KTjDAByA/FvFK2iL/pmtNQLRD
   yKKgcFgMlP4I402JmGsrH7QU3IdU3TG3bvcSMWPl9fmsDbAdPNyH0zn4R
   Q5Zyu7gT8+8xs41Vve0uts5yvcBumfrctruSA07rerAldLYLznMohXU0y
   w==;
X-CSE-ConnectionGUID: iLlc1mrnTs+rKY85dqhS0w==
X-CSE-MsgGUID: BcrGGv2gSZeF8sRLNanV/w==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11938848"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:30511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.123:2525] with esmtp (Farcaster)
 id 9b40c9e8-ea84-469c-a16a-b0824abbf488; Fri, 30 Jan 2026 17:37:13 +0000 (UTC)
X-Farcaster-Flow-ID: 9b40c9e8-ea84-469c-a16a-b0824abbf488
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:10 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:08 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 0/7] ptp: vmclock: Add VM generation counter and ACPI notification
Date: Fri, 30 Jan 2026 17:35:59 +0000
Message-ID: <20260130173704.12575-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255202-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7CA2BD5F8
X-Rspamd-Action: no action

Similarly to live migration, starting a VM from some serialized state
(aka snapshot) is an event which calls for adjusting guest clocks, hence
a hypervisor should increase the disruption_marker before resuming the
VM vCPUs, letting the guest know.

However, loading a snapshot, is slightly different than live migration,
especially since we can start multiple VMs from the same serialized
state. Apart from adjusting clocks, the guest needs to take additional
action during such events, e.g. recreate UUIDs, reset network
adapters/connections, reseed entropy pools, etc. These actions are not
necessary during live migration. This calls for a differentiation
between the two triggering events.

We differentiate between the two events via an extra field in the
vmclock_abi, called vm_generation_counter. Whereas hypervisors should
increase the disruption marker in both cases, they should only increase
vm_generation_counter when a snapshot is loaded in a VM (not during live
migration).

Additionally, we attach an ACPI notification to VMClock. Implementing
the notification is optional for the device. VMClock device will declare
that it implements the notification by setting
VMCLOCK_FLAG_NOTIFICATION_PRESENT bit in vmclock_abi flags. Hypervisors
that implement the notification must send an ACPI notification every
time seq_count changes to an even number. The driver will propagate
these notifications to userspace via the poll() interface.

Changes:

* RFC -> v1:
  - Made the notification support optional. Hypervisor needs to
    advertise support for the notification via a flag in vmclock_abi.
    Subsequently, poll() will return POLLHUP when the feature is not
    supported, to avoid having userspace blocking indefinitely waiting
    for events that won't arrive
  - Reworded the comment around vm_generation_counter field to avoid
    speaking about "jumping forward in time".
* v1 -> v2:
  - Correctly handle failures when calling vmclock_setup_notification to
    setup notifications.
  - Use atomic_t for fst->seq and handle the case of concurrent
    read()/poll() accesses.
  - Initialize fst->seq to 0 rather than what is currently stored in the
    shared page. This is to avoid reading odd numbers.
  - Add DT bindings similar to existing VMGenID ones.
* v2 -> v3:
  - Include missing header file and drop unused variables in PATH 2/4.
  - Include missing Reviewed-by in PATCH 1/4.
  - Fix DT node name to be generic (s/vmclock/ptp).
  - Include missing maintainers.
* v3 -> v4:
  - Added bindings file as maintained by David as part for PTP VMCLOCK
    SUPPORT.
  - Use le64_to_cpu() to access clk->flags.
  - Reference public specification.
  - Pass struct vmclock_state * in the of IRQ handler
  - Included three new patches from David:
    * Making ACPI optional for the driver.
    * Adding "VMCLOCK" to ACPI match.
    * Return TAI instead of UTC.
* v4 -> v5:
  - Use IF_ENABLED instead of #ifdef
  - Use reverse christmas tree order in variable declaration
  - Fix empty changelog
* v5 -> v6:
  - Fix blank line CHECKs reported by checkpatch.pl
* v6 -> v7:
  - Unregister the ACPI notify handler on removal to prevent UAF
  - Fix a race where the ACPI notifier handler could run before
    driver_data initialization.

Babis Chalios (2):
  ptp: vmclock: add vm generation counter
  ptp: vmclock: support device notifications

David Woodhouse (5):
  dt-bindings: ptp: Add amazon,vmclock
  ptp: ptp_vmclock: Add device tree support
  ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
  ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
  ptp: ptp_vmclock: return TAI not UTC

 .../bindings/ptp/amazon,vmclock.yaml          |  46 ++++
 MAINTAINERS                                   |   1 +
 drivers/ptp/Kconfig                           |   2 +-
 drivers/ptp/ptp_vmclock.c                     | 236 ++++++++++++++++--
 include/uapi/linux/vmclock-abi.h              |  20 ++
 5 files changed, 279 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml

-- 
2.50.1


