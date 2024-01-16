Return-Path: <netdev+bounces-63868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442C82FC73
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F81F29652
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77128E0B;
	Tue, 16 Jan 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="faoTYbFa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20228DCB
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438696; cv=fail; b=APfHOulGZtdi+G0YbcrR9XibbBnSVLv1idYraYuj270HMp+vLdxIU9Duo68/+MWy5lpatHeaIQDmUzvzBD3A5gukHtEKop9lTrSiTwdWxgepwmx67JkV2rvbuHktuLU7cjDIk/S9gdruiSwUuMjR+J0SQ00SRtOFqATkt8EDUnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438696; c=relaxed/simple;
	bh=rRHRNqxZT4l7xjW9pMknZgxdvYdcmpTG7HAhem2BFE8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:References:User-agent:From:To:Cc:Subject:Date:
	 In-reply-to:Message-ID:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=clDUJOiQqVT4S3JYD/svuym05VPUI/79JOGDJdBAs5lMFIErKZXlNfj9r5M8UtK+EJgdd+ODrNyVqyDLnitZNaF7ddFb0TvTxRdu0T83G+zgEF5Qwf750/gG86DNlH4sXZY4hKBYFrZCFdA4CtQVQNPMxpEe9bcGNVRKECpJREk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=faoTYbFa; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhZomxAC/a+t/EANh1aW3EwWiHoarWMxTcP6FL14CeP0tClI0X/IPxLU5YSSkCcAbZFMofNOElZ7MEWUgfDV6AEdCS+AtC/kjCGF6e79oEWGvPvyNUvMmO2vRlFC942jhP+5YxVr+VR3bRP7x3QOkRzwuurnf/9TMCZVNmE/+BoyhgVe73OWShvtzdkZvfjFxe5jX/8KJBJr17Lj4UFA63DA2Ucsc2/Vm33w4cP/wj1imQUPDyV0Jjxcr4GsSHgXrR9f0ZP4P3O7iLFeN6LhQ5dzOVoZ9/XmKDXM/qodBT8QamrD7zS7ocR0n7HWjMIAQTMOrvaFS2DvYJ59GIVO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmbgJDxKOgl8jUSC2lI8x7JHcrbqtzPSzzIaf6sRYP0=;
 b=YXimdHDkdrnU3sV3RZmYQZgCoHwsmHblrdCNh8BsZQ+rE4fl19qtFJ/VZ70FjPCRZWHLDMpJA5qN/Xx8IQhD6rfUWYVfaF0O4wQzCykDjmtR+51zhI7JUo6DjumYk8B814ymaLIqtj8LLDOZiMz43PcG4WKe53ToBBsSACY/LTYlrR+yMvYziZ7gXeHz1oe1jWsiANACa8ENXtCj1rgUnHqpCOTgMLAZPNBdyjpBjuydmdTJ0yc6G1chBj7+PZfur+aclXUKK9f85UuEUlJy90HyKb+kH/HRkwvyv4kZkPXOrzyzVqyKleYBRGPVpMw35dgyBnec9dU9YPQ7oUjxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmbgJDxKOgl8jUSC2lI8x7JHcrbqtzPSzzIaf6sRYP0=;
 b=faoTYbFaa7xPtDbibGxtOMGdrmbmAPWA5LKIz40GDbc/jswSfWwWakARZFf1QqIDtvGsur5s+CtCMJxeTGepDXt4o+5Gw+WK9j9ORzsIjJkmyhCWFj44ybjcg0jh5zt5LOvyzUL5E+/aB8EcyF6Icy27rv+nUlQmzaWLDlK8nv6Qe5bQim0o/QHHz1SwCiMsg6EsDvBPEYhPOvSvYtAr7b0Zq3SvG6dB0RhTuSKwuxUR5N8aLzWfGDmT/JrwK63JGz9NWBOGhCCsbVHLQbC8eWdSBbqtDnOosHudqlcv7GIJ15/dI9ntZmkdxH3peTG3HJFrgS1idDhyBM/al3AnTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 20:58:10 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 20:58:10 +0000
