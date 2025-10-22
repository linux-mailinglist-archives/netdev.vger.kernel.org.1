Return-Path: <netdev+bounces-231672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B9BFC5E0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B39D4ED1CA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73948347BC4;
	Wed, 22 Oct 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LUqhnnxN"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA86330B27
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141549; cv=fail; b=Brhra3cWPHuZBW1k2hIqfez1edNL0pxRTcmYSAiFVC0kj4BREm+3sUgTXesgeNYxlKOZER6ZzgnJanX0Ks3XrV6jjTKV3HUERuzf/w9ODCI0od3Iox2DSAhE6xMjE876DYE/v+5Xa+1wj09Ll2FNSYMT2PlaUIRoow+kJ2F3fXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141549; c=relaxed/simple;
	bh=qZ3q9HrBM+ghCzMpsMjpl7zEqivWMX3fGl1ZPFL9DQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BctZCPs5Pje/0AWFFUkpqCmAEM7gwOgQ/itct1XSVCC1UW44oTGAuTUdjk6P7yBpbiY665wNke+YhXxjaagf0N4spEXpUl2/SJtCUMD4LfmIJwCksZVTtf2XbULNJpkFAKbaas5ZCfjbY64mStdl4JbvwS4bzJXVfyVTSwm/7k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LUqhnnxN; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXga+54aiiAJzDK3QRktTDg185oygsv9/5SZjqftfIo8v+Awpl/5LdJIKhPYPbzsgx9KkcS7N0qdNPmDNs/Bh7KYkXJglB5EKMFIrsZC0vxfDd7rCEAfga7hrsEZ/qxpS8slkqLpTF8gUiGoHON9dqTYwl/eF3vry95wQLRyGp8Bhd0zgy8PCoenHfmlNxzvoTBxXOsF0I/y8fIWPLgrt++axHZaOyo93BuDDI2Wu2Q1h0Bm3IQRYsyJ4HPT9x0PGIAL/sF+lpCWkrcc673ukXcYdp0KdNTmbsR4ImHinm76sUbn9JtRME2vA27cJHZs47yHj/FXjmWm6AK2K77qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXuKLXtkPtb91d0sOC9Umm0bPhc2BLlN+o55A6oEOpY=;
 b=svMxMS636u+kI0MYL2F7CSulnz/Qsz78CqqbnTf0HHrT/qyZO56y2soR3RQZSltcxujwjJv1FF++whrw2iweoWgFqog3VV3xXjqn76na12nX78Z0YhHqmtNDhP9FrzlfFOWEHfDEX5QHCiNQArA6HLeLo/0MhRkWorU6SbLWik/Ed2HwtNDLyUxoFupKrIvQISROgY02mDhrgcrh/Rpm7QfwDVB5IY7eXos+xVdOqRjchHIWnhKWDh0gJFeYiJh6qJbyknfVSjbUpQttG0PeBpK2WL3IsQ8V6L8hNDcpz+A8bTovLRZu+63UrE1UKzHNsxVyBy1XrjSJL+aI9UddoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXuKLXtkPtb91d0sOC9Umm0bPhc2BLlN+o55A6oEOpY=;
 b=LUqhnnxN7X/qN9E2CItGpVCBIz5sZmgihF+456slEzd5dC8W4ljLQfdL94wsc6uqyEzebkTFwKsKSvGmu/RJ+PJiTk18t8CieuNp2O1LSa4fXwUxqc94aRG9woWxgHLEqByWkmjQWobv/fPElnpUTU/cTo8ZVBLN3hXGUJl8+avZ4gstUMhMOVf+33xUeF6A3RKOrl0xC1dOgagoeMNGXgTehcku6lvi5Ir7oDmMYHS1C8V+22Pdq+G4LRn+nJ3eCI+YdGoXxfP6h68KYqhNG6iOYKfDYTdr43IdYKGNhAspAAS0UcXn6pFw06LGG3tMYCKOwUIbWWdOFoiLEXa8Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 13:58:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:58:57 +0000
