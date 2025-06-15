Return-Path: <netdev+bounces-197888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FBADA282
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 18:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB51016CACB
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749414C5B0;
	Sun, 15 Jun 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c48KgCVm"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3C35947
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750003442; cv=fail; b=hgNHi6p5Gqf46xl7acOfquVxJlqr77nTOUc17z1pfN1Z+t/s3IRW3cGLcZOh2MvgP3kxxDbkFzBBD2RPxdGoi9xiMEdcXqsiG8WGWtRolQd9bfscloUi6tLmGKhx8S3V59PxzwTDel7mWslUlOrbhooYZfFDLlWUlBM04Vy5bnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750003442; c=relaxed/simple;
	bh=74Nq4MwHlwupRZ3LrX8Lq/QC5iEBAgu1r3MYXTRw1Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z4WAeF4FPtVT3r+pNkbtmiOqaRoZ0MuLYZiGrD+Ui9UXs42ysfgFUpoNPrfHcru1PWdy6d9de0TmCOO5MHNWUnoEP6xAJ9u2Flr8CGxAYjQWHmbuMKHZ4IFUsGpERVnzgKn40+YM7P7RGGVKh31xztyyFCQAOf0RJEXtO3XCLaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c48KgCVm; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj9ebzbAuZnyACJ/XwkmG4e1EYAwVZqwNMvSYMS+H1/3UNqOy+c5UL1CEnY16JBCs/l3Z/bdhD1VCc71FaELAGeA8xkM+tFLJ5UcQsv0oo0ukZFaaolu8LzAeaEBXBLnF2WSajlJqhHgbNAIB3uXag021Diy6n6J6i0KyYaym9Jd9kb0Ke3HHpv9lhFW98PFlol8nZlOxV/ZhACk1WT9Kb87NdtGUBN/0bBxpNttuxivd4A6wSg0cwqRHeZj8jg79JgbpO65aMw3sqM33kBByThFvZHEq2bcGGXFCy2UZoBLUqSlyJ18xSmVyiH8LPyFdlpbPJX3HvugT6nQGskyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZoCMjCGL77JcOef+gHPXGFT+XZ1bXTytdY+yA0dfHg=;
 b=HqoSBprBNn5uiHvemPn/ONW13z7juon1SV8/QAq6YWp3dgnfl1sNsCOsUZ3gf9jSe/Fhkj065NroJkfU38L6h5IdhpaGjwmfmEOZM0MBmJbnTZndzje0KPqMutil3cPN7T9nowNw0A8sjXmNLSkEDD6oM+51IdPJjFoNgsE8a+LCRrv1CbNAs0xuVXJLIMIlO6vkF1CFSl/H/BpPYt9kzftMzP8OBuObJ+J+5KC8g766ENgIJsx9SgHc+d6Exo/kRSblbxpLr9XJXpFFNX/4sTZXJzfrt6V0DweX2wBXkRvneKA305E6+iW9CTMkhPwML2Q8zj0+l2Mj26C32d1rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZoCMjCGL77JcOef+gHPXGFT+XZ1bXTytdY+yA0dfHg=;
 b=c48KgCVm5z7FXaZj7V3OeIHxUF/wzaifM/GD9295cqO/YKg4z14UVx8jjfQss29e1NaRPaJbD+4d9aKKGOFBK9ibkQRfpAiPYzs0abRZ84fwVd7IhvY2jNo4hxYDI7T5Lh3AI8aRNjLN5ZickQgPH+QuQ9KuaxrRjZMuFoh3ReeHSao1LSAmC1OQ4KVU4jEkoanTVnjMKNbPr1gL0ewnHNw72V7G6Ki7BYT9KQEsGXTPHZ+8M+5FMCf/R+F4z271o2ZnuwJRAJHMkI5jrw31LMpgBlGqADr8U7BdLuFnKLaCdtJnItgw0/lhzOxzQWf7kbyx/ydhV0ORrfMbdVpE5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Sun, 15 Jun
 2025 16:03:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.026; Sun, 15 Jun 2025
 16:03:55 +0000
Date: Sun, 15 Jun 2025 19:03:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net 1/2] ptp: fix breakage after ptp_vclock_in_use()
 rework
