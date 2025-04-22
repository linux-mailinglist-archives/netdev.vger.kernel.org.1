Return-Path: <netdev+bounces-184697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08825A96F01
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B84216B2BA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FC25EF9C;
	Tue, 22 Apr 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="jkr4Tisv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF355FB95
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332418; cv=fail; b=fXgVe9CY2u+hnuXyCcYCC0GbMLRLuERqvuPkiTYWIgsYStNMdK2godcWvefn+lI1h3g4KSoL9l3nNYhDZZZruKM2hJE5aXbtkPDvf48uvAsTP+i0huCf94PV2vjDNjbADQ0NomWEMIej5MbUpXKl/ZKltR8+G4lW/TXRBQG2cSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332418; c=relaxed/simple;
	bh=0chFxYrJKcIsprUfpxwCt9HXhL9Y3fpjfm/McJ/8k2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VCBSIk153wyb3EA0KQNh+DMrkLk5bV1J6KzTIQMTL+/AEWrGLfUg3Mn4pPi6au2C+IPNAtFVdKfGhyeeIp6hC+fjAf8dCRcVbN1fgKOtgCVqiChj6QK3xOGDNEIc1ZqUNndMHxrpYvulDD8jL7SvMgldPsE/9xLsC8S/gWLOQQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=jkr4Tisv; arc=fail smtp.client-ip=40.107.223.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S69/OhBujgsD5tnDg4clf3sQrw0fyKWZa7K2CwRpu+I6e4Qaiw1p50nzuhAwqZ5jADk0t0CYELhdicCvbnyHGejQQH8W0GczR36dd1Tp4Ei55f5++0GiVFyxKU2a2M5msiv2pe0g+uVV4FLypgB45Gx7PT/+Q9i8wGIYDA8BAgnywI7RXezDi8cniBD+7nECwQGmOSUbQWUe+efpOp2kwFvRBy8RuPrGuLoI8K+itni6RpadAIeTZgYTu/BtoHqpwD/HM3Zm5maU0+uykQ3drUQHMMafsgDnWnl2i5S8aUb/LiegNUMyNohra8v3o7+AMVYsmJL++MllpMkn/1FdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91qL6Oe4p46Ti/1XHRQK4H6kqohRdGJlYQb7x/bEcas=;
 b=GWMFQE2OtaN+J7Tumhk3odWbo5SEBI0J5F3Zez78N1w7NhIk+oytFDdrb5a3WI0OCcB1BnQ0uMOf1pn+D9Kfdstyct6g5ybmBd6N7ZC6TPt/4AKjcSBILrUhH1UlN/6Bxff2UjyiCNdEQXQSfuhwBS4aLVsEjhMRv8Rpu4kknj9fwTQKj08CfsV/vNKY99cGofrhwMnQefigsVKU/9Z0ywir1cp35I3esUo6swlQ+EZeimwXz6Fhefyk5yf7wL0i9rkSV84xlNbHU51lmHTfpCj5QZzM0XstSarAKhtUDuXAQFRNb8OPzaAtyvglOFo0OdTSiAuN7Kf/APFATGJJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91qL6Oe4p46Ti/1XHRQK4H6kqohRdGJlYQb7x/bEcas=;
 b=jkr4TisvlklQe9mtUvmC6jTBR0UNkGVErVicQUmZtZNBs1JNwDAuFqP0ECypy85TXiVc4ppqQjXkJQ0bXcgpWd0OQY72tm8slTd7lbZSQpSxbdPnqUIqMd3DGC+uLIwJjNWLoPmQ3q7ijvUKNo9kOGmgeb8xA7bTYa/G1zxd5l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH0PR13MB5139.namprd13.prod.outlook.com (2603:10b6:610:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 14:33:32 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%4]) with mapi id 15.20.8632.030; Tue, 22 Apr 2025
 14:33:31 +0000
Date: Tue, 22 Apr 2025 16:33:21 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: Change FW message timeout
 warning
