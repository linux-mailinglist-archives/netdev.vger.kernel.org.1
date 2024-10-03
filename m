Return-Path: <netdev+bounces-131649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2771C98F234
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4859C1C20BF9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A51A01BC;
	Thu,  3 Oct 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxY3c912"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD01B969
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968326; cv=fail; b=F7tQqvz8W9YL1Z9Ahu3mxFKCqtbDcTfOgDPSAEwCRR7dPKgGFy4vge+1eX9DLWB6R9FWSFGKC1RDzYM0wB4oGDoI/EwdAckCMgiOrcgJjKyaSE45oqkOME1tMb0omx65FbuB2811SjFNdyJ3m4ZxxkUydIU62UWx7419yzYf+kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968326; c=relaxed/simple;
	bh=MI6sw4Ca6L+t0f0VwWY2cpnRx/QvMr8nibgZEx7E9s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D7BjpQ+V6rBDlAz+9EaU6MLXmB6iAjL6P7V5t7BvtdQFBwSkvL8LuAaLM4JMMC81yaDcmnVXkcY/KLZCwjsQsep1oJmdDHaJadZ2+jIYGdsaWyLYHGbG8FMzlzrNIrGYaaONGfzqxfYdQz6DUtUk5qQ6SylvkkIuU4kyWdC2tmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gxY3c912; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+jyZ/FtMG2vjh0WvrARW+nAB7ubtHJSqJ9ailr3JCzkgxen/cQT/om1wtv370I34R6J0b4zhx91bs9loG3eIXj/jusCUvldK+70WCkfwv9mU/mS0A63pRXLJ5mHuaxjUDtwHKNPyDx94o7ZvmrvgwlKdoQtk93C8ZQ6E6GXQTx8ntxqGU7Y+cRvLAS2C4T13ldKkfhUcGL+HofMI6+fu0/HBKscYxQGHaHi77OFGn3ZQr9mI+SF8tPOIYzahRaBEWp0rc3O4yjPpMcpRPD1oDQVsM3PCHJWbf4jICEnwQU4Gt4LrKTZBpSqUIoUa/HuO3CPercCwDZkz0y5fk0CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPD3P2B41u0SahuVbRgTM2fUAdGCJjxRopUDjC7W+0Q=;
 b=nOEcSQsb8v9ogOaBhONHIKSBLjr9/3XCKZbB1D1NgqhZG1NItq01epkOI09lEaIs6m7RcNAoKj/gSv7Lxb7Fyk5r7ZRTPfUg/Rf1uMLk4PF6AH7YUEZgM2nqpJYobYqwywS+Jk1lrxCy3OtTTMp0PyPEJEA/w6tfuRLuHHIKxZl5vBAVM68gpaAS7MiFRvKZWjgBsz19Pso2KVmA1XvL4z1QvWhmWx+gfWYwJDMILCNlnMPsUWBKWbMTcs8LRgqSRQ1qgTDTzS7AJr0TOqLB/lGfSa4RseFeZ2ffk0OdIhwbKO1zv6HlRRowPPJ16Hhv0gGcCzWgKHeayilNLcRQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPD3P2B41u0SahuVbRgTM2fUAdGCJjxRopUDjC7W+0Q=;
 b=gxY3c912VbQNNiRCqT8ZlnUSIQmlHWoc13Ior5m8589iw4190NrCF83MwbLB4tfiEzCpYKNyecURfgNIAl602OdbvswXCiqNqDLr+MN/LrDEBvZ+g59QhbgHIQc2vFwDSKbTWseKJmRvX+d40Zi8vFaP4tnG1yNIIct/tqqy3aDBK9LMTJwIERyYVPI+aYMOx4Q56q3GstEuUgAdnzF+k6rZVL3gZFj/MYOQOzF03ldBmes3LEO4tEVYxMFNV7eY9uYvyp0wN/u0ZN/RuEOUEUyCnTnDgKC014q1BLBiOLIrQezPAEb2FVCWlmbns+TZxIJM5814rWsoaDuE38mXrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:11:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:11:59 +0000
Date: Thu, 3 Oct 2024 18:11:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 05/10] lib: packing: duplicate pack() and
 unpack() implementations
