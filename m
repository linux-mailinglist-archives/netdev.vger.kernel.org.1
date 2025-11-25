Return-Path: <netdev+bounces-241554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D756C85CD3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA093B29C8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647C21A421;
	Tue, 25 Nov 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="o/sTPRxh"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3522C0F68;
	Tue, 25 Nov 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085135; cv=none; b=LnwPj6nWWTMyZ8qqPKD9zY75+S3VEMDJFOUa7p+bOIeM5E5tKiX85Hd1r6FjMuABuon9q3xDePWC+mc6eDL83b8l4d2kawCF1sdYejrDL+B24H+zKaOsEdF9Yb9pYzngAnr/MTG6YmZ9DQR4eXNaWxyc8vgx7JHbf5B2zwCHwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085135; c=relaxed/simple;
	bh=/ikvVpsGBVhriT8aSz6qnWHsj4kjQXxXCaB/dwPTXXc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lzSygo/Dx0BTRyrnYN6mLnb/Kpd6tRYdXXCKg/2h9WGCCPLuIR+89KjdjdI8uWzPk8E9BKjshH9twgwGvvFA+cDbPx1zLsy5nm3+yUb4lvaKX1r7a5IMoJpdVuMMaRVlkIJbGSLDQ64RTpfbz4cz6vtrMG7kmLJ9JJ/Knx3Wc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=o/sTPRxh; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764085133; x=1795621133;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tAVd4N0naf/AnARwD+AZviL3qR9xvMYGeSoXJVcJYX8=;
  b=o/sTPRxhgks+1VhQf+ehipct41mulbmgvLU7kNfjFbg9p6j7MCWxBQYy
   qieniHPTvgN203auHERJNLQfbIQHQoXhfo4aPE/7ZRUQ2cmGpktXE6phW
   i5Ed60gJotLMD8jL5MNXmzCbuAONqFnYHLeG1fTm+qdbMvoB4gYsI8DZU
   GPe6jJqUM2syyly+FMWz2+iuljzjZvwGZZyY9w4zZX2O5N1PY99fxBoci
   zWwauYKJZGlOFZFGAmoS2Q6Zr6t3d1Ra0QwLIcHGCXIRxgNt2TnmoeGpq
   ycaK4Xp2FqQxQzSRSPUeUgdWOfve7IrqrwWgE7EVKnkEPn4Frgarr26Zq
   w==;
X-CSE-ConnectionGUID: afbDXzwyRoW29xoP9t+qAw==
X-CSE-MsgGUID: gpg1cOUQTWqrZcfbBwILSA==
X-IronPort-AV: E=Sophos;i="6.20,225,1758585600"; 
   d="scan'208";a="5681698"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 15:38:35 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:21828]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.60:2525] with esmtp (Farcaster)
 id 6b94653b-0561-443d-95d8-321c59f96ecc; Tue, 25 Nov 2025 15:38:34 +0000 (UTC)
X-Farcaster-Flow-ID: 6b94653b-0561-443d-95d8-321c59f96ecc
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:31 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:31 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 25 Nov 2025 15:38:31 +0000
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
Subject: [RFC PATCH 0/2] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Topic: [RFC PATCH 0/2] ptp: vmclock: Add VM generation counter and ACPI
 notification
Thread-Index: AQHcXiGN5TmpWOFD50aX4v9BFCAgDw==
Date: Tue, 25 Nov 2025 15:38:31 +0000
Message-ID: <20251125153830.11487-1-bchalios@amazon.es>
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
Additionally, we attach an ACPI notification to VMClock. Hypervisors=0A=
should execute an ACPI notify operation every time seq_count changes to=0A=
an even number. We implement the poll() interface for VMClock device.=0A=
listeners of poll() will be notified about changes in the ABI every time=0A=
the hypervisor sends us a notification.=0A=
=0A=
Babis Chalios (2):=0A=
  ptp: vmclock: add vm generation counter=0A=
  ptp: vmclock: support device notifications=0A=
=0A=
 drivers/ptp/ptp_vmclock.c        | 85 ++++++++++++++++++++++++++++++--=0A=
 include/uapi/linux/vmclock-abi.h | 19 +++++++=0A=
 2 files changed, 99 insertions(+), 5 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

