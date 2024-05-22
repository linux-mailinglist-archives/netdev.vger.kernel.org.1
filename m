Return-Path: <netdev+bounces-97555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277158CC1C7
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9210A1F219AB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860E13D61A;
	Wed, 22 May 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BoQicW9L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE7757FD;
	Wed, 22 May 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383329; cv=fail; b=N70/k6yedKlFFlDP5G+EVldkpcw0S0Lwk6iKt8P4OslcKMtU+wg1P85lZvfgif2YR/l07OrX7dW/ym2H4oYQN7te5825tgh6kAqzTUbDMqLtUy9bfJIJoNrrikaBbq6IWMzIc45xp0FslDujcc/fG9zk47EDM38H7ljMESo3who=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383329; c=relaxed/simple;
	bh=ZdPSLdZdShJ7mA/Gi598kAujyTuH6FQBkOjwdoG2/CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xqu6tLauEwRfEZTnDD/FBdMRQ9Y4lpwmIXGukAbI2ecCpVZhskESKdxalbMuwHRzXrDZ9/vEvUJ5GbePHyMA5wfi48abk/evEy4H6TSCID3+CSvL+X1LQfB7lb9C8ct/EDa9YnenrDv3r8ShcRtJ/bxNWAmfIoUpOjfr902hoYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BoQicW9L; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGFAqAr7UumUE2V+nbuX3p0m7mRNe1hQjK9sA7R/zd19eGeKsC8r/+M7VKTYGLuHO5+mLKEi7G6LyrZBvI4kaYjGNX7odt4unuNzcBwES5xmRiuLJU6qHYMVV7S6mF4LWa96zeVivegEGotUtp7tkmV0j+/LpriVOcEnNa3RU/8Wy3ORjdlpYVDzXrYAbMY5CaHDxW46feTicPNVsBpfqf2fg5UJsJVXav3bGK0AiG42sIYWpPmZWiFVS/JVhP9c6F6HhAO6YvBjLK8StbMpPB5+UiynHuuMZNXyRU7gZjZPFrv84J8Fw6eJs9OoqH61+nHv/eWevqB5z64sfdMuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdPSLdZdShJ7mA/Gi598kAujyTuH6FQBkOjwdoG2/CA=;
 b=goy+54FhxnofIyPtO+nirjCojxadKNYvMpFOtM3WD2K505FfbZpGA5hVEV8S4X5mc9CNznSF8M1lXWN7pt0hbthGG+BoN73olA1foPlQS75ph7kkhbVj6oQUyWm/qYAx429P7gEEF65GIvL6Z2BwkDWORfDEpXZ/gHNGh5r0PM8WGBpfFOtl5salh9I/byn3BbcoBUtgTxBkhWM+5A2ZW89lvS6Usb1N1m6dpDlX7BlC52DInESuge/7YMYtuYXPws0667904tnP+kfd0wj4AWEo2tDwOqmTE3yT0WW1w0/anf5KP8K+fa//dzyXtfrd3sT3y9xn6EaIjKrYdBdVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdPSLdZdShJ7mA/Gi598kAujyTuH6FQBkOjwdoG2/CA=;
 b=BoQicW9LesR2Fv952k+2Q2+2XQ0VM4+0wR1tKeGXFRvpaIN+V8MCAH4G2Si8Vq5feq56aZoDXSSL7b3WKdaKNysmXRlvDk+zC2AOO3NpsZmyU/H0CvBwsVpVZN89wfA43O8pcVvkaqzjOJWMPAcaUmhJ089Y5JRjcYw4AXrhui0EAvowKlEmW8C98TGVx48fn8woD6Z+mrubucISQ+6p5qFAnM6XcjPuSMgHlLiTj4YjhA00bumFt3/2d1JpLTJMROvoBhVjVYnxk1iKpZEYj9XtVYN32uEqm6bU4X2UPu4AbmAyPaB3D6ixwiut5YrCtYKMFaoAmRkn0BHBIT5PaA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 13:08:44 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 13:08:44 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: RE: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Thread-Topic: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Thread-Index:
 AQHalku5+CuUOiSJUkSAUJYGzVV2UbGAK5kAgAD6ZCCAACA7AIAAxpYAgABw7ACAIJB2MA==
