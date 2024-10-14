Return-Path: <netdev+bounces-135224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E099CFCB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ABC1C228E8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB01AE01D;
	Mon, 14 Oct 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S21RQ3an"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB71BDC3;
	Mon, 14 Oct 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917737; cv=fail; b=rleSlVQ76Q1L/AW1v2ZIb4eLekNgiFv093NL4Csh5SoRQjaEXu+S/HDL0nh2LfULpKwByyxwCmX4HcPZkUF6aLWU8N65g+xETnoz3t3iv9M268T6dZGAKJLWVtluepnWe957roBu1R3Afl8PBaaUPSeETAphITampjj3qx1+6wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917737; c=relaxed/simple;
	bh=5/GWsOHovA3JqT3lc2xUTZMP+vETRZAgI+JRDrmXMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pIFbpmWnAgGFcFqTNaPaGgbowHAcJD/dM1BCZV8/yI91a6eAV9EP7/MjGl8BMFi2DRv06i+cKQKNyl/TR9SGHcqrl8W7Ho+10Ap94wOKYWHEZUVZXplU3gCAmpHhfLvVw8BIyWfJQww8bZMD/DdoGxs5coVBr0tbl+Hk8BtqrIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S21RQ3an; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ4Ihp0B+Conk4pqAAKuH1vmAiGs9bQ7PykR3GoI+pwHw3KMchvQIVvwBf7MarQrMUmByyjDEyM/Gvw81d05lQyvr4bx4/U7kcgxQuPbSnWk+kNjQqo4mWcxyMbdKi/WeQVrQQ1Ck9le6ISAxI4CNJpR8vyLFA+8rmhNxe6gwC1Ac2h+VbAUohRjAbThO8LLaP97+lqs0aAvqTo+H5z6jNWizXSTCO50qwtAgoocT+jdVGVILO1AVw0v4j4rh9P4ek0ZdDVaWydKRiRj9zNbq+t7kJaw5gpJLl7iN4ykwpk00RxstGVEiNBUVdspjppIPHUx8WKg/V4wENcqZezA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL8R7AojCdk5uyr+cq96w1S6PT5gN+GtJnV4ryI0oco=;
 b=lHOO0uKeK5watweARHxnheHIMcYq45lAz2epcbzgrigYY6tCWdPZ/6fqLD7qfcLHQG1s4nFsvYLemP7L6zJqqdxjFU72u7oamiqzMggVtVme9iJ9wizrn1AmsL/vUZDkgw75jVDP2BzLUaJlBmnWomgfCSDO2j7mUvGv65iMtFpjIJ1E/WqfbrPV9iEMCrarRxkAMGi6+Bx5Jb88qJ9c6ekT3qt70K3ybyvSU+k7v4MVTuG/xJ/SNvAzeuUhNugjeZT+l9caa1tlmKS5TGzmEW72mX7DuiK90RxtVq0jvzZvTXbnNLSpTqh7VyMGdc5xSswUJ+dWhL12RAYtSewHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL8R7AojCdk5uyr+cq96w1S6PT5gN+GtJnV4ryI0oco=;
 b=S21RQ3an5ZeXO255sJrrmgVElE2PZixyNDGMMm0A9HdEAz/1MBj5kZt8w5Tlsel1DmKV4EFWs+8wpzqKFqIvtYKTTjoRo7iXA5iNa5Sic4sviBCFfQuFOjdeBUlwL79lelH5txjn8gSyrzFWoARk3Hvt48e3iLSE4R3OFKrRAe1xU7O7U3qpwC7zuelBFZal4JFJMVzZHvKIF1AtPZ0rqcRvMiZMuwUkrqkg4wl3uEK0yyJU1groHgavTyNILIUxCaYKA1lW01+0r4edGAzsG/vItq0HmVP5i0SBggEHHsl1jP7/qakDeH5ID+NkT6isNSG/IA4XrD6zdlpC97LGsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:55:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 14:55:32 +0000
Date: Mon, 14 Oct 2024 17:55:29 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: dsa: vsc73xx: remove
 ds->untag_bridge_pvid request
Message-ID: <20241014145529.zyki6k6yuob4nyop@skbuf>
References: <20241008104657.3549151-1-vladimir.oltean@nxp.com>
 <CAJN1KkyFgHSDydUN5CBhDpEkG2kEJd5iaA1TK24ynjYpVvK7aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkyFgHSDydUN5CBhDpEkG2kEJd5iaA1TK24ynjYpVvK7aA@mail.gmail.com>
