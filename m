Return-Path: <netdev+bounces-233550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D4C15502
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 804C24FB771
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0430340A6D;
	Tue, 28 Oct 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eo4OPQSS"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4833EB0E;
	Tue, 28 Oct 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663520; cv=fail; b=HT4mFyzK0fJN1a3Z1ucOvtUZTlrAhPaqFjVys7qpoPwrQ9rETXhdYx6wrAzxVW9vOPRTPaq4ro0btTvJfrXPUMeX7gvq1Xdx7uZmNBncjHdoZHbsUKmLQVagi8Y64G5nqwgC/68jgRSJ0J5+t2vIAl1birwTKhIXgL094QJHyqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663520; c=relaxed/simple;
	bh=uYUYd/mmaWQcxbwwvvfroHS9NJlMsOd9i0+pD/9lYDs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M5lz7seXAEZ8OLvbbh9IDrcAAAx23BjkibiwyaW4xrWngWr+6ylvrDx6C4jTqMSpb8VBo78cmVaetqjEgYRBIv/7WErAE0fvUYRSgMNnA5Ns5gKa7cjFvNZvkRzMyJ35yvVOuI4RJfei2YVAMkU/baOJFNR8eMb8CsKS25C4WmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eo4OPQSS; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okJP+2HcY3dyxPsdvwrtDu+zbNuPZWT800IZhlHZ6Kfypq+8sf6kphbpLr9/8vSvT9Iz2HrXw98Cc4Nez+NsWdNHBvwNhll+ALLyIOv5ZuQnAafg/6O+SLeoBwmB2bubwMiiQSchb2ezuekNs9NmmfGbiMilvwZknVDIURs2ho5cWVYdoiiSJzBira9vtMPpwNjlebhcRaXOkMxZt8JTVsy8z/3x393kpKghhoARGfMjUFL7crFQY0r5POxdZ0varY19rNCwgbwxItmr7b8/iDg8YNJjF4fQ89Z8I4zQ/JbT+UIdf5RX9NjHByImiLLnGQ15bRCX5YZnZfH8Y/CYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXl3JJnbOOklJCEu0ADhDdnBbAHNKUSJQFfbHzE2IUA=;
 b=LiWTfg2BIbnseUsqp/HalWxQ6XZsDWf6kOtOF+tQCAhqlSnxYTSFjBQ9zH8ULsGxVCo+a6kOKHo0iGuW59YChpHaQB7Lb6QoaPrRN8bKuLzwCiyPMmwW7qDBeJYSoMNdEjS68iQdxCZB21gii17gD//NsqH+8hUzagXnSR93e8hZjAk0h98Cep9/Qx4BOIhO/dQSQ8Ij+I5tIqhX2lGkMJJf26MU53Sb6Ov8Xi7SLwA3PQVEPNKRV6nIr2dwmlP0kj47JdyfK4aghWjl3C77C2EsSZOC8UM8boVVsJv1Cp02vuzWP4YPF6ZmYww5A1nQrFgtF4uN2jKBuSy8WFOLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXl3JJnbOOklJCEu0ADhDdnBbAHNKUSJQFfbHzE2IUA=;
 b=eo4OPQSSRIhfA6KTJIY40OjfpeGxWhj152tyJBM86HOOa0YS/hcafsD3Hm9hE/6XtBScDc34WGoYqbjOzcxQ/OKiDz4qDLZXdfpvcgUmVh9OzRlg9kfsbCYzmnVVDRxshUyCkudlrmw38V4t76ZnM8blcqTIoh8/sqgcwnzC4RrNQixei5j3MU7IFv0gVkHFt0vcR3NVXc/M7WzpBUegoJxVyrKTOSEwFcnwjy1TVxXMIOVlT7UmYD7ZuxX29VGFFwTYejfoRjJjKIF1Ya0G0DrC3p19kPbzOGkpYM2H7V9bmv/dvdPFaATXuhq8RlrmPYNYHulHVlGgEFY/xpFauw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:58:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:58:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:57:55 -0400
