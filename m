Return-Path: <netdev+bounces-195720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216ACAD212B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64067A4860
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA7125DAFF;
	Mon,  9 Jun 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gcxsn2iC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12525A351;
	Mon,  9 Jun 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480092; cv=fail; b=RD3NfY6gMrxlN5wfpJgsF7rKwCoD4JLiMAIvwR1ccTwQDLdoYdbAryCTDn7S10sfShnaPxQFJ/i07QUJXu7Dzw/E2jU+K0QIqUAWoDltZ7edJbMR6/5ALSsdSty1EtGKUwL1YLvTfKCthPmZ0ot26zX9G4E24vbAqy4vbqONOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480092; c=relaxed/simple;
	bh=aZo6bPN4s1f+G0N1rvv6m7NqyXwSt8Gp/a8o16r7ISI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nq3bfgx+XhsYC0ynClbgzkRG1JALiQrdNzCtRCVI9bSoJQiD0AAXHkOmbWDoykQPaZZp7K0AufpvQbvoAHRXt2P+/CUgvjVNGnfvsqkJWE52oEzrKdMmiYk5F+juxSgKdtmrK6Iz3bvMshL1qzx3Vy91C+RbSyFHsG7d9g28ANE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gcxsn2iC; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxWqecxWEPc7mJtOVk8vMF7uqtf/FQXYsWCil52OhTyPrDWeIOm8a/wlQwJCaXwkNwmFxji9GgTAHvEVXDHy9N9cC3/TAyhGmyWjG3Q8XjtVPKTabLc5GoWq29cb/8jd3OU8D74TZRz6yH1tk6XVQDHxp0CCtYjO8Qi75rTCGoLfDPza7wd3ZssgbnifYkyhkB7c5hvAHr63qhE3RZO+AiL+EKvBOFCKid8d6fPzQWRBrvwrzAyP37/FCk84c7NEbn7GZ3OwmWS2Y3JTv5k3varUGg+s9czWrSGnaDnFQFwxG0IevmHBt2HG1i0CzJRAzlpZO9HzwtHP8XKlPkQCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIV556d3Us6ydU+a8L4iTiht2SULASx3qgCMFtyHuUk=;
 b=PkVRj7dMVl454ETarN6D87P/UFjChsOuV0ryUL+FXtFpt2syQfJ12UokC/2KFrq/rVTYSbfOyNYvoksLbD4ZcTtOzipiHBgALFD3whnvNqRSWlwmOuJnWZas3vDqQXVO97tfJztbuffoGqAERkKE8Z7RmFGnb26HcGG2eUrHWsEfn28I6xm/z5DvwcbAPHsawrPRb2aNvM6RY2uXPtERPSE2j6yW4M9Cy/yBpGZE2yXT4dW+emsGHJR2qlNkW/eNY++dArvv2lVvhUaMK01HPgGbWwtNDSCsvpJyK/kiil+NDjUHOg+hyVTWHTiRWptrkDlscGnDGJ0qfWTcUjFf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIV556d3Us6ydU+a8L4iTiht2SULASx3qgCMFtyHuUk=;
 b=Gcxsn2iC9eMby5Mm8g6SLtfnuwOw5cdRaVOn8uz2D6ZFej/KTCzH8fyxWB5YZHYCtXr49n1aeHypywkiqJLj/AEyP5lNUL31+fxfrD0hSv0UI0Uvz+oTSBSaW9Rym88Z+7kRpNvCV/FkCSZ02budip9MCaLyUGgyhN2NLamxT/tpMSgxWh+xWYmR9YXmvC0t8KJnBrngCgnsJJMi4heWlENXOflgBIN9I0MwMxrRiO4EALHidMomA5JP0iB7UmSMAxv+YgX9YoT0YPAVV4pBdfbZk3NmAbQShyWWuHoLG/EKKgiEKmDPUkbYuOrT8igRISaTPnNH380HXFhbCiBAhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 14:41:28 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 14:41:25 +0000
