Return-Path: <netdev+bounces-162947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB758A28998
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFABB3A4346
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6122CBE2;
	Wed,  5 Feb 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+Ad2pGY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C522B584
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755695; cv=fail; b=p1ErnE6i5A0dm7hZrD0FSLHCAu3v9h9YxqUvSczzPEiJJYRfkdI4l+4jc5cBCnwp2TIOnvVuiEF0CggfgtDLWkx3I1BQp0aFrjR5Wwutn8KDbko+yIUwyYz1Y2rpx2E1pbImpaycuKTvPHojyh1yj3DF0lpiePRqt8BuFsEXgiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755695; c=relaxed/simple;
	bh=JDGqQfBkbxIJjFRGoTp6tw5KuOvJ4p9E5TqdZDEKGjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPtR9Vvnpx8+/Cg0tl8oC8N7zl295U0UKbGceTw6/hui43RT2h0K4ae5hCRLxn7SITK83ZKBYpBtvJaw33sg1i+ilPtqGq4gMk1q+Ml84F859eLrk5qnV0wYoe6Rh14VhwBZyaTvYAo9wIKCKgK6rpO3ioNW1gzkKCX4NZgliHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+Ad2pGY; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGz4Dmb78PQlz/I/HVp+r2QIXBSotPcG4lS9+PJ2h2gMi8fdEYLIBdMN2usBEqtPFq/I92Q/Ll9XKx2RqgS7nQtSYK0Uqzoy5aPa4TqUwrnlxwZAFhiLvq83RYX7cai0/KOAiQhd/wSsdFPoJotPs9PE6nYE5AlCJIiPLfH9gb1I5dAlYNBH5hBmGcNTaXxuFYoUkNqoJSOwNgo0ebYog5Ti+db7epCDeMnS0DC8cli87HFajNOxzV3aeX3DJWkANPnnWcbzdg8PgR/lxnZeAy5t+g+3U51GxbpRv5bbg85rotA8kbsxtM/YBM0248VXNGXwqEiQRxZ+sInNW7HVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDGqQfBkbxIJjFRGoTp6tw5KuOvJ4p9E5TqdZDEKGjA=;
 b=aWTC8AGNLeGjWWLVGpoWOy0HJ7NPE9D21Txfy+QOzjHxwoZnfKkYSbzRKBlTeqE4FVifhi8cl9iwQwHZZ7/o3pRtK1VGSA1196B7CuC/riuE8Qv60mNAYu53fb9wKQPexIWB0XqKFks/04CTGhpAG9R+BZiO9Yyw0T7KicY7dRlMkWBkT6BqRsLu6bUwbqtaWZf9iHUjMVnF/TuKuwo9LhUaxNT7d1WVhKjk1eYmEKWAPjuHsXPUuepznyNyYxEBJ1sJWMDj4HaOZEgnC7I9le7hHkDTWr1LjBtbSJp+1RcesFvextFVJx6dS41k5FQQic9XdkRQjvAU2WpCkvtx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDGqQfBkbxIJjFRGoTp6tw5KuOvJ4p9E5TqdZDEKGjA=;
 b=R+Ad2pGY4Wvp9LAKUCIYUQkd8IB1kBVnQv9vDUyAKomZmPBt9KEZwzhKvRuFZ9owjN7GHTXCc+By5RrP+bFIm+swLQoNG3rszyM4vChkTFTidJqnqlVILel9Pc5F7/G4JSWIqf1Po4AUSTHx/JMF5dBjLUrnYL1XBiNL2nbw+pkAcsLIJfswxTki7Hobb1i+okTOf6vpiDGZUkcXCCUT9PrPWitiZRc7oD/ELq1Y7XBfixpHhSWkmWssK8vAgHexlgvpi46OyQULCDbuemWxOtUuXs4806SMakABZ5whGKyF9qUoLv6FmIhkg5k/RZS9J5wKwKywPW9gq+qjxqKD/g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:41:29 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 11:41:29 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbdwpytanztMFZ5kSa6adxP+Q0lLM3/6SAgACVpYCAAAI6wA==