References: <20240114174208.34330-2-rrameshbabu@nvidia.com>
 <9b1d136c156b33759a0323e988b73839d5920acc.camel@redhat.com>
 <ZaaJ17btw2PtW-Sd@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, "David S .
 Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] Revert "net: macsec: use
 skb_ensure_writable_head_tail to expand the skb"
Date: Tue, 16 Jan 2024 12:45:46 -0800
In-reply-to: <ZaaJ17btw2PtW-Sd@hog>
Message-ID: <878r4pov1b.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: a25808f8-3538-4cf1-72ee-08dc16d5d8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XNVkzK1R2SM1HDRxhBtyZXSkxIdOw+osEeso5WbSHOCTx2frxz07PdpFuGMRHAIt3uojfHijt4YJ/5Uf0gmcLoqOB1+RrsM1wWxlgLc3r60a/WulC8w1F3/WfjH4VCK/XV4hDfs+ToVXIlYUJ+m0lWf1VdvwwQk9znlHvPL9Dbakc7aP/0kDLwGd68Qs1r6jEOJBaMrUPjdp7QZbotDKrAuzicTBllsxeYxGAFLyZWw4E4m0ovOHADEdmYD2+gDbdhebiuYyjhY50Hk9kLxw8JbMiT90bjDo8Yhq4JfLvHz9c+OwCPqSLTDVRS0ugHa6Olz3kI8o3yZsyBinYuJOheaTmt9aDse5XAUvq4zkuBHZZizDl2FkAH/s5ln212XrVWVC5Cuy3T7XHW1dOx06Fm2rt2hL2kTqEo7uOS4Wpgbk4XnsPL1LcGsK0PNzz+cejYAveN4aBrwETD3GUtsWQYppQtwOH722hPExplugACRItOF2aGx8WkBEe3wj+LE6kdNpoipqO4zCcJF64k0+RoLgKIGHvyUAmRf4nMjF2atIUut6biRaSntffn6cggr4zO+72tE3ynwznyzLgoPXByPHkE+DUnBy663MhVXOl9kezbWZnS5fwapnGE/kvyGi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(6512007)(2616005)(26005)(6916009)(83380400001)(4326008)(8676002)(38100700002)(2906002)(5660300002)(6486002)(8936002)(6666004)(54906003)(66946007)(316002)(66556008)(478600001)(41300700001)(86362001)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitTdStQb0hBajROS0JRVU9RNVpMK0VpYzZRSWp0THNsL0lpa3pMaTk2OVp1?=
 =?utf-8?B?eS8vRUcxVkRQOGk2RTNnOG4wT1hRaGtRODlmZm5nTjF6T3hOV29OTzJadE5y?=
 =?utf-8?B?dzNGQ3FXb0V5OXozbGJ1T0NrK0ZVMklXblhKdFRsU3krM2kzcW9LaFZENGh4?=
 =?utf-8?B?RGVldEpad1ErVzZFc2hnTDlQMlFkajNpWjM1d0ZScUs2UXpYbUFTRU14amdF?=
 =?utf-8?B?WS95bjdhYmZqajBBa2NiQkNXM1dYVmNWT3NmTGt1WEgwSmh2UnpUczhCWkxM?=
 =?utf-8?B?dDZPdWNmSVEyNDgwU0VGZk0zM0hHUHd2USs5dHZGTno4UHh6ZjQ2VjVFWk01?=
 =?utf-8?B?M242SXhadTRITmFDeUVEamFQbVNrSGF3TllNalNzS0h6RGVlR2s3cnMrNGFG?=
 =?utf-8?B?WU1qWlRxOUJmYUlrWXhDajU2MnlhQVBSdkgyMnoveVpqNDQwdW54TTg2bXJC?=
 =?utf-8?B?TzRIN2JZdVZGQk9CbTVRTXVTWGtYOXcwRWkwS05PQmVPS2dVeTRrT3lIYmJk?=
 =?utf-8?B?bnRIYVFrNnFiRTQwbWJGa0xWQmNPNzU2NmJ0NGljUjYvL3NMZVZ0SnZ6SU5q?=
 =?utf-8?B?TGQ3Q3FaN2g5ME5ITnQraGZyVXQ1TzZUcVRxTG53b24yZ00rM25kcXRZaFhk?=
 =?utf-8?B?c3lEZnRFa0lsczdOOHZCVTJkTmdDRzFSaFgxQ2NrZ3VVVXZWRDVvN1hkVXhn?=
 =?utf-8?B?Q09GcnBFK3Uzb3Y2WGlEOEZaOFBiNEtTVnFieGVDK3g2N00rV2phdndmQURh?=
 =?utf-8?B?bU9DRnA5RFhNM2hjcis1OVBUVkdLM01oYXQ3UVlZY2srcm8xNkRJODlsZm9U?=
 =?utf-8?B?REpxaFNqVTBjVTdoaUkxMUloUm84VTRWcXVWSDRjL04vZVZhekRWL01ESTZI?=
 =?utf-8?B?czZPTk1HZGt6WjBBM2JPNWh6cGZ2WXk1aG9qS3RFeU1TTXJYaWNuQmw5cEJW?=
 =?utf-8?B?OWp1T3Q2TDZGbDBrYmRJQTBmQ25PZVFaY3JLQmhVOWg3QWpPQ3JRb3ZmRDlI?=
 =?utf-8?B?UWMzbFIxRHJSWjNDbnhJcUxUUUpldm03SHI0Nnk1QnhuZGhJVEl6enlUU2tW?=
 =?utf-8?B?YnJ3SDFQazA0dnZtR1UyQm1mTXZhOVhTRTVrZnIvNW1KZWxjN3Mxazd5amhl?=
 =?utf-8?B?SzdtSlFIMGRDcGhEVGNwMEI0cjdjd1BzQUsvb0NvZndSSEZFdk1lbzBhai9w?=
 =?utf-8?B?MytVYm1CVFJmVGlaK1JnUDVNampNZ1oxN2dOMzhSN2FrSHM4L3dHK2RJekZX?=
 =?utf-8?B?NWF6L2Z2NGNqZ0ZOZlFJR2tSVG5mRENKeDJ4emFaV1NUQzkvVTRJY1JhZHhW?=
 =?utf-8?B?WUNZaThBaUJhQ3Z4dnZ1aTJENG0rT0dNVko1eWFSbHlrZUR5V05STDhmL2ZY?=
 =?utf-8?B?QmpEVEkwS1dsS0dRK25KSE53MVBYS1NEbHdzQlErTS9oNUlqL0ZYZFJIWURX?=
 =?utf-8?B?VUxBcTZ0RXhXZFlwZVcrTmJERHhwdHNzcU9PWGRPaUxlQXQ2NmtPb3o4NlJx?=
 =?utf-8?B?SFI5RlZuUGhNamN5Um11WDFPUEhwYm9vZmNKLzdZbllmK0ExL1p1akk5VzZi?=
 =?utf-8?B?MC9uY05iYmw0a0RITU5rOU1zMVFkV1JYNXdVV3FUV0dqNzV1cDAvN05pZEo1?=
 =?utf-8?B?U2tvUE8rSTRlazN6WHNndk81NU1vTHBGaDJISHVOZkR1WC9YdHZ1TCtlLzVa?=
 =?utf-8?B?bXlZdUxRR3hDckpVRmZzQlJoQlg3UU9FRm54OWxXQllqS1djR1VwWWVnQUJE?=
 =?utf-8?B?ZzRKK1ZHWURUdG1ERHF4SVhWU1dJWENwL3JNUE92OFFjc3J5d0NCYmM1aWUz?=
 =?utf-8?B?N3hDcVlVQ1FPbnQ4MEcrOFdPa0M3bm1XYVUyTkQzM2p4dVBldmt6SGZadGd2?=
 =?utf-8?B?U0xlQStDNVBhRDQrVHNKQ1dYeng1dzFUdGxQdUdXczZNcWpwdXYzc21DMGdJ?=
 =?utf-8?B?UXEzb1g5QzJBM1NrK0VTQkFPY0hGZzBncDlHcFBlWGVQNitPckFFOHUzZzZB?=
 =?utf-8?B?TjB3ZlBNeDBCM1c1eHZOZFhJL3l2OU90RWJKcXFrbnBpaWpmdXNvWEVDWVZV?=
 =?utf-8?B?Yk9XblMzQ3pZVVdxNWdVVW0wMDB1aXdueUgxbHJQcE9tRjVFOC9aeFZMNjJB?=
 =?utf-8?B?bk1UWE9aZ1FDRitYRmZWWTBtYXNpY0tpazJiNFd0R0RGQkdJRGtmLzN0K0xC?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25808f8-3538-4cf1-72ee-08dc16d5d8c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:58:10.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Oi8674YaAQc8uNGRmvl2BGmtkbouOt6iUvrMq/0iqvkLStRJY5DcTJnu96fKfqQt+5usW+5sdA7avr/fpTOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On Tue, 16 Jan, 2024 14:51:19 +0100 Sabrina Dubroca <sd@queasysnail.net> wr=
