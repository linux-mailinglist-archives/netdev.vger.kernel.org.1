Return-Path: <netdev+bounces-209359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D593B0F59B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A19E171FC2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566792E7F19;
	Wed, 23 Jul 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mBND6MQC"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDF2877F1;
	Wed, 23 Jul 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281702; cv=fail; b=aivpYUm5DEHFb1m29l+U9nkrVwKmu8dwi9jPGZaM8WrojhDzFii4pNcuIwpJscZdPvnhKyQZ/dE+jGVss/w0Cu5WtyVKuGSGE3EZHSbVDt8hHC31dczbYkLwGNwnXP1A8GCLKZ33+GtfZxNmqWZIBVMMwPSqPWlFIFfTdx5TPUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281702; c=relaxed/simple;
	bh=9ASNVvBDOj0+G733lSd3knREQ+KpM3v5VyxtdMf+oD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ew3N0hmXYLuVTJmZwM3hDsqu2vVwAXvtBazZb2EX7HCLrTSq7yCqa6b8Su/geQ3YvfBTFF/r0N559nzx4gK2+WVGIZ6LNITQBSzSIC1SG7QcScelUsSqLm1hYlPE69+lVdhpmTF1RXWhmHMAVIpDg/59FESvYsKAT/RiMDt+L0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mBND6MQC; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5rh6uCInDCVNRd+ry1SvlBuOC0iWV3KbGymoBEd7sbOsXY/mGgN+hXP7RLcWN6csVNvodNMkf2kuM+nLG/HvZKtdkYJDFb8X8wpxqGAp6lsGp8WpLqbSjqeqAux2s4csuaMuW/ionm6njfSrN6X1cJKtsjkW4Mhs6aMwi/8LGWj84WIM7VE4VGuTHtnXccc0RhlQyt4BMmpn7YD6cmxoK2HL+f+pYcy4J2Kst8ac8p3XpySxHhpfxEQjJLunmwtHZ5jsOEUTzq7bQn0Fp7++W0ovBc9txby20+GM99jiYsWf7P5IudGDC6ahSw4zaG/luC5StKAZ30a9BPndV9aUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeYyeYJrUCS6nbJD2K2GThsU0+lIaUVZIrUhcQwb0Gk=;
 b=LB7vEI9OEzMrmfcltFvI+RO6j84uweQ3teMQTv+KY3XOCaGI+cSAYYVowloXeGsDPWzRMU6C513y5ZMiaNUtSoIvBJTyEC5NMeevZIGV8iH05JUmZ4dus4A8UnZCnFAKkicn12BG2Mx0GrYO7k6Kz1IECMXpXKxEdi4AEy5cgiHW/e6mCcGigWrDOgSGw4Z76fblbMNK3TAV4yicR75SRn3+6YChf5/N5bt+ed58/rH72ZwpJJ8XEsI/jcvljm7oxeKx9KVIWPk+O9uwCGuKLhB5zmNwrEyvWbW3El7VngTSLeFMZJ//iynwfs1JIqCh4UQkrV8b7NZmroIcaM0Hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeYyeYJrUCS6nbJD2K2GThsU0+lIaUVZIrUhcQwb0Gk=;
 b=mBND6MQCjQzjUsVZMJG1Ot9kgAFYCKu7teRtKwgTUMsnXcG7q0jQ4/HumsThQ4iakGIkHYgObEYnouMB8YdN00vGhOWbDd6UAED1pcUWCseBSSvl00cWS+jH1v6rxzCyfP6Z+b42dVAIs+ujv9XcVzMJ/QVBEtmJmHNltmfuGy9VlWx/TGFqvW23EeY9ZvNna0wbOE2PFe2cR6SVEworCaCqEvRr3o4ykRjRy9yBoWwnoK6kUqXWX0nb2yjITRFFSrkbmnsPV69CboUj32+xTT6AELlC2+AuvXX3zWAHYO1AhHNTAwjX9DfsfhHM+tCQqp26BV6RKVomTWY3KHM7xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB11217.eurprd04.prod.outlook.com (2603:10a6:800:29a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 14:41:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 14:41:34 +0000
Date: Wed, 23 Jul 2025 17:41:31 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: Maher Azzouzi <maherazz04@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Ferenc Fejes <fejes@inf.elte.hu>
Subject: Re: [PATCH net] net/sched: mqprio: fix stack out-of-bounds write in
 tc entry parsing
Message-ID: <20250723144131.4uuz3zv3nwzy2qfp@skbuf>
References: <20250722155121.440969-1-maherazz04@gmail.com>
 <20250723125521.GA2459@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723125521.GA2459@horms.kernel.org>
X-ClientProxiedBy: VI1P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB11217:EE_
X-MS-Office365-Filtering-Correlation-Id: 56053543-c093-480f-50fc-08ddc9f705b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgInl91qAbjWXwYYl50LcHyA+YOPEKhd0wXz9B8nr0L7T1uYPfka65KQAfRl?=
 =?us-ascii?Q?3WxLcx1aCMR0gxvjfV/o2kBXjxRpOTowQYFLDPt87a0u9NBNyoXXt081YMtB?=
 =?us-ascii?Q?8zOROA8ZdFnBsECKm9Ljg2p83VfWVN8FZ2RQlxmLi/ObP/d3Y156A60sMY/Q?=
 =?us-ascii?Q?MRhqML3txfLjsEUkdq/5DGFu8Qzg3v1Vpp08w4ef4h5EvMsEgPi864PZOh41?=
 =?us-ascii?Q?yCX+snv+Hzk+qBC/d7TtTCV6sCd4cMAdX4ZiFksdY8U/d0IH412Wr9fjVXEi?=
 =?us-ascii?Q?Fw2Qu2eQEDqUSAvkWCpuW59RARez1Qpz8MEWwTS4ITEo175fJohIj38M4ill?=
 =?us-ascii?Q?5ZxLK8DOZvrPu5K1TE/L998GQZWG8+zUZVYyw1fZaBNp13tzZqIXiJyNaiE5?=
 =?us-ascii?Q?xaKQPLAn4kHyNq2ps4F1Rr77YTTYwCwFNKfaucTpC6zNi2d6/Af2AHXYtzBI?=
 =?us-ascii?Q?vRvM5HLhUyjDibf7b1TMM9iP7rT065LLf9cy5SZQ9QO2hCOwJrfaTOWXXi1K?=
 =?us-ascii?Q?wKy0b0ZUCeb3b4nqcE+xEQ1WPMCYlU8/4AztZzUoJjAaH0Na/B1PsC9Sox6J?=
 =?us-ascii?Q?eTM/FI/uCbLhsseE0AqZvWgRR6Fu/ASKcGZqrIG9/mGshSolIZfThN64D38d?=
 =?us-ascii?Q?u/u7AaWZoZJwq7hfq0SnumOMNzYUnjsOcMXwbikNhCB8HY4OBcHj+NI2kq3Z?=
 =?us-ascii?Q?2euEx1iOwlX+mmBFiJZ0wTXHY93DfUMzicteEyBNdl9WqvLAQ3JPoYxrDIIG?=
 =?us-ascii?Q?KZvEq7dA/spbLdntl5BCzq7JY9gqTYxSWVwbM207Z83Myk1WWdEwaKiHnzHx?=
 =?us-ascii?Q?n0TcxM0Ks2K0ISIqheAIoSBVP7ayxVN2o+qlo+hjYM/M79xyaBOXWR+QGvJf?=
 =?us-ascii?Q?8+jiBLOqb8CNDR2boWtqvdz20p7wyKiJC3fdHFC3majDywllXBXVoPpWAra5?=
 =?us-ascii?Q?5UtcbBjoQ/RutrzoGNhCmIrhrR9hv2KRCJxlcBeTDbP7SAje8myktmdgqoiQ?=
 =?us-ascii?Q?5HND3gwPdzzFej2ClLRxhkayUM0rCD2FLatZSxxgPXwFDNuSJnVD/ZCs2OvO?=
 =?us-ascii?Q?FRNeN0wOe0+lABoYShpwHJOEynTCRpB7Sw7Ee/qqKk1h1etFGv47zsYTD+GB?=
 =?us-ascii?Q?J4G84lYaNkBwMjgOg80aZwajm8DS5w+ag+MMmmcSHZ9h6BT05/I3nPKtVLme?=
 =?us-ascii?Q?18Ku8eDCWp4vLiGw0wwxkMTaBfUEuA6StpiWOuH8DJUottAhqduB+h8ezE4q?=
 =?us-ascii?Q?AB1AkVQpxPbWy5l2wisYcCxfFcGLn3Q4l98US6Qv81p5XAEn/syjV98ijJQG?=
 =?us-ascii?Q?yjcLVDBjkDWOg9VoDiAqNvqf1PEA7o06MflhEI7sViHXdwdwm/fcpxc4ZUBW?=
 =?us-ascii?Q?x+uWqG0dcNSEAYkoDcsTBe0UhYvCit62VmecS8asfyNSPssikIWDlIbFH3po?=
 =?us-ascii?Q?Z0x6HvFgMFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOBlymTaWGy8lRbRdF/jQu+QH+Oa09DqME2MZIEgFtoKhwj/oZNezaYMUTIB?=
 =?us-ascii?Q?z+DeDkZ1PsSSbOA7yseEeZasrkHVnNAeU5oBUg+C1FA82sAN4QLErrAQRYa+?=
 =?us-ascii?Q?NDxp/RxzT02HABMcAGFzVJ4IBn+H/3bNMtDLT8cIB0HIqgNA2FmwA/X7Puj0?=
 =?us-ascii?Q?2zPBh6SaggIHf2TslAQ1tUsjqlRl323j+KkUgTJo2MGu7SzU+fzmE8a65wop?=
 =?us-ascii?Q?csgjV5Pu4FQT2p0wVSargUvHxdpW6Y9Ci/zK15dSCuL/Atqg8Ahp2NfRF/R7?=
 =?us-ascii?Q?i4GH1rpQFS3DzmxC8rqFn1shTo77h/8wy4v8uw9pwPewjflUHnsq5XGa7/dd?=
 =?us-ascii?Q?xlxjpLXdb4kZ+Kwr4o8pFX5FlXrJoWLFh7BbhU1ed0RvwHa3rWU+4fDJwrbh?=
 =?us-ascii?Q?h1WX7F2ueLGXT2O4xshjsV1l6KswpensYaAK+eFKpX4qPwwlqD6WHEBc5SLW?=
 =?us-ascii?Q?onVe5YQMkIbp0GjG7V0jA0sDSxUHjpZQ2Fwd7YXZkyUNGxXIOGNvMX+s2TF/?=
 =?us-ascii?Q?9LX+/BxVD7viFQrWjJmBAQUkDMpi/oc5M795PD17kXWVaxATQT5Qx/+VVOym?=
 =?us-ascii?Q?PrcA8x0phDIcxwnr6Dw6XskU+Wwb6p4WPeYPcMBe2FLopdodywNW6o6k5O2k?=
 =?us-ascii?Q?RtbS8TwIRIqFQlELz88q6QVYjuirmBdTZyKoE6N3+UhxsQWfDSjMMeMPegRM?=
 =?us-ascii?Q?0CZqh4j0iof4iOEwHTczgKIiGePzXeRw5OGx4pVd9doWtFJoDaW9LA8jbT9k?=
 =?us-ascii?Q?dFUYTKjn+mA36KF6kmynujgmVEiacg7RMYTqz2AxMhw5zqHGEVH2ZjXBL/nz?=
 =?us-ascii?Q?gXbgi47C4HhpdALc0eAJMRtM/WiBChfeXK2a81JY8yHFRvr/VJNcBeYBeQ7r?=
 =?us-ascii?Q?wnGs2/X9LO/S/hh2C+hFXX6lZU5lx/1+aU1Jb9HPTZkP1dJp3x5gcoD2qah1?=
 =?us-ascii?Q?klwe9Ce497C4f4LUoCsL9ydCBCnFEwKuKjEFu2E0lLJt7WlOdJeg9q6IKG70?=
 =?us-ascii?Q?rUFGWObiv4Tr2O3EpBQJmWO4Qelu9cwMtgXMoLmIUamJgj5fFEfUG+taSwFt?=
 =?us-ascii?Q?I40z8+S1oybr9ZOi0+LKMJ1o9TyLWTwYJ8cAEzInISXSH1dsa9fEIdH2txQ/?=
 =?us-ascii?Q?nyY/bKQrBLZwrlXYE/fKeUtb5sC0hkHb7GOEmoj3KJheGJxfHbPdJ+3jteoT?=
 =?us-ascii?Q?svDMiVNYEOWPqooRT2pBppbVjh6cAINdX4BxRxclCNS1EWEfCOYpynohUadt?=
 =?us-ascii?Q?xD3Fy04y3ZQSekk8bZ1rWHlMNpqL52/ghuGbhLBTPzGF+4/pe3fiXI8zA7oO?=
 =?us-ascii?Q?eRyyMg7cBjyEgXsLeIta9djIHo+sXI5ilsKRjtoRZNtcHGz1v/t17vhDi6S4?=
 =?us-ascii?Q?nMuJvuw5K7yPi/npBvuX88HIZD0dmN69lw9slwnbL1HPwbdE2iR91iorujQv?=
 =?us-ascii?Q?bpwG74C6O2ePY/y5mOluLS/N5I5gA+mzylslo0zd6tku2whh9s44X9YvZx+F?=
 =?us-ascii?Q?eF7zKRFvY9AoQERMvuObCR/+pTIpLCwzzjEnqzXixYEswo66WAb396vArs9A?=
 =?us-ascii?Q?WeIhO9/3uu7igqSqkUnXKxlKyTKh4ksBY8PO/ns59icQFbuA4ei9mPQKTlll?=
 =?us-ascii?Q?3MFTpc1lyw0HePlaSVmC+cqjZJeDkbdX0fvFWRVHqFWQyYUETsU5uHKebGr0?=
 =?us-ascii?Q?WLPvHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56053543-c093-480f-50fc-08ddc9f705b9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:41:34.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vErdeveK4c1KhPW4FExZ0Qgpj3hM/VLdv8KBmWY/LPkqpEgCI8tsjySXu680lQSkrv6Gd9gWUj8q4wdUIQRp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11217

Hi Simon,

On Wed, Jul 23, 2025 at 01:55:21PM +0100, Simon Horman wrote:
> It seems that taprio has a similar problem, but that it is
> not a bug due to an additional check. I wonder if something
> like this for net-next is appropriate to align it's implementation
> wit that of maprio.
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2b14c81a87e5..e759e43ad27e 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -998,7 +998,7 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
>  
>  static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
>  	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
> -							    TC_QOPT_MAX_QUEUE),
> +							    TC_QOPT_MAX_QUEUE - 1),
>  	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
>  	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
>  							      TC_FP_EXPRESS,
> @@ -1698,19 +1698,15 @@ static int taprio_parse_tc_entry(struct Qdisc *sch,
>  	if (err < 0)
>  		return err;
>  
> -	if (!tb[TCA_TAPRIO_TC_ENTRY_INDEX]) {
> +	if (NL_REQ_ATTR_CHECK(extack, opt, tb, TCA_TAPRIO_TC_ENTRY_INDEX)) {
>  		NL_SET_ERR_MSG_MOD(extack, "TC entry index missing");
>  		return -EINVAL;
>  	}
>  
>  	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
> -	if (tc >= TC_QOPT_MAX_QUEUE) {
> -		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
> -		return -ERANGE;
> -	}
> -
>  	if (*seen_tcs & BIT(tc)) {
> -		NL_SET_ERR_MSG_MOD(extack, "Duplicate TC entry");
> +		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_TAPRIO_TC_ENTRY_INDEX],
> +				    "Duplicate tc entry");
>  		return -EINVAL;
>  	}

Yes, this is net-next material, and you can submit it independently of
the taprio change (i.e. right away).