Message-ID: <aAeosU3V02vWxD7Z@LouisNoVo>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
 <20250417172448.1206107-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417172448.1206107-2-michael.chan@broadcom.com>
X-ClientProxiedBy: JN3P275CA0137.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ce::8)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH0PR13MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4c7102-8e96-4e84-5b98-08dd81aaa7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/zlUa1HS2tUoIBIUI5Mw8DN5fD1QB08xKZseoo02l+5vuNiFMImqOtLMvEC?=
 =?us-ascii?Q?Yp+E2kw6PMk6lzb1FLLAK5ccNqfGXuZoD9jKQV4WfFqfnrYtwzyH6eAIFhw6?=
 =?us-ascii?Q?PQdUYrUZwiPj8TK/kfFhGzX/C0PmZ/46twgneoBuo6/L42G14/0aKWXCnDse?=
 =?us-ascii?Q?blzL+HG2mbwib3emg5mrCvguw2dlDoBhLjUXfuXL1SKQHAFzBxwaES0GlLCB?=
 =?us-ascii?Q?J3q7bZ1hQ7rYcwrvTiQDFyMee9soKfkFcB/SqzMq/3Si+4ThgwjudX6pvKFZ?=
 =?us-ascii?Q?5t+3a3bpALc8tCgRtgAOtN/RT6z6uwdelIz+DTWZGyQzmmvG9M5IfxzNun6m?=
 =?us-ascii?Q?2qUEpQ0U88vx/61f6d1QOPDxK4GzMhYzlCc67DmOo2zvwwhNvRaHB7cBzsnw?=
 =?us-ascii?Q?t8y+yFXY+QFuq+2j1uzi5ehdNNipHlo1GBliIsEqgr55do6CODv4o49OEVHC?=
 =?us-ascii?Q?sjRvmjN4b6Qb9gHLxcocBgjyFLxiPJpMz6L6ReZ7jEHjRd4zaf8Sq6S5pW6b?=
 =?us-ascii?Q?ROwc6uY+iJX+I+4IFvidiZTTviyrdD6lDz6Kp8r/xuKHxYT1i9wu+F0KMS78?=
 =?us-ascii?Q?+zezlu3x0I0JHqI2Ia1G5H1rXKYSrUxQOU5WaxIw84I9wU21DCDwIMd6mNT7?=
 =?us-ascii?Q?Yr/h9pPXXXz0udVqOPKyK0RcqIdM89AMcWB7dc/q1upx4/S/31L5qZJ+Y5aa?=
 =?us-ascii?Q?iyeFNIx3H5dExghKf+BOA3EsrNtXe9CwUoIbFsIu1myulGpY5Z7MaGqSpWga?=
 =?us-ascii?Q?V2MbVorHjJ8VvtnXN+VpDLCPijImQMfmVuFaJGil0d6ftmdpBi5pmtPE5FOh?=
 =?us-ascii?Q?vJCgDA+sYJxQrVwrLLuI+wp1+UFB0rlyxSoDRbZtYB+kPYYd3mpQSlEtk9i7?=
 =?us-ascii?Q?HO9JoEYaEem5hfwGhhRNCG9ZgYRTQ+DD49fSLIU4tByN5/0xkzg+1tlaFnFo?=
 =?us-ascii?Q?N0NNTKyDOSDIoM5pM4rhf7GEFf7QKCW7TlSQH1FoSQ90QOqTtPs9DI2vEKhY?=
 =?us-ascii?Q?0TXQBHCULqge/plqFMYY+/PvvmC2Tctxobgv4KMTqI/2/Opz2a/ezEro3Niq?=
 =?us-ascii?Q?0UdzcDTqici+6a/N5x9+cxCBP5fguouR2zUYafw2WgTq3b6jwxy+cSoPikgc?=
 =?us-ascii?Q?aPlgY0qc3Ua8KDVjw/e/KmUQ8HMaDqBD9hQpsjkn5sRHFVwxs5co/7Po+uGC?=
 =?us-ascii?Q?WioofpwHKFBRdoZiYBlC0wXFqy/B2PclAhoustjhIJ0+btSWyp7245D2pyb5?=
 =?us-ascii?Q?7BeaJeDBKqUjZy9+rWp7xn9R3NQCtYuZ9LreOEKPKXmLdEAVGacq+ekqmAT7?=
 =?us-ascii?Q?9sJUv1kejK87xqN7hYrq4Sl/AILCzLPV9PVd94TQzcsaDz8/QtmkMmZ7OD0B?=
 =?us-ascii?Q?cKvLIOHhZSItkfHusyd/TtecmGQ6EoNjRn1k+65DFElaUgwsBdjBxVcwZsmE?=
 =?us-ascii?Q?fU1hQub5ESc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhjiEkUZwYSMAxhVy83UUhQzhqaKjrrRDZWIBK4nqPaduFvo4zQXw3Sulw3F?=
 =?us-ascii?Q?ZdyZuNYHK47wXhDOFz1makvzgo/yvqXXKABRfWQapT0habM77vUuoTJZO7y2?=
 =?us-ascii?Q?DL9OW+Lg1v+GlxFo97BC+KXyQhDJZYdOOWAkrvROQJc2CumP+wy1ZXDSP9ai?=
 =?us-ascii?Q?V9gG7wGbhdhSAtbebyWqbvNK06YRYyeB8/DbmwSHnrCiunIJ66ru0tT08O8m?=
 =?us-ascii?Q?HUqTSypiZVUxzbKxTFsRbK3czwfcuS7U+GQ2YE9U4HxtlGnXa3OwrsWG/y45?=
 =?us-ascii?Q?GF7kFYxqU8m58+ulW42afDeHjW30sv3wRfQI64FBd+bIqSNXT73x4MHIVYYE?=
 =?us-ascii?Q?4Q5lqMKgQDke9/SJqengWbVTEFZePGp33X+xz8BBJNLuLCPYh5yYtbQP4G2f?=
 =?us-ascii?Q?qUp62RzXKE0F5Ko4NMGU0q3p7ZsGo1hUlT04mUk3ghzEVd/IZ57SUP4xEeQG?=
 =?us-ascii?Q?D1aonjdjm+f7Mv8oYJSHIR/dpgMcCYpreObYLCzQ/adAn+4NWXlEitsFEM7x?=
 =?us-ascii?Q?z8P0CqGWH3ZRW8K391mZO7hWaDTkOj8Bww6eeA3hL62xWdFnAX3gfcbJRRh3?=
 =?us-ascii?Q?lht1xZNGqRLUsaPKlbZjcvFcyqrUMv2tn/fmJ5b7V+pjYmlfXYVEp2WYMB45?=
 =?us-ascii?Q?CsE5UGraityWjQCRN0aPShY7JcUnpCwONXyh8R/HA5wCKDVogXp4/9TKUVQH?=
 =?us-ascii?Q?Y5IeYmOzihqk1rmSrbQKtzKB6wHtXaLsMt3MyvdCxdmOuU2R0fMT1LGWDW6r?=
 =?us-ascii?Q?g0Np+bVdhzAjN5I0ggiQLCYs1Z40qQB0i2kOiNVHGRSkhVSqi4FHC4x3zkK1?=
 =?us-ascii?Q?ZRKyd/whRuf8vHgJn0hwp/HIn+fk2je/D6/9AcVzNbDFcF72REJgi8hRyCsw?=
 =?us-ascii?Q?cx0vvgqSOYluX8Ea1k0hSDWLvkUMkMXFFBiVB6m4ypBvjdJn5X8bNn0wfMpK?=
 =?us-ascii?Q?hkDWwWXKVd3FZ5GbVrAmYRNPIlckc/1RqBOtYpfWg41qgSUHDpLpSebOaIsH?=
 =?us-ascii?Q?B37sK06RVSnu/12vu44mMFgkkYHWL6ILFeB3w/0qeZpI5gGQEln0uRM9sqP+?=
 =?us-ascii?Q?lIr8bjyTJe6/iMTSkIEnMtAGsr5DkGRbw013pmtNPq4y3MQjLLpIRFhllh76?=
 =?us-ascii?Q?ktFnnbxnwe2+FT39n+nFszniVEF4uLaU6E03Xu2g9uQ9e2z330LI55t296Ik?=
 =?us-ascii?Q?tLeRzJc8a+y5hwkf7CXkFDCDQD0G0C92jr7pdmpBUHd7i8oqCmrVxP8NNHTS?=
 =?us-ascii?Q?CDbhcnbzF+1lxP5CanIkKY9Yxt8z8BxFHsUuMLMbe2qbg582izc0liW6Autk?=
 =?us-ascii?Q?4qb9uX9zNFd7V+ceOLP9viiqgOCHEut2ScTcfY461AiTUUVn6zXDM4I49d5+?=
 =?us-ascii?Q?VFlinKflD6umPDMV+++fDL+1XVA3FirXnPoF+1yTf0Kw31U/HudFsP2ZUw8h?=
 =?us-ascii?Q?R5UZPLTn90czvHZFXSAzt8gSbl13yR+tBzrtYzds93Zd9VSSNvNN0P4RMyJv?=
 =?us-ascii?Q?0cBey1HRfbAvZvJ+E0qaKJvTgPretLtLoR1COoL2CmI9oubhUpfjMpslylPr?=
 =?us-ascii?Q?cki5xQrJaRWRk+4m7kWmi20I/OYUyONF1rCh4NmPPCoFeFAINuqN/4xzIEOc?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4c7102-8e96-4e84-5b98-08dd81aaa7b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:33:31.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t01+A7LFOEz5oLUe05tB/3xWynbpMB09akVv6em2A2SZwwdDQKqAk1nMi9jmiJGFnDp3Z6QYOr6yECatufRYLsHYpv7dGSoe4Bq/jyy9lDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5139

