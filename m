Return-Path: <netdev+bounces-103110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8259064E8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC94C1F21805
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25115F876;
	Thu, 13 Jun 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="r5Dckalb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CEB5A10B;
	Thu, 13 Jun 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263482; cv=fail; b=nfSmvZn5MkwB05FkyukvBlKofuFDI/TzQXodXmRMEkvLJtvM5w6SIppCJDC/7/Ybblk55C01nHaXB1H2THPitmGNZKgNffifVBMV87IOAmepdf1kVme0p4fafmc+//aJHwREzbwGoiGar7GRmwyichdpYY5Q/1JlxTUy4xS/WfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263482; c=relaxed/simple;
	bh=NBkuL4m9fXFq7pEqlx2ehtD0vY8ZPbZzJWFclmaEV1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkKCXOrzsJgfmC86YGwaCX6sAQtx3Plnhbnd/A/kLVKe6I592IVcawwZ9sZDOWzIjCovjV4d2C19+W3SZBbs8ffbceBF/cfPwfBBFeM5dVQJx/YPFYXnEwiv4FM6XXcis714Jt8zjpjhgt9yMbi6rAogKyek7H7Mcu2SJf5MYrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=r5Dckalb; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D2jZC6028430;
	Thu, 13 Jun 2024 00:24:23 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yqr92gv8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVg1QSHzQFUD9OYk2oiXCajsw/GoEGPDraSySpMRbWlfHNprfdlOS+LJ/7fNobUmMsp8CaW6gK9ARZX22SiocvGdIK900HT0QA323rU4/HE/0/WtQKCdVXG6Gbu7OC/TK99+2XeVmalGrNzvgoDJ5P9+fGxA0kIKl1cstSJDn6Nu2Bo6KIISa44jMg2THdKglzqb/0iqYos1RktdObTtk9nReLTY9D/LxA2st83/KFrDJSUlGkVNXWYdU3gzG1/hMl7tHlS0neNIT3E8hxBhe1a1XRz/F0eB9kaOjXfkuSADktyu76aVegjjukQVmMGmgnVQFMmCmm6Pxm/1B1GO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isVvmMMZ8mYScMrwbX0+lDdlPmjFe5cN90icK5hLBv8=;
 b=CYs6c4N+sbdXPgh2oEsfjicDb1oSE5648zDf0KaNWBIQhLGL5HidedEr0kDfRgesgh6aTIy/6v7Z9+B5Uk5lIRzk6fcWjbzJGyf7YISa7fwKbbPun6N7M517x8W5uoSgSE043B3MayDIunQbRfxcVERZLqNUAleAsZFMyikcVWBBdutW2GJkH/HWsQQK3s6gO2cDS4ydKM494dJfj7IXF3iNLWFVq8vC1bR2AWgvD24I9ov008aVqUCRkA+CQL+dK/9jzwcy0eKpXFH1cnNoqPQXffQMjgpnHpjf++ukw3xDBkg33vQyxKI/bsvSZZmMBwqe+cynPHk7oQfCAxKKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isVvmMMZ8mYScMrwbX0+lDdlPmjFe5cN90icK5hLBv8=;
 b=r5DckalbvoBK6v04A6ucadm9yaAzNHY8lKsb3xiU8LVW4JH/chTvqrE5YAObS1Js3pQx8XwLkHPjXA6YypqElGwL/eOimc9tgdXXf6c9EjbfSaT6sWKoEPmVhT2fU7tjG3ryYU7j/0Wng/jtL8mDLYkV4iys4mqA1DGa15ejR48=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by BN9PR18MB4169.namprd18.prod.outlook.com (2603:10b6:408:133::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:24:20 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 07:24:20 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Topic: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHauLmglNHUNJhH+k6V4cXh5B3lqrHDkmGAgABipvCAAR/ogIAAPrGQ
Date: Thu, 13 Jun 2024 07:24:20 +0000
Message-ID: 
 <PH0PR18MB4474B697FC71BF96F5EE4EA1DEC12@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
 <PH0PR18MB44745E2CFEA3CC1D9ADC5AC0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
 <89c92725271a4fa28dbf1e37f3fd5e99@realtek.com>
 <PH0PR18MB4474CB7ED482769F166FC50FDEC02@PH0PR18MB4474.namprd18.prod.outlook.com>
 <3b25f342510b42d1beac0d602fc5abd7@realtek.com>
In-Reply-To: <3b25f342510b42d1beac0d602fc5abd7@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|BN9PR18MB4169:EE_
x-ms-office365-filtering-correlation-id: a2f224ab-b8e5-401a-1ce3-08dc8b79d7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?XliLcVbVpyGTGhNdqHPW+McZ3pi3ls/rIPOD4h9/qAdzXklbHG0e5QAOPTHa?=
 =?us-ascii?Q?DsrTgxqtqa7EDe+1VOCNA2pJGCPuUQW8LwZZEf9+x4ACpNgI+EML2zXRULgZ?=
 =?us-ascii?Q?ipGsfgUTNk6tN6aB1SfL+k8n+RJ5MqVYBdHLbyp4B8l6snnUc6dTslVEeUrV?=
 =?us-ascii?Q?3zusv8inIEP+tmvI3l5Q61qgjpjSXEVfqs8dhnQAqIN6yluX1GCY3KwKVNFR?=
 =?us-ascii?Q?tG9dE/AQKUqhsrbQI/edvpQ/kH9gN3EmdrpcTzio5c6jMpP744jPXbkZFjo1?=
 =?us-ascii?Q?bmL/d9LCqeRB45cPyjp3tePCItEPzZM1eH6aPK9KRTOlfFe+1qJ853j/3aEL?=
 =?us-ascii?Q?QgQzu30COj0a1PN9oeTJC4KJoKewW2ohyz/2G8ozDfiXVA4+N6o5eYnNo1Y4?=
 =?us-ascii?Q?NS3r9D1DBg1t0A+LuM7Nm13/tw0/iCPJxSI3SrFJszjMYQnlOHMsOqZB3j/b?=
 =?us-ascii?Q?6Fu0/GHEXNiQMzzOPEVXViNwG30YgxfYLJCdG7XewIrZLRWxclM0ln5GF6SE?=
 =?us-ascii?Q?yXyzBQCqaKcYKt9v/MJgoQ02yWXUPoiTqWj9bDQB39N/pxqp5oFTq1Gz/z4V?=
 =?us-ascii?Q?ERlGv/unOIkl4NyWuYBwPp9oHt+Lc0YCEoyovKEZd8CRB8tLZxYGZiEvJFyd?=
 =?us-ascii?Q?vKxAURf2DxDquy5KSFjVP7oDaJjJiyYK0zAiifsfXRLmAAbFPEG0al3ji+Gu?=
 =?us-ascii?Q?je/ZvKUKTx9+mZph1NwQZf6/0yJotB3ocQDrMnokeYTsMSByeqJD4XXjuIZO?=
 =?us-ascii?Q?J2qSsNYHqVKvy/rdjQWdQ+ryMcOvmR2HFjB4ag09NCUJIL2PLdRjjiyFh6Ei?=
 =?us-ascii?Q?rhMrjfPqzdVsxU3p1fVafJXtefYS4ag/bccBluYvK0W7UZ3DhehG60q9T6FF?=
 =?us-ascii?Q?m5BNb5nsnmF3HtdBvICKMy+AW9QT/PzPnQeICOZxI6UMGgvxkVXs+NklRqRi?=
 =?us-ascii?Q?zvVraZZvqZRRm3SRbNMDCElwesT+u7U53/pUTKVCeH/8Dyu7FvGdPPWOBU0c?=
 =?us-ascii?Q?5du4JUC7wQaNRVwvWDyAognbisXAyqRFeo5tiXWXBXiRMvzZEOAgYvyE8coa?=
 =?us-ascii?Q?oSrGp9PvXHNdMG+Cn1WlepsZn+7rx1EM4wY6j1enWX6FhTJms2N4mPeWJRtS?=
 =?us-ascii?Q?a/Mk+kTdyU7NH3lri7yuq1DKGCbc2SvfQmGbvmcAho0hyDIFKNUO9TJmIkk0?=
 =?us-ascii?Q?VBtkBLniEpSkg0b4yrYK+Vszch0UNvi5fV9RymFRjpbXAZuLsAXf2X0Ufb7K?=
 =?us-ascii?Q?2GTRMvTMCHLqy2jsGTtMBnC/USgtKwkV+/bWoMXFBQmyDmNxRqSOvwyOMdf1?=
 =?us-ascii?Q?ANDcXoOyXxuYCTn0snjTpRqP/U3QEPBlWeIA5Z7p12DwlZJsSBcLkc3RnfGf?=
 =?us-ascii?Q?yWqKXB0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bio+0hW20ccDjUJ7UYROoxjzgHA+TUs8Bl0ifoA1GAq5C7r3mEBKokyFDVHM?=
 =?us-ascii?Q?RKTU0awWcyYEDamPz9uQrdQta7KffJ45CR7L74EYPBtaw99zeW6PHtu3CD/b?=
 =?us-ascii?Q?qUOns7kKJozrr9zC/fHFSNLV2AjPqNIISl/ciLQBcCOGL8CNByxUHPAknZZB?=
 =?us-ascii?Q?f+pyTKv1XCA6T/n1HuoNwUS5rz5Ja1oLhdFO5UrW9JcNpNGpAmBr/UMc0kbm?=
 =?us-ascii?Q?V0L9YpoEvCHfZxV+cD1kdJoHr9iZWAPK1NmEuIh5mqYT8yP5XT8sgOz7WMCa?=
 =?us-ascii?Q?0Gq2yU1f/q8XY3S/6WUUGYWNlkhUuRD55XCVlnBORhbmGewLTd2iVuOZlyfU?=
 =?us-ascii?Q?IE+NmB0KGhwC1JQwPS3i+KPaHauuqOSeGnbsNAhLzJTtKKY3OmNCBGKB0Q1Q?=
 =?us-ascii?Q?qLsn8dhgEEalrCW4LMpm4FIf5NEz9bdsn0TvUN+o+wMTS4nMKxuW+qITwMhU?=
 =?us-ascii?Q?zF45RJPlJUbilNA4iL0dd9cnOqPrLL1yCyJ8MULF6jK9BwP29FIiENDrVySc?=
 =?us-ascii?Q?7uCu+sjPPDl8eu6nqEPGRcft9oT+pfzdBQYs9UaVtx+cOBX2uNWFseS/vWAC?=
 =?us-ascii?Q?5KrM49kgAJjjXbzBkFnFXgV23D2oUzTDM0q1I8KZ6VPmnRjN5XJK5EjryKAn?=
 =?us-ascii?Q?NO7m9rGBEiOEQPLOm/IdoCI7wWE2gCDmJ2uEhNdukpxPwWXxm/J4yXmfpUYf?=
 =?us-ascii?Q?ucVoxtihDaB3qMc4swDNUysU+VfwroLQJFJorSexsXj9u8j2IehX8QWyvGOc?=
 =?us-ascii?Q?1pFaJHgYIUIxEgbW18bcuzLjporTuhrF2tIZ27euDbOMP2tGxu1rMMcRDlS8?=
 =?us-ascii?Q?juWHmlPrqpdgECp2n+tUUk/rr4W369G5bqqW948+oFmALt6HUaWNIEK6tSa8?=
 =?us-ascii?Q?pvkdRBKXDbiJANXXV6Q+o58BYjvmKnR85Y0ewudYS7roPe9GZpDwracnjWyN?=
 =?us-ascii?Q?5leQLEuqVPUgDHfUv9EfvgRX0+nDzSkHzNe5HTI6Gu5EsGcqRct55zQaIjDw?=
 =?us-ascii?Q?wAjPalxPTSpNw35jO6pZeM9UQDQtRE3NAvX61R3zz/IldIDs43oL8TUWQkED?=
 =?us-ascii?Q?JmK9a3VxhyRrowfdygr0555WaT9e7UBDkzySoQptGZYwlR16LFKz5V3ZADaY?=
 =?us-ascii?Q?Y1+fO6rxQm9Y/XI0XiUWfZEogs6Dg7CO2pJGAgn7D8Ug5o8LK+MGevs12t/2?=
 =?us-ascii?Q?ez8+1+JQoKRI+60JqYsIilAWtwU1moo1sD4moOazijtrdl29bERNkOOjtrvg?=
 =?us-ascii?Q?UiWiHhE1uLBvr8kH54l5TbOopClYRJ5DzWSc+aJayFrExbpwM8Cw8GCHnpaD?=
 =?us-ascii?Q?LYzgirRX02VMY4FkPb2c42ohmZblTRxzlG3Jn9yyFqlBcfqHoE3WslG1ba7r?=
 =?us-ascii?Q?RvGnn0XWSUwBuJHZKBi3N8eLhjQwxZYkzqRWQkA+oYuhGxIh9PpTpnMLDHqN?=
 =?us-ascii?Q?4BNBpNVSdMf3Vin77LRIHCK7SMNA9D/UnC55oUFckL5auxEdDJIvgU1Pcl+X?=
 =?us-ascii?Q?aOszeO0WMyD/CHYOtnmopZ4c8NMzti3KGl9MevnCW2zskpjxHUzM+KQ9oBYT?=
 =?us-ascii?Q?jvg2WCfSiOeXZG4wirQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f224ab-b8e5-401a-1ce3-08dc8b79d7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 07:24:20.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTOiHM2rpmfJfpcyVuyAn/68DmOt/e7oWtFVU9jj7KuTX8+PebLYnycDI1JasFtlJjNmOETSiCYgKN9C3AJJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4169
X-Proofpoint-GUID: 3-Z2prE_aTONivb1qP7fZA-Tevndknms
X-Proofpoint-ORIG-GUID: 3-Z2prE_aTONivb1qP7fZA-Tevndknms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01



> > > > > Implement .ndo_start_xmit function to fill the information of
> > > > > the packet to be transmitted into the tx descriptor, and then
> > > > > the hardware will transmit the packet using the information in
> > > > > the tx
> > > descriptor.
> > > > > In addition, we also implemented the tx_handler function to
> > > > > enable the tx descriptor to be reused.
> > > > >
> > > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > > > ---
> > > > >  .../net/ethernet/realtek/rtase/rtase_main.c   | 285
> > ++++++++++++++++++
> > > > >  1 file changed, 285 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > > index 23406c195cff..6bdb4edbfbc1 100644
> > > > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > > @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union
> > > > > rtase_rx_desc *desc, u32 rx_buf_sz)
> > > > >                  cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
> > > > > }
> > > > >
> > > > > +static u32 rtase_tx_avail(struct rtase_ring *ring) {
> > > > > +     return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> > > > > +            READ_ONCE(ring->cur_idx); }
> > > > > +
> > > > > +static int tx_handler(struct rtase_ring *ring, int budget) {
> > > > > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > > > > +     struct net_device *dev =3D tp->dev;
> > > > > +     u32 dirty_tx, tx_left;
> > > > > +     u32 bytes_compl =3D 0;
> > > > > +     u32 pkts_compl =3D 0;
> > > > > +     int workdone =3D 0;
> > > > > +
> > > > > +     dirty_tx =3D ring->dirty_idx;
> > > > > +     tx_left =3D READ_ONCE(ring->cur_idx) - dirty_tx;
> > > > > +
> > > > > +     while (tx_left > 0) {
> > > > > +             u32 entry =3D dirty_tx % RTASE_NUM_DESC;
> > > > > +             struct rtase_tx_desc *desc =3D ring->desc +
> > > > > +                                    sizeof(struct
> > > > > + rtase_tx_desc)
> > > > > + *
> > > > entry;
> > > > > +             u32 status;
> > > > > +
> > > > > +             status =3D le32_to_cpu(desc->opts1);
> > > > > +
> > > > > +             if (status & RTASE_DESC_OWN)
> > > > > +                     break;
> > > > > +
> > > > > +             rtase_unmap_tx_skb(tp->pdev, ring->mis.len[entry],
> > desc);
> > > > > +             ring->mis.len[entry] =3D 0;
> > > > > +             if (ring->skbuff[entry]) {
> > > > > +                     pkts_compl++;
> > > > > +                     bytes_compl +=3D ring->skbuff[entry]->len;
> > > > > +                     napi_consume_skb(ring->skbuff[entry],
> > budget);
> > > > > +                     ring->skbuff[entry] =3D NULL;
> > > > > +             }
> > > > > +
> > > > > +             dirty_tx++;
> > > > > +             tx_left--;
> > > > > +             workdone++;
> > > > > +
> > > > > +             if (workdone =3D=3D RTASE_TX_BUDGET_DEFAULT)
> > > > > +                     break;
> > > > > +     }
> > > > > +
> > > > > +     if (ring->dirty_idx !=3D dirty_tx) {
> > > > > +             dev_sw_netstats_tx_add(dev, pkts_compl,
> > bytes_compl);
> > > > > +             WRITE_ONCE(ring->dirty_idx, dirty_tx);
> > > > > +
> > > > > +             netif_subqueue_completed_wake(dev, ring->index,
> > > > > pkts_compl,
> > > > > +                                           bytes_compl,
> > > > > +
> > rtase_tx_avail(ring),
> > > > > +
> > > > RTASE_TX_START_THRS);
> > > > > +
> > > > > +             if (ring->cur_idx !=3D dirty_tx)
> > > > > +                     rtase_w8(tp, RTASE_TPPOLL,
> > BIT(ring->index));
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx=
)  {
> > > > >       struct rtase_ring *ring =3D &tp->tx_ring[idx]; @@ -1014,6
> > > > > +1076,228 @@ static int rtase_close(struct net_device *dev)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
> > > > > +                          const struct sk_buff *skb) {
> > > > > +     return (skb_vlan_tag_present(skb)) ?
> > > > > +             (RTASE_TX_VLAN_TAG |
> > swab16(skb_vlan_tag_get(skb))) :
> > > > > 0x00; }
> > > > > +
> > > >                Vlan protocol can be either 0x8100 or 0x88A8, how
> > > > does hardware know which header to insert?
> > > > Thanks,
> > > > Hariprasad k
> > >
> > > We only allow the hardware to add 0x8100, the VLAN must at least
> > > have
> > > 0x8100 to potentially have 0x88a8, skb_vlan_tag_present indicates
> > > that VLAN exists, hence at least the 0x8100 VLAN would exist.
> > > >
> > Thanks for the explanation, but one question which bothers me is that
> > "how hardware knows offset with in the packet"
> >
> > For example
> > Case 1:       DMAC  + SMAC + 8100 VLAN_ID + IP
> >                Here offset is right after the SMAC.
> > Case 2:      DMAC + SMAC + 88A8 VLAN_ID + 8100 VLAN_ID + IP
> >                Here offset is right after first vlan tag.
> >
> > Thanks,
> > Hariprasad k
>=20
> This driver only enables NETIF_F_HW_VLAN_CTAG_TX, and we only support
> case 1.
>=20

   Got it . So the hardware is programmed with fixed offset.

> >
> > > > > +static u32 rtase_tx_csum(struct sk_buff *skb, const struct
> > > > > +net_device
> > > > > +*dev) {
> > > > > +     u32 csum_cmd =3D 0;
> > > > > +     u8 ip_protocol;
> > > > > +
> > > > > +     switch (vlan_get_protocol(skb)) {
> > > > > +     case htons(ETH_P_IP):
> > > > > +             csum_cmd =3D RTASE_TX_IPCS_C;
> > > > > +             ip_protocol =3D ip_hdr(skb)->protocol;
> > > > > +             break;
> > > > > +
> > > > > +     case htons(ETH_P_IPV6):
> > > > > +             csum_cmd =3D RTASE_TX_IPV6F_C;
> > > > > +             ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> > > > > +             break;
> > > > > +
> > > > > +     default:
> > > > > +             ip_protocol =3D IPPROTO_RAW;
> > > > > +             break;
> > > > > +     }
> > > > > +
> > > > > +     if (ip_protocol =3D=3D IPPROTO_TCP)
> > > > > +             csum_cmd |=3D RTASE_TX_TCPCS_C;
> > > > > +     else if (ip_protocol =3D=3D IPPROTO_UDP)
> > > > > +             csum_cmd |=3D RTASE_TX_UDPCS_C;
> > > > > +
> > > > > +     csum_cmd |=3D u32_encode_bits(skb_transport_offset(skb),
> > > > > +                                 RTASE_TCPHO_MASK);
> > > > > +
> > > > > +     return csum_cmd;
> > > > > +}
> > > > > +
> > > > > +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_b=
uff *skb,
> > > > > +                         u32 opts1, u32 opts2) {
> > > > > +     const struct skb_shared_info *info =3D skb_shinfo(skb);
> > > > > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > > > > +     const u8 nr_frags =3D info->nr_frags;
> > > > > +     struct rtase_tx_desc *txd =3D NULL;
> > > > > +     u32 cur_frag, entry;
> > > > > +
> > > > > +     entry =3D ring->cur_idx;
> > > > > +     for (cur_frag =3D 0; cur_frag < nr_frags; cur_frag++) {
> > > > > +             const skb_frag_t *frag =3D &info->frags[cur_frag];
> > > > > +             dma_addr_t mapping;
> > > > > +             u32 status, len;
> > > > > +             void *addr;
> > > > > +
> > > > > +             entry =3D (entry + 1) % RTASE_NUM_DESC;
> > > > > +
> > > > > +             txd =3D ring->desc + sizeof(struct rtase_tx_desc) *=
 entry;
> > > > > +             len =3D skb_frag_size(frag);
> > > > > +             addr =3D skb_frag_address(frag);
> > > > > +             mapping =3D dma_map_single(&tp->pdev->dev, addr, le=
n,
> > > > > +                                      DMA_TO_DEVICE);
> > > > > +
> > > > > +             if (unlikely(dma_mapping_error(&tp->pdev->dev,
> > > > > + mapping)))
> > > > > {
> > > > > +                     if (unlikely(net_ratelimit()))
> > > > > +                             netdev_err(tp->dev,
> > > > > +                                        "Failed to map TX
> > > > fragments
> > > > > DMA!\n");
> > > > > +
> > > > > +                     goto err_out;
> > > > > +             }
> > > > > +
> > > > > +             if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > > > > +                     status =3D (opts1 | len | RTASE_RING_END);
> > > > > +             else
> > > > > +                     status =3D opts1 | len;
> > > > > +
> > > > > +             if (cur_frag =3D=3D (nr_frags - 1)) {
> > > > > +                     ring->skbuff[entry] =3D skb;
> > > > > +                     status |=3D RTASE_TX_LAST_FRAG;
> > > > > +             }
> > > > > +
> > > > > +             ring->mis.len[entry] =3D len;
> > > > > +             txd->addr =3D cpu_to_le64(mapping);
> > > > > +             txd->opts2 =3D cpu_to_le32(opts2);
> > > > > +
> > > > > +             /* make sure the operating fields have been updated=
 */
> > > > > +             dma_wmb();
> > > > > +             txd->opts1 =3D cpu_to_le32(status);
> > > > > +     }
> > > > > +
> > > > > +     return cur_frag;
> > > > > +
> > > > > +err_out:
> > > > > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> > > > > +     return -EIO;
> > > > > +}
> > > > > +
> > > > > +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
> > > > > +                                 struct net_device *dev) {
> > > > > +     struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > > > > +     struct rtase_private *tp =3D netdev_priv(dev);
> > > > > +     u32 q_idx, entry, len, opts1, opts2;
> > > > > +     struct netdev_queue *tx_queue;
> > > > > +     bool stop_queue, door_bell;
> > > > > +     u32 mss =3D shinfo->gso_size;
> > > > > +     struct rtase_tx_desc *txd;
> > > > > +     struct rtase_ring *ring;
> > > > > +     dma_addr_t mapping;
> > > > > +     int frags;
> > > > > +
> > > > > +     /* multiqueues */
> > > > > +     q_idx =3D skb_get_queue_mapping(skb);
> > > > > +     ring =3D &tp->tx_ring[q_idx];
> > > > > +     tx_queue =3D netdev_get_tx_queue(dev, q_idx);
> > > > > +
> > > > > +     if (unlikely(!rtase_tx_avail(ring))) {
> > > > > +             if (net_ratelimit())
> > > > > +                     netdev_err(dev, "BUG! Tx Ring full when
> > > > > + queue
> > > > > awake!\n");
> > > > > +             goto err_stop;
> > > > > +     }
> > > > > +
> > > > > +     entry =3D ring->cur_idx % RTASE_NUM_DESC;
> > > > > +     txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry;
> > > > > +
> > > > > +     opts1 =3D RTASE_DESC_OWN;
> > > > > +     opts2 =3D rtase_tx_vlan_tag(tp, skb);
> > > > > +
> > > > > +     /* tcp segmentation offload (or tcp large send) */
> > > > > +     if (mss) {
> > > > > +             if (shinfo->gso_type & SKB_GSO_TCPV4) {
> > > > > +                     opts1 |=3D RTASE_GIANT_SEND_V4;
> > > > > +             } else if (shinfo->gso_type & SKB_GSO_TCPV6) {
> > > > > +                     if (skb_cow_head(skb, 0))
> > > > > +                             goto err_dma_0;
> > > > > +
> > > > > +                     tcp_v6_gso_csum_prep(skb);
> > > > > +                     opts1 |=3D RTASE_GIANT_SEND_V6;
> > > > > +             } else {
> > > > > +                     WARN_ON_ONCE(1);
> > > > > +             }
> > > > > +
> > > > > +             opts1 |=3D u32_encode_bits(skb_transport_offset(skb=
),
> > > > > +                                      RTASE_TCPHO_MASK);
> > > > > +             opts2 |=3D u32_encode_bits(mss, RTASE_MSS_MASK);
> > > > > +     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > > > > +             opts2 |=3D rtase_tx_csum(skb, dev);
> > > > > +     }
> > > > > +
> > > > > +     frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
> > > > > +     if (unlikely(frags < 0))
> > > > > +             goto err_dma_0;
> > > > > +
> > > > > +     if (frags) {
> > > > > +             len =3D skb_headlen(skb);
> > > > > +             opts1 |=3D RTASE_TX_FIRST_FRAG;
> > > > > +     } else {
> > > > > +             len =3D skb->len;
> > > > > +             ring->skbuff[entry] =3D skb;
> > > > > +             opts1 |=3D RTASE_TX_FIRST_FRAG |
> > RTASE_TX_LAST_FRAG;
> > > > > +     }
> > > > > +
> > > > > +     if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > > > > +             opts1 |=3D (len | RTASE_RING_END);
> > > > > +     else
> > > > > +             opts1 |=3D len;
> > > > > +
> > > > > +     mapping =3D dma_map_single(&tp->pdev->dev, skb->data, len,
> > > > > +                              DMA_TO_DEVICE);
> > > > > +
> > > > > +     if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> > > > > +             if (unlikely(net_ratelimit()))
> > > > > +                     netdev_err(dev, "Failed to map TX
> > > > > + DMA!\n");
> > > > > +
> > > > > +             goto err_dma_1;
> > > > > +     }
> > > > > +
> > > > > +     ring->mis.len[entry] =3D len;
> > > > > +     txd->addr =3D cpu_to_le64(mapping);
> > > > > +     txd->opts2 =3D cpu_to_le32(opts2);
> > > > > +     txd->opts1 =3D cpu_to_le32(opts1 & ~RTASE_DESC_OWN);
> > > > > +
> > > > > +     /* make sure the operating fields have been updated */
> > > > > +     dma_wmb();
> > > > > +
> > > > > +     door_bell =3D __netdev_tx_sent_queue(tx_queue, skb->len,
> > > > > +                                        netdev_xmit_more());
> > > > > +
> > > > > +     txd->opts1 =3D cpu_to_le32(opts1);
> > > > > +
> > > > > +     skb_tx_timestamp(skb);
> > > > > +
> > > > > +     /* tx needs to see descriptor changes before updated cur_id=
x */
> > > > > +     smp_wmb();
> > > > > +
> > > > > +     WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
> > > > > +
> > > > > +     stop_queue =3D !netif_subqueue_maybe_stop(dev, ring->index,
> > > > > +
> > > > > + rtase_tx_avail(ring),
> > > > > +
> > > > RTASE_TX_STOP_THRS,
> > > > > +
> > > > RTASE_TX_START_THRS);
> > > > > +
> > > > > +     if (door_bell || stop_queue)
> > > > > +             rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > > > > +
> > > > > +     return NETDEV_TX_OK;
> > > > > +
> > > > > +err_dma_1:
> > > > > +     ring->skbuff[entry] =3D NULL;
> > > > > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> > > > > +
> > > > > +err_dma_0:
> > > > > +     dev->stats.tx_dropped++;
> > > > > +     dev_kfree_skb_any(skb);
> > > > > +     return NETDEV_TX_OK;
> > > > > +
> > > > > +err_stop:
> > > > > +     netif_stop_queue(dev);
> > > > > +     dev->stats.tx_dropped++;
> > > > > +     return NETDEV_TX_BUSY;
> > > > > +}
> > > > > +
> > > > >  static void rtase_enable_eem_write(const struct rtase_private *t=
p)  {
> > > > >       u8 val;
> > > > > @@ -1065,6 +1349,7 @@ static void rtase_netpoll(struct
> > > > > net_device
> > > > > *dev) static const struct net_device_ops rtase_netdev_ops =3D {
> > > > >       .ndo_open =3D rtase_open,
> > > > >       .ndo_stop =3D rtase_close,
> > > > > +     .ndo_start_xmit =3D rtase_start_xmit,
> > > > >  #ifdef CONFIG_NET_POLL_CONTROLLER
> > > > >       .ndo_poll_controller =3D rtase_netpoll,  #endif
> > > > > --
> > > > > 2.34.1
> > > > >


