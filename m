Return-Path: <netdev+bounces-147564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECBB9DA39A
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B5B1640BB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413917A5BE;
	Wed, 27 Nov 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mipmj/tj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEFF9DD
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695120; cv=fail; b=GB55Ed5WNNwcEdyclcTKZyMxZYt4TWYmkbOFkBycG5g83PycktB5uYK/UfLBVwGmrrQPrjiriqNAGq/gaRa52GV5ZgP6JzchMkXN9yeAK1pwVOInPu6v/vsEYjOaNi1kMgvOKogjRywUxmxqINEkPVhTV2+7UF3wDapCZifkaoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695120; c=relaxed/simple;
	bh=45KS6GnNJCu6f28uE8Co8VO3Q7FWgN3+fEVILII8fTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dwR/RL5vx0w1rCzIN5t6iSctURGDaVQyVCV+6eT5Kd7A/AvaYmbQtiO0R9C4v+gqGSukEbk8sFfjVQJh3w3yLiXAdycHoFKM6QMNbXzBGziudAZGj+mQP3AHSmzN+4FlUcfcefQPPW+SJDQDFHur3UJ6R+awI+FtpgiGpwxjhiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mipmj/tj; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkNMqYMv3g0JxXOo4jWJFzdRF6Y0KZe/TIKvPkpOlflhPx+LiDahliG4cuKTBs2XwRI6/DrRAt0tKWIHNfg7WfY29mf9rQnrK/I7M/KpfCPkoUfp+KH9U0kfVLUd3D590iJqZhLFOk92NvwrqpvXesMevMBVyjzlGoLqTDUmbLOR+RxwppP2mWX8JcIqp1YBA2eZwSHeO2F0uLjxxeky/8OI+9+o/3sG1hrsOssuptlsbZOE/VkO2fpcDBGpoFgIVPW2iS5VuRRW06/J7wb6/SFdzATUQgpv/+uHg6QgwCJCYSAq8EsV5e8860TKeFqY+eUnMZq5erG7uOHidhzFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45KS6GnNJCu6f28uE8Co8VO3Q7FWgN3+fEVILII8fTU=;
 b=fNjjWwkF8fiGE0NaVCC8kjAkIQPCQuyQaik+zm5wrzeDhUoAJPMiw2Fq4D5Fs1mfGd+S+CylVDqU8LcsSyQe3ZRKsQc1+uczWco+N/odsB+wfbxtAjOnAuUD5JlfxDeK9vFacHEHKZ8pSKYTHFjdqLfASfuZC52+EUCK5mlE4YV7fJVeMe8zvzuAkAd6neE9PBxpo+JA9eGVIfSWQ/uZzXnqtzBYTahA4SVK8pox2GxepnGv3Rn3q0g3kiqldWV07P1xchKH+sKPa1pMoA83YChCS3nP5odiQ8kT+P/mLiCUH6jxnV55/Z2jEJmIY4DysluocdWZV5m2HthOs2rC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45KS6GnNJCu6f28uE8Co8VO3Q7FWgN3+fEVILII8fTU=;
 b=mipmj/tjFe/hMzokD8QISLUiP5tk/l/hJnCvc0cEt7eSpaZoGnQwle84t8LnaNcYSJZVY/3vHGCzeiZefkMNDuhcLMqUYAddTe5uMUeAAYFzRUE4E3vrSZtADiNR8c43Anm7WefkzulMisgvfw+mcDlImP53cg/hRAA4dE9CgbM82iyksXs0FRCgzFDqKj+gFMn25T7k9b66BvWT744mLX/+8FtsKyten2fVA0eefNRplSQ3HH3ul3e/miLgJuA/F9chtaLw1PNU3Uej3DF0cGxsakAn1DdzrsXZHzWyH9fq6axP4vuVenbJteXSDasD8qgXqlJ3tdYkkT8LrUMN8A==
Received: from MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Wed, 27 Nov
 2024 08:11:54 +0000
