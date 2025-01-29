Return-Path: <netdev+bounces-161488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDEA21D53
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF783A681C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D95C96;
	Wed, 29 Jan 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rn4qk0qu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375157F9
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155048; cv=fail; b=uUA15INNwNOKONuDJBk531S7Paa34MVwnugvBL8eT2sUcGmYHAsm/Am/ZE2/P5ISD6qajdFXOcMk2I5UAC8ugAv124zl+0u1rV43l6wTGl535U/ambtzAQaE4+4MyCZ6D0Jq7SyMwYMeXZXbxZYPnyGEYjQcAIYjcXxuy5c9tgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155048; c=relaxed/simple;
	bh=E+fmFgF8iqL6EFHwl/SYk34k4hfBgGB1IX7eUQVkiac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlBjaGi5liQ3/oeJ1Y4fEv5cb04WeqjgcDGj+4QNS34YF8TTC63lOoTapMgIqR7AdTrNB4AwqFYCV2jNFvkprbxz4q4fnJuG6XPIzZI+1T74MHuYtP6WYkU5oEkvX16MXFxVSxoC6zXo7DokjhmFPHOoszMMtXGSBXolaOIwx2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rn4qk0qu; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx1ZO0tmIykXIOqkxdlqCw8H/rOtGVRDlMNikvDLey7dSw3HJtOgmBz1hO2wS2PnDf3nYKyWhc1hcFL9HwpZgKzLxFk+QJHX+jIWRefeuwavtByUqZ3f+nVigRlUi6pP5xU1R/fGF7xZsifeYbjVgU4BMtRzjbDjlULVm4OAeeqZFnKJl0K1FZOaK4klAGE4ui1Nbi3FmSCTYO86L/QFrh80xqf+cesHW3XKIA2CVJ5wCgR2S7pfoxw47kyO5HHokMezgNWKPQKFAZnyPn1P2L8ES7cvFohJXdqYluktKOh/duW4bIOrD7CoO7q66AofOs//r+ABdm84j/ugHOH36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+fmFgF8iqL6EFHwl/SYk34k4hfBgGB1IX7eUQVkiac=;
 b=B0KAuANfQX5eVg2kE5HrPFQmJuyZUuz0PnX2NaZMBUNgfNGBFnVE2W4wMGO1vMZ9dSDBNZ3ubyjNA3pxmbsKrLkBTomxlojexRKEmakM8llNRFpRdSy/GROOpGA4zC3q+oMjNWPQ3LtdgqOJRrLC/91SijxA2RWHGwW9Z+ZvYo8vxaueu+Ynmp9/TeZh/N4ckyiR+bjgMhJYx4bCI4vcEwZ3TDt+8Syzw9HoBPlkCioacN0bJiTrt5qmldqy/m0hv+r/9jNfIULSEKVsecrzA2lpYRaiHOkVJHCBZaIU/DzJFMuv1LtAReJCDvkIQDRou6ox8fA10+Yfd0Gltvt4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+fmFgF8iqL6EFHwl/SYk34k4hfBgGB1IX7eUQVkiac=;
 b=Rn4qk0qu348xwtwkAUswbUda+Z+L9FSSocQdK6tx7X9SWnhtNO0+uffhrMMGr3gwELfPK300zMNBAOjMkTq2GyDkYHlDrlMpfMUFTH7BtAOjs06aYzM48kASnKj5eVXtkHCu1qM/opz6VsayuHRyhcqBymGSOKkBk8ffvG8wq9unPn/RtL4UA4Vyd+YdghmI6IHZhyG4/cQALOiyH8PElOFHQ+7UmofXb+xOeAGdF8mUyk6OE4tsnLdKgvznZt1vXf17z+WSEteFSMToM+E792LyX3G4J8naOZ7vln1dcaFPp5IlmPrZC/qv5Li2RwGF6fl9YNcJHCHz3xlMOKcJyw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 12:50:44 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 12:50:43 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbb+l5fdqqldfRAUu+2iXPDyW3KrMrEMQAgAEdyvCAAJVigIAA9QUQ
