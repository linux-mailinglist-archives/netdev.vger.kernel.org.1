Return-Path: <netdev+bounces-47256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC487E92CE
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEAB1C2032A
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3B19466;
	Sun, 12 Nov 2023 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="btPsmaKR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53761A287
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 21:08:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D6210E
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 13:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nlh3/2X1DEL2Gu1vfCFjbmOEBI+aJxftTiao/HGDNClSG4ObSlTTPNpPKDp8LTIU+WvJ6XLG1J7AjzV97yKu1+bgM26SkCPtM2/tchg9BZkaEXBIhxhX7Ee29IHCTg/7tqGeKHsUGXxta+DqFBEqJIJZVdLBCaVvxpY1lPQOQBZTkNKgHAMvW0Y3EgyNJH0MISg3+wqddlwZn+JMkfQmOUz/YcjzO8gxu/ikZSF/QO++vqBL/0dpzB7A2cV1cIvBSkNaXa18lqsY79d8xR8z9U1M5Yc1oHeiwWcEC4i8VBj85EeAI7AbK0iQJGL5eRwddO/lWixij7wSf6gXDTRrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/evAY9FFKtcIT20jcPG1TVh5CwitWf0ncsXQTcCXR94=;
 b=LLNPS2lo2Jq1oAFP+0cJJ7GSJT7unjTXmm89nCuS+XKYAxuC7SHzCXzXDBK15CvSFcVjzFG47SeSLBaQAsCKizb1xXi+gfgkQOTv0yvPkjYp0MDFWRE1oXp0GjwNXEpix8z0WAcRijt1pylVWQmLDKt5HcOMXzl0aK7crteASlGRo7xi+vWPieZoWou8UjcNL2Kw7e2q1yR0BnHGT0NEfcUiPxyXOg8sRWfFERm3nT/kEWZGxoH7KEaFA+HgudQYEzpeb8qZlxEcTgf1DWaHM1UrIuiq8H44gVxzi6cuClVdz4mzG0e/HHsTUwV3skpAyvfU8rNzS/PmSRa0exnQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/evAY9FFKtcIT20jcPG1TVh5CwitWf0ncsXQTcCXR94=;
 b=btPsmaKRCQSSIdo0UrYHU22KYpInhwY/8uOV4vDvKTouw5vFp0Ab8rfTwdUdCTtqyMCgAzU7DEmQXwa2QwbGACp3mR9Ce7hsJJypfWl8YYREwwqzwLE7xLT3a0m7RQ1uaYIYyem0nsyovYNTqM06S1t3l5Wx0htYiKPXbSV1Cx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by CY8PR14MB6564.namprd14.prod.outlook.com (2603:10b6:930:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Sun, 12 Nov
 2023 21:08:42 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 21:08:40 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-8-chopps@chopps.org>
 <ZVErFh72plGBUNK0@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 7/8] iptfs: xfrm: add generic
 iptfs defines and functionality