On Thu, Apr 17, 2025 at 10:24:45AM -0700, Michael Chan wrote:
> The firmware advertises a "hwrm_cmd_max_timeout" value to the driver
> for NVRAM and coredump related functions that can take tens of seconds
> to complete.  The driver polls for the operation to complete under
> mutex and may trigger hung task watchdog warning if the wait is too long.
> To warn the user about this, the driver currently prints a warning if
> this advertised value exceeds 40 seconds:
> 
> Device requests max timeout of %d seconds, may trigger hung task watchdog
> 
> Initially, we chose 40 seconds, well below the kernel's default
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT (120 seconds) to avoid triggering
> the hung task watchdog.  But 60 seconds is the timeout on most
> production FW and cannot be reduced further.  Change the driver's warning
> threshold to 60 seconds to avoid triggering this warning on all
> production devices.  We also print the warning if the value exceeds
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT which may be set to architecture
> specific defaults as low as 10 seconds.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Add check for CONFIG_DEFAULT_HUNG_TASK_TIMEOUT

Hi. Sorry if this is noise - but I have not seen this reported yet. I
think this change introduced a config dependency on 'DEBUG_KERNEL'. As far as I
track the dependency chain:

    DEFAULT_HUNG_TASK_TIMEOUT -> DETECT_HUNG_TASK -> DEBUG_KERNEL.

I have a 'local_defconfig' file which I'm regularly using for compiles,
and I had to add all three these CONFIG settings to it to be able to
compile again, otherwise I encounter this issue:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: \
error: 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT' undeclared (first use in this function)
      max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Perhaps this was on purpose, but from what I can tell on a quick scan I don't
think it was.

Regards
Louis
> 
> v1: https://lore.kernel.org/netdev/20250415174818.1088646-2-michael.chan@broadcom.com/
> ---

> -- 
> 2.30.1
> 
> 

