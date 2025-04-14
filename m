Return-Path: <netdev+bounces-182311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9869A887A9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C7188DF0E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E5274FFF;
	Mon, 14 Apr 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fd0VVZdf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582C2750F1;
	Mon, 14 Apr 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645316; cv=fail; b=m2l65wurlaJFVk2plrPIq0lYW2+hUvVXJ3SWsdR8Ha9CIWJORtAcAHn7DclaWc8I/Zq0K+8YLdt0z+8TUh4xQrBVluPp+Ka9CVOxaga3dk/fcXIPn/JxgQaeOR29lq+qGt+846JJBi+7RBqNo7ubKbDIXfdAG6+/XT1lOGP6kWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645316; c=relaxed/simple;
	bh=TRQKLC2IYzXpyrhL4SpFMAiRUqUFbI333X9hHbo1wcA=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=MfcmZ0Y2mwDqZR5SUN8SKZnEjyfH3/IuvaNGDnb78CPHKAYAZLGFDJ/55CW75T6uT7PHCCXq8hgOEjSP7IqVNmUiBYqWKAD17CejaToxaIv5KHU9cq8qS/GZbTmsGhFsbOPGC373VPfWNTEkmmbW7Fm503Cu7qzNHgO9fskHxQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fd0VVZdf; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=af77BYhj6OQ14+mrd/FAnE/pbMVct3sdJ/UMwhlTWKYBSAOgo4t2ov+9Jcs4G5SKAm7np9/J4s6AkYGGe5wG2KYRnta71tbsxhFeJYaC6NtJkEsCvGsofJR490PHC/kvu+fVzobQCKkGRDGsHhlTGp2JcLHQAP3fB+lJd8iHZonSTFF6XKnP2rDRw7kOJROQLux7Of5RyLvIUgqbyRdANi/ZqFOZPh+gd+ut8ZedTXrGI09M67hq2SiKhcsjyDbFfR+I6Hwap1z6G0L6z1yfGHeVIq8PbZG8BhAJS/uDSiF8JGfyyfgVbbfiRdXE70INMHcyDBE9yzPfN0B0qhElpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad3O72mVEW409uxCLfxxEQeyeCRXzZiFB3GrMqgFN50=;
 b=neaUR7MrTPFylvUxlRSVMHAe9ohX+m0ECegtGeG3wUg2dQPNxyA2H+ndjnl8KImVaXgTr63Qe+C3R90pfOUj6EU5UBBk+f2THaecrXiKd3zBtzTpF70g5jCvkuFnSqoRJfBMfCPkOes40jM8BxEO+0gqkZoKBgOfd0qoupDoAKgAeseLzioUB/sY7jolA5t1OeglWnpEwG5i0WDUiqplzP0hP0V4IqgCzD8hrQGTT69Ga+WhKRZCNYVgdo2hblPYOCrp43EeExobcWhbgr1Yg01+KfD+jqPdCXV1aPa0WKSy5yqwIYdiLrEk+rT9GzWUQBvlOO23X3+IQwF+otAm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad3O72mVEW409uxCLfxxEQeyeCRXzZiFB3GrMqgFN50=;
 b=fd0VVZdfRF3oBj55fXnyXcXRo6/wtOJmKJ7uImXDAOXrUp/SrIL2M/7/HjpVovs5J/Cwh6lSX4MkgCRCrPIqfaiLqfcKjcdgiVufaO1Ml45khQUsvFd7E3E1jwSCfNhmsmN2vz58R2UomnxTorxtTCaReY0uYIPBXu3fIVIVJmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:41:52 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 15:41:52 +0000
