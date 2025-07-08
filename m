Return-Path: <netdev+bounces-204998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D493AFCD30
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559CB1681D8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF312DFA2D;
	Tue,  8 Jul 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YI10W+G4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4B1F956
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984169; cv=fail; b=bIvuGb6MZzTqG2Windzf50cVnzNYWtT8KRk8AD1d8bxpxzxc7qkTQ/Ay75aNlSzYKTwiCS612uW9oPEUpaJJQZOc11t3n7DIB4JFq9SXiRJe6DxWz7jxu23UtVYewhHA814BKTUfvA9C5/R+kEodGuWwMPia+ar5NwbjmwY1j5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984169; c=relaxed/simple;
	bh=gEuRmX2lsiB3MjxeABKQ/ZSz/dEndPauU50/l08NziE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=PsCemli4/pcKp2XPp2ZuoCtIDnQ4hEr8h8xmLTBHBYvjlIvjJXAqbvGKIdCET0J4r1ds2GH3/DVOzop5+wuHO7hDEyQD8O7HQ+aLmQ3vbagX0bp/V/D4Idu5ahTP6+7WL0U80Rq5D2WOMNN0B9dppdwEPcf4TLuZDsXRy3Me15E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YI10W+G4; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auwMCn9ZuVMk2rGcflOPthEEDMzVhpz2WBNxlOKePvlz3wi/0W1v4DHyBTtyU9CPstzkQjI7/SSdty97ZpFlNHeykkgqYw+QA7GpYc5xM1P5TBBBgcf0x51+i6i8dLRpHXPBrbol6w19x1OC1EaOgkrnJM6jkzN8Noe1IPODxcSKuuMbj73LbB001vuQuG3ns6yLqYcMn0nZsjAfPuO21EqJClPjAssCi3y18acA9nwlEbVt+5Rhvwlj9q1pBihrWdhaBNVp7OJ5QggnZhSUJLqEw47lM+x/Lb8K1c10uH/0pMhPBH7iZxvkTY6o2EG0TX6rgrQEQvBoy0p/+EJsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3wiQ9n/7sP3+Z+gmto6qlU77D4AtKOS+J25FdXYNow=;
 b=F7kWJkk4H/1QFCQ3D9dU7+dT2CXXgGv1eubrxrcjtuNIJ/UoKovglvpq5yCEc16cCny6z/FjB8Rrh5TWUEiVgE6m/Ot/VilGjb/ySuqDOMGhgdMpKrYZx8322fZu2lPLzoiHMh385ueqk1u1p7LQpbelJzLEXv+UkVS36j3hkCYIYGINwHJQAbhv6ibvvuVDfXS4M9VHoeJdzati1I75EvcW4oYfdSebr1u/dZCXCP+2z+cESQgX9tW9U3o/r+lYgJzOwuJBor2Pczn15Nk2pF0cJj+BFHrWQUQonFGYBSwwGXIan69BlAT1hHIknkL/W6e5hEcVvlPf0BcwQGz2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3wiQ9n/7sP3+Z+gmto6qlU77D4AtKOS+J25FdXYNow=;
 b=YI10W+G4rC5n14WvjKTegTGlpu54cGxU88Rixh5WolU3nXT4fd0YrQL1zI0OkEvOzeCuURp6qHlqS51kLQySUurpw6/1zu06R4dYrejR1OlQ/X1bZc17dOHhOeZF6wLRqFb7bilmKpTLmSaEsBZNzvKqYReRXJ7KTil8ErKTivmaUxy3OQCSM70YhKHtaEk6xOYlIRvPVowRVlRrTQRJzuzvop3OU188nakuAOGDAHm9ZY3DzoKnAHcixXGrWjG8rxW7lwkc5+/KsbcJidodNKe4BT02fXb9Hmlq8rhuwLUvKM03A6TxtsugJ7FFK54Q0b3gzytmWPLa/2AMbN3jhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 14:16:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 14:15:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 tariqt@nvidia.com, gus@collabora.com, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v29 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <e5b994ce-247c-4bfa-96a5-eb842ef99e20@suse.de>