Date: Sun, 12 Nov 2023 16:00:58 -0500
In-reply-to: <ZVErFh72plGBUNK0@Antony2201.local>
Message-ID: <m2o7fy8ysp.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:610:32::28) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|CY8PR14MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dca7e34-9d09-4afc-4797-08dbe3c38ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aqsGDbQHSd7E2U+iLQoauoinSw411yuF99qiJ7KZznSFj25XSQ/DlNmRmT8EYPdXFpHsVA+zjsHm01Mb/u9r5FbA08fpRMTE2+cn4rSKilaGN7l1f4IkAqvuUxhTtFWFBNmmLtAVHdSirSOYWOSl61jVtE0T3AWaJ9d77mES43g06RWI5GMFNV6jSM6d+Z8X3HT2Y1q6xZn3VesV0vLyF+370BBXwaxnTKLE6geCx33TOkd+pVVm8RAnybEjk2JMQi2LdBI16Wr6bVn5uJ5LeKL1DO+S2wiXmnEibhOo8SgpSByd0NgsLsfOp8ewnTAKuF2m8tFnlxivLs2i/RE8iZTWJE8oJ5vFfhBqe14Pzuh1N3q8b5itkIo+2pIvFbUGfWTrgUC/yuM3AFt/SkXXTqkDOzl3AN3vwMYov/Lw7f98muD2GuBnMlvkOQZjDtxT4AvtOIjp4qlopPNWeF8O6wmMDxicIwChVkJrQB5qK6BhwpHeJpmTBLuNWsCdePYJhVW3Gr++0d/IphSI3BwOa5PXHN6FzSbRIOZKtsziwDPfej8GG7Q/lG6pD/fQi0IbeYLCpG1cbpRgCS6BbLvmKX7z8JxusoLqaera1EAG+4shrf99tJxxMB050ATy1zw2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(107886003)(2906002)(38350700005)(30864003)(21480400003)(5660300002)(86362001)(41300700001)(26005)(54906003)(66556008)(66946007)(66476007)(6916009)(9686003)(6512007)(316002)(83380400001)(38100700002)(966005)(478600001)(6486002)(52116002)(6506007)(6666004)(8676002)(4326008)(8936002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GSXOhhyMYBU6BmrMSBIhtb2h/IcQobQ+LzXX0albmevoqNuZy740Ywrrr0YR?=
 =?us-ascii?Q?l4VLLsvvi5xd1cYPxVfvIDRrOelAJfD1V/wZCog4q8kYECYW8m2o4JDxIoKF?=
 =?us-ascii?Q?1PWk2vokud8hPC4+N+G0IkwqLRpN1HfKy6CrZTS/wU8ZKlG945WQB8gicbxX?=
 =?us-ascii?Q?AeKS+bC6rgSA8Bkem+gl2Z6ETVX8e+GRn542wkOTkiwiLKZNHdo2knuM3C0M?=
 =?us-ascii?Q?mALCOIRDlprJM9UV8lBk/O6ASiAkLIuK/JHDsn5KKrA7qAtcJTSOuWu36knn?=
 =?us-ascii?Q?pEY8pZg6sQgltL/gf9l2ZiwxJPDmNLISONHhXvQOS37IBjPmlBP0J7eYlfEY?=
 =?us-ascii?Q?mdOTkYCqzwqt8do1IzNgPP/qRaI28ShxGy0fm538FI1StOR5rmHT7Udm657m?=
 =?us-ascii?Q?WyM+EQT8fuRecGzSQFpOzSxCFOdSot+RU8muD2DmLPXJcctnTQc+C7lnIVkf?=
 =?us-ascii?Q?2LqMFO+iOVjhFq4YubU3fIG8N2M0U8M0hReyWt6XxRrZEO45Fqpr6GOrQKo0?=
 =?us-ascii?Q?esbKp47VXP8VB7RGLe816OCBZYmvecDy0zoyRPydJVDB5kG23nBIfWlwNFjf?=
 =?us-ascii?Q?owhNckho1zOQKMdNRN2Mn9tCUi8a4UFnfhwAASim0/B9ZU/89RtpsrhBwKpu?=
 =?us-ascii?Q?rN0Ikk8aonFm9vY4NLNdvHQ197aD/Icwn6v9YdhX1EZvle4GVO0d/tk65u7f?=
 =?us-ascii?Q?gTL3Lt/0n0zUxOOtrT3nbS5MGtw1BHMWfh/RBMOsaA240AfkaW6zfVXel821?=
 =?us-ascii?Q?35r/alNlZMPTdJNKWXxcBgUelsaGiA+8R/LFJ+5V0rjj79ih58bbPGblQ8yh?=
 =?us-ascii?Q?1k6BGq7ZQu7HZoPRBClfKSixx0lJOJzCZ0J7k+neMSgRIX/VpkTjG+gS3u/U?=
 =?us-ascii?Q?8X8LiDSLoO4j8+PkuFTAlqCk7qGc08wg7opd3SZ6PL95/XEfL2zQn0VqdwI8?=
 =?us-ascii?Q?cYQlwyAb8QnSmc0HsS7YzeVeMDXJWYTPVc15p6q1JWV85Yh07FxzWOa+uyXe?=
 =?us-ascii?Q?kEzkraV+gADSqJhEDwZ0liPxpWRLTOKnGb5tLzVS2sLWHdzPlul53nUEJx/w?=
 =?us-ascii?Q?ZrE3GIpkHL0QMI/qhtHJwOWOQUQD1dyV6Joqk+73tbTpK99Cs2BoERCyQRMM?=
 =?us-ascii?Q?siZhchYsX51X4oZh2uZ1PI/3h6t2eOWz7HFA8MFj2DPc0XDKVLWnxC0p6CMZ?=
 =?us-ascii?Q?RTHeMtmSSJ2qBPtWI+EUa8ttg+EKVqJ9so5+7MIwnl7NQkdd/kdiEgKmBsT7?=
 =?us-ascii?Q?/jOlXdHOgEa03wnrt944QmnnnJN13Ex/z3EflSwuY6hZwIOkxP0XouxegzAp?=
 =?us-ascii?Q?GW+7Be/uR09gKvv/+q3kQoRSUraUskKtJzRwXwz78Gl8Xub6bnK5oVcKUJvV?=
 =?us-ascii?Q?tJszddw3nEp3EsFuKxcy89x+CjnZmm7b0Pkta0LuTfzrq1QyIBG5zmXJEise?=
 =?us-ascii?Q?+fok9ZE6rH+szcjWEB3I6hY10jBeXEqd+QFbOdAf2ZHjcqr6u9Xp7RCoJI9K?=
 =?us-ascii?Q?v9tbal3NJkKVOMr7dDXLMSodSN52VhN4vjkLENkPixSohhEFUI4INf9Jll3f?=
 =?us-ascii?Q?xX/6P2EFQMp8qBOHak9fPuJCMCYwYqBsFgOQyAaO?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dca7e34-9d09-4afc-4797-08dbe3c38ba6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 21:08:40.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qVhdlSXrC6I0JPsWJJcWrjestmts2TGubUm230XEoA7YAg35ZC0+in/YfGnVE9w8lRwoUCNd8QMWeO3uX03Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR14MB6564

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony <antony@phenome.org> writes:

> On Fri, Nov 10, 2023 at 06:37:18AM -0500, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Define `XFRM_MODE_IPTFS` and `IPSEC_MODE_IPTFS` constants, and add these to
>> switch case and conditionals adjacent with the existing TUNNEL modes.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/net/xfrm.h         |  1 +
>>  include/uapi/linux/ipsec.h |  3 ++-
>>  include/uapi/linux/snmp.h  |  2 ++
>>  include/uapi/linux/xfrm.h  |  3 ++-
>>  net/ipv4/esp4.c            |  3 ++-
>>  net/ipv6/esp6.c            |  3 ++-
>>  net/netfilter/nft_xfrm.c   |  3 ++-
>>  net/xfrm/xfrm_device.c     |  1 +
>>  net/xfrm/xfrm_output.c     |  4 ++++
>>  net/xfrm/xfrm_policy.c     |  8 ++++++--
>>  net/xfrm/xfrm_proc.c       |  2 ++
>>  net/xfrm/xfrm_state.c      | 12 ++++++++++++
>>  net/xfrm/xfrm_user.c       |  3 +++
>>  13 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
>> index aeeadadc9545..a6e0e848918d 100644
>> --- a/include/net/xfrm.h
>> +++ b/include/net/xfrm.h
>> @@ -37,6 +37,7 @@
>>  #define XFRM_PROTO_COMP		108
>>  #define XFRM_PROTO_IPIP		4
>>  #define XFRM_PROTO_IPV6		41
>> +#define XFRM_PROTO_IPTFS	IPPROTO_AGGFRAG
>>  #define XFRM_PROTO_ROUTING	IPPROTO_ROUTING
>>  #define XFRM_PROTO_DSTOPTS	IPPROTO_DSTOPTS
>>
>> diff --git a/include/uapi/linux/ipsec.h b/include/uapi/linux/ipsec.h
>> index 50d8ee1791e2..696b790f4346 100644
>> --- a/include/uapi/linux/ipsec.h
>> +++ b/include/uapi/linux/ipsec.h
>> @@ -14,7 +14,8 @@ enum {
>>  	IPSEC_MODE_ANY		= 0,	/* We do not support this for SA */
>>  	IPSEC_MODE_TRANSPORT	= 1,
>>  	IPSEC_MODE_TUNNEL	= 2,
>> -	IPSEC_MODE_BEET         = 3
>> +	IPSEC_MODE_BEET         = 3,
>> +	IPSEC_MODE_IPTFS        = 4
>
> Consider using 'IPSEC_MODE_IPTFS_TUNNEL' for a more descriptive name?
>
> I imagine IPSEC_MODE_BEET could support IPTFS, resulting in 'iptfs-beet.'

I'd like to ask to hold off on making this change if that's OK. Either someone knows what IPTFS is or they are going to have to look it up. Having _TUNNEL on the main identifier (making it even longer) isn't going to help their comprehension, but will cause more line wrapping in the code which does the opposite.

Also, your example of "iptfs-beet" is what it would be currently, with your suggestion change of adding _TUNNEL wouldn't that then yield "mode iptfs-tunnel-beet"? :)

> In applications like iproute2, using
> 'ip xfrm state add ...  mode iptfs-tunnel' might be clearer than 'iptfs'
> alone, especially with possibility of IPTF 'Congestion Control' and
> 'Non-Congestion-Controlled'. Would be seperate modes? Or attributes of
> "iptfs" mode?

For congestion control I'd just have that as another iptfs-opt, I think.

>
>>  };
>>
>>  enum {
>> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
>> index 26f33a4c253d..d0b45f4c22c7 100644
>> --- a/include/uapi/linux/snmp.h
>> +++ b/include/uapi/linux/snmp.h
>> @@ -331,6 +331,8 @@ enum
>>  	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
>>  	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
>>  	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
>> +	LINUX_MIB_XFRMINIPTFSERROR,		/* XfrmInIptfsError */
>> +	LINUX_MIB_XFRMOUTNOQSPACE,		/* XfrmOutNoQueueSpace */
>>  	__LINUX_MIB_XFRMMAX
>>  };
>>
>> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
>> index fa6d264f2ad1..2e7ffc9b7309 100644
>> --- a/include/uapi/linux/xfrm.h
>> +++ b/include/uapi/linux/xfrm.h
>> @@ -153,7 +153,8 @@ enum {
>>  #define XFRM_MODE_ROUTEOPTIMIZATION 2
>>  #define XFRM_MODE_IN_TRIGGER 3
>>  #define XFRM_MODE_BEET 4
>> -#define XFRM_MODE_MAX 5
>> +#define XFRM_MODE_IPTFS 5
>
> same here XFRM_MODE_IPTFS_TUNNEL
>
> I wonder if the patches are in the right order. While XFRM_MODE_IPTFS is
> defined in 7/8 it is already used in 5/8. May be Simon Horman pointed out
> the same.

Yes I'm currently running builds on all the commits after fixing this.

Thanks,
Chris.

>
>
>> +#define XFRM_MODE_MAX 6
>>
>>  /* Netlink configuration messages.  */
>>  enum {
>> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
>> index 2be2d4922557..b7047c0dd7ea 100644
>> --- a/net/ipv4/esp4.c
>> +++ b/net/ipv4/esp4.c
>> @@ -816,7 +816,8 @@ int esp_input_done2(struct sk_buff *skb, int err)
>>  	}
>>
>>  	skb_pull_rcsum(skb, hlen);
>> -	if (x->props.mode == XFRM_MODE_TUNNEL)
>> +	if (x->props.mode == XFRM_MODE_TUNNEL ||
>> +	    x->props.mode == XFRM_MODE_IPTFS)
>>  		skb_reset_transport_header(skb);
>>  	else
>>  		skb_set_transport_header(skb, -ihl);
>> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
>> index fddd0cbdede1..10f2190207a8 100644
>> --- a/net/ipv6/esp6.c
>> +++ b/net/ipv6/esp6.c
>> @@ -865,7 +865,8 @@ int esp6_input_done2(struct sk_buff *skb, int err)
>>  	skb_postpull_rcsum(skb, skb_network_header(skb),
>>  			   skb_network_header_len(skb));
>>  	skb_pull_rcsum(skb, hlen);
>> -	if (x->props.mode == XFRM_MODE_TUNNEL)
>> +	if (x->props.mode == XFRM_MODE_TUNNEL ||
>> +	    x->props.mode == XFRM_MODE_IPTFS)
>>  		skb_reset_transport_header(skb);
>>  	else
>>  		skb_set_transport_header(skb, -hdr_len);
>> diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
>> index 452f8587adda..291b029391cd 100644
>> --- a/net/netfilter/nft_xfrm.c
>> +++ b/net/netfilter/nft_xfrm.c
>> @@ -112,7 +112,8 @@ static bool xfrm_state_addr_ok(enum nft_xfrm_keys k, u8 family, u8 mode)
>>  		return true;
>>  	}
>>
>> -	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL;
>> +	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL ||
>> +	       mode == XFRM_MODE_IPTFS;
>>  }
>>
>>  static void nft_xfrm_state_get_key(const struct nft_xfrm *priv,
>> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
>> index 8b848540ea47..a40f5e09829e 100644
>> --- a/net/xfrm/xfrm_device.c
>> +++ b/net/xfrm/xfrm_device.c
>> @@ -69,6 +69,7 @@ static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
>>  static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
>>  {
>>  	switch (x->outer_mode.encap) {
>> +	case XFRM_MODE_IPTFS:
>>  	case XFRM_MODE_TUNNEL:
>>  		if (x->outer_mode.family == AF_INET)
>>  			return __xfrm_mode_tunnel_prep(x, skb,
>> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
>> index 4390c111410d..16c981ca61ca 100644
>> --- a/net/xfrm/xfrm_output.c
>> +++ b/net/xfrm/xfrm_output.c
>> @@ -680,6 +680,10 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
>>
>>  		return;
>>  	}
>> +	if (x->outer_mode.encap == XFRM_MODE_IPTFS) {
>> +		xo->inner_ipproto = IPPROTO_AGGFRAG;
>> +		return;
>> +	}
>>
>>  	/* non-Tunnel Mode */
>>  	if (!skb->encapsulation)
>> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
>> index 3220b01121f3..94e5889a77d6 100644
>> --- a/net/xfrm/xfrm_policy.c
>> +++ b/net/xfrm/xfrm_policy.c
>> @@ -2468,6 +2468,7 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
>>  		struct xfrm_tmpl *tmpl = &policy->xfrm_vec[i];
>>
>>  		if (tmpl->mode == XFRM_MODE_TUNNEL ||
>> +		    tmpl->mode == XFRM_MODE_IPTFS ||
>>  		    tmpl->mode == XFRM_MODE_BEET) {
>>  			remote = &tmpl->id.daddr;
>>  			local = &tmpl->saddr;
>> @@ -3252,7 +3253,8 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
>>  ok:
>>  	xfrm_pols_put(pols, drop_pols);
>>  	if (dst && dst->xfrm &&
>> -	    dst->xfrm->props.mode == XFRM_MODE_TUNNEL)
>> +	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
>> +	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
>>  		dst->flags |= DST_XFRM_TUNNEL;
>>  	return dst;
>>
>> @@ -4353,6 +4355,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
>>  		switch (t->mode) {
>>  		case XFRM_MODE_TUNNEL:
>>  		case XFRM_MODE_BEET:
>> +		case XFRM_MODE_IPTFS:
>>  			if (xfrm_addr_equal(&t->id.daddr, &m->old_daddr,
>>  					    m->old_family) &&
>>  			    xfrm_addr_equal(&t->saddr, &m->old_saddr,
>> @@ -4395,7 +4398,8 @@ static int xfrm_policy_migrate(struct xfrm_policy *pol,
>>  				continue;
>>  			n++;
>>  			if (pol->xfrm_vec[i].mode != XFRM_MODE_TUNNEL &&
>> -			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET)
>> +			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET &&
>> +			    pol->xfrm_vec[i].mode != XFRM_MODE_IPTFS)
>>  				continue;
>>  			/* update endpoints */
>>  			memcpy(&pol->xfrm_vec[i].id.daddr, &mp->new_daddr,
>> diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
>> index fee9b5cf37a7..d92b1b760749 100644
>> --- a/net/xfrm/xfrm_proc.c
>> +++ b/net/xfrm/xfrm_proc.c
>> @@ -41,6 +41,8 @@ static const struct snmp_mib xfrm_mib_list[] = {
>>  	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
>>  	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
>>  	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
>> +	SNMP_MIB_ITEM("XfrmInIptfsError", LINUX_MIB_XFRMINIPTFSERROR),
>> +	SNMP_MIB_ITEM("XfrmOutNoQueueSpace", LINUX_MIB_XFRMOUTNOQSPACE),
>>  	SNMP_MIB_SENTINEL
>>  };
>>
>> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>> index f5e1a17ebf74..786f3fc0d428 100644
>> --- a/net/xfrm/xfrm_state.c
>> +++ b/net/xfrm/xfrm_state.c
>> @@ -465,6 +465,11 @@ static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
>>  		.flags = XFRM_MODE_FLAG_TUNNEL,
>>  		.family = AF_INET,
>>  	},
>> +	[XFRM_MODE_IPTFS] = {
>> +		.encap = XFRM_MODE_IPTFS,
>> +		.flags = XFRM_MODE_FLAG_TUNNEL,
>> +		.family = AF_INET,
>> +	},
>>  };
>>
>>  static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
>> @@ -486,6 +491,11 @@ static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
>>  		.flags = XFRM_MODE_FLAG_TUNNEL,
>>  		.family = AF_INET6,
>>  	},
>> +	[XFRM_MODE_IPTFS] = {
>> +		.encap = XFRM_MODE_IPTFS,
>> +		.flags = XFRM_MODE_FLAG_TUNNEL,
>> +		.family = AF_INET6,
>> +	},
>>  };
>>
>>  static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
>> @@ -2083,6 +2093,7 @@ static int __xfrm6_state_sort_cmp(const void *p)
>>  #endif
>>  	case XFRM_MODE_TUNNEL:
>>  	case XFRM_MODE_BEET:
>> +	case XFRM_MODE_IPTFS:
>>  		return 4;
>>  	}
>>  	return 5;
>> @@ -2109,6 +2120,7 @@ static int __xfrm6_tmpl_sort_cmp(const void *p)
>>  #endif
>>  	case XFRM_MODE_TUNNEL:
>>  	case XFRM_MODE_BEET:
>> +	case XFRM_MODE_IPTFS:
>>  		return 3;
>>  	}
>>  	return 4;
>> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
>> index 8a504331e369..389656056326 100644
>> --- a/net/xfrm/xfrm_user.c
>> +++ b/net/xfrm/xfrm_user.c
>> @@ -353,6 +353,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>>  	case XFRM_MODE_TUNNEL:
>>  	case XFRM_MODE_ROUTEOPTIMIZATION:
>>  	case XFRM_MODE_BEET:
>> +	case XFRM_MODE_IPTFS:
>>  		break;
>>
>>  	default:
>> @@ -1830,6 +1831,8 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
>>  				return -EINVAL;
>>  			}
>>  			break;
>> +		case XFRM_MODE_IPTFS:
>> +			break;
>>  		default:
>>  			if (ut[i].family != prev_family) {
>>  				NL_SET_ERR_MSG(extack, "Mode in template doesn't support a family change");
>> --
>> 2.42.0
>>
>> --
>> Devel mailing list
>> Devel@linux-ipsec.org
>> https://linux-ipsec.org/mailman/listinfo/devel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVRPtYQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJRqMD/9ksRHV49QJ1q10p3LImXK2Mcxb87E7c8Cn
xwRIVGBslnR06lSVTpZjkdNMHXhTToB2GkZ2gVvzfVd58lqndNA/TGzEEeRjrncU
u7b3Akl6eBpV+KaMhda4rcaHyDCNgTgnmEAAxflpyINXE9NFKBQ/LRZNdyd+5+f1
TIApvWfjjWapcXRPmyDFvUjjZGwU4uYtXVP5E79wEp/HUiT5UqWWXOf4a1lWM4dN
39J750Ww0svWWHdA28YkEn/g0QcSQVUg7AubHJ6fHy14XGoJsosy30mvzvD2eRdu
ZK4quGV3WxX8bYM/7CNVccjhku2z3R7sPcc83oL8tZsVj1jHbcd098KxWbhlJhio
B5ZQHSucQ3MO1dWJX91zHyD953OwCawl84uqmt7mrf/dpN8vlepxX+DCfxiEAO67
0wim7FUw2jNjv5gyYzGxI2DyDdPz5gEgXbbY43pL2j+/YDYIO78kpR2Qs31ZltRi
zd8zcCuUxZ9BvXZH6glDTHwZqxZ41lP3nnPyWB0eOPkjqv3pj+TK1Ng9SbQbZXun
9S/xJTHW51kS+bRyPxWv8e6dW2He9027Ahh8hKjW6oW07OV1SjgCfHwyMF2UoreP
9OfgsjxIvS/NF/K/IA6OY0nj/sGBNQDz5IeXPjqR8d3m4M+2LGYZMQJKP79BUxIs
iymnFRKKmA==
=SI++
-----END PGP SIGNATURE-----

--=-=-=--

