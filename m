Return-Path: <netdev+bounces-98882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968C8D2DEF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0E41F21297
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB31667E8;
	Wed, 29 May 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="KgzR1uXE"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40A15B159;
	Wed, 29 May 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966913; cv=fail; b=gN1vc0NrsP/gEp5+qq8I5NsTlZ9DLk/JojBdToijwYjgUQHlxOVEDxLh9JHkV6aYSDodezSxQH0opS891l8CXzNpfQdnamIdPrH1JWGRX9Gq90gJPf5KFoKiXkyTZBHkTyoWZ6anoxF1EGgo1irEpZy+ZcvAx3vddn6LaMOlpws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966913; c=relaxed/simple;
	bh=TjzSVDtaEbpVzgF9Vhk4r1ENc+flR8CPPPNBVt01tDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L94zPK8P4iB02U0Rkr+haBhIIxUIiQGVtZY5TvUgPK1a/x7TdS/8/dLdTrYt7jFTztqverwMSKpGhaIJyo8tIHTFqMpDx9bRj47ZunCwxogQISukDsoLLyypDaLPGo8NkIqzr7OmrOgA3IzOrRwJXgfMe5nkx/s2HHHdixy6JxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=KgzR1uXE; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoHs0NwnTt8P19BIqA1nFVIwWu6ScLIb0T7BTFCnoLQebqj85OhtNBWOsf8GQw627Act+t1C/PaXt4BiSmzhIVi2tSQmKtV5hkP6hFCCrAKmleuPAHrmNAtJ3UYGscaBYY3fjXfaZkwJ7gV9TnLpbgDRJsF5m96sNcbarCxTxDa0jgweJSYtzp49FZL5J15iXr3gnf7qWq+urtV8UcTs/sVKO730ivRlTYdFIOvXuWaqMzQ5MHOE5zwx4ixoZtwoa/8wH04fDQKt0JwiymMByvVSsBz7jL7j12d/ReK/5kXPuQrC/st7P+pVi1PVbgbiZvuRy/Dy8M+gouj++xB1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjzSVDtaEbpVzgF9Vhk4r1ENc+flR8CPPPNBVt01tDA=;
 b=nmvyYNlmCumbPetSrYReAZtAM3lVWWlGKImg6fbZw4PJsNklhNyXXS5xkOuy3AGEveZcBgXfUgQiffYOureNIRmOkHTfgh6v59X6oANoUAN8jjEW82pyRqdcCJ9r5JM5DSGfbFjZn3PGyFYfG2sYeS7hAtGYCKQcDCcRpYW3ut3eJXqTs0HCVAzmpiT13lBwF/22gJJIQc05GebgL/v8i5n8LpF2Fp9/fe2ZGrWT0Z8lY5PPoQwQJGuRL1s0T5ahuhb0R/gJJ7AcmVMA2Jzh3QR2MRaz1uN96n5sU5ubV8KKGTsHQY6K7GH94tqfdDXwwUQkbcbew3UlcVNZlaWRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjzSVDtaEbpVzgF9Vhk4r1ENc+flR8CPPPNBVt01tDA=;
 b=KgzR1uXEn0q1peCTtO10h5rmgLceOATr/OL24iXE5jhA+ciLa6BrC2/eWOJYve/QITJ36gd09b06bFOor+ytqeOPDAi2blhobPn8Zrz/8lNg7yMcr8lvYF+1WRYguTBFq+YSxVD6qM4q8mKtEuWlerAn7wHlYjIw3apunnYdakxJgwAH9LFKJqWpK9gAJqlpVxko4vnZaYJKj5+UGRBXju6jOBJDvI/5AgfvkiQJS7NgFrBGWkIrJjhSJYzNN/cmfpscWWeBy5Jc4mt2I795hHshibJ2oE7ps5Y43hDUlNZeWwyZqDz8AF9i/iXXaL2rLZl/iy1unAqbU66mxmLbPA==
