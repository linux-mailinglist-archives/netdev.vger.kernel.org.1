Return-Path: <netdev+bounces-149321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0969E51E1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B602828D4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9D1DEFFD;
	Thu,  5 Dec 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E3LFPE0v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C21DE89D
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393710; cv=fail; b=CPWvjsIcK03Yvqvhhu9nokd3htf9QrIksJ+tHp7VV3NR/xcl8U2leLmkssz1se/iQCM++y3yGtE4bfJrH5N8jwD5XYUoTs7W0gZcWpTfbAnaFA00gJLBOgFuQN2ry9d43J5aqhuMcRGhmr0BiavXAEgd0kh1043LQkV8mT5BIW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393710; c=relaxed/simple;
	bh=UjLvsry0J3x4+34nYK2FkLkP+FDU6FMR7/W+nBUJRxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DH1K74oVLOIeWq3tRVnq77XdWbeGmDHvBXDsh9cUwE30Fcj0BPFWl6XDnm31cKDMB2dcpOWTGl+1MgOyazY4S9tGN9MrlGC61owXfRwB+hbvx0Gwy1SnQ9KYilEuK18UmjwsWCfeyfOPxNdu4CNkT1s5TipJS1r3hlK2O1+nmYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E3LFPE0v; arc=fail smtp.client-ip=40.107.104.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCaor7mdTwfGaCh8QVwc6kXnWbOEPyhZMAa8qQbxmnctrEDg5z4fAUelSdOPPq+s5a9crnoZTirp7UYFSUfQUZj0vPAcnho1wStllsZ0HLs/WpzkR7evLzX4q/CcOMqFqlzMmnA/qSW7DJWUfjlgW+cUdnw+g405KYARluSqjcgZ4vOKrC/4J3BDWiLRKO2LukhPf+KEZKTu1i17ySJmAWB6CAtc6nC6HviJJTKFMhmnHYRZGTvB/gZweW8Oo+5DqLlvyhnfhRv4rW7OuStvUMJPczbo3Uf0urIBNXEuH2JhyC345mEuFMhvwcKk10seuMxg6SQhlJtejS4ey+CFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEV4vcrCzDeh6T5naJF3pRTUhcJdkRFwhJqr3BpFIkk=;
 b=Tk9om+uC83iBPbmicpQvnh6E2KtwZs8jtOo7VDdFkkInS6jr895me/pYLSf01czy13xX7DJl2MrIumY2ByLD4jSecccN8rt0nC3vIRkP3VmG3IIv0uV3HJo2CBLT9N9uUjBQFwfoI4BPnIjygC3YaE+sBHUkzsqv5t3FOudqEtXr/qiKL8DRGyBdF10uQTmijWWZQh5igDBRIfcsJDkSb56Ss14BNQ7N1xbL2S+r48g5Tw3z1QwuC0aW3oCMLVLMbu9fdZU8R+FH0H9Wp4ShJb/zxgaMH9XiHf3ZGIy3axb5SiWR4cq+pUzf8M0eOXrL96bKDRPen6nSmJ3Ev8hMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEV4vcrCzDeh6T5naJF3pRTUhcJdkRFwhJqr3BpFIkk=;
 b=E3LFPE0vIi4XXMn/wojRCmbqc5gNXp078+tDZMAYNNWS2GvG1uMszLE+VR058XTG1VrwKblxtB2dEcIXEisz+QN7b8cPdKvNsX1LZGWiBBj5Sytqglxa3pUanh7jwB9RL17xeTg9moyeI2SbAV/WLjbMgIU8Tbfj4nZo5Kf9KqQBwX0Rl0qMn4fIlUmlrfZpzXp3/C03gV20rwwCDqlfmEQ2fW10awOWC5xzsCOI4Q7DMYysbzhsNCdoS3BHo/vXv+WGv+uRe4DW9tyxLHJevpb5qnjZSpHTgFWMq1n7v6iOmdid7y4BrjFDikcPojEDIXQ+utIGxuQXfXcHFTFhdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8826.eurprd04.prod.outlook.com (2603:10a6:20b:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Thu, 5 Dec
 2024 10:15:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:15:04 +0000
Date: Thu, 5 Dec 2024 12:15:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241205101501.ufmixuzon7a2cnam@skbuf>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
X-ClientProxiedBy: VI1PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2d5a14-300b-4d71-bda2-08dd1515afa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJVAeITFGe6m1497J/rQTZhUoPCKeGKtJJP3x148QDj54aoIfNUekUNCFhWf?=
 =?us-ascii?Q?/oP3nTDDhz9p2Mx6gw1G6BuS6loIKpx2egTGAj7ekakPTmcCIUSY4JsaxM8L?=
 =?us-ascii?Q?+uSY+xmDRtjQbxOg9OHsKOqjhLg8ceYY0qqTphOO4oDtvtUNRJn8dGXINSpO?=
 =?us-ascii?Q?nEBeUbms1dSC08LodKH1FMDQGQm21T6KxcsH770FKmNzfiQsosBRRj0keaik?=
 =?us-ascii?Q?SjogsCqhoOIk2/4Qb31hN7H4jeIIxXgh5gwHCe8tPElWy+dpJdZXcoI4HKGM?=
 =?us-ascii?Q?joURuPuqMsq8xtQfQ5J4N+ab2sFJvS0wwNgQJLT3kA2rTQf1fYhNZxTyUgVW?=
 =?us-ascii?Q?3Xapk6tP4S2Jm9Fr6LgUPcVbq60YH2FLELiT4a17oyF1ZDWko/NwXoVy88Mm?=
 =?us-ascii?Q?dLz5i/FBdHTGy+96iuGnlE56wppxmyEHqWAkzFXaWC2YSBF9GJURqdwY+XUX?=
 =?us-ascii?Q?AxFZlGFfY2kDmcxX3YmWNa3rUTOMkycHzYJ7PK0556tk/nr3/3x2ix9PZkgl?=
 =?us-ascii?Q?74wSMOcz/oX8ft2hXGTtER5JZyMXVhSpIw2+pETZexU7oCo4YGUQasKcxHC8?=
 =?us-ascii?Q?UVX8hpjNZ8NIPTcLketeVpymTj79fM5PK3dAFkXjThxJCU2rugjoqFw43kEN?=
 =?us-ascii?Q?s72ibRV4cGBCfU5vaZAbfwMm4S0M6+o7IBgnitOPIR/d7uVJO99NR23npTc/?=
 =?us-ascii?Q?WBFtiMmD/UKojF74ov7xHtQQfS3DX1pOOEFDhNmq7mLDmmNohkg5mDcNhKa5?=
 =?us-ascii?Q?wHia74fGbk3kjchN2hZ/ZrwFmhlJFoe1CDFpIAIGI/99xoegumEp/vtRWjm+?=
 =?us-ascii?Q?1LIWM81OPMbS9qw9dwAMWuog6V1xobVqk2JE4rDtPAUAuu73D+5ckyTHOwvN?=
 =?us-ascii?Q?hwZ7klWnH9hRCFmu2bP0u+EgaNlUj66MX9yIVko4vkFiH9awlimLQzxseBkK?=
 =?us-ascii?Q?t91cFJ4mYpu5GXZapwJ3JJlMDVEGcighnVyRn88cdBtPiUKUrj16ikHlGUPV?=
 =?us-ascii?Q?GdDs02IFKsQSpHQLQFGPNmC8+hzbaTXjFo5Vo6SQq9G+XnoWbSgo3IgiZzV4?=
 =?us-ascii?Q?jOjnFhcrpegOiRoP0r0AeXGQgA4Dlwuidh03JjpkFoGH6pT4R7ti8lSEllGQ?=
 =?us-ascii?Q?7YZfiywdaIu1I/kzFB/J8V9Ne/osCfb6BZJto2Q/W+60U0pkLJkXJA22P3Lv?=
 =?us-ascii?Q?Cvx/I7or8FZUziXeUK6K8Vz7LuHKOis+uAD+1zWWGIkjCTj/yjBjVOoo7DHY?=
 =?us-ascii?Q?+BX6bB2U626cgUMSm10/4Mc9ZcEWTguCW3Or5nxZ8AEZRSc7tAelevDee9sQ?=
 =?us-ascii?Q?P9pgx2oN04Z86llafJ3VrBNg4rwS9oBYLQZWV3gkpYrlSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDH9+gtHFfJdJgq4A3M3JP9EFdk0VUdtQeNz66zAPjZOibV1e1NElQ30X2Vi?=
 =?us-ascii?Q?x5zNI1+Ybd5BLyLyqUAixU02NfOiDA24V1x1phFg5ZZmoyx6o+6jDYqFI0/E?=
 =?us-ascii?Q?CCEBvH143rZW2fz1bhK3C8KwqpqdktksKjijJZphJgtv05YQT78PssQD1uRd?=
 =?us-ascii?Q?yU0f997fyq1CJf3Bpz9Dq0du9aHJuYaHzYPks2y/waUT/o9rbDoEq75Dc2T1?=
 =?us-ascii?Q?DuTYzZI0hKvAn48VGOrlGTFQdbDIwmHiPgCKw29P8Ww0tjKmgRp/RBm/RWEK?=
 =?us-ascii?Q?AfAl18pm4jEh2fyrIn7jGulPzWy2UDamROv5K0BpUPbiL747iWS9+rfrgQZh?=
 =?us-ascii?Q?/9ySi6c9AUBGz55hWQNUCStQ2IzK7v2gm5TfP/4BpofHi0U13BYSir+79hQs?=
 =?us-ascii?Q?16owfo+hamg7cHnhkVtKYJBpRqlJMc4UsZFooPg1PtYlMFIH+lYyuLHL07H1?=
 =?us-ascii?Q?RBjtJ7eYvlaSpo7Yf89MBRJwvy9Hd9uG3XgdPDlEJlanVbifj2RngZ3AVUua?=
 =?us-ascii?Q?Ml8nHbdqRbV9wxp3FtZZZ0lmUQ5hvhgkK/prC+qB2ggAqvbuw/6HdoqcpQb3?=
 =?us-ascii?Q?ZASUFJZnpOeV3gblh0d/kXBo67NOK9s7dsTGRw5YsawuXcjPZtNJA3S4nGK1?=
 =?us-ascii?Q?sn6unkPVtZeMVetm3ovw/PsvTvr5+4bQo7AFkoYpwGX/ADFWHzYRTl3gnrd9?=
 =?us-ascii?Q?J8LrOCgDToGg6JjUyzjCkn+AxRleUvpAFefUK3ONy81g419rYu+ZC9hQ/e8c?=
 =?us-ascii?Q?EMnX5rNXtp0z8xGlbkqEQRVxHgeJrk0P+6pATgDlGiI+MMeimuL+OjrOiEHw?=
 =?us-ascii?Q?30j4twG8ZZgOUn6MG16uZywAbZuHNbXUsrxH6RKMgNretX6h2TO9v28Rv22T?=
 =?us-ascii?Q?WSjBZhb0kDcWevLEeQFcBR7CcbIKUAlxi+dbDRU1Gi0ixW6M2+i2DLN4R+QQ?=
 =?us-ascii?Q?aEkxc+KCE5cXQBZcIA7yb7H3+8PH1rRo7Is8RKT7gdLFHyKibkMzTJ1ealCz?=
 =?us-ascii?Q?aM0eHdg6nzER/oI22QIJntE+poGskOm0wDWslnBJSs3LJQEz6iHZjKzERufN?=
 =?us-ascii?Q?l1eeeEy7oZFMfr3GUKfnq0LukXlqci+ZfSuHOGF6ogsXl+cZzAvJp7WHFxeE?=
 =?us-ascii?Q?yL3ijZHPb2in+PmLheGYcP0w0Y+uKdaVCGp9MrDDRVfmQw5QO+1EE8GpGphO?=
 =?us-ascii?Q?1Mvcm9OMXybwzxg5+uLJVpIQy1Kk4FinD4Wbfupt1OiWyZMNDiJeufdBgyam?=
 =?us-ascii?Q?cpjlrxiscrw8ekEQfgKN6MEBLZnMhwaTs+acVj78HApfNuhlR5jLjRdZAJZU?=
 =?us-ascii?Q?Q9/3gqSuHWJaiFm38jX1J6NwSO+tUqA6g5TrRekCLAi/7PLeC/DiGUlt+2iG?=
 =?us-ascii?Q?35k4wJ5PjGRzznMAGSTdpu+q7VZ5Hfr8bykQOmjaj7vujXEsqJes3zBKAbvv?=
 =?us-ascii?Q?vCY1fKOWbppb9RJ03dkTZy/sTOFQoy1aHndHV0zQssRvDtlwvEm+cigPjVY6?=
 =?us-ascii?Q?2TgfJuiE76vF5WB2FDWfMfIlP7kw8kHWjMHNaJm6o8ZypGjaaBY8bzgx+DRm?=
 =?us-ascii?Q?9F67HGLb5k/AQ+jd0JBxlQ2ljVRsW2Ntt5L6VUrmLp3uKDe6mhcq6ncNCb6O?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d5a14-300b-4d71-bda2-08dd1515afa4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:15:04.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBuiiH4LBFWO14xbMU6Rg1tQ5/wWdz7/HUpPoWL+2AQ0VIScbvx4chaXAsA8SqPF0DKrzbgBI/rufad3byhDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8826

On Wed, Dec 04, 2024 at 05:22:49PM -0800, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This is new API which caters to the following requirements:
> 
> - Pack or unpack a large number of fields to/from a buffer with a small
>   code footprint. The current alternative is to open-code a large number
>   of calls to pack() and unpack(), or to use packing() to reduce that
>   number to half. But packing() is not const-correct.
> 
> - Use unpacked numbers stored in variables smaller than u64. This
>   reduces the rodata footprint of the stored field arrays.
> 
> - Perform error checking at compile time, rather than runtime, and return
>   void from the API functions. Because the C preprocessor can't generate
>   variable length code (loops), this is a bit tricky to do with macros.
> 
>   To handle this, implement macros which sanity check the packed field
>   definitions based on their size. Finally, a single macro with a chain of
>   __builtin_choose_expr() is used to select the appropriate macros. We
>   enforce the use of ascending or descending order to avoid O(N^2) scaling
>   when checking for overlap. Note that the macros are written with care to
>   ensure that the compilers can correctly evaluate the resulting code at
>   compile time. In particular, care was taken with avoiding too many nested
>   statement expressions. Nested statement expressions trip up some
>   compilers, especially when passing down variables created in previous
>   statement expressions.
> 
>   There are two key design choices intended to keep the overall macro code
>   size small. First, the definition of each CHECK_PACKED_FIELDS_N macro is
>   implemented recursively, by calling the N-1 macro. This avoids needing
>   the code to repeat multiple times.
> 
>   Second, the CHECK_PACKED_FIELD macro enforces that the fields in the
>   array are sorted in order. This allows checking for overlap only with
>   neighboring fields, rather than the general overlap case where each field
>   would need to be checked against other fields.
> 
>   The overlap checks use the first two fields to determine the order of the
>   remaining fields, thus allowing either ascending or descending order.
>   This enables drivers the flexibility to keep the fields ordered in which
>   ever order most naturally fits their hardware design and its associated
>   documentation.
> 
>   The CHECK_PACKED_FIELDS macro is directly called from within pack_fields
>   and unpack_fields, ensuring that all drivers using the API receive the
>   benefits of the compile-time checks. Users do not need to directly call
>   any of the macros directly.
> 
>   The CHECK_PACKED_FIELDS and its helper macros CHECK_PACKED_FIELDS_(0..50)
>   are generated using a simple C program in scripts/gen_packed_field_checks.c
>   This program can be compiled on demand and executed to generate the macro
>   code in include/linux/packing.h. This will aid in the event that a driver
>   needs more than 50 fields. The generator can be updated with a new size,
>   and used to update the packing.h header file. In practice, the ice driver
>   will need to support 27 fields, and the sja1105 driver will need to
>   support 40 fields. This on-demand generation avoids the need to modify
>   Kbuild. We do not anticipate the maximum number of fields to grow very
>   often.
> 
> - Reduced rodata footprint for the storage of the packed field arrays.
>   To that end, we have struct packed_field_s (small) and packed_field_m
>   (medium). More can be added as needed (unlikely for now). On these
>   types, the same generic pack_fields() and unpack_fields() API can be
>   used, thanks to the new C11 _Generic() selection feature, which can
>   call pack_fields_s() or pack_fields_m(), depending on the type of the
>   "fields" array - a simplistic form of polymorphism. It is evaluated at
>   compile time which function will actually be called.
> 
> Over time, packing() is expected to be completely replaced either with
> pack() or with pack_fields().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # KUnit

