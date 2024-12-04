Return-Path: <netdev+bounces-149082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CE9E438E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88083B86612
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3822258C;
	Wed,  4 Dec 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N96VLNqq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6626222570;
	Wed,  4 Dec 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331752; cv=fail; b=WzsHbqRa9SvW5muMmvfh4zbfc2amYR7ZhBiQZK/mGPAM/IW4IKEiPeRDcPzCxI3aGoY3hDC7xjeW1kYnBQcsZPY3CiuZb94vCnECrkokkKFu3UZVq1V86onTbX0cj5cfq9QcUpBoLbRNxdq3AAQa157D10h3oO/WQaRQUN1+5vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331752; c=relaxed/simple;
	bh=l7nFsJ13kwDcczfPzpFtl6qFWLKgICHUYJRLsOj1xSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkJxZA7tHbMKxhy9OvxEPyOQWXPJqn2d3ShmynFJrTXTPrFRu4BGxyJSM/HtwZOOiRdWH3IKmzFFutBWPBGWD2zcUZYhaSUotVbuY9r7+ywP945VQ6e+7mRX8gI+SIEzibGSum1eKzRJojs8rVZ1JnEl3xGx41x1yBzEp/OKHVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N96VLNqq; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8Srzz8qjYrmLs7W6yKXSfuY3BEh7nB8WIQfGO3DgQi8OxMC1ZNFwURi+4AbjLwMIf8D0qh0ymhgwj3/mPTS+7dqC80PHcYqCe41SQb5N5QS8MFnCM4QQmVEF0srJm3BTU5bfxCHX3r5xA8N2wCWtCUCmzlSMsQqzwMsBpfZCshAET8N+4t8pPeo7WwoT45fAltzXelamYooDxaahYgsIL6QWSaGQ2oJN5XkmZYVDsmMJ3P1VgDtEV/hgi6ac7pYrmC5iXDTptjK7WMKWc2anHE/fnjmAjPLcCa1+JM5PYPN2M/GFiWULtgfa5eNncjK6XTIGADn4e247whjTXVpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaJ8GrnhbClxvVCGw6mMKQjY879opyTtr28ip6LZkBI=;
 b=lwE19lP/Rm8GarrhPoK2SacykB+yXdNiuXeGi4z60+uhs3VZYNq23tSRaHKeypNsvu0bJdzQ/adVycjPqSQ20wtpF0DKZytYlJ2KpaZWS8TesQ8DZpks6U3ij3yEfG5Qehdg0sqrfbgD2Pmmqh0Pc9ecZc4/GgGQKkuSkpnK5wsGIzNA5D/wxChuhGOihGrE6Gv4dBxiM90J8ETywtqkhaxaWUH0GoBiCGW6PQyOPkVCbkO+3hCRfP3TKZXDPlY8UnOPVFBxzba/8KFO2LW/iJfWiNBtrwQ146V1BoJGSMzQLiacKOYM7AS2P6MaXxZ/5pDBSrLHFaFOXwexJDDoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaJ8GrnhbClxvVCGw6mMKQjY879opyTtr28ip6LZkBI=;
 b=N96VLNqq/eeKvf/57t/sD0fOaqDN/FYjpumUHIfNlXFOVi3chEE9zDBwVNjxd6H1t7qChhbugGdWkw1FbQjBxOX/3uSo2fzjnZipmDzxDMbzMtz6ybpfNN8y5KixoTGASWzd5rpY9WBJ4JUtODpIVXGx4hJkQ3HnujWj1HswiHSYEWLYdtvqk+NYx7CuFx4ruTYo9FIWLsKk7ivF7WwkiGc1rQnimG/y0n+pda9nkfFtfDomXnUVnvBwApXfSOnRqWGvngmPDikYB2lq53c5WRPCQTHADtwlP+MqqTMdhRtUzBqBocj7wk3PIfCbFXSda58UWziBAOX4VSlYtkB48Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 17:02:26 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:02:26 +0000
