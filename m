Return-Path: <netdev+bounces-106886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC97917EFD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABC9B284F3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1917D347;
	Wed, 26 Jun 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BnJQ9U4R";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZTGqcW7f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SbyadFgG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DB17B50B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399267; cv=fail; b=l+2dlDnmtpvNmHBqk9qh8i+OvYR3/y64nbrJvi+LKvJB4vFvoON3bcFY5y3hRIPxHqeJ4Yr97+l3W7ufPDFRkOPeZsjVrLCW79O96QsAZLVV5kLoSzvxLB3DeF215u8fzXlx1y36wosgwcjDlQb/yuIFYzyjgrOZi10p5E0vG74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399267; c=relaxed/simple;
	bh=Ym9G4iTsvDufdtKTBQy+s5cx1SAZBBlcIstF3HvYyx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmNsChTEPmEHl2sT/qd6sXldD34vOu6K8LDKKdSoDz0C8ScwqqRvElY2mTOcgh1Gc+tb4/RQE0daNU+C0kO+9FfDLuMwi6jAT89y2ydBmtoFU2fPktoU9hPHJgarIc2VFvG3XX5994oepwFBVFuF+2qy5QYXVbbaP08p+hQFxSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BnJQ9U4R; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZTGqcW7f; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SbyadFgG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q7T556023549;
	Wed, 26 Jun 2024 03:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=Ym9G4iTsvDufdtKTBQy+s5cx1SAZBBlcIstF3HvYyx4=; b=BnJQ9U4ReEBm
	A8GAnmdfTlv4vvrpXe/yKBfPtzeHWpeVxscLIRQFPJcAw7mozl6zEWkxmhz4Ns8Z
	fYDgZWfBbphCglvRNIG6wp1qG/vyNzhyOA8yyDsb1L3VeHjQPocKCw9cjL0RvR8U
	4t/+mOU0TqFGLDDVkkAAzyeZeAtWXxcG828rgo1FfcJUs1coWFnjLEKWCsBiYMe9
	DFE5P47Cjh/e+gDVgSNcdeIETzN0Q5q9gU5z2o6GGs5n62EoUt3ryn2VpOF+Iavu
	k8tDcrH1onIpI/JiK1U8MMGcKTecIV2+Ttt0XVPzWuytKEVHoAQxyGZo1LX3ounJ
	yTo39O1M4g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3yww8cqv5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719399254; bh=Ym9G4iTsvDufdtKTBQy+s5cx1SAZBBlcIstF3HvYyx4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZTGqcW7f1jwfugFDK23iZVjATfXJNECkN05Fumlulov9g14WVladcaJf0YpK4LnQ8
	 fDqlZkkWgaznW+RMWxRiVrMjeI0cq01bvYlRAHT41CWzaEH2Rk0c+hADWd38xVwRul
	 7v1MFCBpz+u2zSS6JDIKSjeTwsYbCgF28ckidHck2QTUznYj9kJngshD8Hudve0dQG
	 PgQDXC+gUcXuriwtCNWlLaS4C8DOTizNivmqAgvtQVKDLUVK5HztFqegQXWQJdsO0D
	 F4U8q6twesdnGAd84dSzbsd+z3ZRGYEN8kZSBgRt8QwC8mAd1ZHlYoMH8dQ5RHc65v
	 Nhfb6zUhaGnlA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B17C74035A;
	Wed, 26 Jun 2024 10:54:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 897AFA0095;
	Wed, 26 Jun 2024 10:54:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SbyadFgG;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 02BAB404D7;
	Wed, 26 Jun 2024 10:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgMA7SnfLuWLkXzs/22HlE9KzhccBDWHd1SwTaGIpTjc/1eLRToRwQaEhr2KEPA/qMqIGGt2CgiQmtsg5eoXFdpdgg1NnbLpP/+TpCtF2TgATsQIpw/D/qPwzhasnbvv1IBmNhRbCbI4b+C3oBnSFbFl+omaPvyIDjCMlonHGP5wqmW8jhjgrshNXQUfn6lQbnO/ZlDuZJWWTYSqYyQIe1KIfK1L4jQLAzhcEEWgU35MEydnUcjvOaZkt50GV20z2VOkOoHSRrx71+gJbjlMF9c2ynM8z5EJH0+EAxkRT87VYI5O4TVDH2NR5iw4TSCuhLHtWdQyY6yxUCwgjpIrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym9G4iTsvDufdtKTBQy+s5cx1SAZBBlcIstF3HvYyx4=;
 b=mBawOvBgKozh0BhX9zyfczb4vlZGwC0B1zaXFcj7wBrnAAxlyBrqKxSC3kKZ8rZjNgjQjA7/BxqbTvB4/jYBcZ2oB2FLPxA/CdMyI9QkIg+d5BDpFS3tPXZpdElhkkrGUD5TppA3OTguJYXToc4I0iyTbleEuU/rTrDIxudkU/kFV1qnScr900gyiI+0XhMU2UTEII96f0ov5rTriWnpj/lpWsIU0NXev14grW5X8W2LRjbYDoqxFIrjSiYav0Bi4wq7BLPdA4HVEv52ZB12w6GB9CgHwNAYPs45LtF4aWrBmGlQcbzDGhHewBtx9p5yK81Ke8kvVQf36BHXAnayaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym9G4iTsvDufdtKTBQy+s5cx1SAZBBlcIstF3HvYyx4=;
 b=SbyadFgG7ihiOlxcE9J5qX/AaUmJP4yZ4p5R0GNs8KiQ6VUWK8bt20qCHvTg5WGB1NuVsJSNUrRtsv2hCVcvblK71HYKoppWzGjav0BBHb//VL594jBHxsi0urqlU0zGy3Ucfo3WjzlRH2w3nG4gLAa2CMRJ/EUS7ngXiNxaLw4=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:54:09 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::f02d:bb07:127e:8849]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::f02d:bb07:127e:8849%7]) with mapi id 15.20.7587.035; Wed, 26 Jun 2024
 10:54:09 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev <netdev@vger.kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: STMMAC driver CPU stall warning
