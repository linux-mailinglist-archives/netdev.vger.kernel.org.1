Return-Path: <netdev+bounces-219209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E824B4075E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08561889AC7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8EF3126A4;
	Tue,  2 Sep 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUKVkxOh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD84320A2B;
	Tue,  2 Sep 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824170; cv=fail; b=R5XqXoCq0cN5ZIyo10zNfx5QzFRehNG+DughyvRxDOhyWxIF7nw+4LaoZyO3kY2o+AwPzkCFYfIq7Ef9i5R/QHkyBH9E7N0SavupNd1bNQVM3YFrSV4nDFCAf77vcJZtNR7Xh0YHOVU+xAiQgdNCeWP3O6INBEFgV1+0Klh5ZNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824170; c=relaxed/simple;
	bh=b2namDmUWHgrFVeuZKKPr5bICBkbK4mmFN7EE0KFszw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kArpdVcXKiXEu9vqnuiFJJj98CtRmGzogwWl+GNaEDXsqoEYKGJXgXQ8LKhW5lFvMO4udMzi9LxsszlvP90AuoXQZ+2W4DieXoIyzaEANROzFVZvwVlsbHRDav8jNuuTJgaErelFjcJAs/82NCGxUBNj2o4aeUAi94hqvFf+oCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUKVkxOh; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbZuL3VuH5IvdHCza0pvzNWnlfX8GF3lSurmoJJ4lOgg5BBCHQVg+5n+VXTIeps6QF9345xSB6IvjAooYN3kGRcnsg8DITA1cd5k1JkWPDyg4ynBO6KKsU0BBFXqS6E1OkNYPuZ4Y2g0w1kYV6/nekQ6TiArj36N6SJTJmfL0qYRbrAcZICfaFHrbn2qXDshh+a2hHjFnnKA92dSOt01oKnzVkY8RkXlCCmKTHYdF481yxJC2PLvl9EbiNfC8S1uMxplUU8Q7qAYbiBljEw+qz7f7BHW0yIDCZT4hA4CSJ3Xjtv3KM5jkc5QDCrx+lbYzUeDm01i5fsVggEEhWQmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9gRbI+Y/7oIcLTySREbWfwm0eQb4ZxZ7lHHy5Gy8z0=;
 b=Ziz11hSurLG9WgytP8bt1qypIDHn8Bug3F5UThQvxIrxSPMJhdHlqmRkRoDaH4qG3rpnVY9hI9VhHSuhyIclm0dKT3LfInumjOM2mIRPqBE7x1pe2LvaFAkcclggmH/OcuQ93KvkCae/ikZCw6aExzF7UzMIf3T72JXdSq0bVPhob1Lts93l2IRLLQoSbbQ1irSWuxT8kh0LaMnKt4lc9lQmBgaslX/0Y0LoCjTEiOJhaIHJ8KuU2M1wO9j5BsclKXew+r4x4Q5hcHtQt0KvIYA4EGrnYRJPsjvUN+AK6c/5rpC+lf1hdJoYH5tX+mEAnglLxCpx/t+BL8VFBmxJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9gRbI+Y/7oIcLTySREbWfwm0eQb4ZxZ7lHHy5Gy8z0=;
 b=MUKVkxOhZamxtLj7EIdC7hezIWlhWX5oqOmg86LMZkyIiEXgtZxvwliheX+L/slMSbN/IYkMgJCjKmeX7ok70E1EFnRAOHb9C4Ye/uHznH67TCWRqe2EFAm6Boursm+ZYxCXMQ3epoROORwmc1JsM5Ghnh9ImwbNPBXy9Uxq9S7Nl5nl3p5DjuJzYtDVrWoFCke99FKbcXjdNbiRnDmLWJF7eC2skzaAuIISNncpV25A+yb4lcuqv2v66JXA/WOfyTtxFqrizLaN7TIoiavEOws1wHqbqLknYf5zh5MaLyzAvrfbGic3g5UFP+jmXdd6y7OZ3RnC/Mz6Khs/VSOGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB7078.eurprd04.prod.outlook.com (2603:10a6:20b:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 2 Sep
 2025 14:42:44 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 14:42:44 +0000
Date: Tue, 2 Sep 2025 17:42:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] net: phy: transfer phy_config_inband() locking
 responsibility to phylink
