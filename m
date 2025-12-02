Return-Path: <netdev+bounces-243313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E126C9CE03
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9532344108
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481622EAD10;
	Tue,  2 Dec 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="om4vsGg5"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994B2765C4;
	Tue,  2 Dec 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706320; cv=none; b=OilStuSXtkkcR2UZiq3gPdyjg8Pi48kQjILShjaGEYU10//MQkIyegokQ1x3276HQ9/1uxAhaopDf3F5cIFlLN7qOkW8+DPDg7y1kxaMiMEHdFXenvAevBJJgLhkwYoJ28ld+DCpb7UOXFpPHQuQzAuIXfhVjoe/3ixLUufqjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706320; c=relaxed/simple;
	bh=g7IsFndKbms56CVsPSbllGYFBT85qqD7dEcsX0qXs40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNsLy6R49ObPxCT6Eq6jJ3Hhq35VqMtE78L1gKls5ZYx179BSkBSwRYqTwLqLuvR4MKSw5eOLi3KbemfyEZfkzCYFhpOKVhxcMke7SUsTb9//aGnUAlPO+xXssR0Al6hM/Le28s6ykzLw2YDJEugiezunKBw1VtKExd85ZM9Khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=om4vsGg5; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764706318; x=1796242318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJonkJ6xqSpQHV00BuZdIsvLrs8274Dh2dbeIEwEKKA=;
  b=om4vsGg5X5YxtdszApm7HrrL3WY5sbDMGeQHpUQxHFUZJBC4qsoQBupi
   WHqecWTly0Pl6A1XzBJieM08rURhZeakC6PF2Mjl4y5vbHAEWwHdDyMXX
   pYbGkZ4RQMKy93ObAZAOYV6ksOVsS5D25XBxHg97xeYNTOEL27zjCl9pH
   4Z+Yd5KTF9r/Td/gTJAkMUS+ZytBBSUfPNmAWTfo8+UPAp2FR6rCzS5gh
   qR5+f6l7puDw0rXsg60ivnkwnfvNWup2mrdOU3zvU3B25+Wu4lJV4k66l
   mchUAyZASdEjcKo0ACKreJo7Ki2qYb4WKm079WeDOMalj1h0W7Vve1M89
   g==;
X-CSE-ConnectionGUID: TlGgzM47QmG9ExDtie/71g==
X-CSE-MsgGUID: i87N4NA4RJmwj19MVrnKBg==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6144503"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:11:40 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:16772]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.117:2525] with esmtp (Farcaster)
 id a9dafb6a-c1c9-4ba0-a802-78cfe575a742; Tue, 2 Dec 2025 20:11:39 +0000 (UTC)
X-Farcaster-Flow-ID: a9dafb6a-c1c9-4ba0-a802-78cfe575a742
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:32 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:32 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 20:11:32 +0000
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
Subject: [PATCH v2 1/4] ptp: vmclock: add vm generation counter
Thread-Topic: [PATCH v2 1/4] ptp: vmclock: add vm generation counter
Thread-Index: AQHcY8faxhjiyz2mPkiGjW1j83OATw==
Date: Tue, 2 Dec 2025 20:11:32 +0000
Message-ID: <20251202201118.20209-2-bchalios@amazon.es>
References: <20251202201118.20209-1-bchalios@amazon.es>
In-Reply-To: <20251202201118.20209-1-bchalios@amazon.es>
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

