Return-Path: <netdev+bounces-89052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177788A94B3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0CC282D30
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73657D091;
	Thu, 18 Apr 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJkYnSHp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7E75804
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427991; cv=fail; b=bevTO3QZsUIme2B0WIc+pfFsX9r4ecopkJXPyWbJzkdCkMQE5gATFpcr1StHmPkOAez1mA4wC0tY4zfTQ/zbYQV3GqRKUHl3AN5+YUB1wxquuNqpn0/0TWj4xiETr0MZVCqroMRoeogq+IWWf0xsedhQumLLYfPtMt0Xhv13p5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427991; c=relaxed/simple;
	bh=gmzCU/Cq08e9+qnpSP5tEvKWKE0LoJIcEG6fjInjUQQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=OT0/vYm0fTFT8NP0YlVgrTvQbUa5uGBFY3a9qTp5AB81/YNms2nVXPMkNHuobekDz3426zZ4+1anHK9xcogfaFul5uIxr4H22gXuwzhItg8EOd7/sbkPh8OsqRpSId2H5mdIo3lQbbnyhWjbtov4Vd1LbKK0NRipkqfxkrRwIHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJkYnSHp; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYgOudCVSvWARscTLPQdxLQtY3lq7+0peg50dsz9d3XDsRsTYgGjp0sIHU7PL400k1C4HuSMKsW376vug4OQu6nTKOmHVIlkNnZWsyQBHGyqWkP8i0LSS2v5PeFUrTM8aoRYbxfi7c/LyVHp3oCWaV9ScT1C25vcY/f5qIa7zz6N0Bz0VnTDFuN5G1VbelfUpQsvZY1ximVZEzdNEkzrkfdpmKMGkHHu9lDW8DnmYWrBFb43mTdUuseC+p543SOyGif1zfroDK2I0gytjF54bD4I/PJWJli99S/csFt8Xc+/XJB+T2BzBovoUN/Z/eYnmy8cYJN5WhIk+EPpAaxhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=245c9aJgr7ZAq7q6OZWuHWAdLh4KfJ8t1XPnSxyq/TY=;
 b=gKV7smTI52KkO3pVMvupma2heR9mO7/k9w9cgzHPwrKZZ4z5rmnEDzY64I/ptyAvgQ37cZnl/6NGlf5CNxG+PuTJZeKxcRZx0DuZKmzB5DlBbEnktfaRf5Xykl8x2UQB6mjK+FbjgbY66MfFOtwYKYk3ooBNd2X3N64a8cCvGoCSSRQJZjnn+Z01CX87hN0BzFXz6c2UfnhWDmGD198LpkYFFkM+YpJZSXhJYZslB7K5o953QV8Lt9oXe9L6kxg0t9kcd0P3ZQMuMr5DPZzA9nRUk424gePvtIlGH8RNTFjH3XxCHmNy83wsbE2hWYY0FK0WCPF9CR02w+DhUwF1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=245c9aJgr7ZAq7q6OZWuHWAdLh4KfJ8t1XPnSxyq/TY=;
 b=OJkYnSHpkbUPYOxsCP5nzOWB3s9bYFsMx5HbsOXLB8JHEhS43nkJbX4YpwQLtxwjRZ0+UhcgVqS3Ttp0qiI1vLVBP1yb+2Ej7biQjDeaT5Oyp1thQ9wBdjxVIwYI7Mx7pjdLJYXAtjVcYuyWux6OBco3zLytxvkjvYq/EN4L0jbVK6f1GR97JKMvHDisfPhaPfrRzHdSsKJc0Tuvd9slpd3rSo9hIkI5YdM7BbvCp1Tvs4cfGik0dN1zotP/HTRJbo6loP+4vpGjm2B09fCowc7NnfFWnbp6HkRcqGV5+vbWJ5Dlumyi4yy+t0yJL8Q9qCht5zq2q+CgxpAtVyKV6A==
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 08:13:07 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::c8) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.17 via Frontend
 Transport; Thu, 18 Apr 2024 08:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:13:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:12:51 -0700
Received: from [172.27.34.210] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:12:47 -0700
Message-ID: <1b678660-7ee7-44d0-91a7-14985d2c469e@nvidia.com>
Date: Thu, 18 Apr 2024 11:12:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v4 8/8] ice: allow to activate and deactivate
 subfunction
