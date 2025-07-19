Return-Path: <netdev+bounces-208323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A12DB0AF52
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 12:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7911DAA1841
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1322B595;
	Sat, 19 Jul 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRBSJGZY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE72192EA
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920606; cv=fail; b=nYwNklW9svdjiaWO5G5ezq/OU2DNcLzbGpnZEDulGmnd+jhK8lU08p7FXQ7EJIWKxeG7nhSeY/gg6oTl4hSjYDtooQBFHsZyRoQ1CgDPnNSHXwS3T+9sMngAXUaI0LcJN5tQfr2mAEWgwvS0kQX2zjllK2y7EuuCYOGf/VOkcTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920606; c=relaxed/simple;
	bh=v9RpGZ9fYugbi/MKIazlQNUgRpZIukUXj5j/DdkGE9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC3GxDZm8PXbk93+UAH653PjHez1b4gXl2elFW8WJUkJNy+HlYtCJ8+Za0HLPEHF1FuECfsJiTIq0hH+qhL0NFZK3h57VTiFco8XJDpBr0JbQZRhgJGcZw2M7rxlcTF1O1vAnDoWadCbVxDsUv2wWVLxUoYoahQ2JzodbRj8NVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bRBSJGZY; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9o/L9bkzzxrhWxEhFQ2qdl8SZaU1Vee8/f+Bn9BWCPfLJmLHVyNyVXV+hK4Tln6rmzadAmAU6PsVXlvAA+CZ7U3pS6tbul3kwbqZdsGaLstre8+xxGeIRxa1bAJg9TjFtj1mNzqg8doJ+WEOVDV+yLKenqctnUfpGlVPPlTamujtPTmGBClt4XgpbXAh96UmVdseN79zZnZ9wOgvDN+FjlhPFHwaMuO2DsOFM6eCSk+KYYIoj15/2MK8YrPo7echDFCPfA3PJuC2PkE47Y26Kds/ZyjgSMaGRFQVCJVrPdA0zFi1oPK0ag3mjlMMQ3t6p7YCKEEdw+JHVLiSlx0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9RpGZ9fYugbi/MKIazlQNUgRpZIukUXj5j/DdkGE9k=;
 b=NAYOLxmWTJrHJr3Y2OXU4wSxG4D8U9gg+nWbbL5iyMa+IyvVnNCF65APKu1ptW0oB1lmlYs38noJciBTFDqsRpmbvPyp3aZfHjPwnefpwbaluTABaQDQZDACbWVnE5+0YhBEZ/BuxQFfTtgcjbivehRq1XnstD8xdy8zg5NDFYz6KbGef9+w5Aopu8pkm9FRUthE0kyEMest5f1owzccxDB/fvmwO16m2o1PHkvINvd6VEl5B77/p9aB7IdZhS/geITxtUPsNDJxeyYI5f7fDH4vN8FYqGJ04wpB98x/Sx+ROkCV0hvuD4itw28TGm8Nlgp0xT94T0p7USF+w9+jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9RpGZ9fYugbi/MKIazlQNUgRpZIukUXj5j/DdkGE9k=;
 b=bRBSJGZYpu6f/HHwdT4oc8qY205jzt7bef9e8HX3QB80hKB99HLPYluvH5O+wvKg7kbXTNrB0cE9OIskZeG5ZTSuFbP0a5i2zE2tEZ350eOETJ0pctYPhIjEyQxgvgvoi+0FQC2GjeZo079tdZ6CwOayDXJG8nVJIe3fDmSs9zNKWMxtUifaJ+zgfTo7G4QonS0rpdm/kh7PzP5bRGpwdwaXqzwW8uwZ2uERM3s1OuwVM3xGqVyFuwaZF6Bh3YZ6wii/oU2FEUZExSoJs9qLolUbh/4w4NkOMydlVs6DJE1QBPe4lw4C2SbjR3++bhe6VVaXGedsvopHFZwCSRIU9w==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sat, 19 Jul
 2025 10:23:21 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Sat, 19 Jul 2025
 10:23:21 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: Sleeping in atomic context with VLAN and netdev instance lock
 drivers
Thread-Topic: Sleeping in atomic context with VLAN and netdev instance lock
 drivers
