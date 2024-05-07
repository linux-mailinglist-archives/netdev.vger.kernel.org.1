Return-Path: <netdev+bounces-94283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB78BEFCD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E962EB226E0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9147EF10;
	Tue,  7 May 2024 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+xLZ/6/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AA7E0EA
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121086; cv=fail; b=ZD4rOZwGHnAM0HkIohGw/4OaOqaYrSM2CuPQqbP4Hz3qP+MX3GH8fQCqWbbo/hOdesgoQzKs//9NC6XmDZtgN5JgcsW/vbJ6owXtLDobbFNYbKg67hagsLQW5C+bU/Kae/iTjl6pnTx7VXMABIjKF8Rt/Gp+I87TIBAliaS/UWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121086; c=relaxed/simple;
	bh=ZqMKRv3q2WhhKLtZKLbx3u76KCGNsbpD7C7uPV/SmqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwQBnLBXRp8OeqAJoDT1oQqfMcovlufaAMEeEd0/Gp7fqeXQO22cb0f+qMhU3jZu6Ii34i03tl8qgmKlRHQG5mZN4qXtp7BxNyVP4avcw8HZpW4trH4eVUPNGjIsLMpJaa5xG2tqylS9xaMC3Y/7y/QSN3524RZB+OZ3tu5bOS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+xLZ/6/; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP4uDs2UR2h5KSfalzHTVpYZfxVJdV5N2CgDpceQBioi22Kuky3NgLCmfukI4LL9ey+PkdUUyHpe/AN5/wI5SjDujnUFZJmatLNTD60WKdvSd6aaNIFIKH4mKQQbyaTYHp37Y8U6EFbxbdkKwujR+/m85bto9MB7R8dRSg/XxuTuh0xYDi+KrS8uh5DuQ4vbWUnC66jbdAaeRVzu9tKs3lJIJuPtqy7sbtkiJQpXgCmiReXEhqHvJloFkt2Fe+2yTX+4LPqNE6erVv2/CYauQp0V3LcWnr9cqgSxICXBsky9LlHKHEl8cI5WjcqxnrCKx/uaeDDvL4K9NG2NVOBH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuy02noi9uQv26mqQY1FI3v/Tv16gY6uhdMquaNuQqo=;
 b=eiWD4gj9oIcCRY6A7z302tpXJn6CdOjzsACpiIe+H2d8rvJGhBa9RrIXykA++n7DsJ3ssPaKd56j6OzaslfrLN4hk8UlwIOD3+ggnT614AuiOytG1ZTopBGuRANUz9xoym1Os3DmGrjwDLvDvyxeaE9FwWCYfYiFGnn4/cW/3Fr5hchDqUBusWUmNYT8OHpMO4FAdUlkccOMNFWm5sc+aA36ZLB8p/I23SAic5zHrqyNCDgHlAwqSTy6Oj9BIMXjc4AGgHwWFNaYLWPA+SZqgyT8syvXlcKvNnnVIiX/tFjHnKesD4PPQEay7m1lH0VLA50inuuxUf8s6CrIqfimUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yuy02noi9uQv26mqQY1FI3v/Tv16gY6uhdMquaNuQqo=;
 b=X+xLZ/6/YyvGDZvthdIXW3vpyNJRDz4tzHqhqCKqq1RFG6a90VG/AsHEYnZd+c6uZgrLfJjnecBXEFdVadsotsVxe4wXdukOWUeZSrFM5N01FrZlFoIK2RblTbLDQRIKDwuPMw95IlHEYUIom62OyJuaOWfEzzLBUYn1/BX5MxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 22:31:20 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 22:31:20 +0000
Message-ID: <381e1bb7-111a-4af0-94ca-eef6b3423aca@amd.com>
Date: Tue, 7 May 2024 15:31:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: annotate writes on dev->mtu from
 ndo_change_mtu()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Simon Horman <horms@kernel.org>
