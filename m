Return-Path: <netdev+bounces-244970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED8CC4423
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36C5E3005034
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E372D8393;
	Tue, 16 Dec 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7hN76Di"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC22D190C;
	Tue, 16 Dec 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902302; cv=fail; b=KfkVnePoU4Zj1w8/QqqPbD6UwY+NwCsv/ddA8136qIzwKoihCYuqF1vWC2RSR3OF3DoJKcFwOYcKQ6vo1+Z1NMdOhqHFx+VHtHqW2evg5cMSDjUUzSIOODoiJdKVhlCtVnuEdpgQS+30+YUHJHhml3FgeJn4YXhW17TlHilz4/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902302; c=relaxed/simple;
	bh=iItZfmzLSEShxI0Rm7BYy9vLMEBNk0put988Eom0/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwPNFA+EK85z2sCQJO9JYw81fjy2S63E89j4n4kXnYPxmCMMAySow3jyf5CUovKnVcvhc8DBjmWRcQck4yGFsY2n2CREzsvlEosKXsnD15PbVbaqGa/X/ylZde1VqFFyWrI242nUe06xWUDQN1dW3nxbK3Ckvvg3dMXtl0bD5ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7hN76Di; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkcMT5sdKBRTC3kmVJJDPbUwdgXLa6jLjAye/2gVFYpo1vNNdvjkaUIYXPfRhbrmi4LueuZ665gUlsFUUbgE0aGAr2+AUtHa/20+jtnlUbQgpyHTnJ+sOKNYn0a2Oubbb2oPzH9G/uXrd0Doyd1SmSZgVIeXsyIrJBQxqEGLDLfwLj44w1648vgXlHfsJWSBEX2RmHQz553fUmWvX1rh9nDhV4bv3thWuTq/jAfOEEklEDFaNid6gpfGux8hPBj6kSiMTisR0t2P2JDD19TTMwoeYkyuMzQA2Huz+fSxa7zetwXhPOkpcbn3EPTN3nOtRSE7byzasQY23cmErdrKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imcmmKg9r4+gz6zgvDNwa2ywCXS255cD5RrdkG/ufvY=;
 b=lUsynlgey72fATo50NVX02U1D15rPZWQzRRXNgY9wUyEL8kT2d9wSxfds54l7ulaldsn9AhlKJXk8SJCmA84hbx9gJQ7S3OlsaoWylCkKRdiJbmzZ66NKIgLh27oFjDVhCiVJTeWMfB1nkaQnROumOpdz0L9aZO50zotYK5NMkELaYCf/YiSFIEwilvxLa23Uv7JD4fZ/q/ZQCFXlXNt1k4NOejNe240YpGeYm6nhpSJJLTBR7FYYDqsBpP/S49CVQAMzAJ1JanTGkAkBXCKR1WUIWkP3vacrSY9oWnRt5kiQ0jqb9wbBX1KMEoPmo0YLuZdAGkC5q1laMPltWr12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imcmmKg9r4+gz6zgvDNwa2ywCXS255cD5RrdkG/ufvY=;
 b=g7hN76DiYxkNBTaqhz3WF+mOZNx+m8yQljxZ4cNK5UbZMvIgqzzqyuIybvQurBBurPuvx9ldxDvMPve8NLbvr4DitGLjYOP9f7kSGzn4hqYVg4vWHl1NrDfPCXWUGM8osHWE6AGrxVUsbfb6d/o4vs8aHIBqrQuNV91aS4PHviQKcBsqdzm3sxALXnGY64iMkFQBNWNUQmXpxvNcs6GyfYoSOJtZ/c2iqXgBkySYlJ1Z2r/vrV8d4a09SC1rauFws/gE32D1R5zSuflCWoZnoxN8AAmlNKa7bw+2L75IS+TjVlIJq4aRu8wIeyQg83IqvXeYfEYKWHQTTjF30iKzPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:24:50 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:24:50 +0000
