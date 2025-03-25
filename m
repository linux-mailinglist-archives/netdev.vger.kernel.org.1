Return-Path: <netdev+bounces-177544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5692A70852
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5EA166A1D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9F25D8E8;
	Tue, 25 Mar 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5tiVksIu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC372E3387;
	Tue, 25 Mar 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924280; cv=fail; b=QyEDtu7zq9Tj5XUah7qDO+/0Ia+eB4Fv0hDjvlOQU2nFY8tFghgSpGtMIylYrtUCwdVGgMUcx0b8Tx+b8Jorlq1G0bjb2Bzv9wv8ZvQDXIUa4O0/T7L5V8N7OH4NQw/cCi9IcrDWITbrQbrWSVX9wK0y0ABJkQc4Sgix6YaQkt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924280; c=relaxed/simple;
	bh=WwH+3gC9rURcX32cFB4KT0yF/Xs+9RIHK/0OIfyMLXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAvrS6DS/9wvaUJo8cjbEMEJ6vEZcW2+hTmF8Y6AwBMEVWY0WXXsZPGEKBdfG5/zR9PXs52F4tOSkrsKeKjQpZL3j3SMBA+UudYZSUO6qCLV3bDJpDZKzKgvzIare6xbeUavdnqSIdB5tOGEk1eYRYC/zyTudkKbq+KJqOo0wqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5tiVksIu; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeqmRn8IFhskx6Maoo4/ciqs6EZI7WQibU7qrf7Ar4VNR33E13ZAY4M64xDQmyF+QExZP5Vr2oLOS/kcuF1RMnuJqqhD0Kw7Yapnd3FaMEJmBYZIIxKbt+6PFTPf2KWMzrVPV4BsR9cqz2AMUNP2yM1m0Kxr+Lm50coUNNn7k4xoz1C0GTurPaybwXibbaXk+ozhAq3O4PiQlFHnCTPcyVG0phqM5JBsxH/Zp6M3hgsAS/zv9tp5Mo3mxPB6WPfMysG/ingS++E6oU4E1dViWSlebSqXGICcsFwekUbq7RMgK9ta/dFJUXcYjEM9uy7Wf7sNNPhMJxUhDKkPkQF0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwH+3gC9rURcX32cFB4KT0yF/Xs+9RIHK/0OIfyMLXg=;
 b=ex+jl35T0o6rW4wLcOoppqCq5IUji2DoMtZu3LBnts+ryS3EjN5L4hJJPZxEYj0lZzVyLeEOdRNrvtFI6q8GRcutJ6vvmuuzvsR7suaPdXeZ+5OOcf+aNzWba1M+uCFQBYbu1MWBAWXOL8hDvrqOTOrHrrJvNo2nTivUWLsciLcIxG8M0HpHrTKQ5A1Iyq0T5CYbEEDLHCeW4+PPV9WXJas8E5zY5j61q3gS6NgU22wEa78n8SmRwCHduwWHoVOrvBD9ESsFTawcFUrQQ3BEi2Ydhprif1O93iSiXlS7EEnT3WxWbUwlR5OAVyJTMJtV/BVqjp9lc1e11GDzzgfwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwH+3gC9rURcX32cFB4KT0yF/Xs+9RIHK/0OIfyMLXg=;
 b=5tiVksIuUeYTIUVqm8k7cOXpbqQ08LdmYJPCVa0lJz8kCmcRPQsrFNoDGUnuGObI12b2zKJcUkGiyKw76BFTW8un/QvAviVYJrVM0NWcNpwh2KSJMqnMG4pPVbAcwpADhJgGNF3kWM0gQvo6E+89TpuLR+5vaJgIZkNrFVMXleIVRLdddHF+06FhaGoXVhIR5oBWZua3YfWDi0ygyjWtgimSGVazladP8afUPiGyMZgJEoUD+qaa2jsOq4jQb6pK3Tj5V4UERYc6IJ3iaXJZHx3swGLCxea01/BVxrsS5Qm9MQ6Yd8Xngy/RZmPsTVeuAV8DkZ+wZIicF7NyL0EwYA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:37:53 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 17:37:53 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Thangaraj.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink for
 improved PHY and MAC management
