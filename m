Return-Path: <netdev+bounces-183825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B7A92268
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31B71765C1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6721254858;
	Thu, 17 Apr 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TWdFOFqK";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TWdFOFqK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2E254863
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.139
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906367; cv=fail; b=GThWTKvQgZPURKaE3nuVFjaNgIUn1NpQE9AWGyLrt6aERWEl4scQNJ7Ccw9vD+7EArIUTeuOBtZvTtw2NZiiCXC/dfYXh9mTmSaeIQ+8WsorU00XJ60UXfehhJNb5SXV/wYt6UcVuGX7ljlLdTHozFe3xiNT2u8hf7JbkbH5m38=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906367; c=relaxed/simple;
	bh=jeu6BKmkw9JfXNKQRTrgPkygeonG5KKP1ZDAktSYVZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWTRUZw8isgF2PLQ+9rOYIHbIJM5WMWNphgdRp1dbnJ6Qy2ikUrE/QCh53Hl7UC+HSjhODyAjRHtCfLKl1ci9G7k8nH1ddysNBae0WHi0OYRRUVAgdsS44of2fDQwWqbx7yP/mITpuL8K8lzp2vuWtOHBgU4YfSxV2N4HrzI5xM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TWdFOFqK; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TWdFOFqK; arc=fail smtp.client-ip=40.107.20.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ei51/0onAHbqWs7lLFcmfRiS4kXaPhRrbsvyPelT2fM0Fva3bXiPm6pocRfIqGmhK3Gla3CzMkRBAcU+Xnc6AGDS7Hb2IjVP5gxrh5psW2Djl8u5CP56rIqjP2hB3P2I1bGRs2tZTL3Te4tnGzAUD/aC/djQCMkp3RNdLpxZm4TU5YxWtEO99QYFlNxDlJn6Zd5k8tdoDSJ041MibGNxbw1OiDFKh4TmYbKM1zvNzv4Oz+qu86ED9HCCRGZQz2d6HxXlGlN13jvztIyYIcHzWHJxRQDyTn1RiqAyP3qEnNIKFuF+By4ZusyXlptzpWDRUJRFaQbl0Fk2MhM4YIHNpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZVw9eBTbeTwK3Hr1RwS7RnkS1F+grczCqU3tMhL7O4=;
 b=ZMkQAJmgHLcXv+ZRr8TsYKXn1JnVhkUJ/VYdelGElggRz0+ya3vfvVPQNLVcWpsSFi5esLix5iHgTFECxo5S2OJO/Am17N8LRR0y6r1OrZfJeRkWGTINc/8DWx9O6LRN1y1WdksyEQOGFDi7kNcoKF8RQTiXVOAreruT+H+LY2x+M9D7q83FPfhMr24YFyApn11EOaLp9Qg4LkGkTacOXOMd9GoqF5LEtDrZqu/n3amfw2ZvpmzRU6bd4bSArpFj7DpHs0i+UYnqIogttzirZvK5zThDt/FiWbQ4PjYct0ePU6zQgnB22UYu033b52IRKE6BqNY/27Vy7QsK+uHpHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZVw9eBTbeTwK3Hr1RwS7RnkS1F+grczCqU3tMhL7O4=;
 b=TWdFOFqKH5UZsSZZasZpdITo3OMVbOvE4xO1dsZUraViFp4EuIvEbBe1AQ0pd0ho5oVuhPOmjlMA85W67+EID8DBRbkyuzR6h1p+m5CuPaWVW6Jta2iQqg+wrKB1bHnX28NJRY8zbA9b+n+XF+nphZBuO2D+B202bx9omov/RWe9SL4qXIx9L3+zS2LiEW0NJ4z11a5UTYWOCKaYWnkbGTKt3Ha0A4rT1kUHH/gMc0h30w2x20ECjzV55qHzHziWFy3KGyhSGsn+c1UsMkps7y/ZQQykKdgbBZqpOuHWFXWciA+ynsiCovAG420mxV9G9WV0asTx85/+E5vCpKSyuA==
