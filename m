Return-Path: <netdev+bounces-206679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3AB040C3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDB3BADA3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7525A34B;
	Mon, 14 Jul 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fmqk6TcA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C4257AEC;
	Mon, 14 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501414; cv=fail; b=ldjw/G3Xba/oevFxDaygTQFG/fMKKJwexvJR13j2sHGehwbKnfdrwFuOSaw//V1CIuYJy0bLFRNRoKyUGl+4Y8N2kDB+fRoF1utNRdx1X2s/65zcbnjgR+SROrVCYiThiKw0hPOTjjHI72AeFqtTU6SkD5OXAYNudyMiwR7ldAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501414; c=relaxed/simple;
	bh=VEi8QZF5Gnkr+iLJbh6KalHjOPXwtI0CmvxakC3CS0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fjkd80JFFhNuCxxAtqzu7sf8H4MYoa+G8xbTchj1jfVnoB2Uh80PY3SC2pNciKFgrG6Tz1tYdRAKr0KV7WamYUi6pfjNFkXBPmzdhbJs3Hd/o0/sjjmyI9E6vDXO2Xd9CYjYrZNEaXj+CCABTaRyEQjSpXU6jGNlA+PulPd84Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fmqk6TcA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs3qx3CIcvEEGiD8aWtjoLpR+9Gm0kugFBdsphWuG47b2ptTx9JAd2kIzjlShN+xkXwHdYLZ4K6BzcstQAICsuuH5ABhjtrlKFyQXwOuEDlAUuBKhfl4WsdzxcIWuN805/Bqibn2oc4eb27yyU7oTERPsBrDZu7+Ylh8CcDpR1G2+O+Mr8k+gQcEOzgvGjw5HGDjjlY7aaaITkOyqRB2ocGsSutTCGktndMpac1aLYtYsucvusWNFQSZ1eKIRVZzU9NEZ0BUVIdU8pJZKhZi+LEaXO4FtD1Wz3FEqZ4q/tIYlynbSgUP5E1iJt1xCBUseubm4HeQqSwyzsX20uIhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYA51vma8B75PeLYaQrFa5VQDtSZyXLmtt+fMTxL7Hg=;
 b=mKLNIXBrT1PCaY3y5qT8iAbi+qsyXvbe4TvYIdVxWt/VIelZ0gsltnTHrXS5G+c6yTEa71jiE6t+0/iYMv0WwYztorKNc0DFy4QjL0Q4nR6hovRoO1OCPF4hPfiXbroXSGYIL/vvYUfmQg+OkOUp2dFmVt5W24THFGOqyFcKF2WC6KBdEk9Hfc2RzR45TdAhYLhuYdADJNMksM/m/v75TNxeeDePzOGDvPk55olp4HswP0USa5aol9drQSlOPhjnWcbxdkvgQORu02CqlXzrII/aVWZf/PuJouCLvkvGV5QCVCnfU5APjcUVtlEDSJLsQeIGjAwzyGQCTdH2vfjxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYA51vma8B75PeLYaQrFa5VQDtSZyXLmtt+fMTxL7Hg=;
 b=Fmqk6TcA1RNCbLf084kg+C8P+Glz+G1ELXUf9gfZYNqxT72PrUfnAhAU1YG4j4to+cG/SVA0t8c92tDu9fLczsOB90HOISYVdfA5czKvUmkitQKLt0CPywSAx7WGbYFyECSZmsT5ys0/GmW+8xuSjbS3dV9NySmQ4OAorMrfed/rOrbNQpWJ5lTyO4XQhJhEj5i0iq8BW6ZT4x998/5m/dljkidedaCTQWRnf6/pT6TrG5OR6iuLtTdU08tgQiDqj4SVdTCG/XRN2rldb8sAir2vDnDZlTB/O/Xwhv1BwJZm1SzJS3nfin8Va7Onyh/9Xp3NhsKOySfUGCcbusxknQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7692.eurprd04.prod.outlook.com (2603:10a6:10:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:56:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 13:56:45 +0000
Date: Mon, 14 Jul 2025 16:56:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Message-ID: <20250714135641.uwe3jlcv7hcjyep2@skbuf>
References: <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:50::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: e4768d41-77e8-4903-5e8a-08ddc2de44c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?xo2HhWPN/1aJk9rbp6rojmhEUIRO2gFSlBdzQgIoF2zEgwMr1G+iRxBeOn?=
 =?iso-8859-1?Q?c9WR7XUZmmrJlA5+XZb7flWYtsUuBYi1kMb1G6LU5x6xx/qwAOzrhyVefL?=
 =?iso-8859-1?Q?Gyevo+8dCGav8CV1pKDpe/p0bP+7UsNt0jXXa4PqMrQEiMlxB0OP01GwQa?=
 =?iso-8859-1?Q?FPHBLIJDDCkPJBt5rmJOvpzlq4hU05EWxpb0JroGNyTEPnqRpKrIy0IZjW?=
 =?iso-8859-1?Q?iKVdJrJJJ6ibwM0xcjZZdgTv+TVy9RGYH781tVJPY9fsVWHLFwIp3TgzNz?=
 =?iso-8859-1?Q?FKFAsvvKL+WbwfO7yUc1clBjeBlS0o3v7T+Zdk0/1iIy/+xs2MOubQjA0T?=
 =?iso-8859-1?Q?EpgAIES6/mXDU+xNuq85BGZ5GjNC9oYnnxpXPRYf7CpryQ/CRx3808vHGe?=
 =?iso-8859-1?Q?cJ/LI+hXP+Zwxpy1axx2xw1Ci7Yggbizkgyew6i7eaPyQuzzp0MYsPkgGL?=
 =?iso-8859-1?Q?zoCJKqJ4HSuq0X/J86gmekIVIv21jsuIFG0GKUVPiFGSWe+oyg1TCEN5Ns?=
 =?iso-8859-1?Q?HkbXv2Ud4TeHxIWL1A28q14gfULuP/udnTjIRxNYHTZJCUf9DqvFbqVOPV?=
 =?iso-8859-1?Q?HLCjIu6gShiOWTYlc0Il90f1InKtx+mlmNrW/emvMJprfzmW95zRMLE3dD?=
 =?iso-8859-1?Q?ngDG9/xtheMHmNF8oUgFkJYjpVitotWUHRnIczk2Mtrnbg4ntY58caywOa?=
 =?iso-8859-1?Q?+AkMlvcLES372CQ63So4tiOz6++iC//cI4yCFouFETTnDqExb+Nr44OhDA?=
 =?iso-8859-1?Q?H/RcyPg2QQIMvnbCHFszhcveQawnA4LU9/Erkl7zZLwGHSFx2ZM1/IRR7b?=
 =?iso-8859-1?Q?1bsRGSW2eSou2GOJbAKm64JuuLAPhJZyjg5ya8jjvNvz91eh4SpqqcSKPc?=
 =?iso-8859-1?Q?bB9NAnpZVjYgBvRMRJs/xYxwE/XrYSG1RvAaDdQGV0PjftCRoj5/SFSOHs?=
 =?iso-8859-1?Q?YHt7UPkLj3REL/+U/IVf+7fkZ2utL1UCKrDgYWH4pPdeCaKhWAvdO1vSMu?=
 =?iso-8859-1?Q?CcncMBu8khrm2Rw0Lwrym46bS7qPrJguvZoYoWaaC5tQTbuGlLJGGjM4uq?=
 =?iso-8859-1?Q?GE6hqcn1UrHXmt3WONGI7kUikYMB3yeQWo7BZDOvLBhzTj+xmNcj+48xXi?=
 =?iso-8859-1?Q?nnxusXIAsPdKeLcGbbMCbC8xdhdlgplLGFo//T7ZGWNyOBq9kzL/PvpLMj?=
 =?iso-8859-1?Q?bkyc6+0E8IycV2Y3+bGsHra3pNoazaXGbmV3Qv7wt6e/sCn7LlpVLlJQ8v?=
 =?iso-8859-1?Q?MYADUxFG2MPi2DYEUNMFfYmRJau9BXbD9IIJwhjGan9w5DtO0CWI6gCR+S?=
 =?iso-8859-1?Q?K5HxW3mK0F/rxs/KL2WP1HcRjHzwc7mU8zAT61Q1rzP7zVy9NgFlCbdkba?=
 =?iso-8859-1?Q?BEefcbPFGcnbiAXVH6xNFE0z/ktlyT3XqVfG4cfZLDubhu33EpwJnD0I0q?=
 =?iso-8859-1?Q?C7xbUDIDudSGB2mod7T7P+e6E1L8ZMlLZkTH7pXw+Y1ypUXQet5p/AoqCL?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dAm5Ja0K/BzfuI45Q8iZVjLJeaVoHv2FR5bjdiEzE3RU4hdTSPZhwn1P8x?=
 =?iso-8859-1?Q?D1ft6bhclW5Z7D6TTF3bqaqloFM+AjvigiZyjRUCUDlJHeb8AqqBtFTyv3?=
 =?iso-8859-1?Q?Ht2IjiyqAEEug7W3G73oz+YKs8jM3UiOi/u3FsvL9/1fSnupjXjh52RNnV?=
 =?iso-8859-1?Q?HhKHy/frGLRCCROc6mmX036kJvjF7acn6sBfjZtL5YvCmJHLHJTt/T/Mbb?=
 =?iso-8859-1?Q?8VHMvexhXyc56SDncNw+YDM/zYf2kz+c3eTV4lmHluq1UsWNCMuIxziKR/?=
 =?iso-8859-1?Q?CWjGACGF9Q1gaavbhSH0U+X/bTtos8lXTO6MWOs+dhrON/BRHuK+ZqwkPK?=
 =?iso-8859-1?Q?3hhgBI1yWZHpNlSJ0C4arf0B5WXw9gZWa5PdaeQVMhf7ZeghSKpvg2AwyM?=
 =?iso-8859-1?Q?LkdJdHWZSmnXGDp8wbhT5LvKAUm1C+cm0BqNToIw1R+ML6ScwPNEvNHG5k?=
 =?iso-8859-1?Q?WyePQPOy0/AjF8EXC0QaaAuKqmXtn8QHNjgPj1xLTBnO7V16942GiGEMDH?=
 =?iso-8859-1?Q?u0ba/dlH2gYqa49CVOhySdIlJz4btzSj43Ky/jciZ91hOFXxhFQJEMl/sR?=
 =?iso-8859-1?Q?vw/2rG7EcHXHwPbvx5ROwQnwUo6vgRbpTXAYrGCRzC1TxNzzCZ7tCm/awf?=
 =?iso-8859-1?Q?xf9r135VVx72AwPhiDErXcnd76JQtJ6SzKh0amfkw42wTFM3Me8xg21LEl?=
 =?iso-8859-1?Q?7NQ+94PJ7oOO8NkGmpz9aqDCX/uUbyXpTWT5iNqZEhfjXvAIzYEwXAsOSx?=
 =?iso-8859-1?Q?1gyvw7R1iYqgms0fm3Xk454YTM1xaR9L0ZKfBbkhbJWlDzBzgFJhG85ATv?=
 =?iso-8859-1?Q?sarUxl/zF4IIH4O+sIn9h/WJB1aa+YhTWmlQZ9oSDcz7IKY45cIq683uk9?=
 =?iso-8859-1?Q?grzQgcNoApgVFdYMGHmrsK5K3J+409zp2yFLEgfZe0B9wy8gUbMlJq36eW?=
 =?iso-8859-1?Q?3WQ2yZFV4umsK1YQjIDdKVv8FTcTDqdOB6rTmIUln6Dmh2wBxkdZj703Xb?=
 =?iso-8859-1?Q?LqwkMqBNS74n2Wqy98OWTfZmczb8dwqmtDsSk49A3mdaO63GdFXsjDMDXL?=
 =?iso-8859-1?Q?dM3XT2gDpQsm1Pt3rlBpce6CA35seqGzHwfeQLwsN7yYcooP6LeaP1eTE1?=
 =?iso-8859-1?Q?7ov7ikRIxabxQAwgHSFp+qGABQqFlJUfQaD9ub+WlecJIQEukZfiKTHZn3?=
 =?iso-8859-1?Q?Vm3lmy5Eg+s4IHFC+FPFHjmmTogMbAQE8dxzN8D2k9FhLOrdunfwW1pWlP?=
 =?iso-8859-1?Q?mEE3+7iHCPeaQhS/kRSEsHrxTrJSknDQVwNk+v6fHDVvm9pM7prUAZGWm1?=
 =?iso-8859-1?Q?xSxUu2Xwohs7ap50hc4feNZPy1RRTIqhFkIlz8ZUXw3qDOHgzIGkuCI7Wj?=
 =?iso-8859-1?Q?R8zF6TsI7ymrvtXxqIXxFeE997FhwWRFzp4dtswxmR4crY5GhvkNZWwmEk?=
 =?iso-8859-1?Q?rzD0EfaqU4JXC6md/1lTxI8YPpnAAMUrM1tEpo8SrQzH/Q7uvnR0z+zAX7?=
 =?iso-8859-1?Q?I/TqTes9TugZpOaQG+sSVq2zqI8QQfxbrplr7+cMjY8AETz1a0Z4+KE3vf?=
 =?iso-8859-1?Q?X6wlxK2jcQbokAGuPan4WTdEqqTynaTFH6tdeSPDCHE1f+iRRkpS5xbJ68?=
 =?iso-8859-1?Q?I2HxArUVMevzjl5YMObDiIcXajTz78G47niuvNk9jqLdaEa7hhy3yr4cqB?=
 =?iso-8859-1?Q?jp9S4DqnLZW77OJeQLoQbVYllR7KColeXn8EXmzdJ7exV+3cJMeQ95qr+d?=
 =?iso-8859-1?Q?7FoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4768d41-77e8-4903-5e8a-08ddc2de44c8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:56:45.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaStqH6imjFAyVWp3yhcmTY7Nd52cMBJ+UTfct+6Jr2GSXl7/Vp96MYBfq4yBfaQa0UiGVkrGyCxlVH+dVSWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7692

On Mon, Jul 14, 2025 at 04:22:51PM +0300, Wei Fang wrote:
> > On Mon, Jul 14, 2025 at 01:43:49PM +0300, Wei Fang wrote:
> > > > On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> > > > > I do not understand, the property is to indicate which pin the board is
> > > > > used to out PPS signal, as I said earlier, these pins are multiplexed with
> > > > > other devices, so different board design may use different pins to out
> > > > > this PPS signal.
> > > >
> > > > Did you look at the 'pins' API in ptp, as used by other drivers, to set
> > > > a function per pin?
> > >
> > > ptp_set_pinfunc()?
> > 
> > You're in the right area, but ptp_set_pinfunc() is an internal function.
> > I was specifically referring to struct ptp_clock_info :: pin_config, the
> > verify() function, etc.
> 
> I don't think these can meet customer's requirement, the PPS pin depends
> on the board design. If I understand correctly, these can only indicate
> whether the specified pin index is in range, or whether the pin is already
> occupied by another PTP function.
> 
> However, these pins are multiplexed with other devices, such as FLEXIO,
> CAN, etc. If the board is designed to assign this pin to other devices, then
> this pin cannot output the PPS signal. For for this use case, we need to
> specify a PPS pin which can output PPS signal.

Ok, apologies if I misunderstood the purpose of this device tree property
as affecting the function of the NETC 1588 timer IP pins. You gave me
this impression because I followed the code and I saw that "nxp,pps-channel"
is used to select in the PTP driver which FIPER block gets configured to
emit PPS. And I commented that maybe you don't need "nxp,pps-channel" at all,
because:
- PTP_CLK_REQ_PPS doesn't do what you think it does
- PTP_CLK_REQ_PEROUT does use the pin API to describe that one of the
  1588 timer block's pins can be used for the periodic output function

You seem to imply that the "nxp,pps-channel" property affects the
function of the SoC pads, which may be connected to the NETC 1588 timer
block or to some other IP. Nothing in the code I saw suggested this
would be the case, and I still don't see how this is the case - but
anyway, my bad.

In this case, echoing Krzysztof's comments: How come it isn't the system
pinmux driver the one concerned with connecting the SoC pads to the NETC
1588 timer or to FlexIO, CAN etc? The pinmux driver controls the pads,
the NETC timer controls its block's pins, regardless of how they are
routed further.

(reductio ad absurdum) Among the other devices which are muxed to these
SoC pads, why is the NETC 1588 timer responsible of controlling the
muxing, and not FlexIO or CAN? Something is illogical.

> > > > > The PPS interface (echo x > /sys/class/ptp/ptp0/pps_enable) provided
> > > > > by the current PTP framework only supports enabling or disabling the
> > > > > PPS signal. This is obviously limited for PTP devices with multiple
> > channels.
> > > >
> > > > For what we call "PPS" I think you should be looking at the periodic
> > > > output (perout) function. "PPS" is to emit events towards the local
> > > > system.
> > >
> > > The driver supports both PPS and PEROUT.
> > 
> > Ok, I noticed patch 3 but missed patch 4. Anyway, the role of
> > PTP_CLK_REQ_PPS is to emit events which can be monitored on the
> > /dev/ppsN char device. It shouldn't have anything to do with external
> > pins.
> 
> Is there a doc to stating that PTP_CLK_REQ_PPS is not used for external
> pins? As far as I know, some customers/users use PTP_CLK_REQ_PPS to
> output PPS signal to sync with other timer devices, for example, a similar
> property "fsl,pps-channel" was added to fec.yaml by others before.

I'm not sure that what you're asking for is realistic, i.e. an explicit
mention in the documentation that PTP_CLK_REQ_PPS does not affect the
state of external pins. There's an infinity of things that PTP_CLK_REQ_PPS
doesn't affect, it doesn't mean they will all be explicitly documented.

That being said, here's what Documentation/ABI/testing/sysfs-ptp says,
hence my interpretation that they're unrelated:

 97 What:»  »       /sys/class/ptp/ptp<N>/pps_available
 98 Date:»  »       September 2010
 99 Contact:»       Richard Cochran <richardcochran@gmail.com>
100 Description:
101 »       »       This file indicates whether the PTP hardware clock
102 »       »       supports a Pulse Per Second to the host CPU. Reading
103 »       »       "1" means that the PPS is supported, while "0" means
104 »       »       not supported.

135 What:»  »       /sys/class/ptp/ptp<N>/pps_enable
136 Date:»  »       September 2010
137 Contact:»       Richard Cochran <richardcochran@gmail.com>
138 Description:
139 »       »       This write-only file enables or disables delivery of
140 »       »       PPS events to the Linux PPS subsystem. To enable PPS
141 »       »       events, write a "1" into the file. To disable events,
142 »       »       write a "0" into the file.

Search for which user space programs interact with /dev/ppsN and you'll
see chrony, ntpd, even phc2sys. None of those consciously affects the
state of external pins when they use the Linux PPS API
(https://docs.kernel.org/driver-api/pps.html).

Maybe the PTP maintainer can give you an explicit ACK that PPS is not
supposed to affect pin states, if that helps.

As usual, bad practice in old drivers does not justify bad practice in
new drivers.