Message-ID: <20250902144241.avfiqpmqy7xhlwqa@skbuf>
References: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
 <aLb6puGVzR29GpPx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLb6puGVzR29GpPx@shell.armlinux.org.uk>
X-ClientProxiedBy: BE1P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::6) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM7PR04MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a73a616a-a9d0-4b49-a1ff-08ddea2efa31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7fIVu0C2a+VOQSdaCLNuRKy9jOkNrN2gfaM0irIsaNduLCWFE61YvX1mMlyg?=
 =?us-ascii?Q?n6WJJFG8zTpXAwKA7YLHTQA1iaMjjr5iHWu1jh1xzlonsTmgPhfl7bNXr4Tz?=
 =?us-ascii?Q?0plzW7Ys73CmItc2RxGpYc7Q+KfCLBjGuuqTBqPVdUuTDD4BghiIfjpyCqQf?=
 =?us-ascii?Q?Ex+IYjRv/aJkdSs8FHJgJpRk4qBBnFzMrVlkvPkr+3zrjw2fBH3VMM7pu7u7?=
 =?us-ascii?Q?etMFOiLbul4bQbPcxn9z1ByepTwHNsdtdvJ2O+WeIfYyMLlWpOzjxuXc9+Px?=
 =?us-ascii?Q?9zpiZNp6KhT3YzlwSTbk9NMEFCxKakEwPoQDm0QI5aMIM6StdfOWKYhhMmHj?=
 =?us-ascii?Q?lV+2ngjddxVit8ZewevDNDE0NxrKpYU0IYSMOZ5jK03dfwB0Igab3cwpRDeG?=
 =?us-ascii?Q?Km8wMuidp2ZjoqDuIdkOaZIi5/V+RJTJl0jhdvZSin/wg8NHuUdyaLAQzbFk?=
 =?us-ascii?Q?q/C3l6xyzDB+kvcJkiqjiaSsE/Uf1q0fviMqxkdh8PzsZiWZDHtcrFStvbgd?=
 =?us-ascii?Q?rfBGDzI6QQRzFhnPC16sEfvICrAp2L+XwlJkXy3/17Uxg5I0zyQM53Y+bxVg?=
 =?us-ascii?Q?eLpFdLP4jM4VXVa+J4hk0GsfIfykSn8eTSdKishriYKc8ugwixN82F95X//q?=
 =?us-ascii?Q?T2F3xAi0H2EK30AHDcOSZ9tuYWy5RzizXcPSC8fstY3BSWnTsOBo3+YFrmhY?=
 =?us-ascii?Q?9FiwQtt0RMV1Ex46JtUjIcLoZjPvY1TNnq9hMZjg3o+Vbltna96XGMa83kJl?=
 =?us-ascii?Q?a/FGYHPaLrTnq593i2Z8W76Z6oesrPPqFx2QTezVwq4MMgb8DjvRVSdUujxx?=
 =?us-ascii?Q?/bPPZXM/dIvHCaKRSvVBzl+A8guEiBAUJjojvya2Q12LiVf0MoJiR/rwKeYR?=
 =?us-ascii?Q?qm+EVMed4mwyLrliZi1t+1SxdEmt3KwmpmaAFzmNyLTif2kORgxF+DvU72vc?=
 =?us-ascii?Q?aPZZOQZmxQqegF38pjdtmO9f/4nWl7mKsbtsJYlNpktSfW7yMeGPiIyNuo6b?=
 =?us-ascii?Q?7pYzZpHf6m8UXN4et3GDZxReAgieMwgFTgP+p0ujqDIAkQX96H4ygh1UFQ9L?=
 =?us-ascii?Q?Bmr4PwAiMEM0M9Sd1J3//VLEuYgQQQ9Svd0NlKFMW2ZVNdRQXnRXXFUydsoD?=
 =?us-ascii?Q?APJH1J9uLTF1qq6Q3aG5BqF0ZyZrLoNQ0dpsU8dJYf5sIiFJFLImfuXsvwMV?=
 =?us-ascii?Q?qeQ0O/NdI9W+0onqL4f0Nhty/pLAjiTceobox53AQY/HU2uXfW5gdrPYblW1?=
 =?us-ascii?Q?NScesMLFoV6ty1PK3yma0x231Xe2a+9T3n1VaCbTGcLcGj1bI10Kn1D5U40a?=
 =?us-ascii?Q?TDlYaNDXmGMWdyvHUBkCeIiDdNR0cTFo2Sv8gHMaDoX54t7JtkwRsJInQlS8?=
 =?us-ascii?Q?R/WM1M52gZwo7JCk+6pRWHCLG/Y41CoAA30EsFDr8mziGB/CNOZCRQxs97+y?=
 =?us-ascii?Q?y/OM6vTS3vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p15tyjNOEn3Nf6hxSOwPxq4Ai9YEgEJGd5/ZUxu4gvhYTn9aJiVy35tfEfAX?=
 =?us-ascii?Q?r+5XdgiTO7uXXFY3xlxNBQwdbx3H3SQl8wsKEKkKl4ng1TQX2sbqC7uta1Iu?=
 =?us-ascii?Q?4h6SpzCB3cAJve4CrSXh6VtZrzgNgdEof2n6DOOAR3wo3gQFr21K7d4X6oDH?=
 =?us-ascii?Q?qKqp3r5S8AM/DkJ221K6W8qlK4CvhZMiG9ufvR3BYvGa7DwjzUBPj4JwywF6?=
 =?us-ascii?Q?6RGMryr0zaL4BnHR5KmYMru4xw7lcwYo3cPdeziZyBCSAAy5uTihCs/bU52T?=
 =?us-ascii?Q?p6NFDQad+9hVA5Pf61Fw0HkZbLAXqVoI7+sA51JFm7BsIBK910SMCh95dqzM?=
 =?us-ascii?Q?6AJvDYc6GttYrq5HyvvUV+ZPhXg1li/TVKrHfxn6Dtk/UQikqeXb1GfFC2IE?=
 =?us-ascii?Q?zDLbFEQdc6S4iHfEm48LzW6l5Nw84gKyl0odO0GrGNfdTFn63+OBVbN8U+3X?=
 =?us-ascii?Q?M2D5WNOjqcUxwoUw+qeNwtJHSz4dBnACfGDJs9Z14BG2vmYP197T1t58RF4v?=
 =?us-ascii?Q?u3SqbzGm//OXYnvvensZnKQ5hX0nCDJln8AWT74zZgJPjVvLlR9MaaQnL92E?=
 =?us-ascii?Q?4FNWc/jYAayqxxxceEP7F+Cwhj9xLnyisuyVmfUmqmUkjPzzFv8EOf/wTw5y?=
 =?us-ascii?Q?7Jxq//U6Me8cNzR1a2pkis49FzIGWkwwKxCIOrPN7xwdgpyonK111z6JAEky?=
 =?us-ascii?Q?RDZ27bYkXn4PMahLX+IYURsQrFMMQWB8SWf7d4cv3ICMPSUJLl1bPNZ2hhS5?=
 =?us-ascii?Q?8hKc9fT3b4/qAzyO2U7h3moxnDaI5DIjpL25/mnl4M0TKBKj/1U/wLcHh24G?=
 =?us-ascii?Q?aZTYcZKMYUBmiDciXkxfNjRtNwMKzSrKxxZvIPRYgFoucSCbYN4ExA/mXJ76?=
 =?us-ascii?Q?riVyx4WSqw8eNm8WVDPVuXNbbe9K/0xyTJM23jXk6HP/yOY6sRZZHrwkRUix?=
 =?us-ascii?Q?VtNnt4zHvgTA0uXKzaMzIn935hU9y/uZbWhC6N+l65WTIK39Xo7ZDM3qlpmo?=
 =?us-ascii?Q?8yqLroF71Qs5u4Au/xJfg1A3RkVG+68Os1U/1GgTU3wIPv4EjEbtMyM1DF6Q?=
 =?us-ascii?Q?dhrk5cRIuMUyk5v8XqMPnjIihXSqmVUzaBmKyQJ2BEOa8YUYH5THAHVMVwa4?=
 =?us-ascii?Q?Wpf8F5cM13iLuW53nc54Q4RMojYs6fQGVxDSA/dLgm2aROO5Cd5/84ai2fwr?=
 =?us-ascii?Q?rLX7Dylq8cLL0hvIsZesdzQfWGV4qsyFCK9bCubGUGzVHFCH8wxFcr4aLvoe?=
 =?us-ascii?Q?85sdWlHoVa38CT3JnjwSxwb5kGvOY32niFLFfECGYya50aiTXRnWjnNTdflC?=
 =?us-ascii?Q?Y9VtkLfibE2mrmcgE5m2fHYhOv4aE7q6whQ08ilPfZH8lVf/WhEoUh/nksf0?=
 =?us-ascii?Q?FEq3VTXO5vjShr1t7la39n6DYidYuLOyLxCC0RQOOhwi3zGmp01drKr8LpfS?=
 =?us-ascii?Q?KZKLju3XhgV3I0tWyKN2NWWEvT1ZFWunMIaPUvCpLYJwW9JkhjLTcP23P7+n?=
 =?us-ascii?Q?AEWpVvQj6wdYzlpiM61c1kGdl+tImy1MjZ/zF/T6Gb4tBUsVGRTQ/vn20tua?=
 =?us-ascii?Q?ht+OkzeUFFyQzy59Fk1Jv41UWwj3GF8wcU4R+E+1p+mCV9ArSmuXPu1pGRRw?=
 =?us-ascii?Q?tKhasmTOkvQj1XXxRUPoz1jrAw+g+qbo3MXfvAb/NHcq6Ff6hfykIPinat85?=
 =?us-ascii?Q?9z+/Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a616a-a9d0-4b49-a1ff-08ddea2efa31
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:42:44.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCLm4le2uJiY6UbWVU/FffZS2nRtqmFkDsG3s7OpyuYl6gCUJ1s17ONAtymLr6lD/AkdBPsjCjzRna6BYfFzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7078

