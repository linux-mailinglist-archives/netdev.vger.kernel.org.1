Return-Path: <netdev+bounces-259707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtoNK5amGkNGwMAu9opvQ
	(envelope-from <netdev+bounces-259707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:59:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB3167A2B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7B13079FE1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF7344DAB;
	Fri, 20 Feb 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqTAOqr3"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31118340DA6;
	Fri, 20 Feb 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592363; cv=fail; b=Js0Py0e8DPg8/Yt6HybqxwqGIEZjx7N5LvDjfT8wV+bMUerfvBZncjsrSW+SVL23+SjM0C3fq5k+yEKQX7xoxix1rfSxgh2C+LYYNGyGZGEFG4gF0en9FGK1Om7HvXfNqNJjtd0yxsa/b44EGdOIKeIJZihYBLAQumboQht1LIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592363; c=relaxed/simple;
	bh=fE5FwasVT7cJyn/IpmuCIl5rQRdIc+BSZxWflT4TB0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrKV27th8ptsHvbREJtJjQrr5tuJGoSlDz8/6b10Z2Mo6NZWm0BOshTmP/agtwJR9LUsxSqmy0VmPqnZwdGRBVPD2IWZDCHUscjzn7OEpO5jZ/j3CI10VH/yzsVFkKw5DcYz9HVokQogD+tq/5Srq3jfRxB+e41ZeBdV9YLjv6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqTAOqr3; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrei+C+JGN+DkJrTzqyu9OzxdueceLM2UtAnDDb5TOpuWwEeklQ1kzG/+jb0wicDPfHR3JsHWJqA6RjBQn8RE1U1RHapcy2i9NizQ3zIeDs8fX5g1JAwP6gucoHWtoTwRTBT+c4hvegiK3xbA0jx6VoDXUuLKSoWjuSOjtZtGnf6Jafes8H4QElYkgZ3Qj2JVTaYrrt26j2VN/sOqLxmuUjr2hFQ6UiCnb4ZT5RXlauuftVLP/MDC5pTCn2DLlEkCAArmFq510tAZB75yDo25O+SN6uqxBd3SGpbVMDDN/p7MFJn5Ni1Fk2ysb/y8jKqPnBD1dcgjB9skBsw6pbtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE5FwasVT7cJyn/IpmuCIl5rQRdIc+BSZxWflT4TB0U=;
 b=GUS2k3QdwYawO9DR/JLoxFeMnVb9b9Y7PpZkTHOC9tTQ7CvzkFiyNb8rOlaIXn7xjF86RIbex+4xrFd6rwfTha5n5LkSSoFWQuV5PLIMzhX2UCek31mdlVmhEe2ZEY73xqvhCiHmpzFqz5wpIRStbGuRTJAMnlY7YACRhrwV6TVSA6pKdVcGzkX6jPbG9cL9gw7Zr6WzcKupx59F2FNm25Dc1BnycnKTl9XRHKkzfQX+/dVGzVSwQQJbP/ZMWCbG15xJnFrH/FyyogqByls1YFoslWAZ/WXRY4rRJyMtlB1CKTZUf674IvIvDk1OCuOMIlESdlq5G6ad2eNnFYgIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE5FwasVT7cJyn/IpmuCIl5rQRdIc+BSZxWflT4TB0U=;
 b=MqTAOqr3XkSEZJl3RvEGq6nCGQ9Tuoy4WVYmSJPMuQ3vlD/Q1ZuOu2LsHI6r7mxXs0Qc8WeD/0fezIX0zTUv0kWMDSzocb8cebv/RMe4RrfvrC0v6j2H1OeTq4BWuuiWRkmokCcfiGC9thp62GcX3uJtB+nAXHYFZqYa3ovx1WI=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 12:59:17 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 12:59:16 +0000
From: "Neeli, Srinivas" <srinivas.neeli@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver
 support
Thread-Topic: [RFC PATCH 0/8] xilinx: tsn: Add TSN Endpoint Ethernet MAC
 driver support
Thread-Index: AQHcoWOf2lyLhDsprUayl9crynV8IbWKOtEAgAFN2VA=
Date: Fri, 20 Feb 2026 12:59:16 +0000
Message-ID:
 <SN7PR12MB81478FB396CDD9929618C2D69368A@SN7PR12MB8147.namprd12.prod.outlook.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
In-Reply-To: <5f884e29-151a-4ee7-9e1a-d7e1f84d9f6c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-20T12:37:49.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8147:EE_|SA3PR12MB9160:EE_
x-ms-office365-filtering-correlation-id: 6d50e63f-6a69-4999-b58c-08de707fdad6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDVTUkFLZDQ1ZHU5TnN5aG41TGhOVlIwN1RpTnhRL00vNzF1dGhhRnR5aWl6?=
 =?utf-8?B?ai9uYWdkVnR6VDFlTyt5d3I3di9RSDN1SGxoajBSZjZTRE5zYXl3Y2NJTExP?=
 =?utf-8?B?bzlFS1Z3QjN5eVZkTmhmTjdXc21KK1F6K3Ryb0VGVVdCWkpGbXVyZ0ZzRnVq?=
 =?utf-8?B?emtBM1BHZ3E0T3kwbDJBUjNBSUxtVEpWaUw3UHlpUnRmV1dIcEw5SHU5OGYw?=
 =?utf-8?B?WmIrb3pBWHZwTnltQ2grbmhvSFhEaStHSVk0L2lSMnhSYVQ1OUZ2SXdxVXBU?=
 =?utf-8?B?K29PbjFFdVlGQVpGbGZnZG9zMHpDOUFXS3dBVUc5MVZaekVDRk8vVUh2UjVk?=
 =?utf-8?B?NzBmWk41bnVSUkRyM2MxSnBqcGl6bHJYeEFYVkh0VUlORzU2d3BtcmRLa1c5?=
 =?utf-8?B?dzU4ZGlQYWZMVVRlaEZxVUYvY2JTdE1wTXJuMmRlN1dCSkZlRXFQREg2UnVH?=
 =?utf-8?B?Y0phVUdsU1pTS0hvZngrVDZVTVBiZzNpMWpMeEN2MXJwS2tDcHhIbDk2TUhR?=
 =?utf-8?B?S2JuYWpPakdqUGNSZXQvT0txVS9sUFVkTnFxQjNZOVZLK25YOFBWQWZlMnRv?=
 =?utf-8?B?NnVWYmVOOHV4akpRWndoZEFOS2duSlNRVEdjKzNZMTI0UXVINWtDNS95Mldz?=
 =?utf-8?B?V3A0VGdsdkZPSEpFeklHN0xZbjc5Uk1pM0tXVkZFdUM1V1lJOXNiWjhva2k5?=
 =?utf-8?B?UkFUdWMvWWpkMU52SmFjeUJ3TkM2T3dzS0tWQUpkQWR5Y3hldFJWVXhBdW5R?=
 =?utf-8?B?MkJDaXhJR0gxVWZ5dzJKbUpHWVliQ3Y5MnhsME5ETkxTZFVKekJCS3l3aGdo?=
 =?utf-8?B?WFRGRU0xSVJIeUZ0K0RaRlBVZk82Ky9vNk1VR1JuRHJCT3llS2xTa2N0QllN?=
 =?utf-8?B?M2lXWi80cm5vdnNtQjdFczVLQWxwdW1nYmt4YXlqbGs0MFAyREp5QmI0QXRI?=
 =?utf-8?B?cFRHUHNNNmd0NHcycVVFeUxyR1hVMnFHVnVldi9pZVdSakxTU3ViajRxRFB6?=
 =?utf-8?B?aVI5dzU4TVlwTVNWNW53NzlBQzNIS3o3bHUyYWM3SUs0SDBLSHl2bHh1UGtH?=
 =?utf-8?B?OTJlNC9kOW5nSEtlSVVMRXVjbVpGamNPc2xJVnl1WmJCT29DM0lacHJGL3da?=
 =?utf-8?B?SlFDeXYrL0l6aDBOcjNZdEZHYnlUaWMwM3VYRTJDdmFOMkVFcytJU1dHME1Z?=
 =?utf-8?B?OWM3aytraStoQW95NGIxaGN2QUFjMjdEWkp0ZHR6R1RWR0dldFpobjdVRENI?=
 =?utf-8?B?bU9ibURCYWtKOTIySjhRNWJoZG9GM2RHSVhhWVJzTFpYYXJXVUR5T3RtUnNI?=
 =?utf-8?B?TkhhTW9rbFlYb3JlNlRPMjNhYmIzL1J4bHQ0NVRMVUlkdkJ5UnVTeXlLaXYw?=
 =?utf-8?B?cUQ0NXpOd09nMWppcWZsMHBBbm0vMHY2YUQyTTZPMUdDVS9VeEZBZGpSalBt?=
 =?utf-8?B?SGZST25nREdaaVhTMlo1UGd3dGh4TEdrUnZiN0Q5dFVqVlphNzV0NVRyZGY4?=
 =?utf-8?B?aSszRlJKWndlYTNvaE10MXZsREV4VDBUMHdlbXFVcGlra0lUTy9zOVVHa0pX?=
 =?utf-8?B?dGRaZE1EK1M2VVl2SVgxRVJJbnl3S3QvbDNrME9UQUc4b0N2WmtOTlNXMjEx?=
 =?utf-8?B?TmxmWEFzMitkVVVEVVkvSFBMRnlMM0lqcFJiRm81ZGlrOU1xMFQ4dGdxMFB3?=
 =?utf-8?B?MUZ6RUFqRzQ1N0J3eWxCVThybnM2ZnUxZlBldkI2SDJ2eWlKdXRGazFRWkhE?=
 =?utf-8?B?ZG95VVNlcTZvNHJuMHNRZUlsUHJiTnRTWHJzdnhjS3dHQ1Y1SU0ydlZiUXdp?=
 =?utf-8?B?WFNNRThBT1E3ZFJ6bnpGa01hNEZEdmdvR3V0TUtWTFNSYjJVcUdDQnZRUXEr?=
 =?utf-8?B?TktQaERsRlh3R1FXMFRaSHdHYzdHd0IvUHBQK29vR1E2WlY0c1JpdG1YTlVk?=
 =?utf-8?B?OGtVMjBtOGxPYmdwVTNNQjhSYXpkc1FyWU1mZEJ1VHNJaWFIUXBjU3JGcEJ4?=
 =?utf-8?B?ODY0NFBYMStVWWNUWjRsTUNXWTBJalp3OUJJbGlVK3lQbllJSE1MRWdYazV5?=
 =?utf-8?B?WTdrM0VaZDFCdWlma2JZRVpFWThCdk5LS0xPVE4ySDkxaGYxTUZXb3dxY21y?=
 =?utf-8?B?L3lQeXNuckFxZHRxNkdGbkRjazR4S1FLZnAvVnYyNnh5dzQ1NDVRNExLcTFw?=
 =?utf-8?Q?BiZI0H15kQjOWjIqnGdXT7k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ni92MnlYaFlxeEExQUovZVd4em5hcDJ5aXVUSGIwbGl6ZHcwcytSYWNSenhI?=
 =?utf-8?B?anBVVk9idzl3Ym8yeU9ra0cwVGJpNlIzOWlyM3gzalQwT3BuVWZ4OUx6Uytn?=
 =?utf-8?B?aVlLdjZPZysySldhSFhSeWhqbURSSjIyTnlQSkdnc0RBMllxSkFNYmtnek03?=
 =?utf-8?B?QWdqYlhTQ0NYSjcxU2RaSE9CS3VBMkFxOHB0T3RheDdLT3ZleFNMUTdlT0NX?=
 =?utf-8?B?aUJvbUhlMXVJR09HUnVPQTFVN1hVaG5tVVloVnVERDFhb1BKTkJGejhiUDZo?=
 =?utf-8?B?azQramRKRVBBU1FvcE5DYUd3NXVVM255NWk1bW0vdEg5SnR5WGFTR1lGSXgv?=
 =?utf-8?B?K0lkL1F4bkdHdTJGNjQvVmlUc2FRV040dzZpQ01pQU8xRHNDVEdCNFV4TEU4?=
 =?utf-8?B?MWtBQytFT2lTaTJUeDE4Tng2YWczNlE4cW5EWjFDL1lMUThxQTlpSzR1MWxi?=
 =?utf-8?B?ZTV6VTU2eExjVWk3THBrNTZCSzc2YWR1K2NDbGhRajc0NXR2eG5LYUViMEFt?=
 =?utf-8?B?YWtscExaMG1IcUtoMERRMVZlNk5RWGR6QzlLUGVWOU9Pc0JlQS8vNmNJcFRq?=
 =?utf-8?B?WndyeFRBZjgvOUdicnVqNmh3NGpFWmtlMGRydVVQUDJwaTdzM1FPQ25HQ3Vh?=
 =?utf-8?B?RVYzQXB0Rk10THZkYlI3TE5uR2Z1SDBGRUFRcWx1WGxaMFNVNFZEVTE1cDZj?=
 =?utf-8?B?K1dWd0J4Y0hHU1hBeGpQWXMyWXJkSkxQcEFEWXY1SjdkV3Erc0hQRkNBSUxW?=
 =?utf-8?B?b1cydmt0Ym0vdVplendJdmRTbFU0Rm40bDJZQXlKL0FvYzFDK0V0VmwrekJD?=
 =?utf-8?B?MmhZMVEyT1lBSDVZM01vNWFxV1pvWHh0WFR6cG5wOG9sdENMYXlXM3AxQ2s1?=
 =?utf-8?B?WFc0N2hwd2VXbXkvWEIwd1BRMXEwUTlQTGRKbUJHVUlYbHdwN0Nza2lSZEVW?=
 =?utf-8?B?RU9VU29weTB3SmtBL2Y5TjRZaG02QUM2Um16UmhZd2hBQkNnQk5pOWpva2Nr?=
 =?utf-8?B?ZE15UnUwRU5lQUVYNVRjSWoyWUozQ1JVamVzb2FpRlNUVUhheTByMTNxalQv?=
 =?utf-8?B?YnE2V01lY2djcjhCSnpPZVR0RGU1L3hWMDRUM0dkQ3hpK2hRYTk1aWVTVnRD?=
 =?utf-8?B?N2NxMFpMRjEvRkYwbFVwRmVvUVRRaUY5NHhwSkNHWHdVQUpBUXUyNUx2MWVI?=
 =?utf-8?B?SU1tQkhsUkU3U282N28zOVQ5MDBzT3EzS0FhZXE0MjV5Q0NXQjRaZFNSc2I2?=
 =?utf-8?B?ZHFldUVxSkF3RWpqeHE3ZngvSWM2Yk9hWVBuTUJZd3pBVWlBOU14VWVSZmw0?=
 =?utf-8?B?VnJQdXNhSEhaUnpadXlrdERpRjNHODBSczAwMGw1dnlud0tlU2xwazJpangv?=
 =?utf-8?B?eTBzNmprTXdzMCtjTVBLODhxWWVyQndIWDVDdGpsczlqQzh4bktFbkdGcXJN?=
 =?utf-8?B?WXNKS0p6TjBhb0xKYkFEb2hPMHkyUmVOUVJQdXJkcUZqbFNPWlhDcXA0T3Vw?=
 =?utf-8?B?WGhDZE8yK1paVWt1YlJ2bU1YTTJFR3lRbmRNdytpUWF2L04xdjdncWxvY2tP?=
 =?utf-8?B?MXZkd3V0Y0h1bGZ2STJXWjRiUlNrUEY1b1l2eUp4VmM3NTJ0LzViemF4L0Ro?=
 =?utf-8?B?RE9zMW1ScEVMRlNRQThxcjczQ0ZBaFZtL2QxVHNYUHQvUUxrdkRZMk1Qb0lQ?=
 =?utf-8?B?amxocC9pNEhIWmkxbUhiQU1jTEpyeWxQblg5YndVT1Z4Nm5DTTJSQUhnZHhU?=
 =?utf-8?B?QzdrNGl0YWJwTWhxODdhU0w1UzVoMmYwUFVpRHZNcUZ4U2RmQThpNFZVMGZR?=
 =?utf-8?B?UkNxbHFSUGVhMkRqWVYyUUtuY21MTjBnZmNPMmFRek8wT1BlaXNHUVlEQW5z?=
 =?utf-8?B?UUQ3RDBNV1FaNVdMY1NhM1VXeHZtNXZLS1RRTFFpTHErTGZPWWpUZjFuamJ4?=
 =?utf-8?B?Q096WVM3RWMwOFVJalNUSG01YkxOUGlhL0ZnWTBZSXREemJkcml6VXZNRk5L?=
 =?utf-8?B?VHhrcS9PV3ZhMGtFK3ZhUGtOOFJHZkhtLzBDNytzdHhNOXlsTXVuazlPbEdK?=
 =?utf-8?B?N1JXd0Jjb3NDTHZ3S0Rwa1NEOWlYeU90Z0R4eENtK1FxOE5lcXVaVGhLSkFq?=
 =?utf-8?B?dUEwWlhGSVhpSGUzc25Nd2lwSE1mY1diTkZ6S00zdlR6d1M1YndKQmJjb2lP?=
 =?utf-8?B?YjNqWnMwVXAxMW51SUsxWEhYR2ZhL1FsVzl3UjQyV2s2Qlh0UndaQldxakpW?=
 =?utf-8?B?N3M0VlNGSzVMQkI2T0g1MW1EbEV1VzhtUU91cXh1SkVldzl1NW5Sc2tDKzJZ?=
 =?utf-8?Q?sYCYEOxfDCIsrfMPkJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d50e63f-6a69-4999-b58c-08de707fdad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 12:59:16.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyxRw68qrseOgnhb7BsovmxlOHSHuFYY6DnMnAhabRCgqwT5Rn5frjv8VSPBluS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259707-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 2FFB3167A2B
X-Rspamd-Action: no action

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQW5kcmV3LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFu
ZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDE5
LCAyMDI2IDEwOjEzIFBNDQo+IFRvOiBOZWVsaSwgU3Jpbml2YXMgPHNyaW5pdmFzLm5lZWxpQGFt
ZC5jb20+DQo+IENjOiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5j
b207IFNpbWVrLA0KPiBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHJpY2hhcmRj
b2NocmFuQGdtYWlsLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzhdIHhpbGlueDogdHNuOiBBZGQgVFNO
IEVuZHBvaW50IEV0aGVybmV0IE1BQw0KPiBkcml2ZXIgc3VwcG9ydA0KPg0KPiBPbiBUaHUsIEZl
YiAxOSwgMjAyNiBhdCAxMToxOTowM0FNICswNTMwLCBTcmluaXZhcyBOZWVsaSB3cm90ZToNCj4g
PiBJbnRyb2R1Y2UgYSBuZXcgbmV0d29yayBkcml2ZXIgZm9yIHRoZSBBTUQgTG9naUNPUkUgMTAw
TS8xRyBUU04NCj4gPiBTdWJzeXN0ZW0gSVAsIGFsc28ga25vd24gYXMgdGhlIFRTTiBFbmRwb2lu
dCBFdGhlcm5ldCBNQUMsIHdoaWNoDQo+ID4gaW1wbGVtZW50cyBJRUVFIDgwMi4xIFRpbWUtU2Vu
c2l0aXZlIE5ldHdvcmtpbmcgKFRTTikgZmVhdHVyZXMgZm9yDQo+ID4gZGV0ZXJtaW5pc3RpYyBh
bmQgbG93LWxhdGVuY3kgRXRoZXJuZXQgY29tbXVuaWNhdGlvbiBpbiByZWFsLXRpbWUgYW5kDQo+
ID4gaW5kdXN0cmlhbCBhdXRvbWF0aW9uIHVzZSBjYXNlcy4NCj4gPg0KPiA+IElQIENvcmUgT3Zl
cnZpZXc6DQo+ID4gVGhlIEFNRCBMb2dpQ09SRSAxMDBNLzFHIFRTTiBTdWJzeXN0ZW0gSVAgc29s
dXRpb24gKG5hbWVkIGFzIFRTTg0KPiBFbmRwb2ludA0KPiA+IEV0aGVybmV0IE1BQyBJUCBpbiB0
aGUgSVAgY2F0YWxvZykgaW1wbGVtZW50cyBJRUVFIDgwMi4xIFRpbWUgU2Vuc2l0aXZlDQo+ID4g
TmV0d29ya2luZyAoVFNOKSBTdGFuZGFyZHMgYW5kIHByb3ZpZGVzIGEgbG93IGxhdGVuY3kgQnJp
ZGdlZCBFbmRwb2ludCBvcg0KPiA+IEVuZHBvaW50IG9ubHkgc29sdXRpb25zLg0KPg0KPiBTbyBh
biBFbmRwb2ludCBvbmx5IHNvbHV0aW9uIGlzIG5vdCBjb25uZWN0ZWQgdG8gdGhlIHN3aXRjaD8g
SXQNCj4gb3V0cHV0cyBSR01JSSwgY2FuIGhhdmUgYSBQSFkgY29ubmVjdGVkIHRvIGl0LCBhbmQg
c28gaXMgYSBzaW5nbGUNCj4gbmV0ZGV2IGludGVyZmFjZT8gWW91IHdvdWxkIHR5cGljYWxseSB1
c2UgdGhpcyBpbiBhIGNsaWVudD8NCj4NCj4gQnV0IHlvdSBjYW4gYWxzbyBpbnN0YW50aWF0ZSB0
aGUgc2FtZSBNQUMgbXVsdGlwbGUgdGltZXMsIGNvbm5lY3RlZCB0bw0KPiBhbiBFdGhlcm5ldCBz
d2l0Y2g/IFRoYXQgd291bGQgYmUgdGhlIGJyaWRnZWQgZW5kcG9pbnQ/DQo+DQoNClllcywgdGhh
dCB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QuDQpJbiBFbmRwb2ludCBvbmx5IGNvbmZpZ3VyYXRp
b24sIHRoZSBUU04gRW5kcG9pbnQgaXMgY29ubmVjdGVkIEV0aGVybmV0IE1BQyBhbmQgb3BlcmF0
ZXMgYXMgYSBzdGFuZGFsb25lIE1BQywgY29ubmVjdGVkIHZpYSBHTUlJL1JHTUlJIHRvIGEgUEhZ
LA0KYW5kIGlzIGV4cG9zZWQgdG8gTGludXggYXMgYSBzaW5nbGUgbmV0ZGV2LCBzaW1pbGFyIHRv
IGEgY29udmVudGlvbmFsIEV0aGVybmV0IGNvbnRyb2xsZXIuDQpJbiBCcmlkZ2VkIEVuZHBvaW50
IChTd2l0Y2ggRW5kcG9pbnQpLCB0d28gcG9ydHMgY29ubmVjdHMgdG8gdGhlIG5ldHdvcmsgYW5k
IG9uZSBwb3J0IGNvbm5lY3RzIHRvIGFuIGludGVybmFsIEVuZHBvaW50Lg0KVGhlIGludGVybmFs
IGVuZHBvaW50IGNvbm5lY3RzIHRvIHRoZSBDUFUgYW5kIGV4dGVybmFsIHBvcnRzIGNvbm5lY3Qg
dG8gUEhZcy4NCg0KPiA+IFRoZSBicmlkZ2VkIGVuZHBvaW50IHNvbHV0aW9uIGNvbnNpc3RzIG9m
IGEgMy1wb3J0DQo+ID4gc3dpdGNoIHRoYXQgY29ubmVjdHMgdG8gYW4gZW5kcG9pbnQgaW5jbHVk
aW5nIExpbnV4IHNvZnR3YXJlIGRyaXZlcnMuIEZvcg0KPiA+IEJyaWRnZWQgRW5kcG9pbnQgKFN3
aXRjaCBFbmRwb2ludCksIHR3byBwb3J0cyBjb25uZWN0cyB0byB0aGUgbmV0d29yayBhbmQNCj4g
PiBvbmUgcG9ydCBjb25uZWN0cyB0byBhbiBpbnRlcm5hbCBFbmRwb2ludC4NCj4NCj4gVG8gdGhl
IGhvc3QsIGRvZXMgdGhlIGludGVybmFsIGVuZHBvaW50IGp1c3QgbG9vayBsaWtlIGEgc3RhbmRh
cmQNCj4gbmV0ZGV2Pw0KDQpZZXMuIEZyb20gdGhlIGhvc3TigJlzIHBlcnNwZWN0aXZlLCB0aGUg
aW50ZXJuYWwgZW5kcG9pbnQgaXMgZXhwb3NlZCBhcyBhIHN0YW5kYXJkIExpbnV4IG5ldGRldi4N
Cg0KPg0KPiBXaGF0IGknbSB0cnlpbmcgdG8gZG8gaXMgZ2V0IGFuIGFuc3dlciB0bzogSXMgdGhp
cyBhIERTQSBzd2l0Y2gsIG9yIGENCj4gcHVyZSBzd2l0Y2hkZXYgc3dpdGNoLiBJZiB0aGUgaG9z
dCBzZWVzIGEgbmV0ZGV2IHdoaWNoIGlzIGNvbm5lY3RlZCB0bw0KPiBhIHBvcnQgb2YgdGhlIHN3
aXRjaCwgaXQgaXMgcHJvYmFibHkgYSBEU0Egc3dpdGNoLiBJZiB0aGUgaG9zdCBvbmx5DQo+IHNl
ZXMgdGhlIHVzZXIgcG9ydHMsIGl0IGlzIHByb2JhYmx5IGEgcHVyZSBzd2l0Y2hkZXYgc3dpdGNo
Lg0KPg0KDQpXZSBhcmUgcGxhbm5pbmcgdG8gaW1wbGVtZW50IGEgcHVyZSBzd2l0Y2hkZXYgZnJh
bWV3b3JrIGZvciB0aGUgc3dpdGNoLCBhcyBQVFAgcGFja2V0cyBhcmUgc2VudCBkaXJlY3RseSBm
cm9tDQp0aGUgbmV0ZGV2IGludGVyZmFjZXMgdGhhdCByZXByZXNlbnQgdGhlIGV4dGVybmFsIG5l
dHdvcmsgcG9ydHMuDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvciBzdWdnZXN0
aW9ucyBpZiB5b3UgZmVlbCBhIGRpZmZlcmVudCBhcHByb2FjaCB3b3VsZCBiZSBtb3JlIGFwcHJv
cHJpYXRlLg0KDQo+ID4gSXQgc3VwcG9ydHMgdGhlIHVzZSBvZg0KPiA+IEdNSUkvUkdNSUkgaW50
ZXJmYWNlcyBjb25uZWN0aW5nIHRvIGEgcGh5c2ljYWwtc2lkZSBpbnRlcmZhY2UgKFBIWSkgY2hp
cA0KPiA+IHdpdGggZnVsbCBkdXBsZXggMTAwIE1iL3MgYW5kIDEgR2IvcyBvcGVyYXRpb25zLg0K
Pg0KPiBObyAxME1icHMgc3VwcG9ydD8NClllcywgdGhhdCBpcyBjb3JyZWN0LiBUaGUgY3VycmVu
dCBUU04gRW5kcG9pbnQgRXRoZXJuZXQgTUFDIHN1cHBvcnRzIDEwMCBNYi9zIGFuZCAxIEdiL3Mg
ZnVsbOKAkWR1cGxleCBtb2RlcyBvbmx5LiAxMCBNYi9zIG9wZXJhdGlvbiBpcyBub3Qgc3VwcG9y
dGVkIGJ5IHRoZSB1bmRlcmx5aW5nIGhhcmR3YXJlIElQLg0KDQo+DQo+ID4gLSBQcm92aWRlcyBm
ZWF0dXJlIHJpY2ggRXRoZXJuZXQgU3dpdGNoIHRoYXQgY2F0ZXJzIHRvIHZhcmlvdXMgbmV0d29y
aw0KPiA+ICAgbmVlZHMNCj4gPiAgICAgKiAzLXBvcnQgU3dpdGNoICgyLWV4dGVybmFsLCAxLWlu
dGVybmFsKQ0KPiA+ICAgICAqIFByb2dyYW1tYWJsZSBjdXQtdGhyb3VnaCBhbmQgc3RvcmUtZm9y
d2FyZCBvcGVyYXRpb25zDQo+ID4gICAgICogNC1wb3J0IFN3aXRjaCAoMi1leHRlcm5hbCwgMi1p
bnRlcm5hbCkgZXh0ZW5zaW9uIHRocm91Z2gNCj4gPiAgICAgICAgICAgJ0VuZHBvaW50IEV4dGVu
c2lvbicgYW5kICdFbmRwb2ludCBQYWNrZXQgU3dpdGNoaW5nJyBmZWF0dXJlcw0KPg0KPiBXaHkg
bm90IE4tcG9ydHM/IElzIGl0IHJlYWxseSBzZXQgdG8gMyBvciA0PyBJdCBjYW5ub3QgYmUgc3lu
dGhlc2lzZWQNCj4gZm9yIDUsIDg/DQo+DQoNClRoZSBudW1iZXIgb2YgcG9ydHMgaXMgZml4ZWQg
YnkgdGhlIElQIGNvbmZpZ3VyYXRpb24uIFRoZSBzdGFuZGFyZCBUU04gU3Vic3lzdGVtIElQIHN1
cHBvcnRzIDMgcG9ydCBvcGVyYXRpb24gKDIgZXh0ZXJuYWwgKyAxIGludGVybmFsKSwNCndpdGgg
YW4gb3B0aW9uYWwgZXh0ZW5zaW9uIHRvIDQgcG9ydHMgdXNpbmcgZW5kcG9pbnQgZXh0ZW5zaW9u
IGZlYXR1cmVzLg0KQXJiaXRyYXJ5IE7igJFwb3J0IHN5bnRoZXNpcyAoZm9yIGV4YW1wbGUgNSBv
ciA4IHBvcnRzKSBpcyBub3Qgc3VwcG9ydGVkLg0KDQoNCj4gPiBTYW1wbGUgaGFyZHdhcmUgYXJj
aGl0ZWN0dXJlIGRpYWdyYW0gZm9yIEJpZGdlIEVuZCBQb2ludCBsaWtlIGJlbG93Og0KPiA+DQo+
ID4gICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gICAgICAgICAgICAgIHwg
ICAgICBNQ0RNQSAgICAgICB8DQo+ID4gICAgICAgICAgICAgICstLS0tLS0tLS0rLS0tLS0tLS0r
DQo+ID4gICAgICAgICAgICAgICAgICAgICBRMC0tLVE3DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+ID4gICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKw0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAg
fCAgICAgVFNOIHN1YiBzeXN0ZW0oQnJpZGdlIEVuZCBQb2ludCkgICAgICAgfA0KPiA+ICAgICAg
ICAgICB8ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgfCAgICAgKy0tLS0tLSstLS0tKyAgUG9ydCAwICAg
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICB8DQo+ID4gICAgICAgICAgIHwgICAgIHwg
IEVuZFBvaW50IHw8LS0tLS0tLS0tPnwgICAgICAgVFNOIFN3aXRjaCAgICAgIHwgICAgICAgfA0K
PiA+ICAgICAgICAgICB8ICAgICB8ICAgIChFUCkgICB8ICAgICAgICAgICArLS0tLSstLS0tLS0t
LS0tLS0tKy0tLS0rICAgICAgIHwNCj4gPiAgICAgICAgICAgfCAgICAgKy0tLS0tLS0tLS0tKyAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwgICAgICAgICAgICB8DQo+ID4gICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgfA0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUG9y
dCAxICAgICAgICAgUG9ydCAyICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwgICAgICAgICAgICB8DQo+ID4g
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tKyAgKy0t
LS0tLS0tLS0tKyAgICAgfA0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIE1BQy0xICAgIHwgIHwgIE1BQy0yICAgIHwgICAgIHwNCj4gPiAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAoRVRIMSkgICB8ICB8ICAoRVRIMikgICB8ICAg
ICB8DQo+ID4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tKy0t
LS0tKyAgKy0tLS0tKy0tLS0tKyAgICAgfA0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgfA0KPiA+ICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAg
ICAgfA0KPiA+ICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUkdNSUkgICAgICAgICAgIFJHTUlJDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
fA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0t
KyAgKy0tLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgUEhZMSAgICAgfCAgfCAgUEhZMiAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAoUG9ydCAwKSAgfCAgfCAoUG9ydCAyKSAgfA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tKyAgKy0tLS0tLS0t
LS0tKw0KPiA+DQo+DQo+IFNvIGhvdyBkb2VzIHRoZSBob3N0IHNlbmQgYSBmcmFtZSBvdXQgUG9y
dCAyPyBJcyB0aGVyZSBhbiBleHRyYSBoZWFkZXINCj4gb24gdGhlIGZyYW1lIHNlbnQgYnkgRW5k
UG9pbnQsIHdoaWNoIHRoZSBzd2l0Y2ggaW50ZXJwcmV0cz8NCj4NCg0KSW4gdGhpcyBSRkMsIEkg
Y29uZmlndXJlZCBhbGwgc3dpdGNoIHBvcnRzIGluIGZvcndhcmQgbW9kZS4gQXMgYSByZXN1bHQs
IHdoZW4gYSBmcmFtZSBpcyBzZW50IGZyb20gdGhlIGludGVybmFsIGVuZHBvaW50LCBpdCBpcyBm
bG9vZGVkIHRvIGJvdGggZXh0ZXJuYWwgcG9ydHMuDQpUbyBmb3J3YXJkIHBhY2tldHMgdG8gYSBz
cGVjaWZpYyBwb3J0IGluc3RlYWQgb2YgZmxvb2RpbmcsIGVpdGhlciBzdGF0aWMgc3dpdGNoIENB
TSBlbnRyaWVzIG5lZWQgdG8gYmUgY29uZmlndXJlZCBvciBhZGRyZXNzIGxlYXJuaW5nIHNob3Vs
ZCBiZSBlbmFibGVkIHNvIHRoZSBzd2l0Y2ggY2FuIGxlYXJuIENBTSBlbnRyaWVzIGR5bmFtaWNh
bGx5Lg0KDQoNCj4gRllJOiBTZWVtcyBsaWtlIFBIWTEgKHBvcnQgMCkgaXMgYSB0eXBPLg0KPg0K
SGVyZSwgUEhZMSAocG9ydCAwKSBhbmQgUEhZMiAocG9ydCAyKSByZXByZXNlbnQgdGhlIGV4dGVy
bmFsIGRhdWdodGVyIGNhcmQgcG9ydHMgdGhhdCBJIGNvbm5lY3RlZCB0byB0aGUgSVAgZm9yIHRl
c3RpbmcuDQpJIHJlYWxpemUgdGhpcyByZXByZXNlbnRhdGlvbiBtYXkgYmUgY29uZnVzaW5nLCBz
byBJIHdpbGwgcmVtb3ZlIHRoZXNlIHBvcnQgcmVmZXJlbmNlcyB0byBhdm9pZCBhbnkgY29uZnVz
aW9uLg0KDQo+ID4gLSBEdXJpbmcgZHJpdmVyIGluaXRpYWxpemF0aW9uLCBhbGwgc3dpdGNoIHBv
cnRzIChFbmRwb2ludCwgTUFDMSwgTUFDMikNCj4gPiAgIGFyZSBjb25maWd1cmVkIGludG8gdGhl
IEZvcndhcmRpbmcgc3RhdGUgdG8gZW5hYmxlIGRhdGEgZmxvdyBhY3Jvc3MgdGhlDQo+ID4gICBm
YWJyaWMuDQo+DQo+IFdoaWNoIGlzIHdyb25nLiBUaGUgTGludXggbW9kZWwgaXMgdGhhdCBzd2l0
Y2ggcG9ydHMgYXJlIGp1c3QNCj4gbmV0ZGV2cy4gWW91IGNvbmZpZ3VyZSB0aGVtIGp1c3QgbGlr
ZSBldmVyeSBvdGhlciBuZXRkZXYgaW4gdGhlDQo+IHN5c3RlbS4gTmV3bHkgY3JlYXRlZCBuZXRk
ZXZzIGFyZSBzdGFuZGFsb25lLiBUaGV5IG9ubHkgYWxsb3cgZnJhbWVzDQo+IHRvIHBhc3MgYmV0
d2VlbiB0aGUgd2lyZSBhbmQgdGhlIGhvc3QuIElmIHlvdSB3YW50IHRoZW0gdG8gTDIgZm9yd2Fy
ZHMNCj4gZnJhbWVzIGJldHdlZW4gcG9ydHMgeW91IG5lZWQgdG8gYWRkIHRoZW0gdG8gYSBicmlk
Z2UuDQo+DQo+ICAgICAgIEFuZHJldw0KQ3VycmVudGx5LCBJIGhhdmUgdmFsaWRhdGVkIHRoZSBi
ZWhhdmlvciB1c2luZyBmb3J3YXJkIG1vZGUuIEJhc2VkIG9uIHRoZSBmZWVkYmFjaywgSSB3aWxs
IGltcGxlbWVudCB0aGUgcmVxdWlyZWQgc3dpdGNoIGNvbmZpZ3VyYXRpb24gY2hhbmdlcyBpbiB0
aGUgbmV4dCBwYXRjaCBzZXJpZXMuDQoNClRoYW5rcw0KTmVlbGkgU3Jpbml2YXMNCg0K

