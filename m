Return-Path: <netdev+bounces-149162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871849E4920
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E40818812D5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833720E6EE;
	Wed,  4 Dec 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8/c0vEi"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08C20E328
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354821; cv=fail; b=JhZuZ6S3dq5dOzud8YLfjZe51Mhxz3Rf1GnbTKl2NPFt7vZ6UnMoZcpQRA2bXeFGeoEzBH23UheZlqovAv3Jko9/v5jCGOnmYEBvOY+zHD9S2qKVX11LihcdM2tF9DjRpa17kVXNAb8T+/z2IiX7OS82B9s28XxOEs6wg4vjq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354821; c=relaxed/simple;
	bh=VDN/DpKdxOmExKJAU1kMGnL5V5CVQT4q/eG+rlokIzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7x+v6a+RLjsbuh3v/WScXAcvMUTANqj4jQ3QuePVzbBdwYpVuTu/NB4NVmWWAZOQ2wGbqj9otInE0eBURqte2DSYS1YdQzdZvjTMniKpkbhgH7zyRwPGH0lU/ePt/bmWYD7LdL2L0wyzNWZ7vXCMdWDLbCvTZKHlOeX7Owv7EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n8/c0vEi; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geVZFHPrJEJx3n3e2yHL14GcLar/+jz3jlc3Pme3YXKQ0oODLQRLidu6Cy6iUlR6TKNk7AV/s8f8E2HF8r0NDlzmAyF7KwKExUOP0TjpH3Pv0q9XdQTxCFddi91q7sHzOcfjpz4cf76Yzo9atrw5KPW69KR0ltcALaN553mGmTLChGq0m2afcHNUOpo10D3oUHnFliX9fsDVFz6Ue8owTWXacsXwPHwFPUuYHmuMZ4et1NrK2p1ADc+Aapm0P9BQypUfWYGD1J0GBsfLZdN8ikBshOhWpsT+VrcFGn2Xg9ViipJ/DiwpET+azgIWUFRosWiIN79MLV8DZIO8wCQ2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrXXUUdTuMv9qOMFetXeCCsXh5ZT6qPQE2lHndJKw4U=;
 b=eZFuBHQ+QAOBQ6b4msiOFfF/DL42KPk+UGosNpYgVEQZ2yQrqnuItA5Iyah9CSAlAioXltNHuS34Skoqhm1R08Ob3lAFZG86i23XhOcO1zEJPXStlAc/+5qrIRNplKF+kY73xOAuM2stsPWAGhopE1n4ROyS6+59C7QHUelQ+kiAKSrR5RPPziM0Ce+RnHzh2ZMh5ujV5BJv6RRz26fLHyIVTk43yhJcG2xXak6YO5sutohEuqiF/NJ5PjDGTSFV0RfS9QI+5J5FlZdq9UPTK3Q8paxgBHw9Y/CRkkMqzsBhp+QkceIMR7f46BtxOUh1CfrhRB3qI2BHJmfrPeBUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrXXUUdTuMv9qOMFetXeCCsXh5ZT6qPQE2lHndJKw4U=;
 b=n8/c0vEi3/UYRaD75i2ThrIQyPO6MmTzLOmCdFPx0dtQwm36n5q9B5qszgJb5fGJ6knnHioQJt04vyWCE/jTNTHRi/LRYyErLIpIVwIxp8cFaSRA2fMX5cM9n40Nibu8hvynl6/rbNWnFPFSuxxnAtVG4wNdingZLzOohsKvbRmQFvE9EnEyChtHLqBbdU2dxMh5Hvij6f52TMk7rZBNV+hswhVuKF48pigqlks3pvepB7AGoEaLcAFmde9sFVkMCJtTYH2BOk7Aub32KUg+vv/xUYjOrsRGAf8DSMvEUO0p/Ehf8ayLd4Oty6YWe4XvJn4B58KfHj78sHLgUH9wmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 23:26:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:53 +0000
Date: Thu, 5 Dec 2024 01:26:50 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 04/10] lib: packing: document recently added
 APIs
