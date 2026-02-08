Return-Path: <netdev+bounces-257846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nz5AIK2iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:14:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D9D10960B
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83EDA304C54F
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054BA349B08;
	Sun,  8 Feb 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckTUsnsz"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9A34A3A5;
	Sun,  8 Feb 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567122; cv=fail; b=gACLNB6pymwtNoEGk+DYpr/p993D/zzobfeORvfWHrMUCpYpSro/pgnvkq7/c4KMhMlMZrsgfMtnfz9WPDBP78Lb4bNLxtRpYj0aDP49wQRu8dQx+qH152s8kKC0WM/1aV5W3FwTaW66MpVHhx+gLe7S67Ua+PC8S9qDrGnVV3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567122; c=relaxed/simple;
	bh=kspARgD2OS7nYyJRSigbn/1W/cSswdOdzH2EKyFOzM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ja+xd/BCWBl3WjPYGprtE7ZYECoHAIaSAYVbJhqtMvAygx9gYMdhGCLjnX4yAtRi6UbsOHobQJyWUG5bUNoOInDJKIo5Q3FZDbV4SmD+xXO/oXckTRHo2LKspuyzDIt6c5zwbORXtBZ5zrx41xoa7ML9yF7ubjb7LPfq8XlJHgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckTUsnsz reason="signature verification failed"; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6STw2foS6MAK5l3AKOoa9hU9mTAOys+TonFiitELlTed3/5roIvE9KT0bZNzO0JYDO71kNBOuwQ4sz5yXw/1uLv9a5wDbkC8ZUc6F21RSl9iNp0GmrzIy2k2IC/K84fjAJSBRrT/e2GHTHrkEzAUnWA8uE5yM9ZTo/nLsKE68rX3xCazvezrkGuZLt/Vchs/1u+jp0rL1KQMbDbfnhEoTRIcWYzHEehz8Q9OS9/U6vNcaGChosTCAj5x8uOFHcboRs7nWxOSb3U4I8gc1CsByIK8cf/MONz01ZW4Be1KA/nSfOD20+AWuZYjzGd1vVhgv20epYyGcUT55wEyGbjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq6LDjrJBirKDCw7qSHK4Ews0WucoVS+4WsrwmvOPmo=;
 b=tlk8U0V7GD+dR60+BBFKHUiyiKBj+IPuOwALLwQmgLhdkoIqohK3cxNdyjRBAB/pDQclBytu6/H68FCLuw+8UQI8xrTYn4TvOqX5o0E2pnt7+QP+t3Nm1h/sAO+A7ipM3ak9nkxZm2mqM/buk3FPFzhaxnFTCzZMnok4gnl+XOcg33LUgwDg7r+PR1G/AlTpr4XMTbHmDoPW9wephUBRrBAxzPt+ofDOzcmWlzxG6og7aioEo8pOFENrB0ZvOkbBXuxBhww99Uhm8mB8ngfjUWRFSK25xWo9R+SnHXQg3Q3/D6sFIitj7lAhAzuf3ikzJ3h9/cCWALoRZzs2eyn1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq6LDjrJBirKDCw7qSHK4Ews0WucoVS+4WsrwmvOPmo=;
 b=ckTUsnszSflF6deUSxFHjYODAr20IrefNIL0MEu71/mECCbVMvvM8qcKILih/I9S/8G6RNNVe8UYRscbPqymuVOM1CstnskaijuPD71wodYZMRM7vTWqeaTiY5Y84FyEFiuAPGVcTfGB8tLnNpiLmaehx0g419kfSBFrrGVB0y/99u0IILxn4+hPJWq74EBm8xu5zzMLQPUhJL6t0LUwc0MJOIcK1dHWGM8jPZvmSSCcf3tkuhqCoBd9830BPySoQ6BUEJ8jusVN1XVKee5AO/wD/PL210/I3E7mVS/2aWFF9fQwyaREqpI3jt/MheIB9OwUqEfeL0aO6iXlEe8vyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:12:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:12:00 +0000
Date: Sun, 8 Feb 2026 18:11:51 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 12/14] net: bridge: mcast: use combined
 active state in netlink
