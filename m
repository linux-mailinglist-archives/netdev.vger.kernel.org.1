Return-Path: <netdev+bounces-186379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C938A9ED94
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA10E1892A14
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D826561E;
	Mon, 28 Apr 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YqD4ZQQn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18B264629;
	Mon, 28 Apr 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834839; cv=fail; b=Iw2x/YIFXfnDMYdiWyzJmgGsJpkTSYjZ+tJ7+F0iM3eaFIJj4AhTAHbwW6Hm4bQiWZWuzoc50VqKsqoVVsoRpNxmNt8bcGL76V3lxrTRkKe58afnid8y/rpN9yft711h5qAM4yo6gKBKexEPoq8ODnpWp0qReuw1F4AcqCF/itQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834839; c=relaxed/simple;
	bh=2/l5GtjZGLBBEZpH/Kn6J6YvSDdH64hZArKpTESh4is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VMNwWap6NIkgmtKpiAZe+FTUmHmklODyQOMO7j/ke0Fn2hrNFcnsq2U2RbxWle8d66S7ZGY9u/jiO5RSmVhmr7ASmgvPLGuR+UvBjaiedfkPAO65pUML+6qYVYCzG9tmAv/IkEfg1c5SxO2HnIep+CnLAhvMSps1j8xikg32/Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YqD4ZQQn; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsDEoZt6o+ZlP8d0G6feVPwFMB4djqFU0OZdmPAV5R7JFyeRDXPuRG5cKPJFY9n7G4iF/Hl6arDvq95ZW738Sjumz1TJgxNmmL5g3kPRwpL2z4yoYUAtXMUCpgZRjN1TWLGWvnPqq8loYQa1KLYqy/+z4e5EI8TaiM03rd11tKooOhfzVEZ+XmWJWxLJZm/982C+yISyLIX5N6hHQK8zDpQYPvg4P1ff1YPOfJ/fSqWvNBs2xSrYsuPcnHIDA8/1cAKZpH+dBe0PmiMBr7lmXB3EczB/cx1p4L4zHnY/sZTCkuUWtA5m24w48hQHJQlBWBi/sr+gCeQwRbaWPaEW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JQnTMcNxw2iwVIbBoU1FYd18XVg+pJHlN3rCHEMTJM=;
 b=uoT2E/I9eqMPTSTVYcRNlGPBQ4UNynAjsYux4yIOFLOc6d3ndLkSSMr1r6lh/i6K6iIacdMZ72Xm4WvNkHTqVGkgx5Z02D8qXcuUiNn7pwiEln6uvOX9uxAqisk5h/WQjBJj3SskbYvmLho8mvtt1z1oZNZBRQ+j4+2fB8mCQAQ2Hr533T4LDcZsXODFgrrjDT5xR2ifwvwl9lGJjigTcQUgJLDq0/GL/m7PSQMqGuf/KOOTwgG4VxNOf4aVEhbC9ywVB0LeozKXnCvL5iMDD49SIFCsVyJNDI5NQzLNt/pJHrHb/JO7EddHX4RHHwxwPYRZh0yRQ8MgZzYDifupXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JQnTMcNxw2iwVIbBoU1FYd18XVg+pJHlN3rCHEMTJM=;
 b=YqD4ZQQnJbrDiJRLOZY9zx6fDNrGt2mJjmV9I7SzvTzZTXJRnhm/NnB94RDrN/pJcDtAI4VF65MCjKYlVLDWjXuP6iGzmePaIhNPOzzOmRe/y4kGAv/2nGgFp21MWz4U86nSKgh5rI7GJDq/yZrslt9ksIJlcAOkXBUNy5h8PCOQob8LNEMcAcZZ3YVEt7rP1bPnuiVq9SExaPV4TPETkmGhkhwl3Uo/V6DrONS20yu115KiEpsr7fZQ+Yh2bCJ9fh4FGq8OdZjC8OqRrZVJAmGZHesfZiMVUatbdYDdBXAacMV7qHGxBgQH318PJDQj9nJA+OTGivypZ4gZ12vnkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8081.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:07:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:07:14 +0000
