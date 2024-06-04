Return-Path: <netdev+bounces-100408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6378FA6D7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53503281159
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED933182;
	Tue,  4 Jun 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hbYQjJ2F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4C7E2
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460051; cv=fail; b=TMY689icq47TaqvXwXN7QgXEwulc8wCnh/aIdl/NV1CzOwasvVstKSMRnzeWamP22Ny+W6wi3AXqbXSQjvX+6e8KmnOfJwezePbgsbiafG00AgTQO5+457z8sCasNFc8kT7UN7dc67KYLewpolHJPpfBV+hhLS5wcmJ9byRG3cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460051; c=relaxed/simple;
	bh=+sYLTEYzboBwXeIXmA4kZ3lZon6B6H5ln6Bv1WENwQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUpXgCH3GpK8cZjoqodrmV0FerHGAHJfj/fviGAe9pikdZXKUmvvG9vQ8C4h44am5eJW5uillerF8Q3h6aS1bGqRA/2l24MZSSUeS6OajRTSiFzcL35iytEEDqOq0HFBxk5YDlGk2nLgyh1CSMgiXJc0SsCv9pTU7MnLMyeRW+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hbYQjJ2F; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWOGGPR+JET+maNz3oagsRbRmat2rV/SXT573AMtzbtVzYvNDL95Vzq8RcBddwCSckJqhbEfH77XQCjMWddZitQt/TwuER/ujijqUdiLTX+0LR770b6Ha3sO4UR3LRonzzTsQumxiqhVjGEC9cjgUjDMjjFo/Qec4NAlk/tt1p48Cwm/CcM5tGc4CG6J9ubVx0GtS2xwG3cSSz7iyn8xnChBSC/dvNyBsbUIjoBF0h+Ssink9FVKVcETzR3QpuE6+nXh/as4GvHleBE10UxBhuL6Cbz1pUSdiF9OfEm6Plu7db1/EcJOdglqC/nc7fdUD6KeWcM/HcoUdPFJrcJ1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHFQ4G/5l0udxA7w0qfu/QCuPuDJVeB/R3nEnZCxXXU=;
 b=AFkzTquK77pKY1WKzNW9DH6cRgsyEayVdJtkwwUJ4oco5l8BSZ0z8V2hhdBtJbQ+/R9mPZ0LJWNmMvilLQg5V6GXybBcLu6Iwy9ihuAsNUtnzw+nRfs2d0QHQNp7gQjx4gwTec6doVbP4R9+67kyrT1yFS2zP46RFbIoRfxRfq6Tjb85XrsYeH88w8GTeLiV8Eh7ByalKSbJU8NUFM3+0Uos6+F3uk8yuesn7C/4VFsyxq9QMDU3szHWl8Dq9Sh5oSVP5InCbIwXtW85ckrxc+iIBTfO+NjLCqol4zPeM8Cpml6ATCtkNRhLZ1xC8wA+aXIb/jYsqljbMDaCA8GzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHFQ4G/5l0udxA7w0qfu/QCuPuDJVeB/R3nEnZCxXXU=;
 b=hbYQjJ2FzqYotFKJm0m6HmnkXAhhL1ecdVcX25rrY/HA0r0v6ZI5x4GjQhEFYdpNUeCJEguXvmNrvexFmowjTfVn+d+jPpB6ZAamI858BKpRMytkMA0GrxcKdS+QpkRE6h5krplNM4c1twtWngtGCtW1Op3pWgJAunnwAslQabk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 00:14:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 00:14:06 +0000
