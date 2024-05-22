Return-Path: <netdev+bounces-97573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52E8CC2AD
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58870B23B3D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E51411E9;
	Wed, 22 May 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQu+F8Pb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E213F44F;
	Wed, 22 May 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386176; cv=fail; b=Ra8HbKH68auAbgmY5+O/8Jvl26XEehjC1rSDKMMfaCCopUl5UH5zJtE1J65Mo2BLfzjRxXbx+r281I2jv3HRmOR0e/JxblOlHd7R7usDm/CBCvWO0CyBqjzhfbzh/p8T+qBGf6gIh+O/a4io4Fve8pjtjBC7ac1x+/yfeqqGgUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386176; c=relaxed/simple;
	bh=NZNBD6dj6GZ4NeL49e4hYTVGalturaOLqDxPTmdMrVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHWzXnYdjiVvdg4+pfftuDKBMLz1taHWJOPXgxzGIuoHOb43bjFlYkR8jdqJHygKf4fP3ZRijRIp1/JmDi0u2IctqTfoE4WtynJ6dtBdFMhQKkEov/tFchdt/VZCKHrHrQ4XPuBP8VEzIjTA+u6Mh1NyGjmEuvduX43z/gD4sSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gQu+F8Pb; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avs0IzqAgt1pDA+PzRgGcxElcJl2iG57PHo2MlX5ksu1OVcdsGU/j3X3UrYpFadmQR9bNVAbAdagx6Q1YJM5+YhNzCjT/Q+hG+m6RZPUAE87AiMZPaLBj58ZWmZgOyyPxxD0g9DS5T4l5BpyoHCqOpNsrEAzvtoJ4oEuk+paCaDF9eb/UQI0vRd2wpiQ+xUEt+ChxKFBVRDZZFsO6x0faEvubP5Lmc0Z2tOAkGjEowE1JCrRzb8x/lq7wVHLKHpZOoQ8dq4jW512Ad2+pR1EVT9f8neeZVz9MUd8879zKnNBcPWMsJjXUvKu1wtiKuj3epAU7OdZCQevCYAA0bdjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZNBD6dj6GZ4NeL49e4hYTVGalturaOLqDxPTmdMrVU=;
 b=NjTzsacB1wkF/+JqrIcifjCEiGHfUmvENodal/V74pHqmocQXYVqd6uGM/M+b3djg/nD6C+FWJizENw9GoDXKT1PPmuwiz93QxWjxDCr9ndMlZiE8DiTujOfYD793JYpelqMy5A2t3gYoHa+ZK4FR6lrRYrlwa+yyohAQZ+aY2OTSH1BfL7aMNOS8UZh7v67MFoqUAxKXYMOH1zJFi2ASOVbd1+p+yjyG4otgbqZyX0VXYM9BdW19z5nlRCLhfiIq6vsLACrEir7eq5qBwXggOuMtx0ovzrchA5UBkIw2N8AqoaFuyGEp/TjwpdgT2mAWFNgexbNXq6DXsKXhjN8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZNBD6dj6GZ4NeL49e4hYTVGalturaOLqDxPTmdMrVU=;
 b=gQu+F8PbxVLMqL+BdnT7b3c5B6hDH6FRUD/pH9GB8bHwPKduAZMKVbbB92ezTfWqETvpk7oMvIkxlcp0dpJHJNroF4HtL2R523yNpWW6h7vhbRld+y+/9fELrvMVHyxHFdmRaA3Pk/XCBIXkkiWzuZCvdzAzprAd94q21Q/NRjau5sPdVLIYo6RbHoeWc17GiT6Rfm3bVHBGgZUCc8/UTLH+lxJBrC9bbULhWAJDxrd3eSyRiumrpl+blLSxjJ89IksoUpCkLp0OYXdi4ilq/5ZIhmVfP19yp6vfqnlTybNOe8DQpDcrnUxYFRD4qbNel566/a5mM3YHDyP+DwCixA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 13:56:12 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 13:56:11 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
 AQHalku5+CuUOiSJUkSAUJYGzVV2UbGAK5kAgAD6ZCCAACA7AIAAxpYAgABw7ACAIJB2MIAAYcqAgAAA/6A=
Date: Wed, 22 May 2024 13:56:11 +0000
Message-ID:
 <DM6PR12MB451677DBA41EA8A622D3D446D8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>	<ZjH1DCu0rJTL_RYz@shredder>
	<20240501073758.3da76601@kernel.org>
	<DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240522064519.3e980390@kernel.org>