Message-ID: <20250615160352.qsobc7c2g3zbckp2@skbuf>
References: <20250613174749.406826-1-vladimir.oltean@nxp.com>
 <20250613174749.406826-2-vladimir.oltean@nxp.com>
 <CAO9qdTE0jt5U_dN09kPEzu-NUCds2VY1Ch2up9RoLazsc1j49w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTE0jt5U_dN09kPEzu-NUCds2VY1Ch2up9RoLazsc1j49w@mail.gmail.com>
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1916c18e-3a6d-4d4a-54e1-08ddac263af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpH6sBVt6MJPC/UHjor6iRvJsrgqCOB6ZPJyqLRMWkvUINv6b/2Oa+2+3P0U?=
 =?us-ascii?Q?AW660i0JNLVQx9/j6bjuTJHmQWbb5BYSoZjI7dg8OEn8GvSfARBfswuRKHkK?=
 =?us-ascii?Q?gSvehLL7k5HwL+O9TI/b3bqlGqUE7DQO0mnvaoeysUwiZvZQ8cSxY1nncfly?=
 =?us-ascii?Q?/fKXfv1zwn1DYp5K5dSZEDrt6TBOxr0+OVAQMz2+8iYRjuGKcR0aIdqrqNS7?=
 =?us-ascii?Q?1ivMppQBMJ7p0dNV2UHvv37c3NwEs4oQXZwTSfHY8ESJoUmBvSgZuw8/duIl?=
 =?us-ascii?Q?9fd7rGaX5AlPBcSMzJ4cNpMJDl/LD/G2vETY/0Y+s1vZsC4LnYwC0t7VON66?=
 =?us-ascii?Q?kMsJoZ0A71yNMnLqm/gXSVmVFICxlCoHFOgRJZ5zwLppGw7/6O8CKxBDlHT5?=
 =?us-ascii?Q?GB9TMQ+oZX0LFkec6CzsIQOZPPnJDRJC1flec/ODQhkI9ttPkYASZPyboTGb?=
 =?us-ascii?Q?p9g/juhbkL6UWOML6Hvp7R7wDtfwrdZQW7Ylq64kfuk6ybbTuB6Vvl7JiBwv?=
 =?us-ascii?Q?7RuwqCbIjWcWFe/YUQwZ3kwAti+J1AIuyH042gbNl7WMT3V4d553/y6yvTfT?=
 =?us-ascii?Q?RITBeZSlQYAiSQcA6UhcysZ/SjmJQ+A/ItX6Ql1Z2hrMeiq67E3PmpvptjeA?=
 =?us-ascii?Q?wZbsbSDtQ/1hj6qWrJ0A2qN8AEBXijXcmSA+C9wFGUECf7vAlPwePSVSxs8C?=
 =?us-ascii?Q?XTD1FymnAtIudGaRVe6++Iug8cTy6XkqUQIdMSZiSbD+rZkKsyjIn9niYgry?=
 =?us-ascii?Q?lPyeuOA0UxsccSskg3RDNY34k4tKu6WEAp6ITWn2LkV0dL13T1wWFlK2Kc5B?=
 =?us-ascii?Q?GCinxyLoxxXS3wi9yazwN16ThNfpTtUlxxltbiU9nQ4LevcRpH9mmFzZu/tC?=
 =?us-ascii?Q?JxpZYTSvSPvISh/ttR8B9vJP/lWnS7hTevLbysRWYIlUPQhGc9sLECRvykYI?=
 =?us-ascii?Q?w8HZJ0u2Ola/LymkzCzwv9/vAVG4CUWmaPEgAJL0QmUN/jg6sZjyrQ8kuQau?=
 =?us-ascii?Q?U85wpeVGEkXhP0o9jtzWIg/iGXOf5opaZ2odQGcGCuQAJUZUromjsvZYWTPL?=
 =?us-ascii?Q?zA3P7YN2KcWVzg0WZf4vpgm4oVN2HO8iwF6gTEzK6+z/w+YIIcrQSElyfZKZ?=
 =?us-ascii?Q?51Z1r4LML4Bu0AW2gN69lLYX7sdONedAN2kXqVYU997Y2ngRXwRo+nchZ9Bj?=
 =?us-ascii?Q?+ClRtjou1ubJSUdTov/PPcIUpPYPQMdr33SxrYtPZal9pzG8xXPUUAVuZLbA?=
 =?us-ascii?Q?MgECGmLree4gk+KJ+0HFvDlV0fn1lUyUDygY4pNIr7cKK54qHxrSQh5RLV2c?=
 =?us-ascii?Q?BE5OtM6V+zGX5Ctj3KHGQETHZmqY10r+YdQo+N7Z0ei92eJr0ig7OV7Coydt?=
 =?us-ascii?Q?9dN+uF5VPBJhRNmecFMQqjknu+XYh/xQpW3u52nWOQLgwaeFfThRJMR/uZeq?=
 =?us-ascii?Q?iryUVWiGrtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63fmyHa1P5jKxA91HBcJRxy985G6CiRtR6kJvtjo5Gmy/MycGbpvKu1VUP1B?=
 =?us-ascii?Q?I0J+dwrmCMQAgvzDF/L/f23esD3wvvTYW3gULzZXdtoA+t7rZK/E4bGGdmb3?=
 =?us-ascii?Q?PABH688Xk7IPCeTZR3TTIj4O/VLWrVqNcphhGNNMp0DTeUqcU4fSuXD0xJXT?=
 =?us-ascii?Q?BzUlnXS7mr3lt3bjVBVhU4+u09CVkNutUTyv/BHKyaGRcWiYNNDutPRJwb5l?=
 =?us-ascii?Q?77miNSZ8PWAVwnsjzV8PovfLbLTVaww/DzyE7Uqb4Sz0vCr53av87dkZY8HC?=
 =?us-ascii?Q?ywe65tV2tcU0oweORvU8TJDnGnB9bDvU6UDT5WU/xPYu7ajDRbYp5fV9T0VC?=
 =?us-ascii?Q?WfhzX1eDKIYAYRjKM2uxiPKXo8RO48qV8PZ2NNcHqRhJIIDAP18iVIUp6OHb?=
 =?us-ascii?Q?tBlywXtT6EM2gZszVTR10gbC4nmhejWdAxFmReavc1xL61zBCMWz0F/3B9HZ?=
 =?us-ascii?Q?HveKYhYCbBky8y4kYuCYdQUCC9GfgWy5KV9dOlGPU6X+3TFOjVLVXlZXcbTi?=
 =?us-ascii?Q?2nzlb1YSwjOnbNDBy/jcWyrLxX/1ERWzrS35iO9olSwY5fEJ659LNeUqaK6F?=
 =?us-ascii?Q?1GrTio0BNFTEsnssVfH/cOk6bwrKIsa21bAqlPnklvCs8zmnRWEWxa8CBliE?=
 =?us-ascii?Q?337uaH0n4d3wsbB4kUW6srV8z68FSzB9lOxqe3nD4qYzi4Vi4jJHfPhfhnfQ?=
 =?us-ascii?Q?usLe0unlBnCDI4ju+pG3ds2VuoWSkc7IFrfzf8suG9cB9rsvttlnyWTZEIdk?=
 =?us-ascii?Q?nlm92m7ngQVZyBd/j7yGC2ywMgFXsE1BJnnYR1QR8s824snRElm7zxR+8ftR?=
 =?us-ascii?Q?8bID17dSoNVT0Fkgu332NphmEiB9S4fsDkDeYMDe3OE70SD86WX75YjN1bOi?=
 =?us-ascii?Q?F4KC5y9lmlW5hZjIUfvTPf1iFfW8JYm9LF90DMPgJFH7m1z2UaXQ7Oi+2tj+?=
 =?us-ascii?Q?x8mmIXqMR69NPOl3l6ySYZ1clKhT5iy4Zo22/YTOBUFRgVqJCxhflSXQO4E7?=
 =?us-ascii?Q?fNagAhAHw5p4rf8IXcWTpC09ECWZPpwy/i9afkLkODLEcjyOiYnK37OogFqA?=
 =?us-ascii?Q?+Na6G9/AoKo/8jXAYLiD7pGnqvw5T7GalmJmMPJhummgPNpCG+h5qOfIM2hK?=
 =?us-ascii?Q?whhwQcueCi82HgLgc2qn176GLnes2OQ7G5AZdo8Nrln6hjonkelp3ew4D8+7?=
 =?us-ascii?Q?1UyuqHXqOR0dvxFwUiVyuF6Lcbvur5V93PqO0uYpu6prDxiHUTF5vFkC0B+0?=
 =?us-ascii?Q?cTiygipD5mJUYPoxC64xZJ5EFgFPjQHrb7g0oZlk/Q4fRdg/R5o6AQQ35/T3?=
 =?us-ascii?Q?j2Lm/eV9+kznGVOmMdR84K9o9HjRF1Dy2Ud6vDL45zdfYw7Jki7HOqUjdZja?=
 =?us-ascii?Q?RFUH5eOmIUKm3jbpPkSvTHoFHEcHANnzjBu00QMD/DSmUz/WukW6Mok37mTp?=
 =?us-ascii?Q?OMA00Tv5q3ry7J0LZh4g3Ed5LvGF7Y3pHLEM5SO0xNhBglfjf5c/voCrjbYG?=
 =?us-ascii?Q?kwa37MjMqO5eu280nWBsKQJR81BSeXJ/JeJpSeuXH295CaDZbS3XT35G9/xD?=
 =?us-ascii?Q?cYI5NNhnFO/Jtqoh+4XweQAmlrTsoNud+NZWqS8mqdsH4nS6ANB37Ywb9OJM?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1916c18e-3a6d-4d4a-54e1-08ddac263af8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2025 16:03:55.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ctnzdJQFQvIM1EdbTcfQ8Bzk62f6njthnIC5nLJQ+wbmbAV0n5WIDXy9jhU2dbkIoupwKubZcrDCjdOITxNyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609