Message-ID: <f60f7f48-ae0d-2b16-6333-ffddb05ed792@amd.com>
Date: Mon, 14 Apr 2025 10:41:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-4-Raju.Rangoju@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH net-next 3/5] amd-xgbe: add support for new XPCS routines
In-Reply-To: <20250408182001.4072954-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:d3::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ecd8d9-54cd-4ed0-dc2d-08dd7b6ae0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVtU1M1a3FtdUlRblN0TWVFeFR5UlZhb3pKRVcvN1l0WGltNkt2MzdZTmVy?=
 =?utf-8?B?M1FtMXVlLy9JU0l1aVZoUGg0OGdaWlVXVFVjQVpMUEtFTStGMWRHUjNpVTly?=
 =?utf-8?B?cjhyaE50aTZ0UGN4VXAyaGNpK0xiQ3JCUFJQWTN0c0I2eGlSQVh6RVloWmxF?=
 =?utf-8?B?eXcreitDbEVzMzcrWEVHcnNYY2FuQTBOaGVGbmFFYkViSmZyWXZhbVdvNURv?=
 =?utf-8?B?TGlWUkNKZHd5WFVkaTh4QjVaV0FuVzVXVGdEdFE2b1g4RXd1SXBpZmU4QUcy?=
 =?utf-8?B?TlpDVG1vaUg5dU5IL3E5eGhDcWxDUXZLTzUvK09oYmttd0VONHg3T1g3Q0pV?=
 =?utf-8?B?ZGNtS1g3cnlVTUJvcVRkc0Z5NlNEWkpoZDdKSUZQd2V0SkhDcVFOaE9iTTUy?=
 =?utf-8?B?eW1TVW1nT0Z4cFljbktPOENRT1JvUm5KTktPeDFqbU1QaHRaMGxwbVZZYXZD?=
 =?utf-8?B?ejljWGRZbERQSnBwTlZyM3hEZmVEQ0UyMmp2WmNGL0RmbWU5RFpzS2RETW9V?=
 =?utf-8?B?VmNZeUVIUzFhY0ZPSUZkNVMwMWZnNnh3K2pNTDMyQ2dFVEpsUjBFbXJpcjB4?=
 =?utf-8?B?dWdWdENDU3NJbzhuQit2SHZ4emdkSnhkRlJubEYxVU1sZkFaell3ZmhsWlNQ?=
 =?utf-8?B?VFdCR240eFFPSnNTcjdBOEcrZUhXcFVhenZmWW5VMFZFdkRmMVdOUzhBRnBR?=
 =?utf-8?B?VVV1VnZ3ZnNoRE43WVcwMFZqTVZYZjlLYklVSlV2TU5ud29raVBETDh5N0s4?=
 =?utf-8?B?bTNRaFpWcWM0MFNFTVh6Q1A4dXRONHkrMTVob3BjV0R3RUZOemV0QnBqVEYz?=
 =?utf-8?B?bC9oVmwySCtqekRobGZIVmlWc1NFbmRwVk84Y0hLMG9zNk5nS0FPOHF1MXd3?=
 =?utf-8?B?cVZZMW5EZmY5amRPRGF1eWFnM282bnBteDdnU1BoaHdYd2IrcjBaTVVxOU9F?=
 =?utf-8?B?aUpTZFpCczgwcUpscW9PM3RVSzVIWmdNeXpoR0JZVllZWmtsYWdXd2JjZisr?=
 =?utf-8?B?cEhNN1JWNUM4RjQyUjVXbVppeGc1NFVhREJkdXovcEF3Y3Z6SFBLaGJRSXNC?=
 =?utf-8?B?NjJtZWdLNy9lbzkwTnNPeS9Pazc4aEpxcUtUSDVNY0hXTlh6eGlXNTZNell2?=
 =?utf-8?B?dldRVitkSWFCeldCcEovQWI1dTJhdEYxRitaSUc4ZHUxQUVMbGxYSlNDc01w?=
 =?utf-8?B?dFQyN2V2a0FKa2E4S0c2dnFnWW1ldWVmL3h5VmtuR29WSUxHZU9LUVJ3ZSsz?=
 =?utf-8?B?TzlwTWRWVHdaTTNSZkFCS0IwNXJmNHdXdnl3R1UxOEpnekdsd210VnZvQzBK?=
 =?utf-8?B?dGhtZjBseURaSFZVRnRjOTNUYVN1b0pMMGJERFpwN2JyeHhBMlRKbWhaZmRG?=
 =?utf-8?B?T2o3UUlybzQvSU0rbU5kLzF5aFJUMTJVZytna0pUd3hVZW8zMncycFJ2cnFX?=
 =?utf-8?B?dXhGNmRxYkozT3FrTytqbTZRaUthZFB5WjFYRGR5OTAvQ1AxaE1LZ1BORmhJ?=
 =?utf-8?B?TldqZmlRMzAzTWZ3L0FTRjg3ZjNzS25jaXBFWlFrWk1pcUk2V1ZxMW1wODcv?=
 =?utf-8?B?UDFXWXo3Q0RHallpaVkwUkQ0NjFSdWNwa3dic1pESjdFYjNKSitZSnNPTVFt?=
 =?utf-8?B?NlhJZTJDZWhOendwajdEY25GTFVGc0VxdXg4Z2JVT2twU2o1dDZHeUM1UXVV?=
 =?utf-8?B?ZUJ5bk53ZHNqQkJKejJ2RzI0cXNYRjFySHp0NnpweHdhY2dTc3NPaXJJMzY1?=
 =?utf-8?B?YVhYS2hJR2hTVHd4U1JjeEVlUFBFN1c2NlZNTFVkN1M0UlJ5aWVpZkZzQWJ3?=
 =?utf-8?B?T21QQXM5bkZKc3MwNkZSSjdDTEhrL1F2dEJHNkRNQmlSRHZ2eFpWbGxyTXN3?=
 =?utf-8?B?U0JJRFMrRjdQazJYMzF2QmdFZEF2QWZobDhmY1BVTEFpYVJWeW1kam9BZ1VE?=
 =?utf-8?Q?DqowOWF4q4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWZKN3JKejArQit6eTh0RmI4RWlwS20rd0xTSi9wNVlxMVhabVV3UnA0d2Jp?=
 =?utf-8?B?ckNVUUcvb3VQa0g4R2tCeWVubDd4US9NTjUzMkNKVGVBa2tUSFZiRFhBRlR4?=
 =?utf-8?B?b095KzgybzZkdHdUN05FZnFZMXpONmhOYXl4dklzTzZOSW1Ubi9LZnlmZUdB?=
 =?utf-8?B?dVZqYk1zd3NsM3VEajRtYzRneFpid25zWmtUd2R3ZGJNTzVlOHNXNUJwK1pH?=
 =?utf-8?B?bnQxV2JmS3lIY1pNVkJ3MC83ckVjOERLZ0wwSXpQUVg2TGxVVTlRdzJjajRt?=
 =?utf-8?B?bjN0cTZ1bnpwVE1CWlRqTzFuZ3FJVEM5WmpGamM1RUpOT244bjRZTEsvQUpv?=
 =?utf-8?B?VHZ5T2Y5SnQwUkxZZ2Q5MVVvdW1WSVdLdDFxUHloYlNSbENMamZPSExqb2NU?=
 =?utf-8?B?NDJZUmQzLzFTU0JEWFRlOTZtbTJIVEs0S2RPejc5YnBXYnNnQzJkNnc0WCtV?=
 =?utf-8?B?WGtTMFVSQnhPbERIVFpURG9LN2dFTUVTYmdHREhieHpYckFYaDA5QndRaXZj?=
 =?utf-8?B?SzVPQlRSQ3Q1NUpucFZid3lYdkZtbENlVXJ4ZWZ3VmRweFN3di90OUQ2NDBY?=
 =?utf-8?B?dGVQZDFsUFNxcXR0WVhTaVB3TGlLSnV1V0I2RDZ5bnJlNVRJSDNUWldNU2gv?=
 =?utf-8?B?Zi9TUytkdDNNL002RWUzMHpYSldESFBjMVdkSkJYUU9RbnNhTW9QS1VJd0hU?=
 =?utf-8?B?ZTlpeEN0NS8yRm9DQlY1dmhIeEZkNE9zclR5VHNEeWVaSjFld2FEZzQyYUo1?=
 =?utf-8?B?MXJZUWZVTiszQkZFMHpDRjUxSmhOcFhxMDhiNWFLb2VRTVM3SmFCanEzclBl?=
 =?utf-8?B?NkM1cTdjdzBKSFVZNGpjTjJEUWxSZFlRQ2VkV1JSOFpBazRSYnhFeTZqNC84?=
 =?utf-8?B?S0pHb0ptdlNFVkxveXY3TG42OS9yNU1aYi8vajEzODVxbDZNcmdpbTJ4dVB6?=
 =?utf-8?B?clJ0MmdESCtadC9CWlc3ajh0b0xLUkloM25KM0hId2dMN3dMNXRPUXJUWis5?=
 =?utf-8?B?STBCdlJzeHpDcHlmV0lPOWZvcENiTGUvVk1HUkYzNHJKdGlVU28rR2l4MHJ3?=
 =?utf-8?B?U3FERzR2UEwvRUJSaTF5b095U2Z3bVdwRy9rOTdLL0gra29kTFdHd0tyK2t4?=
 =?utf-8?B?L3BoZ3NERG5yd2E3Qjg2eWROLzArbkN0UHZWZTE5a3lSRkNjK2ZqcUVhSTcr?=
 =?utf-8?B?R1FhY1pzQ2lZNVpJVzY3emQ2N01RTUdEdVowY0FrTHZFZVBEM0xpdk9NdTlh?=
 =?utf-8?B?QjJpYVJMaDNHQ3dSVytNS1lUVDM3M1o1OWkwcnloQURDSVk4a1kxTjBKTEt6?=
 =?utf-8?B?QXZSZ1lCaDJPWkFpeGlRVHBLaitoMXNIMnBkcm9iRHdEZExuTVJmRkxlZS8w?=
 =?utf-8?B?QXErMnRwR3pRajg0UkxtYzQwQWtmUDdsTUJ4REZuWVRzTFNLMThaY2U0Sms2?=
 =?utf-8?B?V25mSXFzMFQvYmZHa2RXMExnWFVGNTVsT3lSYTJDZ2JjbDV1dDVIdmEyZk93?=
 =?utf-8?B?Umo2MTh4WG1PKzBTclZaYUQxVzcyVnZQQ2VCOVdHZFVESUgzWGs2N09mWjdD?=
 =?utf-8?B?Y0VOd1dmQkVKR1dqLzZJTlJEOVFPUlBNS2lTNnU2dUtXWm1lL2xRT3JyTlJG?=
 =?utf-8?B?cmU4RVpkNFVnSVVPUGhIb1loN0ZxZWxhdGhVbUVKdWQ3WlZwNUlSQmxEUHdr?=
 =?utf-8?B?c0NYUWZLR3JFVkZORWdJNVM1bUpQUWxBRlZtdjJ3V1dlMVpucUlzcXZOay9q?=
 =?utf-8?B?L1BJeC9pUFNHcWJuV25wODBteXpYR001aVVDeHJESUV3djcvQ2ZoR0dHN1VF?=
 =?utf-8?B?U1ZjOEtra29xdldOM3RRUzIreXRwZ0ZZL1o5K3ZLN0NGczdIS1JHN3owS1JD?=
 =?utf-8?B?OXBTN0IvRFJCV3VDd01TZVVLemFEc2JFZExoWCtiRFNNU1IvQmtacncvczhY?=
 =?utf-8?B?RUFjTVlHLzhUOFdNUmlVdlFSM3JvUktFcmpYUnAybWp1UjVodzJyMXJyZzds?=
 =?utf-8?B?b2hKNVpCZ1ZzcFVxTDFzdm1BU056Q0JyRlJ0OFdpYmMvQWxnM2E5Smc4Sis4?=
 =?utf-8?B?aVh4NVBMSHhaam5QdXFBTXJQNDFXVUUzL2xXZWd4M3h6Z2t0N1dzeWQybklm?=
 =?utf-8?Q?p5ABYICRfQfM7UQMEzloLZkE8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ecd8d9-54cd-4ed0-dc2d-08dd7b6ae0b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:41:52.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEIvYfFIf6mo8Q1nOSWAg2z2uC2YLwji063J52Kpj41kssM21UDWLz2Ca3MKASgYB6yl12nQGMwjNWxytzB16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656

