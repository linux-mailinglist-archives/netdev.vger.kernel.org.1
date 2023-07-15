Return-Path: <netdev+bounces-18069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B2754825
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD63281F9C
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C013735;
	Sat, 15 Jul 2023 10:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98315CD
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 10:11:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2101.outbound.protection.outlook.com [40.107.92.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B65273B
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxR5vm9zKFmTqPcaT1O76UE0vpJpbJqL7r8Nz4Q+8Eh631TqPPNiZj2eklWMVGuP8nLohPZFI5i4VeHxaz0VLAf4a/OkSWTcLHiKVlZQ6ptuf/71PcO1aLbAEtMGn8QPIDueF7s0RYGGkoYIvswPhRhznb8HGHg8NLtievzLEc1hB54a8GC22cd+Vf2CzmUaZLzCnpqHE6acjXDdcOVqjSlfh7Hi9KCwYUWIu9DxNiKt7pMeW9vueFSnxo9jjnpCnMWQwLpT+QIuLM2dfU7dlbvhxrFhb6HAWLgtfzuX57eFyedIWOP+kY9VRPyA7/BQOU3d9e9W8CVr40MbT1TJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1jyYYyc5qwT+OXl5LsJBlikpMZRyrSctV+dopa5GxQ=;
 b=Ke39OFTpiddl5X8gTQIlGP4EJ3r1qtldtk1TrXyHBndRWAcqJTMgbSTbpnew5gUuuladJRxed9TtlIBkZN2kWZl5BCCeDF6Wj/IEfw/A0X7VdWTZZZLk6x7MBmuUrbL+jAg7u5N4hxwmgIoKKKcKV93ME35CQ1IHfPtvRnnUPns1EiySo/bAdtH4K2LrQEOu3UjOZviGjVfERrP1rEVxz3Evp7UvGr7RTb0RMlRNYgU5fLY8YUi3ASEyD9Q7MibLwPfW+mSqxsAXJAyKRNcSvf+HwBLxg+5pbEGfL9OKnHeTwncM0M01G14k97aSGJu3I09s4VBXJUTo+XLEzLqL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1jyYYyc5qwT+OXl5LsJBlikpMZRyrSctV+dopa5GxQ=;
 b=dhdG3tRwdne1NaL9vZ3JRn8NWS6UF8CjNPo+lMbkB733jtcSjblxkzM3QIVBMFRad33/DO0jqkmqnB28tlNn9OT1BMnjsUXun4jgrtyO7qxOJTK/KNY4U7uQMy9Qy+DXFcvb2K+/YqzH7to9/XrlQPAp7rdDTe4Bwwo9YmJCTzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5694.namprd13.prod.outlook.com (2603:10b6:806:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Sat, 15 Jul
 2023 10:11:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:11:13 +0000
Date: Sat, 15 Jul 2023 11:11:07 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] rtnetlink: Move nesting cancellation rollback
 to proper function
Message-ID: <ZLJwu6obpQ01ellQ@corigine.com>
References: <20230713141652.2288309-1-gal@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713141652.2288309-1-gal@nvidia.com>
X-ClientProxiedBy: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c5c82b-4e92-4c12-f55c-08db851bd1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iaKRf1HkK4HuG+jL9MDdfJiV/wabBtrCqXq1K2HppNvu5Qc9pfHgU/bg3lrWAtReAPxxdFmX/oGlMVn3hIhqZVXlLrHOlLXxfu12AcRb5DXagxoJ+v5tQz2lmB7Ctvxu1H4ehuAT/NUuX8vLqgc1hQb6i/P5n+g41BBjqIiSti0ZaB45Q2qCn655+1cQaQaZtB4AvRZrTFgwlceX316KuSOaxsDLG0xUY692E2ZBg0NCYiO0MfKFrdM4VTWBqvbjxGPUyxKgz13K+Ul/P4hSqv1lSa+PdYXcUFRK0kur9RE9C/cGLxqCY2iK4sTXRD/UOCWtFYSBEKy/Old2NSRN4D4KwAZgrxJDr9V3lKfM8Of6jjCCrptDHJpgRwhxblWxR806Xpgl2dm5wd+usLC3wRrG1oBM5USH00lUU2gi/qQ+33IcZBDwdFUW+rvLVbicG+STf4rnjUptoKwiB7BU/987yFq/EpKQdRGiWk5U5r4auPXD6TXgdVzVFWPvOei+d9q9jP/sAJGOAc0aHa+lJEgFE6fcviqo1PL9cwsRsryTNIHfYO+YUoSzhBco6tjxnN2DdSKp1S1IW0ss7ENXJGkyzG4L3pquCbfmpMfU6n4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39830400003)(451199021)(2906002)(2616005)(83380400001)(86362001)(36756003)(38100700002)(316002)(4326008)(41300700001)(6916009)(66556008)(66476007)(66946007)(26005)(186003)(54906003)(478600001)(6512007)(6486002)(44832011)(6666004)(6506007)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNWdiae/q3UX7MJWJiYgx4A00QPhAeGUrduaT8KKfa4sQM58WimsA7tHxRzW?=
 =?us-ascii?Q?fSdluqmfUDKBGBZhtnLGEys6lfXeGC8f+4wCk7D1caPVUWHnwXsEgM7Rcs9x?=
 =?us-ascii?Q?tHvCORly4NFV0NkP+j/Ud+vtic96TalySbeuRjlriS2fQDMc+ZqC2UwkwLHs?=
 =?us-ascii?Q?Ek+PeJQcrkEXBczqkZjtgT6aoHPGEdLYqmO3cmsZGXZiFnjkzEWq8nMKcbXY?=
 =?us-ascii?Q?USjyM8VL3g1e6xv7ZKbNQOwgQGG5GuugdhiOJiKwgw8Eefopcw+qZklFbqY2?=
 =?us-ascii?Q?u8CVKaqgqNXB4g+cLnsjrrgSgSd6dgK8ZdBSQZyCqykssDkWqrYBFUMbLh8o?=
 =?us-ascii?Q?DkmIRxrKssKM0tfP51e3RZXxT+KdbtwWIrcFiNsV0yWRDyywllab4Ok3JF/t?=
 =?us-ascii?Q?/MZZbzcffoqnpGGqcCwElOURcOEOwrPfWQIz9KtmmLxrgO/NU6ubgYO8kQMt?=
 =?us-ascii?Q?Vzkd6bHjT1sTkAlmROiZmrCsc+UA12QI1Ucgnm71uawMiyQ94LDZNEovVx8k?=
 =?us-ascii?Q?U1rqiwHQK0LGp/6pkrcklDzOQsTbNDWeQRGsHQInPRAus1sx8zYATvA+fNpe?=
 =?us-ascii?Q?wWZ4AQfD7/UHTCqKXrRPotDzHMc8nB+LBnvUKzfppTLG90G+Kh48KgMnqm3j?=
 =?us-ascii?Q?KYKEn3SykB/pQbGK0xLQy/zTZeI8/JLFXtCuzNnryZwJain0w+jbHxBrFST+?=
 =?us-ascii?Q?moAtckdaEJxwb7p0rwssTJXeo/4EgmQk9aw21yl7ussOGjp0f21b+u2YW9lq?=
 =?us-ascii?Q?/RYam8A5wvGLquOz2AhWsarBzUEDV20yRLfKZAfqmFL0GvmfFEf7DRDNoMUT?=
 =?us-ascii?Q?LO8zKn+36RaIR3S2VD47GTV1ttUPWtkPrxPpDivFLlnue3Yz9GeWmxqbYXJL?=
 =?us-ascii?Q?NqijQ59G7Ljn1YDEoHMCK2lgPA6q3hQGe0vjbwz/8yYPvfVIuqKelv/Y/OOo?=
 =?us-ascii?Q?GStaj9EJNiXG7Dol1ZF6YRdSvlxQeJuXTssdxxTpdhh/WlB8vlLlmIhGQq99?=
 =?us-ascii?Q?Mbg+X8PP+rmXFIyJLkb4pJ2nfGPiiSE9/8i8AXtOOqx5v2Pl5eL3sFSanfgi?=
 =?us-ascii?Q?pQKxEIN5O9mJObK6N0VRGHwm/7RsqWF1vpBMTb3ZVLvq4XRLHKMMP3465Lq/?=
 =?us-ascii?Q?7TwV+8tHwH557T4eE+HAoCrzwfoHG4QrU8wQJPocqzXHDSfDfQ+/G7h0yDpK?=
 =?us-ascii?Q?zbxgZxZibvPwB32VIBb64h3ejRJY9nXNVVDSURomM1GNJRV3r3O/W0R8nipQ?=
 =?us-ascii?Q?0kJMq7i283bOJ1N0+uYYj7a/0gebipmqO6TmNqpZYI4fVVlfIELR/0qW9jwJ?=
 =?us-ascii?Q?ZcHm1J6Z+7eHoimp39CQsU5xV2L6GbeYq6tlUG6he5le5NrUo5bIdfSj1GQg?=
 =?us-ascii?Q?eyM6Y5iA5Jme3eNktBMyqI2xIisP77kVuWHeWJejZlB1AqGgtk9mOADFNmpM?=
 =?us-ascii?Q?+gmoRRlhtMrRMSZzWgy9Dg80cgFZp6gJj2heGpD7KAAY4OB2z2IRjkPvF8ui?=
 =?us-ascii?Q?WVR1B7+Z9TPaJRlniutII1kC8dHMxviH+QMF0uTTq9ZorWgoVyBAxdpo4FRu?=
 =?us-ascii?Q?uBfY8tCf4qtBF4kMftSflYkbtm2QMfJOkeHHcL6skwWLdZhXWGqGjjNspz/L?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c5c82b-4e92-4c12-f55c-08db851bd1c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:11:13.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAeEcbf5dEFxIlJxZ3ozF3eYmIfCRpsh1CZHGqyX3iYJVKYwo4ZYdcfW1qgZoSoz55E2seLWz4ztPWWoRBsidtHgoMjcD/unLcmJ4fGJiEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5694
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 05:16:52PM +0300, Gal Pressman wrote:
> Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
> inner rtnl_fill_vfinfo(), as it is the function that starts it.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/core/rtnetlink.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 3ad4e030846d..ed9b41ab9afc 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1343,7 +1343,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
>  	vf_trust.setting = ivi.trusted;
>  	vf = nla_nest_start_noflag(skb, IFLA_VF_INFO);
>  	if (!vf)
> -		goto nla_put_vfinfo_failure;
> +		return -EMSGSIZE;
>  	if (nla_put(skb, IFLA_VF_MAC, sizeof(vf_mac), &vf_mac) ||
>  	    nla_put(skb, IFLA_VF_BROADCAST, sizeof(vf_broadcast), &vf_broadcast) ||
>  	    nla_put(skb, IFLA_VF_VLAN, sizeof(vf_vlan), &vf_vlan) ||
> @@ -1414,8 +1414,6 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
>  
>  nla_put_vf_failure:
>  	nla_nest_cancel(skb, vf);
> -nla_put_vfinfo_failure:
> -	nla_nest_cancel(skb, vfinfo);

It seems that the vfinfo parameter of rtnl_fill_vfinfo() is now unused.
Can it be removed?

>  	return -EMSGSIZE;
>  }
>  
> @@ -1441,8 +1439,10 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
>  		return -EMSGSIZE;
>  
>  	for (i = 0; i < num_vfs; i++) {
> -		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
> +		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask)) {
> +			nla_nest_cancel(skb, vfinfo);
>  			return -EMSGSIZE;
> +		}
>  	}
>  
>  	nla_nest_end(skb, vfinfo);
> -- 
> 2.40.1
> 
> 

