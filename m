Return-Path: <netdev+bounces-47235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D697E8F9D
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 12:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4798BB208AA
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656048468;
	Sun, 12 Nov 2023 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="mBk/Mjo0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAC8473
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 11:32:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2115.outbound.protection.outlook.com [40.107.243.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9032D77
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 03:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbKJqO63EXghfgyT9FqOP5/bGpqYaqCVy/SbySvpFZTHnWAXPPHMquPvPQQbU4mAAuE9iVVBAtlnHTRf44Te0dwBRLXwZSJukhelxSv873G+N4l0YTWrOn9nRtIYcuyBHNeTxbORHxsi7nstYv9MNfB2ZGpfu5d+12LfsH6RlN1xh96zLf2lDgyEjy9k00ncKGKTFeTKNlL8q4ZfiMV1hid+piFyXJeq+tItPHQEwMSnA+WdmeMuJsPLMyGGEYB4vpX7UdL7SkEarFuQsBL1inN6+WJ2IbaGrHLulhd8EnMFBwtE6KGKlE5T2MTu7unwxDOUoIB4AxItEExfLylkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWADJeBreeBunj0hlHhfqszrTr+R3FhkgAt10DGS4c8=;
 b=Wra1z0eXw4YMgXgblqkkE0GC3Y0p4MpgCo09YqjGL10Aqsxi/Fy4AjEs1A3kkVy3F7j09wJvOrx4StWMkwULtusn1+SAY+xf0QezQRn5n97Vc2YpFAZ0yeUehYolirlMdOtNnlcetfseJVWCi74soUpEUINf3BvipC8AGK8rleC4fdzf63lUJHB9VtdA5J+Y4inI22ejwkDfiYY0y+4DUaQYZ1Kwz5xIzR4kXKcRAJTKLwjQwhYn+GfHujTaarNWDeu2k424//XL5Si3i3mMYGDIQEthIdMT13JcJ8aI8fs4bmjKiLMvSQyGjNVM74cOI2Yn5egrJvgR7mWgIs/XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWADJeBreeBunj0hlHhfqszrTr+R3FhkgAt10DGS4c8=;
 b=mBk/Mjo0nZxs2gjEp4unWD6wj07i6Zs9cezQ0zx9VM0SIasVqatdUoQn4tVpLENPiIJ0vwQJJ6CWEyMW9cEbPUOo5VRf4Xi+9IITIwVANbm+3uk7h3U4q25Mu+ggHR/Zf5ERnG5kj8mM6lQtj8WDUfNDZC9ad8H8GgN39W6W7+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by SJ0PR14MB5370.namprd14.prod.outlook.com (2603:10b6:a03:429::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 11:31:55 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 11:31:54 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-2-chopps@chopps.org>
 <20231112095705.GG705326@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next 1/8] iptfs: config: add CONFIG_XFRM_IPTFS
Date: Sun, 12 Nov 2023 06:29:44 -0500
In-reply-to: <20231112095705.GG705326@kernel.org>
Message-ID: <m27cmn5hsn.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:610:77::33) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|SJ0PR14MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e9ae9c-1ec2-4c76-f7f6-08dbe372f864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ydsfDB91dtSGluTzUMEwCMVVllVNEPYJzArLbIKO8Q/MujNeDahPIFpTF0omX9yXROnDqmW27+LFnBDKFdx4TGWnNkRwbjCou+c2HisS3VF26OgjjJLSxQ9qseNsi8HOXDGmA1utkWmH9qeKTF5Vv614ZjLdI+cVbN8DWJ21mhStLrIFBseo7c6/zOHr91aSv06vhFshFe3uvmnmnEiSfCPxK4olJKxxWJ4i+pP2WS+oNzpuLeYGcpIlbr70yp3A9uPGVwvVF5V/ozLw61QMCR/bc2oNBa/S3mszJbHNuxIYKSfQ3jZYwUMRXVY0Bkt2muHopKtfZwL1Pltn4roQYOdzsgqxuKtU/STGJvqH8zYRvQ9tgg/gG+Y55zn0HjiwbUjOEKwWKO7d1JNTpS7S4wKGaIZHUWpVDRbwlCdjOqiU+0VSUz8uN0F2PkI7+qwr5Asp+aMHx7f7vJ3xRb3vge5fpeLR6kuDMpd4Lh7EbtQ5A4+TMKm8ocIhQtfu6TRg5JnYY54xpmd5lRjpZ5hGjrdArF+gtSumkDFwoUzuBRr2YbWfwSeU8rMHGvcihSk51CtpsWQ+hsAVqQnvB+KoCcQ6qIkLbZKwpJoHLo7KzxZjNbPIh8YjfRaEr3Z4xQ3zIJvU7nIl1oHKRmUAwokDrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39830400003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(54906003)(6916009)(66946007)(66476007)(66556008)(316002)(478600001)(966005)(6486002)(6666004)(86362001)(5660300002)(38350700005)(41300700001)(2906002)(4326008)(8676002)(8936002)(26005)(107886003)(38100700002)(83380400001)(21480400003)(6512007)(9686003)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryfJPXKjhGpmu19CgGnQe8Fx72XRNLdF8GB+AxeKQr+STGt5jxL5Qn/qdVaY?=
 =?us-ascii?Q?udYOSuZ9CcPBItNIe0caL3Iq/WuqLijn5Eq8mTCfW7n0qmgqhXxUD62H/9gd?=
 =?us-ascii?Q?Zfjm/APnwAJfaQR3scHPuksLB4Ga1AvWBgVl+qCu79Ybey8MkYBbHvvFyyhW?=
 =?us-ascii?Q?AfiynNAS9ARmsIiXMP5U3kI4AEQbBf+tVUK5qzuEZSAns+mOsvyvZtiJL+QD?=
 =?us-ascii?Q?6v0U3TFxF+SINyslGe0Whk/y7s0xY7lVXqphH8G5TERSWZBYO/C7r1gAvdu/?=
 =?us-ascii?Q?hUMUJWchbtU1ld+Lk9ufK2QiYFWEqBNm9JIHebgx90miNDmkK1SPwATrpGg8?=
 =?us-ascii?Q?LCGCbVpNFb8VJQYaM+O1Myaou7d/RrCtc54wZtkUICOeIOLY5/8f1eXewTPW?=
 =?us-ascii?Q?Lf7CBn1mPtxohOuyY0VwFI0/UGthaKbdyfdVTBs/BeDiylYrm0YgaLjuG+d9?=
 =?us-ascii?Q?nvmlocLyi/wwtkiXEme4DyGjol5hjsOuiB4hiS6fr6ENWQ5JMGVFq99QvQms?=
 =?us-ascii?Q?ptJ0mm/RPJmqAwLy04f3oonQHfdCD3WhAeSUYg7VKkH9R5n7pyxvaMvo55od?=
 =?us-ascii?Q?dAHYUoxMh61M1fNmkI1clSp6EmX9O09mxrLT/2KO+63W2lB8G3Gu3tQRCxoS?=
 =?us-ascii?Q?DsCwMJhtWJsxJLsPotiRemNnUOhRdBGbtdSi3Bn2kt9DqCia2cMsj9Xgky+Y?=
 =?us-ascii?Q?OYdaD7sa+DPnAgjh51biZdtl+n3n7fOSj+m/q05hXCqiX2242uqBfDe+kVP/?=
 =?us-ascii?Q?BqHrDELmdonXX5Rk55OjPll4LnqHDwJ7Q1VM5zJhY6y+jjtfgp5fMnc6ykKC?=
 =?us-ascii?Q?6Fs3O+qJZGlkeqcD6RqDxi0D3ruaG8Q8Y7MGVJf4Akckws2GXoh5OON4uY47?=
 =?us-ascii?Q?u+X74Eg0ismh/f2+Kxil1q4OhtLHZpdSMozSMwwY3QBYzGGI1dLNV4whXyLd?=
 =?us-ascii?Q?iEkdOi0Ru4fuWFsSCzF8T8ujysOZ/IpnV2EamFC4C40oU+W+lWigDuFccXwX?=
 =?us-ascii?Q?nP5hkHMggcCXHRD0YIsHtW68h663vJxb5x/HAKCShb197Lriy+V59IZnZKXz?=
 =?us-ascii?Q?17coAEdqxxH6DfzCTke5vfoNnJD6eC0j9CS7t/bipVV6jnKzsyq6yi/PLWiq?=
 =?us-ascii?Q?/+FJNqU7JOAnTzgK3wvYz7JAmYU8/nux/uPus+4ln4lhpb/sD/9fUDnidgWQ?=
 =?us-ascii?Q?sjzklmSk7TBSoYMV6YBEyIaf7Nn2VoPzrmaA6msxIDKHLG+dWKQXjBalMpeZ?=
 =?us-ascii?Q?SUWGQu85HAvBJRu2psmGQcviRUEvST5dtamsDVW1ovBLoVnmL2omebTqkA+R?=
 =?us-ascii?Q?oAMi02xL7AyUSvYkoZWZCQ6IuQLR3/gUDJ7P1wu6ePvuGptZj06ZyqxyH+XY?=
 =?us-ascii?Q?KyT7XDVlxIK5/iiHReJX3sCU7AlcmaT93nEZPisB/316gZIWBqIjRQ/Zxi6v?=
 =?us-ascii?Q?HZktDk6Mwa+s1+rPrw1tFZdiYtJ3IyrkgAxTEzVR/bwH/BIMm1tmhWUox6k1?=
 =?us-ascii?Q?N2jQcILmysRjlmNpvyFUmKejHafvo45X8MDzWI4x9HaK+ROB189cf6tspRil?=
 =?us-ascii?Q?vLeLOB5lTG0mKCtSeu0OqpQwd0vbmFyCipXr/Ky8?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e9ae9c-1ec2-4c76-f7f6-08dbe372f864
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 11:31:53.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lsydpZ5tpdERuNj5I6CG37/Omv5cvMCvsLg3wyY8JZxbD54APrpT5dTe4T9xOUx/H/OP4EYwu043DMR4rDKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB5370

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman <horms@kernel.org> writes:

