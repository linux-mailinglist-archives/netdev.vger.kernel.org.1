Return-Path: <netdev+bounces-272239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EnrISSYxWmK/wQAu9opvQ
	(envelope-from <netdev+bounces-272239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30133B76E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72CED303B2DF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB88351C3E;
	Thu, 26 Mar 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0XMxI4+"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5193451CE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557206; cv=fail; b=RKHINaaHgXD+pnk7RIupuber2YqI+TSH+5nki2ON3pxm6OKNuRyvpfZyY8Xa6WjQIXXtmP5zGKxxwajA9K0pOCJgUnghZMnP9OW+JV2r6ud2PxxsbG8qQRE0snDuux7f2xCVoWgSsNAWdj0biNHrTc+yyAdF8R/vm1maKUDq9WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557206; c=relaxed/simple;
	bh=xfrrZV8kQ3hSlYETwEQoFMWLC7xZ1MT0J/B66tYANUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ko/T/Q4+7kf/wrzWiDnV2VAFxzpjL0ivBg9fpW8EanE9LXX7VILjjDOfNKU713dOseqwsfuonUf0iPj8rlpjbli/pmmYiJ/anH8GYDnMv7Hl4gcDcTJ5ENyhK7iq5krcMuyQnwuDNTiO6lhXX5QAv+Q9t1497vLjrbUt45/SdO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0XMxI4+; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ags9aF1Ggxn3FSN4W/IUajYW9ivs38nwLH0UdHlP3ZytUVwcAjVMlXeXeuA7zhD21E0jWsw1Jg5x/0vKX1QseTDZLJgA689OO5KwC9GZYZBSZZIm0o6ikcz3abXeWBRG5qqzj7WLz1xYRzwadVmH+bOrffp1ukyuIlcqOanKlQPJWitCo6Be2bsqDBguEpHAc07rorlGWoITSy2JE8TfF6aFGADDuheU2HaOfAlA6Ufjp8d/TtXAuK+sEmIGVU7Wg0dQtLhojs+nrF0+M1HoME+n/iXMJqW6vM36pCgtHuMCKb0qr9UEmxPaLZ3AnUYosHiPY7b7ITmMZ3qFPqjvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jt5RoK62BAUvlOXaCA224CGCdm44VmhBzNfgl4cFV8=;
 b=Gtvx3tkVU8AWmISrpv0uHoqpRfrWOaVxgZ5/M3FI7yPOHnI7kBxgEkZ7hwUhUe5nZXXrNnsyRj3CvLVgT4i0dbBUNYCQbpYEjRZTkgBHitfBjPg04XTgo3Dkugq2k1dO1zdCfHDUYq31aUDJmpHYgcRheMDDo/kOZNciLcmEz/6NazIyi+Bvyo+U2wPCr4TRDYvf5q7aKc/nh3JZg+oQofz+cAouD/K5SaTRFwbXvAMfGygxKF2AfHNXxrjVp9Z0k0Pfd6HfBbg+abUa6/vo6MSlSLAXrhYf/wawNIbilimYwBM58iXcYg8cVX1mD/p5M2GBs3unIDlxbpK41bP/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jt5RoK62BAUvlOXaCA224CGCdm44VmhBzNfgl4cFV8=;
 b=D0XMxI4+KWRHznD9KRAiAvAAw7vVveYuPHIuNdEi0IiTTgVCHG9S3GyjVo0KkjLeb1/Wh1EhHtdOkpmMwuglEVktZUjbBeE0yUfDHVPGz0eZ7eZhMmJ9YntdS9IKKynYC3wZi7VktkBls5cknYbtryeze617gb3oPDIIJyROY0iv5Bh2x7b1P4xBU5zaRmXREMOwar/N6Lpu4851Nj1jQb4fPmQH5RZ08bOQIZNAFfquZggfrNijbhcoSZyLHLNs6yEbFi5RwVJyE6CAqgVOfzlOhlYB/3/uadJBpMQY7kT9fPaABT7je+0S2KDND1OHW55FMLTe8cywvXFdnyJxbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 20:33:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 20:33:19 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/3] vrf: Remove unnecessary RCU protection around dst entries
