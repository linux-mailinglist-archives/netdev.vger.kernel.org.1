Return-Path: <netdev+bounces-206428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC4B031AB
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768AB3BAF11
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169E275B1C;
	Sun, 13 Jul 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aiIbQ7op";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aiIbQ7op"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021143.outbound.protection.outlook.com [52.101.70.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897B27A448
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.143
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418984; cv=fail; b=sf4XkVjnKl2OVCQBUYduHlfaXi0p2rGRwCk5ds8GPwdrOWfSu44LyxrspaNnSdOKbRsKYYUwhobAwAnAdEGSvUI069rMdsMEh73x7qP+j2f38Lw1MCJ0FVjV5jlVpHcHirKcHFX0AdLw0rx7VZCpym4KB8hwFS0QAXq5niQUypE=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418984; c=relaxed/simple;
	bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfwl7uLuBmRmF/VuehStYScTHBWVGzMMBAMARUsXdwRyJT/h1uG4M5DI7+hGO3SzxQsWfwsmRD1d1ljF5876zvrtcmZM4bEEw8NY4jZCw/Sz7tCQSSvj5xXvvGeSeAd1Fw/xnsyiAn7B69hP/UIEDYW/Q06Mm+1hgEVqc9NHc40=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aiIbQ7op; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aiIbQ7op; arc=fail smtp.client-ip=52.101.70.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ranq6mQncx66Y1Oln6HcOpz0Ryx5cqZjuxdr5OGLjH4rodwd278JODWc7Qn5111kzfC79H8jkcaDW/xGpYjjcVTtAhhk8+Vm6mcqTtm5yokGqIb6MqDpJCVBzN+J4+ZVlvDoOmC4DsB9sFhwYR0tG20IA5/lH3ak/0eggvnzclHwFK4xzd8IEQ2qPD3Xokkt7BR8UsWmbb8w5cENKAeS7wGYwpl+2lgSEsnI1mheVKr9KB8ypy/gL/cyg4vIQvrPMnb0DIKWaKyWXgBEBZp88uoKlL/Vtd567AVAG+S57VhV2jHUPwy9ESypfTgXiycC/nw/2cmWk8Ikfm0tCAP2NQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
 b=Zmp543vHz/iQI+JrZoZZfje9giMDSUKvgZqCtauxEGyWMnjAXBIA4zkQoTM4CW8BLeZv8w1KvCJETSWbLGdqoDLBZ5aquQif4a3oOTnfdssaulQ0SdQ9wY2iBQX9JIP/RnRVryxNSwHI6uiJUcAhItqFYksTZtlLdq3AJE1Q55E3w0iYIXE5Ryi5n3C33mZpBv9VM3fwt09Ff0d9UA7AI7iX6aNYWzsiTC9WGhxZGIwhQ8/KO+YSvFd7+3we5NQyziZDKYar8zj6REqyxwkQtG+7aGFtBpiWlRq6QtThYAAiudhL8hbkSdSWQsp54aRv9HZ18tRoJ1CoWHjhb5jVyg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
 b=aiIbQ7opjZ2Q8i1PMMU+QwS0ENzgi1Mmj31njZ4Fi47fBHVqshLymBMFzSZYuq9h9049hZoBipCOVUk9QqPzUbkxDUxvzb/KBfYHsz/1garq0puKWVvSpDlrVino0JObdViXOYwFEyFutpUFnQ9rC6+oJVcol+3DOWHpxNLCLG4=
Received: from AM0PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:208:d2::48)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Sun, 13 Jul
 2025 15:02:56 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:208:d2:cafe::63) by AM0PR08CA0035.outlook.office365.com
 (2603:10a6:208:d2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 15:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 15:02:54 +0000
Received: from emails-2577032-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-76.eu-west-1.compute.internal [10.20.6.76])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E199E80038;
	Sun, 13 Jul 2025 15:02:53 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1752418973; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
 b=qOXdDXWP7ClsjBfuPfz04lugtw8DnTgYw9QDBZ5XFJSJRH08qX/HTKEMUlem/CYjiniu/
 A6iQr5JwWcKo/XvbMQqvZ2eF3KFT2XOT+UNqKJRfI+VlzYbpG3Y1eSGs6g7o58rignI4fU/
 dLHkqsur0CvAuuQsMS+b3MvpRDndQKs=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1752418973;
 b=B1BMpm2R5IIafIWv3Ri4PYQDaw7u0Kz7bZ6RvsnYMeS5efzc93l7AODh6GMVJx7Xx30K4
 sNTB8iYuaR91AeFZnnQW//00rtS/RB5X1zMtf9+v0M7J+HkVvQpDG+WvdXiIGEehEFBCiPk
 b2Mb6odoqjjCKtiJeIHOABwMe612ZZ4=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPWum7R0xDQM5THG0IR9+8NvJE+Udx/KU6IAwAKezJIePzf+kxtzz0WAB0asjAaaenZGPnr2bgquq6vdbQvuZyjaUw0y8bGD+xl82B6vK2XOU66n4kxSFmt0CsR17TB7a+Jh/1XbgZMQsz0wMnu0m1w8Bdoa2Ko52ETCx3BxxQUew5SdIMAC+KXpuEtP+QKmygxoqWpcLyX3fWrHzOop384Ct4g6ZKJ+h2YnnivJSh4T+kHNoANHfhDSRewvUfkcshdmECGR28P1VHk7W+zZoGfjMgM65aRoUzJ4hwfStqcUt131ND3n37dbOmkKUGlktyecTt5zYaOL33+2yxXRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
 b=Ynv+rvkh1JhK4zAlWYQC1peHnSU5Hko1rddWss91NlHIxJKuAEhvca7huUZ1EchFzUpPRMPwy2nvF/XXVisnax62f+8kXlHHBeRsGH6IGjhv5yJDygP3zv9MBLjbwVlfylvq3k1az9cZ4a2pMeqQtnOrOH54LPcVCygii+0X282ZWiPZvgvwLRrKTX14JIQc4Hi52+FjJUkEuQ3IakpQaDsChvPb50zHBIKlpWZPZ2thWORX3VoTewY/88/n2OhW6jMhNsU6X6Ptqm6cGFbufXta2Kb3iPIeT7kaQl51IQ0IXdK2qwV5GV4nH4Eec0/5kMJ8JmpzS4CpAmhW88xmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMtJRjwmDaJXwhvdu26c3swsW7h9x0FEBls31joyfvI=;
 b=aiIbQ7opjZ2Q8i1PMMU+QwS0ENzgi1Mmj31njZ4Fi47fBHVqshLymBMFzSZYuq9h9049hZoBipCOVUk9QqPzUbkxDUxvzb/KBfYHsz/1garq0puKWVvSpDlrVino0JObdViXOYwFEyFutpUFnQ9rC6+oJVcol+3DOWHpxNLCLG4=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 15:02:33 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 15:02:33 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH net-next 1/3] net: pcs: pcs-lynx: implement
 pcs_inband_caps() method