Date: Wed, 29 Jan 2025 12:50:43 +0000
Message-ID:
 <DM6PR12MB451695D1B428D0DD183B0036D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-10-danieller@nvidia.com>
	<20250127121606.0c9ace12@kernel.org>
	<DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128141339.40ba2ae2@kernel.org>
In-Reply-To: <20250128141339.40ba2ae2@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DM4PR12MB5937:EE_
x-ms-office365-filtering-correlation-id: 26e57675-d9c1-418a-c359-08dd40638b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlJLNjZJZ1RyWG5yMjdLRlJvYSs3Z0k5MjROcnVjdzkrbTJDQXRMdFYwMGlZ?=
 =?utf-8?B?QXlmcEtaNjRXdXZJY1g2K0x5Q0tKaFJVL0xRUnpON3NGajF1WGRzNzJydmda?=
 =?utf-8?B?Y2JGRndlN1V2dXJONkp1WktYNXdlWnVNSEg5UDVCK0VLVHBmeVVpUHcxaTdk?=
 =?utf-8?B?WW9SSnhLQkZ1UXB4c1VuU1hBMmRJRVM0Z0l3eWpqYnVVSTdXNDB5UVNyOEdz?=
 =?utf-8?B?b0ppUTRIOFFJbzhsT2xwS2N4SnpZdnNsakhrVGVyV1pHTUZLcnNjbGRXOWxF?=
 =?utf-8?B?ck9MQUQ5a0dzdVRtQlJaVTlKZDdlT1BDaDV5M0w0RjRNeTlxOEh1Ynp2QkMx?=
 =?utf-8?B?a3dVV29MOVZ1RkdVZTdUbm9YSU9uT1l3SUlmT3lONmdSZjJMZnBsa3YzSUtN?=
 =?utf-8?B?eE1FK1RwWDRNYmtpbEVWYUdyZ21HaVh2RWhxQVRPVVFyc3dmSGpaaXRZQ0pV?=
 =?utf-8?B?RGhKZXZOeFA4dVB6YTZNZmh6WG1UQktWcmNtVGFvOEtETlZ1TkdBbUtGZDR5?=
 =?utf-8?B?UnlYUjQzM0p6TlNoeXVkWGI2d2wrTTY5dTJ1NldINGtqUWF6Mys3K3VUREty?=
 =?utf-8?B?WEk0VkFpMmpGTXNhUzNjOVAzMVkwNnRZaDZ6bDVpYXBqVkhJRlg2Z0pIK05D?=
 =?utf-8?B?WUZ1YWhTYnJKVEhhNmhPa2dxMnY4NUk5bU5lcGhVS1JkcWFxUkMyaDBlU3RB?=
 =?utf-8?B?MXB5OFJRbzZNcVhqUWFoRXhQY0xGOGhEQnZkN2kvcklBeVBNd1ZVUEE3Rk9U?=
 =?utf-8?B?eDFiVjFTRHg5aHJZejVIc1d2N28vaHNhOWNUUndmN1VYYUlXbUpYZmVRVUN0?=
 =?utf-8?B?S1NVZkd0RVJrUkRUYndIR3BQMEJvM1ZvQXVCakF1YkowclBOZXBjQ0NyTVNw?=
 =?utf-8?B?Q3BWd1k5aDBFYzdJTG42aUwwZzgwUXhmeEtkNitTRUVhNmx6U3d5SHlKakow?=
 =?utf-8?B?K2VrQTdQVzh3di9KZ3R0YWFPTDhua1ZRQjJ1TzAwcG9xZ0lYU0M4R1l3Vzd4?=
 =?utf-8?B?OE5HQWV4QXpLLzczdExnOXQ3dGh4ekd4eEl3UGZUb09SU2VYRU5BSGk2MTRx?=
 =?utf-8?B?Tmd1SXI1VWFuVEJrYzFtc25TcUtqa2VVZi9iZ3VDZDBwaGliMTNsNnN1dkVI?=
 =?utf-8?B?ZHE4empqR2NRRnJzKytldmRKL2RTeHFidEJJVkJmYUI5L0xraXNhSTdRNVRT?=
 =?utf-8?B?Y0ZCRzVlMml6T3B1dTB6MjNHTktZd0FpK1NqMXFWeHRFd1owazJvOXhDZjNo?=
 =?utf-8?B?MHNTekI5UlVFWGtiMVFRWUhDcDVMSk9rVWt6TGl1SFJtakcrbW5lakI5Z0t3?=
 =?utf-8?B?VmNoUzY2RkwrcDN2cS80YlZVYng5RFc4Z05kMzVzb1pEODgwQ3JtMzRQWTgz?=
 =?utf-8?B?dzZZZTZGUW5UV1BZZkhnL0VOcS9tTDZKbmJHVHVSM1ZTTllnWStWdWFUTnJY?=
 =?utf-8?B?dHhWN20wY3dJZ2g4M2lFTlBuSzViZ2M5OWFCSjdoSWlSRnJEcHlFZFVaY2xU?=
 =?utf-8?B?ejNLdmZUODAzKy84b1JMaVRtQXgwSDh6eWx3bnNWUVVaY3J4aGxna2l5Q3I1?=
 =?utf-8?B?ZmthRGZ0eE11dllxU1Y3OFQrTGNOcSt4ZzVQQXlDeFpuaGdsdUVCM0N5TUdy?=
 =?utf-8?B?TDZaRmFiWFFQUW1QMUZRb20xY0xqTWRlSmlEaVo1TjZWT3Ivd2tGNVcwcEY2?=
 =?utf-8?B?UExUaE5Nei9wYUN0enpaL3hnL1NUR1l5RXM0Nk9MNlM3UnB0NVFLNk5KTVRL?=
 =?utf-8?B?cWdtRTBqVVhUVUdSZG53d3JmZW1XMVByMHdlODlNUEsvS1lzRk9jSUlnTGlv?=
 =?utf-8?B?VjFHaTBkMi9NK2VJS0puV1lhbHk4YVhwYW5DMGR0Rzllb0VFT1dqV2dVMExT?=
 =?utf-8?B?U2N4ZXIyTmhLSUl1UEdYQjVTYi9PclBpTk05WHpLcHk1SmkxTWMyMXlxUGVZ?=
 =?utf-8?Q?gsOJKRit+7CXF/fKMhy7r1CpYcdS/CQY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTV3dnRucjF5RWNEMnRuazVoNUphUW9JUWxHV1pDMm9WUyt1cC8rSk9Za3JL?=
 =?utf-8?B?U2w3WDF0RnNsejU4MFpwUURsR1VEZzRkWVJmZ1loSTBuajh3ZkNjeVZNZzhB?=
 =?utf-8?B?QXNtUTJ6MnhGYWFOQlVGTDNlNHB5bmVkdjZBdzVhMWJIei9TeTh1enhiVFQx?=
 =?utf-8?B?VUxaTHpzSDNKaFpNcUpNSW96d2svbUUvQzVieStyeDVVakw1SU5SVjZ3bEpa?=
 =?utf-8?B?S0JEZlZIQ2xYekUwdVhWdGhQMUJTZHBObkxWWmJEc0UzcXdDZk9hNmsyR2NR?=
 =?utf-8?B?NG9XU2pJMXJQbUJvcVFBODZBR2JxWjJNRzlrWVFWMlJvMHh6SU1QUW5TVGFq?=
 =?utf-8?B?RTBlUDdUOHAwQjc1ays5a3NWZjV6eFV5OHpDNmt5dlNlaENIOGc5M1oxT0VD?=
 =?utf-8?B?ZHpQRlpzb3RYRnpHQ3p6ZUE0TEtYU0o4TWNzaEdZU0dubEVyNEFydS9WZXZM?=
 =?utf-8?B?T2tqNXJHMCtxV1ZzRmNOWjUyTHpha2czdjM3NDU5cGI1d2RPSjFLNThSekRm?=
 =?utf-8?B?SUxFMnFBazE3dGVqclNCbWpYTlNucm14cFk3NlduZUt0aysrRU5CT1NISHVo?=
 =?utf-8?B?bUc3T0FmQ0JPZVpvTXFKVTE5MUxjQmRtelNqTWkzMUhIWTVLN2VNTEwrN1Nm?=
 =?utf-8?B?Y2I5Nnk2dmJ2SVRWMmNva2hMczlxUjJVaWozNys1QVF3SVR2ZEVBck44YnZG?=
 =?utf-8?B?NHp3ZFVEU1ZDVGtmS0EzZHNUSE41UUxRSURQMEg1RG9WcjhBQ25uNVVPN0RT?=
 =?utf-8?B?UW9kOS9xQkNqQkMxclo5QnZJL0N3UVh4Z2xTTjlKT2VIZGtIcWNiWGVXV3dS?=
 =?utf-8?B?eHFxS0dtcW5rd1JaYjUwZnJYd0NPRndmSWY3RUVYenlnTGdHY1A3N3c4dzFM?=
 =?utf-8?B?Nk9xb1VUQ1YrUnNRRlRXMzY1V2NGVjNtdlBBV2NaY3hGUW1xdmVwR0tIY1ZP?=
 =?utf-8?B?bHN6MTlBaDRLcDdTYzVaQTVBQmNHcjNYSEYwM2p6ZGFJTnltYkRtS29FUngr?=
 =?utf-8?B?NkR6SG1DellMSFBtdG9hUmdoRFdZTVBHdGU0SFltRnVOWFVwSjZ6Q0NvT3Fa?=
 =?utf-8?B?VTB0dm5HU0o0MUVONmxURURuemlCd29YdlNqdHFzOUZUd3hBcGNQR0tzMEFF?=
 =?utf-8?B?VnpXYmpqZXVIajF3eDYyS2VlU3A3eGdzQy9CZkdHYWttWnBPNVRoNHYvU1Z5?=
 =?utf-8?B?OW4yZVNod2tvYi84elZ1YmlaMVRXMjg0WkdVNldYQWM1eUNQSjZrRXdlZ2o4?=
 =?utf-8?B?QTI2T1o0U2VzWGFmdloxd2t1eDRLNURXSEpIKzRydGwrWmpnSGs2R1l3bE0w?=
 =?utf-8?B?a0NSN2ZaUWFDZlI4OEtKbzU5ZTJ0SVVOLzE1ZHJqSWxJTHpFZi9yNGhUekFY?=
 =?utf-8?B?bkw5Zzhqc2FOVGRmNVpibzlmNmVOVEYrK3dFcmhGWGcrRE5kcHFqL0R6K2JI?=
 =?utf-8?B?eDZucTZkVFRPME52SEVsTURoN0lGOVltc0RBdFVGOEVNRDUwajIwTzMzSW1p?=
 =?utf-8?B?TC9DWjdWZVlGMTFkQncxMzlGd1YwQytCWW4zVXV6SjlpZXRrbDQ3NUFTZ2xX?=
 =?utf-8?B?UEkzZDQyT1B6UFFxaG9JUHFMQjAzZkhkdWtjZlpjeVFwSDJURGlGbGRETHVl?=
 =?utf-8?B?ZUtROWJhVXkwdWJUZjlGUk1qcFUvM2w5bVNRbEhNQy9DU3BkNE51MG5nYXJL?=
 =?utf-8?B?bkFLMDViNWVTRUNTb1Bnd3ZNYkNtYnBaMU1VZkRGNSsyQXorUk5veE9FbVZ0?=
 =?utf-8?B?TlhTaUIyeWQ1UXNyRENYOVl1Y01XVnVEM0xpN2RCdzkrK0x6MHpsVlpzN081?=
 =?utf-8?B?cnJDbjU5eUszcEdaOFZaS29GYUFMayttclVRTUppSmtRNmhDY2NGNlNyd2sw?=
 =?utf-8?B?L2Y1YlFZSW84V1ZnOHhjUldydXNuYk1TTFhwZTQ5MGV0N2h1YnhwSGlxdkpx?=
 =?utf-8?B?ZTFkNFdWWlZVUnJENXRiWEhjT0YwRWFPd2wrS2N4dXk1aEtORkFySGdPQ3Rz?=
 =?utf-8?B?aFArNkxmMFF5MSs0a3VEU05QWjhDVHlsL3BDbmNRZDdtQmJxaTV2WUJHbzlu?=
 =?utf-8?B?bm00TVZvNDAvVlg1TUl1TkZUNVNzeTNwKzlTelY4Rnhhb0tBNzZyUG5ZNWNk?=
 =?utf-8?Q?5YKl+qypruVwin/kLp9o6dKuC?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e57675-d9c1-418a-c359-08dd40638b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 12:50:43.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHVBkmfGblahRKdG5bfBek+pljV0V8O5LB+8u47nBDwIxDQaofRn4TTF0IKC0GOq49udUtl488vkaeIpGEnIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCAyOSBKYW51YXJ5IDIwMjUgMDox