Date: Thu, 26 Mar 2026 22:32:33 +0200
Message-ID: <20260326203233.1128554-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326203233.1128554-1-idosch@nvidia.com>
References: <20260326203233.1128554-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: a68c73ee-c05c-4a72-6ff6-08de8b76eab7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Wtzixm0ywOxQQadMQ+/QJBOFkPjqUzQbJPm0PXkLdqNnv2qOxgu3s5hlPC5dpH+EYGQYOtvnxNRup5xLM/1onFruJpw2qTWnqEbUNJxICgryLAuMEwEsHcucM/GUqhq+3W0xK7PiCQzyg/JhugBwOYLUZd9GPzAdBbF+urQTCWN/2J15oiUkhjbtqq7IlUNEwrCk7PirVAqgL/qYRVnwBAaPFLNJAgOMPPqM8dGyc01cInoPxAXjUvU0bHwp+hJYd4iToXTqvkEukdx1rNNLJ5fYLDqqOo0r2jPBHRo2SKScPzVs7FWXthRmsKXLLVtL/kb0bI2bCKLrrVB2sh+7XVkTmnIbUq51xtT6V1GMXJaecXeHq3XpQ5QKGxRT0ycIITaMmlJ+r7VnKfAYboQFgPps8O/TIkg52Y/F/V/cbSnFw5rORHzaUE7A/z6la7zc746E+oi444LffEyfhpKnrTjxTEoQx++E20iMM3OWuoUpxfC1yvI8qrev3+ZXcXtOTMfUR49jDF211HTPuOiQPwC8DbdyYmBsVrOc3CCbS9oPSgyuRm9vliPyBuXu6pZzanQUErgyZoqt0UV03LxgHgHulWoOsaaSfmd2NRwHCDN124+hh1/gOv/2cL/HmPtAp9hvxjx2HcIW1oth6kIgWoIG8T2GpY/7TXIHTW58yzcB0KsOlakU3KMriOBsnGUi8iZU4LD70Ntv6keoCewAQYop592uftoMdoIH9UL6YTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubjg0YGg+1sEUoLb9q4xnfpQQznl8OXrcqC2AYcmT4EQebzKIUYmgjtBqAq2?=
 =?us-ascii?Q?2H9GmjrjErY/Xp1Ig95wjOzznX1IlYTbp3sbuLr1BiDRecgDsz0oCSmGTIYC?=
 =?us-ascii?Q?XqRVSteJweWxnCetqOQJfC4VqsyvrZ3NbMFH25f2axpQOuhbKpce0YyUUoLT?=
 =?us-ascii?Q?787GjZJRehCGOGOZSNHlc94vwEkWK3ASfio5V43lr4E7XhU9MO+KXtFq4Xew?=
 =?us-ascii?Q?ZVzytI2DwtOzw/+1hLmMN8xD8cbr5QB3l8cVNtRiul/pzXqO5ggpgAdPyFDm?=
 =?us-ascii?Q?gg0MCqkZhfHa8vcIgBCLA8oUZiaopYWDWOU8iIOaReXtRjeZ4j6HxZLIxoMN?=
 =?us-ascii?Q?1EYkA7WBpUuHl67C7QkWzge/taA0FzsqZnnqq4gpGZlVpJNtXEh3a6YxA7hr?=
 =?us-ascii?Q?obfInYT3KqTMKLpj86zq9w6Cd7V2aDp//hXcCIX077pwgDsgqmYL0t8yjc24?=
 =?us-ascii?Q?GlSvEvRQMgjcT4mHAc9D/7C8TmtkPblIXQabvr1ro5CnrZvX0xqK/h8zGi6Y?=
 =?us-ascii?Q?uBvztzBsUMnyFxaJgpX53K14opmS3nzCChF1eiUNy7xsZBVkWt5Y2ghMQFZW?=
 =?us-ascii?Q?uxmGXMS5vBawsu3lfg6pM/2G8jlA2C8AmqwKtSNmA7EizYP0+o+cbgM7IQiz?=
 =?us-ascii?Q?lytgLmamk4HJxo4MhZSVce/fzhJs9YRr7R+Mr5pV3/n6BD/XRylzmlxKHERk?=
 =?us-ascii?Q?eoO65SyOQZK4ssFetbtCPB0UrA5Ec/D59NVkxtGeP22HG9TqOWV1P08d0NN+?=
 =?us-ascii?Q?D6yCfsNUHQRKdLawvaZQLqjnR/tOYYqbx6TeWb2/J0z+V0vzlIBxpJ7xtsoK?=
 =?us-ascii?Q?G+eTErtgB/27JJWCewlMMHl+/JcohtMFUroWw/LEv1X6g6LxqMOnjzlHqKBJ?=
 =?us-ascii?Q?z4YP0MTP4mZAAyWHwrf0xt5KDVBSFJ6NfJfaSQgXyTOAO8tLiwCdKcQ2A4U6?=
 =?us-ascii?Q?ocGgrzrX/MwsoplKwAxUV+3Hj/U6+GV3AAZ73oDdlb98/VxeiCBeFjsCykQQ?=
 =?us-ascii?Q?tPH5hRyTlfebB3dL8LK8dr6UMgXI214B0A9trOjkOPgYi9n5RoV+sfuhjEgD?=
 =?us-ascii?Q?nwXyBd10Ox+t7wMNZHmcbcdZzj+aysLlj9O7QyE+LgvFu1MT+J/38sQfoEXx?=
 =?us-ascii?Q?poIOURdKRWyPQjfmnmCLKmK9TEE3C+c4preU3Hhmfp3g1had6c4667Td8lob?=
 =?us-ascii?Q?lsamxvNnKmMTGglTrU60L8dAgkc+k4NM9N5O1adfprmFhui1kVcJ66dyS/wx?=
 =?us-ascii?Q?o77aZWQIktSl1lHTh4WVo7sCyacU1H/LK/LcJ93wddPeDbPPCiWRgUsLfMNh?=
 =?us-ascii?Q?ulTkKepduqTnkamP2ifO0HwI6/srZG+PBst/n4LLyd7aIr0GQeahXEIH6Yxy?=
 =?us-ascii?Q?1ibFE/hmxjyizumxLxtrZoLuTHbo6m+eLwKiMStC2o7vzNBuGn4rX+dG5m+R?=
 =?us-ascii?Q?pvlYtw+nVX5WWsx/haSGv+WI5fMvDwswOx6BjB0sLs5GTnKh/3eXuhqy8MX8?=
 =?us-ascii?Q?qRDxrYw3PLQiNWgmvh+pWGzy9AfKUMFACKjT6Br1U9aer97Q3EQFbbLcWjke?=
 =?us-ascii?Q?yVrzNrEy1I7wzFzY9NF8PHkM/qA5PZvpl7k0r9EdPvEKO2L5YN9QvPtZaITN?=
 =?us-ascii?Q?p49cgP90YTg2b1B2vTjEPN+cVv5VwPaJrHneWhvk+t9RV5bZFCPClixIhIcD?=
 =?us-ascii?Q?0h//g6AgSYT5mYP0eALq8NNs5l4VoX0N9ZctS3TzTFS4xAs3RyZW5U9CvgXY?=
 =?us-ascii?Q?cDg/9Eeqgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68c73ee-c05c-4a72-6ff6-08de8b76eab7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:33:19.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmCwnel04Q0c1IZSaYQncCP/2tQuikfEQbMiwp32cyH5P5dtX350PSaOaLZkvU1xEpc62klOR4XS1T48kN7MPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272239-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 1C30133B76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During initialization of a VRF device, the VRF driver creates two dst