Message-ID: <20241204232650.67xald6yfbhtz6a4@skbuf>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
X-ClientProxiedBy: VI1PR02CA0049.eurprd02.prod.outlook.com
 (2603:10a6:802:14::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8e9863-4a82-43c3-f2b7-08dd14bb2316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKNNW7IhOUcR466pr6fYTlHetq6AzhcxPU39ysi0Gof3moOpNvrisM+oTkrF?=
 =?us-ascii?Q?iRuoH6FhT7R0g6BTqrGhhoxww7/hhXHyI0ejT+0cBGl34UskGEUU5QV6WNMc?=
 =?us-ascii?Q?0RV9K5kJwYCOSkbXmRCKmY37tKMRR5p2nwSr4plvZaKKLN4XQe769FS7tWo0?=
 =?us-ascii?Q?LwWFundie4U4W7jRfC3F5NKjFKeCJg7R8oQEmcB51Xh/19UUat14h8Od+P1R?=
 =?us-ascii?Q?aFXTKM1BrYztNZQZ/KbnpqLS+UszPGnYfwq+28o9BsY8oc2BSIkFhUMO/Um7?=
 =?us-ascii?Q?XxbqXs0ek0YweDoJkzFhWiFyPOpoGhE05hrUxJQDM/DLNbtjVM9w+JUem6Ku?=
 =?us-ascii?Q?ruP6SIuhCDTnMJZIh8BAe2euwmMzNXdSQrQznPHYamVgbywhSsO8Xta5WUaP?=
 =?us-ascii?Q?Is251lx+z84oHATDMvvmChcarTI29s/R+syRY0lehoF1lLmotPO3CKMaq43q?=
 =?us-ascii?Q?VQVEAZVrh/OKj91UQYz7mmbGzLKxrs1Gu8ucoN4eAYGgTP86QUNLyhqV21/4?=
 =?us-ascii?Q?BStvhcfzihlaNjKpr7nY3o29eCk9s0CmBdMbEdhGhA5VJk23BKZ0hgQW2MM0?=
 =?us-ascii?Q?wHOuMm2rwxrVsw25vaIRKjtAFFX7yPnVdCFpMyueYJHNQz1DY/rFN2Sw5nAl?=
 =?us-ascii?Q?6QUhB7RcyIhe6oa+ftMHiagSBZi0MZ7KBRiBQBgI4ATusSSZVu8zQAHHoxPo?=
 =?us-ascii?Q?LKWt0NRmy7Ip41ynN8DhdlnnGrT1OVlz/VqC6ZZPfvv8m2GO0kfaQC8nIL45?=
 =?us-ascii?Q?XsYobilbFLgmeGAdkVSmfKzKZzNw9JZ1Vpj0238J6IdHPWU2EC19Ut+IyxU9?=
 =?us-ascii?Q?kw1NClMbNvUeVYKrDeBmlYY3ccHOzxZJWZNa10ubWXx2fvUAdwBlErduVPHc?=
 =?us-ascii?Q?S5iGMlFg7jau9PAophgh5QYx+9d7Sudqa2RuM0V7NBAa7ppftun25pDjHMr1?=
 =?us-ascii?Q?o0J5/EBda5zw65QEJ9vB/j+kReI3ofdz+DHh5R2Po4BhsA4rIpGSTZ2d/qZN?=
 =?us-ascii?Q?srFgF1YLqktAPyFDieDkSEzOLw+iPwHrR6ktseNHe535W6QeJlO+DfoIXSBy?=
 =?us-ascii?Q?XffnwyxRnKAcJIaQoqADvEK8GKzrOBDBeWmGFx8vO6+hYyGFaFm1hpQ4OKqo?=
 =?us-ascii?Q?1sCodzVK2VZjkuAbp4TIKygf1v7LW740r1RhH6vmBzrydISqE5VpeGAs4yFu?=
 =?us-ascii?Q?vSpQE1I8Y0Oj2AuNEilzwP7jE+3fIOgg/sZUPUfl/Hu0MmGoTIqWcYVq1cmD?=
 =?us-ascii?Q?Ez7h+I2c0+Odssu4T/g+px81fNMJHNCrfY0YNvyNR1e1xbRbUIolfYtriXin?=
 =?us-ascii?Q?V27jkd08ZTNiXC9+VQdV8WhRCs7A2jIXbQ16Baw06TxNuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MLetcawMGuQegjDXolnfc7XrmpXNHPyJY6Y0ttkMhed5d8ZGAkTrqV782cx?=
 =?us-ascii?Q?1vpSzn5vRgX0W0fwfd3cdE20e13I0yVDQiLAydDNs0Xxgtay983vbzQhvtWo?=
 =?us-ascii?Q?NT1Ms+uc3D8B6c5oRB6vY+2yO5m1MKHgkW/zQ5Vaau8vsrsagLVMWIIVJXhN?=
 =?us-ascii?Q?fWUw4WSWgz/CbnXRtBRzzhPO6ntFjEFH9Jyy41sG9YiqewFP+zLCSPX/iHc/?=
 =?us-ascii?Q?RDiyaY/Qgi+668jG+ldZ7QUumJv3zqeqFlRFQ4JV+aqJeL+wrwygba7RmDt2?=
 =?us-ascii?Q?C3/QGhWoR/WRJSd/zLpBvlkD1jSzTwBp2eWQvFn1JGximL7m1KxaMtuuOHe4?=
 =?us-ascii?Q?0zlBz4km2vnBnbmAsZLns0kABwVHgcVWeAXCuRVtwq2bL9aYLM3LHxPkToJc?=
 =?us-ascii?Q?3a6LiMwYnxGk4A9ulgvtG9avjOAAT9PPoix3L7tlwM8GqSCYtne87LYsa0SH?=
 =?us-ascii?Q?+G6sLedsbH3OZsdSNwqymGV8LUm2StiXNNyB7MDOluxPLS2U7ttXWY8npDjj?=
 =?us-ascii?Q?3KW+pNdMoIWSkQPjoFgv6HlIKKrNFQX7iO8Rxj8LiRbhgQ0JcFp8VPDQlujF?=
 =?us-ascii?Q?0N0mYLt8wqDf/nNakllXSq/Fgh1TT+ZNNTuh2ruVjL7UqF06/Yy+Xa6tzc3S?=
 =?us-ascii?Q?aTQlCHdqcC3eTnJCYEyn39aKR0GPGU3nvwFGpv0WunqCh4aVF0SPlmB/nzzJ?=
 =?us-ascii?Q?zmCYX/05J6h1xcHT+kZIXR0+RRpI9nEm3V1euAYMsIGB6/Mgw43fnigzm0da?=
 =?us-ascii?Q?XgB0ZgFVmtGZRpSZ3laILH/FEZtn62IGFyIieQNwHtfUaV7uPUQ6+SkAuZsZ?=
 =?us-ascii?Q?JsaN4k9Eo4bGxptc4fIva6D5/s+hUJs2CeONUpirocavNQrdEqA9nSgTU8Xj?=
 =?us-ascii?Q?3YPSsCuRFxv2Z05ddzD1VDdNSEymGWqKAf/v8WWmuJFTg+l9uIN3D2xZW+m1?=
 =?us-ascii?Q?72enkAyGYhgZWT4ObEjLKT3gewYZYceyfbqSJ08UmZqMsZIUKsRqNul3xm5M?=
 =?us-ascii?Q?IlCPSrLMnVrbJQum9Fj7oQ144OxQYeW78VBLLd68s+6d2ekUutc+yKHMj3Gx?=
 =?us-ascii?Q?bR+kp5rVJ1S1sgT+jcOsYUGDjDnIi9R9Fz2ZXarU8s4EZX8pv6rDhbgEIf5d?=
 =?us-ascii?Q?gijhZuaKQsxVoHValpRoxvejKwsvoXVrMTibp9QkoUIpqS+qtvqDv1i+WTuv?=
 =?us-ascii?Q?HAKmkFdIrzBxC86IYEePgKcqLApsNfMqYvDsRJrLapk7cnEqoms8kQpEE8yy?=
 =?us-ascii?Q?/0FizwrD9O10iHl3N+L6MW0f/8Vc5toD0CfeFS8GrrOVkaft4gwtQ+FicOjB?=
 =?us-ascii?Q?A/6nsf+auZWwL8cTe5VEQ8sKpTV9ObxcU1XQwG1ctOXMoEMdTcQVk/QZG5jZ?=
 =?us-ascii?Q?OuYhx12a0aLognuuHnBengRiV7xZ5jQwIo4ZJa3st81iIOCArLsY74oCNQRf?=
 =?us-ascii?Q?/8eBtx/9iCkglR0BaXvT8Qa4UbkNeUlA7vPuvMkttVy5AyroQFkH+Od2JE9V?=
 =?us-ascii?Q?hwqxZGARKKzk+cUUhyO7uTg0DNavLeY8hUgAphzfVHKmLsbFgNoz2RAT7T4R?=
 =?us-ascii?Q?5fKnc0c/NFpJmi2BZn/U+n1BhkIc1ocHvxsD1tLZjogY9wxjLW/hmUNxeacL?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8e9863-4a82-43c3-f2b7-08dd14bb2316
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:53.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iepbfIsKyqGZLZ+4P6IOIy5XXfAqWL9YX56OvW0f0JOXNKIX54DtYVfdmBtGbmDPAjCuFjj1GzxVolMPUCDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

On Tue, Dec 03, 2024 at 03:53:50PM -0800, Jacob Keller wrote:
> Extend the documentation for the packing library, covering the intended use
> for the recently added APIs. This includes the pack() and unpack() macros,
> as well as the pack_fields() and unpack_fields() macros.
> 
> Add a note that the packing() API is now deprecated in favor of pack() and
> unpack().
> 
> For the pack_fields() and unpack_fields() APIs, explain the rationale for
> when a driver may want to select this API. Provide an example which shows
> how to define the fields and call the pack_fields() and unpack_fields()
> macros.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Documentation/core-api/packing.rst | 118 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
> index 821691f23c541cee27995bb1d77e23ff04f82433..30fc2328f789920e27a1bcf3945a6793894ef1d4 100644
> --- a/Documentation/core-api/packing.rst
> +++ b/Documentation/core-api/packing.rst
> @@ -227,11 +227,119 @@ Intended use
>  
>  Drivers that opt to use this API first need to identify which of the above 3
>  quirk combinations (for a total of 8) match what the hardware documentation
> -describes. Then they should wrap the packing() function, creating a new
> -xxx_packing() that calls it using the proper QUIRK_* one-hot bits set.
> +describes.
> +
> +There are 3 supported usage patterns, detailed below.
> +
> +packing()
> +^^^^^^^^^
> +
> +This API function is deprecated.
>  
>  The packing() function returns an int-encoded error code, which protects the
>  programmer against incorrect API use.  The errors are not expected to occur
> -during runtime, therefore it is reasonable for xxx_packing() to return void
> -and simply swallow those errors. Optionally it can dump stack or print the
> -error description.
> +during runtime, therefore it is reasonable to wrap packing() into a custom
> +function which returns void and simply swallow those errors. Optionally it can

returns (...) and swallows

> +dump stack or print the error description.

