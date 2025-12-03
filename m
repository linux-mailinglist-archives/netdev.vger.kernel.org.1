Return-Path: <netdev+bounces-243399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E05A2C9F00A
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56481348BBE
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE92F60CD;
	Wed,  3 Dec 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="VlDn4dP6"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DE2F49F9;
	Wed,  3 Dec 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765374; cv=none; b=IrEdWpLpnm0wBwNwBzHRnyXaitGDCKarcXFRPV5P6mi536LUClT8QyXyfQnnAA+c9ZcC5IB8ew6ZZidX7crb7wLIX3wHU67bCfN/7VB5nmxj0y6zlt5whUTUXb3E5TelqbZ5uFfDRPbb2vy6trj8xNrReSXRozw8xwKkhla1O6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765374; c=relaxed/simple;
	bh=24QXbSneUzkowcWpwm9+vQdjcysKLhyGO8cCmRSRb/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogt5DqHXeR0fbe+KPl2hH1nPi2dwn/JsiO1OK/RsNxqFiApQHXe0QjKxQWc1R/FU+I2H4enBZAF0YKZk3i+7StBUa/c4C7Cse5yyHHZNAYVaGmHIPme8uMBmtuLD6R9Dcu0+XjKFyo6QlpsYDxDeAmY5SfgWxPD6ZZL7DgKE5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=VlDn4dP6; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764765372; x=1796301372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5n7SWL5neiOSbmPOaJ0lN43zpKObLVtzFVxXfMFpyiI=;
  b=VlDn4dP6ytwDoMbubPD4EHwjLXZttqNDRtdwz2xZOKUaCQMMUBTOE26I
   5Tbihnzi0rGJ8VJnkfsvwXS7J0hrYkG/51TMN8xWIEgIIeBZBxeYtXIls
   EcLUbg6HFyAp1IoWHj73IjXxajGgpLfmfO/x9jPBI8dtmf2gKDCoeEJyS
   pF47U9USyDYJjvlVumaESJCfgtBNNfUmtMIDOCEMcaP4lcX8uoFxY4Ds4
   GHZhm9odA1Vtu8xt0+sfKCY5A2jXXHV84FWxwF1HwHKul0z7RPOW3PY1y
   rJK/zHd9qWtlcUph3Bogw1c4/QhWTbc+tXMNaBFUBN11ekpd7IL1EB5D8
   g==;
X-CSE-ConnectionGUID: FxbX3hBdQPei6ZhxrXBEjw==
X-CSE-MsgGUID: 2HMezhNnSFStXLr2gruI9g==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="6171979"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 12:35:53 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:16401]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.7.127:2525] with esmtp (Farcaster)
 id cba6b1a3-e02a-4661-b065-2e1e6cc1716e; Wed, 3 Dec 2025 12:35:53 +0000 (UTC)
X-Farcaster-Flow-ID: cba6b1a3-e02a-4661-b065-2e1e6cc1716e
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:35:52 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:35:52 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Wed, 3 Dec 2025 12:35:52 +0000
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
	<xmarcalx@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: [PATCH v3 1/4] ptp: vmclock: add vm generation counter
Thread-Topic: [PATCH v3 1/4] ptp: vmclock: add vm generation counter
Thread-Index: AQHcZFFc6jG+Jh7X8kSNL2GOx/oy9g==
Date: Wed, 3 Dec 2025 12:35:52 +0000
Message-ID: <20251203123539.7292-2-bchalios@amazon.es>
References: <20251203123539.7292-1-bchalios@amazon.es>
In-Reply-To: <20251203123539.7292-1-bchalios@amazon.es>
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

From: "Chalios, Babis" <bchalios@amazon.es>=0A=
=0A=
Similar to live migration, loading a VM from some saved state (aka=0A=
snapshot) is also an event that calls for clock adjustments in the=0A=
guest. However, guests might want to take more actions as a response to=0A=
such events, e.g. as discarding UUIDs, resetting network connections,=0A=
reseeding entropy pools, etc. These are actions that guests don't=0A=
typically take during live migration, so add a new field in the=0A=
vmclock_abi called vm_generation_counter which informs the guest about=0A=
such events.=0A=
=0A=
Hypervisor advertises support for vm_generation_counter through the=0A=
VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT flag. Users need to check the=0A=
presence of this bit in vmclock_abi flags field before using this flag.=0A=
=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
---=0A=
 include/uapi/linux/vmclock-abi.h | 15 +++++++++++++++=0A=
 1 file changed, 15 insertions(+)=0A=
=0A=
diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-=
abi.h=0A=
index 2d99b29ac44a..937fe00e4f33 100644=0A=
--- a/include/uapi/linux/vmclock-abi.h=0A=
+++ b/include/uapi/linux/vmclock-abi.h=0A=
@@ -115,6 +115,12 @@ struct vmclock_abi {=0A=
 	 * bit again after the update, using the about-to-be-valid fields.=0A=
 	 */=0A=
 #define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)=0A=
+	/*=0A=
+	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will=0A=
+	 * bump the vm_generation_counter field every time the guest is=0A=
+	 * loaded from some save state (restored from a snapshot).=0A=
+	 */=0A=
+#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)=0A=
 =0A=
 	__u8 pad[2];=0A=
 	__u8 clock_status;=0A=
@@ -177,6 +183,15 @@ struct vmclock_abi {=0A=
 	__le64 time_frac_sec;		/* Units of 1/2^64 of a second */=0A=
 	__le64 time_esterror_nanosec;=0A=
 	__le64 time_maxerror_nanosec;=0A=
+=0A=
+	/*=0A=
+	 * This field changes to another non-repeating value when the guest=0A=
+	 * has been loaded from a snapshot. In addition to handling a=0A=
+	 * disruption in time (which will also be signalled through the=0A=
+	 * disruption_marker field), a guest may wish to discard UUIDs,=0A=
+	 * reset network connections, reseed entropy, etc.=0A=
+	 */=0A=
+	__le64 vm_generation_counter;=0A=
 };=0A=
 =0A=
 #endif /*  __VMCLOCK_ABI_H__ */=0A=
-- =0A=
2.34.1=0A=
=0A=