X-ClientProxiedBy: VE1PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 906a69e8-be88-4ddf-8b64-08dcec6040a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtXazdJeml6UmZnUjdRdnRPYUg5VklPb1d1b3gzMXlwaVlPVHJGSko1VUpE?=
 =?utf-8?B?T3g4MTYrSVd2Y1c2Qk0zaFBlRVczbzd3NEVJZkZsYVIzRVNKaE1pZVFSOXg5?=
 =?utf-8?B?NzN5dHRDS3pJTHVqZStkcTNGY3BwMDdwVzRnby9qdHV1SkRGVnBwNjNCV3Fq?=
 =?utf-8?B?cGtHMkpJMXJkb1JtZzN5L0lQci9GL3FoUGsxTG1ob2lSc3ZvN2NRdmU5VHFy?=
 =?utf-8?B?ekZsbjRpa3hvNEZVdU9pOG9GeTlORE5BazVOc201TXNUdGQrejVIQ1hOc1oy?=
 =?utf-8?B?ci9RNG9FYVVFVU1QejA3N21ZY2dna2dJcmM1Z3QrVEZyT0lHNW1EYzRHckFz?=
 =?utf-8?B?UWp5b1JONTFZK3J4L3Vvd2VjREZiSU9RU25WM2VFbWpDTlBsNGdsSkxYZGZu?=
 =?utf-8?B?bTRyb2xYa2lyelV0aDBxZHlJVnVxZC9NSzVLWlBMNU5DdDVLcmJjOW92UzNv?=
 =?utf-8?B?RjRjUng1Vnk3Wnd5ZmNHemtvR2pSQWppUVp3SVpsaHdBL1lYb0h1ejN4Ym9I?=
 =?utf-8?B?RXJ0VVZKNHhzNTBpemxSRlpEUzlyNVQrK0VNeHltMnU2TGgwcVpaa3hvN3lx?=
 =?utf-8?B?d1NiaFk2TDQveUhlV2FEMFIydWNXMlhkRm5NNm15ZlJPYU13Nmx5dzBndlR0?=
 =?utf-8?B?V3lrb1V2SHdoa1djR3VCNzk2UHd2SkZtTXRKOWdIYk4vTGhTUFpzWitVaUFy?=
 =?utf-8?B?SC9LSmZFaTU0MnNRc0VoWEE5LzlXVjUySnRxRDFrdGwvQkFwMkdEODJlSWJR?=
 =?utf-8?B?RmdJSEw1bVRpNzFGN1hHdFozc0ZJbEo4NENXcHh4UWxzK3YzMUFUM2UydEpM?=
 =?utf-8?B?cHorRFIwWGg3YWtKdlpNMGUyYVNVdk4rOW5MczFrUmI1YjRJeXo3NnNpZFdk?=
 =?utf-8?B?aVY5ZlZFVUNURHZ5d0U1Qkpacjkwb2lyYmJPYnpobXNQZVdzM1JPejZmaDQ1?=
 =?utf-8?B?Qy8yaFZiR3VsNTU3T09kWFZpbGFWOTNzTDdwRXNyOGduZEdDcE9scGF0cVlt?=
 =?utf-8?B?VGhWN01nam1GYnpKNW9CZnlGRVJKdXh2cXpyWnZNOXozdWd6LzJoUDRHNVM3?=
 =?utf-8?B?T0s5Qko4MlNVOVZhSTZobndWMkVRV3NuMTZvcGZadEQ5M2dhTVFWU2IxTzc4?=
 =?utf-8?B?eGJwb1VXRHBNenVUY0ZNNVhGYkxydGtDZEpCWEFqVlRSL0JjUkpwWkttT05m?=
 =?utf-8?B?ejlmYjRKUkhROFg3WXZvTXhDMlZTV1JVaVFyazhuTDdnT1AyU1dnUGM0Z09M?=
 =?utf-8?B?K0I0ZUxlaGQxOEIwQ0FyNDMxUTVIdW5kRlNscUlYTjlwc0gveXg1Y3ZzZmZo?=
 =?utf-8?B?MmZqSnVRV25wMmV4YkRmZDVHeHk5VFFYdlVsQlZmSCtoSFB6MXdlNnNrQldo?=
 =?utf-8?B?cUdTWndPVThRQWlqNmRNZThUcTgyM1dmQnRSVkhwYVMzY1dmVEx0akVuWmVo?=
 =?utf-8?B?d29RcGN5REFCcU9HVjAwd0FNRGE3Y2pldkdtSXYvbVp0cFB4WWZvQnNDR1BL?=
 =?utf-8?B?QllFZUpKeWRSdlh1TFkyanNlWG5WL3M3a2NvcURUa2s4VlRxc0VzVmI4K2pR?=
 =?utf-8?B?NndZUnZXWjNCaVBlVFJoaDFTOFI2Q0srQ2Q5STFOdjI0REplcXJjRkRNWWIz?=
 =?utf-8?B?YUZlKzY3RUNqckhLc0w3eXZ2dmxpUlNtaUoxS1ppSjFTTnJpZW5aSXZPRGgy?=
 =?utf-8?B?cVlsNDlxb0RpV2lWalEvU3lXK2hDd2VQbXFVTVpVWXBYaVR1MU1VQ2NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3pCSDAyRUNGQk8wbmJCZ3Z5WGRXWEptTkFYd1l2SyszdDNVY1FVNVdyOVlK?=
 =?utf-8?B?ZG1WOFplNnpTRVJoNEF5Vmg3cHd6OXVmQVpSKzMyTHhXREt5eU1NR1dFWjJw?=
 =?utf-8?B?c0F4TVhqcHJlekFNczRXalZoZW51bWdIeHIzMWtobXBGcmVMK3RsYm5PMEFG?=
 =?utf-8?B?WjVqVTZqSVNVQ3pxSGhueUVjRjA5NFdFSEFNWk9NbDNvUkhlRkFxNEdHa1lN?=
 =?utf-8?B?QzlSMFBrdVE5azBMalh1MlVKS0pIMktNVE9aOVBtaUhzZnBMeDdsK3lOZ1A1?=
 =?utf-8?B?SVVIcXg5dUN3Mmc2N1ViS0VoSURIOEhPbyttVjEzTmdQVjRZOUwxUWxmaFE0?=
 =?utf-8?B?bWQyM3duQmVGblpwRi9TdllhSCtBQzE1Z01Qc3ZWdC8reE1uSzlhZFhvalQ4?=
 =?utf-8?B?UzcwSnIzKzNsQnFIM3kvcWdHOWs0Y0tzSm1RUkNwSWZEcmw3YVo0K0MzRXVa?=
 =?utf-8?B?bUNtYWJVNlBsQzYrdEpHQUhCUEhZb2x1TzMvZlNvWnJsdTJOTjNTaFlsSTln?=
 =?utf-8?B?QUZpTlpJMWlGOXZqMzF0NTFyYWJjNzZDOS8veHRxZWc1RHV3U25tOXdHdHBZ?=
 =?utf-8?B?MlQxT2FPZTU4T1lZN2d1bVE0MGRoTzdNU29sbDh2ZmRObTU3bEkrYTdNbDIz?=
 =?utf-8?B?UjRrSU9TM1ViTFg4dm1qaWVKVUQ4QkFtVm1qOHEzVWFaNERGc2RTd3JqaW41?=
 =?utf-8?B?Q3d6WVo3Ulh0dUJOOTFMcmx2RGgrN2Y1Z0ViOW1NUUpiSmxPYjdVNUtHcXhp?=
 =?utf-8?B?UmZrc3YvZkVpcVJiankrMzFpWVkrenBPMWcxeHNJdExpMnFJbkpYQjNDSEk5?=
 =?utf-8?B?TUI4ZWszRGJockJSM1JXUk9aUlVkWVdDalJjUHhuN3FTQTZoSXQ0djJKMjZY?=
 =?utf-8?B?MDJvR3h5OTFqazNSWERlVUZUK3dsd1VQdG9TQU1oYjMwYnRmdFBjRXEwcVY0?=
 =?utf-8?B?RjBZZXNNUDZSNnhGZEo0OGd3R1Zzb1dwbzRyV3hHWkZBdnFqK0Z3c3VCcVNF?=
 =?utf-8?B?RHNQZFJTSU5GVWx5SW1nUUhpU2xJaFBZbERIdnR4R1NRdW1NblY5WEJUK2pB?=
 =?utf-8?B?NVEvbkZDOFdvb2JPVXBRMFptN3o1cUNvREM5RDJMcWl6R1J4MTJRUnF4ZjRN?=
 =?utf-8?B?YjY4NFpyMkN3SjE0VSswSGxLbXl1VndodmJLa0t4MEdaZ0pOc2NUZFAzNVRn?=
 =?utf-8?B?cW96YU1NTGVtaTVMV3FXd1BHaEVqcVY4WkVaZy83dFJPdlFnMDJoY1ZQOFls?=
 =?utf-8?B?WndHRHl6Z1YzQzVOdXNXaXZSNlZVQXFBK2dxbmZRdVhPL2o3aVhCclRJcDdS?=
 =?utf-8?B?dU9ucXN6NXVrenE3clMxbXZQbm5HbnU5NlJNNGRlaVhhb1FSdFc1RlByTU9G?=
 =?utf-8?B?T01wQlJHajhnSjBzLys2ZlIycFUxVkk0RG9BZWtXU0gzZkpyekNyT3pqMkRs?=
 =?utf-8?B?c0paZElMSWdONGhEVFNTckJXWFdxc3RCVENLRXN2cHZkVC9OeEFTVXdKaDB4?=
 =?utf-8?B?NVorNWo3dEZLR3d6RjNwdXRDMFlRMjloc0dSZWcxU2xqZjV2NkpVeWNkT0Vs?=
 =?utf-8?B?OVlFT1VmN09uSlBVR01vVjdTTDBQNXdFaXJyRWhtTEErc2lkdGFGUXBRU1Fk?=
 =?utf-8?B?VDd6ZVdKSFhaV24wQXZoQmRyZ3ZRek03NGZ3c2R0SFVlanoxMW5oMTlpUEEx?=
 =?utf-8?B?d21sZVdFTTlrdkpBYktBck1mNm0xRGJrSFRaYjJjTzQrTU51Wnprd0NDZjRK?=
 =?utf-8?B?bGN5Y3duZVRpMjZNeHJ6Z2dNcS9HbWFIRXBJdVczQ25Ja21GWUU2S1Y3MnZI?=
 =?utf-8?B?OVRCV0tQd3hpL0JPNk1OZzU0T2E5c0oxSG40TktUU1BRSUtiK1BQMkE4WUZw?=
 =?utf-8?B?QzNCd0t6eFBUcTBTUFNubW1PMVpicUdWS1lkdE9JTi9SNHJHVi9MeFQwOWR3?=
 =?utf-8?B?ZnM5MzF0cmxYQlpDVmJXS2trNVBlNDc2TCtTdUxsZERxcENjY2RSdmNTT0lB?=
 =?utf-8?B?MjN3YTlyNTc3NitXVzlHZGpTZExVR0VJUE04THBsK1NCMkNsL1RsamptcWRZ?=
 =?utf-8?B?MWtPWVp6OStyYVg2TExWbFRVR1EzTDUrMWhBVTFJZzRJV216V2ZVMGI5Ni9G?=
 =?utf-8?B?NmdKMDhNK1YvRzBOL3p5ZnJWWUpLaTA4d1k4TTNIOEZoMzR3ZkF6VktRajEr?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906a69e8-be88-4ddf-8b64-08dcec6040a9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:55:32.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A4f2s+3HoxeM2uq2gGhif632UDjHqiLVq7LqLZ/1EduGierRCShWU0lM+2FYfF1i4pC+tdSNAY7TT7z0CEoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