Thread-Topic: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Thread-Index: AQHbmKvwzLyEPzPoOU673ZLFAvNAd7OEJxMA
Date: Tue, 25 Mar 2025 17:37:53 +0000
Message-ID: <5de15da31f71e1bed8782375b402bcb5df2eb63a.camel@microchip.com>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
	 <20250319084952.419051-3-o.rempel@pengutronix.de>
In-Reply-To: <20250319084952.419051-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SJ5PPF7DCFBC32A:EE_
x-ms-office365-filtering-correlation-id: 2643aee0-cbc4-41d7-9ffa-08dd6bc3c5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmcxY1crMlZqUFJJbEpNTnUrREhjYkVZN2FISW5XejZ6UGpFMzVPbjA3UVpy?=
 =?utf-8?B?c1Q4U1lBZFNzVFM3Zk1iN3B4MDRid3c2SEZvcis2TEFoMEpWcXNjcnlXNlpV?=
 =?utf-8?B?aEVXRmlKV1RnY3F6UXBvVGJQWktoeEE2N0ZQUTAweG56anV4VWE3NVgxL3pJ?=
 =?utf-8?B?cXY4V2hZUzNCTHR5TDJ4cnNhWXVVNDYxRmw0R1VVZENvNUlHMS8ybWtNQU1l?=
 =?utf-8?B?bzJwSzFaY3c1OUpjRE1ZSGd6VGltV3A0OFE1UmFJdkh4dzIwQjJ1ajNpVmpS?=
 =?utf-8?B?OFlPVEg2YWoyYWh0eC9MRnIvTUwreS9hSUI1Ris2WFFxYkNDdEwxSFBva3BY?=
 =?utf-8?B?MVF0WWtsMk9OZkR3b0tFS1BLaEUxMGQ2eW44Yit1U1cvSlh6Ymc3TDN0bCt4?=
 =?utf-8?B?NXBFS3NGSlpIUi9hUDc0NVpPZkpDN0JlTzhSNEJXenpCYXVPYlRTU05ldFlr?=
 =?utf-8?B?b1VTdXR0dktCV1UzZFFlbHhraU5jVWlsbmVqNGExTEhvWUdHMUdFUmk1azBj?=
 =?utf-8?B?cHlXMkRkdzRDd0tvTlVYa05nNmtQYnY2ZmxVTm5jUTNxVXVLeVhFUk0raThi?=
 =?utf-8?B?TTZmaVo4a2pCMDNyeTlBSWloRCtxWkFtTEI3d2xrSSs4MFIxRE0yWEJ0TlZm?=
 =?utf-8?B?UTJ1MEZYYy9Hc2E2em1WeVhwLzlLbnFvVzlQR1B0THlDVVozTnFRRzgwcm56?=
 =?utf-8?B?UnJmZ0U5b243QnE0Smg4QS9xbHNqTDFVV21DMkl0cW5BRlVvMWpKTEtubGwz?=
 =?utf-8?B?ZDIzOVBYcm5Kck51SHArekJOQlNFT3JYV1VxSGlCdy8zQUNBSjl6a0hSZnVl?=
 =?utf-8?B?cCtsRjlSOWtTUGdXRzdIdms4Skd6Q05zZEZYU1Y4cmNBcStjUWh6TGxadnAw?=
 =?utf-8?B?a0ZPNSttMXpGYWtibldBa2VLTUNWY0cvSjdWWjduYjNjcHFaTkd6STdxNzdq?=
 =?utf-8?B?TzVCeFFGd20wZVc4RndtdkhiOXJUeWc5cHBNVmdHVE95SXZWVkg2Ni85aU56?=
 =?utf-8?B?L0dndEIvMW9DMlhiM0s1WXR4MUJxTUxhWHF0S0dycjIrV1dIYjFBaXZTdUdn?=
 =?utf-8?B?MW95bDJWcmsvcnhleFpSUVAzaUVvaHg3dk8yaThDZU9tSFRnVTlxc2c0bHdE?=
 =?utf-8?B?NXVJR3p2Qk5ZMTgxS1B6eHA5YjNaaXY0ZzNKSUNJdlJKQWpTMytzQnhtVTN5?=
 =?utf-8?B?anpod29lTWp6bFUzVkJONU5GODJQUE9DOVpKUVY2WDhJYzJ0Y085OHM2L2lW?=
 =?utf-8?B?alBwZFVDdjRBWERTUzJ2aDZhdTlCNEc4R0NQZE9IZlJjVHlFTGZSWlBva2Ix?=
 =?utf-8?B?dlNjWHh4cXNtcDhNYTkxcWIrVzRUblFQNVNrd2hDdFo4YnNSZHRMenhXdGxU?=
 =?utf-8?B?ZGlXcnk0TWhBMlJtc1NjU0diSk1qOXVKbDVFRVhYUkxIUml5Q2huWE1MTUdG?=
 =?utf-8?B?Z21TUHpBN0dTcVB0cUtYRUMwcE54VHF1QUo5UnB4d05ka3NLTE5UOHM1VW1M?=
 =?utf-8?B?WHRPcUUvS3BWWGJSYTNnbElHcjRmQyt3Mk84LzRrcXpYeU9YL041R3dYU243?=
 =?utf-8?B?QmZKUmp1N00wQkxFU2ZSSWF4c2Nsem9qMjZaRnd4bkpqVUdVUEFHazg3Mmlz?=
 =?utf-8?B?UHJyVUFvZ2w4Y3lJeURZQkVEZFdvemxoRjViMXREc0sva0huR0piWTlpRkRi?=
 =?utf-8?B?L1hQUmtVY0hLUWI0aTRocWtaM2lrSlJVL2lCTkFYOTE5WGF3bUxFazRqNE5I?=
 =?utf-8?B?ZWptcTRLcUp0WjVQb2N4emdQOUkyY0g1QkIvd2kyTFFrQ1BSWURaQzVhWnp2?=
 =?utf-8?B?WkR4S3FiQ3NmTEdDT0QvU2s0aTlYclU4Q3o2MW9mZEZSc3hqTjJtYStXTjlM?=
 =?utf-8?B?VzN4ZklNK3ZYRVQwa0RmaHBDeGZYLzA1R0RBRkZIMGdoei8xaWhYU2taeWxr?=
 =?utf-8?Q?SYic4DCT2Mn/pJ71C9fY6wHm+79971kp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU1QSDdxd2JwZk1XdlI0cXFIVEZGTWptbXp2WjJHRW4rTWpZR01TNUQ4Tyt5?=
 =?utf-8?B?UXh1cWdXQ2M4STNrRGZKcUVEZWJyOEVzZ1VtMXJSc3dWN2pMQmdlZ2s0SUxD?=
 =?utf-8?B?YmlWUHRmemhLT0pFZWZlaVF4ZE1RaytUYzByOWFBemF3WWRxa0F6ZmhIenFJ?=
 =?utf-8?B?R09Ba0lIbWhVMWpRQW11amhuTkV3TjdhY3o4M3l2UUQ2bVBnK2duODdtN1Y5?=
 =?utf-8?B?Sk1rVmN4SVpLZ0xhSUh5S3JkNVRNUFhyUGE3WUs1d0o3eHZzMFBFaENIUWRN?=
 =?utf-8?B?U2k2ZkxYOUpVeXNGU3JWcmQvSVpmOVBXQ1dCRDV1czVaUXYzbWdrbytQVkN3?=
 =?utf-8?B?aUlqUUVSdjFpOWlZWGtob0lza3R1Vm13YldvUUFKamErcHdsL0FyVEdJSzNR?=
 =?utf-8?B?MWVqMDN2QzVUMkdvTkZweXdkWG50c2ZKMWt1ekpQN3RORTNKS2xuN1BNdW9J?=
 =?utf-8?B?QTNDTURMMkJGQTB5RG1scHZLb29mOE45TkdQU2tLSUJyckVBb1JBV0hPREFl?=
 =?utf-8?B?blM1MlhPamFXcnRCeHUvQXJXWFFCVjIwOXdwVExSNThPMFpDaFFoRklLaHc5?=
 =?utf-8?B?WnZobnN4K2F1aitMODltWGkzbDBXU0NMdUZRUlhFRTV5THViSm84OU9aZ09K?=
 =?utf-8?B?MWxnNVBMYXYwTUZlSUZZL3RUODFPdXVUT1QrS2o4Y1M2VGJBajRwRjF0TGp5?=
 =?utf-8?B?MCtEMGRBWW5uZ1JNNjVhOGJEUExrb1c4c2E5WDZCMGJlOVluamN5WklyTVRx?=
 =?utf-8?B?U3FjOHVMVG5FN0FQSjBmZlM5NGg2Y2x3ejJLMUhoWURuZW1LbTBXNUtsbjNC?=
 =?utf-8?B?Q09ha1IyS2dKYnJYWlZjdVBETEZUTEQ2WW9yMVdtZXN5Mm5VVEtUNHBvZW9F?=
 =?utf-8?B?Z0RLUkhNazU2bWFtejJEb0lvTmdZTWpRTmFDZ25lYSt4Lzhvb085MXpiUTdY?=
 =?utf-8?B?SU15QmhQcjlZbVphS1dDQlhaMlhVZ3dqUGVqVWFYdERxVUxaUFh4TkpoK0xD?=
 =?utf-8?B?ZHVBaUo5OSs0SVhsVm1EbGx6MHl1NGgzeWQyb2tkaTNFK2JJZ1ZrMmZkQStD?=
 =?utf-8?B?OHdIbUo0KzdMR1N2QzVSa1RkV0R4SmgyZFB0Ty9zdy92dVhibkxuaWg2MElH?=
 =?utf-8?B?M0luNCtxWlpxZVppRWRxOTRFRnMyQlQ1MzdNbEVUUVZtMm9Dc0ZrcGlJaHhR?=
 =?utf-8?B?N1Jsbk5INjJ2WGtDUmRSYkRmRldtRE1rZ096WGt1ck9KZWJ4ZW5Fb01CbjN6?=
 =?utf-8?B?emoyUjFZUDdKTDBuVncwQm00aU1OdFZ6dTZqbnlWMTAvQktZck5BdStxUDgy?=
 =?utf-8?B?NzJmbDJlOTNKbzd3NTVzNEFTcUhmQldiWG4zaHVrUkJDbkEyemd3MWI2Mlpo?=
 =?utf-8?B?NGt1OFRmc21xaEw1ZFo1dzNQcWZMREVSOG15dVBueWcwenpWd0ZSdHIrS2Vo?=
 =?utf-8?B?VCtOSkdHdElkNTl3SDlrV3dHUkFueHh1QThqWlRENFlsRGFTdjBDZG5WV003?=
 =?utf-8?B?cW40NkFwZ0hpWW0vYXZWZDhtbG04a2wwQTR1dFFObDFvOHJVQlRRQktRS0Ez?=
 =?utf-8?B?V3pUblBob2dhUzcreWh6cy9zZ2RIek40blduOXJlcmZZOWptam1FWE9GOEQv?=
 =?utf-8?B?SndBeG9icFdTUzM2ZkxId29GVy96NWlqUFl6TEtzTEVKL0xoWDJZckFzVUxz?=
 =?utf-8?B?WGFZNFBLQklCSDd0cFI5VW1TcVFOV1ZBUEVKUXhKakZNazZUc0lWRnVadW9V?=
 =?utf-8?B?aDd0T01JTjhaTE9tdHlWSldZSGtQb0xoZ0tDLzljN0RuMFFMcXptTFVBbG9N?=
 =?utf-8?B?RkliQVNTb1laUG9RTkVBRUl5aEMxbC9IK3I4Y3g2WHR2czh5eTBzdWlRRDVp?=
 =?utf-8?B?YWljZldYTDdvNy9VUVFYVzBpMU5udWNyQXkrZFlrNUdValhHUXllWE5LNkUw?=
 =?utf-8?B?SWRCNWw5bVNzOExWdXUzdUY1SUtjbFBidTZOZlE2a0xmejRWZE1BYlRKMlhm?=
 =?utf-8?B?Y2kwcEY4WkRjY2NDYWVhZHVOOU1QMEJrSW9pQW1DSjFVN3NIM3o1VndaRlc0?=
 =?utf-8?B?K0lvVE9ZSFJ6QzNQeGw2MVVTN1RQR2hTQ3E4NEY0Um5TS0V1OUZsWWxpK2Nl?=
 =?utf-8?B?TktlRFJyZUJXNWx0MWdtSzNoeHZGNHM3QTlCSGVhS25UQ00rdjI1YjZpQm82?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14FB9251034AAC4192DB797829F38649@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2643aee0-cbc4-41d7-9ffa-08dd6bc3c5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 17:37:53.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGVbhbzdVycOseDUdeDqNj9ui3yDZoyJu72bs18tI8W2Z9cRCDiYtqYCaPq2b4oM9scMOogeOkn6uCDVlwNTpBBwxqwP1c0fwUOlGBl7BJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A