> On Fri, Nov 10, 2023 at 06:37:12AM -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>
> Hi Christian,
>
> thanks for your patchset.
> Some feedback from my side, I hope it is useful.
>
>> ---
>>  net/xfrm/Kconfig  | 9 +++++++++
>>  net/xfrm/Makefile | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
>> index 3adf31a83a79..d07852069e68 100644
>> --- a/net/xfrm/Kconfig
>> +++ b/net/xfrm/Kconfig
>> @@ -134,6 +134,15 @@ config NET_KEY_MIGRATE
>>
>>  	  If unsure, say N.
>>
>> +config XFRM_IPTFS
>> +	bool "IPsec IPTFS (RFC 9347) encapsulation support"
>> +	depends on XFRM
>> +	help
>> +	  Information on the IPTFS encapsulation can be found
>> +          in RFC 9347.
>
> nit: the indentation of the above seems inconsistent

Yes, a spaces vs tabs issue, thanks fixed.

>> +
>> +          If unsure, say N.
>> +
>>  config XFRM_ESPINTCP
>>  	bool
>>
>> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
>> index cd47f88921f5..9b870a3274a7 100644
>> --- a/net/xfrm/Makefile
>> +++ b/net/xfrm/Makefile
>> @@ -20,4 +20,5 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
>> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>
> Unfortunately, this breaks allmodconfig builds.

