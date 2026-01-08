Return-Path: <netdev+bounces-248053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CCD04081
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E7C30339B9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAEF474233;
	Thu,  8 Jan 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pF5ZM3jF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB7474230
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872503; cv=fail; b=QtThLINrFC/QdjiQF+KN32DaNUasgvNf4jULV6g7otPlVFPJBVRZcPnyOnY2H7N1LxRKbSAWaS06MKbzJgWwV4NkQc20rWZ+9XOXbaGpIzLn2VdUf6IqAebnN/6/0WBMe8fKCmobKqK2oNqXWJaHuQ51KN0Cj+OF3WAoj9IEE+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872503; c=relaxed/simple;
	bh=AmqQqGjJ4HXPjXjS0IhvY1LORmShwmmrGscVaDFuYVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orGsq24HL0a1CZCpGfHm6WIi+nmvDgwna0676ZihIsjoT9+ZjsuoK/dzb34C/WntqTzeznxmkAp5LUowyGsdIM+e9L53K9oSzha2CyjxbzpsIoIgtfgSeKba7CidcwP9TsXRWnsfnsfocS8LwTDh4XU8f9h75oQ75RaL/V2ELP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pF5ZM3jF; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt8ZK3HoTI5D+iA8emxHM4u+v+vWnSoIaNUlDgZDKJJe+3vGkiPfozmtpMSYp6NKrnhflm9V3QTz3p/LzVBPcHGVF5KtE6CcV5aXcE2LxXNOafhMdREVrVk+uvX8ZEpVpbkZXlZEWh67CbBoi9RuhUY8pYEfXMEJtobXmTJc80sXD/voNe/tnr1fe574OKiwNA2dfmolSvkp/gIRBE1snfIWyxP9T7MKmFSSHG+APipYqrHWCoSNFNzKqHBxvrgMEiUnyE7JSMRMQAR4ZDChOBwb/Z29LcDIWK8Ec/cApLTeG5ACU8gd7dic2CbLwbZpLOqG2gIpVQXN8Fkpy4yybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAyGeoydneh3UYI3MMjxalpPl2D+6jI4rw0QLfTqCVE=;
 b=VAo4Yx99QfW/EaO4DgHRSe8deSRYfTb2jR6f5wVIMy37FU/adQOX2+4qUNGcRT9xrUtAiJwv91oQuQYVEHnsqDkgV5N/eQltkup0SVSk6EstiDHefLKFv/3PQIDOYB7bnXoEEYhI44PP7o2bOswcABHjxz/Kr581kq8MD0f1SqmbVHYLupuEzYSsfLHkbcYKnq+IU/gcMSSCZWdaD21LSV+11sV8N2gSyR6vU5Vq4MNMW5SjZbb1T7RejPL97LaoAlhP2oVzaT484uXay62gPXsKtI21RsMg7i1CjB6pyoIiGBwn4LrXJafveRbCByY/tedojLQh5kDqlpJoZ5oABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAyGeoydneh3UYI3MMjxalpPl2D+6jI4rw0QLfTqCVE=;
 b=pF5ZM3jFzoB+xIyxEWQ1IpKqAjaDFsDrhKoKrxl/lAjFNhMXml/H7LuHW+xytJaDZfQWLJd9xHyX+Un69XFv/4gj9g6EqvDdkncrNkLuLRkMHvvSylvJgcQoJFDtuoEH8EKr3bra1TV4Of3zrYQC+sNJJTHo+0RmhB2uLBlShmyALgAxZl9ozh4pUbeS8rcJ8SKtUi96ncJ5GaBAEMdmdqU3SdkI4qFCILTxD4h42UugPhG7szwdJpvLz/tTt64HYG1ToWWD9upqZqdNlYlBefBJR8SVR5y0PPUIG25faN0D7/D4Q/fbT9ewakxoq1QrXMUHBT4wtu8NAYakhz1aWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 11:41:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:41:33 +0000
Date: Thu, 8 Jan 2026 13:41:21 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH v3 net] net: bridge: annotate data-races around
 fdb->{updated,used}