References: <20250630140737.28662-1-aaptel@nvidia.com>
 <20250630140737.28662-2-aaptel@nvidia.com>
 <e5b994ce-247c-4bfa-96a5-eb842ef99e20@suse.de>
Date: Tue, 08 Jul 2025 17:15:55 +0300
Message-ID: <25334b64vl0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dc3021-92ed-46a3-61a6-08ddbe29f672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se2N6WIK7U0J5Zzu6M4JpmrTEnaZmwMhq6/Js9bJOqFFHeaWKvU/w3nOxgUJ?=
 =?us-ascii?Q?H4RGwBFgADwCphaZ9IZvYa7L8CpkscG206WSgp3eeVY18peHqD8If3H54z4T?=
 =?us-ascii?Q?4p0pBmSElL7BlUpqdiitGbtYxHgXloZqtZyuqVWlLhJI5jImzCy+KxP97RmZ?=
 =?us-ascii?Q?1e6/URgkwxfUHMuItqEbtjrLjw81LmHG/Jis6ery4n/7Ow1CmMYyBMVrQi53?=
 =?us-ascii?Q?KGuu2lBpl3jp18p39QyE1HeI/OtzjeMqVhpFos0M4fWKmOX0z040OfIiwFTP?=
 =?us-ascii?Q?UpXNDIFwj+bTlOEXkqANXEK6YeicqgLze+uQzzmcCLI6XwdZ5mE4zhC8kmW+?=
 =?us-ascii?Q?09lKSpYMT9EYzbkTC9Z5QOwrOdzIi6eSuRyQq/K05LrLyu3f/7EyzO1ag9X/?=
 =?us-ascii?Q?BhocNOvh4ccq3zD4jy6XdiUm1sFL6tRcRMsTQSAjuCnXGZNbL2ASRVNGv4eK?=
 =?us-ascii?Q?Z4wR324gyv8e1Rx3P7NfRYUOQ49jmym96nKmJSoAn0gt0R/OWyN7Y2urMeys?=
 =?us-ascii?Q?gB3tXUqtJPpreYIj4+Oos/gj5n/IBUPsrsTl0m5qOqkhnwRPNrDLlIb+5uKp?=
 =?us-ascii?Q?KzUogM41V7bYevUWBklAOMMWboHO6gnZp+SJzK0qzN2m+6C6p9k+hYwhWrkO?=
 =?us-ascii?Q?BZx36fdFFGOOu/7n4/eWJHZWBXjZ+XsQ7M9thXXd6ecngnXph6ENA+YLt1Ny?=
 =?us-ascii?Q?jl85tNy60VRt5b7tPB+38LSwGAOjNBi504ZKLdnAW8y3Y3zFx6kiVFPsXsBm?=
 =?us-ascii?Q?mRNU7Yrwidx7zW8j5uICeZbxR4oDzP5vSg1ExfwAH8ZDINsm0dD73kqE3Eg6?=
 =?us-ascii?Q?rPCPH2NYMR1bIbe3/WQs0zyoqa00JiqW2Z0IrC1xSqxHZPRCJpfCcQJkM1la?=
 =?us-ascii?Q?kgj5/6riR8IS8sUYy4n4miYo9qIklqdsXLgDUb4WhHe9LjF5aNZ2s2jiRGrs?=
 =?us-ascii?Q?pk+U4w6T+GDV2bohTwWbSUDlVPiIiWKH1jxPGuOFhXBYU7Q1EM91GseMPcIM?=
 =?us-ascii?Q?dTg6Ddl+bk+KMpg2oNMX62bhUTZWH4MCkDG+h4rseQ412bDcBAMiPRxqlH0U?=
 =?us-ascii?Q?sWseRFU/6viYXhu6aFYCPpE54I+eH4vCwV+nKnVOjxSTN5ZyCyJraXKPx04h?=
 =?us-ascii?Q?w1CvHq4aYZtZ0ivUjdjitzAX3czG43C2xwcDgYYxBD5Eeeeu7mOLIKK0Cvzh?=
 =?us-ascii?Q?lbpL884EiKvedX2ZlgOCs+A4XmafLnOCvkQ+rCetAa5FjoqON5hZOqsUnz10?=
 =?us-ascii?Q?laix+yuxZtOrKw9QQF47r2pbHzRAmup2MTBAs5Bn65S/SqKvFkEtbDEwiNen?=
 =?us-ascii?Q?h5Gnn9uedZFMbMz3W4S42wJVQrFdLje8+zOJePlHxtxyIASGJuOknOnYXnUL?=
 =?us-ascii?Q?Zube6qKZWDCmjbjLCSL2mjTjeojwZbCD+geS9pFasDMIjRgkWUgBbEQQcNTb?=
 =?us-ascii?Q?SoFaODqd0hV0irgV0BbYwDcWsyvsoJMsm+odJ8mp6EN5uBH1Xx2jzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2VLj/E/YmpkGJbgu7n4yqQO0lOwArCJDjb1zrIET91nEJsyEZFKw9fP5frf?=
 =?us-ascii?Q?zEj9HzIW8rpMdWsrw7chMMx8PIagsF53RY6COKl+oy3QjnnwXO8ltkInIF7J?=
 =?us-ascii?Q?m1n60ByRDp1el46z0w7mD7wfK7SM/R0pFuTQEs7sYTfg+kwFNBB3WKMn4qNk?=
 =?us-ascii?Q?IylIFDcoLqMuEMr0/FJHyAtBB40pBsKwm9zWlbzX2M2fYZW6+1qif5cUFvzf?=
 =?us-ascii?Q?1XnS5CbcnkXz47ib/wMgqoVV12HrsDb1DvAA7puTd0ji5ARNwf2C3ZezT14M?=
 =?us-ascii?Q?/D630QmRZm+phFeXe4JfXrWVHgwT4NWSipaPCklmlNy8KPf33D/JyDYuIP37?=
 =?us-ascii?Q?r3NiP31zFGe8flqFmCRfcnck7sczhRbyd3X2sRog+3T7mevFOHbTImpIbHFj?=
 =?us-ascii?Q?VK8BH8BKCgYv/XFQhHWDbWJBQfZg2yKoliBeFXpq/5Kr+FM6VTR/DwXllc2j?=
 =?us-ascii?Q?uv9O4TeTnUFB7O6GOl1iNVU6S+q5QaWwXPhKQTsdK8c7mZTG9Uc+Hs0ELXf/?=
 =?us-ascii?Q?SNaa1PctfV45bfDfMMRlesIuZ0ZPkikBL60HV8pE9ud/pcbeIZ4WQziuEoFS?=
 =?us-ascii?Q?uPxktzOjscVhdCt3gb0d5Q1IzbG5DvppLCUv0XJn8KZCaq7BL8NDxDJR199M?=
 =?us-ascii?Q?nlD90nQ5ZL5C9DqqbJn6hx3BAahhIdQBjJDPP0iCIWdPVx+gOFR2aJEq176v?=
 =?us-ascii?Q?kuDD5rE/9gakWZVZmfkI9Ua0ZX4KkJrqzrDmJQIibrZRzjCj7RyeoFfpIyHw?=
 =?us-ascii?Q?T7VQUZepi2IOCIGubOFgdkxqoY8MareRL36wvvcRQwMtXm6F8AhLJVlaerwt?=
 =?us-ascii?Q?5WLoji/OCy6bBH4ARl8rrxfA+P5xSAN1+kBOO5sMxfuVPm4DzufvpV/tO7NP?=
 =?us-ascii?Q?kgFy4UXXGlM5MJu1bU1DX0SvbdmuXQczgn8LCZhWQBvj5RXebD4vDa1sBMfa?=
 =?us-ascii?Q?vCGJMerd513PCkpExsy8/MqsWr7v5plcW59GF35cT34+h4roZzDIebqNhT5g?=
 =?us-ascii?Q?rR8StT84gO3W0K7S58Y07y6KQEjSRKF7wRZ2yvAOoOueBbkYvm2gUPtSlHoo?=
 =?us-ascii?Q?uf+jan4cFQMkEM/DAysAAsppe7pc7BT6OGwjesTaDQ5hiziV8xJV0XqVP1mP?=
 =?us-ascii?Q?Ju0Oz9OG4g4FXX6GvYitgm3ASAEhoiJ6SzOYvdEbpdXhMZY9jprhP1HQAobD?=
 =?us-ascii?Q?AQ5jpU+t47KtAIeTrTvZ904cSJSD7DbOJb3p+3ilNUR6f5DjRejHrNlTvv6B?=
 =?us-ascii?Q?OKtA43I2EZdMfYTWhG6jMoywYCv9Fzf4wXpnZhOtQzoV/EAvCm9mN9/GxbiP?=
 =?us-ascii?Q?A8Odi8xRoMy3LWxk6uN6aRPgIvGDbe7kNNdp3Z2lAfBQcfXlBTgt7wpHQU2f?=
 =?us-ascii?Q?GV5HbPDImH/cqFfgdXmSSMhq87HrRXZmvTu4LBTzC+GAodG5hassZHcoCe69?=
 =?us-ascii?Q?vk6pjKZ5ynobV3VfqsrnmzrwBPn2DOSMqRaJAT9z86sUxp2bKvg3chGpU08R?=
 =?us-ascii?Q?VfUfgEdl2PfjukgmKthPV1pIYvTDL/HuC/cBkXbu9uiEJCh2iPL267McKMMO?=
 =?us-ascii?Q?Pyd2cSFI7LXkkvbddg/PzF6XcbJZWxQJ/fCj+VT+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc3021-92ed-46a3-61a6-08ddbe29f672
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:15:59.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9Gp6niDUUuI2R93q678jf7S5BCK28EoQ6luhVGQsAmz5pOqdW6oeq6uJQCWgDyh0OpbQBXFsVZnMM03vfqUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

