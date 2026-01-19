Return-Path: <netdev+bounces-251020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E3D3A29E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3998430B65CC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC623352F9B;
	Mon, 19 Jan 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZmsNBuIp"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AD352F89;
	Mon, 19 Jan 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813970; cv=fail; b=krdyduohp3xPzodX8vS18uwEifS19z0G+iVbVLde6XeDMz2j+qXzBqIBbebocv0SZaFegkdBt7/CtHCdFN0A0B0E0wFdHuCFyIG6z5aSXoXnyhTKbyyU4Wx2KyVCwzXKQqyOhgbYNzlrvBQGy4648Zqlcmat0O25XXXdAO5uwIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813970; c=relaxed/simple;
	bh=SVkhjmpzA8CILKJiJvj8iVKhsbS9DtxIOPQKddn6og4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BiQdG3rPJ1jb1YPjJET+GNE2gg2kQD+tk67XyMXLZB+KvXXAVyjciUqP6QA9K2y+YdU3U4LEqOBY/L/JwCdEcVU0WS+9aTf8/FWIOy3eGbGwBhtj/TYSCxyeELifydJ2UKdtRgBHwKOvnALKve8ktm9UQQUG993tG1SEIytKTSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZmsNBuIp; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1QxfVlXGCQ4n0srTU9Xe1B2kxuGQiR/eArNHXGsbKX8OAdZmEsPz4GwEzHnqmQv4OtY24ZPSNzA/1ZEoNdt9OGZEjIFjn+pru+ELtSLlWSR3O6jMlga2YtJQihzODQ8XHyisW0ijHHcWO9yebmjoBdCv7c3GU9RnJEak3lFPKBqHS0WKWgsHLsKag194dWzrUdUmPDPPE3YwiDlcw8BlEqSarSYcknl3wgIw9sDXAXXFj14prvh+avOQB0LNhCQKN11MFrFZP2KcAy30RuexBJgSOMoOfAzCc8Q4OEwctulDN98PqUbamN5exVtOg5TKZXvXCDgEOjwSRnTluMVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ekHD9640RMYgaX3b6xST/k4N8xRtMCdjVJSNpon7/Q=;
 b=IeLOE8+Olq4cUkFqiaRMG97QcAX8hGP+UUF4DESrkhz21azwh4Pji4NLAetIE5SbAfw8LtYo/Kou4ipttlIU+uOMxtKzbboFK3bblYihgKlWiVmrwk86PMaA+V3ped8B5MRuudqZE4/z1TgmXYIpHnCkEW9jUqQBr7dK0DYpQCPn6Jm6wsm87zKpCRVP7Re/x082YIt5SN3mCamg8K7vcRXGqpUl5+M4xf3RIKOwPhZ/54ZpE2uU8DEHc1q3GrTJa+ckQ6KdQ3BKp4Bv7ArN1US8J++fDrufwEgLaTPce25QuTsZquEUYdMgvDtk2V4QXU0T/AH1GC1Di6Cn6FLhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ekHD9640RMYgaX3b6xST/k4N8xRtMCdjVJSNpon7/Q=;
 b=ZmsNBuIpTKzHH+DCabaI9pBDx2EDOmXzmZhxp/y1ir1M9NO7gwwYp58T9jJ2HLKDuNiB1u2DC+TxjmGxxEfVHm0jVTkLF6aS1B3ZwZK28zafEFEai203T5fvJpXgrePvsNjov3tnX37cquhWtAXtxumlulVVmwNO5qbC4mwqnJuSS10OsWPsWME9fnzCP/2QH06fsGrSnqz7jvTHQNFZAKdY/JAMcrXM9+9XXDLVtF8D8cJO0xupG3B3nAGojmh0RdZkiVBqL1kiIWxf4MHwBtk7ql5XKJiMUxLpE4Ma5j7jCm/UDlpow4lRvYa/9fuNjsa5UXTDruQarRZdlzHNCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:12:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 3/5] dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
