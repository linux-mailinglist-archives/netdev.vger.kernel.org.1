Return-Path: <netdev+bounces-220795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E6B48BED
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493771610EA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFB2253F2;
	Mon,  8 Sep 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fEWqMF7p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDB212546
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330138; cv=fail; b=Whai+6DQ2CNlPj5t6oyl5nq7l7mkAts0EeDC6aQTLyiR/dnBEAq4cNiY+KM1sE2Ufd/zSNkxrG/GGj82fmJAt3ChcoguPriFhq4goOrWXTxA3htdAWhKs0spnDXNDpKw9ScFkFt3OwMsuvUmINjPCXWMB3a8anwJ8JelqVMTRPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330138; c=relaxed/simple;
	bh=SY8VcVSUwyRMRR9rwwAjT6t7Q+tIQimm8fWR8OcHClo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RUmsElZ3cHC0yy9zSnYJAjrMZwuGfZDYUUbt3IPRdiC+/UONJO5wofwH5DhD6TCWP+Vpr+wSzYctJUsdd6HXhu0s6E754T6Vz/2x6SGTv7DBsd+pHivI/k+NrF5CWPBhrBH5htklwRlbBpkKNa+CcGCVoeK3NU1pZwaiSBva6mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fEWqMF7p; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Nqx1i018391
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 04:15:09 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 491krgs4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 04:15:09 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 588BF9WB014464;
	Mon, 8 Sep 2025 04:15:09 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 491krgs4uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 04:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0r0eJOYNzwZxZbQyErfjnJZVKmBNgvPoaNagFFZUTGrE3dyxKGOI8eToR3IxaG+54x2xDXofDIRu9W2kU4ci8LjRWHuFu2h7XZmdTVo53ibllHNLfUw8EaiYD1W5yAk7vrxfSyu6wePE4OGXV+FcbCQxD+JEjTAto+8vLOrjZ0xy25dy6224dMBeJRq736kugfo5XNAZImdDhcvM9X0CfpghbYBSEwKQdJf8mxGRiUdxO7iw5Ui7Yq71dduzbr9uldOBtT4qgZu+FaAEGdab8XLHSSdpD6LS8tMy9QOPSMi/p0jZcTcmCH1Ryy/yKC1qEqX306FJmXD8aVf+0XL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY8VcVSUwyRMRR9rwwAjT6t7Q+tIQimm8fWR8OcHClo=;
 b=wRkbIVYTOXgErv31FCMw/zJVlvZ9+uqviUZZ3hEbyFRG5JpAGUWPAprjZOhSn6SzYvFA1mibaBVLaX+Qh0xI03EmMA8xCwfwTtoA7Q71aHOVndxsXXijEPCbHhv0eUVsQX3cyGdXXJ8uHWVTt+saC+0cN57dvzTpbsLrAxKo15AYL0ebzhI+AFgIDO1kg49yE12+vDlzqI25O0Po5ZVWeZceHHoaU0PBRW9PI3BEm1mz8nno7qrCVt+mBmFoYo0vV/UcDRsSmq/Bn4Icsq0omPKFcda97/vlc3LpLuaxyfhwP1sFFYIURLaZvBKQba1rcV50A9CfeMvqMzra5N6Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY8VcVSUwyRMRR9rwwAjT6t7Q+tIQimm8fWR8OcHClo=;
 b=fEWqMF7phmwTsvw5V7CJsSvH/llvuuZXnh71Au3EHwmfbBrvOU+MAWyqLbLb05hYlSkKjliC4i5WLfPPtDsl9UJevqfqmnF/kGgGvVcofMAHgEqPq3DqOxuWdn/FCinktN50jW6PB0TTbC3DCqMYU+ftzd3dPaR4umjUYJEt8R4=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SN7PR18MB3933.namprd18.prod.outlook.com (2603:10b6:806:109::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:15:06 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:15:06 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
        netdev
	<netdev@vger.kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Elijah Craig <elijah.craig@oracle.com>,
        Jeff Warren
	<jeffrey.warren@oracle.com>
Subject: RE: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Topic: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Index: AQHcH5RmOu/c/zvqWkiWPitXjAQCF7SG8Z9wgAIjsGA=
Date: Mon, 8 Sep 2025 11:15:06 +0000
Message-ID:
 <CH0PR18MB4339E84983E30BCA8F6B52BCCD0CA@CH0PR18MB4339.namprd18.prod.outlook.com>
References:
 <PH0PR10MB4504BCA65DAAC15BB640FAFAAC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
 <PH0PR10MB450481C85C4829570F6352D3AC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
In-Reply-To:
 <PH0PR10MB450481C85C4829570F6352D3AC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SN7PR18MB3933:EE_
x-ms-office365-filtering-correlation-id: 1e7bc896-ceb3-489b-f742-08ddeec8f721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGF0bXNjYmJjUlIxYlVTOGFsbC9sdW12cjdRQktwdzArRXpadmNEYm1jOVFS?=
 =?utf-8?B?aUFKOEd0WUFHN0lHVFAwOU5hZERMd2lGRjdvNkdFV2dkaHdwRC9RTjNuWnh4?=
 =?utf-8?B?U25yMTNRcjV1TStWS0pENnR5aFdEMjc1SmwrZTdlNWZlNDVGUXFJS3drWENR?=
 =?utf-8?B?WEV5SkFCb0tSQXFIOGoyUytyRDlkU3FjSmxVQTErOW1lc0QzOWV6Tk5KN2ZZ?=
 =?utf-8?B?aGk5cGg5cldUMllCNnUzbWd4MnQwZ1dDT29BSUY0MVlZNnpvVmpKOUFMRzJE?=
 =?utf-8?B?Z2tyaE9KTmwxcUxOZkluMjA2SFpYaUdXNm5BTEczemNCQWVrZUt1WHZ6cjBU?=
 =?utf-8?B?OXh2a3NtUkdGQUJRTk5mbFFMa2JWeTNRNHZhcVpsNXpyK3ZPUGozdTdLSmZw?=
 =?utf-8?B?amZCRXJHcG9ldkFldytwR2JLN0ZNT2M2SXNubnZQTmc5Ny9Xd1FreDlqMkZM?=
 =?utf-8?B?NVEwTklIZjJ6UVBpWHdQa0VqL3Bud1dESG9BVUdWelJMdlFTZVZDU09oWDhB?=
 =?utf-8?B?WVlZSlBXaUs5ZmdVYkNDaEFUcXlkd0VVczIvaDlROWl3cE92ZlRYWEV3MkRk?=
 =?utf-8?B?L2J1RTRUNGxuS2Z3V1hZWXlWcTdFVis0WmtnYkRlUzdVMVorM2I1Mk1sTWpk?=
 =?utf-8?B?UFdwdlJ4MitvTEdsL3FzbXhRZkpqMTU3bnV1aWxCQ043dUpMQjJRSFgwY01U?=
 =?utf-8?B?VisxaWsrTFdLM2Ruc04rRkV2UG5XVVdScGxpaDZXakp3NHlTTWYwZ0pXaitV?=
 =?utf-8?B?TjZTcUx5RTdDV3dYaUdML01sNXV6U1d3WFdXckRMVkVRbDh1aEVLbWFVZk53?=
 =?utf-8?B?TjZVTHlrSTVxOFI4OWo2ajc5Y1c3eHcwZEZzbjVGczY5Mys5ZkxoQ1FYa1g5?=
 =?utf-8?B?bDVLM2htajhzbjA2UWxrU1E5d1dsbDZIL21PMjIrWDI1T2tDZ3pSbTcxSWk1?=
 =?utf-8?B?ZzBXa0gxVG1wOHZ1MnFEdTNZSGg1UEh5d1g2RURlR3Q0cDFiOWcxVmpMTDRj?=
 =?utf-8?B?QUI4OUs0Sy80YnFXOEhROUdFYmdkdTJLZU1sNHJBdU9pK0lCV1lhbkM3VUI3?=
 =?utf-8?B?SS9UZUs0R1dEWDFrVlQxLy9BT1VuY3JLdUJJS3UxSi83emFpeXZmcEFnb2ha?=
 =?utf-8?B?MEhjQllPTHNyTTMvQ1h1YlpYZWdVaDBMdUN3N1pTL0U0N2xGVEl5Q0wyQ0Nz?=
 =?utf-8?B?UXhkbUQ1S2ZXRHhOZ25UK2xnSmUzeVZWaGlrWEVwOXJ3V0VnNkM2VTVFR2o2?=
 =?utf-8?B?U3NZVlRWL2RXY3BoKzlQQlplZUM0bDdWTU9EMDZFcEczUHFoVGUrRGVoblJ2?=
 =?utf-8?B?QTRpd1kyUzhPa3dNSzVOM1kvVUMyTWRwUnNpRXdGMVc1MlFRU2RpV0Y3SlBD?=
 =?utf-8?B?bGg1QUlhL1VLMjN4MzlsVnJGbjZxdlZaNEo3UjJXelloZ0d6eWRTeE50d0dB?=
 =?utf-8?B?SHZBLytINXJZeldSdVYrZFdqOFY0YlhkZ1UvQm5OQ0NIQkFkWU1jNnVZNW93?=
 =?utf-8?B?SW1tQXNhNU1tUzJVS2pQMjJnM0N2cnF4bUZUM292b1BsVVBkNmJvNGNZYzU5?=
 =?utf-8?B?bHUydDlubWhLWlQ4L2lKMDRaV21HTk1wU0xyY01uTWhjdmxWb1poOFVhUGpj?=
 =?utf-8?B?blNBWldwaDIwWU1uWkNIOEo4dmFYNVBiZklXbDhHMzFGWTN6WXZWOFdIM3p6?=
 =?utf-8?B?anZ0SGVEOTZkOFNRWk5YZGxNempjTEtQY1FaTzJHVDk5Mjc4d2w1bW1zOTdR?=
 =?utf-8?B?eWpBWkVKM1dXS2FiQVVvcHlTRGVwTW1LV3FqVUFQTVJoVFdML2dpMXdlcmNz?=
 =?utf-8?B?UDMvejBLSm96M1hSdG1nS3FFanQzUHVoTWVZRW5KZm1yOW9teGYrSnlPVGlW?=
 =?utf-8?B?QzE0VGlHMnFjQVFOMlB4L1J6c0liQSthNkJybUk5YjBnY01FVWlnaENFNkIw?=
 =?utf-8?B?VGw1elJjZHltTXhxNmd0S1h3aFpSQjhicHZETFdoVndhUE9iNUlLRGlXdzhC?=
 =?utf-8?B?aDQxK1lRWFdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkV0cGpQL24xbUdJQmhRTndlbUxvaFFDbTU3WUtuQitxZ3JrRy93eTZzWSt1?=
 =?utf-8?B?dUJkNTBjdzhjMWlMTlhHcS9uU29pUGFoTlUyeU1lVkVlYmUrK05SV0g0UzA1?=
 =?utf-8?B?UjZVQWhUb3VzU2hkK1NWY25kZ3VZT0w5ZTc3OTAzbnBGeGNGd1lWUngxMC8r?=
 =?utf-8?B?QUVKV1NhTW5aSWd2RldsU3FOaUJOUUFvQmNWd1NNUE9FS3F6cWJBS041NG1U?=
 =?utf-8?B?WldOaWpGd0R6c25McklLcHRaaE1vZVhoS3psTThadWZnV1FJcEw5MVFKeGNl?=
 =?utf-8?B?Wk5CN1pab0xuellRRE4rZzhiNEZ2ZzdVNkh4VVdneDEvc2lhSkhNT0pBUDJP?=
 =?utf-8?B?cmlpQ016aDRTUzhvbkdjbGVBRWR1THlnQXAycDNuVm9TQmFXT1lkOFlzbnJt?=
 =?utf-8?B?YXErUFNrVDBFWUJ1OGtrb2VYT1JGN2JXeTBYb3hvclNNbzZqMTlhcVNsVjJK?=
 =?utf-8?B?WUZRNjBzb3BMWW1HNXNxNG1iQ3Q2MzlUOWk0dUY4ZlQ4WTNDenZoWFFIWG9k?=
 =?utf-8?B?d1ZqanRha2xzay8wck96aWJXbkZGVVJTZTZsSHlIbThJd1FnaEpBTFVEb3gz?=
 =?utf-8?B?Q2RaVUlCMHJPaHZDc0laQXNmYWFzSUxNMU1YQ04yR3VudS8xNWpxdjhkb3gx?=
 =?utf-8?B?UWJ0TzdScHlBR05RUER4ZHZyU2ExTk9HRGl5SEtPZ0RzRitabER5SVdQNU5J?=
 =?utf-8?B?RUlSamlpcWIxSGJnQm9pSXRhMVZacTl1RVArWWw5VEo3Vk9Cdk11WWJyeC9C?=
 =?utf-8?B?cXhoQ0ZweWhGR0xQQzd1Z2U1cFlDbHRJejlXcVlXQ1dGbEVyMXo3d0FlUmxM?=
 =?utf-8?B?SUw1MDY0bmRXL3VMcEV5TVplOE5LNHV5bVBTckZIV2d5aXpQZ0w3WDdCaDlz?=
 =?utf-8?B?VG0zL3I0QjlkK0EzT3RPL3R3dGF1WmlRbVhvcVJNWFBFYjZzSGZKZ25rRDdZ?=
 =?utf-8?B?bXpIRHY1T2trbTQyWktYTmJYWFZRY1NsRUZGeUYyU3NaZlViNTBnaGxkY3BU?=
 =?utf-8?B?WkZNUEs3d2ZOUm1DUUhWbDZMNFRQZUhUQk1wQXpvZDVNZHpSdVViNmYvU2dw?=
 =?utf-8?B?VlV3dkJydjhlVVJVczlOSHZlY1VqZDUyeHhzSWs0bXNXSkxsVWF6a3dQSGVO?=
 =?utf-8?B?Mnh3S3FjTFJjOVhFQmNzeW9ETGFheHhWMjVIU25TUHhKVCt2cnMzV0xoU0VJ?=
 =?utf-8?B?TVpOZDBhVnVDb1ZMeTBicGVvNEJoSE5FdXB5QVBNcFBMOEpHeE1xbnhyV0Vu?=
 =?utf-8?B?WTl0THI2bVVZK1dJalFnekQveEFZZFQrOVlpZ2VEcERTeElyUHFMS09iblNJ?=
 =?utf-8?B?c0NLOFVTenY4MXI1c2I3d1VTSUE5bWh6amh2RkF1ci8rbkh0SUpRWWpneHpz?=
 =?utf-8?B?Q3dLVWNrbk5sNlhCZkQ0bERQajNRZkFnZ2dGT1ovRzFkU1piMXdGd00vOThB?=
 =?utf-8?B?U2dsNzZvMEROK3FhQUdIUTYzT3FLWHBnNm5yUmRldzhONTMrMTR4TnVDU25C?=
 =?utf-8?B?ODE3cElPSjQ3cnVvQmhVU3Irbk51bnVET1o1UmZXNEg4cjJlTURBaHRlU3F1?=
 =?utf-8?B?OE01U3NtWmlrNDBRWThrM0xqNlR4UmZjZDhmOTZDbFZUaUFtaHJVUUVzUXkv?=
 =?utf-8?B?MzBHK1dkRjJKSWdnaGNyZzRmSjZ3QXhscVBVbUZVRjB0bHN5OGo2TW9LckZi?=
 =?utf-8?B?ZjlwbWRDS3VmRnVNa1psU0RrRmtuU3NTcjZ6MHNsU3haS2VOQ29xYlFKZmFL?=
 =?utf-8?B?aGtNK0hvTEdtRDdzd0JnVnhUQnFkQzE0N29vS3dBL0VEbk5sUU5GNlI2OFVQ?=
 =?utf-8?B?L1ZsNm1aNWdlSFpGWmtyWDZiNE9vMEp1VTJITHZOenNscDFhZ2FYT3ZJY3J0?=
 =?utf-8?B?MENsR3JCVEx0Q1ZMSUNXcDdCZ2ljTWFUT2hhNmVnTjllNnRZdTBBSFJJZ2lH?=
 =?utf-8?B?Q2FZdXBidm5tZUxiU1RGUzFtV0ZGM2hlTG5EaWNsM1JIaXBGdXhrZHp4ejZx?=
 =?utf-8?B?aHJVWVI3WUQ0dnA0VzREc0t0dXVwb1JEcU9rSm1SeGpRanA4WkpGZTZaZjl3?=
 =?utf-8?B?NitJYmthMXhQZGtBVldURk9UYXdORGJTbnV3WlFvSkRjbzE2cW9BODNWbmVn?=
 =?utf-8?Q?IrvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7bc896-ceb3-489b-f742-08ddeec8f721
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:15:06.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SElHGXtQREb686AKTpJMyeOfjAkFvHMLsOEyfybKcUfAhiu5Ut4Iq0uFg/IzYmZNlBn+swv4GURWMJhH40sTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3933
X-Authority-Analysis: v=2.4 cv=VNzdn8PX c=1 sm=1 tr=0 ts=68bebabd cx=c_pps a=/NyUMYTBgXGYnqUbJiLyjQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=Jdp9Nr2LksNKq9U6_GYA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: VW_-IJSg3q25SmYCz3UjYMvytOR075jS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDI0NiBTYWx0ZWRfXwO/B+gIXSwEf CfGkKdX8H2iS0zJNJ3/iwrsfhtd8BqzW3wTlTyy9BzSol+qs0euzCPKWhV6eBnb1lNhkpYy+1nZ Mvsah6LTzsfVTq4/4ZGiO0fdPQIgFu0ZRzKExE458EwTXyIIJYk7xKLTMKENmV8h/Jfu5oj8JKZ
 X1oyyxohhK5hqEdng2113D7PqPbqTFxP4o8UJ/EyF/QFYSmx+xoL5yVD3HwXbGjmk+8D8OpBY58 14K+bEcOpvbsAnWzKjZ4uWlz4NjCBPqc9hbZd/qeUCY9wUNl0F8Tg1V1Q08+ZSESXXfYNhMH/0O psrflmwVkXeUwH9gSmI55wPekbvXEvJjLMk0Ns4s8/rh7ixvVF+EDJUxQb+W5AgALteUy9jS9vL Cg6f+jxD
X-Proofpoint-ORIG-GUID: BR7TDo7dH1vvFap8Nj2tEzw1Eg0fAJo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZlbmthdCBWZW5rYXRzdWJy
YSA8dmVua2F0LngudmVua2F0c3VicmFAb3JhY2xlLmNvbT4NCj5TZW50OiBTdW5kYXksIFNlcHRl
bWJlciA3LCAyMDI1IDc6MTMgQU0NCj5UbzogbmV0ZGV2IDxuZXRkZXZAdmdlci5rZXJuZWwub3Jn
Pg0KPkNjOiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2Vl
dGhhc293amFueWEgQWt1bGENCj48Z2FrdWxhQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRl
ZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPjsNCj5IYXJpcHJhc2FkIEtlbGFtIDxoa2Vs
YW1AbWFydmVsbC5jb20+OyBCaGFyYXQgQmh1c2hhbg0KPjxiYmh1c2hhbjJAbWFydmVsbC5jb20+
OyBFbGlqYWggQ3JhaWcgPGVsaWphaC5jcmFpZ0BvcmFjbGUuY29tPjsgSmVmZg0KPldhcnJlbiA8
amVmZnJleS53YXJyZW5Ab3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIEZ3OiBvY3Rl
b250eDIgKHJ2dV9uaWN2ZikgTkVUREVWX1RYX0JVU1kgc3RhdGUNCj5oYW5kbGluZw0KPg0KPjNy
ZCBUcnkuLi5Tb3JyeSBhZ2Fpbi4NCj4NCj5UaGFua3MsDQo+VmVua2F0DQo+DQo+X19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPkZyb206IFZlbmthdCBWZW5rYXRzdWJy
YSA8dmVua2F0LngudmVua2F0c3VicmFAb3JhY2xlLmNvbT4NCj5TZW50OiBTYXR1cmRheSwgU2Vw
dGVtYmVyIDYsIDIwMjUgODozNCBQTQ0KPlRvOiBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc+DQo+Q2M6IEVsaWphaCBDcmFpZyA8ZWxpamFoLmNyYWlnQG9yYWNsZS5jb20+DQo+U3ViamVj
dDogb2N0ZW9udHgyIChydnVfbmljdmYpIE5FVERFVl9UWF9CVVNZIHN0YXRlIGhhbmRsaW5nDQo+
DQo+SGVsbG8gQWxsLA0KPg0KPldvdWxkIHlvdSBiZSBhYmxlIHRvIGhlbHAgdXMgdW5kZXJzdGFu
ZCB0aGUgZm9sbG93aW5nIGJlaGF2aW9yIHdpdGgNCj5vY3Rlb250eDIgZHJpdmVyID8NCj4NCj5v
dHgyX3NxX2FwcGVuZF9za2IoKToNCj4NCj4gICAgICAgIC8qIENoZWNrIGlmIHRoZXJlIGlzIGVu
b3VnaCByb29tIGJldHdlZW4gcHJvZHVjZXINCj4gICAgICAgICAqIGFuZCBjb25zdW1lciBpbmRl
eC4NCj4gICAgICAgICAqLw0KPiAgICAgICAgZnJlZV9kZXNjID0gb3R4Ml9nZXRfZnJlZV9zcWUo
c3EpOw0KPiAgICAgICAgaWYgKGZyZWVfZGVzYyA8IHNxLT5zcWVfdGhyZXNoKQ0KPiAgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+DQo+V2UgZ2V0IGludG8gYSBzaXR1YXRpb24gd2hlcmUg
ZnJlZV9kZXNjIGdvZXMgYmVsb3cgc3EtPnNxZV90aHJlc2guDQo+QW5kIHJlbWFpbnMgc3R1Y2sg
dGhlcmUuIFRoZSByZWFzb24gZm9yIHRoYXQgaXMgc3RpbGwgdW5kZXIgaW52ZXN0aWdhdGlvbi4N
CkhpIFZlbmthdCwNClRoYW5rcyBmb3IgcmVhY2hpbmcgb3V0LiBUaGlzIGlzc3VlIGFwcGVhcnMg
dG8gb2NjdXIgb25seSB3aGVuIHRoZSBOSUMgaXMgdW5hYmxlIHRvIHRyYW5zbWl0IHBhY2tldHMg
ZnJvbSB0aGUgU2VuZCBRdWV1ZXMuDQpJbiB0aGlzIHNjZW5hcmlvLCBkbyB5b3Ugb2JzZXJ2ZSB0
aGUgcGFja2V0cyBiZWluZyB0cmFuc21pdHRlZCBmcm9tIHRoZSBpbnRlcmZhY2VzPw0KDQo+DQo+
VGhlIGhlbHAgd2UgbmVlZGVkIHdhcyB3aXRoIGhvdyB0aGF0IHN0YXRlIGlzIGhhbmRsZWQgYmVs
b3cuDQo+DQo+b3R4MnZmX3htaXQoKToNCj4NCj4gICAgICAgIGlmICghb3R4Ml9zcV9hcHBlbmRf
c2tiKHZmLCB0eHEsIHNxLCBza2IsIHFpZHgpKSB7DQo+ICAgICAgICAgICAgICAgIG5ldGlmX3R4
X3N0b3BfcXVldWUodHhxKTsNCj4NCj4gICAgICAgICAgICAgICAgLyogQ2hlY2sgYWdhaW4sIGlu
Y2FzZSBTUUJzIGdvdCBmcmVlZCB1cCAqLw0KPiAgICAgICAgICAgICAgICBzbXBfbWIoKTsNCj4g
ICAgICAgICAgICAgICAgaWYgKCgoc3EtPm51bV9zcWJzIC0gKnNxLT5hdXJhX2ZjX2FkZHIpICog
c3EtPnNxZV9wZXJfc3FiKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPiBzcS0+c3FlX3RocmVzaCkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICBuZXRpZl90eF93YWtlX3F1ZXVlKHR4cSk7DQo+DQo+ICAgICAgICAgICAgICAgIHJldHVy
biBORVRERVZfVFhfQlVTWTsNCj4gICAgICAgIH0NCj4NCj5XaXRoICgoc3EtPm51bV9zcWJzIC0g
KnNxLT5hdXJhX2ZjX2FkZHIpICogc3EtPnNxZV9wZXJfc3FiKSA+IHNxLQ0KPj5zcWVfdGhyZXNo
ICByZW1haW5pbmcgdHJ1ZSB0eHEgaXMga2VwdCBhd2FrZSBhbmQgTkVUREVWX1RYX0JVU1kgcmV0
dXJuZWQuDQo+cWRpc2MgcmVzZW5kcyB0aGUgcGFja2V0IGFnYWluIGFuZCB0aGUgc2FtZSBzZXF1
ZW5jZSByZXBlYXRzIChmb3JldmVyKS4NClN1Y2ggYmVoYXZpb3Igc2hvdWxkIG5vdCBvY2N1ciB1
bmxlc3MgdGhlIFNRIGlzIHN0dWNrIOKAlCBtZWFuaW5nIHBhY2tldHMgYXJlIG5vdCBiZWluZyB0
cmFuc21pdHRlZC4NCkluIHRoYXQgY2FzZSwgdGhlcmUgd29u4oCZdCBiZSBlbm91Z2ggZnJlZSBk
ZXNjcmlwdG9ycyBhdmFpbGFibGUgdG8gaGFuZGxlIG5ldyBwYWNrZXRzLg0KQ291bGQgeW91IHBs
ZWFzZSBzaGFyZSB0aGUgU1EgcXVldWUgc2l6ZSBjb25maWd1cmVkIGluIHlvdXIgc2V0dXA/DQo+
DQo+VGhpcyBnZXRzIHVzIGludG8NCj5pKSAgIGhpZ2ggY3B1IHVzYWdlIGJ5IGtzb2Z0aXJxZA0K
PmlpKSAgdGhlIHR4IHRpbWVvdXQgd2F0Y2hkb2cgdGltZXIgZXhwaXJ5IGRvZXNuJ3QgdHJpZ2dl
ciAgYSBOSUMgcmVzZXQNCj4gICAgIHNpbmNlIHR4cSBjb250aW51ZXMgdG8gcmVtYWluIGFjdGl2
ZS4NCj4NCj5QYXN0aW5nIHNvbWUgdmFsdWVzIHdlIGhhZCBnYXRoZXJlZCB3aXRoIGEgdHJhY2Ug
aW4gdGhlIGh1bmcgc3RhdGUuDQo+DQo+IG90eDJfc3FfYXBwZW5kX3NrYiBjb25zX2hlYWQgMHg4
OTAgaGVhZCAweDZmNCBzcWVfY250IDB4MTAwMCBmcmVlX2Rlc2MNCj40MTEgc3FlX3RocmVzaCA0
MTIgIG90eDJfc3FfYXBwZW5kX3NrYiBudW1fc3FicyAweDg1IGF1cmFfZmNfYWRkciAweDINCj5z
cWVfcGVyX3NxYiAweDFmDQo+DQo+V2hpbGUgeW91IGFyZSB0aGVyZSBpZiB5b3UgY2FuIGFzc2lz
dCB1cyB3aXRoIHRoZSB3YXRjaGRvZyB0aW1lciB2YWx1ZSB0aGF0IGlzDQo+Y2hvc2VuLg0KPg0K
Pi8qIFRpbWUgdG8gd2FpdCBiZWZvcmUgd2F0Y2hkb2cga2lja3Mgb2ZmICovDQo+I2RlZmluZSBP
VFgyX1RYX1RJTUVPVVQgICAgICAgICAoMTAwICogSFopDQo+DQo+V2h5IGlzIGl0IGtlcHQgc28g
aGlnaCBjb21wYXJlZCB0byBvdGhlciBkcml2ZXJzID8NCj4NCj5XZSBlbmNvdW50ZXJlZCB0aGlz
IHByb2JsZW0gd2l0aCBPcmFjbGUgTGludXguDQo+TG9va2luZyBhdCB0aGUgbGF0ZXN0IHVwc3Ry
ZWFtIG9jdGVvbnR4MiBjb2RlIGl0IHNlZW1lZCB0byBmdW5jdGlvbiB0aGUgc2FtZQ0KPndheS4N
Cj4NCj5XZSBkb24ndCBoYXZlIGEgd2F5IHRvIGluc3RhbGwgdGhlIGxhdGVzdCB1cHN0cmVhbSBr
ZXJuZWwgb24gdGhlIFNtYXJ0TklDLg0KPkN1cnJlbnRseSB3ZSBoaXQgdGhpcyBwcm9ibGVtIG9u
Y2UgZXZlcnkgMiB3ZWVrcyBvciBldmVuIGxlc3MuDQo+UHJldHR5IG11Y2ggcmFuZG9tIHRpbWUg
aXQgdGFrZXMuDQo+DQo+VGhhbmtzIGZvciB5b3VyIGhlbHAuDQo+DQo+VGhhbmtzLA0KPlZlbmth
dA0K