On Sat, Oct 12, 2024 at 10:23:35PM +0200, Paweł Dembicki wrote:
> wt., 8 paź 2024 o 12:47 Vladimir Oltean <vladimir.oltean@nxp.com> napisał(a):
> >
> > Similar to the situation described for sja1105 in commit 1f9fc48fd302
> > ("net: dsa: sja1105: fix reception from VLAN-unaware bridges") from the
> > 'net' tree, the vsc73xx driver uses tag_8021q.
> >
> > The ds->untag_bridge_pvid option strips VLANs from packets received on
> > VLAN-unaware bridge ports. But those VLANs should already be stripped by
> > tag_vsc73xx_8021q.c as part of vsc73xx_rcv(). It is even plausible that
> > the same bug that existed for sja1105 also exists for vsc73xx:
> > dsa_software_untag_vlan_unaware_bridge() tries to untag a VLAN that
> > doesn't exist, corrupting the packet.
> >
> > Only compile tested, as I don't have access to the hardware.
> >
> 
> Thanks Vladimir for this patch. This fix is required for the proper
> functioning of vsc73xx.
> 
> Tested-by: Pawel Dembicki <paweldembicki@gmail.com>

Thanks for testing, Paweł, I suspected as much. I will resend a v2 to
the 'net' tree with your test tag and a Fixes: tag. I hope I caught it
early enough that it didn't cause too much trouble.

