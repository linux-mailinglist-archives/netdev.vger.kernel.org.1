Return-Path: <netdev+bounces-150709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF09EB377
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EC61886D02
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF061BBBFC;
	Tue, 10 Dec 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BzPpNhLS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898061AA1F2;
	Tue, 10 Dec 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841289; cv=fail; b=tJ8cnFCyRS4BBAozPIXo2XeHz2nYo+vJwKWbQHeB3sIvLaca/N6CYA9lL2rmBGxO5E2RaBKwf/zqdpvJV0QRzB/lAqo65GAnMEP8gt7aUbkljqNZGkSocv3dSa1zHfJGeFYfRWkWc4lZ5H4W7mnESDJRleczFJEyQSBvPxPW4EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841289; c=relaxed/simple;
	bh=uoXp8943+IB+uWEYVDeq+E1aF7xpEtbzek8LF+WI4Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q4lkLB6Nndu7Br5thvc1EoZHr0IggCmsK9yhd8oelxcy+SbRZbkh73+0t+X8+ADF91DOndHm43vuKk/H1vNwhc4hxJzt0I7PmJi6bQ65CMqxnVThtXIjWvRupYeU4kYZseuFZZBH6oWYd+SFd8Eo5sR97PIzWUkK/+GE3lftmwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BzPpNhLS; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3R5efRmAQZt2J3dMgPhVpqOYmRL3uUHL+hkpiDak5h50BdNsrgB4tPmt7cqSvEojr5ivVMpEQeFn66pLOcaoLAnKlC+pweihUGDQ7bcxmdPFi/ypdMm9eT29ZDDZBRwfhtLwLGoTBFMJe6AkoO3fe2tHS2Ue1VnlnWQDBrpFeE1v+J7TGxm22nA3vV2ZQBWe8uPIAtnz8ifOidBksSddXYD7ZJVO0Ix+hZYkY0LeOiUVF3jZsvRjBiTOuRT+KDIUO7SbR9Ly6DMtf5FhhVyPsIKGZYmcmMUskKUdx7cTjtrsNV3z3EKByLor+XhBM4hEHAa6I5No6prJFjeSOx7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDRYjrrJ8T5W4x64JHEScZFnezzOX5UxQ4qNKMnXAqY=;
 b=C1J1AfV1g+JqdO8woABprqkp31w0Sc7lMllEDXxa8PX9X8EHXtaA/cLJmhTEndH910LUcHBKEuluEY5zV2na/23QXtZ8xoEIGat7zb4PyKi/TNIiXlNQvQx1tnnrVlaR+R+vd6lsofPXECetydADyFl5M5SVBTZeALXtFG1XQKZfsZWzYD7d5w3g/N9/dE0FB1nQQioWaiPv+L+5TevrrIm1OLsAZELK2Vv9KRdhHa4NM7us7S3jzK85qrA5f12dgk81kkud6zb9kdRMbdd1V7mKya4wheyXRZdBUbNBsIAQbjV0iNQ6i75T+oUKO6C5NuYu1z3jyLVCrq2uYfS5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDRYjrrJ8T5W4x64JHEScZFnezzOX5UxQ4qNKMnXAqY=;
 b=BzPpNhLSrQ//P6n8lzTEhdTa2Tz7rHLfViCzPg0dCDEtIjtWESoQJ6Qpm1ctsjymLbRRpbuXEp6ae78BnAtOKSPQfPqd3YE4FbZQmQ6hbwcSmffv1KE7ASpgz9Bo7oMv0BPo/zloXFVeuBW4zXE5A1gyUYoD8QMDr8QFXogMRcvzxz4H0/yW1+YVCWujKa1iLQXRBBtdAhmgSMWxCx4cW6exS2Fo/gmthxGEMpKl7petMcwtVxxG6dBMHQAtQ+uiQrVI1XQzn/5DAUqk56d3YYPkHGJOn8Jo1wjgTL2Ik665IZ/gO3L0g5UEmB95gLx7DSy5h8MfZ/azZCS8GxUQ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 14:34:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 14:34:41 +0000
