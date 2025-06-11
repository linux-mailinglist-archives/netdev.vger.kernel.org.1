Return-Path: <netdev+bounces-196437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733CAD4C41
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793693A7635
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AD22D4EB;
	Wed, 11 Jun 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cw6tXmU7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F652288D6;
	Wed, 11 Jun 2025 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625379; cv=fail; b=eZYp3x0XB0WqXomAYp7FEcJCL7Qu3ZgP0OnPiidFRvhoqG5OZvhLXgSHRIhTKHPSDY26LOQVJPHR/o+Je66uda//qJrjBYl8OunVS1mY+UB7V/1ZHWIzBceOBBlA9BBOj+b554/Jpm7McxdbgE4+b1rOxqq0Y5B57XOa6rVyCtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625379; c=relaxed/simple;
	bh=mgjOvp805Eim4xZqHY84kXMiU4jct2kL+mDW7E7LvO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBfpfK6vIGHyWvLFFO8cRGKjs5FNuNEif0qOMuzE1BZbMoi5DBLpBFjL7YveP2QUzHJWzmpTwlDNT6aBBWcISl7JoB1/cuUPluXqR83CP+a/ylWN3aqinlu++YNrTfGyh6iplzPoe2zNBm05Vc+bdY94J900lPo4E3peMCFggyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cw6tXmU7; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOa/g3o32pCTr/krsfTBzW7NloJV0U9W/ANovum2zHBW6rOTrTM248ZqnB/0XJ3hs0PWPMYgQYQCOcpQWZei7Mp8df3Zf/NGW0dZ9UrRRlRZpeZvip7ezZVm1ew5QUP2BMvd4o3l5nIETbhL2gAZ9fLrA50tMHH+LGCMjPurviAPRrtgeOPare5faYE+DKiPiuNl7RzYQRbkgopB4rKcS+Kgl0Ck1mLmUzFAkCuRMP/3maJMa4hXnpmCaq19JnOjd7z0QmjQzvdVQSqdohP3/9Up9xXnwhn6tC+WCIUwtor60XidKj+5FPa7O+qDLxQES991SJaKOun5ffnl3SS0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgjOvp805Eim4xZqHY84kXMiU4jct2kL+mDW7E7LvO8=;
 b=n+NAFgt3gLNNFgegkt7Zk/fDiibWC5J+3bIRcZMcERgqFKumI7PXFU+KM6tGY1s+VApIxTwDIcC3X69OX99+18EZTJKme3P/6GBtVKcdFvveZaa4jKkbwUio/h6ZQqklHyc3owJ2fnXxcvzrIrGtYj6I+gq8Rq1YhSZAGqbenhAgfilYnMzPSkq/Qy7UB36EMU32b4qYQfLWRLjbyunHEHjJ6rmIkwOUTgQOHxgCHWAjQFnOqaGsKbNqR5MagPJov0eUWE3X/Isi+6ESllXHwmWeujTaq/VTHX5NuVjs77ukv0M4ydaE6XIYA3CqNcwKsNMCPNZk+vglia1JRkadSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgjOvp805Eim4xZqHY84kXMiU4jct2kL+mDW7E7LvO8=;
 b=cw6tXmU7ogDhKWTFEARDYuy6vbDAhqeGAeXp2rVULd0f9cikuiB1y5hgDeVLGY7OtXNDwWxeO4WeRAyqZaTaztfooK06qcv4qd0n3OCLYDVDEE06b8DpLRU3oTQhI3l35OOVMvzG5I5PVEi6gcLCZlqOCLW64XohCltl0mjWBmMCIGsMZNAy6VVK07QcQttJH/DJrE6snffRqBVMfALXjW6Iyyq6qK+qpEd8F23XfzjIAHKYAhc6+R5ymMKB99DZl7P+7hkV8pIflsitk2WOfypvqAjfZlEShDzUuVbAk4wp1D5itnsACgUTLKFABwxSnRwQgZmghaysLKR5IbpisQ==
Received: from IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 by DS0PR11MB7830.namprd11.prod.outlook.com (2603:10b6:8:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 07:02:53 +0000
Received: from IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f]) by IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::fa56:fac3:2d22:311f%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 07:02:53 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <hkallweit1@gmail.com>,
	<Rengarajan.S@microchip.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <UNGLinuxDriver@microchip.com>
