Return-Path: <netdev+bounces-142020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9B9BCF8B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6291C24B2A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387371D90A5;
	Tue,  5 Nov 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXCCl/sw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7221D5AD7
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817347; cv=fail; b=gzLWNs1RGMUVMvMJm/xTbgytNszeZ4xW3K2pcIgo6x0gxrc+8S4BLZ6v07Kg5rmJDXE3EqoP4CPqPFEhwlgNlHzGiasUsdeUhS6liXD53erXixzulJdBg21kDYMwOUGUywuxkeSsVEIMFgrMUbzxq7AiWHN/FA7PEj4AzsPef3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817347; c=relaxed/simple;
	bh=KDt36tKw8rHA37InU6SxdBPvGAHirybH1WwIDbHGb7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eNCtSWB10nLvcjOC2r6Ga8J0yqlr4IxKQkVbo44MCrU7GRyXLU6eIx6i4/F1sFwDJ+bIBz+6z6uVM5mtT9iZdzzHfWgVJOy+doJgUvcbV6FgbuSo3d3u7ryj4FDRDxgyLm2bfS9mjep/IHly+ic9ZSIaTb+odxgITNi56EzhKOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXCCl/sw; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtf4dmRaSWLHo47pXPMt/4K2/ZdSl+SscZ9O4qAWY0wZcJJN9gT3Q6cmAHiYkF8+g/dtdF96mPgRT3+ajhAdOTBCjXOiSRzpWe6+J1Iy+v+ZCnTs65orDIVfaUzNeNnVDeF+N/qLSe2rgGNwqXtUYSzAQtBfmUbk8CyHUar1AX5SsIzV4BF/EqsClae3RrpPa5UzhuJlfrc8VBWSIKxxPnUOmAqtFN8xkwkWR2lM2xnfol7wUlkIm613ikAyqSbbWWSswrfyZtqmcwm9TCzM42HjtFljSmP+pPcQ0yAr92hK/DYHY4KxdwO76qymJiFBIc09ZMMgBOrB/yWGIVXVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rn6/AtOwPx+pL1Bg+nX/DfwIAnRAJKh7vVwGS+zUms=;
 b=raX5SpTOKXz7L8HKo87tsiosRzrXTEAApABqUTUgiRuegnmnz5XYwLXiT82fys0GfKXTyr8skwFroPUZhqq/ILAu9jN400SVO/l4pfdeq72b3nfrCMusRZxeES9la59wW4weQX4wPoktm1w5dAiE1gDCrvCxUJaVRTClYi2cHATanfwKY5WZdQROUIOzfpudz7udjBl+dHUC3C5vJAPN7Yga2U/1QYbors10ExMwqLozBB1c+eWaRY1duESuTOgImZdye7jqjDWUomJEe2dNmJ5qRpVitZcpEEJlu5UQ6InN6hX8xYhtGpOf7lbtlpLZeNPE+Ueszv+lRpP4YLXNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rn6/AtOwPx+pL1Bg+nX/DfwIAnRAJKh7vVwGS+zUms=;
 b=SXCCl/swyJnKW5NMrkt2CjdJu+Qdbqi1WO6yzJcrZT/lhmiMr56YsahJpHu2YrDmOl5N714RGLymcKAQoOJsPPWrwZFkZesOxhyHixXq1z4p1JiuKmabQ5Cit+vvvd2bX1JGTtC+HrRt89uQxp3Tg2YkM+Zs4B7tKq0xzSCk0jByQzbSBdEDayzGUrJYi1d3TOaL579gbxct8pXREFwiUKgA8xuJznxUDicariT0lR54I8jn3vs5ds3nKspArZMZQojKzBoemCETQwPjKBlFOJqSpvOzfXkc5qbvCMBcCFbilkoNTvcfVT/w5TpeWZPkcIwNU7eU9WWCz1IkGEwyXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 14:35:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:35:41 +0000
Date: Tue, 5 Nov 2024 16:35:29 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, donald.hunter@redhat.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 2/2] netlink: specs: Add a spec for FIB rule
 management
