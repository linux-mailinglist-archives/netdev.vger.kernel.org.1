Return-Path: <netdev+bounces-225344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC3B92748
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1213AFE49
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1C315794;
	Mon, 22 Sep 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IW7K9sTi"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A483164A1;
	Mon, 22 Sep 2025 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562539; cv=fail; b=SeeEvROzbQu29s3a2hVwA6NTuGUzCF8t14owX331hWCWHP7v5/Rhg2zJTkz+KEYlUsUysFCH3x6XdTBCo4Yj71HNCeGq5/g6qh9rabKPJeGo72QVVjNze0JgzsQ6vzJCXlTXqYsNpepkeFpkRRZ6u3fDV4LUQhISTqF73+6fUJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562539; c=relaxed/simple;
	bh=t9rZttgSeBCP4TV3uJrq4Ies8KwRewOCxTR/aZ4idAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aflcr7UTyd+Q0unlel1FxFpx69gH+XopY+ZLl5rcOq3fCFIXxMaHL5c3cupoMlM0GNJHN7z7R59rjUXNnJRlafu9PTIa/EedSgWo6d+/hxt2IDC7oMdAqjbqqT0suZfh5o+4/ow69pxF9hIg7BBVbgBOfyXp7nxKDrJlZ5YEDV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IW7K9sTi; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfHb6k4AcoE2HN1X2uOM53mSWswKZbnZQX2URazQzbgHHsSYr0IVp6YBFkHu64kMwQ69NiOC4+eQUiyYxWrPwYwbrx/GdcAwqSCdFcJsr8L4VesjYzEivgPlWplDXcHoRMgysVhx/YOK4SeOSqpdzxCBYGObCM+25S4AV9MpW5KRaaLr+k/Fe37iCLlAdbPlf7UptatNTqX86bpaJIAWBDM+L2692RwxAjW2tJBlQPsYtnE9zfweXBvA1uHx4mASivwhz+6zs/4dSzZtrd1sfvdx3HfxxwC/fv542qqFuAMWAHyEDDeECNmNpkOavXr4J5SyfnXMWfVya/SSK3K0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0aNnWB+xFKr6LujjAR0acC+k2IMp56FlAlJSpBKwhs=;
 b=OKdrtg6E7/pHyup5WGxMdmaepcjmWDw3fj92p7VxpNrEfXMp/6wPQNQm6b6uYxb+Gh5wYV+i7v++uZGbTg/csqm+ADI/2ulHcuz0iVXVr94Mm7/Z8bCtluXgFvszQ9EDz/5reBnObR63itiL/D2ej+vsftbWvHIjp/LUxjgk+HVzlWaA78NdQ4/nWSOiQG0QnZCUKaN5kTMF42g/sePa8uzbLJT4GrHYarxGQ/6gGnhmPnLlANjSij1TxqYPYk487YharJtq5m0q4PP7PgOfyz+YLioqGiXVCv3TonzpEvjnEC54zOBJ5oNZfJ9WcUOGrClGMgbtbeDsRr2KpCichA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0aNnWB+xFKr6LujjAR0acC+k2IMp56FlAlJSpBKwhs=;
 b=IW7K9sTi0373hIR0ZoSrBecYScnw8qM1QEdV7bAKUIHqsUQhHTnKhbPSc6aBpiuX42aptxs124nuIp7TRHqp3GolTxcSfGtA9nb+6eZsAGek5h02bE4OYi/r9RBveDVi1h8PHpu8F0Thmk3ZOrUjWgdHVRIX7bVELV20Sp3/Oxwer3BDwtJEgBu0EtABBv9hV+OI7dRICSGJI6hhznHUnHIus2FUCh6cOVSnQxUU4PBHe7mFiFeloXMnpp6XJVx3gi2D0eb1YDQY8tcAuOlcLfKAeakrhCrmMY1NyQuKpO0e1aBd7RCxGomS7Hlvw/790IAY0AVw8go/hZ60YBL2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10504.eurprd04.prod.outlook.com (2603:10a6:102:444::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 17:35:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 17:35:33 +0000
Date: Mon, 22 Sep 2025 20:35:29 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: Add
 reset-gpios property
Message-ID: <20250922173529.2372hfwwyhihqccd@skbuf>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
X-ClientProxiedBy: VI1PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:803:50::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10504:EE_
X-MS-Office365-Filtering-Correlation-Id: c6378916-2da9-44be-abad-08ddf9fe6eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZtNUGVF1dXB7DRqeNwMGhi+tCP05RZJ5uL0/Et+KnepA3mp5pn113xt6DWt?=
 =?us-ascii?Q?ksMOfyem1zRKr8EwAGcpBa4STqxEz+uyIRdWb7/pvQOQsZplkkgb9NdLSCiH?=
 =?us-ascii?Q?mzL1pG5bq/yTp5Ox9TNUjgjkcRkLY/p2VhPDBWY5kOzRpDjJaU2nYdwS8M1m?=
 =?us-ascii?Q?SX0Xo4UUDCR3+oI7X8U7pC6TefuGe2OFZQpuzjxS6y1VPk/I2ZY0RHMm3CYl?=
 =?us-ascii?Q?t2BpxGPT8CXlM0vOk4kVixTgJOToc5bKHxUKjot2mW0pwUa/hClo4DxTcxlO?=
 =?us-ascii?Q?DCgRt2711aP9uOzjAuBkD80Dm2F+bZ/Lxqo3WSV5soKA7WmP9ilwHpr3uZ6f?=
 =?us-ascii?Q?3iLEIX8FfUTNxJ47w0ZcAEqbpnv6ugSDK3QLIDM98owbzSFEqQrxug1QORw8?=
 =?us-ascii?Q?/Ig6XySRMTKnKiCIHUnSZ93WjQAc/OVN+8UFVdKhBcvaK9HvNMFQX5LbLp6m?=
 =?us-ascii?Q?+EA2hbzvViAqNbVIjeoiptKkAOy/BI1H4sNVPXzhPYFDbNO/qP5YX5SrYiFG?=
 =?us-ascii?Q?pYoFQFaA32yIDCinGMP85/NfYN9qUzMdCCEWce8peTsbFERuPEhDYsJXjumJ?=
 =?us-ascii?Q?j0P5CyPnNEuWDJrJjdHoBPByfCFqh04w1NZZieuiP3KTxz3YL8090gBy0+xf?=
 =?us-ascii?Q?5dnGKESrYOpa2n2QOOHSYmHio+GkOI90n+ByfIdFM5bFns6+B13UUFqz98o9?=
 =?us-ascii?Q?WjYxKMqLKuh0Xc60GH8rtivzFThTu140iBdJ/FEq248c+4OZBqW/PiYf5lIA?=
 =?us-ascii?Q?rglqKdZCK6X17oogkWXIOhyOttQme9N121JS0N4ras3rQUj5FAL4BQ0t7wxH?=
 =?us-ascii?Q?Ne1G5+b6uHLLhON1Dbx8kAZKaFuKAnvWt0ntbvZYJM2rg9F+pnwTJwkBMrA9?=
 =?us-ascii?Q?qDxUVGyShXRBPwCkp0zzYG3/43otQjJzzT13Em808W4m07K+vyqep2tbDoef?=
 =?us-ascii?Q?X0Zg8GyCJtUPD6Qy6sYMNK/eIBx4ZND7DDklf5tdr7r+QJEUl4QOB2vBbGoG?=
 =?us-ascii?Q?YV+xlzcx3X+NMR0Vz5t6uoSuuhqPtwnCs5ws04N9l/ywq4u3c48vYzQ+ml5+?=
 =?us-ascii?Q?HiIKBZZTuRZOPagMqj/JwJEtA+Ne0zDkdE6VKMgE6rbwuGu2pfFjVMf2sml3?=
 =?us-ascii?Q?/xDaB+cgd7wWe6UGEh6o99VEXbYglt52d9O4yo2yD0R9JBntg0h3yFpQlcPP?=
 =?us-ascii?Q?HN3CFgHYeGorPOqjNuJ7SAbxsehUL1cZU9bYQy80RgvSNFalsGGqokqlCqIx?=
 =?us-ascii?Q?awsDLXMFBiXszPikJY1srgr/5hcBVyKTk0EdDqFdbpz5Hp3Zvx7ll4p+UI2d?=
 =?us-ascii?Q?jsIBl8Fy7dtiaS5u6vRRJfVV6ETSHw7MRFxYA0mZDg1T/iu9Hi0jf4MCBwmq?=
 =?us-ascii?Q?Af/mBTOsMootRR9irT1JRZvGrMVYX7JeE+vjPnuqNTHT0lLjBRxrm0484mRZ?=
 =?us-ascii?Q?eDlS6Y4piFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJhaF6B3tGu8rw/EZ6BJv40iSwamSSXU4j6y1SfhyfFlL1FYYEaQSQ2Slj7f?=
 =?us-ascii?Q?Lkk0rF4U2F1y5GZAxjYI+6hjnGZbu2NumzXKOI/QVIA8SsbSZZSOfy5OB039?=
 =?us-ascii?Q?3ojfk1WR+Gu8DHynclkmwkkRHlMmJIFbCDLv/d4XSYL8F/l4xaXq9XhEhKw6?=
 =?us-ascii?Q?UJZn2aooLgzARvndym8bpU9It4Y10Lzo5CVvTNBvv3jBGj4/9M9jHx2bZHTp?=
 =?us-ascii?Q?HriSokIE2pSfkYUA1/kSTX0XUavrY/PeEXtjOtDT+UZ4rL8jyQiX7fVEkh83?=
 =?us-ascii?Q?F8ckbVu2iw14d14lJT982pL0t6hdvT79PQXV5SPW92BplUluc6QCPzGU1d7x?=
 =?us-ascii?Q?L3yJSqj9ypkPmvdSu+5oxf+HzlLTCBXoooQPcR2iEl5yyoCr58GpbZTUl012?=
 =?us-ascii?Q?97aL/Lfz9Yq/izgOKdISk2zWAm1+F5PhF+GA8Pwegm6ZLvjWNB/Wc3O/pM4j?=
 =?us-ascii?Q?Mhmn1rSxKG9rttXGUEi+dQgXClTw9qtvkT5Dkr0c+6b654PVPJWqgoPfcAq8?=
 =?us-ascii?Q?K0kKyVqkY3zuAPDGm3tcCSyY1Fu9oGhxWjMAFOlQ58OXyS9JV7at0/mQqpzY?=
 =?us-ascii?Q?wJYpLny6ugdwyJ5K9Qk7fCSVYWuheQdFp2SQJxxMfiKr72OTixAnp0T0sS1G?=
 =?us-ascii?Q?hTIe9lk2ki+7reUGpthc7ahtp03JPHuYnWZN8KkhfeDuJfUshZarOcm5ycXr?=
 =?us-ascii?Q?aUPfV3aowD9CTI4/cNB4mtZOslv17owg1dy8noNkgsB1evJUOYLiyfMd/19r?=
 =?us-ascii?Q?7Tjd3QXX5J9naUJnp4Xz4I7d6bK1o5yi9AEUNjAl0YDKiYnVcQeRJFEKi5mv?=
 =?us-ascii?Q?EDQx045scSRIfWqEIiJmdsnhh4cIKUSq9Fma7RC+SOWIzkrJsV7RHVBtHGhV?=
 =?us-ascii?Q?RImW8lJcREW3g++NeTU9HELrjP0XitbT3+2el3Mie91AH521w2OQs614ISqP?=
 =?us-ascii?Q?5m/4Oj9Tp/gjSUo3Wfpu+Y3Keq1dNc6BzsdQVUEgU4zJgDYvy+gMDnmZmZkA?=
 =?us-ascii?Q?XqSoVgw1IdzObFByfFUcjXKJJDFWhjvhvXLlHgK+krqjhWee8Mkz/VfO/Asi?=
 =?us-ascii?Q?ozGOMgFKTfX9pkfrcC0RezXTQl4nVon9v5pzDPnBJfpsLnlHAI7Avn/QtNLL?=
 =?us-ascii?Q?CjQlhMD9G+3rCDj3iSs3CfWJsCCNidlmoyUmyNjbne/Unuz+fGOQzAcc4nw+?=
 =?us-ascii?Q?GJD4euXVupnycGQOaURB2xhauPqkdZto06gKYyFsJ5VaGHqi4fu+thI+UKK/?=
 =?us-ascii?Q?xV4a+frRJyTcNPkceUN6BdRcgt5L68SyAvT8MQrmFEfdUjr6q0LQeT0+ypPA?=
 =?us-ascii?Q?8ZJ0qhBSWZScxbRefkP7u6HrAd7WcVnz4VvZ02YcL6J/TaguMmbVI0Gzg8jj?=
 =?us-ascii?Q?ONQAf7UygUsMjFKr1jYuvhRRUFvVNnF17+ehx6ollgEhDsI1kGBoWOrjAp2Z?=
 =?us-ascii?Q?hx/tIpeaP0DaY05am83FmdM/7+yYD21sXCpI3x/vdssX4uW7KnmJbyxhKVnJ?=
 =?us-ascii?Q?ckHBFy0MVWcaeRzsgIoZQ072ZJUt8wj39nkkVpSfHd8Ce71+fzWEwKYA2l/N?=
 =?us-ascii?Q?7rirNbwYa+qZ+xPMw+5Z49uju1L+FeJKIiF8ivr3Tej40zo8Id4hHPWySU6w?=
 =?us-ascii?Q?lrrtPn4s9aFIasb2xACIg3ogmpC6ZhHIaxEwMyJCHCSQYJsDLzOqYLsoRL8o?=
 =?us-ascii?Q?ZwFKKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6378916-2da9-44be-abad-08ddf9fe6eab
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:35:33.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A/9gyWmNBoJan2sL3c5UH8oS2DtIxMeEhYDjOy3ZTmlHh0dybgUlIIiFWLKagaFe+tRw1UaqbLQo/8SNhHjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10504

On Thu, Sep 18, 2025 at 02:19:44PM +0200, Jonas Rebmann wrote:
> Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
> reset pin, rendering reset-gpios a valid property for all of the
> nxp,sja1105 family.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---

Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

