Return-Path: <netdev+bounces-131884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C329698FDCD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860052811B5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A73132132;
	Fri,  4 Oct 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YSNP9nFc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874B69D2B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026786; cv=fail; b=KfhZSt+5e9tPNIB6lHv7o9aIJXNdT5g/2UcLlylQvpo/GDbgpigmaHq4QLTpFdbjDg+i3DNKnBFiX8rQ8iF4KVKdrh379APpzX5QRVSc2i168df7Om6c4ZS+1gfYG0vQt3oerrtnXVJuBhL3aEhEQm96Vo7ysvzZD5Gb9jXf2TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026786; c=relaxed/simple;
	bh=NhD6gp0Byov8XsplyKkaUPbXMoh4ac08m4fMx/CEH9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1rG75pJOq7QCV9ZyV3AgdnAp13N4ugkD2Ojrd2Bo2wz0JVJJNypHARNWtjyaTxGY461BqqymdPrjqngeumJEgk+hKeDMuRXFdoVdQXT0Ysv9SI2cm3XMWHA+LTAFsewQyFN399KPw9AV1n04OxCvmZH4UBN5YVuejr/fIm7Ng0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YSNP9nFc; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYinihLVZbJZZymH7mRmcWeo08JPRMbzVqDABMXh8jT5ahDy0AUv2hGaiu40XFjQyODBcB0qOa+iwbqyRxf7sKr7Gc7OY060kM70iw2GYMuUpKeqFgVovJIrtEpW6681nFvOSIqH555LhBWE3LYKZCnNZnf82dlyprM1dGVUoZlFNpOCGJ6QOAkg1RHKrp9tM5DguWVQt9AlehNmxjBHGewVo5SBM0hfRosU6D7aAKQD4aOM1nGpoz5WS8DHrnbUN9cUJP3pVUoIcFHjhaCS1YG6P1IVNhPO/aVimR7YvEll6z/1j0DC4LbH2/LwYF8ZH4kcxhDx2a6WKi6k+zJV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhD6gp0Byov8XsplyKkaUPbXMoh4ac08m4fMx/CEH9I=;
 b=vDtwG5Ob+K0c6QdLXPE88qBJVK+ATHOGy6Ce4ZGzncYXpS3Zgwvw5h2oQ3lwt83JBvuPvvVnJFMukofyIgyIlVDdz8XOqsYnST/YFBgLR8s4I+BpBLZsgxpJsXTBEbcteBGhUppK+PQh5RaXn2q2p27GG0W6OMGVHYFEMmKpLuPMg5AR0e854fn+5Kp2bNmbsxbALasmuK0K4XerYrDk2FV2tjqNKKoT+h+mZS56jONU3zQHJ2u2FUCtJVN2QMnCkUFnQBqZ4FKSqOgMduUcyY1uoWs6k9bI9CITkJgryX4i5Y3LhacYBFN+3qJ36pbt0ZlJ7XMpFWYlmIiHFDRBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhD6gp0Byov8XsplyKkaUPbXMoh4ac08m4fMx/CEH9I=;
 b=YSNP9nFcBSG7RxcbA8dHxou0SblP3Cv8V+fd4PcopT4f6oBnCsjLqqk+HyRYyRXhCnEU7gfrIrQ9glKUPObSCMlzCFuYdQUPXNd4yeH2tKGWSqoo1oi6M/+/wgQ0q3oR7N10dzzck56ibA61747HSxsytBftGb4U4/H9WeHN1dR92ujgRteGZsxb3NQP7muYvUysqDXsFqo3+R9rvmNWAKYcJddk6UTzE6O8L/isIVXMV7DkN+i5+Ymf0SU3PXEC7LkynmdxMTr/L+sEHho7/vbc35B0KBmm7+j/wNG+KpGHHSW+7jwPawh72fxjIzif1J+qf0tjYPHG4ABIoLDwag==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 07:26:21 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 07:26:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "agust@denx.de" <agust@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Topic: [PATCH net v2] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Index: AQHbFO5GTnBxf56WoEy8ZQO8QjvNXLJ1iNwAgACqsQA=
Date: Fri, 4 Oct 2024 07:26:21 +0000
Message-ID: <b4e0dba3867bc16f6c0a26f2767e559d5a4156fe.camel@siemens.com>
References: <20241002171230.1502325-1-alexander.sverdlin@siemens.com>
	 <20241003211524.ugrkjjc7legax2ak@skbuf>
