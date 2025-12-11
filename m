Return-Path: <netdev+bounces-244423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37669CB702D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DDBD3003131
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AF31E0E6;
	Thu, 11 Dec 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="cSAl72Sg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC531DDB7;
	Thu, 11 Dec 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481485; cv=fail; b=HY3jmgQXX3l7ZhMWA/QjxmzDIcuxNO1M4ruP9CbP4AFylZTf6L1Z4CHfNQH1WWVaV+clW7TFo8aLELcNgcrekH2hlBuV8SbKSekF1Yzjfw4mv+SO8G1Jzq2aK6t+NoHndBG03dTdL9FCnZAxWPx0ejjh5dNr5pLdUIdx24Gq/CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481485; c=relaxed/simple;
	bh=5w3ShUkDTxNekfqJAD6gXDz4tziDIyLPzvxdzMPPvQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZ/TxeKEfYrTTryi7rBGKMb8EJ6ODzJElGYo6GIRIlS7EHjaY6MXfolFD8FIyRmimiw3fTk+sTy6z5iRSA31y7Ywcs0o8dYd7RNQtRIAnAOHPnI06E076rvtK5OJLYLTcNp8PM3OCxenPGW5/NsVYzSckMNVcCL50Z6JVcrHOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=cSAl72Sg; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAnSKK2374371;
	Thu, 11 Dec 2025 11:30:56 -0800
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020126.outbound.protection.outlook.com [52.101.46.126])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjjfjj11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 11:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8/RNNAyoZvQIcYBbBnN5x1IJf4VhpMkxo3AzBCQ9j4XnGsPoVg7luq+RCvVIT6cgHrg3oY5p/OKeInhv2zkij25YNHPBl2T9Yzm/SkYxyDEXpCFXgc7cVKvoAcp11VAcG5JzWVm2inPA5PGaDm92U8G6RwQR5B62KFp5KHW4Fa3grx4S82aJkOVXi00+SXimnrPVM6xxJyKTHtP9ldd4osf0+I+JS/lNh0s83tbbTgEeYeOVtyQm7IDMF1t8oqGjeA3Y8ggl9URLMosbN6D7jNt6AT+UuZxYt0BJBQ5QH5p15q+CRxwbFbRtLlSKNEm9PFB/LnBsrjaegzx02KcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w3ShUkDTxNekfqJAD6gXDz4tziDIyLPzvxdzMPPvQ8=;
 b=ddHMTxiChdz+j8GUeBduOdrRXmCztnjSH6bAbOZLsnIAUXVOL3gCoPdAw9sZ5URezh1QP3z8magYyoZTyszImj1qWADmjBPtpVcRG0EYQnOIfRt+EvKiDClG/UBgLVxm1SoGvY9jj2Q9yw3auTLoG4bA72qgZA8qKNgkunUYklNSq0/SyymQhRxupRI4V6CPQYtJdJZRXpsXPOSVSWTccyuPlJxHXMjCjXfCjG118kwb7tTbyKTYOMKbNE3M7yfuZlm9mMZFCBF9Xoo+ZekwOoQ2sx1fGXL5aX74Mad8fdn0TUOcDcQy3c/Sl+E3a20k9LyrIONGIQdCAudVsyHFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w3ShUkDTxNekfqJAD6gXDz4tziDIyLPzvxdzMPPvQ8=;
 b=cSAl72SgabVI3z+xp4KslCiXAp2DiG+3uPfmOAfpORBDPNKpTTsPir2jdnn+LMoGKeUa+/kebHkMZZHIvYya+xWAAjk3U3bUyEECzKvLfDTeNtyJEIm4cjESQvIvhqUsnAEYEFTfOhkWGkTX7sIIAY62nUpIDuLVR6TM2s2+6eo=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MW3PR18MB3531.namprd18.prod.outlook.com (2603:10b6:303:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Thu, 11 Dec
 2025 19:30:53 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04%4]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 19:30:53 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: "Chalios, Babis" <bchalios@amazon.es>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Graf (AWS),
 Alexander" <graf@amazon.de>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "Cali, Marco" <xmarcalx@amazon.co.uk>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: RE: [PATCH v3 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Topic: [PATCH v3 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Index: AQHcZFGNDesDBE0O+UOcWP2wUC57mrUc1OqA