Message-ID: <ZyotMdGb23YbCBiK@shredder>
References: <20241105122831.85882-1-donald.hunter@gmail.com>
 <20241105122831.85882-3-donald.hunter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105122831.85882-3-donald.hunter@gmail.com>
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 976baf41-58b0-4571-df64-08dcfda71fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50ojFarF+uhpqJfr7gZCchucrXkPw/kYYARJxwoL7GIi7Hwm2xl5Eo6oRZ25?=
 =?us-ascii?Q?7vtfhl0rCFVfV/pLbRUDSSoTqcDZFnc9qheligdHeqcAa2lAWh+i/Fe5YkUL?=
 =?us-ascii?Q?y5lownQL8ij7/kbO5tG4eS8l0W8ulp/2j0zNuSrZNcjPRoixYMTYCrABA0E/?=
 =?us-ascii?Q?tdhGA96AS740GpWz4d6bl2sWhrtqsAJp2kQQL3z7GqnRXCA8HbN8+lRN88p8?=
 =?us-ascii?Q?vfO92n2Ixs0JpO5Ayr5zRF1xqIxg0uNjE9SXI4kGsxbbB5gmgp/GpwonxqJD?=
 =?us-ascii?Q?OThVKr96PD5YuNVxgKEPHkQ9zt9n3AwnUPfF7w94CW0RMm6LthKCrbD1k32K?=
 =?us-ascii?Q?HXRtq0kigGzKs3udoF4MNZs0rWl00ixbcH3wvwwjAa/2+0Tzm5MkgLtKUAqp?=
 =?us-ascii?Q?d02RQe56XQ/lXR04rvRfgGVi35QFlGSC7ZktFRFWiVhe13HdjrgjH6HKWOkb?=
 =?us-ascii?Q?3yLJ3V2GUnuBgZslZeMOSt+8z8yfh4Zs5z0hEIfD6R9Rum8XKAb21YPi4sRW?=
 =?us-ascii?Q?clQI4dTaRYRgr5L5Ef1dHswv6pF/WJzLBXcufAS4wv0exOirQy23z0icCG0R?=
 =?us-ascii?Q?YwLEwd51PDdSLoKt5VRMbz/Vkm81FAUBnbTwzzPaMUxumf5n833bgMDMl6U2?=
 =?us-ascii?Q?b3+/yz14gLOHmZ39yuRdTzmUqhUpKZp1HM94P2dmxzZNmv7kTDAXdpJ2PI2N?=
 =?us-ascii?Q?Z/1HI0EmNJkd1MAlgumgo0/rnFoRMmg/qhksJOeK1sCkBo/tNdbLP9jUp8en?=
 =?us-ascii?Q?yqZKg1ZgWy4xeekAU+Xm0MyruM91dZrchLvyBBJeFCjXI1ypRE4zFOzcowbu?=
 =?us-ascii?Q?HLEBOwFaOO4oaEnyC3k3ldnBx3FhSNQcFmvjW290QmsnyqIr2tkgbRz+TMWv?=
 =?us-ascii?Q?P+XEo/CtcTbyvyzwwP4mMKP2bgGusMhNq/UdiwCVypC0072Db5y32Za/jRjz?=
 =?us-ascii?Q?BO6abqJrFLSL93qrP2JLwKoGmFbYtUvEBiEoSQ/00f3Njckrje3js/lwhJql?=
 =?us-ascii?Q?OYDR3r2FZ74Cone53qmSSrEHtBtdSSJEkEb90UDXuFDgu36H5VDi+qZqAh62?=
 =?us-ascii?Q?e2mtunrmINIsTgvY2O7zdpAHpuRz5pXhr9Ia8/DTpY6PED+xcGM5bhIibAQM?=
 =?us-ascii?Q?CsuAUTZD3aJTg8frs5C0RTG0dQMN7UBqoB8ROUN94RMNUAZSeGVFRLYlUuac?=
 =?us-ascii?Q?ZtbwMfgD5AUWAVa37K6L/22rfCBbnQvoVllgGQNGeuO/sgD2NPvpMIaU00+H?=
 =?us-ascii?Q?GMFjZsFWA2gLQezZGeUkygI315+kFpecDQpD7/DOBT1ayHJjzL8mnyvZe7Ju?=
 =?us-ascii?Q?Ki87mwNNCLX5saQmX7nxmgYm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hZNcIY3jJNni2HS4iFp4eAcX8o+2z37dE6dt8tp3ArhPcVMj6XC4bp1ND99?=
 =?us-ascii?Q?n6wVkKZgGYn/tZvxkgi7icZ8GGmcQ+PX5+cobd/yAW+6aZS9zIWMNG4Qz5CF?=
 =?us-ascii?Q?+T7xfEAGOGwyG4aRstIyW5lsonhwKSEtbPZ319hq4Rr3tsLAylWitR8O6yYu?=
 =?us-ascii?Q?bf2Kfn4WhwCgy775NBude1SUyUMiI+dBd4eVFcqh+FCmadBg0kV2FIVj5JPj?=
 =?us-ascii?Q?wr1sIkmZvSh0WQhF3AjI1KklWA47KsFofEVh7cpmEm8ndmYZzeV87NJW+0S1?=
 =?us-ascii?Q?Cpj2A+vn01cC2s6rPxRGQc7rzA5OjXQ5F9iTbmvj/UAxJY+tLPPaWkAfkPTp?=
 =?us-ascii?Q?WTFXTEYyxslwcltDFiHDsXEPnvIg2DZXjyC+2NjtYbx4gVYYcO2bcmfaF82n?=
 =?us-ascii?Q?aKqJLSLvqy3wSdpqG40nu7IX92FycCuP/HLGJsKwiObfcz/mJAblwd0Yi2as?=
 =?us-ascii?Q?Ev9r6mGUP2riBnsBsFgcl/IZ2VhAcH/NzCQgTzS4u+fuTsmVHyGad+tfpE2u?=
 =?us-ascii?Q?8YlxcNtXmmGbyGNeFgKajBDRX0RkZjr/Ja3PKbXn/MlrcM65pJPwAyisoRKF?=
 =?us-ascii?Q?8zmIeFc2Dtbn7i+cq1IqA5NHbkQVMJL7lza00nV9HiIwi3v4Ls9QdyibgOvV?=
 =?us-ascii?Q?6inoj6yv3dh8eLeitjTeg2+drkXGO0oPPI+nSpBvMyyEAuESZvtqsTLlXgJA?=
 =?us-ascii?Q?JhAwtpwOoOTo/ffxhZjB9NC7JeV7hBFHkDn/te73Cs4LCt/+MLHaFZgHr3zn?=
 =?us-ascii?Q?Lx1sHapxD2m+SW31kv2Uvpohu/PbANk20JJSQyaj6qzBhjvRp9Ps7nR92GPu?=
 =?us-ascii?Q?Hdoeyf29vLTi2I0vOzFb06J5TSPnJGf5hUpY/9GfMdfATauFhJIFrZomLWS7?=
 =?us-ascii?Q?ZfMgoLsMPTM+uRRlWXhP4MBmyX6Fwc6KLzNfANs4sxPKy9tSGqZ1nY62ovs1?=
 =?us-ascii?Q?H3R89hktsBCVzSE4XmtILa3gllkQwuI7IYy66LqvmyGj2qYCPsh5u0PwQJrT?=
 =?us-ascii?Q?PN+nEfIn7mC0Fj71QLHjjJC6rvb6shpg6zNZOZcl4tPal3u/VK7NaL9w9yH0?=
 =?us-ascii?Q?PYqbX3xNHZ+DDt1oDIxor7+lSTxJvcXyO+Xzzwczh4sY9GHCAZ1aVGF3L/wt?=
 =?us-ascii?Q?fZITQoBW9J6c8II3Q2NsxaFFadXPwUt/LHPnlPx6ADBSxLgCVctkxsl/lDXd?=
 =?us-ascii?Q?Zdd7aE2FuagKFZjzBQNMtIeu0Co1r+TedXAMjb9lrKg4lClHdRlBhwsvSifV?=
 =?us-ascii?Q?IgAon+2Kax+pzpD+2sMeSCUJszXJPZSwEC79hS61cqgj9hGpZWHtl4XFJoCm?=
 =?us-ascii?Q?fOQcBX0qtBickfszuTIAU+Zs6nIfxGFHNyZYHo3KJerAXeN7ap5wzRhEkj3E?=
 =?us-ascii?Q?sFgAWK49UUrd+UQF+3ZSpZ3Jn1BjHeaVjYT8KtYD8iCQLPb+Fug4A7Tks6RZ?=
 =?us-ascii?Q?sMCCvv53QqkleTkW//3WOKjOBBVLzKUS+KK9Km41wxxZQSvpxzTUDNa8ofSS?=
 =?us-ascii?Q?U2gZdddTiMiG5wXiRBXJJaotwU245Lvpngh3qRtsGK1SBKvhjcWdYN+ex+v+?=
 =?us-ascii?Q?6VV/X7SmFa3arIPMDzZNgsAu0PUOqM45guK5q5VD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976baf41-58b0-4571-df64-08dcfda71fa5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:35:41.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDKo8jY19UHfK5gusl0j0TCmtMFd5qboytowc0huRGZ3svgkLxofJwN7/LHBU1xCWGwRS2qD4yx4ZMc9m8dT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

On Tue, Nov 05, 2024 at 12:28:31PM +0000, Donald Hunter wrote:
> Add a YNL spec for FIB rules:
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_rule.yaml \
>     --dump getrule --json '{"family": 2}'
> 
> [{'action': 'to-tbl',
>   'dst-len': 0,
>   'family': 2,
>   'flags': 0,
>   'protocol': 2,
>   'src-len': 0,
>   'suppress-prefixlen': '0xffffffff',
>   'table': 255,
>   'tos': 0},
>   ... ]
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

One question below (didn't notice it before)

[...]

> +    -
> +      name: getrule
> +      doc: Dump all FIB rules
> +      attribute-set: fib-rule-attrs
> +      dump:
> +        request:
> +          value: 34
> +          attributes:
> +            - nsid

What is the significance of 'nsid' here?

> +        reply:
> +          value: 32
> +          attributes: *fib-rule-all