In-Reply-To: <20241003211524.ugrkjjc7legax2ak@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3559:EE_
x-ms-office365-filtering-correlation-id: 92533a49-d10d-4038-2877-08dce445d841
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dURHc1FKdTZxNHlRUXBlZ3k3WERua05BbGt5R21WZkRGQWZUYzE5eG5aOUYw?=
 =?utf-8?B?R0x3ejJhdU9NUk9rV1d2WUpXUytYTS9MR1dsUERSZWJMM3JyTVgzWWZYQzVv?=
 =?utf-8?B?YTZQV2dxNmJSSmdaMHVxaFNnMGNQY1psNTVOc1M4WEx5Wk5qV3poT2hpWmt5?=
 =?utf-8?B?ZVJrSk1qTGxiUTRDdzdRVXVoeTlvZWp5V0dEOFNGWm1UcWJuS3ZDNUxPQmJZ?=
 =?utf-8?B?TG5aWG5udThQeHpJenAvUGhRN0YyelFobklNVmlIeldHR1NRYUlHbmMrQXZY?=
 =?utf-8?B?SklDM3dyaTBOUzdsRDJSdzAzUkpwdE9mM1NFUVdOWi9Td3dwalBFTmxGdlNk?=
 =?utf-8?B?L0FiNkE0azd1QkdOdlgxd3Y3dnAvZ3RDSzZPVXhZaUpkWlk2ZjZSUUltZmpH?=
 =?utf-8?B?elg1TFpua0VkMmdvdHkrSC9GcDkzcldidmdDWFhQZUJiR0lMY3g1a3VIblY3?=
 =?utf-8?B?emVNT2dBdlQ2V2VNTm5CRkFWdHd4MU9POVBxZy91YUJBY1M1Y2k1enZXdDBh?=
 =?utf-8?B?Y0JTMFFxSjRRRnIwQzJnaVl3MGZFTWw1L2doRGUyM3VQcVFkSktpZWFMVVN2?=
 =?utf-8?B?enMybUEyb0NrUjNtdGlNTDdrVU5KWi81YVcvc0hOcDI2ODlEVnZNT00zNW9X?=
 =?utf-8?B?MjQ2cWtXKy9PQi9wckJ5ZzgzNVZCZzNPR0loMURDeFYwYWJRTm94Z2tWWUNC?=
 =?utf-8?B?WE8xdUQ2YkZhU3I5MlMwQXo5NGo0WmpZNWwwVjg5akRvR1c4UUZqWThaNmRB?=
 =?utf-8?B?OTk4Wlp2Yld6aUdRNjB1Sys1cmhxR3hwbFJybUllTHNQS3BseStMU1hpMWtB?=
 =?utf-8?B?MHVEemFLWGM0U0ZtZmROZFVpOVRlMGpGUHFZSFFjbVlPb1ZhTk84Vy9LVzFX?=
 =?utf-8?B?cThLMngrSWhZRlF4OEduN1h6U2tqTHltWG5MNUNsSDRwRFVwSzF2czRnM1Uw?=
 =?utf-8?B?c1lZcldRcmxMT205OXBwYURHUFRIMWcvVDJoSmxqUUtqbWxEa2VpNnNsZTI1?=
 =?utf-8?B?UVpuemlPc1dLYno3L0RpWmRUNVVacTM4NkpVMy9NeFR2WFhRTE9lb2taenFy?=
 =?utf-8?B?YnNoVzBLNDFvdlpyOTdwbk1SOFpnMlpML1ZMbjQ0Vk4xUGw1VUJDMncyZC8x?=
 =?utf-8?B?Nmo0eTZSNUVJZXAwVzZLOTZ0Rnk3S1hwYXFLMHU1S0lrS1llUGVvdVRVaHI3?=
 =?utf-8?B?ZUZzNVBiS2dldEdsU3lQVndickFya0tyK3JBTmYydE1HdjRMSlhGeU1UQ0lv?=
 =?utf-8?B?VDc3YnBvSXhmL3FjNmpua0VWYmFucnRpbTQ1VENKLzhpaE1JMHp4dFQyeWNU?=
 =?utf-8?B?YkZ2TEtia0RrYjhEcDV1QUxrbWxjQVpGdWUwSG14RHpraENpZUtPOW12MmNp?=
 =?utf-8?B?YmdUcEtWa0dTTFFZcXVwT2hFR0xhSVZVak1UdGFXTE1USHBDTDQ1dXVMM2dB?=
 =?utf-8?B?RXFaYzg0SVhkR1lYMVlqcUFxTWxmRFhabEFUR3kwcUE5dXRkei9TQXRRZXRD?=
 =?utf-8?B?K2wvNXFIbnIrWUZsalJXOER3N2J5WDZ2WG5VL1hXMHdnbktidE1nei9yOGx6?=
 =?utf-8?B?dmdMdnRBbGgwNVVGS0R6Z0Q4eG1yREphaW5EM3Z1bzBWZkY5NWdZVi9aQXJS?=
 =?utf-8?B?YWlwQVdSazZGN0lmL1Uzb3dPV1J3STVQUGJKYU94cHQ4eTg4UDBFR0JaUWdw?=
 =?utf-8?B?ZFJVTWpjcFJGOVd1di82d1pyaDFDa3NkRmRXNWhVdFZKQWVCVjVHbHNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTFCcUM0NzdXcmF2RjF0UEJaaHo3ZmZsV1hZYk00SjdWN3BoTmRYS0FqL1hW?=
 =?utf-8?B?cUNSdDIvdTM5SE1nS254M2xqS0U0cHlCVnJKa29YWDAxTEJ0dTZsbkczSTUr?=
 =?utf-8?B?YWthUkFCd0dPMlRaNW5kU0xlV2ptVHpTRWVLL1FYV1FmUEF3OGI4cVppVXVL?=
 =?utf-8?B?eHoxdGFaTmlQaGh3OG5IdHFvUTZSR2hBSEFLUUhiV1BpYmZCN3RlNGtVZklJ?=
 =?utf-8?B?d1pwSXJZWlRIK01ONGUrZW9pVmFUS2hENEZOV3RRbUhHOEdUaXErWlpvZmhw?=
 =?utf-8?B?eTRWWENaWnZPYUlycHVSZndNaXBzZUxQQUMzNUxIWDVpenFhRTRQRW9MbjJ1?=
 =?utf-8?B?RGwwNHYyUHJHaGRoa0VTUmZTNnpYNGlXZVVBVWQ3VzZaRThPd093MkdUbHZG?=
 =?utf-8?B?TnE5a3BoZUxVVzhsSjkvd0VFN3MzMm9BbVdqRjY3Z3EyM0dsdjhBc2s5NTBP?=
 =?utf-8?B?ZUJsTldTc3RqSzVFNkx2SUVML0ZWdktTaCsrKytwZ0Jzd3NiU2dWakx2WXNw?=
 =?utf-8?B?YXVFQi9RZXYxSmpEUm5pZmRoaTk0RENhKzJaZ0dlOEVIbzZQUGQ2RUxINDZq?=
 =?utf-8?B?UkVPSmZKWkU1V0ZKUUdtZlBYMTZqMy9nUVRHczlWVVBDeFA2V0pwV3dnbVdU?=
 =?utf-8?B?TEFlbWNQS29KLzY1UUowVFhzbUNzNTVkYnRuSmZvVlgvWVN0WEpUUjVRVWp2?=
 =?utf-8?B?alJvbEJpUTJ4ai9IRzRWaDdRTEl3V2xtc0o4V0F4dlJHTmM0cng5LzZFbFJy?=
 =?utf-8?B?RlZwSDNPVVBPY2pZYlZhM3hOQjl2cHh4NjBOMEowKzN1ZHI0eWJSY3ZUemVs?=
 =?utf-8?B?Mm9wdXZRc29VWjZDVmRmWXArVzRGbml6MVQ5cHI4aEFSVDQ3UlVPYm1wZFUr?=
 =?utf-8?B?S3NleG0rTmdNeXBnWUkxaTU1NmxnNHRiS0x3T29xZTRDWXNRSnZwNXRrTmVw?=
 =?utf-8?B?WkUrdW40TmZpNmJnR3kvQ0FmTVlPMVR2anFmTXVzWDB3aHRtajJoNHlBdFVR?=
 =?utf-8?B?cVpMZWlMOFFaKzlqZWtKNit6T3RpbmsvTTl6UEcvMnJBNlJGeERPek5SNm1i?=
 =?utf-8?B?RklFakF4MkpVMHZWNG5BalBiUHZnR3UzZUJ2bUl0Zmlqd1Y2bFlWM1JGQUF6?=
 =?utf-8?B?dm9iSHVyMUtvZFl6MHdMZjQ3V2hzRWl3Q2xXYWlud0hKY09ZdWt4Z0VTcE93?=
 =?utf-8?B?MjVQQmEvSld3SVRXNnVDNXBzcGVFbXNWTlFNMmpqUkV2bklDVW82TnFyeTdW?=
 =?utf-8?B?ZklRZHRjT2dFMnBjcG9hdGJxME5wV1pUTTdXazdBTlk4clgyWlJ0d1pQMTVZ?=
 =?utf-8?B?R2JoTWxldTNLVU5JUG5EZjloQmRJUkNReC9uWkljYnlFNXFjTTJ5NGlhdExQ?=
 =?utf-8?B?Q2paWkpLbFJvV2dJdUJ6ZXdoMTNFMmFvenQ0QmlLUkhwZGRlQWpOM3RnTnBF?=
 =?utf-8?B?ZU5WMkRmeU5kZnYrdytqeHhlbXdwUVFTNzhtekNKME1zclpTVFVnZU5tM2ti?=
 =?utf-8?B?WVIwcEcrNGJ3T0VwVW9EeEZpYWkzUmFEcXJPY0FsQlFEcGNwSlhXRjhZWlA1?=
 =?utf-8?B?ekN4RXdsdUtsMWhxeURnVVUxNkhUTU5IWm42T0pDV1prQmZVSGRrWkIzQXRJ?=
 =?utf-8?B?ekJmOTB6SHhEUGpGc2VBaEdXVUE2WTROQ0liUUI0SFIrK3dNazVXdlJ0aGRr?=
 =?utf-8?B?d3kwa0lZb3VjT3FSaFoxOEliQUc2TmZQL1pVcWl0U0R2NjZCZkxETXMzZmxl?=
 =?utf-8?B?NkpHbG9Qcmc4ZFhSSFNVVFpKakFoNUJmcG1ER2kwSGhxZVNkQjhPZU5KbGh2?=
 =?utf-8?B?aFIwYUFFTitrN3haQzZETmxMWSthWVZNWWxCVDNwR1ZsWERKUFNFYmhRWFRn?=
 =?utf-8?B?cDRpMmk3NjdSQ0ZhVGxMRlVHUm5xaFE4Q3E2WVkrOWwwVXhTcjhkbjdLTGRn?=
 =?utf-8?B?Qm9BWkJUSWI1QUZLcnJneG1wUGtNYXU5K3JGQzVOS1pXQmdjU1F6RkpKTk9R?=
 =?utf-8?B?VFUxNzJNOVJ3YkxRbkNseitPbEJEY1cyVG55TGs3TU5iclVSaGlwMk1LTVFj?=
 =?utf-8?B?NGRhejFmMElObnNNdTZ0Nk4reEc2djVwUmZoZTlOdzBheTB5cHpZaDNSZ2Qv?=
 =?utf-8?B?MUZzaTRWdWhVcUtuL0pUNXlDYml3VlYxTnZOb2U3aXpleFM5UUxCTWNDRXlZ?=
 =?utf-8?Q?D0EjzAod/ydICYM4SaKo+vk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B9B8BB958F0D4CA8DD442408B9C498@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92533a49-d10d-4038-2877-08dce445d841
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 07:26:21.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZdWWXPEdm84AYj7kKMI9Bv4GP5xyT2f+xJdSpTMYpYAHpfqSXqCUwIXmCJvmbKYRl+cHs/iWFjTP/oYUg34TtNO9JpJSnons6HDdtzbx5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3559

