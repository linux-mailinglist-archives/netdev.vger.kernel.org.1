Return-Path: <netdev+bounces-140377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB049B6415
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF901C207BF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EFD1EB9F5;
	Wed, 30 Oct 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lMss8O3/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECA1E32B7;
	Wed, 30 Oct 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294936; cv=fail; b=XkGcnILk8I0yDZw/RZ45rSc9SLJenl1pSwRQGTWJuAHzP/TwpN3bSN/zPX4Fuw0aEZa7QiVTAyyeUmrvXlfvekfcsgSj502uIVlCTFus8dTpt6vuRBLX+yLj9yWz0zn6lbRfBZ8wcbBRvY6LZ7PyzqiQrDzXNTqt02dls+qHGpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294936; c=relaxed/simple;
	bh=XJwJA0TlmMouCKbqdUPUsUAqw0IADgal7AxSRrlZPLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sI2ejNt1Wb0dIKlSgTCxM6chSoOL+rqFqOKCIvrE14sW8EM9Jo7Sbp3RxyTHiF5kRRYJ20+xx58wVNQyA78YrYRUX5d/lmZXyejssgXutJcT24bMnuSv8ihzdz8MgrsE/Pk7Z3eX8uNle9a5JgDt/52avADvxqucuBoJUGogIJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lMss8O3/; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZpRBR8qn5wRJl+MePt4HFApbK7yo3he09pyQCg5YjBfZmLx+J9//DPJWLgqg3ZzTbwZrudr6c1mNHYzGXW62ELeFAM7HFrYviP2lnHSfm2DhopxOBUN4MKCFRCjsgFFzuHt+zadjBRwoX15457t1wYyQkhxHpzGGR7eh6rP3Q5GWHFDvnGNix0AniQnvvmJFDvv3xSjxJRVzUTWhIqPcM8Sh1fHrKb4bDW223iVUT29hF4Rz0JqQ2/kn8igWDqevkTBd78nV/0c4lT1FvAn5h/JqvtPtEhmGMY0or7UWd0ggLF3FP9ucoUDvTTlni6cjSa9DMNJHsRIBXAN7uj1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gh74wqIWIW+XJHGSyxq+/VDAiQi7bYIMSmIBb/ChLA=;
 b=IrvGgGp2ZnDtxo5ieyX6RRu9M9CZ7My/JNu/GbDZIVSJDtKXzmjxRZwYgq1d8khUdRpYr0c4gOECYja25ACMxgeHbZbTCf/1M3WsSbLVhs2dJQ11l41HsCy1S2DeFmqItvvWbiBSxvkb30fF/pOtkBBWlzs6GipY2Dl1aotaTh1uhZvDDWMWke4KyG5IefsYODLpQAS+uD+1tJH4kCfezdobwGnqLeAY1zoA0JxnW+2eYqr8GKrIeiYIXEmrjLCYot2Y6VTVT1dfyFNKgi4+Z0DcVmq3ZeITvKPMmzItiktaBTr/gQJM4LeBrpaqYFXdazQH+vgHKcHgGPPFAEjccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gh74wqIWIW+XJHGSyxq+/VDAiQi7bYIMSmIBb/ChLA=;
 b=lMss8O3//brNN8DnRRT0fSlBbIShvwMkIAhPpnmGpsvwptZpZi3kAm4sJ7cdGIBi1eI9pn6GtcuqrGZwx4R5Qdfpz2aiqc6wcW+IJWtvinNUaHRN/Dt55mDtvTvUetqIjpVaiRpkvWHCjqRopUfg2ENWLPYoUjq8CE4cNvDsZUBeFit31u1/NgDTGGSkZd7mx3Z4YFpb9+4hEOQaymQEDdovYeoW6I64UVp4vx2CW7Lliul6vcMWjYuHlj1u22Z+NizNKMMifsi23C8JFLc7gb0Jzz0J1KzaDFDP9Siw4TiZVt3CVQngjfYqsMUu2NbF53fS51x61udS9i8jE9XPig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 13:28:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 13:28:50 +0000
