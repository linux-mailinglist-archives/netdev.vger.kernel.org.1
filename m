Return-Path: <netdev+bounces-47265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A007F7E94D2
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402621F20CE1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 02:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77A1FB6;
	Mon, 13 Nov 2023 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="XVMtQjSf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2AC155
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 02:31:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2108.outbound.protection.outlook.com [40.107.220.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867E18B
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 18:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eikd388x32r9m8Cl8SU9RK/+lwotZxOCeI1PsjU5to+rjMco2kfbDppStFb7gfJIHup3XbUjawpkjKewlSPCPChtVw2oZkDE5rMnAVqyk3cTcXRASlQ9RLXeebmeON6jJY86Xq7bUKS4/+avLN2G9mcLMbgSco3lqlxDI9Vk7VGuhKw2Px+l9vnZtgO0ZiABrdKI67iMmN37I5goS/+0VyKgH47UhQ7zGZtJJyfWoaN37s5CWey+wAxc3UiRJ7KORSOq3inuHTvcYmwHjvzducgmEe7tT6TIpDGu7SwYYnp+ScL681HfhR42QVDZQFRI0it3VY4izlS1X/B6AazohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSUZFuGqrJDVazMEi7Rw/P+tK2IRwvWoHu5958aFrEo=;
 b=c/bzhfu1ecEfpYCuNlgSmsecNqarO0llH9DHL2qgCcodGot04gD+MBlymvYHJJlwlDfwCeHIak5XWkRIpFrSC5gHs3dSI4Y1t9oJv2yxY29nbxTELZv5SFJ61mpwJJZYmLL8uBBJnH/e8YONV0kh4prlC4R2LUo2n8GGKgqosd96ddW5SNv63CXmL/f/5O4OSn2Bl4KhSXFF/4C5kypPEvt8WYvUKovScQeEBDAi6Xd0myKYERdWNcJ9jGmsI/1Nj7DAKJKDgnOLp+68imwmH37eI8rFDIU+GF8KxzESKFDrY/J/7m3Mpfffe/PV0k6T1kHj/09nhKV/2No4ej8q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSUZFuGqrJDVazMEi7Rw/P+tK2IRwvWoHu5958aFrEo=;
 b=XVMtQjSfH1A2kHCVjC+vboBNrT0Ze884Rlk0TC7GgQm4ubgEV/YekvhkQuqIie5Q30tvUc60YmuXlMxtDqceim+Grnpbv8B1tSwo9PNolLQgh6CVtX2hYdBZtxEyzQGy+YNxk97QVxynRfxCWhoCooWYQvwkO3vzFb0DrfwzgPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by CY5PR14MB5653.namprd14.prod.outlook.com (2603:10b6:930:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 02:31:41 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::72bc:7cd2:adb5:be40%7]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 02:31:40 +0000
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-2-chopps@chopps.org>
 <ZVEsLPhykZId7Opz@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 1/8] iptfs: config: add
 CONFIG_XFRM_IPTFS