Message-ID: <20260208161151.GL154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-13-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-13-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: c722ed8d-894a-4da4-0c3a-08de672cca34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Kh102+5GNW98FsvPn07M1X4CX+lfZiEnk0n0VDIb2TZJuypFt2PPgKSLwn?=
 =?iso-8859-1?Q?G4HL8ED4TFWj9FTndbqmt0XGaiswtcXnsYsb4YEH7KR5e+QBCnAJHLkORF?=
 =?iso-8859-1?Q?T5C1L79xTISJt+WA7+nCymS/o31Y8HFESf2Aphbpig9GeNITnElQi3yQg3?=
 =?iso-8859-1?Q?uYCRZjRwiX9LZo9kF6RfwwzSIq6S1CBq/+Kww1m0fEUwi8qCVj+7fODVgz?=
 =?iso-8859-1?Q?SRWB43RgfvoAI2ONkNhip24cTHoBuiFw9a3yHttilUP/6a2Cv9/f2Xxvif?=
 =?iso-8859-1?Q?NudUSUavnxZm9Bg3Phh85R13eebyCmgwkgfynb/N9CTKIcFDV/Hxompty+?=
 =?iso-8859-1?Q?X+A/7ODccYiksr9iyGTCpWE6+3kDUAkA3VWhAh/aGCyKH9O6H+lfpMhqeh?=
 =?iso-8859-1?Q?zr5DFubrJdY6yRV3zYBFb3vjKJC63FZ9Fv78kvU9cFhgc4HHeH+Bf3FRTE?=
 =?iso-8859-1?Q?Qs1/ahm9eLeAM8ioyNMvJPStN/zbqU3lCHk3Fp35t2MxGtEHiumejLNvf5?=
 =?iso-8859-1?Q?/LKjUV/mzwWv4zDONxAkRa8w/ewpBO4bO+dOOa+EoqSn/cvR03JS7sWnhp?=
 =?iso-8859-1?Q?Col5tP900I9SeHYVn6zE2LvR5L0CwLpFp4soHe6q7UQIypcYiqgXtrFShl?=
 =?iso-8859-1?Q?9YSf0rWP+DgLWOvXPbPpBx9y/PR/p9ttyXhEMpB2JvtEK8hSp6ONfsX5hR?=
 =?iso-8859-1?Q?DrAZy1w36q+JTzCF6hG9Bu9bQVwc7QDYIEZ0wMmwUmF/hBjsGijsRJLsNX?=
 =?iso-8859-1?Q?x6Bc633lbg2nhSC3LPrTq3GZ6K0ko2CVcBbL3MT5XijltkmOAhL9gneJh/?=
 =?iso-8859-1?Q?pt5zOxFPFV2k/hBIi7pcsgsh49cFmN5Zz38ZZVOyA9uJxxVKaRT8lw7U9P?=
 =?iso-8859-1?Q?zy2x6pn/thknOczP3mybomVSTGomunIkbYOFW0NJgzHGlmM0eYtcE9irdH?=
 =?iso-8859-1?Q?dDw2CjKxehn68tHPdFDNdtGAi00LsO0ObjmadIW9S52ipw6FyKFtzgEFL2?=
 =?iso-8859-1?Q?s88ps40fERbDb4W6HseC+q5NUzlniMOLaXbzZvDAjgKbqBjuZBXemflBQc?=
 =?iso-8859-1?Q?vtT75DVnMy4i/sIrX2aFolfk0Qwlsu48s+I2BY1qNdIdD3+aN93pgbiifO?=
 =?iso-8859-1?Q?T11jRQhrvdaLR9Ruhh0FQyCg2CX98IAnFrpEqlGgWKnQDORYsilBDbmtFF?=
 =?iso-8859-1?Q?t7G+9Pd9kTVniw4Ih84wBRz0iJ/x3VXsHqxkrNjJdX1I1Jzz8s61gtR9Fc?=
 =?iso-8859-1?Q?oO8gt+bgKPnmYgKk1oJCYUcRLOnRUOX1foefn9jG8HckLrW7lUWcMKGkfn?=
 =?iso-8859-1?Q?OanUqRSMs/r5X9X1erjJO9dvVekvv+CSVyfIojZalRP87AG8BYKBrPsqpm?=
 =?iso-8859-1?Q?mymWdqoSShtmljDA29sJBL6/DnvbhkEqD8cGrfYaMbYVErchQnXGF8uvRd?=
 =?iso-8859-1?Q?+5hMx+GrR3rc7ejfxEBRK33k/vLKdCkgFglDLHUvi/p1UuszHgRPKklDJI?=
 =?iso-8859-1?Q?kNLTT50WsBFln260ILvWijVmPjyJMxFFRB3sNSmY5u5cmaRLNFO8zXf3u2?=
 =?iso-8859-1?Q?aw+nCmvmEK3KKHsduXBFW3+Fx8nfbOLJoK+PUu1doASq72+Jp1h/a51GZ/?=
 =?iso-8859-1?Q?v9YMg93LuoSeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mMZEH9uy3BXB1twjGBl+Rh9u/TPsxeMeuGDcVDsSG2kicNEOQarhbLAN+r?=
 =?iso-8859-1?Q?TnpGKegwb6cgNK3cy+bhIS7xryfUf+UDqMkhOK/M3IuSl3Hx0xAig9+pjq?=
 =?iso-8859-1?Q?TyWEdc/pnBTlGDr+GxOaH8BuKlkDyjCbjiU33IAkR7iPLH27Q2XIj4ml++?=
 =?iso-8859-1?Q?PwsGp6mywhh9WqqF7kyl3y6JmnJAsV3VnbIN2ePzd+m50ZJZ5IKleYkSSI?=
 =?iso-8859-1?Q?Pg0wtDJhYUNuyhhw8u49uOqtQoP4FiKTUOeUwaEyOwLAD8NquLt+2X/fOu?=
 =?iso-8859-1?Q?mtQPPKVkMhyimMTbT1/4QKIjf8sjxfavYKQ5O3nhExWBjX0LVh3hKwvhEU?=
 =?iso-8859-1?Q?hI8mA/DtNqp7BScY5ktXOujUdamS3eb3H8eL3vkYDoOzX0oERm63cSThMX?=
 =?iso-8859-1?Q?kvKOUOetkq9BQgnT8D/6iUzRQF98f9JbvYyt8yTzbbdQfa2YHYcUYexRkC?=
 =?iso-8859-1?Q?OYLqeMXIgof1B040lLbBs60XyPGGCZYl00NikTUCCg7aaw93DYXEnU6Mi5?=
 =?iso-8859-1?Q?mS7diLtahari7mdHj3n0gnmqjS3VvKkL1ACCQa4K5SZW9qvZEEyHtaZvM6?=
 =?iso-8859-1?Q?VbkpNg9PrMg5axFZGzMcPLY1oDpa90XyONj3XR7uqWWaHvMh8h3ysKeBUA?=
 =?iso-8859-1?Q?nZHTSfYdqFyOsHWyeXy0XAEw8Fgr98V+wWcmNFP9mkDDxtuUdGcI3h0G0x?=
 =?iso-8859-1?Q?mw15gL+sRBGR1m/O/d+LCjal7ww/3ACLirRkUNV5m/x8gzHHMBPWJqEuw4?=
 =?iso-8859-1?Q?1fuWWW1fiyIb9skxcIxcvQs8t8swMH+T8iV5GuOWDM4JrsdM2IUbeF7/4z?=
 =?iso-8859-1?Q?HtwhFC/ao0pGT1LCrXDraqnNevo3oAUyzMzf4nM/MXY1TJyI1Z/N9VXo1f?=
 =?iso-8859-1?Q?c4D3PYtrqO2xR1ULq7m4F6689vM9/auFcLgXDsUuElVZbRJLrdDGGQ6rab?=
 =?iso-8859-1?Q?lP2PcfmKrYCHS9ayiQ4x0nsVA4Tu59pnE+HIEpxMe6qFmKbBWNXN2hdtjb?=
 =?iso-8859-1?Q?PYuvPlUc0GPpc/qCXm4i1+SpGyEcGNRiZRi9OJMS0LYaSHOclZpDOKcYrv?=
 =?iso-8859-1?Q?qW6NT4a00kzoH+L0MgPJK4dO3SDWbjVc+IiI9dFn2jsmC7zLdHFQ4T0gbB?=
 =?iso-8859-1?Q?oVA6Mqs8t+JIO6pHx7SqZHZa0W9U1cgTk0Czdf8+1d1oihs471T9EwKSiq?=
 =?iso-8859-1?Q?Z0C+pnSrH/xRWL4pM6vZxUxhJxwTUQEjxboAI/WYYZGM24IZyot3zIqD+O?=
 =?iso-8859-1?Q?oIez73dCMNsn+TZBN/TPEBn2QIz3yqyZ8hhZ0xTdTLJ5iD6aJRxnY2XGde?=
 =?iso-8859-1?Q?FPu/6mtaA7jpGreYTUNH9QKnF3JFY19mv9iitNQCJ/cuJsvVzX31Ch58cj?=
 =?iso-8859-1?Q?1KtCeJAsTToKERsRXybj2Pq0hy7Z+XSSsJmUPBJe+AP95zc/mRJjkCEVc7?=
 =?iso-8859-1?Q?Q+fGqjSsTQTAiyo5TafilNSC4Iu61LoX6/2AEMXV7sP0FhxPNo2mWAzXEW?=
 =?iso-8859-1?Q?y17AFiDk0B+kyOaANd/l16Q0rWoQ8RHTq5wLmB/WkW1xrDp5Xv6fi/kpc8?=
 =?iso-8859-1?Q?+LqfXDRB/EdwtiIDodeJ7fwG1xyve4pPNXqRIW7/hIdPwnNS5JmoCJa5Ov?=
 =?iso-8859-1?Q?8d3JHXTIvoFbPpN9CIKQ2t3zA3GCSEy+upZcS/teClxs2S2Y/YXmWPwVv2?=
 =?iso-8859-1?Q?vrW7INeBpftKV3R+NXgnqNDJ6UijytwIqqXmwdghgNTAGeMnJpT3m/J89V?=
 =?iso-8859-1?Q?HC9w1XtONl8QsBAL8nsFWPNSgcjNego7rEkNkvR1PI/04GTYcz4Ia1ah/z?=
 =?iso-8859-1?Q?GHarKy2+bA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c722ed8d-894a-4da4-0c3a-08de672cca34
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:12:00.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2E0/jBE0ZUyZNwjmo3gWCFHU1THD5uNZ/jI6f67eWgGpl9tvTC1s2SROw1mzrdhXxmlxgFmQhhn7g1maxdAQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257846-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 55D9D10960B
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:18AM +0100, Linus Lüssing wrote:
> Use the new multicast ip{4,6}_active variables for the netlink output.
> The result for the user should be the same. But this allows us to check
> that from userspace tests, to ensure that ip{4,6}_active behave as intended
> for the upcoming fast/data path changes.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