Date: Wed, 22 Oct 2025 16:58:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
	petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net,
	fw@strlen.de, ishaangandhi@gmail.com, rbonica@juniper.net,
	tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <aPjjFeSFT0hlItHf@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022062635.007f508b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022062635.007f508b@kernel.org>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c52f9f-9149-47ae-65a0-08de117324f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHZP9nFtiVJvq6mS6FFI6XQWhF8e02un1q4FzzGU8x93FHCy6cFnYCWzuAPX?=
 =?us-ascii?Q?qCharWwh6bl7Rnd4q2vtCaIyCm7JsSDM2ULuCfpqBCndJRaKGxgVV2qmMedf?=
 =?us-ascii?Q?tW94vm0Zz0Ut/64Ozh+Y3Uz3FQIaC1v+nQR8znZz+cPHSdjq9EDQbapnOPHl?=
 =?us-ascii?Q?ed+jw3tor1AXrDRDeTmDRarAb+uR/R61kUqjUCBT56pXJod9oTA1KtAowIN1?=
 =?us-ascii?Q?D8kg5aLU2ySbStgA9EvNvXwMvRqPyxGH5Q02uOFVxEZNBruHNmqjM6sp2Lb/?=
 =?us-ascii?Q?bil6CfFMftDQu75exAIxO6RBLuJL2+hkcG/1P6XI4uhRZiruPzEqZzlybju1?=
 =?us-ascii?Q?cetuHX+htaE1og0EcZRulxRpIf+Uz7nqAg3hY/x2EC4xUpJjrZsjU5WWMMcw?=
 =?us-ascii?Q?GUBi2e4U/4GTPHuMvTWRumqRFXQc81qLZ92yr4FLW2ahB5jh7FWgkdERxP4G?=
 =?us-ascii?Q?c3/n6dX4bvib+e46hZ9M2ecZqpXleoAAHPsa+rxExgrXdJB19ACt1UB1egP6?=
 =?us-ascii?Q?V5sZOePiKauiMdk/JLKc93kB51Ctdt29+Jm5VxzpFwk94NufxQ1spdjsCgoh?=
 =?us-ascii?Q?jhLiYzTrZCAp5t80W2tUGXGWa/HJhnAj3hI87hCzfoiy+aun/3DnSbCt/kmr?=
 =?us-ascii?Q?8i9Ceo/vlMndROpMs/DQPvUXkIKI1Jozq2Kvn+//MVCNCK4DEA62cwLpO6mc?=
 =?us-ascii?Q?/ntqIu2NY350h7TYxfOs09Umjpk15rCtgSqnNf5NUq3Mx7b68pCR6Uqmil4d?=
 =?us-ascii?Q?LRC+RVJgiT3LYybhBYjAl69mdpfsapZD1x9wM0GyUej77Snk0adQ0fr2cu53?=
 =?us-ascii?Q?mnnie1smawldzeC06CLpNsOTiV7Jpq/YMIyMWotDtJ3zuTGnxzESsJIAB/qh?=
 =?us-ascii?Q?tLpbs5vH14fRiMDeXvNGbkrT79SsXLC6o1vDY/zcxHFvukQ1U5ekRD9slkg5?=
 =?us-ascii?Q?lWswQezWFHEIyfSNibmYK52SBPnfu0Xkov2/GLaGFVvzL4kLu8JulbheM4lv?=
 =?us-ascii?Q?foqrmH0h8OXH5/H0+8iI+M7sc//jmsUd7Iw8ven9yHhpmj1bIWT521zKQ0k5?=
 =?us-ascii?Q?KAsQCdva4MQ/ZgQJLpchCEsfxn5VWq4KAdF5cQw6S/emCU/KtwsLqUI+aho/?=
 =?us-ascii?Q?5xujnY+5P242Coz+zJBboi0rOCpLUMb1/h9E7bAUi8VvhdEH29sAeUkoUB6J?=
 =?us-ascii?Q?T0TbO8FzB2M1YrdkzFkdKkh6cpxuxKaroQ+IvLUdBSp6t9+6N0gt4pa8WlED?=
 =?us-ascii?Q?tJGbEbA/DyPYRd07jUek0xRQk0zkHBfx/BRNLwaznQg/vobMG7Qt5ODJ/AY8?=
 =?us-ascii?Q?Vg8uyOOoF3GVFvuAiCTOjc3+8NCMBbI8whGY2hoJpnT9dhhy9g8nZUY3sG6Q?=
 =?us-ascii?Q?FjqJMcF8Dag8gtGs971s0VQquTFcUXub0dF0Ke4/2dVG6Ll3x+tTbNwHG6hj?=
 =?us-ascii?Q?Ums7MHAgFvlkA5Tm/ufx1yb8Xcm6O+Gg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVLjTLRDBps1bzh3axUBOpd1hdRA2O+metYynZzZFWyulMH46IybLwNCKXXa?=
 =?us-ascii?Q?DowlA/nwzyD2+HQiEyNzxdUdA7awIPrpPdl81xoPYgXTG/GIbnOKtauzmyqK?=
 =?us-ascii?Q?AZJLVZ/5NPQw5u37JlFskY93ggLHQfT1C5OTt7PFL0IpMVp1ONoqd0U03q5M?=
 =?us-ascii?Q?yBiD2iJS/3ayRSeQUocxARFF3weBPNjCYRCtPyYnPxcThy4pyh6GCuBE43xy?=
 =?us-ascii?Q?OvKHMvp2LRV8yRMHy416/gSrSqexQhZ9RjEE7VXR3HV1UFwjy/zpVXsRe6V/?=
 =?us-ascii?Q?sZ+qYBNXM2eqQDh+Xyg5x9k74JuhsEEoJuhQzN3CIGztSEMihyFeKzwQTcR/?=
 =?us-ascii?Q?2TkLWpzJ9h7qgRCBOKcT1d1ys41HuDEElzOfmqFPW6OqX2mQ+Mvm1XuFzvFh?=
 =?us-ascii?Q?zwYlZxnbg6D08oCyjybdV/WzBzCMmb4ZVbC2wXjf8Nav7U3zqQrNMsVV9kN2?=
 =?us-ascii?Q?lWBaB2F4S1DFoZgZlhb+vaKEx5e65PttD5/tBNH/SGrsnW77eTbX937ERi+J?=
 =?us-ascii?Q?4J2kPoqZWvd5M2KLJ2GOSjqCdle7hJ08m999/ZxvAKmd9s6CIDMoJ7VUPWnr?=
 =?us-ascii?Q?bRuj9ACK0zI9hVsMs9xdLzudslX7cLhdCxb4+cERgIy+w3qlXVjHe6QuSW0b?=
 =?us-ascii?Q?lGjAaEEybsbTahNn3COdwAD4ijJNBiG0nJK2V8xi+sJPoZp5AGzVsqFTXh7x?=
 =?us-ascii?Q?tT6U3ey2Xn3+eY95cxZTyrs8UpjF/FUL6RKoBjLc0hvXK+36xrnSQVMFF3Uq?=
 =?us-ascii?Q?YksrrX8VPYQPLpwqQ4fSnU7hjnxvJftXWjPuioVSutkOFG610xNXVhgIXjZ5?=
 =?us-ascii?Q?y0d1RZUvDX2Y2ttfV/lu2hVSH414WCmXvx3gB0ORvwZMsCy3XYys6m8l/p6k?=
 =?us-ascii?Q?BXqJIBtqo5xb6uK3dyegc/zzvnZhfws+yqxH12BIaO+mHKFQgNRLu4x3P2Zg?=
 =?us-ascii?Q?vlK6arwFevk4tBypqeO9oznDH4zREuwKcYTmeqkfdq1TfvOx46KkVPK1dHbe?=
 =?us-ascii?Q?0oP30rpqt1NxPIa7ZJnret6cOtX7CjmdwZBVKLxAZhCv35zSFpQ4hOKSLa2e?=
 =?us-ascii?Q?KEfct4tSzvQoMA3ptLTp3hw5gRW9p9zJdPSzNFxoNYzbFXBh84hzdko3IOwR?=
 =?us-ascii?Q?rwhjf5n3NYanrsbBbhhdnsAUS8WVM5QF/6pOS3Y9K/dkyQ4EbAeHbZTk6/ZW?=
 =?us-ascii?Q?C6808ooB0uTa/zayBA+C6RdU9OI7MlpJFv/orSLfF50qvOfHyQ6Tmc9kZACr?=
 =?us-ascii?Q?w+Dl+GwFEi37UhVjd3HQOzPENVNS66eQ1EwXaDmWLpJ2H1+8mqfegkQK/FPk?=
 =?us-ascii?Q?gE9gjE7ebEIgavDUGpBOdk7yAHsXH5rzP0LpLUyFP36yuLkJBYnkQsUpZzKf?=
 =?us-ascii?Q?Vlg6agxiUTuFXyjDl6ohaHuGde2sJ6eL1wYx/PKYJmFCXu4DsvgsQjLdWFnm?=
 =?us-ascii?Q?Rl0UNvkWpsNKRGhy2D3IXqcnchyZSCz436XiBCy9RDgeXVfkLLex+J9suFU6?=
 =?us-ascii?Q?7+nkqK3/0eJK3ECFgQUhsYl7/3LQhoikORKs5a6wL3fZ6eJU6bV7LJpYBU+i?=
 =?us-ascii?Q?bl/v1bf82CWDvan0zqxUhhaYSW7OUe+3krmWJV8N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c52f9f-9149-47ae-65a0-08de117324f2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:58:57.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkaf6/IxjC5uVe4AtbsGYyJL2SUhaDZFoIK3fdPTdnfNObIslEL95ci0b7RnLy2/xZLaHA3/ICbgdQ0zhhpRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

On Wed, Oct 22, 2025 at 06:26:35AM -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 09:53:46 +0300 Ido Schimmel wrote:
> > Testing
> > =======
> > 
> > The existing traceroute selftest is extended to test that ICMP
> > extensions are reported correctly when enabled. Both address families
> > are tested and with different packet sizes in order to make sure that
> > trimming / padding works correctly.
> 
> Do we need to update traceroute to make the test pass?

It shouldn't be necessary. There is a check to skip the test if
traceroute doesn't have the required functionality. I'm testing with
version 2.1.6 on Fedora 42.

If it's failing, can you please run the test with '-v' and paste the
output? I will try to see what's wrong. I didn't see any failures on my
end with both regular and debug configs.