Date: Wed, 5 Feb 2025 11:41:29 +0000
Message-ID:
 <DM6PR12MB4516013FA5B26F8519499CDAD8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183713.5cf64e08@kernel.org> <871pwcoc43.fsf@nvidia.com>
In-Reply-To: <871pwcoc43.fsf@nvidia.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA1PR12MB7441:EE_
x-ms-office365-filtering-correlation-id: fcb3a117-aea2-4c6a-8f7d-08dd45da07d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0c3T3NvVStiZGtsTnFkS1dKWmtUMkhob3JUNXU5ckp1R3J0MmFhWFVhVkhi?=
 =?utf-8?B?VkRtQy9Ua25iNjI2alB4ZmdQMG1IVXdzWkQzTkg4bVRub2YxVFNvb1hPMDNQ?=
 =?utf-8?B?dXNpZHA4NW1pOEk4VXdiMjVOMGs1S0VVUEd0aGZhb3o4Rkh1L25oNFNUMFZW?=
 =?utf-8?B?VGRtZGMzdXVXUitQQ1ptL1VWZThqRXJUdWViUzNKaXhWSFNmQ2wzcjNqcm1X?=
 =?utf-8?B?d0p5NDR6MnBsRUNaN0U1YjgzWkFMek0rbDM4OTJMejNSblZmWnAvZGMwTUgr?=
 =?utf-8?B?RXIyQm1rWDRqQjFiMFFHeEIvNzRDd1pBNXNhS3I0YzRER2U5YWJrd3VMZWVT?=
 =?utf-8?B?N2N0VTduUEp3NnNHZEhXTW5CL3dSSTBzdTdZUm5xcTlUdyt3TC9nK2Zjamhw?=
 =?utf-8?B?UnhvTVF4cGlPWncxWmRDZy9NcHBjMmR2QlphNlRCVnZSQTBxb1haQjlHakY0?=
 =?utf-8?B?ZWJTOWZPN2lZbyttQUhHMTRyM2xOemtyY2p1WkZMVVFXYmpLbm5ibm9jR1E4?=
 =?utf-8?B?dyswTkM3ZytkSEZBT3MyOWFUWlliQzgwRmJTTVRmNk5naEkrZVlGczA2RGJ1?=
 =?utf-8?B?L3ZaUU1JYmJCbUgva0w2MUE4dVo5a1JzY01aM3JlaHFmQU1ZNjdyeDA2NzNE?=
 =?utf-8?B?WGc3b05velpJS2Q2YzM4TllWUHAvYmtDT1JqdDFCZmU4QzdmRWs2ZTZvS3l6?=
 =?utf-8?B?UG9haHJWZVV6aHljSGtEZ1RRQU9RdjluZFVRZVdhWGZUbzkwYWZSMTVoa0V4?=
 =?utf-8?B?Mm5QQnpYWTNkS29Cc1dIaG1CTWtpVktRYzkzK001eXRjR21nS3kxMWJVZ3Yr?=
 =?utf-8?B?N2NqeC9xMnY2YWRyN3JLNmdOZ2lORjBjaHVQeGhFRkxDWlI3TU1xejFiS3E1?=
 =?utf-8?B?OGdqL1FRNFJZdTRQQVVvd3pOdVh3aXF2VUMvMEd0RUZQbFlnWHJyNWRaKzB0?=
 =?utf-8?B?cFhDeDFZcEFxaUwvRFRZL2FaOUEyeHlzNlBzQ21xd2s2K2NHN3R1T2hVNWpt?=
 =?utf-8?B?aHk3azhOV2M4TE9ubGxLMEl4eFlKSlhhU3V5TUorcTNBendOeVJBQmE4OUJh?=
 =?utf-8?B?QjRRV3REaksxN2NReThtcDROV2JQb1hJaVdQYW1xTnlJQ1BXYjJXcHNHUFJM?=
 =?utf-8?B?MUlsSVF4RUVZRmQ4N1FYK3hxVUFHTDNxTjBmMHUzcUdSYjVYK0R0WVVHVDVr?=
 =?utf-8?B?RTZYUHJBYzd4SVZPd2tacW5nMllkcDZtUTlvZmVoeXEyTmo1bkR4TTd0TG4z?=
 =?utf-8?B?NDNjck5LMzB4akRqdU5iT0tQWHE0M0ZFMm5iQU0xb3VoRDlaSnV5eWIvQUpY?=
 =?utf-8?B?RTJXWkRnT1JVUWorWElNNmV5UDRvWXFQZ29MUUk2LzNQcGYrdENoUUs1Qkxv?=
 =?utf-8?B?WloxeWltZDJ2bkxNdG9QTDl4WnBsdXBTbzRocEJYTGRZcXI2UEdRS1BYSklX?=
 =?utf-8?B?RXJ1Z25nUjVuWGx2a2QwTEtWUkpwVWcvRjQxVVNQVVZKNFZzWEsrVUhQcWVw?=
 =?utf-8?B?b1lhU2NMcU5kaU9RYldiMlNvRVdZR2VQTTJWV1g3SldpYWs4UjZ5ODVlOUs5?=
 =?utf-8?B?TlBZVmJFd3FzbENuU3IzMCtBeldNNk9DSGU1UXBjdXZtU25iNU1JT0FPQ0VN?=
 =?utf-8?B?UmxYbEdZa3czdU14UFhtbVpkU3ZPTGRxcG1HT1BxdXo1MllnNUR0bGk4aUh5?=
 =?utf-8?B?VXNobHFUVVYydkdnVzVUdjZ4RVIzd090ZUExWUVEWlVNU0ZxUU1Eb0lDOE1L?=
 =?utf-8?B?aitHMUVOM0IrZ3VKM2pnd1EzZVNaYklacENvb0ttZmRBcHM5QmpxRU5NbW5t?=
 =?utf-8?B?cDhwc1prZGYwM2szQVNSSlMrVXlvcUx1SmlXa1R1U0plcXViZ0JuTlJ0OUZn?=
 =?utf-8?B?clNRc2JRRzVLOFZYcWRWUnplZkhOM0dMa0MvblQ5NWlEeEZWUUh1a2JVYXhF?=
 =?utf-8?Q?xBsWfeW4hn8+3JvHkxxyySrDAXHAACWV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjZzMFVDL1g4dXNMZjk3bFhJTUs2WWxQbGgrSjNrZ1lTU0dvRm50N3RkK3ZE?=
 =?utf-8?B?NXIyQ0tEN0ZpdjQ2NVFUMWZ5SWhaVlh5bjFVcTIySEcxOVlhNnpaVkJ0RkxW?=
 =?utf-8?B?L3VzMWxqVjV5UE4rLzNhMWVJQkZJL2lLL1dzaVdBV3crRGoxOEdsZEFzSXY5?=
 =?utf-8?B?dnNiaTBYdndBc2lmWTIyb1dyd0N3TXNtQXJVY2FOYXdPOHQxZ0dRczJ3TS9t?=
 =?utf-8?B?ZnFlMmJuQTB0T3MyQW1zQ1k5amlqeGNMM0RUMVJBcHJxQURaSnhmVXd1RTJv?=
 =?utf-8?B?TVR4T2RtL3V2R3ZkbTh3UVFUbktPbnBmY2J4amlHZkNvakN5L2I2SFpMZFBt?=
 =?utf-8?B?V3dsVjhsdGp2WTVRN0JITzBZMTEraC9EMW53SWZQdXJGN0R0WGdYTVFqWnhS?=
 =?utf-8?B?NVJCMUppMTRHZlptRGs1N1Njd1orUlo2eGZmV3c1WDhiYmtFR0phK0JCaGNC?=
 =?utf-8?B?V1g3eU9JVVk2OEdYNjcrNWhIeVJnTzZwL0dPMFROdEFVSHNwd0tPTml6ZGov?=
 =?utf-8?B?aDFrL3dwcnhScE81TFk3QUpXZWlLOUU2Vm0rb0JMUUx6ZEpDaDN2aUpuQno3?=
 =?utf-8?B?a1hnYVg4STVLbWVsZW5vbEI4eEdQalZRRWJtcFB0OWRZcmtVSW5QK2xROFNq?=
 =?utf-8?B?Wjc4S3JYWmtKRnpSb3FXWUR5WjViRFM2S0NVTFR3TVFNK3lVS3J3YStSRHht?=
 =?utf-8?B?dnkzMVVYRTlxSzFXZlM0WkZvb1hYUVFoYjN1SUpuRE55b203c0FjV1JsQ2lG?=
 =?utf-8?B?MVN2eE9GY2FCZjI3bDkwTzZyMmJlcUMvVmhPT1I3T1NJUTZuL0Z3ejZqWGYy?=
 =?utf-8?B?ZytPYVRtUjdGZTdvNE1FMFVuOUlWR3pJejY5VTlFMDBGWGRiejl1YnFjTmFm?=
 =?utf-8?B?bm5qdFptMlFNMER5WE5GcHNZd3pzYVU1ZlNSSjhlTC9lWGErMFpwS0daQms5?=
 =?utf-8?B?OUF6eWtWY2xBbktRVk1EZDdwV2xvdXI0TTFhKy9zeEtHZmIwRmVRVmtlemZo?=
 =?utf-8?B?c01DcDBRdk5ZYkdqUllYUnFpbXhDU3kwZ2NTY2EvU0UzcFFLNk0yM2hFeG5m?=
 =?utf-8?B?SExDbGtORW1aTDJ4K0pRbk9XN1R3SmgwSXdzRUtidmFwZWE5UXJQZUNlUlUz?=
 =?utf-8?B?MmNQLzZWK0tmUzhZTkN0WDZHVGxMQWNvVHNqbklzTzM0bExpY1RQWWhQTjdx?=
 =?utf-8?B?M0N6VndLUVdMRjVBeDVFcUw5MDQrNjg5a216TWNPdW04UFlaUC9JcE9mY05F?=
 =?utf-8?B?RDVyTmE5clhXRXFmdUtwNDhrcFY1RzhLcytuSWNBUFJXUmdrcHlydFFwRXJC?=
 =?utf-8?B?Q2UzajkxUTJ6SnprQ0Y2UjZqTnhjV1NmTVJ1V09rVjdMQ1BJbFlyRVNpbzdT?=
 =?utf-8?B?Tnd5MWJNNkpxSGpjaHpJZ2pyN2VTcTRiNC9UbFltWkJ2M21ocFdSZ2hBSjFs?=
 =?utf-8?B?ZWlxMzZUekJyTTRETCtuUXhuTVhoazF0ekFMWTNpY2JyeEc4d1dGK2RuZ0Uw?=
 =?utf-8?B?YUV4WGEyTWFDSzd2c0JxUXRBRWgwUGV3enVOT3pQLzBLTi9DTGR1SlVzQWhY?=
 =?utf-8?B?K0xOMlh0T2g5TVFIZ1JGWElURnd0REFCL1Vnd0ZsNUdnQy85aG5mMk1leXJY?=
 =?utf-8?B?QSt3RU1GNGNFNC9Ga3grNEp3a3NpT1FUQjJKTW8yYk1WbzZidTdlVDRBQjhL?=
 =?utf-8?B?VmlJcTFqV3VVMjNvU2xxSDVUV3VlK0ZrK0tQc0F4eWNmS21wV3BCS0tSajVG?=
 =?utf-8?B?T0ZJeFNUSlk4THhzeGlnN09FYzllSWp6TVMyWDk3U2dBWFR6S3VpSzZENktt?=
 =?utf-8?B?UGxvZkRFQnhUNVp4Y0FuaWpLZGVJRXFmdjR5b1V1YVZoNkp3K0g3NitMaDJT?=
 =?utf-8?B?SEgxa1pGZ0tQemJXb2RFRS9YcDlhTkVXZldNUlZZWm8yeWdoMi9XRldRdFRm?=
 =?utf-8?B?ejlVSVpkU2pxNkIzdVdWVndsQW9kNXpHcUZSTW84YXRCN25DSnd3MHpwTlhL?=
 =?utf-8?B?d010dzlzYUpZRmkxckhFWXI3TzRsd0VNS3A0b2dSeXNnQ0t5My9oTUZiWktC?=
 =?utf-8?B?eFhFM05ZK21FR3ZGcEVlNDJTdml2bW1qMTE3ZXJtMXJDR2Q3ME5ZUkFONW83?=
 =?utf-8?Q?s51XUfqYmuutYHCGOAiCEK+t3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb3a117-aea2-4c6a-8f7d-08dd45da07d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 11:41:29.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu4UiiKmxOeKxzqU29PSR8copsMNr5ix+aZoNHVUf2nvnDc9D58HgTCRai30I8b7oFBE+3FQRI2WyduC1LqJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