On 4/8/25 13:19, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the smn functions.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 79 ++++++++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index ae82dc3ac460..d75cf8df272f 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitrev.h>
>  #include <linux/crc32.h>
>  #include <linux/crc32poly.h>
> +#include <linux/pci.h>
>  
>  #include "xgbe.h"
>  #include "xgbe-common.h"
> @@ -1066,6 +1067,78 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>  	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>  }
>  
> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				 int mmd_reg)
> +{
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +	int mmd_data;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return 0;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);

These PCI config accesses can race with other drivers performing SMN
accesses. You'll need to make use of the AMD SMN API (see
arch/x86/kernel/amd_node.c, amd_smn_{read,write}()) to ensure protection.

The AMD SMN API uses a mutex to sync access, if you need to protect
these accesses with a spinlock then you are looking at updating the AMD
SMN API, too.

Thanks,
Tom

> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &mmd_data);
> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +
> +	pci_dev_put(rdev);
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +
> +	return mmd_data;
> +}
> +
> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				   int mmd_reg, int mmd_data)
> +{
> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &pci_mmd_data);
> +
> +	if (offset % 4) {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
> +	} else {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +	}
> +
> +	pci_mmd_data = hi_mask | lo_mask;
> +
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
> +	pci_write_config_dword(rdev, 0x64, pci_mmd_data);
> +	pci_dev_put(rdev);
> +
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +}
> +
>  static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>  				 int mmd_reg)
>  {
> @@ -1160,6 +1233,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>  	case XGBE_XPCS_ACCESS_V2:
>  	default:
>  		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
> +
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
>  	}
>  }
>  
> @@ -1173,6 +1249,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>  	case XGBE_XPCS_ACCESS_V2:
>  	default:
>  		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
> +
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 2e9b3be44ff8..6c49bf19e537 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -242,6 +242,10 @@
>  #define XGBE_RV_PCI_DEVICE_ID	0x15d0
>  #define XGBE_YC_PCI_DEVICE_ID	0x14b5
>  
> + /* Generic low and high masks */
> +#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
> +#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
> +
>  struct xgbe_prv_data;
>  
>  struct xgbe_packet_data {
> @@ -460,6 +464,7 @@ enum xgbe_speed {
>  enum xgbe_xpcs_access {
>  	XGBE_XPCS_ACCESS_V1 = 0,
>  	XGBE_XPCS_ACCESS_V2,
> +	XGBE_XPCS_ACCESS_V3,
>  };
>  
>  enum xgbe_an_mode {
> @@ -951,6 +956,7 @@ struct xgbe_prv_data {
>  	struct device *dev;
>  	struct platform_device *phy_platdev;
>  	struct device *phy_dev;
> +	unsigned int xphy_base;
>  
>  	/* Version related data */
>  	struct xgbe_version_data *vdata;

