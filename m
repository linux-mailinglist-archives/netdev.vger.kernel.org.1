Return-Path: <netdev+bounces-177110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236EDA6DF1C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB3016CD4F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68B26138C;
	Mon, 24 Mar 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7JB3/ea"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2225F982
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831771; cv=fail; b=HBhIkgpYTipRWO1eendWwBoZTsOhNeXOB2Z6EAtSw9856Sk9TkZk9QicGIPW8aC/dkvfoYBjHnfdDVu0MKDPmEPqOwBmyW7KKkcPHwOizAx6CgXkX4f3Ormx4S/onMBh5xh1sitBQtvITVZg5UfJzJvtThwv23Xo44WuB10OY7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831771; c=relaxed/simple;
	bh=1eOrxGAUfrwmFy+lOOrK4gpf8naqcvfoG2WM9pr9wNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GijqDcbSkYTK9P+dMhf4nAkrrLX96gg1tU8s34mroiiRoEbvTbDmAOllJ0amC0uimlKb8A+otRCh0J03phJu+r3xlFnRr3FSIQjyye1Ca/IGrC4bnPTP8Sh9RAKiOvKpiyumKzqTQ4rRfCprXGuEh9JTg4DZOBJh2JjiYz0EuvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7JB3/ea; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+dm08x/Ja6D4yzGz1J4Iqcr9xEv5BsiNIsmufKhvU+9xt2Dc6LgzBUkTILsWlwTW9FTjAlHmgd0QUgqr8H42ndJphRkcONShbgLl+fm6ah526UVbvx7Ko4fAXQ9X77Te2V8WhoqkCk7VkbS7Rss7zQr1fxOHwXrVlxLK+PxUH1Bf3fsGysyY6zN3+3Eb5FI/8mDhGQ4TjKsbc/0jINlQL/e280dd8jsv6KsiNeVWdFaGapGDNssFMyRHJitCDBcIGEhaPNjgwGQlueF7Le8HO7Ot0G/nl6UIGpO/rhKSxgbuZg0XyTfoUrmcN67FUJSLbyT4DeWmQnA4L/ReSAtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eOrxGAUfrwmFy+lOOrK4gpf8naqcvfoG2WM9pr9wNg=;
 b=m3ZqzbX1diiSqnPQALhWPtKSLRc+BbnL7oQnzUQhbCC9QiHr0zPw3uF//v1Gj/ilQ/v23gBzb8lkQtlpfX7kpmLFOasWYiwOLHixb7buYAVu2YM1JLqBmfOY3L/GKGl8GstECRt9uUF0diH+AXwSqStoWsx4/IvSyxZqYxfKr2JepplcOMiwM5WLnoFFmh7TeSF1eh7p2q3Brujy56g9UuOadO7KelsDYpwY/2pZtGmaw6ptDM16iI1PrRbFm1qCT9km9mmKHAXklTLHiFE5yVxARigOo8zLb6iznYgMpHtrIF3rQlNDwfUsAfBMz/A0J4KlSyWAHdxP3NvCQ7ibSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eOrxGAUfrwmFy+lOOrK4gpf8naqcvfoG2WM9pr9wNg=;
 b=Z7JB3/eaZpSk/nQ5bl7hBKthH4LAg0XI2BBN5PWU3/XZYtOxtQ3Sd6Gavft5Mq7Uvf8nq5gLSWGuxMPtJCl7lBtn3/9UUz6plO0DVPafbimKGdQorgv4GW8tU5YlQkhabT2jC6JJ0omN3WP5Ddd5FmJW3VXpD+sMpX20hWlPmYK439zKZqpHwRNEzOuOjvOlR4YMB/zgOsEE/wpPMvepvsXeuHiqGUUZfn703XaV3UeDlymsvgLK4nVuwB9udUSCSzmFJQNZctxqRG4kNHYXHFwogVgPmCeAe93C8lSwusREB+DQS1U6X6VGjrMQ377YuFS/yf4FU4hYy4ugpKiCPA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 15:56:07 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:56:07 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "saeed@kernel.org" <saeed@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Topic: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Index: AQHbje0W2l3ubLQ/uUepzvoMt3824rOCiKAAgAAGBYA=
Date: Mon, 24 Mar 2025 15:56:06 +0000
Message-ID: <be3bddb21160f36478744fc8dc10bc1b3d5816b5.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	 <20250305163732.2766420-9-sdf@fomichev.me>
	 <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