Received: from PSAPR04MB4598.apcprd04.prod.outlook.com (2603:1096:301:69::12)
 by PUZPR04MB6652.apcprd04.prod.outlook.com (2603:1096:301:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 07:15:06 +0000
Received: from PSAPR04MB4598.apcprd04.prod.outlook.com
 ([fe80::1b85:a99a:8f39:88e5]) by PSAPR04MB4598.apcprd04.prod.outlook.com
 ([fe80::1b85:a99a:8f39:88e5%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 07:15:05 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Paolo Abeni <pabeni@redhat.com>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net/ncsi: Fix the multi thread manner of NCSI driver
Thread-Topic: [PATCH v2] net/ncsi: Fix the multi thread manner of NCSI driver
Thread-Index: AQHaq+b4Ntb7duakFUCt5bRMqM6E6LGq0+SAgAMEKIA=
Date: Wed, 29 May 2024 07:15:05 +0000
Message-ID:
 <PSAPR04MB459874779F2FD1C88B7E893AA5F22@PSAPR04MB4598.apcprd04.prod.outlook.com>
References: <20240522012537.2485027-1-delphine_cc_chiu@wiwynn.com>
 <9bb0e47adf20c5524b45712fc92a37f2dae568be.camel@redhat.com>
In-Reply-To: <9bb0e47adf20c5524b45712fc92a37f2dae568be.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR04MB4598:EE_|PUZPR04MB6652:EE_
x-ms-office365-filtering-correlation-id: 43c05ada-20e0-41b3-2747-08dc7faf10b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3JIQ1hCV2I4YU9rRUE0Y2FsNmZNMXNWVjZsanpYeExYQ2lzeXppdFNpNlBo?=
 =?utf-8?B?UWhCY2YrNitZcGF0ak45Ly96TCs5YXpYOVhKOEFacGhwZjlHVEtkYVJPTHFx?=
 =?utf-8?B?eTJkbm55WURLNnFON3VzYXRuMVVEdGtjd0JCUkVRczZvUUJCRmRoZWNOUzVi?=
 =?utf-8?B?cEEydmpBamJadTl4MWZ4QTRmL3hkTHFKRjNia2tZN0xxTE51aU5iRjBxczZs?=
 =?utf-8?B?SVQyQmt6WmFaMmdBOXRnWm1kRjYrVVFvYlBrd2d1Sk9LNXdtVXZKKzJCNXRT?=
 =?utf-8?B?RDJBTnM4UmFpMnE3QVI4Y2RKcERhWGpoZmp2aThFTDlqM2pkUHBDRDlBelFv?=
 =?utf-8?B?S3MzUGFkNUNQVVNqWmVDK1ArdUN6M1NhZXNNMjUwZWVkTDZYRkxsemE0REd2?=
 =?utf-8?B?c3Q1YncvTUZ3eW5TNWtoZlZSZmhDKy83b0s0M3AxUmFmWkVoVElTTFdUU09N?=
 =?utf-8?B?TkFkeEFHdDRpNEVMQVVvbGt2bmkvUkFzUU1QYStHdG9pc0UydjJvbUg5L1RJ?=
 =?utf-8?B?OEhUTGVsQ1E4QzZVNmpUZDF4UHBWWG1VRW1sdVNtb0JFaThsN2RTNzRMdTA0?=
 =?utf-8?B?N1crVTExM1EvdzluK3krd0Y5L0swWG1FeElGRlk5VEdta2tpNkZnUmNaQTNx?=
 =?utf-8?B?MFJPL2NEMm1ob1BTNDBvUnJ3VFNkYVZFdmN6VFZtVmlGN01FNklwYUd5RlNo?=
 =?utf-8?B?L1NlYlhSVWc4Z2cwK0wrSTFub3ptUHhMNUMybG5LQTMwbDZUVDRibGlSUklX?=
 =?utf-8?B?Rk5ubXRXT001dGJIQ2x2U0tTSXRJb3dZa21WMVZNMWlPWXVRbU52RDNDOC9m?=
 =?utf-8?B?cCtyUWRwQUtkczFwa2VYdGZjaHpMb2tBTDVzVThzTzZoWEFaRnplcXd3dFlx?=
 =?utf-8?B?THdONGJrUmp6SzdhQzFyRVBTbjZvYnBjTG9lWXpnWE1MSDBNZVlDVlcxOVNO?=
 =?utf-8?B?TkF0aVE1ZGlGazBpN1IyS1ZYQVhEOEF1VEwvOGo0Y1FkUVdCR1d5aGZFY0Rp?=
 =?utf-8?B?RUM5R2JFaFJKREk3N0lJamxIamJpYjk2NFk1Q1dKK2V4QytuR1YwK3crUTZZ?=
 =?utf-8?B?TlFyRGwwZVR1anBNYjNscGxSM1VlUzYwUTJVVG5ISDlNVXhWRC9kQmVzRUFN?=
 =?utf-8?B?d3FtZm9YY0M4TXNaNE5tUUFiMUZpVGpEZDB5NmJ0V0I4K1NMczV1SzBVSUlM?=
 =?utf-8?B?ZU1jTm10bnR5Y3dybktZbGRMVVRBdkUrSStSOHMxaDkxRE5VVmhwZVhZKzZZ?=
 =?utf-8?B?bGVYTzQxc3lQYlB0S2tEYzJsZmdJT2FCazBJaXY3cFM3WXBVbHNTY21HV3da?=
 =?utf-8?B?c1FKM05hQzBrTy8yYTNoTUtKVUJIUk5FRVhIQlRqeFRTeHdES2ZjVU1qOFc3?=
 =?utf-8?B?VmZnQ0EyZFVZekRSdmFEQkhlbExyMTd3Lzl5eTQ1cmtUNWVRcGRYdlU2aU9o?=
 =?utf-8?B?UGpmcVdRUkd4bTdzOFAranlwNEQyNnJsTVREaGRpZWxHMlM4ZVo2K3p0RGhM?=
 =?utf-8?B?Y2E1WHRJazNwNHJaUDJsRm11OEpNQmViYnhzRTlNcTg2SjF5OHFmN2I3MGpD?=
 =?utf-8?B?THBvbTJtV1JuZUQzd3NmSTV1Q2FERGF6YS9ZUmc4RHI2WGgxMkIxU01yT0My?=
 =?utf-8?B?ZGtmcFVSOGhPVWxBT3dubzdrYjd6T2xTbFlUakpEd3pCQmNMdTJVWkpwSXpp?=
 =?utf-8?B?ZzhTcWczQTN4QlpWVU5HZ2Y3ZVNlVUgxZEZLNnhhdXdBNlM5THozUFVFVmY3?=
 =?utf-8?B?NkNhYlN3V2d3SXZwODE3Q2ZkSmZnenhuWUJZSVN4STkvOXlrUVc3NS8reUta?=
 =?utf-8?B?YTQ0VW1JVjJDOUlmMmlDQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR04MB4598.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVVyUjcyQXdSMWdWM2JDQ25zQThhbllCS0V6NGFsQXpvTXV4NmtyNkZLTTYy?=
 =?utf-8?B?N2hMcEpGTUJrdkJUUjFhbHg4SU9EMmJQSGVySWdvWVRWWkhzRlBZK3VhZEUr?=
 =?utf-8?B?VGFHdCtNTldmOVZ6eHBxQ0h4czlMZzMyWTNEWGpEUjdvbHhtSnEvWmdKNGMz?=
 =?utf-8?B?THNYR3h5UHlYTlJvcjRORXpQYTlvY1Z1TlE2alI4ejBYdS82REZEdHpxTGF4?=
 =?utf-8?B?WFFnTkVBSDFydldFUHVxak54MEdxOUk5aHN0OVMzTHFNWjRUNkJzVnhRZEtU?=
 =?utf-8?B?MjAwcDZlUFNGeFgwOXYvNWdpK203b3ZxZzR2MDkwM3cwZDZsL0JMOERCa0M5?=
 =?utf-8?B?VGdPYmU3Ly9XbjlJc3NZb1Y4NzBYS25GK3VYZ3BOM2IyTlV4VmRNWUNWUzk5?=
 =?utf-8?B?dVltRXJSaG84Y1R0bXJmbk9VVFFsQWYxVzlSSEdaOTdwendiNmZST1RRQXJW?=
 =?utf-8?B?S204dC9PeU1QZkJ3Wml5NTR0aWRBWHdzS2J3K3YreCt0b210VzlScVB2V3pY?=
 =?utf-8?B?RDg3RFlYNzBGaEVCKzhqdy9YMEVVQm00QmI4b0xuMVJrbk5oVU85VmJvWjFW?=
 =?utf-8?B?OUgySDVZeUZhMmRjMXBOaUE0Qy84N3loS1VZY1REUHdGTVFRTnlqQllzYWVs?=
 =?utf-8?B?Zjdock1TODNtR1pESmFrM1NaN3NCelMwS2haRjlQYmwyRERpWG5KdHdNUVAx?=
 =?utf-8?B?T2F3TW1TNmhpVWxCRDJRVGVBa1Y2Y1V4RTIzMzF2YWhQc0VFbHE1OUYwWDhW?=
 =?utf-8?B?YVE2WkR5WEd6dzNKYUpadDhBNyttZ3Rqa0F1dkE0S05mYy9zN3o2MWNrL2Jv?=
 =?utf-8?B?alhKcTRtNkQ1cWdsa0VwcGtPYjZIVVc5TUc4TEtUSTE5RHBIL2M3UHZFSDRQ?=
 =?utf-8?B?eTc2VlB0YnlPWnBnNFhvSmRHdkFvQ1dBbmpKMFlFWklOUWo5eGgxZmRNanEw?=
 =?utf-8?B?ZXZHU3plS3k2T0N6c0tPbDl4ekR3bm1oZlhkQWJXZzlWWTFlKzZ3YnFOWlNS?=
 =?utf-8?B?VG1QWVpUeUxQbGRHZmxOekJJd05LOGpFRnAzTXdQYjJ6alNQOXozQm5zcU9K?=
 =?utf-8?B?eFVFRmdhNXljVzVCb2RiS21Oa3dobzdJL041UWhjQk5ERG80VDMrSHRqNzcy?=
 =?utf-8?B?Rk5wNDBYWmE1WGZWTmdYUzk4UEluaUI4bHd4RFRrRURpT0xwWE04bGNPdk1M?=
 =?utf-8?B?ZlZaWjNuSE02cG90dlptekZPWk92UkgxMUdaYU00UFA0c1BYeXEwUGJrQ3gz?=
 =?utf-8?B?bFNzNGZGcHdwTEgwdmduUXA4dG5aSjJVUDhZL29IZ3daQVRMemg1b2wydVlI?=
 =?utf-8?B?cXNjaVBLREFZVEZoVTJhSVRIYUxzS0c1SHhUeFFpYTlLbHFia3dNNzJxMkda?=
 =?utf-8?B?ckUyb0lwSThQM1dFN0tDVmE2WERCV1dCdDZHWXgrVW1GRSs4TjBRUE44OHBP?=
 =?utf-8?B?WkdrRjNUcnBmd3ZWNi8xVjlpVDVnMjR5ZGNYRHVibjhWdHdZOEt4Y2pBR2c4?=
 =?utf-8?B?Y3I4NTJzSUkxYVRyZFd0bnhmWG9GbUFjN0dnanhRVmtia0lQcXNyTFBrWXZD?=
 =?utf-8?B?RGJpZTIvMjBqYTh5N0ZKVkVPQ3MxRW9JWER4dmdaeW1uUnN2SUdadUVkSGJ5?=
 =?utf-8?B?Z01WRUpIYnZCTFcvdWpDU2REZXZvRDJGdHVqMDIrdEpCTVUram16NHhBOS9O?=
 =?utf-8?B?ZWI3MWdQcmFtVUdQM0pBMnVCSTZVVWVvZ2hiSklKNDVLNFhNcHFCMytmTWdx?=
 =?utf-8?B?ZnpBNTVWOG9yVlR5ZlhXSmVFbThPemF0T2x6TTlDbGtVR2ZRbzd1RGcwek5t?=
 =?utf-8?B?SDNuY0tHUElQazJ2WUpjNStCRnZEVTJsdTBNYU0rdFRraDVSRHR4UUludkJJ?=
 =?utf-8?B?WmhQaUhPa29GeCtnb3UrUnFyckpIMk16TjlGK0pFNjJhLzBSS1JzdzZMVXc5?=
 =?utf-8?B?dTc0cy9keEx4ckgwa2JjeE90Ym1YSSs2Z2lOeXNKY3h5RytwTzNjZWNMMUFk?=
 =?utf-8?B?RGZzbkYzM1BUSitEUWN1SE9TM1QyVHZjSGlSVVVibHRQcXh3S1hsZ2ZIL1JN?=
 =?utf-8?B?MjNSVGNXL2J3V044b0J3aTVoTzhuVTJBdW8ra3FqdGxUOThnTTl2LzhHSEU1?=
 =?utf-8?B?eEFTbUlGS25YcmxxUGtUYzVOR2NSQzU4SmFYWGttaEVJMmNFc2VQczlsV3RP?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR04MB4598.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c05ada-20e0-41b3-2747-08dc7faf10b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 07:15:05.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIC0p3dv+YsqUGuoECxObh6XYChX1grzEAQ13tYcJknYQyu62IkzX+l26U4ad635mlTp5ypVHHENb/NtrrhpdYj/lLcIaTkfEzHfPGqyzoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6652

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSAyNywgMjAyNCA1OjExIFBN
DQo+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uIDxEZWxwaGluZV9DQ19DaGl1QHdp
d3lubi5jb20+Ow0KPiBwYXRyaWNrQHN0d2N4Lnh5ejsgU2FtdWVsIE1lbmRvemEtSm9uYXMgPHNh
bUBtZW5kb3pham9uYXMuY29tPjsgRGF2aWQNCj4gUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsNCj4gSmFrdWIgS2ljaW5z
a2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbmV0L25j
c2k6IEZpeCB0aGUgbXVsdGkgdGhyZWFkIG1hbm5lciBvZiBOQ1NJIGRyaXZlcg0KPiANCj4gIFtF
eHRlcm5hbCBTZW5kZXJdDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgMjAyNC0wNS0yMiBhdCAw
OToyNSArMDgwMCwgRGVscGhpbmVDQ0NoaXUgd3JvdGU6DQo+ID4gQ3VycmVudGx5IE5DU0kgZHJp
dmVyIHdpbGwgc2VuZCBzZXZlcmFsIE5DU0kgY29tbWFuZHMgYmFjayB0byBiYWNrDQo+ID4gd2l0
aG91dCB3YWl0aW5nIHRoZSByZXNwb25zZSBvZiBwcmV2aW91cyBOQ1NJIGNvbW1hbmQgb3IgdGlt
ZW91dCBpbg0KPiA+IHNvbWUgc3RhdGUgd2hlbiBOSUMgaGF2ZSBtdWx0aSBjaGFubmVsLiBUaGlz
IG9wZXJhdGlvbiBhZ2FpbnN0IHRoZQ0KPiA+IHNpbmdsZSB0aHJlYWQgbWFubmVyIGRlZmluZWQg
YnkgTkNTSSBTUEVDKHNlY3Rpb24gNi4zLjIuMyBpbg0KPiA+IERTUDAyMjJfMS4xLjEpDQo+ID4N
Cj4gPiBBY2NvcmRpbmcgdG8gTkNTSSBTUEVDKHNlY3Rpb24gNi4yLjEzLjEgaW4gRFNQMDIyMl8x
LjEuMSksIHdlIHNob3VsZA0KPiA+IHByb2JlIG9uZSBjaGFubmVsIGF0IGEgdGltZSBieSBzZW5k
aW5nIE5DU0kgY29tbWFuZHMgKENsZWFyIGluaXRpYWwNCj4gPiBzdGF0ZSwgR2V0IHZlcnNpb24g
SUQsIEdldCBjYXBhYmlsaXRpZXMuLi4pLCB0aGFuIHJlcGVhdCB0aGlzIHN0ZXBzDQo+ID4gdW50
aWwgdGhlIG1heCBudW1iZXIgb2YgY2hhbm5lbHMgd2hpY2ggd2UgZ290IGZyb20gTkNTSSBjb21t
YW5kIChHZXQNCj4gPiBjYXBhYmlsaXRpZXMpIGhhcyBiZWVuIHByb2JlZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERlbHBoaW5lQ0NDaGl1IDxkZWxwaGluZV9jY19jaGl1QHdpd3lubi5jb20+
DQo+IA0KPiBBcyBub3RlZCBieSBKYWt1YiwgdGhpcyBsb29rcyBsaWtlIGEgZml4LiBQbGVhc2Ug
aW5jbHVkZSBhIHN1aXRhYmxlIEZpeGVzIHRhZyBpbiB0aGUNCj4gdGFnIGFyZWEgYW5kIHRoZSB0
YXJnZXQgdHJlZSAnbmV0JyBpbnNpZGUgdGhlIHN1YmplY3QgcHJlZml4Lg0KPiANCj4gVGhhbmtz
IQ0KPiANCj4gUGFvbG8NCg0KSSBoYXZlIHNlbnQgYSBWMyBwYXRjaCB3aGljaCBjb250YWluIEZp
eGVzIHRhZyBhbmQgYWRkZWQgJ25ldCcgaW4gc3ViamVjdCBwcmVmaXguDQoNClRoYW5rcyENCg0K