I've moved it to where the file is added in the last commit, thanks.

> Please ensure that each patch survives an allyesconfig and an allmodconfig
> build with W=1 set without new warnings or failures. [1].
>
> I also recommend checking that no new sparse warnings are introduced.

Ok, thanks,
Chris.

>
> [1] https://docs.kernel.org/process/maintainer-netdev.html#expected-level-of-testing


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVQt6gQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJRq8D/9pER/1YplUrypXA61SPZS0PSLwpnusxef4
99OT8D4HC1F/AhWT1ZNEwnLXCSVQzD3jUKHSbtre6bCSPGxSMFa5kFEZk3cTBKs3
dHwzBzG5/4yec8oAStWxDmOiruc2S0rE17SkRXJnPFKMZD8lng6ex9vlYIVwChqu
qmtPcFRqzVlxlmBE5BUh/EezbNNryv5ogQL/5eHswSoMsnWYgY5VTHLR9E0NPE2R
GjAQYnh9Cg65MYd5yg1OAeq+rsIpB0wcE9Wq3f1gwy0QGZkhPfG6+w7C96wWU7M8
f+IkFj63iz3GWjVnygxZRa7XFghPkIGLUsC8I4Xq47LZZ5Cr48pyyu9i69wE/xr5
PqKsqbY64BO/YL9mTXYklFkIyPJivUegn3qPNQKE1TPByogOl5iqY23RC0Oh1Eff
BVSPFejql7Q3TNdO9IgfuwVFYKq8cU2oCf2Hmi+z08RT1JjjbS7XBv21cRsU/qNf
rL25wp47fb8rDxcyaIWvcE0V5oKfxe1x+MAdU4dNp/vcxxeOvQ4agWPXdDsdatdN
+PdqE79LQFgSJUYW4g6GNFpYr7Mn+BoR4IXYUvw0F03x8qLF3wDmEGeY5sLr7lik
cRvxHqOI0PhU8dpS2XBepbT0ocYb762UgJrlDY5YadPhOf7I9zhk2kzzxqcSvFSm
mz6h71KcCg==
=XYuB
-----END PGP SIGNATURE-----

--=-=-=--