Thread-Topic: STMMAC driver CPU stall warning
Thread-Index: AQHaxhiNJUV7nkEVGE6MRUK8gdfZU7HYMypQgAAFVYCAACzNUIAAM3mAgAFJAyA=
Date: Wed, 26 Jun 2024 10:54:09 +0000
Message-ID: 
 <DM4PR12MB5088B2F2D3A1E8AB1FB34424D3D62@DM4PR12MB5088.namprd12.prod.outlook.com>
References: 
 <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
 <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com>
 <DM4PR12MB50886C5A72024A6F5D990F86D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vwaCt-hspXhdrVSKzTYDnpn6ppHpGcpbD5NSgiQrGeTA@mail.gmail.com>
In-Reply-To: 
 <CA+V-a8vwaCt-hspXhdrVSKzTYDnpn6ppHpGcpbD5NSgiQrGeTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTY5MDA4YWMxLTMzYWEtMTFlZi04NjY4LTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFw2OTAwOGFjMy0zM2FhLTExZWYtODY2OC0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjE1NDAiIHQ9IjEzMzYzODcyODQ4MTAzODkyNSIgaD0iRXl4L3Ewak9aNTVDdEJLVXlaQkJiTTVLUFBzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: 6b0d3a87-4302-4f35-603a-08dc95ce4eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TmdTZ3dxVVY0VE5QV2tYY3h4c3FrdC92UU80c05rR2wwQ3p4emNoRmRuWm56?=
 =?utf-8?B?c0hLOVR6VHRrWlB6ci83MGlEU2tseVBPQTVtajA5YU5XRGFmbi9uczNmOHdx?=
 =?utf-8?B?ZDBCR2hjRzNJY3ZLV0RVdVpMZlp6aldoVldrZUVIeDJCejZYTkg3NWNQelB3?=
 =?utf-8?B?K3NIZmVGZ2dhSE13K2FFamRXVGtrZlBkNWhJaTlibk5JYU1NczZKK1pITHRQ?=
 =?utf-8?B?QWhDOTQvdVFQSkIwMFJQQ3VsKzA4cGtLSGJ1bERpZndVWVhSNW9nNWY1YkVZ?=
 =?utf-8?B?ZXlsVStkT0JHMnk0QXBWR21SQkRpQ0x1K3ZhVnVvUy94c2hFQ2JrK24wUGZk?=
 =?utf-8?B?WHZjekx5Mnl4a2pFTmFoWW5adnQ4czJSK1orbWFnTjRRQlY1U2JtU2I0eTdV?=
 =?utf-8?B?Uk4zODFzUnNtVmY4QTRYbTFVSHhBZDVhMGdXRnFkWkUxRXZsdC9taWlXK1d4?=
 =?utf-8?B?UnZCL0J0N1Z6cjIrMkZqQzBFem83ZElSZFMwdW5seWdPMTdsM2lCNUk1Y3BR?=
 =?utf-8?B?Z3J0V1hBeTdZeTB0UnpRYkxhY0Frc1BtL3puL2ltcVhBTUswZTR2SXFNSUdu?=
 =?utf-8?B?cm9mUmNTY2ozMEdRSWgzYWkwV25zcmt1c2VXeC92U1FvalJPbkdVSGhtNVRJ?=
 =?utf-8?B?Tk5wQzVlb1JORWhSN2hxbm1WaWx3aDJxbDJyTDhjYTlGUTVkdTdwak80ZnBH?=
 =?utf-8?B?dURXSEE2Q3RaempvTTNTVVhyRTB6Uk1JZ1RRN1EzZGRVZ3ZJcXlDQlJISFBU?=
 =?utf-8?B?OUQrbzRWZU0ySnNMYzY2ZnpmQmI0SnlHUXdoMmQ5RmZLZ1ljcEpFaVpPQ0l2?=
 =?utf-8?B?Tm5XMUpLdG51SzBmQ1NNUTFOK01Lcm43WHd2c3RrU3FGL0RyNDdzcU5ScVRq?=
 =?utf-8?B?c0g3RFZSUVMzcDlwdGN0VmErOTJ3ZjZhd0hkbncvaFFBTjh3N2ZVVjFHUURE?=
 =?utf-8?B?NW9kYndzUGRHTXovYjB1Zy9xaUJlMnhCV054cVJockRVYW1IUDVzakFDaVlJ?=
 =?utf-8?B?MjgreHQrVXJuM0FpcEZXclJnL05JZlU2eTY2T0svSHdwZzZtRXhtMUVPbDNH?=
 =?utf-8?B?V0Z5UnVGaGI0d1hudlprc2drMzZrQ3NyNTI2a1BqcS94Q29UOXBDNDR5amRh?=
 =?utf-8?B?WmdsTFN1TnB4a0RIam1YRElLQjBSdm1tdmtXTnEwRHhtUjdYcGYwb00xNElN?=
 =?utf-8?B?cTBFbWRyMjBEMUlZZlF6VDFUZzhJdVhncmhWWWk5OTRuV1Ftb0xwYU81bWEx?=
 =?utf-8?B?UE9LaEVUazJyTDR5bkVuYUZXby9STUxMQnc5QkNodXRYT0xWTHpRNjN5NnNz?=
 =?utf-8?B?Ryt3YUwvd1NrbnZaREpuVm41aGVSRjdVZzd2RThFNFVMM3dCQXdOc2tBK05t?=
 =?utf-8?B?TThLVjVGSkR6RkxOWUZuTUZmcXYwYW5aMFZUZVJWYjlTVHRUV000YWxmeExF?=
 =?utf-8?B?RGpSOHdQVVgrSW9veTA1WlpVZ0V3aFR2Wkg5bjRvSUEweE1EKzRoMFRYQi9p?=
 =?utf-8?B?MUl1MG94NHNTZ1N2ZGpMUklsOHJMSy9wM005NmdpNGNpdUZLc3BGZnZORXVP?=
 =?utf-8?B?MDJwUXo5NmoyVXRQdkl4enpKL2xsNUhORFV1RTFHRWlOVmt5OVZkQ3l4YmFQ?=
 =?utf-8?B?N1VZSUJPNXE2SHVSbGsvalBBWlVwTXRYaFRVVk9FZ1RUR1ZvdUh3Q1BudUxh?=
 =?utf-8?B?M21wcjlub0VrUXEvcDhCS2ttOC9OU1hQVWp4QmJGUCtJdXNVSi9jVjFaemds?=
 =?utf-8?B?NGNnOXgxMVVZSVFYeWZnendGdlJudlNxdTJqaFBrcGIwSVRqTVdsemdJOXpa?=
 =?utf-8?Q?bm6NJEIPZmXAGrVdyuAVzuQP/DYziSJdl70wY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ync0M0tSekdvRjdOK21iYndmRkpXNU5HcUtTWDFCUWh3YWJwRFlKak9hMGNu?=
 =?utf-8?B?TUREUHdTUmRDV2RSZCs5RzFPcHNDd2JlREFPRm5Fa2VOK2N3TCt0cG5LSFFY?=
 =?utf-8?B?Z1ZtdUpTY29hNlIxazVUZEZJWGc5Z05MUlBTRVEyZm5MS0RBTEE2Z3o0MUhr?=
 =?utf-8?B?c2o4SGVaM0NMYXBwTjlQRjVzd3RYajdlUG1IZ09zejR3UmhDTEdlNDZiemJw?=
 =?utf-8?B?V0E0TXlGdmdZY3Z0OXo3VHo3WTA0RUVrcTRjcWRabWdWQTBuRDVaaGNGVW41?=
 =?utf-8?B?NlFDUkFoSENmUEZRdG1ieWJ1U0FRcXROS0hkRG92V1VyYjhMbGI3aHRwQVNC?=
 =?utf-8?B?NmROS1BaT1c4Zko1VnQrQ01UaDN1M2FGeTlJQlpQb1lPQThsQitZbzkxRThp?=
 =?utf-8?B?SzNHY2xwakVVSUc2blZwYkd2YXFDSmlXeVhFYVhBT1h0aDhVcGd1ejRocUc3?=
 =?utf-8?B?ek9QWktOM1J2eUNPRllxODJkOWk0YW9CNUNWNXhDZ3VHKzh4MnlBcS83bXdY?=
 =?utf-8?B?SG5Cb2srY0JId0hiV05JVnR1emY2NTd5cnFyZTFSRWc4LzNCMmkyYm5ybktD?=
 =?utf-8?B?Zm9IdE14dDBkRUxaZHNlU1dJS29MdHhwVCtxbUk5SXNpMGFkSmgxU0NheDF5?=
 =?utf-8?B?Q256alNDejRPTGxhV1hhbXNDWkpPV1ZPb3FCaUtyNTR3VFdtUGJBZzc0QWlY?=
 =?utf-8?B?VXhiSFZMeTJja29wd3JsbnRoU3MrdklyUkR4K3BjOFMxNWFXOGpxTUVaTUpu?=
 =?utf-8?B?Y0VuaFM1VHlObVBWdTRUMzhodUwwTHBteDUvZDZiMEhiaDNZMXl5UUxWMGdM?=
 =?utf-8?B?bG95TVBUZkJuc1k0RFVoamMwaWtPeUdibG9IbDdKVkYyUUltRDRzZUk4VFNH?=
 =?utf-8?B?M1EvK3IrbUQxU3dyR0hsNUt6dEY3T1pOb3dOUlBXWThKQ1VSTUdWWXhncDkx?=
 =?utf-8?B?VCtXc3dqNzBUT0l2bmNxMmZ4RGo0Rzk3bG1lZmUzTEpCVWRmaGZDcnVkd3BW?=
 =?utf-8?B?L2d3OEtjVjBsNkhDakRTSXBDb2tRbnZQcWszZkJUTGYxdGhMUEFJZGZ5Vk8z?=
 =?utf-8?B?OWtheWpSaXJoMDhJcEdXZkJNTlRjTzZhdFM0ZVJlejlnN011Ritybnk4NERW?=
 =?utf-8?B?T1ZQSkwyZnBabytzUlZtb2hhaFFKajh5K3l5TDNXTG0yNDhMakhaZjhSNG5v?=
 =?utf-8?B?OVpCMkdVUndKMFJoTkgxcHUvSmlwTFFPZ1IwZ0NaaDJCc1Q4dThDNDZnU1E0?=
 =?utf-8?B?QjIrTGF2VnZxRUVjTkZXckthNjNIcXJ6aExSV3VCbUZNZ0ZibmRBSitkL2VT?=
 =?utf-8?B?aUl5eGpxdHBKekZiU3RJZUxrMzRVVzFzMkxoRHNIbll6MENncGQ1UDJna3hk?=
 =?utf-8?B?NmJFUTZZNFVjakxnVWRRUlZnMStKOXdKNjBQTytsRmx4ZEdkQjdOdXZWSTlH?=
 =?utf-8?B?Ulg0WnRsdXdnUUtYdHRJTmxPWW9xbTRJM29GMUw3eGxEWE5USElvUHYxRTRD?=
 =?utf-8?B?TytMR3R1WURIb1NPR2RnRDI4Nk1ab1RTbCtJb2JuYm5XRWpFM24wdWQ3TXRU?=
 =?utf-8?B?U0RhTFNveEp0SDY5emFmdENHMGdQOGYxb1Y1UXU0TzR0RHVEMTY0SUdUQnJz?=
 =?utf-8?B?R0dWS1V6VElOcFlMek1EcWpTOW9WTkJES0VJY2VJejl2SDFtQ0V2bHpZVWkr?=
 =?utf-8?B?c1AzNU00Z0pwUzE2YW9zR0JURHNLcS9hY09zV0lqZXlteVNYSk9JUU5UTFVC?=
 =?utf-8?B?MEs4S2E5ZkNxdVlQNWlSbFQwMFRUVU53RCtUMCtncUcwL0laOWpFWWxCcWZ0?=
 =?utf-8?B?Vlp1VXNNUTQ1TUh1K2VnTHlmKzg3Mkw5UUNkQUJoMmFwSFEzWWl4aDRmLzdu?=
 =?utf-8?B?WHBocVJORE9zUktIdmt3SFFkZm9CWklHd2RVT3EvclZXMXl5ZGFadEpKdHVy?=
 =?utf-8?B?dVhzOWxtUDVnNnp0MzZBR0szOVI1aW05YjF1dTVPSzllSEpQMlROUEszeWQz?=
 =?utf-8?B?Mm1VMGJHR2FhbnRzNURmaU1sZmFDbGVMQlVSek5hQWpuQTNNbjhyU21ZeHpv?=
 =?utf-8?B?ZjcvaVlNWWZiWXFFeVlCRHVhWGZ3eW05VDlQdHNDcjRSbUQ2cTV3VTR1cG5h?=
 =?utf-8?Q?dl61jsRmIJCAfpKzctmhoKwbN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3asa1dNFap1bj3QAknm6WC/uJt4/EFLUkV8lMJT2ymvsLpmifTWOxhvux9kJqTjjqjtG6BV+lr64TiTjNw1iwyXuuTs7V/z7qWV31mhTREsRDGoCRguoQryYN//k/bdWGjN4AOccjw04CABrx6TvENj8fXQLHWE1yudp8/z1zj1wVYqKdo7UReLPD601da+CzqgOksdwj8DEUmg/JXtu/yru4h9qc7+tKb1aDaGZCI6QhrbSzOigv6jVthSNwJRotdQxx1SfOKTUHPVx9mk24wrKpTFWw+ChgXTgs/PInGuuzuDsqogTuUmXEIpBL6aSnmRAS3XGbcyZJhUw3CL5hcq5lu9A9Pn4p6dsbJxDmAyKK6LBWl5qyk6gHHv3Ctf230CYPwz6ZCX8OHvyvpuvgk+ymTPsHH9m1kH2vYOjkRz3wsY+WdV/ZiOMAombJH+au5pjHJsc5RNwQiobT2FPddg5ngBLGa8jIzUXYi+DevjfuZNdd1uREQ5PKYJ3KKmIFuLogh9klveWBwiNksAqKgqNBHEipFLjBdKKNyEAWniELqqq5cTxlHMvNYAnD8908tNTYCj4sMyYus0bIiwNdCteFzgqDHKyoO6/jcyeJRp8ArGTms/PXx/kUMUbnp4C3GYhehJ1hEWDk6FAdTVkjA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0d3a87-4302-4f35-603a-08dc95ce4eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 10:54:09.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZlBqngVvuHT3EdY+LhtYoVU1BpFgB5D97s3swJs2HL72AdcLcU+74jmp4CHgXkCMDif5skqiAZXIe6lwUz3Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