Message-ID: <9719982a-d40c-4110-9233-def2e6cb4d74@nvidia.com>
Date: Wed, 4 Dec 2024 17:02:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Furong Xu <0x1207@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding
 <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
 <d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
 <20241128144501.0000619b@gmail.com> <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com> <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
 <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
 <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
 <2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
 <Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d93ee56-bd06-49cf-36ca-08dd14856deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXRBYXp1S0ZOSUxwWDRMMEVPS0VMdlFNNW9tTERBdGFSa1hSUTdRR2IwUDZS?=
 =?utf-8?B?S3F0RjN1WENQeDg5RnBrbmxlcEV4anBOK1VDRnllckxIRE5UN2I0eHRaTFVQ?=
 =?utf-8?B?UnhtTS9tc2thNlc3MzJhRDYxNkZybXhicFZkZmN4a0tGM1pWU3pFQWxqbVFQ?=
 =?utf-8?B?eWNRLzgxVC9HZi9SaEhYWHVITERrZXA4eXZjRkIzRVozMnFHU1N3THBZakV0?=
 =?utf-8?B?aWxsSjlSd3paNGFQOFBnOWNKM2RibzJPd2pnZXVvdnMxUWlxMVdLZlpUSHI1?=
 =?utf-8?B?WlVIekNSMjNEYzBQaWx4Z2NaSjd2OWtDWWd4akJWNi9jQm9EY3dUaTd4K1Bx?=
 =?utf-8?B?Rk55L3U5d0V1SXhIeC8rWGQzSld3MCs3OEVNS3BXRkIyTWtkcTRrMEZ0Sk9F?=
 =?utf-8?B?R0tzTlRXUFhjcFNlekZLQzlyQ0FZWWVXYkYxMExJRjArKzhTL1JpWURFbGNG?=
 =?utf-8?B?QnF3Z0RHZW51MzJwV1dlSlA3aTU1R1J1L0pBdVpHZ2Z6YjdxSXdFTklhUFIy?=
 =?utf-8?B?OEdiT3R4a1JvVnYrak1lKzdmK3VoRVJjOTBqaHV6L3JHRnRaNGR2YUxIY3A5?=
 =?utf-8?B?M0xtUWtvejVpMUZTc0ZuV3c4MytZMHNIMXhwZGM4VCtyWTY0MXpva3Q2QVdZ?=
 =?utf-8?B?THVKY3pyanZxNFE2VVBZRzd1c3pBOGhDZDJDUWFlNWEvenI5QTlpVUQ5VXFV?=
 =?utf-8?B?RXZKL2lBN2t4V1hia29uamQ3ZFpHWFZ0aDFySXVYdVErSnNTNkdqKzJmYkIx?=
 =?utf-8?B?bnBBWm12L0V3WWE0SGNxMU1meEVwUUpjYzF1T08wTnNkM1NsVkwwL0VGU045?=
 =?utf-8?B?SEJLaFY0dnpQUjJhTm5JSEdOVlFodi9ZRElzelNsYkY4TklWVFFGa0ZILzMr?=
 =?utf-8?B?eDRoM1BtNm0rSkI2cjYrZVVVbUxScjRSMXlhUjZmUlFBUFhoUFpPT3lTRHFX?=
 =?utf-8?B?eDBZS05IZUQ5V2lVYmNFcjBIR284RTd5OWxtSEVOdHAvV0s5d1EyTm12WERM?=
 =?utf-8?B?a2t2RnRjREt4RkN1VUZZMWJSSVY1VjN5WVNrekVCblpvQkpZcjZLN2tsNklp?=
 =?utf-8?B?VytlSW5XWEJpWmQ3L1VqNzczeEh1b095cjEzK0pBdlc5QnB0K3FveTFkWjI0?=
 =?utf-8?B?dkY4Wm5xWVZTazBTOGdZQk94YjBCN2RWbnlSdWkwRDFnUHEyQ2xYT3ViZ1Zu?=
 =?utf-8?B?QkRwNUNxdDkvVnpxSXdtcjFtY1kvMDVtam92WFdEZmFUMWRibUJhMlM2T3BT?=
 =?utf-8?B?REFrcUMyaStyS0pvYkxycnI0bUZ4dnpQOE8rcWNuODVYMWJaY00wS2dpTDRX?=
 =?utf-8?B?RGh5cmxXeUtxYlBQWG52eTY2Tlg3UCtNRSs1TlB0ZWJyM1FNSkxmY2pFNlg4?=
 =?utf-8?B?VEhNWlVGRHJUSzNNT1hTbWZLaG1WTDRYZmFOSHk4Y0ZBYTJ5aWNwd3dlZEZ6?=
 =?utf-8?B?Ry9DblpBUWtIUkdSZWd0L0xOMXdkU2pnZUNmTFZVVURPanRRZStyaUZOL1JQ?=
 =?utf-8?B?K3Rpa2UydHBGZGtaUzB0OThwK29IZDA4RytoazRPUDJuWUIzaUZCK2hUbnpl?=
 =?utf-8?B?UnMrY0VBelNpL0dWS0h0Tjh5Rmt6amlMdW9ObGJ0SGFqOWdIVnhsalF1NXYy?=
 =?utf-8?B?TUZQVmRHMlV6LzFIakF5NXd2RlJyQktQUEptKzBxaHZvOFNYb1F6bjVDQml5?=
 =?utf-8?B?Qm1UNWh1alI0cWpSSHNTYVFEbDBSaVBFTzRTN3cwQ0kwTWJnSU5Cam90b095?=
 =?utf-8?B?endhZ3ZIYm9sRUZDN2k3S1lYS2tBcmtQZzN1Zk1Kei94YVhrc0tIYTB0Q24v?=
 =?utf-8?B?VGNQNFJXN2RXRDFkSWdJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2hTWUEvOWs2dUdUTEJLbityTzYvNk1oVzYweC9GYlVHMlE5QTZmaUN4WlJq?=
 =?utf-8?B?azJ3R1AyV0gwa1BTUXN1WVpDZmdCbXIzVFZ0clNnaExVSmNBdVNGN21yd2dz?=
 =?utf-8?B?VjdrRVRFL1RGeVZVUXpnZVpVZkJmMjYybnI3L1BBa2duSkNicHBnSjIzd0lT?=
 =?utf-8?B?K1Jpb2NmVFB1d2VtelMwb1QyeUxNT1c2aXdJQ1hPK21RQTJqVXRlVTk0NWhx?=
 =?utf-8?B?ZWttNjUxY0p1QVRlTmx0emMzaHJ0NGN2bjArZzd5ZFdoUVNGejhpRzlpSUM4?=
 =?utf-8?B?OW51b1BvUWdHZWZ3aUZEaDd4RTdVZ2gwUDZFQ0VNVitkdXRuVlJDT0JCVWR2?=
 =?utf-8?B?bTNDNXFER2RuTUVIeStsa1laaGRFVUJRUjVKUndvN3NFZmpTOFIweFR5NXda?=
 =?utf-8?B?YzR5cEh2ZnJJOWx2ZEduWG1yWkVLN3dRMGg3RmdVZVI2TlBseTdEdjJaVnB1?=
 =?utf-8?B?V3hoaE1wQk5YcC8vaEplOWFkOVJmaFR3d1ZpN3hHaGIxWW1aR3BvWWh5U3pR?=
 =?utf-8?B?VzI5NU1rU2xGVXpGUC9DLzYvTjhlOVAxeFdTMXZ3bHM2MHdINEI0WHM3MG1h?=
 =?utf-8?B?aG9RcGM0NXFnUGJKam94TVZuaUZUcWU5OElRWnJVT3cxRHBtRTBoK1NWcGJE?=
 =?utf-8?B?R2hSSFB0VVk3bWErRE9yQnloc0YyRSsxcHRkOVlFTUIrVmVmam5jQWhnenVJ?=
 =?utf-8?B?bTVZYzhxMEluRXF1NzI0NUhlNk16b3JKUWNGaVhZbzkrdXRubmhiN0JFRUFw?=
 =?utf-8?B?QXNyMHJlV01jWHRWRFZIbUkyUUI0ZDV4cHp2OUY5Z1dxaUVNRW5XQmpnRm42?=
 =?utf-8?B?cldqQm03VFRQeUExSWpld3VMd2Z4WFJKanBkbDREQ1NRWDNvMTY0ckZ1QkJC?=
 =?utf-8?B?eHRRQjdYSFljWDdEZE9JN0NPYTVIeU9jaHA2NWJoS3BsRldqZXZIYTAxbVBE?=
 =?utf-8?B?V3Q0ZlFvTWE1YWZ5MWFqL0RGOHQ5ajVUdlNReEVwNzBjcDE2UlpCSzQ0clpm?=
 =?utf-8?B?S2hLZjk2TmpRRmN2Z0FsZmtvWjFkNmF0QkIrT0ZQb1NHeFZ2RFJVb29BTVQ3?=
 =?utf-8?B?c1ZBWXNGeUc3dEVNMS9QMjQ1NncvL3BISnZGU1F6cHRrc0ErSXBqV0hXcWZQ?=
 =?utf-8?B?d2xaNXZHc1ZHdG4wd2RMSGVwN3Q5dlA3eFpQWGFGOVNnYXBta00xRkEzdXA4?=
 =?utf-8?B?WmEzSEt1ZkN4R3l2bVFGdmZxV2t5TXdNaVcyYTRvMkNiemNWZ0ZVMTdBWWxI?=
 =?utf-8?B?b1h1b3Y0NDMzTDhkeGZnbUJsVGt1Y3JSakNRNmRJRDhlbHNnN29tbDZHL3Ez?=
 =?utf-8?B?ckQ3M2NhMFpaaHRpWkVqMEQxOWhVZjBFTE9paUl2eDlmRVlpNmFFa0puVHYx?=
 =?utf-8?B?aWE4SUs1QjJuZk5VWUFXV1A0djJ0ajUyTXprUzhaSzd6bnF2aXFlUUdIMDdw?=
 =?utf-8?B?RnVQY2x1MnBlZFNSemlkOG1McEEySWI0ZXBNSDFmKzd1Q3ROZCtvdFVxM281?=
 =?utf-8?B?WDN4VXlJUlBsVDBsenpVTGM1YllJTUE2bWZPRkRyQzc5V0pKSFBYUTJnR2dO?=
 =?utf-8?B?T0NmWFkzV3VJL0xwRmcwNklKMHAyTEZTYVFkUUREbm1rejBYV00rTmdKQ3N3?=
 =?utf-8?B?TlBLaE9Ud1AzUGd1YmZMOGo1L05KeVZWYTVvVnZ4YzlBZmxGRVBvNnN2MGgr?=
 =?utf-8?B?K0o5NEV1aFJxQWorWU85ZnVjdFRUOGZMRHJ2QWJHeVplQmhZVlB2Vml3c1Za?=
 =?utf-8?B?UXVwd1E0VllJSE92cDYxWCtHQmxSaVBlUGVZUkREZmd3WG12TU9rSGd0V3M1?=
 =?utf-8?B?bzJmQjlweTBDTG1TNkxwY1ZKdkVNQ01JZ2EyK2JWajlzNW52WWlWamNVSUlO?=
 =?utf-8?B?ODlLV1RwT3ZDajRQYnJtS2ZmYnMrU2ZaQXRHS0JVK2NJbDhXeUpEQThYSVJy?=
 =?utf-8?B?MUZsNzVLMGg4WTE4Q2tZdGdNNlNiQzRJa3ozVGdrc21rUVBnckJiS05PRTBI?=
 =?utf-8?B?cUl1bmJtNDZqR2d6dnEyWFVWSFdXTVc2WERaR0R0L2FMejM3VXZPa3g5MWN1?=
 =?utf-8?B?bWE1TzJ6cEFJRUVlNkVXSkh5ekdteGd2VTZQV0JTM2NDZEI2eGVhTDdudHUz?=
 =?utf-8?B?Z0lWTTliYStRc3FiT0Q4T1BzMTdQVXVEQXFmUVNhRDMxWURmZC9YTFpaN3NM?=
 =?utf-8?Q?uZthaYC2lTHkRu07ddpaKtxXP2nMAtsmUJQhAQYvdZPJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d93ee56-bd06-49cf-36ca-08dd14856deb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:02:26.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yur6nRLN+kUThmgAzZpC3+RuzVc2mQqbbOIE5DbMOPaYeF0X9WkwadSepNbtgY3bA/knhLXq2rRUkj/LQxmWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

