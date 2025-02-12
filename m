Return-Path: <netdev+bounces-165633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB4A32E32
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7715188820A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8C25D531;
	Wed, 12 Feb 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQ5LTnJp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1925A622;
	Wed, 12 Feb 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384024; cv=fail; b=n94ny7FHDmKU5MVUflvCpPcJi1gnh82MtN6ilU6WE6snnktcd/9GBLeWZMPl3dhbn8oxuMxU+30XGG+dx3M/vF/I/smB2/dHuPITEygTIUAERUxrOnmIuv8ysdY1oVGyxc1cHj617niGDX1DwzfOQNgsI5ukz6/2gB/WwIhzqDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384024; c=relaxed/simple;
	bh=ddvk/OYrV+WiJiKiCPL11YNQpvZ6WPSb0S+2bm5mWiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TU4sgk36OD3x3/EvuWggkX2bZ4bmpCahHturlXOgkpYLQluq9ljpOE1V8feWjKrra5oqpC7gyhzq3HcAeNhsHF6Tq3/URI36xtNIs1WrqIwgcy+m1MP6BkTygWR82pF/3GXekkex/BLR3Alzu283DRSW1ZmS+8nARkTYwBEVpQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQ5LTnJp; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg8/wd4qWGh3bJkJV6C+dqzhBU+MbQ/7pjF+ct+8aeSfOAKPi/DcHufgvWCbSs2WUJ53gIdx0RCF/kcYC5lVD9wAH1drxhxnPfPAhUiGUbYT0cdV5eL2M6gr0cWQsC9ng26hnuRnxTHwoAupIJJ1maTKCyXZpcQI2WL83rAX3j6VnRbBH8jl6Sj7A8xIPwCwSPDBqqyR2staHJayrkqUe5JiE7io6TkQ3GtVrWbezxPBOzAV1+uCUgkxma7hfrhL7phoQEcTT94BXFpDUaJ8N+S32RC05Z5qDxmlSLDTHQOET8PeFvjcVPranrBaugq8qTSn/F1ZietPl+tqxj9fWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQtqCVun0XdBIKwZj51em0VHiOAFWh1Iu0BnkMGemjg=;
 b=bBv3VnQcNCPcz8DK4251PsadbWKSUgCmZ3iuZjD+pdi6lRhpUl2uVHfBt9xoHBm3BjXLrdBIwM2sdFKHuV2edHZ+2r4KhTEfPkCsb2VSEFWQGduwom0LJYr8iDRIlmiLCeQsmQbCe6aMsp4wbAeHeOZ/D6SKZF6h/cQEk38UX8plhzqS7Qg56aUnYqtq/TuNIndbn+8hLenYLUSQHADK+TtUbSYvY1GBtDbTDku0RpxeKRnzZU1gYFxiDfKRRJKycWFZxPmBQE5Vt9vq1pJQPPQsQiKORPKwZEkZsP6UgKt83nlMTuEov8q5EcGMbbHD6IFSltLppc//NeK2R/IUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQtqCVun0XdBIKwZj51em0VHiOAFWh1Iu0BnkMGemjg=;
 b=kQ5LTnJpMPlHUNkQUqj8bhHrIJP269G2djT3POZLS2U7Ev6ACWwqB0g64iSlgJGdkY+sgKDnUyCXZGFXGXa8JqKGZ+SlOHnNXyp6T95/e6A4Cewr0xos2Vt7Gb9OzVSJwjipjgWtpSwsjb0plBuqUZT4kvwYV5fdnpPcVPj5+M4U0QtbO+K+wqB11Va4JIeXOHCPEvTSLaHq0FWwp6r3ozwpwSd/+nlWws67/wulx/sjvxq7eVzMCSGtIsgfJt0xtaWpToIC8ZY50a78CpbpMxbQVDqHxEcc+2Bk52WDXEARFWcl0wa+ukXiQ3MZQeuJVwBXAN5IvQWjpXxa12CyoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 18:13:37 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Wed, 12 Feb 2025
 18:13:37 +0000
