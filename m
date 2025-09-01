Return-Path: <netdev+bounces-218775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B8B3E705
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CB6205FD3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D432F49EE;
	Mon,  1 Sep 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaE6sPBO"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CD2EDD76
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736743; cv=fail; b=MAFIe6YCF6lNJ1yq3Mj1FPzJ2t86gx8y5a+VaWgkvry4pHI2O7j7hV9gU5YqayiO7jbp5YH95dM+3n3WFmmHDqxG2WkVO8uR8nimxHgvJuCQu5eHMKSxoT/b8IyvYB2r/UE/IcAwFmUeH3jQsdonq9BhL7/bjrG9qCV04kcV8AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736743; c=relaxed/simple;
	bh=urOZFkiP+uE+GIYr9Ees6aJ1nuMhQHufpJpV037o/sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Eo2YVpJsPszyu2hlIIAKKDljMeYzAn3kNhBxKtDYX/vBK7751L27d2DAeE0AtEuzJb0aFqCqthS4l7CN1/v1ncbmtwkPPcZoORP0Cuv3bqBOvtOkadwZipBRvQnAazQwzu5jib8vrlSc9t+tHBOYQoOlu8DamH3IuLR5tQX5aoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BaE6sPBO; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx2y5Jbsuv9gZQon/IgDVLwUXPBkS7IZtizwY6qj5YbnkyoWZ3vzrWKbN3hzenF8EkgnppcpuRW1e3IbyKOOeQoBFOzoUuvjE3fp2o5a2QXnQL1szy1LOLuE3xIEMEkK2xGDODLaoi3mrf+S1V0g6zMC0jRLDYn577MYUuOC5sSrPWhKIHddAbxBYACSDrgiH+MpL9IaqGdN9ngjAPtV/B+jswaxmh8pHM02x/8ZsTs1i+NmNCEV/EY3dgEAavrcZxfLvEK5dENDL8QhrfGpTMmxAwDT9bSkqPFK0CfyseDzNm1fzYahrUobRJvoG8Ks4kHG3DzfhSNtzOqfY9RIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tSzdMa1SF9/K/FZj+ghS3pjlENQVoDueIVlXZbAOrc=;
 b=GwAaga0neDylLJQo91MRcfcV0/EEq5o9NOIooAclMowxSPWpXRRAvm64L+Qd132cgjIx2pzOuXUhdJhDLYha5AYZ750GNMlhDZ0RXKUd1U/+kX4FBsBqATUGIZo0aX0WKx9dUnl1ToCx9bheHhG0QQsKa6HbpUlOvJgWYXF1bDtCzuuNc/Q4akS8gsy+zlfzx+UN70UpiNtwXrfk3gIVnzNMuPCve51NA64DlGN08ewy/uDdS9RM4NlayQl8h3ss5Ms0Hj0HEpO4ZxOpBxgesLGJyJlOmPeC9qFiGtZ5rNOFJa24/iSbqM4Csf4+onyiK213C1hFJR7Z68sMossGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tSzdMa1SF9/K/FZj+ghS3pjlENQVoDueIVlXZbAOrc=;
 b=BaE6sPBONu5/i67+lR6c2R0xxEZI6ImCh3xJLSIEpyXus3tbVHoG4U3xj4sd3rxUajyDFJkgD6By78Tj9+fDBQm80zt7hhS4yPkS5kJpM9566aOytchU/98hDl9B16Lxb1UCFghodl3vMHxWml7YEtjYwJb//L9tvy95CP0lEDmZ5JdJiqF1kuoSGAGz9P0CVBbM/sZ9Y/I0re9ghZKUPARPptTs1JA/UWRN8I7QKVxdmjD7Nqeu5d8F3XoNuxsAj9/tmVCt6wqsjPhvfESSCYVZRujXGgdUdyg1t367DtaHKvCnI7zmn1tGuF6zDzP24CkcW3AKWlIQz2L221ryXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10726.eurprd04.prod.outlook.com (2603:10a6:150:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 14:25:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 14:25:35 +0000
Date: Mon, 1 Sep 2025 17:25:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901142533.p6wplnjnsnfz2xrn@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
 <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
 <20250901093530.v5surl2wgpusedph@skbuf>
 <aLVwAn87GhFHMjEE@shell.armlinux.org.uk>
 <20250901103624.hv3vnkhjxvp2ep7r@skbuf>
 <aLWqWeGvMM350dB2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLWqWeGvMM350dB2@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10726:EE_