Received: from DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) by PR3PR03MB6394.eurprd03.prod.outlook.com
 (2603:10a6:102:5e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 16:12:40 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::9f) by DUZPR01CA0038.outlook.office365.com
 (2603:10a6:10:468::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 16:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 16:12:39 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 7A1782008009E;
	Thu, 17 Apr 2025 16:12:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.169])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0E2D12008006F;
	Thu, 17 Apr 2025 16:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMFPp47ll5MIMNp1s/lWBNTM2+gtTXBGWz+Y769S7Y14+9EYSiifNraLRdV+GFMp9aTfVFfM6z1ks3UnpgY6P6KbsiQDiBM45SgY93bdpHow8VmyIuloUikRYkXYcVygvzj8g/fgTXSsNQzftL0w7Eh4l3zUO+gH0drqags7dfGgZxQ2LwiCwpsYAQ4ftuphOUlT3vWc9tsy5VunM0/Y9Ujbq3rznXi9u0hnlOcV/56Pv9LFSwyXHRYyVPq0tQR7p6dA0T7mlGswwNFqHYJiEwD6JfZa6LJg0z2W0Z27XmjLR3vvCxhfDXhD0p82KL6HPDLzbclc1Zgq1VMYujrH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZVw9eBTbeTwK3Hr1RwS7RnkS1F+grczCqU3tMhL7O4=;
 b=YwURE1R/VlhoLKHYOV1PGPgAZrRA7eS780JH6dY0lLvjOYMkCUBd49OWdRGtQJOkXPUAWberlJNJrsW5zWzUBjADc7s0rQrF6y7AW8midtxFyfp9FTlmPH5rVTxyoPfhfhCnjGuA+ZwKYKkBCnEjgLeSgb4fnM9foV7b98+LmtnUcXs1Y0TeiTsRSGg84RVwlXuZrXK1mx9IFxWdQ27UsRS/uILrAhGEUupxZdsROjXafUTUyIXQIYfkVjEQTu51nZrLgLqz70iM0MJLPhs47gm2jr+RMIdZxwtpx+D3W/s02RybLePZpmTltxf7OJP4urjZd6ZmRdDyUW8FZI3jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZVw9eBTbeTwK3Hr1RwS7RnkS1F+grczCqU3tMhL7O4=;
 b=TWdFOFqKH5UZsSZZasZpdITo3OMVbOvE4xO1dsZUraViFp4EuIvEbBe1AQ0pd0ho5oVuhPOmjlMA85W67+EID8DBRbkyuzR6h1p+m5CuPaWVW6Jta2iQqg+wrKB1bHnX28NJRY8zbA9b+n+XF+nphZBuO2D+B202bx9omov/RWe9SL4qXIx9L3+zS2LiEW0NJ4z11a5UTYWOCKaYWnkbGTKt3Ha0A4rT1kUHH/gMc0h30w2x20ECjzV55qHzHziWFy3KGyhSGsn+c1UsMkps7y/ZQQykKdgbBZqpOuHWFXWciA+ynsiCovAG420mxV9G9WV0asTx85/+E5vCpKSyuA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM9PR03MB7662.eurprd03.prod.outlook.com (2603:10a6:20b:417::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 16:12:36 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%6]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 16:12:35 +0000
