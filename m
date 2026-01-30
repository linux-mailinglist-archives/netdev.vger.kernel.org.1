Return-Path: <netdev+bounces-255207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD5nG8HtfGmdPQIAu9opvQ
	(envelope-from <netdev+bounces-255207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1DBD672
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D89813056747
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A231A371053;
	Fri, 30 Jan 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iDZV2BOm"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F437D11D;
	Fri, 30 Jan 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794669; cv=none; b=F3VGZ6RlKegbUqHSyC4efTZVpfHWwkiSKxjcawZwGa3ngZcj56h/1AWOla9LlctGFAH12buCX3kqH0X0Mpg4GNZR90s180IhCmf2QzNpSmeXY3NnZR8ma1+7HmCQc1Jqxj6nPETmuaYlOQG4ANPjSL9JpDWdT3DE928CijrYlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794669; c=relaxed/simple;
	bh=APd8pzB5cGdSC+pgQ/q+8mHi7+R97VBwnJXA2a1YMJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3qp/JqxKM3NIP0uSosinw45jo8tavf5r615fSPnezB/u4A6v1o5aycS5IKlEkcqOp8nAwntzGReeb1ahuJfjRHLWJ1toBAiV8379QG/E7uCAnZ7nuFD+eSvbfyV0WpRQ88sM+DWZTUHbx8bbCS/PtNJO9G/kbF+r0bsP93zS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iDZV2BOm; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794667; x=1801330667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j7/ky8lgzP8J1iGcrsTGKcQFpgFnFWEGcw/I+sapgZc=;
  b=iDZV2BOmj5+Gtq4ES7BdG8HzVfEur0zxnrSGmAadj8DYwTogV0I5U8mR
   pn4zKidWnTD2k9L4brhgCkoTYXX2s9/CR0ET61z9wDEZwTkeVLEABRVgC
   aGCxcJlnx/yZVHj2iMbYm07b6gjc4iFpdOB30Sw+bPezD9uyJ319xOoAa
   l59rNIVfEpY/y0vpHo12QMVadjstPLLFLQsVVPbVObzj+a7tFJiblGDBc
   3nj0a4bqcFEYWdZ1Wb5sdY3xEWvQD6AbPX2seJIO3d84QOJ1+pM4tg4mN
   Id1tBjad9bOF6btZCQ5jFn7GSwfZ8Mi03masMBSZPCZZ81EquVdmRA7TS
   A==;
X-CSE-ConnectionGUID: Qu+AwT3DR+CxUosSuivkHw==
X-CSE-MsgGUID: oORUnnsFQPqWXyuVEIP2MA==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11815388"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:19909]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.174:2525] with esmtp (Farcaster)
 id a0a18a15-5f0a-4181-95d8-6977bcce1a0f; Fri, 30 Jan 2026 17:37:44 +0000 (UTC)
X-Farcaster-Flow-ID: a0a18a15-5f0a-4181-95d8-6977bcce1a0f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:43 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:40 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
Date: Fri, 30 Jan 2026 17:36:04 +0000
Message-ID: <20260130173704.12575-6-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255207-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazon.co.uk:email,amazon.es:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EB1DBD672
X-Rspamd-Action: no action

From: David Woodhouse <dwmw@amazon.co.uk>

As we finalised the spec, we spotted that vmgenid actually says that the
_HID is supposed to be hypervisor-specific. Although in the 13 years
since the original vmgenid doc was published, nobody seems to have cared
about using _HID to distinguish between implementations on different
hypervisors, and we only ever use the _CID.

For consistency, match the _CID of "VMCLOCK" too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
---
 drivers/ptp/ptp_vmclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 619c8e5a9..2a173bd28 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -763,6 +763,7 @@ static int vmclock_probe(struct platform_device *pdev)
 
 static const struct acpi_device_id vmclock_acpi_ids[] = {
 	{ "AMZNC10C", 0 },
+	{ "VMCLOCK", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
-- 
2.50.1


