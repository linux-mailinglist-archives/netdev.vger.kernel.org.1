Return-Path: <netdev+bounces-232011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78ABFFF3D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 677224E574A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD6301037;
	Thu, 23 Oct 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgwBlZB5"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471092FCBED
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208572; cv=fail; b=uoxn/C/dUqn0MfMy4DVMkDCcgpAEGFRcAab7HG58wqu7s5Se+iGFeqeepDqVrC6l8X/uuwk1Cj16ES/nRb+hNH6KTNJpT8vA/gqX7qGOnrLslhhg3XcwIB2aMbxXoigFi7gtWJrLH6WnciWe2c9nm/9jnV9CbkMzmTKxTP3BRB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208572; c=relaxed/simple;
	bh=RrgU5MKTwGFW2/3qLd+71jDIahb1X0cd7EQsuxsv0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qfJLhlLeLkI5m7azmD4KnBDV77whcrCkikhRGXdag6q9VxQLJCHDiPSZTFpuju47ZKLbx7HR/dpGqIB7dk+y0UGpiwzgLqmfFiEFqFQ3YqG9hylN+I3ERu67MWQfxmh9Q8gjfHVxL5FXeTxiYqZ8tpmpkpd6uU4cE+vTmYYYZYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgwBlZB5; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajgSRMocBRAxWdVa6GwNqaYvONzU50es4y3TyG6XdRmcG+Q2lskq6CHZ+AtuGMGzgbyObk+BgEAReEXY4mi92E7nZKqFtx0l5kJe4EGC5bi203ogNT1bBkaJH6P7lOs7LEr8fmPG1FDgelkN3btwPWL2v6KI1X+M5u43W22LQzCt0ukijZ7EFARdWOdu+90Ud46725ZhMVU3RpaGNgkPE47sJkVuLMRkcxjzLUsiUYYnthvZ/xf0cgOHO2feJX3YQ9RDwaeZmqcQ+0gwVjtnImmfms+nxRqlBMu6ZVKcxGq/lSpA9At+eoMrilYyF0gxKcd1cKWZSRqodDjtgbctKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhowm+u0eGwBpbNLkIOHr5Djl/sWd9RyX2hbNn6D4ow=;
 b=o/rgP3k26LkMkFs4WosZkSDfUa2utYB08ZMjwP6u8jwR8sRJcLI7DQl4uPWFNIQp7sknxm9Sas8VNlAciyMsOlXmUET2UDBsd1mVL+wtCANW34YsNBtNznOGA5aMzVtw9xKgSYUPYgSC3MBVEvo/vkEPzgxBUMUo6g7pD5CZ/wPc6HfO3vU4MypmDUieMhwe3LEElIa2hWfP7xLlVn06pRWZ3NLutizOzqO1sNb3HLQHDrq/+hItKMz+olIXstc53zJRJX/lhrcY7W8Izqu592BQi3oCp6VXYt7d2akRZEtcvipdHVgmY5wEVukpOt1znnRuqiXEEk1QrnqGlFhdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhowm+u0eGwBpbNLkIOHr5Djl/sWd9RyX2hbNn6D4ow=;
 b=cgwBlZB5d+0YiCGrOiKrurdIac44OilZHrpKnhWahqzPZdDs5K7CFqt5Ei14QpbkGyo4BHfXbO0/CR21YZtgy1tQ1ptN5YkGAHTdhvvq5F6PmE5d1JUjoaNQ6oW2n9rgbx0IuouAofJtAXr5bpsdWo3dYnBLODEhMACTvZ2b71S0mXIo/xxtOsFc/goknAr3LEJQtPvKb3UsNV0Il+k8qi9gvsstRPz+WV0gBF6t0KkpjKs+OsWd4Kd2X/B0llvvItmx/sVTeAATuFBp7mORk5oPKLR0a6jkvZOu2nN5/mOKDmKrxiEkzBmBdiuf01HK04T6MNwuvAVPxLuqsPXGqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 08:36:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:36:07 +0000