entries (for IPv4 and IPv6). They are attached to locally generated
packets that are transmitted out of the VRF ports (via the
l3mdev_l3_out() hook). Their purpose is to redirect packets towards the
VRF device instead of having the packets egress directly out of the VRF
ports. This is useful, for example, when a queuing discipline is
configured on the VRF device.

In order to avoid a NULL pointer dereference, commit b0e95ccdd775 ("net:
vrf: protect changes to private data with rcu") made the pointers to the
dst entries RCU protected. As far as I can tell, this was needed because
back then the dst entries were released (and the pointers reset to NULL)
before removing the VRF ports.

Later on, commit f630c38ef0d7 ("vrf: fix bug_on triggered by rx when
destroying a vrf") moved the removal of the VRF ports to the VRF
device's dellink() callback. As such, the tear down sequence of a VRF
device looks as follows:

1. VRF ports are removed.
2. VRF device is unregistered.
    a. Device is closed.
    b. An RCU grace period passes.
    c. ndo_uninit() is called.
        i. dst entries are released.

Given the above, the Tx path will always see the same fully initialized
dst entries and will never race with the ndo_uninit() callback.

Therefore, there is no need to make the pointers to the dst entries RCU
protected. Remove it as well as the unnecessary NULL checks in the Tx
path.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 56 ++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bfc9ea91ac20..2cf2dbd1c12f 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -112,8 +112,8 @@ struct netns_vrf {
 };
 
 struct net_vrf {
-	struct rtable __rcu	*rth;
-	struct rt6_info	__rcu	*rt6;
+	struct rtable		*rth;
+	struct rt6_info		*rt6;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct fib6_table	*fib6_table;
 #endif
@@ -648,26 +648,13 @@ static struct sk_buff *vrf_ip6_out_redirect(struct net_device *vrf_dev,
 					    struct sk_buff *skb)
 {
 	struct net_vrf *vrf = netdev_priv(vrf_dev);
-	struct dst_entry *dst = NULL;
 	struct rt6_info *rt6;
 
-	rcu_read_lock();
-
-	rt6 = rcu_dereference(vrf->rt6);
-	if (likely(rt6)) {
-		dst = &rt6->dst;
-		dst_hold(dst);
-	}
-
-	rcu_read_unlock();
-
-	if (unlikely(!dst)) {
-		vrf_tx_error(vrf_dev, skb);
-		return NULL;
-	}
+	rt6 = vrf->rt6;
+	dst_hold(&rt6->dst);
 
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	skb_dst_set(skb, &rt6->dst);
 
 	return skb;
 }
@@ -750,10 +737,7 @@ static struct sk_buff *vrf_ip6_out(struct net_device *vrf_dev,
 /* holding rtnl */
 static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 {
-	struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
-
-	RCU_INIT_POINTER(vrf->rt6, NULL);
-	synchronize_rcu();
+	struct rt6_info *rt6 = vrf->rt6;
 
 	if (rt6) {
 		dst_dev_put(&rt6->dst);
@@ -784,7 +768,7 @@ static int vrf_rt6_create(struct net_device *dev)
 
 	rt6->dst.output	= vrf_output6;
 
-	rcu_assign_pointer(vrf->rt6, rt6);
+	vrf->rt6 = rt6;
 
 	rc = 0;
 out:
@@ -870,26 +854,13 @@ static struct sk_buff *vrf_ip_out_redirect(struct net_device *vrf_dev,
 					   struct sk_buff *skb)
 {
 	struct net_vrf *vrf = netdev_priv(vrf_dev);
-	struct dst_entry *dst = NULL;
 	struct rtable *rth;
 
-	rcu_read_lock();
-
-	rth = rcu_dereference(vrf->rth);
-	if (likely(rth)) {
-		dst = &rth->dst;
-		dst_hold(dst);
-	}
-
-	rcu_read_unlock();
-
-	if (unlikely(!dst)) {
-		vrf_tx_error(vrf_dev, skb);
-		return NULL;
-	}
+	rth = vrf->rth;
+	dst_hold(&rth->dst);
 
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	skb_dst_set(skb, &rth->dst);
 
 	return skb;
 }
@@ -989,10 +960,7 @@ static struct sk_buff *vrf_l3_out(struct net_device *vrf_dev,
 /* holding rtnl */
 static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 {
-	struct rtable *rth = rtnl_dereference(vrf->rth);
-
-	RCU_INIT_POINTER(vrf->rth, NULL);
-	synchronize_rcu();
+	struct rtable *rth = vrf->rth;
 
 	dst_dev_put(&rth->dst);
 	dst_release(&rth->dst);
@@ -1013,7 +981,7 @@ static int vrf_rtable_create(struct net_device *dev)
 
 	rth->dst.output	= vrf_output;
 
-	rcu_assign_pointer(vrf->rth, rth);
+	vrf->rth = rth;
 
 	return 0;
 }
-- 
2.53.0


