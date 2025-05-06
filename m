Return-Path: <netdev+bounces-188231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4CAABAA5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01923BB376
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD6272E58;
	Tue,  6 May 2025 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VKhb7DSO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B227F4C7;
	Tue,  6 May 2025 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746504160; cv=fail; b=gJ3n2SaYLkrkj6UFyJ+sjIhe1z6GH+zufEFYiYXvw9zMSlsgTrKu8O4PGSpaWMseY0awpGlOMejiModILXDM5XrtGqAkpBhZl/ayArFtQIJnLZAvkgXuraTOi8BX+fSEBeZpq5K7/BJxHLr4JmSRnjnMPgVpdYSWq1gGFkdCaNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746504160; c=relaxed/simple;
	bh=+iaTGh4dUG4/eHBcyVYMuT2UQebq7tVUT8EKtc8P5Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MsmyPllcUGKIMkpl8RnkSuJ1Jdw5tdID3FV+q7tuJ2hRY/6OWEXvXpq3MCnYuN9/uvtJZ2Fd3goiZeR9jU1dhWxilwdZufN0GA1tSpBvbSwmvhov9Xi/M8EwIcWRrNqINJEN4j9VNtlvCX5Abtsyd71hJxyZq2CNEZZ4zxhISX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VKhb7DSO; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUbzp7OljvHAcuecGp/KZLFSfU9EwyMCdW5S564139pFuYEashA+j0Rfs9tXHNJOuHw3qVhUsut45Jvrkkt0y5FConqteEYgcOAIiP2O2yb3WapwMWCEfAI/KlLoyDioMuUseuaoH2T7MQRB9HFL8u1FBQNicVYNID9SxA5cuv3cO3rb8ieO7iw/IaWN5IbesbVyx4hbKTuXZl1ZMO9YItaxlZ97bFfRTWH3J8gEyzk98dwLx0yyDx5/fREEpSIW+mf5ZXrGeSnG8NMwjdiGsDBIPaZBR0pyhL9BL1kw7wMnIaAjig8zuUwG4B3WB8ts5JHiIgezBZk+4RFQ05Qtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iaTGh4dUG4/eHBcyVYMuT2UQebq7tVUT8EKtc8P5Ms=;
 b=ThWtPRtc+kOW05GoE5bGkU6OFuDgwk7m1nAG72Zh+UCs19vwzH9DrKVRSlNW/kbbF8iiioheiojmGX61xwJLJatsDJuTuzHOgqbpx/gDylvllMdjSoBl3wu56SldvGTZNijRz9Ft83kI+h87HIONWahskjybG1Axj0fqceV5SIiU0fJF/VbPBHXOIszNTh2Ft9fJUCQltuHrWKiz/oUgeWZcV6pwrC91daxl1sdIW7hOH+KJi1zqSOl/OhbjWabGpI0dGXMl800IWsLa2X2kPHXEHaDKNHDUlfsU/wwdUJXv+Pc/mxwjMDGqvkD8dulX6+4zoN2mld35BvN+kiKCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iaTGh4dUG4/eHBcyVYMuT2UQebq7tVUT8EKtc8P5Ms=;
 b=VKhb7DSONOcdfeAAe6VZyCRlxdQ2rfdGxN3zSvrljR7pNiHlinhKIgYMzH7b2YVkDK6KmBFgpQJs8g5Yz4EJHkFBC3a2922rAu3Ng7c2hQeM0Vi+NtvU1DUoWFdttlT0UCRWiw4D0bgEEa6r9mg2dazq29fmf2isZgBT9DnG0a4j/TC84kEeUSyoswGd3AARB5Q3O4fB+VicWs2X2v1vFN4WbsB99MK8Yw9jrzpPhHa5NKEXWwm/5Y+/VZW9SLAxOWjLMO1QnDVSTcOmV64xhzK0IVT1kSh+t3gm8FvTWu4LulkARDwCB689pNOihmeImNoKyb8QnyrAlsoIKa838Q==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 LV3PR11MB8532.namprd11.prod.outlook.com (2603:10b6:408:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 04:02:31 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 04:02:31 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <Bryan.Whitehead@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Topic: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Thread-Index: AQHbvjuwfAb1ipuHUkysqrRCN9cngg==
Date: Tue, 6 May 2025 04:02:30 +0000
Message-ID: <42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
	 <e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
In-Reply-To: <e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|LV3PR11MB8532:EE_
x-ms-office365-filtering-correlation-id: 0880eb34-34c0-4928-2c2b-08dd8c52d2d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eENrQlZNdE53eUpBZWxPdUVYS2JoR1ZoeWpxSnVDMW51TE1sL3R0V3VjZHVB?=
 =?utf-8?B?c3BXdHg3ZGMyaGFDUlprRDF2R08xWjU0dUZlcUE2U3pRTGZxMGhTcTF0T25L?=
 =?utf-8?B?YlpQNzA0bnhZRHFJSG9LUXhkY0pPVDU5VW9NUEpCT2NGMUZDSm1DcmNqR2tG?=
 =?utf-8?B?dHk3WDlkZnZ3NGp4MU4yNDEzZXRnRnRHc05hdzc2Y0VqUVlTZitoMFZKVEZm?=
 =?utf-8?B?Y3owczRjS1loZWhkQkE3UUdINUYxa2tvUFo3L2w4U2xhWGdIVnBDQTAvdGRo?=
 =?utf-8?B?c05NRWQzRjQvRW1WY0FGK0lta2o3NTZSTjdqVHB5ZitjZi9BQWF0Y1RIM3RD?=
 =?utf-8?B?VVZTbHhSYU1VTTRYR2E3VFBhdlhBbjk2UVh3U2p3ZXlLSkhNR2liYi8xc05h?=
 =?utf-8?B?ZDdoRVlqcmFrb2U3NW1DVzVZcWQ2ZzhQc1hIYjhna0RPRUdOeHdpWnFPQ0NM?=
 =?utf-8?B?SGd0UFA0a0tRUlh4MGY3TTJMb1A0aFFwVWxDSG9Iano0amFJbGNsWi9xMHQ3?=
 =?utf-8?B?QmlLYXpzME1vVzdqWFJKNTBLcFhKUXZpNG1DUnVJUmlrYWtwZWlQTTFhQXlk?=
 =?utf-8?B?aVVPblplZXpOZ0ZrbmtEbGdUbitBY1B6ZWJxRFRQVFB5dVNkY3JnNHc0T0RD?=
 =?utf-8?B?QzBtZ2dMa0dZSGpLTkJ5dy83VXlNOFF2YURDTG5VeU9IU1gvSDVJRlhXV0hN?=
 =?utf-8?B?UEVoU2M3UHpoK09vK1dYcnE4MU41S041YnpGYmZjUElHY21BcFN5V2Y4R0tH?=
 =?utf-8?B?eEUvWFNYdkw5eDhJbWRzSFF1U3BMRkVncVo5TTF4STgyc00zUkFqZWtOQVEx?=
 =?utf-8?B?dGZtb3pvVlRnTEZaZ01rWGYwVDA4aDl1NlpZUExROGE1OHdxTm8xQ1ZZSFRR?=
 =?utf-8?B?S3kyR2dlNlgyM1ZlZXdrUHZDNXRiclROMHFoall3N2RjTW1lNSs4WEJZNmx3?=
 =?utf-8?B?OHNQMVVCUlNmSGNiWk80SU5zcjYxV0lGZDFjWnVFNU1VcUVxa1JOWlRhZUNY?=
 =?utf-8?B?bm5yenhiczRja3FFS0VpNk8wc1d4UzVpd1JGRkcxTFNWYk9TbnB6T2ZqcDhp?=
 =?utf-8?B?TlA0YmdvRkxRSEVQOEhBTFYyZGlLRVZxaERmSkhVcC9UT0grRVN0aE8zQ3Z6?=
 =?utf-8?B?WUQ0NjNOZFJqRXo1U2JmMHV3QjdTNUZyMk5yeVNNZFRPT0ozMHpWeEhST3lJ?=
 =?utf-8?B?TlYxc1d3L204UzI4cHg4NXRJTzI5aVBaTS9vWTZja1lUNG5iOElEOVBQbnc0?=
 =?utf-8?B?a3BHdkJZdkQxZGsxM0lqcXpkN3A3eW9Fak51TjVlTUVVQWlXY0JGQml1UHNj?=
 =?utf-8?B?WmxHRkNDRHUwNkNzeG16MlY0Yk5xMDFKei94dkw2NzVuSEJ4NEFZUXhTYkY1?=
 =?utf-8?B?VWloWVJySk1paVV1WHpzQ1YvbFQ4TEZmQUllZjE0eGRCeUI5d3MxMVpaUVR2?=
 =?utf-8?B?Q2gybi9QY0k2SHBOR1R5bGI0bTI2ekhCdFVQVStzdUhwN3hId3BLZzExVDhl?=
 =?utf-8?B?THdsTDVVeUVCWmVpbkY0TjFTQXFTVnNITkdMZkJUcC9iNUlyWXhuTXcyNjU2?=
 =?utf-8?B?cGxYdUFKTktIL0hkMllGRXRYa1ZDc3FwZy9OQ0VnWklFN3VRZ09SV1RRNE12?=
 =?utf-8?B?VXFpdmlKaG5sK2QzMDJiQXpYUklBTDl2TWhTZnlvT3lBWXNsQUEwbWROaElh?=
 =?utf-8?B?QTdZV2NqOEFQdTRXWS9SaityR1EyYzJCWDVPVm4vZVUxV2F5QkNzUTl5YUdC?=
 =?utf-8?B?RzN0akJzVXJsb2lrK003czcxczJ6ZHNtTjlVOVhqdm1LT2FjeVJTTDlwWnM3?=
 =?utf-8?B?T2E2RkVZOW56ci8vZllLb3FHM2tWZlIxYmVOMmp0aUh0c2ZzWm1GNmZZT29W?=
 =?utf-8?B?Q2o0b3ZyUzd2Wi9vVlVyN3EwZFZwMzQ1WDd0eFdYSjB0MEtwQXJUSVpweXk1?=
 =?utf-8?B?ZER1azNXMkVGWlVXTmQrbmltWDhmRXBZMFN3citwZlBKVFhYZkRhWGs2aTBU?=
 =?utf-8?B?K3FVVTNINEd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGszUCt3S1lYZzFtRjNBWFRxWThIYXJ2bGJJWmg2RXo2SVd0QmRWSGdrNHEz?=
 =?utf-8?B?OThLeE5yTlNHVTcvT3AyRmw5SVlVMGFuMXpyR0NOUXNIeU5TeDM4d1R6U3FY?=
 =?utf-8?B?WkF2ZllzWDJoc1J4aWk0Mk1CQmV5UDJya1VCWWtNYVFxV1AvYkJNQzdGV1E4?=
 =?utf-8?B?T0pBLzJ0T2ZMNlE3bEt1d1g5aGU5aWV0SWtOQ2tyTndBTXRpMkVtemc5VXJK?=
 =?utf-8?B?ZXBQUzdNeUtXOVo5OGpMaWp1K1BXMGpMUS9uQXJpWG4ramZkYXppcW5jVnNz?=
 =?utf-8?B?M0tHOWhVYW1IaFhEYjVVVDNzbDgxSVVVOEhjQkMrU05hbW4zU29uNzVmam1j?=
 =?utf-8?B?eDBQTitVRldTa3V6bG41cFdJTWlNd3QvcXBwUGk1cGhOUUlDS3pXUzRJTlAr?=
 =?utf-8?B?MnNlNGFUSE91ckhnRkVQUFJvN21DYzl4WTlFWHVUSDhLc0Y3K2hMeXBCZVBq?=
 =?utf-8?B?cFkzdVBDVUROZThrK3lVVHRzMnlrK3hKNWhLdVZUREFWb3FuS3JwVUhtQzV0?=
 =?utf-8?B?Qnd1a1gvZVhZTldYVjhPcnRSS1o5cGc4Y0I0clJEcW9oSjBtb2h0SjZqTjRF?=
 =?utf-8?B?ZURuaVFoWlR5N0hQOXdFQTRUQzZGVkpUbmkybk9rZnZUYXVOMXQ3bW5VSXhh?=
 =?utf-8?B?QmZZTWI5UkVmTzlqcGwvY0EzZTZvVlRJdFF2SkFKd01ueHFqVElYRThIcGx5?=
 =?utf-8?B?R0ZHZmRqYURTTXRoemh5S0dqVXZxVEZjWDZtOEU3OGNVTEg4UmN0dGJHb3po?=
 =?utf-8?B?SlA2V04yaGMvNE1nMWV3cnNTU2xUMGh6ZE5jSTY2OEtLck9UaDE3U3RqWnNS?=
 =?utf-8?B?U2RkRlF5ME95VVBNNnRzVVh6anAzOWxnL2NSTWk0QjNkNlZJZ2VmRGQ5eSt0?=
 =?utf-8?B?Mm52RXlTRDZMV3JPSlltV2xZeHJFWkFQY05qOXlaU2NmUE9FN1IyT3lIa05O?=
 =?utf-8?B?eEtUUlVUc2xDcUZWQWl3WStoTVNuVmRqcVRBcnJYMDVmWklFblBXWWNKck9D?=
 =?utf-8?B?Z0xLcmV4c3EyZXppNnM5aWVPdGtWL1lnZ25SdWp2WWRmeXloZWVlaExkQ01s?=
 =?utf-8?B?RVZCb2VLVS91TFBQRENRMW5iOTByOGhWLzBFMEd1emVCSWNkMzVpczloUHA1?=
 =?utf-8?B?RFYybXBiYlZpd0NBMWg0QXJQbUhndzA2SGI5UGlyK2xHZ0tCaTRVR0RRRTl1?=
 =?utf-8?B?ZWhxdGk5aitQTWUxSDRLSFUrK2lMYkVSaC84dFNYTDlpc0VoNUUyNi83NmtX?=
 =?utf-8?B?c2hpazBremtLc0lQazBubnNVS3I4TDdXamg0N0JpZVBOUXc1RzhCQm9zdFRn?=
 =?utf-8?B?VzhPNTBWei9meFZ1SEZIR3ZldnpIRE5mMzc4VjdwOEtmUE03bEY4L2lJa2Nz?=
 =?utf-8?B?cFVWQWN6TlZrVE5MMURHOHU3aFIxRVo3bFlLTEk2eGp3cktYSGF6U05iSTBG?=
 =?utf-8?B?NHZnU0F5NTN6VHU1S0hGalhTQkZJRVo0L3A1S2lXNVlvVUhiVjE0MXRLczZk?=
 =?utf-8?B?ZEpwVXFLYURxOTN3Mk9WeGsyVExVeUc3ME9zNWhQanZjQTNYZU1OTHBQdnN3?=
 =?utf-8?B?aWtxc29NdEtCeFlDYmVaWUdVcFBzdjA5MEhTbDFrcDRrWUhtaFpaV3lnU0Za?=
 =?utf-8?B?SFdkOHd5NGRRNWR1SjZ6bFgyVmM5eFNQVDlZU21DbzExTDdRTnNsMTZBRXRZ?=
 =?utf-8?B?NUJUOVZsNENHYWJwYmRVQmk5SWpETy9LRWxvSi9Bek5QVGd1U0NMN1JhNTVk?=
 =?utf-8?B?RjlEQ3UxR3BNbmdoQy95NDBJNjFYdkxMUDRzdndLM1pMRzlqVnRyS1UyYWMr?=
 =?utf-8?B?RUFqVHoxQzU3YTVNRWY5eXNkY0NhVHhNbzJ3OXdlbmhmSE94bzJkeERINnpy?=
 =?utf-8?B?R3Ruc1NvbkRrb3pjck9WUVdIQmUxRlc4ZUE5Q3Y1TnRWSittZzI0VVkyamJx?=
 =?utf-8?B?OEdxbzY3ZnAySGJNcFg3emN0L1YxcTB5cEdZdUk5b2xNaDlBWEc1cjRSd3JS?=
 =?utf-8?B?aGV3bWNJSUI3OXh3WkIxUDB3aVI1T0t4UnI3TmFVa256SkpaUjJ4WjFxakhS?=
 =?utf-8?B?cTlhZkdkTGpyeGpQRWtEbEpnOFFvWjlzbER4RXU1bTNvQUMyS0s0Wnl3NjZW?=
 =?utf-8?B?bWdzOVErb0VPK3ArWXNETFdLc0xJWjhDWWNBZnBxdlgrQ2Rxa29DYmV5QUpa?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCAA3E4C3ED0E40A0C142DEC46F176A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0880eb34-34c0-4928-2c2b-08dd8c52d2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 04:02:30.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK57IcpgU13Z04UbfB8pFUT/Y7GecMWOly9k8d07vtYCke5ilskbzWgO/O3LHcwN4kO1TEqJi5M1DhoulqvgOJvpP7oPlDdB4MMYF1VBzMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8532

SGkgQW5kcmV3LA0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLA0KDQpPbiBNb24sIDIw
MjUtMDUtMDUgYXQgMTQ6MTUgKzAyMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0K
PiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgTWF5IDA1LCAyMDI1IGF0
IDEyOjU5OjQzUE0gKzA1MzAsIFRoYW5nYXJhaiBTYW15bmF0aGFuIHdyb3RlOg0KPiA+IENvbmZp
Z3VyZXMgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIHRpbWVyIHZhbHVlIHRvIDY0dXMgZm9yIDIu
NUcsDQo+ID4gMTUwdXMgZm9yIDFHLCAzMzB1cyBmb3IgMTAvMTAwTS4gRWFybGllciB0aGlzIHdh
cyA0MDB1cyBmb3IgYWxsDQo+ID4gc3BlZWRzLiBUaGlzIGltcHJvdmVzcyBVRFAgVFggYW5kIEJp
ZGlyZWN0aW9uYWwgcGVyZm9ybWFuY2UgdG8NCj4gPiAyLjNHYnBzIGZyb20gMS40R2JwcyBpbiAy
LjVHLiBUaGVzZSB2YWx1ZXMgYXJlIGRlcml2ZWQgYWZ0ZXINCj4gPiBleHBlcmltZW50aW5nIHdp
dGggZGlmZmVyZW50IHZhbHVlcy4NCj4gDQo+IEl0IHdvdWxkIGJlIGdvb2QgdG8gYWxzbyBpbXBs
ZW1lbnQ6DQo+IA0KPiAgICAgICAgZXRodG9vbCAtY3wtLXNob3ctY29hbGVzY2UgZGV2bmFtZQ0K
PiANCj4gICAgICAgIGV0aHRvb2wgLUN8LS1jb2FsZXNjZSBkZXZuYW1lIFthZGFwdGl2ZS1yeCBv
bnxvZmZdIFthZGFwdGl2ZS0NCj4gdHggb258b2ZmXQ0KPiAgICAgICAgICAgICAgIFtyeC11c2Vj
cyBOXSBbcngtZnJhbWVzIE5dIFtyeC11c2Vjcy1pcnEgTl0gW3J4LWZyYW1lcy0NCj4gaXJxIE5d
DQo+ICAgICAgICAgICAgICAgW3R4LXVzZWNzIE5dIFt0eC1mcmFtZXMgTl0gW3R4LXVzZWNzLWly
cSBOXSBbdHgtZnJhbWVzLQ0KPiBpcnEgTl0NCj4gICAgICAgICAgICAgICBbc3RhdHMtYmxvY2st
dXNlY3MgTl0gW3BrdC1yYXRlLWxvdyBOXSBbcngtdXNlY3MtbG93IE5dDQo+ICAgICAgICAgICAg
ICAgW3J4LWZyYW1lcy1sb3cgTl0gW3R4LXVzZWNzLWxvdyBOXSBbdHgtZnJhbWVzLWxvdyBOXQ0K
PiAgICAgICAgICAgICAgIFtwa3QtcmF0ZS1oaWdoIE5dIFtyeC11c2Vjcy1oaWdoIE5dIFtyeC1m
cmFtZXMtaGlnaCBOXQ0KPiAgICAgICAgICAgICAgIFt0eC11c2Vjcy1oaWdoIE5dIFt0eC1mcmFt
ZXMtaGlnaCBOXSBbc2FtcGxlLWludGVydmFsDQo+IE5dDQo+ICAgICAgICAgICAgICAgW2NxZS1t
b2RlLXJ4IG9ufG9mZl0gW2NxZS1tb2RlLXR4IG9ufG9mZl0gW3R4LWFnZ3ItbWF4LQ0KPiBieXRl
cyBOXQ0KPiAgICAgICAgICAgICAgIFt0eC1hZ2dyLW1heC1mcmFtZXMgTl0gW3R4LWFnZ3ItdGlt
ZS11c2VjcyBOXQ0KPiANCj4gc28gdGhlIHVzZXIgY2FuIGNvbmZpZ3VyZSBpdC4gU29tZXRpbWVz
IGxvd2VyIHBvd2VyIGlzIG1vcmUgaW1wb3J0YW50DQo+IHRoYW4gaGlnaCBzcGVlZC4NCj4gDQo+
ICAgICAgICAgQW5kcmV3DQoNCldlJ3ZlIHR1bmVkIHRoZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiB2
YWx1ZXMgYmFzZWQgb24gdGVzdGluZyB0byBpbXByb3ZlDQpwZXJmb3JtYW5jZS4gRm9yIG5vdywg
d2XigJlsbCBrZWVwIHRoZXNlIGZpeGVkIHZhbHVlcyBvcHRpbWl6ZWQgZm9yDQpwZXJmb3JtYW5j
ZSBhY3Jvc3MgYWxsIHNwZWVkcy4gVGhhdCBzYWlkLCB3ZSBhZ3JlZSB0aGF0IGFkZGluZyBldGh0
b29sDQotYy8tQyBzdXBwb3J0IHdvdWxkIHByb3ZpZGUgdmFsdWFibGUgZmxleGliaWxpdHkgZm9y
IHVzZXJzIHRvIGJhbGFuY2UNCnBvd2VyIGFuZCBwZXJmb3JtYW5jZSwgYW5kIHdl4oCZbGwgY29u
c2lkZXIgaW1wbGVtZW50aW5nIHRoYXQgaW4gYSBmdXR1cmUNCnVwZGF0ZS4NCg==

