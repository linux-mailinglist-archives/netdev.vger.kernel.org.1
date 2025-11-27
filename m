Return-Path: <netdev+bounces-242228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C97C8DC4A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799403A3054
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847A3233FA;
	Thu, 27 Nov 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="UzYplAMg"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37629327217;
	Thu, 27 Nov 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239542; cv=none; b=JJF+GCf/8rpqeuePhScK6i+WfOYGWppcOOlheHRMwBD3AvBrzknYo2j3uH0UkRuHlMu9EGU1sRDYcc8IfXgJQNqbVaGMYkDeEVMUFnk2th0PIg40HWrL8epRmZlUo1+3oRU6n3hlO0nw/Cqh79EVxTWYb22NT6lDh2OU29NFzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239542; c=relaxed/simple;
	bh=GuvwizvJYs0kWgM14MdsnOaWZP0RxCNaKjJQvHFDkQg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ufHv+yPdV3z0oWD6r4GdfpDx60mEw7xyXxn6TsWS1/9YagFF2yGCeVi6jDiI9vmwVWSCEk76AfEllpWBRZGp/VY+KzLELIF9FOjycHOgoljSFb++1Cga7TwFlQY9EyGoggwIe+cLYcH69l8ijO1Mm0eUhsNFc2A+ICPt3bd/Z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=UzYplAMg; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764239540; x=1795775540;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WomCTY1UJJoumaWbyccUNUsU0M2GF1QIaS8QGqtnX44=;
  b=UzYplAMgGd8fe2UhdNhWz1LuMMX64VSsS3JGlLscUpfuRCDfRIFptpur
   DHWPon6DKyT8IgXZvd5hVHQArIxP3friEF1E/ElkQZVhcqP1Tc6wG58UC
   PMAUb5LJ1JZnorOS0nVDOgcdCA0b5OMUR5geZEqq5Drj3M29laM6TD/9I
   xwyFBW7+Ffbu/akl8yfTU/k+txWD5F4XD8Id00tQCJUH9Y/VCSB/j17GB
   0X4wkeVd6c4l+T8Ut6zn0rWdAWodMx1hrWpHEjIBhcXXoWvxufOQrvT63
   OX1S3isIVNuBYPqw3Hy933JxzOp1siTzd3uJjJBWER9FcZKMJxXJoAXwT
   w==;
X-CSE-ConnectionGUID: uWTG8I5uTQeXAR4JqZGApw==
X-CSE-MsgGUID: 8W8rmJ63TuWx4KchyoRAWA==
X-IronPort-AV: E=Sophos;i="6.20,230,1758585600"; 
   d="scan'208";a="5884645"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:32:02 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:13792]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id abcd2036-4104-4164-a254-87c02ce3544d; Thu, 27 Nov 2025 10:32:02 +0000 (UTC)
X-Farcaster-Flow-ID: abcd2036-4104-4164-a254-87c02ce3544d
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 27 Nov 2025 10:32:02 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 27 Nov 2025 10:32:01 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Thu, 27 Nov 2025 10:32:01 +0000
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
Subject: [PATCH 0/2] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [PATCH 0/2] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHcX4kRNEV0QVboekqfY2E7oo3q+w==
Date: Thu, 27 Nov 2025 10:32:01 +0000
Message-ID: <20251127103159.19816-1-bchalios@amazon.es>
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
Once we are happy with the semantics and implementation, I will post a=0A=
patchset for QEMU so people can test this.=0A=
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
=0A=
Babis Chalios (2):=0A=
  ptp: vmclock: add vm generation counter=0A=
  ptp: vmclock: support device notifications=0A=
=0A=
 drivers/ptp/ptp_vmclock.c        | 113 +++++++++++++++++++++++++++++--=0A=
 include/uapi/linux/vmclock-abi.h |  20 ++++++=0A=
 2 files changed, 128 insertions(+), 5 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

