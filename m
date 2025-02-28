Return-Path: <netdev+bounces-170782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE5A49DD0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894BA177D8A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839E27181C;
	Fri, 28 Feb 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cTKA2VcW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AE2702A5;
	Fri, 28 Feb 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757428; cv=fail; b=BcfJx7+nnCcOerdko5x6sTiUS99y//HZhKMesut5aRqqdQIxtwbGK+ZO7K/C0KTOqKtqRJA3Jbau0Nim5ZEU70tnFi5xaUQmYFZUNA+m0Vsy3Jo301Q4BnunBoKfxbt1Q5HQ6NR+48B3zLnW6dzVQqJ4Qt7/gxKqF/4e6Dz7kmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757428; c=relaxed/simple;
	bh=bvEF3X1xspEkrRl/6XCuZmqiGytC9KyBHv3h9uzpYd0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nIzTo6yE5Cwrf1aqxlrmzsfz2DLcRb4QT9WKZuHpDt71xcNlukkVFXSUXkQoUt6aFHuoGcVKu9zGv4M9bocGHufw4MRmDp3IN6G2bcxn4U5155ebGwbvua5GNTKncusTZlPk8uo/ZICX7fXr22KIaM91GmTUDqgg2ZQ9FhFcntI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cTKA2VcW; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sbjos0KBZdLif3mu3BdYWccLmMySNbU4WXlOcVlsczMsrcHGvSEykh2xIxUZnTtK38pmH2yjl4X/u6ZoxN2h+E4E7HO31U2M1gobV4h3sf6O3jFUZtMvIFJmXfIHmTTuFIKW5am/m0Mr5PwrIx5np6TKsDwtfSJ3rSil6519AATtK2DttxOLDr0VCkoM5ahbvZBGVe5MYJdWiKuvuJ6mXaUSYBukHh7TFBEPltzzj4rytOhYCXnP9/tq3Jgn1yGyHt8XvAYYvkFUy9dgB1FGvW3WVoKwkah6HZ4eSdyAE2xC6mZcQPDE+tJzd0Fo341/pTSTLRGSabIpvRK8+VZV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giG25u9QW7UUSc7J55ByNf6RWI66RXJ1nJiWcWmD4pw=;
 b=nn4Q9jxLLqxjzTOCqlfpXg4dUOvGZRgMW/1ZXWDBlgcRfTv/Xarg4xcu3jJDTVe4I+fZxc/OSDpA4oq2/hQyhZljLBIRzkY4MzbmjWep1k5l0SmihR/JoIBmyX4rIlNzkFJUegTWiXj2UV/+78pgjREYqCh0Kb24bljFddxVke8uqkOkEvia4DivCEUVG08OGOau/TXFPkN6IDsW7OAVT4/87YUztURKHsB/ejvS9Gy81NuXMrBIQpAUlb2BXEwY0PFHdcB2OTQpZrmLUUshF4Qxjc52nWV0wuBW4KChACdw3PInbqGN3AboHe65u+kuTdgufVwm69lBE8gsAH7cMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giG25u9QW7UUSc7J55ByNf6RWI66RXJ1nJiWcWmD4pw=;
 b=cTKA2VcWoJKWfT7Tbhznw1ReVttPmWQLdtg+bnThJDeitCowPtOVzC6O8eQFOi1a08dici1sM4rNqkRJkDGlOfjf4VNY5RWvZBNi0YDqvfim9LZK+fYlT56/4QY2fhhMmv1voG4nXCKOVtCDZsfoisIWfddxir5DkxZS3sfsDXbfrzUrw2Vyy+nPsrhfvj/GJ3rMWW/nFUsLwYnlVXNk5l57k8x6afUp8fqjZ+kBUN//EOpvxtD+j+TtrPjBuhAmUVZUcfFMmXnVJ61m7rs3f6OE2VCpDhesNjql9FS8ICn3vdpQe3hDZD7qdnmMJOIMNGwD1hLMfBg0TvVmrULB6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:43:43 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 15:43:42 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH net-next v2 0/2] net: phy: nxp-c45-tja11xx: add support for TJA1121