References: <20240506102812.3025432-1-edumazet@google.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240506102812.3025432-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2bb806-65c3-4cf2-8359-08dc6ee56b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdXdTBkK1Q0SEU1UlRUb1BaREU5VHYzM1p0K0U4RkpaaWdkWVVxTWVITFR0?=
 =?utf-8?B?MnRCN2RuNWlUQTJ6bHhlbi9wcjYzRXQydmlkT2wrTmF5QzdmNzN6UjRobSsw?=
 =?utf-8?B?VkhVOWN5Sy9kMzVRTWtUVWZ3VHFOOHBhVHJITGFEaFVmcEkrZG50MGUwa3BB?=
 =?utf-8?B?Yy83U3dtNEl3RWRzSk5nYkRkdVhwNXVoTEs2Y3F0YnNUMUVEa3Y3Mk5aNTVP?=
 =?utf-8?B?aEE1MDRXMWhTN2tjTlpGT0RrVi8yUWU2aFYwSzJHWnRvaGxsZ2RIZXVOVWZ6?=
 =?utf-8?B?RENVMnNzVlg5UWNsWmgzSEhiczg5bjh4TzA1NmM5WUpBR3RJcEd0NGlzRmRT?=
 =?utf-8?B?UkgrY0ZvVXgyVTJzTWhDRHBtSDE0SVdiQXlsSUxaRDN4MkNPMnh0YkROMW1z?=
 =?utf-8?B?L2dwbWpNWEgrM1VrQURBMXd2cVBCK3padzVLRnVsOGRNUzdoZ3pOZ2VYYnFL?=
 =?utf-8?B?OEtKNzhSalNaWnhKeTc3ekxBT2lrRXNXZk0vVEhvbnQvNWdPT0NpUDVNSWxO?=
 =?utf-8?B?eDkreTlXVUpOLzBsVUpWa1NBY3B1d0VYNy95OUR1US9oQVROdW9zY21Kc3pz?=
 =?utf-8?B?a2ZSVlFoUXc5R1MxU2Y2Ly9MU2JGQmhsZkpOTENTRWRLTzA2MGtFTFA3MFpX?=
 =?utf-8?B?SXUwNFlhK1JnU2trUFJQWVgwcGFDYmhMd0Vud21MZDc5VnlBQWtJWHFaWjIx?=
 =?utf-8?B?WVpEZE9jTmw0YUplVXpvN04wMnQ3OUNycG5WWEJJRkQ4M3l5clFaaXByUjJJ?=
 =?utf-8?B?Ukc2eGFiRFRJNnUxSGtEbWI2QUdxZDZjTVNaZk9FUUU1UHBsUVBlbnB4QlpE?=
 =?utf-8?B?RnEzdnNob2NPWDhlU1JUclorQXhGamRRL1B2dlpEMmUrSUtVa3NCWFByV3hZ?=
 =?utf-8?B?b0dzMHhlb0Z5ZWZLbE9Xa0VEaVd2OU1KMVd0RlBvd3JzRGQzbVNoUTVDOVF0?=
 =?utf-8?B?eUh5eVVQUXQyUm96UTE5bm5mdVB0VVhRZFhLb1kydytOV1NHS1IxSnlwbG91?=
 =?utf-8?B?c3NpMjMwc1NkdFNMbTVpL3dDNkR0V1d2aWpBcG1GTGtodjBLV21QUVIzbnJO?=
 =?utf-8?B?MXdCcTJZL3d2a3dUcUNMOGc0K0NDR3RyUjV1bC9uandFVGFxYm5JYlBldjFM?=
 =?utf-8?B?Mk8wc29OL091NEJzVmFlTXBxTUtCM1N5SmVCak5GckhXd01SN2VWTEFreWJm?=
 =?utf-8?B?RXVtMHNYc3RLclZTTndlMU9zc29LWTk1MmpYZ1V4UGkyWHIvdzlHYTlISlI3?=
 =?utf-8?B?QXpNUGdweXR1eXFXQW1LWHFMSktRdjBITCtsUUpXaWFjbWg1VXRteVBRU0Ja?=
 =?utf-8?B?a3ArTVhGcmNnbjRDRXVEZFBGZlViUGxaVzZ3NS9tMUJNVG1QZFUyQWViRGt5?=
 =?utf-8?B?MWdLeVUzTEd0VjAvUUd1OUlaalQrQ0NVNHFVZWkxNUMyUTJ0QnpWVmRld3Q0?=
 =?utf-8?B?MnNjWkJHTTFsRlRsYkFNaWx5WHdrZUVFRmNLTGhSWEFFZkZTb2xsOEI4YlV2?=
 =?utf-8?B?bkJYNmkrWTVMYk1pR2pLNkp4TnI1NlZkb3hnY1NwYkpvQmVvVTREK2MzYjBG?=
 =?utf-8?B?MFVaeVhLa295YzBDYnRkckRSQnY2N1poaFBxR09hN2xXaXE2YWRRZGFtay9M?=
 =?utf-8?Q?ONPiqcJysRxvnIbHdRmcqS0q2oH48ixZHLH+c7lmMyQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUMyY2FLYkhjTVZUUHBWUXZmRkpnZDYybHJZdHlUcC9Pc3gvTk9semF2OVFW?=
 =?utf-8?B?b21WdXZpTk5wREVES0NQWWJLbWM3MCtiUytVUzB6Mko4ZEMxMXNvcTRRYVpX?=
 =?utf-8?B?VEd6OHdRZDZmeEU1bXo3a0E3aHIvYmVNTFFyYmRuLzZhNzBUbHlkYVpxNlda?=
 =?utf-8?B?WkJwUElTTmlwRW9DdWVrRUtRcnBPSUFlazR6V1RGa0tlQW9RVkloeURmaDVD?=
 =?utf-8?B?dTZwTkdVK01CUHlHbS95MFJlWHM1bmd6N2xGemRyOWErcXgzS1JZajBKZlZw?=
 =?utf-8?B?OFJBbDFIczFjSEFzWlRJRGl3WWdGcUIrMmZMUjZuYXloZW9Ta29sTUpQMVRD?=
 =?utf-8?B?a1dNUEpTdlk1ajdMOHF4ZXAvb2lUZkJtczZwUnBOUmhMM0crMEp4TTJuTmVv?=
 =?utf-8?B?dTZBN2FGNzhqNHczNXNhbWkwZDlmWGxzTmNSOUE3dm9FNFZlQm5GRDNxcFlQ?=
 =?utf-8?B?ejBrRTc4dGg3Y28vZVl4cjlHMkI1ZURHOW85M0JBOWMrQ1dlTC9NSERaT3NS?=
 =?utf-8?B?STUyanAyRVdmcit0ZWd5UDhOejhPUGNrdG9WenF1eEpia3VKaWtVMWh2VXBv?=
 =?utf-8?B?K3VFYkN5RkJ2TjNXZ0pyekVURy8xaUN4aFBKcVRTNWIzeEkzTW14V2pnM2tK?=
 =?utf-8?B?RWltVnpOVzBweDI4TFhGWFAvM1ljRFQra09tckJ1dEJzalpCK3FkMVh2UWtK?=
 =?utf-8?B?K0NMN0RFb1BHSkNTekpmWXJCY2NxdlVjT2dsMys4S1k5R1lKUk9pc3ViUVZZ?=
 =?utf-8?B?VUdaTG0rVXRBNmo5ZVJOY0NwYTdZdzllaFduc0IvbGV0YWR3dEdlS2xTZVpP?=
 =?utf-8?B?RC9CTmRrd0c1QTJDQVFRbTRVQXcvL0VrWlJWNHhQU1N6dXE0UlZXeXBoUk5X?=
 =?utf-8?B?R0JzMm13c1V1VVJWeVJlZjJsRy9mZDZvYWt5NG51U0ZFSmNqS3V4N2k3WGlY?=
 =?utf-8?B?c3ZuOFcySTVYSTZyVjZuUlZvd3FjNzFQY21RT3AzbFVEaDFGTDhRSytTWDZU?=
 =?utf-8?B?WVpmZzcvMXBXWE5mTWQzbzZIU2R5VXNhd3JhYlc0SUVNQW5FQmFaVFJPQ1lK?=
 =?utf-8?B?YWZZbnM0TmFoc3BuYjU3QlhQTEZXaFN1QlZhbFJqQVMyU0wvNW03Mjd4MUc5?=
 =?utf-8?B?MDMxRnVHSmRTeXR1clluSkNTbWxmMkwvK2JxS3ZqTXlFRGNmNVpwMVFFV2Q2?=
 =?utf-8?B?U3JFd3c3ZFc2VVArbXZ4Zkg4TkZBUzBrYzJ3d3RySjRmRGFNakJiYmVUREt5?=
 =?utf-8?B?OTMwV0wxckppVTNROFFyZFhkZFR6OU93K2hNeHlDakpEVEpTUzhSdnpQeW9u?=
 =?utf-8?B?N0VIVkpTR3M4VjZ0K0hIaVd3aW1XYlF6M3dkVVdmSlJiOVVTNnhadk1GQ0xO?=
 =?utf-8?B?VVRTcTVBdVFaTk9iKzNFeThMbzF2NVVkNmtQdjEybjZTZ09JU2l1cG1RSk9T?=
 =?utf-8?B?RHF0T1MzdlVNb0xLV1hzd0lFSVZ5cmNFdzB3R29wV0R0NHJNQ0lwTmxldHR0?=
 =?utf-8?B?ejM4YlNmZWl5ZnR3ZHBBZzVNZUJnTkpxOFNhNzJiNVU0eDVaeEZOOGJIY1J5?=
 =?utf-8?B?OUNvZGZXMGVBTkcyd2l1RmJkWUJDWnVCQWxiUjRheUZFKzV4WC8yd0MzVld0?=
 =?utf-8?B?d2tmVlQvaEw5bXQ4cCtmUEwzQUpuTEJiRHZqVjF2VkVGSUIwR3N0WnpFc0o5?=
 =?utf-8?B?OUl0Y2lJd3ZzZldEL3R2ckd1Wk10RkV3U0kwYUZITXU2U1p6TTJlQk9zOHpv?=
 =?utf-8?B?QmsyTjFqSmxMWUZwL2xrekRBclMzbTU5YXFlVkhjd0VNWXN3MVJpM2hENHRW?=
 =?utf-8?B?MzhiaHRZU3dhQVNpR0grYjE2ZklrbW5scHFXeVp3TU14NFJUOEx1MWN1Z3Nh?=
 =?utf-8?B?UytBWUdMMVJrRE96dVRFWnE5QTdTRTVCSWMrOGlVUXIraytNdXdic0FLSm50?=
 =?utf-8?B?TG1uZVQ2dXJoYy9wM0xaS3E2ZTh1enFNaFRsa2lBckFURTR6d09IYi9mM0Zr?=
 =?utf-8?B?RktiaEhReE1uRHNVQWRGQjROVEJXMVpqUWxObm93YWw5eVFVN0grMWd6Q0Vt?=
 =?utf-8?B?VDkyVEt0SFpFMzVpQXFyVHg4RTVuMVVqMkZzaUtmaW84QUIwTlVNeXhRNEZJ?=
 =?utf-8?Q?OuY4IJV5X+GcqH2Ms43ITsnzt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2bb806-65c3-4cf2-8359-08dc6ee56b21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 22:31:20.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+a96WCVK3ZfRFAVc81Q6TwqtVqCXOR+OA4+LV54mBHmFuCx52diUFJLzGAXplBxXVVZe+XZa7B08qSM+1aLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

