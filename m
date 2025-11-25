Return-Path: <netdev+bounces-241555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3804C85CE2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 253EA350916
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66570326942;
	Tue, 25 Nov 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="Ae8fRmK/"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A921A421;
	Tue, 25 Nov 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085149; cv=none; b=Xgi/tGXFs35I7IUiiOa5Gdx3phehILmTJ1ZzrxUbz8/NKjPpfyj4f29Ib0pR+HxwjayJ6cDt9ae9NmK1VaHeDPtn1q8XnclEwxRgqoCwNVk0Fove+tdPTmQSZ39QrBl6B/6tTvT7sGB4cTdCE3MtSRQeo3moUDvuB6FIzjOegrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085149; c=relaxed/simple;
	bh=F3wVitqTdhkt4K5GbPbcMWH0oBFSL/Dt1VzigSgc7uY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCESEnSwEYH4inH3UyMC2Ye3imDs1dBGdfgzFeeCfJIsHHyfhUiKXTxjUEBidn1CVy3uJTRW7ATd9EI8J18ZyY/PJauZ6idjhCaA8T43IdGSU/fdATfd77Q4g9oYlVZuOfchFY6ZoFvEQqbV441h+9JFwI3eGDXigkwX5FZZbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=Ae8fRmK/; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764085147; x=1795621147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=13eTutcxh9lZaMEOjzHKKLA6BF1+kkJovExzbTmDEmA=;
  b=Ae8fRmK/vP/xPAEYs+08LX/WUkUPPLdKmLrC5xBRoZ3ApWRtPbE1L67q
   nyyPNoKIKu6i3rIPnaj9wraT9IBU+vX83sXM9nT95JARA8Gk/KKthCudE
   yX2klEvLDPfrbsxe84V/TpBsJAOlDfwQqw6IXOGeNodIous77A2h5qxb+
   O2+0Yore0GwPG5nRdUq8NOMeUgdn1bvgAhYkB4N+5yPudhrEPX9M5lfoU
   hHzrWEiulWZ38TwlCnDawhhSRm6U5OMUucVWx51+ZOgpwhh0ZJVczVsJh
   axM3r2BeJXz4VBBZlbdFVC6yspnpij4VpB7sDXDcDsnykRHaaCyWA4rnY
   g==;
X-CSE-ConnectionGUID: vo9qeRnqT52s5MS9Gl4hUQ==
X-CSE-MsgGUID: 0h8hazqqQQemVZMF9P0xQw==
X-IronPort-AV: E=Sophos;i="6.20,225,1758585600"; 
   d="scan'208";a="5683316"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 15:38:48 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:18574]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.117:2525] with esmtp (Farcaster)
 id 9d7503b1-dc14-4182-af76-253cba4c6bba; Tue, 25 Nov 2025 15:38:48 +0000 (UTC)
X-Farcaster-Flow-ID: 9d7503b1-dc14-4182-af76-253cba4c6bba
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:43 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 25 Nov 2025 15:38:42 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 25 Nov 2025 15:38:42 +0000
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
Subject: [RFC PATCH 1/2] ptp: vmclock: add vm generation counter
Thread-Topic: [RFC PATCH 1/2] ptp: vmclock: add vm generation counter
Thread-Index: AQHcXiGULOjT2pJ3DUOuKuUixiRsuQ==
Date: Tue, 25 Nov 2025 15:38:42 +0000
Message-ID: <20251125153830.11487-2-bchalios@amazon.es>
References: <20251125153830.11487-1-bchalios@amazon.es>
In-Reply-To: <20251125153830.11487-1-bchalios@amazon.es>
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
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 include/uapi/linux/vmclock-abi.h | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-=
abi.h=0A=
index 2d99b29ac44a..fbf1c5928273 100644=0A=
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
@@ -177,6 +183,19 @@ struct vmclock_abi {=0A=
 	__le64 time_frac_sec;		/* Units of 1/2^64 of a second */=0A=
 	__le64 time_esterror_nanosec;=0A=
 	__le64 time_maxerror_nanosec;=0A=
+=0A=
+	/*=0A=
+	 * This field changes to another non-repeating value when the VM=0A=
+	 * is loaded from a snapshot. This event, typically, represents a=0A=
+	 * "jump" forward in time. As a result, in this case as well, the=0A=
+	 * guest needs to discard any calibrarion against external sources.=0A=
+	 * Loading a snapshot in a VM has different semantics than other VM=0A=
+	 * events such as live migration, i.e. apart from re-adjusting guest=0A=
+	 * clocks a guest user space might want to discard UUIDs, reset=0A=
+	 * network connections or reseed entropy, etc. As a result, we=0A=
+	 * use a dedicated marker for such events.=0A=
+	 */=0A=
+	__le64 vm_generation_counter;=0A=
 };=0A=
 =0A=
 #endif /*  __VMCLOCK_ABI_H__ */=0A=
-- =0A=
2.34.1=0A=
=0A=

