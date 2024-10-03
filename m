Return-Path: <netdev+bounces-131653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A598F26D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73A92838A0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A671A0726;
	Thu,  3 Oct 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gLRJZ9GX"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585091B969
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968873; cv=fail; b=Bg73Sy/BdChvkWrhlJRbxaUiSIhhIjUii1Mhmhcu3CLqNBkCXOYLcCLbVMqt9jXrOCJ1nZiTQzhIhVkeS54/nbxmUri53YzxB0OEuZaC9ni5hlGnqjJIdb08UBq8njB6p2D2aByfIS7uJLe/WdBTfbsaEjsq1InHHrQVMjz9AAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968873; c=relaxed/simple;
	bh=nkVmYCCddYq2Ubxe1WznRuqCW/8upCw1B/9v0J6x97E=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GqEUJibgQnZybI9nM5Lvt4lLNcI6FnEWKpexz6CMWPl7g/DaKzw2hwYJDp+IqwcKK/ggYyU/Zxi5Ixtre0kZM4YfSZ8OZ/J0yx78mudfEgkdD3xOIBySSMd50GX/6BfF29uwpsdYExvStHqlDFSkXnZu5C+m5+Gmd1LpcU1nfLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gLRJZ9GX; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFPcbsNoAx770YEGES9d8jW9lDpkxNvkHu8UkHL7AICSIAWFuNsNUtW4AHPHI9yWlKu3Xm8dVUYvzongkCf7Ba1Jr2fE/xeYJ2OyyjIqQvXAoeIVldAJhFzbKJKkFdrTeNyyMFMzuAGDyqKktRAaBJ6oArnuiSwPu0p+CaGHY8mK2KvZEu3x4jQitwCCFHg9p5jdqtXzX1KXcP19QkEOajEsPdNOLsfA+Ggk4x0Qe1mjKRCpFDNCNPcoMQWMAWwfmgQWsW5clorKqNi0Yy4bus1wscSW44ytHuyKQpSk7sOzkSklEOcl05yk43W0hBZgpktPkJcYyC2XfPyjxqUPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuV/kkmcQUjCW35d+esXeXZN/vmZ67F8U4WxkYqONTQ=;
 b=j6393h9Tp5woJWa9MfE06ptsK10bNYMmWtFBcJvZtA5FGii/MtDJ+lNBC8Y4hVwm1Y1PT6V/6n6G3Xncg38kJZvauZI9GyydX5i/d+5h52djMiTgc9ItRqtabhBcPq9cUhbUraZBWwlhIn+4DzcFLCiCPN4Y4w6GTs5l7iU88jb5uVK6e8FM2WE8qoUmZIXmKvfjV/1q0EKuL3i4eVp+ZDgsUGRCqAPH3i9KUsXidfoViZc96USWEeW694TzY82Olu/41FaD05YT+j2UhrO6rKFDlBGvVvebkFR2g6qnS78ERyRNGqhaArFmIIFXrDhWbiYsI/38idehi9UM7zlz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuV/kkmcQUjCW35d+esXeXZN/vmZ67F8U4WxkYqONTQ=;
 b=gLRJZ9GXdlWzdndgHhiBX2UoGtfOUVeIHNiCIHldh4xBaRUdUXTEQHmyN1XKTOeV54nGCC5iCxW7Ju4zMJhtxMAwiwy6IaZ7YDFLYtPABbVgZH9nKz18qsv7pzyExynzgvAU6SgtXqJgTLiHsW1RKzF7e8k4f0+jRyS8hA0k5zojuyeYjVswdZJ2FbPoBb+j8Js8esbjvbUdRdlwaD2a7XTy72r0MYiEajuZMCvkSVpAMqwz4CnHsXRPH8MOpZQqpWT6J9k7t4aOkm7zQ7EGZYE/QtejbXgs/cToXW2gOhJk+NmaJfjMeStex3/S1o2OcbtRzHpmoHXoC+yNhIEAvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB11065.eurprd04.prod.outlook.com (2603:10a6:150:227::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:21:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:21:07 +0000
Date: Thu, 3 Oct 2024 18:21:04 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 07/10] lib: packing: add additional KUnit
 tests