Message-ID: <2e0cc718-38eb-47fb-ac02-150ecc9858d8@amd.com>
Date: Mon, 3 Jun 2024 17:14:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Intel Wired LAN Driver Updates 2024-06-03
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>,
 David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, Sunil Goutham <sgoutham@marvell.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Karen Ostrowska <karen.ostrowska@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Menachem Fogel <menachem.fogel@intel.com>,
 Naama Meir <naamax.meir@linux.intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb9d4af-f12b-4429-4ff4-08dc842b3f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhUUlljc3o2Q0h1RkJ3OFNFYUhqR0pPcUhjTXlOQnAzS01vY2pWK1ZlS2tz?=
 =?utf-8?B?UE1GNW5TemlDVWl4a3NMNUdNUjliS0VrV2F2VEF3QnFhWHYybytrSmo0dkxY?=
 =?utf-8?B?V0RaUFpxUGlsWkdvcm5IcEFFV081dlhOOWNVaWNIOU1TZUVZeURwWVJYY3FX?=
 =?utf-8?B?aU5ndUxWbUNVYktUR21oc3JRT0RObllET0l3SXJtMjljUE40dXJ3ekpxY3VW?=
 =?utf-8?B?R2psSDErTXpRT3VzdjBBa21CYm9KeWlEM3R5eU1KeFBoaFdaa0dHa21wQjJQ?=
 =?utf-8?B?TDlFdEZ6aHVsTHVYb2ZoUUI3dzR4UVpIZ21keFVlcUNoenFXTEJBNHRhczJL?=
 =?utf-8?B?WHdyekozSUdubytxK0wrSXAxOWpoU20rMjUzZTNTb0lHejEyYTJyYVVvQWVO?=
 =?utf-8?B?TUdITWVPREpGek5ERW9UV0ZCb05nTGJ1R0YxNlRoNG13RkZIcnFGUFIrZGM3?=
 =?utf-8?B?bDV6VE5LS0JhU3hHaUJVemxhT255b3gvcURSMXYwWUZXbmlpcnhjVytHRmU2?=
 =?utf-8?B?QUNzNWY5VEc5U3JDY3NPQWU4a0haZ0xRZFl2WWMzRjBmSkdnSGFnWk94eEs5?=
 =?utf-8?B?L0JWWGR6TlVWVmxFVHdwa29QL2ZVWlFjQW56cUMrTjZ3RGNKVFdKd0EvcWIv?=
 =?utf-8?B?OGZrU3ZPQjNqMGNOR1Evd1FGTk9MUUJubG9FdEJzMks3WXY3QXVEWjlJUDFO?=
 =?utf-8?B?cjdCczFwd0ZjVjZ1RG54MXY5T1Q1Q2NncDNsZXJ4ZTJlc2o0Ti9FUGNtZkVP?=
 =?utf-8?B?M0ZteG1wTjlrclptWWFBbHErL1hpandMVkZrQkhsTGd6YnZmKzMzM3FKckhO?=
 =?utf-8?B?NFlJL01UVEF3aEhCL215eWx6ak5lOGtkcXo0V3RoVEErOFBXMVUrTXVOZUxR?=
 =?utf-8?B?YWJkRStwUVM2SXBNTjFKWllQbVpMRUZWSjhZY0hENEJrSlFqUUVpU3FGR3VL?=
 =?utf-8?B?UGtUWDV4dzlIOUZvR1ZpaU9tYXlac0VGb2hEckoyVmxmY1Nha0txR3gyblFY?=
 =?utf-8?B?RUdmTzNUdUxob0cwVi84Um51dHNYTzFaelZSNlcwL09zNHlZb012a0F5SFQ0?=
 =?utf-8?B?NHJMY2FvajJISjFDNXhvMnhTcllHdHVldDRoZURHNEtpMFdrUmxGb3ljUDVX?=
 =?utf-8?B?OVNIKy9aYm1PeXNjT1U1UGtBMkQ5Wkh4aGl4KzZlamJreGZIaWI2UWhXT0dX?=
 =?utf-8?B?bjFYVVN5Und1ZFNBKzE5NXhxWGpkRVM2RUQ2Qjl0SDFKbXZONzdOTmpiQkMx?=
 =?utf-8?B?RnNQbElqL2FQZDZ2NXlrOFFyTnNLUmM3N3ZJTU1ZZ2NMaStoaVlRbStnK3hh?=
 =?utf-8?B?Ym5jY2VadXhOWUljd3RsQnRMcGh2eHRiRUpMWjE3Wk9BTHpCY3FVUlhNSExi?=
 =?utf-8?B?b1M1SzE2T2xCUVA4bXdSWEpqeG03YWcweW9xZW5BQ2s3RzB1S1g1Zmk0dUIw?=
 =?utf-8?B?UlNHOGZrZWhWbnE4V09QRFJCcFBhR2NZbDFUM3VKUXkwTFlqSGlNQTFtalA1?=
 =?utf-8?B?RXcxaXZzejhuNktJYldhbXhSYTJpNVBmcW41c29RTkZJMnVKN2F0RHppb2ls?=
 =?utf-8?B?MVVmMmxWakNZWGU5bElTWDMvcUFCbW4wTSsyUnROM1NxRUl3STJ0TW5tL0pl?=
 =?utf-8?B?cUt4djZkaTFoa292UEsvNDZMbWRnSlNCSFJHc3JLbFVnOWdJWGRwaVNMdnY4?=
 =?utf-8?B?WG5OT2gxWlpEMzJFa3FWKzNBcEhtaVZZamhlOUhlRnZkOXdRTEQ3RXVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylh5NEIxSVBLSXhva3h3RzBZV2trcmtKcnpQZlBKVmlOZER3QUlPUXhzS3BN?=
 =?utf-8?B?WFhWczJXbktRdEtacHRMa0NyRVZyV0hKbmJod1loRDRha0w5Y1JmVndNeGlK?=
 =?utf-8?B?amNwV0xITXhrTmV2RFVVdjBzSE8yYjZNYVdKZzk2UDdmL1A4VUhBbytsdFYx?=
 =?utf-8?B?cjV5dDJiTnAvS1hVNm5lU1U3R1BCQk9iUmJUNktDeTZEa1NGVGMvYzNJeGlo?=
 =?utf-8?B?N3lHekViNjdONUNNNU1Jdjd0aG9WMkZrbWIxRzhBdVhacjhyZEJtS0FIa1lJ?=
 =?utf-8?B?bE1WWitxSmp2aSt5bk9NS24xR0RJYlZBMTkyd2ZTMHRsTUVDbjlUOWJRZmJI?=
 =?utf-8?B?NlJkUXlrSU5Za1JZTW1uRGhuT2diKzJrSU1lNGRlOTYzWXFLcC9ISW5nL3dm?=
 =?utf-8?B?Mmk5VHJQVndsRkMxUG8yRC9YcjY4bWgyYkY3blRLTEg5MXlhOVp3T2RrN0M4?=
 =?utf-8?B?d1NGRG5mWjY3eXVuQlcwakVkbEtPRm1Bek9BSkxZeVdobGlxNEQzOUhuQ1pJ?=
 =?utf-8?B?M0lPVU9IMTlSWlRzbUNuNVNZVC82NnJLK25YWGlPZTZ6SHRDVHdUVUptUjNv?=
 =?utf-8?B?Mm5NbSs2MWgxS0hIaVlXa1RSSlRIK1Yrd2l1S3J1Ykw1dUYrTFBIa0hadHBK?=
 =?utf-8?B?NjBIOGU4ajErVzNNUnpWV1JLUmp1ZWw2YU5oYW1RdndwUzlTR2xGODlHbHpk?=
 =?utf-8?B?YVU3emVSdEVEVlRPU0FSK1IwVi9xS2NwYXR0UUY1cFc2UHdsM1hvUWk5c0Yy?=
 =?utf-8?B?T21MOEtRNHhiTWd0MGRqckRRamlMa1lmOTNhUDF5aVgvb241U3hEaTBtcFMy?=
 =?utf-8?B?OVA3M1NpVk4wUTdLVTNvRUJKdXN6eHZwSXAvM01xZTl3ZUpLYlg4dnZybG1U?=
 =?utf-8?B?QndRL2JiYm5IRG4rWHZjRWdVengvZzVuVE5WTGxZZVU4UjFUVFpHeGQyL2ZX?=
 =?utf-8?B?ZEZtQ01IeEZkTmYyVUlnZy8xRW4ydmJwdVBxRTM4c2lTMlhpOWs4OW1SZnl0?=
 =?utf-8?B?c1VFUVZ6Q2xGVW9Tb0hiUy83ZDFRazRwMXRQOFlaR0s4cTA4YkhOWFBRMmF0?=
 =?utf-8?B?dTNnaE9saEhQVjFNWFdPc2g5SGF5eTkyVWNtWldpYThDUWRoRGtkaGFrQ3h3?=
 =?utf-8?B?SmVKVnNIWVFmOVJwYTdxTU9CQmFsaktOY1FSR2tLRXZlRVhLb2lFbVQ3aXMv?=
 =?utf-8?B?cmxxYnVvQktTaG0zNzl5TWEzOWEzZ1I3TURMRGw2YWRwbkZQZE43aVkvblpM?=
 =?utf-8?B?b1JjQVFQSzVxODdydmtXRGdSUnlBek1jbFVINnI4aWpWczN1SWdVd0pKN3dq?=
 =?utf-8?B?Sk5xUDlja0JQWDFNUzFXZlNyaWU3dVBKVVpvSmUyNnlhNjkxQmdwL2RzMHJ5?=
 =?utf-8?B?U09sTmMrNGdLUk8yQklmYktrd1lCY0tnelAyQ0wzd0ZhckFucms3N1RhM2xO?=
 =?utf-8?B?Sml6T2dPOGxXbUovU05WTWNGSFZuQmJZM2hGR3BRWW53dmd1VmhMOCtEQm8v?=
 =?utf-8?B?SStsdVVSOG55UW1xMHlkWUNTZ3NxV0w1dFJPNHpNbFIrZ0pnSzFRTkRVYnlm?=
 =?utf-8?B?ZlI1d3BrSVZMRDFSK1NVZ2dZL2RiMzN0ZkV1c0paUStBcFg2dFRlbHd0SUFI?=
 =?utf-8?B?T093cU9RRHpoWUlKK095NTRNVCtsb0ZNQ3MyOTRwYWkrVnZFRHdETUN0WFFF?=
 =?utf-8?B?NUgxTzZGc1kxcU0vVnFkTmZxRjR6UHA0U0dhMEwwS1RhRGhCazU5MDgvUlZE?=
 =?utf-8?B?NzFrV0hOQko3aW12QjFrb1UzdUFvSkxwZmczTFp1MUhiMFlJWVRONFNybmh6?=
 =?utf-8?B?ZUExRE1XcXJYbGNwSWxXLzNzSGsvM0JBcmJuclJ2TmY3QmR3MEVDZ0Z5TzZw?=
 =?utf-8?B?dmZZazgxeHM3SlhkOSsxeHhucENraGxCN2JzSjNaL29NWGlaUjVua3dZWnFV?=
 =?utf-8?B?K3kxVkVxbjBiV0tPQ0Z2U2p1RGFHa0N6bHUxRHNTcXhaa1Q5V2krV2NwUXB3?=
 =?utf-8?B?VTdiSTRHWGZFeS84STNQdm1FU09CNzVZWGI0TnBkQUhIMjlvUXpUN0t0Q2hj?=
 =?utf-8?B?UTVtOEJGcEk1YUdsZFROYVJCZkR5T1h2M0k0MWdBMEF3ejFYY2Y4dHUvbXRt?=
 =?utf-8?Q?ZjmvfFA5fz4+5NAIEZ859Wwrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb9d4af-f12b-4429-4ff4-08dc842b3f7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 00:14:06.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpkRxnKpuYrFk+StA3k36cb6I+zf/gsGnr6QLaBj8g+HnbN3z7EX3pAodxVhdT8qqtE5gY5IAfW9GzBBqtx3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

