Return-Path: <netdev+bounces-271969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPs3NLcKxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E43335DC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F70D30BFE9C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2B3BF671;
	Thu, 26 Mar 2026 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2BoqeVo8"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDD3BD645;
	Thu, 26 Mar 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519927; cv=fail; b=ULvKY8ir4O+UUU09jTAwJiMncpbe+653DdO+gJeYWFtRifm770IDgSGZ4oG3tXbDZZwwKuNEjJFKd9pHqw+V8+VRdIGjhbJ8k0pcc+3b4D5x5Y1TP03Ha4uUSz6dGLye3gbgWex+bf86varZolat9y7gQ67CkbGV9QSY2OiaiTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519927; c=relaxed/simple;
	bh=Qw5+3kCvMtzRA1bOkWOrx59w2nUAyKRMYp2sAtY9Pto=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtlSst28nbF7yZUajzrzsur6kSjWihCvAEDGhYB/LTPlCUe2qaNkM5nZplgrwBoFM30jX9Rlq1rLwb5o9c+qBPrbDd4MK37QgTrOClrEEO90J07aZmq94MydhMsOS8GMRuFEcrnjeibxQEc85sKY2FPsdnGXfwoVZN7oEMiIanU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2BoqeVo8; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6SdPhq5chM+Zr7+ZjKoe11cvaZfHRTpac8p+LgZjlLzsdCP18F3UWeSkhSfvG7c3/pfEbXbadB3GpB9TuhZ5A/13w7hKIoF6Idq4TRdU3IReLLfgqtV5KLaCOAWTTyJZvb/hMuq/LRscPHd2gQUZtyDFOlrGWeNKUhJZlVe0rw1wrYhzUsm8AhxGOrcBrnTOx2iHP850ZQPfVpHIblJ+A3vxrkC+cKAFFx0aIBNbGYu5PhVn+E2uEHacQmf3z4yTdVz5t8hnVnKLDieGLOCAazQpQ/pQVd8FOpijs3v9DMCt58FBMPddLY824LdEoLfyJop4PPNe/C95QIEK0BDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70UumQ0wXahp/fPc8rN0VZbGI4i5m524rI0Onbo5mUE=;
 b=tkZo5zI0EV4HedrlZB5naBExKAk3jGiZhgF/gmIhT/C/Uin3C1bYftG6gXsvxBxx+woQ7OZ6uHLy7UkmNEOb/wz4sbl7fPtUa6qBevGEtZrNycdNNjFSuOzcyQu82jQlCL65khq7mwQnt0hQzqq6zkqbnfEEmqvRfiVZEqRpjEK9EFZuPrti8qnuTZaAWpCVagcOy2VG4ctt8kKyt5Re2giPuEyXA6iL7bqSjKkYN8DI2/z8KRZxG4p9rsY35sOBFmXePbLpfzsLm/ah0p59itG9zvpaaVm8wpi0zrEpsXrghbY3Rd3GKwe7RYEkqNbD8v+Uod/gjqYCMv7vi5YEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70UumQ0wXahp/fPc8rN0VZbGI4i5m524rI0Onbo5mUE=;
 b=2BoqeVo8b/r8r1kU2jB8tm4ELNpBxJ99sx3bypmBhmJ6ghMbqUNHDuKrghv7ecwYhC/tH9YL7XnYyiVsSFX4W3i/EtzNhomIXJkMA/cQtlQqgAJzJsaL327vpdg3WHbIbbs4oM6gbcfHFmcN3zj9dMfw7lQ5Ctp0+URlEQ2RMrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 10:12:00 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 10:12:00 +0000
Message-ID: <57b046e7-79ca-4d3c-952d-1cb9439601c1@amd.com>
Date: Thu, 26 Mar 2026 15:41:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver
 support
From: "Neeli, Srinivas" <srneeli@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
 <SN7PR12MB81478FB396CDD9929618C2D69368A@SN7PR12MB8147.namprd12.prod.outlook.com>
 <28b232f1-5814-4b3a-af28-1eab023743c0@lunn.ch>
 <ca273ea9-2d6f-4c01-b243-803835d08248@amd.com>
