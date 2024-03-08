Return-Path: <netdev+bounces-78868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCE876CFB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8438B1C20D0B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7465FBB2;
	Fri,  8 Mar 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="uPtJJqIW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2129.outbound.protection.outlook.com [40.107.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775824B2A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936647; cv=fail; b=prwE5w/YkBgk/BFFTzTxfhI3cb6dBBKBKurz7Jjriz8Emxteob0qtfxlx3PtxOCJR4x362exMm4/m+RqhKTsezqvnnfs5mvcj4FfR7NrdElxMmblPK2yk/PQk86vkiripZJ6AcjtLS3QNaP4rqYK78IDmJGxIWSJcWrUE502/LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936647; c=relaxed/simple;
	bh=j6EzygJ7wwZjpg3i2P53IIK3ebxIhXzAKJtHlXZHBWY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=Ge90WezIhwrf3RNWE613lNls+t1nDDg8VnLDILZkoFU+BENoshbzHJQ3ohV732HqRCQYprA1UicFLs8mN5lns0fOO+ehoei6JlH8MIQ6HL9l6utwZotczkp5ZqFIlpjjSpDTZCnWARLTRuYhnaDp0TXZSUCLhWfqMRLfXwiEYc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=uPtJJqIW; arc=fail smtp.client-ip=40.107.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFLAl49KKGsFSm9EG70bnZQpXkEImev7PMB23nO1/sKsqX8T6fRLq5DZ3Gb6kv7URPPWh072FAjoKeh9pP9v9x3lOguFNJd3oq2ZIG+MR7pKMHk9X7hB7oi0HAgSzrI7xQeANSUSb3T1m2wiSCoNdPM4IVHArKFoJ6RU9IKIGx6NTdibzHp6DZfw7FwA6Mq2YvZAL8VvIz9yacO1F1SVny1xtxJi9zfgR48cfu1xbE0tsC5p4ceqi1vmBnosA/Lmsi6IMx7kuQrnLa+m6aylZLEOU+bK5MwOoVH+KcHm7tGqUjnjDX05Q1gJf5QiOQscYhH6d6vyzPvj3IX+TcXn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJBN4kCmPbxt4iw9VSER/Yz+StA1z1gDYiTqvtH/zZo=;
 b=THfiMbySRJo8ZTzFJz+ebGWkfL4Zn4U3lL0omGrQjbnEtsfpJvlCy2Kj2yX8/EoqcZtFPtnCDKdj3dE7Jeo8lPqRwiuHayDlJuGfxLyqhzw0VjosZ7Iyxjui9/x8Ft3tqB6iyMHA7FgQSvXNfsw+exKRyxnKPPqggNqzeLjlzVJqJ2sOqoUUDN2rpfhuSHNDsu/8vK7scWOge3PaNHeq8lZGFeyjb9d/ECrFLOdELgOfNKvpVhrCGiqen6z4LpD7mEkkKalXenerm1LEJvoctFRjd+wdSGktDyS9S3stfsJgivYVOakLkqi2DegSfV2TTiYKTxawEeDflGiToMBX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJBN4kCmPbxt4iw9VSER/Yz+StA1z1gDYiTqvtH/zZo=;
 b=uPtJJqIW43ZE74lhEj917FSCAdpYy7DtHixX7njCKEdcsqLW4FJKrld9OwL12d+JVYSooY1KFn5D4uSoBGO3msrY7ebvlXmJUgARuUbcJLHO8J1R/xMQULx/0V3jeroROLI7DQQNZF1JDi3ytbJ/XPgo5ialM2BlOAZUIRN+Z6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by MN2PR14MB4016.namprd14.prod.outlook.com (2603:10b6:208:1df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 22:24:00 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::f98a:6287:8b91:ad78]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::f98a:6287:8b91:ad78%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 22:24:00 +0000
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-7-chopps@chopps.org>
 <Zdsv19c9nTqDF0TB@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v1 6/8] iptfs: xfrm: Add
 mode_cbs module functionality