Date: Mon, 28 Apr 2025 13:07:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Message-ID: <20250428100711.cushq4ok3s2n5fxm@skbuf>
References: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250414124930.j435ccohw3lna4ig@skbuf>
 <20250414125248.55kdsbjfllz4jjed@skbuf>
 <CAOiHx==VEbdn3ULHXf5FEBaNAxzyoHTqJEMYYtcQzjkj__RoLg@mail.gmail.com>
 <20250414150743.zku6yhs7x3sthn55@skbuf>
 <CAOiHx==Wk8b43x8HLX4i-o696LioqeHoTpM+kzwn+NBE7dV8wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==Wk8b43x8HLX4i-o696LioqeHoTpM+kzwn+NBE7dV8wg@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: a02308ed-1f62-43ab-b087-08dd863c72fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDRHVEpkUjR2NmVySlNLUGF6Tzl6dWl3Yk1PZnhJSkFzNk5mNkVyNFA4OXZB?=
 =?utf-8?B?WHhZQnNvT2wxS2paZ0dnUTlUMER1aktuSTFRdmwxc25YbElqQjN2SkE5Ky9a?=
 =?utf-8?B?OEF1dzNyMktMcWNGSG1hRXB0WmxqK0RUTVYyQ3NhbjdGeW5sT1RQWGR4MHo1?=
 =?utf-8?B?N3k4QktvcnY5emc4cDljcFpxQ1kwcU9vaWhWck9VZWkzQys5TkowNEU5Z2NI?=
 =?utf-8?B?UEpVMldJV1RXNy9Qbi9HT1pYcEpzTURTVDNBRnFRRkJROEUzSEd2UU5naHlz?=
 =?utf-8?B?QUJDcEpUb0EwNWxuN0swRTRBYmdEczhDaWpXRyt1OUFseUJMUFRxTG5yMmZo?=
 =?utf-8?B?ZTluTUd1U1FhVHBZTnpLQzNSWEMyS2s1UG9ydGlGeFQ4Y0xCKzVZUkJMVnQ0?=
 =?utf-8?B?bVd6c0RGQ2tmbEYyTmwzY0o0RGVBYVVRdHN0NHc4SWdnRmtjR0xVNjJhYitS?=
 =?utf-8?B?TTNRVHB5b1JGdGlqa2dSTU44alllS3NEQzh0MXhiZnh2SkN2QS9sc1FNVjRG?=
 =?utf-8?B?N1JDb1FYTDBGY3dhZEpCUE5vRXNuUlF0RGV3Z3pZei9xTTBqWDg5OFk1UGVU?=
 =?utf-8?B?NkI4Q2FFdG8zeXV2SU5OZVRzeU8wb3JXWmF1UnljUzJIVGRGcWtPd1orKzNX?=
 =?utf-8?B?RWFsVFlob2d4OXJDc2lYNzhrbjFwM0duV1hVTnBvL1diWHY4ckhwSTVLMHk0?=
 =?utf-8?B?VmVrR3Fyci9kUDIxYmdwd0NmdDY1QW5LRDFyWGE5QTNmZ1RNYnFNY3J1QWNz?=
 =?utf-8?B?Rk1pSDkvUDlRY2RBdHYxYmtsSTlQUThvUE5kV0JZWlhhYzU0VmRKb00xRmM1?=
 =?utf-8?B?d0pqUEhRTmlrVVdsUnppaVVZYW1ENWEwVytiOExycHJ4VUw5QXlyZGVzZjNx?=
 =?utf-8?B?cU9zbjRYaTJRMG9aVFZhZFB5RGVoeGNCWG53VTVJbkJrUCtIR3ZjdU5xWlhu?=
 =?utf-8?B?QVNmbGQ4V0RnNVB6OEk5N3ByYXFodHFNZzMwMWNYTFJmQXNyY2psNUVSYlU3?=
 =?utf-8?B?L3BhRnQ3SUFLVkxIZ1cxRklEREZEOGp5TVpubEFJWmNMUnpacFpMYUtsWTNM?=
 =?utf-8?B?OUpuMzlXeENSYjUrSWdxUmZOQmdqaUZwNjgvN2VVSUN6WFpKZWZNMU1UeDgz?=
 =?utf-8?B?WisvZWtmN1kxM1VKNkVZRklGaTMwMU15bWxXQjhJQmdhUy9XY0Ivb2UwbGdO?=
 =?utf-8?B?WFhxakRxNWg3VkFKcW1VbS9XTytXWFBBYTdpaDhsNlV6eTY0UHM1Kzk2K29C?=
 =?utf-8?B?WWFaL0dwZkdFd3d4OWx4RkVvS2RubmVYZUVJNHVMby9oRlN2c0RTZmhRb1ZT?=
 =?utf-8?B?YWFrVHdPSkthaDNhOHREbEtraGtVWDRSeUx2YzAyUWk2Y1VLUzhjd0gzRHhO?=
 =?utf-8?B?NUI4dDNiS0M2Y2o2Z29GTFRBRTRockV0VnIrdzcwYUNrakh3Ulk3SjExS0J1?=
 =?utf-8?B?OWVCME83MyszWE5nb1RWNm44YjlsRXB3TGtoSHY0RU9ydWJQVUNCNWEyTjdG?=
 =?utf-8?B?TUN6U1lMbnAyNjlaZzMxQlRYVWg1QzFEQm8xdGdmL1puMFRsQ1FORU5nNXdV?=
 =?utf-8?B?Rzk1eUx3RTlsT2Qzdkk1TDdrUGcxQkZaVUtUQkpQdXlZYnRyQnEzNVYvVGkz?=
 =?utf-8?B?cFI2RFIvOU9sRmV5aTdnWmZ6QjhrSEZKVCtnQTJsZmFCdVVWTkxhQlJFdW9W?=
 =?utf-8?B?Z2dtT3daNFd1Y0I1RGdTd0trN2wwMXVYZHBDc0JaSHYrR1g2K2dsY3RUTFVI?=
 =?utf-8?B?dWdlemVOb1NzUWN5eGFGUFhsSzJpZ0FsUTlzcXJXVHcxN21XVm5rSkJ0U0x2?=
 =?utf-8?B?U2ZOSjg3TEN2OGZxemptaE5lTDhoaEtKMHFxVEtsM2RaWDA4cWVSYVg5alVs?=
 =?utf-8?B?VlpEYjVUSGorZFA0dUhFcWNqaVkyOWtHRkQ4V2hYNGg3RXR0dUpjckZTRXBM?=
 =?utf-8?Q?5fo+FX2IfOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elhLMUlHRXYvWEdWVWVvam53bUlOUUlhRkxrT01ESU9uZ01pelRWZ1R0Z2xh?=
 =?utf-8?B?WHphRzV5VUprWWtiZGlMU1hDQzI5K3hwUDZ6OXgvUmU4MXMreFYxSTVYNFpz?=
 =?utf-8?B?WkVjeHdoWTdMUXpwbTdJdHY1dU0rTGRTeU8vSGVsb2xVUXhNSFc3MVNNM1lp?=
 =?utf-8?B?SGJKZEpYbzBOYk5mejB0N253Q0J0STFpTlBSSDd6SnUyeXZPYTFaY3VObk9N?=
 =?utf-8?B?UG5CQ3B2aTlrTjVxcHpRazdJczZKUDlacUhJd2dGZU5sak54NHpHM3VOR1pv?=
 =?utf-8?B?L1Mwb0QzN2g1dUdFaUhVYi9kdUM3SUJyRVRRVGRhVHZsZVI4ZFNrM3ZEdTgz?=
 =?utf-8?B?eCtNeGhieExDR0I4a0V1UisvZkM4eE9RN0duSnpVVmtsQXIzMkpJSzduYUty?=
 =?utf-8?B?Y2txMFpMdVlPUElqUi9WRkNkVmg2UUpHc3cvano1Rm8za3k4UDN3TU5BQjVq?=
 =?utf-8?B?R21sVlpzSTd2WEtncU1RWlFxcHducHFWazRHcmpENVZlRWY3Q09ZZ0hmdTVq?=
 =?utf-8?B?dHdqRER5RG5LY1dsV1YzZmFDVG9xbUY3ZzlLS1VCY1lLRjNLY0tvbzNlLzMx?=
 =?utf-8?B?Y0VCa1BuNWpuamVMR1JVNjJtalY2RDg2Rk5JUXJIS2lIWTBrVWpINXhPRHhF?=
 =?utf-8?B?a1VuNXE5Zy9MS0Y2YVJqM3Rmd1ZJUlc2Y2JmTzVMNzBhRmU5dnY1c3U4UTda?=
 =?utf-8?B?RFBCMFF1ZnB5VGlmVk1Va09hNlhDT2RoWFgwVVlSa0N6WFpBQW1wQWpXVEtR?=
 =?utf-8?B?N005ZnNjakNuT3Y4amVxdTVZMmlPZVoxR1Ayek9lQ1daeVdWaGhnOFJXSTNV?=
 =?utf-8?B?V2cwZHMyTDJRbktHbzRrOXVvMWs5R0hKTGtVS09rQzhiSC9heEl6QXErZVNh?=
 =?utf-8?B?L0pOT1hpbWhvaFZXWGlhZFc2Q3YyN2VWaWNjYURDUmY3NHhJK1d3NHZEVmVH?=
 =?utf-8?B?RkhrZVhKNDZJZE9RMFBmTkpVdnFHRGhzMTUxWGRSbm5ES1BZZVd5WlJxTm04?=
 =?utf-8?B?MVo0QmU0MDFxS2VnblNLbml2aHYvcHNUU2ppODlZTFJGZ3pyU1hoK3BGbXpO?=
 =?utf-8?B?SnVQSC9rVHdJbjdBTmNWdG1McTBWeW9tbDJWOUJiRjVIelFmdi8vL1h5eWJq?=
 =?utf-8?B?bVI2YkZmMFFwbDYvcURwNGlJRTZnVDZFQU94dm82ZnI4MXNEOFZJbS9qRFFh?=
 =?utf-8?B?dHphWmtXYkFrVUJnZEhNTVFmQmc4Unkvc21na0F3dWpWaDU2d2JSZFo3djl2?=
 =?utf-8?B?eE5ETUdnc2YzdnRWM2xESzVTMWY0RnJ4NkRGVkdNOVVtZVM0OVRsTWliMERH?=
 =?utf-8?B?OFZlTW5qSFc0cHBlVVZTQk9KbnVaSTNpSWdZRlp3b2d0VFkrMjF4cURnN0lW?=
 =?utf-8?B?M1F4Kzh6OGU1eFhFdmlnbnNzUzdtamVLeFY2cmxLZEFhQnZvOGVVOWNQbGl6?=
 =?utf-8?B?aS9HSzFBKzJMdHc3aVZ1MExUSDZrbVNtbUR2OGg2dXdiYVEyWkdMYUgwUUly?=
 =?utf-8?B?ZVdqbU9NVjcyQThkYzhNMkJ1YVZlV2ttdHM2K1Zmdy9Wbkx3cUFkTFpaQ0F1?=
 =?utf-8?B?M2h2R0YyVXBsVVFFM2NwT0c5ZTR5UWJQcmZJYVY5NzNiWFZqQTZ6cDJWRHdl?=
 =?utf-8?B?VEdJYmhwN0JGZEFPZzFWV3Qzd3UwbmZ2U1hSalA5bEU4T0Ruc2ROUzFrcDRL?=
 =?utf-8?B?eTVleXZ5ekxvS0Q1ZUF1ZzZ6RVJYRFpVSFZ2L05oaU1ONk5PRWJha3Y5RU9i?=
 =?utf-8?B?NEIxTVFKLzZWamUvSXlxTHJLSW5iSmNkQnBjVmFTVEp3VldSM1ZEbzY1ajFN?=
 =?utf-8?B?RW1xREQzSVRqKzZiQ1Z1UG9tcXM4NTBGYmFKekg3S3J3bDBGVGprRmNuVDNG?=
 =?utf-8?B?dmdpR3owVitOOWhhQTFpc2JEdEJyQmdvNWFyUDRKdFcrbWpFTXE5WGd6YTJR?=
 =?utf-8?B?eWxuaEsycEl4YWh0QmpFcFNHMEliT1dvWm5LTnVMOTAwZit1bzFiaWdDYk9J?=
 =?utf-8?B?bW01OFJvWW1meW5nZ2dJTEtEZ3VzaFc3SWZwbFFudnVPbmR6NmVyazh0TU0x?=
 =?utf-8?B?TlBhRm5CZXVXRkFMNDROTWtvamJkelEyM0dwUjVISG4vQjNtMXJKekN2ODBr?=
 =?utf-8?B?MlV2SitRa2JKSG1GZVpwa29FWTlGK3hQVlljYWFQbGoxVkgwVkRRa0xzZ3B5?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02308ed-1f62-43ab-b087-08dd863c72fb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:07:14.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2p+xcH2B7bTczhURtqSVWzJYyGAG8kKKwOAL3+JchPpIyyF0Pu7foXMpJfsEDPEMiRL/4V8PNDhi9fXcFCQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8081

