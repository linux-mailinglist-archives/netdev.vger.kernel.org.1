Return-Path: <netdev+bounces-248783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 672EBD0E7B5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A40BA3010776
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE6330B27;
	Sun, 11 Jan 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mks2jgMM"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27333064A;
	Sun, 11 Jan 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124465; cv=fail; b=NdjkfTMrNIXKEFmIq+kICaQB4b5DcYQ0qhd1BEXITMuELUvu0Am22eW9zkLO1hNoDyHsJmTPxmfCCiF5XfIpho6I/lJTG2O0Hsscxmu7Jlvq/HfxoVJj8KfmHaLi0SSXd2c0B+h63v57xt5RbxhLV4yKwd+6InqsohavY4MxupM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124465; c=relaxed/simple;
	bh=o1R+dSRx0PxLtt3+Bp/p3Yr/mJ/6xWdQVDi6kK+27ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tr8KD2qZ4i2/W0rfmzuufcn1Ky1bA7AJ0Nzn1RswDRgSiRSJwws+KMB1cXbvUKxXLFRNvewh8Mc0MUPdZ7MhsrlYy7lew2poW0TBPhZhiqmleRmpvrNS9OvWUGJJ6MRv770eaDQrDqHBUr9eKKsMEVTvQ6yKiLkJ7QCFXVUfMdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mks2jgMM; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPA72y9sVMJIE1djqvzmFGOjksy00fSF7kv0K0RoOt7hZmfsbYDg8hJFaUPlpRmUqLOu5tIQhhRp8PicynAPKZEghD6n2mt6eD2R3sV9Amb2hGA5M3pRsDaCp1EqMayxT0CMklanNahzJdzAqua+X+3QUQzwO8t6g7KWdMdAjZP5AD0mOpnxNBHLSSBAVocv9cRYlcKEsgedKM8Xn/WwcOiY02EAiTLVJTLuwq2ytKTMs1tPV+1FZWRyDcOuJ7au/KxgrjEZeBkeUmHuzJ4qdZk6GEUH5jcIIwnRO8Ky8cD7zPeoBuw7MxdGwff5c9gYAhwyJAXH+FJwgxpidCM11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMifGfZWqExURlipKxAQvVQxYjRaxAtF5HZ3ivTnHPM=;
 b=UKMSvQjilIbXy0d1Y3gnlxvIo8vH/P9USvWdAvFo8d3cDaWTnlWlAh9PXUNKyI1omGuLBWpvNvt1PoI+k5/mo9cJj/pZfrz0hJMl7O0locDIen6DmyUg91ULQXzpHQEmK7RuKDq9bM2j990gB2JNqNpmeYnFGurCTWuwUfGuZYUfwzJlR5FOB4AUUEHDlhw0O3YqH095XOrs0ofYebhITcgsxW8+XvldyuRWXe29jawlf+/NDdzumXQi/CmBOtug+NB4SffUWXvohI+rBBBf3JRZ6azchY0h3yT/5RLvxNYF2wfnb5aErib6yraeD6DLXt45vkYKatB/3c1xTESWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMifGfZWqExURlipKxAQvVQxYjRaxAtF5HZ3ivTnHPM=;
 b=mks2jgMMsFpdasxjylbMlJOPjWFQVbOLxlIvTtM4FIE2S1CTV52I99/h/BQOSzmCkJR37ZL0RWBZLX1KeG91H/Y4fEhjO5zANDDzhx+DMUqv6TW7HF/KTPd22ZpnmhBSEmpNSTlVLF7Me/9O7/7keF0S4nYEkzs4wwrpDU2qQmxRLAmsCBR9MCJ62RKqXoy81CJaqwuVWTRe7DVUdRxbSr+rvxjdb09QkyPuyfBZomNAFrZGDpy0vOcKIzYHgs2mYQTedFjR/Byh07FUFp3vQ30NppEAvfXMH1SArZ8bPAjH085+ZslWS9YL+Aiq6SEfViKlxZemYSkn1/x8//ATgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:40:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:40:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 01/10] dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
