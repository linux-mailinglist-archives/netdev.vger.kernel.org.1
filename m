Return-Path: <netdev+bounces-245359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E80CCC478
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0E430413D9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFD287518;
	Thu, 18 Dec 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="HJjIk01v"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3642877F4;
	Thu, 18 Dec 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067872; cv=none; b=RWBTP+r69xkW+34cXrjFAheurRlG7ruc5FsD0bkIlYYqhmA9pby/o89jUta/Avf/K1vl3RoZBQcoedS/B/I3nyNAneCh/ZLHLk+KJxNkBO4m7w/UHcP/Y7y1q4VBEmm3XZ0SL4CoWhWdY/DtUYKjXwvtYpFWsUeExYzDi5NeyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067872; c=relaxed/simple;
	bh=0cipM977IhZ/FD+5hZHsbMFZHzQRGANFOZF4DEZm+Q8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FjkszvOM+rMGt+fdBaPH8SjhXQhCnKGXMkaQ0z6dBjqSkvNmsMXj+rJV5M1rQlIdU5DidpoJ4FfU6G3Usf+XBvZT8bOxsp+SfBJPdYxrhOWORdiMa63s85aoqqR/zqemNiki6orpxHC2al67jGr+ELzoGW6Sf/x2WYvKP7EBc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=HJjIk01v; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067870; x=1797603870;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HGfacwEIr6P9UImYxcnM50Ppjowi/9glt+UsaySx1z4=;
  b=HJjIk01vChjZSSH99soGfHrL+KjX3az/GylFWutmBp9WqVDNpNiGxwki
   m/CJz/SkAuEYkJjJ76Ad618JT1AiUEMfUSSL5wrzBm0xIayv4TuyJ4f+r
   RMcD6W2YjUbjaKTeZst6oZecvmu5r6Kx1wt1PIUhHnBs9MwAYCH536Bff
   ytux0iPhH0QDTFCFQSSN+BEWsNMUU7Dp1dC6xXpzkO68gVpakDSkY/cYE
   0nFIFQkDtulMlxtVTTl8h4CHNfSLEpnT96FYctdEQoUckOO6doB+rpBCk
   SqMDhYz3s0QyZTyObN2RQEK0bie6UcMlrtmn7O1aNrVD+WrwS/zTAUAfF
   w==;
X-CSE-ConnectionGUID: 29wV36AVRZOp8t8uldGV2A==
X-CSE-MsgGUID: ycdphhv5QhaS0U6OxDCxmA==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6890821"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:24:11 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:8693]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.54:2525] with esmtp (Farcaster)
 id 596c40f2-bde7-4c01-8fe7-a884d9139314; Thu, 18 Dec 2025 14:24:11 +0000 (UTC)
X-Farcaster-Flow-ID: 596c40f2-bde7-4c01-8fe7-a884d9139314
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:24:10 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:24:10 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:24:10 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chalios,
 Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 0/7] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [PATCH v4 0/7] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHccCn5Zg1upPC190WbOW1Ajeq1DQ==
Date: Thu, 18 Dec 2025 14:24:10 +0000
Message-ID: <20251218142408.8395-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Similarly to live migration, starting a VM from some serialized state=0A=
(aka snapshot) is an event which calls for adjusting guest clocks, hence=0A=
a hypervisor should increase the disruption_marker before resuming the=0A=
VM vCPUs, letting the guest know.=0A=
=0A=
However, loading a snapshot, is slightly different than live migration,=0A=
especially since we can start multiple VMs from the same serialized=0A=
state. Apart from adjusting clocks, the guest needs to take additional=0A=
action during such events, e.g. recreate UUIDs, reset network=0A=
adapters/connections, reseed entropy pools, etc. These actions are not=0A=
necessary during live migration. This calls for a differentiation=0A=
between the two triggering events.=0A=
=0A=
We differentiate between the two events via an extra field in the=0A=
vmclock_abi, called vm_generation_counter. Whereas hypervisors should=0A=
increase the disruption marker in both cases, they should only increase=0A=
vm_generation_counter when a snapshot is loaded in a VM (not during live=0A=
migration).=0A=
=0A=
Additionally, we attach an ACPI notification to VMClock. Implementing=0A=
the notification is optional for the device. VMClock device will declare=0A=
that it implements the notification by setting=0A=
VMCLOCK_FLAG_NOTIFICATION_PRESENT bit in vmclock_abi flags. Hypervisors=0A=
that implement the notification must send an ACPI notification every=0A=
time seq_count changes to an even number. The driver will propagate=0A=
these notifications to userspace via the poll() interface.=0A=
=0A=
Changes:=0A=
=0A=
* RFC -> v1:=0A=
  - Made the notification support optional. Hypervisor needs to=0A=
    advertise support for the notification via a flag in vmclock_abi.=0A=
    Subsequently, poll() will return POLLHUP when the feature is not=0A=
    supported, to avoid having userspace blocking indefinitely waiting=0A=
    for events that won't arrive=0A=
  - Reworded the comment around vm_generation_counter field to avoid=0A=
    speaking about "jumping forward in time".=0A=
* v1 -> v2:=0A=
  - Correctly handle failures when calling vmclock_setup_notification to=0A=
    setup notifications.=0A=
  - Use atomic_t for fst->seq and handle the case of concurrent=0A=
    read()/poll() accesses.=0A=
  - Initialize fst->seq to 0 rather than what is currently stored in the=0A=
    shared page. This is to avoid reading odd numbers.=0A=
  - Add DT bindings similar to existing VMGenID ones.=0A=
* v2 -> v3:=0A=
  - Include missing header file and drop unused variables in PATH 2/4.=0A=
  - Include missing Reviewed-by in PATCH 1/4.=0A=
  - Fix DT node name to be generic (s/vmclock/ptp).=0A=
  - Include missing maintainers.=0A=
* v3 -> v4:=0A=
  - Added bindings file as maintained by David as part for PTP VMCLOCK=0A=
    SUPPORT.=0A=
  - Use le64_to_cpu() to access clk->flags.=0A=
  - Reference public specification.=0A=
  - Pass struct vmclock_state * in the of IRQ handler=0A=
  - Included three new patches from David:=0A=
    * Making ACPI optional for the driver.=0A=
    * Adding "VMCLOCK" to ACPI match.=0A=
    * Return TAI instead of UTC.=0A=
=0A=
=0A=
Babis Chalios (2):=0A=
  ptp: vmclock: add vm generation counter=0A=
  ptp: vmclock: support device notifications=0A=
=0A=
David Woodhouse (5):=0A=
  dt-bindings: ptp: Add amazon,vmclock=0A=
  ptp: ptp_vmclock: Add device tree support=0A=
  ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match=0A=
  ptp: ptp_vmclock: remove dependency on CONFIG_ACPI=0A=
  ptp: ptp_vmclock: return TAI not UTC=0A=
=0A=
 .../bindings/ptp/amazon,vmclock.yaml          |  46 ++++=0A=
 MAINTAINERS                                   |   1 +=0A=
 drivers/ptp/Kconfig                           |   2 +-=0A=
 drivers/ptp/ptp_vmclock.c                     | 197 ++++++++++++++++--=0A=
 include/uapi/linux/vmclock-abi.h              |  20 ++=0A=
 5 files changed, 252 insertions(+), 14 deletions(-)=0A=
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.ya=
ml=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