Date: Tue, 16 Dec 2025 18:24:47 +0200
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
Message-ID: <20251216162447.erl5cuxlj7yd3ktv@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216091831.GG9275@google.com>
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: bb25f5d0-d787-401a-ae56-08de3cbfa2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+S/SsUELOI7Ym9/fcBbb69n9Tv/8x6PyL17NutAHu29rWPaS40uD6+YA01BW?=
 =?us-ascii?Q?+ellcm2FtLWATf9di3vzyyW+/PAnBKPlua/7mlWHMm4OUD8WJStKsrq85hqS?=
 =?us-ascii?Q?DElHxLge3rilrlHVhDojnL31X6ld1Pi2XEoLU6HiYTzy4xMBtuDnrZ1aXqwY?=
 =?us-ascii?Q?XnvA1rj7O5SQvqwthoNjXdFGcBwHFhTmmIh1lfwpCeWgkBfFGnjUfzX52L1g?=
 =?us-ascii?Q?6+/H9+2sW36BBxrNnQHJtfLm2a4DkLldMs7N0NtMoXmP+zL+FhZ4CiYWCYaS?=
 =?us-ascii?Q?dm4+ATMYKPcvf1Vw/XH7VLJ/O41nDLkcln3rGRK97nMtwNV1WHhkuk4vL9N5?=
 =?us-ascii?Q?udKvfYre5Y/bgUE5O6rK7ATL5Bs9dbMS8USrIrtwoadWQB2jxQB5XIlC0tTB?=
 =?us-ascii?Q?O1CsfHdqwIhYdxW/xHZ/HHUItd2jO0HfJc6B919Uc8rBN5yCMcLWPK6DcXWZ?=
 =?us-ascii?Q?oX7oPgSlxpDRXWT9aaGAM3G/QL/QzHwz7NqVvPdq+4qWtTDWvn68+nHiQUdD?=
 =?us-ascii?Q?RIbOl4iUSBtQenK6bzZfSO+CySzv+kmZjg1PuYiUwdj6pd2dRPeIhNkZk+aI?=
 =?us-ascii?Q?BlR/HQ4qc/bRQX21CZ9TyFWgfSU+ImOlQJqZJN1TGIdoqz8fc83817iqsi8R?=
 =?us-ascii?Q?V8EzGFqVxlHUXu5ogOAtpWwVeec4RIALwj/gdFSTpQf8g7IiYmiArn5UfygY?=
 =?us-ascii?Q?wmJOG+wIPM5kPccZWKfl0Ym1BGosVvgahHXTBFRqCCgmxJSYTdvGzK68/Uk5?=
 =?us-ascii?Q?kQXoKFiGZUjfYBZ9JM3K77SBmvsaw5Q0ZxE//6R2yqYkFxzWL31aK/seaQay?=
 =?us-ascii?Q?deznFCE1JH4XqOrhbsRB/lEWuWSF/gw8mvENAU5jI9yPAZQhJvsFKtmiSLrq?=
 =?us-ascii?Q?nGvDjfkficw3i4I5Wu1DRlzCglT3+FPfMg9jU4xJuoyRDWZjtlG7FtXxJKqs?=
 =?us-ascii?Q?VjkRhaLXoQhK332sTDTcSeY3vuXsVqQw3fFKMbSeHkytJ1z8GcUpefQgLfh2?=
 =?us-ascii?Q?YPG7XDMyOSJvMbejrt8FPysTwNPjVmAEYHXGyhPtA9cn8fdBzgfeHVrSO+ST?=
 =?us-ascii?Q?dJ+5C43k9ay8kO4bwTTjr7+jdvFJADc56lJMf4PPwYYKv3rD48tr39JjzPYk?=
 =?us-ascii?Q?A6hYukbGIylVpoLiZmqnrGGMcPw+MHrfZy/WVPmvAkWV+gTAp+rhCgerSJj4?=
 =?us-ascii?Q?2zp9qS9PnTJG5IZJf/tqxSXZ2EdHo2AKCIy2G39uKl1q1Bord+KsM+Bvz1AR?=
 =?us-ascii?Q?rN2nopXO5MBw0DwFN/E1VxlZInOv5CZTcgDvpM1EMrpwHn8zdFtHp0tej3k0?=
 =?us-ascii?Q?8k6XnxwhtkZPoZWefw67yNTlmLG90CZCjkrmDsD4riMNoE1VrHDPeTKsnfmA?=
 =?us-ascii?Q?oRjYYf9vFYMaHRFPXI5bdgGGk+wi8GUiVL3e1aoEBpE2gxZ3NIOU0ObrqA2h?=
 =?us-ascii?Q?chx7xRBEQtkAVZxcqcCN/v9KGstn0TYl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7/ncHjCv7WSSoeHM24kCORiJAnmG1/+xuvmz+jdqMM0t5YJoyPAVzpo2KXP?=
 =?us-ascii?Q?8MMcxzeIsV3Vv8c4aMt6x6WklX7K80AYPPdY/NwOR22yn0+cyS8yAhuCVN6Z?=
 =?us-ascii?Q?SMDRSkicqxVlZO1BE0gJk1D0bOX13JW0F1+x0MgJHgLMTRWfbT1AGQOsTPAr?=
 =?us-ascii?Q?aDisubmqOwU/zwnAzbxIHePaxhkBS2sgbc4EABdkszJX30ggO+g5PfzcFfYJ?=
 =?us-ascii?Q?pjdENJN6eLE1Wnnk81hVse5g31tlEs/BmcIkcT8R39OPFJNZWNJZLTLQQp20?=
 =?us-ascii?Q?hTJ/qNF0Neaxw2CIixAj8szrIdq6X2H2qfEF/9FUAa9h0tkNneIpl0YBvkQ8?=
 =?us-ascii?Q?Ky8uUYh3U7gKSwdeGw770z56HGKSxSy7SPT7g83/ECnA9kaoMupugp4E+T1j?=
 =?us-ascii?Q?wqlHFYLd1A3c3V9cD3HmPhK01uJbuAbOJzgrL2U0CluhTdZHdEERRgchp3ld?=
 =?us-ascii?Q?p0KtTndm27KX7j+7n+PA+I+AYsO43gsMNN2Nhx9sbfrpDI2OSByZFmF158wm?=
 =?us-ascii?Q?GkMr4uDMPdRoFtbkSPVX5tVk4m71iiy2T2Ijyh/7c8JQIGVvdeFRAq+w9bJ1?=
 =?us-ascii?Q?EGvB01HZYE6UZjkiBV/rWO8bwuJNSHuKe+Uzmif9yTPWbgf0KJUPK1jF/9Vs?=
 =?us-ascii?Q?95iTRShWA3WY7XcaN5pQHMNa5InePPavm+xe4SRHmhtDTrgLNuBqRrfVKop8?=
 =?us-ascii?Q?5a7zokgCAY3+wHAQPQ+rcrmFDpiRWydUYzMx0bTkDRJreM37XyWPCfjesSij?=
 =?us-ascii?Q?zys6wTazVelE1fVBx7/y6J0yGQYeMnCrdEdrTvTUQC2Mb4OB7ayPb5DqTOOW?=
 =?us-ascii?Q?aPqCu89RD8hxd6uqHBfHArAMT7y8pjVomhLiZiv6Jiji146Wj+xhNwT9Y9uF?=
 =?us-ascii?Q?zOcntNFbvQc5zjbsa6u8Z/EN9E3ygfsZ19a1IhMNZJnK7Q5svCoRxNxm5HL4?=
 =?us-ascii?Q?fFA4QvnRQrmkBnZJvm978c/AiiU7SWcVkU8CjkLMFikq0msiKBI0y7hmAx5R?=
 =?us-ascii?Q?EQcpj75Uhtj66IsRRY7O+Sd8iabpAzzx9IPSeapuecwRxT8q2Ro37l8vGLBJ?=
 =?us-ascii?Q?6Xz8xsSRMIWZQxVaRM2H/EbKzvoqybON5Mp2hNCt0G4e/PG3gBUsqjMyaLk9?=
 =?us-ascii?Q?tgv6A0itv37QQ8xpDs7MccSX56wC9jAreP3nvyLSyb2U7W3ElXviCCuWO0hg?=
 =?us-ascii?Q?jIRoxHs9poXVMNfr66Rd2FwhRprw9L8OEJkXQglMP/i5y5gf99LyUW2bQIfK?=
 =?us-ascii?Q?LRmPn5XLx4MTfI4BIDs1dQ62tuJv+/otnLz+/va6iwBhOUaIq33aqh0kpbZz?=
 =?us-ascii?Q?zYdedlMCSd+s2jjriUZE9JqUQ5NK58rSOyK0EjTe2jnEiwwKzWlM8jYboGPl?=
 =?us-ascii?Q?nzj4jrV/zjhXf9pbXHFKwog6ilWoAdLxq82Euc3rMnR/QMf1saaglsnEp/+k?=
 =?us-ascii?Q?iJ5h75SpsS0sQ5jsUzBEYWW6U0PywMLXt7Fc8zIURbWTDut+rVmObf+N8s7U?=
 =?us-ascii?Q?3GTdpCQncduf9aFpvYBDmwr61fHDBeo3blA5UJ1zwTv5SIj9taEAfao/7I46?=
 =?us-ascii?Q?heUREQoJ19l6YbdqXxfDCl4wqxnfJ9ipHlbbP6I/QQLMv7v75Y015nFHq1yP?=
 =?us-ascii?Q?gABrAul8DPsUAtH3k/Id1SwXZp4tHF8mNh7AZsC00+t81QzxzMXni821v5DO?=
 =?us-ascii?Q?hdL6VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25f5d0-d787-401a-ae56-08de3cbfa2e0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:24:50.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9Q+pAZMx1Zvmn34R7jkHALy6oPzWWj2LCVrrQ3MiueHmTwfhKkw4FrrfDE4m87Ks1vUbFVHrPII8UAS5J6aHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

