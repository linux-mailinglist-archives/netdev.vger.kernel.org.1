Return-Path: <netdev+bounces-161332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D8A20B41
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FB33A4A9C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49241A2C0B;
	Tue, 28 Jan 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VPTRzRUp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEC25A641
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070633; cv=fail; b=GSM2f3UxNBvij0b0B8BG9Z44WfGLQ5rPo7spmI1Awpzs8VGKUoGiu0SnItXJzP8+B4RRKz5ZJ9ca6vHQWPWK5GmM5aa1yZqzHmjdyNbHnwTmzyFh3DLKOroKQLRvrSGd68cpxpWROthj2OTsnMIyED39OVVj2yysa1oHvkT5f8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070633; c=relaxed/simple;
	bh=C3VWkdEmbPZlC4Wd9j0A8nMgKXYAGnkHtXtmb+a22+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rK94Q6frN6HjIjKrvzrU4mJX1WlcEFrJlAoavhOQtfvw7AxC1oVmzAgpoKdF0fSzFjikIdGyFjkfzOyoLKAwzTarGhk5kSU+nuAFyotaohGEWoOqjVM78x3K7MVA4KosCV5OtbAiCbskyWYyv56XOHIBMYGznEPJQJXrFtKeGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VPTRzRUp; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pkaa8+qEjLp6DtDYhYkZS5anxfA9STFVQ/HOrMwy2xPxwujqSph59q9Yh6SJ8YLXKQjclK0gSDoCaCwbyTM2ZPHbgRyocH38pj3nav4RnWKlmuuK2+bTNvglJiUpAOAz9BGYGtIgZfkIf8gxM3yQkx+gDksaKSiifH/X9Gs8OBaaY2JX2W8/PTwI+fXoSIhqd9fDDmDKmCDmTnNfFTi83r+bQt5mE9QN9PTq8X28vVpBzb3VqbKT//depMXFKuWM+KyrbNcqH5wORxYtON2vH9sZkJbosWUB8Sj5UrIbk54p1s+9MRlmCp1EMx3pp7J1PAbja4vn08I8ZxIizbW0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3VWkdEmbPZlC4Wd9j0A8nMgKXYAGnkHtXtmb+a22+Y=;
 b=pF/cSB/mH9ZfqCkEKdkq15mz7oR5+qnSmCa/O3eLKvddtIR/T8U0Shuh3cbzLMkl+UHH+evPex0XEE7KXAsMsrlTqAP7EP81lEoS2y99+Sk+5reXBaT8+AiQFMb82jDT66pEIHsWk+i+6uzzGwc4wF9rvxCqZUIMuAfyhECONwTrTyWXlLWag1Hwnn18HSUQkNQohi9mKvjyzI0WOK95ChtRWpxQ8ys324c+BgUlPjw4djApOkqn8Sp72/BsvvmKEKZ3oDCRuIR8GPKiQPwgn5L1D4A6cCsfF2/shxTiLUX4HykEV+hM4NVnxxW8U2ctay4ymNz9hPM00eBia+6ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3VWkdEmbPZlC4Wd9j0A8nMgKXYAGnkHtXtmb+a22+Y=;
 b=VPTRzRUpNMsmTIGGuAUABhz+9edyWGKWOSgPmB9krVq19Uy5MoQbFZyGdxCZ1ymYCXCmJbpxLJoCqTr7ApKMY+6AZ0fb4MwjuBjT5AmAnfFOm9ZOKVB/fZER8v9VxwixVccB2dAWoeRobsMnQOJhNuBOTULDWEmWqi1BakcfkH+Qc0fcbohSkTCtut6g2BC6GubinBBeZbqvPH7MhWPXostg2b4KmEnecCDb5QTcfIHDYGeDKGsZWGL5dS+ZBplspO3oc3ylYijpX+2k5kIBILhpmCdVrustks1hcScgsLJ4LIE6DgLOhLKFrxdzhlJgjbiwbKt92sOvhCV6zFJKvg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 13:23:48 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 13:23:42 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbb+l5fdqqldfRAUu+2iXPDyW3KrMrEMQAgAEdyvA=
