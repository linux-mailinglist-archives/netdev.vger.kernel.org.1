Return-Path: <netdev+bounces-120401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D87959246
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2A9B21AF4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9ED2B9B5;
	Wed, 21 Aug 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEcWQ1gr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B604D8B1;
	Wed, 21 Aug 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204460; cv=fail; b=dielEze7bmmBN0Pm76qURjLXFVwni2TepVPs8GkwpwO6Mehl852bPYzAivY18RdDeV5sr1BSdHwRtaMzlNiCOb9pFYrhe3Z7EAb3vbgL27jmqEiU5uU8FUmRsQCkDE8/ppZ0GaMcujqKG70eRptJVv4yfkN84aDlW4w7SCjKdwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204460; c=relaxed/simple;
	bh=jQ9sSp3RTKB/jD5evx+ZNUaMKKDzO/oC8ta4zGDhEos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmOOT4Ljw06/Oiu+qkDxJ7DLnhHGUe+UV80Jh9pSb7rw5GsC9ZSaXFH9cXgBmMY+t/AVPW/GhaPKkEfvyMLJ1F9uiaMJsFBGW/tD5ktRsdXh7ARoiYFkIJrg9lFCnCxh//NL0yUXAVep6i25EpflbkuMszIrjFytrtLZUYuIVbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEcWQ1gr; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnFsA3WYqkeFQpURlOMWii+EkrQu5/36ww5vIhY7/TLOsD9ZuK4h/QnT0x0BQrXQ52FHqv4BUa7YjVAbGXg+3T3yFDAk4G/LrbXhgbKLR4jtQpxHkLNxR9cuGWQX/RauUCo7+ojohOLYKfvYMARET1N8CwJTlE47V7B1ap9eGn6EWp4nXRHGvIagy///B3jb8KdEBzpLESAP6wL2amdhVGQfO1yEdVq8uYdAzAfpq6JykT0BPLgD3YZJ5SDr49nNcoe5abL8AFFINuQvd9HzePk0zfddI2txOPYihM4lnjhopFS7QgfpO3HzjGBAYXANcYLr6Syy5Xa3GIccAyTszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ9sSp3RTKB/jD5evx+ZNUaMKKDzO/oC8ta4zGDhEos=;
 b=Njp+1KKsFO/c36doNkap+37cjIZEBZNasKSHSeyrmjEJM9Dd4GYPBM8nxFfux69aDKhuT/RXweUyHy0tdxsIxbbhq/GfDJ/qmepKxkWj4Bpr7tJoHoXtt6+AM3eS66Ca3pvtq9PPL+tvJfMVhsSR6VEzhl4bzRu6W2TDdTvQDa5zxRx+SuqHMageRGpRHxSAos1i9JbbzqWm/zUDHlzmM7D9+B1RhAADmpo9+vhN68+8N9be8IsH6tEcaZn7fHkSc1zzDpEqJMvuzIZFjUSN7VV4SHyDY+/EWDmCV4er4PLLoS4+0ZYmNblwPrUW00IzTOlKqZAjHliDQKRkdn7zWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ9sSp3RTKB/jD5evx+ZNUaMKKDzO/oC8ta4zGDhEos=;
 b=iEcWQ1grHPIdy1QB1QDXZsegux8vP++UnBctlNAMpPOCHsJJoOtuNoxcSodLp+P8Tb4jiuUfVOb0TqjtSbZQewYxuTi/QA+i89yXsXQw/d4vO7SOngiIS3D6iWeODaVJG2Xmde9JLKRowxQSVSjuuVbsW3u77hFdT1MicD9B6Do8cxWk97FjDfLoYbIx8MunwFE4OVMjoHsI2t3R9bRyHukV9rP0IBXFqw1EIrbsRhCDL+Cri/IJNdObqL53+a6KyejH3lqye+O65KaqG0aPVaWvvpXsxp/nfZEqFrofREWtehyjoEVLxWt305FFV8+RypUzoQmBibm/qKmsBpekLA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10460.eurprd04.prod.outlook.com (2603:10a6:10:567::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 01:40:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 01:40:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Topic: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Index:
 AQHa7tklv/4L4ggGKE+iM9Tw+y7ldLIoYlwAgAC0geCAABSogIAAAo/AgAAM1wCAABLEQIAGUg+QgACLZwCAAMwDgA==
Date: Wed, 21 Aug 2024 01:40:51 +0000
Message-ID:
 <PAXPR04MB8510B308FFF8BF25C0D775CD888E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
 <PAXPR04MB851069B2ABDBBBC4C235336E88812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510B51569571BA58243FEB0888D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <248b38f3-3cb6-4dd8-825b-e4d2083a99ef@lunn.ch>
In-Reply-To: <248b38f3-3cb6-4dd8-825b-e4d2083a99ef@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10460:EE_
x-ms-office365-filtering-correlation-id: ce6e89ff-41b2-4e82-a835-08dcc1824a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cURHbk56M1VROTc1L3ZKOG53U0V5QlI3MFlybTNma1RxOTlNRkR5d0d2OTY4?=
 =?gb2312?B?N0J1QnI2a0gybk5BUVBHK3I2cVpkZ3JxNmZhZjVFZHRLR2NiOStmVkJjM245?=
 =?gb2312?B?c01NeFhXZjc3c0hTYlpubnVSMFNoWmFHYUlLZVh3WTFDZzY1N21wa1VtVXJB?=
 =?gb2312?B?WlpESnA4dkZ2YzU1WVp0Z3M2OVo2cElqMFFRMk9qWmRkY0Q4Mi9aTTArZHJW?=
 =?gb2312?B?S0ZhMnpxMWhzY04vNmR4cDMrcnRCa3k0ZTE5VzFFaEdYYmtzWkZEYUsydVJF?=
 =?gb2312?B?RFRKUldqazlhREJLQXFtZWw0aDNyVkd4OStkVUNBcEg2VVNXTTFDVVFSckEw?=
 =?gb2312?B?WDlsNkh4bys1eVNDb2VBQUV2bjFkd00zdVBJVVFXektEMEQrMGRsRWVSTzBK?=
 =?gb2312?B?WEVtcEVJQzNUakxlOWZ4bGRVREg5M0tPajRmbUxhYkZmS1N4d2lwMnhsaGpD?=
 =?gb2312?B?TXJNY1JaSDlISmlkRm9wZHI3a2NvTkRMSXJkTktlYXJTbFBxQjh1c09yeUtm?=
 =?gb2312?B?WmZ3aVB2L1NuWGcwbVZEVDB6S3dVUk5tN3F0K0xFNG11R0pNZWJ0M2ZNVlBK?=
 =?gb2312?B?eHQwbDMrdmp0ekpOV20vNDJQZGRBUzBtWkZ3MzBiSnlVQUtwalJISGg5b25j?=
 =?gb2312?B?L0J1SVF3SjVRY0lxUGUwM2Nrdlh1Q3FzWFNRUytWRFZqWkREMkdrTU1IdFk5?=
 =?gb2312?B?UTlpMUxGTkZNOWMydXdjRkFIelMzUWJsWHd3WEVHVjN0YWhSVHBHWVlOMkxO?=
 =?gb2312?B?Y3VYd2tVME92Mlhlelo5Ynh0MnRnZ1ZNL3RoeGVFSW1YdWk2V3Y5Zjg2WHJa?=
 =?gb2312?B?dmYwaW9KMm80TlVGbjVuL0xXazZzWXpvZnZiSW1JYWo5Q09NdnN0dFBMaFRs?=
 =?gb2312?B?emNFTVRnbm9rUlg3N28yZ2xYSmJDa0xjWm1WVHNMUHBpRWs4V3hNMFRVdWMz?=
 =?gb2312?B?c00ySXBZVjRXdytaZ1hKZ0UvRUhmaGtCa0J3eVdLMkx4REMxTmNndXZKSVJI?=
 =?gb2312?B?b3hLckdsV2puQXQ5QTlhbUZUUkFXb05tWWc2MzVhVkx0Z3pVVzdtWEFMd0h0?=
 =?gb2312?B?d1NlTnF3K1hyWHhROC9GU3l4VXpqVlQvdUNjSjdMVU55dXRBd2VVN3M1NUlq?=
 =?gb2312?B?V3RMWGtRRzNyOHJNa0RBYURFR0U3WWdZTGdiM1E3NnBQUDVXcGovcm1FQVZs?=
 =?gb2312?B?dWs5QlI4WjZiQ0tXOGg1bkU2ZTBKcjRmYkhhSFhzNExjV0tIdmtLOCtyUitO?=
 =?gb2312?B?YnNuSHF0SjYvOG1aNUhsLzNaQklTcmwyUHhpWFRUUGFtb0lOcjBYOGl4b3Ji?=
 =?gb2312?B?Nzg5ekRiY2xsYWc3UnVyb1Y1YS90aWN5UUJNbDNKakdMVUxNVWVWTkpFK24w?=
 =?gb2312?B?RUhXakQ1d2FvTWg5S3lOVzN2OU1NVFZPNGlrRHZGZlRwWlhuUS83OURMdjdl?=
 =?gb2312?B?WXlIOXkrQk9aUWJsT1V6RHcxczQreFpjbmZNVXhCM1MyZ3crd2RZMDBNd3FV?=
 =?gb2312?B?ZlkrNXByd1V4YTFkRmQzQkVtaU5yVGI3a1Q4MStpUVI4OEl3Ym5xaW9KYzBz?=
 =?gb2312?B?cmlaQ1IzeVh2bjc3eTdocU0zOGlrQkxQd1l1RzdoWUlsRWFHcE91VXFvZXFx?=
 =?gb2312?B?ZUhiNDAxNExhc3lPU3AxZUtZdUlVY2I0NllRcFVaamZHbjNQeVhvcGFaNWVD?=
 =?gb2312?B?R21xcWJQQzZrSFBTZVB5dHZhNE5Zc2hPeW1aQi8yL2JvK1hzQzJpd0VxQUFL?=
 =?gb2312?B?WWJLOTZBQmYxcmlOSE1IYktua0UzeEl4RWNtdHVhMkYxam5yUk5OZ2NFMnV6?=
 =?gb2312?B?aWxrbFlFdlJ3ZjF6bmRBT3d3TDkySVRERkVxS1VoNmJ3N1g5clZlUDdJSDY0?=
 =?gb2312?B?MDc0ZTZnMDdmTkJ3QXErYnFVa0pISVlKTzlCY2Z0aDlaSWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TzYrTlhDMG5qdWZHOTJ1UnVzMVUxeVVVMVJQYlRhbTVhbmdKWWdaSUtnMUJV?=
 =?gb2312?B?RHZGUDZBVGtWeDNvSlB5enFUZkFhT0RoVVFyU1VJODJoeDF4UXlEMXQ4OHNy?=
 =?gb2312?B?b2pUUjRVRExTWWlTc25YOXZBS0s2cXRYbnVqclVhVk91b3I3RlVkZGhENnZ4?=
 =?gb2312?B?eVlSYWt6Nlp4Z0puL0N4SnVES1JaNGZwRVhoaU1oV09PWmVieGpaSjE3UnpL?=
 =?gb2312?B?RThIU1ZHMFNJb29pUFB6WTRvN0hHWnhOSGc2Qjc4a3diK0xPK1BLb1NpakFl?=
 =?gb2312?B?TTA2ZEpPL3RpWHZxU202QUxYL1N6QUYxZEZlRjZrK2FreTNsbGptM1FzZzdj?=
 =?gb2312?B?RllpZVBrUWhDVHZVL21TT0VybytpQWZwSStBaTM1K0NGSzJEcWpmTjZuaWlV?=
 =?gb2312?B?NjVOKzUwUGhSY3pZTGllaGZnYnErSkZab3ZzR1FTd2RIRzdMT0dURWJBbDZ4?=
 =?gb2312?B?dlU3Y1pyWkhBSDhqM2hOZXU1T0xOdmxnSjNmekhYNU5Eam9sRWZmbXRoZk41?=
 =?gb2312?B?cndDSDg3Sk01UDA3V1hnNTlCcGg1TjZrVkJsck5SeFFYQklxMjFLSUc2QnUz?=
 =?gb2312?B?SGhZQ3lRYkRYQU5LQzMrUGlBOGMrU2xmTDJiaVc5Wk1mdWpJNndKTGNDR1Br?=
 =?gb2312?B?UUk3YklEeE1UT3d1Q0hwWjRKWDJWektLMTRQaEpnaXM4amQvNmdjWGYvV2xT?=
 =?gb2312?B?Z3ZwMnoyR2tBT2gvcXk4cDIyVmFZL2xhemRWakdjR09jczNTQkVpdFZETnBG?=
 =?gb2312?B?b01aSlkxWVk5R1FXaXJ2TWJaamUvOUowVFVzSHRMVkl4YUFDREhvVE1rcnBY?=
 =?gb2312?B?Q1BlZFZXbGVvd1YyZVhtR2xGYkdFVnhKZGhBaEJUNThBMEo5WVpHa1R4cFFL?=
 =?gb2312?B?WERiTFl0ODR3VmlNcWxaVU8zUGpQNUdvSStXam1YVFNydDdUdHVINEZtZy9Z?=
 =?gb2312?B?Q0xEcm5tWGYvOTdHQlEyMHNxOUNaQ2didUxNYmVCdDNqbU9BQ09kUWVCenFz?=
 =?gb2312?B?N0srdStiK0hKeHRVZm5FZnlsQmZ4QktjUG0yaTA1bFhkNTNVb0lldG9TcjZG?=
 =?gb2312?B?cUJxWElZbjByOFZHR2dFanJHT2xsWWNJQ1J5dzJEVXE3b1VIblJSVnhZUkRP?=
 =?gb2312?B?ZFhYdzN2bjNmeW9sR05DbWFCcForaHVyRnZVNlV3cWNaeS9TSmFEaWc2Z0FR?=
 =?gb2312?B?WjI1YjdBb2pvaXRndjVjWkRsWUZxNVU4Y2h2RXBOd2ExREJpRlhEQ0lxNnVI?=
 =?gb2312?B?b2ZRbGlpSzh4clFGNktIM3VVUUJaUWhldURuZjVhUC9DckZsUnpzQmRQZnlF?=
 =?gb2312?B?OEkvc3pRQVd6aEJIbmZPR1JmRkdrN0c4WDc1eERId2pRRDFFUHQvTjZnUlJo?=
 =?gb2312?B?UzhpbjZSQktQMGNnUThVWmpGL2RubU1vMTNMczZLVDFkZ09TZUZlRmZmc09t?=
 =?gb2312?B?aGJtTjJkNk5YYXgwTVlVQ2dicGdPQXVZT0Q3SkFuclpnNlMrSXBvZXF0MXov?=
 =?gb2312?B?Q2xtdTFxWWR4UTJWUU83emJIZnB2bmE2NE5xOXcxMmk2dFk4dnhmem9DMit2?=
 =?gb2312?B?Q2x5SlVaZlBINkFRWGFNYkk3UEg2dEdac1BRSlIzUjVYMFJvaEJvd3ZMMGg1?=
 =?gb2312?B?dXNIZjZxR3NNanhEWDJJTXRqMk9TNDNmRmx1MkVxbTBMbjNxWkxwMHUwS0FI?=
 =?gb2312?B?dGF3ODRGMklCckZOeCtIMVNybU5DdnowdUJMSDhXSzd6d1QwVXhoWTU4SFkv?=
 =?gb2312?B?dVVScnFkUDUrWndqalExYy9DWENOY3VxVk8wcXJwSjdqSEFKdE05ejZMeE81?=
 =?gb2312?B?bmdDYTB1NkJWTWlGUHlCbG40bHVxd1VnRGd0Q0p4R1J4RDVxdFpUKzJoMWFs?=
 =?gb2312?B?K2xUaVNJQVdBOGR5RGlaMUJ4SU1DZ0Zhd1hXcDMyb2pKdWVqLzBnRnRXeWho?=
 =?gb2312?B?aXRNeEhSaWh4cjM2Nk1VUWcrc0c4SG91U0JqdlYxMXFrMWVlNVhyanhHYjlJ?=
 =?gb2312?B?ck1wcEdHQmlrTHNTVDdOUkRwc210NzFaazhFa3ZYdjZsdTZveUdKaXpESFNj?=
 =?gb2312?B?Tms5TDVHcXFpZzBwUm5TVkZkcTZOSmtTclhzNXBtdW1RYVBOU2h3OFV2emYy?=
 =?gb2312?Q?LwJE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6e89ff-41b2-4e82-a835-08dcc1824a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:40:51.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWEIEDsy50AvltD8EdWVW9WciEVH7HTYBaA/2qkfdN23ZGRJStDR5lWEYOYCH+gypoepVX3gBpYXDfi5b65K0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10460

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjIwyNUgMjE6MjUNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGYuZmFp
bmVsbGlAZ21haWwuY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgu
b3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpIDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxLzNdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IHVzZSByZXZlcnNlLW1vZGUNCj4g
dG8gaW5zdGVhZCBvZiBybWlpLXJlZmNsay1pbg0KPiANCj4gPiA+IFNvcnJ5LCBJIGRpZG4ndCBm
aW5kIHRoZSBjb3JyZWN0IFBIWSBkcml2ZXIsIGNvdWxkIHlvdSBwb2ludCBtZSB0byB3aGljaCBQ
SFkNCj4gPiA+IGRyaXZlciB0aGF0IEkgY2FuIHJlZmVyIHRvPw0KPiA+ID4gVGhlIFBIWSBkcml2
ZXJzIEkgc2VhcmNoZWQgZm9yIHVzaW5nIHRoZSAiY2xrIiBrZXl3b3JkIGFsbCBzZWVtIHRvIHNl
dCB0aGUNCj4gPiA+IGNsb2NrIHZpYSBhIHZlbmRvciBkZWZpbmVkIHByb3BlcnR5LiBTdWNoIGFz
LA0KPiA+ID4gcmVhbHRlazogInJlYWx0ZWssY2xrb3V0LWRpc2FibGUiDQo+ID4gPiBkcDgzODY3
IGFuZCBkcDgzODY5OiAidGksY2xrLW91dHB1dC1zZWwiIGFuZA0KPiA+ID4gInRpLHNnbWlpLXJl
Zi1jbG9jay1vdXRwdXQtZW5hYmxlIg0KPiA+ID4gbW90b3Jjb21tOiAiIG1vdG9yY29tbSx0eC1j
bGstMTAwMC1pbnZlcnRlZCINCj4gPiA+IG1pY3JlbDogInJtaWktcmVmIg0KPiA+DQo+ID4gSGkg
QW5kcmV3LA0KPiA+IEkgc3RpbGwgY2Fubm90IGZpbmQgYSBnZW5lcmljIG1ldGhvZCBpbiBvdGhl
ciBQSFkgZHJpdmVycyB0byBwcm92aWRlDQo+ID4gcmVmZXJlbmNlIGNsb2NrIGJ5IFBIWS4gU28g
SSB0aGluayB0aGlzIHBhdGNoIGlzIHRoZSBiZXN0IEkgY291bGQgZG8sIGF0DQo+ID4gbGVhc3Qg
aXQncyBtb3JlIHJlYXNvbmFibGUgdGhhbiB0aGUgIm54cCxybWlpLXJlZmNsay1pbiIgcHJvcGVy
dHkuDQo+IA0KPiBJIGRpZCBub3Qgc2F5IHRoZXJlIHdhcyBhIGdlbmVyaWMgbWV0aG9kLiBJIGp1
c3Qgc2FpZCBjb3B5IG9uZS4gV2UNCj4gaGF2ZSB0b28gbWFueSBkaWZmZXJlbnQgd2F5cyBvZiBk
b2luZyB0aGUgc2FtZSB0aGluZywgc28gd2Ugc2hvdWxkIG5vdA0KPiBhZGQgYW5vdGhlciBvbmUu
IFdoaWNoIG9mIHRoZXNlIGlzIGNsb3Nlc3QgdG8gd2hhdCB5b3Ugd2FudD8gWW91DQo+IHNob3Vs
ZCB1c2UgeW91ciBvd24gdmVuZG9yIHBhcnQsIGJ1dCBjb3B5IGNsay1vdXRwdXQtc2VsLCBybWlp
LXJlZiwNCj4gZXRjLCBhbmQgaW1wbGVtZW50IHRoZSBzYW1lIGJlaGF2aW91ciBpbiB5b3VyIGRy
aXZlci4NCj4gDQpTb3JyeSwgSSBtaXN1bmRlcnN0b29kIHlvdXIgbWVhbmluZy4gU28gInJldmVy
c2UtbW9kZSIgZG9lcyBub3Qgc2VlbSB0byANCmJlIGVhc3kgdG8gdW5kZXJzdGFuZCBpdHMgcmVh
bCBwdXJwb3NlLiBSZWZlcnJpbmcgdG8gdGhlIA0KImFkaSxwaHktb3V0cHV0LXJlZmVyZW5jZS1j
bG9jayIgcHJvcGVydHksIGZvciBUSkExMXh4IFBIWSwgd2UgY2FuIHVzZSB0aGUNCiJueHAscGh5
LW91dHB1dC1yZWZjbGsiIHRvIG1ha2UgdGhlIFBIWSBwcm92aWRlIHJlZmVyZW5jZSBjbG9jay4N
Cg==