On Sat, Apr 19, 2025 at 12:52:09PM +0200, Jonas Gorski wrote:
> On Mon, Apr 14, 2025 at 5:07â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > You'd have to ask yourself how do you even expect DSA to react and sort
> > this out, between the bridge direction wanting the VLAN untagged and the
> > 8021q direction wanting it tagged.
> 
> Unless the switch chip supports passing frames as is to the cpu port
> (and only there), the only winning move is likely to keep the cpu port
> tagged in all cases, and untag in software as needed. I guess this is
> what untag_vlan_aware_bridge_pvid is for.
> 
> As a side note, b53 datasheets state that all vlans are always tagged
> on egress and ignore the untag map for the management port, but that
> is clearly not the case for most devices lol.

So it's in fact not a problem, am I reading this right?

> I am still a bit confused by untag_bridge_pvid, or more specifically
> dsa_software_untag_vlan_unaware_bridge(). I would have expected a non
> vlan_filtering bridge to ignore any vlan configuration, including
> PVID. Or rather the PVID is implicit by a port being bridged with vlan
> uppers of a certain vid (e.g. port1.10 + port2 => port2 has PVID 10),
> but not explicitly via the bridge vlan configuration.

I think dsa_software_untag_vlan_unaware_bridge() exists in this form
only as a result of the misunderstanding that the bridge PVID must not
be committed to hardware in vlan_filtering=0 mode. Otherwise, it is a
coincidence that the bridge PVID == the VID added by hardware to packets
in VLAN-unaware bridging mode.