Date: Wed, 30 Oct 2024 15:28:38 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mellanox: use ethtool string helpers
Message-ID: <ZyI0htf7Q9ocD6Oc@shredder.mtl.com>
References: <20241029235422.101202-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029235422.101202-1-rosenp@gmail.com>
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: b5245b75-ea67-4d38-d2cd-08dcf8e6ca86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMgwr5r7iT2WMYSsXGviRw5LjIDGCCHkXemZX7s/HdgCvJluhDmfhb2dAQ28?=
 =?us-ascii?Q?MUUck4Hp2iVEnPHoPyyn3n/E3oJP3+eLp2/yu/IK8Qh2F1Yun+IbY9+iEb8G?=
 =?us-ascii?Q?MYBijoaHVWBhfkF3sq+zrx4HM/HphJpAPj0ZOluG8bUJXieEty7ofWBtDjHU?=
 =?us-ascii?Q?6f8r/te6OZdQW430Gbc3c0Uy7nFYeyTvm9hLnUCiummwocecD731eE/FtMqa?=
 =?us-ascii?Q?qyapo/neKH6n3wznY3Rm42OA2LesKsSUS7rCEYAE3cPdfEQJ4x3XWvahESGd?=
 =?us-ascii?Q?J062jsK9Ers1Kb2Gi9c+mhybcY/RMXEaB+AhMnOsxzvCLhqsJveimgLCarM+?=
 =?us-ascii?Q?sShAKrcIPc1blyTL34gEab4afLLXJVA9sksvJM2AvZp8VB/Ythv+Nw2RFxaC?=
 =?us-ascii?Q?v6C3HVg5BK9UaMsT0f/3CeqwRnevqDn6BMvvoJYwwsguaUS6G5bLb5TM1l3T?=
 =?us-ascii?Q?expLwnUIK5ZQB88N+Tt5mv5Sr75FOfPDiwOTuVlaIty2JTS+GAUcuxMwf9Tb?=
 =?us-ascii?Q?RCfZ1swIRuK4aPSBp2TQ+OpR0cDW5cq+8NQA3R+7qwnwlc4rjZV+5QFpWSMw?=
 =?us-ascii?Q?MzTz4282N14Uz/CdmHpMZIMEMD7uYfSR3nKK5O0R/VQ5tDKbERPv4B9SyqBZ?=
 =?us-ascii?Q?e2zSG1jUunxCHrzTRDYXVH+jPgmhgwLWLfpGEhUCPqERUVO1JJXnpfyDW2rV?=
 =?us-ascii?Q?Dt1MqQnMWoQpggRn1ZxsT4AzdaK8mFOJgi0DKIg1tTE/vZuTR2aotem76ZiL?=
 =?us-ascii?Q?TsgI0tWxKu/z+Ly1SUFYdQvoO7U/kNyd+YVRjiXD8XqfXGtMIu2tgELZ3tzE?=
 =?us-ascii?Q?0L8CXui9vvirL+ltqwJcN2p2RLs8Q6y91cyvoJGiTS5WL9Be2qPD84EjUPku?=
 =?us-ascii?Q?oFywujq5lKN1XTPvvpnk3ELZaqoWpm+l6UDiTdNCZGbflsjVd2SppHPEXK5k?=
 =?us-ascii?Q?ImZ/XMAwjedxhbEt5ZjhFDOLqt8JdnqFfEVFdCdWq1vuwL0jBLlhlOCSh9Sy?=
 =?us-ascii?Q?a5/PUNAlR3uO8JVzeiS5be+78/c+ygD5roZPYwJ0WRRA+rO3YE1AH0TdDnTK?=
 =?us-ascii?Q?99BWs5RPfHCJnQA0hSHru6g9eR8/FE3EiSE5ToYsFXBib8HnbnQThRF8N36/?=
 =?us-ascii?Q?5z9ED8fzcvz1MfwNEZiIxNcFUcoENUtO3oIbhGV6eeo54Xz3W3fwjaSVpwEj?=
 =?us-ascii?Q?DbZcJ+wt64M1QKTleBjK+PpPqsYa/w93iaZcghjKVEn/OylX6fCP3jhVXqIA?=
 =?us-ascii?Q?Cd1b1dOuOat+80ohrEXj2fmmpNcHTl8ENPu2JeoSwz+/VMLPOaA9SLtnwI07?=
 =?us-ascii?Q?o4ViIdhbHYa4As/7M4Gkn93B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33+8f6viOQ3QJNjxoO7F9TLpaYDBhYhMJbZBPoOzILDiIYYG9RosEuJPZDSY?=
 =?us-ascii?Q?ZDUkKi/Jm8TYFKpa3s9PotJ4lx+Ixncpxvreo+ljJt91pJQK4re/dfUFp9dD?=
 =?us-ascii?Q?7RYQt3AHYcjUbeg0IF0h77w//QV4/szybwjaB8Aqoz6ww0IiU5J06E220TFx?=
 =?us-ascii?Q?ZZ6u/oTqApacenT54+81EFNb4avrCou9fXwYxL/wranM8IG8tuS1UPXACuMy?=
 =?us-ascii?Q?/uSsi/4HPk5IA1w9pe0xE+tijGmPlPPjekHyfhToodWBv6LzyZMMdAiiw1HE?=
 =?us-ascii?Q?PhzswvDnL/9VehleXuWnGW9hmhFnIkewoEG648fxWnlJD89hjY4RDOu9c89y?=
 =?us-ascii?Q?mY5znrmN2q4r2L9vP/YnVvXrv7GQHLeqcU0iFsu/wfdGC+EmGFlmlLm3ALvm?=
 =?us-ascii?Q?jXMKIhF/O43d3ob+htNOqQ3PBfsL1o5AgedKvT3rcRCTxZl5g14mvswSsi/9?=
 =?us-ascii?Q?I3efesmbMdhVVRhMkEfE9axMNKz6b9hd7HIyiAYKcN5Qs5xu2eI4P72z4Oex?=
 =?us-ascii?Q?dapKZxPtgTY5I6h0Zm2K1wgnZhhshr0jjKF3kl7kyxfzr7J+nsXtt5r6lBsv?=
 =?us-ascii?Q?ohWfRc5tr9B2/ZWBqo1j8nwf8zRQ8nBxekg5LDr0oArSQbqwJV8Kn2O5ACA4?=
 =?us-ascii?Q?wO+j/HwZ7TF6I0c6+DyuVJREAG2ixY7bTu+3FC37y8LgyzGzaJX+R6yeZpDR?=
 =?us-ascii?Q?7Mrnbv39o30uSYsoWPK0mytYgXV4/LBIYjPKlVdlQeCeb8DhLkIlU5ZPGsMR?=
 =?us-ascii?Q?O6G6Lplb9g4eZLB/yw1sBVe5PcWGCkMYpJ1UI/2qbW1KwRRYMWN6MP1bSLjk?=
 =?us-ascii?Q?ARPs+SAsZv4aEBHqVmZUYQkRFI/LO8UYTzxUVv8BLGGMw423IIL3zqSd22fe?=
 =?us-ascii?Q?g9vM6/P44HFM3SK4b24XiaiuzDPUAZMuwrmzGb7L6m/erw38r04tN1an/suz?=
 =?us-ascii?Q?PGcuo/9ZsA7GSUmap1ndSC9UhfWNT5o2WOaKhYvtJYT2yi+dosaDh5X0bYJ4?=
 =?us-ascii?Q?7ie0uEJzrYIUNrkjOJG/pilzlSY49oaPinCfMhiRLNTuwNhphGpC/7Ag4lzg?=
 =?us-ascii?Q?kQMElQikfkcIaLdfv2gYG44jPNVEVmmqTPfSrSZFNv6iKEuhrk5zZ2ROhSH2?=
 =?us-ascii?Q?IC1/2bUQTXr8ko5XWsKDY8yD8+lvwtBKLvGYw4tUKCBl3C2eMxbGelIPkKXp?=
 =?us-ascii?Q?WbpQ2xJZN0/5kOe+IRPfgg4elr1c/sRZG4orD+5aKFvcCkhWZbB7O0r3yso5?=
 =?us-ascii?Q?E3NK8SBbLK1WcDEw04BN8+lQpDH7PONWaAu/o4Ba8XvPcPfubKM6v/b5ciln?=
 =?us-ascii?Q?C0Up8zGzSerk/4ad0hQ9bi3rWXYE1i3artznZybPex9xTYDJNKX8SfmdRjxX?=
 =?us-ascii?Q?wARxZHC9RMXF6SxurIh3uBYNqr+1vu8xoeKZmRVw0TZ9k1xjIdAPTK2IhaWG?=
 =?us-ascii?Q?coC5CDyZr88uAp4Hk7xsP4xf0OWUyFaRCehdnyGx/mrQwru/Alxa9nfn1iS3?=
 =?us-ascii?Q?mQ2s/e2NEYMeuLGixotk7s2vD25G7weSNOL7Lj6H37U0zpanx9eejvlBeO7G?=
 =?us-ascii?Q?kZyn3qTRXIo8XaYDOEKRA5oW9Yb+3+7+68F43/kv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5245b75-ea67-4d38-d2cd-08dcf8e6ca86
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:28:50.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJr7h5TjYNXC8GJ8jj5HlDGj3b8XpUHdTALfXCh/LlhO4S3DO9RvybA/Enu4rAt5a7n+x9xEFPljHwXERPIheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477

