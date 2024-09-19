Return-Path: <netdev+bounces-129016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DB97CEC4
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA711F220BF
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59A4963A;
	Thu, 19 Sep 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Q7YRUEMY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362A125A9
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781590; cv=fail; b=JCfRYjcTzWMor+2jtUqQC40IBJUFXIzIYDiwN1U8NU0eBnecPuf8siUIcWZYae0k0BIdzUub0JxTa05bLgnXk3KJy7U2x3BjsisRNpIB/by4IFzrpVM1IbeLQVU2qCjxA50VNRZ9eBxkZCdf+6igVAuPwwFKthdDfwL7KerlVGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781590; c=relaxed/simple;
	bh=KDyzn+URkCKkg9Zmzjy1cBJlL6r2Qv3Xn+kEVyhU1Io=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+QtUFJ5Kn4G9mTb0A5R6VKi/25pgXwinj7lRy+5m93ifbVFAcn/lOWb2Yec+JA2sGHexUJTqn+rkA6C2+GwpU1TRG9wl2mAx1FSotdsqpGsp3EmBdvSrSVT+eOfZU4W2t8Hc0/HE3/HLvyU5/TsFI+CEw4uKpp2/NJG7njWOKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Q7YRUEMY; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JIDP9b018487;
	Thu, 19 Sep 2024 20:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=KDyzn+URk
	CKkg9Zmzjy1cBJlL6r2Qv3Xn+kEVyhU1Io=; b=Q7YRUEMYZLFjRWG6xtoXIb2Mm
	LmxHKN8ZzGAsbZlwTIYKG7VzuI+6+4fLLKN7uwu2ahRc7Ddrw4OWpA6bTVhvmsc8
	K+ANy3evET4b67P+GMx0wb8iUpwK0CjM+Lt30UgWRrHUcOFo0ltaMlFPf1P8b0fx
	uGKmGk2fxZAYTnmvXG2qoS0/wHVpsXWlzWZVn4EGzIucfdIdxvP1LsDGNBxOr6DH
	u9lJ94AdhkTO4MRnPBwI0PS44nmOeDtXfCNlBTpesWz5E0/VLN6cZuNl3Tj/pQFi
	KEutiaLITxpUdPV/bFN/wrShMg+2IVAL/sDcKmxBzH0CLTLJfUzAECIVE6HPQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 41r6t5r2k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 20:31:16 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id EDBCED272;
	Thu, 19 Sep 2024 20:30:07 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 08:30:04 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 19 Sep 2024 08:30:04 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 08:30:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG5h5mVuPT55Jr8GAv7wL811ktvemLwe0JnQn7v1HF/BqQubd6iNcnboLEnfE8sKDNH/mSPmavOIaGsyOFifJw8ynasSq94wY550q/0j+U/Tw3sWbSFnnkMWoE3gH5u+Ms2A5nfSY7Slg+o+JdIS55mJeDf0H7p4YDaEhXJG/TBlg3o96+GVnnTOLSs3NTh1cNsQdGER2+X0u66v5VpHQHDQwrYcN9okU63pF+EVJ1Avyib5cPk2dPGWBsmyA66Y7D3qJ+JdYMVrTcWJF7L4VlP8Aultr9K3pRA3VrlNRGRDPfivgxC647MCMHe9oxTJohtSBh+BzkqDoVdZnW44Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDyzn+URkCKkg9Zmzjy1cBJlL6r2Qv3Xn+kEVyhU1Io=;
 b=kGMGD9TNjpeRqV+9+miKYX6LF2lE3Ks9lWzlmBaWAwmf1vwymBva/J1WYyw/Y3LMyZkO3XFfIM9nef15tIqAe397jmkdhZWCe+7zy6zpvc2UEydbWtk0i5io3MwD/Fd/EZ9D7DfqHmCh5MMT67oyIUgnu4itIlg3naHmV+FzQYjXA6PKuKy8NcytVB/bB88QZK+dsSdcUMmUpydGK1PlHl4gOHtSM6yFcOxu8cixbUdBiGIuGG/eTmocvFL6V8pLWMhbyALS0a7V4bEOfTbA40up7Nm1bRgWg6RIteTOIfOvwGMjkVvvB08GsKGa6jSHIbz4Oha0e4cNmIBHwCardg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:161::13)
 by MW5PR84MB2992.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 20:30:03 +0000