In-Reply-To: <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN0PR12MB6077:EE_
x-ms-office365-filtering-correlation-id: 51811cb5-848a-404d-113c-08dd6aec6371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFh5bEtpT1dqeW8zSHJncTFxRTQrTHlrQWk0R3JYd2tISFhKanBrM1FMZHU0?=
 =?utf-8?B?WlZWYzEybzNLeDF5dUJ2R0V5K1A4YThwYjhNTk9nT2xUWHpKemUzWTJGbk5p?=
 =?utf-8?B?b1ZjRU50QU5RdVhXMGQ2enNxdlpmcmtaOEdCZHZqT3p4ZVlSeGdlN3BqMXZB?=
 =?utf-8?B?cUg3c1c3WmZXdWViOW1YWDFhUDBTditKWnRiM2I2WjNEakhLbnlUT2svT0lv?=
 =?utf-8?B?cjN6UVJ4OFk1ZGFrdVh4THZhNmRYdWUyWmZ4M0xNQXc4dDBTVDl5SzlNeFhM?=
 =?utf-8?B?eVF6b3NTV3l3WnhIbTBzU1I1M1p6dmhBVkhUSWVIMVg2S0xBRjBBSGJDUXdz?=
 =?utf-8?B?NjBFK2FrQks4anQwYkdxRWZWTExOWXA2YjRLRC9sbXRHNVZSUXBSYUx1Y0hp?=
 =?utf-8?B?bm1CeG5LejZrQ0pKWkRPZldXQm9EL3Q3Rk1IQlpMMzlNRHVubUpSakh4aGRN?=
 =?utf-8?B?eHNjbmUrOVF3ckVLRldHaStTUndDUDJEaFAreVdPQVdxc2ZaYXlvbUxTeS9Q?=
 =?utf-8?B?YnJtTTBNVUw4REJ4N2tPMTJJcVZrU2t4YWdKaWFTN25tSXRKYjBkWU9PdG9r?=
 =?utf-8?B?T2tvZnNTYUFPWC84NjVxbEdDZjdUaG81Rms1ME4rQVdtRGl4VEZ6SWxIUGVv?=
 =?utf-8?B?M2pZaFdZNU1WQ2xIZEJCVHk0L1RjNERlbExYa0p1aDNFTEhCYk85M0VHNkhi?=
 =?utf-8?B?ekhPYTQvbm1FZktkaGE3YWZ1OC9oOEpXeTJMcmxUZ1Z1RUs0NzRsRS9pRkhi?=
 =?utf-8?B?eThOT0V5MmFlUXpRMDdNNzBWeHphZXZ4K0EvbmhjbG5qbFo5aFpLdHlqYnFG?=
 =?utf-8?B?SG9Od1VBUWxLbUorTU1jNXJPYzFtcHJoejdzWkI2eXpZZGZmQkFCUFRMQlk4?=
 =?utf-8?B?ZUZ0REV0b3VVNzlHYVN6L0xXVVVZeVhoYTBIRVk1dzg5T3MzNkxLOEhZTkdi?=
 =?utf-8?B?dndpdTQ4Sy9sWk9qRm1KeVFZMlJTNllmVHY3WnRVTktMZ216MjVaemRPZTE1?=
 =?utf-8?B?cE9tZ0FqbmpOanNCeWI5QUM4cEV0TXlGbjB2L1h0aTFkSFkyT1dvdWNFVEJ2?=
 =?utf-8?B?ZzdUREdsb29DK3RXK2tsdFprbWRBajdIeHROUFFGcktiNGFNZTVZeGJHU2VL?=
 =?utf-8?B?SURmOEdjOGZvVkVtTXV4RzBRblB3L2ZXNTY4aGQ5eDg3eU5jQisrYllUWHYv?=
 =?utf-8?B?cTB1SFYwSVoxZVdIck9rWGdZajB5TzY2MXVIQ3BNUDhLWlNnQ010YWxWWXgz?=
 =?utf-8?B?M3V2T0VhVFk2QXVXMHpySkpnVU9tdENJbnUwUEh1aXJVdjVINnJkbHh1Z0lw?=
 =?utf-8?B?Um95Tm9lRmwvZjBsbjIrVTgxSmFJSHc2ZzRMQ1VmMndneklvQm5QMWpSVEk0?=
 =?utf-8?B?ZTZjbktNa2hVUjViMHBZelUvdEhaSWk3TU40Y0YxMDRja2ozMzFONXdqbVRw?=
 =?utf-8?B?V241QitXMDFPeXJhblpQMjJlYmo4bDV2QmxXWW1RWVlyNXFESzZWdWlSL3RB?=
 =?utf-8?B?blFNd1lXQTdGZUkxbHp4QUh3eVZFNGRjaERjc0JLcjZYMzFKellyYW5xMnZ1?=
 =?utf-8?B?NUZsUjZJd2NmRVk2NHpBU2hhVUFTWVR1aXpKM0ZrbURmMzVBQkh4SkhiWC9i?=
 =?utf-8?B?ZG1xbVNEREMrRGhFQzdCUjd3cm1JVnBUeU5mOExSL2xTc2ZWSjRweVR5aU1a?=
 =?utf-8?B?eVhjekRaaGJicDMvK0hnTUVhcUdqUnA1cmpqZHgyMExRODU2MHA0N2s2RS9Q?=
 =?utf-8?B?dnVKd1dYUVMrcnpKRm5QbXVWOWF0WGFsSEFNZTNIa1d2bEVYMHNqQ2FTdjF2?=
 =?utf-8?B?aXczZDBQa0lyTlhaSnBvUU4zWSt6U1FBcSsvcUszMmFud3BMUFg1ZmN0TUh3?=
 =?utf-8?B?OVAwWHIvRmNvNkpHS3h3bi9MLzFhUEVuRXpwRFIzZlp0UXVyUDNGS2t0R010?=
 =?utf-8?Q?+673dV851em+6ubpJibAb2PpXMNlDwfk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2lESndvbHRrai9SZllETW80Ylk1Q1hqbEJEVEZRQmYyRlZyM2YvaGpBUWJ4?=
 =?utf-8?B?M3l4SHl4YnU3M2wzU0ljM0w1bVN1Vy92Q0Y2TUpMd0F0ZzF0SklyTjF1YkpW?=
 =?utf-8?B?NjF4QWhkbldGTHIzTzh6TjBQOVR1VE1Dc1lkdHpyL0lEZ0ZHaW9TTWphTjRZ?=
 =?utf-8?B?T21IcG1qb0doUVVXSjBkcm1IY0drQTNoUDcwNWdpZk45NFBUZGNEMklnTE9Z?=
 =?utf-8?B?KzE5YlZZZVpoOUV6My9UaHpJTGNnSDVHOUpUaXFwU1RJQlVXTURqUC9panhv?=
 =?utf-8?B?ZXFmUzIvQXZqOThQRmEvRkhLaXlsSUtRaFJGdWI3VGFBY2RxKzJkR1Y1dGh2?=
 =?utf-8?B?emdQNFEwcUFWejhWRnZyeTJFc09YV0F5cGNIeDRod2FMaEJwL2lsV3JPWFN0?=
 =?utf-8?B?WllzSzFqNGJpWXNXZGdPck9hSTNtdzhYRkw1RUZxYmM5cFZmVzN5SHRKRjRG?=
 =?utf-8?B?YlJjcGQ5YXpvRHdUZU11WVZ5c29MT1FEcFhBYWJOUWxHQ1dGYk05ZFNVd250?=
 =?utf-8?B?alNzMlV1RFhSMk93ZXFGakVLZzZIaElzWjVvSDR1MVFpbldXNWVQNTJ3SDNC?=
 =?utf-8?B?TFRuSzJRZVhIZTJvNXFwckYySCtURFhHUEI0VjF0ekZWS002aFRNa0p1Z3VS?=
 =?utf-8?B?UVExTmNXMVZOTlZ3aXp6UHBwcDF5RytpeHhHc3ovWjFob0lqWk1yeGorQm1p?=
 =?utf-8?B?MWdPcHRac2NhU0lOUlYxbHVjVVNWcWx1dGpHd2lCdytlOU0ySUdFM2djVFhy?=
 =?utf-8?B?SG9lQ1hTWGxVTmlNb0VwVWVKY3NZcFVEZU5KckZVd0pIei94QWNzTnBiSUYx?=
 =?utf-8?B?Zk1PWnpmb3NsZ1YxZUZ3TEFJQUZSN1BtYmdEdWltNFpWdlJKMXg4Ri91K2pt?=
 =?utf-8?B?TzFSRmdtS0ZYOC9INkRDZnEvTlduVUQ1SkE0cGNmOHFSUDBiUXVhNkh6Tmcy?=
 =?utf-8?B?ZkhXbWZobjI1Tm94aDFodFhNbzJUbVB0ckFFM0cveXVFbzFTY09KREowTXh1?=
 =?utf-8?B?bm1LdUl3SlAybm04bDV4aVVNeEwxRU5rNUZZKzZmcmxORGtPSXpUcDhxSzUz?=
 =?utf-8?B?NmY2VjE4NE1XZVhDRmlBOHIyTFBrLzUyaHp6UkorYXJoZ21vUG5wVmNCckVJ?=
 =?utf-8?B?dW1mdTdBbVYwUVlXWmpTcmlveDUzczVJbzVUUW5KSXBQY1Q3dWthdm1PRitG?=
 =?utf-8?B?ZkpuQUFhUTRqUytBNmtRZlVZSDFPc0kvR0NWVDgxVklvQlRlNldWaDZTM2FQ?=
 =?utf-8?B?WHF1VHVxWlJsTVc4ZUcvRHYrWkpPVTNVVTVBcHJEMmJqNTBJVlYwWXFsaC9I?=
 =?utf-8?B?OCtwSVJIWWZBay9VbDRpbWE4TkZhcXZOUTUzR2RFcXg4cUtFR2tqR0YrNTBp?=
 =?utf-8?B?ZUpncWdBYUY2UWNDZkh0b3k2ekEzbnhRbDRSSGorbjg4K1Q5WWlxalBMY1NY?=
 =?utf-8?B?QUs1Q0ZodFRyVlpWWWU3MkFDSGIrL2JvTDBLL0d2c1loZURxbyswSkFTT0Rp?=
 =?utf-8?B?TnRUek0zRzZVc0ZYTGwwWnRsckxjb0hncXN0SFMzZ045bzk5ZmZsWitocTgx?=
 =?utf-8?B?dUVrWllkWlIyaktnODV4NkJFWjFBSjE1NHVtK01Yc1kxdFo3R05uTnpVVjRk?=
 =?utf-8?B?Y3Fnc3RXZ3lYMndiSkFhZ2x0cCt2UTZ2NlJJYVBvQzVaSitqRGRqUHhSN2Qx?=
 =?utf-8?B?VVNPb0NSR0hwMFVWazFOdEc5Q0Rhc3ZCMUtHYzNIb0V0RURWRGdybWdVeDB2?=
 =?utf-8?B?UlJOVVQ3SkRMbGY5T2FLN2Z1MWRXUHlRdUV2b2RuSk9RcmRiUTZjT1o0WGxs?=
 =?utf-8?B?QzF4QzdDNTVUV21hYmw2YjRZSm54STBzU29vNTFBM0dFYnZ1ckJ5WG9pZmhW?=
 =?utf-8?B?dlJ3NlJtM0tENGpEYWRXT2dyVi82eTFmNUVDaVEyMXNRd2J4SW9lNnRnNmxL?=
 =?utf-8?B?Vkdmd3g3N0tlcmdvM21tMkpHVUYyREVKOFB1eXFMV2I1Lzk4RncyWmJZTW9I?=
 =?utf-8?B?TGFXNFY5cjNtTVJtMk5CeGdJckhLOU1CR0psR0JRbkgrdENOclhpbU1iVWxG?=
 =?utf-8?B?anY0M1BYdFhta043VC9WK3BJUy9qd1NxSjc2MFpWWjFCZXlxOVdmQzZjVWEy?=
 =?utf-8?Q?2g10L5zrQZpwLInrBZEw7CCky?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76A9502F93DAA5429B85963305857451@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51811cb5-848a-404d-113c-08dd6aec6371
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 15:56:06.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqS+R3HumAmLUn8UvUErhPZ2RiOyZo2gmYJiIcGBDjJBldurf/Y+LG3q79Om3I7cjJ8NgkhvoUlqwjzf+D4XSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

T24gTW9uLCAyMDI1LTAzLTI0IGF0IDE1OjM0ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IEl0IHNlZW1zIHRoaXMgcGFydCBwbHVzIHRoZSBmb2xsb3dpbmcgcGFydCBmcm9tIHBhdGNoIDYg
b2YgdGhpcw0KPiBzZXJpZXMNCj4gcmVzdWx0IGluIGEgcmVjdXJzaXZlIGRlYWRsb2NrIHdoZW4g
aW5ldCBmb3J3YXJkaW5nIGlzIG5vdCBlbmFibGVkOg0KDQpDb3JyZWN0aW9uOiBUaGlzIHNob3Vs
ZCByZWFkICJ3aGVuIGluZXQgZm9yd2FyZGluZyBpcyBlbmFibGVkIi4NCg==