See the reference to ds->ops->get_private_vid() if you need to pop a
driver-specific VID from packets received from VLAN-unaware bridge ports,
VID which is not necessarily equal to the bridge PVID.

> > > I guess the proper fix for b53 is probably to always have a vlan tag
> > > on the cpu port (except for the special vlan 0 for untagged traffic on
> > > ports with no PVID), and enable untag_vlan_aware_bridge_pvid.
> >
> > What's the story with the ports with no PVID, and VID 0?
> > In Documentation/networking/switchdev.rst, it is said that VLAN
> > filtering bridge ports should drop untagged and VID 0 tagged RX packets
> > when there is no pvid.
> 
> Hm, that's not what the code does:
> 
> With a vlan_filtering bridge VID 0 always gets added to bridge ports
> if they get set up:
> 
> The order is:
> 
> 1. filtering is enabled on the port => NETIF_F_HW_VLAN_CTAG_FILTER is set
> 2. on if up, vlan_device_event() sees that NETIF_F_HW_VLAN_CTAG_FILTER
> is enabled and calls vlan_vid_add(dev, .., 0)
> 3. switchdev/dsa passes this on to the dsa driver via port_vlan_add()
> 4. all bridge ports being up are now members of vlan 0/have vlan 0 enabled.
> 
> Not sure if this is intended/expected behavior, but this enables
> untagged rx at least with b53. And since b53 can't restrict forwarding
> on a per-vlan base, likely enables forwarding between all bridge ports
> for untagged traffic (until a PVID vlan is configured on the bridge,
> then the untagged traffic is moved to a different port). This part is
> likely not intended.
> 
> My first guess was that this is intentional to allow STP & co to work
> regardless if there is a PVID/egress untagged VLAN configured. Though
> this will likely also require preventing of forwarding unless this is
> a configured bridge vlan. Currently trying to read 802.1Q-2022 to see
> if I find anything clearly stating how this should (not) work ... .