Content-Language: en-US
In-Reply-To: <ca273ea9-2d6f-4c01-b243-803835d08248@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 70653daf-d7d1-43ec-992d-08de8b201e7a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jn8i6s00ooAwQ4my1lTsT8QLJflzl7dZlbfNpa9VVWQ6P6hQwtoeLl8VgFhLm5QlVJba3+py3x9ZihR3fMu0joNhHgo+z0SavTFGpZ3BPAlvk3M0l2nfmBWFH9E/APWeJzAt4PGgzTu5LiIp6jS3Fa8CbR3QPhgx2S7pBX08WFOk6p5oPELlHL7/Xdr4o/rsb6DBLE88b3AjfwDSgBnj+kA2ZhXmy6guQZSXtts53tii3I4og2lFSsU1iT8wqpdeebyXyXm6CQMFf7ijQUEkynLMWj13TbD7vghM1bhK17xe1APxyX+my96KkZef6OKw/s81sE9SI0JEmc6Cg526MXn9uGGyA6tEexLFO2ogJBCwhKyKGh+iiGdEIk0EVw8qNljC3sttBLz7j83G18d5R6UiEd8jhGrzbBxjoIjG0W7csMFpXCsCsS6Z+27RkxEg1RUe3xCrYdc5CB48hcAVmhqnmpihxgplH3+VjsOGJvDgSpFG7tfYCwze5djk069Dt79AfQkn3EDZimYxjUkyps2sYP/d6P8HPsjJNWvxQj7NY0nThdY/CdOfa8VVtapZpuoAMPlMbNA/vDkdUk9lWAvo6pm+zlerMO2QlKVz1DWQIp6MtcU+XC6QZNhk4L2sQC4tqe0ryuQb77461g40PW82ibRilkP+XnpVq5y3hTDt1N8Td2y1sk1SaBtOVdH8NqADdxwdei7rBViAPOj6chqQLm+zOijNJmy4PPwVrDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZyMDNiUkRZM2g4VlFEY3gwVTdlLzdHNG1Tc1hDTUZ0QVBDZTJCWXFWNnJz?=
 =?utf-8?B?bG5makRydm04ZHNoczMwd3VXbE5lVnRzcndpRUEzMDBKa1ovQVdDK2Erclow?=
 =?utf-8?B?dHFjS0U1SGRKaEMweTFqcXh0MTY0WUhpVjk0cEFQT1FOTUk2OXJwNkJuR0tD?=
 =?utf-8?B?T3ZvbmpvbllleHA0VkQvNWN5QnloZWVRbVJoOEJaRTRUL0dIT2NPOVMwOUVk?=
 =?utf-8?B?S3F4SE1sOXhUTXdweENJMHJBUnI0TnVlQnhaNVlMRUptN3ZOSHIzNkpxZ1J6?=
 =?utf-8?B?MXQyUTBmR1c5dFdtUVI0VWNwc2o5TjF4c0JlMU9sdWljd0ZITmZraDROMG5o?=
 =?utf-8?B?TDdiWDk1U1UrcEVXZ0xpTGQzZDBxVmZ3ejhwVUdVMVF4UjBIVHVwN3Jrdm44?=
 =?utf-8?B?ek4yN21ucG1UNDN6bWpPQXJySFlsTG5ld2JJWEY0VUlMYUtHUC9xV3lManFY?=
 =?utf-8?B?enBXRUhwZyt1eU93MTRsMjlLdTA2cHhReEF6Y2MvQ3ljY3hJU0VpOFlWSDBY?=
 =?utf-8?B?S29McHhqQ3MvdGZPVzdpdXRoQmkxYm1LMG5iTy82L1Z2STFsNCtUWFJiaFRZ?=
 =?utf-8?B?cHdYd0NiYXd3MzFhQVVmaHFCT2J0R3BDNVU1QTRjSGNaTUMzWlFjejN6cG04?=
 =?utf-8?B?NktoOVlwUWMyY29vM25LaUJZWmhZbEtJS0doSThLcXZJK3k1WmRVSnYvayt4?=
 =?utf-8?B?blBpOVliVWpTNG13dk5tNitiTGtJVHFFYXA3akl3ekxhNWovNnJLQm52OWJS?=
 =?utf-8?B?MVpsWngwYVh2L3dBV1A4YjVtUTV2UGxVZmdXT1kybXV5SmlONnZ5Yks2VEV3?=
 =?utf-8?B?MDUzdjlEVjhteU91MVpWdm1Ua2lXS01uMkg0Tys2ZmV3RFhXZk54RCtIeTFa?=
 =?utf-8?B?b3ZwTlZHNDNmSkU1TFl0bER4QmxQYko1V2ZYSHJYU05RbERtb1B1QUFPbXlq?=
 =?utf-8?B?SHo1VldNVEpHcnFxUFo5SFNUNHcwdThVS21rQjN1Tkg3eWFOY2pnck9CT2R2?=
 =?utf-8?B?QXAxZ21KS0hwWXpMUHFEWmVabEIvT0pkZTNDRlkrZW10enErbWMybEdVRzdv?=
 =?utf-8?B?Sm1IMGhRVENnOXJrOWFSWVludWhGaGZtWkV3cEdUQTJaajZOeXFBWVBlRmZZ?=
 =?utf-8?B?aWZac055Q2FnVUlMd1VyUTUxUlY3TTBYVkZiWVRkRkVuSjhaRTZ4bVlCZnYy?=
 =?utf-8?B?eTMvU3BwV0hHTGt6RVpoYU1UZDkrVkRGVXR0TDQ4WEUrSnJKQ2ZJODZFQ1c3?=
 =?utf-8?B?SGVLVlVpN1NGUHFraDA1M1lSek5lYVN0dVpxYnJNYUlaODlVNjdOWnozT3Fv?=
 =?utf-8?B?MlhubXp1eW5NcFlIMTRhVm4xaGtzdjAvNkRpRTNKZ2lnQlRCVTJudTBKN2pz?=
 =?utf-8?B?VVpzWitLK0hPWmw3QXdLdHRNdWtJMWpIWXVGSkFKL1dFbEN0Q2hBUG5GYmFF?=
 =?utf-8?B?MzNJWEdnNFplSzkrb3pzQXJVMVVMYU1vbEx2Z1ZKbWlKcVZqSS9lcVNXSHN6?=
 =?utf-8?B?MEZldUtvYzJrZlI4V3cvQVRsT1hNeFN2UHBkZm82K3RPNHoyL0dsNGpGanNr?=
 =?utf-8?B?amx0Z1lzU2c3M09oV0Z6RWlUL3JTTHNsbDNmd0ExTjRoM3JEYTI5d2VCWnJr?=
 =?utf-8?B?bk1jTlRRVUhPb0hyc0tEOGVQT2czK3FuUThhOEJoOU9KSWF6bzBpTTZOZXRX?=
 =?utf-8?B?MnRtWlVYMHJ1VUtydW1oQ0FQbWh4NHYvcTFmSk1nbm1QVklTQi8vY2dTZ1R2?=
 =?utf-8?B?bW1iTG9kb0ZlWDNra0l2OERyclNjL3o3Rml3bU5PdkcySmwyYlA2VTBZWnNo?=
 =?utf-8?B?Ni9CcDN1ZXJzQU1QQ202TlhMR3BBdVlaMERIUDdROWdTZXk4bFl6Wkw1MEVR?=
 =?utf-8?B?TjNOTlMzUDVPVHhpbVcrQ05nQjZueHZMaVJtQnR1UDR2YUZUMUxyd29wS1Yw?=
 =?utf-8?B?NGZlVUJ6cnREN2s1Nk1JT1ZkK2taclFlRFg0cHVGMmY1NkU0S1pxRmVra3NU?=
 =?utf-8?B?S1dxalk1NFBZLzdrTWxnNEpmWmJ0ZG5XQjdjYkhGMUVFMkRKd0wrTzB0b3NC?=
 =?utf-8?B?VWFHNmlRbWlLeXVhOWdzUE1pR2N6SHBOaTFsaVp4NU55anZBM2pxRVQ4NUxP?=
 =?utf-8?B?MmZENTdHUjFQbkhTV1pUTktYUS9hTzFYZkVxNXllQXVlaXhueHB2cTEwRnl3?=
 =?utf-8?B?eGVzcGpaN2JmZlNmRlFTbFVxSHAwS1luZSt5MExTUkN6T0VSOStyQ1FwQnJ0?=
 =?utf-8?B?MkRXSlJUVkFJM0haQVB2cFpXMDRJR1Vpb0tFUUd0M0FlZEgrVkdpL2JUejB5?=
 =?utf-8?Q?HF1X+J5fKJTFw9oMjF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70653daf-d7d1-43ec-992d-08de8b201e7a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:12:00.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF024T49ANTALzh7XzGMlybLuspQjYnzoVYwHSCbhaVqvYcY5ORQx7QOxH5hrR/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271969-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srneeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 903E43335DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/5/2026 5:16 PM, Neeli, Srinivas wrote:
> Hi Andrew,
>
> On 2/20/2026 7:06 PM, Andrew Lunn wrote:
>> On Fri, Feb 20, 2026 at 12:59:16PM +0000, Neeli, Srinivas wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>> Sorry, i'm not part of AMD...
>>
>>>> So how does the host send a frame out Port 2? Is there an extra header
>>>> on the frame sent by EndPoint, which the switch interprets?
>>>>
>>> In this RFC, I configured all switch ports in forward mode. As a
>>> result, when a frame is sent from the internal endpoint, it is
>>> flooded to both external ports.  To forward packets to a specific
>>> port instead of flooding, either static switch CAM entries need to
>>> be configured or address learning should be enabled so the switch
>>> can learn CAM entries dynamically.
>> Despite not being part of AMD, this part is important.
>>
>> I don't care about how the RFC works, i want to know how the hardware
>> works, to ensure you have the correct choice of DSA vs pure switchdev.
>>
>> Take the example of running Spanning Tree Protocol. The bridge needs
>> to send the BPDU out a specific port. What mechanism is used to do
>> that? It also needs to know which port a BPDU ingressed.
>>
>>     Andrew
>
>
> Hi Andrew,
>
> I would like to briefly share an overview of our TSN switch 
> capabilities and seek your guidance on the most appropriate Linux 
> framework for the driver implementation specifically whether switchdev 
> or DSA would be the better fit.
>
> TSN Switch Capabilities
> -----------------------
> Our TSN subsystem supports the following IEEE TSN clauses:
>
> IEEE 802.1Qbv – Time-Aware Shaper (scheduled traffic using gate control)
> IEEE 802.1Qbu / IEEE 802.3br – Frame preemption
> IEEE 802.1Qci – Per-Stream Filtering and Policing (PSFP), including: 
> SDU-based filtering and Meter-based policing
> IEEE 802.1CB – Frame Replication and Elimination for Reliability (FRER)
> IEEE 802.1AS / IEEE 1588 – Time synchronization (PTP / gPTP)
>
> Hardware Architecture Overview
> ------------------------------
> The switch consists of three ports:
>
> Port 0: Connected to the CPU (control/endpoint port)
> Port 1: Connected to MAC1
> Port 2: Connected to MAC2
>
> MAC1 and MAC2 are capable of transmitting and receiving PTP packets, 
> with received packets stored in internal BRAM. They will not be 
> forwarded by switch to the internal endpoint (EP) and MAC network 
> drivers xmit's and receives the PTP frames.
> The switch forwards frames based on VLAN port membership and the CAM 
> entries and switch supports TSN features such as CBS, Qci (PSFP) and 
> 802.1CB (FRER) through hardware configuration.
> The CPU is intended to operate purely in the control plane and is not 
> part of the forwarding data path.
>
> Thank you very much for your time and guidance. Please let us know if 
> any additional details would be helpful.
>
>
> Best regards,
> Neeli Srinivas
>
Hi Andrew,

Based on the feedback so far, I am planning to proceed with a switchdev 
based implementation for the next RFC series, as this appears to be a 
better fit with the Linux networking model.
Please let me know if you have any concerns with this approach. If this 
direction is acceptable, I will share the next version of the RFC series 
accordingly.
Thank you for your guidance.

Best regards,
Neeli Srinivas

