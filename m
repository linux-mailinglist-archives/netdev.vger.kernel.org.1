Return-Path: <netdev+bounces-241329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69939C82BB0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0BB24EB12C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAA25FA13;
	Mon, 24 Nov 2025 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lg9YVFeU"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F81F50F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024112; cv=fail; b=YIN4Mb4qnhuHllI53js0RIqLt0iPWskshMowwjIEdyk8BobZtEabZcoAbR+3GXsm0UD83HWWfp+mpI1ViVFhJSnTRF9ecLLaPuHFY1Q1zePxkAYGnejfeV3fWvNN4tzbJCNSAcULAoTCHPuDEu4JbcgOEXM30f0Ex4AoNUe7HEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024112; c=relaxed/simple;
	bh=x6mUddBkUm1zgFsaQeVeMSodv9GozFITjS7Gv3cGOR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNhfNsftAJf2VRAsEZeyNczmCzzFbZmK8o/KNr6fGELAWGN1NBLPLaFAAtUMonIhCQq4Clufo7AZ6+MjcPrjDcXw/2wz7WH9zF7f+mDczV1SZzIkfrUBTHA3DpMhWhrOwjgWyuKeXYZSY5kh52DiLsV8/f9bkf3qDh3E3lSbNT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lg9YVFeU; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMUKl1pgG0JJKXNPrJe6/b7xg3p1sv20j19ukQy4o0sSB9UEVb1bagDO4yvzlvVLXgF/U2KZEUGmSoyZq2reRbmM1douCSTpGE7NBFPKBghufoDmW7+jwGGxzite96b9Ge22nHM4Z5CgVQ/82GUTbt4lrNz1d7tABROadMlAfta0y4rv/n5n0t4hM7uGgtMCdcK7fiSzDk/iQM1SvTSp8H7wg7QM8on07iwjLMAEUJDaq9W4G7tZoMfJtAtfaO+N4pXMK5VfHHwihNwGRXN1DX7CrzcP+EsuqdLeMPKOdj8q0Y+nHZ5jkg1i5X/TBK8kWGEv2QGPdb/2Y5a0cDehiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fottO9wW1kL+zk0+IuYfVYlR5k/sQ6zfMKMP6BBWmU=;
 b=dA4L5q3jkW4qrsVSSmMumIZEoQfEZexRs8V6BO8ltoYoCC4RHqNvZl2deP3Za4L+H27WxIkswpuFbm15dfXO8uPgxgwljdhB7RXvaU9sCKX14pCDio0unUasKO5vkxxvB4RslFGxAEI4DItDoiaR1hWduXvyqO7fe8nbXIkURA7Ff70rtdpzYJCs19FbqAPYVCTu//KJKrLBPBG64bVPzt3d/C3qwHw5q1kirzuw7jqEKQKz+ewbExn/mXt8D1msLxsP54cWyPeZzoxjb42A4iQvbPnfmkFFQ9t9wF0koezXiWGDqh83qltI3f0oIAU/a3c0EgaDwMJMmZi24bVKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fottO9wW1kL+zk0+IuYfVYlR5k/sQ6zfMKMP6BBWmU=;
 b=lg9YVFeUyJ+BB5UvQ5mQ6SZBvQg8gJQykbORMIBIPfnVk3iYS69e0yeCSrZQvFVpbx4z0AZ4/Ngu/+N1REDzMFuxlxfm82NOn/E4qevuH5c2mgQnLvV1wKY/6FhzBXeq44SWyxWAa5Eq9YxZd3nxbwixnpEMC0yteGmZ1x8aAo4reDi1RqqRPXbTLBQrIUzasB89jh4xQ+ILAStwF4uAZAQvrgRKn2OqEvKHuKLxsN8428nRWfAzhommAN01uV3HU9DKtX/+lchHYSG6z+iaog/rRCAOnr+Fb13gXGkOM/BFN2AWmnpqM2xNRnEeZDoSrVtfKE9N+2WflDslmxv3rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:41:47 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 22:41:47 +0000
