Return-Path: <netdev+bounces-140723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC79B7B60
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6896F1F221E9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CD19DF4C;
	Thu, 31 Oct 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="F2RdWql0"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2127.outbound.protection.outlook.com [40.107.215.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C21991BE;
	Thu, 31 Oct 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380197; cv=fail; b=FNkhEHcp8R9QXFwLW/1sQAclpc4cA0JcwzDmjPXg6FNx+6mt0CZNaMCpv8hdysiCx4GS5hzo+6FCn/GQb8gHToV5xltWiAuEHy1QNvitHyH/9fEz8Ih4msoZDVlCbyxmgcnHNuG40I86vd4oHDyv++Bdx1mp93HsZmaq56/z7/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380197; c=relaxed/simple;
	bh=KQt0qyfnFczN9Nikee8eYixTLeSpTX0GHq4Ke9cQUmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnutY6qKJ2rEcbYhp+sb80jdnx7ypj+7SqztrnTmdDpnVu6ZQKOXtD7t/lrFYUE+xAmYC1p+Vaao8dEchZ+KU+QNqjzHj7HMyKEOH2gv5IMibQaQwoP633SJ9GXbrASTRTjSMUCD/0dTssHrQ9RUmUHTfqRj5uAHV3oKcnMQ7fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=F2RdWql0; arc=fail smtp.client-ip=40.107.215.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqSlOjpjffkiElb1Q+oecdnw/uoWdbFX5Y2BL88uqnm4uM2IDXNhyE/1F6SHU+C1/McnxLj8WbRiZj0SUYdS7kmvOz1Rn4y93ndVvgQyy6l5dnD42dZnf9cpZYF2mTP+5NESZx//8mOFwUoiEEC5HnSgYQBZsr71I0G2dBTw605v/6xZ6DuYEaki28FQ08r85lBnvL/jtY0Q1P7tdFg22GtGSDV/khB7IjKYDeWlOtDFt1CL9AsksYONfhs4/LNjZivf06FIHQRl9h2xDCls4+T+GFN6QIeFl0eedcwTzryVhdaqGwnjUSVpPgHw9CVUklXxhC/asILqqGI1Z7Gk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZYlpQTCTa8nV6TQLlq7S+sdt2aCdcEeGA6qU1KAn/o=;
 b=AtLB0lxzL9K1lVgGfglhsJ+hJWeAnYgTnkFWKZBCjvsEhCCFi0lWRhRDUAGRlRY+zFIDnYohzSP0DEghtfGd3QuHY2+cfInf67cuws5mkwttLUKy0DlRkYjklArm11MUCpqwp023wJqkooTtiAuPepooFkRFoM/xdg06nluses+tBaDX3UT1Cm+v1o1YARHFVNm6+uhRrBbd//Co/wCoBR2bdpWonUTuEptyLA9SssDXaMOaLmIcJ/hXFHyMJzUfA89osE5oeFW0VDlWf0nZgK2clEsctcDH4ysyAYTeOGRVJ3K+I+zt8xoRp1DP4f3hr1gxwzueqvrS0okb4sbl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZYlpQTCTa8nV6TQLlq7S+sdt2aCdcEeGA6qU1KAn/o=;
 b=F2RdWql09cEEgJULpD+0+05PHj7g4ZBhUe9zexEJczGoYKr6KrQk1Onr1qE4TcDJskI5Mklpd+MgPrirzv9ntBUlebUvHfCnsyhDAsS7+Uz/Y4MVEV+Ukvu2egMELU+aPCvTUXzn1C/3F8bfq0BWJfuanSRJiCjqJF3n7b9t8u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYZPR02MB6294.apcprd02.prod.outlook.com (2603:1096:400:287::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 13:09:47 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 13:09:47 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	helgaas@kernel.org,
	korneld@google.com,
	linasvepstas@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
Date: Thu, 31 Oct 2024 21:09:30 +0800
Message-Id: <20241031130930.5583-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e37b9baa-51e5-48f9-a15d-521f29ce5f9c@gmail.com>
References: <20241022084348.4571-1-jinjian.song@fibocom.com> <20241029034657.6937-1-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYZPR02MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd1cf01-6e63-4f22-3279-08dcf9ad4b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZyZmxlZGM5ZnhoMHVTTVNYcWpZME9GNU1kamRaK1FtTEFCSGJmY0VhMEVN?=
 =?utf-8?B?L0xESHlMS05BYys2aHRJUFpsa1dKYWtNaXJncFpMY1dwR283V3hYY1VRcnhV?=
 =?utf-8?B?eHo4Y1RSZGFxY3o5dmViVnRKaFd5YUl5OWIwQm5WQkUzWXF6ZENqaWR2NFI5?=
 =?utf-8?B?YUpVeDgrazZyU3ZFU2RvOVZyOHdMRDQxN0xzNGtOWUFDdFB3THZQVlZsajNB?=
 =?utf-8?B?eWx2YTdxRklxN3dUMUZ3WHhBWWdFeFZvcWFTRjBCdzNLeFV6UXNLeTBVMk1s?=
 =?utf-8?B?aWdYa0o1MHZ2cXRBZnp0Z2crdkpBZVEwMHZWb1BzcGhpVllvQUtiVStMMll4?=
 =?utf-8?B?WWM0eDErTFhHUkNzRnE5aUpnVzlnV0t0M0hVVW9iL3hDaGZDbFd5MW9CREx4?=
 =?utf-8?B?TngySWtUbVVzc3ozYlhzQWVtd24rYjJFYklkRVJzQUN1cFRFV082TUZQVzVT?=
 =?utf-8?B?K1RmZXd1YURhNWRqcUN5R1NySXdtR25XZUpMTHlYSXlOSXdOU3VMVDhlb0lO?=
 =?utf-8?B?Qm9PMXhCbHlmVWthdWRvZ1JiU3FHaVVjSGt1Y2hHREV3K3lPdWYraUpmRWlY?=
 =?utf-8?B?MmJ3cGVNbm9uMTNSemJGc0w2UG9Jb21lYldHd2FNRGIxZmxIQTBvTDZXVk1v?=
 =?utf-8?B?TkdsSDdveFk0SmxIZG5teURjdFRjRXNRNE9Ic1lIbjhlQkc2Z1VkUXRhWk9H?=
 =?utf-8?B?VW4yWXlvV21Qcjc2dzd0ZEtCbnJHK093QTloVXJ0c0FWSXZqZFJBbVEwMjlp?=
 =?utf-8?B?c3FvYk42RFNLMDJWZk81L3FkMVl3c3V5ZlYzbmFsSE9scjJTdnc1T284R2Qz?=
 =?utf-8?B?YkRSanJyd1drTlBuVFZYTjFpaG9tQVlpeDZzK3VLWnRCZUpCR2xUa1E1M1Bj?=
 =?utf-8?B?ZjRPOWV5eXBLMXNoakh0dTNYOXI0bVdQWURiWmNyc1plNDloRC80OWl1T3J6?=
 =?utf-8?B?cHZ3aTU0aEt3d2gxU2FvMFlVMHRBNncvTHhUaFlnd1J0TFAyMjlwSThlT1p3?=
 =?utf-8?B?QTNPcmlBc3E1TnZ2SHBReG1ncGRJMmRSdWovd004WW5wV2ZNTm9mOVBYNXMv?=
 =?utf-8?B?RUdVVWdQUmJGdnlCd3kyc1BGT29VdjBMdTNHdGcrZkZycC96cXRuUHZBWm9y?=
 =?utf-8?B?WDZDTFU4Um90dDZBL3l0OHBPQ0xtYlVXRnVzVldhOFlwZHVoZXFXSlQ1V0ln?=
 =?utf-8?B?OTRGL1d3VHA3d2xZQWZ0VzQyNThxVEpqUGExWjhTUlFuYjArZEdiMW44QW9L?=
 =?utf-8?B?RzdXZ3g3Z1FXK0tQN3FnSVRrZS9sWHI4aCtCVFFyb0QybkdaTWZMMm1FTUVw?=
 =?utf-8?B?dlltMDZueFQxTGRmWTdPZ1Bpa2s3WVFFVWtMT09BU3VuTEd0NFlITlY5c2Vw?=
 =?utf-8?B?WDBmZGxzNXpNUkc0Vks0aG1xM2UySVMwOVhydExQbkVCRlUwRjhXenp0TnpS?=
 =?utf-8?B?cFRXVkRQYzZia1gvNVlNR3BISGpmVmU5K2FjeVN1TGw4bUpRMGw2N2VoYytC?=
 =?utf-8?B?eW8yRGY2TDJOc3JqSDdnTi9Za09Va083ZFk0TzNYbTFWOGtVWnYvTWZSRGZ0?=
 =?utf-8?B?MHdwdVVCZ3daRlpVMVFsZElwaXV1N2JMbUk5ektOemg0VUZTUkprd05sVWZu?=
 =?utf-8?B?eEE1NUdxK0NxeHc2Y0x5K0txVk05YkhScFJKN2E1aGI3UE82L0dKM1kvTnU1?=
 =?utf-8?B?Q2ZrOEgrTUxVK0NFaVpNMURGeVp0MTEzd05uRDY0VC9RTnpEOEx0VE8wZFg4?=
 =?utf-8?B?d3grbHBhZ3ZHbVlIYnFVMjZBdVVITlY5dXZ6ZjNkQ1VaS0tZVHU2YklSUTkv?=
 =?utf-8?B?YUxsR21ySzFVWm1nNFFyUkFUV0RWZVIyZEpPWmM5VEtqMlBnYStFdnk3Z24x?=
 =?utf-8?Q?No8Z87wbMYmPb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJDZ0lhdDBvZHoyazZNcXp4L3FFRHM3RUU2RU80VllEUzVWT3RxbDE4L2xu?=
 =?utf-8?B?eE5kazI2TnpoQVU3RUd0L0F3T0VGZkMyUWw5MHpabkJWTi93cEFkc0tHQnZB?=
 =?utf-8?B?QXNlUDhrU3FKbHpVS1VJSGlBMm4xRWNhWTR5UFhXRDh1TW5SaG9UaisyTjBa?=
 =?utf-8?B?SllzOWlVQ0ZxVXhPKzhPeXlmeFpVczMvVTdZOFNjZjN3V0ZUejYvZWYxYURt?=
 =?utf-8?B?S2dRMkNqZkFqZWYvLzlseWhXTnpOdGlGdmZwUVQyL3hGRFphNWFvdkpjZ05F?=
 =?utf-8?B?YXovRG95dll6aDJFU3B1cGJ6Mi96UU1kdUwvL2MwMDJKNkQxQlpJWWtMeGNk?=
 =?utf-8?B?bnEvbjhjcWJ3b2tSaGt0VW8wSEdNU25SeDVsZWRTdmcwV0lGTnFLOFlVeUhN?=
 =?utf-8?B?dUIxNjRhYXEveWt6TU5Mb1JZY0lSUXZUU3c0bWZCZE5YWlp4VDQxM0RXZkJi?=
 =?utf-8?B?RkRsVCtPNXNPVVVIMmlKMmtBbG5oajdadDdQdk01YzlZYWNCODVWMGhleVBJ?=
 =?utf-8?B?UytmWmx2dTRsWVNFRDVSK1F3Q0dkeTdvQVJsb2pnWHM5WE1jNDVxSnorQ1hr?=
 =?utf-8?B?bDg5MlA3S0plUlBSdGJZS1VKdk1sN2g4TkdRM1oxNDBCR0hvaEwyRjF6bmJE?=
 =?utf-8?B?cUU5QTJKR3hnMlVieGdRN241QkU1R0VTcjByZzVJVi8zTURwbDJMTG01ank3?=
 =?utf-8?B?Z3p1U1dTU3VCZUFyT01VRVkyYlBudnl0WVpPWTNVZFlwVTFUTVRVWkV3RXRV?=
 =?utf-8?B?MW5FNGdhWFJOVE5vZS9seUxJVFQ3V0RaRnJOM2tNazRrUmZ6bEdJdGVvTFZ4?=
 =?utf-8?B?UUZVYm9CR01UdGJtZnpGcXVZSm1SSVhIQ0M2czQxdy8zbXZMQmxRSTkyayta?=
 =?utf-8?B?TDNiWnE2b21jcy9Fdzc4aG1md1VYTlhIbFlPVG80TjR1Y2RmU3BuTTlkcC9i?=
 =?utf-8?B?NzlIaWhKeEFxc2NiaHYzZDd0WXZ5NVE3d29GVFBEa0ZPbVoyUnNCUit2L2hM?=
 =?utf-8?B?aHNlTm9Dd0tqbjQvN25DRDI1TXVqRkoybHdmRUlubTdPeFhka0pXR2ZaL3Bo?=
 =?utf-8?B?Y0pIMXBEWHRXdjZpRjB3YU16TDZTc3FZWlJEMlN5aEJMWG9JV1ZEZFE2cnhn?=
 =?utf-8?B?MXJEajltOEV0SndJbWRnWHZHMU4wdjIxZEtnanVQcG4ra2JXRzhudjV0NTl2?=
 =?utf-8?B?eHlsUVdlSGFnK2VtMzRXNFUzTWswR2lpQnNaaDBzb3N3VE9oUGExNmZ5NHJC?=
 =?utf-8?B?RnBZS0ovaHhYYTYvNkpzZTQ1RFVGQXRiYTZ1L3pkaUR0WmoyN2ZSTlBZR1Bl?=
 =?utf-8?B?MXdsY1FTOGpET1NuR0JBcWdibkNzVENSRXRZUUNQUFk3NWwyb2tHanhqRlZB?=
 =?utf-8?B?Mm1iMWFwRHJqN0JYQ2VMOE02RU1JWEE3RmdudkVwUnBKN21zYjhUaldCa3Ni?=
 =?utf-8?B?dkcrMFpES1duSG1nQXpFdGtSamVqUjk4SmFFMFNmbVAyeDl5Y0FLRnF4UkhX?=
 =?utf-8?B?VmJZN0V4QmJsOFlTdzA5WERRTWR1a3dsVkpxakpwTWJTRkpDMlNxV21jWmNr?=
 =?utf-8?B?YlBQRy9UWmdSQWJaUThwVkdacDl4L0Z5Z3FPc0RxNGNXUE5NVzdrQk4xeUw1?=
 =?utf-8?B?eFA5QVhmYzdvQTNoMFRFeFZEMEUrTHdzc29zdGM1MnU2ZWlVL2czSmQ4VDRO?=
 =?utf-8?B?MmQzQmlPbEd2cGM3VXE2cFhMSVdPNFZkL2JiZ1pLWW9nVndHUnR4Z2s4bHFo?=
 =?utf-8?B?QXBnQjNnWXBpZkpndVRTMnBVVjZsbTJ4cWFFYThoWm1NUFd1QncxWFZLYXhL?=
 =?utf-8?B?QWZkZTNWWmlhZ2hqZXlHNEVTVmxWU3lnU1kvWmdRRXNRQmdQSlNYNzJManli?=
 =?utf-8?B?NWkzcE1KN1cxenhNanA2QS9ZK3E3TzJFVjRHTzllQUZlQ2NaSzBDelp4QVMy?=
 =?utf-8?B?dkRXRFM3T1ZWSkN4ZW9ZWkRyVW5tTXk1QkZ1dmJnWi9QSlROaEgwQWowaERN?=
 =?utf-8?B?L29yRkg4MEJSRUQ0RDlpbGYzWFN1aGlYTUZwWk41Z3VpenRQSWNoYmNQZXQy?=
 =?utf-8?B?NEg5d0lSTDdOeEk5RnM2ODdYdDBjTGI1M2FiSmdNOXZGeHQ3ZlFtK1BGR0Jm?=
 =?utf-8?B?aHZldnRHbmR5anlpL25XODRFR1c5K2I1d0JTQXZYQXI5UytsWVpiL0F6cTFH?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd1cf01-6e63-4f22-3279-08dcf9ad4b59
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:09:47.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLgpRfjTMmiueSuCkZxlajCnm0CKazX7dwtAK/mDMPTdfOzDFaomrM167hv94lpR/oM5MDSFHKXAOFhmzQ85h247HF7XuRXgAp9jcB86l3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6294

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

>Hi Jinjian,
>
>On 29.10.2024 05:46, Jinjian Song wrote:
>> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>> On 22.10.2024 11:43, Jinjian Song wrote:
>>>> If driver fails to set the device to suspend, it means that the
>>>> device is abnormal. In this case, reset the device to recover
>>>> when PCIe device is offline.
>>>
>>> Is it a reproducible or a speculative issue? Does the fix recover 
>>> modem from a problematic state?
>>>
>>> Anyway we need someone more familiar with this hardware (Intel or 
>>> MediaTek engineer) to Ack the change to make sure we are not going to 
>>> put a system in a more complicated state.
>> 
>> Hi Sergey,
>> 
>> This is a very difficult issue to replicate onece occured and fixed.
>> 
>> The issue occured when driver and device lost the connection. I have
>> encountered this problem twice so far:
>> 1. During suspend/resume stress test, there was a probabilistic D3L2
>> time sequence issue with the BIOS, result in PCIe link down, driver
>> read and write the register of device invalid, so suspend failed.
>> This issue was eventually fixed in the BIOS and I was able to restore
>> it through the reset module after reproducing the problem.
>> 
>> 2. During idle test, the modem probabilistic hang up, result in PCIe
>> link down, driver read and write the register of device invalid, so
>> suspend failed. This issue was eventually fiex in device modem firmware
>> by adjust a certain power supply voltage, and reset modem as a workround
>> to restore when the MBIM port command timeout in userspace applycations.
>> 
>> Hardware reset modem to recover was discussed with MTK, and they said
>> that if we don't want to keep the on-site problem location in case of
>> suspend failure, we can use the recover solution.
>> Both the ocurred issues result in the PCIe link issue, driver can't read 
>> and writer the register of WWAN device, so I want to add this path
>> to restore, hardware reset modem can recover modem, but using the 
>> pci_channle_offline() as the judgment is my inference.
>
>Thank you for the clarification. Let me summarize what I've understood 
>from the explanation:
>a) there were hardware (firmware) issues,
>b) issues already were solved,
>c) issues were not directly related to the device suspension procedure,
>d) you want to implement a backup plan to make the modem support robust.
>
>If got it right, then I would like to recommend to implement a generic 
>error handling solution for the PCIe interface. You can check this 
>document: Documentation/PCI/pci-error-recovery.rst
Hi Sergey,

Yes, got it right.
I want to identify the scenario and then recover by reset device,
otherwise suspend failure will aways prevent the system from suspending
if it occurs.

>Suddenly, I am not an expert in the PCIe link recovery procedure, so 
>I've CCed this message to PCI subsystem maintainers. I hope they can 
>suggest a conceptually correct way to handle these cases.

Thanks.

>>>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>>>> ---
>>>> V2:
>>>>   * Add judgment, reset when device is offline
>>>> ---
>>>>   drivers/net/wwan/t7xx/t7xx_pci.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/ 
>>>> t7xx/t7xx_pci.c
>>>> index e556e5bd49ab..4f89a353588b 100644
>>>> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
>>>> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>>>> @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct pci_dev 
>>>> *pdev)
>>>>       iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + 
>>>> ENABLE_ASPM_LOWPWR);
>>>>       atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
>>>>       t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
>>>> +    if (pci_channel_offline(pdev)) {
>>>> +        dev_err(&pdev->dev, "Device offline, reset to recover\n");
>>>> +        t7xx_reset_device(t7xx_dev, PLDR);
>>>> +    }
>>>>       return ret;
>>>>   }
>
>--
>Sergey
>

Best Regards,
Jinjian