Thread-Topic: [PATCH net-next 1/3] net: pcs: pcs-lynx: implement
 pcs_inband_caps() method
Thread-Index: AQHbRvokIj4UPiYWyEaLi4z6AdkhIbQxgFwA
Date: Sun, 13 Jul 2025 15:02:32 +0000
Message-ID: <5e573c7e-234c-4947-9e61-541d22167fea@solid-run.com>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DB9PR04MB9750:EE_|AM1PEPF000252DE:EE_|GV1PR04MB10775:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e5f982-7505-46ca-8601-08ddc21e584f
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OSs4bS9xZ1RGRDd6aUtVQkVxKzJMMjVUVlhxQWdqKzY2bWZWcmlFTHIrWFh6?=
 =?utf-8?B?REVyS2VudnNhVnNiY2Nlc3NvVXA4a2dGSjBFTXhqekFtbDYyTDA5SmVrZDB6?=
 =?utf-8?B?MHgvZjNWWU95M2NWZ2JtQkI2dXhqNHF1Q2lDMUFYVUltaWdNWGN3NkN5MDV5?=
 =?utf-8?B?NEo4ZnVPN3Z3cDN1dTdacndIbG40cW1XUHNKRm9uek55UVRCbGdKTE9vci84?=
 =?utf-8?B?MjI0cUlzZFhubmtlWGhSNXBnZWM5YlJ0eTdUZnNkcUkzVWlOa3pRUU1idGNq?=
 =?utf-8?B?a3Q2U0hnYUl1aU1Hd1dlZVNLeUlLNHNzNFNWOXBkbzl5SFE1RmNXbG4vUEs0?=
 =?utf-8?B?UU1xRlN5dWlyM3FWcHVnVXJqejdLSFA0THFpSjFZdkx4eUR2WHZFMFBxUzAw?=
 =?utf-8?B?SVV1dXFCOFN3bUFBYUxJM3JZVWd6enBsV21Zb1NPMldRcVNOSGNET2dxMUV4?=
 =?utf-8?B?WTMwSHg0eXVYT29nSUgwamtSVDhadFF4SEJnclRQTnNDREFKUXpLYXJMUmFG?=
 =?utf-8?B?YlBleGMzeGNWVVdQcnRReE5haEVsdC91ZmZ0S0VsQWdtT2dNbkNsUUNJZnVM?=
 =?utf-8?B?U1lnWlg2VHFPUE5jRXVuTGhYU3BxL284WCtJOXFmZDdpb1pmaWZrTEo3dnBE?=
 =?utf-8?B?V3dZa0ZNbFp1Ry9kMVJ5VWlEZDZwSVF6UnhsT0Npc004RnhtZXdvaGNiZ25F?=
 =?utf-8?B?RUovbTduaEpEL1l1L3MzeWh4TWdxbk0vQ1VrUmhzeXNFa0VlZWYrMWttZS8y?=
 =?utf-8?B?b25TMGRDK3puNEh2Rkp0cHY5L1RhbVN1T1U3UzRuQURGMTM2dURlSnE1ZXFu?=
 =?utf-8?B?Q3pacVE1T3ZpcE1HSHhTSzg2Zmd3dm5iWUdqdjZYNjdLS21wS0MxSjdHSG5j?=
 =?utf-8?B?dm9IZXMxUFh4SGFqbEFmcWZ6QTgwS0xvQWQ4KzRMV1dWWTl4RHJwZTY1bFZP?=
 =?utf-8?B?ZG5ON0dwR0h1amI3U2N5T3hSZzN6bVhndklldjdQdUhCN3lDTklmUjV0VjQr?=
 =?utf-8?B?UTVFRFVIUG9FbU5tQWU1VGRXUHNwN3BaMTcrVHNIangxQ0trc3grNDQyRjBL?=
 =?utf-8?B?NzVoOVV1Y2RGczJ1Z3hjN0dqWjR4enliNmNoc29BMWFyQVNHNy9FYzN3T1V2?=
 =?utf-8?B?KzlsdTZOd01rd1BzTVdMZ09oaHN5cGFvNXJkWjVERlBrYVFoYTRqWVo1VWx2?=
 =?utf-8?B?dnhZcDUrRytpcEMyNEVnWTBuMnA5SFJCS0I0R2RsdlZxUmJJU3ZzR3V0cE5M?=
 =?utf-8?B?VGpkUUZPcHZXVVUyUjlSeGRDZnMwaDh2RjVFckpIM0toSk1LYmxWMldtQXpJ?=
 =?utf-8?B?WjBNZ2tTbDA5RkxZOTNjdVdHenMvbnlUbFpsZHFvd3kzV0RKSWh5UXk4Z2l2?=
 =?utf-8?B?ZUFtTlVmS25tQnFkT2liNWZ6OFVtR2RaMk9FLytjd2x2SjlXVmRYbEpiUVZw?=
 =?utf-8?B?SVJWbVJENmVSMllaUmxLaGlKQ3lhUmNTeGhqeEdjNTQzQ29mWUZnMXhvVHht?=
 =?utf-8?B?dTM0RGNDWW9FNjViMWxmSUdqc0hQSFFoeFdZRTllM0JIZXpYcWpPSU9Udnpv?=
 =?utf-8?B?RU1yVi9xVzNsWW9PVHJ6THVBL2o0a3R4MWcrZFc5Q0pBMmtoZzRzMFJrM1px?=
 =?utf-8?B?Mm01OGo3REwzL1Y1MEpkNi9tczVEZnhHV0Y3N3kxMFRjUTZJVW5EWjRkZm9U?=
 =?utf-8?B?U1I3S1JpWlFMNVlSbHhhWXdHM0x2VHlCbmtENjJtL2o5eUFXekt2NTBQUm5D?=
 =?utf-8?B?MUQwRVEzdS9qUyt3V0Q5bC94c21MbkxONVFuQnU5YWhMWU8vb0lpWUhnM3ZB?=
 =?utf-8?B?Vmdhc2xqN0hocUZhdHIzbkYzb2lyRmZkZFZhOUZ4OUxxNXMrcXdtTFJ5OExy?=
 =?utf-8?B?L3A1WkF5b05XUE84Z3ZuL3hrdGEyUlA4KzVMS2s2djZydWFRRHcxb25tSzRv?=
 =?utf-8?B?NEM0TEZ3WkNCU2g4WkZ0MWFieG10THpPbEdtRjF6c1FKR2FKakdrV1RWVnFh?=
 =?utf-8?B?MGl4M0tFaWZnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B93AAF6C00E644BAE0D5D4F8757312@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b5cbf85d4365466192943738974781a2:solidrun,office365_emails,sent,inline:0039657c022127027543e17f71f9fc62
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8ba5ab41-a494-42ea-1418-08ddc21e4b98
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|35042699022|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUFaZUk4SGxFODRQQjhQYnlOV0NZalpucklCMVpoakF3RlRjZ0FmdHhUZmVw?=
 =?utf-8?B?UTcrWXJSKzNGeTdQWkRuQlRqeE5NK2hUY3ozWENPMXUwQ2JiMDFwM0ZDam5p?=
 =?utf-8?B?QWVDM0hUeFZYRGVNaUg3NHlhVzVqWkZQS1QxUDE4dW5RcW5jMTl6MUV3VmYz?=
 =?utf-8?B?QjZDbTMrdGxiVTVTTUh0eXVYZXYwRGV6QzI0aFErN1VpakFTSkpxOGdBVXdI?=
 =?utf-8?B?MEJEbnpsZTkzQ25hWncxbUZOVmhaOU1SZEc5ajZaUU1FK0pKSFZrUTFwYmNm?=
 =?utf-8?B?K1ozY1dWcVVSbjJFeDRsazZObkMyUEw5MDBtejJDVEE3VVprNjR0UWs3bFh5?=
 =?utf-8?B?YzVZVVB6VVRyc1c5Y0pwNkJlUjJnQWs3UHIwOFV0UHNDRVcxMlBzOFNaYkNE?=
 =?utf-8?B?UkVrOEdFcmhRd2p2NWk2ZHpuNnpSTUtVSzlaY2h6MXo2a2JaTEVyb01FVmtC?=
 =?utf-8?B?Y2VTNGJFSlZCZCs0bWFQQXFFME5YRm4zeEhEQndzRWdYbGJjOEx2d2lBWnZ6?=
 =?utf-8?B?cWNLaVVIZjRxamRnMDAraWtuSysydTFYSTJjcWtUVnVuVUtZNnA1aXdHOWgw?=
 =?utf-8?B?WXc1MzJVSWMyaFZOcDMweHdaVTNkQ2xQTmFtcTRMcjFVR1FjWlNhM1hha2VU?=
 =?utf-8?B?V2pZYmhhait1RFFuZzRTV3FzMldpOTF2eWRzeHJXQlRUQ0lmRmFSK3VxcGly?=
 =?utf-8?B?ek10emxGNGsraTZ0dTF1Vjc0QmhvTVUzcUVaUStaS0hVeTJVbzREVFVUUVps?=
 =?utf-8?B?SWRERzY2aHJXYnN1QXo0VWVaVGhZNzEwa29KSHk5K2Q0QTA2eU1ZZ0t4TjlV?=
 =?utf-8?B?SW5heWlmc2lGcGtWaHNJMVF6Wm9vWTNqSDBvZHRzT2dMNXRTdFpIVVVHYjdR?=
 =?utf-8?B?eXRNemU5OVB6R0YxeE9ENFptR3A2ZGFTWkJlTzU5M2ZZeHMzMENTY1dUOFVl?=
 =?utf-8?B?QXNGZVRpUjkzR1ArWTBQeDdWMjlrSUw1MnMwQURGYUVHSUlkZnFxMy9XSnEz?=
 =?utf-8?B?cEtiTlFSWHo4cGM2S0k4aUtHQU9OTkN1eGhacDBQUnRwbUdzV01GNnQ1ajZ0?=
 =?utf-8?B?RDJhN25ESWNOS3A0QnZKeFpqSUpOR1czdjVFOGc0S3A2Tm84eXlabUZuTy92?=
 =?utf-8?B?djBmejJ4aFlzSVkxK2VXbERSaVZXa3RrL3l1MTdibXluQ2VWRk4vaE5sU3U3?=
 =?utf-8?B?RjNxZVcyMzJIc3hwMnBEQU5LblRuZFJRTW5Ka05qSnVmQzJCcmkwUEw3VkdL?=
 =?utf-8?B?NnBlVFQ2QUtKZ1BiWngvZmUzbzQ2dThSckhOK1FQUnlTTE1lMUg4NlFPaHNs?=
 =?utf-8?B?VTJ2K1RYZllldTY3Nk1tMjJRV20xamUxdjVXYWhQdFgrajZHajQvWGFKWDVG?=
 =?utf-8?B?UTFQbGxobkxLVnZwemNDbStoK1ZqR1pKRmtMcUw3cFRCcm45cEhwOEthTEZl?=
 =?utf-8?B?SUtwR1h6UVdETmc3cE0wQnlBakNNY1VxTjFDVkNNb3RNK0VqR2hkTWR5QVRB?=
 =?utf-8?B?M0RiaUZ0ZTgyQ09Obnd6NFBjOFV3Y1lBcmxSalplM2xPUEpCMXFWZDJra1J4?=
 =?utf-8?B?VVlnZXcwTDNaTnJENkU1SWsyV0ovUk00clRvSGhDWEZVbk83TnRCbTYxM2E0?=
 =?utf-8?B?eFk5M1d4YWw5SGJHbVpGQ0pNUlZUTVFEcEpMdm9OR05sY1hMejNhWWh2VHJ0?=
 =?utf-8?B?TmdqbEdQVERDQldId1RkaGVDeEw4UnRkNVV2c2tRcGpsQ0htUEJ1eTIzLzFF?=
 =?utf-8?B?cDJLdS9zN08ybXVrejlMK1M2TFp4Ly9ZbHVRZllQRlZXSU1iNGNaQnN5K2FT?=
 =?utf-8?B?b21rLy9NSm9sK3FFVzVqdUFnWUFRNXZlMGc4cTBVcUVPRlRhcWdvQkcvNjVN?=
 =?utf-8?B?ajBpK2ZMcU9xNHVxSGVVU09Ob0lRS1ROVU5UNVQ4clVvSSt4L1o1SlRMV3NL?=
 =?utf-8?B?SVU4bkQyKzN0d1k5cUphWEM0bzREdmxUQWwwRU5pM04rOTBXMDJlallBUUsv?=
 =?utf-8?B?SGhUVEErMXNOeVh2N0xieXBsMExQNVdmZ2JzWHlCMklQdjRFWFY1bDh0NFcy?=
 =?utf-8?Q?VNsqAf?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 15:02:54.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e5f982-7505-46ca-8601-08ddc21e584f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

