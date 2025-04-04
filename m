Return-Path: <netdev+bounces-179305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62250A7BEA2
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C7C18879E5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D8B1EB9F4;
	Fri,  4 Apr 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBPReOJZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254342A87
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775433; cv=fail; b=UgBi3gRFvVeVvi6xxviwzEqc+V0sjmAEnK9fjFAl/46DN6G26jGRY1JLut10fNJihlyMk7C4LbqkfMn6PS2pW3ULk2ydeOabOKSDQP8SJVe41TKxNCWhRQWSocOUY5kLi1LP2lbsT6xTbF+/8bc2YAilmVF6m+8OfEsfbDssW9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775433; c=relaxed/simple;
	bh=1+acajrdKUZ/wqIQtMPuU0Rh9FRksiK8qpKKsD3Og5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOy4FkRAnary2ooWf49IH/rlwB7FmjU1UYCJqRHnNkWrS+B6rdD9mGrzyuyp3Lqnt/fMzdcrEtjVIxj8tyn1rFcRAuQo4VsZStICZBEIdLN1wPGYEmIyQ4TWpCLJGx8mWq0igsjZ3tSyajTfwUZ1TTGNki41+xxVaN7U/PBa1fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBPReOJZ; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7ZDfSR8SVrtLXsBQ1Cl5AOVVkuz5V/7Eu0teZtEUF14G5LM7efyunRAPEIjS4DhF27nH37sU7lruUIQ9QX68JJZUuYBvExov0A8zdLOiQSLB34LHZi4anrQnKL+gOemKHGG8xhFyWjTR7ACH4QZ4FiSYRG637Zthkv0FbJ+JLkmdbVnPbKTzvN2ZztV/8g3BAOVAVyJMfpapeyb9QPyju5x22ZJAxfhfDeahlx93SNJIU50YixO0YzV1+AXn0gP8uE/lINOMWJO74EI94QEoRVCWbxjvSFp9PFLaayGNG3r+4+OhJ4I+s6jDXRGowbiDqiHV1Tf5pN9KyowLlIFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+acajrdKUZ/wqIQtMPuU0Rh9FRksiK8qpKKsD3Og5E=;
 b=H7U59AC1sEg6wWN01KRvZocWAUESZpMv0Qje7IAA9bwriCQ4/HcxOLQVity3y8FB1vQRxrg4jVGxk7bDtOUmBpy6PrBE/qEw0EJ77ODZFVJ47ZAnUuzVZ1kaGd20GZ44/JKhS8+gv/c0j9sP38v2BPYcWKLQngzM/hdLxKaCNnG8Ty7bOzPxR/KmuCcOQhaF8Eboq9NfOztccMek3ZjmXtXaoJK7ElMVuaB3nsBpZWNsrSHXfKXBKTLDj1QX2khGEzzN7tqMGzpA5k+yYvQDlfEKoESjDQ1oYop+NKAT0QEdn/7dn5SN3HeugV/1oA3ePoDA9UvDfu79FJUH147iGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+acajrdKUZ/wqIQtMPuU0Rh9FRksiK8qpKKsD3Og5E=;
 b=EBPReOJZ5SqdZb24Z+MbjN+5F3kkPLhKkPqrck8PBb35nwDzoCMwNwDWOlkeo6xilHE3yZRESsSWBZAj6C7JHlB7MGr6Of/FrwFhxzM9zmhFXKEbPOpk3ROpE/c90dfGQsUo1hEGB2B0OC22yXrtk9cGV+7qfmBHUg9qh+eDiGCW9ZixBUjf6A/7SRLDWuZW2Fw2goXO8CpfEdWx6vPd9KFf4EJLvSWnFbBVy87Z9qBrQWohHCogqXBN9yMWEFQpBi0lSoOW7+PdDPCI1xCGuTUfmHCbI65y2HH7vKZmCd92vIuzy9EDr9/2VSvXHVb6Y8pznX7q0XHZk/4PGuLbCg==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 4 Apr 2025 14:03:48 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 14:03:48 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: another netdev instance lock bug in ipv6_add_dev
Thread-Topic: another netdev instance lock bug in ipv6_add_dev
Thread-Index: AQHbpBgNsW0Cw2ElFUOEQjFKH76LcbORA5IAgADrjwCAADHJgIAAX4gAgAEMIoA=
Date: Fri, 4 Apr 2025 14:03:48 +0000
Message-ID: <1b244bc366ff8843d88fa74866faecbb9ab85605.camel@nvidia.com>
References: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>
	 <Z-3GVgPJHZSyxfaI@mini-arch>
	 <c4b1397ffa83c73dfdab6bcbce51e564592e18c8.camel@nvidia.com>
	 <Z-61sxcLSA6z9eoy@mini-arch> <Z-8F1qAvQDGf9SXV@mini-arch>