Date: Sun, 12 Nov 2023 21:31:17 -0500
In-reply-to: <ZVEsLPhykZId7Opz@Antony2201.local>
Message-ID: <m2jzqm8jud.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::29) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|CY5PR14MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c8e385-eec2-4097-35bb-08dbe3f0aad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pyFeaXn+YnI6XoH64wwdcPiIkitK554hcVAn0gFJU+KWrhCZkVhVe2AIALLK9Q3d1moHYZOk20j+rSi33jfAVxpcNjuFjzLjLWlmGTHHXA6jCLs7NnkJxa2SnR3yX/B3HG36Lx4MFKeooIoWRTy5ogMmvptNMlUU/yGx5OsnTs0O9nYopsPKpVLAe+DX3+regugeJ2Cpo0bxzWrGsXQhu04IQ+ZnNvexOyiMSP3RMwMx2GUFY56udFmJfOKPFY+G7j0EWgsfM9RCxh5F0R6VVre2UqVVoia2COx/gLX5Tiw+UuGH1voWYQHR1O4RItwPLQ0uNXOTBLxOj6Tf/iWABXq/CdPGOUlYl9/J19zF7FerwP8XjHFn6Pl77kEMc344N3Vl1hqemTiwxuwINhsQBUdWCKF8WNkEcAzRpjAma6+FR14UrCG6HrIfmJ0aJ8y1y7EZEr3h+kvUc2HE4UsqdlxmhL0KoD/YiZGSnO4ps4lJingQ4FgHK5bwKi+hhFj0zX1JxNpP61B4DC+XJ6GeuqGHPnx7VyiBpGsjjzb5F7fC2zRvFINP+prKgnmqNyFsRz1mqo6gns21+6hnsoFNaN2UbuSu8lTROzUSirSj4DA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(107886003)(26005)(21480400003)(6506007)(52116002)(6666004)(6512007)(9686003)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(966005)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZtyuLzhkT8fhBRmc6Gk22vSNyjYJ6KZjQI3XHs4xUzj6fgPelp4zdBoG8ug?=
 =?us-ascii?Q?Xa9eqE1uQwW6ThqHoHkhvGdxbCxdMjMMyR7WC78X2JvrUISlrOEzpb9/uTCG?=
 =?us-ascii?Q?hJ3059XuhBhk6hOIPs13t+dNm3+ZSwNPsAeU/D3Fi6xVu3prKX0CtaStZAfA?=
 =?us-ascii?Q?ah30je5TDzb8UQgGm+g3I0CKkYpSluNYuXA6viyLwtiiV9Pi3HIMdu7wkC7n?=
 =?us-ascii?Q?L81BctdHrLXfPXz7yi/1TWs7F2N6d7RJEtaCA4PHvH1aoqQRb73noMpOuP2N?=
 =?us-ascii?Q?Kt5R/xWsx5DEC+1chGSjmKnmmZIfuyAqjPWalZ/Xv+cmC682XBTKGC1/fgYF?=
 =?us-ascii?Q?EIOwecpBt44JpmnxpTyyTBSxFE3fN06NYoJH1JvCyNfWaxEOxttGrPCAJCLE?=
 =?us-ascii?Q?/XBKSY3FGkdYGzCwlBQF9RxHr1LJLdSrZJJsHF7udwTOUQ4VsVAH36AUEM3E?=
 =?us-ascii?Q?VwmtMuFCpVABap9HG1MMmymkpPGRZ9xhOMig7yh0z6UBkzIF6bvHlRmflrSd?=
 =?us-ascii?Q?FysKEMRR332hfAk4vY0rh0pcs4qNkco0/noLypRoTvgkHoMVia46BMJNsA+2?=
 =?us-ascii?Q?+m+Xy6ekrynneiGH8jDw3JYVuwOy2FflXOFfupbcq6vTwxPCAS1aTej3EePx?=
 =?us-ascii?Q?7sHgKv0mibS0Kt9qQNswVyvJ+ku3qX2dlc4zeM6WMrBM6dWRzAFqxqyj4cWc?=
 =?us-ascii?Q?L+Y5YB33cK6uaR5Kzp9u8afnEV130XcbxT2pYCKbxrGYpFc4SYGuW5dlLGad?=
 =?us-ascii?Q?QfxtQZpjH/gOXqvj5zH0mUu1BA+KcGv543So5NvqI0h7FlbSmLYkNpZD1EV7?=
 =?us-ascii?Q?ixJyzTAhJAfQo2aGz0sRjkna0hx243nX0DZffgIC/LTbq0q2n0ghUBeoNUOB?=
 =?us-ascii?Q?sUFNOEF5FPLtpyn2oEtG4buJEmiw7ZcV/Hp0cRXO7PbKQ4azopBqPZnNEdH+?=
 =?us-ascii?Q?qL1EaxWDutrPwJR32gqy5182HxelWlezcWNB+/NQTWP0o3e6pScADVGeL+Nn?=
 =?us-ascii?Q?SQCE695ez17iOsqQ0oMiO+2f3NS4zLPPF6ZTindLhjg6QhjZPeUSddhdbqj8?=
 =?us-ascii?Q?Auxy0+VojeznQ6a0I55QYLMy1EGQ5dsc+bHeCQHkCoxDeeABV+3oUqSqEmd2?=
 =?us-ascii?Q?fgovofapfr3i5vthdJmVWYbLiSs+9/BUdSp4rHZOs3Z6lpyzCBP8VRyRLf1A?=
 =?us-ascii?Q?30PCcjQOg2HiRDXM152nDLguWmBYHLYmW+aQFxJm/91IN7fz95xm+A6xWMFb?=
 =?us-ascii?Q?4lCRRRkY+1375PkNYv4KtemNYLhDIjiVe0OLzPCvXLR8hjo4BfyVFIcocQNC?=
 =?us-ascii?Q?ejoTi0Rcpku2yDLCz9tf01/KpDua0IiSIHtfyE+N4M2CwqmWkwENNfrxrW8J?=
 =?us-ascii?Q?WSkguEvrzAYz9lKtymoIov67oWBOn6KfRCIDb13OeHkbxeDQd9pWIc7UTmS6?=
 =?us-ascii?Q?uqYgzRuYDApEYG7bHN+LYoJ+rQT5dsJQpNY12XUKaIyGPENr+3eK5BXMqNj/?=
 =?us-ascii?Q?hZIdv8HaVU7xTfrv/MhV7HBJS+vkktUGLlZr5AQbNJizpIfV9T8UqhZ+6ufh?=
 =?us-ascii?Q?9i8b5uR9OXh3Bve1jpdCNpL9lIAnzuxAsuwIveLA?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c8e385-eec2-4097-35bb-08dbe3f0aad4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:31:40.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSf0s0ax8rbw1uSaSe4B+4tkxLkXhQrDPAtQBRs5CtIdrozVBNcHMcHqiwQVGnSikTQjtk9pjI0Vf/fEw/ePjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR14MB5653

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony <antony@phenome.org> writes:

