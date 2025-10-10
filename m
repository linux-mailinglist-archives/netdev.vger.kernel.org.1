Return-Path: <netdev+bounces-228503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF4BCCB27
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 257A3343FF4
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B92ED871;
	Fri, 10 Oct 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YvdDYvCL"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DC271A9A;
	Fri, 10 Oct 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094500; cv=fail; b=EaNYoTmB/Hp+yysls90UKa2ldCZNgkC8nU1GwpSMVvWuPscQsebSuGPUozAfIm7HpLynO/gjAGHesRR+JiRQ1i4Bp2E0iMrYRtGeMEBr0H/E34w3zDPSVscvYA/e3aS9m2GZLqcxiZYS1sqOI9Gsr7TgH1MLEv1DZVSpyTzRlpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094500; c=relaxed/simple;
	bh=PnSM/Hx3FBAT9DxzoLw5yz8miCebAb6m0bAipeSj5IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEc+ml8cKtVfhiUdG8rwqfruGFxynLZgGDHWJ2TzdCUkRu35zY3wRmRxvlGvTIORHNEko8bmsKuKnGx5Gkjo8k9g9YsA3XxcyO+XlPZ/rWUUJcb+xPQj1ODcKeGzCmMqxZZ+556GS2PwNb2L/9tmL+0FJwDmf7gplUS/3dH7C5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YvdDYvCL; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlponh640Mk2VpMqCzwcIBlN4SZcacxP4EtRzqk6zBARd9rtjJ4thSb1r0KJUaPzqEow7iQNHm9fHK6pLMmazmYFxDzIV3JIXYO0Lj3C4Qy5TXyG1PQz5nEeX0y+1nOdA6PWBot5hPrSAKDuz9zjt80213bFkQzMoj3KZNOLCjeJyaA6IiZ4zfsurCSnVFmHNtC+1dA9AYYpYy5SpoBzp5k0igPHqAsVVfd1jeqy09NtCQm7y+qQ0YKIkceMVq0VWGwIRl5alUpK8zHg68kLDDqJllVZRoYsi7f0/P1zc7TF5YUsk/8uXPohxITj8IoP+mHM0nqImbalf5rVo2Y95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4itrh2mozeLvWgxQQAxxBJZjxV/1UXSRlYJd8q5uvo=;
 b=hNks8jva0rEnkQRBSbDP03d14xpPypL1ZaJE4PO0DApFTyDgVsdKuaiEu8oCvr42fOETt00XfVfmNiqBbS+7M0t7M4cm2G8JO5iIVdbS/QH8esNTlakAiBXCgoGNVFJQALdZqI0uYEkTVIWsgNUyEMxZ8gorhzkszkFMQcBOez8xizoT9uXoemk8PbC8/WL2HXdpTJFHZQ0XPniSDYqhkTrs740WJCl642QmP3wqiSyzHQmcUFNz4u/OWuNGpBxhJYk+IBcssd4d1Bg4qehXBLr8m/gJcQs2NmXNO7feCQUktDyqWTcj3ltSiDaFs+eHy+Uy5I1FlTMPvvrxRn+osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4itrh2mozeLvWgxQQAxxBJZjxV/1UXSRlYJd8q5uvo=;
 b=YvdDYvCLwIrIfj7pRyM7kJ2cpx5v5kq5Se97lcvRJFoRqzD/6RrLcAPcXVTBEcveGeaCHGXXxYHqM4ISYP1UmBc8PdKfQNcacbXmUBwPApmpTyvdKde6aN4bNc0Y/Wh6B4uagIkavBagsuc7YJGrQFrtRfneCckkvR2FTNS/lHtyun/oR5bdNO8lofpAshmfDfsF0uSV56LCsgCJOy9Is3Vq9RWCi+0EXYOhj0/fpBb5NI/ff6KlRd7j/4EDqCHA0H2hzKd7PS04i+zGvBYX40IYnI8RnutsQdj8QSIvzV6NIu+FR2TgRIv6YQzoHV+Nfjr4xHr8+8eO9hzfeoOQNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10994.eurprd04.prod.outlook.com (2603:10a6:150:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:08:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:08:15 +0000
Date: Fri, 10 Oct 2025 14:08:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: Re: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Message-ID: <20251010110812.3edrut6puoao36b3@skbuf>
References: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
 <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251010105138.j2mqxy6ejiroszsy@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010105138.j2mqxy6ejiroszsy@skbuf>
X-ClientProxiedBy: BE1P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10994:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cb4241-76b2-4b15-956c-08de07ed4f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wxsNKqPSjAzPYtN4nFqiET4X5HmUK5ML9lVGgsl2f948OYkh/Hqgi5T4UJfz?=
 =?us-ascii?Q?RCnGXQFJ1aofw5S4m5HAN1uQ/gAKQVJ21i/u18BfMy+poutOTkdPi1HFnl3R?=
 =?us-ascii?Q?0bja4Qys9JqT5B3q1ycpU0a3nubCE9v/7Gnlb2L5BnCP/SdW6MkZjPgx+Fap?=
 =?us-ascii?Q?Y+4WQ4sIjo02gm+zhOaSmn+ZyhaLL8rI3AbYeW90ziAKGtG6bzAZsfanoTer?=
 =?us-ascii?Q?TX5p+EfDtBogH9uky1mVGHvB4H9Au537CyrzTIAXCfZY6dXR7c0WDlctushH?=
 =?us-ascii?Q?IjJCrCBQK/3IzVsMBJexZfoQERAu5E095jsOq2oaQoz8rkpPE0uT7CmAFJAV?=
 =?us-ascii?Q?agSl0T7IEr3XCpppAmKccgnaDmc3ojHCmiSxy+leDQFnvEoiPE5SztqAchkF?=
 =?us-ascii?Q?N1My9/JjrcKgvuh7uDeHl+PRAG49MV1DMT5zJvB49HpqoFcWN3tmVx0eOe0y?=
 =?us-ascii?Q?VYHEBk0dBdxqg353afdp6ZxSm+Evi18O5eJZ5Kpb2adQSfb+X9Wv47LBjeIF?=
 =?us-ascii?Q?klGRayNrpHvRnR1FUif4ZNIs0/PNjcS2I8FqLCFRKt6EzW9daj6coAzDAlAH?=
 =?us-ascii?Q?S+ZOfpKyaUjZGVRBb/OM9qxveIFmiVsWkNfqjxC+bcDTTyDo3yUpgv0K/w5V?=
 =?us-ascii?Q?uyKg9bKxgfUxSCIWdwKj2kOFd31KvSlFR5AZbumsWQqB8PqeQyiHXYLjvFt9?=
 =?us-ascii?Q?daGal5o+5FL5g5lIrDueCHBCJLdb7bkAIG7YW8rRvVWIIqj7WtqKadY4DAy0?=
 =?us-ascii?Q?U6utIxQHYqdnupSmpfzs8ixOFjyeul47H8uD9F0lWEcnbRuVXBdZDkiwdBk3?=
 =?us-ascii?Q?pPTPP1tNR+2FF8fabA4qGHoZ2DsAbiCzxJJW1s9DRAdy+yKgxrJWlEvQrsQg?=
 =?us-ascii?Q?KXGQWfQmxEBn4NISdoYUl00BF/utOaBdvuI5jWM0OZ619kar8rDFT11Ls70+?=
 =?us-ascii?Q?KxN2QvxI2E/rI0GprR4821UhQGzOS6AHdNIbjhbkLfY3rO8dEMIKLFI1124l?=
 =?us-ascii?Q?yhMA16VSH85+TfDkt3wb+sI1/sU6rkDG5kicdxkeoCNzq9Aa92Y9fqES7DFp?=
 =?us-ascii?Q?5O/99ouPuk99svUfPgCXWRUuz3bg9/ll2b5aImokdGPrR5Lr0ywq48M1cyJD?=
 =?us-ascii?Q?lBrDMV5xmBaVpSLeFy/zaszqcC4L1JIIH0j8Trvd1fTE8gIAlsZRSWlUB7lL?=
 =?us-ascii?Q?YDmbhhfjJrAvSiNA52IFDz6TpFAdmziMqHuLJuNlunG2V+YijRRDwWJfsO2j?=
 =?us-ascii?Q?WrsinYPG3PdU76WMzCFDuzF8iNYrK9xCtp6aJp1w24gNBdewOaJYWxQ9ezT8?=
 =?us-ascii?Q?RepJt/4kB39lgQ5I+ATdBTzSWdaxEI8y3DeP0Ml1TRkmorL3tUVgWvMO0N4r?=
 =?us-ascii?Q?bTrX3W4/4tdhzAFVn6tW5ICAm1/cb1J/LBlUgS4B4FhKjKieD8UIGRmQeoVg?=
 =?us-ascii?Q?Hj/C2c273PTu7O6SFYrw17u7wctuMBFb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhLM024XTJBoxE0ZDEg8Z/t9LZNFAXjgnCjUHQCOKdnhsfVBrAkoZLar2Gye?=
 =?us-ascii?Q?J+WKaR0RBmQiDscNFEz9zo7k23IDSytOdhKCv3s4r5LC+7/yH1Kyk9bTYdXu?=
 =?us-ascii?Q?FR0RZFMKIBqIZJw5zYxjgMP3evkrS/BD/3J/FEC8WRWpXXz/NaXL0kEarcm3?=
 =?us-ascii?Q?Js7n1wafH0koeRSur9VtT5FjKrHA+pO8ZWZ8/NzJGzKI5sNQzJC9lJa6rTyh?=
 =?us-ascii?Q?LT/hqU5JW+BDlfsd7GiglEGNBFkoOfS3rIOuhILObFShg7GBop7C36AbsU46?=
 =?us-ascii?Q?xj8BbWlRjXFOcVbRLEvKSibvGqK6jz4wdgmDIF6irsQLOeBSLrI83l60MCml?=
 =?us-ascii?Q?jMheS3emgBHtpmbiZdMOG5QixmdhxjPbRfGbo3TfftrUtZ3RCt/ROVCuHNrn?=
 =?us-ascii?Q?sOBLOGp28WpX0Oait+5f39oav1yCTZbyOT+dhesQDAYJMJ0TgbIuZHCN2FD8?=
 =?us-ascii?Q?ou5gaVjsL6zDp2ksYF7zunzMEyASusqn4BVJprdpRk1NLUeI7yKUipO+hnP1?=
 =?us-ascii?Q?hMjKyPGNVLbO6JFnf4o/6YEZfLdqFUau3NOp9N+9gXdJS+M7Ll5oT+jTHMaD?=
 =?us-ascii?Q?W+UZxYzwFlZn1sXeXu8PhyeTPtVSkJ1UZW+jNqig1cOIZ/ngO7PHh11Q6fPH?=
 =?us-ascii?Q?RIMUYtFX6j1suV5JIJkTBSqlw36QWWw44ES698p4RGM54zCGwKCNjj6PYRUz?=
 =?us-ascii?Q?UDaXZcXg7HQNiWu/8zecBMd+OzlejHJCEr2zdyF04zVvq24OL6HBQSjJYxMI?=
 =?us-ascii?Q?QVVKD4eMKr9Vcymt6mbzLe2zecw4yAeuF2uuk4A3eUkijKcoUo3qqL/7nz/B?=
 =?us-ascii?Q?v7E651h6QZzUPR7IYybbxZlNUiiUG5oiaFNggwtfUnJjdDI7gW585+QgLFS5?=
 =?us-ascii?Q?XUdyHrpD1B+PgFIGii2M4MV7B70t+H2lxcein0WejGhRnjFthmFPqC0cI8dh?=
 =?us-ascii?Q?M0Qd0kSs0Vubu5mrUhn5kp75qLTmS1nErlFNncE3wKe18sVoLVebFz5fmpEM?=
 =?us-ascii?Q?KjFnbGidBP6MlbETrvyOY8swk+AfwLoYSmEsTaXDElHTmcXrZeSVqYUjlvUf?=
 =?us-ascii?Q?9TNoxde3DNAywFukoO+H54aRJGwJ56W/1eevsQ3W5uVyvFHhgxzrp1WyseaH?=
 =?us-ascii?Q?+ncQg88M5nAy/e6Slx3YJrZH3pFWHGOU24HjlPfn21+LygIb7sLISUV8BFfk?=
 =?us-ascii?Q?1illV1ikhrO/BKKPtIBOrZ7yQWMOAg8Wi74+t6i7piAEgFHisF903ZWnu6IL?=
 =?us-ascii?Q?CmJvO037FxCAWjwTDrgWHetA8EE/ziESo6hDAlsBuVc0f1BWz0lspc2QMCZ2?=
 =?us-ascii?Q?xoLjh0IuQQKA4lQHzHpfKHuoJq8YBdAT8jNJaQlamCZgEmKBNEUO4XQuMtr7?=
 =?us-ascii?Q?BlVXCjJdFhr+fMEzUrg4FZXqe6VsVXiJaZsDzayU0+/PZNzck7BTnQlCuTnX?=
 =?us-ascii?Q?mhWb5cmOMTZAXRrJiv7yiQkMfDb0IS+gvq6kNOJfv78G5/bOswdqGwudGJ9a?=
 =?us-ascii?Q?Dt8GSR0qHx/8sxI0t21eAtT3YcIWqsOyKR55qk40wwDZT9VeCK8F/aeuoJFI?=
 =?us-ascii?Q?ykyQz0r/oYduYB+/hGHkGz3qJpfknS0oCwTeLWG5SoMAxEj32aouebnIZZnV?=
 =?us-ascii?Q?Y8TIGMUSXuWNuwDy6vu3VLfM9+f/VGamhoQsNbPKiV3Siocwp1baWSLbxH2O?=
 =?us-ascii?Q?YWwTVg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cb4241-76b2-4b15-956c-08de07ed4f85
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:08:15.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG80uAlB+oznu61jrfr+GdnSBglcTM6/fjqlLco3JnpngOGpd2kvKI8XXJxU4N9/sFjhK0KxFidoWhjz0zFcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10994

On Fri, Oct 10, 2025 at 01:51:38PM +0300, Vladimir Oltean wrote:
> On Fri, Oct 10, 2025 at 12:31:37PM +0300, Wei Fang wrote:
> > > After applying the workaround for err050089, the LS1028A platform
> > > experiences RCU stalls on RT kernel. This issue is caused by the
> > > recursive acquisition of the read lock enetc_mdio_lock. Here list some
> > > of the call stacks identified under the enetc_poll path that may lead to
> > > a deadlock:
> > > 
> > > enetc_poll
> > >   -> enetc_lock_mdio
> > >   -> enetc_clean_rx_ring OR napi_complete_done
> > >      -> napi_gro_receive
> > >         -> enetc_start_xmit
> > >            -> enetc_lock_mdio
> > >            -> enetc_map_tx_buffs
> > >            -> enetc_unlock_mdio
> > >   -> enetc_unlock_mdio
> > > 
> > > After enetc_poll acquires the read lock, a higher-priority writer attempts
> > > to acquire the lock, causing preemption. The writer detects that a
> > > read lock is already held and is scheduled out. However, readers under
> > > enetc_poll cannot acquire the read lock again because a writer is already
> > > waiting, leading to a thread hang.
> > > 
> > > Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
> > > recursive lock acquisition.
> > > 
> > > Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll
> > > cycle")
> > > Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> > 
> > Acked-by: Wei Fang <wei.fang@nxp.com>
> > 
> > Hi Vladimir,
> > 
> > Do you have any comments? This patch will cause the regression of performance
> > degradation, but the RCU stalls are more severe.
> >
> 
> I'm fine with the change in principle. It's my fault because I didn't
> understand how rwlock writer starvation prevention is implemented, I
> thought there would be no problem with reentrant readers.
> 
> But I wonder if xdp_do_flush() shouldn't also be outside the enetc_lock_mdio()
> section. Flushing XDP buffs with XDP_REDIRECT action might lead to
> enetc_xdp_xmit() being called, which also takes the lock...

And I think the same concern exists for the xdp_do_redirect() calls.
Most of the time it will be fine, but when the batch fills up it will be
auto-flushed by bq_enqueue():

	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
		bq_xmit_all(bq, 0);

