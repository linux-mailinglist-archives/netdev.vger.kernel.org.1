Return-Path: <netdev+bounces-136387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84659A193B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7112B287A9A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0F42ABE;
	Thu, 17 Oct 2024 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CVbXx2NW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C8F6C;
	Thu, 17 Oct 2024 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134916; cv=fail; b=S9/RhOM/NF6YxTnxLteeoW8Udu3uWIHvAQLeBNM4PPNTURov0+CI5uUS7kgb7uBMEG+luRMAEzkv8jQMnm33scTJ1pNPyl4vJHUQBIcTmIk9Hs1zI8zIwHWyQBnhGepPJfTtfsjg9fi8BvxMXh1EdzQaP0P+/EiwLyZwEU/IcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134916; c=relaxed/simple;
	bh=+OHx/GCSXNSizxxG29Tjz4P6PSmaxQiuxp2eY/4iPXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rgCDqntuCWCAw4HI/HRcPrwBbngP+0bx0o07McH4jcCOfBzev7LWcR/F+N83wULO+LdtuDqTgADcDIpLNBN/6LHgfVuCXXkg76bZvvMKTVX8vheqd8DxF0dUObtZHLIuRMU5NkwEq6Y6pB516N6WXiisUj8V5QG9sHSZGFe/kQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CVbXx2NW; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxiy5TJKXdcb4Zjd17glq8icIG6iYg+yMKDITUkdVW7ZWvBSV19WoMKYmzJikgV9CBLFXwHgGarhePG2IP5Yo+F6lgUgxjvoTdvZ1nrJIjAaupb7pBgnwEBWFbNf3lE6N7r0+iSy9hGxZIMQX0vDoilNlmOGc2fp8psnyQ+8Qs4gv/s1TZ65JkuwthTaLJHLvs+Ki5jz6xfxwy1WIuegQJ8NRJcq2d5jIsIY0Hbm7UUlTJm2rL7sDfPFQCyholU9O+S4pMbHZKmPwqC6Vco2o6Ek7zeOxrXw1yUVt6cHqDA6WNTrRrKkI5w8owKp8UkZxaJq6LMiPBD4++ucCdJJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OHx/GCSXNSizxxG29Tjz4P6PSmaxQiuxp2eY/4iPXM=;
 b=wSYBaUK6/raYPmPSs2C5nCHu1PKFGn7oL/3umuSIlrpks7D9HzZR+LnhVPCAclSCMs19yV3gsJ6wiEeXUDZxnN4q8fi1L/aIHE3s4kFFRvga507tSI8HT9jK+QFFQGTFvcBTC9zpeumsjPKX7P2vIn8Y9rodXb9Q3xF4ezCRI1fC+/y8fK5KadYlWjCLYczv4/C3xTCZfinptLFa7/INEhaBP33yxdftPihYzNZnzuQ/vE69gaQDbMawGMdsxgCE1k8DOp/sHGe2eJJzjOfS8shVAK5Gq63LISNFs1yS0nk0kTlpxogPgM8qH4WYQ/XfScgugjI0XO0QBzDdILnlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OHx/GCSXNSizxxG29Tjz4P6PSmaxQiuxp2eY/4iPXM=;
 b=CVbXx2NWOgJQh2QU7xWWccnwdXbhTz4uUMKdyU+UZYxRHaeLThCuz7p601DqDTrZhiRDxszNThKK9ZF+QvQlyHM/fmExiLUWy2lJJUQPaVvT1hBjxcWH7fss9V0FZSNzfM+IcmyA1fn/iYBqAXEKvfYmauFR46rxPF+08E6b0uzAY+3fdMX9URux9Rvgkjxw8HkiT3Egtpxz1WDUPstXKcjaiDmQ1D9e+gJIEZMoEaFUunZzxKhjW2gl7u3l2s5/+NzPnsWsOZaZRQIx14Prsy8Djy+fw6lGkrbd+lgULmtY+w7aL3/uyHylQZSAnDNZjPzToddXjUkRAqjKferQmA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 03:15:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:15:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 10/13] net: fec: fec_enet_rx_queue(): replace
 open coded cast by skb_vlan_eth_hdr()
