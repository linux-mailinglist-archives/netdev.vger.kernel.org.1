Return-Path: <netdev+bounces-232417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4DC05A37
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682D03B8249
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466430FC17;
	Fri, 24 Oct 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="KXFAd/m6";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="Txpvzlxn"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay12-hz2-if1.hornetsecurity.com (mx-relay12-hz2-if1.hornetsecurity.com [94.100.137.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A030F939
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302106; cv=fail; b=BlQKu8h4G0aMP6QNso8HvTB5V6W0L03Nsu1A8Ot81OVDyiHDw4ixjOwEmJT+ItK33jzNtPa3cU17OkqAlV/434VMcwfazlnkGi8jlVL3/p3pNsEFgzg2Ks73fJszERUoI2sxnQTe8pYItdzZ2IvCBrgWpwoTK4jizpabHLWDYkU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302106; c=relaxed/simple;
	bh=1mxoY06HSAr560ID8TPxF/NTwzZnojq4V6B/SB6uIEA=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=qOrUIZEVEjRTU7WRcsGF3naUHSynThdl1TXMmfEy/NNwHuQWgGEQNIA8tyo7gk7XY9TpmPPKDOESnesHr2qvXUkkgcR1ZF9vQmE/cWecvFkSWt8thQRCRp1XsPhQz7Jhz2EG6MVjkWOBsDljKbZxLUis2HtGfUP6WGjerOlBRuw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=KXFAd/m6 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=Txpvzlxn; arc=fail smtp.client-ip=94.100.137.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate12-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=Ce2L3zJG4Q3NzMzohKiwhOWxenthoToB/zNgKRw+zg0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761302054;
 b=KT1lflLfi+jcQdmNOfIZHnCoWv/p1LfXmPwZY4X83vO7MydnB+6flZaqzOqxXgyYV1ueIGY9
 USGVGBbUDUfjgubF8GkXm9cgHj9Es+earHQTsbEQFVug1mHSpR9yf7rD+QdM1k1etHTkoYTfF0C
 zoLTqmjO3LcgwGHekXl/1xuL49XTWY3fqyVvLIDGTYMWoWyGzgRNTbei1kn0S3KYhGyxeNgvT8R
 cqLEQcIlyDBz112xkdkzpK015h6FlcS/yQRYjayajhDYpi7SMVtbQO/lE8wikIMkhgSK6YARMKg
 Xc4IeuTiq//wmG1GTL/B+Omd+4qgAZ4aGsWeBF85Nyk4Q==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761302054;
 b=H/uloJJRDCLVnolBBvR70+4aY4nIiIvglY9lixYfokLM4z4SLT0P64EZHGEpBcWMHCJVXYpl
 x1o+oTfOKDBKzkuC3wTiWXTTomQbkcMnqRth449tFMJdCQrTU8rvwWsy2WT4FM/8StNyWowq3tT
 JA2mkCesHV/FovKKbvLXjNMtfXJPFCFGCTYj1vmtO5+c6UiqCc4zJgGBhcMJe3J0UsXttn6igZu
 JUWt8Pra4UqaXBXvk+KYIEEVFRrFA07wyQAemEURMZV2L7xWRfTCi4GJHhGWzwU7+KkTWVTP7BH
 UAhFhTqKWj+ebo9O/GXmz1herARjXj5L7VJmE0V1SDI2A==
Received: from mail-westeuropeazon11023102.outbound.protection.outlook.com ([52.101.72.102]) by mx-relay12-hz2.antispameurope.com;
 Fri, 24 Oct 2025 12:34:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOnrljljcOiBNSFcwo0mHM/NLnK/UY4ZsJy0Zpr3IOqA82hq5hYdB8XqByt1KCwUGdyQbZ/ukKSLgpnQWF+Kz4k14VGeetmKWWwtlc2BI5BS9XlSSI0UM3mjLpK2mGyHygPA44mlkpcTHKztjB82wh/dG1H/P2s00CAazlZL7OzDKOUR3A2w5be6Q6JUhXeEtHfXDBqzP6M1QLNmv1EGR1qqtzYURbwmaXf2X3UfsSpfrX7iuJPLKOVLRqr5Y8WydYMO885UaTMpKWIDzqympCcj6WjwHJEEFt85b+BUDAGE4r1TtZyL/SmcW5JCR81zziTNAXZ9zmpE09yP0DJX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ5j/PPjs6XgAEUPjLn29vZtjJ2doEae3GJ0I2U62Uk=;
 b=fDBBcQOB3DMyzRuFagy/M8xMnQQrryLadTEEpBKu5MOL5V8y2akAdXoRf3jcng3WX+X/RogpEeRDAPqu/M4r77hYed1S7httIICAt8kOZdsE/+dmaF/UdZ1z8oa8wf+f7kaXlFhqPMdVF2Z62r10kSXtCqLbEXYLpXBFNXSghAjRQAQv1dXeOyFsG8E9fwo7M2se6xdxfERZj09FFfc81lOh2IZO4pK7o5i0mha7DTPE1LTR8o9Pl5qmfw3dM9e19MasTmaQN3bo9J/aJQvMaluAOfSRanO97bn2o9gNFkHKVkHkSo9rmxN4CKiqR8LZ5cwwyAihhoWIGB/cLA4huA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ5j/PPjs6XgAEUPjLn29vZtjJ2doEae3GJ0I2U62Uk=;
 b=KXFAd/m67XplzGivvbmyLJ+gk8d9yeT72V/O1lpq5NJLblUyncsGFT0Py2uudyuu2AFTumn1aGGaIYM6Pqir3uxYG1VWg60DQ/hmWNZZb5QAHEA/B4FL+8j7g8qRyHoKB3oqrRF6LdT8JaA9ETCg8QxmI9PaxaqAgHn+oZk2Z1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by PAWPR10MB7789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:34:02 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:34:02 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: [PATCH ethtool v3 0/2] fix module info JSON output
Date: Fri, 24 Oct 2025 12:32:50 +0200
Message-Id: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJV+2gC/4XNPQ7CMAwF4KtUmTGK3Z+oTNwDMbTEoUElQQlEo
 Kp3J+0EA2J89vPnSUQOlqPYFZMInGy03uVQbgpxGjp3ZrA6Z0GSapSEYOwTrl4/xrxxxsMlege
 yogqlUgoNi3x6C5x7K3s45jzYePfhtX5JuEz/gAlBgkTdYI+tKk2z74B7DiNvNYuFTPTJ0A+GM
 qPRqL7UxKpuv5l5nt9t+SFiAQEAAA==
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761302040; l=2020;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=ebr8BH/fN3AmB2Bzyex1QxDxlMn9HJ/GeYb91ou5wFQ=;
 b=GGgdVbx1095/Oz+TI5XuTM/ppCD8cC1vXxG5n5W643vy7w45Z1gRY4TVet1RTdiXMZqP0+m5M
 O8OFujbWDo7CzpNwGDsQJRR/4+1x6kqIATJsa8Ao7JpfLhTjlTuX7uN
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|PAWPR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: ad284277-dbe1-4d50-e24d-08de12e8d961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUZpRVBDSTNaV0pzUVN4d1dCeHc1dlZoTXA5czdOMEJvemM4SzRuclptK1Ew?=
 =?utf-8?B?YnNHc0MvRUpiZnorZ0tObnJBWGpTUnZXc0J5R1ZYVDdGMHFidTJ2VGprZGQ4?=
 =?utf-8?B?STNkbVgraWp6VFBEUVhuL3dTUzEzZk51ZmVIN3dMNzl5WWRuVTlxZjZ1TnZT?=
 =?utf-8?B?cGVDdkFURFJoTmZ1MDV1b2FyRE1vVGFNTDBsQXFzUzI5UVhmdUdNZ1JkK1RY?=
 =?utf-8?B?QmJMWS80ckN2T2NETHpucklJaDdEalA5dmdhQjdMcGlucURBU2J0dS9LSGtp?=
 =?utf-8?B?NGh3RGJLcHRDZ2FMdndzalBnUlBjSUlZc1JMZ2JPSUkzNElOSzJXSGVjZE9Q?=
 =?utf-8?B?Rk4rUlYrQU13RlhLK0pkdnBzU0QvZ1dpdmwxUlFnNk9KMlFka3RsOVZRUGVJ?=
 =?utf-8?B?ZXRXOVpNclpnTVlWa0JJRWFtZ25YSFpYMjNiQUxDd1Q2WmVjMzlVbWIxbUdk?=
 =?utf-8?B?Z1B4K3QxRjFOUGgwRTZNZEN6R0tRemVzTmljbTRUeXNJVDNEalV2U1NtRkhQ?=
 =?utf-8?B?aU90bm9xb0NUV0FEcWVocUpCTi84WGZZVkIrR3EvNlR4YTBZNzc0YmtTcldY?=
 =?utf-8?B?VHZYNjVlTnFpMkptMURidjJEb3c4RWtPWC9JSlY2T2lWRjc3eWFBZSt6Y1E2?=
 =?utf-8?B?MFpaWi94OTlFWnNpalVvQkw5a3pVTlhhdm1LcVBYVDBIQ1UyeTNwdDJqUGNS?=
 =?utf-8?B?ZmdpdzFOamRQcHYyeU82VVpWN2xaclUwQVYwTVpqWlExVEc3aHZnbWV2U3Vh?=
 =?utf-8?B?QXd5ZDZ3UzhwMFpNV2xVcVZkSEJLYkFuUngwNjdUb1ZqRzhJRkYwZ0hiOVVq?=
 =?utf-8?B?Wnd0NVdvcHFMOFF3Qm8vMG1rUkgrY1pRMWtTQXJMbUlWUEVGVnA2RUlLVVht?=
 =?utf-8?B?RkxTcUVJcGRrNnBHbkxXWktUdTlQeVFxT0F1MzkyQWJzVE13U0pqNmVLaHBS?=
 =?utf-8?B?RFpwa29BQm5PVU91eFdSWmZjVG9zVVkxaTJUQ2JxYVR3YWtsck0zWlN0YW1n?=
 =?utf-8?B?NHgwcjhFWW5pVktkd0V4NmFZWWNnYmhUR1RQUWJzOGZEYWZFZHFzcTQzdXpU?=
 =?utf-8?B?MGV6c1JQTmczOWFJMjArRFZma29rWHV5emFjU2RmR3NwajhiR01ibGY5M0ty?=
 =?utf-8?B?eWtBUkdhclQzb01YTjZoT1pJVjZBRmdKV1ZFSlJRQjV5aXJjcnhINHRUVjFP?=
 =?utf-8?B?QmY0WWZxZXhjMFhFcE5RSkZGa2tTWWI5dmFubGE3eG5IaXFPa3F0R1A1L1Zp?=
 =?utf-8?B?K3BFWjExL1EvWndyOVgxcGJod2hqZldlTC96RE1rVENFRUI5bEsweVZYQkxU?=
 =?utf-8?B?VWgzaXBxTG9XNnlhTEFFbDdDeHRnamliNFNhNEhUdXI0OXp2YkZCTXJzL3oz?=
 =?utf-8?B?UTJsYTM4V0RvY2RYeGoxMERHNC9TOW92OFpHQlFOU1I3MFNyNE1TaVBJYlRw?=
 =?utf-8?B?aTdLRlJkSVQvL3NkZVE0MTBMZmFYTkpBNHNwd1llb2pwNzBFR1NCSnZkTXJQ?=
 =?utf-8?B?VzZQeFFvMlNudnFxdklOUEV5em5qemJNZGVzZ0NTa0hPYmJoekp1K3FwUGsx?=
 =?utf-8?B?TTBOUnphL3N3UjEzbDd4WXFoWHhqNEp6bzlMV3Jsc2REaURlODFHMTN1ZWps?=
 =?utf-8?B?WGNuVWZpa3hpSG1LTmc1TkdhVU1ab3JpR250NWFZQ0gycUZ6TWp3bHZva2t0?=
 =?utf-8?B?aEM2T0xlTHRwMm9TaW5uSWladU9WUmo3OWtyTzYyalJNc01qbnhYVCtlZmxV?=
 =?utf-8?B?RHBLL2J2ZThrMmNTN0g1cjc4NnEwTStkN0Q4cHcvZDlhVGhjVDl0YWZGL2pi?=
 =?utf-8?B?VFNhOUpYV1d1VGo1bTRWL3NYNk43dHkvNFUzd3h6cnhKSEl2NXNoMzlLMWZP?=
 =?utf-8?B?Ti8vS05rZ1hnVzRMZmpVbVA2NFBkRC92NUVMSThQaUhsK0t1MThEYVlVYTQv?=
 =?utf-8?B?UmZOaWZDQUNCam12YWcya0Vmd1BKc01ObnFrcjRFSy9UeHdub0FsbWt1ZFY3?=
 =?utf-8?B?T3d0SEpUaGFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjM4c2x5dks5MWJFcnhqVHk0SUozWTJLak1WdHl5bWVKM1Boaml3aE5aS2Vj?=
 =?utf-8?B?d0VnWnpRV2FIdUt1SmJhVUJrVzdyMTh4L3NYdnlzRTNPODNwVVhLcC9NY21n?=
 =?utf-8?B?cTVDbnhFZDVDWFIrSXU2ZVFTTDlkL0FETElrc2YzVmJlbUlveWJoQkphSVpE?=
 =?utf-8?B?RmpqZFcvaHN1M0Q5dEg5ZEkxN2xmeWZyay9ObGRNeEZ6TUZnM1ZhUHlPREZp?=
 =?utf-8?B?WmdUWGYrSXliNzVDRUdBVm1mdUtyZklWeE1rdTVVUStZSmRTKzBLTmUwYXlL?=
 =?utf-8?B?N1hSOXZGbDFjODNoS0ZBeDdnVC8xUEtEWFBvWlQvaXVOOWpJU0RPWWQ5Q21L?=
 =?utf-8?B?YjFaNzFCdXZTVFVVS3lLTkl6Y2NMWHR3R05hcjZ4VDhnK2FOZ3VYRWowR2gy?=
 =?utf-8?B?RUJ6d3Rrc0pGZlE1c2FtZmt1d2dZdnJ5dVpoZHM1VHlIbDdERytzZnROa2tI?=
 =?utf-8?B?aEtHbXpyanUwNDRyaUtGMmE4d0ZSS2gzMXo2UXc1amhCdHFuZC9keUZud2hi?=
 =?utf-8?B?QnlrZUdFUE5ucnZoZmlsZW1Vek9qRGxxOXc4WERxOUdtK3FzOCtzdjZ3RHhq?=
 =?utf-8?B?OUJZbjRBQjRUL2NRL1dHUnUrU3VUYXgrRXlzWUM4Ly9yRElweWZGYnQ1WXp5?=
 =?utf-8?B?SDduZmRsNFdNaXRNRE9JSFEyV29PMWIvRXNIMWhIeTBaUXBPdjJyL2ZNVWVl?=
 =?utf-8?B?WUpyUGxsOHpGdkVqNjc5cGQrQ2FzN1N0bHJ5Yy9zQUlYczhXclVRZWt4T3BJ?=
 =?utf-8?B?aVNDQW94eVdyeER4TkZUZ0NZUm51Ulpha01EZjZBOThvVXZ1cktFTHdtRXUv?=
 =?utf-8?B?UG5xbjhsblhCWWxyK0xNQ2JXVVZTTnY1Y1BmVHFvdnQ5Q0Fsc0QxeU94U1lz?=
 =?utf-8?B?OC91V1I2NHg0ZWphb0VQZE5LUnMrOVlTaktNWnRHWENHSTZnQmJmVnRSRG1s?=
 =?utf-8?B?SlpPcG10MThkbG9HTGpnaGxqZTFIN0l4RHRwbjRDcGx6WDh6L3Z1aGx3U3g1?=
 =?utf-8?B?ZVlyVUZXaE0xNmtzUnFtdnU1TFVLUzVmU0x3bnpvSlA0cms0TGlNYUdkdFhC?=
 =?utf-8?B?WWtyaG1XbVFnMVh6ZmJMMExENEV4dVV1eWliM3FGeXlWQ0lGNE44VXpLSXla?=
 =?utf-8?B?UFJPZ2w3eGhnbVJqSitGUEZBQXpTeE54d2RvNXdJcUtEUUpGaUlnazk5dXR3?=
 =?utf-8?B?RUFkSEh2b3NCcndRNVBsZk9DKysyZElBYUNrZWxSNDJuQ0tqMkpmSjczaU4z?=
 =?utf-8?B?bmpLcTIyZlJGWFc0dkVLU3h4WEt3eXJjaEh2WkFsS3IrbzlzNzFEalEvVE5U?=
 =?utf-8?B?YTJmUk1yam9nU0xxWTZjdlRheU9NWGVIald3UkhYUS9xTVFwT0RjcklWbGlv?=
 =?utf-8?B?elRYczBPMGs5YU05TFltL0J6cEJ2SUUyLzFTU2Jzc3RzbTR0UCtIak5zdzZz?=
 =?utf-8?B?b1N5bnBhb3lxNTk0d0dNYWxjU2FiamVtZGJZSm1MOGJYWkNGbVRVL3h0QjVU?=
 =?utf-8?B?cm4wOUNZVGpvclpSeXF3UFQ1M1JTNzlUbzJFSndiVnpDdTNQVUY3K1B2VjNL?=
 =?utf-8?B?dnZROUM4ZjNkUU13SnpKMEE5bWxwaEpqTVVPZk5sbDFGZkt1a1dKMmpKWU5m?=
 =?utf-8?B?eVpTM29lakJybkZXYk10ekg3ajNLMlN2VSswbllJL052QWFnbGp1Z0hPdUNQ?=
 =?utf-8?B?OThhZkZOK3djYW9pa3ZLWlBFaDRnVXorU3lTcitNN1JBSmhDSmVTOTRLcHNn?=
 =?utf-8?B?cld3RTZEVjlaMnZKTnVDV0VHM0U2ekxUM1FXemp2aDhmalNTT3ZXT1BqaWZv?=
 =?utf-8?B?N0d6aDkySktDRC9RTzQrTEZxQU9nSC93eWZHZU9qSm9lVnJXTmE3UUQ0RDA0?=
 =?utf-8?B?bFh1SEgwVlRXUTdsNW5vRndzWkxYbUFBSS9DNHFjUWZ2RlI2c1g4OFBPNmFP?=
 =?utf-8?B?RU9Xb2tJMEhZUWhITDQ0VlRSYnUxOEtPOW1JWVhOUUtnbHN0cnc3ZldLUUtD?=
 =?utf-8?B?RzVicjRoNnBmSTBUMnJTdDRSRXNVNDVRdUxsVEJONThGN1I1RVJOaHRtSXpT?=
 =?utf-8?B?RGZqaTNrSUJvUDVDTkVGSlRRWTAvcWc4bGdHRkIrejc0TXlQcFVScHJqQm1E?=
 =?utf-8?B?ano1ZFM1ZkNBTkVkMm4yYmU0MTZXNnpENTZHMVhXRUhoSm12c2V5N2liSUxM?=
 =?utf-8?B?SHF1cW96d3pCVFJaZG15dlkxYitlbXhxd1NXbzhWcWVSeStFaG5OcTJMSnV3?=
 =?utf-8?B?Qk5sQkNla0g4eFFLYm0wa1BQSkd3PT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad284277-dbe1-4d50-e24d-08de12e8d961
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:34:02.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLlaDZ6Qtagw6ZRcjIjau/4564AR1XcF+9A1uXg4sFhsw462t4x/tDgvQ6D5UPgRkRXhMCpmKpjGvhI8QHsJ6bjWK4mPoqPuwgYFwhHmLJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7789
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----10EA76CE49A48059EFFDA87C776FB554"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay12-hz2.antispameurope.com with 4ctK581sbQz3B3kT
X-cloud-security-connect: mail-westeuropeazon11023102.outbound.protection.outlook.com[52.101.72.102], TLS=1, IP=52.101.72.102
X-cloud-security-Digest:2b34d2ac51f169f3d7e4be3d4281da1d
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.740
DKIM-Signature: a=rsa-sha256;
 bh=Ce2L3zJG4Q3NzMzohKiwhOWxenthoToB/zNgKRw+zg0=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761302054; v=1;
 b=TxpvzlxnDLqfizmJS1hoMthbfHu8YK9Rm2FDE67v4qp/BvbeA3XBhA+WTF71e7QYiskWRpV2
 ZPlMfG66GUZKDL6k5QbypyILL6uWwVb7xaVQvRct7GmBIaoPac25roQaIaKkC3aar2sxeu+WN4I
 Gr7u4MkjA7rFfVSjsa72gh27BOM+VId7nbv2xA8DcqdB9Kh4c+uC6Snh4NNMj/X1MH/WMYZtV1D
 A4IBrNx3JE94LkXN0qCRoLzUlzsskx6RKgfdqaCJfMH4XizouNiPAMbGp49PBdbpKC0ttwV1JjU
 WiEnyDZWgnmjqA+V+S72Nng7xAVGHAKqN+zOrbx9KEqCw==

This is an S/MIME signed message

------10EA76CE49A48059EFFDA87C776FB554
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v3 0/2] fix module info JSON output
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Fri, 24 Oct 2025 12:32:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In one of our products we need to show the SFP diagnostics in a web
interface. Therefore we want to use the JSON output of the ethtool
module information. During integration I found two problems.

When using `ethtool -j -m sfpX` only the basic module information was
JSON formatted, the diagnostics part was not. First patch ensures whole
module information output is JSON formatted for SFP modules.

The same keys were used for both the measured and threshold values in
the diagnostics JSON output, which is not valid JSON. Second patch
avoids this by renaming the keys for the measured values.
This solution is not backward compatible. But keeping the broken JSON
output is not an option either. The API change is kept as small as
possible. Further details are in the commit message of the second patch.
Second bug is definitely affecting SFP modules and maybe also affecting
QSFP and CMIS modules. Possible bug for QSFP and CMIS modules are based
on my understanding of the code only. I have only access to hardware
supporting SFP modules.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
Changes in v3:
- Reworked second patch to minimize API change
- Update description of second patch in cover letter
- Link to v2: https://lore.kernel.org/r/20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de

Changes in v2:
- Add fixes tags
- Do not close and delete a never created json object
- Link to v1: https://lore.kernel.org/r/20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de

---
Johannes Eigner (2):
      sfpid: Fix JSON output of SFP diagnostics
      module info: Fix duplicated JSON keys

 module-common.c  | 4 ++--
 module_info.json | 4 ++--
 sfpdiag.c        | 4 ++--
 sfpid.c          | 9 +++++----
 4 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: 422504811c13c245cd627be2718fbaa109bdd6ec
change-id: 20251021-fix-module-info-json-0424107771fe

Best regards,
-- 
Johannes Eigner <johannes.eigner@a-eberle.de>


------10EA76CE49A48059EFFDA87C776FB554
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjQxMDM0MDdaMC8GCSqG
SIb3DQEJBDEiBCDkYLdMhDQQBDodP7m+w5NoroZMlJZ7KCj66gIrykdE+zB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAKNUk9NBet
jtWrjCGGrv6cfrn8HQV4FBQiQugaLSnP3gmfj2v3qmZnYfm98EPe1dicvH1/7KGl
vv/Q5/6TR2oO35gUV36ksRqucryWNl2NEYVtZa8+iTL6gSV+0sSQMfqAPlSYGM3D
xn7SxHNkMCwMFTTUfHkmJ8fOinfaPP+eh9cHy+DO8HK8AsyTfm4t7yGVrX3+0QZV
++oSkNvOAnCE4ErFxu0uJawmCNir+qY0bIR3C6fGa3Oola1yCIlL87R/+/rNMpag
yHsATiq6neYRxBX2lX6jkOEqMGPbQih+ujiSsdbEW7yG4jPxJatvYhhcbQ9TMhsO
XGx8JpAcRdwJf0n5Z7J8uFxoP9c0lsGK3rMF+oSBf8LNSYp+X60aCq5gxLxK3Rbk
vj/w0QRm9HHB3FfHolmtXj8wkvCvtqwzifA5YwAkgjuDzcaY25tJDPqmcD1oNji5
I7FqdmKc+sPwDt0TbcHWvQ27xpsMn9D/t2wccQI7FNpKHuTi/R/A3ouL7J09uHv1
OK/QZprwm1b0wN75lp+FAHIcJZ/uAheDCSaKImIFFBKKxEX1oMUV8800YOfoRGvm
4QxxS30R8GsGSi4nObz1woWVF5GDddILI+OAByUiFVE7xWbe2av7c8oQbGY8wfU9
k2nGLgy/nLR0gMIzeCwCVJ8gh4A8mn2Q0g==

------10EA76CE49A48059EFFDA87C776FB554--