Received: from MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418]) by MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 08:11:54 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index: AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNA=
Date: Wed, 27 Nov 2024 08:11:54 +0000
Message-ID:
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
In-Reply-To: <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4517:EE_|MW6PR12MB8759:EE_
x-ms-office365-filtering-correlation-id: fae416c3-7624-4bd2-387b-08dd0ebb2797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akdkRHhOTG1iL3RMOWl3VmR4NGJodGtrSFVRakZiN3lIZ2dDNHYzNTg5cVh0?=
 =?utf-8?B?cmhDanRma1pBdTNoUmRDMmd3NzErWFR6SkdWTjBSMzQ0Wk9CLzhDL1N2MkMr?=
 =?utf-8?B?OFVVWmxpNUdNVzMwUFZyZ3pNWm1aTmJBUStPaXJwUzZWZGxkVGp1dEZ3VFln?=
 =?utf-8?B?ZkNFaHN4OFVNZllXb0pxR29uUGhJQVhwVmhEN3R0NlAzQjRIRkRBaUJlZHZ6?=
 =?utf-8?B?NU9QNW1MZ1N1M2EwK2pjSE1VaVVWUTRVaUlzbEZJKzF3N1VpMDk5M0ZuRU9K?=
 =?utf-8?B?RG5xT0RCTTFZN0FNbWNWdTBDNDF6dlo1UDVzMlRKcFpjUXZEUU9GSUk3NlJP?=
 =?utf-8?B?UHBhSmdnaVdKbzRNWlVHb1RoVEV1a3pJbk1BNG1tQlFwNG9GSVhTZzFHSVFN?=
 =?utf-8?B?QjNXZVJNNHFDbVBVTDB0MGo0ck1lVmFPTGdOc2RFcSt0T2J1NHF2OEZzaE5y?=
 =?utf-8?B?OTA5QmpZSTVZOGRJZ090aTJaMWl4Z1l3REFHamJQQzhKLzlkb1cwaG03NWts?=
 =?utf-8?B?NEpUYWlVSjYwSUxkWTBwMmNUN2NkSG4rbDZMQUpQL2NwaGlDRE03UTRnN2Jn?=
 =?utf-8?B?blpPbW5wSUZaZ1dyWFRyd05oY0hWaVVpZDlqdm9xZWNoMXdDT295RUN2L01U?=
 =?utf-8?B?bnUva3NJbldKazQwSFFtUTA0eWNpam5QN2lwdkxKZTF1UmhyUFZqY3R3NHpU?=
 =?utf-8?B?TTdXeUtFTFRyQnpDOHY3bzBmOGx4Vkt3NUE3L1hMamhnZzdHNDdvb2VqTlcy?=
 =?utf-8?B?S1hNV08wbU9LbXFXUzRucko5Y29PWVFIdmJ3U2JGaFVLb1VXSTE1a2diaVZE?=
 =?utf-8?B?ZWRRMFpjdzMyanhCNVZISFZ1c1BpM3RrYUVDdzVrYkVncEFtVFNZUG9GblpQ?=
 =?utf-8?B?aVd2eHZWaXZqck5WTmxGQlJmRGhEMFJhd3FPR0I1NzFQVE9teHFXbVhtYzgx?=
 =?utf-8?B?MlVGVVRGZDVsc2FXRnZkWERPdGcwdDB2VW8reDU2blJZeUhGemQwM0ZCQlNQ?=
 =?utf-8?B?WGduaytFYUtUcmQva25ieStnK3lac1JSQlNNS3lxNWxzT0dMODZkd0tBc1dr?=
 =?utf-8?B?ZzlPR25lS1VvbmxnUDJGaWdTMm1hSW9Ldm5xT2FiZCsrWlZKRE9Jd3dDWTdj?=
 =?utf-8?B?eDFqWHFLS3dSS2c3SG5ESUdheDdNVGRmV1N5Qjhob29zWDN5enludFpYa0pN?=
 =?utf-8?B?YzNYZ1hRL1lXUEV5Y1pGb1BMZXhVMFZ5ODYxUUVPanRkTHBKY0c2clRqbDVZ?=
 =?utf-8?B?cnQrOUJVMVJka2o2TlI5b1JTUFpCYzJ6elVWWHZBaTc3bHhSMEgybEJlYWs2?=
 =?utf-8?B?T3VhOFVVY25MdEcrTllNZXhvTjIxYkpxZFBNZGplM2xYREtBNUZZenNoQWdS?=
 =?utf-8?B?bXFzcGRKMGx4THBydFU0MEhxNk16bjhHRkdLN0QzdUFuam5EZWJHOFdibjJH?=
 =?utf-8?B?ZlYra3VUSWtVeklwRGV6ZlJzTUVPY2wyb01jMnVXU3lqd0pwUHJBakVYVlRO?=
 =?utf-8?B?UjdNVDFaZFFaamloVXlaT3gzZWF4ZG5GZnB2R2Z3WFE3WTFMcnVCNHpKZktv?=
 =?utf-8?B?Y2tySkYwVFNJQ2V5TE1HL0V1cEdiK0NlaXlleWJOWkxTU1NlRjVCZ0pYbkRk?=
 =?utf-8?B?M2lFcEVKUFFFMnpCamFVQitkaUJiOE96bkM3NzF3R3RLUC9Yd2swR0ZQZ1dE?=
 =?utf-8?B?bWFOeGEyc3VZOFFNS2lDZGRsWG9sdSswMGMvVzg5YXpCZ3B1eE9aZ1h5UmhD?=
 =?utf-8?B?a21nQmQydTJlMWY2RHRWWTlFUEY4SXAyTjhyajNWZFFMVWppK084TXlsbC9D?=
 =?utf-8?B?Mmk0V0VtY0xFMkdGeVk3ZEgyTGZodFdwMHBiVE91SUxZaHA2STRXKzJwRExt?=
 =?utf-8?B?YW53Rmc1NWVxUTd3aGlqUVpTYU1TWGhVSnFSS0t3V3pKR2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW1FVlRNeVJBRlh4M0FXcEtINkpNWnI5M1piNEJTQU04dE1HcVFZN3ZaZ2do?=
 =?utf-8?B?dnQ0T3hFVFhYb0tzWWQ4RktoRXpUeE5IOGljN2oyZGNxN3VRUHF3Q0YyZFla?=
 =?utf-8?B?NmxTaGdwQ2dJM3VralR5aW1hYWRIenhTQ2VLUlVIRzI5UTB0VU5IM0U2RlBh?=
 =?utf-8?B?Wm0wNFFjczBnUkNRVis1cVhZaXpXV0piWjlxRzQvZGpheExUSTBtQ2VTdzY3?=
 =?utf-8?B?ZXNMZmR2OVFLMUFhNWJ3RGIxUlZ5ZElzdUhDYy9na3FSb3d4TlNPUW10UDRx?=
 =?utf-8?B?MnJReTF3KzhKTlN1M0pGdlFPM043NEVDTDMvVm85cSthVUZhU3VVcmFJOVYy?=
 =?utf-8?B?YUJlZTI3RzNuMXhvdDY5R0VvTjhRd2g0TnJneVo0WnhMR3Q5Z0hydFhDcVZS?=
 =?utf-8?B?elBCd2F1OTVTT3BoL3c0RU9Yc1dLTnhmcExtYnJNK0czQWMyNFFQb09DeWdG?=
 =?utf-8?B?QVJCMlhRcjFmNGh0WmdrMUhuSFphZVd0ZTZmSmMxT05VdlE4VE1icHdxR1Rh?=
 =?utf-8?B?eUoza0s5Mjd1b1JFSTFKMlZ1cE4yUDZleERkVTR3b3Y4RTZPTS8rNVFhQ2M1?=
 =?utf-8?B?OStQUCtmZW1zUVdaRXdKeTNBcnd6MFFJcXBGQmIva2dlbzVsaHUwdnhpUmFI?=
 =?utf-8?B?Y2Qvd1N4TW9ubDlEaFpnS0lrZ1JWWFUvNEZtTlJXME9PSUE3dGlnampKMlYv?=
 =?utf-8?B?ZjJXUThRb3hhd0g4dFpyYVg2b0ljbkFLOHpMWUZsb0lEcytXMHNIWTFFL0pE?=
 =?utf-8?B?NU1YQlFERE9temdjUEpTODU5dFpjQXg0TzlQSU5SekdMRHNmVmFxOFFDanF0?=
 =?utf-8?B?MWJ5Q2x5MFExd0U1ZEtNUWtlZmpDVXBKb3BMYkIrcHc5eXE0OGdXR3BUTDhn?=
 =?utf-8?B?b2l4eGl1ZDd4VGRZU2liL3dEZnd1ZG5nNVlGV2ljR2dCTDRkRVZuNmxiTTFB?=
 =?utf-8?B?T3VUWFVpWUZWdHBxNEFlaytmVWpRSzlHcWV3aHhHMmE5THZVYURUdFhaQ3lF?=
 =?utf-8?B?Z0RTNWVMVzZtejNFcDZ0bjlvY3NONjFrN1pNVU9SekY4ZGVRdlp5ZFlCK2tR?=
 =?utf-8?B?d0VINTRJY2dlZis5TXZDWU45Sk1xOGowVmQwUzVLSGltSTQ0VVhjdTdRS1N1?=
 =?utf-8?B?aDhOcUkxdytuUS96YVVHT2dGZ2JVLzFBSHl5NnlXRTdYTUN3STBrWUlINStI?=
 =?utf-8?B?MzFERVpETWphWlZyaWg4VkVtclczcEV1ZElTVys2MmxoOHhrSFhrcGN6Q3Yy?=
 =?utf-8?B?NnB4bWJKaUFacUVLWDJRMXp0Uk81L1ErN3pnejUrQmMwZ0JVS0k2bEdIWU1T?=
 =?utf-8?B?MW9JelFEdGhZQjdqL2dJd29vcmtRU0VlRWtoeDhCekRDQWtoalpTYjdaSnFY?=
 =?utf-8?B?dURzZ0dKZVpFWFdFemt2Rmx5T2MwQis0emtQM3g0K2JhMUtBKzFXWnlDVVRD?=
 =?utf-8?B?ZEpjeG5qeG1wdXREV0MyVC82Vm5ubGptVWd1TWJJdW9RSWgvdzhXUmtadm5V?=
 =?utf-8?B?UHl3R3RIdnMvOUQ1aGgxbkVNd0VlbEVmbDY1NWpubEhJb3g5di95QWMwNUJV?=
 =?utf-8?B?NVZrVEt6cm5NVCtKcVBBa1o3cXc5d0R6dUdYOUkrOElpMkxoL0JlMjd0Yld1?=
 =?utf-8?B?OFdzZkpyOTZhS3piNUkwVEdvc2tod0xnMXc3ZjlTNUkyYlVISCtlRHpzTi8x?=
 =?utf-8?B?VzJpYTBTYzdUOXdURUpWWDNsQVU1akFIakJPa2J3RGZuSHViVmxacXUyaTkx?=
 =?utf-8?B?YjJ6WU5iblJDZksvTjdlcHVONWRrZU9oZTAvRUN5RW5zVGxERlN6OHNkUWFr?=
 =?utf-8?B?NzFsWnVXTEJMT05PQWtQSkhMUGFUSW42cUZ6dFN4RWxKMGRUVFEwSGZrdVEw?=
 =?utf-8?B?Q09VdkRlRzJXQ1JKSmdsL0I4NWNwOEJLYXNucitoYURJMVhPYTJPOG5QMFNt?=
 =?utf-8?B?elR0L3l0aDg4MWRDb2VvNXgvNmE5WUxvMWMrVVVXbVJxYjU1MWx0aXcvRnlH?=
 =?utf-8?B?Z1Bkc2RCRVNaTUlDNEN1SVhIVUdRMlhzL0sweEo1NmcvMUdlVUJGRWhLNHQz?=
 =?utf-8?B?Yk43b3MwbzVrQUcrdTJBb28zVFgxblJpQUYwb3ZsdnhhTDlrOFJWeGRhNW9E?=
 =?utf-8?Q?eFQdwNlNRCQa4gbNRcOVEzFLs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae416c3-7624-4bd2-387b-08dd0ebb2797
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 08:11:54.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGCSuaIMjOby6217AZ9fAPl/CoM7EomNH5iiq6XMJ5Aueh3PK+2H6xjlGjs6LV7MJq6PWV/7IIitLhyEhFyj4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759