> On Fri, Nov 10, 2023 at 06:37:12AM -0500, Christian Hopps via Devel wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
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
>
> RFC use "IP-TFS"?  in the text use consistanly.

Ok.

>> +	depends on XFRM
>> +	help
>> +	  Information on the IPTFS encapsulation can be found
>> +          in RFC 9347.
>
> Add details what is actually supported when enabling this options. RFC 9347
> has several combinations. Are all combinations supported?

Done.

Thanks,
Chris.

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

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVRiooQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJVTKD/9CNB0Hl2nkFhoJvLSZWYB88185aKAe9J5A
j6TcyeHmoBQ8aEiMphP2ATnvYlzkMVhn3t1RNpm4XMgTvLNKIhJmC/GuPqjJ5Mo+
nLe8d7jXB/m3oWXxUAshXUEj1EcfhyPaqhuCzSkuK0+h1jXMaM+SpjoJH+MD96yW
LAWiM9do1nQtT743SH1ZC0FZR1hZN9KaliNQQMIgenJ8lZo19VFfpIEM5UibtA/4
rSBCE2IofPm7KoHOr8JJqm9jzPZCnkVAwu3zpSCcYMQoUOnfOlr9ElG7FGb6sd3r
x2NJkb/b1dqyBFwKJjNL13yE5KEZY2/eSTE5RuQOfgmgG0jKpKV2Z+GCl5CmG0ub
0CFrjx6cMTMwfRalC1uXwXb5c+zxLXVDlmoTRLxd6/l6y/YfljnSts6n6iCSku7s
uLXaRo3XdVnsmrUPx6MUmKw4E7mwKKaF72VFxpAw8iFrLKTy/ddMpVVIMpj/mqtC
fjZ9yJHvsrJVnJMmID6gLFiJ6IHAd7s4pfc2tdrJiQLWfL9vq35YKErotPOPuZ9d
FwV5aoJLnT20+fwq7dzX1dYxhSDvjs/vWeddL6qt45WNNARDF/HljeMuT36veyS1
R3UZkpAY8JswDCfMHRXKgoO7EL46qIjOKjX+UqtIUe9INrHwU2kkLfWEVNiRk0Li
PXJXk0wyOQ==
=o/WZ
-----END PGP SIGNATURE-----

--=-=-=--