On Tue, Sep 02, 2025 at 03:09:42PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 02, 2025 at 04:41:41PM +0300, Vladimir Oltean wrote:
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index c7f867b361dd..350905928d46 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -1580,10 +1585,13 @@ static void phylink_resolve(struct work_struct *w)
> >  {
> >  	struct phylink *pl = container_of(w, struct phylink, resolve);
> >  	struct phylink_link_state link_state;
> > +	struct phy_device *phy = pl->phydev;
> >  	bool mac_config = false;
> >  	bool retrigger = false;
> >  	bool cur_link_state;
> >  
> > +	if (phy)
> > +		mutex_lock(&phy->lock);
> 
> I don't think this is safe.
> 
> The addition and removal of PHYs is protected by two locks:
> 
> 1. RTNL, to prevent ethtool operations running concurrently with the
>    addition or removal of PHYs.
> 
> 2. The state_mutex which protects the resolver which doesn't take the
>    RTNL.
> 
> Given that the RTNL is not held in this path, dereferencing pl->phydev
> is unsafe as the PHY may go away (through e.g. SFP module removal)
> which means this mutex_lock() may end up operating on free'd memory.
> 
> I'm not sure we want to be taking the RTNL on this path.
> 
> At the moment, I'm not sure what the solution is here.

Rephrased and slightly expanded: phylink_disconnect_phy(), when called
from drivers, has the convention that phylink_stop() must have been
called prior, or phylink_start() must have never been called.

However, when called from phylink_sfp_disconnect_phy(),
phylink_disconnect_phy() does not benefit from the same guarantee that
phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED) ran.

