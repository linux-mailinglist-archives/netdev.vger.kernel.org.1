Return-Path: <netdev+bounces-243398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EACC9EFFE
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7BD5348BBE
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F94277CAB;
	Wed,  3 Dec 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="JZhAIsQC"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC2B665;
	Wed,  3 Dec 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765370; cv=none; b=c9SNhYnCkEvlSl3z2G0v27wK1PzNe87wvJW4axhdT57w1tny2vMdDZWUrRCyyJqvxvmI5BSZp7nziEXqNxlw3jqBIyuqyVB8joprACvg4akT+sdNUuRcvIe1d0txCQqLyj+MJX1kBYGpq8V3nJgO7GKfbOq5cTzfjiLLPOjmwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765370; c=relaxed/simple;
	bh=W6v9q/AMeHromkGhCplANkSOyT4E8R5TCICmr0YrzgQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tqtoeYxOSOtAFvt3UL5EIJo198YowKpHbQDCUDml7K2YOq2vOvUg1zQ07c2br+/8tlcVvutGPhWEGRUcWYnWkKk3CNSaN4kWPxITnyjHMUJTwl30JC1NGPRftFnNOo6JXBnKGfAhG8CgHxXzw9deABgqT/45G7xijXQT7dAlU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=JZhAIsQC; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764765368; x=1796301368;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=52W5hZPacCe5bhwqtzlsO9YXwPUI2d9FykI2hO70lHg=;
  b=JZhAIsQCkSK5gxDySAZmkO2izbgUCBx1WPYFkNLTILC2PQMJeMp08+DG
   0wvw+u7poDSpx8WsDZSlDh9GDirDH2/Irm6aWukWXNXwPkgsNSxhVTzDn
   QpPzmF3uYGyyZ41J/yCgt8uwUrpdk0RaMz1ahopUCEuBT8HbEz7Tqgpi0
   fUxct4KPUWFzLQjf5K5wvCk4vH1mESAPxviMdyleloDzdNq7+3SUJxqF5
   dh+CaltaydIcQI0BU0waqM469V1A3/4JmjZBXjJL0VlM67Lamf1HDxWUs
   pV3PJjkpylHkMLX2Fe0+t7BeyB/QIaEoFNoDZcWQg7WFPWoVQEiRcXDwY
   w==;
X-CSE-ConnectionGUID: Alu+96wSSCOvFNBxvMMGuA==
X-CSE-MsgGUID: 0BovM2XCR0Gz3kiQiThEWA==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="6175028"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 12:35:50 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:27224]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.7.127:2525] with esmtp (Farcaster)
 id 77f166b8-0f67-463f-ab1a-d6b35aa7066d; Wed, 3 Dec 2025 12:35:50 +0000 (UTC)
X-Farcaster-Flow-ID: 77f166b8-0f67-463f-ab1a-d6b35aa7066d
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:35:41 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:35:41 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Wed, 3 Dec 2025 12:35:41 +0000
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
Subject: [PATCH v3 0/4] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [PATCH v3 0/4] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHcZFFVAaUrgcb9LUmNfY5mJnOwDQ==
Date: Wed, 3 Dec 2025 12:35:41 +0000
Message-ID: <20251203123539.7292-1-bchalios@amazon.es>
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
=0A=
=0A=
Chalios, Babis (2):=0A=
  ptp: vmclock: add vm generation counter=0A=
  ptp: vmclock: support device notifications=0A=
=0A=
David Woodhouse (2):=0A=
  dt-bindings: ptp: Add amazon,vmclock=0A=
  ptp: ptp_vmclock: Add device tree support=0A=
=0A=
 .../bindings/ptp/amazon,vmclock.yaml          |  46 +++++=0A=
 drivers/ptp/ptp_vmclock.c                     | 185 +++++++++++++++++-=0A=
 include/uapi/linux/vmclock-abi.h              |  20 ++=0A=
 3 files changed, 243 insertions(+), 8 deletions(-)=0A=
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.ya=
ml=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

