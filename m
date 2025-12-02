Return-Path: <netdev+bounces-243312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FAC9CDFD
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB754E0489
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219B2EDD62;
	Tue,  2 Dec 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="WbX+n78J"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110782C327A;
	Tue,  2 Dec 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706302; cv=none; b=rhFJASUZdBu6qhFhDGfdooq8QZLCIhll2H0w1XmWc5UJ/qouxX2/5a7CDY9jXHc8vhiuDa4464JL5Xcb3e7hFCeN/7xawqZRMQ1+KnOPv/2EIyhg9JpXoQBD+FwNu5TFD6uPf17NeB3Hsf23ifFO0WJANiWw4AU6BLpU/xSjzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706302; c=relaxed/simple;
	bh=ZloIz8LfVUkcwmGHf5ic3yW8VzNjfI2gp4sckgIqEk4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=muQ6JFajLOU4wLTt4rSho8zwXCUbqJnmt0xERAB47UIp5esHu1fB1sdIJggp4B0GNSnC5CkhcCypRni9V4c5Zduz5M+9VGIISkPBTAh60q/Xa+RG8yTmfh3IaM5c9woNAt4uUuk+hul9cMGhT1zAr+SJVNKUse/xoJMTx9peO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=WbX+n78J; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764706300; x=1796242300;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TAo0sveljbproKhPHBfuzgqmOf9l7bC8wtAecNRh8NA=;
  b=WbX+n78JD3/bs04poHN6vmjWH7Iw4eVhocJKALOj9F9Gcn1OsJoqRN4D
   aZSPlnXRKjHes8wSuVtX9z4OiSh/Wh4Q7PG8z2rP6DP/jaXA3yaMwPDy7
   1VE5yOlDmW7vL4da+HveUAbZur1W+xaaStXRAK/TBEyaBRINxbMm+Zd4u
   WHp9kK9RzAYGVjSpwHyd7vmTLqPmXkRIA6dB2+Cw7XwPNHFZ5h6Kd4fF5
   vMqyIkisZ/flwHWySBlKpghUxVl0sf/RUS8qvxW9tYWmrqAIyuhCudEPV
   g5ZjmDYO1JT1EX4cfzy61f8lsLK1WzKRhYqKHl4j7vDXPAwYEAc72jsPt
   Q==;
X-CSE-ConnectionGUID: GR3GMfHpTVqakgESrCRWiQ==
X-CSE-MsgGUID: dKzv9bxbTCKTzmn3Q7CisA==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6142560"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:11:21 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:18814]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.7.127:2525] with esmtp (Farcaster)
 id b6b691d2-4b77-444f-a599-6cc4982a8ecd; Tue, 2 Dec 2025 20:11:21 +0000 (UTC)
X-Farcaster-Flow-ID: b6b691d2-4b77-444f-a599-6cc4982a8ecd
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:21 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:20 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 20:11:20 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [PATCH v2 0/4] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [PATCH v2 0/4] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHcY8fTqK481kxajk6oEKr+4qWoWQ==
Date: Tue, 2 Dec 2025 20:11:20 +0000
Message-ID: <20251202201118.20209-1-bchalios@amazon.es>
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
=0A=
=0A=
Babis Chalios (2):=0A=
  ptp: vmclock: add vm generation counter=0A=
  ptp: vmclock: support device notifications=0A=
=0A=
David Woodhouse (2):=0A=
  dt-bindings: clock: Add device tree bindings for vmclock=0A=
  ptp: ptp_vmclock: Add device tree support=0A=
=0A=
 .../bindings/clock/amazon,vmclock.yaml        |  46 +++++=0A=
 drivers/ptp/ptp_vmclock.c                     | 185 +++++++++++++++++-=0A=
 include/uapi/linux/vmclock-abi.h              |  20 ++=0A=
 3 files changed, 243 insertions(+), 8 deletions(-)=0A=
 create mode 100644 Documentation/devicetree/bindings/clock/amazon,vmclock.=
yaml=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