Message-ID: <0ba3c459-f95f-483e-923d-78bf406554ea@nvidia.com>
Date: Mon, 9 Jun 2025 17:41:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
 <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
 <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
 <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
 <20250609160346.39776688@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250609160346.39776688@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbdbf60-bf3f-447d-d286-08dda763b5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjZpZ1NTeFMyQUM5b3o0WkJQa0V4dVNrZFk1eVNXZWQvbGFHK3Uvc0JhSVRI?=
 =?utf-8?B?N2RRLzJ1U2pIQUMxS3ExdExQSnlVVmVhb0hTbFovbGJHYWlkaGMyN2xhVVN3?=
 =?utf-8?B?Mzc1QUdzcEVVZjFwK1Q1akJ5QklCWUJYSXcvR0hCczJoNUV4dVBua3cyT2F5?=
 =?utf-8?B?MUJsOHNqY0JSZXhDTzVFTG10cCs0Qk9jdWVERGRyQmVtNFlyaXlGand4R0N0?=
 =?utf-8?B?RWVFQUFWdjBUc0hJRlY2Q2VNaWFCanY3VjhFeXgydWFwcXVkSW5aTS92M0tw?=
 =?utf-8?B?Z2FldHBBYmhydkM3cWR2V1BBVTJmMURkS3N5bWVEVS9KbnljeUhTRVBqcGJ3?=
 =?utf-8?B?WEdUaWVmbGZRZGYrU0RpWERxVFdpSWZVa0FvRVlYS2JJSEZOOU5wcENGRFpj?=
 =?utf-8?B?RURJM2ZvQXZ2c3ZQa09WellpYzJNdkxTbDUyWlJuM0d3SGN0Q0htN0RqdE80?=
 =?utf-8?B?TWVCUE45T0luL3hydXc0NERiNHQ0RnYxU2RDUlloODVZaC92Rkd1UFZMaEZn?=
 =?utf-8?B?b21GcmRHR21ueGxrSmNZZ1BxL3UxTlhkK05CdXkyYTlFTVBsTWpsaGRIalRi?=
 =?utf-8?B?K3ZWUEFRdW1aWjBOZjBZR203aFJEK1FmWmZwY3p6dEU0eWxqU2owcWs5cm53?=
 =?utf-8?B?bG1Nb3B2QkQ1ZDArT0ZqeXFHN1ZHM2o4SkxuNU9jZWRaSkJrYUtPUTZQbkRj?=
 =?utf-8?B?MFBERzh0U3Z3a2xNNUpUMzU1ZzEwanZDaEpET1FHNlFNaS9Od2k1Q0MrNHkx?=
 =?utf-8?B?ZGJuaVZDOTBGMm4vbFVKZUZlLy91c3M3dkZKM1NFUEtnMXBsZmNNcThTelVl?=
 =?utf-8?B?NGN0UjFOTHpwVXFTUjBIZGZOd1Fvd1dMZ08vZHZiWkV6djl2NjdnY3AzbkFL?=
 =?utf-8?B?ejlWKzlwUTFTc2l3eHgxdW1xYXYwbGRYa0cxbDhPQjdRU0NielRmcTlTeGha?=
 =?utf-8?B?alUzMjg4aFRwc3NUOVZOd3gvOG10d2dqeEZTS0ZWQjRWSXQvdG92UklEV09a?=
 =?utf-8?B?cVdSWmljVTVSa3cwTHNORmJQY2pnV0dVM1lTN09DRzM1NEMzWFBhSGhLM0NS?=
 =?utf-8?B?TlJVZGIxc09CdjlHc2Y1bElPQnVBeW55dDJNSFVjUGdzMnJxVzBNeWNpcW1C?=
 =?utf-8?B?WkpsZVpqNmx0aUQraFpiOTRQVmtPbGwwT3JubXptYXhCckl0T28rOFA0Q2pl?=
 =?utf-8?B?aUNsWjZEQjNXM0xSem9hcjBZZnBWUnJSeDladGxkRXB3U2c1VUdHZnVxRStw?=
 =?utf-8?B?Y0hXSHBrWjg0bS81cnZMYW05Skppc21aRCt5UWVkUzhyc0lNNW10K2d0VlNs?=
 =?utf-8?B?b0NRb0JEcVM0WmFwMXRHam1OeW5YdFVPZGJkZS9SdGpNcHZHUkk4a2tZUFVo?=
 =?utf-8?B?NWVwUEg3VXVsQ21oNzdrT3grLzNTZ205OThnRjJaWEtiUkRtUGFhTTQ3MUor?=
 =?utf-8?B?V2dkU0Z6TDhoZlgybnRaS1ZkTjV3RDRZRXliazhNSDVjR1l6ZlZpbDRuZmZx?=
 =?utf-8?B?MXVNZ2pxTlZBNmtRcmwzVFI4bDZhaERnMllSZ2w0eUttcGtGeno4M3pWS2gx?=
 =?utf-8?B?M3BMUHV1QmI4bXIvTHBNbXFnS3Z2aVdGRmZETU9EWk5nVUE4N1cvQ0l6d0VS?=
 =?utf-8?B?aTJVSE5JcWR0V21scERaYzRtbFA5YjVaaGlXVHM0TStja25hUUgva1lCb1pP?=
 =?utf-8?B?SDRQTTE4MnpqalpQK0t2MlRFTTBmYkhIT0huYWs2V3dlVm5IeDVtZ241Qml5?=
 =?utf-8?B?a0dyTC9QMzlYajFRR0lZcVpOQ2FQbDB6Y21Oa1A4WFV0WFoyTkI3MWU5Mktz?=
 =?utf-8?B?Q2dXWWsvMm13cWxHNWFiSS83NUVueFZGR0dsUmhxQkRPWFo3ckc1SmFUU1ZP?=
 =?utf-8?B?VHNVT3o2dXJIMS82VGdPYW0xMHJ6WlFzQzEzeURUNHJxbkp6V0pVYjliZUtM?=
 =?utf-8?Q?RRy3qBdcRU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FlbXVCVWZ0RXB0QklUZGZBQk8xNEdkU0xhRzMyS0FZSmxXcm5FTjJrR3Y2?=
 =?utf-8?B?VzVJM2kyeE5kTHFBcFQ4OVh0L3JnRzJDK2k0WHo0Z1lKMFhHVjN3RmN4ZWY4?=
 =?utf-8?B?M29NOTVOanVBUW4wU3RkN0VyUmVNbXlxZkdTMHVsTXhsMjdSclZGQmhlTnhz?=
 =?utf-8?B?cWJYbk9sT1BvREp5YVFoNHQxVXpGbktBQUdwMkVWUW53Y3FVN3RtNCtJNzJx?=
 =?utf-8?B?OGlWVjFlc2lONVBlU2kxTnZRQXgwTGJTQUtkM0hFOEJpczloQWthTXNwU3VN?=
 =?utf-8?B?YjdDOElIMGhhbUNCMVBXSEc3cDF5aENCVERJdUpBUXFlUFI5eE04b3JzeFlF?=
 =?utf-8?B?T21pb2NUZzRpWHdoVE1KL1k0SjREWHg1MWpPc2NTQWZjL0h5T3FIRUFHK0Uw?=
 =?utf-8?B?Zk5yN0tSQXVMQlVERHRPVmJaQmJwa0taeHU3U0hpa2hpT0RxZEhneERYd1Ev?=
 =?utf-8?B?L201czBZRDBvdWFuMm1DUWs3bVBvTC9mOC96UDZsOXp6dE04ci8zakZDa2hX?=
 =?utf-8?B?VXV0cDBZTnRaeEVNMVYzVlJRczl4Um8zUnlXUDJ3WWxZalBQUmxCeWRFajRL?=
 =?utf-8?B?S20yMC85Q0pjR0oyVEUzOXlTVDRKTzM1TlpKMGJmM1lRMHRFK0tkZDl3ZEpw?=
 =?utf-8?B?d1NyVHdFdE5SVmx3RTlwUDQ0bndNWG8xM0ZZVXpTQ0tVVE9sWXYvZFNSeGRW?=
 =?utf-8?B?RWxUTkZ3bi9MKzRuOHg1bDlraGZ4clFsZFAwTFpnam9uSzlNU1hyOVZuWHJY?=
 =?utf-8?B?eHQwSTlKcDVDaVNCRkY3N2VjQjVJak95NzdYYVdGeEcvQTR4NHZkNTl6Y2hC?=
 =?utf-8?B?MDRzclRlSy9DOXhPaUpodFZIUzBhTVpXc1F5RGl6akFIWG9ZTFVEWStHSTZ5?=
 =?utf-8?B?QU1sRmppZnZEei8yTE1FeTZrRkZUTHhFV1l0d2xzbUlhVExGbEVhc3hUU2Zx?=
 =?utf-8?B?MFFVanY5RFRZWFJzWkxSdXZQLzBHT2JuS1c4a3NyVlBzaHFEaEtEOVplZFhU?=
 =?utf-8?B?bWxaQ2tKV3k3eW9kcmIrNzhOUUJMWXF4a1puTTlReTRuTE9CNmJpZDBkYkI4?=
 =?utf-8?B?NVZxQVdpM2JsVlhsUG9iMFhWYjFEays2ZjZzKzNJNnFzYlk4WmQ3VGJ4Ykht?=
 =?utf-8?B?WXVTeEdxNVRTN2F0dkJzcGMxblFFZkozQXNxY3owVWRET0VxQmtRZE9MR0hk?=
 =?utf-8?B?SEFyaUF5Vkk1YUcwTnZISmNVMlBvQytlakwwV3hjNjRlSTVKdVBlaGl2ZC9u?=
 =?utf-8?B?ZmVPMmszUXRWOGJhblM1bWp0R3BLdWQyVXNqaXQ5dmR4Y0hkRnZsNVFwUHRL?=
 =?utf-8?B?ektFU1Jvcmp2SGdzK2l5b0U5VVJxMVR2alhlY20vWlNjTE9hdWd0Y0tkQ0ZT?=
 =?utf-8?B?VnU3NFB1bDJhNkxMbVo4VGV1RTd0ZkoxOEpXaEU3N0ZZcmhvNHlQeE81elRm?=
 =?utf-8?B?eERXSTdzYVBVcStlWGFyZDRwQ1pVVEw2YWJMdlVKN0I2T1dwQ2xoZnVsUWMz?=
 =?utf-8?B?by9WYnlnSnUrSDZvMFN5Mkt1cjByc1UzN0IxNGRZNC84N3RSK0ZndW40T0Ny?=
 =?utf-8?B?dmlzREtYbUY1NUxwMHBSZmFuQ0R2TDcyeTVTY2J5WVhtRFVLR2xDTWh3QjlH?=
 =?utf-8?B?MmtNSFlQNG5DRVdFTitKTE5qMExTZFkwMnl3RitEeDFWQ2F0SE81VkQ5dWFS?=
 =?utf-8?B?LzE1NW4ydWl0cFRhdGlWdG53OWlhYVVXbnZkTTNXM3R4TzZscW5wR29WZUNU?=
 =?utf-8?B?SGQzRnVBZktyQlk0bUp2dWZ0OUw5d3Rxa0tBTmV4WEdwY2Q4MHlzZ2RSM3l1?=
 =?utf-8?B?Z0I4aVVoSDhDcFlva1RFbnluR1h2ZEt6OHpMUUZUa3RIYmV0VG9VbGhHbS95?=
 =?utf-8?B?VHpMbjdwS1oxWWdXTksvSGdNT3QyYW9XQkRoS3I4aXpKQ244L0wzd2M3Ym41?=
 =?utf-8?B?c24vUy9DaUVYdFhrWXVIY0hQd2Y3aU9TZkxtY1BMMk1Td1dlTTFZZzRVMUht?=
 =?utf-8?B?Q2xzZStiTkQ3bjE1NHc1SHdJcERFK2VhRnJjVkE0Zi9ZRHNDOGE1aEttcHBN?=
 =?utf-8?B?T0hYVHRrc2dmWkpwVWZiZVlEbEwvSXJoc010aGNWTGFieWhBZWJlekJvRzJz?=
 =?utf-8?Q?PWBVMcVRLqjRRGGjaCvhV8J9U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbdbf60-bf3f-447d-d286-08dda763b5f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:41:25.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDRxLTgk5h0XUdFDuZF7BrSoQPUuBZll16qGGt9xLrfDFb/Ylqo9NORRLQKWYNZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540