Hi Russell,

On 04/12/2024 16:39, Russell King (Oracle) wrote:
> On Wed, Dec 04, 2024 at 04:58:34PM +0100, Thierry Reding wrote:
>> This doesn't match the location from earlier, but at least there's
>> something afoot here that needs fixing. I suppose this could simply be
>> hiding any subsequent errors, so once this is fixed we might see other
>> similar issues.
> 
> Well, having a quick look at this, the first thing which stands out is:
> 
> In stmmac_tx_clean(), we have:
> 
>                  if (likely(tx_q->tx_skbuff_dma[entry].buf &&
>                             tx_q->tx_skbuff_dma[entry].buf_type != STMMAC_TXBUF_T
> _XDP_TX)) {
>                          if (tx_q->tx_skbuff_dma[entry].map_as_page)
>                                  dma_unmap_page(priv->device,
>                                                 tx_q->tx_skbuff_dma[entry].buf,
>                                                 tx_q->tx_skbuff_dma[entry].len,
>                                                 DMA_TO_DEVICE);
>                          else
>                                  dma_unmap_single(priv->device,
>                                                   tx_q->tx_skbuff_dma[entry].buf,
>                                                   tx_q->tx_skbuff_dma[entry].len,
>                                                   DMA_TO_DEVICE);
>                          tx_q->tx_skbuff_dma[entry].buf = 0;
>                          tx_q->tx_skbuff_dma[entry].len = 0;
>                          tx_q->tx_skbuff_dma[entry].map_as_page = false;
>                  }
> 
> So, tx_skbuff_dma[entry].buf is expected to point appropriately to the
> DMA region.
> 
> Now if we look at stmmac_tso_xmit():
> 
>          des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
>                               DMA_TO_DEVICE);
>          if (dma_mapping_error(priv->device, des))
>                  goto dma_map_err;
> 
>          if (priv->dma_cap.addr64 <= 32) {
> ...
>          } else {
> ...
>                  des += proto_hdr_len;
> ...
> 	}
> 
>          tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
>          tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
>          tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
>          tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> 
> This will result in stmmac_tx_clean() calling dma_unmap_single() using
> "des" and "skb_headlen(skb)" as the buffer start and length.
> 
> One of the requirements of the DMA mapping API is that the DMA handle
> returned by the map operation will be passed into the unmap function.
> Not something that was offset. The length will also be the same.
> 
> We can clearly see above that there is a case where the DMA handle has
> been offset by proto_hdr_len, and when this is so, the value that is
> passed into the unmap operation no longer matches this requirement.
> 
> So, a question to the reporter - what is the value of
> priv->dma_cap.addr64 in your failing case? You should see the value
> in the "Using %d/%d bits DMA host/device width" kernel message.

It is ...

  dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width

Thanks
Jon

-- 
nvpublic


