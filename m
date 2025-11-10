Return-Path: <netdev+bounces-237360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44ACC49917
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C1B3B2A03
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E40B33F367;
	Mon, 10 Nov 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jAGov41d"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434942F83BE;
	Mon, 10 Nov 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813510; cv=fail; b=bOGr15UUp1OU+vG2OObIH0qDyMUyCnoT1SWyJKeXO2RFe282r8olxFIcCiKyrTnGWk+0xfgR/4JNzMF+J2a9ZkSac9ifnYc/3WUW2hfqS81TbPrifbB+udPKc5hZq1Zyp1Jz0982VVstTK7XdmYHpKdvM5v/etuisflGMYmD0+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813510; c=relaxed/simple;
	bh=CD4U0+vCOf9km/NSWbFhkZpbxjiqGrX6Vqb5ykG3c2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hiDe+S35M7rK6Y0N9gNC31dzFVq3aLa3HOg7b87lpMf8AEm9ro9RsGqY3jzQW9iCjBacHqfCebUDVMaPtofURdJdbuqUNxQO7zXhD8cZXP2edTc+rJVN0YZwjybDyoyDRyuL6gKq3XhnWQ9UBZcGJT8ITW7pFTzGT7C72iLcW+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jAGov41d; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngRLlxsAZLptQ+szicubky5/RB8+9nfxhghTRdxr3vdg32Gc4fjGRh+cCFhVze18uwPIPp7mSZgc4bZRCHjK98/ssbg05qbAyY5W44FD/iW8OKRWCUYZE+artpO3p3LZLveEs+MzygK4TrJOx0w3+GwFOBhrcS8T83WSFivudiKWnCEW8s5rVaoG8JUUUZzfHMKf6vPfNe0VWRbki+4XeBg8we6oFl540snEEUdbrX85u8+ewhF1Wugfm9/2mKSVLyq+0ToryLWVqQrZbky78GHSdIg1LrOZ248NJFEdUpMS2P4L2Gir7i3bFIkXWjtosqCm3JjhtIEOsHXSnKFs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQyG8qGSv7PFV7OrfUPNFJNGS3sduW/Fz6ivPzGSIck=;
 b=QRARIGSngG8Ioi8dlCMXQzf45jNNkQBaQY6Fd7c6cybrUCEYDeroyhaSh5uPTh1EvzakXh841zN0djrzfFYNat51YndX4t9dQrOi1HwGvUfv3VqWYEVvXiGUWd+yDorh4fOMBZrlZwKh+zsMyvzXwSjTVyRWcUQACUC5lQ82yH5GE/qWZ2/uMs/4/y4YiLWgfb/YiMEPno4+XZmpDUGyJUgPbZfTmv7f2PkE2A4Z95YE6oq0ZfmAXSBI2yV4BHPNgi7pixGQ21QeB4zPDvRlzLfxmpDQJGvgUyR9JOywdKvC5wMR2TePL7zFDoBwkMPRKG6LBR4ULHAJmqbsdIhy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQyG8qGSv7PFV7OrfUPNFJNGS3sduW/Fz6ivPzGSIck=;
 b=jAGov41dXdw2kbPfLspNbe/9hPd9Wi/+vv3H+AtWjaFtDiWfpcG5yM629NQVOGD0ARb4N/1BN0CcfBlGd4J2blGiNSqffsz4AR9A3MJIpmmzcVz/rNovSltLpNgV1n+ETXIZaqqg/lmSU2FnxWx6qLzn7tL5UPu4euPAf33dcvyHPWTlFxFo/gFelnxRfMzt4kEJMZLprt1QBQdwjBRFcCltj2LY7fNgR4ldGdwdmKjx21Yi3ANLCck5+sHrymd+yZlAdzvOZIpR1Qlv353rHMSJNGSMrsRup8z3HlkUknOrpiRQgNN0VKhBfHxbADmGD/lm31OD5dw4OdYJpnZnSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV1PR04MB10992.eurprd04.prod.outlook.com (2603:10a6:150:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:25:05 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:25:05 +0000
Date: Tue, 11 Nov 2025 00:25:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
Message-ID: <20251110222501.bghtbydtokuofwlr@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110214443.342103-4-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com>
X-ClientProxiedBy: VE1PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::33) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV1PR04MB10992:EE_
X-MS-Office365-Filtering-Correlation-Id: 46164e34-230c-4d96-fecc-08de20a7ff60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQCtMIsMsv1twK9/DjtHNyUrWxQLSHgZQNagHEpSlGwSRYKZcq+98cd2WHhs?=
 =?us-ascii?Q?c1ZNKfjewRkuXlQoNciE1vjFL1q+3OfzSVVE4V1gbI9tuIshmGi6gnJCfo7n?=
 =?us-ascii?Q?M06G4GJts/NHhW3VE/MQ52jGmCxyTZbe5JA7vdFskbGMsLqbDN7rsnbI+KTT?=
 =?us-ascii?Q?RJVz2yPSTGw+sLFD+YdQWk1wZ7KoPRljNeiNgrt0oQwlL1BBGKerDV9guwhq?=
 =?us-ascii?Q?An2jEyzuEeGkrJhnwA4BJwLMNrsIHcpOWgTAiBMgRUGckrLCLdFLvkUxoI5F?=
 =?us-ascii?Q?XfCMzZc8xFN9gH7kwSZpbyLO2JAg/IW2N5GBjgqEd7pjROb7vBY9C4SFqIiv?=
 =?us-ascii?Q?YcD8r6ytZgNwjp7M41fDeWK2QhAElVmbXc5aqFEIx/lWukgZxlHeNnrYfIVp?=
 =?us-ascii?Q?EUy3VI6e1hXorjlhLMgqHC+DUF2JjK8GdOaJykOzyjGEuZIN3nlMqxsaz/SL?=
 =?us-ascii?Q?vR8EjN4n2Mpe9NLoGfIcIWOJLbOK6IpL+wvIqJTJoSvtHqXii7NBAmKQ1mSC?=
 =?us-ascii?Q?bcvdTPmAAgeGvW9hxZRdM4FM72ydDqBOJFuNoQdj+f3yJurEWa84rDIcW31y?=
 =?us-ascii?Q?k/Aag0F2KwHz+xyvoukrT6V/HlzPAM19VHJc8rdJ8QEhErHuFEt7GoqNXrQG?=
 =?us-ascii?Q?aynXLfBrVAAw1vOSHhVGb1MCGGFQfyJXvBPgmcAXksznXgTKqUQrn+jcKxAi?=
 =?us-ascii?Q?kainsplTv7lzRtY7fx0xkMRvw8k+zl/AA9vh9zSOvCAo3tRSExQ8qxUK/Fjs?=
 =?us-ascii?Q?K+atgDRzfMiELhf4XXgU7wKi90sQYPmjxqdA1b2nAYWZ9hVL1dDYkpL3Rvtl?=
 =?us-ascii?Q?VkXLNK6MtmWhgV6tsXiIX2rDBKuWEWaRRDeD7Ihy6b8e2VD2SEsrJ0kjiU24?=
 =?us-ascii?Q?bRFfkxYREe2sISIDgaMHxXibp3aOOhzmdmNfwI36vHUG4OCsEhgfak6SILVQ?=
 =?us-ascii?Q?DzGg88VR8qOtJIDEVTYjLXQWQNSZ6KSSWbEdRROTyxvEnHzC1il2swnyyhWb?=
 =?us-ascii?Q?dyj+uzxq1MHBc/tvDqEMzTzNVYgzXAj+NuKPkn81MEG6Fad1KGGm+jZw2bmI?=
 =?us-ascii?Q?Noy8y14WKuU0nH2BeKap2tAnTsLqN4qBb95XrAye32aOYioBYERu+SFrCQbf?=
 =?us-ascii?Q?3zO86QW7keFf28UnSlbwQ7ZzB6Op/7Y29g5EE4qMNyYcOCkNPP8K6cdAaHWc?=
 =?us-ascii?Q?RzLGzyAcqrxiGOaak5MAOqnYJS6UECZ3rrAWe7IIB1LHyh/tBllnPY9vnLBb?=
 =?us-ascii?Q?iMFl3RtcnTTAmgqgW+CypU2awHcUbfbERWD9DsMLivzf+hbwFxpOnVoJdI20?=
 =?us-ascii?Q?JgX0S3RfNG0z0O+D9aSzyS0bEin6nvuCFnaOlBwDaLxBRjkPPtS9k94Ug0Qb?=
 =?us-ascii?Q?BLJ/cgOqCl6FVJZyYPxJ8T1SGw+xCwBNs8c7Hrocx0HE5yvK2dbahnI4C4dB?=
 =?us-ascii?Q?yS3cwBGJ3czOtcxMyXLKjMoqE3BiHBVW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/HioXQTr8nt5mABda4V0WNwXRf0zREdM38WqFzYq6iaYwTVj3UVvG/W9fhCh?=
 =?us-ascii?Q?7p8Qy/YF3VZlxiajWFY94F8r+FMdKidJt5uAFpKeA8gHJY1FoXHzIILVT6nw?=
 =?us-ascii?Q?+5AaqT56AD1l9wqKKHb6s1ME2JGf6EIWLvBYWJerOjTuQMa/52WdTgNtILww?=
 =?us-ascii?Q?d5K1GaYipT6oK3GVsyjzKZ7THeAwRrkQ5Expz/SA3lqJR8hls6l6+B7X2+QA?=
 =?us-ascii?Q?DWtkl5/+MA48oUHOqs1rEWIr9NSyDMBHdYqinh4NWSNiflj/AjMIo/RHAVp+?=
 =?us-ascii?Q?sg8hqr7dWH0itGWetzi+nYnQkxgtFnTDt1EzecJjocNc9Dyb/Z4TkdgFw8zO?=
 =?us-ascii?Q?j/vaJzy5hTibIMmT5ByDluZoEtMovLVPFFtfsBSV/X3UN9JP1GH16UbsY8v3?=
 =?us-ascii?Q?3kwSN1D/+akB5Ah1u2fyjEPZ05hW7QFYU25JqdblLacEiu3ngXvf5TAAmDI1?=
 =?us-ascii?Q?Q43AYfsZLhnDplTB6h5c6Efgo7BcJUTc9NDXKjNjRa86Bj9kUKKkENbTEHS7?=
 =?us-ascii?Q?4+zTvFeTNkYl8mb2SvkBPELiuMabRViqD7Q6Nfj8Gqa+opo3mGEfa0zM3+gw?=
 =?us-ascii?Q?aTP5S1M2pBwnWfTWFFWz+sZ65j7alCl4L2Pr+NDKD8tifupyYkCL+gadIajV?=
 =?us-ascii?Q?OfuUnfgNpXloAuTgGg2Zk0lKMwfgonEM6AFNXfH/DeSjB0R+apo25UgdTLQD?=
 =?us-ascii?Q?TloiGLQv+ni68JS5rQhjSQHHkzW3oBxf6Q2NlQH1kAEwd9Wymu8xD6gWdKkb?=
 =?us-ascii?Q?q0ev+dnztyNpY8S2LAdHSHfIWqDPCBkYRtBuQIsahwO2BjK7g84w7QUsbbS0?=
 =?us-ascii?Q?015it4JCwBntEQFxgtn7QVL7JqYFGn1BOgbgSHL8GU5UU8mdpeXHFs/s284J?=
 =?us-ascii?Q?fNYTkx8NvsaK/kTE/SXdfb90JX/Gy9Y08BU+/XM7DU8ypNr34VdYZU9YeYZ4?=
 =?us-ascii?Q?F0eQY428rIik99mx4xr3oGU50noib2Zifq29R3C/ZwqtllkxlevVpnM8svb2?=
 =?us-ascii?Q?U53svIg2dV2taCcChOV7xvPfFlizHCOkNINSLNjWuWyIO3mvcXtWuBhtpTRV?=
 =?us-ascii?Q?XPxQc6973Sm8RfF/VAV5RfYr+KCXRt3JPgRUcU26Hk4fjf1rJvRAFGj6ulFK?=
 =?us-ascii?Q?MJO5GvBIhw+g6nJTttgUXXwXSojt5YiGGob0aZCpsg7pqMkJ9vHvDAMyP5be?=
 =?us-ascii?Q?zzynhjbWiD45ay2t239k/x5OUnsG7NMMruCQ1wOSg/9qRR0v79xk4J52dCxq?=
 =?us-ascii?Q?jpL+LOHYKdyh3lSUrldGmpzFHEfr23SAJ8HLVdYTjOP48sLyQ3grAfe4U41h?=
 =?us-ascii?Q?bpm/X6ZPmAXz2LsiqDK6o/C7HLCgAtj0wocrmy5iH1nkJtALiV5mx43JPo+R?=
 =?us-ascii?Q?/3SoxSvKRRm64UsyMyE1TkIY8INEvZ7yQdqgsoyReTbRdOfiIdSdsrnagK+e?=
 =?us-ascii?Q?zYqlhhL8A+/G31gUU+b337nihmEXr7N2uGlNUWI/zwW82p5G9wdNS7sZb8i1?=
 =?us-ascii?Q?OKrWM0wLrxGMyzAye3bSOovHYsMXN3kUoT0WoAw/a9OKU6U6HDbCswodkFvu?=
 =?us-ascii?Q?SAgxZWhdYlzUI5ScwLECrG+cXp+S009DlAHfHgzl+/zzb21Cj2guGT+eitb4?=
 =?us-ascii?Q?0Fpx1zNkNBlErIGY284pxQbu/BTW1+tptQpCIvgiVjA/N7yJNI2tyrO+xSqw?=
 =?us-ascii?Q?B4CLwQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46164e34-230c-4d96-fecc-08de20a7ff60
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:25:05.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysxgmYElEGn0D8XTra9cZCU0dBe3RzDMVA4qOpqDn1Y0wBOv26sAoZEolk4QUjIhEpj3oR1cRMaoE3VOcoKEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10992

