Return-Path: <netdev+bounces-118654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BA9525C8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC34A1F21BE7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF546146A8A;
	Wed, 14 Aug 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="11JZgqPR";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cpIL7gbf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEC60B96;
	Wed, 14 Aug 2024 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674823; cv=fail; b=GQkGaYRFijHb4Jcsn2hYwNxKs0OToPbJ9/ukukpG0ekchCIyWGtL9WgNhqnfTDIyWVQqCwJSYXrxtNLMJ0cU5i7NIj2AH9uSs4VlLaIzigNpfDELIkjV0qxLPPXABLJxfdDWTYwprx11wbZhn/pWkMGVLKFGheG1SVBb4kgSysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674823; c=relaxed/simple;
	bh=ZYb4iCg+NiEBrnON6iRDOW4VTOGob8M0K2ftEQ2B0E8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwpOfxVPrpEJAsJnhERGPlTDnJ0IFSvybLUriiBTMUz2fQA75IwTFeK5iuytK4fxUKMGG5A8s56p8FQDhzoTL687v1nS2Kx23s0NcJRUEYxCa5lGk615a3b6hbs1/hHTEtaGk7Yi4LkfDaJ0nQ4JQup2bLZRLLYBi4Joq40aBnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=11JZgqPR; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cpIL7gbf; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723674820; x=1755210820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZYb4iCg+NiEBrnON6iRDOW4VTOGob8M0K2ftEQ2B0E8=;
  b=11JZgqPRqCAsPps3aBaWya+9x5Xk/dg34+fMNxhihFh/kEthm05Jt232
   W+M35vk2jMg0c8CItCzGdQ4Z3znmVrGuaLGxwS3B4GILW9X7aYW7fB+t9
   aQPgk6PxJh4JUX5Sy/Cauu8348xe6TqNLxu9zd4MulVuZt4af0EeBFZib
   1W4smfI79maoc2y5ibECur9NWrBcHmvntMWaqmeB7pOh5++0/fq7iJoNH
   rKcAaq9W1OeXI9dK3s5u//40A9Y1zs6smN9NKZcVavakrguEuQJT5V45z
   1pLS4nRNX2Q29J0eq5w5NSFZdAoUTiA6V4vhyOjbzOJ8vqKY55q3elJAI
   A==;
X-CSE-ConnectionGUID: 72CzC5HiT9emk2jU1Z+Frg==
X-CSE-MsgGUID: uQaip48RRlKNMHuSy0ehDA==
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="197927587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 15:33:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 15:33:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 15:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgY2F0hXQV/GmpEkdvA5ARtwS1exT+3JQAQ7SLoOvS7oqN9GfZ0LcrNt+LXBZ2bQRwRl6NoZ6ijWsCe/T7R+uXGTpaUCMsWNzZOy/RUI1UrKCvGv9wzFLfAquZSD+8kFXuy71ZsHeT9ZHtN3djiGNeNPgBi5/Z3DI79uw6S7V2DtTuT86vDTlfU/n6LtDR/vxmogwCGd+tLyAkOjwZH1FoMLoEeR8uM75/smy1uOLteP2x3zYLeLfXGwjfQ1XP/diMVl0+dIJWc2hewAValmq5eMKKLj/pVseM93LtX2UQxb3/VpA06sKwE6VwuOTLR/a7bgFus3DRIfNzW/oQlZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYb4iCg+NiEBrnON6iRDOW4VTOGob8M0K2ftEQ2B0E8=;
 b=NCQU1MlTAUsMYuCA+NTGi9s3eSDcag2HyNm7lOZWH+r6zWdt+1j0eMKswbtWfmHjip8XenC5wqyhVy9bQrjZqEjJxH7ffvQ+awdeLodUooOcdvxELqUXZCb6gcbCZ14QWDeZZet9nYvCb/VfK3b9eIJBAQR6s5VNVL3Y7t08S3AcM3hFs+vhvvGBdxmlu3HJUhma88jgX69XNCaFRXI/2GiQasohWAoBAt7H6KkQcSkymiR3AtPvX8TpQkZWGnxlOJCJ2rOrOp0JCcd28DVGJM+6PRzFj2O0UorOHi1H35xESbg5SblQsq8z61w4iFvpKPV4ty/4jqMyJ4ytEx5Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYb4iCg+NiEBrnON6iRDOW4VTOGob8M0K2ftEQ2B0E8=;
 b=cpIL7gbfNaZRYkIPqAlnD9rUpNucbt/vuCAHPgGi10L+DPtrC/7HfnGAT3DlRSMFGIz5J67ZtLsrfOUlHDAS3YqYASZLe0ipPE/w2r+ZH4zGEKHO/fLbm4xElVxqt4RajRO6YXDIt7rVnFcShKtvtfqCzmLYbkeISmTrp6pftaXxEgNfVAtokRWDcd/mYTaRZhtKrHYauhlN+o5GLFn46Ga1Neq0ChUhqqyQ3Ec80bOotPyOUEW6cTqj3VEiff662GgfNQWU6QIiQrO4XN7/Ym1xoqUooYjBAEFexYI06WrIXlVrDIdYMVHLofbMMZYZK5WKmWHQQc9iTSOW8TDdRw==