NA0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2UuY3o7IG1hdHRAdHJhdmVyc2UuY29t
LmF1Ow0KPiBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0IENvaGVuIDxhbWNvaGVuQG52aWRp
YS5jb20+OyBOQlUtbWx4c3cNCj4gPE5CVS1tbHhzd0BleGNoYW5nZS5udmlkaWEuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIGV0aHRvb2wtbmV4dCAwOS8xNF0gcXNmcDogQWRkIEpTT04gb3V0
cHV0IGhhbmRsaW5nIHRvIC0tDQo+IG1vZHVsZS1pbmZvIGluIFNGRjg2MzYgbW9kdWxlcw0KPiAN
Cj4gT24gVHVlLCAyOCBKYW4gMjAyNSAxMzoyMzo0MiArMDAwMCBEYW5pZWxsZSBSYXRzb24gd3Jv
dGU6DQo+ID4gPiBPbiBTdW4sIDI2IEphbiAyMDI1IDEzOjU2OjMwICswMjAwIERhbmllbGxlIFJh
dHNvbiB3cm90ZToNCj4gPiA+ID4gKwkJb3Blbl9qc29uX29iamVjdCgiZXh0ZW5kZWRfaWRlbnRp
ZmllciIpOw0KPiA+ID4gPiArCQlwcmludF9pbnQoUFJJTlRfSlNPTiwgInZhbHVlIiwgIjB4JTAy
eCIsDQo+ID4gPiA+ICsJCQkgIG1hcC0+cGFnZV8wMGhbU0ZGODYzNl9FWFRfSURfT0ZGU0VUXSk7
DQo+ID4gPg0KPiA+ID4gSG0sIHdoeSBoZXggaGVyZT8NCj4gPiA+IFByaW9yaXR5IGZvciBKU09O
IG91dHB1dCBpcyB0byBtYWtlIGl0IGVhc3kgdG8gaGFuZGxlIGluIGNvZGUsDQo+ID4gPiByYXRo
ZXIgdGhhbiBlYXN5IHRvIHJlYWQuIEhleCBzdHJpbmdzIG5lZWQgZXh0cmEgbWFudWFsIGRlY29k
aW5nLCBubz8NCj4gPg0KPiA+IEkga2VwdCB0aGUgc2FtZSBjb252ZW50aW9uIGFzIGluIHRoZSBy
ZWd1bGFyIG91dHB1dC4NCj4gPiBBbmQgYXMgYWdyZWVkIGluIERhbmllbCdzIGRlc2lnbiB0aG9z
ZSBoZXggZmllbGRzIHJlbWFpbiBoZXggZmllbGRzDQo+ID4gYW5kIGFyZSBmb2xsb3dlZCBieSBh
IGRlc2NyaXB0aW9uIGZpZWxkLg0KPiA+DQo+ID4gRG8geW91IHRoaW5rIG90aGVyd2lzZT8NCj4g
DQo+IEkgaGF2ZSBhIHdlYWsgcHJlZmVyZW5jZSB0byBuZXZlciB1c2UgaGV4IHN0cmluZ3MuDQo+
IEkgaGF2ZSByZWdyZXR0ZWQgdXNpbmcgaGV4IHN0cmluZ3MgaW4gSlNPTiBtdWx0aXBsZSB0aW1l
cyBidXQgaGF2ZW4ndCByZWdyZXR0ZWQNCj4gdXNpbmcgcGxhaW4gaW50ZWdlcnMsIHlldC4NCg0K
T2suDQo=

