Return-Path: <netdev+bounces-262739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBByJBe+pWn8FQAAu9opvQ
	(envelope-from <netdev+bounces-262739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:43:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B431DD194
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AEF3018D44
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746641160F;
	Mon,  2 Mar 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lmRbq7h9"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C10374162
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469421; cv=fail; b=DMN1ft5PEpj/E9YA8SPZwrSXwGY0Qi9kBZWxFj/o187YxHVo3vWfedIWypnRnXO/dmvIjzmgkhNP54tjFilDUx4+3pwCAiuvHqpPuikfS3m/A7Xl65RLX2fv1GARKEUCGwXAuqGw+0UBlJzt3VLUV5oYaOUGET+2NwOxl/b2Crc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469421; c=relaxed/simple;
	bh=V+edY2J/pyMEtHXEEyzmsw5dEHS0tQQm4lFa3P8zTJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FzwipjT9I7VezP63gIXUuo2tnaoIOu+hJtykH6st0QEv7o9gzkg+VOOai2A02d1U9578ez7I7IGy0WezJFFKiuGxZSXX3jZNcfeYlb7rzie/k2BYwEm8nGn1iwrsiBdDFMWfH7CKLZEeS/MLkkmDvqrLyuCd8nWmNYa9Eznhjqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lmRbq7h9; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btetK4NOWNPRO/37baqSdARkycjj6ga4CNj9QleXJEAifGXbp4g7jqZhuJJTtGQ3+IKCm5YBafMVGvqj4tMObcPyCBrAe/ryP26Wp659qRgCVrxmPZhX4OLRkdXvT9xs+C2z+NvKUXvQUBD6AQdsAM7SvKN9UC1bNtF/Ebw+BUrgJ1QTtBRqOfYtLlqiaVqQIi8Ml0r17oMCo1b2E/4ECEzfpOdCOPdENdzGRtuzkkVO06GrdR9NzxQY14rHrLEUB94bo7urd4q/GIlCNv/JdIaz+uG9xKESiktPChhFnaYWiE94MOP/LaQye5WGbC9cqZpMM+KcliqssE4nSSdRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtWSB6aoG8rFjcy2gv2IhHbDfZRYEH1j6a5Q0aM5Pio=;
 b=I3o2/tIpsFQjIwqQMVvbsGstWoKE4/+8wsO3aerwAaSK5zL1gHnKj+vVuxDJ2tmeAWiuz2X56oxfuGy2txOhrG/lenbfKJJl/dg2JReDijjkVeIQXje2/U8QMzGaO5rigVn5D59PrIjyS+VPLdFC9Wnkk0RLfJb3W5iCLn9oSoxzEYeTPmLr+JsJcbn4pUhPK5sDaRGsOsxt/KoUFIjLpwvUZsgq1ADUv30RNvy0/584DRWJosTXPjJNGoXvEXAd6RYxIsR7L55+UkUbmVOyHW9YixwSO6ICFmRqFaeHu5Yb4s9KoVqcia06ZDYkCwpwdY7vPLcQOuE/kvd9iDGcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtWSB6aoG8rFjcy2gv2IhHbDfZRYEH1j6a5Q0aM5Pio=;
 b=lmRbq7h9IMMZLcNleC5u9nnsDJA1B7cWGTx61/vKbAaLboNfG4QTGy/fWOSzQsyumvu6Wa97vpcWAZmwz+h0tpCwuIVrBWlsZaYTztmq0jxeeGYAjYL0U1DkKMP+ly3A7ZQOT+uuaMmtBZzdN9YIj5S4kh7DsB/1fj1rOziGvh9AM/EW36rgFQHmNzo0x0YHOwtAzP5rZAR7ZVp1jyuIhEvqWMKYNYysXT+UdSPgr6Bg8EjiEeJU3B2l9aaWMJJWdxqrzOPKl75ycxbrxuz6Bd3JnFqgIU1agdxVpIZYQTS28xOBC8y5ez386F7t2TSI+4BiCk5ktM5czLGIEDUyfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:36:52 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 16:36:52 +0000
Date: Mon, 2 Mar 2026 18:36:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, roopa@cumulusnetworks.com, sdf@fomichev.me,
	petrm@nvidia.com, horms@kernel.org, razor@blackwall.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <20260302163643.GA971179@shredder>
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de>
 <aaWiH5KBf-n1NxAR@krikkit>
 <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fb7472-e526-4d44-64c9-08de7879e876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	FlQF8IAeZCIMo6cEPSYjhmY3r5yi7l1mSw/E6TAA8w1v6hla5RhVuXYq1c6bg0QtJfLsCOxs32GIyFc0JgseJMABPtEuf8TiB3RjsTpMXWrwAR/BxspQaBiGBcmOqMKrgbAlT6TKTY4pbuTFNYUwlvT5NwoNKQ0dKabTo8Aj7b7LDAA7eLPserQO8gQypr8ccr19VJGSt58xwMWt8cM/8rhcn6hYitwtOhgyGj0QqpSjCpGSJWNJs8Fewj97sjj9EKRL6SuaUGxSH7PU09nnT54RtQJu3GSGr/Ig21tHVeYs3iqmQvdc82nRbI8bSStu8IhWzWgYTWEZV3DtEgIruQpy7sxk86p/0O1ppm+yBlJHfivw3l/mQt3VZYZ/wxjXTvzj42vP2QnpW9sCYU6ohmBMEiAE++kcG2jdMKKV0sTMk0VRW8yK7C47/5tQ9oNEF8WD7bgUsDGNHs4sAUrEUyH9UqqkRRc2BmuoGOcfF/c2qefOWmG2vsQ/VdlB8ChBFOP1zKAtsbTX1Jz/YCT0XsSM0yTTjVdbHyXyy+lrksqqdP7ZbK/6ji5pZINncHti5KZFgEPvWUQxpHUXaPpZyoovjxhPns4qzm2hyGcGneA0tynmJOzzfKpmGZyKoR3Nn/7WoJwP+sMpu7j5CHSCHrrYZrTiPj2ZTC0NYJQWGNP9u9njq4SFltzWA7psdJtSOEb6s3xdDp1asFrGh1zTIc48ySET/NGiy0KYCWaW6SY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4DbF8Gj/Iv1YxIPnNNA4sGxChag1wZbceTiyxDGHxd+gzMdBKYGpRMvE28Qv?=
 =?us-ascii?Q?aI1m6kHvchFhSJ8IQAcgwz7Xp2VD9Mr+UrKNKm1uuZCWq7GNi5aecoSvjctS?=
 =?us-ascii?Q?iyLaEX6qDcp1F5A/WjCQ6tzMRZan2mAnaMtoJyolVPTuoC4LTY8wb6v2Z9bj?=
 =?us-ascii?Q?StK90V7G5roqeJR81zM2CmWPLhvKj575igWwjxaEFNbyWNaMoGNV7yd2tve2?=
 =?us-ascii?Q?dq/1fw0OSphDnq+s/R+/paIPzX1gJ+jH2lV04iPIfVRu1Q9f4BkfsdG6vCSu?=
 =?us-ascii?Q?QYlIlzzdeaLZ28aSThSDD08Nk0sk+pKugyAmwuDYiPe8rHXQePPGQRePKU+G?=
 =?us-ascii?Q?G8iURY5X3jri6BE3C/E83crVX0BO6EddPsLYU57mKeAsX3daYih/hdO803/D?=
 =?us-ascii?Q?JK3eqt6NbMwEqX4flFsTLe3mXVzUlo3YJB/csK6/7P8yspmrHnz2FMkd4PIp?=
 =?us-ascii?Q?NgUCcJ3VQTMPoW9YiBCmlsni2h/lU5nFsOX406P0NTsMoplV9lbZRZulVjXT?=
 =?us-ascii?Q?mayl+Z1yo4x6Th95QfnKHnXJPc8PHRkfSuR5Q6jYUaoFp6BMjRQ96RLCzy/H?=
 =?us-ascii?Q?56B7ANsXBA4X2jPEfGhHTksA7CC72ou++cOCzNLMZ1k8Tw4mCHfhfcSa8toZ?=
 =?us-ascii?Q?vQPJ4pMhLIoxpzl7a2jOckxkHaJK4uMXUyuiJrXJ/22TzHefO/nR21MhLyyS?=
 =?us-ascii?Q?t6jCW49jsHn0784WT+Y3Z1FB8wfWD3UconHEa6FcTwnFCH6p/YI7YgytScZf?=
 =?us-ascii?Q?AJkEseERXOuHApz0NARH8OilmkCATWh7xLfsV/huCxoZRy7IKIkttlraSiBC?=
 =?us-ascii?Q?toTSEfYb9XipGJ1rUB4mwP9/PAIUaf1iOly5iOvtbc19IJxKJhxWfVGwR95W?=
 =?us-ascii?Q?xXQwspwhSUZjCoTzdWIffT6Mcz5ZaoPiwRsp/JAGTrcH2jM8mFoiT/Bnyqx/?=
 =?us-ascii?Q?mrKUz5yW4TQa3rwvkYqTPR7EFn2jqM+HdDAiO4bYiL5yvRMiDj2ilYYskEgs?=
 =?us-ascii?Q?wPpdW4DQq83ri8YCcJc1MwQ9ORYqbUpC3Q/h651tcbyFAAIKBCR1xT7+/GG6?=
 =?us-ascii?Q?m1dYFLkbTONzLeTIGkvIDZP+gceITOpLWLTfctheZI93R6nexkp463Yd4qpA?=
 =?us-ascii?Q?flWCaawDe2frkr3Zf3AuTjwaRYHKbgunjyDWTv+eZb+lvFoWJbgPFWG2rnvv?=
 =?us-ascii?Q?ude9dnOlmocYk/zsUmsfA7etX9sjzZHqTmK68AFg6qTC3qU+gOQ0zalAM05x?=
 =?us-ascii?Q?v5WkhTtmR77j6uy2wTauX2YoOJiaYVdB67ZxvX5diKGsXV0gHBwX37I4IJ3z?=
 =?us-ascii?Q?Qg5eGgb/SvzBAv4rWh+xhkKKRCN2SwWv0k+3jnR/TblP54ZJ7bHiSDjQuQMo?=
 =?us-ascii?Q?ZVn6xl03QUokLrlJDiAdMx9yjJiY3Ya5LLSA0Cx6vtNMQlfub3GbwDdODPQ/?=
 =?us-ascii?Q?GiTskYc/NlmdCW8/h6S4EQmBa6k+AJCpvZmM9+AuXtXZXqcbUB4VQt3/U69f?=
 =?us-ascii?Q?Eik0r1sq3kDNNz2Zyck1egKbUrGMQyE6DhI8KA06TuOltOrsb+0Y3qTuNdbe?=
 =?us-ascii?Q?8JBls/y0mQDuNC0acEWg4hSUKGz4A1yHA75bllq8a6H9RhTMf7o+x3JovUl+?=
 =?us-ascii?Q?/YZV/YoPGKG84XHvSl4nqVh5UKk8X19F3q4Z0lelEIg/ghVDTP2F00a3eZ8e?=
 =?us-ascii?Q?CaKbPKfH+p46Q6g79EajSR7CRFD+CPQzAxG7ZWVIOhLswLO//m74oX6kotmj?=
 =?us-ascii?Q?4z9OH3xtxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fb7472-e526-4d44-64c9-08de7879e876
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:36:52.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2lzhmTh0Y2TDSI+4nNHCKHwSeCV6ECEp/Jk1KSw2yUR9va3MKJ94gEclRXB8ym059dlg2HwIWPwpFXLxTGjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
X-Rspamd-Queue-Id: 16B431DD194
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 04:13:14PM +0100, Fernando Fernandez Mancera wrote:
> On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
> > 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
> > > When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> > > initialized because inet6_init() exits before ndisc_init() is called
> > > which initializes it. If an IPv6 packet is injected into the interface,
> > > route_shortcircuit() is called and a NULL pointer dereference happens on
> > > neigh_lookup().
> > 
> > VXLAN can be built-in even when IPv6 is built as a module, and then
> > ipv6_mod_enabled can't be used in VXLAN:
> > 
> > ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
> > drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0): undefined reference to `ipv6_mod_enabled'
> > 
> > 
> > GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
> > ("geneve: fix build with modular IPV6"):
> > 
> >      depends on IPV6 || !IPV6
> > 
> > but VXLAN doesn't.
> > 
> 
> Ugh, good catch. Thanks Sabrina.
> 
> > But then I think we don't need to use ipv6_stub at all.
> 
> If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of
> ipv6_stub completely and use direct calls instead.

I just noticed that this is already enforced for the bridge, so maybe
you can just remove ipv6_stub in patch #1?