CC: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: usb: lan78xx: make struct fphy_status
 static const
Thread-Topic: [PATCH v2 net-next] net: usb: lan78xx: make struct fphy_status
 static const
Thread-Index: AQHb2kpnzSyMDna94UGYvf1M6eBpJrP9iAgA
Date: Wed, 11 Jun 2025 07:02:52 +0000
Message-ID: <58e97a033835bc9347e24ff50aea26275054e9b2.camel@microchip.com>
References: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
In-Reply-To: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8804:EE_|DS0PR11MB7830:EE_
x-ms-office365-filtering-correlation-id: d10e3926-216a-430d-e13a-08dda8b5fc53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1hCSmQvYk81RXA5OU5iTFZkc25mT1V1S3ZIUUVCM0s5dHk0SHlmZ2FwL0NM?=
 =?utf-8?B?TDBJWkliVWZ4bDlWTW9VZEtkNFUzVDR3bjV2YzZwcEZQaUR5ODl5M2ZsY0Y0?=
 =?utf-8?B?cHkxQWlEN1p4dnI2VjZrWnRWUU9vVG14MVVFc0hlNkNYY29XSlRQai9GV1FS?=
 =?utf-8?B?ZU1kTXEwaGlFQUxaajNTUGVWYkVUNG5tWEVBci81bnVJL3BMR1ZzajFRYW00?=
 =?utf-8?B?Sm9ndU9PTklaTmZKT2wrQ0M5U2VUNGp1T1l0SjU1aGRtdW12cjZtSGl0QlRv?=
 =?utf-8?B?MmgwNENvc2t1RzU1Rnh4bU9NOFhqbXhNVUdoVE16WVNyeERRVEpVejFScUtO?=
 =?utf-8?B?MXlOeFAxNXg0UDdaUk9BeFFKMWx1cG1YSnpNclRHa2FoL25MZHlDdDVSZTlL?=
 =?utf-8?B?bFFOYjV0YVhKSktScUdvMHE0Umh2SXl0dWpieHl4TWExN2tXb1E0OGFla0Nz?=
 =?utf-8?B?R0dTc2ZkZnUxU2ZUK3NMclVwRWlOR1hOZkNZanM5d0o3MnFwdGN5R0JlZFpu?=
 =?utf-8?B?cmxqQVdkemoyUFhSQU1CV29BWHBiZkM5d1VzeElRN09SWVZOYmJwdGs1UlNs?=
 =?utf-8?B?T3dUdmRmaHdscFZJMVNFcVZCTFZBelN2VVQ0dk52d3FmNm1HY3M5b2tub0Na?=
 =?utf-8?B?VWc0ZkdTWk9JajA0WFRISU03ekMrcHlmR2ZjNFpQc0NGWGsxY1UzTjdncmJz?=
 =?utf-8?B?MHN1cERpeHRKQnF0UHFxd2dXYW1LbmZwSWJWTHJjYXJ0cm1GVVNpK1JOT3c0?=
 =?utf-8?B?ZG9qVFByMUUwZ0l1WHRnSlBGNmJZUTB0U29NMGlTeWlqaUFaMmlsRXI2enNZ?=
 =?utf-8?B?Um1lV3ZEQzJ4azhLcTUrREV5L0hBaFVVeHdSR0RQbVFIVUw1eStySjNLM29H?=
 =?utf-8?B?OUFzcFlrTjN2Yjk3RHJ2U3NOL1QrTkZNL04waG0yUjhPTnc5blNJdGdQdU8w?=
 =?utf-8?B?dFhVTTRlcXlhdDc3ZXpIdDRRTVFlMFQwTUNVZ25USVArSmw0ZUZsN2ROc09U?=
 =?utf-8?B?ZElmeHM4TUJJSDE4UlZ6SG5yeWVMM2s3ZklxdVdmUkhKSGgzYjRtTi81YlRx?=
 =?utf-8?B?TU80RWJZSEhudks4MThjYjlsNW1uZDRtWEoxN2RUYXRMdll0cVp5Qk9EUm5z?=
 =?utf-8?B?MlRJcjF5ZFhGZlhFSDkzSGxya1A1OUJDNGJEaVNNMU1oZjVpdFVldUlXL1RV?=
 =?utf-8?B?YzFhdTkwbUwzL0F2TG8zKzBoSm9oRWxFTnZKRmNac29jNUd3SExFS0FjM1Zt?=
 =?utf-8?B?RGd2K1BXd0U5dGVuUmFZRGk2QkVlVmJ4ODhRT0t4dnQ3biswMmdlS0ZoS3VI?=
 =?utf-8?B?cGRTT29DTURVcEVGZThUWitHZmNiN09GaFFaU0RDNWxRZ1ZTTFBwVzhnVUh2?=
 =?utf-8?B?Sm80Y1JUYjZTMVBFbi9Dc2QwbjVZZzlPVlh3ZklFRXV4T1NYMno2Vk1EYzlm?=
 =?utf-8?B?YlRzVUNKMG1ZdmhGendGdktIWlJxbVlZbHZzWDFnaGxzTWZxZ1cwcXk1NC96?=
 =?utf-8?B?V2Z2eXRBT1I2Y0puSVBldDFUSEVTZDMxUFY1bzJiVXMvbjB6OXgwZ24zOE9K?=
 =?utf-8?B?VXYrNjAxVVdseG12Q3I1VUNHNGxLM3Nyc0JRNGtpNkdPMm1JbU9QWUVORHJV?=
 =?utf-8?B?d2tmY0gvYTlNNS8ra2kxNmkyMFNiWnZocnhTZkZzZ1ExcVJIMWh2T1pjOUhp?=
 =?utf-8?B?d2hmK2YxdWZEMnlJelZKd1c4MkpGdGtkOEJPamRlSlpGNFBYMTAwOFJYUTN0?=
 =?utf-8?B?R3V2ZW16a0JzRnBEbFJkOXNNL0lyOTJDZFFzbm9PR1NhL1IyZHdUK21yU09F?=
 =?utf-8?B?OXJhQzh2TllJelFtN2RScGlKN1AwOGtXYzlnMWlmVmQ3QUgwemZleFFJWUdC?=
 =?utf-8?B?WE1nMHBVRHV3MTEzVVlvOGY4YVY5SXkzUEhnUG9WMkpiSnQ4czhKSy81NWFL?=
 =?utf-8?B?OUY2a3ZsSytkSXJlTXZwcnVOK2ZSVEl0b2FpSy9EQ05LV3lqWG9YNFc1YkE5?=
 =?utf-8?Q?B7cbab5v/bnpcqBf8oAGHbn3U/24Dw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWhzeHFrTDB1L2hHZUxxelFJQ2JUMDhmRFBPNloxcXZvKzgvaGp1K1J6aklN?=
 =?utf-8?B?cnp0bjVRTFM0MkprT0doT3RndGNmaXRwVDlyWTFudk13bWlJMTlpamZXb2FV?=
 =?utf-8?B?TnEvSzBxT0hQUXY3c2ZiTWxOc1NZVHJ5Y2Q3ekNDSHJFcGx2Y3B2b25MVStE?=
 =?utf-8?B?SjNkTCtsdFBYU0tHS2lHblQxaFF5NFhpZVo5SFh0cTNiU0xraEJlR044Wmp3?=
 =?utf-8?B?aVdUaGlGeGl3TzZxVVJoWmFvRjBxbm9xc0xVNjI5cHIrWHluTjJjRkFzc25l?=
 =?utf-8?B?UDFSWW0wSVY3SWhxbTZub0xXeC9Pb090eC8ydkRLdm9ydHRQYytUMXJLcUd1?=
 =?utf-8?B?a2F2aSt5MDZ2VXd3dDZyK252QTVQbnRBeVdaTDBKWXFvbHA4dVV0NTd3c25q?=
 =?utf-8?B?cDVDbHdoWnBYQ3J3cTZKeGpUT0JwWjhGRDlnM25KbWJ4VC9MVHA5d3ZQUGdM?=
 =?utf-8?B?a1lwMWo5aW14UmtxNnBkR3UwN1h1a1MzME56VUhoSUdnR0I0K25UbVlOSjlY?=
 =?utf-8?B?eXQzNmZGVklqUTRkRWVqcDZhM21rTWdnelJITEVhVjdmMnFMZVAvcDFWaTVB?=
 =?utf-8?B?MmtQL2N2WjVTQmNhN1dVOFcwYUFzYWF2b1ZqWEFVdDlaTVl4VTQvM0cySklB?=
 =?utf-8?B?Z09iTjZlRUQ0R09wNXN2WUp2VWFYUE11bmJUZWt5SjJoaUJENDg3SlJkN2Mw?=
 =?utf-8?B?ajFVQVFnaHpNUmpRbUxQQUJtY2JzcEFDVTdNTlgrVXRUQUFJVGNEK3hPbkM1?=
 =?utf-8?B?VncrcFVVSnFvMnV0TDZtV0pSdDFnM2xQYThselpISGxyRzdFL0pqZzlOYk5I?=
 =?utf-8?B?YzRzaFl2b1R4QWZVanEyeEZTamNrS0FyakZ4dktSaDdKT2FLbHhvRmY4blp0?=
 =?utf-8?B?VGdsbk95UHhTbFZwQVExUTJEK0RLeFh5ditrbXBXcnZEYlpxZ3hhSnM1MFFW?=
 =?utf-8?B?WHZpTFJTcTdBN3YvWVNQZkZYRjdYQnk2dXVDejdnY2c5bjJ3TGFlOFhYdjc0?=
 =?utf-8?B?WC8waEdiWTNGcUFpRVBHTFpnYlAyYXg1ckxXR0RnUlRkaHN4SlRURU80dnht?=
 =?utf-8?B?VDVXMDhUalpYMzMrVDBidTB2REtMZWhyaVZJb0crajFQMGJrOE1wdzVvVHUz?=
 =?utf-8?B?M1NuMTV0R3lTK0JvdDFHMlpBVFBuR2xrNGxPcVZSK1E1dGNTUlltY0dha2hE?=
 =?utf-8?B?SGk1Y2lpUnZoNldHanlVNUMvNjR0NERTL1pHTDBqOFZ3MkhEYldtTWJla2VW?=
 =?utf-8?B?L2RWeWFaNHJTQWVEZmpGUzdmWFNha2FicTB3ejliR0Q4dk1hRDZkRkF4SU8x?=
 =?utf-8?B?dGtDM3ZueVhmWDl2aWZQR2lqeVpXcHVIRXBFbllIYXFMWXVQOXQ3dElqeGQv?=
 =?utf-8?B?ZWJqeHp2V2NCWUMzMko2bHJYZHdiY2xPZVBMUFpuYWZlQUNDL05nN1F0N3VK?=
 =?utf-8?B?a3NlWTJnVkphbGZVZ3FsdEtqWnFyeEV3enlPdmRjeVlnak5idUljTFdGRHBF?=
 =?utf-8?B?Qy81ZkplRERpczdHQ2dGSzBIYnpTLy9HVVdBVVZ5aEsyRlVTN0dsUUVBa3Bu?=
 =?utf-8?B?S3VjUlcyci9vV0hGZ2Y3bDNCcnRSY1IyVk5DVmtjRlJ0RUFQbHoySXRSVzVI?=
 =?utf-8?B?WjY3VHdRM0lWSkNsZmFSWjVWSFgvZE1GeVp2M2tWN0EvM2hlbVJTNCswQ1dG?=
 =?utf-8?B?cUZzNWlLandjeW9UMXRpL0NLbEFSK0p6U3p2NG4wN01ja2F3KzMyb1poVnpp?=
 =?utf-8?B?VGRtYU1rOW5sQUZEZVB3N1FWS2lNaHRqdDBEVXBOQUQ5alhGRUJySEdTM3pR?=
 =?utf-8?B?QTgvUU9DY1BVSGYrVzNGMDFQNmhxNG1GaGVDZ3FscUdFME03VFdSQ09oanEr?=
 =?utf-8?B?SjQ3aXg2cjJLQU9OZk5JR3BwS01qek0wQTZ4SnRIV21uRjlpSVhHVHk2Qi9n?=
 =?utf-8?B?QjBjTWtFS2dyckVVcUN1eWRETzFJMDkzK2FndERGNi9BejdXbmE2UlRiQ2VO?=
 =?utf-8?B?U2JudW9HV0k4WCtzSEM1TnVqbTRpNytMUXRIZHpNSzdzRzYyQ3FOUURPRElU?=
 =?utf-8?B?cU5wWm5tQTNUOU9JZnl5c1ZnaFd4dElKbjJmTG5SenhCdms1aWZlaDZkQnJV?=
 =?utf-8?B?YzduUzQ0d003bVdmR1lLOTJvMHdNRWpmMjhVbnVQTVMyMWRXeDQySjViQmNO?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B7B43A9FEF624C8791ECFF3B62D36C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e3926-216a-430d-e13a-08dda8b5fc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 07:02:53.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXI3jsTAEyTP6O6BKP7GHooyL4dMGUzKuLPT7mvq0Jv1iKXJ3C/FtWrER5VIzd6Bd/mDd18adep3BS7Y9/aUgc9/anhsJ6Y2kXpWt6DHpWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7830

