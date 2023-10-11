Return-Path: <netdev+bounces-39888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04367C4B4F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21361C20BD9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B717986;
	Wed, 11 Oct 2023 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZw0+7eU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74379171D6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:11:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D259E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeHRX7jbXxgRQtE/6ZGCtNqF/5Bj5szA8RVVlPZmP4LT/24yl5RrZg7GXfIuk9IzxWOJvZLqv8jh4cIMxFjAtr90/Zcx0fRUwTzp0RZTMi3gTXmF9woloWudJvN3Rx3ZIsoj4yzx0MLVSNoDVhfzGtXATVwpLsw2WPtOtkmf/z1F9R+FDw9QQQz1xp2KctVvWcMvP2Cnosbj1u69yRzbuFRuV1/kRcsdyTy4IVzcEiwvlV/PFoKGyJt3P8rZLdxBV5wMMwoE2FVYq03fUsb/pSt1s3IxucA+9M91sP9IeOqaVfoDDvvWlHQhR9szdB6AuYM7ILXULwu7GDPQrUlQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkiY7pq79K17jg1l1sTR5Ndekv85AVwYcPpgpApQBEw=;
 b=JfQcen+Uk+zlpHeomO36FZHjpUbUq7il0eJwx32V91U5HKf4Sg3KVJhX2D/cei3hleNKyNAIMfetmX24bJuqoz2EP7JzIGstkqDI/PcO+RcKlvAb03gPDWfaDglqqCE+Idpxtf8dDtRDajhKRwH/kI5L0xk9n/ONUNHXGieI1oCN+s4Sx0gK1GDqsMHXbrdBdhCD/oolyEcdqethguUiKL93tfHY5D/fDekpdgF4AFkvQVZ6cAAv3ZrAAIvtTYD95aePfroPsALT2d+ehqCiEak3s+UlTQQPtfVEKZiEUyV2aMSjy1ntK72ImR4jSo5167l/ZJ3fou4tGNWjQY/ZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkiY7pq79K17jg1l1sTR5Ndekv85AVwYcPpgpApQBEw=;
 b=cZw0+7eUTgGYXd2sxt61S33EoJa2Za7+JHePpILgQxpcKpD6QBPGs/YvhZ5bOtcmN3319R3g6kWixHU7nXFUPpSjsOYBXVoZibhYzml5Pdr8+K3zj84VcmYUr4d3ssAEY3lPb0fYH5kYfbhHAULU7QtbI0foafBNP16OU5UsAjD+xWONM9mUrMwD7gmTHqYMjoBwKlZOtOIHjrtkIe6C5/rLJ76/qpnQ22e0UEhnpo+UQgEzJ5hq8vqAja1scq2hgvNxWPzViv9/8E/9NttIqCeUk5t4aNGYyZju/Ww+bSOrDvnDFYlWYaUaBkymmh4hMUs0x5DfSwpboYuUljzmcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 07:11:18 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:11:18 +0000