VGhhbmtzIGZvciB0aGUgcmV2aWV3IFZsYWRpbWlyIQ0KDQpPbiBGcmksIDIwMjQtMTAtMDQgYXQg
MDA6MTUgKzAzMDAsIFZsYWRpbWlyIE9sdGVhbiB3cm90ZToNCj4gPiArCSAqIHN3aXRjaCdzIHJl
YWRpbmcgb2YgRUVQUk9NIHJpZ2h0IGFmdGVyIHJlc2V0IGFuZCB0aGlzIGJlaGF2aW91ciBpcw0K
PiA+ICsJICogbm90IGNvbmZpZ3VyYWJsZS4gV2hpbGUgbGFuOTMwM19yZWFkKCkgYWxyZWFkeSBo
YXMgcXVpdGUgbG9uZyByZXRyeQ0KPiA+ICsJICogdGltZW91dCwgc2VlbXMgbm90IGFsbCBjYXNl
cyBhcmUgYmVpbmcgZGV0ZWN0ZWQgYXMgYXJiaXRyYXRpb24gZXJyb3IuDQo+IA0KPiBUaGVzZSBh
cmJpdHJhdGlvbiBlcnJvcnMgaGFwcGVuIG9ubHkgYWZ0ZXIgcmVzZXQ/IFNvIGluIHRoZW9yeSwg
YWZ0ZXINCj4gdGhpcyBwYXRjaCwgd2UgY291bGQgcmVtb3ZlIHRoZSBmb3IoKSBsb29wIGZyb20g
bGFuOTMwM19yZWFkKCk/DQoNClRoaXMgaXMgYSBnb29kIHBvaW50ISBTaGFsbCBJIGFkZCB0aGUg
cmVtb3ZhbCB0byBhIHNlcmllcyBmb3IgbmV0IG9yIHBvc3QgdGhlDQpyZW1vdmFsIHNlcGFyYXRl
bHkgZm9yIG5ldC1uZXh0Pw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=