Message-ID: <a63756cc-1312-47a4-9dad-1ff8431ac7e7@seco.com>
Date: Thu, 17 Apr 2025 12:12:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro.gamez@hazent.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Katakam, Harini" <harini.katakam@amd.com>,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
 <20250402100039.4cae8073@kernel.org>
 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ce56ed7345d2077a7647687f90cf42da57bf90c7.camel@hazent.com>
 <MN0PR12MB59539CF99653EC1F937591AAB7B42@MN0PR12MB5953.namprd12.prod.outlook.com>
 <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|AM9PR03MB7662:EE_|DU2PEPF00028D0D:EE_|PR3PR03MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8cfbef-c554-48cc-8b8f-08dd7dcaad49
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OWFrUjNoQzFITCsyZHFkeHNSeTFjVDIrNVQ0Z2VTYzhFa1NLMUZtYlBDNTZL?=
 =?utf-8?B?aGhtVmtYOGNaL0w0ek9QK2VmVCtBRkdmanBrdE9XUnpHZjVmVGRVemRqWDJY?=
 =?utf-8?B?eFo1NG1WbS9FWSs1N2xmRWJEb09kNlVYMHFBYUcwQ2UrSktKSFZaQUVndjVu?=
 =?utf-8?B?WUhUQW90M2RZQlJubmxMdW92aTJiUXZSVDR4MDhqUm1adjlyZUNiOENvQW12?=
 =?utf-8?B?UFZJWEF2TkN3RnlhRDh1Z0srNTRoTlFLOWNPQWliOUdOcFdMWkZ4ZUppOFRO?=
 =?utf-8?B?MGk0UmNFbWpjNmNGeUtybzUvTENJWXVRbWN1RWJTUnBnMGJ3NUVZVmZBcktG?=
 =?utf-8?B?c2hpQTlacUxBd0lkdHRrNHJTZlZaNmkzY3lkd1RBTTdxdUpObjNpd1dhV2Vz?=
 =?utf-8?B?eFlRWWdsdmpXbktwR0NxMTBRREUwVG5QOHVQQXF1alhnNmpjQnFHYTJqSFdn?=
 =?utf-8?B?V2NoS05mc0E0K1ZXSUp4L0I1SzFqTjZBVFNNbEY0djVxSHR1Vm50bmZhTDBm?=
 =?utf-8?B?dC9DRCsvM0Z2YW5vYldEelN0Qm9wakFzMEhid0FQeFFFc2U1SlVRZUtGdXFt?=
 =?utf-8?B?QjVucFhWZnJaenNzQVZDalNFaURwSXVleGVDUkNVaGtPKzFuS1RmTTcxQWVp?=
 =?utf-8?B?V0hYNW1sbm9uMnY4SjU5K2grNmdjRUp4dnBrUHhPMmdPMlRrQ3d2cHo3TXY2?=
 =?utf-8?B?NmJGaUNjSkdSOGlCVWhuclByek5BQ3FhWDJYWExYV3laRFlYTHp6YXZ0M1JR?=
 =?utf-8?B?Wnl3QjhKT0tSL0pNNUpTRkxxcmdVeHhuTCtCZTR0OEtBeVEzRkdqUmZkVHVH?=
 =?utf-8?B?R3IyV0Y5YTBZRzVDckdGT2R0VHZ2UkRhby9YSlRoYXRhQ1R1N1Z2TDB5cGRh?=
 =?utf-8?B?c1h6UGZTRjhJRlJaYmxVZ1Y5cUJ4Ny9McHZIV1ZxOS9iZytlMXkyZ1dEbmdR?=
 =?utf-8?B?US9LT1JQaGdOMDZhWVdLcG1XQXFHVDZWajZIOUtUZUZsRDFWbWt1RnFQZ0d5?=
 =?utf-8?B?d0pjSStHNzFkTjBIMFR1NVFyV25pL0EvVW1td3pXUjdKSWRNck5CUXFLZkda?=
 =?utf-8?B?dG9hL2dJandsbFJoNkorY080WHZqUENISXV0Q3ErcjBtUHZNSXhwaDBtQ0Jw?=
 =?utf-8?B?NDZHVncvRHRrWENnN3BwM2Y1UExwTkZhc0JmbEs2ZFVpNjJ6UHFXWk45VFhY?=
 =?utf-8?B?c1lwTTg1SnY2WlhPaHMxbVlZeXZtVWhKZzQ2NDF6TzU1dFVOWWlxQ1pUQ0Ey?=
 =?utf-8?B?bjIxNHRQLzVCM2hBTWpDQVNOUFJ2ejFjQ1BERno4Z0NtMWNXV2dQNmx1Skt2?=
 =?utf-8?B?ZXNYM3dRSkMzcU84UUpFZ1ZlZ3Vtd3ViTmU4dXdyQmZYTzNpaUJjQnF0UDNV?=
 =?utf-8?B?QjM4bUlvZE10OEZCQnRqc2FvMU16dmJrdGtKL0RpbTIyTmg5ZXB0aDZsUW8r?=
 =?utf-8?B?UnJPV2xvVmZKN3hBWVVycld4VU1xc3VJU2Y0RVUxbjZuMjNBZDdEUmNPSFNm?=
 =?utf-8?B?MGZiMFpaM2lTVWN2Q05rVWN6NnV0WitpZ20zOVQ0SWJreVJnQ2ZFdXRDT0k1?=
 =?utf-8?B?bU9lc1l1bzFUN1JDUFNadjJTUjhlS3JhUFFJaWpZRDQvdzFRS0xhaVB2Tm50?=
 =?utf-8?B?R09vL3VsM0c2bS9WUmoyaG11WlVTYmpVbWp6KzFVM0tyallsZmVaU2VkaTgy?=
 =?utf-8?B?RkhwNzBXSDZhTEdPTHhscno1b2sydnVWdW5zdTMvQ1poSzF4cFljZWUyTFpl?=
 =?utf-8?B?bW1OQXJZQTRKaCtqRTg3bTQ2S0lRWitvaGxmaWp5RTVGU0FBcDJGVjRmeHVZ?=
 =?utf-8?B?bXlTUmNiaGo2VEpteEtoY2FHYmQzdGZ1Ni9yRGtRWmptdDluWUkzVVFtSXZi?=
 =?utf-8?B?a25NZ3huZE83dituYTNjbmdIcU03MVNmTjlKNXV6QXJQak5tUkIvaTZqT2Zm?=
 =?utf-8?Q?995M9N7uwVI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7662
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	16449116-bee3-4c5c-5adb-08dd7dcaaa9a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|14060799003|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDR1N2lza21LMVJrNzZhVElMdERROEVseEc4VW1DaE96clFxeFR5RkpiOHM1?=
 =?utf-8?B?U2R1U05IY081ZTVVSEtnb2k0bklNa1NmRk9ObCttb2pyZkRzQlRMWGR6ODdR?=
 =?utf-8?B?RVR3ZG96WTVKME1kWWhkMmZCdC9NcGdkVVVSQ0E1QUdHTkN4TEJaNGlRUkhs?=
 =?utf-8?B?d3kvcEhqRzR4MytPbjRnbFN5SjRxV1U1RGFBRjVSdWYzTFhOdHJyUzhQZ201?=
 =?utf-8?B?elVETmt0UGQzTTFYRUtjK2pWKy9lcVVFN01UUEl6WlNER2xiSTNiZHVVdjgx?=
 =?utf-8?B?b1BiWHBaVnc2MDI4WEFmRlJZamZwYnVVbWlmZk4xL2VtOFpQQTBOR0YrZzVI?=
 =?utf-8?B?V0FhN0x4T3JjL2xCRXorK1krcml3YkxnY1Q1OXFKTzk0RUNEZ2FvQ09ZaDd1?=
 =?utf-8?B?WS9ZdVAvM2hUMlNRVWIvUnpXbEdWY0NhcXBlVEtlaHJpWHF5MmNjY1k4UDhw?=
 =?utf-8?B?cFFtNGVEUjRSTEtLQkR5U21uZC84aFdaenJWakxnUjlsUFhqcWxqMnozeThG?=
 =?utf-8?B?K0RkRENNcUhZcVVhbFBRSThqSU94amJwWGtIM2VRY0FDUkJyaG1RUHgyMDhG?=
 =?utf-8?B?ZGx1ZzNjNFdIRmFsR1h1ZXBsWnhucDVTOEk0S2wxZG9ZdStILzFHMVRsRHlD?=
 =?utf-8?B?YkpYL0xRWm9XMEJNTTRpeWFnc0pnbFJXcGZuMDRPUldBZkdNMkhxTVQyR0l4?=
 =?utf-8?B?RE4wbmJjRk0rRzRNT3AxSURHTXJCY0RFV3AyYUlVOTBOWEtZYmV0Tm4ycjJR?=
 =?utf-8?B?Qk1CRmJzZXc5YWR2T3B2YTYyUTRnaVgwVEY2WTErQTdIOFFNTXNtbXcza1Ir?=
 =?utf-8?B?N3d4N2pkNUlRb1dLUktmYW5rNXRIa240cElrOHBzdXUwNVdXM1BsU1RWUDBj?=
 =?utf-8?B?c1cyQk1ZZDNvb0VzdHMrK2Q3b2ZwMm5MMlJEdFAxL2ttaS9BWldFUzRYYVJH?=
 =?utf-8?B?TklJN0FwNGZydzE1YzFtSzZuUHI4OS9OOVdMb2hNazdCbGVrODRJcXYwVFgx?=
 =?utf-8?B?dXEvZzdLeXlUVjlhRGR1Z1pmSnkwcGh5ZzEraFg0c0hGdmRMdWNQWUdxNkhn?=
 =?utf-8?B?SXNTbWdtMG5hWkdnRCt6NFFQQ1VOWDJOZzRNb1ZOanN1eFEvYjg3UmxNRzN4?=
 =?utf-8?B?c2JzYzNOcHU0QXVSY2d6bUZEc01wSk1qQ05MQ28yT1hyR2lkZkZwSE1lRTNI?=
 =?utf-8?B?cnI0akE1emJqcml6WXJIWXJKcWJVOWd2L2MyNUxUSG1vOEl1cklJOGJteEpZ?=
 =?utf-8?B?VEZIcTNBbm9QYUtaZlF2UkUvWkZFR2VhVUVWZ3cyR2hKV0NoSTdBSUZrb1U0?=
 =?utf-8?B?VzRLM3VPYmNuSFZIVlRyM2w4UnhTSTlRaEFGeEZCV3kwNTJkTjVlN21DM29T?=
 =?utf-8?B?VzFXOEUrZStQNnZvTkR2R0lMQ1FsU1JTV1IwcHhuTUVrWkwrblRjS2RpS0Jw?=
 =?utf-8?B?Z2xraWhkZzFzQ3ByMmdpOENaWEg3dCtidVN3c0FQd3J1emhYT3RjWHhYcDJG?=
 =?utf-8?B?WGN6V3k1MjdLOEZub09sRERyM04yWFZWRWhEcFUyNXRGa1JObFJyRjJLb0dN?=
 =?utf-8?B?dDZScTV0OWtsRXV1SUJCVmRKZnhzRWxCR2M0akhic1RGc3BrUzJFaEtnZzNm?=
 =?utf-8?B?Slk5QzZZUmxlOHV4SmpXQm5PS2MwZmFneFp2andjMXNnUDdsL2E0WkIwNjVV?=
 =?utf-8?B?cm1ibFdTM2l5QmNDb1BOMlhtQjN6YWY4THhOSEUySCs3akVzN05QZFRodm1O?=
 =?utf-8?B?MUNiTjlodjZoTWpPQURZWUJILzdxZE5NaWkyZ01YeGFFcWVOSkR1QVU0Tzhu?=
 =?utf-8?B?djRMTWZ3aENYTzZ2bURETGN1Mlk2UllRa2Nud1VaMGJZL2FDRkYvbENaU0h1?=
 =?utf-8?B?MnRCQnJ4VVAxVVBKT04xVGFYZ0UyN256cUZGWWFCU1hzYWtjSXhkblY1ZHRk?=
 =?utf-8?B?dSsrcktPODRhbmpZNEYyK1padVFyaCt6OHJqQlZzUE16aFlhR1hQeTFuakJ1?=
 =?utf-8?B?WUFJTXdRQUo1akFDQlI5YlVDUUFVdHcrSHdkR3MyQnVHRVdzblhRUExzQmE1?=
 =?utf-8?Q?3aUZl9?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:12:39.9841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8cfbef-c554-48cc-8b8f-08dd7dcaad49
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6394

