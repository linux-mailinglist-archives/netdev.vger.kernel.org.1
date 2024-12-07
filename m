Return-Path: <netdev+bounces-149926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7B9E828A
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 23:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F1C188492F
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE414D2A0;
	Sat,  7 Dec 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="X1dclN2d"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC476034
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733611492; cv=fail; b=k1OZ1U/ZkGdqWsi2TGK3A+kR6UpmTFJnFEHBWx0YW1Fhl3MT+2JMwQgYmrK5Pmzc6d5PhbkY7RYRVUyiv0U9yz5/H2vGFusBzrKcDUaQCsIMDjjreAD81jfm2VE/guFQuaIArfPFWkJ3ZsFufyqf61HBBFYSGZtRQkr5iFNcsLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733611492; c=relaxed/simple;
	bh=gvZ34F/IubJgus9Rjvn5OieT5hxXYuodkmoYpxHqpmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAn70SEUahWQvgtzWcmODUxd8iW0eKU1qzy8GpGtjc+gmMQsQgTSUFocWhLljrqWP17ceRzAvr3p8Uce4+7JEqqdufzElEYcK5Dt6UPPuWtaUQ1OgnLWfjk/JJ8Wq0zzhSC++P9Fn13stT7NL4YYVSsjug+cM2X1BP9zFPJ8O48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=X1dclN2d; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk5TNSrsaP+Bx7a7EVyO+6xMPHklJ93WkuMzL75YcSwWphKke6kllhTu9ommjamTeAa0hM4pPQORMy0PJJ7nbeXzegyiL3AzArcM4hE+lrZJAvRMhpu2SLc6bBoBXd4la6W8rOZGAL6LMTcSelrQ0NhzfOAx9VEY52sGgzahXr548JVCDb06Sz8zyCVTBU2Nu+45E58NYV+68g8kK5z/VEgCtkGyYygutvfmhS0baAkOVUY6ju10rE37YQix//EWM2o1wIePbNvCchuBL2gFeH3azePXHst0cZZE1Onxml6Hkpd6XWOOFoHOhl+s7j4UsCVUXNGgNSe4HKZBotiDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlArsTuCRpjNPHiYqPfighrZfKVj1LiLG7vJmZDxDSE=;
 b=AHZ16jF10yaCjj52p20OfmiW8+1sQE+LVfJfCJhvaW6U6MTBd9/iSlL7o/DWyPg1FequppXfEDqyTrfo1MGzP5230JH3+5nqgTRew2RzUa4YJGRf1td/XE75MYQriDyAtTzKgHbz4QsnNp2YvtQl5c27xx0Kemx3doTJVB1nOdaeoH2irL3jbR15GO8vOYoAkvDs/i7OOYnWCsKy2Ln97u7oYsqGTY2L7tpnvTh5fDOBi7LM5Kr2KO3xEdoZnU3W6OQgbzUT1inCHhrspUfsuzWDoJyxgDjPvs6nv5QA/NjrAIGWwHGxI55UVgCyoRUB/TOZWHgR9YntBSfZ/WN7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=lunn.ch smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlArsTuCRpjNPHiYqPfighrZfKVj1LiLG7vJmZDxDSE=;
 b=X1dclN2dKdDCB8ueiChWI9lI1PAAT7/2l1k86Lax9+d7ts8C5JL2uGMhBLlUxdziasr3UOYdVBOEvbCbNdgeEbBTpZXk0FiWLPLUL910JmS6fdo9LaW2cids4Fv/fYUiEM6OcD9iIqyaJv1tk1r0BtqzrwY5dG7S8eFlbpli0ak=