SGksDQoNCkkgYW0gYXR0YWNoaW5nIHRoZSBkdW1wIEkgYWxyZWFkeSBoYXZlIGltcGxlbWVudGVk
IGZvciBib3RoIENNSVMgYW5kIFNGRiBtb2R1bGVzOg0KDQokIHN1ZG8gZXRodG9vbCAtLWpzb24g
LW0gc3dwMjMNClsgew0KICAgICAgICAiaWRlbnRpZmllciI6IDI0LA0KICAgICAgICAiaWRlbnRp
Zmllcl9kZXNjcmlwdGlvbiI6ICJRU0ZQLUREIERvdWJsZSBEZW5zaXR5IDhYIFBsdWdnYWJsZSBU
cmFuc2NlaXZlciAoSU5GLTg2MjgpIiwNCiAgICAgICAgInBvd2VyX2NsYXNzIjogNSwNCiAgICAg
ICAgIm1heF9wb3dlciI6IDEwLjAwLA0KICAgICAgICAibWF4X3Bvd2VyX3VuaXRzIjogIlciLA0K
ICAgICAgICAiY29ubmVjdG9yIjogNDAsDQogICAgICAgICJjb25uZWN0b3JfZGVzY3JpcHRpb24i
OiAiTVBPIDF4MTYiLA0KICAgICAgICAiY2FibGVfYXNzZW1ibHlfbGVuZ3RoIjogMC4wMCwNCiAg
ICAgICAgImNhYmxlX2Fzc2VtYmx5X2xlbmd0aF91bml0cyI6ICJtIiwNCiAgICAgICAgInR4X2Nk
cl9ieXBhc3NfY29udHJvbCI6IGZhbHNlLA0KICAgICAgICAicnhfY2RyX2J5cGFzc19jb250cm9s
IjogZmFsc2UsDQogICAgICAgICJ0eF9jZHIiOiB0cnVlLA0KICAgICAgICAicnhfY2RyIjogdHJ1
ZSwNCiAgICAgICAgInRyYW5zbWl0dGVyX3RlY2hub2xvZ3kiOiAwLA0KICAgICAgICAidHJhbnNt
aXR0ZXJfdGVjaG5vbG9neV9kZXNjcmlwdGlvbiI6ICI4NTAgbm0gVkNTRUwiLA0KICAgICAgICAi
bGVuZ3RoXyhzbWYpIjogMC4wMCwNCiAgICAgICAgImxlbmd0aF8oc21mKV91bml0cyI6ICJrbSIs
DQogICAgICAgICJsZW5ndGhfKG9tNSkiOiAwLA0KICAgICAgICAibGVuZ3RoXyhvbTUpX3VuaXRz
IjogIm0iLA0KICAgICAgICAibGVuZ3RoXyhvbTQpIjogMTAwLA0KICAgICAgICAibGVuZ3RoXyhv
bTQpX3VuaXRzIjogIm0iLA0KICAgICAgICAibGVuZ3RoXyhvbTNfNTAvMTI1dW0pIjogNzAsDQog
ICAgICAgICJsZW5ndGhfKG9tM181MC8xMjV1bSlfdW5pdHMiOiAibSIsDQogICAgICAgICJsZW5n
dGhfKG9tMl81MC8xMjV1bSkiOiAwLA0KICAgICAgICAibGVuZ3RoXyhvbTJfNTAvMTI1dW0pX3Vu
aXRzIjogIm0iLA0KICAgICAgICAicmV2aXNpb25fY29tcGxpYW5jZSI6IFsNCiAgICAgICAgICAg
ICJtYWpvciI6IDQsDQogICAgICAgICAgICAibWlub3IiOiAwIF0sDQogICAgICAgICJyeF9sb3Nz
X29mX3NpZ25hbCI6IFsgIlllcyIsIlllcyIsIlllcyIsIlllcyIsIlllcyIsIlllcyIsIlllcyIs
IlllcyIgXSwNCiAgICAgICAgInR4X2xvc3Nfb2Zfc2lnbmFsIjogIk5vbmUiLA0KICAgICAgICAi
cnhfbG9zc19vZl9sb2NrIjogIk5vbmUiLA0KICAgICAgICAidHhfbG9zc19vZl9sb2NrIjogIk5v
bmUiLA0KICAgICAgICAidHhfZmF1bHQiOiAiTm9uZSIsDQogICAgICAgICJtb2R1bGVfc3RhdGUi
OiAzLA0KICAgICAgICAibW9kdWxlX3N0YXRlX2Rlc2NyaXB0aW9uIjogIk1vZHVsZVJlYWR5IiwN
CiAgICAgICAgImxvd19wd3JfYWxsb3dfcmVxdWVzdF9odyI6IGZhbHNlLA0KICAgICAgICAibG93
X3B3cl9yZXF1ZXN0X3N3IjogZmFsc2UsDQogICAgICAgICJtb2R1bGVfdGVtcGVyYXR1cmUiOiAz
Ni4wMCwNCiAgICAgICAgIm1vZHVsZV90ZW1wZXJhdHVyZV91bml0cyI6ICJkZWdyZWVzIEMiLA0K
ICAgICAgICAibW9kdWxlX3ZvbHRhZ2UiOiAzLjAwLA0KICAgICAgICAibW9kdWxlX3ZvbHRhZ2Vf
dW5pdHMiOiAiViIsDQogICAgICAgICJtb2R1bGVfdGVtcGVyYXR1cmVfaGlnaF9hbGFybSI6IGZh
bHNlLA0KICAgICAgICAibW9kdWxlX3RlbXBlcmF0dXJlX2xvd19hbGFybSI6IGZhbHNlLA0KICAg
ICAgICAibW9kdWxlX3RlbXBlcmF0dXJlX2hpZ2hfd2FybmluZyI6IGZhbHNlLA0KICAgICAgICAi
bW9kdWxlX3RlbXBlcmF0dXJlX2xvd193YXJuaW5nIjogZmFsc2UsDQogICAgICAgICJtb2R1bGVf
dm9sdGFnZV9oaWdoX2FsYXJtIjogZmFsc2UsDQogICAgICAgICJtb2R1bGVfdm9sdGFnZV9sb3df
YWxhcm0iOiBmYWxzZSwNCiAgICAgICAgIm1vZHVsZV92b2x0YWdlX2hpZ2hfd2FybmluZyI6IGZh
bHNlLA0KICAgICAgICAibW9kdWxlX3ZvbHRhZ2VfbG93X3dhcm5pbmciOiBmYWxzZSwNCiAgICAg
ICAgImNkYl9pbnN0YW5jZXMiOiAxLA0KICAgICAgICAiY2RiX2JhY2tncm91bmRfbW9kZSI6ICJT
dXBwb3J0ZWQiLA0KICAgICAgICAiY2RiX2VwbF9wYWdlcyI6IDAsDQogICAgICAgICJjZGJfbWF4
aW11bV9lcGxfcndfbGVuZ3RoIjogMTI4LA0KICAgICAgICAiY2RiX21heGltdW1fbHBsX3J3X2xl
bmd0aCI6IDEyOCwNCiAgICAgICAgImNkYl90cmlnZ2VyX21ldGhvZCI6ICJTaW5nbGUgd3JpdGUi
DQogICAgfSBdDQoNCiQgc3VkbyBldGh0b29sIC0tanNvbiAtbSBzd3AxDQpbIHsNCiAgICAgICAg
ImlkZW50aWZpZXIiOiAyNCwNCiAgICAgICAgImlkZW50aWZpZXJfZGVzY3JpcHRpb24iOiAiUVNG
UC1ERCBEb3VibGUgRGVuc2l0eSA4WCBQbHVnZ2FibGUgVHJhbnNjZWl2ZXIgKElORi04NjI4KSIs
DQogICAgICAgICJwb3dlcl9jbGFzcyI6IDEsDQogICAgICAgICJtYXhfcG93ZXIiOiAwLjI1LA0K
ICAgICAgICAibWF4X3Bvd2VyX3VuaXRzIjogIlciLA0KICAgICAgICAiY29ubmVjdG9yIjogMzUs
DQogICAgICAgICJjb25uZWN0b3JfZGVzY3JpcHRpb24iOiAiTm8gc2VwYXJhYmxlIGNvbm5lY3Rv
ciIsDQogICAgICAgICJjYWJsZV9hc3NlbWJseV9sZW5ndGgiOiAwLjUwLA0KICAgICAgICAiY2Fi
bGVfYXNzZW1ibHlfbGVuZ3RoX3VuaXRzIjogIm0iLA0KICAgICAgICAidHJhbnNtaXR0ZXJfdGVj
aG5vbG9neSI6IDEwLA0KICAgICAgICAidHJhbnNtaXR0ZXJfdGVjaG5vbG9neV9kZXNjcmlwdGlv
biI6ICJDb3BwZXIgY2FibGUsIHVuZXF1YWxpemVkIiwNCiAgICAgICAgImF0dGVudWF0aW9uX2F0
XzVnaHoiOiAzLA0KICAgICAgICAiYXR0ZW51YXRpb25fYXRfNWdoel91bml0cyI6ICJkYiIsDQog
ICAgICAgICJhdHRlbnVhdGlvbl9hdF83Z2h6IjogNCwNCiAgICAgICAgImF0dGVudWF0aW9uX2F0
XzdnaHpfdW5pdHMiOiAiZGIiLA0KICAgICAgICAiYXR0ZW51YXRpb25fYXRfMTIuOWdoeiI6IDYs
DQogICAgICAgICJhdHRlbnVhdGlvbl9hdF8xMi45Z2h6X3VuaXRzIjogImRiIiwNCiAgICAgICAg
ImF0dGVudWF0aW9uX2F0XzI1LjhnaHoiOiAxNiwNCiAgICAgICAgImF0dGVudWF0aW9uX2F0XzI1
LjhnaHpfdW5pdHMiOiAiZGIiLA0KICAgICAgICAicmV2aXNpb25fY29tcGxpYW5jZSI6IFsNCiAg
ICAgICAgICAgICJtYWpvciI6IDQsDQogICAgICAgICAgICAibWlub3IiOiAwIF0sDQogICAgICAg
ICJtb2R1bGVfc3RhdGUiOiAzLA0KICAgICAgICAibW9kdWxlX3N0YXRlX2Rlc2NyaXB0aW9uIjog
Ik1vZHVsZVJlYWR5IiwNCiAgICAgICAgImxvd19wd3JfYWxsb3dfcmVxdWVzdF9odyI6IGZhbHNl
LA0KICAgICAgICAibG93X3B3cl9yZXF1ZXN0X3N3IjogZmFsc2UNCiAgICB9IF0NCg0KUGxlYXNl
IGxldCBtZSBrbm93IHdoYXQgZG8geW91IHRoaW5rLg0KDQpJIGJlbGlldmUgSSB3aWxsIHNlbmQg
YSB2ZXJzaW9uIGFib3V0IHR3byB3ZWVrcyBmcm9tIG5vdy4NCg0KVGhhbmtzLA0KRGFuaWVsbGUN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgWmFoa2EgPGRh
bmllbC56YWhrYUBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMjUgTm92ZW1iZXIgMjAyNCAy
MzoxMg0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBJZG8gU2NoaW1tZWwNCj4gPGlkb3NjaEBudmlkaWEuY29tPjsgbWt1YmVjZWtAc3VzZS5jeg0K
PiBTdWJqZWN0OiBSZTogW1JGQyBldGh0b29sXSBldGh0b29sOiBtb2NrIEpTT04gb3V0cHV0IGZv
ciAtLW1vZHVsZS1pbmZvDQo+IA0KPiANCj4gT24gMTAvMjcvMjQgNDozMSBBTSwgRGFuaWVsbGUg
UmF0c29uIHdyb3RlOg0KPiA+IEdyZWF0LCBzbyB3aGVuIEkgd2lsbCBzZW5kIHRoZSBjb2RlIChp
dCBpcyBpbiBlYXJseSBzdGFnZXMpIGl0IHdvdWxkIGJlIGdyZWF0IGlmDQo+IHlvdSBjb3VsZCBs
b29rIGF0IGl0Lg0KPiA+IFRoYW5rcyENCj4gRG8geW91IGhhdmUgYW55IHVwZGF0ZXMgb3IgRVRB
IG9uIHBhdGNoZXMgZm9yIHRoaXM/DQo=