SGkgSGVpbmVyLA0KVGhhbmtzIGZvciB0aGUgcGF0Y2gNCk9uIFR1ZSwgMjAyNS0wNi0xMCBhdCAy
Mjo1OCArMDIwMCwgSGVpbmVyIEthbGx3ZWl0IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IENvbnN0aWZ5IHZhcmlhYmxlIGZwaHlfc3RhdHVzIGFu
ZCBtYWtlIGl0IHN0YXRpYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gLSBleHRlbmQgY29tbWl0IG1l
c3NhZ2UNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYyBiL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4
LmMNCj4gaW5kZXggNzU5ZGFiOTgwLi4xN2MyM2VhZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L3VzYi9sYW43OHh4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYw0KPiBA
QCAtMjYzMCw3ICsyNjMwLDcgQEAgc3RhdGljIGludCBsYW43OHh4X2NvbmZpZ3VyZV9mbG93Y29u
dHJvbChzdHJ1Y3QNCj4gbGFuNzh4eF9uZXQgKmRldiwNCj4gICAqLw0KPiAgc3RhdGljIHN0cnVj
dCBwaHlfZGV2aWNlICpsYW43OHh4X3JlZ2lzdGVyX2ZpeGVkX3BoeShzdHJ1Y3QNCj4gbGFuNzh4
eF9uZXQgKmRldikNCj4gIHsNCj4gLSAgICAgICBzdHJ1Y3QgZml4ZWRfcGh5X3N0YXR1cyBmcGh5
X3N0YXR1cyA9IHsNCj4gKyAgICAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkX3BoeV9zdGF0
dXMgZnBoeV9zdGF0dXMgPSB7DQo+ICAgICAgICAgICAgICAgICAubGluayA9IDEsDQo+ICAgICAg
ICAgICAgICAgICAuc3BlZWQgPSBTUEVFRF8xMDAwLA0KPiAgICAgICAgICAgICAgICAgLmR1cGxl
eCA9IERVUExFWF9GVUxMLA0KPiAtLQ0KPiAyLjQ5LjANCj4gDQoNClRoaXMgcGF0Y2ggY2hhbmdl
cyBmcGh5X3N0YXR1cyB0byBzdGF0aWMgY29uc3QsIGJ1dCBhcyBmYXIgYXMgSSBjYW4gdGVsbCx0
aGUgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgb25jZSBkdXJpbmcgcHJvYmUsIGFuZCB0aGUgc3Ry
dWN0IGlzDQppbml0aWFsaXplZCBhbmQgdXNlZCBpbW1lZGlhdGVseS4gU2luY2UgaXQncyBub3Qg
cmV1c2VkIGFuZCBkb2Vzbid0DQpuZWVkIHRvIHBlcnNpc3QgYmV5b25kIHRoZSBmdW5jdGlvbiBj
YWxsLCBJIGRvbid0IHNlZSBhIGNsZWFyIHJlYXNvbg0KZm9yIG1ha2luZyBpdCBzdGF0aWMgY29u
c3QuIElzIHRoZXJlIGEgc3BlY2lmaWMgbW90aXZhdGlvbiBiZWhpbmQgdGhpcw0KY2hhbmdlPw0K
DQpUaGFua3MsDQpUaGFuZ2FyYWogU2FteW5hdGhhbg0K

