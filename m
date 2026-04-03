Return-Path: <netdev+bounces-275135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPGbCqvqz2lF1wYAu9opvQ
	(envelope-from <netdev+bounces-275135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B283965FE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 317033028C3C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3737F8BC;
	Fri,  3 Apr 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JkgVE9oO"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533C3CBE67;
	Fri,  3 Apr 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233338; cv=fail; b=DEnLBUvwMnu5xsxTUYtUZTNCtKV8KNr4IAl2kW/rJbnZfbPxE8K/+RQw5HvPFubVF7ZxeZ0Cm8qonn1ajZSkfobFlq0EUqUgPrQJvkvy10+B1J5Hw4yhZhxDfA3V51D4V1sarzY9r/eXIvzxIWh3FBBmFfd/ogS1BATqZrY7ccs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233338; c=relaxed/simple;
	bh=nYZJPc4P03qSne325pYmOmrcpNlZpVbANs/P3vQTXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0bYpMc9nhY6dY5q9SF/L/+Ot7WbX8lAegADj7eKrP9WTG/4BrWvPL+joZnRJH9dhYMeOs1UXofaMLLkSu1HFr3Lt4Qyufq/HY7nuYt4wZR8SfWoQ37yBgvUoSHmq1/xYLXg7Ev9yt4We5ByZlU2Om2WpjB/VeGGgV4BCKzj+sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JkgVE9oO; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVrq3NSqJu6xHpePE4rLJWFBqBrh627V5ftwxbaSd6gFV1snN7oNZl2+yM101jKU3mWeOnIdxdXyKleuM7rM/TdYG1HZFFFyMOaie5vkkQgU7965/fEFfyFSMdFqi/zcL5M+iqsu8q4Y+4ygXDfE5c39/FBL5Pi0c+1OmwDPhQ/NXfjpWqAKPBQ/pFPwPcpjHq1DOz7h08OWMARCUV0qYvO2EcLtYY8IWH//p9rDN3Qot1zZq/YTME58Xm3HuqYRb5CmlEp6iStvH+At67CxaekRAI0VG331/eleBLj7S8uQ9oGU9jqBySjjEEiUT+8flqKAA7wsTQFAyOyLfypckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16CeUcggKdoMuoEHUSJTujZrRWAc/si/JniLaBbcVws=;
 b=cKFvHBfTKf2+t9PQGV+tcoEVsg+dRsyXTbVojyUuvB7L/o7FIvZi8aBIVlkVeSmKGHWU5unP9Qg+yCXUDBZnDZL65E8BBzdg4kq1F6KSp085p7TZ1nYo0bT/dZotQ6qtiBFE3XULf3fAYbYOB5D+n89zaszA+yT9tcsNFbmz4JIwLbjSF1opewCPjIKQ1MNjmni84IlKNnryAB5F2JvnwTCT2tbX6+fAqZwAqwhuEa/bxwf4SpWJbR6umi8bI7TQCxQf7y3D8yEDgxRqtWiSycTxgz+i9M7SE44Ys7FXCPmWaNduHk31aJpURHTx6KNAqPmho0+ICx1AEGt+gjG3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16CeUcggKdoMuoEHUSJTujZrRWAc/si/JniLaBbcVws=;
 b=JkgVE9oOcxCR/1yV8R3o3NpKQxh4UhGQoOGezQHKnyy2Afvygl8a1Npp+XMZX9e0Bp0BG+WwyM9QsHU0TV0Z2VhRdKGCWx8HQ0zFQxvnESSXDoDPs42kZwsg9SiHZmWW0KGuchja0uH1+6NgGL8KEXnW0GDAtkWTe/StQAmbISD7liDDwkJMZsx/+JiVPPRAG5YwlzSzDsC8q6TAh01d5sm5lPZJG+NyWGWvifTKKf1GEcis2m7z/Uk85ZyuDqgQ3ujIxa9Of+Su55Llmfis1iPdKfrDcOY0ZSusFTsMoeBXKwNhW5yzYJVxvLSdkkhGMA3ZIuAbA/qrjze8vl5k8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 16:22:13 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:22:12 +0000
Date: Fri, 3 Apr 2026 12:18:45 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <ac_oZe6wjuOjVLcW@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
 <acx_1dOF3EjvGt4B@yury>
 <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
 <20260402102717.5eb48393@pumpkin>
 <ac50sX3MZAcVSNJo@yury>
 <20260402232126.2e74631e@pumpkin>
 <CAJq09z5kMu4ANp3n2Q0C1j8TULdCKW_yPM=nN78mNupAt51YGQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z5kMu4ANp3n2Q0C1j8TULdCKW_yPM=nN78mNupAt51YGQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5b9ca0-ccc0-4e41-54a4-08de919d298e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YbyIm3oqobFO8XQZDKcn8N8hgnNdUhTugLaJNGGdeflHMAjdUpKjHuIi6i6Ojv6tCFId4JnH0uAWctvLJ+vMBZew3TsdTQkaK4HS8V2n8ABkqRiqk6HtUXZW2uAaZc+DdRxDMml9jW7T6S6UVKjTDreUmJ8VpW1ddmo5e+DYhknySU2garO9iC1YxmMdxPg3orgfuBtPffFcQoCd+/nNTHvrMlPJ82cLiZ7HMx63OG4CUYceifoU6a2BIFwuxa3bB2WOMeblliDouu4Ob3fGI2bvwrtBdTtWSv+STyeC7LLGlR4jKzlX8/1F++7dQcsRzy9oEHpvfqgB+EsyXKMRWhJY0nZ4PBLst1KcwtkSACoQ1fUsE4e2SLeVUsTzpo2kh4vYBzYVUkwIrD9spVZl1VD8XRqapQKR+oPWhHkk5BMMyRF3NtTVEDCLFWTtY8CnufSG8xvGHeIn501YMzboaE3tcfVKgoIpEJLegYjv1K8RANQJrTY8s+B4cG7lMV0cB8CBd3/ZtW5Arktqvoo/Y+5wICIe2Og6gGl05Ds08Lu9i4h02WgjTWJrPdSUnx9KUEUu3W4RLE5jRmaqWtWTwQzgLqwe1U5JwmxhesH9ZSg7o7rAvlX+BYGQe/MuEJ/BcbkQxOZM9LUtPnQ3oa3BObkfE9Y5ZY8AK5dWTEJhW++lyKco3WsD4PeASlQ1n0ilXDinVwO35/nI0ABjo5+8dFZ+fpxAtaOoy9YdYc5+EvE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w24yLxu1KhctUOl3NYMYCUMtySDLh2EBykqu+jOC15CWp+EHoZ+2MaA9TKDS?=
 =?us-ascii?Q?iQwfeqiWaalfqulfD1WctFndCYfIva25w08hvjkPOPiyvTU2F8tJ7N3UiyrF?=
 =?us-ascii?Q?KXawRyG/b/2UBYCvAURir8HlcxLmc6VAvakuh8HlvnnU2cuSKvrq+m8CUvNd?=
 =?us-ascii?Q?5YpNdphjjii4c/bDFBmKrv760CBi71rmCHwMmqUOkNXnmtrFUfpp5roTkIX4?=
 =?us-ascii?Q?eJc3s02UcpK64sAI/ePHP6tZLzmXo0llfwTv9CkVYy9rQtnPWQ/81L4QT67/?=
 =?us-ascii?Q?6LEOpC9Oq0ig+VrUKu4BDOg4nt3t7NRBiNkRqj3NvN+39S+tpl+fu1hjKhgL?=
 =?us-ascii?Q?yrlURT3J2bc0dsPkaH2aRZ9PrI644J2p/LHGMrHMub4GJkPKVYND5UiolVK7?=
 =?us-ascii?Q?3zvL916jNRAwZ+LyGcgnXXSqD5Ma4mXBceOwURoXsxlLklp/BjbzXXcQJbhz?=
 =?us-ascii?Q?CGW2rGpftlq/SfSe7g///WD/8L23YqjM1jHmR2pO3frYiANVNeXByTghu/Zr?=
 =?us-ascii?Q?n/1ooMyliVw7i3Wsr8Iz0MiaPuj3bt90YjkyEXtDEolB1jEkyw3PjRBkWZtN?=
 =?us-ascii?Q?jROVAIfhB/lROTkt1kvZXh1XqinWvWJDZOvwZbp1vi87BG9shU2Na/RY1V0g?=
 =?us-ascii?Q?rjt6iL1LfJkTrTqhxfOPT/qynFdDlyoZkWPN/qr3El3uQXedbiKMNypO2h0y?=
 =?us-ascii?Q?pHdLU8to8NpwFN3IMlEpg5IQqLEnHqVO42XAys5ArEixk4tQb77cHYccRV34?=
 =?us-ascii?Q?xxnanHlC62Ai6g45j50GKwYjKztdbgKz2VfrSzVZQo59OhxCIoWy29CjRtS4?=
 =?us-ascii?Q?/CkEbEXnyVUB/RiUdPTMuQzQIELECQHhseh8iMKH2rEVlWGvJAAhSAHbDMo+?=
 =?us-ascii?Q?qYS8W+jHftOtBBQfplh6ZeIFbwPB7Wb0pvvBt/v4SBVZ9dBYxciB/wrQtnLx?=
 =?us-ascii?Q?yRgrHoSxalnhQ3cLhnGNY2k5ofeL+5HN6/mdNedvaNC3KR78DLpAmCJ4mxW4?=
 =?us-ascii?Q?E2gVAZNZP+hvGze6Yd7bNBcq0isAySeX+J+kBOkre1F+lEc7r7ja7dlLmQDE?=
 =?us-ascii?Q?3SLFVtPSdneoi/h6Vu6NZ/A5ZHg9e3Gn+KQyzyL3hMUdOZoj3+DxzsDTIlsp?=
 =?us-ascii?Q?wn8nJLgGAtLBh/wtVYsAsx/ZCry6OMEcMA4kOQ4qeZXAiT8IN92tI0OfQWJK?=
 =?us-ascii?Q?bSDhHgWykmpryvgIbjLudjPspc+SsYtpg34Y0JtWraR9Oh6Mw+um6pklDQxV?=
 =?us-ascii?Q?F9K6mP79OsdV5YcgLCxlcTGE4THwUjpt25/xYey0Vqp0ArhJD45xDaZTAOkY?=
 =?us-ascii?Q?sC3pb22KPAwp2vZEL7TQZBICbcgdDXw5kt3t77kEXBvCDhLUgHlh2jP+ZWcy?=
 =?us-ascii?Q?1i+wu3fSC1TsG2xkLhq0IOU1A5WrolM5isEsieOAOiVre24jA912fYQLCKTg?=
 =?us-ascii?Q?uhOWVQ2JjoNdUpsqxoZIUUgRif3oh4wHPGYDN1yv+7M2l/BEJQHXy3tSbSl+?=
 =?us-ascii?Q?fBUhjH06Vrr0Ams+/KNBpsOnWl28XxTT3ZMYFQCxEsXkhQafpevcpdrzGBro?=
 =?us-ascii?Q?+d0h19n4YEv+7QNA5uGi0GPv7FAHKqeij+fmsIhizSyOFkMUPZ3qBcOkeUAH?=
 =?us-ascii?Q?yKe/FpuV7GJJH93beb/tCapDNcm/UiQ/w48Ftw7qjdzfVJBHicspm8zFNQMM?=
 =?us-ascii?Q?85UqkRmjC3+H4OqBwoVWJe0KYi5cgpKJdf5gwUNCmKTxXeY3BbQyyqT9znTN?=
 =?us-ascii?Q?7lFZyjgF75Fne/J4bTNPjMWjiwaKKqFnLqk3E2iogeMqF8yNOIIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5b9ca0-ccc0-4e41-54a4-08de919d298e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 16:22:12.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhfKaBJD8pbsZYCyXqJRWv8QNGUt5zCWGNOM/km4o0zvspcfqpI6gwTuayZ2RC97mHHvILqPrRZOVYGTbQDXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275135-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: B5B283965FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:09:30AM -0300, Luiz Angelo Daros de Luca wrote:
> Thanks David and Yuri,
> 
> This patch was originally intended to reconstruct a value split across
> multiple registers. Originally:
> 
>         vlan4k->member =
>                FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
>                (FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
>                 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));
> 
> However, as Yuri pointed out, I can use FIELD_PREP() to align the bits
> into the final struct member without manual bitops. While less common,
> this pattern is used elsewhere (e.g., drivers/clk/clk-lmk04832.c). The
> updated approach would be:
> 
>         vlan4k->member =
>                FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK,
>                           FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK,
> data[0])) |
>                FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK,
> 
> FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]));
> 
> If this use of FIELD_PREP is preferred, I will drop this FIELD_WIDTH
> patch from the series as it would no longer have any users.

Then, for relevant patches:

Suggested-by: Yury Norov <ynorov@nvidia.com> # for split fields handling