Received: from PAZP264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::18)
 by AS8PR07MB9494.eurprd07.prod.outlook.com (2603:10a6:20b:631::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 22:44:42 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::64) by PAZP264CA0245.outlook.office365.com
 (2603:10a6:102:239::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sat,
 7 Dec 2024 22:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Sat, 7 Dec 2024 22:44:42 +0000
Received: from n9w6sw14.localnet (192.168.54.15) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 7 Dec
 2024 23:44:41 +0100
From: Christian Eggers <ceggers@arri.de>
To: Andrew Lunn <andrew@lunn.ch>, =?ISO-8859-1?Q?J=F6rg?= Sommer
	<joerg@jo-so.de>
CC: <netdev@vger.kernel.org>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Date: Sat, 7 Dec 2024 23:44:41 +0100
Message-ID: <7080052.9J7NaK4W3v@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
 <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AS8PR07MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5f3462-dd8b-4584-92d3-08dd1710bd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5PJ8rqEf4NS0qjfo0E1J6ypMLgunjqN2l1XNgCLEAvrB6yk3LDNnYK9vKu?=
 =?iso-8859-1?Q?nch0AI00UTiSA19gfzzp+hAC3fCCkVh3oz9ssNUy1ItMteAvfknJ/ChQrc?=
 =?iso-8859-1?Q?2xsd98BfYmmKqWZRHtB6LmLPNRcgQAyEdu4ZDTAFumppD7dzNQt6muKAEO?=
 =?iso-8859-1?Q?uETDqRJFKxnEbY/uSlFS9uRzdHSKx6pGf/aPf4YOPYdtt2t81e8mnFBusx?=
 =?iso-8859-1?Q?9EJyDM3thUm4Y0YQSeSw57hi1ZNKaqYMZZ4H2Bfgr9VBtYt+9GSONCvXmO?=
 =?iso-8859-1?Q?22KSVlQWaGlpnggyiT/sza/jNlzOWeoBzffNpxtOv4OU7rFL1sgrJPo+pP?=
 =?iso-8859-1?Q?g2L7gFj1MFwrPO3pQi10iAuDvxxT5h7h6nXQztX9zLEv0xeGwd47uXB73J?=
 =?iso-8859-1?Q?dbRECXLXw9UF6vxjFMq2j/4YHD/WWXc6XTsKPjYkIzxmSRXyerUu+i2urs?=
 =?iso-8859-1?Q?jX9n2YxqP2oGGcS+aiIvPcfxK78OgtQ/7rFJdFMjSiHUa330y+qI4zF0gK?=
 =?iso-8859-1?Q?jwxhqJhJlvkTblgQ5a8vqKBfygRUxwEe+4axnVtcpSAa6iBNUCdwxcTPob?=
 =?iso-8859-1?Q?YC0b/tYjYwxLCWMOKrRmlAOUwsEb+J+czTC9aslisZcpAT2QhoNZFv4qkw?=
 =?iso-8859-1?Q?z9vBsAm0np23NL7Nr7W7qeKR/hPhBJVVF0MhQwo3W+gH0d+pOa4IHtMzKK?=
 =?iso-8859-1?Q?HATy59DeXRpj8MJSIY86B44lhBP5O4Zod+Kn67cS+sbZ/JEqHdLwbA4vcV?=
 =?iso-8859-1?Q?AoXa+1pHBtbESynFO8gvLmSwEQSeclD1hIf1wrqH4PbP6JIUfEpPV+aNkJ?=
 =?iso-8859-1?Q?xzebbyjbxiR+TfAXXii57OTOcp+WUe6UYEXfYJ1a42qbEYk+S1d7QfZyVv?=
 =?iso-8859-1?Q?HUKHOeUB1CdC9O9+4/PuPPR2BAXKsW87TVO+vMIpMkZsoDDQdiH0OO6t8T?=
 =?iso-8859-1?Q?ciaBrMU12p8DWz6JZVuCjh2x8vSSGtw5H0UhrtzoSujSmoPYpU2SNfEP5V?=
 =?iso-8859-1?Q?NNHkYwYmNy/SSTd8jwUGn4yNLx1zuQxifUrWERaKTTqFGPWamJnyTr1/Zb?=
 =?iso-8859-1?Q?fhPmIGhkJZDH6gvE3Fhh1NuUbvmTbSDvpihRSPH+X0wm4i1MXxEa6Fs0aN?=
 =?iso-8859-1?Q?0qkgPsVLJuntqCcEl9t9kk8Y30KI+XiabB5z3iBxc0C+idEfXE97rPitVK?=
 =?iso-8859-1?Q?4MyPJkskSNglOGK9OaFW9O8kGdX/L8HM2mocyeMcbVEIVUJoqRhJ7x9yLq?=
 =?iso-8859-1?Q?KGMLviWAOmIIAMV/TZH0aO50ugwLLIgJSamtmH35tJUtuM7M8uwzoz8xbM?=
 =?iso-8859-1?Q?dKMSBRiVAkrQzhZcV/pmAVpG6G+0le9dxNFSgC0NM2nQ6Xmql3aeO4rm1O?=
 =?iso-8859-1?Q?aDRMugyLxY71vmzouTKqaBXFd/RE7dJx5/A+MJstBIiYwAEmHVtC1lBS4W?=
 =?iso-8859-1?Q?P+FsWnR5onQ8INWr0cR8+CS2rnHEjcyZ0bfGDLSNsBlz0/1dFFUzvJFA63?=
 =?iso-8859-1?Q?bOTDW+68lioz35o/ubFWn9?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 22:44:42.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5f3462-dd8b-4584-92d3-08dd1710bd92
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9494

Hi J=F6rg, hi Andrew,

On Saturday, 7 December 2024, 21:47:31 CET, Andrew Lunn wrote:
> What i don't understand from your description is why:
>=20
> > +       /* setup spi */
> > +       spi->mode =3D SPI_MODE_3;
> > +       ret =3D spi_setup(spi);
> > +       if (ret)
> > +               return ret;
> > +
>=20
> is causing this issue. Is spi_setup() failing?

On Saturday, 7 December 2024, 22:07:23 CET, J=F6rg Sommer wrote:

> I've added another dev_err() after the spi_setup:
>=20
> [    1.680516] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_se=
tup=3D0
> [    1.819194] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-22#

It doesn't look so.

@J=F6rg. You didn't explicitly mention which kernel version you are trying =
to run.
But from the line numbers in you log I guess at could be 5.11 or similar.

I guess that the 2nd return code (-22) originates from ksz8795_switch_regis=
ter()
which in turn calls ksz_switch_register() [ksz_common.c]. Maybe the -EINVAL=
 comes from=20
line 414:

    if (dev->dev_ops->detect(dev))
        return -EINVAL;

But this is only a guess. Can you please add further debug messages in ksz_=
switch_register()
in order to track down were the -EINVAL actually comes from? Maybe it's one=
 of the
error returns from ksz8795_register_switch().

My original intention for the mentioned patch presumably was, that always S=
PI mode 3
should be configured for this switch (as stated in the data sheet). But may=
be this
isn't true for your setup (do you have an inverter in your SPI clock line)?=
=20


> Andrew Lunn schrieb am Sa 07. Dez, 21:47 (+0100):
> >=20
> > What i don't understand from your description is why:
> >=20
> > > +       /* setup spi */
> > > +       spi->mode =3D SPI_MODE_3;
> > > +       ret =3D spi_setup(spi);
> > > +       if (ret)
> > > +               return ret;
> > > +
> >=20
> > is causing this issue. Is spi_setup() failing?

Maybe that the configured SPI mode does somehow not work for J=F6rg's setup.
Perhaps SPI mode 3 on his controller is not the same as for my one (NXP i.M=
X6).
This could then cause a mismatch when reading the chip id in ksz8795_switch=
_detect().

@J=F6rg: Can you please check this? If possible, a measurement of the SPI l=
ines (with
an oscilloscope or logic analyzer) would be interesting.

regards,
Christian



