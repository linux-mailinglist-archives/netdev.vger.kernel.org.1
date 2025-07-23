Return-Path: <netdev+bounces-209353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A5B0F553
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2606F3A933F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906762F2C5F;
	Wed, 23 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+d/dyWp"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB962F2C56;
	Wed, 23 Jul 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281111; cv=fail; b=McFq/SwjpOwlyXYk26uQHVyNI1rIrSJZ0NSNuOM4S8kKyWf7XSBtrkDCeeQHfX3l2uuX8WDP2syXY6Ey5WEJhVAFMYXJytEf0FlWm+VYjJrnBKT+Lj9oQVjd0Hzdv1iDECAx8VbM89uetUPxEk0tnL3YgpfUcwHC/ouaIoHVYGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281111; c=relaxed/simple;
	bh=0HvNvBCtYR6t9a/c7AVKie2SHR5e1d+eFaAuXEhEE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugePdhhW8CKUJgl839UnX+rFEbWlhiJJNNPg3Mw4BuhZDAjDSQEJE3sRwFSEbrWUaeCDb9W9gbY+MbNnrIWmiXKd2piU3j+W7ykKI02R4qrJJ2kRKwwSShF5hgeHXotxGgyA2XdjDhhjyLbFf+V4mVaRfnJ8fuBAsDeSVlvRWk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a+d/dyWp; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLQdI2if6Wz7ubQQuPQ9d45XvxIncvpamMoNvYnlPtsYBVh66NLDjJKKLJwf/wSQ2pfdRrr9ALvdWXZrKB6JAZjOcxqgSnkAGtnjwcaK8C+BPuoz5ebeR72UmDCs4w/76NIF1nUeGSkkFQTTFzaYT/WI6KJCiBcs4/S223Ca4fPDyOTLjPFE5vQlQS5YVAggRZYbVT+/HZC7LsSM3alRci/at2kunMfA71C6l3m/3BIkSJi+ZPdQ+/FVbAHR359HYL2z15of0EaaGL0mJAfvjej7edrQYCLMqyKpBaxHq96a8TWmcbJXNAtw6wRz/Ov1oWJSH031EBlzId8Ey2qTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRJqOTD+WWUb+jW8G5WoIMd/cS37GDWcBEDvHbkj+FA=;
 b=Ty5cif7nXQx6eMvq9tdSmf6Ab3CFU0GF9UvGhR83A0M1OiaGwTS/zWGKFdDzz9zDlIM4KFhlCSJ4y6KXqzpcscAQQtSQQAtyavzTnzHFhPar62CFUbdfVo1LOmNV3zWoBvSOTSYh80mt+K2kD/hnB13RkJhPT9y6Y6PQLsTmODY9OhoNRoo23Pz/exxu5D5ElPry/KQHBIRqTGNsgZkf9JrzINjr7mtAM3Rjr9Eg1xwD5XeF+Kquv1E0yREb1kBAu/E28ljhTGUtyeSLfpx6SbgYNU/gU4nuAZSuDduWfyfCiyzlNomlH2WJNdJNQb2YnC2sh9pEW4KBenqlYmCmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRJqOTD+WWUb+jW8G5WoIMd/cS37GDWcBEDvHbkj+FA=;
 b=a+d/dyWpcPkO7pUpzbD+rJcc/ZER9I70WdLkQXDovFdtsLs3ojWI9LqQ9KuMhxdffMSDkF2KRldBeBUKit7Z7i+EIBcApzw+/sSOuqg4nWxRdkJ2HXdp4Fn6GObu26v/4Z72ATx2Wz43G7h7+f8NPnYDi1KCvZwHDOthpMvUyZDws1k6EgucZtqVLHceV+SWmOwWI+2eaMZak9XJHDO97RCnEEwqw441XLCkRa+gPgD6jv/Xs2fBcty4GUSaNUnPbpH1EZCklHJmw5ZNG/4C12sdErxFjJ3p2TcNpjH4amZW78C0TgAOb1LDy9gwIPB6oKbUtSSPQupMbtwPwD5xdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 14:31:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 14:31:44 +0000
Date: Wed, 23 Jul 2025 17:31:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: maher azz <maherazz04@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Ferenc Fejes <fejes@inf.elte.hu>
Subject: Re: [PATCH net] net/sched: mqprio: fix stack out-of-bounds write in
 tc entry parsing
