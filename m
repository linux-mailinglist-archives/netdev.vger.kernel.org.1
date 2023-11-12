Return-Path: <netdev+bounces-47230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0B7E8F83
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F55280C82
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B102C23DD;
	Sun, 12 Nov 2023 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="cJ+H7Sr9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83096FA3
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 10:38:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2114.outbound.protection.outlook.com [40.107.96.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273A2D46
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 02:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXAXGboFl0lJ1XAB52Kd1JcIr4lUKag6LUNZ8TG9016te3vvRN8cYOevl2ibE0dOti+SwVVYiWPuTGF42jtR2bwV/O0zApk207fMGubNtG0qs+LIszAa0vZznWosyOk+ZPuL//dRDoI7xpVORYVdNTOUq83ytI/90JiUHi6+0GxOW4e4pSkseiIKQ61m787FqP52QHkUwYamB6CI26AKF7la18uUTUbQNnCwApvFffde8yFQ40y0ktNdzhDjkBZ17j7lCDdP6gloZQOE2nXPbyzt/m+vB+dwvlcyAI7P5FU+oZY/eRWrp8EnrIwihUhcu/5Sb63ryRQzZ1yw+PtDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aObfHLUiFetfGbQGfJv5pp+6YpsoWkaoR9NdlOTIwnU=;
 b=OsEGgDQcAAi4PvfVu0hYUjLA5OVhhWGyfw/FtzN4hrZ9GVcWuW5NgNigsJ4NAP96WAk5ib1y6IuW2V/ECBAYXxbG5rARfSWRddhhU7k7/cyw8kGn08wdTSbz2syFoiiRbxBUfhh92E+rArer/P1ruIKNRhUaK7O+x6B4WhWOtl3M658H2kC7+9QQgpOBV3yHi4+7CGqsBbKLIVfJ8Z7rPzRCRAZmc7LXhPkaHiqtbwvLFsvHF7NKa8A0hhsEFW0gLiQkcm1htdlL7+VgJ1AjGdmVAPjHiqSwpmTTH9WVUMdvMMQxUmB/GXjgtbWKjXENE9/LJOkMEEXvi2k7GE98Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aObfHLUiFetfGbQGfJv5pp+6YpsoWkaoR9NdlOTIwnU=;
 b=cJ+H7Sr9D7mUC55oW8zkMnjOCKKPEUlVeT7NndqKGV7l8QczUsmcgEBiayHJ+8crbg//4NH2hba+ZmEHozYZtgISceA537OioWXR9Tai74bne82j/3c7kiqTDrIL6jfATh9o1QtEHf8kmiJL4Kcg9QV6RvOOqiP6nDw3M3LHQ/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by SA1PR14MB4594.namprd14.prod.outlook.com (2603:10b6:806:1ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sun, 12 Nov
 2023 10:38:50 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 10:38:49 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-5-chopps@chopps.org> <3808085.1699777584@dyas>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 4/8] iptfs: sysctl: allow
 configuration of global default values