Date: Mon, 19 Jan 2026 11:12:18 +0200
Message-Id: <20260119091220.1493761-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d57c65-a7d3-4c62-7bde-08de573ae434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xT1bneXwqlv8PcTCETU8vLFABUhLRfnS60DWWP+ja+AWePUvsE4QaS49eEpR?=
 =?us-ascii?Q?HlKRpw/gNxnruykcti5y/8rhN6wnvKaOq1aDp9Ez0OH/mO5L4WU/K97+mdt/?=
 =?us-ascii?Q?m4vRY4SV9nlLtn5xESQeBEfgM4Ab0vneK45/f2E7grY38RtgG2Xu/rckTcZz?=
 =?us-ascii?Q?UMH03tNzfTcQxWEZ2E/SeCsmRG6nQp60NLrxDi35JPjbUGzbckedBfG5sP0E?=
 =?us-ascii?Q?KhNki8lQwpJSVka3ZQsWKxduzDwo8MgF3yUPnhbCFCTx02g+RpNFNpxwV3Ha?=
 =?us-ascii?Q?sSVc8w87MGdlf/FNgwiyLiaJA9cUVDJIWVbXEhMJbvXNf/WHUc1asTgGZr7/?=
 =?us-ascii?Q?OKFhhr/emZ2RouloMVmc/EqHL+bgyv6FrWu9ClMJsu5AZCFqkeLD0nqqEaNY?=
 =?us-ascii?Q?ZRDmQ4/6XgvkpTVKDTyCT5cCbXcuaMUgcUL3xsLcaxRtKd8T2v8eFhLL7Rz8?=
 =?us-ascii?Q?sEHPm6z3Q/u8AazvM85lYz7svLhQYZJB2tHK73qb9X9cf601hJfZzSDEAdCR?=
 =?us-ascii?Q?e6jrtjsJa8L9tUqLrfAr1fOngirFobQYzHKnpSRTVHVtZw3RiAz4OAXsAbYq?=
 =?us-ascii?Q?iHhsfd+ER8X68JPDz6AxdAL6XwhZ2U5eOLtWOn3tQojZL7zrDhNXGvC2uFcX?=
 =?us-ascii?Q?Ow0bPcoD1/Och1LTCKw952PWEu3T+rgOPpCjdl4Q0MGpDzESzipdYSQcbfDs?=
 =?us-ascii?Q?KyXc1eyF0ldRIUSGlU5fdzjzJr2p7Ga7x62RK5ImM3z9X8aqJELJObpgpmSt?=
 =?us-ascii?Q?UkAiIpiDa5I4+YD2m5n1UKpS6ztv0tG86+q2Nn7fH+oSj0BolVO9GnVDx84b?=
 =?us-ascii?Q?fGDY5879Mu1iRQCGHLLkVC6rYitYXWQ3qCezREs6NowIeilqUcYgIzDQlok7?=
 =?us-ascii?Q?Q0i04loUshHtHe5yBXPfuNBl3YCIpxxytIi90Cr72XozS5jX0ni1MmSgPNmO?=
 =?us-ascii?Q?pNkJasIA1HY37+VIRh8bpY9n3CeMlxWQQT7WVOixnHQVJal0wAWwCFyVnrNc?=
 =?us-ascii?Q?NKm5zceZg7t/lpK0MCEabADOnMAet+nmaghl4mPQAfkHo5fIONpXMh25DCf2?=
 =?us-ascii?Q?nzynhxViXHs7HLuFui6m0iTATKexSjoomHUYAZicCe51N4+oDo0eUbShJ7Im?=
 =?us-ascii?Q?GshupZJNDJ8pv29zIw8vDCydoZ49AgXsanHAIJ5REb5z7iljU1OA4z/xDlfa?=
 =?us-ascii?Q?ZZZ30C2/zoFVlRV4C+5bpC6VlK//77b69rQx4ZiOF5EsF05JnE+4YY8eqiqJ?=
 =?us-ascii?Q?FTUWlud2zF3n3/LVU2O2vAg21zrMUeJ5S8PTX3Thuc8z8H4pMckBh9DFn06p?=
 =?us-ascii?Q?gPSZ9MTEUhFeV/+Om2kudPcsnodjLIO7HkTDEa/hgx8cY8XyQuSdFrmW0tRK?=
 =?us-ascii?Q?aL9PAyu/pgRwxqEqCQmGyH7ti6nnU9kSMBYwAxuuT6x3yTl+qG7QRvWvXPHS?=
 =?us-ascii?Q?cyC1o1v5end9wAcLoCqahKUfDYXarUJcvlZsWea1/f9aMSti27HvRED30JaV?=
 =?us-ascii?Q?nvTSaBsQz1Cjqx1U8MJLof3ROAzMRPMIQviD9ZlcQU+5zcEJKmCJMKbcG3QD?=
 =?us-ascii?Q?eYuTrT10PgOm1M42LdE97gur3WkmwQ76AEkW5iyemvyC3PF6vPAHeCWmI/vr?=
 =?us-ascii?Q?xVjGi1GL3DX8TQPuBLIeSxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?woMLPmcXLoHMqb2oXMWMYeWhBkPMUBq3kXk4C4zcq7g3XPhX3liMSH5tWEt6?=
 =?us-ascii?Q?sZS5thktvbOCs+TzjSbli6nwMQKxockI5w+t4GEyjUT4JOfaY+BrrF8c3a7B?=
 =?us-ascii?Q?Wsstew4eBexhEvIs0izycQaKzYxY0FRGnO50kv6hC+husBBPG07UrIJN0IrV?=
 =?us-ascii?Q?oZhmNzSOdhkpdD2O3piGEhZeMOhuuA+MM+2Kngb++WBXy48biPRN0PjGxfvW?=
 =?us-ascii?Q?T/AfhkKlJiRYu0//oljYdru2VsEY3R4HxrWVAQ9C8KzzavzhB53vJqhdv/z+?=
 =?us-ascii?Q?r6ChSIGqaQlRRhmFqMUMUnrejdgl0+Q0kV2A1g5trwlOhlcoaavrCxUSXBST?=
 =?us-ascii?Q?WBoBwFdrkMUC/ksYIGZ/oKxdcL7v4u2zmxpl3NUBihcM5IXP5dsa/bssgocV?=
 =?us-ascii?Q?c8CxYa8SddAxrtkNF7Cjj80YbI/h06gOQBbVn2cGKmEMJUn2bsQ5BYYiFQGa?=
 =?us-ascii?Q?lpG9eQHWw4A47fwGQd1E4YWyiY3tBtM3OR9fE2kGN/oBi3zFKStXYHGS642A?=
 =?us-ascii?Q?OMPP1S0kGV1qVC/s7e9WRq/gaHrWHL8nNc00RGITt7xeNEqo22AWymyea8V5?=
 =?us-ascii?Q?SSsP6u8WCQlutkAzbFJfTvO88AkoCIKzfrzCP+Zof3hU6ExWr6VITQeYrYFs?=
 =?us-ascii?Q?N7Nn8H2bH5Ro5xNAkMqH0n6xHdhulIdp3m7UswZVsh54Rpi63R5wRZcRlfxw?=
 =?us-ascii?Q?ecGo1hLw5BdhnQNIfPC5W6V5bjRNh3a9ZXdKIgH3JIWqZqHkVlhRvo0xKFKm?=
 =?us-ascii?Q?4pl72XQAESCW5SSMzFYKIlUj6BthZXwQEcjcbKi8lJ5oQYIgLY3ZZ1CQXedJ?=
 =?us-ascii?Q?cWvpj4BD2RaGNQjaYP0eYaD9i0AvUX6oUWM1X2HN0TEv12CClTXgIgcRAjD/?=
 =?us-ascii?Q?K8RvDq55Qs9TiTjICZm9JHYW5eveYZ4u3KntXbTYYSdZ/TIvao2TBdDGBgyV?=
 =?us-ascii?Q?7njluDzHPkFgu6wzde/v8W7TfqoNkGoUE4M51SO3REMbLkPzapWCdK5lONUu?=
 =?us-ascii?Q?7lJQSTF91h2c6VLc7wbkwagKwdrlAjN3Fvlly3OYsVsnhHP9dOM2397DbRTh?=
 =?us-ascii?Q?7H5aUt5UppCH+4oy0hjmAXWhXHJFB8vgsrRl9dfTj/YKHifJHmsUhrzL0QZI?=
 =?us-ascii?Q?gexmZkHNl2epSEfHPSUSACZmFEugYkStwvtOtQ+mhCfS7sC0M389wgARJOJA?=
 =?us-ascii?Q?JB8ktsUuuhjcpcXG6ypCbQtwGHl6osblNt5k7fjJf/rdNXflMu1Di1nMlZU9?=
 =?us-ascii?Q?noYkyS2E8/9xXzWh5QUK+VjNC6uMqfOr7XcG83CxFNHHKaoqDmg3aA/iinQM?=
 =?us-ascii?Q?RRfsJaTxHV7IS139f4h9QPGjx8Hqb2WoSWlLYnblRBj+8eaFl7eGucHktzXo?=
 =?us-ascii?Q?5qBh2EIZ7cnmnyX5JDjSQgybVW9nNlMk7fra0ycI9n2DYDMao7tZtRD0YYQs?=
 =?us-ascii?Q?tAqmfcoKenO3FtXzPpQBuUiThKQ3mfcN0BTwDKDKpdPJSvQcbIaC3tDXH0UA?=
 =?us-ascii?Q?h7+VNMY6DoxF4Egab4q7NcCBLJi77qHvgrmiyW8L09d8b3sJv5oBMpc7XJl0?=
 =?us-ascii?Q?CUlY/lwE4ZrVn5bu05LnPOPd+455ZOyyKOQxAjf6dU44Lbw4G2dRC8WBLnwK?=
 =?us-ascii?Q?1syyPKsc9c+FFT/ItszV1wKWbPoCUs64IOUBx1EQDWdn1SmKjUG4FtmtHvv6?=
 =?us-ascii?Q?s+WyWyO/TjzMWOIOaTilKEekNPMnmEUPt/j+/CBGvcAu0Uen39oY70DRODlp?=
 =?us-ascii?Q?X3fEtaft1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d57c65-a7d3-4c62-7bde-08de573ae434
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:38.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka1orXXfMCs+VCTVbZHdP4xW00V0gS4n1IW+LiErDjfU9/H1+I2537NN6UB5FuUZvos/i/H/0bpXpZdshOiggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762

Reference the common PHY properties, and update the example to use them.
Note that a PCS subnode exists, and it seems a better container of the
polarity description than the SGMIISYS node that hosts "mediatek,pnswap".
So use that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v4: none

 .../devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 1bacc0eeff75..b8478416f8ef 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -39,12 +39,17 @@ properties:
     const: 1
 
   mediatek,pnswap:
-    description: Invert polarity of the SGMII data lanes
+    description:
+      Invert polarity of the SGMII data lanes.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml.
     type: boolean
+    deprecated: true
 
   pcs:
     type: object
     description: MediaTek LynxI HSGMII PCS
+    $ref: /schemas/phy/phy-common-props.yaml#
     properties:
       compatible:
         const: mediatek,mt7988-sgmii
-- 
2.34.1


