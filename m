Return-Path: <netdev+bounces-240841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3AFC7B04F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3BC44F3F4D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47343587D6;
	Fri, 21 Nov 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBD4YFu6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311134A76F;
	Fri, 21 Nov 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744604; cv=fail; b=nGIFUOiWtVky1I8U1VehvsJcykoBevBT7raw1xzoaGTCuh5lM1cvEj2YrSt+Qj5VWsB2BCspbwvYYqFIulHsOLyJy5Qo0U9bdAEzRjMhVMqg8CC7WDaqiA8WzKTISIgi66IpBoxvt2FZX4P7kpEJGizrMAbA9MEIFz6H/I13ZYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744604; c=relaxed/simple;
	bh=GjhdhcGC1IgnYX/cVlomamMw696D2n0fRq58T8LbgNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ezamfGyh3uOurVX1Uh7JwxJm9MmLbrkxzJv+7wPrJ3NPM3+7H1FHGd+XOQ+pDnbsyEteUC27vPLaEln77LxLFhSkc61a5TEmabzMrOSAbfhIjLsDs8tLQ+l4MTrh7iaG0/DDDAh3ArAQKVboz0Q+k4eJUTnqvSuRVtuLjC/j10U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBD4YFu6; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP5b7wJgzFtlGRfgIXOIFcyxaAKqVLiZ7DCwBICQ0LdCgfOaU0JDLq/i/d3LIkY15m58GbsF0It9Yul3VLP34TXz4WzWVv16YaIrnOp0AYiqRXww65ORb+VRKLFbygz3ZIfJVr+/tjX2lOPpfsgGq7HvF+vEe0X2h72Nv4f5Mf1ZirvVw13x7yEVXePya2QCcA5Qd8FLgrZsoCjCdFU30991F1SmgpBGAiG5HC2HnaNPhLFFK+nRI8AQdRe6etQ891VeEtAQ4Hs2jNrX8S8IJhKBCznpk57Y0ztWtMv0nsSprebjVuWy8lLWKP+qrGxbPARA4mfT+L0irGYyLlVfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJftMJSs7p9HvdyJ9J/t0WQTsF98z+TfylnczihT1ds=;
 b=UnWfs0K7Q81Kz7QRaBHEr4zlvf2t2XWFMbhgCYrVexX2VbaAkk2CMNZCH8ZNZ8VvaP5ZBgpMlk/aKwn3CkObRSeC6v1NpqYdvdt8q5bAledX9u6KpZD/SlmP0UzQywwosMsXTUekU/zKGkJWQGdOdWpJkIiq00Nf1tGHWn8Amx1ttgkEiOKPXOuG8bwLBwEi7kejeXnv64OBs4+6VJfdpBoPM3ohjwVyJyNgdxul8ypaeo/sw7QFA3sb7DX29HhtFGcqTUXst7kykNf/Oj+xKae4iqBti/LL1NEZBp0TEH4eRZIyLcat0ZHrphNqjvB65zupOpFHs9SQqT46ge3lpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJftMJSs7p9HvdyJ9J/t0WQTsF98z+TfylnczihT1ds=;
 b=fBD4YFu60cbdU9ZHEuE1szCNdVyD+8V4bGTnurbnCOIKH+kaCTB7Vf+hWsIYyMePdH4o9PQB8ynDUTczl69/052hMdsYo6xjOT/M+GlfhZfhKN48Ay7bqRO6M1c4OQuSxF4NIlNWPdz1wsu6eXUDMY7KJOioCHVDLRutz33DwxGtCEMlV43G8byASv2kvNWapNrVO/snIdzc1ZifGzxDsnl+dhjg/TvTTO4lZhKSTRq/sDdydk8n3KuaOiVjofPh4LxFyxe9VckptUCvpsxIjmjvI3CSNuJvhgjAa8lN6FfB3TDn4bk/+toI5bu4wz+1eCUnDaB/8qabPv5DLzFVmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com (2603:10a6:20b:283::7)
 by VI0PR04MB11865.eurprd04.prod.outlook.com (2603:10a6:800:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 17:03:12 +0000
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195]) by AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:03:12 +0000
Date: Fri, 21 Nov 2025 19:03:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251121170308.tntvl2mcp2qwx6qz@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121120646.GB1117685@google.com>
X-ClientProxiedBy: VI1PR06CA0090.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::19) To AM9PR04MB7491.eurprd04.prod.outlook.com
 (2603:10a6:20b:283::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7491:EE_|VI0PR04MB11865:EE_
X-MS-Office365-Filtering-Correlation-Id: d21e1e77-54ae-4b7c-a10b-08de291fd9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XWMjFYrFsz5TZX75AIJOXF7RN5yFz9qY4HmyS7x+thsU73U0SSBhkoJGj4D2?=
 =?us-ascii?Q?PTVAt7tTfzx3ojGwu7krtc20LxZz4RyMcAMZelHBYIqtrh9Igto3/TzjU4oe?=
 =?us-ascii?Q?85/FXh3VUuQ3/vHVNxPL0Jqt6ewVDErChldkhf/iu2kobK5Jij0HZ7UcKT3F?=
 =?us-ascii?Q?UvVCJLSXNWm+KaFGLMCuNyJMlmR4Dm6OF3Deeo9OqNAR89O0OiVAKs+pGcZm?=
 =?us-ascii?Q?SRO6CaHC6oFShkuA3oL4dVGug89jtGikiJqn1tXOlMuUeFW01ZCXhRi6+Dd3?=
 =?us-ascii?Q?KXvt4/8BFOFu+lXZ03G3sYz1/77hbD+01TNTy+YfrljGk4lG7b1XDW4VvUd4?=
 =?us-ascii?Q?9WTpCmm56+GlI/ljg34JTD/l0MyAuITO2FAg9U0V9/fGQaDbgNuMXjtRdCqy?=
 =?us-ascii?Q?3dOuQuFhC8Gz/Y4ewdnnSZaGCZJyjY+8nlJEkHqojq87MzfckiQDrm0z/6KG?=
 =?us-ascii?Q?oauNNwjqBvKV9VUe7RmRCjp6jy4yfG9dHkbTnmP8BpZGJXnJ76RnPfIMSnQz?=
 =?us-ascii?Q?nS04pLNrSHG6sl1C3gymqcdsc2phojzw0m7W55kESPm5/yL4BeWv2bY6BQdn?=
 =?us-ascii?Q?f1dKdmgBFWarwND44WqLEwhR/vMkXai8HSHm8cXi5HCDpMsQUyXEoxAtzRA8?=
 =?us-ascii?Q?OZ0pLOTfIJovFFgQxOfGWN/0QJVTStJ4iiQt96FRGh1M+Be/Q/rf5k0nXlo1?=
 =?us-ascii?Q?yZwh7LNORoAP6aytI4MPHh6iMLKdZXWerGr5gpE5hOr96e+VXrLFop0m5BIZ?=
 =?us-ascii?Q?moGzuD5hEafvZ9GlZZ5M1wgU8WE6GB4CMpt6nbt3Xr4+xqDZfG6HKgXJB0Hd?=
 =?us-ascii?Q?fRVJjNRtCpB6gjNVrMedvIH0DRiBsavsvKI6104g0tE2p2CFVRnUD5j/+yvP?=
 =?us-ascii?Q?7ky0GN8qmjaa03LfbDgwAuMQ4lVvRelGxEYW5rTZie/v4R9jGtH1X9RnkQu4?=
 =?us-ascii?Q?19hKoQO7Kc7Djn8n9TA7SY2v2ZOvZbCHcPhR/3XswdZ52KVyljMHceEHJGgv?=
 =?us-ascii?Q?bc8Vb9/IylqokPgG/PHrDvznjdGHdZnbevtz2oUEQIeUdUfSbcEdWMYaxEzz?=
 =?us-ascii?Q?KBUGWV1UlPkYRQI571g6PjyyLJ3pOPeyh1KwMYds4ESEV2Kn0Od7eMePSy+0?=
 =?us-ascii?Q?yYOPy8cIpgGUkllWgG484gHr6cLgI8XBxujGyZr0WiuX7/+w8gxuJCl965v7?=
 =?us-ascii?Q?RNL0unwftw3oHvRmdXTh1PrULHdoYOI72+X/ZNLBI3a+hD5dhbXQ4pOVzIil?=
 =?us-ascii?Q?FrZ4mOlXOBTEitNtUAYZdkftW6l83kXEJMne2opdTFZeRPB9wkR4YgU9LLGv?=
 =?us-ascii?Q?gtBvMMsXWEt33RPKcDpN2BI3bwjW4hq9DQU5z5v5vAgkwuWqR5L9hoG0y8qV?=
 =?us-ascii?Q?eUuUBsdm7P3OdMv5Bmd+GYRDfd4AiMmQJPXxr6vuqH5bBFxwywkB2fPEDeI8?=
 =?us-ascii?Q?JgXkTQKYwh83n5OXtCtM17v9R2flIYMEf9SIYo6BAkvoaLRORWeqnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7491.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MyadW67/RiGJVX1okoOs1RlZexYEAUaSzBQR9/AOFEhZ1QQOYdcMOYEv5kgi?=
 =?us-ascii?Q?qVtxhIsHHMGDdZOH1QtKQyAhMkmTGl6CBM/7vUyKAeiaWVc0Vm67mmRcu6D/?=
 =?us-ascii?Q?1C+DXUEDYpxsX781yfDkUIJ4sxl/nXGg72cz+btcqpTCuT9TLxlx9IoOQvGx?=
 =?us-ascii?Q?tvggCsOGmERgGAdxnfcUy0z/ftvLSKs1t6qc8SDQO3/is2l2vEJEWG4W3/Sl?=
 =?us-ascii?Q?KhHoDUuHkJ6/2A9nizKaYYNb4QA+ZfMptvLJ/HkZh92dp/pEzdW5yf7T0nI6?=
 =?us-ascii?Q?P31oH7C8nfkLDdSSZdNGTCY9qqrZN1gI3fv14u/c1tr19jC0b6mLFeZ6nnLV?=
 =?us-ascii?Q?huaGWxkqL566yn+Lkw9DoVAL63zEO03rUKAAqHnrAQZzAijFnqRvblrHbx1V?=
 =?us-ascii?Q?BujB2Tg2ftllFVZbS2TJm9b/kNiFd32nuAS7L23mlQzgdz6i+JnbOiX7htV9?=
 =?us-ascii?Q?LomZ3WVkNfnPBbpGqE4yLzy3c1FD1lIBPGTINQcZITRwi4M8IZl2FLPxd+Zo?=
 =?us-ascii?Q?38oYbWPqx7E9HZVfXRpBBz71A5bz7UJh4MvCYGq0y6A/YPEjktyZE0BgSKTg?=
 =?us-ascii?Q?dVs2V90Kq1u2OalkJgsO6mQOEk4vw4vwhjXVfb4fmP2PYB0Uu4vnBTpoQlUl?=
 =?us-ascii?Q?LCxf0TnKoMrpqC6gdHh/Vbz1oBxtTVsKPev5X7H0JsjMHlHkb9ohRHACza/p?=
 =?us-ascii?Q?Z2ot6VVtvsTQuTBE5OucGR9DzBUOnDFbn40OwkEDzaV2xCPxLLZkVHEFm9w8?=
 =?us-ascii?Q?CIZh7OVVQuZUzAuvo7uTPRwWhB5V7bol349l915gd6pit5HGasST10s0gux/?=
 =?us-ascii?Q?JDGRQZzCObKM4G9FjBYLs7cTPpWue5NNbVh+SWwr9sBh2aOyaytsiyn/9mHM?=
 =?us-ascii?Q?KzNE/STfJef+wbPXa6CLEbgOkkXxuIxgnbd3rG82/0BYytiBdDO+ek3gp9tA?=
 =?us-ascii?Q?LgyAnYq+d2cUfgME+SRJogsXFLOtPkOB0RmOiFs+rXetJeOLymJWy1HHvvqf?=
 =?us-ascii?Q?A+3HXdYhDeCBUwKdXL8vhDY9KUsLAT2L9HS6vunA+74DYlCFzHtrhyrQHhhf?=
 =?us-ascii?Q?Ms3oekJyl6WhOsldkDaJANUg0PruiLFg9OATNKhVFzcXiMERy5RdXOieqc0f?=
 =?us-ascii?Q?bvUaxQSG4AMXhbPZuhFsdQty+D6XB/KCFE1dCp/6B5G5TWWY5DK+sdF2VOzX?=
 =?us-ascii?Q?bXfEhTnvPaj4cqtjrUdIY7d0jcfVDYNHaeuEL0C+guMCMpggLS2VYfetpF5y?=
 =?us-ascii?Q?AdL1+wgVDZT6pe+V0Er2XrSIPq5ydeVEulvTXc0zc5pwNDghkMfpvPbbGlyi?=
 =?us-ascii?Q?M8Uqd3H2bxpDDqc9IvxTnTrNAdW6SxHCTNRC4CP27tpmUzoUC0pue8m3TJad?=
 =?us-ascii?Q?KOUljahiSeZAZtmcvzknK1UA1jH3HUOI+2tieSMyz7WDr047ax78RB/F6yF+?=
 =?us-ascii?Q?yByBFvmu5N8DwtijZSWsIurRNh1EWjtKTc/XE6qURkMbbL69SqFxn1siswPS?=
 =?us-ascii?Q?b1ybsCMv9fvJgI634d2fvbxgQC9v4QYDgykr/YDuDnO91xe2uWfuxfV083Mp?=
 =?us-ascii?Q?GZvIcPK9w5E/EUC4csXCIeWYJXUyOXrSTTG3g5DdNUusiAhLRB7KfN68wpJq?=
 =?us-ascii?Q?1KqFpxYTbnGgtwuxwdHne/FYsCBDKqtfzZtl+vpFDMVRsXPpjjbXxycRAYWE?=
 =?us-ascii?Q?pe9rwA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21e1e77-54ae-4b7c-a10b-08de291fd9c8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7491.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:03:12.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGD7K3PqpDCHxasWGz44BOgnuf1y5ENPsdfvJAHv23tbgzgU9jbkBXRHlRuMx5cROOBBNqa09gWzEYwPFiUEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11865

On Fri, Nov 21, 2025 at 12:06:46PM +0000, Lee Jones wrote:
> MFD is Linuxisum, simply used to split devices up such that each
> component can be located it their own applicable subsystem and be
> reviewed and maintained by the subject matter experts of those domains.

Perfect, so the SJA1110 fits the MFD bill perfectly.

I'm getting the impression that the more I write to explain, the fewer
chances I have for you to read. I'll try to keep things as concise as I
can, but please remember that:
- We've had the exact same discussions with Colin Foster's VSC7512
  work, which you ended up accepting
- This email sent to you in 2022 and again in the other reply on patch 8:
  https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
  already explains what is the kind of hardware I'm dealing with

> TL;DR: if your device only deals with Networking, that's where it should
> live.  And from there, it should handle its own device registration and
> instantiation without reaching into other, non-related subsystems.

Ok, you make a vague reference which I think I understand the point of.

I need to merge the discussion with the one from patch 8:
https://lore.kernel.org/netdev/20251121120037.GA1117685@google.com/
where you say:

| Another more recent avenue you may explore is the Auxiliary Bus.

Excerpt from documentation here:
https://docs.kernel.org/driver-api/auxiliary_bus.html

  When Should the Auxiliary Bus Be Used

  (...)
  The emphasis here is on a common generic interface that keeps subsystem
  customization out of the bus infrastructure.
  (...)
  A key requirement for utilizing the auxiliary bus is that there is no
  dependency on a physical bus, device, register accesses or regmap
  support. These individual devices split from the core cannot live on the
  platform bus as they are not physical devices that are controlled by
  DT/ACPI. The same argument applies for not using MFD in this scenario as
  MFD relies on individual function devices being physical devices.

The thesis I need to defend is that the SJA1110 usage is 100% fit for
MFD and 0% auxiliary bus. In order to explain it I have to give a bit of
history on DSA.

DSA is a Linuxism for managing Ethernet switches. Key thing is they are
a hardware IP with registers to configure them. There are many ways
to integrate an Ethernet switch hardware IP in a chip that you sell.
You can (a) sell the IP itself for SoC vendors to put in their address
space and access using MMIO, or you can (b) sell them an entire chip
with the switch IP in it, that they access over a bus like PCIe, SPI,
I2C, MDIO, whatever, and integrate with their existing Linux SoC.

DSA has started from a place where it didn't really understand that its
core domain of expertise was the Ethernet switching IP itself. The first
devices it supported were all of the (b) kind, discrete chips on buses.
Thus, many drivers were written where DSA takes charge of the struct
spi_device, mdio_device, i2c_client etc.

These early drivers are simplistic, they configure the switch to pass
traffic, and the PHYs through the internal MDIO bus to establish a link,
and voila! They pass traffic, they're good to go.

Then you start to want to develop these further. You want to avoid
polling PHYs for link status every second.. well, you find there's an
interrupt controller in that chip too, that you should be using with
irqchip. You want to read the chip's temperature to prevent it from
overheating - you find temperature sensors too, for which you register
with hwmon. You find reset blocks, clock generation blocks, power
management blocks, GPIO controllers, what have you.

See, the more you look at the datasheet, the more you start to notice
an entire universe of hardware IPs, and then.. you notice a microcontroller!
Those hardware IPs are all also memory-mapped in the address space of
that microcontroller, and when you from Linux are accessing them, you're
just going through a SPI-to-AHB bridge.

Things become really shitty when the DSA chip that you want to drive
from drivers/net/dsa has a full-blown microprocessor capable of running
Linux instead of that microcontroller! Then you have to support driving
the same switch from the small Linux, using MMIO, or from the big Linux,
over SPI.

Out of a lack of expressivity that we as engineers have, we call both
the SoC at large "a switch", and the switching IP "a switch". Hell,
we even call the rack-mounted pizza box computer with many ports "a switch",
no wonder nobody understands anything! We just name things after the
most important thing that's in them.

So unwind 100 steps from the rabbit hole and ask: what does DSA concern
itself with?

Ideally, the answer is "the Ethernet switch IP". This is always mapped
in somebody's address space from address X to Y.

Practically, legacy makes it that DSA concerns itself with the entire
address space of SPI devices, MDIO devices, I2C devices etc. If you
imagine a microprocessor in these discrete chips (which is architecturally
almost always possible), the device tree of that would only describe a
single region with the Ethernet switching IP, and Linux would probe a
platform device for that. The rest is.. other stuff (of various degrees
of functional relatedness, but nonetheless, other stuff) with *other*
platform devices.

So, DSA is in a process of trying to define a conversion model that is
coherent, compatible with the past, minimal in its description,
applicable to other devices, and not a pain in the butt.

Fact of the matter is, we will always clash with the MFD maintainer in
this process, and it simply doesn't scale for us to keep repeating the
same stuff over and over. It is just too much friction. We went through
this once, with Colin Foster who added the Microchip VSC7512 as MFD
through your tree, and that marked the first time when a DSA driver over
a SPI device concerned itself with just the switching IP, using MFD as
the abstraction layer.

The NXP SJA1110 is just another step in that journey, but this one is
harder because it has legacy device tree bindings to maintain. However,
if we are to accept that Colin Foster's work was not an architectural
mistake, then the SJA1110 is not the end of the road either, and you
have to be prepared for more devices to come and do the same thing.

So practically speaking, the fact that DSA has these particular needs
is just a fact. Treat the above description as a "global prompt", if you
will :)

So why not the auxiliary bus? That creates auxiliary_device structures,
which are fake things that some core device wants to keep out to make
things leaner. But what we want is a platform_device, because that is
the common denominator between what kind of drivers the "small Linux"
and the "big Linux" would use for the same hardware IPs. MFD gives us
exactly that, and regmap provides the abstraction between MMIO and SPI.

================================================================

The above was the "global prompt" that you need to have in your context,
now let's return to the patch at hand.

SJA1110 is *not* capable of running Linux inside. This allows us to get
away with partial conversions, where the DSA driver still remains in
charge of the entire SPI device, but delegates the other stuff to MFD.

The existing bindings cannot be broken. Hindsight is 20/20, but whatever
stupid decisions I made in the past with this "mdios" container node are
there to stay.

