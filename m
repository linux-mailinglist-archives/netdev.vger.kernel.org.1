Return-Path: <netdev+bounces-150927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2E9EC1E4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5227281A4D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB171AAA00;
	Wed, 11 Dec 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8VN1876"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281319D897;
	Wed, 11 Dec 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882538; cv=fail; b=BGmIhOR2VM9xp8eoCDb7vfJss4J4BHTi+pt8BeYSR0Qc/oIPCSmoTQB/HOLA06baCdwkxfH/35HYlu6LKvt1vEXDY8xMm0q2w8+0HMRUaoIqXT0AZE2HGIWWVX/yLot95T3ZZxYt+YJDuZCmz5kyeVXFdKmAWvGntsdz4mVENIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882538; c=relaxed/simple;
	bh=XQbVHh1FWMHbArY6B0l20zq5R5ZgaVqxTSA4h4DTq6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDnWscTD9M7/8awfp9Fvy9XcMW+bFbqau8fpwV6xl22DmIZn+WOcDREPY8NrR0GYF+NhN06HqxgkT6SbNn7NaNdGtLUCh+pif3z2EUMs++rMfYFOHFQieMrOwDd2bBzA8asiChchX9bndJGWgHobyBCBSqcYu7bzzDkfu3+5C1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T8VN1876; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p71u1gtrFoqkJZqG+Vt/aBexdEZe0DkQwpOIUlpUOa3wzXs5gp2Xf60+HE92lTra+Lxl5gxhGJJy149Cr6cFlFzwiJx0Mtbk5Et/gx4HwyEjdXDz/lWCfFGGlPV8cylo4MKhNsPp7w5B9JMLhbiaQDinuq02oGcDPBi4S9630weDwZFPFYXmFX4x+Sx8LX7bIqSh6M77dqY0D2Esq8hxh1mgALM8r3MymvZnZewgPmRv4wNc/msRToZ0pJDCmnKiU7j3Udm90dKHznGSfMOf9pF1bXq+ZoXucKX0ARDs8S29N8Btyshdxnp5CNTY6cGQK8C3D2q5Smns44FDqtqHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQbVHh1FWMHbArY6B0l20zq5R5ZgaVqxTSA4h4DTq6M=;
 b=mXAcsSfJp1IFBJsTMPtMums3M+FtqSZTiti7TW/+QMPmle5/XVDZ1KBjWb/olW4lDV/SH8Dure7n1AM5ILLaSJS/qS7kDxTirwUl613uABreoDrC1nJPegPEcdhgDoSZhiJFQbXbsvl4rUnAzVUPkgQgMDuyox2QEnLpmyCfO+ksiyzCtMQlPkAHXnUaQoweu+1E/fVp5YHutidsXxmpUQ1xWYDLvPDiiQuJOlwnvfICO82ApIAMCL6v4Ql1LeucThZrD7ngAEukVozTrodck6iUqm1Ee5HABczEbZO98Zu+tGcwG1IQWxROFe+Y+QN691DMuJlvmEXFZe7z8+0HKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQbVHh1FWMHbArY6B0l20zq5R5ZgaVqxTSA4h4DTq6M=;
 b=T8VN1876mQYPO0cB56U/A8pljr2jipmcwbMJicId5KnP7zci0qHevtD7+RA+9VmUPxFEnkoyGtRBt46zCL8KR+ftfSmktSLk98E2gJOYDJIAzs4i90/ejDBqST68n/F6cXhB5AVNbyuwgEqU61SHTPnBNFOMholDgNkHIWg4D+HBN/xWqhFWORbAyxdIPyRHX6KXNlRDHFHdzTKyI4WJA7bykzQD0dUtQsh5pDh1xBVJWc/NKkdT+v/Y+HgP9tXcLr3E1Ow8+ytHLXbiZ+/OLQAqf1TLTQ0aTJnthXkd0yhq7mjV5z6loRgarCANjOeY35F3ON0jFVsiGiMQ82m8HA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 02:02:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 02:02:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "fank.li@nxp.com"
	<fank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Topic: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Index:
 AQHbR39SNqGVTmwHjEW5jLsNZX4FgrLew5eAgAAGOPCAAXJ9AIAAD69wgAAFpQCAAACz8A==
