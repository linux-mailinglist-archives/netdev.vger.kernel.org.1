Return-Path: <netdev+bounces-248718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424CD0DA3C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D93203004849
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06AF28C862;
	Sat, 10 Jan 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yoq6c1aB"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658042050;
	Sat, 10 Jan 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768068356; cv=fail; b=mjj9IPCnt3epzPME+v8ek7kkBbw4UAPdylicjarjb8vB4CvLjChVrVZKu9U28djCSbNd6P30bu+xVt2RtpICaZQw0RhxXtuzXSVkb6K2zihD782corjtxokdEG0SqQtK7Rf1EeII2rBh2UReCLguyRxv2+jn/P6LR1zv+cpuHuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768068356; c=relaxed/simple;
	bh=4DWElHv+yW0bZgHqgGjeLLBy/IBvepPWLrLmMODgKjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyNzivO8yxFzv8sO4fFZB4TXH3JXtQoqT+0lOQFK1D/xDHky0r9x7FzJMIQAfC6mOlXkGlQd2InVS4nkf28UylrDALM0XY4I2gEZVOGKE58z9FZqm0LBqOVhCTOh3YtnsjYKOaYNEaAEFJ9jzMG4EyUTfVy93tIhGT6S9JtGmac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yoq6c1aB reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1yV+rcdzgEa4YGwJnsHGCOrlGNO6KtnOW9hF+9tl/wuYT5JTjGYiGwPvIp2W5JrOteWRtCn+cOALG73UmVEtYveS9AGVUnU/BxrDLdNqoE+p5mjbNhdnVxTq+BjnFb2m6PCCXZjTiUdNr9YaJKLhov8+DeWhklSZ78OMpbBGTzX+mMYGJ3z3XY5ezUw1gjV1Rhd+H8ZPfHz5V5eEAAWNrkKpA8G8BH+YqHWHaQqKGRjttgZgaUaFbcllWCfUam9l57MS+cwBYCnL/scY10kN962rqj69A2C2ZxwFT69ubFKXRhjPZ4WO5cJwwVN55v/ElecBBIZkrBvsGLT4pqybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isWjE2MMgE8o6xT9r6NOaa+RzJZlMswAeuuEWlHP0OA=;
 b=MU6bZCqkboelYOdGv/nyYxV8o9zWJTXcqzy7XzZkFCMXaJtigschS+J9USVWjmYbbNoEtZqKP5JDimFXe+FZcuqz+TsXYjWkx+SA1y1cmzDU3xXrBYsKA89dMuBI6CQHNsJZxCnJEPQTA4GWYH4uCQPHIoWTSbiby1ODmmZvTW06WuNuge3KOELGkZRtS+lTAFkvo/XgjXA0shhTpBRcCzMeRDypKfRVso8bJPNH5Gc5MAGikNhNLL7+Bmgf9SOn+xHM16WJJPFH6MTYPAdrI55AkYcThiP82stfMWQTa9jA3+53i252JZ8pDIdM0heA5Y+9OIWxMa2iUIzQDW+bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isWjE2MMgE8o6xT9r6NOaa+RzJZlMswAeuuEWlHP0OA=;
 b=Yoq6c1aBsDEtVyf+/0UAYVdMrbOPDIY0GL4r8065id/OZztY1OxDCV8B8SxhVu7Z9jiowSgJvLcCz1sYWx2n9KMPdbLt4NSwsV0N76pERi/gYv+jG7kw0/BjceWcED2Ixf/pse1uhf5R2MaNg3RYozPeuC9tmLDvrj340QaVYlpteUsnzRFQ987bucQSutvFe6Wdchqm1hMpfKxQAT7VgmS858TbynFjgCYQV+kHR5cAr7iTWIEmQZbDYXAajmYvclxDUxyUpYNPgnJTh5JXDnC2Dqk3iEhejOUxWvPmETCRdQ3ykmW2qWYkjlJ/yyNqBTqTIuWY7/kt0uNcRIdZFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB11051.eurprd04.prod.outlook.com (2603:10a6:800:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 18:04:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 18:04:38 +0000
Date: Sat, 10 Jan 2026 20:04:33 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260110180433.bfg2hxbdjkfllkiq@skbuf>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-6-vladimir.oltean@nxp.com>
 <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-6-vladimir.oltean@nxp.com>
 <87jyxtaljn.fsf@miraculix.mork.no>
 <87jyxtaljn.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyxtaljn.fsf@miraculix.mork.no>
 <87jyxtaljn.fsf@miraculix.mork.no>
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7f90ce-7c8b-4f1e-d7c4-08de5072b817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?SerYDNWolUvD7E2cl4QNCAreujnQprk5QTIrsrD0ollvffg0eUn2O7dZEx?=
 =?iso-8859-1?Q?edxrqv2+i1zQJyTBGwn4QtOKXLrQTwm2jP3ihyv62QUl+0/BJqQlfbO/Pb?=
 =?iso-8859-1?Q?QMPQl34qC7cbLVhaDYB58f/+mT/o0m7MJiUl8cZ8rfirD2y9iIqlSVlX59?=
 =?iso-8859-1?Q?PwffHy68gc6PXesDGn3ozDgJUd4J3xhDvzKk2h2y5RQ2KpWsecomQvEXU8?=
 =?iso-8859-1?Q?18gmPi59F734AqOoKBDYpRxD0C44z3/sZPBDbOh0KkfBff+Pru6XrUqeqf?=
 =?iso-8859-1?Q?XnLsMswC+RV9ShC4nFVhcO8FZ2P8e5Hc4t5/NYAKyIlwRL3uNzYNJGD9Lf?=
 =?iso-8859-1?Q?EegYYZyfCNLaTmDcfQsrnSeWrAvack2ssPcW3+9OWYnxz4yvSSxznNC6iB?=
 =?iso-8859-1?Q?5cG/Ech8meaHWVjUB18KGJyCJNCmRHqPOXaIPgxLiMtlle9+55m8AM+zgX?=
 =?iso-8859-1?Q?4oSXXKVhWb3mYrGd0HRwXvFLW9cDRcscDn/v0xD3Ce4oFiFdbVHf0TncXP?=
 =?iso-8859-1?Q?V/U/BjEON5L22UoswqdUJXwniQrGNvPHNPVLxoS0FLE6jzz5fSeN689gPa?=
 =?iso-8859-1?Q?JpRFZ8QqsBi2Xsh2vyGrb4EaWrYdh+nposB3Kd+kMPfvlcDKn1TjnUdDgr?=
 =?iso-8859-1?Q?9yJNVbcLzHOtzxhSsLyEBdgDE8Twg/M25u8wj1N4IrXWO1IGeimP8ouktr?=
 =?iso-8859-1?Q?PJuneIH6qHxx+iENrlZFxbQ4LZKrnqALnsZu60njYauCyavPgoKS7wCA6j?=
 =?iso-8859-1?Q?6SM5JI/G8Wn5HiXHpCc2R8gY5wGwb5b9fG3HKetkldA2MfDiaqz99iAnzY?=
 =?iso-8859-1?Q?frtL7aQsd5f56R9RBU97dFLDca1YRLWDs9nnyvNh8xYnQQ4zouiyjeG8De?=
 =?iso-8859-1?Q?hJQpy66riwILQcckk5LmUsm5OZQP4Ba+QBXFP60kGQGYqHg5x1yk7dpcsE?=
 =?iso-8859-1?Q?XqDN5d7uF6cDkOCJqoSMxVHvKxYB4lYRnrSSpmBWbh1BZ2TI2nlIkQ6rj6?=
 =?iso-8859-1?Q?Ks9P9VYoCnE6cxuuga5qVXpH7zfkFwQdhhROwmdVMQYc9WXC2bk9zAcR6p?=
 =?iso-8859-1?Q?wfGhn4OBxezR5ZJOWJY3hbuSsiN+dOOuXtsKmN7yzYqciSh8EAOoKejV2V?=
 =?iso-8859-1?Q?EtBxl4kb7q9TQtr8RLVTsblN5J3AlWvN5Mb2ZaDrSy/O6CEj+GnGAgNU8z?=
 =?iso-8859-1?Q?jI/ZFVa4g7U07XrmwG8FYIVh3PGghjnjml2H06d2nkTrBDblYNsFuHdKGZ?=
 =?iso-8859-1?Q?W/BWMvysCF0L99ksSLqLEs9T9+MhLqA0mAOZT8H40qGWRVPH0lne1rCaLf?=
 =?iso-8859-1?Q?s3iTyT3YtZ4L6Q4YwpHpdf6FuMY4yd1piAXUh4A1dEEqVXJsc+RI1rWxt3?=
 =?iso-8859-1?Q?3j+hiNz9641FuCOLL0fDajLz0B48zRgCtBYOlZ6VuvwGcSW0BAoIoDdZgh?=
 =?iso-8859-1?Q?52O4m/f+0VPxqri/VTVrBtwuhihYXgFv77/Y9xxA1gslad7b/xpkoG8bX9?=
 =?iso-8859-1?Q?GXrlLAg0LlmXDVW6qsZfVD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nC6Oc+WAAD1T1epEOzBBI74XDwUzySaL1A030WNH4Jv+Kd+QKVa7ElBkxg?=
 =?iso-8859-1?Q?hRETrI0uaRGO8qDbSsX38h/H54o+UDrxRC7TmbJ4yuzMkLcj7qEYO57ac2?=
 =?iso-8859-1?Q?dGMkT90zzkW+UkufIiEKKz20F7SHfUHzTjKFcay3Ht4zmLQPsUiP2Wo1kb?=
 =?iso-8859-1?Q?a1uj4DaxBhen0IkCO2jnUciYNhvuXf7JEgvwFuyHLUBxZzsP9YWVzCF5Q5?=
 =?iso-8859-1?Q?ZMNFBd/aHobmtg2y+mcvZ+UGsr5A5gWVZ4SvjmFIP0xLulaOqWLnEolmrz?=
 =?iso-8859-1?Q?en0C3DUoePxM4iAKXkKSqysl452GDyeLPhw3E8acOvzfJX9JmZJ4mfrkj8?=
 =?iso-8859-1?Q?Ira0kVi6IiU9v9vIZMgr8go2nyaZRnNjZJAmVZEzVAEUMHlZr7Eb9bHMZW?=
 =?iso-8859-1?Q?fUPzo1/2ztixo94saJab8SHx8HUeNOCvaNb+FzYT+0srKl0AM9CD71n8c5?=
 =?iso-8859-1?Q?jvXOdFpxswcV6R4ZwHJPzSZgdZw8chyk3DfgTSwdB79tnGYZJYnoeG2ciK?=
 =?iso-8859-1?Q?Ubr5YbP0Rf2IqvHiN1py97E7zdlONBwTJ9O4MMlnaDqa4zLAJGU1/8QtTZ?=
 =?iso-8859-1?Q?VTK5M5LFNyKWzfAywl7C1PHkb2V5/wjQhPZtSVbIoC8svGfQT5C83He6wu?=
 =?iso-8859-1?Q?BtIiWNnWlu7um8KQiA2A2Scu0BoLfxkmmqCw9fIIgq+ewT5u9c1V8ZIYrs?=
 =?iso-8859-1?Q?eAKGNcVQiIY6sR4rOPOdIRjQaUGInrDkuEMS0uJj2t6efdAHRqF8bIj1+e?=
 =?iso-8859-1?Q?olFor340aO6aN4EofR+roxMIEs12Fy5qg/mHfB17tRwx6jgUg/c9LJxSEU?=
 =?iso-8859-1?Q?UZpfjixrCUsAQN0lGd8S4TteVbW2s3q9wKMFFtAr7CYLizsKkO1R2f5Bbd?=
 =?iso-8859-1?Q?8h37fyRtPogFxa830Tmm0nxKmNPg03YBF1YGQMxciTNJqPeeId9IY+I+fH?=
 =?iso-8859-1?Q?MVdFhugXk7++Z6aq4lpfUm2dT6yKG/cXuK36S9NECvGZOqcmys7mFLeU/v?=
 =?iso-8859-1?Q?tASO/HeFXcNPWDbbMRLAvHlwW3y3emI7hoWxvdGkq+9PBSjFwflOtNlxw0?=
 =?iso-8859-1?Q?e9y2w/VYdYMPprM5vHZQAHk0vz0Arb5G/hu7a5UAD3MTmB8oDLeBfbhXwM?=
 =?iso-8859-1?Q?WMy9aeqJzkSA+0XyPMyh6U6yvDfZSc4Guy0aCzPK83BaXXz2rDwX3eBCsZ?=
 =?iso-8859-1?Q?W/Hk3BMVegOSBjpDjacE0Ixsd765+UnTP5n58/pCqpnkmhbnQcv3UJiubL?=
 =?iso-8859-1?Q?mDZ1SSjdltgo8g+HgfexRQ9PuW8sde3jYrM+KiB+M2uD9tY7a9Mhmla2d+?=
 =?iso-8859-1?Q?7eHjmVJEv935lIRryMHZGe9Gvd04/ZyHH8ag5XtFvPC6wKtRV7bi6Axbi5?=
 =?iso-8859-1?Q?iR6yXOoRJz+19oSK9pEYlSkSoJo6/QkUaGWjTRgVUxbqsS7hpoHd8nIbu+?=
 =?iso-8859-1?Q?DcixgGfSGLTTxkyK0I1zigPGd/TfNE3zH6KSxIWqX6KjiPC4kj/78geWNF?=
 =?iso-8859-1?Q?n97O+Rr63MWIZiYlDvqpLmmbWokH/pSPjWUVhWPgwiIl/Zo/EZonqxPDaJ?=
 =?iso-8859-1?Q?HlEuoup8agWJ7FQhMmf/Q9TdIQ5h0vMkQqR6m/juvbCZ7x7xvcRiG2pEm7?=
 =?iso-8859-1?Q?v/sWdnyzTrPo9y974AaM4Q5N0q0P1Y6G5hz5+wvSl/6ySl2o9PIQ2Mokwb?=
 =?iso-8859-1?Q?uVzD2CwjzQixDk9nA7HtnPj/yW3/lnWSJb6iY8ws22tPwjQuI8g9Mag3Gz?=
 =?iso-8859-1?Q?sfgnOwj1hFKxGd01OhkS2JF5pmmbFqT7vdJc3FMQ8LPGZlp9kqALsns6b8?=
 =?iso-8859-1?Q?PeCimgBP8K6e4QiJNpIextgK7bCYOfwJcOZW4AQL5r7cLVrDusGZym6xH8?=
 =?iso-8859-1?Q?HS?=
X-MS-Exchange-AntiSpam-MessageData-1: +/KELZ4Z0lhiTA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7f90ce-7c8b-4f1e-d7c4-08de5072b817
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 18:04:38.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rum4weFlV02sx0CFOpDXK1yvOFlrz0IT8AIFTolJvTnXyTBH/aGmahWyj9lH1BTPIueKrUNIed8TEMiexVgReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11051

Hi Bjørn,

On Wed, Jan 07, 2026 at 09:12:28AM +0100, Bjørn Mork wrote:
> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> 
> > +static int fwnode_get_u32_prop_for_name(struct fwnode_handle *fwnode,
> > +					const char *name,
> > +					const char *props_title,
> > +					const char *names_title,
> > +					unsigned int default_val,
> > +					unsigned int *val)
> > +{
> > +	int err, n_props, n_names, idx = -1;
> > +	u32 *props;
> > +
> > +	if (!name) {
> > +		pr_err("Lookup key inside \"%s\" is mandatory\n", names_title);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!fwnode) {
> > +		*val = default_val;
> > +		return 0;
> > +	}
> > +
> > +	err = fwnode_property_count_u32(fwnode, props_title);
> > +	if (err < 0)
> > +		return err;
> > +	if (err == 0) {
> > +		*val = default_val;
> > +		return 0;
> > +	}
> > +	n_props = err;
> 
> I tried using this in the air_en8811h driver and started wondering if I
> have misunderstood something.
> 
> The problem I have is that fwnode_property_count_u32() returns -EINVAL
> if props_title is missing.  So if you have a node with the legacy
> "airoha,pnswap-rx" property instead of "rx-polarity", or more common: no
> polariy property at all, then we see -EINVAL returned from
> phy_get_rx_polarity().  Which is propagated back to config_init() and
> the phy fails to attach.  That can't be the intention?
> 
> The behaviour I expected is described by this test:
> 
> 
> /* Test: tx-polarity property is missing */
> static void phy_test_tx_polarity_is_missing(struct kunit *test)
> {
> 	static const struct property_entry entries[] = {
> 		{}
> 	};
> 	struct fwnode_handle *node;
> 	unsigned int val;
> 	int ret;
> 
> 	node = fwnode_create_software_node(entries, NULL);
> 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
> 
> 	ret = phy_get_manual_tx_polarity(node, "sgmi", &val);
> 	KUNIT_EXPECT_EQ(test, ret, 0);
> 	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
> 
> 	fwnode_remove_software_node(node);
> }

Thanks for debugging and for the test! This is a regression from v1,
where I just checked the fwnode_property_count_u32() return code for
being <= 0.

I've integrated your test and added one more for RX. Do you have any
further comments, or shall I send an updated v3?