On 4/9/25 09:09, Álvaro G. M. wrote:
> On Wed, 2025-04-09 at 11:14 +0000, Pandey, Radhey Shyam wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>> 
>> > -----Original Message-----
>> > From: Álvaro G. M. <alvaro.gamez@hazent.com>
>> > Sent: Wednesday, April 9, 2025 4:31 PM
>> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub Kicinski
>> > <kuba@kernel.org>
>> > Cc: netdev@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>; Gupta,
>> > Suraj <Suraj.Gupta2@amd.com>
>> > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on MicroBlaze:
>> > Packets only received after some buffer is full
>> > 
>> > On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
>> > > [...]
>> > >  + Going through the details and will get back to you . Just to
>> > > confirm there is no vivado design update ? and we are only updating linux kernel to
>> > latest?
>> > > 
>> > 
>> > Hi again,
>> > 
>> > I've reconsidered the upgrading approach and I've first upgraded buildroot and kept
>> > the same kernel version (4.4.43). This has the effect of upgrading gcc from version
>> > 10 to version 13.
>> > 
>> > With buildroot's compiled gcc-13 and keeping this same old kernel, the effect is that
>> > the system drops ARP requests. Compiling with older gcc-10, ARP requests are
>> 
>> When the system drops ARP packet - Is it drop by MAC hw or by software layer.
>> Reading MAC stats and DMA descriptors help us know if it reaches software
>> layer or not ?
> 
> I'm not sure, who is the open dropping packets, I can only check with
> ethtool -S eth0 and this is its output after a few dozens of arpings:
> 
> # ifconfig eth0
> eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:01  
>           inet addr:10.188.140.1  Bcast:10.188.143.255  Mask:255.255.248.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:164 errors:0 dropped:99 overruns:0 frame:0
>           TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:11236 (10.9 KiB)  TX bytes:1844 (1.8 KiB)
> 
> # ethtool -S eth0
> NIC statistics:
>      Received bytes: 13950
>      Transmitted bytes: 2016
>      RX Good VLAN Tagged Frames: 0
>      TX Good VLAN Tagged Frames: 0
>      TX Good PFC Frames: 0
>      RX Good PFC Frames: 0
>      User Defined Counter 0: 0
>      User Defined Counter 1: 0
>      User Defined Counter 2: 0