Thread-Index: AQHb9ZnO+kjhBdD8ckK42p/bZlc01LQzVoAAgAXsmAA=
Date: Sat, 19 Jul 2025 10:23:21 +0000
Message-ID: <d7555a08d9c44ab89161c400119b3edf28043a74.camel@nvidia.com>
References: <2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com>
	 <aHZ54sAfzIe0rmCd@mini-arch>
In-Reply-To: <aHZ54sAfzIe0rmCd@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CY1PR12MB9558:EE_
x-ms-office365-filtering-correlation-id: a2f9e3b7-b7b2-40f5-dcdc-08ddc6ae492b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emFvZE1lcHg3cmVwMVV5emlaL2ZmUnVta2F0WEoya1dYM0M0c3VxdG02RlVB?=
 =?utf-8?B?ZjdFWFRVWUY3ZUI2Rm1KcHpSSC9IMFp4bGxRUnF5UDFNV0IvNU1QV2tvV01Z?=
 =?utf-8?B?U1NHMG1hM3lPaG9xbXJMc04ra3JIQ1lZcm5QSkdSSEhjc2JHTEFiRlV2Q21p?=
 =?utf-8?B?M2JESlBLQ2o2c2I5bS9veGFMdmlGN0JrMDhqVUh4dlFRLzQ2SUZleE9KUkZD?=
 =?utf-8?B?cTk4VldNOXpZTXVsNXEvbTBhNk8rOHA4cStBSkY3Ymo5TnFGajJ0NE1DQWc3?=
 =?utf-8?B?cGFJbVVoRFNGdFRGb04rUkJuNDhtdW14cFRjNklnNnIwRis3TlJTRE15MkFB?=
 =?utf-8?B?NU9HQmNuS2VsTkJoQUZlTU5VZEhrZU9LclFIOEthMUlwY0p2ZDFJY3d1TUVz?=
 =?utf-8?B?cmxGbDdFUEg1WGdRN0tzYmZHSUdaNitxeEt3QlBybjRPSGFRb3F5bUtKZlE5?=
 =?utf-8?B?cmhNTFJielRCT0o2cG5vN29Qazc2UXVZRFl1TUpGamQ1c2U4aUU2eDZPcmQx?=
 =?utf-8?B?NVAyVmx0aXdiZTllZ0FvYmlvbzE2Ny84bVJnNytqZkliemdLYzFsMEk5TVFs?=
 =?utf-8?B?Tms4ZHJBb3pQY3U3T3J6ZUdONCtDVTV1QjJPNkNXKzU1cktpOVFUQm9DMDZI?=
 =?utf-8?B?d1I5Ti9pY1RQcVJBOG5WK0doanE1MThLZ2Y5ZUxhdERzVWdOelRpRVpWdG5a?=
 =?utf-8?B?dVFTUnJCQXFJSzIwTmF3UXkzSGVlM0tHRUxDd2V5UjRodytmRmdLdnRqWkdI?=
 =?utf-8?B?eTRMZlhzaW1UTEdyb2ZSbGdCRkNka1dPK2Nnbm9jdDU4KzlEUWN6MkpOaWN6?=
 =?utf-8?B?QWQwS0Vtb1BqOS80VC82MVNLb2VmR0RvTkJUSXpRaDJGTHFDM3FtUnVmKzZu?=
 =?utf-8?B?T2t6bUVzdW16OUt5Qk9mbGxtTUxWd0JKeFNTMTRxR2UyanFVSlZscDd0ZEhi?=
 =?utf-8?B?N1U1WXh6QUp1VDhMRXEvZTFTVENaSVpMZmU1TmN0TTg1MTJyVzhLMXlCbmFN?=
 =?utf-8?B?bnZhWlRkV3BuOGp6ZE9NSUVldDJYQkRaeHVwYlFpWnhQRWQ3UWc1UFZZVWNB?=
 =?utf-8?B?SXBjTlkwTnZTVSttMHVzUlRCd1VZS2Y2ZzBOWUlSaXl1TUZGMXlhSjhBVW0x?=
 =?utf-8?B?VDFxZHJsN0xuVmIySkxRK0NsdTFSS0h2UlYwMlV0dE9JcVlSSERReVB3UE9u?=
 =?utf-8?B?cC83eG9ZWEVyWFlpOEF0ZEQ1d214dGp5NlgzYktuWWN0UzYyS0tHTE0zTzBP?=
 =?utf-8?B?V3NqU2JXeVgvQnBtTW5yL2ExYjdvQVpYZndJc0pwakdhdzQzb2hkS2c3eTNr?=
 =?utf-8?B?VGo3MjZBZWcxSnU3TEUyWXJXNWxwOVpld3VkRlZxRXFnUkRKNWJRQnBnS0l1?=
 =?utf-8?B?eW5yV2tDckIyQkM1SDhPSFhwUXFsQWxyVFprWTd2alB5SW5FZDVoV0ExUnV5?=
 =?utf-8?B?T1FIb2srQlpxbXFMeGJtUjRiR0hiWDVsQXNPSTJCcUg0U2hBOVkrRG5HWHVZ?=
 =?utf-8?B?cythTTVLTWRZemZYZWZuNXZ6ai8rVXVFbU80amptTElvajJUTXVYcmxJOSto?=
 =?utf-8?B?Y3EvZ3FSbm8vR2dMYWRFMTJ1REVqQzZ5STVWd1NIZ0dsY3JNdWhPK1FTalQ2?=
 =?utf-8?B?ckZac3luK1FENElEVkkyMDZXd2ZweEdQak9FbHVBSVd5VFlQSjlZdC82K3Iw?=
 =?utf-8?B?dmtOYUlyT1JiYjJTSTdKaWxQVkpPLzJpSDlJSzBWbW5YVEx1UXFYSmc4V3Vu?=
 =?utf-8?B?dWc3elkxZGNxem0wbkVab0c1WFBaWHlxRjZqWldySWRwSllUeS9kVjJVRUc3?=
 =?utf-8?B?QWhodGJIN0tzSzYwM2Q1cDJJMU9sQ3NxdEFmUkQyWldxd09xUkl2N1cxQ0c0?=
 =?utf-8?B?elRCK29POWJGMS9qOEpSWWR6RVZwOVFsYlhsaS9UKzBjR0lSQXMwUzJCcE04?=
 =?utf-8?B?Vlc3aUdRZTIyWXJ6VlhXTzFtSkc1eW9TeUxhYklTY0JQTHM1cGxFWW92SFBM?=
 =?utf-8?Q?fYZp8tkscTVgoDn+7dev5IFOlZqMX0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXVoU2htOUxzQmxvdC9KbVRMcElIOGM0WUZ0bVQ2NkIyYlFwOTJYa0paNm1I?=
 =?utf-8?B?S3g3SUI3VlZqVTFwTzQxTUdiVldhK0JtaGFTUzYzejFkYVdUU0xyaStKY29N?=
 =?utf-8?B?c1dFLzlLK3cySXBMTzIyNFJscHJ4ZjV3cy8vRWVLZXBkRE12Y3kxbEF4ZWRt?=
 =?utf-8?B?OTJ4MTBjSjNtcTgvU0QrOUNMOEdmZzArVjUxcWdUOTlTV3Q0MWNnUDhCNVUz?=
 =?utf-8?B?QzE3aWFkYXBVN3hqVmhvVkhxUVY3NHRmNTAyNmJmUG5ERk5WRXlIZUhrTWFv?=
 =?utf-8?B?MUVwSGc4Zmx4VGsxU1U1ZVNuWUxURUMxZnErRk84WmR5NDgra3p1ajJRVjA2?=
 =?utf-8?B?RkZMcGJKOGREdzVvclRHRTFFYzUzWjZUYUc0YlBiM1luMmJkZHNxangrK0Rs?=
 =?utf-8?B?TG1uQ0tCczljWSthSzZUWjdhaXlUZWxXaDZQR1ZFWGpkeGVOd3VSUlczaURD?=
 =?utf-8?B?NGRnRG1XRVpWREVHNTJMUXNPOHh2N2dCcmRheld2LzVla1dqUXRZS2ZndkNj?=
 =?utf-8?B?Mml3VDAwVVVBemVaVTZoQ1dsS1ZXVGhPWnhxQmhiOU5WNVU5elc2U2Vna0N5?=
 =?utf-8?B?bjZoRjF4WTRLVW91Z2hwRDllcXE1Q2pZK3FMazk2STVybjRta2M3b1cyMEpV?=
 =?utf-8?B?WWRNazg1bUtnQUl2K0dHUlJrUzczdjRhWXdNaUliTTVKSVB1NGJ3c2JJaXpP?=
 =?utf-8?B?TEF5RUtRSytUZXBpZ2Zidm1KZlBVNjhHR21pMzQ5WXRvaW9DYXNDaGVrWDV1?=
 =?utf-8?B?TElMN1pKTlJmNVYwSVJLMVVOUjUvNGpQVEhLdTZWaTl6VUw5OHM0NUphT0py?=
 =?utf-8?B?SmNyZE5XWDhvcEJEbFVCaU1TSHZkZmpQK3p6MElubkZHQmhBT2Nmam12d1Jh?=
 =?utf-8?B?TGdSQmQzQTZPUnVlL3BXYVFvSWFiQlNGQUxSZ1NOejA5ZU1nekp5MGhwaS9W?=
 =?utf-8?B?NWxzMTlwa0dpeWF4N3FPN1pkOStmcEp2WnMzakhpb2gzeFg1cWNhR05YWmEw?=
 =?utf-8?B?TWtVTWliejdmelU1UXNsZUVFb3oyUzk1cWRqUFNENit1dU85QUs2L20zNmhm?=
 =?utf-8?B?QWN0RUZoNGJ1a2lGUWNBcU9ITHV2V3NrVUJJZzhJcEtwYmZ4VVRmakd1Y0hp?=
 =?utf-8?B?TXpxNEpKUkQ4SHpsNlFyQmRPa1BET29NZzNJaFdLeTVyV05tSW5aa04vYXd3?=
 =?utf-8?B?OUZWRUdwWCtSZzRTdmQ4VTR2RkwySDVIYmRycFlpRWNaZzZjTXJVaGIyZEZr?=
 =?utf-8?B?QldXYTFoR1o2WkFkQ3haQitxWWxHTlh4RnN4QTF0eTVUWk1iOG5XeDRGbGNl?=
 =?utf-8?B?MWwwdGxOT09SNStoYUhXQ3IreklseGtSb3FMQXoxNEphYUZQcTZuOGNjc2s0?=
 =?utf-8?B?MGtBZ1lRcEEzQWU5THZUeHJ2RnhMSEZKNTdFajdudldNcDZET2RZdUJQZ1cr?=
 =?utf-8?B?THR1dlVFZCtreU1Oc2VKczZxZVA0TnN2L1FlUC9NT3ZoRERqbEg1aHdjTU1X?=
 =?utf-8?B?bmg0NFlLVjd6UkJLQXQyVnlISGdPWlhqOUdkRTd2QWkrSHN4dXZ4bTkxbUR2?=
 =?utf-8?B?QlRsTUcrSDBCVDRHd0VpMG9tN0Q0VXhTd0JoeG1SLzJ0S2lFbkRFYnFPeFpo?=
 =?utf-8?B?ZjQzRjJycm05UzBkUEhVL1NqTGM2TW9IYTAxRWJEWlhSSTRwdmlrU0h1bEdV?=
 =?utf-8?B?WUxQOC9XS2M0YmtVL1pjTnlkbzQ4dFQrM3QzZmhWNkVrQnJaQytoTExBR2d0?=
 =?utf-8?B?NW9ETWJMN2tGcFJSQ2pUbGM2VXFjaWxTamVSZUZrbTd3OEZFUkVRSUgvWnBV?=
 =?utf-8?B?ZzZ4UFZlSStOcWtvelVpVS9WaGlWaHBxZkxTazUvTkdvaGF4L0RUWVFUOGhj?=
 =?utf-8?B?VHdaUTY3OGNMaVYyNFI1Vkd5OW04cUk1d1JUeDlQdnloNlc2ZWhSSVFsbEdQ?=
 =?utf-8?B?VEFaOG02WnJWYXBNVmw0VllkSVFqWC9LR0FGZHdIY0I4QlNJR1ZRT3JKcDVv?=
 =?utf-8?B?WSsxME9RS1Y1NWFwUm9FdFIzU2NRZGg1L211MVRCbDFCNmI4d0sxMG84RXY0?=
 =?utf-8?B?UnIxTnFiMGZJa3FzcnFWbHpoTEEvUWh5ZnFYRFFkazZDUDRQcWdMY3IrN1VE?=
 =?utf-8?Q?Z5rKMhEQh5d5kt9c3zqYnYrjO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06CFA7C8CB650947979006422D47EC86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f9e3b7-b7b2-40f5-dcdc-08ddc6ae492b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2025 10:23:21.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkECBKCaQKHLbpARC+GtQvEX8bOb5caYJ7N17Lsp1Z8QOczDKlojgqNsJzALoVu0SY5oVFm6gHRNPPHFw4f0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558