Date: Thu, 11 Dec 2025 19:30:53 +0000
Message-ID:
 <BY3PR18MB4707921531D6A7DF7B1FBF0FA0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20251203123539.7292-1-bchalios@amazon.es>
 <20251203123539.7292-5-bchalios@amazon.es>
In-Reply-To: <20251203123539.7292-5-bchalios@amazon.es>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MW3PR18MB3531:EE_
x-ms-office365-filtering-correlation-id: 015f5c6f-92d9-4d92-9007-08de38ebcc75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkU5VmNtcXNwQWJtdS96WVY0aEVua2tJOE9KMWo0WHlKN3V0OGsyT3lHUHd0?=
 =?utf-8?B?eHZFeHNWQVN0dkVCU2g0aStyUFcyR1htRmJhRG9RVDVQcHJPcmJPamVSK05G?=
 =?utf-8?B?cy81b3dYaWk2WVFPMVBIYUlJMXRvQ1FrWExZRDRXUDRrb2NZSUNOcWlGZ0o4?=
 =?utf-8?B?N253S3ZJVUFJRFI1NmduQ1kwNVVYUW9iRnE2elg2Q3ZBZjQ1NXQzZFJZMU16?=
 =?utf-8?B?bXNyZ1pYSXFsNS9ZbHJzUUhVSmlzQitLd1UwTjhaQUYvd0ZNaDVMZW4weGs3?=
 =?utf-8?B?MnhKSUFicmF3ZkxOLzdpZUgyR2dMRmVJYUJDclkrMjBsUkQzL3dtUjZiYTdY?=
 =?utf-8?B?SkJGdEQwTXEwTEdWdTVYZVVucnlKdUFSY0xGdFJMK1NabnpaeHNrWklvSFZT?=
 =?utf-8?B?VTVzQThXN1ppcmJMYW1OQmc5aS9oWFRROVJKRGVPdlZ4WUhPZVdSeU5JRE9z?=
 =?utf-8?B?ZEJkY3pDVGxHOEpIT1loZXhIWEtPVjRRL1lObTMrUkVCZy9hREZ6amVyY2Rk?=
 =?utf-8?B?QkpkOFF1Y042bjc1VUpuNkpxSnNoOGlUZFIzQlZqbmp3amljVmRjeFpGK25C?=
 =?utf-8?B?NlBlaGtnZUxRMTJtKzY0M0wrRDRtSHJ2RHF2cHhEd1FORzRITzNzZnQzTmhD?=
 =?utf-8?B?TWdZeVAwZkNXdHJzNDc3YjhvTHdOOXhlNnRieHlxc2R5eFpOaDF4VmNkRlVp?=
 =?utf-8?B?UFpjSFpUaVZtSHl6VjJWcWkydEhwbnAxOGhiS3FPYkE2U2xiRWl2ajlieSt4?=
 =?utf-8?B?RVI0VWtmUGJZSHJyZ0I1V1lSdFJhblY1Q2dzRlNmRk1nTVkwdENvQm01bzJt?=
 =?utf-8?B?RmQvOFFUZ3lvd2FNbmZaVC9QLzNKcVJzY0orQ1VONmIrNE1CVkxLNHNvVjZX?=
 =?utf-8?B?UURZd2toZ1UrWTRjRDZkemhuOW16bElrVkt0WW5VNG9QMnQ0Z0JiSDBCdDFP?=
 =?utf-8?B?cmdRcldYNFR4NnJFaWlzWDlUNDZOZVh3NW93bzEvMEZkdTJxWklDR04yY3dV?=
 =?utf-8?B?ZDlmcjBId1RTNytuZDI1ZDJmVFVDejVmTEd1aEJwUURJNnUvbnRFVWxFMUZp?=
 =?utf-8?B?UmVCa2NYNXcxZHZjNW5YSlFrMDlGTEZKbWUvZ0hFY3BPWVZtL3V0Y1RyM2pJ?=
 =?utf-8?B?aVM3YVNqREI1dFl6QjA2d3JobWtpRXFUdEFsYkJTdDlOVU1hYzlYM2NjWXg0?=
 =?utf-8?B?bnR5TzNBNFNxS2ZYRzFtSmFNMGFCQXo0ZUI0eDJyVGxCai8yUExDMUpUZ1Fu?=
 =?utf-8?B?RmF5YlgzM1JUekF2eGRLRTg3OVQ1azdKNFUwTEkrWTdmSHcyblp1TEVud29M?=
 =?utf-8?B?YU91c3NEb3BxVXlsVVEzKzN2OWNyVU1qdG84cXBVMTVPMmZnK1ZRdHJDVnBm?=
 =?utf-8?B?aGRXdWV2NGdlS0s3QVk0emIxaVJuM0srb2lxQWh6OVBYblpURWN4aGFZa1Za?=
 =?utf-8?B?eE43SFdNb0N4dUJHekZzVW1jSnlBODNFVG5rSVBRTzhZRzFLRTZwVS9LSEIx?=
 =?utf-8?B?M25uTTJBOTBrNDhobmIzNzlLNDBzV1Rwbkp3QWVvK1EvWWFNYmFkZWlNMkRN?=
 =?utf-8?B?dExmMTR5WUZVYlBhNUFTUGhLNHEvOUkralNhNlRxOU9tTFlCb2c5T3VRRmRi?=
 =?utf-8?B?VU9iUVdmSGxYSWJHRVNEYy9iTTJKYzhrK05NQ2F1RmI2aFpYb1QxY1puWjVv?=
 =?utf-8?B?UjgxRnV2ZSs3SHBBUldPc1pCWE15UWs3WVhYd09rQ29lTE9IcWJra2VaNkpI?=
 =?utf-8?B?Y1ExVGs1d1RQL0FtdGFyTlV4Y1Y4b1lRVXhEaEVoS2dSUCsrSWUyRG5UbVRE?=
 =?utf-8?B?d2Z0SzVSVFJWb2VYcktWaDVUZm1qMnpOUy9PSlVKSlNhOTlvWnNZa2ZYZlJn?=
 =?utf-8?B?UjdzL0ZWd0laU2RMMnVJSW5UaTRzSzdqL3VPWTFjTHJGSzhmOGhSZ0NOTGUr?=
 =?utf-8?B?SnNVRk9qR1JsTTBLeERFTGV1WjF0TFp1aTNzd2IxSjRQM21CaFN5UjVFNUth?=
 =?utf-8?B?cHpMTjVhT1djYWFIZGZqcU1OdHhpcUpORlV6MWIxdzJKbG1oRzJ2UUZ4eW1h?=
 =?utf-8?B?Zm1JRWxhTVFIZ1hVT0tsWTVTWkxQTGpoUnlIZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjNlcnppMnZZOE92WDhjY05VTkJaSG5sdEpid1hiMW15SmlIdWJGTUZnS1M0?=
 =?utf-8?B?ZndpQlUyMlZuT3c4TWwvY2ozSmswUlI4ZzNwZEVMY3RzNHN6eUJwSXkweWE4?=
 =?utf-8?B?YWs2SFRvN3hXbmhHYU5lZFd1RzIzVXVSd0kzV201emkvaDh3OWVkZzMwNEJ4?=
 =?utf-8?B?SkR3N3ZVMzJKRWlUSDRMbVk3ZVdCVnFnWGpaM3hwQnJVSncwWFpoT05jd2cx?=
 =?utf-8?B?SUNHeXJ4T1JzTExxSUNpa1JPalR1RFRwUFhvazRWbDhjU1c0aWMzYlhzYys4?=
 =?utf-8?B?a0xTbjdPTzZLT0htMnp0NlFFZU9uY014ZGxVMUNhSjhmM3F6ZUtETXhHQVFx?=
 =?utf-8?B?OGYxVkp2UWhnOUJ6dEo2TnZWZ1lGT0NZWEpZdzg1UThqbVU1cDhNR0haWkRv?=
 =?utf-8?B?bXF1N0Z3VkdKUnBYL1dabkQxOGRFUzZmdHlNNVdGdis0N0V0SnY4V1EzRTVR?=
 =?utf-8?B?cHpsSmRIUGNxVXZpRjZteEM1MmlpSFVoN0lpY0dKcW0xSkcxKzY5eEE5cFpx?=
 =?utf-8?B?RW54OXhNeW02L3U2ZENJV0RNbnpZVGpDOHRYaUMyMlVZU0p1enVzc1hHamRJ?=
 =?utf-8?B?ZWFzNktrajgvQk1QVzdKWC82Nm1sdGhpd2NtbzRYbDFxcG9aeU5RQkt3OENK?=
 =?utf-8?B?UVhtVndGSSt5WFNLWEZJV05NUzFzKzg2eEV1SW5OUTBIQ2g2SE9sdUpyNXpP?=
 =?utf-8?B?RVIvOXdFTlREM3BuSkhhZzBPRkRwMzZDaUZzbEd3SjVlWHQ1Y3dGWHhDbUxo?=
 =?utf-8?B?OTFTbDVBTkROcFR3TVIxNFV2UVBudDBvVUlyc2lxYjIxeWI5YlNLWmJpUzE4?=
 =?utf-8?B?bXkwSHlSMTNtNmI2TDhoQ1hRcmJqcGgybm9SSHZvRVBFWlZOcWNKd3VqbG02?=
 =?utf-8?B?RVJwTlJCcWd3OHJFY1dPSlZwYm1UcFJPa0pZVGdKR3NLZnI5R0JPdUw4Nk5M?=
 =?utf-8?B?LzlHWC9IK2h2d1Q5Z1JQQzVoK2ZaWFNkTmt1N2I4c0R5L1VnTmRmUTVycjdT?=
 =?utf-8?B?YjlYcTJlckxDZGl5Ky9WQnlEZFltQkQ2OHYrc0hFWG9rcTRwU20rQTJZNkxH?=
 =?utf-8?B?eFRQNlFPbjdCU0p2MVpmaDVLZkhNMjV3UWN5NktJcUhvRUxDSmIrMXc4dnEy?=
 =?utf-8?B?aU03S1JSbEMzaDlRTTdtYnBtak5Wd0xGMDNFMkVYWEpXQ294QXU3d0FjVk5w?=
 =?utf-8?B?aVhGM3RlZHhxZ1lFaldyeWVhWEsrMjZZdTJ4VGhJOTNRdWlLREtWQnVpTUwx?=
 =?utf-8?B?OUxHUlJhdHovSWFYZ0QvUDBCU2M0dWpQVEMxazhvSm5zVTA0ZE9mbzBBSy95?=
 =?utf-8?B?eGM0RU96MUkzUkVPVDMvaVVIazZESjJ4MXY1Z1FSdDdEWGp1Q1VWZDNhRWU2?=
 =?utf-8?B?ZUtvYUtjSDU0UjRxOUdVZG5qTDBwSnVOQThwRExHTnNQNW1kYkNBTUJyNzNy?=
 =?utf-8?B?cHZhbGhHUHJSTlRuTXNiWHBUODhxVWZueTV0UDhVZVUyaG1hNVRoTGZWcUF5?=
 =?utf-8?B?Kzd5aEs3c1JWRXhaQXlXeVp5MGtHalVtT291R3dTa1Q5cHNndm82VFV1R252?=
 =?utf-8?B?TE13Vk1wVGxqOThIVmNWT0tkLzFJUkk2U1pTVlViajBFNFdGUEFWTFVEdkF4?=
 =?utf-8?B?VnpFMUkySDErbnZHT25KN0dxbUNoSnRLclpRbzVBZjg5WnBySkluOWVlUU5D?=
 =?utf-8?B?N3dhVjBzTzZCS0lWY0Z6OGs4bDArZGNJdGhrbFdSd0dXYllGd1Vqd1R0Umxy?=
 =?utf-8?B?WFJzSWhQdSticVJwWFhpTVdaZFV2VzMyTlVUb2tpRzNZa0lIV3FURDhGTmVp?=
 =?utf-8?B?NzJBUWV6SEV3Z3N5eldoUTBjRlZoUlMvQ1ZnMXI5ektxelZmV0JnN3VEMFlT?=
 =?utf-8?B?Z3ArWVVVakVPbFdSaWpudmxsTUxYNUZpUENuL0lKZWRycFJSNHdudEt0UUJD?=
 =?utf-8?B?UXhsZ3RXMmt3MmZYSlh3UkhvaGw5MkphVTN4MXU4UHloS0VkNmEzVmtVUzRu?=
 =?utf-8?B?UGxWSDAxMVJuZUVpSExubThwV0ZCZ2tuRjVvSlNDamVMRWNKZWJ0RWRtYzhv?=
 =?utf-8?B?YlArS055NXR2Y2hSQ3h3Wk1YOUszK255VEVRdTJmVTlrZklXOUZUZzV5QzAz?=
 =?utf-8?B?Wm9SaE81ZFQvZ2ptaUJoL21CNWpCZjFBNEk4cHQzYVhVLzFUNk5FTXZ5TXNk?=
 =?utf-8?Q?55ZFbT1tFK6BVXdMdE2MXZFFJAXHB0taWNNvR1miGKRP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015f5c6f-92d9-4d92-9007-08de38ebcc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 19:30:53.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDlyavBEFabGQIhOBh4qsM5HSGWcuykR39MNshsMSg6AoVZqlhWae6mgeyM1iqRlGy9+Sqh8vtbrAVuDp8VN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3531
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE1NiBTYWx0ZWRfX5L4yEmm/DiXt
 sloZbu6nzSWZ0KVtY7pEKhx0T1Oif4slNo1a5OowTo86mZGVJzMf56iBgW/bzzaSJXS5fUsOUwA
 Tpncb38+K6Px3tD3FFb+lUkdaT6niKSwnyzceY6aIQlRYhTwz/YBWTF6bUx1aKSUXLpTd2hTAJw
 YqkKaaFD9s3NXJc9i/I/x3+Gp2bYdpjZjsAmgtldNinUiSxG3Wywag1EVKCv7xFZKPODxptfyQ3
 5gX63e3aKy9oFUwzVNWh2+b5kfknAsvcDreHjbUTqnbcjmxJnC15wOo0CJEI1s+tSCrdE2T7jQU
 rVH9dia2sXEqxm0PUl1vMn0rMzlkZ+gvhs+RfJJoVp02Dt/d52q60ULtrIhZt3uqDbbAUX2pRXP
 078Xa0o23OVzhCzVng16qKdxUqL/KQ==