Received: from PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7cc4:91b5:ecdf:727d]) by PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7cc4:91b5:ecdf:727d%7]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 20:30:03 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: Submitted a patch, got error "Patch does not apply to net-next-0"
Thread-Topic: Submitted a patch, got error "Patch does not apply to
 net-next-0"
Thread-Index: AdsKN4cQPqFaBe0nSyiFGCTE3NqYjQAIUVQAAB1TxaA=
Date: Thu, 19 Sep 2024 20:30:02 +0000
Message-ID: <PH0PR84MB2073021945EE35CCD20FAF33D8632@PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
In-Reply-To: <2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB2073:EE_|MW5PR84MB2992:EE_
x-ms-office365-filtering-correlation-id: 8e7afe48-8510-487e-df73-08dcd8e9d743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUt0MUhlWEd5UGw0Q0UycmNyOWs2R3ZlSFdQcjM0SjBtY0wxV04ybjBmekdl?=
 =?utf-8?B?dklCYzFSaUlrVTUvdWt4MXdlNk8xL1laNFI5L0NrU1V6Ykh2dEowbnVBZTVY?=
 =?utf-8?B?eHhGbFlMaVB5U3A0UjFzTmdlbDFCYmlqbk4ySHBNc2VOUTRDVmtzV3lZNEFO?=
 =?utf-8?B?cTFjVTRObUd5QUJvR3lxbmtpSCtySzQveG1oVW1zK1YyNlpoYW1DdFhFc3Vy?=
 =?utf-8?B?ZnRSK2ZzOEJjbGdOVkV5dWpPUzRoRjQrc0E2dkg1d0tYTkxKVmRaWmNibFho?=
 =?utf-8?B?akpNQjZDNC9jN2NDQkVGV3ZBbXN5Y3dUOXBTY0xoVW9aS1k3WEsrYTlrdDRC?=
 =?utf-8?B?b2hmK3oycGtaakhzeWxxZXhFV2pJTXZmcFBzN2V5S2oxQW9NdkRaQklKSkN5?=
 =?utf-8?B?dXhYVHNQVld0RCtHTmxmbVpwVy80Q2xPUHJQb1dQd25keGtGM3piSDU2bHc2?=
 =?utf-8?B?VkRFVWtmbEx0bkd2MncwYVdwTkVta1htSmJqanZWMVNTTi9FeEpLNVNLM2wr?=
 =?utf-8?B?NzZHZUJGOEFzdUNOWVVZZ2ZpQkpmT3kzOGJDRG8xNnJ2NDV1NkVkNk9SUnMz?=
 =?utf-8?B?L0ZIbGFEbFZDdGd6TG11RGVFRWg1UmNjS21aUEUxSTBrbm13UHp6cUF1dzJq?=
 =?utf-8?B?WEY4WnphZllNSUgrSTk5K2tTeTkrcjJvS0ZadlhUSHBWOVVFM0xZbWJqenpL?=
 =?utf-8?B?L0Jsa24yMktDV01YSkk1Wi9KUHQ5YjRmY1NhYVBKbllpR2wyUW9nbU1ZNVdu?=
 =?utf-8?B?alo5TjR6bEtVdHFmYmEzTnlxTU9UYStIVnRIU0ZYODJRSUw1SzAreEFPV0ZX?=
 =?utf-8?B?RUR1V1N5L3NQdkN5TWlWTHNCOU5MSGd2VXRXdmxueXJFdTZSeEZSdDdoUFdN?=
 =?utf-8?B?MUVpYjNDOHdjREhRdnoraUdqOE5aQmhUUy9meHdSYWhkaGtPZDZCcmxsR21E?=
 =?utf-8?B?UFJhQUZ1TGx2ZW4weVMzUGVUT3hYM0hYckU4bjNxUkdJRzczTSs2U25JR0k1?=
 =?utf-8?B?NlVzZWdsdjlEd2g1em1LV0YvMDdNdlpXT1BkZSs1SmNkckhFanMwRVhVSDd6?=
 =?utf-8?B?T3g2TktsTTZwbVFDNEpoVjlBTnV3OGROMVJqSjIrOHFjUUdZcVJiNUl6UnRV?=
 =?utf-8?B?RnhBNkRsSUwxQ1NPYjIxSnpHd3JUQlpPQXVtOXdtT0hHdmtaTmJxUHE2YUtT?=
 =?utf-8?B?bWRaTjA4NkQySzVGU1ExZnZ4VGVpQlBUWXFBVDdzK0ZVWmE4TWdoRktMcTV4?=
 =?utf-8?B?UnNvM3hNUjJvTXF1WDlicmJTZmhhek8yV1BCZ09JUU5EenZxNWFsK2lPaVVC?=
 =?utf-8?B?djZnZW9rVzhJV3oxaUF3bk9YdzU1Y0FRZUxpaHVlZGFSOUJvMm55VkxnNDJ6?=
 =?utf-8?B?cXpsVjY0L2puUWVuYW4xbjJoanlUK09sTXhkSU1ybWk1c1o0RzJ4MHVkeUdE?=
 =?utf-8?B?RTNLMzkzeG9FU1hvQjBPSGNOa01oejVRYW9NUlpFMkU1MGhMaDFFSEVTejJY?=
 =?utf-8?B?aml2djZsS1FiSHJidEpOQVdobzVBVVJiNVF5M2hIQ3Ruai9KT3RqaWljcVgx?=
 =?utf-8?B?enBYNlFzZlFPd0p6ZFhHVXBCMmhtR0pnZmdKR0VYdzJQcHFrc3Z2QnFwSDl1?=
 =?utf-8?B?TDBXY2NwY1dlZ2t3NHBPeEhoZEJXaVNUZk9EU2tQL09KczlsQnNENmpOSTBz?=
 =?utf-8?B?S0FIRGx2YWRtWjBVT0JuaFdtSFVvUTNGc09lRC8zcFBGNGNJZ1hWeUNQVm8z?=
 =?utf-8?B?WFl5c1pLQ0IwS3VZb1pSVWsrYXQrVllYV045aVJmaHgzZTlJeU5UZlJ2MEFU?=
 =?utf-8?B?Sk93aXJ2bk5lOHZpNHJtWHAzYmQ4MGhwdFFYRStRT3pqVWtULy8yNTFhV294?=
 =?utf-8?B?ZzU2K3paa1BmZmdyOU5xYVIzNldIVEZ6Mm43WUQvUEFORUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lZdEN2cEdicEVTd3VMSUhWMmxiUFh6TGNnNlh1eUJvZ3JIMk5vVVBLZWJQ?=
 =?utf-8?B?cDlwdGYwUVRvQkFZaEhwbG5KVmQ1UUVzbXVJUnZqMUxBMTVaTFc2ZFprVzRo?=
 =?utf-8?B?Mis5ZmFDMW01dnJ3cFpOK3VuM2xDUGhVc0d4UEpVZlA4MUhUZWVZdW9BdzRr?=
 =?utf-8?B?TUR0c0dRUDg3TU5hYnVYNlV1dlhqamNLa01GWlJnYmZaNXQ2aTM1VlZhMWI4?=
 =?utf-8?B?dVhHdlU0aFEyeWhTeEN6VWUyUmVWUDViTGlLS09wcllpWE5RY21GR1h2ZUUr?=
 =?utf-8?B?aHVIWkphWEF0RGpUZURCSXlnTFQwQVhDMGhiTkJ0UHVPMUd0RjN5NzU5QUdw?=
 =?utf-8?B?Z1VEdGxhM3ZaZ2RwMnFKbjdzWmcvQWxlS0NTa280SGtaTjl6Z0hpTExCMTZy?=
 =?utf-8?B?d1pOOEF1UVZwOE1xdk9CSWxYOG0yK2d5aGlHMlpqOXBtWk9KemNOYlFUWXdx?=
 =?utf-8?B?b0ZlRWV6SVp6L3AyVWtQZ3RKaEZBQTl4VUpQTXlJaVpLYjAvV1hxVEltSHNX?=
 =?utf-8?B?Z3Q5eUwzalNlUFZTSUdNQnpCa1BZZ01QeWMvbk4rNXd5TkdBMlE2bHpOZmZM?=
 =?utf-8?B?djdBd1JQSFVGTDMrZzRlY1J6K1NoL3RmNWZ3aGQ1VnhaWm1mSEdNTWNyWXZL?=
 =?utf-8?B?WTlyanhnTFVEUytTeStWUGV3Z0lpVCtXOGdGUUlDamJXMGYrTXhiS05WM3V2?=
 =?utf-8?B?MG5nMVRDVEx4Z0dRZVJlV01rbzgrb3dCL09IcFFOQXgyT3YrbFBXUGFETFRR?=
 =?utf-8?B?a2NyVVpqUll0V3hiTW8xRUZMbDBvVnRmaGg1SUFqTStqbE5yamNIR1N3dDNQ?=
 =?utf-8?B?Ni9VSWJ6c1BGSDJTdm1oekhrQktvamlvekdEYWZnWHBsdHZkMWRRNUFmbEVu?=
 =?utf-8?B?bEtKUW1VYm5jc2prZzZvTlREbWV5cFFlM0luNjJEbm5GN0diUVJ4NS8wRmdQ?=
 =?utf-8?B?bVpZZkJtZDU0RHFGVXVHTEcvMmoxWjhOTW1ZaHFzYkdjNVh4dzV2MXlpakRZ?=
 =?utf-8?B?Qm1RL083Sm5HZ3diRlFENkhKNzBQd0Q1ZWQ1cXNlS2JqaTcxVjFyclhXRXhz?=
 =?utf-8?B?V3JzUWJqT2h2NHB4VlVybE01ZVExTnlZLysybDNKZkhzRXRzTm14Ykl1bklY?=
 =?utf-8?B?OVhKemhQR3VVdHZTeW82b2pwM01EUjFWSnZuY2hLSlJNV2tqU09DcG14Tkw4?=
 =?utf-8?B?WEVWWXo5aGRjY3RlNzNBb0dYME5VVWNneFMvdEdsOUZkaGZMajlGaTMrV0xP?=
 =?utf-8?B?VStMRHNIemgxMERENEwySU1NTTA1M3lLUW1tN0RPRVNkQlAxOWNvei9KL2ZU?=
 =?utf-8?B?Y0U3cWpONjhiOHBpUElZcnhYS21FOHlIMXRrQzhkdUFDNEVpK1RmOWtYRlNu?=
 =?utf-8?B?UlNKNWI2YnE0VnRaTTI4SDhSYjA0VkxpYlQyVGIxZ1hveEtaa2VXV2haZmc5?=
 =?utf-8?B?aE5xaXpDR0pBQXVEb0VlNDMwdFFJUmNsNmxPTjdwRE5YR041RTRpRXhmaXRU?=
 =?utf-8?B?ZmhSRGRPR1pyVEhpQzVLWFNjQVd2dHNRWE00Wk91V3hRWFc5RzQ1ZUt2ZXN4?=
 =?utf-8?B?VDJTZEE5SGFnRzlGTlhJU2tWekNOb1ZJdmZSUU9ZcW5VWDFQSmdBdG9UclJF?=
 =?utf-8?B?WUowWHcxOHZMZXB6UTNmMnMyQ0NQNWp0YWkwaXdHRnZRVHJXay9zK1g3aXQ3?=
 =?utf-8?B?amhTTU1NMXUrM3pjRncxdnRhbzM3VVh3SVFQNkQ5VUZzQUI1NkNIdkFqdjBS?=
 =?utf-8?B?MFplaldxeHNWS0thay9aOG12VkRWOXdOZjNwWEN0bU5LRWpVTFRydFhnMkd1?=
 =?utf-8?B?cmNEd3plNkJMKzI5VWxobVlqRDV3SGw4NVhQdmprU29iYzNWY3pia2NFdG1t?=
 =?utf-8?B?WWNwMFB3TWE1YTlkYnNtaTEyT1ZneG14MGtsNzVEQTFrZjlQY25lZlErOTNq?=
 =?utf-8?B?dGpxcXY0K3VIc1lkS2JMUTJoTHZNTUhQK05rcVJmWFpxTDB0QmJ4OFlTKzRG?=
 =?utf-8?B?czNud1BLSWhVWSs2MXNKenJsVUlmZWl4MlRjN202SW0wc1pvZnVuRHdub0hW?=
 =?utf-8?B?TlRBUVdjNGRabjJwbFVCVCtWL2FEanppNDh5MEFoRlZCQlBYemlIc3FNNDBY?=
 =?utf-8?Q?gCaB0BMV7ppczdm98rHN47/14?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7afe48-8510-487e-df73-08dcd8e9d743
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 20:30:02.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZsJ1ZOfcUG68y26DiN1SWAqXJ5g0B0YN5yV776tSTcCRtP472TSdk+DvPaLxr6n/2D0kHYfImhYElARZ7Ak336xb8xWgH4DP2Ohr0TymPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB2992
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 27idZTht5RRUxduFd4a9CLf1ahip4D_S
X-Proofpoint-ORIG-GUID: 27idZTht5RRUxduFd4a9CLf1ahip4D_S
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_19,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190138

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhr
YWxsd2VpdDFAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgMTkgU2VwdGVtYmVyIDIwMjQg
Mzo1NyBQTQ0KPiBUbzogTXVnZ2VyaWRnZSwgTWF0dCA8bWF0dC5tdWdnZXJpZGdlMkBocGUuY29t
PjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogU3VibWl0dGVkIGEg
cGF0Y2gsIGdvdCBlcnJvciAiUGF0Y2ggZG9lcyBub3QgYXBwbHkgdG8gbmV0LW5leHQtMCINCj4g
DQoNClRoYW5reW91IGZvciB5b3VyIGRldGFpbGVkIGFuZCBjb25zaWRlcmF0ZSByZXBseSwgSGVp
bmVyLiBBcyBhIG5ldyBzdWJtaXR0ZXIsIEkgd2FzIHRyeWluZyBoYXJkIHRvIGNvbXBseSB3aXRo
IGFsbCB0aGUgZG9jdW1lbnRlZCBwcm9jZXNzLg0KDQo+IE9uIDE5LjA5LjIwMjQgMDQ6MjMsIE11
Z2dlcmlkZ2UsIE1hdHQgd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBGaXJzdCB0aW1lIHN1Ym1p
dHRlciBhbmQgaXQgc2VlbXMgSSBkaWQgc29tZXRoaW5nIHdyb25nLCBhcyBJIGdvdCB0aGUgZXJy
b3INCj4gIlBhdGNoIGRvZXMgbm90IGFwcGx5IHRvIG5ldC1uZXh0LTAiLiBJIHN1c3BlY3RlZCBp
dCB3YXMgY29tcGxhaW5pbmcgYWJvdXQgYQ0KPiBtaXNzaW5nIGVuZC1vZi1saW5lLCBzbyBJIHJl
c3VibWl0dGVkIGFuZCBnZXQgdGhlIGVycm9yICJQYXRjaCBkb2VzIG5vdCBhcHBseQ0KPiB0byBu
ZXQtbmV4dC0xIi4gU28gbm93IEknbSB1bnN1cmUgaG93IHRvIGNvcnJlY3QgdGhpcy4NCj4gPg0K
PiA+IE15IHBhdGNoIGlzOiBOZXRsaW5rIGZsYWcgZm9yIGNyZWF0aW5nIElQdjYgRGVmYXVsdCBS
b3V0ZXMNCj4gKGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYv
cGF0Y2gvU0owUFI4NE1CMjA4OEIxDQo+IEI5M0M3NUE0QUFDNUI5MDQ5MEQ4NjMyQFNKMFBSODRN
QjIwODguTkFNUFJEODQuUFJPRC5PVVRMTw0KPiBPSy5DT00vKS4NCj4gPg0KPiA+IEkgZm9sbG93
ZWQgdGhlIGluc3RydWN0aW9ucyBhdA0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1s
L3Y1LjEyL25ldHdvcmtpbmcvbmV0ZGV2LUZBUS5odG1sLg0KPiA+DQo+ID4gSGVyZSdzIG15IGxv
Y2FsIHJlcG86DQo+ID4NCj4gPiAkIGdpdCByZW1vdGUgLXYNCj4gPiBvcmlnaW4NCj4gPiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5l
eHQuZ2l0DQo+ID4gKGZldGNoKSBvcmlnaW4NCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5leHQuZ2l0DQo+ID4gKHB1c2gpDQo+
ID4NCj4gPiBBZnRlciBjb21taXR0aW5nIG15IGNoYW5nZXMsIEkgcmFuOg0KPiA+DQo+ID4gJCBn
aXQgZm9ybWF0LXBhdGNoIC0tc3ViamVjdC1wcmVmaXg9J1BBVENIIG5ldC1uZXh0JyAtMSA5NWM2
ZTVjODk4ZDMNCj4gPg0KPiA+IEl0IHByb2R1Y2VkIHRoZSBmaWxlICIwMDAxLU5ldGxpbmstZmxh
Zy1mb3ItY3JlYXRpbmctSVB2Ni1EZWZhdWx0LQ0KPiBSb3V0ZXMucGF0Y2giLiAgSSBlbWFpbGVk
IHRoZSBjb250ZW50cyBvZiB0aGF0IGZpbGUgdG8gdGhpcyBsaXN0Lg0KPiA+DQo+ID4gSG93IGRv
IEkgY29ycmVjdCB0aGlzPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1hdHQuDQo+ID4NCj4gPg0K
PiBUaGVyZSdzIGZldyBpc3N1ZXMgd2l0aCB5b3VyIHN1Ym1pc3Npb246DQo+IC0gbmV0LW5leHQg
aXMgY2xvc2VkIGN1cnJlbnRseS4gVGhlcmUncyBhIHNlY3Rpb24gaW4gdGhlIEZBUSBleHBsYWlu
aW5nIHdoZW4gYW5kDQo+IHdoeSBpdCdzIGNsb3NlZC4NCg0KVG8gY2xhcmlmeSwgZG8gSSB3YWl0
IGZvciB0aGUgInJjMSIgdGFnIGJlZm9yZSBzdWJtaXR0aW5nPw0KDQpGV0lXLCBJIHJlYWQgdGhh
dCBzZWN0aW9uLCBleGFtaW5lZCB0aGUgdG9ydmFsZHMgZ2l0IHJlcG8gYW5kIHNhdyB0aGF0DQpp
dCBoYWQgY3JlYXRlZCBhIHRhZyBmb3IgdjYuMTEuIEkgcHJlc3VtZWQgdGhhdCBtZWFudCB0aGF0
IDYuMTEgaXMNCmNsb3NlZCBhbmQgdGhlIHRyZWUgd2FzIG9wZW4gZm9yIDYuMTIgd29yay4gSSBh
bHNvIG5vdGVkIHRoZXJlIHdlcmUNCm90aGVyIG5ldC1uZXh0IHN1Ym1pc3Npb25zIGFuZCB0b29r
IHRoYXQgYXMgZnVydGhlciBldmlkZW5jZSB0aGUgdHJlZQ0Kd2FzIG9wZW4uIEFsc28sIHRoZSB0
b3Atb2YtdHJlZSBoYXMgdGhpcyBjb21taXQgbWVzc2FnZSwgd2hpY2ggSSB0b29rIGFzDQpldmlk
ZW5jZSB0aGF0IDYuMTIgd2FzIG9wZW46IA0KDQpNZXJnZSB0YWcgJ25ldC1uZXh0LTYuMTInIG9m
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0
LW5leHQNCj4gLSBQbGVhc2Ugb25seSBvbmUgdmVyc2lvbiBvZiBhIHBhdGNoIHBlciBkYXkNCg0K
VW5kZXJzdG9vZC4NCg0KPiAtIFlvdXIgY29tbWl0IG1lc3NhZ2Ugc3RhdGVzIHRoYXQgdGhlIHBh
dGNoIGZpeGVzIHNvbWV0aGluZy4gU28geW91IHNob3VsZA0KPiBhZGQgYSBGaXhlcyB0YWcuDQoN
Ck15IHBhdGNoIGlzIGluIGEgYml0IG9mIGEgZ3JleSBhcmVhLiBTb21lIHdvdWxkIGNhbGwgaXQg
YSBidWcgZml4LA0Kb3RoZXJzIHdvdWxkIGNhbGwgaXQgbmV3IGZ1bmN0aW9uYWxpdHkuIE15IHBh
dGNoIGV4dGVuZHMgdGhlIG5ldGxpbmsgQVBJDQp3aXRoIHNvbWUgZnVuY3Rpb25hbGl0eSB0aGF0
IGhhcyBwcmV2aW91c2x5IGJlZW4gb3Zlcmxvb2tlZC4gSW5kZWVkLA0Kd2hlbiB0aGVyZSBhcmUg
bXVsdGlwbGUgZGVmYXVsdCByb3V0ZXJzIGluIGFuIElQdjYgbmV0d29yayBpdCBpcw0KZXhwZWN0
ZWQgdG8gcHJvdmlkZSByZXNpbGllbmN5IGluIHRoZSBldmVudCBhIHJvdXRlciBiZWNvbWVzDQp1
bnJlYWNoYWJsZS4gSW5zdGVhZCwgd2hlbiB1c2luZyBzeXN0ZW1kLW5ldHdvcmtkIGFzIHRoZSBu
ZXR3b3JrDQptYW5hZ2VyIHlvdSBnZXQgaW5zdGFiaWxpdHksIHdoZXJlIHNvbWUgY29ubmVjdGlv
bnMgd2lsbCBmYWlsIGFuZCBvdGhlcnMNCmNhbiBzdWNjZWVkLiBTbywgaXQgZml4ZXMgYSBuZXR3
b3JrIGluZnJhc3RydWN0dXJlIHByb2JsZW0gZm9yIHN5c3RlbWQtDQpuZXR3b3JrZCBieSBleHRl
bmRpbmcgdGhlIG5ldGxpbmsgQVBJIHdpdGggYSBuZXcgZmxhZy4gDQoNCkknbSBoYXBweSB0byBi
ZSBndWlkZWQgb24gdGhpcy4gV291bGQgeW91IGxpa2UgdG8gc2VlIGl0IHN1Ym1pdHRlZCB0bw0K
bmV0IGFzIGEgYnVnZml4LCBvciBuZXQtbmV4dCBhcyBuZXcgZnVuY3Rpb25hbGl0eT8NCg0KPiAg
IElmIGFwcGxpY2FibGUgYWxzbyBjYyB0aGUgcGF0Y2ggdG8gc3RhYmxlLg0KPiAgIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1
bGVzLnJzdA0KPiAtIElmIHRoZSBmaXhlZCBjaGFuZ2UgaXNuJ3QgaW4gbmV0LW5leHQgb25seSwg
eW91ciBwYXRjaCBzaG91bGQgYmUgYmFzZWQgb24gYW5kDQo+IHRhZ2dlZCAibmV0Ii4NCg0KVW5k
ZXJzdG9vZC4gSSBjaG9zZSBuZXQtbmV4dCBhcyBuZXcgZnVuY3Rpb25hbGl0eSwgYnV0IGlmIHlv
dSBmZWVsIHRoaXMNCnNob3VsZCBnbyBpbiBuZXQsIHRoZW4gSSdsbCByZXN1Ym1pdCB0byBuZXQu
DQoNCj4gLSBQYXRjaCB0aXRsZSBzaG91bGQgYmUgcHJlZml4ZWQgaXB2NiBvciBuZXQvaXB2Ni4g
Tm90IHN1cmUgd2hpY2ggaXMgcHJlZmVycmVkLA0KPiBib3RoIGFyZSBjb21tb24uDQo+ICAgU2Vl
IGNoYW5nZSBoaXN0b3J5IG9mIG5ldC9pcHY2L3JvdXRlLmMNCg0KR290IGl0LiBZZXMsIEkgc2Vl
IHdoYXQgeW91IG1lYW4uIFNvbWUgaGF2ZSBuZXQvaXB2NiBhbmQgb3RoZXJzIGlwdjYgYW5kDQph
IGZldyBvdGhlciB2YXJpYW50cy4gSSB3aWxsIHByZWZpeCBtaW5lIHdpdGggbmV0L2lwdjYuDQoN
ClRoYW5rcyBhZ2FpbiENCk1hdHQuDQoNCg==