Wasn't able to apply the patch. Seems to be corrupted. See below.

On Tue, Oct 29, 2024 at 04:54:22PM -0700, Rosen Penev wrote:
[...]
>  static void mlxsw_sp_port_get_strings(struct net_device *dev,
>  				      u32 stringset, u8 *data)
>  {
>  	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
> -	u8 *p = data;
>  	int i;
>  
> -	switch (stringset) {
> -	case ETH_SS_STATS:
> -		for (i = 0; i < MLXSW_SP_PORT_HW_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	if (stringset != ETH_SS_STATS)
> +		return;
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2863_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_rfc_2863_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	for (i = 0; i < MLXSW_SP_PORT_HW_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_stats[i].str);
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2819_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_rfc_2819_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2863_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_2863_stats[i].str);
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_RFC_3635_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_rfc_3635_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_2819_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_2819_stats[i].str);
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_EXT_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_ext_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	for (i = 0; i < MLXSW_SP_PORT_HW_RFC_3635_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_rfc_3635_stats[i].str);
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_DISCARD_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_hw_discard_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> +	for (i = 0; i < MLXSW_SP_PORT_HW_EXT_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_ext_stats[i].str);
>  
> -		for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
> -			mlxsw_sp_port_get_prio_strings(&data, i);

s/data/p/ in current code

> +	for (i = 0; i < MLXSW_SP_PORT_HW_DISCARD_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_hw_discard_stats[i].str);
>  
> -		for (i = 0; i < TC_MAX_QUEUE; i++)
> -			mlxsw_sp_port_get_tc_strings(&data, i);

Likewise

> +	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
> +		mlxsw_sp_port_get_prio_strings(&data, i);
>  
> -		mlxsw_sp_port->mlxsw_sp->ptp_ops->get_stats_strings(&data);

Likewise

> +	for (i = 0; i < TC_MAX_QUEUE; i++)
> +		mlxsw_sp_port_get_tc_strings(&data, i);
>  
> -		for (i = 0; i < MLXSW_SP_PORT_HW_TRANSCEIVER_STATS_LEN; i++) {
> -			memcpy(p, mlxsw_sp_port_transceiver_stats[i].str,
> -			       ETH_GSTRING_LEN);
> -			p += ETH_GSTRING_LEN;
> -		}
> -		break;
> -	}
> +	mlxsw_sp_port->mlxsw_sp->ptp_ops->get_stats_strings(&data);
> +
> +	for (i = 0; i < MLXSW_SP_PORT_HW_TRANSCEIVER_STATS_LEN; i++)
> +		ethtool_puts(&data, mlxsw_sp_port_transceiver_stats[i].str);
>  }