X-MS-Office365-Filtering-Correlation-Id: b7116ff8-ac73-42d3-1bc3-08dde9636ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/p+xNeI8heUm9K8UC8eRhGWkv50xJn2guipB4HIRbx7Axz7k3brgoOzoNv2Z?=
 =?us-ascii?Q?GDgau6E+Dpn98Z4QKr8OeTSWQgerjG3zHgFhuOm/TGr9fhve9nRk6HeZEXKo?=
 =?us-ascii?Q?IyMY+p4BrN8U+n6nl/Nd6H7V+VXM9d3UGdeGfbpxquxDZfERp+EW/qvkJzrT?=
 =?us-ascii?Q?/i3WzV/tFSxVGVisTMNrZRey9wNH9KuWyTX/X5fm7qHo5QoY2D6r6HWrfKkm?=
 =?us-ascii?Q?YzQQrPTZBRN0vth6rK/8TlWBay5NEzKfun97OmaKsZ0YtL3nJXabytE1ecT+?=
 =?us-ascii?Q?T6UP/3Y6n1vFWt9mNjYjBBoZdcCvAc5xo7NI6GBKlSaz18nBp+2WXBmFGy5W?=
 =?us-ascii?Q?dZWJH4qaMzfwX+WGw5fyD1xJycYamRAcROHmw41E6XW4VeKLLyiySFJkMw8D?=
 =?us-ascii?Q?as73PEqcoYWGjya6OmYTEy2Rj1vTpCTHsSDJV96ecfZOswauCe3DDbaMQVuK?=
 =?us-ascii?Q?gcRBQKlRxrzpRlOgDNe5tsgSWBP2eOZuuComE+1brrO2Mg/adkNqUyYP+oBt?=
 =?us-ascii?Q?1qEtpSIdKcC/GOr7OoJ2FkzNlBHUKEIbVbeJMh/QGbZ028OEVRmiebvoFdYy?=
 =?us-ascii?Q?3Q8rVwl5rGSXwd2chXG/tnZw78PUzjYFgOZXgnqih660fN1kFepKJCic+VKT?=
 =?us-ascii?Q?367O8eyMyrZ5+KqWoSIeiMdxIVa/NaNsBZSc04TQ075/9k3LXeoUBvKIz7Yb?=
 =?us-ascii?Q?IxFX+vTeC/3nvs68U5eK/3ZypRAY/RFCCrrMBvSF10VhlSC+uOTAC8V35gb6?=
 =?us-ascii?Q?2cI3YCbiPhbFaVyVRfMq0GQwYQFqDhfgNCsldmloZmBqpW6RFfJhtY7Y/5am?=
 =?us-ascii?Q?0TLBIAxzZFysMQwBUa1pzlt8vtUx11O3q17UUbnbP5kRjFuBjnSH/+PdxkFQ?=
 =?us-ascii?Q?ebngjbarZBlikpxe0NL+cxdtETCF4zxQOMp5sYdkfdap9hNGEi2VTBnWSNzO?=
 =?us-ascii?Q?1WefHOMg8cXhyc2/DHDA23xV4jhuY/+PlW/NAYwTt+E9ZycYNPhCEHFjWGZv?=
 =?us-ascii?Q?7upBpYi4VJpN01NKUgG8I2WVSxlWYEJRCM+xN5iytmwkuxoblSVk4wdknAkp?=
 =?us-ascii?Q?2FlLd5K/BaRXoCc5gZmlvibPyRqtCjELM7Z28L/OI4XqnCERJ+sYw+zU1yqY?=
 =?us-ascii?Q?D3c1zysDVFNr1SAy5r6OBzDJMDo+nMQxn0cjBjHSmI4YlahhQwotdoqe1NrZ?=
 =?us-ascii?Q?XXIATHfLMttXCiJONsn+eZ0PhSHlOmYQC0RYxCBr6PbwRd7B9WrqX4MchRj2?=
 =?us-ascii?Q?gS/agfGXQhoMAYoyFBcICO2tW/N6qaxvC+Gb/NgOylblO6710/VNNISbprX7?=
 =?us-ascii?Q?YV2mLx/P7uurYITgoheVG8QxXBgfrhcWuhR5i65Lp+Y1jdz6EUEZZ2TU0yUg?=
 =?us-ascii?Q?Nnh47zvwFU5iatGeFJab5oOV1P+s05Ne4BvB54XW97on/Oig0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pm4m1EK78KanEcQKkJX4sjgCH4AGBfRVEjNE2TZ7+SavSWQSf3lq+6LBuaJj?=
 =?us-ascii?Q?9YmnPUw9045T0bTJ7NBnd3P6xaEcm57gzqUM40GECrMcW8irHiPeSxCO9IfR?=
 =?us-ascii?Q?ufZNkmEu9rFHFIQHbUNkhcm8GoW9KaUzMprehhF88oMI6sVPJGO6bLIo4I6T?=
 =?us-ascii?Q?/m3uBGLQlUPlbSSRA5ikhY6VHzWVowJVMITKuIjYQEMnMa+4cz8Edcf/IEa8?=
 =?us-ascii?Q?+IgAqFBXKU22cww8dG4/+Hub3qpnNWto5ZvgTRFHazx5usT7P9xBNvMueeEQ?=
 =?us-ascii?Q?115lsZvR0wU8VNvAn1bvgmnXspq9RmuNBkm8CFrOGs4f4857c3GIwxnYUzbp?=
 =?us-ascii?Q?W8pVhQy2pWh97nlWO9KPLly5a8J23wKMvv46teTDQIi791WBCgMSXzmaO508?=
 =?us-ascii?Q?MDYn0nYrRNH9uPsYMS+mHfCItLV96bTE59qrkJDvFJp15Tcsl0JTcUInreCr?=
 =?us-ascii?Q?LHF5XD2djQIx+ogT7Cr3ay1YBn9HHQFzdcaJpMwEiIJJrRIm1ScRFRgfPhTY?=
 =?us-ascii?Q?ugFWErrnfiahw3Y4Obg7Iq7HGrw0/yJ39IsuEKRyfKH/gkiTPhGJTm8HNVrJ?=
 =?us-ascii?Q?bS5MB5M8tLc7+HEoyjWxQlPVuNiK3TARR5emc1sOQPMsl+UIR1+rhB5AJi1i?=
 =?us-ascii?Q?dzgrhwgNG4O7x0FxK80O9sqTQ2aKBp2HXL3EE25xnYdZlnxLQkWYJi23W2BX?=
 =?us-ascii?Q?zNqoXrYvMAbPOEstmSHgmd193lRcn1NQxOtPjgHrtlkLy8XrbVXpljbjS0gA?=
 =?us-ascii?Q?yjMKI+JnQak36BOC98FRozc5MZBibaThzc/dEx4bWrWIl74vmqtxQzrHm8BA?=
 =?us-ascii?Q?L1ROTpCCA4P68qAG4ZSh5YMPvPjrzVOjAKCWo+GvCC97qAPjzVSQoxxoyxky?=
 =?us-ascii?Q?/Z6N0fHexlIHiBFwnSbqA0JuYgvBR8uP6BsrFDcTVPYrPXkCjrdB0kY0aiMj?=
 =?us-ascii?Q?OfNWOcyJZ/9ZeSulV/NdkdWRha5N1Bc4jzVfEGzKtwHU+zk5dIGTbxrQWjI0?=
 =?us-ascii?Q?S1G+DP1dKG5COAzRp5XK5IuwbwTuXLKEsSYARS8y8ZEUtF6tTru6H73/cDWI?=
 =?us-ascii?Q?1Vfl37xNH3kFVUbGmukkjPS3zxD/n/mk0dgMJFnWoEd1mg9rj9yNLZqrPmRm?=
 =?us-ascii?Q?AbPMzTet4WxfL5eQL65SzE3khD0LwPeLXtEpNh2VWZuD+RVKYjMqKIl4BBGM?=
 =?us-ascii?Q?kVvSoq1dGVaMeL7uvbVKNWoniup3cWZPH9F3sprOGys8IzMqgYzyHQ4J4CwQ?=
 =?us-ascii?Q?W1XCQZH3xnJhvpKECmGJcOIV31xUvr5icj2ZEvkNgJp0Y5Yk64d9iWqmUXw1?=
 =?us-ascii?Q?SaWpFm2cKZzV62df4DOQCQ1Wr6mWohGjK5XbPUnoPjIC9x+rDs48go8qQPvD?=
 =?us-ascii?Q?Oi46XEqMOVpb4JUjV5spqapXc5ZbUkdHU4C2vbr01+rW+Yy3CSxXLQg4j/ty?=
 =?us-ascii?Q?oZCXOKkYpJg+c69KqTUrGVGa6O4NM6S6m38j2Dn2iA1L+raLpy+0wwN+EPUU?=
 =?us-ascii?Q?E5GvQuMGGaH4gtQlUc40Esh4IUoLmZX78b/h/tMnh4BkYvN74LHVim9T9PLj?=
 =?us-ascii?Q?MhPSjHgS5EPEiBS0e1St7bNxnARzM9065baxC8VuFCrNhBMqFgwMGQa8Pyjq?=
 =?us-ascii?Q?4GVZmt3sSraT0AelFHmkbWdz4H2qopphYBGvh3AGSbZhoHgKRP4hFR1l60PV?=
 =?us-ascii?Q?AuYQPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7116ff8-ac73-42d3-1bc3-08dde9636ab0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:25:35.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhxUvoRulbYeAhZSuYou79ykKnQmYoABOomFfIFkEOpkQx8arUE+fOuPxTPxHPWnrSTLQzwFwEvyolWa9vUxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10726

On Mon, Sep 01, 2025 at 03:14:49PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 01, 2025 at 01:36:24PM +0300, Vladimir Oltean wrote:
> > The new explanation and the placement of the function pointer clearing
> > make sense, thanks. Maybe add one last sentence at the end: "This covers
> > both the phylink_bringup_phy() error path, as well as the normal
> > phylink_disconnect_phy() path."
> 
> Is it really necessary to add that level of detail? phy_attach() sets
> phydev->phy_link_change, so it's natural that phy_detach() should undo
> that action, especially as phy_detach() is phy_attach()'s complement.

Well, it shows for future reference the code paths you've considered
when establishing the placement of the code. Your call whether you want
to include this sentence or not - and it looks like you don't want to.