X-Proofpoint-ORIG-GUID: pdAHoJRlyTBVooUOvhYcGT75qt2B0Qmw
X-Proofpoint-GUID: pdAHoJRlyTBVooUOvhYcGT75qt2B0Qmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260082

RnJvbTogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KRGF0ZTog
VHVlLCBKdW4gMjUsIDIwMjQgYXQgMTY6MTU6MTUNCg0KPiBIaSBKb3NlLA0KPiANCj4gT24gVHVl
LCBKdW4gMjUsIDIwMjQgYXQgMToxMeKAr1BNIEpvc2UgQWJyZXUgPEpvc2UuQWJyZXVAc3lub3Bz
eXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IExhZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIu
Y3NlbmdnQGdtYWlsLmNvbT4NCj4gPiBEYXRlOiBUdWUsIEp1biAyNSwgMjAyNCBhdCAxMDozMDo0
MQ0KPiA+DQo+ID4gPiAgICAgbXRsX3R4X3NldHVwMDogdHgtcXVldWVzLWNvbmZpZyB7DQo+ID4g
PiAgICAgICAgIHNucHMsdHgtcXVldWVzLXRvLXVzZSA9IDw0PjsNCj4gPiA+ICAgICAgICAgc25w
cyx0eC1zY2hlZC1zcDsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHF1ZXVlMCB7DQo+ID4gPiAgICAg
ICAgICAgICBzbnBzLGRjYi1hbGdvcml0aG07DQo+ID4gPiAgICAgICAgICAgICBzbnBzLHByaW9y
aXR5ID0gPDB4MT47DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gICAgICAgICBxdWV1
ZTEgew0KPiA+ID4gICAgICAgICAgICAgc25wcyxkY2ItYWxnb3JpdGhtOw0KPiA+ID4gICAgICAg
ICAgICAgc25wcyxwcmlvcml0eSA9IDwweDI+Ow0KPiA+ID4gICAgICAgICB9Ow0KPiA+ID4NCj4g
PiA+ICAgICAgICAgcXVldWUyIHsNCj4gPiA+ICAgICAgICAgICAgIHNucHMsZGNiLWFsZ29yaXRo
bTsNCj4gPiA+ICAgICAgICAgICAgIHNucHMscHJpb3JpdHkgPSA8MHg0PjsNCj4gPiA+ICAgICAg
ICAgfTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHF1ZXVlMyB7DQo+ID4gPiAgICAgICAgICAgICBz
bnBzLGRjYi1hbGdvcml0aG07DQo+ID4gPiAgICAgICAgICAgICBzbnBzLHByaW9yaXR5ID0gPDB4
MT47DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPiAgICAgfTsNCj4gPg0KPiA+IENhbiB5b3UgdHJ5
IHRoaXMgcXVldWUzIHdpdGggcHJpb3JpdHkgMHg4Pw0KPiA+DQo+IFRoYW5rcyBmb3IgdGhlIHBv
aW50ZXIsIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoYXQgZGlkdCBoZWxwIChjb21wbGV0ZQ0KPiBib290
IGxvZyBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXN0ZWJpbi5jb20vNUZr
MHZtd2FfXzshIUE0RjJSOUdfcGchZFhsMk1YcnYxUFFlTmxBbFY5LUUtZ0VCZ0VGMnhOUE9XVUM4
cENhMFdGb3I5aEMtS0ZSSUpsOGNsazd2MXNMZ3BBZVJlSTBjZkg5d05PSHJkSHFQMG1pMHNEZXZ4
USQgKQ0KDQpPay4gVGhlbiBJIHdvdWxkIHN1Z2dlc3QgeW91IHRyeSB3aXRoIGp1c3QgeDEgcXVl
dWUgYW5kIGNvbmZpcm0gaWYgaXQgc3RpbGwgaGFwcGVucy4NCg0KSWYgaXQgZG9lcywgdGhlbiBt
YXliZSBhIGJpc2VjdCB3aWxsIGhlbHAuDQpJZiBpdCBkb2Vzbid0LCB0aGVuIHlvdSBoYXZlIGEg
bWlzLWNvbmZpZyB3aXRoIHlvdXIgSFcgc2V0dGluZ3MuDQoNClRoYW5rcywNCkpvc2UNCg==