In-Reply-To: <20240522064519.3e980390@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DM6PR12MB4058:EE_
x-ms-office365-filtering-correlation-id: bb74d0d2-267b-45b6-8c39-08dc7a66f073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0tOaElPWkk1bFArd3M4NWExaGNlbXNoTUlaQXZwL0drcUFiMy9sZ2c5cFQ1?=
 =?utf-8?B?TDdDWGtnelhON1dacVl4TnU2Z3AvN3pDRnhVYVV1RlYzREVVcTR5MGxFN0Z2?=
 =?utf-8?B?ZmpLMUxYQUI0S2FKbE5aK3F1UDNEMmNMdzhTSERlaGtRRGZaNUNkSHRiL0tG?=
 =?utf-8?B?SEs1ZWx5dVQwQ0ZMMkltcEROU0JEczFsS3VlSHZhNW9kOC9ncy83cm43SmtS?=
 =?utf-8?B?Q2VGSlY1aGdtMlVRUlBobEdSZnFRWEplWWJJcENUS3dFNytjVDcvOUdjcGtv?=
 =?utf-8?B?L3dha0FscEo4aHdPZmJab1NJTmhHYmpxMnFKd1QwL2taTDVGMVVmU2U5c1Jq?=
 =?utf-8?B?bVRLQ3E2R1NZc0hoMkJHaC9DbUcrZnZDdDVNK0E5eTdvWDZRL3hZZmUyaUtv?=
 =?utf-8?B?MEJGU2ZEemdWajJ0dUlVaWRnUnlHaUF6MVozanM0STZRbk9oVFdBc0FqSHlI?=
 =?utf-8?B?MkN4NytrdXNMK0tNR1EwWFhMWnFFeHkvMURQZFQrdXhydlNYSWZjOG1FMWg2?=
 =?utf-8?B?bFd6SkhOaW1WSnhBVVUwbnE3VmhBeFZNWTdEdkFUMTJOMXpGQ0NwTkFCMDJ5?=
 =?utf-8?B?R1NWV1l4Q1o4UzdrREpMVjhNUnB5VFBsYXRVNXQ4cERyOXlKTFhxNWVQWElR?=
 =?utf-8?B?b2dmUHNIOTB5c3JaU0JmRlJ6RUhLNTZsWmlyc2J2Rm9WcGJjTUxENHJMTlRh?=
 =?utf-8?B?aWcxbW4vNnppL2VUNVM0L3JkU0UxQXNob1pIL3pFVWRYV2ZyMnZob1VWMi85?=
 =?utf-8?B?Z0d6SUdIa2s5YTNEQkVKcUtYSE1xNDRtTHJybTR4Y2lFUTU1OWxHcmdib2lr?=
 =?utf-8?B?QVBUc3ZOOTlvNDZiZStXUE1FWlM5U1lGRXFYbFNtNXZJQkNqODNITnpLdzkx?=
 =?utf-8?B?cXdGVkR3YS9XRWxxL0dRZGw3dGJ4UkVzQ1MrT3ZBZ1F2dkFPY1piZC9mQ29H?=
 =?utf-8?B?UTE1aUM4NlZ0cjM3YUxMUEVKQS9BOFQ1aGtwVTVVN3UzVWJUYlVQUmxQYm5T?=
 =?utf-8?B?blhsbzU5MzNoT1ltUDIrV1QwMEZjODBPMWdwTGJFdjZpQ2pkcHo4MlhLWlU4?=
 =?utf-8?B?d0ExVy9lL3MxZURCME9Yd3F4Vmt3LzVXM3ExdzFHU1dwR1Z1amtWOWtvUXVz?=
 =?utf-8?B?RS9icXlMUnBKeWpEUVJ5ZmdXaVpTMnp3aGc3b1g2YzR2c3JFcEVpcXB3SUUy?=
 =?utf-8?B?U2swOVMyWmxML0ovZU45cTBleEtCaFl0QlpKME9yc3hEWjhHMmtLOFlGdnlD?=
 =?utf-8?B?SC9OSFp6ODFIVTFLZ2RJaThtMXdyQUhndDBWWVk2ZE04b1g5djQzU1pjcGgw?=
 =?utf-8?B?dFEvUUZTQ29kY3V5U01FTysvTVVxZVU2SEk5TWtzYlZveEJKTEI3U2gyTmtN?=
 =?utf-8?B?aWZpSjdnbTNOUHZjeGw4SVlJV3A1Mk90ZUZNdE9GVnZQUk1qb3YvblcrRklD?=
 =?utf-8?B?SGVVdzJDczZzT2E5cGtmcHFLMEViWWl0b0N2NmErM1JtenpmelU3azZldmVo?=
 =?utf-8?B?M2k3K2VwbTlYUUErc1FqQVF2ZmZjM01Qb24xSSs4MnczNFZVUWpVbERmYWV5?=
 =?utf-8?B?bXpiZVZNbW9xTW1weVExQXhYS2tWL3d2VWlGZms5UlB1L1NQcXZtejdmbnBO?=
 =?utf-8?B?cDZta3lOek16VS9kRC92a3F4VW9wbzVUQlhwMXpqVTNTSGJoVWllbWRHajNB?=
 =?utf-8?B?dnRaaEd4N1ZvckRHSVZSRldWV3VybTlVNWVTMTJ1TVN4V3lQVzAzYzhMc1ov?=
 =?utf-8?B?ZmZwRmYyU0J1T2RHeVBJOXVoT3F5UUpzS1RtWkhyY3czR2UyNkJGeG1KalEx?=
 =?utf-8?B?d05ncmpGRlY0S1F1Nk5XZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmVxTVpsWjFBNlFFU1l2cnl6ai9mL2ZoU21aL1VkUlk5WDhLQUd6WXVjOG9P?=
 =?utf-8?B?Q0tJQnluSVEwMklNR1pwSnFIRyt2aGZ1R1R4S05aRGNUamFwUlo5OVMxZDhS?=
 =?utf-8?B?REh5em43dXQ1ZWNjUSs0U1liM2JBMllpVlN0dDN4Ti9PZU1YM2dYTlJZbVk0?=
 =?utf-8?B?SmdYV2tMY1JEaG1uZGpoMHNzUlA4dXVnT21EYUJkT0hQVkE2QWgvcGdacm52?=
 =?utf-8?B?S1ZsdDZvVUs5VXpkbURYNks2MHJncWFEdnY3MmQyTWRNWklka2F6a05keXhr?=
 =?utf-8?B?ZWdjNmdkaHR5WE5PRnFlZDEwZVhLZjg0WlNNWU5LSlg1YWttSWNtU09aOFdS?=
 =?utf-8?B?dlU5V0RwNUlLMXVNYWZpS2J0TnBrTjBmYkxqdVNLYWJtNW1Venh5S0gxaHBS?=
 =?utf-8?B?NCsvdmprd3czbFY4aCtlM2tSL0xlenMvQWhNME1UT2ZOeHUxNnhYU3pvWVlQ?=
 =?utf-8?B?dEtONFN4bjBKYkJSaWlqdExtMFJLTGpXdzVvQ2Y1OUs2OEd6eVRwcUJPakFO?=
 =?utf-8?B?a1ZXbWw5ek5EaVowUnBQQXc4U29adDlBUXNPWU5rNTRrT25FOUgwUkFiZmVm?=
 =?utf-8?B?STFpeU4wSENmL3BrczJSMnFjNXcrTGwrdlllR1dhMlV2LzY1dk5LYU95VVl3?=
 =?utf-8?B?UVVRcTg1VkRsT2ppTllscHBzdHd6TXlpY0xNMUZtbVJuK2FaVjFnMEVBaHNC?=
 =?utf-8?B?WDdCMDRNSkFPUm8xL0RJZFpOOURyN1ZicFlCMDk1SGJFcHA3d3haNjFPdHZn?=
 =?utf-8?B?WWlVM1ozc003ZkI5dGhlSjBHMkx4aTNvbEloSHJnTjdXbFhvVkduT3c5SnpZ?=
 =?utf-8?B?VTI5dDBRdk1ENE02TGpiOVBSUzNQM2NWSERkWnBTM3U4c2UrZFlSZXkwSjVi?=
 =?utf-8?B?U0FwdVRwejRWa3dJSTFXS1lCdk1wRVVMZ2IxTSsvYkcySFhPbXdGdVhuQktH?=
 =?utf-8?B?RWtCWjJzMDhrRTBRT0l0cE9rOWN2WW5IU2xjYmlNZ2Zpd09MYVl5UjlsT1BP?=
 =?utf-8?B?RDdBUkZFK3pNWGRnNG54eFlSclA2MWxFRXhobTNKZExKVlgrNDdNZFpxaDVS?=
 =?utf-8?B?R0RMT3hYVVYvc0ZrRStHR3ZJeGp0bmxNSVpBSk9pZjZQVzJrTG9MdU45bkdo?=
 =?utf-8?B?emRMWFpZeDBUek5lZ2dpdkg3OCt5NmdiK29JeXY1YmdrTERoQmpDY25LN3F5?=
 =?utf-8?B?OWRoTit3TWZneEl1WlUrSStyaUowa2VzVnZMa1JiMURCV2RhbCt5LzkydUlH?=
 =?utf-8?B?dWxFaHIwV2wxQ25UK2phWTI2SCt0Z2xVT1loMm9HQmY1WmRHV2daUEduamZE?=
 =?utf-8?B?d3BPZVFqWDVNVmRkMVNKOHdZNjQvQ2RkNzh0OHpLblB0cDRDMHdsYkhCa0hR?=
 =?utf-8?B?bVE1dFFBUzFTTXV2M0xxdHRvUFZsZGxtV3Z2eFZwY2owR1RZOW5ja1lKVlB3?=
 =?utf-8?B?OUxOYzV3cGtsRTJ0NDQzUjZlTUdmWXlsbklNeGNsTnpOK1A4SXdZWG1PZ0Y1?=
 =?utf-8?B?c3BsTWowdldpRDJYb1Uzc1EvT2l0MHVpUGsxdEVsdUZ3WU11bzhVdEVNdlZy?=
 =?utf-8?B?YkJtOFFkS1JiMkF6dS9jdE9FVnpQMS9weEVsRmN0TXNNTTduWk1MM2FCSnNS?=
 =?utf-8?B?KzRZTlAvcUNMV0FzcVNtaE9BRURxSHh1Yy9yTzE0SWxxU1dzR1FDZG9ZR0dT?=
 =?utf-8?B?RXdkOWJnaGkxZm1HeEJhTldJNGV2ODcvckVONEErR21yWGpyODVhWHBKSmNu?=
 =?utf-8?B?d21BaHFqWUxSWnZDWG12dXdNV2x2Q0Yycmh4emhKb1ZyMTU5ODArR2NHMUJt?=
 =?utf-8?B?aUtjVGNNZktMOUIzLzNOQ3ErTnQwWDJaZjVuN3MvVC9hN0lKR1FPN3Boemdo?=
 =?utf-8?B?SmJZWnBFMFhRa0tRcnpHaC93YWI2eHFIK3dlRUc5eFkrWUxadlAxc241dWhw?=
 =?utf-8?B?L094UEVOUVA4azRFYWRKdVM0ZjFwZ2FORThRMWE1NEtKUG5hbkNCMUhlU1ls?=
 =?utf-8?B?bUJhTUZqd2toRmNVZXNyZU81bXdhTjZkZXRUR3hXTXlQbHRTL3ZPdldxTVBj?=
 =?utf-8?B?eGtUVXcrVmtKWk1hU0xpS2t6RklJUStpRzg2UGE4M0MwNU5DZFNtWlRjeFky?=
 =?utf-8?Q?aVw7paIVFJv268FMhcxBFNXEo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb74d0d2-267b-45b6-8c39-08dc7a66f073
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:56:11.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4HlrOvraUvKhVoyrj4ZrMLruW2GSSqdTkxXofEjI8L5ztIu8DsaB8LuGvuKYCWm2MX2l1FzegLQpayfuGbCMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058