SGkgT2xla3NqaSwNCg0KT24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjQ5ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBDb252ZXJ0IHRoZSBMQU43OHh4IGRyaXZlciB0byB1c2UgdGhlIFBIWWxpbmsgZnJhbWV3
b3JrIGZvciBtYW5hZ2luZw0KPiBQSFkgYW5kIE1BQyBpbnRlcmFjdGlvbnMuDQo+IA0KPiBLZXkg
Y2hhbmdlcyBpbmNsdWRlOg0KPiAtIFJlcGxhY2UgZGlyZWN0IFBIWSBvcGVyYXRpb25zIHdpdGgg
cGh5bGluayBlcXVpdmFsZW50cyAoZS5nLiwNCj4gICBwaHlsaW5rX3N0YXJ0LCBwaHlsaW5rX3N0
b3ApLg0KPiAtIEludHJvZHVjZSBsYW43OHh4X3BoeWxpbmtfc2V0dXAgZm9yIHBoeWxpbmsgaW5p
dGlhbGl6YXRpb24gYW5kDQo+ICAgY29uZmlndXJhdGlvbi4NCj4gLSBBZGQgcGh5bGluayBNQUMg
b3BlcmF0aW9ucyAobGFuNzh4eF9tYWNfY29uZmlnLA0KPiAgIGxhbjc4eHhfbWFjX2xpbmtfZG93
biwgbGFuNzh4eF9tYWNfbGlua191cCkgZm9yIG1hbmFnaW5nIGxpbmsNCj4gICBzZXR0aW5ncyBh
bmQgZmxvdyBjb250cm9sLg0KPiAtIFJlbW92ZSByZWR1bmRhbnQgYW5kIG5vdyBwaHlsaW5rLW1h
bmFnZWQgZnVuY3Rpb25zIGxpa2UNCj4gICBgbGFuNzh4eF9saW5rX3N0YXR1c19jaGFuZ2VgLg0K
PiAtIHVwZGF0ZSBsYW43OHh4X2dldC9zZXRfcGF1c2UgdG8gdXNlIHBoeWxpbmsgaGVscGVycw0K
PiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPg0KPiAtLS0NCj4gY2hhbmdlcyB2NToNCj4gLSBtZXJnZSBldGh0b29sIHBhdXNlIGludGVy
ZmFjZSBjaGFuZ2VzIHRvIHRoaXMgcGF0Y2gNCj4gY2hhbmdlcyB2NDoNCj4gLSBhZGQgUEhZTElO
SyBkZXBlbmRlbmN5DQo+IC0gcmVtb3ZlIFBIWUxJQiBhbmQgRklYRURfUEhZLCBib3RoIGFyZSBy
ZXBsYWNlZCBieSBQSFlMSU5LDQo+IGNoYW5nZXMgdjM6DQo+IC0gbGFuNzh4eF9waHlfaW5pdDog
ZHJvcCBwaHlfc3VzcGVuZCgpDQo+IC0gbGFuNzh4eF9waHlsaW5rX3NldHVwOiB1c2UgcGh5X2lu
dGVyZmFjZV9zZXRfcmdtaWkoKQ0KPiBjaGFuZ2VzIHYyOg0KPiAtIGxhbjc4eHhfbWFjX2NvbmZp
ZzogcmVtb3ZlIHVudXNlZCByZ21paV9pZA0KPiAtIGxhbjc4eHhfbWFjX2NvbmZpZzogUEhZX0lO
VEVSRkFDRV9NT0RFX1JHTUlJKiB2YXJpYW50cw0KPiAtIGxhbjc4eHhfbWFjX2NvbmZpZzogcmVt
b3ZlIGF1dG8tc3BlZWQgYW5kIGR1cGxleCBjb25maWd1cmF0aW9uDQo+IC0gbGFuNzh4eF9waHls
aW5rX3NldHVwOiBzZXQgbGlua19pbnRlcmZhY2UgdG8NCj4gUEhZX0lOVEVSRkFDRV9NT0RFX1JH
TUlJX0lEDQo+ICAgaW5zdGVhZCBvZiBQSFlfSU5URVJGQUNFX01PREVfTkEuDQo+IC0gbGFuNzh4
eF9waHlfaW5pdDogdXNlIHBoeWxpbmtfc2V0X2ZpeGVkX2xpbmsoKSBpbnN0ZWFkIG9mDQo+IGFs
bG9jYXRpbmcNCj4gICBmaXhlZCBQSFkuDQo+IC0gbGFuNzh4eF9jb25maWd1cmVfdXNiOiBtb3Zl
IGZ1bmN0aW9uIHZhbHVlcyB0byBzZXBhcmF0ZSB2YXJpYWJsZXMNCj4gDQo+IDIwMjIwNDI3X2x1
a2FzX3BvbGxpbmdfYmVfZ29uZV9vbl9sYW45NXh4LmNvdmVyDQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvdXNiL0tjb25maWcgICB8ICAgMyArLQ0KPiAgZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYyB8
IDYxNSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMjk4IGluc2VydGlvbnMoKyksIDMyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvS2NvbmZpZyBiL2RyaXZlcnMvbmV0L3VzYi9LY29u
ZmlnDQo+IGluZGV4IDNjMzYwZDRmMDYzNS4uNzExNjhlNDdhOWIxIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC91c2IvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL25ldC91c2IvS2NvbmZpZw0K
PiBAQCAtMTE1LDkgKzExNSw4IEBAIGNvbmZpZyBVU0JfUlRMODE1Mg0KPiAgY29uZmlnIFVTQl9M
QU43OFhYDQo+ICAgICAgICAgdHJpc3RhdGUgIk1pY3JvY2hpcCBMQU43OFhYIEJhc2VkIFVTQiBF
dGhlcm5ldCBBZGFwdGVycyINCj4gICAgICAgICBzZWxlY3QgTUlJDQo+IC0gICAgICAgc2VsZWN0
IFBIWUxJQg0KPiArICAgICAgIHNlbGVjdCBQSFlMSU5LDQo+ICAgICAgICAgc2VsZWN0IE1JQ1JP
Q0hJUF9QSFkNCj4gLSAgICAgICBzZWxlY3QgRklYRURfUEhZDQo+ICAgICAgICAgc2VsZWN0IENS
QzMyDQo+ICAgICAgICAgaGVscA0KPiAgICAgICAgICAgVGhpcyBvcHRpb24gYWRkcyBzdXBwb3J0
IGZvciBNaWNyb2NoaXAgTEFONzhYWCBiYXNlZCBVU0IgMg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdXNiL2xhbjc4eHguYyBiL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMNCj4gaW5kZXgg
MTNiNWRhMTg4NTBhLi5mZDZlODBmOWMzNWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3Vz
Yi9sYW43OHh4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYw0KPiArc3RhdGlj
IGludCBsYW43OHh4X2NvbmZpZ3VyZV91c2Ioc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYsIGludCBz
cGVlZCkNCj4gK3sNCj4gKyAgICAgICB1MzIgbWFzaywgdmFsOw0KPiArICAgICAgIGludCByZXQ7
DQo+ICsNCj4gKyAgICAgICAvKiBSZXR1cm4gZWFybHkgaWYgVVNCIHNwZWVkIGlzIG5vdCBTdXBl
clNwZWVkICovDQo+ICsgICAgICAgaWYgKGRldi0+dWRldi0+c3BlZWQgIT0gVVNCX1NQRUVEX1NV
UEVSKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICAvKiBVcGRh
dGUgVTEgYW5kIFUyIHNldHRpbmdzIGJhc2VkIG9uIHNwZWVkICovDQo+ICsgICAgICAgaWYgKHNw
ZWVkICE9IFNQRUVEXzEwMDApIHsNCj4gKyAgICAgICAgICAgICAgIG1hc2sgPSBVU0JfQ0ZHMV9E
RVZfVTJfSU5JVF9FTl8gfA0KPiBVU0JfQ0ZHMV9ERVZfVTFfSU5JVF9FTl87DQo+ICsgICAgICAg
ICAgICAgICB2YWwgPSBVU0JfQ0ZHMV9ERVZfVTJfSU5JVF9FTl8gfA0KPiBVU0JfQ0ZHMV9ERVZf
VTFfSU5JVF9FTl87DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gbGFuNzh4eF91cGRhdGVfcmVn
KGRldiwgVVNCX0NGRzEsIG1hc2ssIHZhbCk7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
LyogRm9yIDEwMDAgTWJwczogZGlzYWJsZSBVMiBhbmQgZW5hYmxlIFUxICovDQo+ICsgICAgICAg
bWFzayA9IFVTQl9DRkcxX0RFVl9VMl9JTklUX0VOXzsNCj4gKyAgICAgICB2YWwgPSAwOw0KPiAr
ICAgICAgIHJldCA9IGxhbjc4eHhfdXBkYXRlX3JlZyhkZXYsIFVTQl9DRkcxLCBtYXNrLCB2YWwp
Ow0KPiArICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gKw0KPiArICAgICAgIG1hc2sgPSBVU0JfQ0ZHMV9ERVZfVTFfSU5JVF9FTl87DQo+ICsgICAg
ICAgdmFsID0gVVNCX0NGRzFfREVWX1UxX0lOSVRfRU5fOw0KPiArICAgICAgIHJldHVybiBsYW43
OHh4X3VwZGF0ZV9yZWcoZGV2LCBVU0JfQ0ZHMSwgbWFzaywgdmFsKTsNCg0KSXMgaXQgcG9zc2li
bGUgdG8gY29tYmluZSB0aGUgbWFzayBhbmQgdmFsIHVzZWQgYWJvdmUgaW50byBhIHNpbmdsZQ0K
c3RhdGVtZW50IGFuZCBwYXNzIGl0IGFzIGFyZ3VtZW50IHRvIGxhbjc4eHhfdXBkYXRlX3JlZy4g
WW91IGNhbiBoYXZlDQppdCBhcyBlbHNlIHBhcnQuDQoNCj4gK30NCj4gKw0KPiBAQCAtNDM1Miwz
MiArNDMyOSwyOSBAQCBzdGF0aWMgdm9pZCBsYW43OHh4X2Rpc2Nvbm5lY3Qoc3RydWN0DQo+IHVz
Yl9pbnRlcmZhY2UgKmludGYpDQo+ICAgICAgICAgc3RydWN0IGxhbjc4eHhfbmV0ICpkZXY7DQo+
ICAgICAgICAgc3RydWN0IHVzYl9kZXZpY2UgKnVkZXY7DQo+ICAgICAgICAgc3RydWN0IG5ldF9k
ZXZpY2UgKm5ldDsNCj4gLSAgICAgICBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2Ow0KPiANCj4g
ICAgICAgICBkZXYgPSB1c2JfZ2V0X2ludGZkYXRhKGludGYpOw0KPiAgICAgICAgIHVzYl9zZXRf
aW50ZmRhdGEoaW50ZiwgTlVMTCk7DQo+ICAgICAgICAgaWYgKCFkZXYpDQo+ICAgICAgICAgICAg
ICAgICByZXR1cm47DQo+IA0KPiAtICAgICAgIG5ldGlmX25hcGlfZGVsKCZkZXYtPm5hcGkpOw0K
PiAtDQo+ICAgICAgICAgdWRldiA9IGludGVyZmFjZV90b191c2JkZXYoaW50Zik7DQo+ICAgICAg
ICAgbmV0ID0gZGV2LT5uZXQ7DQo+IA0KPiArICAgICAgIHJ0bmxfbG9jaygpOw0KPiArICAgICAg
IHBoeWxpbmtfc3RvcChkZXYtPnBoeWxpbmspOw0KPiArICAgICAgIHBoeWxpbmtfZGlzY29ubmVj
dF9waHkoZGV2LT5waHlsaW5rKTsNCj4gKyAgICAgICBydG5sX3VubG9jaygpOw0KPiArDQo+ICsg
ICAgICAgbmV0aWZfbmFwaV9kZWwoJmRldi0+bmFwaSk7DQo+ICsNCj4gICAgICAgICB1bnJlZ2lz
dGVyX25ldGRldihuZXQpOw0KPiANCj4gICAgICAgICB0aW1lcl9zaHV0ZG93bl9zeW5jKCZkZXYt
PnN0YXRfbW9uaXRvcik7DQo+ICAgICAgICAgc2V0X2JpdChFVkVOVF9ERVZfRElTQ09OTkVDVCwg
JmRldi0+ZmxhZ3MpOw0KPiAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmZGV2LT53
cSk7DQo+IA0KPiAtICAgICAgIHBoeWRldiA9IG5ldC0+cGh5ZGV2Ow0KPiAtDQo+IC0gICAgICAg
cGh5X2Rpc2Nvbm5lY3QobmV0LT5waHlkZXYpOw0KPiAtDQo+IC0gICAgICAgaWYgKHBoeV9pc19w
c2V1ZG9fZml4ZWRfbGluayhwaHlkZXYpKSB7DQo+IC0gICAgICAgICAgICAgICBmaXhlZF9waHlf
dW5yZWdpc3RlcihwaHlkZXYpOw0KPiAtICAgICAgICAgICAgICAgcGh5X2RldmljZV9mcmVlKHBo
eWRldik7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIHBoeWxpbmtfZGVzdHJveShkZXYtPnBoeWxp
bmspOw0KDQpCZWZvcmUgZGVzdHJveWluZyBwaHlsaW5rIGhlcmUgaXMgaXQgcG9zc2libGUgdG8g
YWRkIGEgY2hlY2sgdG8gbWFrZQ0Kc3VyZSBkZXYtPnBoeWxpbmsgaXMgYWxsb2NhdGVkIHByb3Bl
cmx5Lg0KDQo+IA0KPiAgICAgICAgIHVzYl9zY3V0dGxlX2FuY2hvcmVkX3VyYnMoJmRldi0+ZGVm
ZXJyZWQpOw0KPiANCj4gDQo+IEBAIC01MTU4LDcgKzUxMzcsNyBAQCBzdGF0aWMgaW50IGxhbjc4
eHhfcmVzZXRfcmVzdW1lKHN0cnVjdA0KPiB1c2JfaW50ZXJmYWNlICppbnRmKQ0KPiAgICAgICAg
IGlmIChyZXQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC0gICAg
ICAgcGh5X3N0YXJ0KGRldi0+bmV0LT5waHlkZXYpOw0KPiArICAgICAgIHBoeWxpbmtfc3RhcnQo
ZGV2LT5waHlsaW5rKTsNCj4gDQo+ICAgICAgICAgcmV0ID0gbGFuNzh4eF9yZXN1bWUoaW50Zik7
DQo+IA0KPiAtLQ0KPiAyLjM5LjUNCj4gDQo=