Thread-Topic: [PATCH net-next 10/13] net: fec: fec_enet_rx_queue(): replace
 open coded cast by skb_vlan_eth_hdr()
Thread-Index: AQHbIBW2Su+SW/a2Uk+FGdUeu+F7n7KKRVNg
Date: Thu, 17 Oct 2024 03:15:09 +0000
Message-ID:
 <PAXPR04MB8510E1BB81106DD43249A08188472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-10-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-10-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS4PR04MB9388:EE_
x-ms-office365-filtering-correlation-id: 37a89482-cc6f-429b-8e5a-08dcee59e87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXE3UCtDbUxlRTN6ODd4a0FWeXNFYzZUbGREZEVLK3Y1Rm54MEFFbE5XaEcz?=
 =?utf-8?B?RE9VajNHQjlwV3hHZ2o3RkVCRkVoZEtHQVNBRkVmdlFTTENvYUd0ZCsxRXh5?=
 =?utf-8?B?RjNDUmQ2ekFTdWplV09MZmN1SVFPNmNpRTR2ekt2VTVBQ0V1dkorTDVXNis1?=
 =?utf-8?B?NTNKL3ZlSnE2ako5T0h4SEtCS0xLZ2JHOEhRY2hkYllxTWRWQkx2K0JlUFJ5?=
 =?utf-8?B?dmVBWmV2ZmJFRnNON21LdjBtYjRkK1Bpc3V1NGNWTXJubVNNK09qYWxMbzNM?=
 =?utf-8?B?RUZJOG5wNUU4WDUvZ3I0Q00zN3VCSzRWYmtzano3ODNtTi9BeG4wcWJmNGpw?=
 =?utf-8?B?U1RvdXJHeE5xZldWckV1QUM1L1o2V0oxeFNudk9SdVpHVjk1clhnWWtydDRi?=
 =?utf-8?B?dVBmditjV1NqTVhrZE1BNXhwOVpuRXZpOCt5RldOamRxaExqbXhuSE9DWWZm?=
 =?utf-8?B?M1hrNk96TmVGU0w3U0Fsd3FFODlOQ0RYM21sZ1lWMzJaUFhGZnp1bGE5OFl1?=
 =?utf-8?B?MkdlcUwwVWFNY0JJMWxOM2Z5ZFNodWJaSUtxaVBJWWdBNFFNbXd6Y2QwNnB2?=
 =?utf-8?B?c3hmdVRGZW9lRFV4Ny9sM29lV2dpbGQyZTNZVG5nWHhEUHh2MXJuTmtkeU1Q?=
 =?utf-8?B?R1BBb1FpUEFXeXlmQ0k2YWxqclM0ZnVleTZoSUMxTGVsa0RMckJ3RnBDZ213?=
 =?utf-8?B?Tk9RQy8yWnBrSm9QNnBab3lGdUI4a2JjdDI0aFEzbVNsQWtueFU0TE84K0x0?=
 =?utf-8?B?elB4RDV4SktCczJndVY4L1p0dkp6cXJ5bndFNHlNR0MxdWZHT2tleUkydEJL?=
 =?utf-8?B?akxDZCsxbGFCdlZRcE1LcVZlY21kaFdCYjhFS2NlZDBETVdsS1AzeVZiaUg0?=
 =?utf-8?B?OE9RZ2tnNlVTS253bzZzZ0Q1ZzB3Z09FSWFCQTNkQTdsSHZCanFwVm1xdVBw?=
 =?utf-8?B?eUJrOFdYa1lYWWo5c1NsY0gwZU92K0tMZG1LbFJDNExBWXJjdlJwaHFZRGVI?=
 =?utf-8?B?Y083VHJCczgwOENRM2Z0T2VDOWs3b0lHUzhHZE9EdXI5aWhaWUZrN3Exb0g4?=
 =?utf-8?B?NVZZcXM1cDk1bzF2OExFSHhSQkNpdFhTdUxkbVZUdzdEUkl0Y2UwVzQrQ1hi?=
 =?utf-8?B?bFFyZkRoS05FaENTUGlvS3BmSDJzcEYya21BVVl4WkN1ekFjVnV3bnBudXc2?=
 =?utf-8?B?WERSOXZLSFZRTjJnRXBjU0dKbUxEZFB5eWg3UXdMOUgvVUpYMndtR2orekY4?=
 =?utf-8?B?bXhIRTFHWGtoSHU4b0QveHBkRHUyOGNhQ2VGS2JZTnBVeUlQQm1CbzF0NjhE?=
 =?utf-8?B?a2FJRFdDbmJIMkZrMmgxZWZFbkdiajBTVkpiazBKcWU2K3lxWmk3T1pneExG?=
 =?utf-8?B?ajA0eXhpTWFYdm1waDJ6SUI0UFNGUVlFN2pwRUpSdmNnejlGSXRpRFBldXBr?=
 =?utf-8?B?T0dsY1dScGd2WE1LWHFXUlpDSllNeTNTandOa0xjQmo1NkJTSFk2NVNHWktI?=
 =?utf-8?B?VjNhZHRLVG8yWEMxV3g4ekZQM0doYVgzaXZZL09HSTdpWlVmTHNXaUZzTHhQ?=
 =?utf-8?B?Qmk5L0xBSThVaWtHWGR1dnhUTG9mS28zU3pWaW1iN0plK1RySFAwYnFYZ2pq?=
 =?utf-8?B?Nm1SdVZESlljazRXNDVBU1Z5ZkJ1WW56aXhDMVRwM05Xb2xCWnF4K2VtbkVv?=
 =?utf-8?B?TFRHTnJTbHYybE5RaTNQYlVKeG1JZkdLd2FhZndrTFJ1R29nU2dkQmNOdHIw?=
 =?utf-8?B?SjdKdE5vQjcydXR0NmM0d0pFZE05VnB6RU5rZUlodmNsRHdMYVFSZWpmaUpR?=
 =?utf-8?Q?soK9loMeqBNOV3m7bXBmrUyx8PZutSJkaFEn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXpzWjZHdlBkZ3JNV2tXV0trVWFONndWMWZBeTdDMWVWeHM0bmtZdCtzUndY?=
 =?utf-8?B?M2xZYmNPNUtFdDIxUjJiYmJRSFJDVUUvdjRmZW9TTTd3N1BJdklyY1ZZMUpR?=
 =?utf-8?B?eFA5V1NJQ2t5L0RyWUFpa0ZRRnlQVG1LREg5Rm40dUlQL1E1Y1g1Z3Exa2VI?=
 =?utf-8?B?aW5xWVI5UXJtd1Q0N2MxdzYxVTlFY1RVNHRHMnU3UlNTQ3dWVDhwMElwUHhV?=
 =?utf-8?B?U1hxdXU0dUYwRS81NGkxMEhSaU1rcUZHUExOR1dVM1BGcHRxMGVIZ2Vsdk12?=
 =?utf-8?B?eGI5OVdjaS9OK1dGVGwwNjk3K3VRcXBrTUEvcFBtb0VwZlhPVE5QVDg4cUNr?=
 =?utf-8?B?ZzRVUmoyK1ZDUTlLMFNRUGVtQ0ZRcDc1VjdoZjVJYlRxNUcrMU1odXRBMW1Z?=
 =?utf-8?B?TC9tQWFmRE5TL2VzUzNwQ2Q4d3pyNkNaaUFXQUl1bzFLRjFzVEw1M0ZEU3lp?=
 =?utf-8?B?MnZvS29BK3VLSk5wcENLL2tRTHc1Z3NJZm42aEJLQU40UWwxQmlkdytUUmIr?=
 =?utf-8?B?UDJFWXh0OVRPNjZ3REJUVHpjaEo1WEhFUjdkYkw4b0xGMUxLRkpFeVo2ZlRQ?=
 =?utf-8?B?U092ZjlXQ0JXNDF3S1lvamdtMHVCNnIzN2FFVGdCaFdFbmJnWGRrWHplY1p4?=
 =?utf-8?B?VG1HVlVhc0JPSitnelBSamRJcnhKcUNkMWluMHNSQWJHbS9MNFJYQ0kwd0ND?=
 =?utf-8?B?R2ZTblVYNzRuWDh1UGk5SDMyM2F5QWNiVUl5MWpRZURDQjdwZzlZQmw1UVB1?=
 =?utf-8?B?S2tEMjE2RDIxOHA2T1R6ekV2UWNMYnpZTG9YMnJmOVpSUXYxM1NBaHVHRElm?=
 =?utf-8?B?U0hoandrRVk1bG9qbSs1T0VPVlJKNmFza0N4dksyVm8zZXZ0NS81ekRPS3BM?=
 =?utf-8?B?WTdyeWFwVExpYzRpU2EwTjNLTTgrTCtiYnpwSHdLZG9Xa0lnUVNyUUlmMWlT?=
 =?utf-8?B?RWpnT1N3ejVJd2krQ3RRZkVuZVZGOC9UMXZTZms1WURJdjJUMndQYzR0dmQy?=
 =?utf-8?B?NndSdTNTcUk0a01jYS8vaTBUcm5mNEdMNExid3N1dTg4QUpveXQ5N1d5RitF?=
 =?utf-8?B?MWRYT1I3YkJtbjkzdmhQRzBETDRkOVJEeS9xR0hYbzgvd1ZxTmM0VVB3MXl0?=
 =?utf-8?B?Y3NSY25rSkZhYnI0akdZWjl3dWcydEJpVDYyK0x1eEgyNG82b1NJYTA4Wis1?=
 =?utf-8?B?dHRsVWliMDhkVkJobU4wSFpIeDd4L09TdzlVbG5Hc1VBVDJDbGF2VWVqcDAx?=
 =?utf-8?B?QllCSFlaaHF3VU9xakhzSEJ0NnBaejJWRE4rUnFLOUM1VFc0YjNiN0I5M3Qy?=
 =?utf-8?B?eFlZd1NQSVFpL09Da1R4YU50U0N0NEtWaW1YK0d1MUF0Q1BtRTkyQU8xbjZD?=
 =?utf-8?B?dkQyTVhLSGJJOUNUTW9Gc2NMVmMwUTB5U2pRbjlwRTh0dVkxZzdSdVlJbzRF?=
 =?utf-8?B?WjczNXFycW5MeUQrZlZzVDdYTnplb2pyRExkTSs1ZnFRaEh2SUZjZWM0U3o3?=
 =?utf-8?B?b1BsV0F0Y2J4aGJuT3lGUnhsSzFBSzRSaXVibFhkeGpsWVJlSWMxZFUxTGRh?=
 =?utf-8?B?WFA3UDhQUmp6OXBHZjFTYnA0N0x4TUpacUpZaHBUVlRUZ2VQbVpVSlZRU1Fa?=
 =?utf-8?B?dEZ0anFNTE9CT1EzdXBYWjNRWEZEeHk4RHc2bU1xcitLdkl4NHhoZkI5QVU0?=
 =?utf-8?B?TDRMNjZJM01jb1NCdTdkbnhzRFd0UTIvdW9TNSt0b2lJekZGNURCMU4wU0Vs?=
 =?utf-8?B?TXlOV0FYNUxnZ2x3c3Ixak5VSVJBZ1Q1a0xpajRyMTVwNEV5NkowZ3FpM0FB?=
 =?utf-8?B?VktoWWR6UTZOYks1dXd4RkkxbEY0SVhOM0txNWZHZERVUkczYmdYcm9vNndl?=
 =?utf-8?B?MkFEb05HN2FrQ0NRKzl0Qm1DMk9qYWw5QnRpM0FKN0JhOU5RMTJOQU9TUVls?=
 =?utf-8?B?UWN3OWxOZmNVQkxFUGtzV20wRitCZFZTK0crTXc4aUNWRm9oYkVvMzlNMmxa?=
 =?utf-8?B?UlpNZ0ZCa2I4WWhicHJuWStKTW90RS8yMUh6dWJXZDFSQTFJWUFMN3kyNnhB?=
 =?utf-8?B?RzVjSHFjZmRJRGhmY25PUnhyTisrd2N6YVY2cUpJNHU0NzFIL0ZFcFRxWUp4?=
 =?utf-8?Q?Ekr4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a89482-cc6f-429b-8e5a-08dcee59e87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:15:09.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaM8uYvU7MwQ3r/QYQRWzo4VLU4NkPEK22kq4tb49ndlB/I0Dw4Lhk3YQDDHHJOebzb81fGrLFjiPIQZE7FRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9388

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAxMC8xM10gbmV0OiBmZWM6IGZlY19lbmV0X3J4X3F1ZXVlKCk6
IHJlcGxhY2Ugb3Blbg0KPiBjb2RlZCBjYXN0IGJ5IHNrYl92bGFuX2V0aF9oZHIoKQ0KPiANCj4g
SW4gb3JkZXIgdG8gY2xlYW4gdXAgdGhlIFZMQU4gaGFuZGxpbmcsIHJlcGxhY2UgYW4gb3BlbiBj
b2RlZCBjYXN0DQo+IGZyb20gc2tiLT5kYXRhIHRvIHRoZSB2bGFuIGhlYWRlciB3aXRoIHNrYl92
bGFuX2V0aF9oZHIoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxt
a2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gaW5kZXgNCj4gZWIyNmU4NjljMDI2MjI1MTk0ZjRkZjY2ZGIxNDU0OTQ0
MDhiZmU4YS4uZmQ3YTc4ZWM1ZmE4YWMwZjdkMTQxNzc5DQo+IDkzOGE0NjkwNTk0ZGJlZjEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0x
ODE5LDggKzE4MTksNyBAQCBmZWNfZW5ldF9yeF9xdWV1ZShzdHJ1Y3QgbmV0X2RldmljZSAqbmRl
diwgdTE2DQo+IHF1ZXVlX2lkLCBpbnQgYnVkZ2V0KQ0KPiAgCQkgICAgZmVwLT5idWZkZXNjX2V4
ICYmDQo+ICAJCSAgICAoZWJkcC0+Y2JkX2VzYyAmIGNwdV90b19mZWMzMihCRF9FTkVUX1JYX1ZM
QU4pKSkgew0KPiAgCQkJLyogUHVzaCBhbmQgcmVtb3ZlIHRoZSB2bGFuIHRhZyAqLw0KPiAtCQkJ
c3RydWN0IHZsYW5faGRyICp2bGFuX2hlYWRlciA9DQo+IC0JCQkJCShzdHJ1Y3Qgdmxhbl9oZHIg
KikgKGRhdGEgKyBFVEhfSExFTik7DQo+ICsJCQlzdHJ1Y3Qgdmxhbl9ldGhoZHIgKnZsYW5faGVh
ZGVyID0gc2tiX3ZsYW5fZXRoX2hkcihza2IpOw0KPiAgCQkJdmxhbl90YWcgPSBudG9ocyh2bGFu
X2hlYWRlci0+aF92bGFuX1RDSSk7DQo+IA0KPiAgCQkJdmxhbl9wYWNrZXRfcmN2ZCA9IHRydWU7
DQo+IA0KPiAtLQ0KPiAyLjQ1LjINCj4gDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZh
bmdAbnhwLmNvbT4NCg0K

