Return-Path: <netdev+bounces-47236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CB7E8FA3
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082731C20325
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E28473;
	Sun, 12 Nov 2023 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="GkoYd+mV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1F8BE3
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 11:35:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D792D77
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 03:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpgFND+N25VECAjIeK+7bez2PGUPvrHD6IG+hvJqsny1Hw99HVqOb7v+tyPdF8zP8TuQUyTWwBbBwcHbfAqWzOUgXVE4ke12qW99/JapU157606aw21mN4OBrWd4utwYLfLExBPVt0HfotFDsU6mptcjjkWJiu4KdjM4Ljufb2PBnNhKFwYZBIJrN7FKCufPVo14AyA4p1VqxY3eNQsYefSa3f8KgwXm4raHV3pXkUAIK4Zu7IKcvQfU5zCR4001fytopWYCz1vFQJKhKIf0B/eFDnk26qQlzn7/Ug4ihp5M8fc7GafOqpSkQ4F9f4xKvLji3o1cxYMUoYoY7mY+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXxvXs712t3IDw8okWReTvAO+/YRZ6AlwXXqBrMfjI4=;
 b=GSum7cmgDrziybCPDz27AXrbLdy8iOkxT7KOi744cJm6/wZJ7KJ91jxBP24bBmL+bsntO0XOntw+cGsfpnEu+VwRzbYQR72biWR0ocgR/iGMJREvW4yA+DduueY1iPAXl/bD5yyFHUKSTnBdFY02FTwlhbAoBdl9CCzcJDLXURdlrqNIrbosyFhmiLZh28usb7f9pLiSsyxgB533ImEXpTametKHR3keKOagx18fluD0rLtAtKRSkaOqrqJ3EB2PMoHbXpG+fcSj8P6gVqOIcf6IXTf/qfhX0Wvf43nRchhef2qveOmgzouBBmqCzmaqXjIlUloabeU/qucjrasFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXxvXs712t3IDw8okWReTvAO+/YRZ6AlwXXqBrMfjI4=;
 b=GkoYd+mVa3QO5ZR3/g5iMInLtu3jaxIDtU82GdpW1Cq29tJZCvNgmv4LJf1x1ZpP+pgXWMf1sdWrKXcSCpSC65mmZRDMiyfax4L5PaKqsj4BvG3R0p2dNkyDVD3Rf3G9yV5em33NKc9LTm/b11vp0/kCMA38EO3dEOG5xruF9X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by SJ0PR14MB5370.namprd14.prod.outlook.com (2603:10b6:a03:429::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 11:35:36 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 11:35:35 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-9-chopps@chopps.org>
 <20231112100256.GH705326@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next 8/8] iptfs: impl: add new iptfs xfrm mode impl