Correct so far?

Can we disable the resolver from phylink_sfp_disconnect_phy(), to offer
a similar guarantee that phylink_disconnect_phy() never runs with a
concurrent resolver?

I don't have a local setup at the moment to test what happens when I
unplug an SFP module with the change I am proposing. I can test in a few
hours at the earliest. However, there's a chance testing won't reveal
why we don't stop the resolver during SFP module disconnection, hence
the reason for this possibly stupid question.

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 350905928d46..a8facc177f1f 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2313,17 +2313,13 @@ void phylink_disconnect_phy(struct phylink *pl)

 	ASSERT_RTNL();

+	WARN_ON(!test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state));
+
 	phy = pl->phydev;
 	if (phy) {
-		mutex_lock(&phy->lock);
-		mutex_lock(&pl->state_mutex);
 		pl->phydev = NULL;
 		pl->phy_enable_tx_lpi = false;
 		pl->mac_tx_clk_stop = false;
-		mutex_unlock(&pl->state_mutex);
-		mutex_unlock(&phy->lock);
-		flush_work(&pl->resolve);
-
 		phy_disconnect(phy);
 	}
 }
@@ -3809,7 +3805,10 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 static void phylink_sfp_disconnect_phy(void *upstream,
 				       struct phy_device *phydev)
 {
-	phylink_disconnect_phy(upstream);
+	struct phylink *pl = upstream;
+
+	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
+	phylink_disconnect_phy(pl);
 }

 static const struct sfp_upstream_ops sfp_phylink_ops = {