Date: Sun, 11 Jan 2026 11:39:30 +0200
Message-ID: <20260111093940.975359-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7453f7e7-95c0-4834-db92-08de50f586c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2MyUElqVmMyQWsyT0pNVWQ5MGNFblhscDFrVGg2RnB1cUorb0JtRWYzT2lY?=
 =?utf-8?B?VGdQR3Q3NUFXQk5SVlJ3TXFKNGNXb21mNGg2MTdkT3V0MWRzS0c5Z2k1cEVt?=
 =?utf-8?B?ampUdC9ScHd5aWJMQlpnQms3RUN5amdmd0Qzdjh6a0FTV1E0Y21NY1FmUjla?=
 =?utf-8?B?ZEtQVnpvSkdmL2RwSmlsYVgyUys5aTk1Q0ovMXkzWXlNb0ZEMmFMZm9UNklQ?=
 =?utf-8?B?bWZ1OXBrWlZGQlJJeGNwMVRXWkxzTGdxakVCeGZjaSt5aGVwaXMraitjYVR2?=
 =?utf-8?B?RTVFNHQzSFh1eWRsbWx6UTZveE9sSHAwMm05MUg2Ti93NC81V1l6QVg2V0FN?=
 =?utf-8?B?TXJUK0R5STdla0FIZjIzSXp4UnZ2MUhUSEd3ZnlaVnEwdGtwRlRRLzJKK0kz?=
 =?utf-8?B?L3UrVFlTUnlQUzRybVZSejlvYVZ3bEhiVm9BUENQMElXazVwb08wUDJ2V1Fl?=
 =?utf-8?B?NjRDaEx6RVZ1eXJpTmI3WS9BaG5HcWM3SXkrSkRHZGdXbGJSaWkyVExzTEhp?=
 =?utf-8?B?ZGdzWXhma0ZtcUgyQkxQTTFCcTVHL3djcklDZFRmdFBRazZSdkg2bjBJZjA0?=
 =?utf-8?B?RmVjaTFiaCtFUDZwaUdCbXI4Q3Bqd3ZMZzBEcmxvZGRDVm4vaVBLcHpseTJH?=
 =?utf-8?B?UGVESzFRUEtwUVpWVk5UaVBBdWJtTnkvaklyZmpPWnJ0c0h0bWd1Zkp6TXIy?=
 =?utf-8?B?YWVCSnRyRlRqSkpsZjNYQ1p3dEFNaVY1YWMwZUZjNVBsVXBmeGh4TkNlMVVl?=
 =?utf-8?B?Z1dFUHR0WU0rT09ZK3lyTGtSZXV2KzNlTGgydWJGQmI1Y1U3QmdSNHdScTBB?=
 =?utf-8?B?a3lZMFFwKzZUYjQvTndkZkdIeUJtU2hhNFI1V2U2R1d1aEpTSE14eXdHSlho?=
 =?utf-8?B?SGlWb2JLUHNxS0Nxckpld3hyMDlXWFk4TzlXVi9UK3NMME1aSkt2bmxDaFo0?=
 =?utf-8?B?aGRONTRoK2hPZ3BJQit2b1BRR252UUVaT1ZMdzZ6U3J6alpYWFFPLzRKa0dK?=
 =?utf-8?B?VHRiOHVabU1ZY2dkV1JrdG84TTNjYm1YRGFPMmI3dkJvMUtiUVhMc2s4MnVJ?=
 =?utf-8?B?dUVYRnZ2aThGOUFPWkYxV2srYnoyQXBoa3J4ODdNZ3IvRyt2NlZDTG95b3F6?=
 =?utf-8?B?SUVFWGdEblNYdi9jbTI2QTljOFFybkdQd1JVd3dFQkpqV2lRTXhZSktEeFlM?=
 =?utf-8?B?QnlPUWtUL1N4VzdNaHB4L0pMbngzTTBMb2JWdnVLRGZBS0gxemY2Y1hKck1B?=
 =?utf-8?B?T0htd3pLaUFxeVd3TGZnZWEvVGd3cG9pbStabW9KSEVZSTRJTFl6TVBhUmU4?=
 =?utf-8?B?VHB0OG0vMTZuZTVFMVoxNWlSNXlHckZLbWNGZjgrcDlwcmdtY1lweklveWVa?=
 =?utf-8?B?eHlkUFd5OFdBb1ZLR0VjL053czA3N0V1dDNBVG8vaEZwVzdrTWZUbTBqMVlz?=
 =?utf-8?B?N252QkNEVEJtOWI0MlUvbTcraUhkRGdsTFJFdWFtZXBJbmdlZXVsbS8zSzhN?=
 =?utf-8?B?TW40bjNaYVc5c3pneHg4RHZvS1RZOVlSRHpXNGp1dkF5dkpsVEdwWUJyS0FZ?=
 =?utf-8?B?S05sbDJFRGhaM0dnZVJkT3Nrd040djBPam4yWEMwTjhsSmRWYWFSZEtUdkJN?=
 =?utf-8?B?cXlGdGp5ZlYxOTdRV3E2Z3hSNk1vbkQyOTlPVGt1ejYza0p1Q3NQRi9adXBY?=
 =?utf-8?B?WnRGZS9FUkFweG16NHBWRTl6eVBZNzdZbXM0YjdjM25rdjRmd1M1QU15Mkp5?=
 =?utf-8?B?d3NPdFpVUkpwMWpoWWJwb3dMcTdZT2pUbnJrdTRwL3RHK00yaWNaYkp0dVNN?=
 =?utf-8?B?MTdVVVhDSW1lcFdnY1JmQWpJRGUvL3k4eU5CYkJOWHk5MGxmN2hrS014clMx?=
 =?utf-8?B?M29WRUp0anNaQnZxemt2ZWthTk5NaE9lcEJUZm4rZHZBNzFtTWx0aVRDME1k?=
 =?utf-8?B?S3BhSEJ1Y0x1aUoyUjFKMUw0Z1ArYkk0dkltVmVETXYrQWsvNUdkeXczaStC?=
 =?utf-8?B?TWVzWm9ZYVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhTMzc4TTRSRC84QnI2VHY3QkdwU0hXV1FERHNWZUxqcm5zNVcrVVBReitF?=
 =?utf-8?B?L1lXOGpCVzJrakVRVVREbnhxeEM3cjk4US8xNUU5RzJCWDhCVzFqNS96WWRC?=
 =?utf-8?B?T1ZJUVZXZVdZY3hrWFZCYmVYcjBvbEZiYW9wTHRTTFRSTnRXK1pObHE1VUVw?=
 =?utf-8?B?RkYxSlRKRlVnRllrTFVnYU50VXB1ZVNNcURsR09rWFNTVkNab1U3TzNrSDl3?=
 =?utf-8?B?SThSOURuTkJLRE9XMm5yaW14VnVkR1pQRERtOUdwK1ZRKytxK1hyMkZYOFNF?=
 =?utf-8?B?RjVvMHh2L1EyTU5VdXROaFFQS0VqYkhqWkF3SEJFSzJ3WWhnV3VFOTA4a0JE?=
 =?utf-8?B?OFhLaFU2YVU0c2NsTkpZRjdXK0tBdXdvelU2VmVJVm9IU3l1QWc5Tkg0ZjV5?=
 =?utf-8?B?ZE84VDZudGhEaWhlUytzNWpqMmEyVHpDNE1SQkdENUx1NDh5QjB6bGdhaU1X?=
 =?utf-8?B?S2NTMTRmWWNGU2s1ajFnNk5jN2F2QzY3ZzVQM3dvRW5FVno0elhVanhxR2dl?=
 =?utf-8?B?a3FHMHkwZ1dGM0J2YkRUTEFqY1NzczJIcm94MldqSXBSdkNodEYzRk5Edmtq?=
 =?utf-8?B?emZQMzQzWEN1Njhwb3l4aURIZ0JLckJCcWQ0T3dBb216MUx3N1FPenZ3amNO?=
 =?utf-8?B?T1U4Q3lEUzVrSkpzNWdWbEhwZTBIVFhlWUlJeDdZSC9EUEtQRExEc1RNVlVG?=
 =?utf-8?B?T1Y2ME15Tm5CMUhNSG9JdS9iL3o4YmU2eDhVZlZhdTJNRlNGb0c3bmdVdTZ6?=
 =?utf-8?B?MFVvay9SRlhldEpBcFVndDg5T2VkSHpvMEpkblBxMU5oRXNZOHVRY3FsQWdp?=
 =?utf-8?B?bHNCVUs0MkJkWm83NTI3NzhFbzV4MlBFY1JGTDh4bGw1NmRudTJ4UFpjNjB2?=
 =?utf-8?B?aW9qUm8xNTNNa3dzNklWeC9QdEFFT2RZRWVpVFFaYTQ3ZDh1dVE4VmlDN3Bx?=
 =?utf-8?B?OEF6bGhKK3Q0QXY2ZVJEUlZWaFRpUXB6dmlrY1FTVXBjL3lLRkJORjN2UFNs?=
 =?utf-8?B?M2l1Z09TdFhjbDk0d2U0SU80bi9hT2l0KzdVdWtISkpZdEhDaVpUVkJhb0Jr?=
 =?utf-8?B?UURmUGRIZ0NaNS9FYmJ0WDFwQU1ib1J4UU5ZUEtnclJkQWtEdFFzYUliSjNw?=
 =?utf-8?B?UGlaaUVHZVNMTzlNcHphYTY0QThSbjlFQXVGNnlzUGFHNnRjNGhLaFcvRlgw?=
 =?utf-8?B?WSt6aEZCLzMrVHQ3RnBQekJDSlRGZDdtdUx3MHp0TTFtaU9GbklMTUNQdnhm?=
 =?utf-8?B?ZkNINHg0cEw0MkhIQXJqVjBRYVZCN21EeWNjSjNEVFZWWnl3cUJnS2dVZEZs?=
 =?utf-8?B?YVBwNlhTdSt2d3lBdEh6b0tsVVBGUlJTVFZwTmRXR3JpZjBMTHNTNXhJMUUz?=
 =?utf-8?B?ZXg1cDBCeFVUVmhjN2hxVklVRzU5dVVrTWpvSVVhNGlCSlVvUUFiMmhnY216?=
 =?utf-8?B?NURDZU90NTg2dEdSdGd1NU01TWhzL3hiZVVJRDZITVRCb3dVZnFQYmlhTlBp?=
 =?utf-8?B?QmZ1UUxGVldDR0o5RjRGbVNyK29NdnM0ODd3RkxxK1RTRlFJZ0xGVWdzV3Fm?=
 =?utf-8?B?dkNUcFpsRThJcS94V1FxdXkrcXR6SnU4RkJNdXAwdUdIekVQREFBQU5BTG5W?=
 =?utf-8?B?S0l0aTAvdnlreGEzbXg2UHVEUWFraHowSUYzcjNldmxHMExFTUZyaUNzWk1I?=
 =?utf-8?B?NkJuWGQvTVZhZ2lEMEl1Y1ZabzREMmtBZVpnQnhTbFA2TVVrRFdRUGR2VldG?=
 =?utf-8?B?N3M5Q3AyU3VtSEwvZTVqalNtWWNPSWRjaW5TemRYUFYzV3VVYzFONC9uMlpN?=
 =?utf-8?B?YmpsYlViNVNtU1l2TjlpZlhxcnc5QmsrY0RoV3V0czE1RjQwdnFaYnVxT2k5?=
 =?utf-8?B?bXBXeENleE1VRmtHeks2UWFXQllnWk1Sdng5aUhaUVR2dlBrbDFzN0Z2NmpD?=
 =?utf-8?B?ZjdnSE5NRkVtSlZRcEwvajVjVVpPU1ExRlI2cVdreGw3SlpBTkdvYnh6TzVR?=
 =?utf-8?B?N0pEMWUrYm1uWFIzYXRkcUdpL1kwQitjcmJreHplamhKYUsvK0NJeGIrV0RC?=
 =?utf-8?B?WlJvNi9YOSt3V1FNWUsrNm5MRllEOHJPTkFROUFmT1Vad0t4VjJ2aWdoVTdD?=
 =?utf-8?B?Rk9pZUY0UitZRVpTRnhUcUovbkRIZ1ZkSVl6bDlqSm9lbUVBWlM4VENYdTRT?=
 =?utf-8?B?aFEwS0l2T0RONm5aOE1kMHNwRXlwZ0hadXZiVWFveHp4UnpWbE5zUDNuT3l3?=
 =?utf-8?B?YnkvYkNCWkVJcDh2NzBDaFZNTlZxTHkveG1LcW9IWWUydSsyeG9rQ2ZPR1F5?=
 =?utf-8?B?RlZ5Z1NscmtpNlhuNXZFRXNzeHROOE40bi9wM3NJbFVWR2lvemx4d3lIN3Vr?=
 =?utf-8?Q?LbpI/7kGRVflLQzQuufbz8S+byEa7S7wh8dXLKibs6Kyi?=