FYI you can do

# ethtool -S net4 --all-groups
Standard stats for net4:
eth-mac-FramesTransmittedOK: 74
eth-mac-SingleCollisionFrames: 0
eth-mac-MultipleCollisionFrames: 0
eth-mac-FramesReceivedOK: 92
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-AlignmentErrors: 0
eth-mac-FramesWithDeferredXmissions: 0
eth-mac-LateCollisions: 0
eth-mac-FramesAbortedDueToXSColls: 0
eth-mac-MulticastFramesXmittedOK: 38
eth-mac-BroadcastFramesXmittedOK: 3
eth-mac-FramesWithExcessiveDeferral: 0
eth-mac-MulticastFramesReceivedOK: 24
eth-mac-BroadcastFramesReceivedOK: 33
eth-mac-InRangeLengthErrors: 0
eth-ctrl-MACControlFramesTransmitted: 0
eth-ctrl-MACControlFramesReceived: 0
eth-ctrl-UnsupportedOpcodesReceived: 0
rmon-etherStatsUndersizePkts: 0
rmon-etherStatsOversizePkts: 0
rmon-etherStatsFragments: 0
rx-rmon-etherStatsPkts64to64Octets: 19
rx-rmon-etherStatsPkts65to127Octets: 22
rx-rmon-etherStatsPkts128to255Octets: 9
rx-rmon-etherStatsPkts256to511Octets: 3
rx-rmon-etherStatsPkts512to1023Octets: 27
rx-rmon-etherStatsPkts1024to1518Octets: 12
rx-rmon-etherStatsPkts1519to16384Octets: 0
tx-rmon-etherStatsPkts64to64Octets: 2
tx-rmon-etherStatsPkts65to127Octets: 52
tx-rmon-etherStatsPkts128to255Octets: 18
tx-rmon-etherStatsPkts256to511Octets: 2
tx-rmon-etherStatsPkts512to1023Octets: 0
tx-rmon-etherStatsPkts1024to1518Octets: 0
tx-rmon-etherStatsPkts1519to16384Octets: 0

to get standard statistics.

--Sean