Date: Sun, 12 Nov 2023 06:35:17 -0500
In-reply-to: <20231112100256.GH705326@kernel.org>
Message-ID: <m234xb5hmh.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|SJ0PR14MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 339ffb64-ace6-4fb8-a43b-08dbe3737ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t54KVkpoBBJVpb/t+kmHEMOKMBmNWcKZHVdJO0M/7E2Vdl0xesvTTedAxHuuuZnEVnBdtEpBpqcwdH4+P0+Ev07gD9eZySwF2NTAhPev5kvV8Uo1cFxLqCn7oU////lCRFfNS2NzSe6eoU1Z919UOVx+SDGRTjaGPK7mJw1PS7AvBfbJkPNvC4ON1jtL5nLzc+PRw1/rthiejHijtrAyjI6f61pg2FQsXeUKs+HHc6XgSyT2g4i3PX6OF8Ftscgv7QpuugnAasCGR2CbznB5XEeTcO1957q7sXwTFX2zXK1BWy7fEUljSrWVlnPkRV2beopzL3rl9JQgdyYoPqaocdODNjqjCtqLQPgtl5vXyZ4XsgG/QZ7ZkaLJYWC1qH1oRThf2HwoI/CakEkqC9LpSmy/9tyiajVzm+oeXH8YG0sCTixwJkZfd0x2zZqwFPh/QrH/uEDP2erny6KAwXfUcVOwZ3/YrEYswQhFZ5m+GISaGqPawffj23uFz/fOrW2RUjSwx8wOovtA8qcUBmGRYGyUL8FFYC+xDV1hWEAa6LwG0jiRfZpP03iRMmSTW9mFDNoe3W+dkvUkAW7uAMf1Z/ntpPy6gEKy3siGYVqSK2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39830400003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(54906003)(6916009)(66946007)(66476007)(66556008)(316002)(478600001)(966005)(6486002)(6666004)(86362001)(5660300002)(38350700005)(41300700001)(2906002)(4326008)(8676002)(8936002)(26005)(107886003)(38100700002)(21480400003)(6512007)(9686003)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5hGxtG61fOoN7Wmh95ac7wlTlkgUrmpvb941EACLMx736INmcZ8RQkZxDDSt?=
 =?us-ascii?Q?hyCZZYqONfGWrLS2pZPXYL4G8FX+DCIWipS9MgruO2Nu37rBnJZt6h3xFZnC?=
 =?us-ascii?Q?olTaZvz9Zo5Q+TLvcAkS34ULLRv9+vnWjRumLADEdPUC46OXYaDv/FZQwYQW?=
 =?us-ascii?Q?N7khsvzpvGQ7suDijSrW82HnIs9Uu/7F1VuiPRDy5CMe9051JZSiAoIQ+GWo?=
 =?us-ascii?Q?24B872iVzEj1owxbd+8tLGQsTKO+D9u++aiDNLFIH6KHTF3sJBzJ1Sy2PbUF?=
 =?us-ascii?Q?PtUca5uzllFoXEmGQ0GXJnVxN4s9UsS49oKhw2Hp982L936v7R0fixhIe4OW?=
 =?us-ascii?Q?9pQncZ2s5IQwe2TC/Dj+7+ATj8VpM6I0qvdWmL2EzxAFwY8nLk4xYrS1idz3?=
 =?us-ascii?Q?kHx26l6zSKw046GdjxL4942dPIN9U1nF1GQKrlqGFreR5KI0eKKhU8sK45y3?=
 =?us-ascii?Q?bEFqWxSfWpetUdm3D5GE8Sh2z2LVGS6p10s+JkUVKfxk7ZQ2zeYdZI/c347H?=
 =?us-ascii?Q?nEWNkwFXky46nQoE93/aA+T0dw/QO7rBWNEBaY2E9FFHdtVgOsT4DsqtUPRX?=
 =?us-ascii?Q?nzeCajYyYqw1GgBjWU16jHyajS988lOuaf++MEcr/BcRySgkon8W7vnJOeHj?=
 =?us-ascii?Q?oSpKa97OkfwLycCCDt5NFfTP2ZIbQ+JbPrmCxIaiPvIlPkYyIiQirN36JnrG?=
 =?us-ascii?Q?ojnDRCNu/8CawmzUXkTcjEExqGsj6MD090VWzCqRrmavo+f2QsD6mfUgo69J?=
 =?us-ascii?Q?KwnY/8bd/Wl65AXQmKDCrjbSJ0ycrvqW/zDBxlpk5AgGWiov4TQI5l+n8yM7?=
 =?us-ascii?Q?0XotkXVKazyhxFMq2uO1D75NpJ2JGIra5nXyDvABrQ94WUwhptTshUWpi5xi?=
 =?us-ascii?Q?JosKWZ3h0vagRnuaQYI1KpTPVApiC4k/M21FyrwNKDAPWy5h0z2Y8ySjV0KH?=
 =?us-ascii?Q?DFvo3cer6ceQhHsBFYoONvAHpu2Rz/8G4dYIXeip3NZL5KFCJPkrEdS8Z98o?=
 =?us-ascii?Q?Y6CUDEY1BXZ8A/WUznII+nHgnTOgSB9xcZpVkxgbuteMM9Zx/yOm0mJ7iWJq?=
 =?us-ascii?Q?QKP1578uEi8zYsLyI1iKoy+IZbr4phagJdTWulJW0POfb/qabNryTfRr70GE?=
 =?us-ascii?Q?Lhfqo0I3uEupv7DsRCu7SMOoVGhxpPgphoxXeUkbYcmTkNmdlFX75dzw6Fch?=
 =?us-ascii?Q?Y6omY/OKOMdLlZjFoUKiH7EoqaV1lQRIywNLCoI+CtAcXlakTm9XB8jw1ixt?=
 =?us-ascii?Q?M4GK8rqN1JUeBK/OW/DBem+emubs5sC0QYvO2kZ8VigQzWEuGpEiWiEKLkON?=
 =?us-ascii?Q?jyJjSPVQPtUZGwGd0GF/6Q3MmWyF54TAV5UZ5cKebxQPm0RxZSnK4wm1PiHR?=
 =?us-ascii?Q?u1EFLq0tTUYwFY5wREbf7nl031VajXv9VsxfkJfxzpBiJ4XMrrYeHNsoapeQ?=
 =?us-ascii?Q?pzcxFNI4d/MeqjipV5PFMCePrBm8tcmwm1W28ijaKKw1Ifkc9kSM0ZdnRiPa?=
 =?us-ascii?Q?oDOrPuPtP+6w9gM4bTIaEUsAXJO1uhK9d1UvBAv/hFzEo5YXkUOdHbWZqaO7?=
 =?us-ascii?Q?b+tEAeoFMQRUMIhIB66j1hFL2XGUSwEKvVQ0hpBq?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ffb64-ace6-4fb8-a43b-08dbe3737ca9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 11:35:35.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l4se8ju94LOkjasSJ3KjuCtcA3BiiZlXjz9WvimHVG4aJbDD3J0YkP45EuTuCd4h/R4A68n2vbV6SjR1Ett2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB5370

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman <horms@kernel.org> writes:

> On Fri, Nov 10, 2023 at 06:37:19AM -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>>
>> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
>> functionality. This functionality can be used to increase bandwidth
>> utilization through small packet aggregation, as well as help solve PMTU
>> issues through it's efficient use of fragmentation.
>>
>> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>
> ...
>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>
> ...
>
>> +/* ================= */
>> +/* Utility Functions */
>> +/* ================= */
>> +
>> +static inline u32 __trace_ip_proto(struct iphdr *iph)
>> +{
>> +	if (iph->version == 4)
>> +		return iph->protocol;
>> +	return ((struct ipv6hdr *)iph)->nexthdr;
>> +}
>
> Hi Christian,
>
> please don't use inline in .c files unless there is a demonstrable reason
> to do so. Rather, please leave inlining up to the compiler.

Removed all cases.

Thanks,
Chris.

>
> ...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVQuIYQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJS+UD/9VDHGniLSdJljNr0QQWyDXMYJXkG6i8d3n
xDIQ8oEFyxof8ErY6HJoHF9OnnOffBE8NkhLrxskGVCxNsG8gYlgq4lZntkIpdww
FG8zkIZWdRVu6NRin+0SfEjJzO8grQU5ro3OAqzw9gEblyyZ6bJQ5OgrMssFpXwL
hTkNp43cE3hS+MZgIrBmIoPQoSGWAtfg6C6Pb3j59Qm4KCUAKsBpd4zqSgOaqcL/
CFuDF4ouyhtkjWkXJqY0+M4tYU22bmQz5EyDNWT6hBlXFJqcD1ZdkViZd9We+WAI
m3y0VYfgcOTMY9DlipDirYAf0klpvWsf8P4DP+wjFUDzd6gHhtK2e/yPk4HwfQ2a
s8KZbrApa1zg3fpV1r+vrsUdH7nB3X5WV1V5N1lsezNCXwH3vYiA/kNf8BxV88gC
ylcKnXlzzyPXdfFr4De+txRbxzjIYb9EcJaxJqhgDmdUOyHbOW8ovo6F3RTOoQ5v
K4gVL8VubSktTTqNqSix7Yjv7Xp2SGyE6HlRF3qa6d6XjR1fHy2ML9fnrQ6/O6B5
ZDu3ybPKPCDenQBIqSzcO9VRjgktwmyABenduEg5MNvZckjE44Rfwe4zqTQLctPa
0/BjjPt/f0f5Oh5Ght3NZIlg4NOldEfwFiOIyDQgNlOlYvnbY/uvkkXDLju1izL9
c6BRIvXBXg==
=Rjmw
-----END PGP SIGNATURE-----

--=-=-=--