Date: Fri, 08 Mar 2024 17:21:20 -0500
In-reply-to: <Zdsv19c9nTqDF0TB@Antony2201.local>
Message-ID: <m24jdgicqq.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|MN2PR14MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: 17813a3c-f10f-48d5-db37-08dc3fbe73cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rUaGs9i24o/ZPMQbf6yI4T+ZPvPkv8X/aTwVk8M6KJfi/zNjTRN8QUECy7OHXg2so2kUxKuJJVdJDYndUOD3ZQguFbPiXzaygfP9/8D41RicxKqtZKGrveidiusagno25oNCVUwZUOrSa9TonWIoCrD8XqWD8ZLIUJC6kceUM/AsMSkdTfNuQ4Bt7Qeo2cKSeRPJ+hA3u0bE2zpm+4w7FzhVUe2Ffn/uceqNx6AGljgTOEiyMgxc6jkY/7aGn0eX8onmXyV1N9IKCBIb1+V3mnge2wyKlia/3p2vpWQi44+/NSpN8/nIwWJTGp+UqHw0O7B7dil4X32mejU58IVIgSS1fnj4NEKUlJ464+Cuw3dFae81T0F1bdl418XidSMtrCBYtM5V9y0m5gYfCChsnCupfaPm5/VZa0WPmBOL2u5it8gBu3IFqPPu7waPxNFycfeDVdMwpuBcWb6iLnCp60e4lsm2ql/cXvUWJ+6tiXTeRB1gn8Yi79i5Msc3i29bDIhDqf7bAoCBwPokM/1Dl8RWSLEUQlQJiW6K8N/x7HOQQkkfSn77dymVwG2Mr3hFOpwdxv9exBGIxDaX0gSfsCgh7egM66kKvt01BqUyPg6wLcVATHGzrnVTHyMipbzEMnJvVmVql7M2KY+1YydgivtNujGnrv3/TFDeeH+bwf0NBl5OD0SYmBxQIJWW50D34g/5kM1gBAh+KUm6NsE/gEQOyVd/s6Qmv9oLhM+Nrk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6u7WgeEbfSsIsVIyFxBJ36LMJPGgtBkwGgYWc0LtHns0PWJRwGyw656XS641?=
 =?us-ascii?Q?DVzEMC4ug72zNHxvIr4ariDbAAsO9npv61y58spmd+luLwQLROw9Ydb+flo2?=
 =?us-ascii?Q?8SEh3OHSZgXhXQKX1ROs8m0BqFenZNeNnYj1pnFAvzRWJMqK4USvrNu8c1fW?=
 =?us-ascii?Q?UkgZrzF5150rgQ+DuvUfCU8Z9up0Ik5tIIYz7nSDSRUkXi8tsqvD3WxkzM0C?=
 =?us-ascii?Q?DMV+OIMwUvg24uB8Y7QfXHBcTTY4eT5bWK1UKn8eBx8GmCOgI9fBcbe3MBGb?=
 =?us-ascii?Q?V5d2M+PHF8eSe1QSA61KYoYR9Zl0ORMPKg0RxdhnQ61Z2gavBOpf7zfiPFfk?=
 =?us-ascii?Q?906twV0DSWgKgBUR9xJx53NkOZgvSo7zA1jd+7PM/Iv4zM7sM1JrKmw+cBMD?=
 =?us-ascii?Q?WySY3I6FRRklNuHFcjgfm60dgFD/lZIXbz7PIU//03cQpXADWdTpW852qvb4?=
 =?us-ascii?Q?/dgd6gFD6ZHbJIvmsT2zGHL8edNeuKy0iJ7NrzpN/EuN+OnxxTcfyrvFX3Nz?=
 =?us-ascii?Q?gyQKI8ggG9i1sM27HKB/j1kAxvJGsjsACt/gA2zdYX+frczYt3TeL+csuOwk?=
 =?us-ascii?Q?WmhESTsXqlzC4WBH+Zy5kW6o2USEfik8eg1651/Od6fc3q9D/MlO2E8Q9Tqy?=
 =?us-ascii?Q?A4z3D5/BrmX31jf4VVrr7on6jir7uv5OzJ6GsbmLaypIQv/GyRlgnrdDPwQn?=
 =?us-ascii?Q?OAtq0Ziasd5RM0lMg7aUJ+1bpD7VBKJ45ChfSHTYcc/L4UnauLCVhBgcCKO6?=
 =?us-ascii?Q?Qp6JDpsAdNKMCd2lfgAH2jHMr58GR2Cr8GHDjXQOfBb6O7XK1WlQD8Tnva8b?=
 =?us-ascii?Q?92IO7M6DAcSMaKA4wtyytNxX59PCM9+ZlUpJ2kDFbfY6nH6C9A+21R2esbaK?=
 =?us-ascii?Q?h3fV8Ra25wPQJ/Gl5RWpHSXGEt1JFy1d7ZT6CXBkr7zQDdiB9YgOD7xEl4sj?=
 =?us-ascii?Q?ypo17th2GoD7TZ5VydAGXeVuV5rROP7UnhR+84ZrmSVwPWy7UCe4ue82+VDA?=
 =?us-ascii?Q?hLDfQgD+sSXMmjxyoCbgObjq0Pf7Liqj1GwXdkIHbdkwBuYeNGYtJUoT4OAr?=
 =?us-ascii?Q?svrZ+SQ3+DS1rdsj7OV29rtsBrrLmhSop6Eq6TRN18qFGCa525QDx3Uk/opE?=
 =?us-ascii?Q?TEtFezW5dfsLa/BeASnH0k/kBhNErnr7UUZAoG5IdnG/24LnYLBveEIWtghs?=
 =?us-ascii?Q?CHoevLKzJKugbsTtWdMn5ERpt0hkcRrL0+FsRapQXsHe4NRoV0SYg12iBI3x?=
 =?us-ascii?Q?YVNrhjYhsLFLrxsA9ZFeo9GdM6lMUIRBXvoJm7O0r+WOQjQ2coGrJI8Ytl5d?=
 =?us-ascii?Q?Er52CV5iNyU/JD+qhiJH0vvQVoYHdN0kGlj6kB81Y/+uWVeorHJYX31uDnZG?=
 =?us-ascii?Q?dQOe1EZPxvl+d5slGxJQujbMgt/rPxvC09pgCD8IQeRHqaY7iHNB8T5nQQLX?=
 =?us-ascii?Q?mc1eQaL+8ByzFufaRGb1Xg7snffUufMP/AKTSJfMvIprumw2jHar5I582w4b?=
 =?us-ascii?Q?JG6Cd5bl7CGRfWq9yNIG/X9G1clmFT1dERbbQZQbWF/krwAd9jdx61t1d2Dx?=
 =?us-ascii?Q?M1wzeTU+u4GduRgz02DWuifmE5g8zR0ml+S1Pili?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17813a3c-f10f-48d5-db37-08dc3fbe73cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:24:00.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOaRW0deJ+MvTymDNZwgaWkrFserUXSX++y9g6Ef1QS4THYaX17TAbXmXtDZ6nb+f526d2WGP3JRHZuBOVIi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4016

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony <antony@phenome.org> writes:

> Hi Chris,
>
> I was testing this version.
> And I ran into issues when migrating states. IP-TFS values are set to 0.
> I noticed 2-3 issues both in this patch and 8/8
>
> On Mon, Feb 19, 2024 at 03:57:33AM -0500, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
>> enable the addition of new xfrm modes, such as IP-TFS to be defined
>> in modules.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/net/xfrm.h     | 38 ++++++++++++++++++++++++++++++++++
>>  net/xfrm/xfrm_device.c |  3 ++-
>>  net/xfrm/xfrm_input.c  | 14 +++++++++++--
>>  net/xfrm/xfrm_output.c |  2 ++
>>  net/xfrm/xfrm_policy.c | 18 +++++++++-------
>>  net/xfrm/xfrm_state.c  | 47 ++++++++++++++++++++++++++++++++++++++++++
>>  net/xfrm/xfrm_user.c   | 10 +++++++++
>>  7 files changed, 122 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
>> index 1d107241b901..f1d5e99f0a47 100644
>> --- a/include/net/xfrm.h
>> +++ b/include/net/xfrm.h
>> @@ -204,6 +204,7 @@ struct xfrm_state {
>>  		u16		family;
>>  		xfrm_address_t	saddr;
>>  		int		header_len;
>> +		int		enc_hdr_len;
>>  		int		trailer_len;
>>  		u32		extra_flags;
>>  		struct xfrm_mark	smark;
>> @@ -289,6 +290,9 @@ struct xfrm_state {
>>  	/* Private data of this transformer, format is opaque,
>>  	 * interpreted by xfrm_type methods. */
>>  	void			*data;
>> +
>> +	const struct xfrm_mode_cbs	*mode_cbs;
>> +	void				*mode_data;
>>  };
>>
>>  static inline struct net *xs_net(struct xfrm_state *x)
>> @@ -441,6 +445,40 @@ struct xfrm_type_offload {
>>  int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>>  void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>>
>> +struct xfrm_mode_cbs {
>> +	struct module	*owner;
>> +	/* Add/delete state in the new xfrm_state in `x`. */
>> +	int	(*create_state)(struct xfrm_state *x);
>> +	void	(*delete_state)(struct xfrm_state *x);
>> +
>> +	/* Called while handling the user netlink options. */
>> +	int	(*user_init)(struct net *net, struct xfrm_state *x,
>> +			     struct nlattr **attrs,
>> +			     struct netlink_ext_ack *extack);
>> +	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
>> +	int     (*clone)(struct xfrm_state *x, struct xfrm_state *orig);
>> +
>> +	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
>> +
>> +	/* Called to handle received xfrm (egress) packets. */
>> +	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
>> +
>> +	/* Placed in dst_output of the dst when an xfrm_state is bound. */
>> +	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
>> +
>> +	/**
>> +	 * Prepare the skb for output for the given mode. Returns:
>> +	 *    Error value, if 0 then skb values should be as follows:
>> +	 *    transport_header should point at ESP header
>> +	 *    network_header should point at Outer IP header
>> +	 *    mac_header should point at protocol/nexthdr of the outer IP
>> +	 */
>> +	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
>> +};
>> +
>> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
>> +void xfrm_unregister_mode_cbs(u8 mode);
>> +
>>  static inline int xfrm_af2proto(unsigned int family)
>>  {
>>  	switch(family) {
>> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
>> index 3784534c9185..8b848540ea47 100644
>> --- a/net/xfrm/xfrm_device.c
>> +++ b/net/xfrm/xfrm_device.c
>> @@ -42,7 +42,8 @@ static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
>>  		skb->transport_header = skb->network_header + hsize;
>>
>>  	skb_reset_mac_len(skb);
>> -	pskb_pull(skb, skb->mac_len + x->props.header_len);
>> +	pskb_pull(skb,
>> +		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
>>  }
>>
>>  static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>> index bd4ce21d76d7..824f7b7f90e0 100644
>> --- a/net/xfrm/xfrm_input.c
>> +++ b/net/xfrm/xfrm_input.c
>> @@ -437,6 +437,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
>>  		WARN_ON_ONCE(1);
>>  		break;
>>  	default:
>> +		if (x->mode_cbs && x->mode_cbs->input)
>> +			return x->mode_cbs->input(x, skb);
>> +
>>  		WARN_ON_ONCE(1);
>>  		break;
>>  	}
>> @@ -479,6 +482,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>
>>  		family = x->props.family;
>>
>> +		/* An encap_type of -3 indicates reconstructed inner packet */
>> +		if (encap_type == -3)
>> +			goto resume_decapped;
>> +
>>  		/* An encap_type of -1 indicates async resumption. */
>>  		if (encap_type == -1) {
>>  			async = 1;
>> @@ -660,11 +667,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>
>>  		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
>>
>> -		if (xfrm_inner_mode_input(x, skb)) {
>> +		err = xfrm_inner_mode_input(x, skb);
>> +		if (err == -EINPROGRESS)
>> +			return 0;
>> +		else if (err) {
>>  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
>>  			goto drop;
>>  		}
>> -
>> +resume_decapped:
>>  		if (x->outer_mode.flags & XFRM_MODE_FLAG_TUNNEL) {
>>  			decaps = 1;
>>  			break;
>> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
>> index 662c83beb345..8f98e42d4252 100644
>> --- a/net/xfrm/xfrm_output.c
>> +++ b/net/xfrm/xfrm_output.c
>> @@ -472,6 +472,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
>>  		WARN_ON_ONCE(1);
>>  		break;
>>  	default:
>> +		if (x->mode_cbs && x->mode_cbs->prepare_output)
>> +			return x->mode_cbs->prepare_output(x, skb);
>>  		WARN_ON_ONCE(1);
>>  		break;
>>  	}
>> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
>> index 53b7ce4a4db0..f3cd8483d427 100644
>> --- a/net/xfrm/xfrm_policy.c
>> +++ b/net/xfrm/xfrm_policy.c
>> @@ -2713,13 +2713,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>>
>>  		dst1->input = dst_discard;
>>
>> -		rcu_read_lock();
>> -		afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
>> -		if (likely(afinfo))
>> -			dst1->output = afinfo->output;
>> -		else
>> -			dst1->output = dst_discard_out;
>> -		rcu_read_unlock();
>> +		if (xfrm[i]->mode_cbs && xfrm[i]->mode_cbs->output) {
>> +			dst1->output = xfrm[i]->mode_cbs->output;
>> +		} else {
>> +			rcu_read_lock();
>> +			afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
>> +			if (likely(afinfo))
>> +				dst1->output = afinfo->output;
>> +			else
>> +				dst1->output = dst_discard_out;
>> +			rcu_read_unlock();
>> +		}
>>
>>  		xdst_prev = xdst;
>>
>> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>> index bda5327bf34d..2b58e35bea63 100644
>> --- a/net/xfrm/xfrm_state.c
>> +++ b/net/xfrm/xfrm_state.c
>> @@ -513,6 +513,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
>>  	return NULL;
>>  }
>>
>> +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
>> +
>> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
>> +{
>> +	if (mode >= XFRM_MODE_MAX)
>> +		return -EINVAL;
>> +
>> +	xfrm_mode_cbs_map[mode] = *mode_cbs;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(xfrm_register_mode_cbs);
>> +
>> +void xfrm_unregister_mode_cbs(u8 mode)
>> +{
>> +	if (mode >= XFRM_MODE_MAX)
>> +		return;
>> +
>> +	memset(&xfrm_mode_cbs_map[mode], 0, sizeof(xfrm_mode_cbs_map[mode]));
>> +}
>> +EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
>> +
>> +static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
>> +{
>> +	if (mode >= XFRM_MODE_MAX)
>> +		return NULL;
>> +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
>> +		request_module("xfrm-iptfs");
>> +	return &xfrm_mode_cbs_map[mode];
>> +}
>> +
>>  void xfrm_state_free(struct xfrm_state *x)
>>  {
>>  	kmem_cache_free(xfrm_state_cache, x);
>> @@ -521,6 +551,8 @@ EXPORT_SYMBOL(xfrm_state_free);
>>
>>  static void ___xfrm_state_destroy(struct xfrm_state *x)
>>  {
>> +	if (x->mode_cbs && x->mode_cbs->delete_state)
>> +		x->mode_cbs->delete_state(x);
>>  	hrtimer_cancel(&x->mtimer);
>>  	del_timer_sync(&x->rtimer);
>>  	kfree(x->aead);
>> @@ -678,6 +710,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>>  		x->replay_maxage = 0;
>>  		x->replay_maxdiff = 0;
>>  		spin_lock_init(&x->lock);
>> +		x->mode_data = NULL;
>>  	}
>>  	return x;
>>  }
>> @@ -1745,6 +1778,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
>>  	x->new_mapping = 0;
>>  	x->new_mapping_sport = 0;
>>
>> +	if (x->mode_cbs && x->mode_cbs->clone) {
>
> I notice x->mode_cbs,  it should check old state?
>
> + if (orig->mode_cbs && orig->mode_cbs->clone) {

Actually we need:

+	x->mode_cbs = orig->mode_cbs;
	if (x->mode_cbs && x->mode_cbs->clone) {

>> +		if (!x->mode_cbs->clone(x, orig))
>
> iptfs_clone()  return 0 on success. So
> "!". x->mode_cbs->clone -> iptfs_clone()
> also use orig?
> +		if (orig->mode_cbs->clone(x, orig))

Thanks for catching these!
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmXrj/0QHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJeVsD/4gddPJs+S2yBLPVfoInZg4qUffrd+fhgHq
foy6UDpEOyCv5WR8RFLf5uXKQWDl7WatVeobcOhIX7/Sz4BWvsZ+H0YkXZxNwttU
py2/0rUtiExNYIKoICtY4RtweUjgDMHvdB1Bo0iNZdtSZv78JKX0rc02qopd/dNo
vmR6xhZ+7dV6X4lk7waekFT4hRKdmjUPo/mJl4dTlBxDLRj4FS2jMOCyo47l4drL
yLFSdfETdiNK1FIL0CuKvJXU9mU3K/bC5IHmuwvXDOyo8socgcQKgWQG57Zc9DES
WHozSOkMighucq5z5UAylMcWQ3vUQRmXHoThicmFV/BurL/+0d7WG7YeSyxK72dG
kisa48uPXmJiJmE+V/kq6H1FLPbvybNLqVcHEy/DTjvHjzaDX4XimWMIaJtMIde0
8sQJ/lP0iCQWtdxvG9e2BSPUdBupRCDh/vauWB24VYi5++e3FQpK4UVB+dYM702p
BAi3O7veSH+rgmPnRM2MAp96W731sPoQG8xnrP7U2ulk9JyuAiXbu0aHVc32j7fK
WKBkSo8wcIQnFoZ4FvRKJ7YJFG9MMgZcjzK3dGcbTpwaO89faf5gSQuofJBju6Xn
ZSdQ2ZR7Yy45Y2nmBRbCaeDLO5DfHAvIfCeiU5wfXt1ncJ2uAsASuL62Unj5Crq3
HaW9xFaeZQ==
=QTtP
-----END PGP SIGNATURE-----

--=-=-=--