Message-ID: <d98d0c20-741d-4d87-b39e-5aa8eed4624c@nvidia.com>
Date: Wed, 12 Feb 2025 20:13:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Add options as a flexible array to
 struct ip_tunnel_info
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, dev@openvswitch.org,
 linux-hardening@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250212140953.107533-1-gal@nvidia.com>
 <f9adb864-8ed5-4368-a880-b2aac8aac885@intel.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <f9adb864-8ed5-4368-a880-b2aac8aac885@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00006634.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d6) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff699f-ffc9-482c-3c54-08dd4b90f886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUJGYk9Wa0lOaFBDa1NXRmE0d3NxbWFqVDV4Zk14SWIwekdHUExtOHk1ZlhL?=
 =?utf-8?B?V2RLSzhwZlAyRDFBdlVkbklXWFIzZUc4eGpHZm4rK2dIbHFjMXNEOE1HRFRE?=
 =?utf-8?B?aEJ1eHR2d0Z1U0JCVHFUODR6ayt5bFVWdUFDVmRVVHR0Y2JjUjA1a1VUNmtD?=
 =?utf-8?B?MitWSkxZclNDMDF6dDRqNXNRRHRPUGtrWVFPdWxrWDRrNGhueG1SVkZHdHhX?=
 =?utf-8?B?cmZ1NUdER05FS0t4RWdrblp3U1pWblVWYUcrQmlsQjZzTzNSelRXZHJGKzZu?=
 =?utf-8?B?bmdFQS9RQzRwbjV5ODYwdWFFMDBCbEV6RGl0WDdCM21xMUcyZ3FIMERSRUdK?=
 =?utf-8?B?RWtLTFFmT2hQeVAxVEN1OGpJVVlmblQ0LzZYaW5GbmowaXhOMWJkUmRSRVE2?=
 =?utf-8?B?dnRCYlAwM0FES2hhVmJ3WGR1SEFmYlRISkd0RFM5TzJzVExlbHV1NXNPOHNn?=
 =?utf-8?B?anhodDl1ZkJacitjd3kwR2sycVlIWkI3enVGT2RTMkxrUHFxNmMxMFRRZE9V?=
 =?utf-8?B?REdwQjBNVDR2R0xwczJTc3lCVDQrUEtwM1JVczRzTlozUHFjTGZLL05Xa0p3?=
 =?utf-8?B?bkJLNytXMm54aDhvUnVQdDNqWTRuTUw0RnBjSzV2T2x3amsvd01pbGNQZ3BR?=
 =?utf-8?B?OHI3Y1NENlpmZ0xwRGhDWkdZV1UweHBVM0x0Y1ZFaXRad3MyVHQ0Ty9yQms2?=
 =?utf-8?B?c053blU3clc4MisvOTlnSXBoeThDSGxTWi9CY2N4ZmdBa1dOZ0RDSXpRV0F4?=
 =?utf-8?B?dkdvbTJhTjdpVEdla0lid3ZzMWZURTEyY2xUNCtCOFhNRmc4V0dwNis5QWU1?=
 =?utf-8?B?YmN3aFBKc2JiMWhLMkFpZU1ORCtObDlraWFZTVd3dkxzKzJOT0lDK1pWbFlz?=
 =?utf-8?B?d2FqODViT2lFL1ZJOXhFZVhiSXFxSlRNWVptR2dsQVhpYnJkd3F0WjQzd3Rx?=
 =?utf-8?B?cFN1eXpaOTdPNUtpb0xqTGtTY0Z6YUwvTHBnT2xPbnp3RTk4aEVkMFJROW9w?=
 =?utf-8?B?cEVwem5ja05vam1RSGlmalBKWmZjc29aaldwMzNyR09vUXNwK25lQ2hDZnVm?=
 =?utf-8?B?bjZRaTZKWExZTjc3d1FTdWtETEpZMHhkekRiZFJ4WmppTm92YmlwNngzS2hM?=
 =?utf-8?B?bG1JZ0YwRk5RQ0pVOHBZOVJCdkgvTU45ZTdMVGh4K25ETzdDU1d0cDJxUTJB?=
 =?utf-8?B?WHhZb29wSXdvK0V0aHM4d25ONmlLUDFNV0pIa0ZuZXV6TWoyVzhEVmI1bnh5?=
 =?utf-8?B?aEk3dlZXM0VIdUxBRnRnNFVrN3Frc1hFTEQ5czNhWEUvakFFMThaZ3BVVGR6?=
 =?utf-8?B?YnhsRVJoZDRoV0dCSWgyanY3Nm9Ubk9FQkZFQmhpN2RVZGN2dXZaQXl2MTV1?=
 =?utf-8?B?TW9uZGRnWHoydHdDR29iZmNFZVpOZkJsNHBZS01XN3J4NDlmUVZIK1M1L3FS?=
 =?utf-8?B?TGVlOFZWdnB3bGMyZHpvYVlGa2ZnYnBLelJ5eTh1SFBDdTEvb1cvSGNCZ0l3?=
 =?utf-8?B?b2NBMTRzVFc5bjlhUnlOTDErQkpiUzYrUk1mcFg5eEdjYk1mZmR4ZnJqcEFz?=
 =?utf-8?B?MWRDQ3p3UGdNUXd1VEtoMUZTNDlaQ0hVZTRNQkQ5Q25GL2xtRmNlSUJ6K1c5?=
 =?utf-8?B?YVd6bTlTdHh5NjFJY2FvVHNSeGJXUDR5YnZxRDlLWUZad2pPcXBPbE14UW0y?=
 =?utf-8?B?cVF6ZzY4ZWpDbS9aQmVXdTFhWkxHSWxOOWd2eDErV2lRRUtpTzExY2orQmxy?=
 =?utf-8?B?RWRtajY0MDUzd3V3bURRaFBKdFNuUjRUblJJenBCaWhZT1U0NEl3cG5BQ2lZ?=
 =?utf-8?B?Nzhpamlxc2drUk5SQkM0UWNtWXNrRzVUREhYRzRSZGZHbC9JcloyRitRQVZE?=
 =?utf-8?Q?JKzpD/Hr6pMah?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QysrbmxBUEtzZmNGYTM3RWV5elg4WUhsa3I0YW5ZbTlSTEZ1Z1RrZkVxdTNH?=
 =?utf-8?B?Um9XdDJmNHE0aEVaTVo5WFNiZUlZNFJ5dGVqRVc5dDIvckxYR1N1WWhxcjRu?=
 =?utf-8?B?dUNhZ05hOVdVWkllYngrdGdVbzNwalE4YjBFNmFYSUM0RVZlS1NnTnVwK0tW?=
 =?utf-8?B?SXBIU2twWHYrM3dUTkZmbWtGWUJsaDFMZjEvODgydWJkRkpJWXBKZTJwajlv?=
 =?utf-8?B?QlRrSGRrNFRROExXcGVnNmdnUVU0RDNiWVBkcmZLQnp0aWcxbFhjR2VXNVBJ?=
 =?utf-8?B?TlFHNk5NM2NHekdZTmt1N0ZQMVF2b3ZTazFFR0VYbUFKOGwrRC9XSEhjTm1Q?=
 =?utf-8?B?aVhHa1QydnBJVXI2cnowZlYvRjcrTzlkVlN6R292dW1ubG00MlhjaFBVdE5s?=
 =?utf-8?B?Qk1MYldnZnRpZEN5V1JQZ2ZyMWxEajViaW1jRzdsR0U1NjE2alYvWE1MT0Yz?=
 =?utf-8?B?dDh2V3ZsR2xETkt3Y3dUb1pzelFUNlFiUTVMR2I0bU5WSm1iU0haZS95Q1Bs?=
 =?utf-8?B?Ny9uRVFqWXhGNWwydG04VWRuYzU0OFFkcENTSEtoRkJXMGJ1VkxzbUQ3eWph?=
 =?utf-8?B?VHhUbUo4TzkrWS8rMnh1UXdqSzlrMWlFUVZ0TXZkTHg1V045YUFpc1BIWk85?=
 =?utf-8?B?aEp5MkJVMlhaVE1ZTHRudFVqamZGUzBaRzljMmxlNXBmZ2FTaUtKd29oMlRn?=
 =?utf-8?B?ZXZva1ljcDhSSmRXQWUvT200YXhWVmk2QnpJN1hqS0djTENHd3doRkRGZkhF?=
 =?utf-8?B?cTVTS3dsRFFnM2pPNU1vN285VTUyTzFjZXRYam44MG9UeGRwY1BhWmh1WGc0?=
 =?utf-8?B?Yk91UlZoZkVrbzRYRWt0b2JyTVN1REVBeEthY3ZRdFFQWXV1MFVacEtYRWxX?=
 =?utf-8?B?YmZYaU5rZ3lqbTJmTVNFeGV6QkhLOFgvSUE3QXdNZGp4SmNxRFo3TGcvM2g2?=
 =?utf-8?B?WTZkRG5kNDZldmczZHRWOTRQSHpGOGZmOWRIOEoySzFzK3YzZEFEdmxWVGNa?=
 =?utf-8?B?Q1lBeTZLRDA4RDNxVFpZazJhQ1pYdWxHdkZqaWlTbjJtQjZJODlHOEN3U2M2?=
 =?utf-8?B?bzY5ajBCT3pINXd3NUZ4d2V2V3RYOTJUT2xwb1RkUTNzQ3J5Q21aUTBZaE52?=
 =?utf-8?B?ZFYvMVBLS3ZQUmFrZGRSNUlodUFReFJNQ1RCTCtlZEF3ZmpveGdraEFiaTc2?=
 =?utf-8?B?alV4ZElxMmRqbFNSVVBwd3ZUQWMxN3Y1RXVYSmhySzZESTNmQVNkYVFrU3c3?=
 =?utf-8?B?anp1VlpUK2FmT2NSS2toV3VaNDZSYnlJQ08yZnJsaXovK3U1bWFGR3pmZmMr?=
 =?utf-8?B?VG1UTXZoZU0rK0MyYkNyZjUvcUhNY1ZDeTJQYnBmTzNySERITDhsbndDOTND?=
 =?utf-8?B?S3J6Y0s5aEQ4M1YyNHJDWFFXd2xzTmltdTk5OEwxa0VpaHRHYyt4SHVFTUJL?=
 =?utf-8?B?Q3E4VGpJUjdOMUpsNGtlU1lNWHZTQXZaUkFWWjJldzMyOCtTYkNZR3ErdU9I?=
 =?utf-8?B?UkYzRmRuQ0JpeGJEelFGb0RsYThQZ1BkTi9BcCtLM2hWNHMrbTNZaldoSEdk?=
 =?utf-8?B?QU1xWDRMREFMS0J6KzdYczdlQldlbzA1d2FKam9vR2M0YlkrRUh5UUxRaFBG?=
 =?utf-8?B?TEk0OWR3ak1sVWVEQU9hUWdqOEFpbmE4UjhBYitHS0NURlV4eEpiUmtDV3J1?=
 =?utf-8?B?bmpnZmRhQmFDeDFUSFpRd09wR3pnQlBVTnBHTGd6eVFhbEUybGJqQnYzbmRS?=
 =?utf-8?B?aGJuTVI5N3NZWSs0VGpiMDFsS2FCYmtoZlhWQmljT1JjTjlLN3prSVZpS2dN?=
 =?utf-8?B?aldTdElhVWVsL0RFT01BcUxqMlFIaDdmUnBrOFJqT2JyWm1vVWF0T0JRK0Fz?=
 =?utf-8?B?dytCK08yaFBOejNjZzNHTW1YbFNua1BndlFvZ0tTeUR6OWVaQU93cmpYZjNv?=
 =?utf-8?B?Uzc1QjZRRjlmbVc3bGF0cW03Rzd0M09kSUg0WTJESlJCdFRXNG0zNHQxL2lB?=
 =?utf-8?B?ODA2bUYweG1iMlRuR0tlOTQ1cjBsRkdPaWtaalExR2tvdlJKL01ndkRwY3p4?=
 =?utf-8?B?SUFWL2JLQXNFNURTaERrMTJ6bVhoTUIwTXFPT3pxZ2VwcVpDQXRldElmM2ha?=
 =?utf-8?Q?fvdFBUlmH7Ke0kSfRwZx3rmrq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff699f-ffc9-482c-3c54-08dd4b90f886
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 18:13:37.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfZzDsCscgCpGA7rWhlDK06SSogKU+Y5ICfOanF4tdgP9cMUhgsEfm9m6uJd0NYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