Message-ID: <20241003151156.oxsf33omtxqci5jw@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-5-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-5-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-5-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-5-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1PR07CA0219.eurprd07.prod.outlook.com
 (2603:10a6:802:58::22) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da230e4-66c7-4392-8d93-08dce3bdba4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/F5hobch4rtPlpWf5Pw0M7sEMB6z1s5PVTRR33uvO2ADSXZs/dVrpaKzo69n?=
 =?us-ascii?Q?DyggbLPGERr6a7qsLF8TlBIRPvzlX4a/9O06jlFckpdF6uxeMQiq6UGNTIMT?=
 =?us-ascii?Q?Mn8IsxXAbkgmjC3QSOc1LXfgVacVzz8JWuH+K+ht/XthW1+QxVVvf2CNnr88?=
 =?us-ascii?Q?wCZHAFqWh4TeF6qCDmwNKc3yPtxNSZdmoTb4+KN0kgFPcizN+UiUIRgpFxEo?=
 =?us-ascii?Q?VIVPExc7gf5Z5cqI3hZWxuEHtXzt1AqMzSry6nBfa+G55Iki3t6yJ0hGLCeg?=
 =?us-ascii?Q?66blciN/KGgXYCiZ8N7KUFOsSQsgpcyD23SSSdRQ2K+17smtMntjTofiv9tp?=
 =?us-ascii?Q?O2cIXaJp3T5ahUJwpPysrFVyCS8doHcR2km9/J9pg5RNSwdePc95OxSJARcj?=
 =?us-ascii?Q?Bh/ItigIg5YMnR71gckaUN1scGEPZwmiGVgR5VmIRP+ywulLBAnEpUP2ZE2z?=
 =?us-ascii?Q?DAa+/6v0TpLZg4mBkXdL8DxUG6ZODYSqKNDhYq9yK6xLL434RXcCwBSs7cJj?=
 =?us-ascii?Q?VgfNHo+ANIZLOxaNHKukIINHtkyCBA/zT02lxAUuYaWW5lmb1VLWYc05lLSy?=
 =?us-ascii?Q?W9nGeNGVfCgEGCHb0+k/yIK2vkXCw4A/VZ4xzKcl2QZWP+MfGoba6hCTaItA?=
 =?us-ascii?Q?nD2DxM/w2oXrPhy+KM3JyeHDzuKv+6Ao3n9TVMgclnK6ui10wfisy4lVylot?=
 =?us-ascii?Q?1Xzvc30EHKQCs8kWIRQug74zojmvS4RflmQ1by9SkIVc9N+AtIb2Ws4m2q6s?=
 =?us-ascii?Q?FS0W3F+HrsF3CiXy+UrxvugysaPdVU1HVuUP80N43JIfr+q1UkwCUKEkzSYS?=
 =?us-ascii?Q?fO979CBn2/3U3y+jf8dvch1PvZSm+3wbho5Gm0ULCVf9Vu2JWhsHw4yrj/br?=
 =?us-ascii?Q?zJZriMjUlG9xHnQ7jQizYLtvGDDrJrGypYJcTp5ckXiqmnI+OuACYd6RmMCg?=
 =?us-ascii?Q?U8Avg0QRvpSfBAkEfWOxLGjAmwsbkhL0qtg2BCFJp2Zeea8zfVfOs6GGOPHx?=
 =?us-ascii?Q?R+cPq7U34LIy5J7dpjrxBB+ydbP4x1begqM5gtaeomGf9ohfvR0mxJOUWnZY?=
 =?us-ascii?Q?noT4x6h4bsWxOBihO0bqV6Udac14BpG5viKgka3wQKm5bEmboGN/DSh/QTLQ?=
 =?us-ascii?Q?VsM78tZglwS/tssYJL8gAQqwyUfgv9suxCcceEvvfrwevDo8paqMyZN3vGCN?=
 =?us-ascii?Q?ogc5Bj5LMrxu2xMcDMFitOjv2yfhlIqxB/A0878tvf8ZY/a+pNtLmmmTATdu?=
 =?us-ascii?Q?8HeBHCkEF09o16TmGN7PrnO5tNd1myzaLtUm9Z2Hog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0AlfA0w/LAX6UVtLFizaonr+44dWXJiSo07vJvggGLJnA1bX3a7qcDpkwoJ?=
 =?us-ascii?Q?I9bIxEYiyuWA44YWqY1lbubzLlV7b5TPFcwmgo2Svb8w/ueRilPp7UetU+RD?=
 =?us-ascii?Q?54gCATUb1UcUfuwmsoyWV4UcVGaY3Du3txUA26lK0V57SHekL21QvLHodNca?=
 =?us-ascii?Q?0Buh9TDAuzbvmcmsotaxqLHQw7EQ3rFcIDfTyQlTPtMMteAqR5u5fx6KW1tT?=
 =?us-ascii?Q?Pvf+IXQqIX0BrncJLWKWW1YNoBlihfc2xI0OfdFYqD3hH/kbfxWPjg6tFzxF?=
 =?us-ascii?Q?FO+1urVKFO9guVl3B88LJPceOO2A2FOoTp9GmByygARagXiCaYPg7ZvkTWty?=
 =?us-ascii?Q?ne9dsX41s5W634Yj+3oDYaBtnkLhLUsqjbHH3Z/pGAWi5raJmMU/2Ccx7bMD?=
 =?us-ascii?Q?xlsJeNhNI8Py4UZtaxyjD9NzHCV6gMFr56AIM7G3YI5PqJk98IsVQSzsBKn5?=
 =?us-ascii?Q?X9NOwz+U82hXD4mJEtGT3586hpSfCjNko9HaHq4FGV8+XXfWmclVCCk1bn2C?=
 =?us-ascii?Q?SbB0WYrqfUHnpfNrY35cobcWmH6hnn3LpLZLtpI9TTJ75ECw6y3VmTMmeP13?=
 =?us-ascii?Q?a6+eCg27ZQuFl46og8Kb2mzQXz5T7ZqmSeUj+pPOi9Zz18xF7QLkooE/Vazj?=
 =?us-ascii?Q?OdeCv36Q+fC+0lsMajNJkZ6u3MQxsVDnXRNI6wn33apogt8pE8Y4dEI+6RWF?=
 =?us-ascii?Q?4qTyK2DrQjlM/4ETxlKxOoM/APnkjqTmnmWB+JX8ZHfDM0fT1xoSLcijMzT0?=
 =?us-ascii?Q?u8wi5F6hgOM26Ria07r25KHH6maLdXLjEQJPTYmqUL++Eyj28qO3hT4qmoqW?=
 =?us-ascii?Q?KbPYvTPcoM0kuVTDSYW7cuHR5YC6j+X3UMmENmO6q2Y1kMIY8C83iXiDxyzy?=
 =?us-ascii?Q?0N+SzMUEzLjCRK+V0wCpMx37sdXJ9xqzF4f80zZIj0aohMc34WREUj1mHY8B?=
 =?us-ascii?Q?Jl0z8aipurL/0evG5I+DKu/Qu2RjLpR9DLx0BFFa8MfU72uMzw3UXa2OLnlp?=
 =?us-ascii?Q?3HqotDueTkUCU7EL2eaIyzq5zoQfoqFpEwTGphMwdcfK8dZJYoIqWFwSrrrn?=
 =?us-ascii?Q?VgA4q9pRy7uxnBNrAEths4u9eacfdbeCgStrtIQbAqx68eDWtPScH/8OTXg2?=
 =?us-ascii?Q?O6i6oqCZo7fWk+pyLUVUvK0ctJsF89b8ALqSzKRjZDES5lt1EiHqr9kA0s/p?=
 =?us-ascii?Q?oOwqAKDTwA+47Ol552GJs3zEWoL0oiyREAFe3lgNR0RCEMDamXx+L9jG9CLg?=
 =?us-ascii?Q?s64vgWme+mUQVB+3DNWhzTDhEzIalPW3l4oeXu78WrTH12Hqv8qJ1SMxp4sZ?=
 =?us-ascii?Q?MLMQvoM1uJOHViTMP6SUJWYsR6OpAcu+2s2h9REQ4sQg7ugTGAxn62nw94Yu?=
 =?us-ascii?Q?bdnez6a00ZbPQ3EQbKO8X0Yb2nOJBuMnpXVoIBASxyImCw+BeCu9He7J0y13?=
 =?us-ascii?Q?YlZq4knfZivr+sK86YCW7erOM5VWrpbnQzt5Z/JLiFbOTEPu8ylMdCSBUTU9?=
 =?us-ascii?Q?n4Cm4oFVfpj1pOI1KKzc06F05ULK0ZSVh9iySFihYx4Yc1c/4saOuVUmAvjm?=
 =?us-ascii?Q?dmtDh+lpsh6kf3S2VXsb+IBtOBrtPxx0JWIRW254UgxdCivyg/aoqQ5aUNew?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da230e4-66c7-4392-8d93-08dce3bdba4b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:11:59.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0dmmuvt5TnNtJlt8JriHCIVVCpf/E/UpqFk22Jhc/Z/AHtsNBjTZFkxgNIvph/tTrKAg1Ume3gMndcYNuLscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910

On Wed, Oct 02, 2024 at 02:51:54PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> packing() is now used in some hot paths, and it would be good to get rid
> of some ifs and buts that depend on "op", to speed things up a little bit.
> 
> With the main implementations now taking size_t endbit, we no longer
> have to check for negative values. Update the local integer variables to
> also be size_t to match.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