Date: Fri, 28 Feb 2025 17:43:18 +0200
Message-ID: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: c182a436-f452-4672-cbf0-08dd580eadba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVY0OTd3VmpreUFJRkJjTnFGSVRVSUU5Z3AzWlJmQjlMVkF5YWw2UThTTkZS?=
 =?utf-8?B?NkN4dEhzSkkvVnlONkJHeDErRGJyZ2hJNzRxeDd4a2tJUGZDL3RvcWNsZ1k5?=
 =?utf-8?B?WFlUMVU4TXpaTDRUNVNrcUphVG1wQVEvTENUeDBQdFI2czhkYjBwRHJNNFNJ?=
 =?utf-8?B?blJFLzZaZEpoZDIzSGNqUWxxN21FWSsreTk3aXEzSUtvWjdnK0UrdnRPamJ5?=
 =?utf-8?B?ei9qWHp0b2RnNjBsMjNiRVdIUGRERkw0eGIrcmU0b0NmNnIxbHVpdXRtdi83?=
 =?utf-8?B?T1FFdGhLczJhZTJUVC9RRmUrNkJSSVJod01DMHg4RitpNjVwdS9qb3BkOHU0?=
 =?utf-8?B?RllUcmt5RUR0UnN3RWpPNzZyS3hkMFUyMXRXSUZKejBiQm55SWVSb1BWUmQ1?=
 =?utf-8?B?U2h3WnlnM01YVjMydU55SlduU2dvTWI0MHBYSDBZZHBlK3Y0K0cvR2Jvcjlx?=
 =?utf-8?B?VEtlK3pQWlcvVnlyVysxcHV5L3dpN3VBQ0o5Vm82ZGpjdzljWVdBVytOWnZw?=
 =?utf-8?B?MEw5NUl5K2lwSlprbytNVnkwdkpFVUJTa3hld2V0WWZCRWZGTW5qM2JiR3dO?=
 =?utf-8?B?M3d4ZVRRSVNaTllEYTVybnl1bkFneVloSzNVbWMvZWc1alNvcFQ2eTJMbW91?=
 =?utf-8?B?RjN3S1drRjhBTWF6OE9TY1FhWlhnbkNkZEtXZTZSMWhSbVh2SGdCNlQyRTNC?=
 =?utf-8?B?V2s3ZUNDeGEzQndwSWNWSndsWk9yVzlQamYrOVlGcldkMkhoZDZPdmQ4QkFx?=
 =?utf-8?B?emhWU1AvTnh3cUxuRk52K3IyR296cnVTWFcyWkttTndGU3VCNnVvbzdzVmty?=
 =?utf-8?B?UUIzYmxLSnZmUnJLSDlSbFl2dUxQSmV6eDgzUW1LeTNSSHhHNndsQ1BxSWkw?=
 =?utf-8?B?VXZVVWNWRU8xMEEzak5SajgxcjVWbkIvck8xMEE2UXRoaElPZVIzbWNKUUM0?=
 =?utf-8?B?bVVrSzQ0QXljYkZBNXgvVk9HM3RGeUhFcTRMTUFiOGNQMWd0WGUybXBDbHFX?=
 =?utf-8?B?TzY3b2RDTWh2TUFCenU5RDgyUkIvUmE1T2F4eUZ4MjliQzBCVGY5RHdkd1c0?=
 =?utf-8?B?MzZFb1dBRjdVU2liR1hjYjcrVkZzdTljWjE1NW9kNkJQTlRNVW1ReXlIem9Q?=
 =?utf-8?B?S2tiV2NWUXpxNGU5c0U5VVBuZ3FZSHpaM3dJb3gxZVNYTXhrUHdBeGFuaFd5?=
 =?utf-8?B?UjkwTmpncDNVRXN3WGRNSi9Ea3RSb2Iwdll4QURXdGxaRWppZExHRHN5RGl4?=
 =?utf-8?B?NS9kM2QxMVBHZjJ2czVTZGUyVjU1TkQ3cUlGUzJ0Q0UvSGI3Zks1d2syNGkz?=
 =?utf-8?B?ZWxEc0tRV0I5RmJGdzhiNGhlTU1VejdHL29jNncxT1g3TUNPNzRqWEQwUkNQ?=
 =?utf-8?B?MXYyQ2VxelBBa2psZUNHcEVwbUdPekluRTBJVGY0SW5vSVhZeC9qVVFTZVZV?=
 =?utf-8?B?a3daanVXN1BhcUlVZTgrZWJPSDFSYWE4cUNteFM3dWVST1JiaEtwV0VLQWZH?=
 =?utf-8?B?Q013cjVMMjVTM1NVenlVRlpXUjhHcThpQlpXSTlodGVhMzRiZG1OWExoQ2Zu?=
 =?utf-8?B?MkNCYXVJQUwyRVZzOFBBYTN1SklCRUdYcWFVQU96djdXSHlsRWRRLzFSWHlL?=
 =?utf-8?B?bTJxMXVSNTFlS3dibXNkbFFwWnBabjVneDM2dVFTemdVSFUwa1RMeEJlOVd6?=
 =?utf-8?B?dkVEMy9oY1d0c3V6aDRlMFFpOEJIUzZ1KzhDczhtRHI0RVBqaCtVZlZPMEpD?=
 =?utf-8?B?Q0FqMFVZeCtvN2dselBVSVF4S2E3TXYwV0ZCSHZUVk13SnAxcTNFUzhPRGdY?=
 =?utf-8?B?cHUrNjRvcEJaL09ESEpMekpDWVJ4K2VKMzg3OEZxY1MxYjhZSzEwS29OMXFi?=
 =?utf-8?Q?hJiP0628nQnbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW8yalVGRUpVcnVSNVpRSXBseTRVbWttb040aHNXNTNzZDhFaTRieVVGb2JP?=
 =?utf-8?B?bFNPVk1QU3VvYnVzU2NQRFc5bDhpUGEvRlhqeUtxK3pVem0rV0Q1V1BBbVps?=
 =?utf-8?B?RHRTdFB3SW1GZGFyc0h5bUF1cjZIUlp0R1NTOHYzU0tXSlpBY3hrQXh6ZThW?=
 =?utf-8?B?VzNTaTJwbVdjeGpoc1UxL2JPWFMxTXFHZldEUVMxMWNWajR6UHdlODJWMk1C?=
 =?utf-8?B?N3VUTlpPRnFjbEl4d0Q4dUF3ZjlBd3NTT0JlM3UzVlZ0d2I4V0pTb1c0VkNU?=
 =?utf-8?B?VlB3ZXN6WEUzcm5iRlUzdkVsY0M5TE9DZGRTaXBEQ2ZUalozSXFLNU1CSnZt?=
 =?utf-8?B?eGFERG1haTU3V3JSZmtMbVo5WUl5N0xhRnhsSmlhSFp2djc1bEpsZHRrOXAy?=
 =?utf-8?B?eXNEaXd0NE1MS04zZmpvNElXQzg1RDRRVktuVTA2U3d4em1SenRUVDJ0dzEx?=
 =?utf-8?B?NmNtQitGSEErd0VBcjV4TERDcEF1ODVMU3A5a0lKOTRHWmNlZndEMHpBZWNy?=
 =?utf-8?B?c1hFNFRtR2NYTk1DVmpsSUxXaWZtWGRFYTNianVhL2FHaUpkQ1VxVGE3Zm5Z?=
 =?utf-8?B?Q0dlMUhUeEhQN2R5dVRuNXZDaDZFMHlqd01YbC9VL041SkdMZTRxWG11ZURV?=
 =?utf-8?B?dUNmV0VmN00xemRTU0phSG1kaFJvaWJKM0tIbGVpKy9WQlhjWXozdE5zUVdB?=
 =?utf-8?B?Wm5IVHJiWWZzMGtzZ1NzSHJGL0ZWSTR0MjhJUGx0RTAyYVVYRnFCbXQ1NWdI?=
 =?utf-8?B?WlppeHJWSURyQ1R6emwxTzBobDMyVXlQUkM2aGQ0NjNUSHFITVZGVFJIb2tR?=
 =?utf-8?B?TzFXV2pTbWJ4ckt6QkNWTmpsUm52K2M5cldwN2IyRGlFWVNiOS9HQUVxL2cx?=
 =?utf-8?B?M2NEWGllZ2xkMXFXcnhjSkVVZzhYSmNQQUJBeGdmZHJFQVRSN1REc0hvVFhW?=
 =?utf-8?B?cVhWVjByZHJLSWhsMW1tY2hFN2QzSERUS2VyblpSUXhTbHRuN0J6YjhraFpw?=
 =?utf-8?B?Ujc3Znp4Tm1rU1BRa1dvblpzL1lKdDg0NVlaQ3BBTTBvZjJTUlV5YWV3U0R1?=
 =?utf-8?B?WWRNOUxEbkVJT0xLQ1Q3VTBTQklDaHp2WEYxd0orVmtrNTdFalNaSE9qMEEv?=
 =?utf-8?B?Wng1UzBOYlhqOWt5NmFjeDRjTktiZzJiWnFhY2tSMURKZzV5TC9kN3ZmcG5C?=
 =?utf-8?B?RG5DeGtkekJISnlzQmNuYUp2TE1wdzRrZ0lERS8rK0pieFpkVS9peW85cEpx?=
 =?utf-8?B?MlFMY3dZc2YvektaVGJLbndDL1lWVlYweTY4U2EraWV1ckdzM0t2SzRMTVlC?=
 =?utf-8?B?TDgrOUtuWGNiWjRITVlUUmVvMVFTakFOV2RMZnZiSTYrRk1uWDJrNklrdU0z?=
 =?utf-8?B?dC9NdWozS3J1ZFFGNnBkVUlMa1hqTDFGeW1VbGpFK09lcEZJdUFETnpaTW1p?=
 =?utf-8?B?RkpFemxtVCs3TXBndTZ5V01uUllCb2ovYXNyMENkeFpvUXlQcnl0OS8vVjRG?=
 =?utf-8?B?dUl2SnFQN2d2ZzNob1dDRzh2SEZva1hkRCtQY0UxdXg2UndhVVl2cDR2ME80?=
 =?utf-8?B?bXRBS0tkbWFhS3I1M2RQZ2hROVhnSmR5QkNUK3VGRE1OOVhJR1ZtWStuWHhE?=
 =?utf-8?B?QUdZajdUL2pyWUU2Qm96bm9tZUsya2NpbDRyK0t4UXpnNkR4b3hWQ2MvZloy?=
 =?utf-8?B?VmJkM1pSSSswdkhnYldZeWozRUF6c3NKdCtYV2ZDWGZ5L1RhZnJaR1NLZVAz?=
 =?utf-8?B?TGt5dlROc2pzTUlVYzRwRkhDZXZDcDhuVFNKMDVGTEFMUkc0MlJNME1EMksx?=
 =?utf-8?B?SmxGeHdsM0RYeDFjLzg4VCtyNUxjdDNkL0FKVEVuTldFbUh0T0E5MXVvRkhv?=
 =?utf-8?B?YzVLV1F1UVZ4T1QwSHBaVHdvdDBsd2NlalFCR2xRT0ovd3RhNzljUi9yYldF?=
 =?utf-8?B?TlN1eEJnTjJ1d1VZT24vUHNhbzZHWlpUMTFla2JNN3BBV3VPb1pxeXpJRitS?=
 =?utf-8?B?S1U1dHVPMXBmeDhLeUE4cU5yRDZOeVRpRE9LUjgvRjNFYWdzT2J2VTY5ZTJS?=
 =?utf-8?B?VlhIM1NDcjZTbGpIcGl5TDlwOXFEaGtMYjNLU0REbENTSUhjaHlnVERjM2ZN?=
 =?utf-8?Q?3+79sdTY5PRSXtWdrfXdLoUBc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c182a436-f452-4672-cbf0-08dd580eadba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:43:42.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zMG0O0MI6RBXw9f0cJjuuOrN4lzyKgpCcT9EPAiwtC2CxP78dgCFuhlqQU5ZUg5oNkrcIM95fyD1cdGD/rpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

This patch series adds .match_phy_device for the existing TJAs
to differentiate between TJA1103/TJA1104 and TJA1120/TJA1121.
TJA1103 and TJA1104 share the same PHY_ID but TJA1104 has MACsec
capabilities while TJA1103 doesn't.
Also add support for TJA1121 which is based on TJA1120 hardware
with additional MACsec IP.

Changes in v2:
- add .match_phy_device
- removed errata from v1, will be sent to net for backporting

Andrei Botila (2):
  net: phy: nxp-c45-tja11xx: add match_phy_device to TJA1103/TJA1104
  net: phy: nxp-c45-tja11xx: add support for TJA1121

 drivers/net/phy/Kconfig           |  2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 94 ++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 4 deletions(-)

-- 
2.48.1