On Tue, Dec 16, 2025 at 09:18:31AM +0000, Lee Jones wrote:
> Unless you add/convert more child devices that are outside of net/ and
> drivers/net AND move the core MFD usage to drivers/mfd/, then we can't
> conclude that [ this device is suitable for MFD ].

To me, the argument that child devices can't all be under drivers/net/
is superficial. An mii_bus is very different in purpose from a phylink_pcs
and from a net_device, yet all 3 live in drivers/net/.

Furthermore, I am looking at schemas such as /devicetree/bindings/mfd/adi,max77541.yaml:
"MAX77540 is a Power Management IC with 2 buck regulators."
and I don't understand how it possibly passed this criterion. It is one
chip with two devices of the same kind, and nothing else.


If moving the core MFD usage to drivers/mfd/ is another hard requirement,
this is also attacking form rather than substance. You as the MFD
maintainer can make an appeal to authority and NACK aesthetics you don't
like, but I just want everyone to be on the same page about this.

> > > There does appear to be at least some level of misunderstanding between
> > > us.  I'm not for one moment suggesting that a switch can't be an MFD. If
> > > it contains probe-able components that need to be split-up across
> > > multiple different subsystems, then by all means, move the core driver
> > > into drivers/mfd/ and register child devices 'till your heart's content.
> > 
> > Are you still speaking generically here, or have you actually looked at
> > any "nxp,sja1105q" or "nxp,sja1110a" device trees to see what it would
> > mean for these compatible strings to be probed by a driver in drivers/mfd?
> 
> It's not my role to go digging into existing implementations and
> previous submissions to prove whether a particular submission is
> suitable for inclusion into MFD.
> 
> Please put in front of me, in a concise way (please), why you think this
> is fit for inclusion.