Date: Thu, 23 Oct 2025 11:35:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, rbonica@juniper.net
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	dsahern@kernel.org, petrm@nvidia.com, willemb@google.com,
	daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
	tom@herbertland.com
Subject: Re: [PATCH net-next 1/3] ipv4: icmp: Add RFC 5837 support
Message-ID: <aPno7Zt2Fu1DapvM@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-2-idosch@nvidia.com>
 <willemdebruijn.kernel.2e842c8c31670@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2e842c8c31670@gmail.com>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c947f4-2d1c-4a24-24e4-08de120f35c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhPyCtNAaxAe8pyB6vOFmP7mimwpZehZaN4dLVyiPzS7WCEjacz0daAlxbFD?=
 =?us-ascii?Q?6lWagCk0/rXeCcs20EjH3qayaL4LRQLLkAdQyl1pNOl3ISKEKp98URTk0yCd?=
 =?us-ascii?Q?+/ZW4P0++f4S2p3+NEfklnXTXL03rxQ6DCvyBnSjfHFbS0zgb4qKGYPvmwoW?=
 =?us-ascii?Q?+jqgo4xlADzlPYdVrmTooxyEAm5ioHDVewNQXut9ihU0AApGZUvC10EBvWVB?=
 =?us-ascii?Q?/dp4QuoRkOOJK8cWj0GCLHAM1nzA3TQnlWJO/mAgGA3cahEYSD9nEz+mqETz?=
 =?us-ascii?Q?6v3dXBoEL1O+bj9pJXTBVX0eUVQ/ddLyVkj7z4mqCnK3ToKmiGEuQ/KabwVW?=
 =?us-ascii?Q?9dYnMB4m6g3DlHElPD5uolAEe54GK5wwb1Qta0+iO6BsZv56+bM7ZYfmfoUb?=
 =?us-ascii?Q?F9TuUuJ8XvJ1n2VsTpjG3LqLJUgMDfukQETJLCejiHf5A7xH/SeC1Ff276O5?=
 =?us-ascii?Q?g6EWZFJPIJ43gL77zKYQu7wUux+ShVM5iql8B9YVzSHAX/iV5pUBfZNFRtuJ?=
 =?us-ascii?Q?taF9jx2nAlnt2+Z9ys67hwk1vEiCSD6+smhyAOxUMYob6nwWzSbiMge8BqWs?=
 =?us-ascii?Q?KHa6gh9vjkn+n4RBONcHbUIluN0Wbly72sEbx0h8fWu/rwGdem8t6o5i4GMv?=
 =?us-ascii?Q?dIFmVyVF84rAWwgxYzZ8QwxpaEhm/BncN+Sy1PCwGEXkH4XDuFN67pMwj4NN?=
 =?us-ascii?Q?yfnS7Xreb59KOrNaN3HRykuPhnr+jWgBVVoNKe+fVNYNfqJwMJH1H5Gwyy5x?=
 =?us-ascii?Q?qtyzD/cGAx086e743NGBSOTcwAl7AklfU7ObaBGk6nT7FLT2KhkQZ+RuSQmr?=
 =?us-ascii?Q?JrCOh6SAGn1alPaPwEPg8lf5r9KbPhRIAVOE+8SgpNLmAusdMhlhBdWBSTm8?=
 =?us-ascii?Q?m7TZ2GlPqhPdJpaKlS4oOdJ5lZGF/1u8S3hNRau13cmwwTopmM3h2KfPt96k?=
 =?us-ascii?Q?TwDyyqYJpM564Vu+YM6ER1qB/Fkg+F+ILvyJoW2l6jCbPso9QIzIVnZQbOcy?=
 =?us-ascii?Q?OXYL78DovxfhNcehITAHjcf3GFnDEyTsLq/Lj7z4uYJRbwF2gtNcCXyt5rqX?=
 =?us-ascii?Q?Sp2+jxug/MnpT1z9p51XjGHi1w/RsidAhxJQaPdoSPFkgyKdLkBuQ+lpdusR?=
 =?us-ascii?Q?UZvsFof83uxEcbMIDwmI1qD1x2hq9mu1za+HaISzW6PLPJc0LkFrm4q5UH8K?=
 =?us-ascii?Q?XHzkwKjC27+/J908ccjqsU5DtwX3lJOTaQ83dlkyhu6fVswGq2idLYWDUQW4?=
 =?us-ascii?Q?rp9DHJAteB/k6PHN9v+EWaXjN0oMa8rY1lrEfvTywwHCV3qUk7z32Fx9JeqV?=
 =?us-ascii?Q?kKI88e8Ozukf0p6vmXFIws3XS3mBENFRw/bwzqJ//SE7L7FuX1qSLTGqiFxd?=
 =?us-ascii?Q?Ycy0JOM6GoGIYtKOHoJSKh4fkIBL3t0RHzVSbzgPeiYk81SWbNTEH/CB1b6K?=
 =?us-ascii?Q?NTtzscepaRfh3p1H9b+bW7/JZfAz7nav?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sR1TJlOFNB2hLFwW2ZpBTR3W5r9YhyLYyvp1doZ9FSFA2PwbsgbLKdp9jE3N?=
 =?us-ascii?Q?8kJCEZoKD7cu1CF+XsILS0uNDLrbMpZXdHV40g8HSNnkyTlWghbp/t8+35Rx?=
 =?us-ascii?Q?QarYXRavwORDtE3S1oThHEoajHG1UPXDccYH5Ool9vW0nOI4z83df3RFKrgP?=
 =?us-ascii?Q?+bSQAr+ex5QVfYNTKC8WB9fQUYU3BXWd3v1nDdDgkd9/LrjVmXA3Ebin1rgx?=
 =?us-ascii?Q?BSpOIN+nujaMH7H7ZJbKmHfxlNP84Vrv75GHiGeSNxPofxhM1hVy62u7UD0z?=
 =?us-ascii?Q?vfJIgOiimy7ovWWAxUGUnhR15u8X9+ZPdc1ge2MNTxaRHjt0670zlAPkawnm?=
 =?us-ascii?Q?lDM6y+/EjAdZ0EyC2kawkp7SBbZyTM7p/zm1vE+1QDzA2hepHjhG1wn9u7LP?=
 =?us-ascii?Q?NHLq8tTRzOVjRLndUK6xffZDIRxEcK6Bm6ERF2UCsS19yDp9XrmeEa7wTTdj?=
 =?us-ascii?Q?IGuaeUdNdrmgj2iZB/Tj4SFy4v6A1C+dOKqvLHwSftnP/SDSM6OyIyWNPKhh?=
 =?us-ascii?Q?xGhVT0OCi0frI2KOHiuMi7+Mpqd6DGsQqedd40+DQpw3AmcCTGfQzi/FkRqf?=
 =?us-ascii?Q?X6eMdIp1T9SEhuSorkOlYq7cfMuj8ewZAMQYyKrdSL5Nw8bW+coFv/dbi+1V?=
 =?us-ascii?Q?AWElhiNrwLELe0SOlmwgDU4fi0JvmH6s7ZPf+Cl4qzhuw0IWruhAp+RN9IWM?=
 =?us-ascii?Q?/riYW/H/FB65Sf1i46WYhoPNuDhTQ8p5f9XmF3kIzsgEeAh5xcLwxX2P4xCK?=
 =?us-ascii?Q?Br/by3RKInaemM4+UFx0+D220MJpT5iUB4j3ZI9tQtrgD9Lv+wrxrb3Mf/D2?=
 =?us-ascii?Q?olTi+5pQre/Br+CXosPSlzZX9rs3cQgPPn3le9W3G6aSI99FLInIrJCYGQ3j?=
 =?us-ascii?Q?VIwfn8OxZIUsgo+C8lSGMkuRsLYMLjs5N2VM4uBcGEx/GijTujL1CgDxZr0H?=
 =?us-ascii?Q?rhxL5NGkRRwwAXusyJP4lpy+UGoy436m85Wyoz7JGbADd8qqUaIf6cI8EEPr?=
 =?us-ascii?Q?HohiV0ysZpOkV6q6ZbngITmX5Yp9mshlDmzKB6x0UG1aD0LTo7MIs6F6H25n?=
 =?us-ascii?Q?hH7iKCk2O8Ji4JIlIf1hfqqvWixdBGKbyxgAvTuFK6z68Jm+qJIG/xUZWvtQ?=
 =?us-ascii?Q?VbOcmnpqkcE+R1ZHN50Gg0rxnsdhfxRA4noUWy15p7d9ReBikNmhynspACPD?=
 =?us-ascii?Q?1D8iiPHzqebaYVbT1R5CZ2TV66L4bIpOn5IoizStWCIb1R1ccBNdoZN3vUrL?=
 =?us-ascii?Q?Yk0zsg25eVBY8jHMhH+g2M9buYfpyfh1x5RyrIluWiHU+Xwv3JsIm05+nZwa?=
 =?us-ascii?Q?wux5Ngwfs6Og+CauOWTzPGwttOVkUjC291OjWmQnqXCxb+eBe2kpe0QBFBoZ?=
 =?us-ascii?Q?V8F964kuBVCjmCZl3zSQCNKr2hfN4rc0ROlN2w1BHE4mshYfPctdJ2M5yNRv?=
 =?us-ascii?Q?qu48ltG1pOxUTFrAxqh5PpsNTvxR07THBGopBTv8iYrToRKNr5dQ4lC/fKxM?=
 =?us-ascii?Q?vVHj/u6upNaFWS5jtt0w5d64y8iU+Mb4pioApK8osjeWGhsak4GMCpFb7KV9?=
 =?us-ascii?Q?E/j3lstrqb/G07z1EZ20fp/abQUlbNd8ofg6PyTG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c947f4-2d1c-4a24-24e4-08de120f35c8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:36:07.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SrOP4vzf7QL9mh8f2Ma/PlhoFlQ/g+OgAEUqWAgOhCL4sZfFl+cMn9rtfLvp63da0rcuMY05ssxmwn+wVqz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