X-MS-Exchange-AntiSpam-MessageData-1: dBTqK20qU9s+Kiu4F1+KS8ba5B7jEfTmX40=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7453f7e7-95c0-4834-db92-08de50f586c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:40:59.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csfLcLdB4pOpEs6TMwLTwrB9wrrfnvQeRdRy5WU3QSiVE+0N01U2jgA9+TwM76Dd+PghrrfpCxKFvX1VUc/RMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

I would like to add more properties similar to tx-p2p-microvolt, and I
don't think it makes sense to create one schema for each such property
(transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
etc).

Instead, let's rename to phy-common-props.yaml, which makes it a more
adequate host schema for all the above properties.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v3: none

 .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (90%)

diff --git a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
similarity index 90%
rename from Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
rename to Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 617f3c0b3dfb..255205ac09cd 100644
--- a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/transmit-amplitude.yaml#
+$id: http://devicetree.org/schemas/phy/phy-common-props.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common PHY and network PCS transmit amplitude property
+title: Common PHY and network PCS properties
 
 description:
-  Binding describing the peak-to-peak transmit amplitude for common PHYs
-  and network PCSes.
+  Common PHY and network PCS properties, such as peak-to-peak transmit
+  amplitude.
 
 maintainers:
   - Marek Behún <kabel@kernel.org>
-- 
2.43.0