PiBGcm9tOiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgNSBGZWJydWFyeSAyMDI1IDEzOjMzDQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPg0KPiBDYzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1rdWJlY2VrQHN1c2UuY3o7IG1hdHRAdHJhdmVyc2Uu
Y29tLmF1OyBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0DQo+IENvaGVuIDxhbWNvaGVuQG52
aWRpYS5jb20+OyBOQlUtbWx4c3cgPG5idS0NCj4gbWx4c3dAZXhjaGFuZ2UubnZpZGlhLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBldGh0b29sLW5leHQgdjMgMTAvMTZdIHFzZnA6IEFkZCBK
U09OIG91dHB1dCBoYW5kbGluZw0KPiB0byAtLW1vZHVsZS1pbmZvIGluIFNGRjg2MzYgbW9kdWxl
cw0KPiANCj4gDQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4g
DQo+ID4gSSB0aGluayB0aGUgZGVzY3JpcHRpb24gZmllbGRzIG5lZWQgdG8gZWl0aGVyIGJlIGNv
bmNhdGVuYXRlZCwgb3IgYW4NCj4gPiBhcnJheS4NCj4gDQo+IFllcC4NCj4gDQo+IGh0dHBzOi8v
d3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM4MjU5I3NlY3Rpb24tNCA6DQo+IA0KPiAgICBUaGUg
bmFtZXMgd2l0aGluIGFuIG9iamVjdCBTSE9VTEQgYmUgdW5pcXVlLg0KPiANCj4gICAgQW4gb2Jq
ZWN0IHdob3NlIG5hbWVzIGFyZSBhbGwgdW5pcXVlIGlzIGludGVyb3BlcmFibGUgaW4gdGhlIHNl
bnNlDQo+ICAgIHRoYXQgYWxsIHNvZnR3YXJlIGltcGxlbWVudGF0aW9ucyByZWNlaXZpbmcgdGhh
dCBvYmplY3Qgd2lsbCBhZ3JlZSBvbg0KPiAgICB0aGUgbmFtZS12YWx1ZSBtYXBwaW5ncy4gIFdo
ZW4gdGhlIG5hbWVzIHdpdGhpbiBhbiBvYmplY3QgYXJlIG5vdA0KPiAgICB1bmlxdWUsIHRoZSBi
ZWhhdmlvciBvZiBzb2Z0d2FyZSB0aGF0IHJlY2VpdmVzIHN1Y2ggYW4gb2JqZWN0IGlzDQo+ICAg
IHVucHJlZGljdGFibGUuICBNYW55IGltcGxlbWVudGF0aW9ucyByZXBvcnQgdGhlIGxhc3QgbmFt
ZS92YWx1ZSBwYWlyDQo+ICAgIG9ubHkuICBPdGhlciBpbXBsZW1lbnRhdGlvbnMgcmVwb3J0IGFu
IGVycm9yIG9yIGZhaWwgdG8gcGFyc2UgdGhlDQo+ICAgIG9iamVjdCwgYW5kIHNvbWUgaW1wbGVt
ZW50YXRpb25zIHJlcG9ydCBhbGwgb2YgdGhlIG5hbWUvdmFsdWUgcGFpcnMsDQo+ICAgIGluY2x1
ZGluZyBkdXBsaWNhdGVzLg0KDQpPSywgd2lsbCBmaXguDQo=