T24gVHVlLCAyMDI1LTA3LTE1IGF0IDA4OjU1IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXBvcnQsIEkgd2FzIGxvb2tpbmcgYXQgc2ltaWxh
ciBpc3N1ZSBpbiBbMF0gYW5kIGZvcg0KPiBtYWNzZWMgSSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhl
IGZvbGxvd2luZzoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9tYWNzZWMuYyBiL2Ry
aXZlcnMvbmV0L21hY3NlYy5jDQo+IGluZGV4IDdlZGJlNzZiNTQ1NS4uNGM3NWQxZmVhNTUyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9tYWNzZWMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9t
YWNzZWMuYw0KPiBAQCAtMzg2OCw3ICszODY4LDcgQEAgc3RhdGljIHZvaWQgbWFjc2VjX3NldHVw
KHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpkZXYpDQo+IMKgCWV0aGVyX3NldHVwKGRldik7DQo+IMKg
CWRldi0+bWluX210dSA9IDA7DQo+IMKgCWRldi0+bWF4X210dSA9IEVUSF9NQVhfTVRVOw0KPiAt
CWRldi0+cHJpdl9mbGFncyB8PSBJRkZfTk9fUVVFVUU7DQo+ICsJZGV2LT5wcml2X2ZsYWdzIHw9
IElGRl9OT19RVUVVRSB8IElGRl9VTklDQVNUX0ZMVDsNCj4gwqAJZGV2LT5uZXRkZXZfb3BzID0g
Jm1hY3NlY19uZXRkZXZfb3BzOw0KPiDCoAlkZXYtPm5lZWRzX2ZyZWVfbmV0ZGV2ID0gdHJ1ZTsN
Cj4gwqAJZGV2LT5wcml2X2Rlc3RydWN0b3IgPSBtYWNzZWNfZnJlZV9uZXRkZXY7DQo+IA0KPiBt
YWNzZWMgaGFzIGFuIG5kb19zZXRfcnhfbW9kZSBoYW5kbGVyIHRoYXQgcHJvcGFnYXRlcyB0aGUg
dWMgbGlzdCBzbw0KPiBub3Qgc3VyZSB3aHkgaXQgbGFja3MgSUZGX1VOSUNBU1RfRkxULg0KPiAN
Cj4gVGhpcyBpcyBub3QgYSBzeXN0ZW1pYyBmaXgsIGJ1dCBJIGd1ZXNzIHdpdGggdGhlIGxpbWl0
ZWQgbnVtYmVyIG9mDQo+IHN0YWNraW5nIGRldmljZXMsIHRoYXQgc2hvdWxkIGRvPyBJZiB0aGF0
IGZpeGVzIHRoZSBpc3N1ZSBmb3IgeW91LA0KPiBJIGNhbiBzZW5kIGEgcGF0Y2guLg0KPiANCj4g
MDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzY4NmQ1NWI0LjA1MGEwMjIwLjFm
ZmFiNy4wMDE0LkdBRUBnb29nbGUuY29tLw0KDQpJIHRlc3RlZCwgdGhpcyB3b3JrcywgdGhhbmsg
eW91Lg0KSSBndWVzcyBhdm9pZGluZyBuZXN0ZWQgY2FsbHMgcmVxdWlyaW5nIHRoZSBpbnN0YW5j
ZSBsb2NrIHdoaWxlIGhvbGRpbmcNCnRoZSBzcGlubG9jayBpcyBvbmUgd2F5IG9mIGF2b2lkaW5n
IHRoZSBwcm9ibGVtLiBMb29raW5nIGZvcndhcmQgdG8gdGhlDQpmaXguDQoNClRoYW5rIHlvdSwN
CkNvc21pbi4NCg==