Subject: [PATCH 4/4] i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-lm75-v1-4-9bf88989c49c@nxp.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
In-Reply-To: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761663488; l=1769;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uYUYd/mmaWQcxbwwvvfroHS9NJlMsOd9i0+pD/9lYDs=;
 b=rvrKZYwmJC5bmYFIpTA3KP5BbG6KDHhqBEsWi4tuwnOnjeSCfwjgauM7ge5mzK1eaO9UUJDw4
 O+XynH5tVw1Dz5RS4XGFQnWJmiDVSqh37lGclohi2v5AL0B5jCppHwi
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
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b368e9-e090-4159-1447-08de163273c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXd3L0NNUE5iNVNrZ2xRSVRtRUd3eTY5Tm80dlBndGdaZkJMMS9Sa2g3cXMy?=
 =?utf-8?B?Tm0xWmtiYXg2N01BVU9HbXlqSjJvTi9sUG1ydnpoUHlRT2JlUnY2a09ETHFi?=
 =?utf-8?B?T1NDYjBFY1ZkeXJxOXZQenFlYnlzeGUzL1pQTVpra1VSL0psSFV5MTlSeWdz?=
 =?utf-8?B?WVJydnJEdGJMZEREcWQwOGFObGx3TzA1VzYxSEh1emJ5eVJGRkRXUUFzakg2?=
 =?utf-8?B?eW5aeXVCZ3IxQ21iWkQ3SDU0SHg3NTQ2TGs3c3FsN0x1NTlrYTMvZkY5alVI?=
 =?utf-8?B?WExvZEVZL3lRckthQkN1Vi80TXlndWE0V25QQUd0MkJlQktPRzdWYmh4TG8v?=
 =?utf-8?B?aFJxWVhNOUZ1Z3B5cDRPZU9mVnJYMFdYK0oxZnpYVFJYc3QwWW9pSFE0WU9n?=
 =?utf-8?B?TDJvREsvN0JlaFdKUXZDMGdrR2k3dHlTeTEwaXFBNllDVk9NUjdZVWhDN2VR?=
 =?utf-8?B?TmgxWWNlTjdoSjdaU3FRTGJHMHNnRzB1K28wUlY4OTQxd0hCaWVPQi93c2FP?=
 =?utf-8?B?eDZMajJPN00vRHFvTU1LS01nMVZMZmkyRXlLS1Npc2xDU1ZNUm4zUCtYSjhG?=
 =?utf-8?B?SFpYNHR0eUNGUEM5bmlQSldzRGtQS3hjeFhVcFZTayttRCt4M1RZaHJmbGRV?=
 =?utf-8?B?ZXFWRUJYWDliMVBxWlBteDk1VlFreFVyUjBKTjgyT01GbTIyOHNMZ04wYkRh?=
 =?utf-8?B?Q1Jqb3RJZklyZlhzNm5GdVh1K2hSMDhwT1grK09oUHZET2pTSmNWdkdpSGF4?=
 =?utf-8?B?TUNJWDZaUWVLTys4aFRMbHRtOTAvOTQ2WUJuNDcvZitKaVNOQ29hb21SRnY1?=
 =?utf-8?B?emJlZVJLeStPY093QnBnbG44bmZVYjJCdmFoTllvV04ydi9HdmkxcVUzWDJR?=
 =?utf-8?B?TEhxdXRQOUc0N1BQa0hhQXE0Rm9ncC9Ua3VoMGx5QjJseVlpZEFEQzVBRkpn?=
 =?utf-8?B?UzBaZWo3M08zNjVBci9QMENTUFFKaGxsL2hPUDVXNG5wM2ZOM0w3aWRaU09Z?=
 =?utf-8?B?UHBPcURIY2NCcThzSEwvMHFFdWk5NkVLbHdtMmtSUmxDUStkbDVINkhhRFNF?=
 =?utf-8?B?YzB3QkdFWklNZ0Z2bG90SGhYK3VsZ3FwcXR3R2REeHY0Y2s1cmVidjBVeFVI?=
 =?utf-8?B?eGhpV2xWWHNEcGNLSEVMeDRLblZ5OXMyT2tOeWNJS1RvMm1kdkpQd3pFSndR?=
 =?utf-8?B?dkttQllDcndUeFZYT1hjbnlwd25hUC9EdUYvKzBSZWZ1WjJseWUzOTluUi81?=
 =?utf-8?B?cytMSHpaZmV0K3ZJUFl1NEVIVHowN3lkZjZrU0JkemtDVlNxbkdXL1hQNkI0?=
 =?utf-8?B?ZkhhcDRLQkpCTzNnYjlVSE9qVUoxbVpMMUxuZXk1L1ZFSTN3L3g3OG43aEF1?=
 =?utf-8?B?Wk85blI0U3N6N2ZJcFE5bXNiWk5FSEVXMVQ5TUg0K1QyVktxREJDWmNVUktm?=
 =?utf-8?B?cEQ4KzVTSlpGTVlaMFlLQjBIYVFaUUxVTld1aG5uWDF6N0JRQW5wYnBxQWEw?=
 =?utf-8?B?dVd2THE2TzNjaVc4Nm5mWHFIWFNzTHY4VEdtYUlpOGFCa1Z5NWVyNzQvSXFG?=
 =?utf-8?B?VGRHWnM3Y2xKL3J5OVA2clRtNGhMR2lRVkJUd3UrU2xQc29Tb0kzY1NJZnFs?=
 =?utf-8?B?cjd4b20rWlNRZ0ZqYmY1dVlmUFpWSi9XWUQ0N2NNSVdGdDNJTmdMNkRQRUpQ?=
 =?utf-8?B?ajdVQlBZY1F6REhQOHVSZVlySTMya3lzZWsvZXpoS1VFRXZwSnk2ZytPUHZP?=
 =?utf-8?B?NVBRcWVndy9sazJPd1JhZDkwV1FOMjZ6bHpYSEtLQTY2VHA3blczWVQ1QUV5?=
 =?utf-8?B?QWRnZ01IQ0QvUjlRVFVnUEVrdGtoYnJFMlBEUEg0UVVaT0tNVmI0NWhDeGk3?=
 =?utf-8?B?cm5JRkdKWDNDL0c4K2ZoL2Z2TEpTOEx1dTc0elNJWXZWUHNDSWU0LzNrSFFy?=
 =?utf-8?B?UTQ5azVadW1xbVQ3U0lTVUxHam1oWmdHbFBEcyt1L1Y2WEc2ZHZsZWZvQnlh?=
 =?utf-8?B?REl3UFJvOGw5V3BJUHFUT1JQa3RtOU5xVXErVDZRUkVVV094WVNPR0VGTXNL?=
 =?utf-8?B?UTdUVG5SOGRCam5ibmw5a2R5VmtkclNLMy9sdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmF4bHdUMk9JbHZJZnBJcmZ0UmFRelJtVzN5ZWRTNDJxOFBJenY2dDVONm1z?=
 =?utf-8?B?YVJsZHBLMjhJRjV1V3J1NVVWK1NwL0RtM3hBT2VRQ3ArQ0pNQlJSMk84dnZ0?=
 =?utf-8?B?OEdQRUFCWHhmQi9IbEZKS3owbTZmRGh4WEEyellyS3pDKzVZSkZiMktOVG5n?=
 =?utf-8?B?ejltM3BzMTdnSW1vb0wvWTJpMjkwaVVpbzdUUWdxUW9PamZFN3NsMnpQZDN4?=
 =?utf-8?B?UU4xdWNHTDVrbGQ4YVRxeUQyYU5mSFRrcFhHd3hjUThJd1VKQTA1ZE1WYTRF?=
 =?utf-8?B?SUtyaUcvcWdiWXJFenRMK3I4RWMyMUNMT0txZHZjSnBwL1BwVjJPUWRYRkRZ?=
 =?utf-8?B?THlzWFZmN2lFZlNVd3BUeFo4RHdaSVhNSDhWSDZQNXpzaHRERS9qK2tGcEZ1?=
 =?utf-8?B?cG5pcE9SNlNoaEtkNy9MMTJYbmVOU21TRDV4ZmFWckxsYmFBejV6VFc4amht?=
 =?utf-8?B?T1ZORlF6L29qb3M4cW1uZ1c3TS9KQU9HdXlXb3ZQZUdEdU1pTXBLUXkyR3g2?=
 =?utf-8?B?NzNqVlNWRWgvUnpxQ2l6N2NxSFYwZzVpVGJ5UDBQdk1IcG12VDJBd2RSdkEz?=
 =?utf-8?B?VzFtc250NGp5WW5zTTd0Y3lybWlxWGwyWUFVcGJhUEcwUWxLb2U1TDk2UXRr?=
 =?utf-8?B?SkFxLzgxWGRmMG01Sk9CamxZOGEvaXBQUmd0UzZlYnNhTFVZekNZRExnSDFj?=
 =?utf-8?B?bU50MFYrOUNxUE85RTJLRVo3Q1RWdE1xb0hhVmpvMStneFpIc1VsQ1JXUWxO?=
 =?utf-8?B?K1pCNEx1bUJaeVVCbkU3OGhIMTl0ZmN3MmxxQkNnNzFuVWN0WFhpVGlQTjVQ?=
 =?utf-8?B?STRISXlmbTgwV0ptZFErRnRzaGZsU25FWkRGVzRFMCt2aFRraVZOT3B2bUhz?=
 =?utf-8?B?RFJ0bWROOVpOZTJVK09QV0tCdWFoVkU4cEVTeUhPUVJUSFQ2SUFuTGZmZVBh?=
 =?utf-8?B?ckVqTWJxaFh5RXUrak5IWlM5WHcyVTNvWXpPUmNUOEVJMmtyWEpGdDdaT2th?=
 =?utf-8?B?UzVtMVJWMituQUowd2QzY3I2SStvR1lmWXp3ek5xVTJ3R1lqU3VUTmNmZEVp?=
 =?utf-8?B?RW1uNG5VOXV6b0NHU2dzOGE1SXhzbEErOW5wTmtWZVk0Slh6YllDb2JVTUp5?=
 =?utf-8?B?dmE4NC94QStaQ3Q0N1laNUpPNGlrVnU3MkhzSXNRbzZIcVNSWUluK1hnMm05?=
 =?utf-8?B?aThSczRSMWZTcWk4UTFIbTFLUXZ0ZXA4VlIyczl4QzBVMVljbU9pYnlhTE92?=
 =?utf-8?B?V0NiY3VEeEZCZmFKa3lzNm1uQlJaVGhxRVR6aUY0K21WMmxlSGN5ZGZLZUVx?=
 =?utf-8?B?S2ZtRHNwWEFrWkhwY0Q5ZUZpdTZxc1hzUEZsWFRzdVBPcHdtRjkweEhlamFZ?=
 =?utf-8?B?UStHNDliSUJic0VLcVZkdVA1Y0NxNzAydUpNaStIT2N0OEg4ZHNqQnMzblAz?=
 =?utf-8?B?RHVOeklnTm1RVVFEalVORXdZWXV0a0I5eXZSMVVNL2tmL094QkdaSDl4MnNz?=
 =?utf-8?B?ckY1NVJyWHE3Rmx2c0JwQVVlUUd6WndCMHRGYzBFb05aYnd0OFVOM1YrUzBQ?=
 =?utf-8?B?YkE0VlZSMTdmd291RFB6SFlBU0hJbk9kMDRjVlBZTVArVi9jYURXNnJnZDE0?=
 =?utf-8?B?VTU2VGpLRWRWSXBvTCt4bjlPcEJWWHJRdDNZMkdjSWNWSFhXYndLMGh5WVkr?=
 =?utf-8?B?UG56TkFkM2sweVhOY3J0Q1N1R29uNUZXdTZuM01IZFdsS3NIaGZ2SjRXTkdL?=
 =?utf-8?B?YlJ0TFdyWU9pMjc3WTdiVVFKbGoyaG8vWkUzaWZ4WEhNdFR6WlpIUDFwaG9i?=
 =?utf-8?B?NERCZGx1ajd2YUJFSHNvb050VVBiekxWQisxTzBkK1Z0NGFyVmtnQWhXckZF?=
 =?utf-8?B?Q2Q4YzRvMGFhaGdFV1IyQS9iZ1Zpd2diL01vTUpYNklqdDRJSWJ0ZXZBYUxB?=
 =?utf-8?B?V245Y3hPOGdxYUpLQ2Q1aDdBeGNtd2oyS1BmYXpBeG5CdFdnRFZjTjNrSnRk?=
 =?utf-8?B?cDJ3SHNPZXVDUEFYWVJOcmM5dUpRQTdOV2F5TUxhTU5iZjZ6aFcyRkpWU3NJ?=
 =?utf-8?B?QXNNL2xxaDBTRWhzb2J3VnpjaTV3RlNHVkcxd1VhSXphRVNEbXA5d2RLdWlB?=
 =?utf-8?Q?h1po=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b368e9-e090-4159-1447-08de163273c1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:58:28.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PzeouxQmH91zmR06N05XddX/b3BecZZxH4qgozx3rrQuJeeI40EkdaSgc5pnyZ1TzEhwfiyCiC7u9gdOPawzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

Drop i3c_priv_xfer and i3c_device_do_priv_xfers() after all driver switch
to use new API.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This patch need be applied after all other patches applied.
---
 include/linux/i3c/device.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index ae0662d9d77eb3fa0c976de1803e9c2ff9547451..47e6c95d87f9494d48c5b0463544916f26923501 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -25,7 +25,7 @@
  * @I3C_ERROR_M2: M2 error
  *
  * These are the standard error codes as defined by the I3C specification.
- * When -EIO is returned by the i3c_device_do_priv_xfers() or
+ * When -EIO is returned by the i3c_device_do_i3c_xfers() or
  * i3c_device_send_hdr_cmds() one can check the error code in
  * &struct_i3c_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
  * what went wrong.
@@ -79,9 +79,6 @@ struct i3c_xfer {
 	enum i3c_error_code err;
 };
 
-/* keep back compatible */
-#define i3c_priv_xfer i3c_xfer
-
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -311,13 +308,6 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
 			int nxfers, enum i3c_xfer_mode mode);
 
-static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
-					   struct i3c_xfer *xfers,
-					   int nxfers)
-{
-	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
-}
-
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
 void i3c_device_get_info(const struct i3c_device *dev, struct i3c_device_info *info);

-- 
2.34.1