Date: Wed, 11 Dec 2024 02:02:12 +0000
Message-ID:
 <PAXPR04MB8510AFDFB179F51A33825ED8883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
	<20241209181451.56790483@kernel.org>
	<PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<20241210164308.6af97d00@kernel.org>
	<PAXPR04MB8510008EBDA6EB1CF89246F8883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241210175928.39505f6c@kernel.org>
In-Reply-To: <20241210175928.39505f6c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: f9391603-942b-4f9c-33c5-08dd1987d3ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SFhRbEkzOFZ3SWgwaFJad3hnVThtWFhMb21SbFNYWGlvdlR3aFRhbVZHZlZU?=
 =?gb2312?B?TEE2aEFEaEZIMDArMm0wbE9POFNOZnZlY2ZIUmoxN0hGQ3V4S01TTmlzU0hJ?=
 =?gb2312?B?aFlUSUg2c0p4eVFETEVrZk1NZmtobFkwYldvOHdhUzhOUGJRZFExMWREVlNR?=
 =?gb2312?B?bk1XVVEwN09nRUQ2VXVVOVRzRXMreURzd01vcDFCeUxXZUNNVTBuYU9hdm5J?=
 =?gb2312?B?cTRTeEdDYmFHUzBYeWZhTHNrUklwWFFWdTR0STJwaHplMFh2WXo1eFBZbGZk?=
 =?gb2312?B?UFdEK0FGaUhIbGQ3R2N2T0QwYU5RQTk0bnIwUkdHS0pGYWhJOXJRZ1F3dzdB?=
 =?gb2312?B?THFiVDBhYiszdTRDb2xtYnFtRnFLdmpkRTVXV2IzalFrR1hNZmUxUkdDc0Fs?=
 =?gb2312?B?R3VyRkFvbk56SnE2TmR6UTM4SzdTRkNtN0NqTkkzZy9FaVpuVGVHVnN0bVRm?=
 =?gb2312?B?eTQvbmwzYTA3amhmQXl4c05IeFZKd0xYb002bDdtN3VyYVVKSG5Ja3JZSDFB?=
 =?gb2312?B?dmJ2d2lOWlQ1dTA3dm1USGloQWxxUGUrT2p0MkpHb055NG9OMXJBMTVPOEh6?=
 =?gb2312?B?SWNlVm1BbHJHNTJXSXBvSkFwSXlyMDZ2STdGSWNya2htZ0liV0QxN0U4Y3JR?=
 =?gb2312?B?Ny9xcUZYQ1praUlFczdxTTdpNk5YaDQ0a2Z4MnhKNEtETTFNQ3diVUFMNXlQ?=
 =?gb2312?B?LzMyekZJMjFmQWIwUllJaDBDT2ZUV090eTlhM3ZWempCSFFsNE5ncUdQQ1NX?=
 =?gb2312?B?MWFTZFYvSmd4VWp1T0tYbEYyTDZOc1RKc0VXRGJ1b0lBMlhhYzYxSFYxNTc5?=
 =?gb2312?B?UVNrWnUzQTJpMkxydENMRndzU3hPOEZKM3BEWjNjNzVGU2hiVFdmUmEydmVQ?=
 =?gb2312?B?dUczK0VEZXVGL1N0WVkwZlpSOC9IM09tbzBDWjRMWmdWT3kyM0tDM21lQVdB?=
 =?gb2312?B?cVlGdE5rYXB6UUpVV1EvTXd1d2Y1R0UzSHRFK3FmdlNxSHg5M2MvTGpZelow?=
 =?gb2312?B?VjI1WU1xdENmN3k3a2tUb3YvSnI1MFdYQ0pRc0dYejJKcHVFV3pwU2JEWlho?=
 =?gb2312?B?ZldodzJpdGs4ejY3dTlrRlV0bUVuSUFOZXZrbk1vekpUZ01BTzBLTXNEOFI5?=
 =?gb2312?B?WCtkV2NySnRVY1c5ejRocXRMOGFoUkQxclZMQ1hWbDVLbFdFOXdpUzNDVXJG?=
 =?gb2312?B?VXlmSWloaGQ0eERsMEN5QXMraS9PWk44aUdlSHhnMHNyMEl1cHRpWVBLdkNI?=
 =?gb2312?B?U09JYlJDcEo3bnJjQ0JRZVRla001Q3YrMks1OExmTE9oQzcvSWxNYzFldVZG?=
 =?gb2312?B?NjQ4RnlrZmh1ZjFBRTdTTzZudUN5SGVXSXdkNnlPZE9pU2hCSnFiTjFyQ3I5?=
 =?gb2312?B?REcwMGVFL3FTc21xYVhTWU4weElsTTJTRFhuelkrb2VwZlpaOUxtakxXYzJa?=
 =?gb2312?B?aStFVEo3KzRheGkxd3BCcFJSYzdrQm5RaitaZUZNOHZhTG9rWm9JNXN5L1Br?=
 =?gb2312?B?SUl0Ujk3YTFUb3ZlVDVCdUtqcXJSZWNnRXdwYVltYW83amJzUGxBclU3UVhV?=
 =?gb2312?B?NCtPcS9uV2RuUWtlTHBNTCs0OVEwWWVaNXJvM3p4Tkg2dG1pQk9PM0Z3VU82?=
 =?gb2312?B?WStjdG1pc1J5UTZkM0FlMjBGVGlMek9nUnRIbHk3VTgweXdIdkxoV1IyRVY3?=
 =?gb2312?B?Wnd1aUlLeVkwdmcwYm1XeFRUaGU1TFdNZ0t3VzhFdnZFUFBSK01FNnR3bUZ5?=
 =?gb2312?B?cW51RGJ0Y2x6dkRFK0RFSUVOdzlpZituUGNJbkN3bkFJYUFXMlJBZExHbmtM?=
 =?gb2312?B?SGQvZEI1MDBrQmxiOFVITVhlaXNDTnRvYzlCRUdpVThENUlkZGpZcjFQQ2lL?=
 =?gb2312?B?N3B6TXIrSjdqZDQ5MndRQ2hsRk1ZWm4zdzg0TnR5RmdNSnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eDZidEp5QjNKOE41ejBqd0d2ZVFyV01ScFUxbWhSb0hJZ21oWTlNMEZ0cFdV?=
 =?gb2312?B?djRtRFcrM0JpQi96WDBnOVhHL1YrU3BFOGtRc09yUjNFQnlEcGRjRk5Zd09L?=
 =?gb2312?B?dE50ZlE2S29peWV3Qy96b1V5V29tK2hMRWdpUUE5L3VDdEQrc1dXY0ZTb0sz?=
 =?gb2312?B?YVVmV2xQV2dtdG1OOGF0WEJleVAydjkwZFpUbXB1UTZQVWcxTm53QURxRWZY?=
 =?gb2312?B?QWI2WCtuOTg5QVk3SnRNZTRCN2hWTmhJQ0pRTjhVbWxVWUk0bVFyTDBOVGlT?=
 =?gb2312?B?TXhOd2NVZG56anYrOW9PRDUwYlpBZlczYVNYa0ZUNHJlbkhjNTdieW5sQlgy?=
 =?gb2312?B?Q1ZDRTlhL0xIM0FSWmN4Z2VMVTdkTDFLdmVMdGtLa04yNTZDaXlyYXdENEpN?=
 =?gb2312?B?RWlJQ05pWEx2ajUxT1FzV2JJdndmY1hBVmMxWVRNNVVtVnY1ay81cjhyYVp1?=
 =?gb2312?B?NzNBTGttdThBSlkrRk1iVUJRYk03eVhGcCtkVVhZOHU5TDE1U1NTaEZSSjdq?=
 =?gb2312?B?UkVlMTVoNk9jV3B3MFZ6WXRqKzBxOUVacFJMQVVVZ091NGk5c2ZYbmdSSzM0?=
 =?gb2312?B?Unl1WklHa1p1TVcrS0pic1JLSnJ3anlhNU1IcWl3aElnbjdEbDFtbFRuUzNt?=
 =?gb2312?B?KzFhYk02Mk1yRWhIdWIyYi9EUi9GVUVBd1NpWWp0UlpDYkhKV0ovdlVVcFpN?=
 =?gb2312?B?RVRrZDhjMkdYN3FIWGp1VkhpOHVNWjN3dmV4WEJPSWVldU9VSzdEWS9ELzNI?=
 =?gb2312?B?S2JaVUZ0NTNpbG1MMzN3Vjh3cVd1N3h5b2pERkpneGFYVm0wN09sV3p4VVhC?=
 =?gb2312?B?a3p2VnFpSFo2bmNmZkVWNGZmMytZZVZPZ2pzZ2tuenEvMzYxL1YyTmd3ckVE?=
 =?gb2312?B?Y0d1V1hDZGp0ODFOalRSc2JqRXpzZUhnS2lQOGlwTloycGtsdUtOSXFhSDJL?=
 =?gb2312?B?cmJZaE9XOERVVGlTUXp6SkVvcGErVDVBMEtYT2FGZ0wwV3hkdWRnNXJuLzIv?=
 =?gb2312?B?UWl2ODlkcjd5cG1KN0xOcWZEOG9XTFNKeC9wSGRsTTBzZHdQeEVUMGJ6U3Ba?=
 =?gb2312?B?MXRTVTRKVitucmpGUWR1eXpiNXpCVnQ5Q1BYdlpHQ0l0VjMvalF2L0FFUDZo?=
 =?gb2312?B?RUxueUdqbkhNWVE3MDJrZzlKdWNPeW5DY3pKem9HS1EwSnFXOSsxdEE3V2Qw?=
 =?gb2312?B?VFB0RDBOd1ZrdEtpbTkzTHNHNjRhZXg4Tzg5SFZ1dlJZR0xhcmdMVmVDTjlK?=
 =?gb2312?B?Q0cxaGJjNWtjUnMvNUJ6WDhhWVJydVJTQzhlQmQwQzBJdThCMFN1K2FEUWxC?=
 =?gb2312?B?eFFYcTcwNE4zTDhOdVY1K0g2VTNtMExOTEk5bWFsMUY2K1VPNzVlT1NZeHd1?=
 =?gb2312?B?eFhsWGFQVkRKK0lXdjFiSkw4bU41cGgrTEZrYmQxbVdaUjJNV2hWN0tTQWpR?=
 =?gb2312?B?bkdzYTN6K2d2SDR4c1ZEWFFwTkRtTG9jY0NrUDlLdklNSlBtSnF0ZG56V3E2?=
 =?gb2312?B?c2YzcmxCNkZRMHhHSldzOVhrUnY0cEU2YmUzL3ZmOE1PTlFQRSt4TnJwdlM3?=
 =?gb2312?B?ZnR2bnBnYmQrd1ZvMnFBVkE4N2lFU3J0T3h0ODhqbFkweFExNzFCTWpZNGdR?=
 =?gb2312?B?Ynl0S1gyNzZiZk9rdi9sb3o3TFZyeXZOTEsvRWZMU0czZ2Fvc2czcWY0VTNX?=
 =?gb2312?B?dkNWa256d29RMUNKS1dMTFFlWlRyQSthSFM5STJXSmpVMm5hdmo1MTVLZ2ZF?=
 =?gb2312?B?cHNvN0NQL3NnSWgrZmlGS1ppWUx2WUY4ZEY3SVpoRS80aHlzVnh1TWloajFI?=
 =?gb2312?B?dG44M0RYMHlYaHVzSjFVanh6L29CNHJaeXlmUnlTYnExQnZHdWMrc214cDJB?=
 =?gb2312?B?bzFsSXNkTmNScDRyV0IzSlFFclBNbXNuRG5sVmlxdEVvWlBoVUd2R0pGc0sv?=
 =?gb2312?B?RGJUTWpibnd4MGhQcGs4emJGYnhDOC85WDZGa3NLb0FHL2wxTkNMVDE2Tm1M?=
 =?gb2312?B?YW1ZNU5oWlRyaXJuNllyVW9uZ2lhWXNJZWVwS3dTSHVhN2ZHK0xmQ0Z2bVBo?=
 =?gb2312?B?em93U3AwQnUyS1RuSlltU3Q1Uyt6MFgzOHozU3VoOVU5NHB1VzN0K0d0ZDhn?=
 =?gb2312?Q?gwc0=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9391603-942b-4f9c-33c5-08dd1987d3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:02:12.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va9GH2XB+S8ObjTidt+ixbuk/iXozw6mB/Og+rFjhd9g7hs3u2XpoKJ3YyXtD+w1KVdTVYkyMEYQw5z5Lnapaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMtTCMTHI1SA5OjU5DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBoa2FsbHdlaXQxQGdt
YWlsLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gZmxvcmlhbi5mYWluZWxs
aUBicm9hZGNvbS5jb207IGhlaWtvLnN0dWVibmVyQGNoZXJyeS5kZTsgZmFuay5saUBueHAuY29t
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgbmV0XSBuZXQ6
IHBoeTogbWljcmVsOiBEeW5hbWljYWxseSBjb250cm9sIGV4dGVybmFsIGNsb2NrDQo+IG9mIEtT
WiBQSFkNCj4gDQo+IE9uIFdlZCwgMTEgRGVjIDIwMjQgMDE6NDk6NTAgKzAwMDAgV2VpIEZhbmcg
d3JvdGU6DQo+ID4gPiBJIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZyBidXQgaWYgeW91IGRvbid0
IG5lZWQgdG8gZGlzYWJsZSB0aGUNCj4gPiA+IGdlbmVyaWMgY2xvY2sgeW91IGNhbiBwdXQgdGhl
IGRpc2FibGUgaW50byB0aGUgaWYgKCkgYmxvY2sgZm9yIHJtaWktcmVmID8NCj4gPg0KPiA+IEZv
ciBteSBjYXNlLCBpdCdzIGZpbmUgdG8gZGlzYWJsZSBybWlpLXJlZiBiZWNhdXNlIHRoaXMgY2xv
Y2sgc291cmNlDQo+ID4gaXMgYWx3YXlzIGVuYWJsZWQgaW4gRkVDIGRyaXZlci4gQnV0IHRoZSBj
b21taXQgOTlhYzRjYmNjMmE1ICgibmV0Og0KPiA+IHBoeTogbWljcmVsOiBhbGxvdyB1c2FnZSBv
ZiBnZW5lcmljIGV0aGVybmV0LXBoeSBjbG9jayIpIHdhcyBhcHBsaWVkIGENCj4gPiB5ZWFyIGFn
bywgc28gSSByYWlzZWQgYSBjb25jZXJuIGluIFYyIFsxXSwgaWYgYSBuZXcgcGxhdGZvcm0gb25s
eQ0KPiA+IGVuYWJsZXMgcm1paS1yZWYgaW4gdGhlIFBIWSBkcml2ZXIsIGRpc2FibGluZyBybWlp
LXJlZiBhZnRlciBnZXR0aW5nDQo+ID4gdGhlIGNsb2NrIHJhdGUgd2lsbCBjYXVzZSBwcm9ibGVt
LCB3aGljaCB3aWxsIGNhdXNlIFJNSUkgdG8gbm90IHdvcmsuDQo+ID4gSSdtIG5vdCBzdXJlIGlm
IGFueSBwbGF0Zm9ybSBhY3R1YWxseSBkb2VzIHRoaXMsIGlmIHNvIHRoZSBmb2xsb3dpbmcgY2hh
bmdlcyB3aWxsDQo+IGJlIGEgbW9yZSBzZXJpb3VzIHByb2JsZW0uDQo+IA0KPiBQdXQgbW9yZSBv
ZiB0aGlzIGV4cGxhbmF0aW9uIGludG8gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCByZXNlbmQuDQo+
IElmIGl0IGNvbnZpbmNlcyBBbmRyZXcgd2UgY2FuIGFwcGx5Lg0KDQpPa2F5LCB0aGFua3MNCg==