Date: Sun, 12 Nov 2023 05:28:16 -0500
In-reply-to: <3808085.1699777584@dyas>
Message-ID: <m2bkbz5k96.fsf@ja.int.chopps.org>
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::17) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|SA1PR14MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: bde3dbdd-fc60-42e4-5cb8-08dbe36b8deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ut1Fo+i8Xkspklaz5JSBTsTWNONy2bwDl+LxUz9fxZ/FzGUIVxQE3ml/7IhPEx6Iq4aMJkfyMo8qVPc26qyiK3+5GXZ3iHTGZPWv1+4X1yDlTzrS4zgqoIFqII5e3tehaBj0z8/4oF15IA5w/ZQoscmlsihvdMyQzlZVwIvL6lvH0ZVIRgamcBP5Yh8mE1hr4VCKfcgqUkihfFpH8Ms+Z1A2tOPe2UMO77IwdTu9j8UOt2OqRiT3kFQxrD/MI4fcn9h2660ZlJFGPQjL5nBSexIZUWUpvyd44Vq3zrHedzNmS83pL2aojWcl5WLes1S2Xxs5ZYE023tOMLIgE1xqRAoJSKV/EfFCcbjWb6KQ2PPDnaf+rsjj0Zs9PAnNxU+yVwtqoRxnNm5Ju4iL72/seokQPL1UYmSgEDBEV8QrTVi6GqXih9LaNjSuKwsTDP7dkrYTa6hk+KctJmnS5qYVZpWXbZaxXwD/oGFyFFHmttZPjv4hiVdLkKqqBIK9y9CErVInWFATOXBA2N/AtUVIROCJVB1XS9tiwFM11tKpeKXNcBEqIRlUVI9cMUGZ55G2mhZE1ikdp98h8uCFSW6Gaktc43Mbx2YklaVuc7uWwMDFDxK03c69nDLpGxQT5TDj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39830400003)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(6486002)(478600001)(66946007)(66556008)(54906003)(6916009)(316002)(66476007)(5660300002)(8676002)(4326008)(6666004)(6506007)(8936002)(52116002)(6512007)(107886003)(26005)(41300700001)(38350700005)(83380400001)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8iblRPRPlL69oKex0NpWym/huIysAdythUwEWH/iko7UHzZkysTYmcrRn1W?=
 =?us-ascii?Q?NV9xEN7QfGkTYkHCovg/l/x2kWdTL5cVHVJn79UI6Z5/JmL7aNTTDN82Xkf7?=
 =?us-ascii?Q?5M3VqPH4xi39U1baSoIcInem9rTfszXH+8smzKo3dCduNSjDZpYSAffgEjrK?=
 =?us-ascii?Q?zxGurbNEWB19fbCeYsaxA9EF6J38SaxJ+X5l2MC/WnVySyOkz4onOFgjOxDF?=
 =?us-ascii?Q?75uyq2vUa96skEzQSNzvhkxwnqJEFDfsGb/3d53TMDrpn+6kK8AxhmfzK3Qr?=
 =?us-ascii?Q?H+ytoCgqkfl3wICJC8TRmeDtDhIsiIBaQX35v6vgS9Nf6eeOQAmyHGnroiXG?=
 =?us-ascii?Q?ZlexG25ZLeXOFzLIhmhtfV1efe7dlPgVdOOQ2I18sjHePxeZM80CUHwwyIHS?=
 =?us-ascii?Q?VZ6CHn5vkeogLc3H59nSVNV0RD8+MMap2ymXKyRUOuQoGFNjatDjt4LFPnsW?=
 =?us-ascii?Q?NXC66qeKGaEGxE8ol44bZJa3sr9c9IPpjU6kgKv4vPnEu8QWQCIbU4cx8+Uq?=
 =?us-ascii?Q?oJ+Ed91f4keGmnpu5F5jzXvC3X0Ql6ViDymR9fMe/Ue54bfurYpovPIFWfIG?=
 =?us-ascii?Q?yIM0RwJRzIqBM5bzYriT+69z5KqqMjEsvTYeSs1NwKjYAMmHRell7BoTJ07J?=
 =?us-ascii?Q?q0LFl9xx74xS59OmiH7VGED1e4l1T6rcx6upcSWLgVr7GFvZBHuV8X8SyUF3?=
 =?us-ascii?Q?lqwUIa6cKH4F7iZW2ikSNZO/+EZyp2BxHAbczUcXZWxJaawc0itmrH0fdD6E?=
 =?us-ascii?Q?FswBB1szSe3pSVVpHSYfx9Zctz2USbXWSVlbbNrgkjr0zeICKVBVPWQ+4C1B?=
 =?us-ascii?Q?1ND+68tF+h6WabT3XA9n6VkLul8TheeF0ISNEkPR3hOOpJiQmLw6r6BZxXaB?=
 =?us-ascii?Q?5f5AKaF1at4aMY7XjzybLTZtCGXT1SCtSWjBuwnbihYIbCv9NfX368YE/rlE?=
 =?us-ascii?Q?mxdx63QB32+cI4D8sxPP5bv0z9kHcXU9lNoV9p0N1Gl6QcCFxNpnwS3WGbW9?=
 =?us-ascii?Q?Sapp88RFxSXRzy/HZklvCnt+QcqHSisONYniTORt4xBopBhArmbCmg7dfgKa?=
 =?us-ascii?Q?yYCJkusOlTP5EnrNlTI9Unk2BMSHyA1pG5HE/Rk1fVJ3mYMoHGEWoDGr6mCY?=
 =?us-ascii?Q?PGk1gOKWwnNd0vxnjxXuhvqqn6pSzHt4DA+VXv5TlT03dkOrTNsGC2QlBioo?=
 =?us-ascii?Q?ZytQUBGhn3/AYm4tvrg3XInhMZ0Gms864z8HuFl9/ETGm4IZkKnhrJSqc8ok?=
 =?us-ascii?Q?Xc/C43yqEkKagqM78btLSvxhKlcwbycZ1284NR4/U64auH6HzBq0ZZ0o9m3P?=
 =?us-ascii?Q?WdddFqYFTfeDHgx7RGakEf1MOrOb0ZQ9K8SEyy/pXUKn03E7RDWbqbxuOoh5?=
 =?us-ascii?Q?hpkr3HoXCpdplr+S1jXg8hcJoVyiAAsSu068TV6QPcAwqhek0GToSDT0mPvd?=
 =?us-ascii?Q?6T1frNErMmB0/BiRu08x2GN+/M/yrrZI/NShxOUzxxhGaVQ2lqEurnnOBGcy?=
 =?us-ascii?Q?UidqIVwjHSEMM7BknaX3cJkU4+cElgONfcIfpRxUCqqQVPJg/c+ei5sAnOM+?=
 =?us-ascii?Q?Owfv1pnwzbrsj5XTPTNf4o4rYgK7Sg/vm4egbUx1?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bde3dbdd-fc60-42e4-5cb8-08dbe36b8deb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 10:38:49.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yETkFAA6lOf/1lUbRFZGdAmkHwPO2EpciuIrdDfqqCq5ur8gXKLOqVlvnwAu28z7Har/2sluDeyYMgAOiKqCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB4594

