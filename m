Return-Path: <netdev+bounces-105660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B89122D7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B9B21156
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16296171679;
	Fri, 21 Jun 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="sDkDzh/X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945183207;
	Fri, 21 Jun 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967278; cv=fail; b=uwjuiLbJ2faSYThjYfFenH9uWU+aggjLfDz9b6M45o6l1y9Y/GVEtVrmJfk1aGq6YYLWVOximgugA2cFFM2HDGJWN5XXXp/WwnGycNEFEZkMPB6J3eB2GEIPpvdqAURE8lP0a9G/LaFziWaDGhxADPzAXcLQ/fOFmFSMl9MI2BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967278; c=relaxed/simple;
	bh=h52com0wK0feCgGBZz0+YWrUW+k3FH4gmmWOKctIvQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ubSo8nVrOANBJCZgoNyrUrLMw4GtZcTKPZYUI9h6YX098EyYJNO82pUoNlWvt3A+VETfAY5/N6hf1hVEMMnsQsu+p0Jk5Q3GR269KqcOF5re4F/1jbSQInOFutqaxfdwsr6kogov45iS8D+wpuCnSKJxJD02RrwpFDUOYBb2A20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=sDkDzh/X; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9LYrt008778;
	Fri, 21 Jun 2024 03:53:53 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yw6t8080b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 03:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pif9PMptxC+j9bDJo7dQyMyQ87b8KwGuCgVKe5kIM4toh6/4qy4yuXNHMgiARcAuilapvJASortin0r51R5c1Ly4by1jhxqfied2TVj9l2lrpvO5RBHFkVH/Fa8jeHa5tXsJ8o6vtJBCzSBrL8RPb7qLP/0NT/ipXBgP1s6b13DWRpl8rU7+EH857L+otLlCFseofSqkxlGxAWVP9VI1QRmlFkZLMylusITFJXQBxM1iabqqbtMGbPhfd0zAZHnLO90tYqQmyoA/vmzYofzddlibpcOORyZu+A7oe/bSNVa+uBHnb2sB7croad1TvMpDU3vJrd/+40EkHMryhvqhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h52com0wK0feCgGBZz0+YWrUW+k3FH4gmmWOKctIvQE=;
 b=LaYhhaZ1dbRcwCTZ5Cxx0RHLzLAJpTMeJ811Fqopnisit0HFYHy5IOZVXgA3WYZsifBsVCbuLmSxvGtu7Ktduzq51t36jN4j1eAahAfip7bIgo0FESEk41NAublerWQNb0HgOxKQRtyZuhsqqjvvqY5+rKBkYpQFiKZ+HPgFcLrf97XjxlZ+LKXPlcfJGU6OzDDIFq877Pvkz4nT9noSL0L3Vdt3fNcZ4JEUFpTk0mJ7WZiZFt2n8ho8eqJk7LWTOMrbu+jWFVnqIilx9XWSxlqdXeowfkZvnb4+lcZJjWp25tqf846SOYlI/dGr90It48sgncawgVqVyzgiVw7g1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h52com0wK0feCgGBZz0+YWrUW+k3FH4gmmWOKctIvQE=;
 b=sDkDzh/XcK3poM+v89ORh5+FdyLdk+JjzXmdDVSr72Qp01kpVuy48oiiOyIA00a0u19KQKuM5zm3OuQhf3aUPOTLSffym1NttPKqKqQInG0sN8HPeYbmfhd45/+OahGjy0dulbcc5eN7stNXfcX/hNq/FIftl1/IFZKMq2iC/Rc=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SA1PR18MB4597.namprd18.prod.outlook.com (2603:10b6:806:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:53:51 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:53:51 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: WangYuli <wangyuli@uniontech.com>,
        "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>,
        "joabreu@synopsys.com"
	<joabreu@synopsys.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "guanwentao@uniontech.com"
	<guanwentao@uniontech.com>,
        Wang Zhimin <wangzhimin1179@phytium.com.cn>,
        Li
 Wencheng <liwencheng@phytium.com.cn>,
        Chen Baozi <chenbaozi@phytium.com.cn>,
        Wang Yinfeng <wangyinfeng@phytium.com.cn>
Subject: RE:  [PATCH] net: stmmac: Add a barrier to make sure all access
 coherent
Thread-Topic: [PATCH] net: stmmac: Add a barrier to make sure all access
 coherent
Thread-Index: AQHaw8lNZhplgX4tGUSVGK59EDHVFA==
Date: Fri, 21 Jun 2024 10:53:51 +0000
Message-ID: 
 <BY3PR18MB4737007F602F43294EFAF36EC6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <F19E93E071D95714+20240621101836.167600-1-wangyuli@uniontech.com>
In-Reply-To: <F19E93E071D95714+20240621101836.167600-1-wangyuli@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SA1PR18MB4597:EE_
x-ms-office365-filtering-correlation-id: 8cd201a4-f183-4065-8d0c-08dc91e06faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|366013|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ejhkQjdzTitPRjFsQURMVTlNNldqbDhYYm5YWmJoQjFITmZNVnpVSzF2cEpr?=
 =?utf-8?B?bzlIM0xzUWErQitDQUwyU1JaNEI4Titja3Vhd09FaTUvakxoRU9QN3NYdENO?=
 =?utf-8?B?R1NLdTZqTS9vUWhFM1RwK3k5MWdnWHdOdUVhQTk2UEV6dFJPYTVZcEJLWVRJ?=
 =?utf-8?B?VDFud0pZWGNubGZWelhyOWNhQTNpdlhjWjFueUFlRWFyc0pVcUtWVy9HbDVQ?=
 =?utf-8?B?aURmOGxkNGp1c2ZIR0VSdVU2bDc2Q0pwTlBrVUhydjZ1a013RDUyRHZhdmx3?=
 =?utf-8?B?aU1QcEVVVWN6UGZOb1BWckhCOXhmKzY0M2xRUExqcXhDcldrYzFOcHViVTln?=
 =?utf-8?B?ekZtbHlNZGtGMDkzeEF0Z3J2WjdJNkc1aFU4NkNqTDcvd0cvVHpKcU5LVWIx?=
 =?utf-8?B?ZEIxVW54eTlTRXZEL1pMZ2NhK1IwV2RFeDhyY1lRY21QK05vSVBkUk1mMS9u?=
 =?utf-8?B?dHEwTkU5bVpoR1M3WFRmaUpld2JpOGJYdFR3ellIZFI1VkpaSzdiT2UzNy9W?=
 =?utf-8?B?RkIwcE1xbEh3M2NlYjVnTTBNWFBSeXBTTzJIRGNUZVUreTRmTzQ4U211R2hi?=
 =?utf-8?B?YTZNcmlIQ1czQS84V2w4bVY2WUpwL2wyTFpCdW1pSUtuUW9wOVlqTWFkZTUv?=
 =?utf-8?B?Zm4wdjNVTk5PdzlNTy9wYi9wb3c0ODJlRnVzbFVrc1hCS2s3cTBJUlJBV0Fx?=
 =?utf-8?B?eTM0ZGNudGRDNXBhSXJ2aHBQbzdVdVpNd3luZ1poTUNqcmNvNFlHM3pxaUtJ?=
 =?utf-8?B?TUt1amxCY3l6WGhjOFdDY08vQXJOYjFSL3drMUhSMmJjTjZzUERraUlYczE2?=
 =?utf-8?B?OHorK2pmaUk5SUxhZ1JFcndXSGFoVURvZVEvbWRWRjZOOGJtMXR0a0xhS3lp?=
 =?utf-8?B?Y1U4bHpUVndEOVRRQkRUTDBQbWsycXRCNkZHWjdsdDFoZUZiL2dOcUZtK1ls?=
 =?utf-8?B?QWVDV3dYV1hGYmlJWVA4a240cEY5cWVHSXhRdkZacFZpeXFacUZTcjRUWkUy?=
 =?utf-8?B?TDg4TXlndmF3MDVGbjAyYk9OcDZLVjl2R2F4YXFvS3NtNGpzbE83R2VnODFF?=
 =?utf-8?B?ODg4ZTVPV3ZKSC9YdDRTdDRlQWtBK3RjVWllWG0vc3QzN3JuaUhmbmxIQjhX?=
 =?utf-8?B?YzZRVlEwTytXSzIwUlBIL0hHQ3pUMU5EeDByVW13ckhGMUFmaThvS0QrdFc0?=
 =?utf-8?B?emN6akRUbnNTdDVWUEt3N1dFZFlnRDBHeEhVU0toS01DeE5zSVFyWTRmM1B6?=
 =?utf-8?B?dmpwbzRMOWlMb3NFSGIrdVVwdTFkYkpKVkVnY2s3S2pwcWM3MTNIQ09aWG1X?=
 =?utf-8?B?eWZ1SHAzT2NQVE1tSDJuaE92TjFqMHZYaFFOb3FDSDlQSGJiVEtnQUYwOUdp?=
 =?utf-8?B?RnJsRWhyWlZicnNYY3FIZmZtYWFTZHg4U1lVNWNCMzZlY0xmTGtTN3pPVXlQ?=
 =?utf-8?B?bTNkT0dRTTlFMUIrSlJxNDRuVFBCeWRXczkyOXRqcWtaZWpIa2FRc0lEN2Nz?=
 =?utf-8?B?aVFnL0FpVTRKL2daVGl6Y3lEV3g0eXZjSk8ySjZqRVdtUkZ5YzBweE5mMDNa?=
 =?utf-8?B?ZEFjSlJpd3RpQzNYVHhiOTVwVXlnZjVqS3dyY0pwNEUzVEh0QjJkNDYvM3BY?=
 =?utf-8?B?cU5TWWwzdjRoRktkRlBlSS9OenY0OVY4L0syc1pZQ21VUkR6WG1WVElPOHVj?=
 =?utf-8?B?OWYrUERjd20wSERySjFCTVNhOXpIby96b2ZqK0NyaXAzc1dKbTdibTFidWNF?=
 =?utf-8?B?R1FxRnNxY0x5dEs4Wk9NcmlvTmZKaWhFZC9RenlyZmJ0T29jckFkRlM1RFU0?=
 =?utf-8?Q?WDv0At7SOelBC/u4rbKVZeqkBSARxyPZ6Y59I=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZkJMVE1ySjhwVmpGbnZKRGxrbG85UklqOVl1OStqYlFwdlpwampGcVF6M1M4?=
 =?utf-8?B?WkRES0xCR0RnNjhTKzltSGVyTG93WkZEUXJobkZ5b1Vib0xweVBZaFFqUE9Z?=
 =?utf-8?B?WUxtK2lpVzVQUW1OTXlIUFFjNmdLTlF0K21RbjJnSU1HT0labXVIVXg1TVB1?=
 =?utf-8?B?ci9yY1VQTHFqZWt5a1UvQW9JVFpvWXhmUjRCMmh0MzBHZjQyc3lyM091UENs?=
 =?utf-8?B?M3dCazBGU1dHT05UWGxIV1p4QlVyQkt4bnMyRlVoTXFEc1prZk9YR2JJazZa?=
 =?utf-8?B?V2hEd29JVTUvTE16MDFmQXB4NS9QSEV5UjVEYmV4eWIrRGZPTXhEc3V2WVVx?=
 =?utf-8?B?VnhmN2RmMlc5ZC9xZzU1d3B5V3piVkVLaUFHWWpTYTRsOG5VWHFtQlk4ekIy?=
 =?utf-8?B?Nno0QUkwWklGclMvQlhRYlorRTFpdHpXM2JvdGQyS1U4MHB5YlhYalcxWWMx?=
 =?utf-8?B?T0lTUjZUaHdtRCt5UjZoSWFtdktQdVo5RFR3L3E5cW9zcGhLUmpyRlN2K3hz?=
 =?utf-8?B?ZWFZTmcxd1Vrd0NUY1pucmh5UGZjQUtueVV3MTEwYjFFRElSVHZRNlpwdDlm?=
 =?utf-8?B?U2hGZFB5eHZUeEc1dEE4MHJXNUNJcno0WmdsM2dxbFlZeUtSVmJaNmc1OWFN?=
 =?utf-8?B?dk9TaUZJUEc5YngzMWh6YmxWS0gzUjQrRDRseFlKdGRmTDZ5ZmJZNmZ0Skwy?=
 =?utf-8?B?bjFtQzBXWU1mbTJTaU9IMkxIa2tJRUQzbXJYbW10RTJWTlVSanc2MnFRMzZx?=
 =?utf-8?B?d1gxV1ZTakVGMDdyN216S1FvdUJJY3p4VE43UGhUZkhUVVE3dEgwWG5CSXpa?=
 =?utf-8?B?cU41eFUyL2F5YStmMDdEaWp3SDBndVdlWENOSnliMTBycGYzS1BhbUlUR2wx?=
 =?utf-8?B?S1M4UEpIaXJVQ3VuUnE2RXlWdm9HOE9YcEtycXRMNWtINDU1YS9RemEyeUlD?=
 =?utf-8?B?b2kvdkUzdmtTQjFSejFnUkNvNk1VeEVBMTlSSkhhZk5CRjliTG5KenRYd0l0?=
 =?utf-8?B?bzc4YlpKQXlrOEpNcHNIVUpyZmxjdWxTQUE4UnRoOThkVDNrQUpFczhseU11?=
 =?utf-8?B?QXhsb1FYdzNNdHkrUUN0bFg4eVIyYUQ4QmF3LzlvUjlWUW9mWUZFMTA2eCtv?=
 =?utf-8?B?Q0NYM0JERzMxWlk2L0RoVHRINElMaGNIWXhOd0x5R2FtdGNybnRrNjRkWUZ3?=
 =?utf-8?B?aFowTTc0cVV1dFlqME9OaUVnMENhcGNyTlE3OTJsVzZvWllscms0U2FWMExH?=
 =?utf-8?B?NTNqOG1TTVkwZUZFaTZsNUxMMVVuVkJwZEtkNHV4RzRhdGVLTm93djNTNmRN?=
 =?utf-8?B?K2lsRGlBcnE2N0pZTDJmS0FYQm1IL1NJVFA1Q0NSWE85UUlVcHplVHBlczdY?=
 =?utf-8?B?Z2xscURmSFo5NXNhRjlyTFlsT20rRTBsc1JJMHAyL1hDeGJMQkRON2NObW5G?=
 =?utf-8?B?SW01YnA3dXZ1dUFYRzFHK25nbkZqb1puMWxoU0VlbjhvUkV3R29WQkJaOHlW?=
 =?utf-8?B?ZEx6eW5tbzloVG1sZUZ6VFJZT3ZnVmtVVW1oVWhZcmpTU2locVRsTGVFWlVj?=
 =?utf-8?B?ZWorSWFJSTVpWDAxNnU0b3B2RWpwamtQa2hPRkJzSlBaOG1xNzRUS2hkSXgw?=
 =?utf-8?B?VEh1NkRWaUVHemNUR0ZiVVJJUDRzSmNTSGpyczFObk9tdHJPWWlkMmN5aG9F?=
 =?utf-8?B?R0d0RVZ0clVPd21tWFcyWFV0bFFWNnRUck5hcW5GdmpxQ096Z2UxRGMyemZ5?=
 =?utf-8?B?WDlGNy9YU0cvd1dsK1RmVXd4WERWb25adWUvZEEraVdmSE5zL1hqbS90d1cv?=
 =?utf-8?B?Z3NpVitPSWErelNIVS9RRG45TnRHKythZFRmSVArbjNlaGdlZ2p4VmVLTmJO?=
 =?utf-8?B?THhPbWV4bWVDc1A1ckhzR2JrVDRmeW9qdDVCV2V2a0l1MkxGSEl1VWhhV1lB?=
 =?utf-8?B?Nml6SDFWOWEra3VEblNVSmsweGFHcG1hS3VrN01zeXd5dm5JeWQxRXQvSmNQ?=
 =?utf-8?B?dE1QUHFMSW9JYkc2a3kwWk95alJDaWZkaGdCZnk3MHFuMFVZclQrb0ozcm1K?=
 =?utf-8?B?QVpONlNPYjlidG5BWFVaYktQc1FneFU4NmZPY2VTSmxXam5vckJQYkVYNzI5?=
 =?utf-8?Q?G2+adHrq3ZWkGDMBvRnP5q6Lf?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd201a4-f183-4065-8d0c-08dc91e06faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 10:53:51.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIFAoUBGGFUjLqAnh/jOEYFYa5xmu6UoL/Jyz+u/CwVSwuUwCmLs8qT3s5z/MBbysq1+2W7BAZIljZGleYFkxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4597
X-Proofpoint-GUID: 265OdJEoAOv49vhqczaTuqpXmIPlWwW1
X-Proofpoint-ORIG-GUID: 265OdJEoAOv49vhqczaTuqpXmIPlWwW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01

DQo+QmVzaWRlcywgaW5jcmVhc2UgdGhlIHJpbmcgYnVmZmVyIHNpemUgdG8gYXZvaWQgYnVmZmVy
IG92ZXJmbG93Lg0KPg0KPiAgKi8NCj4gI2RlZmluZSBETUFfTUlOX1RYX1NJWkUJCTY0DQo+ICNk
ZWZpbmUgRE1BX01BWF9UWF9TSVpFCQkxMDI0DQo+LSNkZWZpbmUgRE1BX0RFRkFVTFRfVFhfU0la
RQk1MTINCj4rI2RlZmluZSBETUFfREVGQVVMVF9UWF9TSVpFCTEwMjQNCj4gI2RlZmluZSBETUFf
TUlOX1JYX1NJWkUJCTY0DQo+ICNkZWZpbmUgRE1BX01BWF9SWF9TSVpFCQkxMDI0DQo+LSNkZWZp
bmUgRE1BX0RFRkFVTFRfUlhfU0laRQk1MTINCj4rI2RlZmluZSBETUFfREVGQVVMVF9SWF9TSVpF
CTEwMjQNCj4gI2RlZmluZSBTVE1NQUNfR0VUX0VOVFJZKHgsIHNpemUpCSgoeCArIDEpICYgKHNp
emUgLSAxKSkNCj4NCg0KSWYgdGhpcyBpcyBhIGZpeCwgcGxlYXNlIGFkZCBhIGZpeGVzIHRhZy4N
Cg0KICAgICAgICAgICAgICAgIC8qIFByZWZldGNoIHRoZSBuZXh0IFJYIGRlc2NyaXB0b3IgKi8N
CiAgICAgICAgICAgICAgICByeF9xLT5jdXJfcnggPSBTVE1NQUNfR0VUX0VOVFJZKHJ4X3EtPmN1
cl9yeCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBy
aXYtPmRtYV9jb25mLmRtYV9yeF9zaXplKTsNCg0KQWxzbyBkbyBwbGVhc2UgZWxhYm9yYXRlIGJ1
ZmZlciBvdmVyZmxvdyBwcm9ibGVtLg0KSXMgdGhpcyAnIERNQV9ERUZBVUxUX1JYX1NJWkUgJyBk
ZXNjcmlwdG9yIHNpemUgb3Igc2l6ZSBvZiBmdWxsIGRlc2NyaXB0b3IgcmluZyA/DQoNClRoYW5r
cywNClN1bmlsLg0KDQo=

