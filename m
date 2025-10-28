Return-Path: <netdev+bounces-233546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB45C154CF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D40DE5042EC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA857337B86;
	Tue, 28 Oct 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VtCXAgK7"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143D2E7BAA;
	Tue, 28 Oct 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663498; cv=fail; b=BgtTr/HwF3W8lXWJrzRTw3uBnK/Yx6aIGUH+p0RFDmv/rZtp20L6hb3K4k7EcCxWrOb8FzjU78WvJYtz5WOmokBrgDzXhBv4q8YycKS2g9nvOdTFfw0gKNBse2GjPl74NrG3vWS90JH0g8invk9JSpTXzdvTlguNvJRXXpk6svA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663498; c=relaxed/simple;
	bh=8DfpqvG06yYCGEJQqpghLBEKbXILUVGQd5VyWCjUnVI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PEyjj0cccw5io6WvYVPZJxDpiZuXqtbK/u411JkEX5OvhDBLqYCkLqR5BgUgXl32yUduXycUdiZ+qCTEP8Ik1LSaCHrIY7T0rJKMRxiao+A0v73PIpXzUit7LdRU+FzPMXUXSYm+MQ6ASCZJLxvbDttUIR2+ki91+oK6xX45KVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VtCXAgK7; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6D4tmkaQkUrdLl3H8pVtKo6lBc0Osw1CQPcZimuZLvZNZ63umfcn5qbpXaKJdoPjwM8o3C4L080GWLHHhUxWw6wownZPOW5yfhhyb2elFjzcTFP8IWK0d2K4LqGG927ZYRgaw9HpXM8KTRmw6+nNkI0yI3CcYMZpqZItyYEheH+rYpXmX7YxRSxULCeTORrz7mAqyDnBtRSzR8lCSCLExeX8i2AKk+/CNlf3K/9f2sHuwi2T+TOQe3pqOc/r4h4ccBsjMQfNG99fjgxw19H68zZgd8op3+gqlBvNecrgfTSfsGZce/bVKwsO+ztumXfMDPG8++daHD5SoilAU0CiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URojyIYSorC2KCN3kXdznwvG/V3yGb+6kFh2wTyFLQc=;
 b=CS8gpuC6qlwTsO1FCNzBEATiqfIufzL4XNicAStrWx9gEn+OpSLFSJbJ/cEOl0E/1b+kW6BmcEvUW8TTNTrBlyIndzs1z+/N87zOmO9pxSsUbAgpxNggHqvEsDFnxcoMYdvoCiqGNON0IH9xJYMlQUh+y15vWJhClufpuf2uOytvFPTtF3PQSeiO9BjRzRuVasgCLyzEg2mJH7dsWYz6nqyExllZ8ZhGTw5C0xD8h8r3UcWVXO3X89RIoaZmHHHudyBXIgZNwfPu9eyuR82QlkPnHkkBN2p0yUGQKlx6EU6xBxk6ly8p+4m8xNE/Vnr3cxPYwEWEjzmiDeSshQlXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URojyIYSorC2KCN3kXdznwvG/V3yGb+6kFh2wTyFLQc=;
 b=VtCXAgK7hYuHQQFhrZ5cC3oqqjqzUHUgZKEAV0RnD3fnswNrOfhPsa5pknFnjAddt6EXmL2MlnH0+s7wKZBWeeO9www8Kc1wNPpP7RrMJ5q0cwX5FASwwVcgCt2qpSSpFzC8r3G8g/F89bH+ooDvWj/FIX4f9VHO3q3lsAy7mnakDzJ2sTz1UVcHXEP+ycmPmCyERaPdA25nMiLPWa63nfM0kiXGVNVTOr0/JXwtLijn55fjKFZtkYhcXUuLA58EG7iT2HyK9BrRDml7NakiNzCi2pSeKbvgYuSzK4WQYI6/SchvYyYkdU786xECOL8Pc+rRlvvDRuLNY67o1R0uhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:58:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:58:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] i3c: switch to use switch to use i3c_xfer from
 i3c_priv_xfer
Date: Tue, 28 Oct 2025 10:57:51 -0400
Message-Id: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/ZAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3Zxcc1Pd5KSktDQLA0MTC0MLJaDSgqLUtMwKsDHRsbW1AC8uikR
 WAAAA