Message-ID: <20260108114121.GA615553@shredder>
References: <20260108093806.834459-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108093806.834459-1-edumazet@google.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1c342c-4f3f-4226-6b9e-08de4eaadf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRCGZZQs01eKFwXT4w56J5T0d7ZznEd4iHBJhHrQW4DH9b4ezYcX2UdhPr+a?=
 =?us-ascii?Q?2SDdcIrdauXC8MQpKodWdR0TPZhlFnfLUBuF6i2+/A5ob64LJOXprop+keuM?=
 =?us-ascii?Q?Zdd9l0uMsIlqiXXXj/IQbpEaPrSfEgsMymKRjKihwtDUNlc2hCuHN7H5pTQo?=
 =?us-ascii?Q?HYOUQsWnX/QpKQ1ZncxhPjzcMsP3hdYqbSR6CtWA2/kVSi+IO1a+3N2tDVW7?=
 =?us-ascii?Q?Q+++6hkBiBDwU0yD54W4oHHxxSXVi1CK7artU/PYfiBFOSF9Japgj5VrsVY/?=
 =?us-ascii?Q?xsfwbQwToMUCbl1d+ZrMLvwYON5cCCHvGn9GeGN/cjJqkDHTEingjUpJlB0A?=
 =?us-ascii?Q?DLpLTll14+JqeF/6Ur7R841aVZzJ7Hn9HeQCiXxQhXfJbee2NEDiu/h/hW4x?=
 =?us-ascii?Q?AzNu5IiOtECPRzaxCux5IvIkvBfAJKwwLhfYdxOx/KTdmqzxJN44706viDIB?=
 =?us-ascii?Q?1SwyhdZp08F6S65Hieo8zev0QF8cvZ765SczwtMkTH/9I9jRxa8cqEQbspkr?=
 =?us-ascii?Q?IIUJsKx7Fp5cPohqZFiKy2Es2htiT7TX5TE062bFkE3xNcXO+BCN859vL4gc?=
 =?us-ascii?Q?dmj8D9nFJ7evbUlgepC6twuzuYuMcR5UobLSsn1OgSh6z8+QME4Br97VM8XV?=
 =?us-ascii?Q?qv+AfDIHKjHdpQHkZRfiRamO58+upJ4oxIxdg3aN3HYGw29vPObetXAGNIBJ?=
 =?us-ascii?Q?VrUs3kN+hh42yDeMcFrD6phDvOZNUBwxHDqGbvphRTIiUVfqVKTb2qyB/fHI?=
 =?us-ascii?Q?RCcXJ2urRyOjfLV0GzoyJudtzaiGqWXcn/2lGChzfr81ViyUaZXZGGwv3FoG?=
 =?us-ascii?Q?oTbnjSSR3G8qddX6LucLAfyKj7PD/dekrBSI95UjlQKIEFQw+iifxplPZXOs?=
 =?us-ascii?Q?6LGz1dYr4q4nq580eSKIco0v9OC/k443/7mYUFwTTsbEoubNCe7ukUVNVXpL?=
 =?us-ascii?Q?LHzA8niEWTAkUePkgFZy8HfChdoAveeI25LnDL+b09DAIdcyPX3+4M/d/g5O?=
 =?us-ascii?Q?E0LgeuV8azHo2kOUrBEmgQ8k18u3+DHE8GTICwlmnz3gojJvAj1dGwyx7wXO?=
 =?us-ascii?Q?HEqbAqnHNn5MalmEEAqxDVvhGXW8hTCeLZPGdvVdSalH4CMp5PphTOtBcz5M?=
 =?us-ascii?Q?H00F+F7Z6D+LGxPqvxSldvJz57idWBGUDbftPVEXmuEZI2kd3LAHNLG1rWj3?=
 =?us-ascii?Q?D/dTIvN3BVTu2i761Lhizef3/XSsBG9alNgQ06ltllbAqY49rmgjckDSTj0a?=
 =?us-ascii?Q?Gw+eGsvlNlCjoI9kTr/uVLAalFhGnGkwQaC82chAlOVyLBOEJi/IBZJq44Fh?=
 =?us-ascii?Q?0s4wxN/YqcXzSigJoyPs85qHzxFXyzGEDvV6D6mGeQ4vpi2nDq5dByVOV+kh?=
 =?us-ascii?Q?0ONcl3XoagUYfthQ1jvCFw8QJc4WX1tp4t0ERpVaWYztY8pDGErxnDhod78y?=
 =?us-ascii?Q?t/AdQ+hxraHriMUUCbWwReEty2Yj0isHaKlne4MDGBa5osVD16vuPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MHIOTvMXP3rwjVD0qVLypuD8JQfK/eV7kUo8Eaxe05Nr4zp3f9mhUvwPbZ3?=
 =?us-ascii?Q?uB/ZuwchBuXvOxMTeCwwH4/2seMslAT2MPLQZe2DvzSv/3OTP7NH7B4PvJh3?=
 =?us-ascii?Q?A8ulhQnA4cyJL6fORwL9K7gXtMtTX0k1fePILHCBOfJdosLyv+qP+BSvwd3x?=
 =?us-ascii?Q?e4VZJ4mmPrxum6rmRg2vgL4sJZFz5H1QSLyua2cvTr+X0jokx3Den6y3tGXJ?=
 =?us-ascii?Q?gVLrkgrZzpfedoQxic6r2qKCFlKiGyFkotD02CjXJOx56Dew6qDc4C3xR24T?=
 =?us-ascii?Q?WrXSlQUJYQtAM+G9zZj/wryrw4pZje10OXpJz5Y++YDr3C1qmCQWU/R0ZemE?=
 =?us-ascii?Q?DC0rtb8ArXYqNpqOMVYGSILu1mm1qN3f1OY2KCXiqUig701LwZfJ4ukHO7hr?=
 =?us-ascii?Q?biPgOpGzRhwySEnqXvY65tqpY9+mEtekuSTpzYUe5X0q/9KAnH1EZKVB+rZw?=
 =?us-ascii?Q?5xQI6llbzlJeOnY5MJI+f9WNjhbMoE4UvcOtljLNgtdu5kinVp7LOSLbgOIg?=
 =?us-ascii?Q?dqcKG6D9NpzI24m6JCa3D/wWXsNjI0nveXcPOiIK0UfIDDyHhmM+YmPxjt/G?=
 =?us-ascii?Q?nC5UH6HeNurV3ZIK8BvffoGwS0rGFuqYu/44/ovgzXWSXfC5ZKcbEGsdalQg?=
 =?us-ascii?Q?KjZqlhl6sedsQ8qWoohXwLCnxKPyRQJSQI6i9nSFGvgYWjQuGjGZv1IYpCv6?=
 =?us-ascii?Q?wq1NsvAyxAOaw4l/N5LgmCrBI3zfjsArvqtD0FXRRVNKwgxRj6hJNwUkEGQ2?=
 =?us-ascii?Q?siV3qt9i8ILrLsI+E03HASo0LZ3eG9VSdEnrQOkDEbFSizEpKCmlDRwBPXJu?=
 =?us-ascii?Q?2c+0ZYA1hyY4k9JuDPYIMQxdLqjhWRxf95lVyAySCqnoJH+GGr5Yyxipayvg?=
 =?us-ascii?Q?GkwJ2VuPRPbrHnaSHe8tSa59E7tHN88vSWIA+yXqF2pMKoJVzjAaChCKJzg/?=
 =?us-ascii?Q?/Af3Mia3wHjw3uwejx0t1TnJS6EVFCVJ7uI1df/IIBNH1mVO41YxdcRifbJc?=
 =?us-ascii?Q?NHjS+xbQV85ULU6aeDGK5F/e9iRcnjcw/pwHvwgZZt926C8Up1k7o2eSYAi8?=
 =?us-ascii?Q?4Rfd5FNRx3V3Kt1n5m8h3PEAt2sqnIrjTGNffu1jttRqFpO9v5+hte/fDJmd?=
 =?us-ascii?Q?t2Df1EqErFfoyu0I0SvcstBcfr6GJlfsG/pJgflSK/L2IkB4sq2CLMKRrOak?=
 =?us-ascii?Q?krqGKdbNtwnFdWxFqhXxiGj9kq4iproaRkUijbIWglDUxlnajk5Ju9sGF6id?=
 =?us-ascii?Q?RAyrO/AMSywtJ/izufSUWWb6erKXHfMMOWq/MS10G8fNy2RmH36YTESIh8iK?=
 =?us-ascii?Q?kq8GJj3nHseVKrxshoOxb2WpOZb2tycDiUcVteja34dNi9eVWgYrgkU7gsRg?=
 =?us-ascii?Q?+oFARTxLA51bBDAPV0Rs84Kssutf23qfSuQWW2d0TRHueXZZY2JfJ25FmzQ1?=
 =?us-ascii?Q?BFrBGF6X3Fo/9MCPXHbgD23vgwpBlBlht78AJclR7pChO0sO67D7g2wViZSS?=
 =?us-ascii?Q?Mfr7zCpe+4aRNE/xAbIaXj0pNXWv+UYU2FmOiHdCRL5lKa64YRpznKswDXFL?=
 =?us-ascii?Q?Do9Alqu/A9w8uWWLEOsytPg9s1Hr40NhG5icLrNxKkpSIWsxU8fiVPt3ma1x?=
 =?us-ascii?Q?KWZUp9WgXSeCbZTARagK5PNNng6m1ulvgfbprqHHo6l+gpD4T+qn6GsOU6j4?=
 =?us-ascii?Q?zecd2KvFgB03HREX+6WD5Ke8wlCSZCe7dMOBU+9tVPJXFnYk5xQUCaMJaTrW?=
 =?us-ascii?Q?aocXVZZyAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c342c-4f3f-4226-6b9e-08de4eaadf63
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:41:33.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPswu0KEfJ/O9Y6seGWWVWUcm5XhKXphDK3zF7kDWdu+DB8lIWnSZsfX3KoafQQJdHi6eNpnNzIlu6GxYq4ApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

On Thu, Jan 08, 2026 at 09:38:06AM +0000, Eric Dumazet wrote:
> fdb->updated and fdb->used are read and written locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
> Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/695e3d74.050a0220.1c677c.035f.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