Michael Richardson <mcr@sandelman.ca> writes:

> [[PGP Signed Part:Signature made by expired key 7002AEC2CCD88043 Michael Richardson <mcr+china@sandelman.ca>]]
>
>>>>>> Christian Hopps <chopps@labn.net> writes:
> Christian Hopps via Devel <devel@linux-ipsec.org> wrote:
>     > Add sysctls for the changing the IPTFS default SA values.
>
> Add sysctls for the changing the IPTFS default SA values.
>
> +xfrm_iptfs_idelay - UNSIGNED INTEGER
> +        The default IPTFS initial output delay. The initial output delay is the
> +        amount of time prior to servicing the output queue after queueing the
> +        first packet on said queue.
>
> I'm guessing this is in miliseconds, but the documentation here does not say.

It's microseconds actually, thanks for noticing this. Drop timer is the same.

> +xfrm_iptfs_rewin - UNSIGNED INTEGER
> +        The default IPTFS reorder window size. The reorder window size dictates
> +        the maximum number of IPTFS tunnel packets in a sequence that may arrive
> +        out of order.
> +
> +        Default 3.
>
> Why three?
> Is there some experimental reason to pick three?

B/c I had no idea what the right value was (guesses but no data), and so I asked the TCP guys at IETF and that's what the TCP guys told me they used. :)

> It seems that maybe the reorder window size could have been a per-SA attribute.

All of these are per-SA values. These sysctl variables adjust the defaults assigned to an SA when the user does not specify a value.

> I read through the rest of the patches, and they seem great, but I didn't
> read with a lot of comprehension.  I found the explanatory comments and
> diagrams very well done!

Thanks, :)
Chris.

