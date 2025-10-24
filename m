Return-Path: <netdev+bounces-232415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59DC05991
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E05A4E5BAE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FB30FC17;
	Fri, 24 Oct 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="lFLTNrF4";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="ZQ4zOpMz"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay12-hz2-if1.hornetsecurity.com (mx-relay12-hz2-if1.hornetsecurity.com [94.100.137.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C6279DC8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302072; cv=fail; b=Q49e3fYH7nBvLAy/Hskdd/mDNJ5ou/HbHp14OaU7xFhczFUZOyaMDc/fG9DaD7XqPl781qxVocgACcJ5T1Pnpo9pXP4fHjCOVAHXx0dPuw7q3WByKFifoE2iu0z9QTf9qZo8cI+lXnvv2GSIwYRVstt67YtsreTCRaotcWdgsPE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302072; c=relaxed/simple;
	bh=HkosUf4sPNQYiFvxU5kZSr7o+sJwiQTDLAlD/+/VboA=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=EJYDR9taawHmH0o+HaxrrZFvwcHABcFVO/kPEcC7f74OcCWTbBakOJpgTiy3KB39wSW9pn/EiJibhSASJMoTlZojZfeb8gBLe0ZCWJ40/5ly/t7ZEcjMJTFRQuCeKj1optBzZULjgOjJOSTWd1p04dG/haWwMDwuqIEOJ4Rru7Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=lFLTNrF4 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=ZQ4zOpMz; arc=fail smtp.client-ip=94.100.137.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate12-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.72.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=zhjPkfHR/+qk9+WmvHdM/C+ePDLZyfzwD+zYw5be2jE=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761302066;
 b=suC3uI1Jgv0ZksSL3cr2E+IhP5yPOK9R4zxruFDvGbKlX7UtiTEDGJFTSDMh4nUr9Lo35jdM
 i2iYYxB4iA4nLKxC11BSAwYFE4ObXqi0PJW6BaFrQpppDP+N8SSdL2qbywA1jInQVvytBhnYxZj
 F4BRBUCQhFXULzlljqUmI5wrKXBJnTjil66MqLUPBH+k54V3c3YLs3wXRg+uffqmcFoQEMl1AF5
 HBrE4bh5iUQJjoAdRIN84KoKn7ooy8ZbdcMgOMvVsrPzybbNtywJL0EnxIbTkYIaKueooT8mTAN
 RtX8ofbTN9szA5gP7ucC+1WQedGheR1TZu5D8qMVgciqw==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761302066;
 b=OYSihgUxfXmfKP6mvq1/CwRWft9yfjAcCRS7AuTuAg4dbCjNXyhxKShjOQBw6A5RIOiG0Z8Z
 ddUvPXPDLv/ybG90Qs/YE1ZymiTrauLm0p00z9POqOElgEoOk0px63lhPAhUY8xtQ0JMa/BHjsO
 n8qFgUgy+IwSyR0JhharUlT1MXS/Vb4efvZW65nl+xTJAk7dcZhSDlTH7px71rHvMJxB8OovK3h
 IkVwzTKjjlDYyBfHr3B8hOO8lh2S6Kch/JnHfHdcRHX4OiMYPnBwApumlzEtxGr6PPVOILwDJL5
 QV4z8h3KtdkUb2lhMgPivr6RuzOVRbd40ZXowQaZYLQ3A==
Received: from mail-westeuropeazon11023102.outbound.protection.outlook.com ([52.101.72.102]) by mx-relay12-hz2.antispameurope.com;
 Fri, 24 Oct 2025 12:34:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZwgiNre64LgQKmXLwl2HczHwoDmXI9VXY1/JKr6gmlydxaKaGEnX2yWn6feKiVVUdZBiKDGZDeU33M8AbYebfiRQ4s5vnY/pvyhxWQs9fhw4D1ZmvknWAL6Dl3oXmGJD5Yr+Vn/iPNzJ2UfqyAmT7Nfrg42/7B9DFXuMIgmNMh2WRE3RP+92oXTLMEYOcmHyZSyUJX9XgsuHlweW/mraDyblV+RZDWGtWy34yG8uR3PPYgrBui7v3IL1Pmnkm1ggyXghSpvZxAAt9UWbUwidUM90pxaHaSaAE5FWKvKpbd1xJKbIakIBMK9GtiFkM9lYU5Ef77p/nZDY0UcI5VCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w52phcheU8zqdmTIwok9cX89n7LQRpYFLl0EAosiHVQ=;
 b=Gde78E2f/U2xiLyvyvcN7KzXFtW1CkajTaQ/vHDIPCPSOgvUF47+o4bfHhyDzP8jntd2QSQcAAotg7DycbkhogIZi3CjGugrm2gYztEs7bS2hISagPbaHVlj5Ca9W3Cw4I7p82JfHsnH1FfScyEfF9MM48SD+gs+6z+QvRiyfEezl3CXFG7j2nCs5ibdFTEomebUNQ7p/U0ThFfOsrrYRUGlidiTbdrrBSnuBDDMZEJUGIrq89owj5Wc8AF1/ZVhtYv0EccWTC3aFd/7D6epxiBze39e84/8ZfimXVK3xXhctKeoHs9ggnx5hjnJc3DjR4/cCPRUFJFv92wEpEk3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w52phcheU8zqdmTIwok9cX89n7LQRpYFLl0EAosiHVQ=;
 b=lFLTNrF4WlqncV3SsXSIOhaXEelR4pK1fJgeQ3N//cA4YEPA3LjcQbgRwVcpEManxbUVAdQ+77a6D+6UEgSEpqPFl9GasDPXPwDe1VIzt3LYPw0mRY5NYsM1uIKE+AT0hRn79DuNkHA69BK9KVQy91o/YB4Jx5WHQFeGpJA8c0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by PAWPR10MB7789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:34:03 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:34:03 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Fri, 24 Oct 2025 12:32:51 +0200
Subject: [PATCH ethtool v3 1/2] sfpid: Fix JSON output of SFP diagnostics
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-fix-module-info-json-v3-1-36862ce701ae@a-eberle.de>
References: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
In-Reply-To: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761302040; l=1288;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=kvosG01SGkXySoK4NwRHxjhexte6vCfAW3rUnBcLAO8=;
 b=C2xfP8DV1qeeUqh3t8chbNNgBMjvKq44MjXNQGDM0dkKCHbrOjBZSOkP9DnO4KskGeczhqf8Q
 KLjmHSeVUXBCC1+++tYi6Kp8nuwabOdgN8r0nS2ys2xnyzgvYYRsaP7
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|PAWPR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 436a898d-324f-4a03-a5ee-08de12e8da0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TytBTzFRWkZDNnIrZUgrZ3JscmFpMytuakJUWmYwWTVYc0FLcTRhVU1IVURP?=
 =?utf-8?B?S25YMXRBbzMrM1lLSTc1OVpFSWUvUTlxTjU4UEphRWs5NTZDcWdXYjNpT3Fa?=
 =?utf-8?B?bzhVMHBSYzcvNHVXRWtrRGt6NDZBSEI3cWNBaHJidGVwRjNkZlhqZWdTQXlH?=
 =?utf-8?B?N05JRmZWdElJT3ovZUJBcndVOUd0dk84Qlh0UWtYdGNra1lwRDE0T2piWm5r?=
 =?utf-8?B?VjhicStWNEpEMmNqbGpHSVlKMEZSVVoyY0ZtaldYSFg4bUVpYzN5S1JyeDl5?=
 =?utf-8?B?RUhVeStBWGlTSXhuSmIrMDQvVFFxMHk1WjkzT0RpUmFtaXkwWFFUNUJFeCtI?=
 =?utf-8?B?STgzNWJzYmJybXg3QThrZ0c5QkVUQTk3RTFCN0dleklIWU5za3o2Mis5MUc4?=
 =?utf-8?B?WTBHTzU3TmYwWDl0VmN1d2Nwd1gweDZ3Ulo0Ni9TRnBDN0Y0TGJ2REh5N2ZF?=
 =?utf-8?B?cDJCR0hLR3U3NllJRDJEUnpxbUJ1VFdwQTV4Z3JKWUdzOHZBQk5ETGxMSWdS?=
 =?utf-8?B?SW4rWnpNUHhqMTc5ZXVMVUk2a0FIcW9YdGIxSkxTQU8vTHFleUF1bnJLZFBD?=
 =?utf-8?B?V1hSOFlXejlPTzZWamxRYjd1T2pRZEZtdzllUmE4eXY3K2pxRFJxMm5hT0Jw?=
 =?utf-8?B?b0NQVFpYRlpOTHZrVy9mN3lZelFDelZXcklwRlpLc0cxSi9KanRhTEE5cHBz?=
 =?utf-8?B?SkZSRUtRWlZmZFd6dXJpWFliVVE3U2JKbWpZQVhWZkl6SmxFWncvSXFRR3M4?=
 =?utf-8?B?T1VmdjN1Z0RKQitOYWdXQjdJUUpEN0NWdjJlb2VrYkZOM3Y4U1cxUkhoaUVU?=
 =?utf-8?B?L3RnRE9hQ0JGNDNwVWJ0NTUxR2pmS1pTMW1TSGphRGc0dEs0M0RWREFsY3Ft?=
 =?utf-8?B?SEZ4a1I0RVl4N1p1eURkVndTYUVUYzhhb3IwNEloaFNpdldQNEJRblJMcDhS?=
 =?utf-8?B?cDhQTk9oUjhCSThOeDhCSXRrRjZjb1NES3BFbXRiVEQwWUZuYlp0V2U3RGo3?=
 =?utf-8?B?UE9SSTA1WUdzOTk5RUx2U2xiTGRwQ3Z4eEhJUzJNRVNwQUQ2bTlCa2NLU2lH?=
 =?utf-8?B?c2g1MnRKc2pYZU9mN2puVlpWdXdUS29XbCtKR0dPSEFMMVRsQXpYeXRBUG9C?=
 =?utf-8?B?dUU5WVQwbnlVWmYzMDJzVHJodHpqZkRsL2FlYjh4YlpGME5XY3krRXdGZEQw?=
 =?utf-8?B?VnRYYWJlMmYrU09ldEJUQzRaMmd3aldFMk8yYU5LaHUrV2hhZTU4SGhlWG5Q?=
 =?utf-8?B?SmxDbnJ0WHhHRWhBdnJJcEhZS0FZUkZvc21qS01KSlJjRC9oc3ptOVZqL2J1?=
 =?utf-8?B?SElTM2JYOGxCdU5BczY2TmRGR0k4VnJQbWNJODVYVzNTc0NtM3JUc3NZT2Zj?=
 =?utf-8?B?SlpaS0xJZFB3dnVJeHlVbU9NSHA5dHdBaEUyMys4NlVqU2UzQkxZMEpGcWds?=
 =?utf-8?B?d2NYQTZ3RmxjS2kwa0g0VmFLS0Fod0xsWlFOcmxuSzZtTzdMdEFjdi9yUnNW?=
 =?utf-8?B?eXpRRzhRemdhVC9vNnpiVTc4WC9YeEFER0hrdmVIZDJyd0w1cExHZjJRdmNM?=
 =?utf-8?B?b1NqRnoxTWRWM1EyTzUxS2ExME5JUW9ndG5Jd3BJdUY5TTRScU56dDlSV1kx?=
 =?utf-8?B?RTJ2Q2pTSXhmbEZ5RDA0QnFtdERrVXFNWWJta2NGYUdzcTBnMWFxQjZvYVk1?=
 =?utf-8?B?ZU5FZmYyT080N0Qyemh5RVdmM1JaZkswbTgxa2JwK042ekV4Zy94a2U2WWNT?=
 =?utf-8?B?Rm9DVm8rQXZTWUJUQVJNRFMzc0t6MVhBbDhURk56ODVGQjNhS3F3RE15RDJt?=
 =?utf-8?B?UEtYVkpySlNqdlVmZE1oN2FYSE9iWGdlWUNOSGpHSkZ6V2EzV05yblNjNWc0?=
 =?utf-8?B?aWVxenJSZ2s5OEh5czlSMysvblgyeVRwdDU3SXBSOHBUQUdqOU1raWovUERV?=
 =?utf-8?Q?XpVK001AjiRbW+T2eE6fhY64cL5COLaw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDdTVFlUTFYra2VKc1YzRTB2bFJhOFpHNzNOR3BQZnk1UURkQ1B6YStZWWNC?=
 =?utf-8?B?eFZYelZkTk91V3Q3TE9jelpGT2JvTC9FTzVDbVhMWm1qRlQwaDZjUjZOSEkr?=
 =?utf-8?B?WE1pTEdqaGNSQVNKUWdlcE9hbThkeDVnY25zVkFkUW81RUJFbFIvZlZvamxQ?=
 =?utf-8?B?NEVuc1h5b1JwM2M4UUsxNjlWUDkwczRTTHlhMEpoQ2g2dGlTRStBbnFTUmZn?=
 =?utf-8?B?enJoSjlXbnRuemtkVGNhTXBmWlhUZW9QaUp2cXdqYjNJQzg5ZXQvbDUrWUJZ?=
 =?utf-8?B?Zk9hOUFMa2gxS1pxNTJMamIxNTA5akxzUFRHM1pIUHRQTXJ0WXVKc0dmYXYv?=
 =?utf-8?B?Z256Ym1jRVJlMkZkUk1EM1NGWWxCZ1RWMjdsRGtIV3FRQXE1dUt4dDFsZERY?=
 =?utf-8?B?Q28rVWx0UjBuYlMzSnQrajdmcXpwa2cvb2F6WmN0N3J4b2NiZk44cFhDOEdS?=
 =?utf-8?B?YUVoU2cxZUVsczZBWnVqNlZxRmpDSXFPYko4Q2tocmRvNCtPS25ZSVo4bnBH?=
 =?utf-8?B?anJnL2NBeThEc2xlbTluaFZWd2l2WElCWVlmaTlsbmU4b1NWa2xqdEhEekFL?=
 =?utf-8?B?QTJUUXhDK1BjRlo4NnBuQmh6Q2VrZ21qeEE5d1dLa2Y1aEtvKytnZjRYdTUx?=
 =?utf-8?B?NlVjQWZFelg4amZmSjY5Nm9xcjVtaUpncVVHNnR0ZmlyeWFrNTBYS3NSRGl0?=
 =?utf-8?B?R00xUHVURUZ4eloxcGlTSjRCTm1tNjhZZitpcTI4ODBZL3loTFBRV3ZjS0dO?=
 =?utf-8?B?WjRZWW51dlpVMy9GcHZQbUdHbXhNNzhuajhFSWQzYWFZZ1F2SGFmSGVJbDM3?=
 =?utf-8?B?YmlXN2JGZU95WUh6T3FRMFVCN1QwTTNPRFJOdWdaU0tOTmF0YnFUdDdyeXl1?=
 =?utf-8?B?eFJ5ZlprQWJIMFhXSzd4RHpoQlJ1amtQWGYrMkt3VDZ4SkFURVFDaVNVc20r?=
 =?utf-8?B?bkM1N1BKbDdEbTUrbjBoc3IvSUl2ckIxdW11V01sa3FMTGE5UjYvZTJvMVRQ?=
 =?utf-8?B?THVsbEFub3VpTGxKOXZxaWxTMldLSTJ3T3dXbG1nU1U4SXdqQmFaZEkremVh?=
 =?utf-8?B?OEhpNDg3Vk4vNGIwYkRwRkFpdldqL0ZSa1ViRW94TG53VkFkM3R5TlRIYzRu?=
 =?utf-8?B?RUJsdFc1QlpnQ3h4Ymk1ek91T2toRjZnZDh3QllCVUxuMUpVVmlxUDlhcnNy?=
 =?utf-8?B?MU12YzBEQmNzbmphMVJhT0RlNk9kYi9iWjNXekcyQUtIMCtQYWJyUyswRzFj?=
 =?utf-8?B?VmJBQmJUcXJVQjVjZGZnVkxaZ1pCZVlDWjNVdndvS0dhcnUyRXhaMEIrRTRP?=
 =?utf-8?B?NElaVE1XV1doR0V6YUFmTGdCSkdXV1EzWitVVUFWZU9YeEc3L0ErNWZKMm9w?=
 =?utf-8?B?M05QNzdoQnFtK3hTRkxTYnlLdEF5TGYwdkZFK0gvRzlDVUU1aGc0ZlYyTTlj?=
 =?utf-8?B?alVrS1BGdHZ5N1NLZGdYNXRTdHMwQVhDRExJbDQ2Y0RVc05nU3M4a3o0SDNz?=
 =?utf-8?B?cDNpYmhoYklPalhFWVFwQUt1OE85UUxPZ05lSzdKZ1M5YW1oakx5dHo0UkNC?=
 =?utf-8?B?N2U0UEFoOUdmT3pQN3ozOWRZWkdJVDBDM3VWSUNTamlhYlQzSWZuN2FVd0dY?=
 =?utf-8?B?UmRSOHNSblR2cnNjdmJnVzJEKzRpZDVkdjVDTE9vYnU0aUlIcHVYekNWMmZS?=
 =?utf-8?B?VmtjTjFMWTBvU21yRGN6c3pmbVRvM2szMEQ2OTJaKzlya0ZvZXdkRDhtMWNP?=
 =?utf-8?B?b1hyeXMrVE9tSGFwWE9XeFZyU2N0cmFoS1Q0RWNxSDNsbmZ3cTRqQUp6aTNV?=
 =?utf-8?B?TWx2VzA1ZHQ0U2V6UXhvQ01za2JpZmVZZGkrUUlYVHFpckxzaGsyZi82cWI1?=
 =?utf-8?B?eVNVQytJUjZNWVYzb05TckFvWjA2bmdhMHVPU05acWpZcmJ2OXphZExhc0RG?=
 =?utf-8?B?WGdtVGdrZWg4ZmFZM085Nm1IL2V4VWM1UXdQRlZmd1NPRkt5V2FBenprWEJw?=
 =?utf-8?B?VU9QVk11Z2ZVbkUzcWJieWV1c1NIc2kxRWtKVmhhZC8yOG9wTjNIbTk3NFZy?=
 =?utf-8?B?bjRYanB6ZzdwaHhrVjc3NVVSSVFKWjlCTnJ6d29KNzVNb0Y1Qi95aWc4WHU5?=
 =?utf-8?B?aEhPbjkySDMybTY4Y2p5L001Q0JZMUJPZ2JVSzhJMlAwd2xhVmxGalNzODQ2?=
 =?utf-8?B?cG5YMnB5TUw5bHl5UXVVMEZtcjlPQmpmcUl3dkFZMFd0SGNHem1nSmN0eFpH?=
 =?utf-8?B?TzRpOUVrVVJGWjlUbHlyVjIyRzNRPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 436a898d-324f-4a03-a5ee-08de12e8da0b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:34:03.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mADQORhGvcPNuagt9kAES2EYAsJ7WPMeEw00jkES1AcZZnUpFqJUMTZvbuPGAN2yTP5L2w/OFOfM9Gr9qDhkhrnxcIcOqggR9r9CZD4YlEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7789
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----588777BAE0D7C9EBD358705836F611AF"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay12-hz2.antispameurope.com with 4ctK5M5KV7z3BBhx
X-cloud-security-connect: mail-westeuropeazon11023102.outbound.protection.outlook.com[52.101.72.102], TLS=1, IP=52.101.72.102
X-cloud-security-Digest:712fdfc27be4f483ee9c9a99b1eb2a97
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.665
DKIM-Signature: a=rsa-sha256;
 bh=zhjPkfHR/+qk9+WmvHdM/C+ePDLZyfzwD+zYw5be2jE=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761302065; v=1;
 b=ZQ4zOpMz6PVmBwKX8G4VDiWhFYz8qK+uhcrZzOZc8Ur3yFHH7VBypiWn6NdMGj0nH6BT2s6b
 Oo4J+jWta6ogr8++ABbvFib24WQbGS6zLvA7lHKBviswGvCVZ6MbRZcR+uyXKgWQBDm7PUpcfKo
 j8LnF6q16YzoSp6s4jXeuRM379vMOZShuHXlBhyCjnR3MIlkq0IUmfwuoRGj/DNfQVuslBgDx78
 42a6skAET9jqYgMp2MhXVFZWpIOX50ye1gu52aqpuxDCMNYejv03I96cMdRDOER1R1xy6KSDBN+
 frLJyUgBkxKW3cd40c6ucroftyitb7ASkdJCDna61lRNw==

This is an S/MIME signed message

------588777BAE0D7C9EBD358705836F611AF
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v3 1/2] sfpid: Fix JSON output of SFP diagnostics
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Fri, 24 Oct 2025 12:32:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Close and delete JSON object only after output of SFP diagnostics so
that it is also JSON formatted. If the JSON object is deleted too early,
some of the output will not be JSON formatted, resulting in mixed output
formats.

Fixes: 703bfee13649 (ethtool: Enable JSON output support for SFF8079 and SFF8472 modules)
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sfpid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 62acb4f..9d09256 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -520,22 +520,23 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
-	close_json_object();
-	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-		goto out;
+		goto out_json;
 
 	/* Read A2h page */
 	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
 				      buf + ETH_MODULE_SFF_8079_LEN);
 	if (ret) {
 		fprintf(stderr, "Failed to read Page A2h.\n");
-		goto out;
+		goto out_json;
 	}
 
 	sff8472_show_all(buf);