No new information, I think the devices are fit for MFD because of their
memory map which was shown in the previous reply.

> I've explained what is usually required, but I'll (over-)simplify
> again for clarity:
> 
>  - The mfd_* API call-sites must only exist in drivers/mfd/
>    - Consumers usually spit out non-system specific logic into a 'core'
>  - MFDs need to have more than one child
>    - This is where the 'Multi' comes in
>  - Children should straddle different sub-systems
>    - drivers/net is not enough [0]
>    - If all of your sub-devices are in 'net' use the platform_* API
>  - <other stipulations less relevant to this stipulation> ...
> 
> There will always be exceptions, but previous mistakes are not good
> justifications for future ones.
> 
> [0]
> 
>   .../bindings/net/dsa/nxp,sja1105.yaml         |  28 +
>    .../bindings/net/pcs/snps,dw-xpcs.yaml        |   8 +
>    MAINTAINERS                                   |   2 +
>    drivers/mfd/mfd-core.c                        |  11 +-
>    drivers/net/dsa/sja1105/Kconfig               |   2 +
>    drivers/net/dsa/sja1105/Makefile              |   2 +-
>    drivers/net/dsa/sja1105/sja1105.h             |  42 +-
>    drivers/net/dsa/sja1105/sja1105_main.c        | 169 +++---
>    drivers/net/dsa/sja1105/sja1105_mdio.c        | 507 ------------------
>    drivers/net/dsa/sja1105/sja1105_mfd.c         | 293 ++++++++++
>    drivers/net/dsa/sja1105/sja1105_mfd.h         |  11 +
>    drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
>    drivers/net/mdio/Kconfig                      |  21 +-
>    drivers/net/mdio/Makefile                     |   2 +
>    drivers/net/mdio/mdio-regmap-simple.c         |  77 +++
>    drivers/net/mdio/mdio-regmap.c                |   7 +-
>    drivers/net/mdio/mdio-sja1110-cbt1.c          | 173 ++++++
>    drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
>    drivers/net/pcs/pcs-xpcs.c                    |  12 +
>    drivers/net/phy/phylink.c                     |  75 ++-
>    include/linux/mdio/mdio-regmap.h              |   2 +
>    include/linux/mfd/core.h                      |   7 +
>    include/linux/pcs/pcs-xpcs.h                  |   1 +
>    include/linux/phylink.h                       |   5 +
>    24 files changed, 1033 insertions(+), 683 deletions(-)
>    delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c
>    create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.c
>    create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.h
>    create mode 100644 drivers/net/mdio/mdio-regmap-simple.c
>    create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c
> 
> > What OF node would remain for the DSA switch (child) device driver? The same?
> > Or are you suggesting that the entire drivers/net/dsa/sja1105/ would
> > move to drivers/mfd/? Or?
> 
> See bullet 1.1 above.
> 
> [...]
> 
> > > I don't recall those discussions from 3 years ago, but the Ocelot
> > > platform, whatever it may be, seems to have quite a lot more
> > > cross-subsystem device support requirements going on than I see here:
> > > 
> > > drivers/i2c/busses/i2c-designware-platdrv.c
> > > drivers/irqchip/irq-mscc-ocelot.c
> > > drivers/mfd/ocelot-*
> > > drivers/net/dsa/ocelot/*
> > > drivers/net/ethernet/mscc/ocelot*
> > > drivers/net/mdio/mdio-mscc-miim.c
> > > drivers/phy/mscc/phy-ocelot-serdes.c
> > > drivers/pinctrl/pinctrl-microchip-sgpio.c
> > > drivers/pinctrl/pinctrl-ocelot.c
> > > drivers/power/reset/ocelot-reset.c
> > > drivers/spi/spi-dw-mmio.c
> > > net/dsa/tag_ocelot_8021q.c
> > 
> > This is a natural effect of Ocelot being "whatever it may be". It is a
> > family of networking SoCs, of which VSC7514 has a MIPS CPU and Linux
> > port, where the above drivers are used. The VSC7512 is then a simplified
> > variant with the MIPS CPU removed, and the internal components controlled
> > externally over SPI. Hence MFD to reuse the same drivers as Linux on
> > MIPS (using MMIO) did. This is all that matters, not the quantity.
> 
> From what I can see, Ocelot ticks all of the boxes for MFD API usage,
> whereas this submission does not.  The fact that the overarching device
> provides a similar function is neither here nor there.
> 
> These are the results from my searches of your device:
> 
>   git grep -i SJA1110 | grep -v 'net\|arch\|include'
>   <no results>
> 
> [...]
> 
> > > My point is, you don't seem to have have any of that here.
> > 
> > What do you want to see exactly which is not here?
> > 
> > I have converted three classes of sub-devices on the NXP SJA1110 to MFD
> > children in this patch set. Two MDIO buses and an Ethernet PCS for SGMII.
> > 
> > In the SJA1110 memory map, the important resources look something like this:
> > 
> > Name         Description                                         Start      End
> > SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
> > 100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
> > SGMII1       SGMII Port 1                                        0x705000   0x705ffc
> > SGMII2       SGMII Port 2                                        0x706000   0x706ffc
> > SGMII3       SGMII Port 3                                        0x707000   0x707ffc
> > SGMII4       SGMII Port 4                                        0x708000   0x708ffc
> > 100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc
> 
> All in drivers/net.
> 
> > ACU          Auxiliary Control Unit                              0x711000   0x711ffc
> > GPIO         General Purpose Input/Output                        0x712000   0x712ffc
> 
> Where are these drivers?

For the GPIO I have no driver yet.

For the ACU, there is a reusable group of 4 registers for which I wrote
a cascaded interrupt controller driver in 2022. This register group is
instantiated multiple times in the SJA1110, which justified a reusable
driver.

Upstreaming it was blocked by the inability to instantiate it from the
main DSA driver using backwards-compatible DT bindings.

In any case, on the older generation SJA1105 (common driver with SJA1110),
the GPIO and interrupt controller blocks are missing. There is an ACU
block, but it handles just pinmux and pad configuration, and the DSA
driver programs it directly rather than going through the pinmux subsystem.

This highlights a key requirement I have from the API for instantiating
sub-devices: that it is sufficiently flexible to split them out of the
main device when that starts making sense (we identify a reusable block,
or we need to configure it in the device tree, etc). Otherwise, chopping
up the switch address space upfront is a huge overhead that may have no
practical gains.

> 
> > I need to remind you that my purpose here is not to add drivers in
> > breadth for all SJA1110 sub-devices now.
> 
> You'll see from my discussions with Colin, sub-drivers (if they are to
> be used for MFD justification (point 3 above), then they must be added
> as part of the first submission.  Perhaps this isn't an MFD, "yet"?
> 
> [...]

IMHO, the concept of being or not being MFD "yet" is silly. Based on the
register map, you are, or are not.

> > The SGMII blocks are highly reusable IPs licensed from Synopsys, and
> > Linux already has DT bindings and a corresponding platform driver for
> > the case where their registers are viewed using MMIO.
> 
> This is a good reason for dividing them up into subordinate platform
> devices.  However, it is not a good use-case of MFD.  In it's current
> guise, your best bet is to use the platform_* API directly.
> 
> This is a well trodden path and it not challenging:
> 
>   % git grep platform_device_add -- arch drivers sound | wc -l
>   398
> 
> [...]
> 
> > In my opinion I do not need to add handling for any other sub-device,
> > for the support to be more "cross-system" like for Ocelot. What is here
> > is enough for you to decide if this is adequate for MFD or not.
> 
> Currently ... it's not.
> 
> [...]
> 
> Hopefully that helps to clarify my expectations a little.
> 
> TL;DR, this looks like a good candidate for direct platform_* usage.

I do have a local branch with platform devices created manually, and yet,
I considered the mfd_add_devices() form looked cleaner when submitting.

I expect the desire to split up reusable register regions into platform
sub-devices to pop up again, so the logic should be available as library
code at some level (possibly DSA).

Unless you have something against the idea, I'm thinking a good name for
this library code would be "nmfd", for "Not MFD". It is like MFD, except:
- the parent can simultaneously handle the main function of the device
  while delegating other regions to sub-devices
- the sub-devices can all have drivers in the same subsystem (debatable
  whether MFD follows this - just to avoid discussions)
- their OF nodes don't have to be direct children of the parent.