In-Reply-To: <Z-8F1qAvQDGf9SXV@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|IA1PR12MB7664:EE_
x-ms-office365-filtering-correlation-id: 9faa05a9-bfa2-4c6f-239a-08dd73818564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjFXQ01BbzVXUXVPRHQ5dWRBbDFPWDFCelhzSjZVazlicXVXS21CU2U0RUEw?=
 =?utf-8?B?eW44S2xqUzA4ekZ0Tjh2R0YxQXZIdnJuUXZkMG1ITVFlOEZFZXgycnBiYVVO?=
 =?utf-8?B?aHZWUVVNNUgyR0dPcitEd3A1Q3hVZmVKWjI0eXBuUUNzWG1aMnduVWoyR0JG?=
 =?utf-8?B?SHZMN29WczJ5R0d2TlFFNmtOWVFRd1FTc2tqUW14WkZRUk9YSlkwdFl2cHpO?=
 =?utf-8?B?K3BQODhWZUlqTnlkbjBoRjJmWjBuc1B3OEppSWdtVzJDZkh0T0VSemNVR1BU?=
 =?utf-8?B?dUV5cEs2UVdtTFZpUUROS1RtV0lxYXZoR1pwVWF1ZXdGdExHTmV3aHNPS0lp?=
 =?utf-8?B?OFJDTHF4SmlRZklRaTluL0YyWWtvUEx0YjZQUnN6NUc2b3B0UjYyMVBxL1pL?=
 =?utf-8?B?cmpydEhnb3NYM2tIeW1QK2dtR2Q0S3UvaDVmaUtNeENVSkxDTm5QQ0ZPMXRi?=
 =?utf-8?B?SUJPWC9vUElkeW1NYm4zZk9JN0k1NVJ5RzJpRWNHdDFNeHBMeE0vL0ZFMzZl?=
 =?utf-8?B?SmFrYjFuY05tcDY3T05zZjZpRWRZVVhqNWIvMDFTUlI4OHVObktKU3pYTU9F?=
 =?utf-8?B?Q2pDeWNTSnQwSm9MNWI3dnVZMWFOQVJ5WGxSQ3NTOERjNXRrZVNjWGZzOCsx?=
 =?utf-8?B?V0ZreklRM0tpMnVqZHpPTmdSRkFZdlVMYkVVK042UjZRNHp0cVpTQkRTMnlj?=
 =?utf-8?B?WmZ3SU5DNDN5VWJIRFhuc1BxWkNsZ0RkK1YwZGQ5R1Jod3dCRnVtQUxPQ1Ez?=
 =?utf-8?B?aUJCcFZ3QWdtNFM2Q01wWlhIYzkvbTVoL0JDVEhtWVc0bFpwLy93M0kzOFZu?=
 =?utf-8?B?UXNWMGhNN1UrSFFIbGl5dTJYcnh1VG55eUNKa1pFVTJaRWFKTDBwdnVFUEZv?=
 =?utf-8?B?RUdvK3lOQk9OeEdOZzhSdE5pYTZLMG8xZ2hESFZWZGlBMGxOUWx2Wm9pdk4y?=
 =?utf-8?B?NFVYMFZ0dDVxT2ExSFhGU3BHcWtSSXNlV0Yya0UxR0dLUENweW9UMk8yUE5n?=
 =?utf-8?B?enJDek9XUHhPZEJUbG1OeUNEMWtTL2lIbVdIZE1QK1YzNTNMMFlwY3JodGNv?=
 =?utf-8?B?VWtVZ2YzbUZ1emttTzBDdDBmR2pQNngvenNtdk03V2pFbEtzUm5rTVhnMXJn?=
 =?utf-8?B?Y1d1UFVvN1JNK1hJTUNqRVZtT2RlNGpsc0oreVNDUGczTlQ3T2lLelB0d25F?=
 =?utf-8?B?bDlsR3NyY3FtRTJDNld4WnU5TDRQTTBYZ3M3ZkNRb0gvb0RUdGExUUdHZWtk?=
 =?utf-8?B?QXgyNlM0V004VlpQZUZyT2ZGUXJKNTMzbjVJMERqbm50cjJxaGx6VWpnWEMz?=
 =?utf-8?B?SDNleXZqaE1LUkhnL0x3WGtITVF6NzlaaTVZV3piQnlvSjV3M1pjYmJoUnBD?=
 =?utf-8?B?UDRTUWpKQmc4MHRMeXlzbFd1ZW1BOWd2YVhRbm5JRHhjb0luVnNFNWx6RWMy?=
 =?utf-8?B?enBBQjZNcHlFSUZpMHIzeWhHTlhxUlpscGpTS3Z3WkhaQU82YS9TcjBEZVFO?=
 =?utf-8?B?OHVkcHVScnRUTDJzTDRxWGtwTmRsOTdQMUg4OWU2ZDc1ZE1ZOElGUU43WVdr?=
 =?utf-8?B?bWhnTDVLc3hnUXBnckZvbm9JMlpoNDlaaHFoWFZBVXcxb3Q1YW9ZZTJWZ2hM?=
 =?utf-8?B?SUdHbUdJT0VINzlxdTREb2FEaUlSRzVFOEdUL0xUa1hzQjlJQURVaEt4eGJB?=
 =?utf-8?B?bldWamd1UVVmRDkyYTFpMUdGT3hTd2tIYWpoODlNeThOUHR2cGdXS0t2VldE?=
 =?utf-8?B?U3ppNzQ5Y0RlODQxSjFpL1g5alJZNCtzM0pXTHJZWmhwMzVPUzB3L05tK204?=
 =?utf-8?B?VGRtR0s3NEQyVW1OYnMzSmdrTXlCS1NySVdQckxFcE9WTTE4ZVJ3THVwVVdw?=
 =?utf-8?B?SGQrczhaUTV6WXlFME5mMy9Lb0pEUnhpOTNXTk5meTF5Tm1MWWxoN0Ryajhp?=
 =?utf-8?Q?ieBvWPpxJh9bmosEU8DQ1+xk2oe+DSB9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZktqaVg1YVhIU202ZkV4VDRxT0hGMHg4VU1jc2Z6TDcyVFh4aHJ1VjhIU045?=
 =?utf-8?B?eTdJaytBTWNjeUk2Y0l3WUlHd1E1akVnZ0ZGeTVzTlQ3bkdrT3RaT2cyOWs2?=
 =?utf-8?B?eVc2WjhuejdlWWZNYkJJZ3Nqam9PRXZnbktMUlVmSFl1eEZiSkp0ZzZCcDVL?=
 =?utf-8?B?NlFhcUtmTWs0MDlvS09lVm5SYmNhdWNoZ2syOHBkT3JJRmNxdkc1VHdkcU5S?=
 =?utf-8?B?M0Y2WU5TWVZqS1RQRDNHaG9oQlA1TiswMXo1MDdONUxsQTlhY2lCV3BqYWZ4?=
 =?utf-8?B?cXptb1hkYzBoc1VwK0lQZWthUXdnektsL3NEMXovSkRMVGVKdkVlNGZ0STky?=
 =?utf-8?B?S2J1VkI4SDBubjA1Y3lzR3JUWkYzZFJCTVFUamt3Y3Z1T0g1dUVtL1B0Ym9Y?=
 =?utf-8?B?WGZZampwbWxpMXpRTzVZWVpiWmtBLzJZOGdmaWdtRkRtWXdMUHhaRHFmejQv?=
 =?utf-8?B?bjhKNzM0aWt4dTZCWTQ4amlMMm5ER2NxYlhiTmNoRjFqRWNINlFicDRPSDM5?=
 =?utf-8?B?UC9WSjJMUDBVODBEcWtNdEVaUUJwd05BcEsva1hxSDA2bTI4MWhXUitiS25J?=
 =?utf-8?B?WGxJdzFDUU5DZkROTWVmaWhCbUpwUzJrdXZNd2RvQWs0ellBZFpxRHZmMlN1?=
 =?utf-8?B?RFZyUDhPZDlpaFNaYXcwTGxISXdwUlRhRnZsdUp0MUxFWFU3USsxSHpyb1Jk?=
 =?utf-8?B?RTNGdW5INzhkQnYybmovRTMrQkY3ekNXaVo5YStMVmFHdkYrN25PZndTYUdW?=
 =?utf-8?B?cXB5Z0xqaUVXTnFpeUwrZUswVWx3ZitFNThQQVhiY2daZUxxL3Vlb1B0S3Q0?=
 =?utf-8?B?L1h4Q01IOGM2SkpiUmQwRDA5ZGY2bVR0RWQ1RE5pVVdoNHJET20wOFpmdDg2?=
 =?utf-8?B?Rmg1ekplRlVpOXZLNThac2RXSkppT084REZ0eDRYQTA3ZEpvNkllSEorREdo?=
 =?utf-8?B?WldPWGF1OGd3NExMNkVaMjQyOFliLzJPb3dsbU1iRGdVdHZVMUxIL3ZTVUxT?=
 =?utf-8?B?SUg0WXIwdXV6ZTNTSVhTSXA3NnJVUnAwUWZaRXhkRmlUUlNKVTNDUDJnamx1?=
 =?utf-8?B?elJ0TFZKclE5NWU5Rkk0bEpBYncyelEyMHFXaUM4aG1RVFE2UUZPZloyR25F?=
 =?utf-8?B?c0pQbVhGMUlQMnZacEhvMGxONW9Eb1hXWEhGa3RhcFUzRFNabWkzbFpESkJF?=
 =?utf-8?B?djlKYTRLYzhxQS9LRHJ6aG1jZGQ1T25HM3NuOWxzOGVITHUzUGJOYzJZZ25i?=
 =?utf-8?B?czdIVHA5ZDlSc21sZ0VpcnlRa0RWT3hEODVEcHBReUd2NzhTNEh4bDhnTXJL?=
 =?utf-8?B?Tm5SMzVyOTZDQ3dZRHJYY01RV1NmQ3N3UUhYOWJscWJmdWxMdkRXY05mb2w4?=
 =?utf-8?B?MFpRM3lSR0h0dFI3Vzd3V2NWeG9ZRFkwMWxHaUtHMWZFZ01ydzVtVklWSktr?=
 =?utf-8?B?cGtPQzA0dGxYTFdVU2ptWnhoZ2xlaHpOeTIzUjYxclBhOXFkYTVHKzVaRURL?=
 =?utf-8?B?bWdNZGduTWF2UnEwVEw0UzA1cWplZHdFN2x4QVNoTFR4VG4zUXFNbVhoRHJr?=
 =?utf-8?B?bUFxUkRyS1RHVFErY21GVUZNQjZDTkpRdk5Fa2dKZzFucTIvWktxa3hxU09m?=
 =?utf-8?B?YXZaUWxmWFhHVVcvUytaWm81WG8zTFBEUnVabVVMUXVUTEVZUUh2Szl4TUJh?=
 =?utf-8?B?dE02UEFlOXlyL2N3R0ZqSm5XWlovSjVhUXBaVXJKYjA3aW9wcXI2TFk4R25C?=
 =?utf-8?B?dGdDemlGN2pMZzE2NDFhdWZoOGVBNGtCWExWUkNvZ1NSZkVmQWdXMUNBanBS?=
 =?utf-8?B?T3JLQWZXalZkbVA0OVFjY0QrbUd6Sm9VRlM0L1plVjgwOGhYeUNJWjVaV1Bz?=
 =?utf-8?B?RlhlelcyRkZZSWkxWFRoQjlOdVNueHV1d3ZtaWoxYnJrNklEVG5rd2REOVkv?=
 =?utf-8?B?Zzl3SkZjb3BDSDdVQUFnVU5GTnlPVHJtMU5TQ0JSOU1RQ21iMXduZm1LK3FT?=
 =?utf-8?B?Q003cXdWeEpZbHRFTGltTytkNXBUZ2JhbnJDclFYdFJOYkF4endWOWpnUHJp?=
 =?utf-8?B?RlBabGRhMEVaSWFkZUJUVklaaGxQVHlESnUzNG9HSzdZS2xYVlpzYkVqQWNJ?=
 =?utf-8?Q?Pv75Fp06ltEDGV+m9agSW68Tz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBC87C8B1C6104EB133006F0B5908EE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faa05a9-bfa2-4c6f-239a-08dd73818564
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 14:03:48.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz+IZlRvI/7aooMrid4eYPMk7Fk8m5ZJyk6ncy+e2SCWT2apHtLrdTnmWKgtKaEs0/W9++s02HeDkYPKLZcunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

T24gVGh1LCAyMDI1LTA0LTAzIGF0IDE1OjA0IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9rLCBzbyB0aGUgZmluYWwgcGF0Y2ggaXMgZ29ubmEgbG9vayBsaWtlIHRoaXMuIExN
SyBpZiB5b3UgY2FuIGdpdmUNCj4gaXQgYSB0ZXN0IG9uIHlvdXIgc2lkZS4NCg0KSSBwdXQgdGhp
cyB0aHJvdWdoIHJlZ3Jlc3Npb25zIHdpdGggbXkgcGVuZGluZyBtbHg1IGxvY2tpbmcgcGF0Y2hl
cyBhbmQNCmdvdCBhbGwgZ3JlZW4uDQpUaGFua3MgZm9yIGZpeGluZyB0aGlzIG5ldyBpc3N1ZSEN
Cg0KQ29zbWluLg0K