X-Change-ID: 20251027-lm75-cbbff8014818
To: Guenter Roeck <linux@roeck-us.net>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-i3c@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761663488; l=1022;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8DfpqvG06yYCGEJQqpghLBEKbXILUVGQd5VyWCjUnVI=;
 b=RCWsbTnlp2c1SM3Cl/mbU0ynP+NEngIInc2SxjNz/rUdxmDkqCCMZxXy+NtucDFoE+Is/Iu3M
 NoG0epr8MRpBtE2fIpk7Du0DwIbp8ex9suPueIMfpUTKML3xumaJ2PC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e6777f-fd44-4873-5247-08de16326a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2hyYzBqeE5xS1o0VUN3RzAxQTBQUUpCTzNCRGxpRHdlUlRwVDZZdTVhajBD?=
 =?utf-8?B?TFJKdW9FU3VzYWhuOXdmVzloNFFQM3hHYVBpaTYrUXl0WnNjZzhlZU9PQjU5?=
 =?utf-8?B?aUxiWnFNdGQvczdwKzZ2bGpjWUp6enA0VUFmVXN2Q2k4Q05FdHZOZEhRZ0tU?=
 =?utf-8?B?a1F5NmQ0Zm45clNGcFRGeEIyNVhNQjJadW1nM1ZobG4zTnBOTnpnVlU3WWlO?=
 =?utf-8?B?SFJvTko1UTBhTXpiNXVVR0ROdE5saWs1YWtQZzczcWlaYWFld1NrSUxYdlFZ?=
 =?utf-8?B?WC90d3d1QXdETDZIdnFtYkZCYlJLU0g5UWg3bXBadFdJb01Fb2hLUFVZRElD?=
 =?utf-8?B?dW14REdkN3dKclNBMGJkQ1dKTEJjc0YvQ2MyUXpFYjNldzhkWm9NK2dQeWxT?=
 =?utf-8?B?eFl4ZEJiTm80REF3Z0tnNENMNWVTdzRpU1NGaU4rVFFwOTlCRVJtcUpnZzBx?=
 =?utf-8?B?WVJDSFI1YzQ3SE1yK3cvbEszRXlYSUgrU090ckc2a0ZrWnl5VHF0Nzc0K3la?=
 =?utf-8?B?alk5NnNRcmdOK2VZL2dEQTBpMVhHZk5keTVtK0tTMHJYZmlmNW4ySWpBU3lK?=
 =?utf-8?B?Y1dOcnpJakFyb0g5czRhR1Znb3BWa0tiTXNERWZ2cVBocHNzazRSVWZMVGdL?=
 =?utf-8?B?Y3dlZlR1VXd3WlFVa2tZbHRPS0I0VXN2aldrak10YmtRZCtyaTNLN0xoem9r?=
 =?utf-8?B?bGJ2eDN6TzBWeE1OTEhkaTBCRkh3cjFyNXZwWkZIODZxVmNIOWVLaTZ3WGow?=
 =?utf-8?B?Uis4bURONEd0UWIzK2RPY1c0M1lLNFlWV3M4bEhiU25jV3FZQlpORnE4a3Vm?=
 =?utf-8?B?QSt6NlMwWU1WK040cXpHTDZkWXBXdFRRd1J1K2pvK052YysvOGdkZytuNlVJ?=
 =?utf-8?B?VVNySnowZDNPTWpreW83R0tlTW5YdUY0ZjR0cVE3TmhrL01xUFZneWhTaWsv?=
 =?utf-8?B?NkxrOUZIcFh5SmozYlVaYnNWSU80WldEaXNhaEw2NTNtN1c3c2ZnOWQxanZ3?=
 =?utf-8?B?eTJNNUorTnA1d01kTlIzM3IyZ21xK2xKWExlZHhTMnU3Tnl0aStJb1UvN013?=
 =?utf-8?B?L2owaW02K0JFU3p5b2w4ODNhbXlNOXI1dFZPR3BBd1A2Z3ZYKzNTa2lLekk4?=
 =?utf-8?B?bEozY2lXZ25sK3FvL0dlanNjdDA1by94TjVCSXpBZWtHcEdWRHMyd3NjbGNq?=
 =?utf-8?B?Ym5WSlNhejEzam9JejV1RVRVcU4rejljMGZzTDF4T2l4bWxSSENiNHV5UXRU?=
 =?utf-8?B?dDY4SC9uYXJBcmxTWmM3OHNSUjVkS1NDcFh1Q3FCbUlEQmV2NzNUVzVVWnho?=
 =?utf-8?B?RmxuK3RnN1BXOHcvQW45VERTaWVaeFhrWCtoWUhmVXA0T04vUnZMcEMvc0s4?=
 =?utf-8?B?Z3lETzFzeEpvMC9mSGtCdmVLNFp6QnBPMmxsbWF6K2FjalpMTnZCakF0SDdU?=
 =?utf-8?B?NmVPeWRBRGJ0TDgvY25Dbnp3VXhLOXdUZlhLWHZ5aG9GSUlDMkM1UGdDWG9j?=
 =?utf-8?B?QkkraUVoWXJJYk05NEdkQmFTNkJPTzFFY2ZMUlVSWU5PcXluT0MxNjJBc2xF?=
 =?utf-8?B?bm5uU1p4bFUwTFlnRi92ejNWY0FMRXdydStSS1dRQ0JXZy8raDJlSWNOOUpZ?=
 =?utf-8?B?Q0h2RHVkalZNWExwY1FuSGV4ZDNpUlIyenp6dk1jaDUzM2dVVlZkZXNTVDdN?=
 =?utf-8?B?aStQYzVzSzdHTG5GVnlIdU9sVHcxSGxXbUtrN3VzSGVIR25jeStHY2p1MGdE?=
 =?utf-8?B?Q0o4enBMZUVvQVBSbGlUcFRsWC84OTZGWlNHSklHWHRZdkRsdGZNdE9RU3hZ?=
 =?utf-8?B?WG5KdkxVY1hyd3MzbDlRZXo5OWQ2T3FiREthYzZqWmtOZ25BTkFPOTc1Ti9X?=
 =?utf-8?B?cGxwd2g5RmZVZ0VsQjdNTHJON1lFZFlENkUyRWJLQmpBR0JvSHJXZHJySnZx?=
 =?utf-8?B?K1VrQThNaXk1Uks1WVB0TEVtbFI3VnhkSTljTWNsaDMwN2huTFpJNVMzbmQy?=
 =?utf-8?B?bWtxV3hCdDlQNngwTzVSQ0VEaHY4NjkyejVLTzAzb3lQN2JCSFpIdkJoOU9Z?=
 =?utf-8?B?R0lOMGx5R3VxUWNLeWdVSFlaYWg1VlVrejBpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3FiU0dqSHo4NXlWREQ4TFJ2T1dOVFdSUmNFT0VzalR5QUZzYzVpSWpLNXRX?=
 =?utf-8?B?Mmg2TXk3dng1Y05HblZJRnc0TmVQbDFLT012N3BzT2w4elZ3ZW5lNXR1bm5U?=
 =?utf-8?B?SGVXSEZUQlpERWZQeWIrVFIvMDBTSVZ3RkhUQjJ0T1ZDenVoOGVwT2d0RThT?=
 =?utf-8?B?dUxSTWhqOHJtQmZWSHhPRU1iUHh5WTJ6TnR4bTFnaHNhZGIvTXJmcjc4T1BY?=
 =?utf-8?B?Wjd3YXVSZS9yanIxQy95YTF5c05oSG1lczdzcTczVHV5d0JkRVQyUlhoWFY5?=
 =?utf-8?B?NzV1TFdlSGgrellHZjZUWmYzMy9abXJvQ2t0SFJhMDVrQVN1b3ZMVWlaRkVl?=
 =?utf-8?B?ekZBUWJhMDRwNWJmbUJLY1laaktkUzdTMHkwMWdhZ3REM3M3bk8valk0amZ3?=
 =?utf-8?B?UDlSQy90Q0JiRkoxNWRLSFg5M0xyanNPcmVXVk1Kd3JiaTZlUy9EdTlWVWZL?=
 =?utf-8?B?eitGNytzOWlYVjk1OVVQUjhSMXFnNjdiWnc3dnNOUDhTV2hsblVFWjZyUVBw?=
 =?utf-8?B?TlVFejVseFFSdzZnbjZWdndsZGJLQWJJeU1xV21HU2Fzc1BPMXpWMEZYcnJ6?=
 =?utf-8?B?YWVLRXEwZUJBMU5NbklyZSsvZWl3cmRPM0ZST3REcnRLdlZ5NmpNMW5nMXVQ?=
 =?utf-8?B?ZjZabTdSc29MNm11UTA4bXlnQVJMckVtVG83Zlpia0hMVEdFQnJNLzNpdlY0?=
 =?utf-8?B?akFzVXVsNHliZ3lGZnhIY1ZESmRhRGlqRXpNSlB5RVpwN3RZQ1ZSSG02My9p?=
 =?utf-8?B?TmtmZjF3RlphTi9PYkFZN0h5QUNHaVI4YzBJWkg3L2VjL25wSlJlbDZZRXgr?=
 =?utf-8?B?Ly8rdmdvc2NHVW01TUphd2l5MXZyUWlIUXJGSENtN3dGcE9XMm1IMzJxazFz?=
 =?utf-8?B?ZXJwL1piZUtxeTZMaURpaDU3YldpdWN3eFV6ODJoT2FWUlRzdHRqMElnWWI5?=
 =?utf-8?B?aEl1ejB3TEVTdjRRbkdDcSs0S01YN1Z6RS85WHNqZXgvMkcyRVp1MndTKzBO?=
 =?utf-8?B?VFM0WEVjSGg4K2hNTTQzbnBRYkY5SXFoVkdPOVVyNlJjcTlFWHZjYWIvOGtR?=
 =?utf-8?B?Zk10QkE5M1hmNWs1cFBuZ0MyQjYybmpSSjlnbTBvS2g5SDNNVU9hUkFScy9L?=
 =?utf-8?B?YjlxVlFRU2h5TEVoZm5TZlByWXk0V3pTekxWcHpKNWs5OHJRa3lLREhjOTRw?=
 =?utf-8?B?RCs0Vys0cS81OVZIQWM4RmxzODQwOFF5dWdCZ2lLMnRkZGRvY2dnUlpDYkxT?=
 =?utf-8?B?akIwQnZTZjhtVW9zb3ZiejNnUXRGV0dLc1VDVUVkZEYxS1lDTDVyQ0x1eGNG?=
 =?utf-8?B?TzdKUXNvZkV2OC9mbXFETEU1aUdRak9mWHNUMHZDWlo5TEx6VWh6QmdVSmg1?=
 =?utf-8?B?aEZXbXF6Sy82QVFjQmF2M0lrdHFGNE1xMXRic2xMS2t2NExmQUxJU2NBV1hv?=
 =?utf-8?B?RElLclRFN2N2akxONlcreFhGN013VllPK2I4VURUZHJncnAzV0dVWE1hckl1?=
 =?utf-8?B?WmJncUJqVjVXTUhIbFRZVkxEckZ1aU80UHhXSmp1ci9UMUtCUzRnVDJYWjNI?=
 =?utf-8?B?RFZ4cVpJdVBmMjRQUVBIMW55dVArcVg2K1R4WkI5cGlxNFBkV3dhcjVhQ2tL?=
 =?utf-8?B?RVh5Zlk0V1JES3VoMVBKc1phNUU4VE5sOVRFcE9YOExmdS9maFkyTE5ZOEdr?=
 =?utf-8?B?ck1SK1F4V3d0TjhDQlgrc0xoWnVvK3J1LytVZGtrYUN0c2ZOQnNQUFl5NGdP?=
 =?utf-8?B?UlFNellnblRGUXBqa2hvbGhEdFYxT1cwOU9wVnMzU003aUxPdkExMm1uRXR4?=
 =?utf-8?B?S21tU3RhYjBXZ1QzaERnWFhZcXdYRmdpWStjZzdQcWg4bzhHQTFJMmdLWFBX?=
 =?utf-8?B?Smp6MmhyMmhBVkRXaFJCMGJhNDZrMTZ2V0NqdExUNGZmeXJSSWZBVDJlaXRH?=
 =?utf-8?B?NDdSRHlDRi9XcTlWWi9YMzU4TTlzeklSaVMyRmhhTXg3Y1grT1YyaCtHMGRF?=
 =?utf-8?B?UnBMam9EVmpQdExrYldlYk1PSGNMbnVVdGdyUTIreUJMMWxPNDF1cTMzVkRV?=
 =?utf-8?B?SWNhM2FwQ0daOXhRNEpFUFlod2ROZFFPckJ0MEtza1FUSDlXK3pIdW1JWk44?=
 =?utf-8?Q?sTN8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e6777f-fd44-4873-5247-08de16326a74
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:58:12.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbZZo5GClhjy4FfSA84+VEN10OD8hq82ObrUcGzLixm/p/gsElHZxNLsIHQRaEp75sYtX1K6AavtW8+TKZns2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10889

This depend on the serise
https://lore.kernel.org/linux-i3c/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com/T/#t

Convert all existed i3c consumer to new API.

The below patch need be applied after other patch applied to avoid build
break.
  i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      hwmon: (lm75): switch to use i3c_xfer from i3c_priv_xfer
      net: mctp i3c: switch to use i3c_xfer from i3c_priv_xfer
      regmap: i3c: switch to use i3c_xfer from i3c_priv_xfer
      i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()

 drivers/base/regmap/regmap-i3c.c |  8 ++++----
 drivers/hwmon/lm75.c             |  8 ++++----
 drivers/net/mctp/mctp-i3c.c      |  8 ++++----
 include/linux/i3c/device.h       | 12 +-----------
 4 files changed, 13 insertions(+), 23 deletions(-)
---
base-commit: 689aa5c47412a17e4c71d63c35b263da10fa2184
change-id: 20251027-lm75-cbbff8014818

Best regards,
--
Frank Li <Frank.Li@nxp.com>


