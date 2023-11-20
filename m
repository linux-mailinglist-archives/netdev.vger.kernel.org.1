Return-Path: <netdev+bounces-49356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA127F1CDD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0406B281894
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBD321A3;
	Mon, 20 Nov 2023 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="ONMllVdP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2103.outbound.protection.outlook.com [40.107.212.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB87C4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr6b+SgXSTU9+FXllvftAO4KUrLqIKF1LfRKOaODLW6nB9ZG3eVBpTjVa/l8y7RF1PUu6dH5HDRdL2kRcVFV7f9StFwSqipTVQYlebKTrr4tdFWVZDDr2dCzNvwW7kPQ6FgklC8vl3TEgCjyJNQm6H1+CfUvbUgKLfIZqLUxofetYazmYJP2yNmFxI7//GMVfrd23F54LzMcp0cBwtaFexZqXRhaIrvl9Nc7bdn08PdK1FQ2gIhX6xgiERPHSUKq/kzMs7ZLC6zehG1GkaaJhqEGCu3nBsrqoy1lgXEZ6y2D+EeHpCoBGtUYe7haes2aljwrJ1Yt41p5bXoYQbyUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sasq4DYM51qtTuNGnIiZEMya6Cnqn4o0kkLkYpJtIE=;
 b=AaIBUPdGVrNwp2hwN96AHvJeBzUpSEBE6HrffutpM2ZkiyXyqonF0qNM1j0D69fTLHFUmelRcnO8nvQoAiOP0yA8v1/vynH2PylmhwhfGcOjqvJBdGxTxyFbog0DtNe9t3AnATxFSftbW0wkNAdJxt6+JXU6cqfEwQNJa1782jhHz1DvCX/Jv2rt4Sj0zqWZnVrF7zEElAnqtijhRy+XHFAaw8OwVZZDSy8HFpdpu3FPA6F5r8icBgs7e16a2lx44qFGeeEdjIZJ2C3hB7BEhGa6qBcgKkph9pgwmCUBxJVT0iER+zEc2PD0B+kuvI/SzDSkSFe/mf3f4uO/Tv+thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Sasq4DYM51qtTuNGnIiZEMya6Cnqn4o0kkLkYpJtIE=;
 b=ONMllVdP/fYUopRYsU9wy0pMh2LSFJmW5y92JvrOtvXdu6Xgp+Eb31PN00bJ3obT6nc7aC0OhoXS4wGGMxDzG3/1oL4VWFtE6xtf/Wj7naRG6p43dJkYGONtlkDNo8g20xCKbKjYGgLd/Ny1uicOdcR35iLiT+6b+AdbeiriWV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by SJ0PR14MB5294.namprd14.prod.outlook.com (2603:10b6:a03:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:45:15 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 18:45:14 +0000
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
 <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Andrew Cagney <andrew.cagney@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Christian Hopps
 <chopps@chopps.org>, devel@linux-ipsec.org, netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Date: Mon, 20 Nov 2023 13:39:50 -0500
In-reply-to: <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
Message-ID: <m21qck1cxz.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH5PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::7) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|SJ0PR14MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f772c8d-922d-4b15-fb68-08dbe9f8d55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZIfds4iQ5n2ieM1/DrfyjRRTwCm65H9/oc6kb9lF3zOppjTBeZStmpRvi4l4b2yOWaWjc1AryQmWi8rKJ72vCK0P2U/LaFU4PCvMVkWKGaNmVj04xMtzpd/thO+B8PS9MMpi3pCBWaq3Ei0y0ldLzQssWvkoLsckyjBgxuzevjfQsR5sQ4I74aIdGmvCxCZIvWChPSV49oWujccuIWETlpdwYsT8fesOkUzqWstqgkxpLerSt65iTPjYuPlksmTFM9wgusFYMc/dWxvk5RFzMCwrtskvdku/wHvTZqtAhS1d/e2hy+Iij/vc1rgevt5xJ6Hw8/ROwtP0AI/mNtCVOByQ/bwuEhkNbIKIX3cSm7JFaaSlwBvCPWdel4TrUdRlS087Ea2KyE/amwC3m6SyH/3OBKN4VPLakJPQQrOhTfJUeUZjr28HkKta7Dsexr1+WDnk97tUm+y9CKrz+7GMOJaejDNG1h91e5Fj+BeMGwUP+cPjR0ucNkkh6RzP6P1Z6Fe0QXd9SKsKWmS1yaHTrZfaFcdm6sNClXBsvTt3EM1daCjbCc4hTZGQYAK14WOLz8R5jan/2KCB1KvceayNc4m5XyiGkcDu2ZC9s0i8gAthPjmxrWsFyhOAFSP+r7LL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39830400003)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(6486002)(6666004)(6506007)(66476007)(66556008)(6916009)(66946007)(316002)(54906003)(66899024)(38350700005)(107886003)(52116002)(6512007)(9686003)(26005)(21480400003)(83380400001)(2906002)(478600001)(5660300002)(8936002)(38100700002)(41300700001)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f57wcue1nK2yaEPbdpDGX1nr1IzR3OZKQz2RKh1dS6pt/6QHgipCdEuQKaky?=
 =?us-ascii?Q?T0cT7cp0q4d5BWxA6vInXbpZUZbtPDbIgMFpWOywOciR0S7GUpaBuHtFR0xg?=
 =?us-ascii?Q?ja2RoETSNT5Z9669yC1ZM6VohfoMdxH9jswzk6oyrCywiwu8VF+TwUKtCavm?=
 =?us-ascii?Q?wanKHsOEfhWS0Znce/5d7eRorOzi+euPoQC43HjnL6d3sPT3EeV0cuQQA69q?=
 =?us-ascii?Q?f8cuLbkPyLoEo2ITfv2LMJlbApmEO3cc7BT0n+oAAzHGyGr7W/7iNtNs3mHX?=
 =?us-ascii?Q?IX+xcLf3kCHKNF6VAaGHC1BnitSBWZHh1DpIAt2QcdIjva/Ts2yI8NpJXBSK?=
 =?us-ascii?Q?oEkZWJpXw0/Xb6slJQ2W9OnBilaE84y1801AHZEIse2K8A3XvOR1QKLRnEPm?=
 =?us-ascii?Q?JRXsQmrGhyREPyYWEqa9Wkd0j9KZPa2wRwrjyFR92tf3jikdCOOwbQL4+loh?=
 =?us-ascii?Q?dlWjI6qNWR2etYVaienVPZ5FYlYRLf3l44G8uh0aCPF8cqLC8bd25+89wzpG?=
 =?us-ascii?Q?9Ov/d93/8AfeHHHkDnz5qV9nImeo1I0O35uJh8SdzB3fg2YslXSfQOlwjNvb?=
 =?us-ascii?Q?E+7VKolVz+flkcISS7SSiVppwwO2y+C7Rru0EZhMSc+R38r5IofOFwPwDjV/?=
 =?us-ascii?Q?j0KYPC/WS+woue+x/9Dkpcyb/Q4NnkeZ1w4ZnkyJSbVbb1O5jKJBNrBj+iU7?=
 =?us-ascii?Q?/Spc/Fin7UhIY7d7OU8r4/YomlGBSAAgN+mhcluFGTXprpccycZjRRV7EfHa?=
 =?us-ascii?Q?9l9pDeM7v0rBPi6VKSI4XA8DaHZWMQuAqP3Tl/Dg/6hnZp9i8kybhtnwHW+u?=
 =?us-ascii?Q?qaK4MBKa1Rr/SwLdgQ5LJMITHlAjC3kSotW6a4Ib90/qS1esKsAzSfNVZ8rm?=
 =?us-ascii?Q?PHhlUvVd5Y1rpXs3QUzNmxcq/vfcW2pmVMjG975P7AJbZRsygqbBQbOYK6Z4?=
 =?us-ascii?Q?bSJCSPPNT92al/hjEY7txCzRUy47jGaRv9IIgXDFvo5pcM3NUOz7RvTEx9sQ?=
 =?us-ascii?Q?ihJIilS+pnI3KVVNsQgf9Tg9cVLBpWxVCfDMm0n1bFrMPjaqLEBnmAfGiOsD?=
 =?us-ascii?Q?TLP4Bk28UWFp6ARLeC+Hy0In4uh1NSz1b3SonNxGzM01xQaxoPSvNbMigm+G?=
 =?us-ascii?Q?1lQof1MOFyPpDqWJGDAaw61ajcgagddOXSQmjQ01PRjjn/M70c35ToRGt6T7?=
 =?us-ascii?Q?CxknoRpgAMAhXrfUCcEUuomg2Lpn7HZEqA7MnUdrsWTYnD5dcVQB2CrVkwmO?=
 =?us-ascii?Q?c3r9P7O4+ADHX9A4toqmXsPR+GfjNxgNKF0HBGJ6+PGDJTAzyfJRwgsgBDM6?=
 =?us-ascii?Q?IMmLmKVvkfNS0azWlJTmaNIydoApyekVzrCuMgYq91iQ1mckDlOBUTTga+YK?=
 =?us-ascii?Q?Utge7FWuURJUMGKrCY2P5F07/vVs3mp7SR3aTHhbB+Yv71q+5V8yzRJ6xncT?=
 =?us-ascii?Q?aSQuj1DkXRqTIKVX9uNCOAF/Rbu0SWoOGTpHpVgwG2JqRdxTyyTUIoCqbbMR?=
 =?us-ascii?Q?53kKoEpC7/+sCWSpdsdtQC01fGvlCAH/AgQcboJB/YFNEHSRm5XXFu/BNP6g?=
 =?us-ascii?Q?fJNS4dfC5jAEdMQUzZrBzRTF1BPx/WmwcxfA7b3i?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f772c8d-922d-4b15-fb68-08dbe9f8d55b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:45:14.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey4042DzYuXR+SK5KZkwXPeYqOIsxqAbm9KM3WCbXqKkhgp7uT1Hpy0CmvXkxU99YJb8YuFcJC47FwE8bezqzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB5294