Date: Tue, 10 Dec 2024 16:34:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <20241210143438.sw4bytcsk46cwqlf@skbuf>
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210140654.108998-1-jonas.gorski@bisdn.de>
X-ClientProxiedBy: VI1PR0102CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bb7f0b-87f2-4ec5-9a89-08dd1927c8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXrc0X62MRaL3e8MaEClOY+keelqLLcbTOZ+o+I2oJqfx80Mg14WslB12F5z?=
 =?us-ascii?Q?b1erp2YmiqeDH38XWNm3WOJxABh+PIs3hVhIkolPV3cysUEMwNhSz7G1f2DN?=
 =?us-ascii?Q?pTrX18pHRmYA+7XIoeFyHA5iMwrCjomZg6xE0y+FJVRwX2U6ewTY5nimQOYs?=
 =?us-ascii?Q?HaMJzda7pEUQi+n+ghMg5zrX7RkfvlQOiVzWC4ZB/MNGnUOoOVl3NcnT9rlD?=
 =?us-ascii?Q?jQKiiprKA3FOIf1l2XprUpLL588RnyGw9rghHOArVWwlimKgI+d3nTEbv7XK?=
 =?us-ascii?Q?Xyv6k6eW/C/W+Gy2DZmHe87b4Q3joXQyiz/kdD3Ldc1WWxrwWQeGnZye2ryK?=
 =?us-ascii?Q?qfFD2CZg0/1nExmmJ/eQTGYA9/zJy3NmwccSnite2ZXHmA071efWtk5GjOTd?=
 =?us-ascii?Q?y/88NF+OuFI9ocauhWujZflrOreK3zKzFJZQZcKY3XxKtNr1vxNSkFP4H3LC?=
 =?us-ascii?Q?AnPot8dICPuJ8B+nZ5EUrkAkzi3ZOPPmj5Y1YU4RY80cInM6vcyvlO/HeAF+?=
 =?us-ascii?Q?Bw1ZgUbf9x0Upnf1w/lYWfGigdT1SA98vgIr2XFZe4OLwcd16gESo70ah6yE?=
 =?us-ascii?Q?b+aIJgzTUKfqiy1RJjTglyR82y/l8yf9dsdn7D+D7+dmTRTMD80yKPilpL6P?=
 =?us-ascii?Q?pfCsBA3gkbuJ7C92JqOk4PrFnu1OgV09C/uXDLz7cMIx2wPQr79Xu1jQtsXo?=
 =?us-ascii?Q?EgtGnzf9vt/BdZTnB4tnXkbrWN0f9uMy1P2Fp1tS6iGqkgY4X71W8eyu/cMF?=
 =?us-ascii?Q?JG/t4sDXzJLAB+BHZCXK6ryMj4uhDfIzrS3d8cjcvGUiRP6k33XMfxiKnbXm?=
 =?us-ascii?Q?ZiX45l2f0C5iyVfE/YyM3YLQ+G0gkMLSqU29HEnb9duuu6SD84pPmNWpHHHY?=
 =?us-ascii?Q?SBf6XqYvQwhmRfsIIDkHDN4jk1DJBfrRprVCili8QLZ5Go95OYGUsZoZtrPP?=
 =?us-ascii?Q?JosAydEjFMfjrzvydnviIOPQKMUq13WYoRzOrppm0cySa7tPZDhxLWIcF/7A?=
 =?us-ascii?Q?ulqMPm5/iWg46u90O2RhocMRQ/znyBbduoxhMrzWz9fP69XwKFA4diGQD39U?=
 =?us-ascii?Q?kBnpFT1kp1jlnSrQQgWTe9/aq4oegfle48Xj+x6yTMF+b4Wmb5eziE3Bn55u?=
 =?us-ascii?Q?nzAWU62qkJPEHc7GMx1eOPmfv4n/3gCrypx7syxiwmjTXu/14aXvbfO4cIEq?=
 =?us-ascii?Q?kY7opEcbEEpCmOVqRr/NYEyXcqB1oeftEoL1E8Po+Q8O+kK3Ha44YoWuO+Mz?=
 =?us-ascii?Q?2Jvnrixtm6h4bmzhQGL9LBm+xtrF7VriauRwkMxaeq2FxoCSxPisbSbT13Af?=
 =?us-ascii?Q?e/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHzsUjVdViRFnLtPWrFHMuH1MtCLeexRw/cH/mVg8RK5UDtVuFuXKlPuVWUO?=
 =?us-ascii?Q?gVRIz75vTN3nZc1gBVJbEkU7Tz6rMYeDdHjp+yQMGJFwmTxJc1T9wRWwm8X2?=
 =?us-ascii?Q?zSweoUaExC7wg62HZMahqc7rvyAuw7V6vcKPp/QvGEZyhHPbdUBNjH5osVls?=
 =?us-ascii?Q?oHDCA/RDsIhEEre6bdhVq6+Xup3YjOfcToAgomM9Tpcxi3KwOuHGdjtw6xoB?=
 =?us-ascii?Q?YjEkywUkgs8GeNxixpsTsha2F8kXgZPpeBggi89cZjH3E3Y0dEXM9IVR/ljj?=
 =?us-ascii?Q?WO1pQWLim3PZSfwKgQylUpJk8IFqX2Z7/UzaC5R+MDWQxwQj2wu8o5SbI2ty?=
 =?us-ascii?Q?t4asogYQWxwictkDVlMssrfP0TkB8l/nBKBprz5M0rCko8Nm8gXsMz+cvAa7?=
 =?us-ascii?Q?cF8cQpyRjIodELh1yMXfMbJbjq16Sso6XlkMvVgxma1Zz2Xf+l+RN8Vf4fye?=
 =?us-ascii?Q?9vdyIJ+4tWpqYRzXWOSZhyzgiY+nNNqU9yUuboyR9OF7nlIY3pdRBBfi1oNJ?=
 =?us-ascii?Q?j/f6REfH3m73TrANO0fA5foYFYGnW6pgDA7VUmSql893mGCQJ/1+o/Uyn9eq?=
 =?us-ascii?Q?DbvK3OEd6uk/Bvkns2/OisWFWRffKmnYeevusezewvtTI4rIHCpE5lqYp31K?=
 =?us-ascii?Q?N4BWbl64qOrQiwQTh/uGOV97wVCn2GRZP0GyQnwkKXOhG4zxO0UHp49BkInA?=
 =?us-ascii?Q?JmowFQTDQ+0SjuLFzXn1MDoDyraM6to6xasTjAHjZzJheG+WMVmNzaOlxyrh?=
 =?us-ascii?Q?tBG1ciJ/wpEpoGMwQ7JfPt3wK2qabaV//7iG87gHbDEzBrC1B+HJLIrGZQdE?=
 =?us-ascii?Q?LDO2h8yq94sRj4212Ohe1l9DLqVgATLd7cHaD7lxIDsvOeydQihvefBcVlJ+?=
 =?us-ascii?Q?xXAAU7Om/Mp1vB4dt2XQoHIu5cZ1d6amv4nZRrXJrcGKSVX4K1Es1uiBQMN8?=
 =?us-ascii?Q?Gp/xQTRYPM3CfmVKENcaUku9IUelloXPK8X8Q7dKnB5DwLttHEEGyou0o5W6?=
 =?us-ascii?Q?IBaFCl3tFXhlxauNUy25tI7mNzJf3BXMKa03+9DctREiJ4oIQjWMC/N/q6Q1?=
 =?us-ascii?Q?W9lZoksQyjOP3VDVXpwD4+VAbO52UwkcjWQw7318ufvuOkiw5jUBElDBFsLG?=
 =?us-ascii?Q?5nN6oJinW1AdKVMNgcAwfRWyioS9Kn5T5lVMdiAp9NQ0IIYLhwuP5utD0aZz?=
 =?us-ascii?Q?EMsHkHB1J7ud0j3GhHstnFHGsHJ8+F0BfHLxA7g2Z8mfrSQBZ2imQ8csOCTW?=
 =?us-ascii?Q?CRRCkD/Y6U1U92X3FXbH/CF09CUErc0TnWdgvS7OreisMAkNpezVJ5p47M0B?=
 =?us-ascii?Q?2CjwWm1EPVmfbVFcVY62IwNRMfprpEquNj6gqiBV09p17Zx3wQI9skCblvL5?=
 =?us-ascii?Q?TI1t5cpSFVc0Bcd5tWM401I1L6prCF8G6O0dRHtlenSjmXD+hYrdJnVEIiZH?=
 =?us-ascii?Q?TuNaSu8v2u4JjMPpeh8RW2XybNGI83D4ix87ewMqy6Zv5nPrZoY0RQFHUXka?=
 =?us-ascii?Q?8n2RlQxPufwqv3pJa6TsJFjb91QjNV9qbbDRqb4uE9umtsuiAfKoFGe8R2ci?=
 =?us-ascii?Q?eIoNPvrcHuYZ02RqiG8AN3vIfAjEets28Kss5NP/+AZg0dHHaOjKm7FTuFcX?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bb7f0b-87f2-4ec5-9a89-08dd1927c8a9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:34:41.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgEccHfvkIVHrldTWP+sGj54pYwTE/OGb3U6dl1dwguW5suQEL2P3375SaWOGDwseAf7Gm+UyStarh20AZ/ECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8199

