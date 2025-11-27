Return-Path: <netdev+bounces-242229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A62C8DC5C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84733AFC6F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62932AABD;
	Thu, 27 Nov 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="RQCkSodI"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE6329E45;
	Thu, 27 Nov 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239554; cv=none; b=iyYsoNRzJZA/g23h5HpL3JPqT0q7dPItIZyiMXWCQt1nhjxNfDW6/O3vk3tYmMZl5wjyCWtxdMLo2g4zMu+jGmHy0IpTJEm88n+K+8KF9PEyEEDfoWd5VZFuO++61hsrizqVIniAsgVp7yXSm9VJ1ZAgPiNHK1wAfrMVYu/loBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239554; c=relaxed/simple;
	bh=g7IsFndKbms56CVsPSbllGYFBT85qqD7dEcsX0qXs40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTfx4SUU5H0Ujt/1Gk9+Cs9QKb8v9FMGKewAUnwpRCjjuAZRAAyvfLMnNBzTKX1Xq2Ph2vdpO8driFuECI3IQ+47gB5ZCABnnALm4sDcrAfk1n1i79gc5nIvTNQqs08yj84ZftMMej+5NOTuvWYbKYBX6un92fBtTHzeLwP7QQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=RQCkSodI; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764239553; x=1795775553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJonkJ6xqSpQHV00BuZdIsvLrs8274Dh2dbeIEwEKKA=;
  b=RQCkSodIy1eRZ1tFj/I74xcw2komNWWMhwFZAhsHs716KzaHki7FqN9v
   fuyP/ad+kfwB//qsV9VsivpLA489Ver0lAoR8Wqhi3Ye97u0+EQnia3e6
   fQx8ZpLIam15DGQWZncYRgzsPMwtRTGnbliMx87wih8gdCcWgQ9ziiiaQ
   09slM3G6J7o//2g0fLRGjAnM3BPwOupCLvcY8mU+ld10jLAY9zBOOjs8K
   O/qSividdHUyhXBh3ytvQt6NHh0p3pcRZii6nC43FFxYl2tQiq6B4qyZe
   oUi4XKrMtvj/k11zNzKgbqEl4cE3jOOW7Z0HWyq2Qh4T+1wnscsjZTago
   w==;
X-CSE-ConnectionGUID: KGHGDfNrQyqkrodz2S0QRg==
X-CSE-MsgGUID: szbImzM/RzeWi0WPYJGG/w==
X-IronPort-AV: E=Sophos;i="6.20,230,1758585600"; 
   d="scan'208";a="5786098"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:32:14 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:5055]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id 3c80d3d6-1abd-4daf-af23-582b068df660; Thu, 27 Nov 2025 10:32:14 +0000 (UTC)
X-Farcaster-Flow-ID: 3c80d3d6-1abd-4daf-af23-582b068df660
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 27 Nov 2025 10:32:13 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 27 Nov 2025 10:32:13 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Thu, 27 Nov 2025 10:32:13 +0000
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
Subject: [PATCH 1/2] ptp: vmclock: add vm generation counter
Thread-Topic: [PATCH 1/2] ptp: vmclock: add vm generation counter
Thread-Index: AQHcX4kY5B7M0REmD0KWvNDREOoHug==
Date: Thu, 27 Nov 2025 10:32:13 +0000
Message-ID: <20251127103159.19816-2-bchalios@amazon.es>
References: <20251127103159.19816-1-bchalios@amazon.es>
In-Reply-To: <20251127103159.19816-1-bchalios@amazon.es>
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