Message-ID: <73140271-6218-4201-96c4-7de563da965e@nvidia.com>
Date: Mon, 24 Nov 2025 16:41:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-10-danielj@nvidia.com>
 <20251124164600-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124164600-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b74af92-8f44-4ed5-5144-08de2baaa671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9obUdUNVN4NDVWSS9VZzIrOHh6SEVPZDRkZUdBTXdPQlpDaTc4cmZRSFVP?=
 =?utf-8?B?NW45M0xNaURVQnpscDNxMnljeVRIZ0tjRDE0SmxONnJJSDNGQThhajhtOENP?=
 =?utf-8?B?VnhoUnNYdEI0dlVYNUlxOWp1ZlFPenhMSG0wY0R4TmhjV2pCZTJKM1RzdGV3?=
 =?utf-8?B?OUt2UmNHZ3hmb2NjbnJPUU9RRWo2N0FnRXRpZkc3cnlBSkVsdG40WkZZcmhy?=
 =?utf-8?B?dXRPbzlibktneWREWnlYSEdyZ2duU0hlb2dmSktlUFlPNDh0V3JXaUVkWkZl?=
 =?utf-8?B?RS8vTUFhZHNaTXNXbWhCYjdpeTlZcGFhWW1BSmVEVlQ1UENYYkpucHFhMm44?=
 =?utf-8?B?TjlyemtYNENCa3luRTdTR0lQRHRHQndSek1VMS9hZ0puSnRXTUpOeHBKKytC?=
 =?utf-8?B?cEFjQTJrckl0SU5KdTJ4NndJQ2RnbGdSWE14Z0lTTnI5N0FNUlo1TWpYQ2dI?=
 =?utf-8?B?c2FZUkVoMHFxN3dLeko4dXVRSGYxaDNaaHFBM3ZTY3JydjBjQVJ2T2twN1hC?=
 =?utf-8?B?aElUclg0TitBMi9qUE9qa3JDK3BhOGVZUG9TNFkyZDV1R1dlN2Q4SWxxSVo0?=
 =?utf-8?B?MWphSUF0U1BWY2ROc1hraVBQRjRoZlZHd0tsdktoVmdqWDI2L3UvWXhKaXJq?=
 =?utf-8?B?TzhEemF1RUpVMk42R213ZGU2a1llVEVweld5MDZhRXB3NVRLSnBJYldIaXFp?=
 =?utf-8?B?TzhUQUNzaFltM1BxdVpLUnpSa2Jtam9KSkEwSmFiTmdLZER3eWt3Ym5TVHN5?=
 =?utf-8?B?K2dEbllGUjV4ZE9oNVNoL2pXNmo4VE9TNjFualEyaUtXWThOR3VSaUhiRkFr?=
 =?utf-8?B?eDZkRFA3VHVZcE5CVkFTSGdWVTdpaVBvaUZSMjh1SHpnVCtOMnJVbU02Kyt5?=
 =?utf-8?B?OFpjN2xOZTBMb0k4cTFOa3A3NHkxYXdmZmJsZzFqSGlReWhYQVcyZVFPaVgv?=
 =?utf-8?B?Y082Z0tjK0JJM3d3V1VybTJ1NG5ZT29wTlVBVlQzN3FSZTZIaW1FRlRCNWhK?=
 =?utf-8?B?dndCcUN1Q3lTY1VRVUt1S2c3Vm4yUU5Ed0o4cnA2NGRMWjlMOEFFMzhIWjBa?=
 =?utf-8?B?S3c4QjYwdUViWm9JcHB3bHRha3FhSFdEQUptYlNLdUgwZHVuVUhaL0tQYmNt?=
 =?utf-8?B?ekRKaWtnUU1WdW94TVNtZDdYT2tTYWN2ZVhtYjE4VUpSQlZNd1l2M3B6bmJW?=
 =?utf-8?B?M1dCMHRPcFhvUE1zRnVSSE1MNUY0SUxnQnhJbVJvSFdHd2RwaEVKaHR0NlNp?=
 =?utf-8?B?aEI0ZWxGWmJQem56Qkp2eXlnMFI3MkphYzhXK2h4NkJOcU1YSis4cndDVTQy?=
 =?utf-8?B?ZHRyWXA3NXhZZlZZRjFCUWM3bzVUemtCd2NHU2ZtUTMydTZwTmxvWVR2bHNX?=
 =?utf-8?B?MlQzOXkrUGNNd3RockpsSkZDa012cjczbGh2N2FHY2FNZTdrTmdHaU1VYkdn?=
 =?utf-8?B?N1doR2hXR2QxZ0RhWE1Gejd4L0lMQ3o3NnFjTW1iSGFEQ3Jkb0JwamRHNlRQ?=
 =?utf-8?B?NnBjcmhnWWV5RDhoMk9zNjNVWC9hNEZwdVFDYjRPdEFUaUVoQ2o0Rmh5QWpw?=
 =?utf-8?B?V2hwUVgvb09hVkpmTjgvaVNESFhYVkNRaFR3YlFYb01aSWhveHp5eGo5ejlN?=
 =?utf-8?B?S2g0d1puR0JWTFlVTE1YMnRxTS82dHhtS1dHbzEweklwMWxXWmlwTlBSWWls?=
 =?utf-8?B?MDJEL0lTQWF4ZDR2eWdYWUsyS1BFSHgwUG9DbEV3SkVUS3ZIU1lEa3hkVXdP?=
 =?utf-8?B?aVpvMFZnZkxXcXdYWmY0OHJQak1NdVI4aWFmSjJxdWZiYmF1d1pWSUFOeDRt?=
 =?utf-8?B?ZHFsL2lUMnUyV3ZiaDY2OGZKWDIvTnl1YmFtNXhURTNCSldRUUdOOW5McGU0?=
 =?utf-8?B?alJ2dmNpa1Ftb21zOHR4VTA1ak1CVURmWU1nN3FodU1YdHIvRFJwT3JHVUp6?=
 =?utf-8?Q?WUVzFYV+6jPeXIr6w4jstZiU/ogwDK9f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGxkbjhFcFozZ2pFNXFBZEFwQ3did0dvYitpa1laeGxBNitnQ1NXT0toZjFL?=
 =?utf-8?B?L1gwaDhMNmFROEkvYUxwS1p5ajgrVEdTSndqdUJzVnoyN3Uydyt4Wm5OOFk1?=
 =?utf-8?B?VDFkc1JSVFpGckxFN3M4SGlaRFJwOVhwQVhJb2ZoSDdVbTM1Q0JGVW1DM2J4?=
 =?utf-8?B?YVYvbllYU0x2cS9XamR3d24wSmpOU25SYUxTRlhKMDAzVlozbWlwZ1dPZmQr?=
 =?utf-8?B?WXczUUhqWWtQWi9nRkNTSXRuOWxveHpmV296UWhEdm50bGNXdlFsWE5SL292?=
 =?utf-8?B?Z1ZSeFhYTUxHVTF1cU9JZG9UR2JXUC9xdWlBaDJmY1o1UXM3L0xTdkRwdFBa?=
 =?utf-8?B?ZnRKS0sxTXUyMUsrWWFMbk9reGlSdmx4bC9QTk5FUXg0QkpwZktLbUwyUm5I?=
 =?utf-8?B?M25Jc2hMUEV6NVMvZEcrWGJqUDZ3NW9ab05SdHluVmpWLzJ1WldQL2NBM1BN?=
 =?utf-8?B?em5mdkVhcTJHVzgySmVlSTdsb2xOaTNmbE9QSFZtMW5WVTY4L3gyeDcwaUxx?=
 =?utf-8?B?a1RuSkswckdHaGJRd2ZoRkZDeDlZV1NmcGdQQzczVHVRdDRaZzJpcWttUkhD?=
 =?utf-8?B?WHBYcEFQclUvcW1mNWtMK0M3b2QrdVFrODFzc1JOWWRFUjlxMkN0MnhmbUUx?=
 =?utf-8?B?SEI3THZkN1FybWNtR21kV2FCUHZIWEk0ejJOZ1RKc241Z0dUTXNycTBlOTFZ?=
 =?utf-8?B?RGJYcDBXcEcxSi9HQ1JKZHJ6cUhTb3pKTHB3UzRrNWV6VTN0TWhqVHFSVGJV?=
 =?utf-8?B?TklLNGtmNWVmR2laeVA3Z0JTMFI1R2RjSUpOTHhyN21JMU1hc1lrWktBNEVj?=
 =?utf-8?B?amlrYnFDek01RnpIQmcxV2Y2ZFBqV1B6R3h0ODlwblp5U3BOSWpuMkR6RkMw?=
 =?utf-8?B?enZwVlNIWXl4bXBvM2E2MnlsYnR2TkN5blBudEpOZkhCN0MyTSt2aFBwSnVY?=
 =?utf-8?B?Mm9GY251bFRWMlBZREpUQ05GU2dNK054WVdhb1MvcTBweFo3YVdYMERoeUV3?=
 =?utf-8?B?dTN5amswYVlRand4K25ZdTU3MnNLamZqa25BVG1DRHBTK1NlOEI0eGI0ZjBh?=
 =?utf-8?B?cWsxV2hYQ09VbE13d3l5cmdGcHBUNXF5eTFmNHZUajBFTjBiYVhtajJ0UTdh?=
 =?utf-8?B?bGlxYU9QU3pITkRxSnpveUZQSHhyQzVUNHE1SDBXa3hvS0orLytZMXF6a1Zr?=
 =?utf-8?B?MGJTRHhjQVJVWkFTMklkR05oMGg5dWdMM1ZmU0lJQXRSak16ZHBCTnA1TVgv?=
 =?utf-8?B?ZEFFTE13TUZvSnplZUlmWVlmVml3SzJJb2tYTnFWR2VrNm56YldoWUJxVnZR?=
 =?utf-8?B?Y01SRlhGY2I5YWhlYWtEMjY2UzV0eXpWZnJ4WlpaQThkQUY1RVl3aDJ2dXJU?=
 =?utf-8?B?R3d2ZVJIQ3B5Mm9sTGUvWFhzbkI2YjBDdjFwMTNENFFZV3d3YUV6bGpSeHFm?=
 =?utf-8?B?cEdnUjR2a2pWWFFYMTFkQUdrbEZoOXBCTEdnUzZVdXVHS1ZRNXBhUk9LNTNU?=
 =?utf-8?B?ak56enZpZ3dMVlAwTDZSOVd6dmpEMHVFSmg4ekZJZVVjZWJhZUYzaE5OZHFR?=
 =?utf-8?B?WGNLL3VvdnpHZWlIaER5Z2pvbTNrL1kvcXg1Ry85T3hDZ0VqV01kQkVsdjE4?=
 =?utf-8?B?RjdYMEFUd3JFS21QRzA3REhoZnBMMWVPUVQ1N3hiOXVTY0dQYjRGNWcwNzJI?=
 =?utf-8?B?NXBrN0pVOE00Y1VSb050RCtZWCtVUkVobmo0ekd2aHV6SGF6ZzgyN21YdGJO?=
 =?utf-8?B?Vk41eFpEU2ptcy9pR216cGlUMnZXRTNiKytmTXFoTnhyUDV1blI0VUxEcElE?=
 =?utf-8?B?T0hHTjFaWGIvQ1U0WmJ6dlErSHBMc1JudUZHK083QkE5Q2hyNjZTUGlxMDlr?=
 =?utf-8?B?YUQzb0pqNHdGOExRRWVPTzErODVYOTJGdXZ0MzViL2lPQ2tBU3FIazE1emZW?=
 =?utf-8?B?TkRzU0JReEo4bjJYWHVlRE4zZU15TGExc0FqaWJxZGlmdWlJNjQ4QkJLYkE2?=
 =?utf-8?B?NW9tQkFQYW8ybVVMWThCbkhRejZpQ2pMM3lkcGVDemg2eDMzRkJ0aGNVeEFj?=
 =?utf-8?B?U0o3M0dVcEJqYW03c09aM3AzbEpqWnJOS3FwVmRLQ3h4LzlSZHZFZkZndDI4?=
 =?utf-8?Q?C1nkIsheCB2go0MsEwBIEAZAS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b74af92-8f44-4ed5-5144-08de2baaa671
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:41:47.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdJMh/WFPEncCwVNdYQFbx0scx0m5UNP3hYBQ0aH2eWkiVg89xWav+OKWK/4jsxPrab5LgE3jgtKF2emFi3NGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On 11/24/25 3:51 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:20PM -0600, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
>> Added rule with ID 1
>>
>> The example rule will drop packets with the source IP specified.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed bug in protocol check of parse_ip4
>>     - (u8 *) to (void *) casting.
>>     - Alignment issues.
>>
>> v12
>>     - refactor calculate_flow_sizes to remove goto. MST
>>     - refactor build_and_insert to remove goto validate. MST
>>     - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
>>     - Check saddr/daddr mask before copying in parse_ip4. MST
>>     - Remove tos check in setup_ip_key_mask.
> 
> So if user attempts to set a filter by tos now, what blocks it?
> because parse_ip4 seems to ignore it ...
> 
>>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>>     - changed return of setup_ip_key_mask to -EINVAL.
>>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
>> ---
>> ---
>>  drivers/net/virtio_net.c | 119 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 113 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 5e49cd78904f..b0b9972fe624 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5894,6 +5894,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>>  	return true;
>>  }
>>  
>> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct iphdr *cap, *mask;
>> +
>> +	cap = (struct iphdr *)&sel_cap->mask;
>> +	mask = (struct iphdr *)&sel->mask;
>> +
>> +	if (mask->saddr &&
>> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
>> +			       sizeof(__be32), partial_mask))
>> +		return false;
>> +
>> +	if (mask->daddr &&
>> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
>> +			       sizeof(__be32), partial_mask))
>> +		return false;
>> +
>> +	if (mask->protocol &&
>> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
>> +			       sizeof(u8), partial_mask))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static bool validate_mask(const struct virtnet_ff *ff,
>>  			  const struct virtio_net_ff_selector *sel)
>>  {
>> @@ -5905,11 +5933,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
>>  	switch (sel->type) {
>>  	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>>  		return validate_eth_mask(ff, sel, sel_cap);
>> +
>> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>> +		return validate_ip4_mask(ff, sel, sel_cap);
>>  	}
>>  
>>  	return false;
>>  }
>>  
>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>> +		      const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
>> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
>> +
>> +	if (mask->saddr) {
>> +		mask->saddr = l3_mask->ip4src;
>> +		key->saddr = l3_val->ip4src;
>> +	}
> 
> So if mast->saddr is already set you over-write it?
> 
> But what sets it? Don't you really mean l3_mask->ip4src maybe?

Yes your right. My abbreviated test was only checking filtering by port
number on ipv4. Will fix that as well.

> 
> 
> 
>> +
>> +	if (mask->daddr) {
>> +		mask->daddr = l3_mask->ip4dst;
>> +		key->daddr = l3_val->ip4dst;
>> +	}
>> +}
> 
> 
> Same question.
> 
> 
> 