Date: Tue, 28 Jan 2025 13:23:42 +0000
Message-ID:
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
In-Reply-To: <20250127121606.0c9ace12@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CY8PR12MB7292:EE_
x-ms-office365-filtering-correlation-id: 3fb0bee0-ad0a-41ef-5a6a-08dd3f9efc1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEs0bkwrWHV5ZVhnblF5RGFscnhUNUFNdm04QzNFRk1wTkJNVXI5cjJQUHN2?=
 =?utf-8?B?ME84L3h3NU9tL2R0MVpWSHd0ZjdISm9CWThDZkdMQ2xhdUNCOFNJemxIamhm?=
 =?utf-8?B?UVJudjFnRzNIeU90c2dxcXE3MGVYbmJXY1o5ZERFKzIyZVlCYkIweXhaRnh4?=
 =?utf-8?B?cFdWTDdFSTFiajh5dFJncFVBVDgxY3BMb0VvRzEzSjBDcnlyeDZDd0FUMEpD?=
 =?utf-8?B?STJTZmdockRCMXltTHd2d3JkODRXYWk0L1JDWGNickd3a0p0c1FuUUpaNlhp?=
 =?utf-8?B?dmRHcmplcWlVRTdwSVlIREw4eHdFWUw1MGZ6TXp3VzNjMkR2NGZLaGhHQTBt?=
 =?utf-8?B?Rmd2c1JNOFpHYU9ESFZKTU9vYmdhYlAvK1h1NlVUMXROS0pBZ2FQQzBYdElm?=
 =?utf-8?B?c1F6bnFHeldNbHgzUU9mVjVON29MUndJM2RJNDJBT29QUEw5dU9WSi9EK2Nk?=
 =?utf-8?B?TXJobnNVcmhYUFFmTGpqcG9aRGpHTlhaQ3FzVHVyMjhzYVBGZzQvQXNFb1Bs?=
 =?utf-8?B?NW1vTHdNTXNONkpSMzR6YktjYkNIMTh4VDhQaUxvNmpRbzNoYUdBVXZIbHpU?=
 =?utf-8?B?ZjBwajBWdDhvaFZXTEI1YXBJVFpyWkFocDl3UnRoUkFHZDA5UTVqc3k0bDFy?=
 =?utf-8?B?MkViUjI4cGdsUXlxVGxFN1ZjRG9RR3BXR2Vra1JiVG0wMm03VHBTUWUzeU0w?=
 =?utf-8?B?NUlNRXgrbEMxNUNJa3UxU0lnMWVWVUhiWVVKV3paSTdod0hIaktNTDJZYmsv?=
 =?utf-8?B?WUJoRzBVYTJBT2h6M1dRcWtqR1dKYmhsSGJJdGxqbmxLK2VSWVUwTlNrNGdk?=
 =?utf-8?B?Z0hoVHUycE9oUEVrM3ZmanBvZysvK1F5SWRsYjQ4RExvNGgyMmYxV2lFQnZ6?=
 =?utf-8?B?NEw4QllCYlFmREdPRVlRVU0yM1ZEWEtXb0kwL3hwV0swU2poNHBGYlNjaFlW?=
 =?utf-8?B?ZUxFd085eDMwRTNnL0VGUjBPMGJRYUptUmYyd3pNTXFmR1d1Z0pSanFXaGpV?=
 =?utf-8?B?ZzJrd3FpMkdDR2tLR2VlRW1od0ZIQlQwY0VUTnFRdVZiUms3SzVuZGlQTUVy?=
 =?utf-8?B?Y01ySWdGUVBsTy9UamlOaUZ0aEFmTTdhSXlwRFdlRkJYeDV6NTRXY0VaUGRJ?=
 =?utf-8?B?YVNDeHNKbXBqcm12Z2QyUlo3ZkZuSCt6SklCeEJKY0gyWWdNemNtTERHVHBR?=
 =?utf-8?B?TEZPVFIzVGhidi9heXJuTU5nL2hjdUZqYnNJQkFjT2V5cGtJblB6Tk02Umty?=
 =?utf-8?B?UXN1MXU4bDVGQlNTNTBEU0JkeWJmNlJHc3NXbWZYdFMwQVU1amhWNTUrUDBj?=
 =?utf-8?B?YmZFT0c1V245K1YxNlVnelBpUWhVd1F3QVNlUEpYb1JPNDlhR1hzYUJDM2p1?=
 =?utf-8?B?ZEJWVVpVRFI2ZkZYMml1TVVFTy96eHozaFV4dzBrWkxMVUpaaUhMQ1V3eS9J?=
 =?utf-8?B?ZEh2UHI5VzJzVXhZZE1ZL25zWjN6dkp1dDVRMTRjTWJQUkppbmNEb1pLNnls?=
 =?utf-8?B?ZGk1QXV4U2Zsa0NKWXNjeGFVdkNXcGpxTFpTZEVNbklKZ2Z4Q0pXUFVBVEpw?=
 =?utf-8?B?S2FVNkJGbFdwMTFwV09EWHU1S1FvQ1JjZmUwL0FsWkwxczFZMi9XSGwwSVlN?=
 =?utf-8?B?MzhNODVrRUMydlR1Qlgxb3hRekhRTzZXYUNodFNrQ21IVVE4VDFzNElEdGNZ?=
 =?utf-8?B?L0MwRGlJdHNFTk11RWJHTU16Nm9TdmtseVRsY24zcmtzR1R5U0FUQWFEU2JW?=
 =?utf-8?B?ZmxmbForTjNEdUpvSWV2NUJCQmdqdUhLK1JlMnVuYjRMZ013K0FORzRDcnly?=
 =?utf-8?B?RitXOEQvVmRLSUdBUWlzVldMRjVVa2dablM3VjE5RkFwRld2SzNVMVNpQlNn?=
 =?utf-8?B?L2lNcUhoMC85NUNCQjlzUVV6RFR2bUxnc2xFUVYzbHgzQ3c0K3pPems3aXM4?=
 =?utf-8?Q?kJf8YcMBOoxAQKKVEdlWwwyfOiK8yISK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STk2b1lDVmF1Z3pWNDdGbFdhQXhEdXhscmFoZkZTL0xja2V0NUVCbzlycjRE?=
 =?utf-8?B?ZTg3Nm9VeFZnWU1DMEVtYVluRGtFcVB0d3hnY2dhUHVGdkk0UXhTMzNiSVFY?=
 =?utf-8?B?aGQraExSeEhSTEpnY3cwM3lPYmE1NTRhRG5JZjFGYXRuVVVDckYzWGJXeEpG?=
 =?utf-8?B?WUdOWDhrc1NmS1dNVW1JQmlkS1puVlN5OTZFbkptK3k3bnVGSU9JMjlFL251?=
 =?utf-8?B?UTJ4Sk42WUh0TURVQWVNdW9Gbk16NTQyeVQ0ODNhVmowSGwzRTVraUg4RFFE?=
 =?utf-8?B?ZXhMVFZQOEFEb0dSeUZHSDdTZTZ0SGRGTVNFUWYwNlByNFdBMFVNUDhQSndq?=
 =?utf-8?B?aUVrdEs5ZndYMU1oaTRMczVYSGRLU3RZeFdPb0lXUEZJeTlxdjNDMWlXMFNi?=
 =?utf-8?B?QXA0ZzY5RjJIR1IyMjR0ZXo2Y0ZMbWg3Q2FxSm85SDJPVkFIS1FjTXJuTmFO?=
 =?utf-8?B?UVUvSWZtRzk5RmUrU2NsTFk5cURXbWROaDBoSThTa3Ewdk1NcmlENUhHU01U?=
 =?utf-8?B?OWJkcDNORS9hdVBLZWl1WFRjaWQyY0d6d2Q5VHdiMitNWXRIeHRZUWRERHdN?=
 =?utf-8?B?eXMwU2ZPSGN0VDRadHE1M0xXVUJmNVN4TEZadStUckpzT0VYSi9HNi9YRHla?=
 =?utf-8?B?RFd4ZDZmSE5KdmZxTkFwYnlJRW5sLzh6TlB0a0REVHRMT09yV0NMN2NXYkNS?=
 =?utf-8?B?NXZZdnNJVklOZWVrU2pVM0dVcGsxei9vV1dXM0J1TS9TMjE5RHJEZUZUU2Iy?=
 =?utf-8?B?STJtbkFtUzBJZ0NJUlc1WmZ2K3piMmtReGZuME1wbkIrM1o5cXI0aWdDL2Nt?=
 =?utf-8?B?R3NEcEg2TDVSUjJSM0tQcnYwcktOZCszQk0wc05sVDJjODd1RE9ENzE5Yzlv?=
 =?utf-8?B?SVQ1OEJmUWQrd0ZPYmlFOUs4NTh5SHBjUXJpTHdqakdJeGVaWmVhT3Y5OW10?=
 =?utf-8?B?ZlV4T2JOaWcwRkJORE5aTnBZaWhsbVEwUUVGbVBiUGVEZXFyQXIwdVFlZE5O?=
 =?utf-8?B?NXRtYSszNklDS3VKRkJMZWdpeUF6dUtJWVlob3hjTFZEMkJ4QldxbGR1dnlT?=
 =?utf-8?B?ZkovSEs4cThMVklwZzlXblNpT3puVFppd0k5QjVwQkl6enpJME44ZFBsb3VM?=
 =?utf-8?B?WVRLaEVUekhWVDRVdTlPbmpuWWpOY3BBWXFpekIydEZ2NUxuTmtsczZ4MVVR?=
 =?utf-8?B?TXk4dnFsVWQxN0tUOTNCVU1sYWwweU5EL3B6dWViTVhLNi9haEJGaDBjOFpt?=
 =?utf-8?B?SVZIWGVFWHg4UHhURXIxb2d0cXhnVWZZZVcwbUpOeTBDS3l5VFdFNGpuZGFr?=
 =?utf-8?B?a0lJRHFUdjA4dmVucHFoV1d6ZGlKUFVobldMdUQxay9ScG1ZMEozdm9aUjVl?=
 =?utf-8?B?ZHhRbFFrMW44aDN0SGgzVXh5djRaS2ZhbUNqa0puZXY0YmRMYmlBc0RYb3p1?=
 =?utf-8?B?Y0VJVnpVRWlLZHpGVWQwbDI3endlejhpVUdoak82Q1JTaXhLekwxL2htbVM4?=
 =?utf-8?B?TThNMTNQMHBlRkY1anZNbFkwekJxajlRcHZXZmYxdHFvdjZFdStwenZONk9B?=
 =?utf-8?B?RXFxajFrRjJuS1M1S2dwZko4OVlLZEhaSzExUmZ4a29VcDc4ejl1dTE2U3gz?=
 =?utf-8?B?VFhPSkptcWhhMkwyZFk1SGdYRmxGSUxNaUs4Mk5FWVRFU1RTSmRUeEkyUHdQ?=
 =?utf-8?B?OEdyVmhld0pZeUI4TE9hcEQzOWp6ckFMOFZ2WGJZbDJ5M0FMd3kwWXJGRkk3?=
 =?utf-8?B?VXdUa0pqNWI3dDkyeVJlY1VEVU53RFJRcFN1dVd5ZHU1OEZCVGhJaTlPVEtZ?=
 =?utf-8?B?clFnN2ZrTU53WThjV1FkQVpHUjdBbWtTSmllT3hTL3BTVEhwTHM1ZHk1ZExn?=
 =?utf-8?B?c0p2N3FiaVdnTlZ0VUMxVFMxbXFxOUFIWGIxL3liZWRFOWhxS05QenNnM3hG?=
 =?utf-8?B?VFhNcys1NGtPTElFL3plcmE3Smt0R3lEZ1ZpcW41ZU8zV1BhT0o2ZFh3NUxH?=
 =?utf-8?B?eXlEdExzaVdmZ285NHlOOTVVcldyNE85dVR6S3p5MHlwcUdjc2xDdGExL1ln?=
 =?utf-8?B?QXZrZDJsV0dSUEwwdjVDczB0M2VqUDVtYnpLUXRqT0RqZ1daQ1EwbWUxY0VL?=
 =?utf-8?Q?KiVk2rZ17LhHe8juj/kVB5UHn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb0bee0-ad0a-41ef-5a6a-08dd3f9efc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 13:23:42.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJ8CUpSF0MwCGNN7RYLqhrle3x/MZ1Ml4MrXqWEv91vqhlZRd46nBtOBxZdkjOY/ii6lgoS/T62e6Tqx1LPF2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXks
IDI3IEphbnVhcnkgMjAyNSAyMjoxNg0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJA
bnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2Uu
Y3o7IG1hdHRAdHJhdmVyc2UuY29tLmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0
IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+OyBOQlUtbWx4c3cNCj4gPG5idS1tbHhzd0BleGNo
YW5nZS5udmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCAwOS8x
NF0gcXNmcDogQWRkIEpTT04gb3V0cHV0IGhhbmRsaW5nIHRvIC0tDQo+IG1vZHVsZS1pbmZvIGlu
IFNGRjg2MzYgbW9kdWxlcw0KPiANCj4gT24gU3VuLCAyNiBKYW4gMjAyNSAxMzo1NjozMCArMDIw
MCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gKwkJb3Blbl9qc29uX29iamVjdCgiZXh0ZW5k
ZWRfaWRlbnRpZmllciIpOw0KPiA+ICsJCXByaW50X2ludChQUklOVF9KU09OLCAidmFsdWUiLCAi
MHglMDJ4IiwNCj4gPiArCQkJICBtYXAtPnBhZ2VfMDBoW1NGRjg2MzZfRVhUX0lEX09GRlNFVF0p
Ow0KPiANCj4gSG0sIHdoeSBoZXggaGVyZT8NCj4gUHJpb3JpdHkgZm9yIEpTT04gb3V0cHV0IGlz
IHRvIG1ha2UgaXQgZWFzeSB0byBoYW5kbGUgaW4gY29kZSwgcmF0aGVyIHRoYW4gZWFzeQ0KPiB0
byByZWFkLiBIZXggc3RyaW5ncyBuZWVkIGV4dHJhIG1hbnVhbCBkZWNvZGluZywgbm8/DQoNCkkg
a2VwdCB0aGUgc2FtZSBjb252ZW50aW9uIGFzIGluIHRoZSByZWd1bGFyIG91dHB1dC4NCkFuZCBh
cyBhZ3JlZWQgaW4gRGFuaWVsJ3MgZGVzaWduIHRob3NlIGhleCBmaWVsZHMgcmVtYWluIGhleCBm
aWVsZHMgYW5kIGFyZSBmb2xsb3dlZCBieSBhIGRlc2NyaXB0aW9uIGZpZWxkLg0KDQpEbyB5b3Ug
dGhpbmsgb3RoZXJ3aXNlPyAgDQoNCj4NCj4gQlRXIHRoYW5rcyBmb3IgcHVzaGluZyB0aGlzIHdv
cmsgZm9yd2FyZCENCg0KVGhhbmtzIQ0K

