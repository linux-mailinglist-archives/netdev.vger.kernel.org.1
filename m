Return-Path: <netdev+bounces-247753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43356CFE221
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F4DC30E2B80
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A29C33D6C5;
	Wed,  7 Jan 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="PliNvngO"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349133D515;
	Wed,  7 Jan 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792406; cv=none; b=m3oIG4uNuqjOGOk+dTPoi05UIX+S2ntXIvlWIjbRiAlLJHI5OOWxj7xynoIrHtrOAvZ0eHklJuFTXgvIzsnfduWOUHlawvZGsBlHcZZ13G+Pkgwmi0GBG5Y5fkbiPE8itL+e7qmJ5G46rhwSiHmIBGxGNmgoSxSw41Y9L72e5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792406; c=relaxed/simple;
	bh=/rZBpO52xXxuoQQPkKXOrNVD4n+k/Zjfwbo5z10uqxg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JPfDMULNyFWurcJOW3HYTTTtoZVOs8ww7S7oGURymRCHNjq2NEgKHPhO3hxn2J+zx5oRcoQsqPYmmRZsLrUTYK2ROgWDQZyOUxsmKDyAyujZL/uzXdBfVeGy07t8t5vIQNJc5Nem3iJreGklY/S0m+36C53RyNyq6rrXA+OmvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=PliNvngO; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792404; x=1799328404;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=RMIophZlxEgjfa3KqgxSCBF+iO3l+zbvvXo+LD3V8BU=;
  b=PliNvngOAbEToECEPSXzMkzTFdFYZMQMEprDhkKTxbBrm/eqR0lJe8qH
   qmpXYSXzMLRPnAbr5X7ZC2zbLyQiphOYP0Y5+D19y2GA1sR0OPjLiyvC9
   60H7bfPAVool6XAfXTgvC+sypIMUB8hRNSGxjdhQxJ/Ofc7/LuWRcNQiR
   OFa6A2Wzs2u5jq41ObEvyKiS/0i6YiVllrWI9QaninV36+OQSFfUlD2WL
   sgnEqQ2Rq+v8qA9oq8NN+S8O6UYPaUMv0F3PcupSx/rrX8b5+QdDj2Ia0
   HfFFYtSVBV7kgQLKOzaNfhZR2Yr6JXGMZTSMFy34ADx5oQEnsvBw1tDPJ
   A==;
X-CSE-ConnectionGUID: NzmdXprxT6acyEg2nq96gw==
X-CSE-MsgGUID: NCbr6197RUKoTawg1ZzxpA==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7478796"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:25:17 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:25205]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.35.222:2525] with esmtp (Farcaster)
 id a21d1c4b-5ea1-4cd6-9863-0fabfd08ba92; Wed, 7 Jan 2026 13:25:17 +0000 (UTC)
X-Farcaster-Flow-ID: a21d1c4b-5ea1-4cd6-9863-0fabfd08ba92
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:25:16 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:25:16 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:25:16 +0000
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
Subject: [PATCH v5 0/7] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [PATCH v5 0/7] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHcf9kPVyPtWnY4eUqCg4Dkevi9Nw==
Date: Wed, 7 Jan 2026 13:25:16 +0000
Message-ID: <20260107132514.437-1-bchalios@amazon.es>
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
* v4 -> v5:=0A=
  - Use IF_ENABLED instead of #ifdef=0A=
  - Use reverse christmas tree order in variable declaration=0A=
  - Fix empty changelog=0A=
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