On 5/6/2024 3:28 AM, Eric Dumazet wrote:
> 
> Simon reported that ndo_change_mtu() methods were never
> updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
> in commit 501a90c94510 ("inet: protect against too small
> mtu values.")
> 
> We read dev->mtu without holding RTNL in many places,
> with READ_ONCE() annotations.
> 
> It is time to take care of ndo_change_mtu() methods
> to use corresponding WRITE_ONCE()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Simon Horman <horms@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240505144608.GB67882@kernel.org/
> ---

[...]

> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7f0c6cdc375e3686fb870739067b7faa712ed565..24870da3f4848857d2d6012ed82c78d2f031f7a1 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1761,13 +1761,13 @@ static int ionic_change_mtu(struct net_device *netdev, int new_mtu)
> 
>          /* if we're not running, nothing more to do */
>          if (!netif_running(netdev)) {
> -               netdev->mtu = new_mtu;
> +               WRITE_ONCE(netdev->mtu, new_mtu);
>                  return 0;
>          }
> 
>          mutex_lock(&lif->queue_lock);
>          ionic_stop_queues_reconfig(lif);
> -       netdev->mtu = new_mtu;
> +       WRITE_ONCE(netdev->mtu, new_mtu);
>          err = ionic_start_queues_reconfig(lif);
>          mutex_unlock(&lif->queue_lock);

Acked-by: Shannon Nelson <shannon.nelson@amd.com>