Message-ID: <20250723143141.dnhct6w22uzi7ufk@skbuf>
References: <20250722155121.440969-1-maherazz04@gmail.com>
 <20250723125521.GA2459@horms.kernel.org>
 <CAFQ-Uc_qYu--YG4LNVOB=UQeUGyuQ9fSPT=e52HwHu-j3kjQtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ-Uc_qYu--YG4LNVOB=UQeUGyuQ9fSPT=e52HwHu-j3kjQtQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0137.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d23789-b1e7-4fa2-d1d3-08ddc9f5a618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEVFOUtwei9MTVo1ZTdGVU9OcnlvUXd4K2xxNmJISkZsZEF5UzFTL2sxS3h6?=
 =?utf-8?B?UDNrTG5tdTMrMVJCL2VaVzNtZHVnVXcxenNMaHpldGhWTGFKL2ZrYlhQUUQ0?=
 =?utf-8?B?S0dMRnVQZ2NpZzBqdmdxS0JnUUtKVDh6RTZFaEZMLzBYYkJuTWVDNWc4cDdC?=
 =?utf-8?B?MjhSazBaT0ZzU3hDSWY0VFk2UmErV1pXUWtRVUczbU1MemFUVy9Ud01Zelpi?=
 =?utf-8?B?SFZtckNLTEdLVStHak1ITkFtSFZSYWg4U1FsbXhiS0xzdG50VjY2VnQ5dktr?=
 =?utf-8?B?K3J2dFp2ZnJvMXZIVldlQ3lmbEtMRlY1U0hNdW5iTlUrSnBzc1lUOVRqa091?=
 =?utf-8?B?Mzd0NVFldkNBTk55Yk5pNUtCV21WNTVXcXgvdU5JUEtSVmN0Um0rM251Uy8x?=
 =?utf-8?B?L3FYMHhuVm11V0lxeTJpUnUvZkZGT054bkhqVTdSeHB6L1g4UlcyTUJRS09C?=
 =?utf-8?B?SXFSU29aQUQ3QW5SVHR4a3BkcmxqV3l6LzJ6SDZ1cWFDeVRxNE9ENElMWld0?=
 =?utf-8?B?TG1vWXV1LzZ3cGpiTHhWQWpaa2Nvb0ZGcHRPNTlLNFg3eEl6dVdKZmJBOTBl?=
 =?utf-8?B?STlMT1g5M1Z4S250NHZmSlhxb0F6VGgyOU9BUEdoTXpzMXNGMWtEaWp6aTQr?=
 =?utf-8?B?Y3R4d0dCd0VTZXE1RmV5cFBLN1Z3N1l0MENSQ3RkTU80S3RmY1FCWVFBdXdW?=
 =?utf-8?B?QnJ6YVJmWWR5MUkwSkhmdXJ0dThlVGtQNHZlSWxvVWpoZFQxeGlxMERRYUpv?=
 =?utf-8?B?QW8rU2JFNUlMTFgzZGNNUjNBazFDR3EzTkNIUFNNeU9jbCt6UVorSEMwZWor?=
 =?utf-8?B?K3Z4VEpMTGk5aDRxTWp4WkI2QnQ5enVFYmRieHhpTzViUGQ3SVlIL1BEWkNB?=
 =?utf-8?B?ZnFpa09yZFhaVVkvNkpreXpvRnZNNWxDVzRSM2lLWU0zTG5PWnI3Z1p0TGc4?=
 =?utf-8?B?MGQ1cWhiUGtnWlQwek1rSU1zTkRGVWVIS1F5QzA2endOaE1ITlZ2K09UTXF5?=
 =?utf-8?B?UmpxaE11WTdRN2RnSjc4OXJ3d2tuQTA2ZUVnY1JNL01HcmMvNk9idzY5Z2Y5?=
 =?utf-8?B?bWp1aWN2eURDdkFiZThUNnBLNDB3Q2huWlhLU3MxNnZEY2YxNi9odzFCb2x3?=
 =?utf-8?B?Rnpsa2FxYWsydzU1YTN6OWFabU5MeUF3VmZiY2RVWjBGQkR0b3V6dWhBTnJp?=
 =?utf-8?B?VnRMbEIwU25hZ0ZBV2tpTk14MzVYR2pqTE00RFNyWEc4WllhRGFkeUlEa3Fj?=
 =?utf-8?B?aUtZVU5neUZTRitrUVlHbGpmbnZtSlNRV2dpQVhPenp2aUk2VmcrT21wUEta?=
 =?utf-8?B?SWZ6V0l1Tk9PMEt5Zyt0dGJodXM1RWdRaTNvVnRkVFRRTVZUSy9rMmdjWFM5?=
 =?utf-8?B?dWRRSUFQWlY5MUJxclRRYVIzbnlMSmcyandJdkxySzlDT3JrdVlrQ2I5QmZD?=
 =?utf-8?B?Uno4b2tONXBxTEVDRHYvL1cxMHlKemhGcEw4R3ZyOEx0N1ZZL2FyVU0zbVhp?=
 =?utf-8?B?SmpxR3J4M1Bnc3lRNmNNRTBPVVUzQW5sL1hSVWp4YzR5SVFReEw0UEIzVlN2?=
 =?utf-8?B?aFd6TnVtZXVRb3liL1Z0cS9wVG80YlRLSUMzQVFlZmlVQjVXSmhYNHBjSG1G?=
 =?utf-8?B?M1hjeVFvMlhWT3RIUWFLSlE4OTVWKy9rTkY4djBmUXBXYzdMa3Z0c1QwRC8x?=
 =?utf-8?B?VWw1bG1BMisyaXBLWGpxMk1pckxnYktZMHd1WFJaY2JQa1ZXT2picHR4VXow?=
 =?utf-8?B?bDNCM3BRVEE5OEdXUjBJYWQ5NVNCVEJmT2lkUE1uSmg0d3hSZkVBWUh5Z25C?=
 =?utf-8?B?YnRYeWE5cGRublZPZ1AyWmNmalBOcy9uL2pwMkVRL2N3QnIyWTh2T2xHc2ZD?=
 =?utf-8?B?UlN4MUVNRWREMW94cTNMUnRYOVdoSnF6eUtHY1JBcFpZc3ozRVpiVjBKTHl5?=
 =?utf-8?Q?GqrAkXS6eHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVdhR3VqbG1wNG9SYzRlN3BHM0tJcS9uSlMyWHB5RzNvMlhOUzFKOVVlQjlD?=
 =?utf-8?B?c0g0aTd0am1vVkxNZmprUTFRV0kxSzNZWXNEYzM1QVhrZ2tMZU5XanZrOEwy?=
 =?utf-8?B?MWFySVpRdGlMeWc2bVRHbHJYTkxvdUIvSmxjK25VcW1UV0Y3cUpmSTRGVXVS?=
 =?utf-8?B?ejF4RVYxRW9Sb0lLdjdxQmVoMnhBYjBBa0hYZ3hLdGVzNWcyeE5pSXkxUFo5?=
 =?utf-8?B?RGhUNVlBbkVuOEhmeThFUXU4N3lTVkdWOXRRU2wzWXYzNGplaXo5VzVlZUlu?=
 =?utf-8?B?cDgyTzlKdi91VE1mQzdzMHNxVU9rNnpHcm5ZZHI3NXduNytmUkdCSWVvL05M?=
 =?utf-8?B?QVZZeE01TUJJRFRMemE0Z1JtMGJMa3NnMis3UlQ1TlVYdE5vM2JVZCtrVWZ6?=
 =?utf-8?B?eTNWSGxsOWt0SnNxT1FERlVkRWZTdGZGNmtMZzNNRFZLQm1RcjBzUm9kMFFX?=
 =?utf-8?B?YnVVMG5sVEhTTXVvUXRNZ0V2NjFqbmJkenJxd3YxL1FDaVkzNE5NVHZZRUVJ?=
 =?utf-8?B?aGZRdnRwL1Yzc1JkT2RTeUpuaTdoK1dnVGNmaWhTYU9OZkJiM1YrbytuS0Vs?=
 =?utf-8?B?ZnRsNFpTUW00RFgxUVlkMDRVeTZsdWh3MTV0cXl6SzRMaFRFekRZZnpFLys3?=
 =?utf-8?B?M0Qyblo4aGZoWUVTQVVSVWxick1JZmwvcjkzcXB6ckptVTBWVTE3bmtjWWpt?=
 =?utf-8?B?Vk12L0ZXOFRINnhMQWh6R3kwYk5OQ2g4Z3U3M2ZIN0VRRDZJNVFhOXJBWHVV?=
 =?utf-8?B?YXFwYVNNRWhJTXltcHZaMUp2RGpQUFJCQjE4TmlXcFV5WlR5Q1Y2ZCt2bzRX?=
 =?utf-8?B?Zlo5Rmp0TFZlcmllclBLc1ZuaWhSR2xBc3Fya1R1L2hMMTFzaDZad0Y4dE5a?=
 =?utf-8?B?M0JCR0k2TWhUVldSQWFMenQ5LzNYcC9rMHo2N3IzaFduWUYxSzJqL3VjNGtj?=
 =?utf-8?B?ckFQa01td05lZ3FZeGplLzQwNDVXano1V1AxOHp4ejJDVHZ6all4cTh2QW5D?=
 =?utf-8?B?bGc4MDM5U3BXL0lmQmgyQmJWS3VFbG5mekhiS3RDOHR0SUEzS0RUaUxqd1JR?=
 =?utf-8?B?N3dvTS9XVGNDZklRK0tJT256OG8xeDE3dVRJcU5UcWZCeGdOOUExYmZ1TFhD?=
 =?utf-8?B?cWlkTmo2R1BzbDBlTGVNZ3FyZXVHRzkvVHU3WkJsbHVjcHg4Q3lTZGF0Nktn?=
 =?utf-8?B?cXFUdU04aFdXdm9SeU9xU2ZSNzlNK3hiYnBoUkJhT3pkM3psYllSZ3N6eFhG?=
 =?utf-8?B?K2tVSnQ3Y0YrZm05N09jZ0pSU0pWd1JzYm5IT01lOVJpcVVPOWFld3Zmb2w0?=
 =?utf-8?B?bzVDWVplTHZnVW92V3lXMUFmWDFlcmxFQkhaVUU2RUhlbDJiaUFmS0dCbFR0?=
 =?utf-8?B?OUMvQlFRZWl6UDduSkFYVnI1a3FqejdMLzR0bFBhWGpDYkh4ckdmSkZhSkta?=
 =?utf-8?B?TlkvWVFpbHprNDlWQ3EvckxIZkhtWHdrRkc2YytEUEZ4NXZpTVNGSVVFZWtn?=
 =?utf-8?B?MHdmUHQ3emozZFdOU3hTaHdtemZadG53ajVBWHpLbjA5dUJOS1I1RVVOMEk5?=
 =?utf-8?B?SElYZ3V5ZGFXVy8xb2g0dElBMnlPQ3hCVTk0MXBjd0tNRUZYakhMM1p3aHR2?=
 =?utf-8?B?VjBTOXpEakNHbnAxUVF6V1RvRC9zT3p0YVloeTF1Q3c4WDZyclh5UlU1ckZy?=
 =?utf-8?B?WEpnVzBQK2Q4dVN5OWxrRHpLa0R4QXo0VTRYWk4xc3BycGFoWitjaEEyMFkx?=
 =?utf-8?B?Tk82NXZpS1FvZVJwcC9XRU1RYnNKakx4RmpEcVBwaW5DRllqV2w1SUdFTWVO?=
 =?utf-8?B?aDZPejBBMGFZZDQ0Y3hJNTlWaFYvMHVJcTJVM0trRUJ2US91djVHeWxlQmFY?=
 =?utf-8?B?Z1FxN0dsUURUcjJmVGg3NlBBb0szVUpjS1Fmazk1WUtVOHJCbEtoN2V1bVdW?=
 =?utf-8?B?UmlZY2hpR25xV3JFZlhrRGt3aWZObWRkREhwbHdmV2dLMURYamVGNlV6bnlR?=
 =?utf-8?B?ZGplYm1NbW5yUHJEZDlCYzZEVTJiSXhtd1c1VTF1RUx5TWd5TExCazBnWWE2?=
 =?utf-8?B?eUZzd1FQcW9iUWt6djgvU2c4ZHF0bE1ua0xZc2ZiYWVXU3J6TGZTaXU3dThq?=
 =?utf-8?B?Slo5R3JHbXF0blZOcDZSSnoxTlU2K3AzS0huWDhRcHpSUi90WVVqY0hwQWY2?=
 =?utf-8?B?WjdYdHR4WWlwQUZub1lVakpqZDlvRjBrb3RnL296Mmx5aVBBOUExSlRnVWN0?=
 =?utf-8?B?VisySUtnQk84QVNUNEQ0dXlFZDNBPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d23789-b1e7-4fa2-d1d3-08ddc9f5a618
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:31:44.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs4d2MraPtlIoqxAPxVqoIA9Ex77SbqBuv9ySpp2IL1Tsb4RZu6KR0VvJ37Qz0VB2AqedE/9CNKlSEvkwFcpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645

Hi Maher,

On Wed, Jul 23, 2025 at 02:01:52PM +0100, maher azz wrote:
> Hello,
> 
> Thank you for taking the time to look into it. Should I remove the
> “reported by” tag? resend another patch or is it fine like that?
> 
> Best regards,
> Maher

For an initial patch submission, the quality is reasonable. But it needs
improvement before it can be merged, and I recommend submitting a v2, no
earlier than 24 hours after the initial submission.

Some comments:

1. The "Author:" (in git; in the email it is the "From:" field) and last
   "Signed-off-by:" tag need to coincide. In your case, they point to
   the same person (you), but the formatting is different, so they don't
   coincide. Please fix your "git config --global user.name" in the way
   that Simon indicated.
2. Please don't top-post. Trim the quoted email to just the relevant
   portions you're responding to, and respond below the quoted email.
3. Please configure your email client to respond only using plain-text
   emails, no HTML.

