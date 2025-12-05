Return-Path: <netdev+bounces-243749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C8ACA6B4A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 09:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 297D534350DD
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB4346E55;
	Fri,  5 Dec 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="d79W5Hu3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DE2FD7AE;
	Fri,  5 Dec 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920210; cv=fail; b=Yxjy9gCudj78y0nfHbYgvNhR8LPleEw+ePWOuiUB0XifF1y643gUvknfX7N06vmWT+H6Tan+wZFjYh13rRsy6zQ4H0Yh5ktGpPXAmYT66+sj586N857eWR/XY0+C6hory2w5i+puz+DcKuxEFobX4j0220tMDMOcp41fwkmdg1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920210; c=relaxed/simple;
	bh=YxekMZXC8z1IV/gTZqkEAE9+TtHGcZYVdN1LmuQ4rMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMyobcXl/lULc2oR0ojPxOXZTHdftz571N9Tb1koQMU9Qm0rJHC4rP9bntqKpDnJaXC84sAnD5hsWXdnA2RZNyPzzgZdbwyIhw5dpw8SoJ156bp1TYr+4OtLYtmy8xmRjk2Qypx+mopCvkaVQ+WbD2gK1ASuD51MOqjkFRe2xXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=d79W5Hu3; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B55SkFl844717;
	Fri, 5 Dec 2025 07:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=XDOXj1+CRBJ7VP8Cu7Tkcl
	FAdlaXPXyVIqYyOWM9dy0=; b=d79W5Hu3JA+goBS+oJfdc0fzkULQp+U9yYPgB4
	fghcoLAx81nzgdrkrFM9jY3+nNWBbmkPS3+b103qcCcCcq3PmP2MbkKhigiTG1B4
	mFxmGgym9gS/20cdxLz4HohUONXfnGm04UnVD0YNcSqVX8dvtXYbNMgyFO3R7orv
	RPUL1P1rmU5sDqmAgj0KmzhVGfv4ce2zuLleZHQ48h/fy1TtnY4w1ZuvBooqN9+v
	2fmYsb6Glj680u/xe7uqw4ctqiSeJ7WAvZ47+BjMd5LG2lETJXapXQRmdi2w2KW7
	TFu8W3tX25nf/XXjKdM5U81FreESG0VvjT2uA3Lq7PYxsKKQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4audrgrqwe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 07:36:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opzxVPlGaKemcvPdpojogv85Y0KYdFPcWKeHc6qF5MaFOMuL+z+EKkLCzpa3Tn2wrSIm6/65W1aiPto84E62gGNkHuvOpS3ZV6HgHbb0Js5TxgaFZ4Y7+BDSnFSeY8KtfHT6KtBi7bU648JwNpKViZ7m902FbuQsw9ZBNRpJRddAPonG6cWipk58EfW7eQJr+mCEIMnrjaD9IZVHi5oJouYOy+VrLNuPezrtmue9oXkeECVJpYUXF7cY7m1ZhgNGal3OtbDDcCsuqcodkqKYeQdKfxCy06MJS1XXRZIPajRm1AVxQR6Q4vy3llxZTQeHx+7dQ5ktKH5Mr9jlABa7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDOXj1+CRBJ7VP8Cu7TkclFAdlaXPXyVIqYyOWM9dy0=;
 b=i9yj07tZfg3mSrS5Za6LLiTzAdSd/i2jY3eWGf3ln8zq2QJtTyJUls8Y2t1aOHKiioIGtgAGd1ndYYomg8QmGLX81vu9pLZBkVHVMdyMJfUGz7IVmrkqkxdGmcfH3RTZ/58IhIEv+FJj6NS41IYTPjCzslnZ0L3htdLZsRuGliIQgJJLGXdIh4fXsioaeLkwvS1FqagSpPpix+OtFWEzk7hlHfn/zETf79ZHG3K6jlVy2JhXv87XBS1VoakgccAxSG5oxvcCbcCtfCoy2VO/pJATDI5y/XbZvypRRdPHIdaQnLIZVJteo3LDlefpcds9evpr97QsX8TcJKs4HojnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8)
 by SA1PR11MB8838.namprd11.prod.outlook.com (2603:10b6:806:46b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 07:36:08 +0000
Received: from MN2PR11MB4646.namprd11.prod.outlook.com
 ([fe80::5a5d:3c61:7600:4a56]) by MN2PR11MB4646.namprd11.prod.outlook.com
 ([fe80::5a5d:3c61:7600:4a56%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 07:36:08 +0000
Date: Fri, 5 Dec 2025 15:36:01 +0800
From: Kevin Hao <kexin.hao@windriver.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, nicolas.ferre@microchip.com,
        claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
Message-ID: <aTKLYc7-lc7lfmvI@pek-khao-d3>
References: <20251128103647.351259-1-xiaolei.wang@windriver.com>
 <1b9ade5b-bfa9-4bcd-9bc4-6457dffcd887@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EhXYeZk8OU1zNtw3"
Content-Disposition: inline
In-Reply-To: <1b9ade5b-bfa9-4bcd-9bc4-6457dffcd887@redhat.com>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To MN2PR11MB4646.namprd11.prod.outlook.com
 (2603:10b6:208:264::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4646:EE_|SA1PR11MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c59c52-8dec-487c-521b-08de33d0f482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CT/0Q1uG1CfOzfuZ6X0WCOSEN/Vmn3Pyt3xTdAcCkptYEBtH5boExrg4cAQo?=
 =?us-ascii?Q?64188U6wYoIYgRtLpl+2vZlGUYgztgOiEIUDsVX+Q+8tEEyzW2mxAFxEGbfS?=
 =?us-ascii?Q?CRSJCd2Ks9Yh6lYXA36vdJg5wVMw5t+4SpAaAVrlOrgMDITvQup52vyE245c?=
 =?us-ascii?Q?Sg/y96wMZu5VC7qP2u0wEyFvffVqS+aoq/0RjNX2b8eoVG5L7AgCmJdusl+h?=
 =?us-ascii?Q?y1Dvtx+37QTZkj64xaXvig9QtkkhR5RLmiWSJidNM6M8kfEPUyVVb5TnVw/L?=
 =?us-ascii?Q?EIsiWUTd0wKZL36IRX6Lv1TRYNroAXdPwRU50A4pGhFqSC5L/6YC4tlAAOwi?=
 =?us-ascii?Q?LTJaid3YNHvnBkjgMyJism4tHtSy0lS0KjT/wG+VLht7BNJRnm3Zf8DxxeVz?=
 =?us-ascii?Q?j5ALbTbfXiBdz+RF5a7BV+7pfvDLFX6onm7GQ3cUQimnBHI3ZA0FpDGTF5Lo?=
 =?us-ascii?Q?J2jZOeiEsWQsZTRhUXSelLxU9ifsAMtYs73tBt48eB14yCNWCgXqEW5qc4GE?=
 =?us-ascii?Q?60ahJg89En7arYbd9+SFab/HispbJ9VlKnwVqP42e/3DF7T0v27W3oeoL5Z3?=
 =?us-ascii?Q?/gpi/JSjhm72tUA3iP9Cjvu4SSlYw/nLbXxF2YD3VhgTMPty8khMigjLNKov?=
 =?us-ascii?Q?qBXrXHeLAZaNQueBqK6XsIEHc5UMy3zwlphA5T6ehTsbNqzb+jxb/kbWxe8y?=
 =?us-ascii?Q?AQr8gUJthjDaLaP25ruXM/Eb9vwv78HSUE3CbidOzSr1S/rSpwrfEEHkPHlK?=
 =?us-ascii?Q?fzkFCmrC23b5Fo4OpkAU7dBRtkBfrRH3U4Hyt4GogZfVlOeIN/72ofWWGEeo?=
 =?us-ascii?Q?nf1sivuX+B9K3tgBpSINmG05ho6DgXyE3HDnPoaAuiZ4UtGSIAUoN8rs6w2x?=
 =?us-ascii?Q?MKtvUs13zikJ3X4PG5rYZt5jBZfdlJOqqZTi1l129RPrjYh7GgpXWj3h15R/?=
 =?us-ascii?Q?rxXJMcxBkmBrv/Tzht+Gr63yvcuk1dOrBSDF4/qvl1IgVgXpvxhf0pdPDzuM?=
 =?us-ascii?Q?LgN6fSeQ1D5ysLipzYZ0Oa9EJkOUNEX9hIji+ZTqf4OEfnifD+ZUQiDn3ufI?=
 =?us-ascii?Q?FHg8EBSfB5QzN5BwL01afgdTwy3FGK8EXiS4W30UywCY8+jKyEKCSrR06/Xh?=
 =?us-ascii?Q?Ax/kN0cjm5bmg6njHbTou+xGpPzcE+pxeoAhZd/Yi5h1j5GRRY7g/TC5HSlV?=
 =?us-ascii?Q?1SnZB5Z6cHR+fdPVGP5qqVefc/+TmDKTmgxbtVL3BiddIHpwarhHH7d95LoU?=
 =?us-ascii?Q?vsYR5EiP/0KFk+WSAvZSZbfIWKVFY16Mmt6++Guo1O+swTeFvkWikHwAwkcJ?=
 =?us-ascii?Q?N9HI5759bIuoGawAss6xdRHzR1dBWKN4JUxhoseAi33a6WEaoaBdivT1sdvZ?=
 =?us-ascii?Q?fFVyi+OFcXnVFXKlGWKrc7CTI0LyMi4GUlAfQygY21D+e6o5wFwyqhRJknoD?=
 =?us-ascii?Q?hnKagBpkuyeWCs+sYQ6nr7V8io43FMGQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4646.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3i7XuC7gCufb6mKhg8VqbBZTnOAnQwARFZmwQzF5zPhhqv+3SOdlLs15e55G?=
 =?us-ascii?Q?qEjoRuJahfazazV1KO+SnqzXVA41o7MWd6Jt4lvKbGf9A7BviyCW2B9eBvHM?=
 =?us-ascii?Q?P4p6nxdK0ciKo25NZUe2c/wcd55H7IdhuvlOtKT2cVVlVjyEm6tOV8xWbluO?=
 =?us-ascii?Q?8iQ6zkL3KoH+DROrpyLQeLzcudWiBKZ/Ul6kzW3cnUuGzj6uIbsVoumcsQTD?=
 =?us-ascii?Q?jFMFlqzqzuovTGHycs5kYUsY7UHhhdJEvawldeuyLgI1HB8xbIpVYi6J12dY?=
 =?us-ascii?Q?/jA52rvVFhVOn2oaodjy7pDOMB1JZsqv26Jh7cZ0oEFdMZ6DJhp9ia+6nvVV?=
 =?us-ascii?Q?NCluGjuYw/p7F2q2IxYWUrVeSJxPEr7ynJT64CmqvRK25sJoRwvTG/t8XBAt?=
 =?us-ascii?Q?hEwQCK1QqVgQCvRZszhGWW53MYahufxKMn9F63AxkGi/OYl3wLnvgdF5ScPx?=
 =?us-ascii?Q?fSIJHrO0Ri+lJT0u/RYoEsqvs8BjycfYmqwFZ9kptzN/YoUe50fP6AO3q+SB?=
 =?us-ascii?Q?MvDClt+SiyPP5OA3OTmo19PqmgN4UryZLOTX1gAH4xJQm42LUNp1/8shDQFJ?=
 =?us-ascii?Q?JTMwtk5NJb5nN0pRVT8jUC1DllvBvrmRQAEbFDx4756CqKGeLFMW3sXiGaXY?=
 =?us-ascii?Q?E3lHInT/o1FA5acKU8xpX9KeMm/Oi9lmOkReH9OMTcT+KmmSRerIboN8Mri0?=
 =?us-ascii?Q?hy6nQtSXSjkmTyyi/TFP9gX3IL1vYTzoRwie+Sx/rY5SAlDluj/XM9vwbetY?=
 =?us-ascii?Q?7gACzb5d2o2lzq5oQf7k5S+NuWILqs863t7ohs2GXnbKFeFlTmdYm1qGqgva?=
 =?us-ascii?Q?jKnFjZ0VmsBwCI41ekhgUUR4HJkBOom1pXI/S1gD4X8+XwTTU0QSstzOLD0+?=
 =?us-ascii?Q?5zCimlB011K6bKb7P9x72cNMjCkbcNOlDIAucRgvlgJ7oyZE7kSEZjeybbMa?=
 =?us-ascii?Q?GJyr0WQZhrWRYhewKkhghEw3/MBMCfg+SUrnRvxQAkG4NEUuhWxsdsn2pMAJ?=
 =?us-ascii?Q?IheFV4NThy+0hE1z9GKLwCj8Uh3znxBHwTQ6HXflQRL3oDAQl1GdxAurHrZi?=
 =?us-ascii?Q?tvNWjuTTELiNaWiuGjWdamiHG7AD931LqoDRlLVdRjfT59Z0r5/f6QdVmwIZ?=
 =?us-ascii?Q?eu5Qtla31MocxBehcZXJFzBYwLIx7insBvs7re9PVdycupNT1kOkrq89UzVk?=
 =?us-ascii?Q?urpp3pYp2y5KYm9QsItrRjsSlxmqkuynctUKFvqJtk8pEeKBvCE8oJUtA2jY?=
 =?us-ascii?Q?Xp79LxWJkJDi8Up2sJPxSRiFExBu77pbc7s0nNv4q/ZWGV6OAtoH3UndI7rN?=
 =?us-ascii?Q?JiV0Fzs00u4NFU+t8L5LSEnRm4gzgj35/bdX2qbujxV+WSeH8+zOIXv7JpaB?=
 =?us-ascii?Q?fLuDDV+m6iodAgZ0wS8qAyQiV0I0bd4/mhJSAGF/4bDNSJbvYoTO5RqvvX93?=
 =?us-ascii?Q?kl4VA2+OI1rBzAxO/Db46GraLL96HWdJ/+EL3GXjTiFLtrw9ZV3HdqhthHny?=
 =?us-ascii?Q?rS6gNru7dITS/fzBeaiCIn7f1aesC9qvlg6bDPYxy2O/LqynGswEzQ0+DT1o?=
 =?us-ascii?Q?F6sY/zWcCCudGRufFdaGKl+HlPDUHPjHVkhU/F0aFaP6EtEPvJ0nLkLSeGZZ?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c59c52-8dec-487c-521b-08de33d0f482
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 07:36:08.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pRV6AFQm+ccxh4601ZiQq/tqf0sL/qAky9NLc/z9KDOY7ZMqPADo1cDILvPUDNU2AP7c6xWmJ8/kub4a3ebqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8838
X-Authority-Analysis: v=2.4 cv=C+vkCAP+ c=1 sm=1 tr=0 ts=69328b6c cx=c_pps
 a=HPJBkY93y09GhBhYB2jcmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=YQrpizaU7kasljbXRfcA:9 a=CjuIK1q_8ugA:10
 a=rgOHtiJjaPd7tCvGJsEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: tTOJybfR-XXCXms_338PZctMMv6kMg1T
X-Proofpoint-ORIG-GUID: tTOJybfR-XXCXms_338PZctMMv6kMg1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA1MiBTYWx0ZWRfX10kDofmFjjT5
 TH9wf6xMK+sAul8u6WYDVo0UcUWxlLAPVLIB1ZlvdiOvD4a/4gM2B9T6+Sre8oIJPH17ID4rY8Q
 v7p2YShsvwOGmSdBc+du6VLx1UaDt7U6ERLpFfBhsM9Zc2PETz0XDGzaSb5Aq3N0Yk6paE2bnqG
 3XDrlTX3ax294BhY6okTkW5dtVVQir+bhQ+WokSxFOtE3ym8wGIWMgI34TEUDZ//zSEDOH51c9r
 i4gHbl2tpwhjBWSRVKwdhMADviDwqE0BC+KNK67SVlO3FGTOYY14f/U7zEQmNdQG27vKr7hvZuD
 /OzoP5zYrOmqM9cV0O+jy+bGWFBlP4SjtArJsCAJDUpzrdbJ2HcmjlWsw+NBmvzk7TtuPeTPwDD
 9Ezw6CSMeOiRsWJ6G7ELKjjSiJPkhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050052

--EhXYeZk8OU1zNtw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 10:25:04AM +0100, Paolo Abeni wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>=20
> On 11/28/25 11:36 AM, Xiaolei Wang wrote:
> > In the non-RT kernel, local_bh_disable() merely disables preemption,
> > whereas it maps to an actual spin lock in the RT kernel. Consequently,
> > when attempting to refill RX buffers via netdev_alloc_skb() in
> > macb_mac_link_up(), a deadlock scenario arises as follows:
> >   The dependency chain caused by macb_mac_link_up():
> >   &bp->lock --> (softirq_ctrl.lock) --> _xmit_ETHER#2
>=20
> I'm sorry, but I can't see how this dependency chain is caused by
> mog_init_rings(), please extend the above info pin pointing the
> function/code effectively acquiring the lock and how it's reached.

Apologies for the confusion. It appears I made an error in the lock chain d=
escription.

The correct lock dependency chain is as follows:

   Chain caused by macb_mac_link_up():
   &bp->lock --> (softirq_ctrl.lock)

   Chain caused by macb_start_xmit():
   (softirq_ctrl.lock) --> _xmit_ETHER#2 --> &bp->lock

Below is the complete log output from lockdep:
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
   WARNING: possible circular locking dependency detected
   6.18.0-08691-g2061f18ad76e #39 Not tainted
   ------------------------------------------------------
   kworker/0:0/8 is trying to acquire lock:
   ffff00080369bbe0 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit+0x808/0xb7c
  =20
   but task is already holding lock:
   ffff000803698e58 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit+=
0x148/0xb7c
  =20
   which lock already depends on the new lock.
  =20
  =20
   the existing dependency chain (in reverse order) is:
  =20
   -> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
          rt_spin_lock+0x50/0x1f0
          macb_start_xmit+0x148/0xb7c
          dev_hard_start_xmit+0x94/0x284
          sch_direct_xmit+0x8c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20
  =20
   -> #2 (_xmit_ETHER#2){+...}-{3:3}:
          rt_spin_lock+0x50/0x1f0
          sch_direct_xmit+0x11c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20
  =20
   -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
          lock_release+0x250/0x348
          __local_bh_enable_ip+0x7c/0x240
          __netdev_alloc_skb+0x1b4/0x1d8
          gem_rx_refill+0xdc/0x240
          gem_init_rings+0xb4/0x108
          macb_mac_link_up+0x9c/0x2b4
          phylink_resolve+0x170/0x614
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20
  =20
   -> #0 (&bp->lock){+.+.}-{3:3}:
          __lock_acquire+0x15a8/0x2084
          lock_acquire+0x1cc/0x350
          rt_spin_lock+0x50/0x1f0
          macb_start_xmit+0x808/0xb7c
          dev_hard_start_xmit+0x94/0x284
          sch_direct_xmit+0x8c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20
  =20
   other info that might help us debug this:
  =20
   Chain exists of:
     &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock
  =20
    Possible unsafe locking scenario:
  =20
          CPU0                    CPU1
          ----                    ----
     lock(&queue->tx_ptr_lock);
                                  lock(_xmit_ETHER#2);
                                  lock(&queue->tx_ptr_lock);
     lock(&bp->lock);
  =20
    *** DEADLOCK ***
  =20
   16 locks held by kworker/0:0/8:
    #0: ffff000800905b38 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_=
work+0x190/0x5f8
    #1: ffff800082943d80 ((work_completion)(&(&idev->mc_ifc_work)->work)){+=
=2E+.}-{0:0}, at: process_one_work+0x1b8/0x5f8
    #2: ffff0008036a1620 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x3=
4/0x4f4
    #3: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x0/=
0x68c
    #4: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: ip6_output+0x44/0=
x4a4
    #5: ffff800081b7d158 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+=
0x2c/0x2ac
    #6: ffff00087f6e4588 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_=
disable_ip+0x1d0/0x2ac
    #7: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xd4=
/0x1f0
    #8: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: __local_bh_disabl=
e_ip+0x1b8/0x2ac
    #9: ffff800081bc0260 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xm=
it+0x64/0x1120
    #10: ffff000803711328 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+.=
=2E.}-{3:3}, at: __dev_queue_xmit+0x694/0x1120
    #11: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+=
0x40/0x170
    #12: ffff0008001e3558 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+=
0x11c/0x37c
    #13: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xd=
4/0x1f0
    #14: ffff000803698e58 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start=
_xmit+0x148/0xb7c
    #15: ffff800081bc0238 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xd=
4/0x1f0
  =20
   stack backtrace:
   CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.18.0-08691-g2061f18=
ad76e #39 PREEMPT_RT=20
   Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
   Workqueue: mld mld_ifc_work
   Call trace:
    show_stack+0x18/0x24 (C)
    dump_stack_lvl+0xa0/0xf0
    dump_stack+0x18/0x24
    print_circular_bug+0x28c/0x370
    check_noncircular+0x198/0x1ac
    __lock_acquire+0x15a8/0x2084
    lock_acquire+0x1cc/0x350
    rt_spin_lock+0x50/0x1f0
    macb_start_xmit+0x808/0xb7c
    dev_hard_start_xmit+0x94/0x284
    sch_direct_xmit+0x8c/0x37c
    __dev_queue_xmit+0x708/0x1120
    neigh_resolve_output+0x148/0x28c
    ip6_finish_output2+0x2c0/0xb2c
    __ip6_finish_output+0x114/0x308
    ip6_output+0xc4/0x4a4
    mld_sendpack+0x220/0x68c
    mld_ifc_work+0x2a8/0x4f4
    process_one_work+0x20c/0x5f8
    worker_thread+0x1b0/0x35c
    kthread+0x144/0x200
    ret_from_fork+0x10/0x20

>=20
> >   The dependency chain caused by macb_start_xmit():
> >   _xmit_ETHER#2 --> &bp->lock
> >
> > Notably, invoking the mog_init_rings() callback upon link establishment
> > is unnecessary. Instead, we can exclusively call mog_init_rings() within
> > the ndo_open() callback. This adjustment resolves the deadlock issue.
> > Given that mog_init_rings() is only applicable to
> > non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
> > and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.
> >
> > Suggested-by: Kevin Hao <kexin.hao@windriver.com>
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>=20
> Please include a suitable fixes tag.

This issue has been present since commit 633e98a711ac ("net: macb: use reso=
lved
link config in mac_link_up()") introduced the acquisition of bp->lock in
macb_mac_link_up(). Therefore, I will add:
  Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up(=
)")

Thanks,
Kevin

--EhXYeZk8OU1zNtw3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmkyi2EACgkQk1jtMN6u
sXFngQf/dK242/SxGwzf1W4zYbyrM4afHCJRxNKsSFyDnNFivchzEciODWOre+Yx
olLhvBZEyViLIaLtGI5k9XNu7jy6qWYyGI8qq0CCy4WygDo9wSVSCfD5JigwuY+6
I75x9nvPX2E7Z8GBlkekjBAwV4a6W9u5meNE1U/G+B/muLA2hPoe9uDe4NCiaLTD
rlIUJPmyBuXebncLpRDQCiEdXX5e+aTcebPGOCTSAfPPsdwafwTpVDddqNCJeSAP
jEbveOF3f+HOTLgxNpZnKhow5/LeXd32xWPrqdE0jXvRKU7E16KUhwgwhYCnDP/j
cNRgp5dkWLVsjyqX4cP/C6XPUZsG+w==
=6yDp
-----END PGP SIGNATURE-----

--EhXYeZk8OU1zNtw3--