+out_json:
+	close_json_object();
+	delete_json_obj();
 out:
 	free(buf);
 

-- 
2.43.0


------588777BAE0D7C9EBD358705836F611AF
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjQxMDM0MThaMC8GCSqG
SIb3DQEJBDEiBCBNyU6tcqW8sDg4p7APs8H7TiV+ViHmYPZmHvwfTz65ezB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgBf4tCUTI4w
3o1PuDceMVjSw+qlkP8F+tuKM9CF0HQ0csnAysm1rB7n2uPykIE7pdI5TZWQtHev
W4e1zoS42kOnSYlF3QJr++SbP5XmgN5rVW+NPZ6VX9kLVG6adLug7Qi4lqFHHAeH
Sh3OeiREqKlLePwJFH5psVq5VvA8bDKfXZXsYBMAxrpRbXGDw+VnMMEJjQB9lgFK
mGAdLi31TEPAmhqriqMp8ipK+HziHxHoJZlmRU3uHGrPFMB9HgwP2NJK+iGIAKEF
teEPlorwKlAhKhYomtwGTfiyczrIKKSuYDHLTYMXvdpENeOTGmYsPw5RBbDIfbR9
8pgd0sNXSuAWp3wQve70S+K+HRNn3sz1JteSvyxdOaYVAadtg4tts79eVwiC8YlK
grp4AbOOo7vUkI9mBZHHZFZK0kreh0zNE+GA+S9Ito/aQ4jbU1MXzZZTtmNzw6yk
14AV1IkUFtlk0muQ5yLiKP7kr9tK2tXpxerTeWPrIzEmRZMWVP8DDbDv2Mq7aDXg
ExMcKrCoegiHwf8zv3KnbdnQasbySWOmLeQ1ri7AKP3+hhx0Pa2FS9WjlUXOL2BU
wSRMqi0iEfXjsoH1uDrkLxOi6urZOeHSRFGMltS0z9EKunCWVMbM1sZEMPonkjgr
Eu7molgdlbk6rqKC1A1yLzT1+3CxjbVapw==

------588777BAE0D7C9EBD358705836F611AF--