Date: Wed, 22 May 2024 13:08:43 +0000
Message-ID:
 <DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>	<ZjH1DCu0rJTL_RYz@shredder>
 <20240501073758.3da76601@kernel.org>
In-Reply-To: <20240501073758.3da76601@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SJ0PR12MB8140:EE_
x-ms-office365-filtering-correlation-id: d70f0eb3-4580-41f2-ebf5-08dc7a604efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?akxOOHI4QTlneHZsZWQxRkl4aE9iYnpyVG5zNVFDUlhXSHdtbWtXL1VkTWcy?=
 =?utf-8?B?V2ZGSk5XMHg4S0tFSUJhTXRPR1hyMklXOWIrRzFUOExXOTg0NlBEQTg3bjBF?=
 =?utf-8?B?a2NHa21yOTJvNE5FYzFRdkxSa0hFRFVvbklBUEo3cUhsL2NkV3dUMDFpZXMx?=
 =?utf-8?B?amVlRnRwVlBGMDZkQmZGNGU0c3dqOGFyWlNPdWZ1TlZ2TmN4Z1M5MzdXR2hp?=
 =?utf-8?B?ZVdBV2tpQlp2RytsWnIyeFR4cStSSlJ3ZGZyY1VsZEw0VmFNM0xDMkl0L25p?=
 =?utf-8?B?eDdMYzJOQSt0dnVic3dsMFdCVkV3SDJYMkhPcHRqUk93cnBTMXZtWWVuZzhz?=
 =?utf-8?B?NVZ4YmxZVndhL0VXanVwdVhWMGw5dG9jVWt4SHNEc2xydDAySllhUzVoNTFO?=
 =?utf-8?B?VDZOM0lWM3V3NmVRSGdFcWJ4Qy83YmZJQjBGeUZ5dFJsT2tmR1NycXIzSTE4?=
 =?utf-8?B?YUZMSE1SRVhJOGEwSVQ4UndnSkxtQ1Zkb0QwTzQ2d0ltVjlQUVRNbm5aWG12?=
 =?utf-8?B?RmtmMHJWa3hNQUZNT29tVnphcjlOTDVOSlNsMnIxZlhHWk5HVWdtbFpIQUdm?=
 =?utf-8?B?SEZmY25yYjNtR0MxdHBzTnk0WGJLK3pYV3VvRHc5VXVXZHJnc3lTa2lJSXRO?=
 =?utf-8?B?eUwvTGZWR3p0b3VhU1lwcWlxY0lGTkZURThDd0JvdGhPNzJhVDE4bXkzOFVU?=
 =?utf-8?B?Ly9KTmoraklnc3lrcVpYejl3OVBuTUtYZ2ZJWnRncUNybkNjQ3pldXBmZlE5?=
 =?utf-8?B?aDJ0ZWpTREdkMmJKUmlLd3pPNEE2WWkzWHRSZkFFbWNWbWYwWEhkemJPYjJp?=
 =?utf-8?B?d1lkdUpOYWtQQWoxMUtXQ0p3SWpVTmthdjlEYnVoU0RQZUtRMVQ1VFBKUTBQ?=
 =?utf-8?B?WU1nbUpBaVNIUmZ3NnJUUUREcHFKamZHaTVhcUw1S20zeGFGd25kNnVEaXNn?=
 =?utf-8?B?OVFRSE5VdUIza0t0dmpFRzNZcW5tQkZMUW81T2JaTndQcXgreEtjaDJSbi94?=
 =?utf-8?B?WGlPN083d1ErRFNaOUs1azVPZTJKM2FkMC9YRFJEWFRVeENxbWt6WUY0VERX?=
 =?utf-8?B?TW1yZWFxb1Q1T1BzelRIVE5GRldVQXRXdFp4R01hNmZTMFFWeklFSWJjSWJO?=
 =?utf-8?B?TS94Zmo5RytiRFdBTU1ucWN6cGJjQ2hmbUgzMkN5NmUzdXlIZmg4NHh3YjE0?=
 =?utf-8?B?dUp4R25BL1dYTndTU2VhRWp4VFF0bjcyT2lVdmM5MWdQd2hVekludGJzNUNZ?=
 =?utf-8?B?SnZDSkVSUnpZV0R0V00vcWN0RHJLYUNLdjVNTk1WZTFISXJLRlNXRkxidjd6?=
 =?utf-8?B?U3I2Z2JiSGk0YmVQdVYrYUNpcW9sOEJDS1BOZW1NTG9hOVMyMXp0SnFjL0E4?=
 =?utf-8?B?VDcrb0NxUmZVclJyR1FOT0NHSDQ4cWErbUk1NWQ0NUlNSUNlZ0RDelc5TFNW?=
 =?utf-8?B?ck5xYnZ6MTlZMzBiaVU1ejlrN0R6TTVDdWxNM3Zpbi95VlFSdFJ1ekxFYVha?=
 =?utf-8?B?WkpINGdaYTRyMzZJY1FIemhsckhtMkVVRWxhMjh0bVIyRmVDNUhKWjVpamp4?=
 =?utf-8?B?Wk9mbXhoeDlaQ3ZZS05LRXExNHlCdDY4MkRqRDJXOU1PMDRTT0dOWmk1dVBs?=
 =?utf-8?B?OUZUaXVyVVBGeFQ3bTkwQmVZTklCTHJwN3ZXS1I2bUhpK2dqVzY0bDJNQ1lq?=
 =?utf-8?B?RGQ2ZGxOQ3ZtOFB1YXBoODVMQURwSlBDNldXSEd6NGtNbVRnZFZjUWZKQitF?=
 =?utf-8?B?Ym5QNWpzeVEwTFRCY0hCcXNQdnZlekdhTW9TUnlQQUFaMnN3Qk5Sa3grZVhK?=
 =?utf-8?B?Y2t4YWp1YjlxaUsxRE9Fdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlNwOGZGSXlxSk5QcTlEdTVOckNYZ1hHRlBNcTNIUlBsbjUxRzJlVGdWVzk4?=
 =?utf-8?B?R1FNOXhjNXgwMUxpRDZSRXUycGZnQ0tBUnh0bW1QTVUxdVd5dDc5NVBjUGht?=
 =?utf-8?B?UGtlQ1c3YXl1Ym1TRkN6V2xHK3dCcEMyUmFRaUFwc1F4bTBxZS9MdVVQdEQ0?=
 =?utf-8?B?RkdEYVdHck5EU282UW5wQnMycXM3endGQzk4MG9RV2FCZmVGR2RWYUV2K1A0?=
 =?utf-8?B?QkxKM0hIWG9QV0NCcEpOVEpxU28vNmJZandOcTV3TUxhN2h6R3RwNytXZGhY?=
 =?utf-8?B?YUEyZm9FamhZMTQrRktRcjBFVmhGWENOUUg0QWNoWCtkT0JDdVdzT2xkWktK?=
 =?utf-8?B?MzRDZlAvOHA5akhsQk5jRFZUVDY4MURtQmhzQ2dZNkVoTVJHK2xtM3RvYWcz?=
 =?utf-8?B?SUVDMHNPcXZsTExFaG1JYWN1dzRua3lXMXM4VzFYUW1kVnNET0hqenJPQ2d4?=
 =?utf-8?B?M0oxOS9YWTl6Qi9CT0Y4U1QxaFV1ZVV0Um1TWi8vQkJLUUQ2MnFYekg1N0d0?=
 =?utf-8?B?dkhrL0p0dmVGSDlrbFEwNzMxakwzenhSN1dPRlBKbEl4VEd6SHc1eDBMcnky?=
 =?utf-8?B?cHZzUGw1OWNEL0RFZXhRdFo4cHpuVEVkeUJadE5IMXQyMEFaWURiUDVGaEdH?=
 =?utf-8?B?TjhqU1JKUWw2czRvdDhFSUNkcis0SDY0WDdnZFFlMmtQNFdwMG5RZlA1V3Vp?=
 =?utf-8?B?aVZ1T21HVnhYSXZFNXNwTXpyaU4ydnhIQmdQbWRybTNrTkRVVmk1TDlaQWNn?=
 =?utf-8?B?Rk1KZ1NMTEVqQ0Y5MGpsTVpiNm1SWjAxZ2FUaEI2dEQ0KzlZbXNVQ3RiWFo5?=
 =?utf-8?B?NzhvYkR3Y3hSemJXNXFSS2JKWGF4bTVCU1B4dDVPZE9SRGlJWHhKZThBaTYw?=
 =?utf-8?B?S2dZS095M2krekU3QVFQVjZwRWxRN05FNVgzQnhxS0FwSVZHR01wdm95dXNF?=
 =?utf-8?B?ekh0UGhsMENYa2ZXb25LekhYRlE4SFZrdFdGT0k3WWhZRGFNRVJBbEtkVkRU?=
 =?utf-8?B?NzlpdnF5NkpJZ05FdEthRUhTODBuY3N2Qlk1TkE2V2p1dHp6cXdHTnVLWkRy?=
 =?utf-8?B?NnFUWStUUGdWK2VZNlVIbDJnNU5WTUE4OWtEYkc4Q050UTFuUlJTL0N5WmtT?=
 =?utf-8?B?aXZFNVY4dTRiQ2dvemZxeTNPeVRsYWF3SERxSVJrUUxUbXpPcWpUV2dCSlha?=
 =?utf-8?B?MThZS3dxVHp5Ly83a3dITkxwdW14WU1SUWtaRHhwRThOUGQ1YWErT0ltVVhi?=
 =?utf-8?B?Ym84MzRCWjJSU3czN3FmQ1hUVEVKakd3WG1FLy9ycmpnMDJvdmd6eXVJbjdW?=
 =?utf-8?B?L1dpZDZJNUZNZmNLWkNGN0xBVzFLZDZEckhFQ2J5NXI5dUc3bkFLVnVlQ1VJ?=
 =?utf-8?B?VWdWRjNVdlpDMWFmdmFMbk5leVVNMTZhMnNxcFFiaTZZcUlQbTFmYmQ5OXZV?=
 =?utf-8?B?WDVSQVJtZ1o5RjE3MFg1dWVsczZCR1JqM2JFV0J3d3NQdFlFSkxYK25CZ2lj?=
 =?utf-8?B?Z01jY1pOaTBCYzZwM2VOaStlYkI0cVluSWRXMmcvSDhaVFNwYTBSZ2ZWMTZo?=
 =?utf-8?B?bU5SeEtuSGhnOVZIWGpxZ0NHWGQyQ0ZIQWF5bGRMd2h0dEVKOHNlSU9kMDdC?=
 =?utf-8?B?RVd3b1hGUHp1NVdpYldHV09lRjlCWUZ2dHRuMlJhM0l3Vnd2N2g1Q1c1THZL?=
 =?utf-8?B?eGV1SEdxSHlJd1RFcEh4ZHZXeXFpMkRRMURhNllxSEx3SHNwbDdUUGxCR01m?=
 =?utf-8?B?MkM0NzIraUljWStZYk91VDRNNGp4cVRvT1d3dGF2ZmM0b3J2bHFvNnd1UDdN?=
 =?utf-8?B?WmxaTVBKYndvRkFqemlxSGpURVlFNnRpZGo2R01URWlZR1lReWVUU2dYVXBi?=
 =?utf-8?B?L1RONUVQaTM5aEU1QkJCU2p6NytQZGxLVGhlRWNFVVhHcHlKaGpYaWlvUldD?=
 =?utf-8?B?OVJpQkFuaWJIT3FkbXNEeG1tMUZsczI3bnFmZ0RiT0lMRXVGMDBGb3N2cXlW?=
 =?utf-8?B?L2lweFhtVzJBMVlJVHkvdkVHYjJFUm16TmI5aGpwRktxMnZsQkZYU1pLWkxv?=
 =?utf-8?B?T2hLK3M1dkYvRGZDcWNDUHhFWmxoa3dWTmNhTDFqU1FJUStzbTY2b0J1VWZh?=
 =?utf-8?Q?Oo/kCCf+4b8SmoSNkfjXP+bbc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d70f0eb3-4580-41f2-ebf5-08dc7a604efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:08:44.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qYcWHlJ2FIbgt2BeKqsjxyraqCSpTwmLMANZrYH3qv5UHfA3bVVJmsJ/E3vyLofp7JfR4XtisAPww0ByNKdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDEgTWF5IDIwMjQgMTc6MzgNCj4gVG86
IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+IENjOiBEYW5pZWxsZSBSYXRzb24g
PGRhbmllbGxlckBudmlkaWEuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+
IGNvcmJldEBsd24ubmV0OyBsaW51eEBhcm1saW51eC5vcmcudWs7IHNkZkBnb29nbGUuY29tOw0K
PiBrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tOyBtYXhpbWUuY2hldmFsbGllckBib290bGluLmNv
bTsNCj4gdmxhZGltaXIub2x0ZWFuQG54cC5jb207IHByemVteXNsYXcua2l0c3plbEBpbnRlbC5j
b207DQo+IGFobWVkLnpha2lAaW50ZWwuY29tOyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IHNo
YXlhZ3JAYW1hem9uLmNvbTsNCj4gcGF1bC5ncmVlbndhbHRAaW50ZWwuY29tOyBqaXJpQHJlc251
bGxpLnVzOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGENCj4gPHBl
dHJtQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjUgMDQvMTBd
IGV0aHRvb2w6IEFkZCBmbGFzaGluZyB0cmFuc2NlaXZlcg0KPiBtb2R1bGVzJyBmaXJtd2FyZSBu
b3RpZmljYXRpb25zIGFiaWxpdHkNCj4gDQo+IE9uIFdlZCwgMSBNYXkgMjAyNCAxMDo1Mzo0OCAr
MDMwMCBJZG8gU2NoaW1tZWwgd3JvdGU6DQo+ID4gV2UgY2FuIHRyeSB0byB1c2UgdW5pY2FzdCwg
YnV0IHRoZSBjdXJyZW50IGRlc2lnbiBpcyBpbmZsdWVuY2VkIGJ5DQo+ID4gZGV2bGluayBmaXJt
d2FyZSBmbGFzaCAoc2VlIF9fZGV2bGlua19mbGFzaF91cGRhdGVfbm90aWZ5KCkpIGFuZA0KPiA+
IGV0aHRvb2wgY2FibGUgdGVzdGluZyAoc2VlIGV0aG5sX2NhYmxlX3Rlc3Rfc3RhcnRlZCgpIGFu
ZA0KPiA+IGV0aG5sX2NhYmxlX3Rlc3RfZmluaXNoZWQoKSksIGJvdGggb2Ygd2hpY2ggdXNlIG11
bHRpY2FzdA0KPiA+IG5vdGlmaWNhdGlvbnMgYWx0aG91Z2ggdGhlIGxhdHRlciBkb2VzIG5vdCB1
cGRhdGUgYWJvdXQgcHJvZ3Jlc3MuDQo+ID4NCj4gPiBEbyB5b3Ugd2FudCB1cyB0byB0cnkgdGhl
IHVuaWNhc3QgYXBwcm9hY2ggb3IgYmUgY29uc2lzdGVudCB3aXRoIHRoZQ0KPiA+IGFib3ZlIGV4
YW1wbGVzPw0KPiANCj4gV2UgYXJlIGNoYXJ0aW5nIGEgYml0IG9mIGEgbmV3IHRlcnJpdG9yeSBo
ZXJlLCB5b3UncmUgcmlnaHQgdGhhdCB0aGUgcHJlY2VkZW50cw0KPiBwb2ludCBpbiB0aGUgZGly
ZWN0aW9uIG9mIG11bHRpY2FzdC4NCj4gVGhlIHVuaWNhc3QgaXMgaGFyZGVyIHRvIGdldCBkb25l
IG9uIHRoZSBrZXJuZWwgc2lkZSAod2Ugc2hvdWxkIHByb2JhYmx5IGFsc28NCj4gY2hlY2sgdGhh
dCB0aGUgc29ja2V0IHBpZCBkaWRuJ3QgZ2V0IHJldXNlZCwgc3RvcCBzZW5kaW5nIHRoZSBub3Rp
ZmljYXRpb25zDQo+IHdoZW4gb3JpZ2luYWwgc29ja2V0IGdldHMgY2xvc2VkPykgSXQgd2lsbCBy
ZXF1aXJlIHVzaW5nIHByZXR0eSBtdWNoIGFsbCB0aGUNCj4gcGllY2VzIG9mIGFkdmFuY2VkIG5l
dGxpbmsgaW5mcmEgd2UgaGF2ZSwgSSdtIGhhcHB5IHRvIGV4cGxhaW4gbW9yZSwgYnV0IEknbGwN
Cj4gYWxzbyB1bmRlcnN0YW5kIGlmIHlvdSBwcmVmZXIgdG8gc3RpY2sgdG8gbXVsdGljYXN0Lg0K
DQpIaSBKYWt1YiwNCg0KRm9sbG93aW5nIG91ciBkaXNjdXNzaW9uLCBJIHdhbnRlZCB0byBzZWUg
aWYgeW91IGFyZSBvayB3aXRoIHRoZSBpZGVhIGJlbG93Og0KDQoxLiBBZGQgYSBuZXcgdW5pY2Fz
dCBmdW5jdGlvbiB0byBuZXRsaW5rLmM6DQp2b2lkICpldGhubF91bmljYXN0X3B1dChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCB1MzIgcG9ydGlkLCB1MzIgc2VxLCB1OCBjbWQpDQoNCjIuIFVzZSBpdCBp
biB0aGUgbm90aWZpY2F0aW9uIGZ1bmN0aW9uIGluc3RlYWQgb2YgdGhlIG11bHRpY2FzdCBwcmV2
aW91c2x5IHVzZWQgYWxvbmcgd2l0aCBnZW5sbXNnX3VuaWNhc3QoKS4NCidwb3J0aWQnIGFuZCAn
c2VxJyB0YWtlbiBmcm9tIGdlbmxfaW5mbygpLCBhcmUgYWRkZWQgdG8gdGhlIHN0cnVjdCBldGh0
b29sX21vZHVsZV9md19mbGFzaCwgd2hpY2ggaXMgYWNjZXNzaWJsZSBmcm9tIHRoZSB3b3JrIGl0
ZW0uDQoNCjMuIENyZWF0ZSBhIGdsb2JhbCBsaXN0IHRoYXQgaG9sZHMgbm9kZXMgZnJvbSB0eXBl
IHN0cnVjdCBldGh0b29sX21vZHVsZV9md19mbGFzaCgpIGFuZCBhZGQgaXQgYXMgYSBmaWVsZCBp
biB0aGUgc3RydWN0IGV0aHRvb2xfbW9kdWxlX2Z3X2ZsYXNoLg0KQmVmb3JlIHNjaGVkdWxpbmcg
YSB3b3JrLCBhIG5ldyBub2RlIGlzIGFkZGVkIHRvIHRoZSBsaXN0Lg0KDQo0LiBBZGQgYSBuZXcg
bmV0bGluayBub3RpZmllciB0aGF0IHdoZW4gdGhlIHJlbGV2YW50IGV2ZW50IHRha2VzIHBsYWNl
LCBkZWxldGVzIHRoZSBub2RlIGZyb20gdGhlIGxpc3QsIHdhaXQgdW50aWwgdGhlIGVuZCBvZiB0
aGUgd29yayBpdGVtLCB3aXRoIGNhbmNlbF93b3JrX3N5bmMoKSBhbmQgZnJlZSBhbGxvY2F0aW9u
cy4NCg0KVGhhbmtzLA0KRGFuaWVsbGUNCg==