Not replying to this, as this discussion continued in the other thread.

> > > Makes the think the cpu port always tagged should be the default
> > > behavior. It's easy to strip a vlan tag that shouldn't be there, but
> > > hard to add one that's missing, especially since in contrast to PVID
> > > you can have more than one vlan as egress untagged.
> >
> > I agree and I would like to see b53 converge towards that. But changing
> > the default by unsetting this flag in DSA could be a breaking change, we
> > should be careful, and definitely only consider that for net-next.
> >
> > b53 already sets a form (the deprecated form) of ds->untag_bridge_pvid,
> > someone with hardware should compare its behavior to the issues
> > documented in dsa_software_untag_vlan_unaware_bridge(), and, if
> > necessary, transition it to ds->untag_vlan_aware_bridge_pvid or perhaps
> > something else.
> 
> This is for the case when you have a b53 switch behind a b53 switch, e.g.
> 
> sw0.port1..4 user ports
> sw0.cpu -> sw1.port1
> sw1.port2..4 user ports
> sw1.cpu -> eth0
> 
> and you have user ports on both switches. Due to the way the broadcom
> tag works, if sw0 would be brcm tagged, then sw1 wouldn't see the vlan
> tag anymore on rx (since there will now be the brcm tag), and all
> traffic would go to the pvid of sw1.port1, thus any forwarding between
> ports of sw0 and sw1 would have to be done in software.

