Return-Path: <netdev+bounces-245360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED3CCC47B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6B0306B6AE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC91295DBD;
	Thu, 18 Dec 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="kc2S88A4"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D6274FE8;
	Thu, 18 Dec 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067883; cv=none; b=a/3fDJ3IqXCYWXfXq4kLNkh34M6ne01FkGSROsxyVaQhKpRs/r8UDPkKx4jJpmsnJP4h+NHdOCh3+wOv7HppmdWeXPhYzF6AbTTYVXmE3GXWGCoZc8i6Seg7ep4Qkc9ohZRebMoUnCACDVoqM3rVHm2UlqEjxXeHgaxBd8HPBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067883; c=relaxed/simple;
	bh=K9PWfOsr2URHViwINyOwCX3J3UQ1Ltgw6a13juuLadA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE3kMAuH/JdSE9Yacsm/jS0+XYKaq5SmyRhwuU6CSMajy+ETZY154IFB+SgQG8FPhXwyxe5INFpGVTOpXEL6yV88j7O9JZMPU06d8ka6gP1miecRcAlUCcgS1ECHraX+B/lvoAf+p1EOqdPF931ylqE6iN0m/x/nxQm1oHlGXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=kc2S88A4; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067881; x=1797603881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKrltbaD/Drhq8kMDPgbTPux36kEXGe0gvAIL/BeBmI=;
  b=kc2S88A4zrIGLuEh8fb3W3ZFtSEE6FzK8lY6Em8EoLzKfFEJop/iml2c
   2P4h/pCX3aauB8bz58soIb7+7XmuZW/SYDjfFUVoc35uRkws4qfKqp/Tz
   RTcNzL9jKgSGUrw4o1sEDoYMje5U5rK1XFpfr3BzAUohUsMlnqRp1f0lm
   X4z+60LrPR/23ABfxf3NjZ0My0pTHRlj99esEPU/QFgH9qc8XNY0jdoXg
   vAETpkGVAn/l00p9nxBXHB12yD/WYNBsx1Dd6tvTdWCpFT1dULkhMS2O1
   Tb3MGXmhH95Ydy0YEFtJi/FMbULJ9TicEyas3tkRe2MDQIKsJax4IYCnt
   A==;
X-CSE-ConnectionGUID: v/ySFvy/QBq0lzqgpmQLMA==
X-CSE-MsgGUID: VXlcMyENRS6EuyaQK4cZAA==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6787979"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:24:22 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:15173]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.12.153:2525] with esmtp (Farcaster)
 id b8e9a253-10d9-4617-9a75-3cd1f6a0b577; Thu, 18 Dec 2025 14:24:22 +0000 (UTC)
X-Farcaster-Flow-ID: b8e9a253-10d9-4617-9a75-3cd1f6a0b577
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:24:21 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:24:21 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:24:21 +0000
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
Subject: [PATCH v4 1/7] ptp: vmclock: add vm generation counter
Thread-Topic: [PATCH v4 1/7] ptp: vmclock: add vm generation counter
Thread-Index: AQHccCoA8Zlu7ja/r0auHBzyScVYrg==
Date: Thu, 18 Dec 2025 14:24:21 +0000
Message-ID: <20251218142408.8395-2-bchalios@amazon.es>
References: <20251218142408.8395-1-bchalios@amazon.es>
In-Reply-To: <20251218142408.8395-1-bchalios@amazon.es>
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