Date: Wed, 11 Oct 2023 10:11:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v2] vxlan: add support for flowlabel inherit
Message-ID: <ZSZKjDA2ZBAHn5EH@shredder>
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
 <20231007142624.739192-1-alce@lafranque.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007142624.739192-1-alce@lafranque.net>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6769404d-6f06-4016-24a3-08dbca29439a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cxb+zcUJu2vpdGqSrA2zJq0nUH6T2iDYlM9Nm1Jd5jF9RiRKnQ2XUN/lZj3aKyv/21PGcZecnza17QTspqI6uHGh7kXxlbP5jzukSmRgtab5Mm/hlPZ9Mh7tNog0zD5jBbvTKVyyPaoQQJzRBi6e9KIgNerd3SVAibSxBBMGbg+dca7T/RoW9fUN6Pi36/bo/E0abTXP5QQhuvNOZDlIbcV3DuTWguYi6QVxLvGRNZV7fNPctLQoswhWnQc+ArmSUzIhg/MQLSGEyoxmC1mMgLBcZc59H69hiZwJY1RaSuIBKHqbZBZgidIfM5dmrz8uKP6sVMcxKRkkYNQJBA7pXTlgySn8mi1tCucFq5a3xD37ULTi+ko6TFcbALLtBbxyFIpqS8B217/ZbMYVKitmVDfwvaY3G4YHSinqhBVgX8JVEHmCM995PBM/YGe0X1QLC82xwWQAyNckhoMsokcNIR8YzXSaV8nrRQFTwWzWXYV1dcJek+dkOvolocK+ingdiSe2eniIB2C2wQLWFndSizuOgmWwvQSsUDnKAh1WblvJKlhx+NE4gAHPyMB+wDS7mKBGlr7VJV6KAnQ1Cb1+qIYL6fmAvyOuunmdX4EDj7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(9686003)(86362001)(38100700002)(66574015)(26005)(83380400001)(6506007)(966005)(478600001)(6666004)(6486002)(66556008)(8676002)(8936002)(6916009)(4326008)(41300700001)(2906002)(66476007)(33716001)(316002)(66946007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYHyaefpx1pk5VG3orz5HGSXupcHSWDz9khTjImCL26XGncc6LJHa/Ow/R8s?=
 =?us-ascii?Q?SJusmQBOcOuJ0b37lD4ncFoToJmAZJgpHGEqtHT10bX3hXUIQ/DlQ4TzGKEF?=
 =?us-ascii?Q?AyUKvBe3Z1iUYUBkXxdumxarykOEzq93M9lOl8yplumI2hKKW7kK5niMQFkM?=
 =?us-ascii?Q?4npt0tTmkDo7unRJuas6gzIXKYJAQ5qm/HKiczwiOB9h1ftwHWVHFjRExQlT?=
 =?us-ascii?Q?TmDvYNMyEnScgVhs5O6SbN8/QmGV1c+P4TAqSZ0JHLuaqqsvPHTGO8I1tqEg?=
 =?us-ascii?Q?tu3PKiEOZ0jMRkP6VGQTBfg1tC99kuDIV/rKnyhwgSMMy/EX8QCaTgqLLpo+?=
 =?us-ascii?Q?LYwXl1ZnQwBBoVrCDETwI3g9wWk/rXNmMidxU5/FGf6kHGrPPh70JFCuS6sg?=
 =?us-ascii?Q?VsdiOOctfH4LMyJlazZCJ99DnFNz4Do4b+4hI0cSW8uDgBWe7SPuH0QMvUqP?=
 =?us-ascii?Q?rMWkQA0EEs+sJQkNrWQfPwwyenIECM5rhUJ7lDa1VwFHPX7XESPzyhu8xDAi?=
 =?us-ascii?Q?T6XkxQ4LHUaJsHorAuZu14QAx4X/5gpsbfKCkVuYCKP+YUZ0UvW7O2R8tpFL?=
 =?us-ascii?Q?CG2BZ5DKRmvwikO2PtD1IlrtVAs+MYkYkl41UyaUOC/s05qlVE9jIUGBSiJs?=
 =?us-ascii?Q?zPAL4rNcasFFx5U8XmQ5JniAGKlCmlpwm0CqA4KgqkCt53Zy6nsraCSgLnze?=
 =?us-ascii?Q?/l1fOsZZgTZmy4poJRg6tPczJ+k9BFXTLGQVojU1mT5S9BFoPdTQ0Mcv/7ia?=
 =?us-ascii?Q?dmG2DyMP7F5T4ZzI9dhVNVPZ2L6hjkLTcYYXIzw6HhOU0Gy+MD7ZUGLVGPAf?=
 =?us-ascii?Q?ggWBPGTM+kDlhB3iFeGXAEXnzQhMASiHT27Wj3CWPzZjMX4SpDg3frfEiE1m?=
 =?us-ascii?Q?lghNhgFrSRYNN2RPBYgBbMRperwCz0aVYf4qNSK/4Wev+sIlK9VGjN5UlHTd?=
 =?us-ascii?Q?iClL7u+8gckgWS6LS7uDJIGCImK9cha80oJeeZjF8Qk6x/HzEiXKLyavRA0L?=
 =?us-ascii?Q?MMBx5LALKjxIM3xmRPjSkJ+pLFRIxu4wTKAz9/psK+4FC9yzvIHDlaMFTLQT?=
 =?us-ascii?Q?VuohpzJZOMXxXM218kvY0NyMpWW6aJVd+C/7YpGuKXWA/5fBoyS16gK+oIS5?=
 =?us-ascii?Q?2OBUMbkYgaDAxVmfxNSYFUdRvGUZPaRlnRZ+q78UttKjBdrZlZvB8blU1/Eh?=
 =?us-ascii?Q?zYK9rn/yjvQzCQ63HiSZbQVaJ/HoWGzN3IR3KaAUq5x5gSW9bkD+CjfO16pc?=
 =?us-ascii?Q?8ujEr3zrS57ZP5eloBlq4ZbCNx82cHM6pEuO3QpW9kNtS2C6pXfnBIFrnPCi?=
 =?us-ascii?Q?73U4QyzJu8OundBt3toVWKX+RJERJBgTSldiI3O+lsFDVudoIZLlOPd0b+1l?=
 =?us-ascii?Q?EhZ3ZSJ+/TWfjON3OT3xj524ItIozU61al+cWa8/w6Wkhrw7yGWlYdL0ukgi?=
 =?us-ascii?Q?Ur8gLuVnGRoZcjGcsLFFu9qqgmojpHiCSoIF1gijaUkzwwJuJ5V5cwDd/HuZ?=
 =?us-ascii?Q?UHXQgziO+oy1OAqBWlCuQ67PLy/bEmhhroPIUqsYWYu+3DId69G/p70NxZUH?=
 =?us-ascii?Q?LQfNDTMplRQM+Jof/FBsnmjorwZeQJOGrIOzAXH3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6769404d-6f06-4016-24a3-08dbca29439a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:11:18.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5G/v8pfeO5EsHTY/riFUxWygs4XZ79T2ciJQNm8qksW67Ngl5txIKrBb23ZmmuUvy56pbstIv3aeG7DpwymdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Process note: Please post new versions as a separate thread with a
changelog:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#resending-after-review

On Sat, Oct 07, 2023 at 09:26:24AM -0500, Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.
> 
> ```
> $ ./ip/ip link add dummy1 type dummy
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
> $ ./ip/ip link set up dev vxlan1
> $ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
> $ ./ip/ip link set arp off dev vxlan1
> $ ping -q 2001:db8:1::1 &
> $ tshark -d udp.port==8472,vxlan -Vpni dummy1 -c1
> [...]
> Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> [...]
> Virtual eXtensible Local Area Network
>     Flags: 0x0800, VXLAN Network ID (VNI)
>     Group Policy ID: 0
>     VXLAN Network Identifier (VNI): 100
> [...]
> Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> ```
> 
> Signed-off-by: Alce Lafranque <alce@lafranque.net>
> Co-developed-by: Vincent Bernat <vincent@bernat.ch>
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> ---
>  drivers/net/vxlan/vxlan_core.c | 15 ++++++++++++++-
>  include/net/ip_tunnels.h       | 11 +++++++++++
>  include/net/vxlan.h            | 33 +++++++++++++++++----------------
>  include/uapi/linux/if_link.h   |  8 ++++++++
>  4 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 5b5597073b00..d1f2376c0c73 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2475,7 +2475,14 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  		else
>  			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
>  #if IS_ENABLED(CONFIG_IPV6)
> -		label = vxlan->cfg.label;
> +		switch (vxlan->cfg.label_behavior) {
> +		case VXLAN_LABEL_FIXED:
> +			label = vxlan->cfg.label;
> +			break;
> +		case VXLAN_LABEL_INHERIT:
> +			label = ip_tunnel_get_flowlabel(old_iph, skb);
> +			break;

I saw the kbuild robot complaining about this. You can add:

default:
	DEBUG_NET_WARN_ON_ONCE(1);
	goto drop;

> +		}
>  #endif
>  	} else {
>  		if (!info) {
> @@ -3286,6 +3293,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>  	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
>  	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
>  	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
> +	[IFLA_VXLAN_LABEL_BEHAVIOR]	= NLA_POLICY_MAX(NLA_U8, VXLAN_LABEL_MAX),

My preference would be IFLA_VXLAN_LABEL_POLICY.

>  };
>  
>  static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -4003,6 +4011,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
>  			     IPV6_FLOWLABEL_MASK;
>  
> +	if (data[IFLA_VXLAN_LABEL_BEHAVIOR])
> +		conf->label_behavior = nla_get_u8(data[IFLA_VXLAN_LABEL_BEHAVIOR]);

There is a check in vxlan_config_validate() that prevents setting a
non-zero flow label when the VXLAN device encapsulates using IPv4. For
consistency it would be good to include a similar check regarding the
flow label policy.

> +
>  	if (data[IFLA_VXLAN_LEARNING]) {
>  		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
>  				    VXLAN_F_LEARN, changelink, true,
> @@ -4315,6 +4326,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
>  		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
> +		nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_BEHAVIOR */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
>  		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
> @@ -4387,6 +4399,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
>  	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
> +	    nla_put_u8(skb, IFLA_VXLAN_LABEL_BEHAVIOR, vxlan->cfg.label_behavior) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
>  		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index f346b4efbc30..2d746f4c9a0a 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -416,6 +416,17 @@ static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
>  		return 0;
>  }
>  
> +static inline __be32 ip_tunnel_get_flowlabel(const struct iphdr *iph,
> +					     const struct sk_buff *skb)
> +{
> +	__be16 payload_protocol = skb_protocol(skb, true);
> +
> +	if (payload_protocol == htons(ETH_P_IPV6))
> +		return ip6_flowlabel((const struct ipv6hdr *)iph);
> +	else
> +		return 0;
> +}
> +
>  static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
>  				       const struct sk_buff *skb)
>  {
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 6a9f8a5f387c..9ccbc8b7b8f9 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -210,22 +210,23 @@ struct vxlan_rdst {
>  };
>  
>  struct vxlan_config {
> -	union vxlan_addr	remote_ip;
> -	union vxlan_addr	saddr;
> -	__be32			vni;
> -	int			remote_ifindex;
> -	int			mtu;
> -	__be16			dst_port;
> -	u16			port_min;
> -	u16			port_max;
> -	u8			tos;
> -	u8			ttl;
> -	__be32			label;
> -	u32			flags;
> -	unsigned long		age_interval;
> -	unsigned int		addrmax;
> -	bool			no_share;
> -	enum ifla_vxlan_df	df;
> +	union vxlan_addr		remote_ip;
> +	union vxlan_addr		saddr;
> +	__be32				vni;
> +	int				remote_ifindex;
> +	int				mtu;
> +	__be16				dst_port;
> +	u16				port_min;
> +	u16				port_max;
> +	u8				tos;
> +	u8				ttl;
> +	__be32				label;
> +	enum ifla_vxlan_label_behavior	label_behavior;
> +	u32				flags;
> +	unsigned long			age_interval;
> +	unsigned int			addrmax;
> +	bool				no_share;
> +	enum ifla_vxlan_df		df;
>  };
>  
>  enum {
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..13afc4afcc76 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -830,6 +830,7 @@ enum {
>  	IFLA_VXLAN_DF,
>  	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
>  	IFLA_VXLAN_LOCALBYPASS,
> +	IFLA_VXLAN_LABEL_BEHAVIOR,
>  	__IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
> @@ -847,6 +848,13 @@ enum ifla_vxlan_df {
>  	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
>  };
>  
> +enum ifla_vxlan_label_behavior {
> +	VXLAN_LABEL_FIXED = 0,
> +	VXLAN_LABEL_INHERIT = 1,
> +	__VXLAN_LABEL_END,
> +	VXLAN_LABEL_MAX = __VXLAN_LABEL_END - 1,
> +};
> +
>  /* GENEVE section */
>  enum {
>  	IFLA_GENEVE_UNSPEC,
> -- 
> 2.39.2
> 