ote:
> 2024-01-16, 11:39:35 +0100, Paolo Abeni wrote:
>> On Sun, 2024-01-14 at 09:42 -0800, Rahul Rameshbabu wrote:
>> > This reverts commit b34ab3527b9622ca4910df24ff5beed5aa66c6b5.
>> >=20
>> > Using skb_ensure_writable_head_tail without a call to skb_unshare caus=
es
>> > the MACsec stack to operate on the original skb rather than a copy in =
the
>> > macsec_encrypt path. This causes the buffer to be exceeded in space, a=
nd
>> > leads to warnings generated by skb_put operations.=C2=A0
>>=20
>> This part of the changelog is confusing to me. It looks like the skb
>> should be uncloned under the same conditions before and after this
>> patch (and/or the reverted)??!
>
> I don't think so. The old code was doing unshare +
> expand. skb_ensure_writable_head_tail calls pskb_expand_head without
> unshare, which doesn't give us a fresh sk_buff, only takes care of the
> headroom/tailroom. Or do I need more coffee? :/

Sabrina's analysis is correct. We no longer get a fresh sk_buff with
this commit.

>
>> Possibly dev->needed_headroom/needed_tailroom values are incorrect?!?
>
> That's also possible following commit a73d8779d61a ("net: macsec:
> introduce mdo_insert_tx_tag"). Then this revert would only be hiding
> the issue.

Ah, I think that is an interesting point.

    static void macsec_set_head_tail_room(struct net_device *dev)
    {
    	struct macsec_dev *macsec =3D macsec_priv(dev);
    	struct net_device *real_dev =3D macsec->real_dev;
    	int needed_headroom, needed_tailroom;
    	const struct macsec_ops *ops;

    	ops =3D macsec_get_ops(macsec, NULL);
    	if (ops) {

This condition should really be ops && ops->mdo_insert_tx_tags. Let me
retest with this change and post back. That said, I am wondering if we
still need a fresh skb in the macsec stack or not as was done previously
with skb_unshare/skb_copy_expand or not.

    		needed_headroom =3D ops->needed_headroom;
    		needed_tailroom =3D ops->needed_tailroom;
    	} else {
    		needed_headroom =3D MACSEC_NEEDED_HEADROOM;
    		needed_tailroom =3D MACSEC_NEEDED_TAILROOM;
    	}

    	dev->needed_headroom =3D real_dev->needed_headroom + needed_headroom;
    	dev->needed_tailroom =3D real_dev->needed_tailroom + needed_tailroom;
    }

--
Thanks,

Rahul Rameshbabu