Hannes Reinecke <hare@suse.de> writes:
> Hmm. One wonders: where is the different between this DDP implementation
> and the existing DDP implementation added with 4d288d5767f8 ("[SCSI]
> net: add FCoE offload support through net_device") ?

On first sight there are some similarities with the FCoE DDP offload but
things work differently.

Device querying:
- FCoE DDP has an operation for retrieving hardcoded attributes from the
  device (ndo_fcoe_get_hbainfo)
- ULP DDP has an operation for retrieving protocol generic and
  per-protocol info (limits())

Enablement:
- FCoE DDP has operations to enable/disable the feature on the device,
  and dedicated netdev feature bits
- ULP DPP uses netlink capability bits instead, as request by Jakub

Payload DDP:
- FCoE DDP works on a per-FCoE-frame basis, on top of ethernet. There
  are ddp_setup()/ddp_done() ops.
- ULP DPP works on a per-IO basis, on top of TCP. One IO can be split in
  multiple TCP packets. There are setup()/teardown() ops.

But because ULP DDP is per-IO and based on TCP, it requires knowledge
about the ULP header lenghts encoded in the HW/driver. It has to handle
OOO and dropped packets, via the resync() flow which FCoE lacks.

ULP DDP provides operation to enable/disable the offload per-socket,
which FCoE has no concept of.

Another difference is ULP DDP teardown operation is async. The ULP layer
does not have to wait for the HW to free up the resources: the ULP
provides callback to the driver, which the driver calls when it is done
tearing down so that the ULP can free its resources.

ULP DDP API also includes per-protocol stats retrieval. Overall, ULP DDP
was designed to be extended to support multiple protocols.

Thanks