Can sw0 be brcm-tagged in another way that allows sw1 to see VLAN tags?
Like with brcm-legacy perhaps?

> In this case, sw0 needs to have its traffic always tagged. Also sw1
> needs to keep all vlans on port1 egress tagged, not sure if we
> actually take care of that ... (maybe the dsa code does that for us,
> didn't check).

No, this would be driver-level configuration. DSA doesn't alter the
egress-tagged flag of bridge VLANs.

> Although forwarding works between user ports of sw0 and sw1, from the
> linux perspective we would never receive any traffic from sw0's ports,
> since we only have sw1's tag, and that one will say sw1.port1.
> 
> So while you may be able to configure vlans and forwarding, probably
> everything else won't work as expected. Like when you want to send out
> a packet on a certain port.
> 
> Though I assume this isn't a special issue for b53, and rather a
> common issue of chained switch chips, and b53 just acknowledges it /
> tries to work around it. I know that marvell (E)DSA can handle this,
> but I wouldn't be surprised if many others can't.

For the record, we have a non-proprietary DSA tagging infrastructure
(tag_8021q.c) which supports cross-chip bridging, used for 3 drivers
already. I know Florian has looked at it in the past, but due to various
reasons couldn't immediately find a way to make use of it for b53.
It could be interesting though.

> Looking at devices in OpenWrt that are affected by this, these device
> have exactly one user port on sw1, and that one is mostly used as a
> wan port, so as a stand-alone port, not a bridge port. One could argue
> here that proper functioning of the "outer" switch's ports is more
> important than being able to forward frames in hardware to the wan
> port.
> 
> Unfortunately I do not have a device at hand, might need to figure out
> if I can get my hands on one ... .

Generally, switches which support a cascading topology have the necessary
prerequisites taken care of at the tagging protocol level. Two switches
from the same vendor which are connected together are more likely to
form a single switch tree, and the switch ID from the packet indicates
which device from the tree does the packet belong to. There's a single
DSA tag in this situation.

On the other hand you have tag stacking, where a DSA user port is the
conduit of a downstream DSA switch. There are 2 single-switch trees in
that case. That also tends to work, usually, though you wouldn't expect
hardware-accelerated forwarding between the top and bottom switch
(software needs to perform tag adaptation for the general case).
There are recorded cases of tagging protocols "ocelot" and "ocelot-8021q"
working just fine as DSA conduits for "sja1105".

For the stacked b53 case, it looks like due to hardware limitations, the
tag stacking solution was partially adopted, but with b53 specificities.
You have hardware-accelerated cross-chip bridging (which you wouldn't
normally expect) and one of the switches has tagging protocol "none"
(which again you wouldn't expect). See if maybe a single tree with a
custom "brcm-8021q" tagging protocol is something feasible.