--=-=-=
Content-Type: text/plain; format=flowed


Andrew Cagney <andrew.cagney@gmail.com> writes:

>> I did a multiple days peer review with Chris on this pachset. So my
>> concerns are already addressed.
>>
>> Further reviews are welcome! This is a bigger change and it would
>> be nice if more people could look at it.
>
> I have a usability question.  What name should appear when a user
> interacts with and sees log messages from this feature?
>     ip-tfs, IP-TFS, IP_TFS
> or:
>    iptfs, IPTFS, ...

I think no `-` or `_` in the code/api. For documentation it is probably better to hew closer to the RFC and use `IP-TFS`.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVbqTgQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJfbhD/kBrunA2UGijRQMGo2Dsvq1l9CnphnWOwoJ
Yy6s6p2KRsyVrLy2mVUJGjCCtj91kcbMqlUbKkjM86Orw26csjsOI93SH2A+qOMd
mQMvSCRNw//2hZMKTKVLrJedNYQM4UvPTFpCyZ71bqCclvBhHowUejwTqD/xVCC1
rD7IAjUr+bwCrxdz9Z3tfEwKi0p58jpq5L04SAGaPtWtVIikxXvCW+TiqNIRjsxE
rPAXmHKKD9tPgufXfjl1Uh5PKW/7fp8LPtBOp50GhuL0K6vRTUGpgJ6QdfBlzUgc
ClXQolTg+7scKudpAAV98S8xPJwKl3R6QsZnOGTt4JJoY22EjONyZDuMjg+Eos4n
d80nhuToTZnft1KeDTdnROfFEYhNbOk6O98ZZMJZUAd0ZflQDaArJ8SR52ARcPfw
7GHWrr7IPDP+WP3758/Im5JzPhdpJZkueb7MLtYs3oIMnr7vQwG2sPwg8mVl+3uq
o/JtW/OaXBbM5/ZbJp4/YY4fi99yK9vgTjfVzaEJlSPjxU9u+s2+0lox9Wt0It7F
XjG1x2f73S3IRKeimKl++65medFfn7I33N8z0M9ot8a7JywWevt+o6JTymDdMQMz
Jchq8/KhT6EtcpIz9wzBZBnl1fMT8pv915YEtKfrrhE3uPsbxSmuRp2+0rl3nned
cMXhhqADag==
=GoDC
-----END PGP SIGNATURE-----

--=-=-=--