On Mon, Nov 10, 2025 at 10:44:43PM +0100, Jonas Gorski wrote:
> Documentation/networking/switchdev.rst says:
> 
> - with VLAN filtering turned off, the bridge will process all ingress
>   traffic for the port, except for the traffic tagged with a VLAN ID
>   destined for a VLAN upper.
> 
> But there is currently no way to configure this in dsa. The vlan upper
> will trigger a vlan add to the driver, but it is the same message as a
> newly configured bridge VLAN.

hmm, not necessarily. vlan_vid_add() will only go through with
vlan_add_rx_filter_info() -> dev->netdev_ops->ndo_vlan_rx_add_vid()
if the device is vlan_hw_filter_capable().

And that's the key, DSA user ports only(*) become vlan_hw_filter_capable()
when under a VLAN _aware_ bridge. (*)actually here is the exception
you're probably hitting: due to the ds->vlan_filtering_is_global quirk,
unrelated ports become vlan_hw_filter_capable() too, not just the ones
under the VLAN-aware bridge. This is possibly what you're seeing and the
reason for the incorrect conclusion that VLAN-unaware bridge ports have
the behaviour you mention.

> Therefore traffic tagged with the VID will continue to be forwarded to
> other ports, and therefore we cannot support VLAN uppers on ports of a
> VLAN unaware bridges.

Incorrect premise => incorrect conclusion.
(not to say that an uncaught problem isn't there for ds->vlan_filtering_is_global
switches, but this isn't it)

