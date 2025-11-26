Return-Path: <netdev+bounces-241944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32700C8ADEA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA763358757
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4533A719;
	Wed, 26 Nov 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LVM2UgP/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bQmgfgtr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308C304BBD;
	Wed, 26 Nov 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173535; cv=fail; b=I5z38+jNL2O1z3Vpl8OHChGgWbzH9SA3dd3Whm4ohhk3ItNJJKdgFdN75eugqygaa0jvZdUHTPI+x4xv5f1y/xm8+SDBnRshMC+P1nQpZcC5EKPfD+47JuTwXEermQZ59iX0Nt7/z0WYvpYegyXHPrjcVuAalq7jv2bM+sAdGzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173535; c=relaxed/simple;
	bh=pPn/eWT2NhC/a2XgRPbpOCBreF74hcGeHzWtSrEfwHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nyifM9nExDjHDTIns/c22AaEejkkLinAUuvkcHSL1+W2toRC6nhXmaWEE1SmoilpUt3pGG7Y5MsZTj7809MG9j4HnaX5aCAgsAkV8XG7k0CgdLbC8oNqghn6dW9vRQEiqk5xZwqB3aSR6uaabmj0hrvyYpqO+G2CQeCbq+eRGp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LVM2UgP/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bQmgfgtr; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQEmWch956469;
	Wed, 26 Nov 2025 08:11:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=pPn/eWT2NhC/a2XgRPbpOCBreF74hcGeHzWtSrEfw
	Hk=; b=LVM2UgP/8LuBmwNpjZlEm/GAPEfNl2ydEyafTVk5jvh5/O2aKpfumKCQF
	Um8C/dEgQt6AnfCk4PxEph6v7xENwJBoXV4P2jHnWPXyMF/VWpBWnl1lqgzlN+zW
	tOzfXOKq+T3zvlk9OrH757fPwW5GGQ5Mh/mxHHU3TE0EnfJW0vBHzD5O+6/Mlxdn
	IGIGnlha8mwrEo73VN/b0pb06LPc8v6y3pqDsAavLxm9XjctRMI2R6DJUlaInl3v
	ike7I42O8/icVMSZ0RM4NqxzD8rdO09th+ga4ePqZrEEpr08PJeqjSqwAKaFr9NH
	UCE6YtPtUiinZPLnEyOdFxnez9Rug==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022133.outbound.protection.outlook.com [52.101.43.133])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3my85u6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 08:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8oy8L2Dv7biBB9mw2HeJFAZj7qe+82aRKNiE7iW8Zzr+lqAdO0NUISLBTq8n7yQ6lSNCksfvWxzEg2dsBCTFHprdUzhkHAto5JAZG6zTMKcg1fWq2OH7wmPxv3iOghOz/Pk8jHmP+RQWvrOuzpF3VchJHT4rOTbUMdUENT9YgUne3o6pnISclC4GoGjSzvPgmZP+xKPNI4JriicYRj2n4jik5dOIPKB+ttCTzYezesDE/ubBcU2QyxOt0rNmaYOQHOXop664gH+Tr/CUUs40AV3Hqsr/pgI7/QzWZ2GjwdJ1D9aND+/ueHutfe+aKDI/LzlsGBhV95yCQCYaapO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPn/eWT2NhC/a2XgRPbpOCBreF74hcGeHzWtSrEfwHk=;
 b=pVmpibxgS3kpPdVvO97Y2QdmQ714jCgvd20YxW30zv3lxvUkqqidjRoXJ1Vo+gfSVyDCGqMij3m94PIDjPtqqGp68oFoAVyzlDLg104j90+DE4f9rXXWmgU8yfcpcWFFM0iQSr0/tCB1mQF5WB5Yo9OdDxJB8lxLe1jQx87U2+LMfXqKx8X0ozU6NMTqKmiuHkTvIXEubmOTIvZIe55PyQl01Hn+u0t/cSkUMInSjZm0RX0DH8fuDZahISETsjicgJngffCaRJqWuAKhEASUJbSQkMYYSVk0gQ4Kr7hfkjIDpmkXG1jJ2ja4kmdF4XJyPn8tWevs2yKaVWYiKqOsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPn/eWT2NhC/a2XgRPbpOCBreF74hcGeHzWtSrEfwHk=;
 b=bQmgfgtrH0ZtZbViBTXF1+oNR1urn0psmSNsk0pNyXoQ0JGwyJ0vAEGLSmykGKokU2jjkwdG9kVdlKPRyTPuojvFvvHeGn5csXvIWLGwcX0ZVxLManYQj//Qh0tBX17E/E1N5iiX4i9UB8NPvQuF6ACa4+fhvnvf54s8KXJ4WQuaQxsdKBNMWTpjpz2FJqywfHtORmtOC8knDT1r55nf9wxzj/icpIZN8wb0ddqLPeJy+Tj4YhyEN3r56/MmBzM5t9cEQzE8Q8y3lv9OiLflnw0hg2JRD/KeyjH8siDtsOOg/cGZ3KbI/JI5FNv0pHKGqIR1tuYuyx6QRs34+CnJqg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DS0PR02MB8926.namprd02.prod.outlook.com
 (2603:10b6:8:ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 16:11:49 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 16:11:48 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jason Wang <jasowang@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation
 on guest RX
Thread-Topic: [PATCH net v3] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Thread-Index: AQHcXlTUlyOutKF1Tk+biL9fA9wOnrUEf4IAgACihAA=
Date: Wed, 26 Nov 2025 16:11:48 +0000
Message-ID: <8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
References: <20251125222754.1737443-1-jon@nutanix.com>
 <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
In-Reply-To:
 <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DS0PR02MB8926:EE_
x-ms-office365-filtering-correlation-id: d1d686ff-1033-4153-561f-08de2d0680e4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sk1Pc21Ub1cvWGZiUk5KUlNWN29pQTBqUVBidmpzRnhvQlJLamc1bVFudDZj?=
 =?utf-8?B?TEhhOVRRaE4xZnBBeC96UmlIamg1U0FDcVZTS3htZjY0eE1JV1ZRYlNaUE8w?=
 =?utf-8?B?SlE2djVXbGcySGRDT2RpZGtNNmRibTU0N0tOTUtxY3NYaVJXZUdrNEhpRWt2?=
 =?utf-8?B?dUlubmdabDlKRVlTWWdKcjJqczU4UHpPSHVFVm14S0dyNW5TTmJDUG4wSmV1?=
 =?utf-8?B?VTh5d0QvNUk2MUJYZVliRjN3cGEzRE9lRTdYbkJTaW0vZlo3OG9paHhMZkIw?=
 =?utf-8?B?cGVwN2g4bm5tZ2tpc0piNXNpbTMySlBqbmtKNVcwa2tkc0ZLam4wQ0N0SHBB?=
 =?utf-8?B?Q2UxUCtGVmZwK1liUUlielVodUVNSFNuY2NKUjlmODhGa2ZhcnQxbFBVTUlw?=
 =?utf-8?B?RzZUTlMweVFtWW1OUmlzR0ZHdkh1dDFjVnVlUjVGZDhVdGN1NVJyNXFNTklr?=
 =?utf-8?B?NFdxSDIrYi92T2pjc3BGby9va2pESEN5YWJHMDJscmZpU3huQ1hjNHQyOE5u?=
 =?utf-8?B?VkhzSVFocU1IRmZCRjVTdURVV3RReXJHY0RwNTgreE1TRXVtWStwbi9pcWNW?=
 =?utf-8?B?eGRSRjlrV00ya0xTMHlzalhEN3lsNFhxSTlCMnJyV0pDVjc1Tkp5Z3o0Vkpu?=
 =?utf-8?B?dnVMRXhRRHRVcUd4ZUxmRzdqMlcrQzQzSG5UTS95MGQvS1A2YW9SSjR0bFpa?=
 =?utf-8?B?RFlNVlVWOXlYcTBYM1pzL3U4MSttZ3ZBTjQ5UFdNNmRkZnBNdkszY3hiekdC?=
 =?utf-8?B?L2lMTHQ2ZTBPdDZsa2xXak1BN0xaNGp5Q1h5MVYyb29TUmNSWG5KNXNMVHc4?=
 =?utf-8?B?YXFnZy9FTjRMenRrbWRlN3ZEdmdSM05GeGtjQ1Era1M0V3BRclhwcW9qNlRX?=
 =?utf-8?B?WTNmQkphSWRUMW5QSEtMRXpmd3FSZVFKcktna3VNdG91eExsc0plcEpkOGpI?=
 =?utf-8?B?OHMwMjJCZUJvem9MYXBxSDBlc21lR2J0d2ovMW5UVm5oWkkzeFN6eE8wUnA4?=
 =?utf-8?B?WnNqS0N6L0Q1RVZHL25nVjNkRGlwUXViOGE1SjlOaUxxS2w3cklpVGxZVWll?=
 =?utf-8?B?Q1dDYkNBc01vdHVGUEVJVDJxMzU4bmNVUWxPU0VINDVUd3M3VXBjNEhkTHE5?=
 =?utf-8?B?bTZ4Nm1vV1BLNTVDOC83L1gzcDFVTUVJR1F6cHpCd1prbnhhZzVld3RYaUZR?=
 =?utf-8?B?ZFlLK1VTZEpzZHRVQXE4WW91UER6SEpDMVpzaENrZ3VGZDlNVTBsejRTKzZm?=
 =?utf-8?B?NzRNeUtULzFNd3pRa3VtVC9lTU9MZzREb2ZZRVZWRngyQ0JySXZYejRCbkxJ?=
 =?utf-8?B?QzByL2JMdW1zUGljdjhIS1RLMHp4MlFIYjkyNHBjZGdhOU5rbDRNY3ROSkpC?=
 =?utf-8?B?YU1uamZDV0pZT3JQYlJNMVV2YXRETVZpZ3B4RTY3QmhYYkV6Vm1IT3g2enhL?=
 =?utf-8?B?aGRSOWdLWGJOMlAxQVFOTjJjVjNMOXovOFZ5QklneVFZdjc2ejU3dHZvWGxW?=
 =?utf-8?B?K003VEI5OHAwNXZHUEk1cXR3bUNRWk5lTkN3UzhhdTNObE44TWYxUjA1aDNV?=
 =?utf-8?B?eWczbnNGd0ZramQ5a1Z6a0JsbldtUklIRzFZN1BORE45TXBjRjgyRlQ2RDR6?=
 =?utf-8?B?c1dzUmFEMmVzQ3lYVlNNa0xrWFd1WkJUZ0JaN1EvVnJxdUZBUTl0THYyL0hI?=
 =?utf-8?B?YTUrOGNjL09BUlJLZ2RYaWlkVzdxY2Zob3VvQkRtemtWYzAzRWUwNFIrcmNj?=
 =?utf-8?B?YjlDV3hFaGY5TnRpdXpmRU5oMHNsVEg4WURXNzVQWVNwU3R1Q3pHak8yaGxl?=
 =?utf-8?B?OEJnYmVOMVJ0STk3eVBIWlkxYndyaUszRmE0RFVvYmxxRFNFSkc1dlk0UHpa?=
 =?utf-8?B?dE9lT0xRSk9mMklBVnRaYUpNMzN3MW5ybU1vT1pWZjBFdDg3NkxxbWszd2Ur?=
 =?utf-8?B?YzBMZ3VBZ3VGZHhRTENrdGhqVGFoT1d6WTk4VWlmRVM4RXFmelhXZUYwdWtW?=
 =?utf-8?B?a0tycUNRanA2ZncyTUJYYmI3dWVVZE9pT0ttZExldU1vT3JodkpzVWJoTGtu?=
 =?utf-8?Q?5nSnVS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2VxZEVieGt0NmFYNUtyeGhBcHFZOWZUdmFLZWdIazhJSEhwMk9TTWtHcFFO?=
 =?utf-8?B?Wmw4TlNaRGc4SzRma05VWG5iTkxzSVBxenZaUWFVckZUTHpXdm5tS05HaURO?=
 =?utf-8?B?eU9ZYk9XNzdOdmVZc1pEOGsxK05SeVkySE5RR1dwcDJqOC9JekpYNzliL3dE?=
 =?utf-8?B?TS9jcUxuNmxVYm1YN0VWaVlEZkhyYzVGM1BmTkk4K0ttTGFEeEhIYmRZOXJ4?=
 =?utf-8?B?VTNnRnFwUXZESTY1MkJHYXBDRkJrdW13c3dJZzl2M0RHczYzNnlxazY0Wk1D?=
 =?utf-8?B?dTFzRUlqODR1K3Q3RGJ6UHRCWWwwanhldHdxdUk0MEdxaXl3RHRoSkdlaERR?=
 =?utf-8?B?bUR5MnNQVHdwYlN5MnlFT1NrVzdDT3hiRi91bzFnYmcwMHo2NWkweFlPSGpR?=
 =?utf-8?B?YlRYbS9TTkt6M1pNQWxrdjNVeXcxYm54c2hEUU4wMEE2YnpabDBBYk1BNHUr?=
 =?utf-8?B?SEU3b3dDY21DeWhhZ1B3eFkyYTdRRFVvWTJSUHFVYXhGK0hmajU0dVZYNVVH?=
 =?utf-8?B?U1poTit1WThXWlNqN0RXRmNOWTNYQzc5NlZjZ0tvb3pFSUhCUVNvVitYWFFU?=
 =?utf-8?B?N1dzZEpoVDF2QTZZOThHZll4QS9nVzA3dkpUMkQvd05POVRJMG50TkFrMXA5?=
 =?utf-8?B?NitETDRHTmhlNS9XR0VpYkpmaGhKMU5jVzFra21yMFBqT0k4a1V3YWVYbkpt?=
 =?utf-8?B?SDBXakFrcDhiTldyeVozSnpBdXg0ZDNYV3BiNFhwcWVSL0s2N2t0cGNGSHRU?=
 =?utf-8?B?VFJBYkFreVhTMkw1cm9oUEpjbTM3Wmh3ajlndWV6ZDhSRHZUZXBoMzYxOVV3?=
 =?utf-8?B?OGIwdFVLQUZtUTcvK2kxd2s5eVFEbERoOGlIOVQ1Ri9IZ0hUengwZ1ZPQ0ZE?=
 =?utf-8?B?SWY1YXRWT2g2TThEOHlDUkhyY1JIVlBQNitVdTZWQmR0alNra3crcm5mU09k?=
 =?utf-8?B?N2NNRnIvS2lZaDNkNmlKdHkrQVJDQ2lKemZaQW9MVFU4VGIyNnArcEFpWThv?=
 =?utf-8?B?OGphU1lwWGdSd1R3NVZqRlg5Mk15Yk02RXoyTTkxdWQ0WDNqcE9nZEdLVW5R?=
 =?utf-8?B?YzZOTU9lRHpKTlM2UnBHbFpYMW9ESjVmUDFiM01NNGN6VGdBV3duNXprWmpy?=
 =?utf-8?B?eU1GTnJpcWlNS3p0elJKc1VIMTBVVjEyOFdPMHY3K1N2dStueEJGdktmSnk1?=
 =?utf-8?B?MnBYRTJLdTFwa3hPUElXT0psUlVzTDVYeG5QZWxuc2s4WGhuTUxBTGpseFpW?=
 =?utf-8?B?UTR0amEwdDZDS0hhRHVwOTlxSit0eVEyT3BDWHM1MEFYUmFWZE1uNEp4UHR2?=
 =?utf-8?B?RWh5ckY4YXkyL3MyYVNYQVp2WnJVZUZpQ2xMN2tKQTc0U055eStxR1NjdFM4?=
 =?utf-8?B?K3Vmc3QxUjZoU0xyMWhUNTE3NjloNzQzbTNOZ1d1RlhXdWZBb3pMSEkwOUs1?=
 =?utf-8?B?R2JKTG5ybi8vZGo2QlNxNHpDVEc1QnhKZEFQSm9ZOUhNdjUvc3hUSXBQOUNp?=
 =?utf-8?B?TlFVWllNeXN0aC9wcWs3ZDNVNjBBMkZaS29XSXVrRHA5bUh4bVZ2UzArZG5M?=
 =?utf-8?B?c2g0RytxNUtPMVhQZDZtbFNCS1UwQndWUFNMNEhwbmxzK1FJWmFvQjBPVWpa?=
 =?utf-8?B?L1M3U0tGSXdQSFNDTnlHUERGNHhjS2NBajBTRFdyRnpQSmJBQUIxZzZnN0lW?=
 =?utf-8?B?aFZKdnhhZmQ4czZuTlFFTnFmTHpHSnR3MXE4YzNZeWJzU2tIN3N3UW5aaXly?=
 =?utf-8?B?NjdhdG9sKzUwRVZNb2tzcTNTVjhKS29od3VneDM3UjE0N2p6ckxGLzRKWTNB?=
 =?utf-8?B?ZEtEN1VQSlBnQ3kwUEFHczhTRG12dFVOcFBJa0h4NG9MMy9PVThubTRYMGYw?=
 =?utf-8?B?NlpsYklnTmlGakZvcURkTW4zK0FyeU0zVW5TdkQ0cVpqa2VwRHA5bUtBd1U2?=
 =?utf-8?B?NTUwQ0ZmcElialArWlg4Z0hHdEg0Q2dZN1VqWVhIdEpKSXh2ejlLWFRIQjJT?=
 =?utf-8?B?M3gyNEY3WTRobFcxZS9uYlMrZkVJeUFGN0RCRkRkTjZDcTIrYi9raWJFaEpR?=
 =?utf-8?B?K0JrYkFvV3A4bGE3S1I4Wk9LTFpLK2tGbnlzZlk4dStOay8wTkRkNzVlVWhW?=
 =?utf-8?B?RnBPazk4aGVPS2pUYzAwcm9hbjBSU3lJdSsvSGZjTlJOdmFGRHlOd1cwbi9w?=
 =?utf-8?B?dndnY3FZeWNlUFU5TVc5bEJXUHo5WUxZSXVuUXVka2VTYm1veXo4cmtKZUZZ?=
 =?utf-8?B?Yzc5MlZHY1VRTFRnanF6SmlnNkRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FC7AB32287F194FB6B6EAFBE179793F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d686ff-1033-4153-561f-08de2d0680e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 16:11:48.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfYjDtezV9WjOmVZsOFCVmMgclCo1sxcxsDyhrM8lMJvL7hIVIPlUVSgZS+f1nu0Wq6lt1umWjYsym2xNt+Ikv1N7rk5VjRJQQPG+zWBiX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8926
X-Authority-Analysis: v=2.4 cv=b8+/I9Gx c=1 sm=1 tr=0 ts=692726c7 cx=c_pps
 a=2IfHlQ6Ja6FpH7ZLVKJGcA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=qltdTnjbulf98eO7R5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEzMiBTYWx0ZWRfX7VhixV6WMv1P
 w6LA4Ex1vwpkF58dA1+t4c9aSGTtdpsceZeUb4/RR9+UpB8QENMzssXjdKI3dIIYzGzQNDwoYz1
 YxgQfQGky/G6rYKUF1XmAOQPFoHuBjMi/BnD11Iffy17RXnN9VxYGMqRq8lKN06f4jBB1oTIgey
 PWhuekbQoo9IBZRbXxfYcLUwfU3r9lLmb5WyqKY4Q+zGR5MDfN4tQmw2k0OcTlSxRM+6GG4ThLq
 7nN4gqC+OEiVtjf175Uis+HhRJl/r5Kzzwwr7ThnmUnjWz79F5T75mf+HZsuA5L4CQah0Pm5L8P
 XxMmI4nAshqmw+3Syd2hhvSyTXnnqYsSEns4+Gsy4Ovk8d+WqMVQ2d4W2zqeID0XmqHMAVEUyA+
 JCOOnQXpdqLXhCOsypQe/UuLsq6s/w==
X-Proofpoint-GUID: aLJlhvFD6KXWzocWclIfNDaNXifz5JL6
X-Proofpoint-ORIG-GUID: aLJlhvFD6KXWzocWclIfNDaNXifz5JL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI2LCAyMDI1LCBhdCAxOjI54oCvQU0sIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgNTo0NuKA
r0FNIEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4gd3JvdGU6DQo+PiANCj4+IENvbW1pdCBh
MmZiNGJjNGUyYTYgKCJuZXQ6IGltcGxlbWVudCB2aXJ0aW8gaGVscGVycyB0byBoYW5kbGUgVURQ
DQo+PiBHU08gdHVubmVsaW5nLiIpIGluYWR2ZXJ0ZW50bHkgYWx0ZXJlZCBjaGVja3N1bSBvZmZs
b2FkIGJlaGF2aW9yDQo+PiBmb3IgZ3Vlc3RzIG5vdCB1c2luZyBVRFAgR1NPIHR1bm5lbGluZy4N
Cj4+IA0KPj4gQmVmb3JlLCB0dW5fcHV0X3VzZXIgY2FsbGVkIHR1bl92bmV0X2hkcl9mcm9tX3Nr
Yiwgd2hpY2ggcGFzc2VkDQo+PiBoYXNfZGF0YV92YWxpZCA9IHRydWUgdG8gdmlydGlvX25ldF9o
ZHJfZnJvbV9za2IuDQo+PiANCj4+IEFmdGVyLCB0dW5fcHV0X3VzZXIgYmVnYW4gY2FsbGluZyB0
dW5fdm5ldF9oZHJfdG5sX2Zyb21fc2tiIGluc3RlYWQsDQo+PiB3aGljaCBwYXNzZXMgaGFzX2Rh
dGFfdmFsaWQgPSBmYWxzZSBpbnRvIGJvdGggY2FsbCBzaXRlcy4NCj4+IA0KPj4gVGhpcyBjYXVz
ZWQgdmlydGlvIGhkciBmbGFncyB0byBub3QgaW5jbHVkZSBWSVJUSU9fTkVUX0hEUl9GX0RBVEFf
VkFMSUQNCj4+IGZvciBTS0JzIHdoZXJlIHNrYi0+aXBfc3VtbWVkID09IENIRUNLU1VNX1VOTkVD
RVNTQVJZLiBBcyBhIHJlc3VsdCwNCj4+IGd1ZXN0cyBhcmUgZm9yY2VkIHRvIHJlY2FsY3VsYXRl
IGNoZWNrc3VtcyB1bm5lY2Vzc2FyaWx5Lg0KPj4gDQo+PiBSZXN0b3JlIHRoZSBwcmV2aW91cyBi
ZWhhdmlvciBieSBlbnN1cmluZyBoYXNfZGF0YV92YWxpZCA9IHRydWUgaXMNCj4+IHBhc3NlZCBp
biB0aGUgIXRubF9nc29fdHlwZSBjYXNlLCBidXQgb25seSBmcm9tIHR1biBzaWRlLCBhcw0KPj4g
dmlydGlvX25ldF9oZHJfdG5sX2Zyb21fc2tiKCkgaXMgdXNlZCBhbHNvIGJ5IHRoZSB2aXJ0aW9f
bmV0IGRyaXZlciwNCj4+IHdoaWNoIGluIHR1cm4gbXVzdCBub3QgdXNlIFZJUlRJT19ORVRfSERS
X0ZfREFUQV9WQUxJRCBvbiB0eC4NCj4+IA0KPj4gQ2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVk
aGF0LmNvbT4NCj4+IEZpeGVzOiBhMmZiNGJjNGUyYTYgKCJuZXQ6IGltcGxlbWVudCB2aXJ0aW8g
aGVscGVycyB0byBoYW5kbGUgVURQIEdTTyB0dW5uZWxpbmcuIikNCj4+IFNpZ25lZC1vZmYtYnk6
IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPiANCj4gQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IA0KPiAoU2hvdWxkIHRoaXMgZ28gLXN0
YWJsZT8pDQo+IA0KPiBUaGFua3MNCg0KSXQgY291bGQsIHN1cmUuIFRoaXMgbWFkZSBpdCBpbnRv
IDYuMTcgYnJhbmNoLg0KDQpXb3VsZCB5b3UgbGlrZSBtZSB0byBzZW5kIGEgc2VwYXJhdGUgcGF0
Y2ggd2l0aCBhIENjOiBzdGFibGUNCm9yIGNvdWxkIHNvbWVvbmUganVzdCBlZGl0IHRoZSBjb21t
aXQgbXNnIHdoZW4gdGhleSBxdWV1ZQ0KdGhpcz8=