On 12/02/2025 18:29, Alexander Lobakin wrote:
> From: Gal Pressman <gal@nvidia.com>
> Date: Wed, 12 Feb 2025 16:09:53 +0200
> 
>> Remove the hidden assumption that options are allocated at the end of
>> the struct, and teach the compiler about them using a flexible array.
> 
> [...]
> 
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 84c15402931c..4160731dcb6e 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -163,11 +163,8 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>  	if (!new_md)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> -		      sizeof(struct ip_tunnel_info) + md_size,
>> -		      /* metadata_dst_alloc() reserves room (md_size bytes) for
>> -		       * options right after the ip_tunnel_info struct.
>> -		       */);
>> +	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> +	       sizeof(struct ip_tunnel_info) + md_size);
>>  #ifdef CONFIG_DST_CACHE
>>  	/* Unclone the dst cache if there is one */
>>  	if (new_md->u.tun_info.dst_cache.cache) {
>> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
>> index 1aa31bdb2b31..517f78070be0 100644
>> --- a/include/net/ip_tunnels.h
>> +++ b/include/net/ip_tunnels.h
>> @@ -93,12 +93,6 @@ struct ip_tunnel_encap {
>>  	GENMASK((sizeof_field(struct ip_tunnel_info,		\
>>  			      options_len) * BITS_PER_BYTE) - 1, 0)
>>  
>> -#define ip_tunnel_info_opts(info)				\
>> -	_Generic(info,						\
>> -		 const struct ip_tunnel_info * : ((const void *)((info) + 1)),\
>> -		 struct ip_tunnel_info * : ((void *)((info) + 1))\
>> -	)
> 
> You could leave this macro inplace and just change `(info) + 1` to
> `(info)->options` avoiding changes in lots of files and adding casts
> everywhere.

I'd rather not, having a macro to do 'info->options' doesn't help code
readability IMHO.

> 
>> -
>>  struct ip_tunnel_info {
>>  	struct ip_tunnel_key	key;
>>  	struct ip_tunnel_encap	encap;
>> @@ -107,6 +101,7 @@ struct ip_tunnel_info {
>>  #endif
>>  	u8			options_len;
>>  	u8			mode;
>> +	u8			options[] __aligned(sizeof(void *)) __counted_by(options_len);
> 
> Since 96 % 16 == 0, I'd check if __aligned_largest would change the
> bytecode anyhow... Sometimes it does.

__aligned_largest aligns the field to 16 bytes, so the struct remains
the same (96 bytes).
When should __aligned_larget be used? What needs 16 bytes alignment?

