Return-Path: <netdev+bounces-47266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8D7E950E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 03:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941432811E1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AABE368;
	Mon, 13 Nov 2023 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="tMlBnVhc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE763A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:33:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D1D109
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 18:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjMJYSSnnZ7wbiqfcqwOzg1YkH0JDc1PRzY+l79pr+ccXOJXnpOu621ny/ZrBYChnPuQjOJvHrOzz5NmVFnF1gT3vh7+AAa2R1Z4s5/jZw10oZ/T66eT+PzAOXQIn8PQa9/ae5j/XxScyT0GE2E0+m37/3SNQ7t3iJHmOeX8VHd+1Dk69EES3iuRWAm/VAE6u5VDevxxJ46fHB3LTSLGKrjdmQTEKwYR5JMydXLoLXpuSr5A2TgnFCZPvrrGirWmenIkULGSDreIwKu2YhVYxhoac/p8zBu2l7YIbe0izeoDaO/4JFd9lzJovOPFbV4DNwULCnOUNl+SjYMcrbVW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb28Jd7A1Am6asT1GSkfvp4C5szNSfjqBg3PFcoQokA=;
 b=Vms+vyajXU35oofXK1e0WtH7K43w6qNqrHUS8IGScB+q7xO6iGXz72FNLZJtsSyiKOUfaF0hiIdugBct1aong5EknSZUWcSpvdN7zMQaspOQrRZkzDROusZZvbmpf9nhYwZJ28Ozl89hqhU5ZqGljhYFinBM2dCp+IRG8GHjv4kRtJCPpqyZvqPZCnce4pQ3AhI/oDCJliZT60+nyS8XojkBH2jgWhQNTX7sytv2Za8UFCTfeW8M8JzoYNyTWS73PQ0LRDGHNzQhc094jEdm/uYz/XsoimcoP2vaj5eqqRyMtrCzraRV0nQN3P+gMP4FzjCZ+rHeF0lWe7XLayuh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb28Jd7A1Am6asT1GSkfvp4C5szNSfjqBg3PFcoQokA=;
 b=tMlBnVhc4lANbYjlUj6yphrEm4kom9VpeZZxXdnNnETm6NgPy3C8/2OzNbK92sFlIomFcllfl4v67oWzcfCzo08J6rVu4OQ/Fccj5VFspmGM9t+ApN8NcodVbyU2235670JoFbUO6IJ0Zmug6BSwgQxcITSGYYaaE29g/AAj1aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by CY5PR14MB5653.namprd14.prod.outlook.com (2603:10b6:930:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 02:33:56 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 02:33:56 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <ZVErXNOWfR24hkwx@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next] Add IP-TFS mode to xfrm