Received: from MN2PR11MB3566.namprd11.prod.outlook.com (2603:10b6:208:ec::12)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 22:32:57 +0000
Received: from MN2PR11MB3566.namprd11.prod.outlook.com
 ([fe80::6454:7701:796e:a050]) by MN2PR11MB3566.namprd11.prod.outlook.com
 ([fe80::6454:7701:796e:a050%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 22:32:57 +0000
From: <Tristram.Ha@microchip.com>
To: <krzk@kernel.org>, <krzk+dt@kernel.org>
CC: <davem@davemloft.net>, <conor+dt@kernel.org>, <edumazet@google.com>,
	<robh@kernel.org>, <olteanv@gmail.com>, <f.fainelli@gmail.com>,
	<andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <marex@denx.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7IgYQ8AgAV0fnCAAHcDAIABERzQ
Date: Wed, 14 Aug 2024 22:32:57 +0000
Message-ID: <MN2PR11MB35667304A9B1D1899D788BC9EC872@MN2PR11MB3566.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <6f28c65f-c91f-4210-934f-7479c9a6f719@kernel.org>
 <BYAPR11MB355819407FDCD6E1E601BB33EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <557edcbd-28ad-4e0e-a891-8bac8e2f3e53@kernel.org>
In-Reply-To: <557edcbd-28ad-4e0e-a891-8bac8e2f3e53@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3566:EE_|CY8PR11MB6963:EE_
x-ms-office365-filtering-correlation-id: 5aa62eda-501b-49da-6c43-08dcbcb10c20
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?endyTjVHUmlMZXFUYUlrZzE1T1huSU44eVF2UVYxMHBqZXNWWHd1RVpTWlBz?=
 =?utf-8?B?Y2hRNTU4S1haR0dmbytGNTRvQlg3a0c4SkxaTk1SKzE4SGlsMCt1eEV5OU1v?=
 =?utf-8?B?Q2xhTnJWbzZDckIvUVJTVVVPTVltSDR3eTVFOCtweFNnZlVBNXpnRkxWSnlO?=
 =?utf-8?B?ZjcwaCtRNFMxSHNmbUdPY3NVZEtuTThVOGlzQjZsSjVPOGtIVWo1OW04R0hi?=
 =?utf-8?B?VEIwTlJ4N0pHVVVDd0NmY2lEc0VrQkN6NFl1V1VTS3hBQWRkMjRqdWVxZVg0?=
 =?utf-8?B?UTllUTJCeGF1cFUwZDBOVUpMbmNXb1lwYkY0VCs5THo3MDlNNXFyek4zVUZ5?=
 =?utf-8?B?N1hPdEZmNVBsT1VSUWZaUDRxaUhNYUJtVVFYUnlkS3ArRnJNWGVlL2ExZnA4?=
 =?utf-8?B?aXhwV0xibklkQW9MTUFZV1g5YW9KUVA4ZmhrWFRiY0xUQi94OEVibVlGQnVH?=
 =?utf-8?B?SGNPVU5scWZ2VHlZVFRmV01mZWFsVHJJRUNmZVBLLytNc2NuTjM1a0puUnJK?=
 =?utf-8?B?OUMzM1Z0SWdnK3Nqb3lsWDRORHgwSTR3dE4xN2ZVRFN5ZWJmUEt3ZmRzYnhi?=
 =?utf-8?B?K01VckhmQ0lUWk5zMkVEakV1eHB4bEtqWit2RzdhVzQrZEhWTE1Vc0lRSmpW?=
 =?utf-8?B?ejRNYU1leW12MGsyZkpZRkEyME12YUh3Mm0rTXh3dHdlQmwxUTdVMU9jWWNP?=
 =?utf-8?B?OGhGQUlJcTJ3T2FXbVowd3lpMDRSMXJaN21YbXA5R3Z4RHNvdnRJUFRCc2xF?=
 =?utf-8?B?R2tsVUp0V3JtTnJ4a0c2Y29yRkVYZkNGem02L3VDZGo4dEJ3T0oyNDBneGd2?=
 =?utf-8?B?R2dkbTRXeHZtMUlKcWNiaTRCbGhraFIvWXVtbHJhN09aQnRuVTFVSHBjT29r?=
 =?utf-8?B?Y0QzejMzUjNKRmlBUENnMHJpSkhQdmZFZW5RSkU4ald2MnlFTVExS2k3b3lk?=
 =?utf-8?B?NDRyNlN6VStWb1RKcU1QWDNHeUdBY2M0dWJralEwNk0rcmZDbG1rYU5tYTVk?=
 =?utf-8?B?Y3M4N3NrN002R1NwQ29oOW43RlNZRmNDKytWZ1ZIRFVtZWR1MU5vWWcwQk8v?=
 =?utf-8?B?NktJUmc2cm43TGs1UGxjNWRMb3NieERuRXlPM1VKV2NJckhma2NuMUJ0OG85?=
 =?utf-8?B?U2JiakFaaXY0Z280SlVCaFpRR3h4dnhSVFA4bzdWWHZ6Ui9VVEVhaVgvaFRi?=
 =?utf-8?B?M1ltVXNmTFJIeUtFUHA4Q0lPVEZ6OGVHWE51VW1vamJlT2VXUEcyaXRyeHZG?=
 =?utf-8?B?aWxjOWIvKzlQQ2NzSzBIL2JJNTBmTGltZFFkQVJ0aGR6ZDJhd1Q1YUVCdFEv?=
 =?utf-8?B?RUZyUkxEdU5NY1ZTbDdRY1NHa2hVVnhGbWFSbXNQRnppZGx3a3V2TWtCSEY1?=
 =?utf-8?B?K3dIQWhVanB3M3JRMzBVQVloOEtDbXdWbit1S25PUE9ZZVFoY0FxTHNrM0hk?=
 =?utf-8?B?eHkrVkJDR0xQV1d1NjBEWDd0Y1ljUy90Qk5IMWRqQWZiRjJuNTBTd205bGxq?=
 =?utf-8?B?cHZYUS8xdDZnQ3YyVnRPeVpWclBJeG9vdmtkazRkaWUvQzlFamFGVXNrMGtn?=
 =?utf-8?B?dURBVmJlTHhvVVpycGtLYUwxNlBuWFpCemh1Um91VG93TzZSR1VoeFhPTVFD?=
 =?utf-8?B?aWRLSXVuOHBqT0h5SkZmd3lHOVRnNWpVQ2ZwU0Y1VFcwQ2VVUHhwUWZQS09u?=
 =?utf-8?B?UFZHeGxNb25rMXB6dGloSHl0bmZZZVgvc29XQWlYT0ZZTS94UUkxK3dsVHBy?=
 =?utf-8?B?QWJnenNlMVpsenZLTzhIeVNaeUJsY0YxSEtqMWoreFloZ2tqYjZGVjc2b2hX?=
 =?utf-8?B?eUk3Z0xRWElnQWM4Nml4RGFBY0t3UFRwbDlvMU5aeXNqSjRiRWRMVmdVZ2RN?=
 =?utf-8?B?cUxqcTc4L1Mrbyt5WHhiQmFGY0lTckh2NVdvcCtiTnY4L2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3lDNzhOSmNQOHZ2VWIzenhBaFlGSDBIazNTVWRpQmlWWE0xeDA2YVhUZjZY?=
 =?utf-8?B?aVlNZVBsNW15NkhnUUZjZVM1MzhITThxWm9aaE1QODBkS0kxNEh3aWFoWlh6?=
 =?utf-8?B?dEJENnZEMG84YnBWUXVXNTVuQVlkQ29HdVcwdHptdjlBbjVveWdYcm1mVEhI?=
 =?utf-8?B?eGZzaGV4S1MxNmM2dU5VRGZpQ1AzTG1tUDZhNi9hekdEM0xxUFlVcDVCMTgr?=
 =?utf-8?B?MFRzUE5KMXVjUHV2dFBtbEUyTTBtWk4xTUtCWHdKSFRYUFVQcnRGYXlTem5S?=
 =?utf-8?B?M0EwNVNRSkJPZysyc09udkFveFNBaUNIOEJqemh1TUZuWGNPLzVZOE1TZFZJ?=
 =?utf-8?B?VjhkSXZ1VlJlaU9BZmRJYTJ5OXJIUzVkVm9NUXpDY2xYYk43SldnRnlWUDVF?=
 =?utf-8?B?T1ZZWlc5cm5UcFNxUnR3STg2b0F0TlYrbVlvaFQrRjczaWpTTlVuQm83N2JK?=
 =?utf-8?B?YkJSMnJrb3FWakpyU1ZBellrNlZGaWU4dDZIcEZWQ2U4elZseFl2UzkrQ0wy?=
 =?utf-8?B?Ky9hRWVhakhGd0dyVngvNTBZZVBWMnM5blA3eGdVdWJtUnlkMDEvRTlQbk5M?=
 =?utf-8?B?QUVKdk0xNlM5NjJDRWMyY3YwOWlsY2prUTZFTDk1ZE9FVE1vWlBUSGh1clZL?=
 =?utf-8?B?YzY1R044RkthVzFJYmNOU1haendUR1NBOGxkMFlINjBJdktsSEE3dVQxRnZ5?=
 =?utf-8?B?dEhpeG9abEExVE5PVkMwek9UZkErbkFhRHZ1dkxYMFlReDkvUVREMEpKTWRD?=
 =?utf-8?B?MDZ6cUc2b1M1SXRDdENnK3htM2hrdWh2ZGIycC8yRjF2d1JRZndnaUpKeXdN?=
 =?utf-8?B?U2lUdEt1YmIyeGl3RjlIN2hxRE40ZmMvVUtyTHdrSEFyWWpUZmwxbGVmKzR3?=
 =?utf-8?B?MGJGMkdqTVI1UGl0bVVVU01SQ2U2Q1JUS3Z4MmVSWFpMV3NSVjhrV2s1d2pr?=
 =?utf-8?B?MklWTksxdkpsbC9SY29yeG1zRVpKTCthczhQanEvMHpxanhSWGN0MXZBQmRt?=
 =?utf-8?B?MXE5bHNnS3prSnlTMm9EazdWZmQ4RVFkMXB0QkJoNTFyTHl2bkVXb2NnQlJp?=
 =?utf-8?B?RDM2NGppNytpc2wwWnRia3FRbVF6TXpKYmFiUUJWeXpCL2NSV2RUc0FVTVRU?=
 =?utf-8?B?YXV3OWx3TVQ5dzNNdzVidWtTMHRBRGl2d1hYUkRydDFYdmdlTUdmOEQ1OG9E?=
 =?utf-8?B?UVZZbVVrVGVrUzJUeEUrVzhxWFphYXRRekg4ZU9ybEp1VjEwcjNnSWJCN2Rn?=
 =?utf-8?B?NXg1Z2FZT1QwRHdtbno0bXJOeFFqR0VTTFRoUTA2Q0c2TVROM2pzbG1lQ1J3?=
 =?utf-8?B?dTBsNW9lVVF1b3RsU2FXNGlxSmx0K290TWZtNjIzdHFSMkd3MUNXMEFhNVRy?=
 =?utf-8?B?NkdlY3JJYzZCeUZuKzVocm5Vc3hCU2o3K0N3TUNTYldld3hIVHBaWlNwb21u?=
 =?utf-8?B?ZXd6YmxIUVRKOXFDVHBMWFhZRDA0Q0JsVEZvNFdqU2tvb29ZbCtrRW1XeHhC?=
 =?utf-8?B?UVVZWkloOXdDS0VqeHRUcTRLL0JEMmk5bzYvbzM1d2x3dkJQSUNZWWpGcGh0?=
 =?utf-8?B?K0h4eWduaFUrdDVreTEvYndwN25MbWlzQkVnZERMVm9VbWZNTEZtMzZxY1FY?=
 =?utf-8?B?SjNzWHFmUFNvS0dRcEV5cUJMUFNHVzlEWkU1WlB4MVdHL0ZzS2hDVWFzaFkz?=
 =?utf-8?B?ZWdETktUY3FIRng5SmdyWEhjaWptd05EeUhwa2RQRXpYNTluQm4vS1pFZ2VV?=
 =?utf-8?B?VFYza1dWSDE2b1BTU3N4a0dlbU1hSDhMb1E5QkEzbDZVOUZvN1Vob0M2dDB0?=
 =?utf-8?B?QkFlQUJaTSt1U2tncDFEbHFpT2NqdEtpSHp1S1B6c3ZuOS8vaDJYZm10azJ0?=
 =?utf-8?B?OE90M3ZFSkNGajZMVFQwd1B6Y2lCc1FmMVJnMWRDclNiTDc2NjJxdDV6MEVJ?=
 =?utf-8?B?cnQvM1RMSWpSZFVUWU9yMnl4RllObTFESGMxQzdXaklZK2lWM1VaWldEVnZ3?=
 =?utf-8?B?alZiZlBkb3VXQ3NCNlo2b0w0a2Q4YXdmUmdzOGg1MHdPY09Lb3JiMDA4Z2Fm?=
 =?utf-8?B?eG81SlVHZGhjR1NBaEFvOGhZQVVCVC9iVXRyTmRRMXB2WWlYZ1o3cTlxOUVS?=
 =?utf-8?Q?4m/EL4Y2AEIB0miCN6rhxzJ8V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa62eda-501b-49da-6c43-08dcbcb10c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 22:32:57.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfMh6HB8yMW9MI1S+6IZpWkkiyG+Uyygx4Fy7o3t5yJElEAq+WOiueA8n6agl8af80SoxY2NuRcdSXmTjvSkpnv8wqzB8Kh2K/AQ5BOnBb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963

PiBPbiAxNC8wOC8yMDI0IDAxOjA5LCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiA+PiBPbiAxMC8wOC8yMDI0IDAxOjM4LCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiA+Pj4gRnJvbTogVHJpc3RyYW0gSGEgPHRyaXN0cmFtLmhhQG1pY3JvY2hpcC5jb20+DQo+
ID4+Pg0KPiA+Pj4gVGhlIFNHTUlJIG1vZHVsZSBvZiBLU1o5NDc3IHN3aXRjaCBjYW4gYmUgc2V0
dXAgaW4gMyB3YXlzOiAwIGZvciBkaXJlY3QNCj4gPj4+IGNvbm5lY3QsIDEgZm9yIDEwMDBCYXNl
VCBTRlAsIGFuZCAyIGZvciAxMC8xMDAvMTAwMCBTRlAuDQo+ID4+DQo+ID4+IEJpbmRpbmcgc2hv
dWxkIHNheSBpdCwgbm90IGNvbW1pdCBtc2cuIEJ1dCBhcmVuJ3QgeW91IGR1cGxpY2F0aW5nDQo+
ID4+IHNvbWV0aGluZyBsaWtlIHBoeS1jb25uZWN0aW9uLXR5cGU/DQo+ID4NCj4gPiBUaGUgc2dt
aWktbW9kZSBwYXJhbWV0ZXIgaXMganVzdCB1c2VkIGludGVybmFsbHkuICBJIGFtIG5vdCBzdXJl
IHVzaW5nDQo+IA0KPiBUaGlzIGRvZXMgbm90IG1hdHRlci4NCj4gDQo+ID4gcGh5LWNvbm5lY3Rp
b24tdHlwZSBvciBwaHktbW9kZSBpcyBhcHByb3ByaWF0ZS4NCj4gDQo+IERlcGVuZHMgb24gd2hh
dCB0aGlzIHByb3BlcnR5IGV4cHJlc3NlZCBpbiB0ZXJtcyBvZiBoYXJkd2FyZS4gTG9va3MgbGlr
ZQ0KPiB5b3Ugd2FudCB0byBzYXkgd2hpY2ggU0dNSUkgbW9kZSBpcyBiZWluZyB1c2VkPw0KDQpU
aGUgZHJpdmVyIGNhbiBkZXRlY3Qgd2hldGhlciAxMC8xMDAvMTAwMEJhc2UtVCBjb3BwZXIgU0ZQ
IGlzIGJlaW5nDQp1c2VkLiAgU28gdGhlIG1haW4gcHVycG9zZSBvZiB0aGlzIGRldmljZSB0cmVl
IHBhcmFtZXRlciBpcyB0byBpbmRpY2F0ZQ0KdGhlIFNHTUlJIG1vZHVsZSBpcyBkaXJlY3RseSBj
b25uZWN0ZWQgdG8gYW5vdGhlciBvbmUgd2l0aG91dCB1c2luZyBhbnkNClNGUC4gIFRoaXMgaXMg
YSB2ZXJ5IHJhcmUgY2FzZS4gIEluIHN1Y2ggY2FzZSB0aGUgZGV2aWNlIHRyZWUgcGFyYW1ldGVy
DQpjYW4gYmUgY2hhbmdlZCB0byBhIGZsYWcgdG8ganVzdCBpbmRpY2F0ZSBTRlAgaXMgbm90IHVz
ZWQuDQoNCg==