From: Shay Drori <shayd@nvidia.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<michal.kubiak@intel.com>, <maciej.fijalkowski@intel.com>,
	<sridhar.samudrala@intel.com>, <przemyslaw.kitszel@intel.com>,
	<wojciech.drewek@intel.com>, <pio.raczynski@gmail.com>, <jiri@nvidia.com>,
	<mateusz.polchlopek@intel.com>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-9-michal.swiatkowski@linux.intel.com>
 <0045c1a5-1065-40b3-ae61-1f372d4a89e5@nvidia.com>
Content-Language: en-US
In-Reply-To: <0045c1a5-1065-40b3-ae61-1f372d4a89e5@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9485f6d0-a0f1-451a-1686-08dc5f7f60ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PpVu4S4JL1u+cpqga5yeVyOqeMqkbyy0w9PEg9MYO19t1dxUQFK/sdIZxjF0SBifSW30+FZGECkxReyXlAqJ0gIeyvkLUOaCm1ITMrnYlf+S5sqos5DtbNWwEmb1B72D+K465CvihNLqLnjGyyNc9InjHzwc+L0nn+eWrQh5h1apDIv1Mxg3nUcBJOo+kQLh39NgjaK1kPbjIhoa5h8kKC8tyQ5zA3LraML57CIup4cmIzEUIS3275gx5CSlJEATpfrFuk3764gK58aIyha4PsBj3+Ia6C47trEPJRBMtq14Ulf3EQNMWs+h67xivMacyqoA96pU8Jix8gu8KEPG7tK4C9kVLkW54d8VX1iXnCP4JJZzP37vYZ81RqS3U5q9P7Hlnbq1FrFtu9CYXjWfAOD2EfwRXxmh4bIOlV1C4/T/hs6wjhE2EN/4WJYfJi74OknLL+ZQ4a3mO1ajazmAggaFtpl7k437ldl3djqVbaA9yQwFduZmu5OyLPPR/g9Mqr7eDPb2j6eiWoThbpinOVwdbsyOVCdmmn9J8BnP+NoYQfCR8KgD+F4UQteGPTuFKmiRFU4s7+S+hLzy7IKfjn8iGSHAQBvChSeDNb4kPW9f3785IJKcRGh/uo+ubSPsurOl2PGOCYZjbPCUo8XVmaN6HFp/YZzHFitNm0GHoRAW8cJsTppRIEGYUiCvxGWvYjPxh1HGo/8VQoRW7RKHn9T+G6H5UsauHazUYB0l5hguvF1WD4DDdqYKC+c5h6Jb
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:13:06.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9485f6d0-a0f1-451a-1686-08dc5f7f60ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

resend as plain test

On 18/04/2024 10:53, Shay Drori wrote:
> On 17/04/2024 17:20, Michal Swiatkowski wrote:
>> +/**
>> + * ice_devlink_port_fn_state_get - devlink handler for port state get
>> + * @port: pointer to devlink port
>> + * @state: admin configured state of the port
>> + * @opstate: current port operational state
>> + * @extack: extack for reporting error messages
>> + *
>> + * Gets port state.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +static int
>> +ice_devlink_port_fn_state_get(struct devlink_port *port,
>> +			      enum devlink_port_fn_state *state,
>> +			      enum devlink_port_fn_opstate *opstate,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct ice_dynamic_port *dyn_port;
>> +
>> +	dyn_port = ice_devlink_port_to_dyn(port);
>> +
>> +	if (dyn_port->active) {
>> +		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
>> +		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> 
> 
> DEVLINK_PORT_FN_OPSTATE_ATTACHED means the SF is up/bind[1].
> ice is using auxiliary bus for SFs, which means user can unbind it
> via the auxiliary sysfs (/sys/bus/auxiliary/drivers/ice_sf/unbind).
> In this case[2], you need to return:
> *state = DEVLINK_PORT_FN_STATE_ACTIVE;
> *opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> 
> 
> [1]
> Documentation from include/uapi/linux/devlink.h:
> 
> * @DEVLINK_PORT_FN_OPSTATE_ATTACHED: Driver is attached to the function. 
> <...>
> * @DEVLINK_PORT_FN_OPSTATE_DETACHED: Driver is detached from the function.
> 
>> +	} else {
>> +		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
>> +		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