On Wed, Oct 22, 2025 at 06:00:28PM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > +static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
> > +{
> > +	struct in_device *in_dev;
> > +	struct in_ifaddr *ifa;
> > +
> > +	in_dev = __in_dev_get_rcu(dev);
> > +	if (!in_dev)
> > +		return 0;
> > +
> > +	/* It is unclear from RFC 5837 which IP address should be chosen, but
> > +	 * it makes sense to choose a global unicast address.
> 
> Is it possible for no such address to exist, and in that case should
> one of the backup options be considered?

It is possible for no such address to exist, but I believe this
extension is mainly going to be used in unnumbered networks where router
interfaces do not have IPv4 addresses assigned to them. At least that is
the use case I'm interested in supporting. So, while we can try to fall
back to backup options, I think that in the common case they are not
going to exist.

Ron, do you have any opinion on this? I read RFC 5837 again and could
not find any hints about which IP address to choose. I suspect because
the IP address is the least interesting sub-object.

> 
> > +	 */
> > +	in_dev_for_each_ifa_rcu(ifa, in_dev) {
> > +		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
> > +			continue;
> > +		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
> > +		    ipv4_is_multicast(ifa->ifa_address))
> > +			continue;
> > +		return ifa->ifa_address;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
> > +				    int iif)
> > +{
> > +	struct icmp_ext_iio_name_subobj *name_subobj;
> > +	struct icmp_extobj_hdr *objh;
> > +	struct net_device *dev;
> > +	__be32 data;
> > +
> > +	if (!iif)
> > +		return;
> > +
> 
> Might be good to add a comment that field order is prescribed by the RFC.

Good idea. Will add. Looking at the traceroute code, I expect the
selftest to fail if someone changes this order, but it's good to be
explicit about it.