Date: Sun, 12 Nov 2023 21:31:49 -0500
In-reply-to: <ZVErXNOWfR24hkwx@Antony2201.local>
Message-ID: <m2fs1a8jql.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:610:4c::22) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|CY5PR14MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee55f72-b00c-4618-fc0f-08dbe3f0fbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/HW+7HA9d6++oEuQlIABgZw5ZbOyV0fXjaM2PorivxltK1N9C7imq5eB7eHiiFNp4waGZU7gU8zXpa3yk8gjGXBAFiADSIfkihu+bTsCaRE90P/qYOIBV6oKLLoUS+Y0qR9YvjQosAl1WHWPoVSKy/U9Bm+jctfErtKzfJi+SVuVmPZn3L5Owo8KeBSkHSvAPz54oWZYgucsnE0ngD5tgjax+szJJ7IbouxFj5JnEmWUsDvRWrRoIcQ0tlkHqLTqG3aWlCPRBCl6ScIa8kTecrIu1vFa07BOl9jKFtmk1pPAASu6AMV+BhdQf2JmDPtgAsJ3aojDdSsZXv3pM5KKNjkM7coDUrymDVSJd0+OG7mYVEFT1SxH7W6ORBU7aCL7xR9sjDaAhoZBQw3GfaiK/AG+hNR9/fY+H696Uq2pnZQqL+/XV1nMan0zyjeTPO1eQZ8oaYGahpoooaPSiVZQGJ08K7rO3xIJJ0ncLXIyGDM0ShoOYsH+AtUWoEkpJcf8RdkT9ekjGEDKuJgrHQBrc7ZNl9NcSltGhcLvzzKmhwPasRiZUhhwnLjrZbJElbxiwTmnOlBXNrvrY/pHG4cwLwDB5XFxXDHJVDFiT9OyHDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(107886003)(26005)(21480400003)(6506007)(52116002)(6666004)(6512007)(9686003)(83380400001)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(966005)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJ/jYe+aPEvkb8SxbrmDILfztEBTAD1rlCdNoxG+kh4jsOnDE97zWhjwtmPF?=
 =?us-ascii?Q?tL4ov3qeeVB1Y18uv0+6lIAVD5bzbpym/fXNBF2c8+A2bynx11GBv2d+KIDa?=
 =?us-ascii?Q?nqpvjnT63o9/TbY+5dpKDdr3hhC/rfVqnPnlb1nTItFT2CT131SO1Un7+qp8?=
 =?us-ascii?Q?hiBLi/LguUm49zKalvTSWrwtk8d2lTrskAKVnf8jRUNNVf71sGduarUsYqPd?=
 =?us-ascii?Q?pV3TFK8j23gW7VgMv29nqQ5GGhbJLoHafV6mXMJOaHDPdosQJQG6k2SG3EE0?=
 =?us-ascii?Q?vyPrEUaDopL+zo9YvT9+rK9wY4YzOU/xGqIQ0w//BSA2gpVBI5ZtP7m7yaqO?=
 =?us-ascii?Q?mV2icYZJVcOMPulN2ufH1zOwWb/k71qIuU9ufEPlwGb8gW8l/UYEI/rOEy7r?=
 =?us-ascii?Q?QMW7Q7K+comlaaAk/LqsxX7VIGXqS6G4FysfbLz+hW3/klKs3UrJ/9O57sAf?=
 =?us-ascii?Q?rpSooRlIlzSE0c4sKsQkIgw6jfO8zE4uMg34BjnOTixdPJWyL5CZouuCxoAz?=
 =?us-ascii?Q?ZViqip17SFIprJ2eLvlVVgPoZrQv8TFV31+GkytTFgZJBBHSjzMrlJ3kmZyd?=
 =?us-ascii?Q?m/iLRceg943U4EQg6wWfXiJkPLpQrbEh+wDbW8dhte4fhYtiZF2qRHWGqWvE?=
 =?us-ascii?Q?ElJegcIUDSMhPOHv21kQAaIgY6GfOI5S+MegUfNojJ3HwynbKM4rJzfnqLkM?=
 =?us-ascii?Q?+ICxLMYLBZ2AKcYMEYyEi/MZn73Tb2fi90ZhnfsqOJbh27ggdMhD3gMwqqqr?=
 =?us-ascii?Q?MaKI2dCD6LdulXTIshHyVpG3ykStpJwZlIBSAC4lqB1PY+aHAoMF5djt645A?=
 =?us-ascii?Q?GPSEFGkG1/u4rufLSzsqi9fCaQkATvxQN4rz47VXyKAe1yJGxmchgCVRlxXo?=
 =?us-ascii?Q?YAinsoYVotxb3KyS9KDNXFz7HfXEJBly8IK8h5dUr4fstl0segzXJ2j8jj2B?=
 =?us-ascii?Q?u5l2GL29btsKLEW0Tx62Yg6o2SKCt584HQin3hwUvpefJvp9RlwoHmV/Lfuu?=
 =?us-ascii?Q?cWEI4VBtZGBSFGcgNqkjdOPBqOwC3WyQBydM12YifRGPeFTg246iLU1NLMQx?=
 =?us-ascii?Q?0GHfIG4vBKbZ5TIkA7E4ow8kmtRIGSQol18pjIcrE4XV+s4xMHIAKxm4HFPb?=
 =?us-ascii?Q?MWPPx++zW3PN233IFNZri7Dlu35T3cG3gFlDo3JcPlm5QU6yaQjBgCPmgBy9?=
 =?us-ascii?Q?NLZR8OUX0KDPmLKvV23kfo9G5yV+BiWhFKbMc6q6EGvlcgHUvyOTZABlXNOx?=
 =?us-ascii?Q?mAub3E/xr3UHDo58zGWFnUa9UUeycfNUB3nYUwgiRIUDUqvSTML3/fxvrLPP?=
 =?us-ascii?Q?cSd3/R9UlnI64VmkCYqwY/5DXs/Vqs/DVK4b49nXsByu4kTG6xl220K0fH5l?=
 =?us-ascii?Q?jRfQLDoWNmK9vYRa4UBd6qp7XEwSiEJZG1JFMbn9HA0JooWgbfD2h+p+HFnl?=
 =?us-ascii?Q?dhRz+EORFfwlGbr7ceorjiXPNXjsppMpumRUTnCE5iChKNw71jhckMAytOKS?=
 =?us-ascii?Q?uwLvRxxylfz/v8LhL4FO7Te83QROikOR7RrZP0PyKgTrvdDRloFtENyITfSI?=
 =?us-ascii?Q?xLKtXvfhxNXTNG8lkEanm0ZzRbPPkkSw9+vFqgIF?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee55f72-b00c-4618-fc0f-08dbe3f0fbe0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:33:56.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/BtbSV8jOppgdmRpVnvd+3n/z4sgKj2Wy6vO51sFju9AWG7L/PnwfaCPUZTHQEF5vrglCwJyEvS42KDUhPQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR14MB5653

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony <antony@phenome.org> writes:

> On Fri, Nov 10, 2023 at 06:37:11AM -0500, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
>> (AggFrag encapsulation) has been standardized in RFC9347.
>>
>> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>
> It would great to have details which parts of the RFC is supported in this
> patch series.

I'll add the new extra text from the Kconfig help text in the next patch set. Here it is now though:

	  Information on the IP-TFS/AGGFRAG encapsulation can be found
	  in RFC 9347. This feature supports demand driven (i.e.,
	  non-constant send rate) IP-TFS to take advantage of the
	  AGGFRAG ESP payload encapsulation. This payload type
	  supports aggregation and fragmentation of the inner IP
	  packet stream which in turn yields higher small-packet
	  bandwidth as well as reducing MTU/PMTU issues. Congestion
	  control is unimplementated as the send rate is demand driven
	  rather than constant.

Thanks!
Chris.

>
> Such as : Non-Congestion-Controlled ...
>
>> In order to allow loading this fucntionality as a module a set of callbacks
>> xfrm_mode_cbs has been added to xfrm as well.
>> --
>> Devel mailing list
>> Devel@linux-ipsec.org
>> https://linux-ipsec.org/mailman/listinfo/devel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVRixIQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJbeBD/99u4PJuvXHF5HMDqMDdQiTt1I0X/MR+EsR
aZEayA4ss3nWdzACqDwDttuVv3vdsbrU+TMNMFSB38qLH3SoWhPAmjARdsEsHWDA
WBuxQmj9aaZq1PDvbQ/glr7UDRj65PdRaLHlerEVbQOhd/VoMKdWDQiKrcxClAqw
p8DA3d+3uiksB3QeZRQgUxz91c4D38utXKsL683ofttaSRy6TXU8ETJtZU2HDvd1
a5wY8kN7kiambECtM8qd9aQYBBXO+FQ3ZQC6gulQwcduu9TqK7KntXzlVKRgXvsp
KLph9VTPDcoORaiI9bemXII519h8p4OO0eaktddG4BYcIphgt0ZPzHpdn+dm5YW9
vh6zsEssTpyF7w7l088qPFSIINwemI+CHhr3XgT61pnms5shb0SfH0R4sot12Wiw
yyHOWGgc9sds6JE8LnOMgquvN6LsEPD888wa7Gj7N/M8n/eN85PalIiQuZfDTr0u
69iNLO/EB3+FmkkTeTi7R7f7gXgwRsgHAtrfdimvWfR+EDfpFPY8+Re0V4VsSKca
3oZ7wAP7TLopfER04yPVSCE3DGceTPP/2WgxS8Zgt7JVBWF4U99ehviBS20HZtGU
7gM3tb6nOAMRSNJt5OzGWGS10XSkoOlF+7RTdURf98h3GEB8TEFbhMqUN46zTpr5
nNfSub/eBA==
=Pu5J
-----END PGP SIGNATURE-----

--=-=-=--