On Mon, Jun 16, 2025 at 12:34:59AM +0900, Jeongjun Park wrote:
> However, I don't think it is appropriate to fix ptp_vclock_in_use().
> I agree that ptp->n_vclocks should be checked in the path where
> ptp_clock_freerun() is called, but there are many drivers that do not
> have any contact with ptp->n_vclocks in the path where
> ptp_clock_unregister() is called.

What do you mean there are many drivers that do not have any contact
with ptp->n_vclocks? It is a feature visible only to the core, and
transparent to the drivers. All drivers have contact with it, or none
do. It all depends solely upon user configuration, and not dependent at
all upon the specific driver.

> The reason I removed the ptp->n_vclocks check logic from the
> ptp_vclock_in_use() function is to prevent false positives from lockdep,
> but also to prevent the performance overhead caused by locking
> ptp->n_vclocks_mux and checking ptp->n_vclocks when calling
> ptp_vclock_in_use() from a driver that has nothing to do with
> ptp->n_vclocks.

Can you quantify the performance overhead caused by acquiring
ptp->n_vclocks_mux on unregistering physical clocks?

> 
> Therefore, I think it would be appropriate to modify ptp_clock_freerun()
> like this instead of ptp_vclock_in_use():
> ---
>  drivers/ptp/ptp_private.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 528d86a33f37..abd99087f0ca 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -104,10 +104,20 @@ static inline bool ptp_vclock_in_use(struct
> ptp_clock *ptp)
>  /* Check if ptp clock shall be free running */
>  static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
>  {
> +   bool ret = false;
> +
>     if (ptp->has_cycles)
> -       return false;
> +       return ret;
> +
> +   if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
> +       return true;
> +
> +   if (ptp_vclock_in_use(ptp) && ptp->n_vclocks)
> +       ret = true;
> +
> +   mutex_unlock(&ptp->n_vclocks_mux);
> 
> -   return ptp_vclock_in_use(ptp);
> +   return ret;
>  }
> 
>  extern const struct class ptp_class;
> -- 

If we leave the ptp_vclock_in_use() implementation as
"return !ptp->is_virtual_clock;", then a physical PTP clock with
n_vclocks=0 will have ptp_vclock_in_use() return true.
Do you consider that expected behavior? What does "vclocks in use"
even mean?

In any case, I do agree with the fact that we shouldn't need to acquire
a mutex in ptp_clock_unregister() to avoid racing with the sysfs device
attributes. This seems avoidable with better operation ordering
(unregister child virtual clocks when sysfs calls are no longer
possible), or the use of pre-existing "ptp->defunct", or some other
mechanism.

You can certainly expand on that idea in net-next. The lockdep splat is
a completely unrelated issue, and only that part is 'net' material.