Message-ID: <20241003152104.zhhf3makliljoaa7@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-7-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-7-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB11065:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e4d61e-796a-4aff-fa37-08dce3bf0104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2gyLXTL+ugQMFv2JxUf8wSPgnmBQmX8iPpWNXnjvwc3MumxnVK4gIy6RWFW?=
 =?us-ascii?Q?3YjHyEUAgTELbN+sXmNXOKjErrVDD6h7rDpj0H3F5/5IdKhgfUTP1EIH3J5O?=
 =?us-ascii?Q?K+F2QBUPGGOJni5DdS5RXFp8zaqMSdnqSorerZ4HxQ6+nKXj9CHr+aVoeWNG?=
 =?us-ascii?Q?q63qP650QR1nkUMV8Y4bWulR7XXKrPDFXAY0U2Vr5gGaBV5Q76+nsjqimiyx?=
 =?us-ascii?Q?Hew/vK5LXqZ0NdF3/EhC/qwTuqXXWdXEpVmkPCmvkehA/xoE6Ye4b0rdhrOX?=
 =?us-ascii?Q?QTp4LVLoEtLHJ9h7IIEC/UNJ/5HNMJu922QAUQunhr259U2AyDv7dikfiPQI?=
 =?us-ascii?Q?Fzw4MTuwm/zOUsC5ulMpUiKZPZLiJawyszUKZUt1ng+O8/WLSgoQA7fUlZEj?=
 =?us-ascii?Q?mud7IqCVZylvT02uoJGGtHoovReCOJI1wpHWN3MG4WDvUj80YR7mk+RylSfU?=
 =?us-ascii?Q?tHuaup5yLkiKjNlEkNPAJZtUjZbjG0aLHIa33rugNe1iTy6hgFkyybxSscsH?=
 =?us-ascii?Q?QHb83b9bKgBehIII30rC5KsyQx0cXmFa2hvOerfsEdosUpf20qQsYQVuoFxh?=
 =?us-ascii?Q?eKdCU9PuD3p3WeuZ9hSfmLSXbG7nXi8DGHl6/kY5hTEFdDbi9XiFrvrYJmGW?=
 =?us-ascii?Q?VkxcJea+gqUwwYF3DmJmAmeOEj9wuEDeYuekFsn5ONj7KtICBPBdxj74EanQ?=
 =?us-ascii?Q?1KhoKnu7+Xe8CHJhu9cRv6oky5dwcku4i087xNJ+q1NrJh2cJBFDWrk1YNMP?=
 =?us-ascii?Q?yn3LxN+YrC4pXlAluVfQlM/ZR4SDZYgY6Dr1Qay6tOQnNvhJMhYkT4ROuA0+?=
 =?us-ascii?Q?mz+RQ453VPAELYfZPW96yy8UqRnEhiGdRO3RqQ6/dUWOyILux5fMCQ6W/H6W?=
 =?us-ascii?Q?I5+Y2/P1B5KN9ROfCOAUuR5d1HmVw64AkGmqINPwtjGF6Np3FujXIfeAqv9Y?=
 =?us-ascii?Q?GE2YOHJ9glYscBxnTNoSlh71ASn2ONbaswuV98EjO7HMJ7U03kZv+WpYGyHR?=
 =?us-ascii?Q?A8crYC3LhOya2EyxRxhOOONUHEux80AaED5ZMgpOULQJTqtyfXWF4SXbfCci?=
 =?us-ascii?Q?F+aR0W420hBGtaDx5cUTD5lj3IKd8lcBXXOBSZUJ5OLtC7/EfuLJhnRGmNy2?=
 =?us-ascii?Q?NoxqPf1oYAF6CisUx6i+Z68o8zo6wgaIcPmaOXAgj3sd1KiFeCJ1TOZgm+Tu?=
 =?us-ascii?Q?M04dBnUQHzRgCO8fzOdoTZtwT3retBYxB3QUI21f0iemWzmEQDvwQFX5jENb?=
 =?us-ascii?Q?eGSQ2crJr7FSZ88zZbEBTM7JSA6MijcEqXXXYB35cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V34+uViUWKoDDEs4pKy0CFRxcmrtL1OMf2cbXeDbELRbUgCIG3XVgys5Xm/b?=
 =?us-ascii?Q?lIZAkBtDogEOmcbW0jNPOoNmEAX/oJEPQsFNerRVYoDap62PsBAoekXAD1/n?=
 =?us-ascii?Q?kZshd0P0pupedqmxnJAszv74tbc+MlrTSYncXOOUCphIm672PQ7kyB4RAPbx?=
 =?us-ascii?Q?vhsALKWT5UXb/xnLeI5Qcw6e78dRHvzdtOh+9UfaiiAoXZYeZNcJo8RUmAwg?=
 =?us-ascii?Q?eVKqyzszKfkGSbOO5dkzI2NwSjaXQ+t0v+YWq5SpKfm3++FYvmB3Vjk5xzV7?=
 =?us-ascii?Q?igxUB1AKOEefE9BsYKPMdShGOQ90X9EsL4w05msg6PL9CVxmiu84YrY1rAaP?=
 =?us-ascii?Q?WqOQtKOk6aSanfYTp10Pj40gxByGrEATVVItz+OR/x7tN3qiB3NUypcsNgAc?=
 =?us-ascii?Q?l9hPV0EqxnLeg1BNeZ0880dkFTZkFWcaq3BZ7axckIO9rMEmRzXrJAjDJahr?=
 =?us-ascii?Q?hdQqxypx/3xndurMiu5tE4SiFinx4vXEy9TYY+6mLkfpkQZBBZoBYwyHC5ID?=
 =?us-ascii?Q?5S+gaukc2+Yp3LmUlK/3fR7FRN+nK8l0kVnta8BHv9ejmP77mKtAoyosW52y?=
 =?us-ascii?Q?nbfDTOS6juYN0L3DtzIw0IrX39pKU4ZOyd/KhmFkTafAVfPR3VZTGo6tXzPS?=
 =?us-ascii?Q?dITDOmwT7b71Fd4Ppj/wwwugVQlSSwS64ObfPvkntQ1PhHHQLNsB37SS1o18?=
 =?us-ascii?Q?Ex2bzzQWGjIs81v+cpuFTnRGNFdEICiWKILhRm3+xOB6j+TtLLuEUX39xI4g?=
 =?us-ascii?Q?YRGwEpT6MfTowU2X/B/2+/dShvArJsDlHhYfnthYQorr6Wrs12IIDnANnlvV?=
 =?us-ascii?Q?dlG/ZEFDbrh/vXDXPXzvu7Uu7kvdRrWJgiLY35/WsxFueofxvX/97/nArUIV?=
 =?us-ascii?Q?1ychln0wn7xRHKbyEUaaU01bkJVKPFhJzJfezOz6figKs+/x3/B47uUeuM2y?=
 =?us-ascii?Q?Nd7iG5NcBm7Q74zRMykMCz/hREsly/b1hXTRfLdzPJ/zkB9Ua2MX509aJeVZ?=
 =?us-ascii?Q?TUKC5Qje06HjCuOK6BP98HcHocAEkNYSoulWoz12texcUJ8FylJOkYaiZyFE?=
 =?us-ascii?Q?7TvlIXdzutwgStnTzogb+JGWnXavxRVfFOMO2sBA9LfrU45jxEiiuQHD8i/r?=
 =?us-ascii?Q?BFimk7T9nlEoihrFc7OesImsz8pEjCcvdJ3EfNjnB1vWkcYmuGt+3jq/PAmV?=
 =?us-ascii?Q?5ICXTkHsGhjBVSiKBv7BRi2k/5BBocFk/Ro33IauNp0CsMp7M8i6KY0GIQIb?=
 =?us-ascii?Q?xrHMlpV29bzbFrKZqkEFsNCUtbYrvJrCKhXPMNVBWhQRyBmjwhPf4XGd5XPG?=
 =?us-ascii?Q?54d7QkWQKHlCJjDLzPvBKEzlb4In6o1Sr3OzJ8qHQl5Q3k6xz5Tis4p53UuH?=
 =?us-ascii?Q?Xg0O+OHmjuD2kYDlF401oVB+S3f4wd7/Dg5Jipwd0NKjGrwHRIl263almsBL?=
 =?us-ascii?Q?jP5KG5X7TF1mALn5jos/A8nRgig/ZycRJ1EPpS/omGqmUNteU9HZIBKHQUPB?=
 =?us-ascii?Q?rItzqtojNx1AMJz6g5DG8te9rW7BVP0hsOojkN72lyiZQA12Eoxs16YIWwB1?=
 =?us-ascii?Q?/PhKpig2AjUkdlhRcoUUIpRr7gQhlM4k9MlIH7uYq+/Ab3zA0PtqbTAOIShC?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e4d61e-796a-4aff-fa37-08dce3bf0104
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:21:07.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEMJ1zIKVJIKAEvYj7bQfINmcIeYmJbUge6BV/x+6joqRa5Qu2S1vF5J/YT4DS9XtKVRdcrLhBfeK9aSCj+new==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11065

On Wed, Oct 02, 2024 at 02:51:56PM -0700, Jacob Keller wrote:
> While reviewing the initial KUnit tests for lib/packing, Przemek pointed
> out that the test values have duplicate bytes in the input sequence.
> 
> In addition, I noticed that the unit tests pack and unpack on a byte
> boundary, instead of crossing bytes. Thus, we lack good coverage of the
> corner cases of the API.
> 
> Add additional unit tests to cover packing and unpacking byte buffers which
> do not have duplicate bytes in the unpacked value, and which pack and
> unpack to an unaligned offset.
> 
> A careful reviewer may note the lack tests for QUIRK_MSB_ON_THE_RIGHT. This
> is because I found issues with that quirk during test implementation. This
> quirk will be fixed and the tests will be included in a future change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