On Tue, Dec 10, 2024 at 03:06:53PM +0100, Jonas Gorski wrote:
> 
> When support for locked ports was added with commit a21d9a670d81 ("net:
> bridge: Add support for bridge port in locked mode"), learning is
> inhibited when the port is locked in br_handle_frame_finish().
> 
> It was later extended in commit a35ec8e38cdd ("bridge: Add MAC
> Authentication Bypass (MAB) support") where optionally learning is done
> with locked entries.
> 
> Unfortunately both missed that learning may also happen on frames to
> link local addresses (01:80:c2:00:00:0X) in br_handle_frame(), which
> will call __br_handle_local_finish(), which may update the fdb unless
> (ll) learning is disabled as well.
> 
> This can be easily observed by e.g. EAPOL frames to 01:80:c2:00:00:03 on
> a port causing the source mac to be learned, which is then forwarded
> normally, essentially bypassing any authentication.
> 
> Fix this by moving the BR_PORT_LOCKED handling into its own function,
> and call it from both places.
> 
> Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locked mode")
> Fixes: a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB) support")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
> Sent as RFC since I'm not 100% sure this is the right way to fix.

It was decided that this is expected behavior.
https://man7.org/linux/man-pages/man8/bridge.8.html
       locked on or locked off
              Controls whether a port is locked or not. When locked,
              non-link-local frames received through the port are
              dropped unless an FDB entry with the MAC source address
              points to the port. The common use case is IEEE 802.1X
              where hosts can authenticate themselves by exchanging
              EAPOL frames with an authenticator. After authentication
              is complete, the user space control plane can install a
              matching FDB entry to allow traffic from the host to be
              forwarded by the bridge. When learning is enabled on a
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              locked port, the no_linklocal_learn bridge option needs to
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              be on to prevent the bridge from learning from received
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              EAPOL frames. By default this flag is off.
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