On 6/3/2024 3:38 PM, Jacob Keller wrote:
> 
> This series includes miscellaneous improvements for the ice and igc, as
> well as a cleanup to the Makefiles for all Intel net drivers.
> 
> Andy fixes all of the Intel net driver Makefiles to use the documented
> '*-y' syntax for specifying object files to link into kernel driver
> modules, rather than the '*-objs' syntax which works but is documented as
> reserved for user-space host programs.
> 
> Michal Swiatkowski has four patches to prepare the ice driver for
> supporting subfunctions. This includes some cleanups to the locking around
> devlink port creation as well as improvements to the driver's handling of
> port representor VSIs.
> 
> Jacob has a cleanup to refactor rounding logic in the ice driver into a
> common roundup_u64 helper function.
> 
> Michal Schmidt replaces irq_set_affinity_hint() to use
> irq_update_affinity_hint() which behaves better with user-applied affinity
> settings.
> 
> Eric improves checks to the ice_vsi_rebuild() function, checking and
> reporting failures when the function is called during a reset.
> 
> Vitaly adds support for ethtool .set_phys_id, used for blinking the device
> LEDs to identify the physical port for which a device is connected to.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Aside from a couple of minor questions on 9/9, these all look reasonable.

For the set:
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
> Andy Shevchenko (1):
>        net: intel: Use *-y instead of *-objs in Makefile
> 
> Eric Joyner (1):
>        ice: Check all ice_vsi_rebuild() errors in function
> 
> Jacob Keller (1):
>        ice: add and use roundup_u64 instead of open coding equivalent
> 
> Michal Schmidt (1):
>        ice: use irq_update_affinity_hint()
> 
> Michal Swiatkowski (4):
>        ice: store representor ID in bridge port
>        ice: move devlink locking outside the port creation
>        ice: move VSI configuration outside repr setup
>        ice: update representor when VSI is ready
> 
> Vitaly Lifshits (1):
>        igc: add support for ethtool.set_phys_id
> 
>   drivers/net/ethernet/intel/e1000/Makefile          |  2 +-
>   drivers/net/ethernet/intel/e1000e/Makefile         |  7 +-
>   drivers/net/ethernet/intel/i40e/Makefile           |  2 +-
>   drivers/net/ethernet/intel/iavf/Makefile           |  5 +-
>   drivers/net/ethernet/intel/ice/devlink/devlink.c   |  2 -
>   .../net/ethernet/intel/ice/devlink/devlink_port.c  |  4 +-
>   drivers/net/ethernet/intel/ice/ice_eswitch.c       | 85 ++++++++++++++++------
>   drivers/net/ethernet/intel/ice/ice_eswitch.h       | 14 +++-
>   drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |  4 +-
>   drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |  1 +
>   drivers/net/ethernet/intel/ice/ice_lib.c           |  4 +-
>   drivers/net/ethernet/intel/ice/ice_main.c          | 17 ++++-
>   drivers/net/ethernet/intel/ice/ice_ptp.c           |  3 +-
>   drivers/net/ethernet/intel/ice/ice_repr.c          | 16 ++--
>   drivers/net/ethernet/intel/ice/ice_repr.h          |  1 +
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  2 +-
>   drivers/net/ethernet/intel/igb/Makefile            |  6 +-
>   drivers/net/ethernet/intel/igbvf/Makefile          |  6 +-
>   drivers/net/ethernet/intel/igc/Makefile            |  6 +-
>   drivers/net/ethernet/intel/igc/igc_defines.h       | 22 ++++++
>   drivers/net/ethernet/intel/igc/igc_ethtool.c       | 32 ++++++++
>   drivers/net/ethernet/intel/igc/igc_hw.h            |  2 +
>   drivers/net/ethernet/intel/igc/igc_leds.c          | 21 +-----
>   drivers/net/ethernet/intel/igc/igc_main.c          |  2 +
>   drivers/net/ethernet/intel/ixgbe/Makefile          |  8 +-
>   drivers/net/ethernet/intel/ixgbevf/Makefile        |  6 +-
>   drivers/net/ethernet/intel/libeth/Makefile         |  2 +-
>   drivers/net/ethernet/intel/libie/Makefile          |  2 +-
>   include/linux/math64.h                             | 28 +++++++
>   29 files changed, 214 insertions(+), 98 deletions(-)
> ---
> base-commit: 83042ce9b7c39b0e64094d86a70d62392ac21a06
> change-id: 20240603-next-2024-06-03-intel-next-batch-4537be19dc21
> 
> Best regards,
> --
> Jacob Keller <jacob.e.keller@intel.com>
> 
> 