T24gMDUvMTIvMjAyNCAxMTo0MiwgUnVzc2VsbCBLaW5nIChPcmFjbGUpIHdyb3RlOg0KPiBSZXBv
cnQgdGhlIFBDUyBpbi1iYW5kIGNhcGFiaWxpdGllcyB0byBwaHlsaW5rIGZvciB0aGUgTHlueCBQ
Q1MuDQo+DQo+IFJldmlld2VkLWJ5OiBNYXhpbWUgQ2hldmFsbGllciA8bWF4aW1lLmNoZXZhbGxp
ZXJAYm9vdGxpbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8
cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L3Bjcy9w
Y3MtbHlueC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9wY3MvcGNz
LWx5bnguYyBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MtbHlueC5jDQo+IGluZGV4IGI3OWFlZGFkODU1
Yi4uNzY3YThjMDcxNGFjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9wY3MvcGNzLWx5bngu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9wY3MvcGNzLWx5bnguYw0KPiBAQCAtMzUsNiArMzUsMjcg
QEAgZW51bSBzZ21paV9zcGVlZCB7DQo+ICAgI2RlZmluZSBwaHlsaW5rX3Bjc190b19seW54KHBs
X3BjcykgY29udGFpbmVyX29mKChwbF9wY3MpLCBzdHJ1Y3QgbHlueF9wY3MsIHBjcykNCj4gICAj
ZGVmaW5lIGx5bnhfdG9fcGh5bGlua19wY3MobHlueCkgKCYobHlueCktPnBjcykNCj4gICANCj4g
K3N0YXRpYyB1bnNpZ25lZCBpbnQgbHlueF9wY3NfaW5iYW5kX2NhcHMoc3RydWN0IHBoeWxpbmtf
cGNzICpwY3MsDQo+ICsJCQkJCSBwaHlfaW50ZXJmYWNlX3QgaW50ZXJmYWNlKQ0KPiArew0KPiAr
CXN3aXRjaCAoaW50ZXJmYWNlKSB7DQo+ICsJY2FzZSBQSFlfSU5URVJGQUNFX01PREVfMTAwMEJB
U0VYOg0KPiArCWNhc2UgUEhZX0lOVEVSRkFDRV9NT0RFX1NHTUlJOg0KPiArCWNhc2UgUEhZX0lO
VEVSRkFDRV9NT0RFX1FTR01JSToNCj4gKwkJcmV0dXJuIExJTktfSU5CQU5EX0RJU0FCTEUgfCBM
SU5LX0lOQkFORF9FTkFCTEU7DQo+ICsNCj4gKwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV8xMEdC
QVNFUjoNCj4gKwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV8yNTAwQkFTRVg6DQo+ICsJCXJldHVy
biBMSU5LX0lOQkFORF9ESVNBQkxFOw0KPiArDQo+ICsJY2FzZSBQSFlfSU5URVJGQUNFX01PREVf
VVNYR01JSToNCj4gKwkJcmV0dXJuIExJTktfSU5CQU5EX0VOQUJMRTsNCj4gKw0KPiArCWRlZmF1
bHQ6DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgIHN0YXRpYyB2b2lkIGx5
bnhfcGNzX2dldF9zdGF0ZV91c3hnbWlpKHN0cnVjdCBtZGlvX2RldmljZSAqcGNzLA0KPiAgIAkJ
CQkgICAgICAgc3RydWN0IHBoeWxpbmtfbGlua19zdGF0ZSAqc3RhdGUpDQo+ICAgew0KPiBAQCAt
MzA2LDYgKzMyNyw3IEBAIHN0YXRpYyB2b2lkIGx5bnhfcGNzX2xpbmtfdXAoc3RydWN0IHBoeWxp
bmtfcGNzICpwY3MsIHVuc2lnbmVkIGludCBuZWdfbW9kZSwNCj4gICB9DQo+ICAgDQo+ICAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBwaHlsaW5rX3Bjc19vcHMgbHlueF9wY3NfcGh5bGlua19vcHMgPSB7
DQo+ICsJLnBjc19pbmJhbmRfY2FwcyA9IGx5bnhfcGNzX2luYmFuZF9jYXBzLA0KPiAgIAkucGNz
X2dldF9zdGF0ZSA9IGx5bnhfcGNzX2dldF9zdGF0ZSwNCj4gICAJLnBjc19jb25maWcgPSBseW54
X3Bjc19jb25maWcsDQo+ICAgCS5wY3NfYW5fcmVzdGFydCA9IGx5bnhfcGNzX2FuX3Jlc3RhcnQs
DQoNCkkgaGF2ZSBub3RpY2VkIGEgcmVncmVzc2lvbiBvbiBMWDIxNjAgSG9uZXljb21iIGFuZCBM
WDIxNjIgQ2xlYXJmb2csDQpiZXR3ZWVuIHY2LjEzIGFuZCB2Ni4xNDogV2hlbiBjb25uZWN0aW5n
IDEwRyBmaWJlciBTRlAsIHRoZXJlIGFyZQ0Ka2VybmVsIGVycm9ycyBhbmQgbm8gbGluay11cDoN
Cg0KaWZjb25maWcgZXRoMSB1cA0KW8KgwqAgMjcuNjQ5NTcxXSBmc2xfZHBhYTJfZXRoIGRwbmku
MTAgZXRoMTogY29uZmlndXJpbmcgZm9yIA0KaW5iYW5kLzEwZ2Jhc2UtciBsaW5rIG1vZGUNClvC
oMKgIDQ1LjY0MjkzNl0gc2ZwIHNmcC1hYjogbW9kdWxlIEZTIFNGUFAtQU8wMsKgwqDCoMKgwqDC
oMKgIHJldiBBwqDCoMKgIHNuIA0KQzI0MDUzOTU1ODItMsKgwqDCoCBkYyAyNDA1MTcNClvCoMKg
IDQ1LjY1MjU0M10gZnNsX2RwYWEyX2V0aCBkcG5pLjEwIGV0aDE6IGF1dG9uZWcgc2V0dGluZyBu
b3QgDQpjb21wYXRpYmxlIHdpdGggUENTDQoNCkFwcGFyZW50bHkgdGhlIHN5c3RlbSBzdGFydHMg
d2l0aCBBTiBhdCAxMEcsIHdoaWxlIHRoZSBwY3MtbHlueCBkcml2ZXIgDQpyZXBvcnRzIEFOIGRp
c2FibGVkLg0KVGhlbiB3ZSByZWNlaXZlIHRoZSBlcnJvciBtZXNzYWdlIGFib3ZlLg0KDQpJIGRv
bid0IHF1aXRlIHVuZGVyc3RhbmQgd2hhdCBpcyBnb2luZyB3cm9uZyBoZXJlIC0gd2h5IHRoZSBz
eXN0ZW0gdHJpZXMgDQp0byBlbmFibGUgQU4NCmluIHRoZSBmaXJzdCBwbGFjZSBhZnRlciBpbnNl
cnRpbmcgU0ZQIC4uLiBhbnkgaWRlYXM/DQoNCg==