PiA+IDEuIEFkZCBhIG5ldyB1bmljYXN0IGZ1bmN0aW9uIHRvIG5ldGxpbmsuYzoNCj4gPiB2b2lk
ICpldGhubF91bmljYXN0X3B1dChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1MzIgcG9ydGlkLCB1MzIg
c2VxLCB1OA0KPiA+IGNtZCkNCj4gPg0KPiA+IDIuIFVzZSBpdCBpbiB0aGUgbm90aWZpY2F0aW9u
IGZ1bmN0aW9uIGluc3RlYWQgb2YgdGhlIG11bHRpY2FzdCBwcmV2aW91c2x5IHVzZWQNCj4gYWxv
bmcgd2l0aCBnZW5sbXNnX3VuaWNhc3QoKS4NCj4gPiAncG9ydGlkJyBhbmQgJ3NlcScgdGFrZW4g
ZnJvbSBnZW5sX2luZm8oKSwgYXJlIGFkZGVkIHRvIHRoZSBzdHJ1Y3QNCj4gZXRodG9vbF9tb2R1
bGVfZndfZmxhc2gsIHdoaWNoIGlzIGFjY2Vzc2libGUgZnJvbSB0aGUgd29yayBpdGVtLg0KPiA+
DQo+ID4gMy4gQ3JlYXRlIGEgZ2xvYmFsIGxpc3QgdGhhdCBob2xkcyBub2RlcyBmcm9tIHR5cGUg
c3RydWN0DQo+IGV0aHRvb2xfbW9kdWxlX2Z3X2ZsYXNoKCkgYW5kIGFkZCBpdCBhcyBhIGZpZWxk
IGluIHRoZSBzdHJ1Y3QNCj4gZXRodG9vbF9tb2R1bGVfZndfZmxhc2guDQo+ID4gQmVmb3JlIHNj
aGVkdWxpbmcgYSB3b3JrLCBhIG5ldyBub2RlIGlzIGFkZGVkIHRvIHRoZSBsaXN0Lg0KPiANCj4g
TWFrZXMgc2Vuc2UuDQo+IA0KPiA+IDQuIEFkZCBhIG5ldyBuZXRsaW5rIG5vdGlmaWVyIHRoYXQg
d2hlbiB0aGUgcmVsZXZhbnQgZXZlbnQgdGFrZXMgcGxhY2UsDQo+IGRlbGV0ZXMgdGhlIG5vZGUg
ZnJvbSB0aGUgbGlzdCwgd2FpdCB1bnRpbCB0aGUgZW5kIG9mIHRoZSB3b3JrIGl0ZW0sIHdpdGgN
Cj4gY2FuY2VsX3dvcmtfc3luYygpIGFuZCBmcmVlIGFsbG9jYXRpb25zLg0KPiANCj4gV2hhdCdz
IHRoZSAicmVsZXZhbnQgZXZlbnQiIGluIHRoaXMgY2FzZT8gQ2xvc2luZyBvZiB0aGUgc29ja2V0
IHRoYXQgdXNlciBoYWQNCj4gaXNzdWVkIHRoZSBjb21tYW5kIG9uPw0KDQpUaGUgZXZlbnQgc2hv
dWxkIG1hdGNoIHRoZSBiZWxvdzoNCmV2ZW50ID09IE5FVExJTktfVVJFTEVBU0UgJiYgbm90aWZ5
LT5wcm90b2NvbCA9PSBORVRMSU5LX0dFTkVSSUMNCg0KVGhlbiBpdGVyYXRlIG92ZXIgdGhlIGxp
c3QgdG8gbG9vayBmb3Igd29yayB0aGF0IG1hdGNoZXMgdGhlIGRldiBhbmQgcG9ydGlkLg0KVGhl
IHNvY2tldCBkb2VzbuKAmXQgY2xvc2UgdW50aWwgdGhlIHdvcmsgaXMgZG9uZSBpbiB0aGF0IGNh
c2UuIA0KDQo+IA0KPiBFYXNpZXN0IHdheSB0byAibm90aWNlIiB0aGUgc29ja2V0IGdvdCBjbG9z
ZWQgd291bGQgcHJvYmFibHkgYmUgdG8gYWRkIHNvbWUNCj4gaW5mbyB0byBnZW5sX3NrX3ByaXZf
KigpLiAtPnNvY2tfcHJpdl9kZXN0cm95KCkgd2lsbCBnZXQgY2FsbGVkLiBCdXQgeW91IGNhbiBh
bHNvDQo+IGdldCBhIGNsb3NlIG5vdGlmaWNhdGlvbiBpbiB0aGUgZmFtaWx5DQo+IC0+dW5iaW5k
IGNhbGxiYWNrLg0KPiANCj4gSSdtIG9uIHRoZSBmZW5jZSB3aGV0aGVyIHdlIHNob3VsZCBjYW5j
ZWwgdGhlIHdvcmsuIFdlIGNvdWxkIGp1c3QgbWFyayB0aGUNCj4gY29tbWFuZCBhcyAnbm8gc29j
a2V0IHByZXNlbnQnIGFuZCBzdG9wIHNlbmRpbmcgbm90aWZpY2F0aW9ucy4NCj4gTm90IHN1cmUg
d2hpY2ggaXMgYmV0dGVyLi4NCg0KSXMgdGhlcmUgYSBzY2VuYXJpbyB0aGF0IHdlIGhpdCB0aGlz
IGV2ZW50IGFuZCB3b24ndCBpbnRlbmQgdG8gY2FuY2VsIHRoZSB3b3JrPyANCg0KVGhhbmtzLA0K
RGFuaWVsbGUNCg==