X-Authority-Analysis: v=2.4 cv=IayKmGqa c=1 sm=1 tr=0 ts=693b1bf0 cx=c_pps
 a=W9KrTTgrKfNcK5viAlcM6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=pBOR-ozoAAAA:8 a=i_jxt56ykGC74MhKlw8A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: k-rJJ_p5vv6a7Tf_fvhySNyXJszd6pjP
X-Proofpoint-ORIG-GUID: k-rJJ_p5vv6a7Tf_fvhySNyXJszd6pjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhbGlvcywgQmFiaXMg
PGJjaGFsaW9zQGFtYXpvbi5lcz4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAzLCAyMDI1
IDY6MDYgUE0NCj4gVG86IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOw0KPiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IGR3bXcyQGluZnJh
ZGVhZC5vcmc7DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsg
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNv
bQ0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGFsaW9zLCBCYWJpcyA8YmNo
YWxpb3NAYW1hem9uLmVzPjsgR3JhZiAoQVdTKSwNCj4gQWxleGFuZGVyIDxncmFmQGFtYXpvbi5k
ZT47IG16eHJlYXJ5QDBwb2ludGVyLmRlOyBDYWxpLCBNYXJjbw0KPiA8eG1hcmNhbHhAYW1hem9u
LmNvLnVrPjsgV29vZGhvdXNlLCBEYXZpZCA8ZHdtd0BhbWF6b24uY28udWs+DQo+IFN1YmplY3Q6
ICBbUEFUQ0ggdjMgNC80XSBwdHA6IHB0cF92bWNsb2NrOiBBZGQgZGV2aWNlIHRyZWUNCj4gc3Vw
cG9ydA0KPiANCj4gRnJvbTogRGF2aWQgV29vZGhvdXNlIDxkd213QOKAimFtYXpvbi7igIpjby7i
gIp1az4gQWRkIGRldmljZSB0cmVlIHN1cHBvcnQNCj4gdG8gdGhlIHB0cF92bWNsb2NrIGRyaXZl
ciwgYWxsb3dpbmcgaXQgdG8gcHJvYmUgdmlhIGRldmljZSB0cmVlIGluIGFkZGl0aW9uIHRvDQo+
IEFDUEkuIEhhbmRsZSBvcHRpb25hbCBpbnRlcnJ1cHQgZm9yIGNsb2NrIGRpc3J1cHRpb24gbm90
aWZpY2F0aW9ucywgbWlycm9yaW5nDQo+IHRoZSBBQ1BJIG5vdGlmaWNhdGlvbiANCj4gRnJvbTog
RGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4NCj4gDQo+IEFkZCBkZXZpY2UgdHJl
ZSBzdXBwb3J0IHRvIHRoZSBwdHBfdm1jbG9jayBkcml2ZXIsIGFsbG93aW5nIGl0IHRvIHByb2Jl
IHZpYQ0KPiBkZXZpY2UgdHJlZSBpbiBhZGRpdGlvbiB0byBBQ1BJLg0KPiANCj4gSGFuZGxlIG9w
dGlvbmFsIGludGVycnVwdCBmb3IgY2xvY2sgZGlzcnVwdGlvbiBub3RpZmljYXRpb25zLCBtaXJy
b3JpbmcgdGhlIEFDUEkNCj4gbm90aWZpY2F0aW9uIGJlaGF2aW9yLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4NCj4gU2lnbmVkLW9mZi1i
eTogQmFiaXMgQ2hhbGlvcyA8YmNoYWxpb3NAYW1hem9uLmVzPg0KPiAtLS0NCj4gIGRyaXZlcnMv
cHRwL3B0cF92bWNsb2NrLmMgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHRwL3B0cF92bWNsb2NrLmMgYi9kcml2ZXJz
L3B0cC9wdHBfdm1jbG9jay5jIGluZGV4DQo+IDQ5YTE3NDM1YmQzNS4uMzQ5NTgyZjFjY2MzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B0cC9wdHBfdm1jbG9jay5jDQo+ICsrKyBiL2RyaXZlcnMv
cHRwL3B0cF92bWNsb2NrLmMNCj4gQEAgLTE0LDEwICsxNCwxMiBAQA0KPiAgI2luY2x1ZGUgPGxp
bnV4L2ZpbGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvbW0uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gDQo+IEBAIC01MzYsNyArNTM4LDcgQEAgdm1j
bG9ja19hY3BpX25vdGlmaWNhdGlvbl9oYW5kbGVyKGFjcGlfaGFuZGxlDQo+IF9fYWx3YXlzX3Vu
dXNlZCBoYW5kbGUsDQo+ICAJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZzdC0+ZGlzcnVwdF93YWl0
KTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IHZtY2xvY2tfc2V0dXBfbm90aWZpY2F0aW9uKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHZtY2xvY2tfc3RhdGUNCj4gKnN0KQ0KPiArc3RhdGlj
IGludCB2bWNsb2NrX3NldHVwX2FjcGlfbm90aWZpY2F0aW9uKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYgPSBBQ1BJX0NPTVBBTklPTihkZXYp
Ow0KPiAgCWFjcGlfc3RhdHVzIHN0YXR1czsNCj4gQEAgLTU0OSwxMCArNTUxLDYgQEAgc3RhdGlj
IGludCB2bWNsb2NrX3NldHVwX25vdGlmaWNhdGlvbihzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIHN0
cnVjdCB2bWNsb2NrX3N0YXRlICoNCj4gIAlpZiAoIWFkZXYpDQo+ICAJCXJldHVybiAtRU5PREVW
Ow0KPiANCj4gLQkvKiBUaGUgZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgbm90aWZpY2F0aW9ucy4g
Tm90aGluZyBlbHNlIHRvIGRvICovDQo+IC0JaWYgKCEobGU2NF90b19jcHUoc3QtPmNsay0+Zmxh
Z3MpICYNCj4gVk1DTE9DS19GTEFHX05PVElGSUNBVElPTl9QUkVTRU5UKSkNCj4gLQkJcmV0dXJu
IDA7DQo+IC0NCj4gIAlzdGF0dXMgPSBhY3BpX2luc3RhbGxfbm90aWZ5X2hhbmRsZXIoYWRldi0+
aGFuZGxlLA0KPiBBQ1BJX0RFVklDRV9OT1RJRlksDQo+ICAJCQkJCSAgICAgdm1jbG9ja19hY3Bp
X25vdGlmaWNhdGlvbl9oYW5kbGVyLA0KPiAgCQkJCQkgICAgIGRldik7DQo+IEBAIC01ODcsNiAr
NTg1LDU4IEBAIHN0YXRpYyBpbnQgdm1jbG9ja19wcm9iZV9hY3BpKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gc3RydWN0IHZtY2xvY2tfc3RhdGUgKnN0KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAN
Cj4gK3N0YXRpYyBpcnFyZXR1cm5fdCB2bWNsb2NrX29mX2lycV9oYW5kbGVyKGludCBfX2Fsd2F5
c191bnVzZWQgaXJxLCB2b2lkDQo+ICsqZGV2KSB7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2aWNl
ID0gZGV2Ow0KPiArCXN0cnVjdCB2bWNsb2NrX3N0YXRlICpzdCA9IGRldmljZS0+ZHJpdmVyX2Rh
dGE7DQo+ICsNCj4gKwl3YWtlX3VwX2ludGVycnVwdGlibGUoJnN0LT5kaXNydXB0X3dhaXQpOw0K
PiArCXJldHVybiBJUlFfSEFORExFRDsNCj4gK30NCg0KTWlub3Igbml0OiAgIEZvciBjbGFyaXR5
IGFuZCB0eXBlLXNhZmV0eSwgaXQgd291bGQgYmUgYmV0dGVyIHRvIHBhc3Mgc3QgYXMgdGhlIElS
USBoYW5kbGVyIGRldl9pZCBhbmQgY2FzdCBkaXJlY3RseToNCnN0YXRpYyBpcnFyZXR1cm5fdCB2
bWNsb2NrX29mX2lycV9oYW5kbGVyKGludCBfX2Fsd2F5c191bnVzZWQgaXJxLCB2b2lkICpkZXZf
aWQpDQp7DQogICAgc3RydWN0IHZtY2xvY2tfc3RhdGUgKnN0ID0gZGV2X2lkOw0KLi4uDQp9DQoN
CnN0YXRpYyBpbnQgdm1jbG9ja19zZXR1cF9vZl9ub3RpZmljYXRpb24oc3RydWN0IGRldmljZSAq
ZGV2KQ0Kew0KICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9k
ZXZpY2UoZGV2KTsNCiAgICBzdHJ1Y3Qgdm1jbG9ja19zdGF0ZSAqc3QgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCi4uLi4NCnJldHVybiBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCB2bWNsb2Nr
X29mX2lycV9oYW5kbGVyLCBJUlFGX1NIQVJFRCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAidm1jbG9jayIsIHN0KTsgIC8qIFBhc3Mgc3QgZGlyZWN0bHkgKi8NCn0NCg0KDQo+ICsNCj4g
K3N0YXRpYyBpbnQgdm1jbG9ja19wcm9iZV9kdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB2
bWNsb2NrX3N0YXRlDQo+ICsqc3QpIHsNCkFsc28sIHNob3VsZCBhbGwgZnVuY3Rpb25zIGhhdmUg
dGhlIG9wZW5pbmcgYnJhY2Ugb24gdGhlIG5leHQgbGluZSwgdG8gc2F0aXNmeSBrZXJuZWwgY29k
aW5nIHN0eWxlLg0KDQpzdGF0aWMgaW50IHZtY2xvY2tfcHJvYmVfZHQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3Qgdm1jbG9ja19zdGF0ZSAgKnN0KSANCnsNCi4uLg0KfQ0KDQo+ICsJc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiArCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiArDQo+ICsJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
KHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gKwlpZiAoIXJlcykNCj4gKwkJcmV0dXJuIC1F
Tk9ERVY7DQo+ICsNCj4gKwlzdC0+cmVzID0gKnJlczsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgaW50IHZtY2xvY2tfc2V0dXBfb2Zfbm90aWZpY2F0aW9uKHN0cnVj
dCBkZXZpY2UgKmRldikgew0KPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19w
bGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gKwlpbnQgaXJxOw0KPiArDQo+ICsJaXJxID0gcGxhdGZv
cm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gKwlpZiAoaXJxIDwgMCkNCj4gKwkJcmV0dXJuIGlycTsN
Cj4gKw0KPiArCXJldHVybiBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCB2bWNsb2NrX29mX2ly
cV9oYW5kbGVyLA0KPiBJUlFGX1NIQVJFRCwNCj4gKwkJCQkidm1jbG9jayIsIGRldik7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBpbnQgdm1jbG9ja19zZXR1cF9ub3RpZmljYXRpb24oc3RydWN0IGRl
dmljZSAqZGV2LA0KPiArCQkJCSAgICAgIHN0cnVjdCB2bWNsb2NrX3N0YXRlICpzdCkNCj4gK3sN
Cj4gKwkvKiBUaGUgZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgbm90aWZpY2F0aW9ucy4gTm90aGlu
ZyBlbHNlIHRvIGRvICovDQo+ICsJaWYgKCEobGU2NF90b19jcHUoc3QtPmNsay0+ZmxhZ3MpICYN
Cj4gVk1DTE9DS19GTEFHX05PVElGSUNBVElPTl9QUkVTRU5UKSkNCj4gKwkJcmV0dXJuIDA7DQo+
ICsNCj4gKwlpZiAoaGFzX2FjcGlfY29tcGFuaW9uKGRldikpIHsNCj4gKwkJcmV0dXJuIHZtY2xv
Y2tfc2V0dXBfYWNwaV9ub3RpZmljYXRpb24oZGV2KTsNCj4gKwl9IGVsc2Ugew0KPiArCQlyZXR1
cm4gdm1jbG9ja19zZXR1cF9vZl9ub3RpZmljYXRpb24oZGV2KTsNCj4gKwl9DQo+ICsNCj4gK30N
Cj4gKw0KPiArDQo+ICBzdGF0aWMgdm9pZCB2bWNsb2NrX3B1dF9pZHgodm9pZCAqZGF0YSkgIHsN
Cj4gIAlzdHJ1Y3Qgdm1jbG9ja19zdGF0ZSAqc3QgPSBkYXRhOw0KPiBAQCAtNjA3LDcgKzY1Nyw3
IEBAIHN0YXRpYyBpbnQgdm1jbG9ja19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpw
ZGV2KQ0KPiAgCWlmIChoYXNfYWNwaV9jb21wYW5pb24oZGV2KSkNCj4gIAkJcmV0ID0gdm1jbG9j
a19wcm9iZV9hY3BpKGRldiwgc3QpOw0KPiAgCWVsc2UNCj4gLQkJcmV0ID0gLUVJTlZBTDsgLyog
T25seSBBQ1BJIGZvciBub3cgKi8NCj4gKwkJcmV0ID0gdm1jbG9ja19wcm9iZV9kdChkZXYsIHN0
KTsNCj4gDQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfaW5mbyhkZXYsICJGYWlsZWQgdG8gb2J0
YWluIHBoeXNpY2FsIGFkZHJlc3M6ICVkXG4iLCByZXQpOw0KPiBAQCAtNzA3LDExICs3NTcsMTgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZA0KPiB2bWNsb2NrX2FjcGlfaWRz
W10gPSB7ICB9OyAgTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCB2bWNsb2NrX2FjcGlfaWRzKTsN
Cj4gDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB2bWNsb2NrX29mX2lkc1td
ID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAiYW1hem9uLHZtY2xvY2siLCB9LA0KPiArCXsgfSwN
Cj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCB2bWNsb2NrX29mX2lkcyk7DQo+ICsN
Cj4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHZtY2xvY2tfcGxhdGZvcm1fZHJpdmVy
ID0gew0KPiAgCS5wcm9iZQkJPSB2bWNsb2NrX3Byb2JlLA0KPiAgCS5kcml2ZXIJPSB7DQo+ICAJ
CS5uYW1lCT0gInZtY2xvY2siLA0KPiAgCQkuYWNwaV9tYXRjaF90YWJsZSA9IHZtY2xvY2tfYWNw
aV9pZHMsDQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IHZtY2xvY2tfb2ZfaWRzLA0KPiAgCX0sDQo+
ICB9Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=