On 09/06/2025 17:03, Kory Maincent wrote:
> Le Mon, 9 Jun 2025 14:03:46 +0300,
> Gal Pressman <gal@nvidia.com> a écrit :
> 
>> On 09/06/2025 11:36, Kory Maincent wrote:
>>> Le Sun, 8 Jun 2025 09:17:59 +0300,
>>> Gal Pressman <gal@nvidia.com> a écrit :
>>>   
>>>> On 28/05/2025 10:31, Paolo Abeni wrote:  
>>  [...]  
>>>>
>>>> Are all new uapi changes expected to come with a test that exercises the
>>>> functionality?  
>>>
>>> I don't think so and I don't think it is doable for now on PSE. There is
>>> nothing that could get the PSE control of a dummy PSE controller driver. We
>>> need either the support for a dummy PHY driver similarly to netdevsim or
>>> the support for the MDI ports.
>>> By luck Maxime Chevallier is currently working on both of these tasks and
>>> had already sent several times the patch series for the MDI port support.
>>>   
>>
>> We shouldn't rule it out so quickly, testing is important, let's try to
>> accommodate to our rules.
>>
>> Why can't this be tested on real hardware using a drivers/net/hw
>> selftest? The test can skip if it lacks the needed hardware.
>> Or rebase this over Maxime's work?
> 
> How should I do it if I need to use ethtool to test it? It is a vicious circle
> as ethtool need this to be merge before supporting it.
> Would it be ok to accept it like that and wait for ethtool support to add the
> selftest?
> Otherwise I could test it through ynl python command but there is no similar
> cases in the selftest.

I think that in theory the userspace patches need to be posted together
with the kernel, from maintainer-netdev.rst:

	User space code exercising kernel features should be posted
	alongside kernel patches. This gives reviewers a chance to see
	how any new interface is used and how well it works.

I am not sure if that's really the case though.

> 
> Nevertheless, it would have been nicer to point this out earlier in the series.

I agree, we also encountered the same thing :\...
I tried to convince the maintainer [1] that this needs to be documented
more clearly, but got ignored.

The current rule we have is:
"Broadly, any new uAPI should come with tests which exercise the
functionality."

[1]
https://lore.kernel.org/all/3a3ce4c2-5cc1-4deb-be47-d936b61c42c4@nvidia.com/

