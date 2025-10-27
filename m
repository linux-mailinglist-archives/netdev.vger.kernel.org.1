Return-Path: <netdev+bounces-233050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF88C0BA9F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FD23B9B42
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7FF2C08C0;
	Mon, 27 Oct 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FFmQ9Yzi"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FE2C0269;
	Mon, 27 Oct 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530856; cv=fail; b=sXEu5acDjArc1Wul3dI6jNxEKYJ4lE1bPJNCTHKfaWg+zL4qgs4U3YjrhQNVaJD2HQa2CTGXAGKVRWWHzX5YGhpVJwYfICqXqQ+tc9ciZfkk5P+aFtFG7LjklbNoEa5s1WsQuQRBcl4IbOTnyBqubuDbfSXtHJR65G6ZJ8+Gc8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530856; c=relaxed/simple;
	bh=3ActxqDgLUfbMFCEqtK86H4/9D6Bq2df1AeY2Z9RBKw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kaUe9ort5XP0/IoSSfritmT8cTeC+aDCecKNL4I0kcHKYa6wW/QJAOMN5zcVPfcwsolWwLrzsI+MOoHzr8vpD6iMa3r6H54Mygo3aiw5Tn0ICyjCj9Oam5Nvv6twmO8AhfBXK9f7BSGhITz4VFtRaG/Yas6aPT1Z5cO4xSxPcmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FFmQ9Yzi; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMRZ3uCDeF+6IdVJEMemVYRJm3TkmzfkEUyplrrTBiDwSPmJR214c8Ts4IZPRhAwQTlmuxSJIl4WITCRpeRD1jdOamRg4aelT4coLiVD8FMoN+9TtSmO4q6ZEe8ZQjR/rdb5X/E/4UaS4aidX0R9DGWI1ALL4ERiRdeZhY4LDlA5o144SRVJcqDVFuHT0xNqpodMd88C9zg1eBGIfgTgTqPpCumxIFfYaYpltE5FEqF5CLmBlFBZfJ02yCEbNBgejqFEYtCuy/hUF0fzEQFrtc0AXXUVrQjXSq6Ybjlj4FDn/NJuHTxt249VTRjvmqoKwtccrBl7ZVcNMTfAP3alpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plfJyPEWfURVKsez4frvN9HPhwBRC1faKpsZCNLzyIA=;
 b=JnQOKNfIrmYsX+Ut6tot+xQcPJn7F2OPEX53AhZO9z3XygBg2BSFwsP9KdcnkAsNVO9djaX/oxNCHA4wEzYBFbU55TcPq7VNadgXh57vTWh7uSc0jR1/HrkvyWJGKNGnqGWRIynI4balz3IEukdmhcl5rmuoKIplHIOpiBfCcyDfoldoLL3/w0PB/LUuaR0sBnf9psa6R55R1zEQgxV4lBsFtmaMDjAbpt3AmXypbA8ja7ubQ4zZn300KR24gom+OfWySCsB2PmxyXSBoEO4px3t6EJrevU7Rrf2RWb73T+EwwWy4CleKzTpdJwd8nP+jJzu5d3UNqVk5aquGK+4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plfJyPEWfURVKsez4frvN9HPhwBRC1faKpsZCNLzyIA=;
 b=FFmQ9YzivxmXfp5tWzk2jj1lzIhpaWj/gFfKxdrsVw2g5LcBcJ6QUnpIvt0e/QgwAAdgblT4wfyGWD2idjp2lT+QMcARf4pHsObnXXPbqUEOF69BzBQ5jTQHzw+IrvzeqIkMoU2/TgKoSEjned2Zx4iHFDIWGcJZyzp3wUL3pzSEciTXwynOOdh7mZU3b7yKxyQVxtKTYVwHh4Ml6Q/v3b8ozD3qpq4GwtHsnXiumF8Q5pDN33aIbBlPjBVYTNSPpDI/QAI8wfC3iFbFC8MkNDUlbGM/jvFraaCxsVYwMp2ndUTVPIdULKF7oss1dHrXKLBZgBgQfkgHfKb/WQNGbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 02:07:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Date: Mon, 27 Oct 2025 09:44:57 +0800
Message-Id: <20251027014503.176237-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5ec8c6-ab06-4091-2fd0-08de14fd9667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|19092799006|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAroFh5n2X4zRU4UN+jEQyF0yZcUR8jlyTB2eHADZVAq02/nCTcpNloKXmw9?=
 =?us-ascii?Q?6ymjbW4BJngbNpAQutB7W26aTzgm+vSd6u8CbjjKfdEythxeuxzMyutBSOqk?=
 =?us-ascii?Q?CE5nJqx9eCDIQ4AQ/QzmvKSqZNWGY0eiIPV2WEVMW1LCd5igH0HNtDHHl66b?=
 =?us-ascii?Q?ifkajV/tesJxieGCTrDls91omi+TKtFgwgBVdvKIJiSBln229WH3sLs4qeCt?=
 =?us-ascii?Q?oJk39kzyUzpiEIz36sD2qxOzW//pfA972b7sey7So/Y34POAruHngJNq9QyG?=
 =?us-ascii?Q?XNC18d2+Yo8tGM+l5CqaRRMtAl+jQSKPaCe7DuKWGrn6TsXZ5e2vgPA/oHXE?=
 =?us-ascii?Q?jSWZPFMTiknE4w5Zs4vG9kwY7QXGP9oqf3K+j29/gTqGeUPLo6LlZZPV9k2Q?=
 =?us-ascii?Q?20I2F7WC/Y6mHE7PVLqqBD2tCmJ6Xsr1dOwGbPHehXTlNmL7ywgrRuyi2Q53?=
 =?us-ascii?Q?ozX23HcBO6UDIKihSe4xZiyxlfOZ7aUSH6fAh520exuDqNc7TAiNd7u+MAbD?=
 =?us-ascii?Q?UpTXQixANfKTUpTeE6CHtVfL6VLdUiNj6Wrh3WVQQqDH5Bx2TTnuoqjY2ggA?=
 =?us-ascii?Q?TwzI0SqHWegTm76AsXMd57MQroKiRC+ttAns0DApMk6LvxNn3FOTL0qdWkDJ?=
 =?us-ascii?Q?1aKphwdWa03mKO32F1Qi0gjyge7KyYuPprWqJ9gdNUvqk6S3EmWlG//lL6zD?=
 =?us-ascii?Q?b3fFSFYhsNijUd+KAbp1yvSzc3mz89LqYffIvuTNX6tUIKzxBz+XQdWM/ELu?=
 =?us-ascii?Q?+XVlJzIlUMSXiodi5Ja7xXE+1xaGCdX2kN/kaq1qtyA99UldhgJnOoiGoYGo?=
 =?us-ascii?Q?+tilrEBM6WgHt/kiEQIGVm1hNjCc7VNhuLgkMrIWeZj66ZfSL0q3XJYnCPDm?=
 =?us-ascii?Q?4F1QQ8iZ75mJjFpoDutnRoK30tnACtv7TZoIfQWEgxMVNaqsiXsRsvZrZaAz?=
 =?us-ascii?Q?EpB9gfJzK7dk3M5x3kfoTu+ZVpfVRBxnHFK5Zf/eWvHu6kukVw5+/t1WZ5qI?=
 =?us-ascii?Q?2hjXDL0RBT9gsxB1IJPGoZfJDdublCXh04I2GiHyQe9uRGHb5z5O1OKVeptm?=
 =?us-ascii?Q?dMlLNK9guVbYCu0YIDnejk5uw6UxZfET6w7aiB1pNxrmZdoSiBB91igIfElz?=
 =?us-ascii?Q?T4+OAfitKHPWWFxkpW1yBQH+TR/syjqrrL+xPnM8B6Cp90Bk6gbFh1iljRH2?=
 =?us-ascii?Q?gYPeenMHIKJZUFCiQIUiC/2pMsecoT52/hKQS2LqhHJfRse9vcjcGlfy8rVp?=
 =?us-ascii?Q?6Hhxo2PDFuFTukpqjpHw5AYB1cYBAzvjnzmTdLtNsVL7THJtv5rNypKeYI6w?=
 =?us-ascii?Q?NtIBza40RL+DRgJHZhy7CeM9Ac6tYYr8h0GdsG/F4MO9KYJqbKNUPPLftZlp?=
 =?us-ascii?Q?/x8qDU1+ywxWo6Oz7fEKwYSlm1A6EWYyZVdRrHAbK1GlldxucudY663ayEfk?=
 =?us-ascii?Q?r519XNzixqnkRGli+l9J6zkZGAEWxRKpzhWDaeaGXsuxRNILN+IXUj10YdC1?=
 =?us-ascii?Q?wjtu+jkFFv2IAx7l9AgMd6FCaKY5Rq9yDkZs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(19092799006)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skVCLx6IwaEqSz2D0TjoIOZP2gaNCSy7oznr+Le5kYLNrZmrNV7xGlEKawfr?=
 =?us-ascii?Q?2DgZDHWalunkl3RWGGBcB9E7Ve439e2OeocbdFxRKKvHhB95HKxg5N5aFnlU?=
 =?us-ascii?Q?8LTR7lCwPY5Pmk5xPBFE20draTblctuUegz6K5Qj0dIFMkcRISUZ0HtXcFVE?=
 =?us-ascii?Q?yvkb8lZptTSKEbyvPlGQzNtNqOriDfEZ7nQJ7wGP7cDMEr+HmJBlRQvZO/hR?=
 =?us-ascii?Q?EOFmy4FpYgrEw2NhB/Zk38MlhH/8ABBeQDVfByMdXd8pXqDT8w6sz2JstHU2?=
 =?us-ascii?Q?8abat9a+GlDdnH1uNjUj7N4Neeig/FrQQwPVD9wAJEyhywTXi6MS7qr+RP7w?=
 =?us-ascii?Q?lFZ+4L3K9fS6BpSPa7lrqWrOVw6mSATsW82Y0yfWAiMhRyoz/wBdBeru4DOo?=
 =?us-ascii?Q?pFNnUI6OdBLSulnmobN+WMVZ5v4jZ/pEMCjpWNWo2iJgwHF7zOZmt25B/P9J?=
 =?us-ascii?Q?cbcBJySZCmIjeqYblM2LVhK3pcZJ1Tie3nEhtP0fw13yv4D1cEFK8s8CIS6n?=
 =?us-ascii?Q?5yE53zuBEgL24X+OHzAw82PUI4dNAKfmYWZxqGBf7AvwIIkjmNCCYkiPP843?=
 =?us-ascii?Q?ArpYOtKVvUUd9NfrLY/90SG1AfH8KiqjN05cD3dphKBUo94luImQyTcln3EN?=
 =?us-ascii?Q?BQyxkCYuEG0EcOmFUQBysJkHpHk9JWhX8xnZ6jJKx8oGahMInHDd3tLsQ+gn?=
 =?us-ascii?Q?Jo5Otg7m3k7PzyAuvA8zdHf4GsQRgWCorgtDlBgWQvPzoR8G5ZLEOwyM3Tuy?=
 =?us-ascii?Q?HYZaN7+T1hoP5WB18PSLvUhytDef1yQn8y4Ake6zvTZkIXgCJn1nR9/pyF/d?=
 =?us-ascii?Q?5HgH9oa2SMJytqlCWdnIFNwRelJTFwH7zyj+q6AOSym+cRHPNs51GnwGVOtI?=
 =?us-ascii?Q?ksrgDkoW1DbRXB7qDKk/3Pq5wDNGPZgFeClLmN13l04djvHFjt6JLht4D4jA?=
 =?us-ascii?Q?j+l/5SENbWvv5SLMo10YzpkRd/4PdU09frvI6xcLLhX9J05OGzmhe9uKzFMi?=
 =?us-ascii?Q?bBQxSAboMm4ClNJj1wbYDZrKL8GqRCgVos7IHYarxYsrXwegTeTEExaR1QeO?=
 =?us-ascii?Q?pSrBiG3qXlvr91uDdQ1wEwOAji9uCpQ5mtIxBgR+NsaACKdNU/qLp/4MTILj?=
 =?us-ascii?Q?3OdEEIiNYztb325Ak9p6pNh6Bfggw7Lp+c6hOKIDBSTZzmXr9LvvuqgUjvLh?=
 =?us-ascii?Q?OvokqV9fPM9USdFo2h23hFj+OnFYqdwC/mXmw+3TGmYsxXMJl9md1Npb46rt?=
 =?us-ascii?Q?uOKiqg2BnVLHbz8UJ5j6ROo5+W8uQ4E/5duEOywQaKJTTv9+7gQhyGFRO8hp?=
 =?us-ascii?Q?k+BzqfPZxWMXgr20gU07gMfAbWKey9fOj3lldZGTBG706hTY/4rqNVNBRVo+?=
 =?us-ascii?Q?blDlWbUXKRTgMF7pLqoqyWlEjyza/p5PuRbajbVLCfI/GnQL9rB1e1lf/LMh?=
 =?us-ascii?Q?IUnYiirRBve+3IDCzK+roPelA6QEqhkZeEPwOo3gxxfLTKdflNNqoN4glaDk?=
 =?us-ascii?Q?a/9D13tCxSpI+yLfxhcCOSGTwJSgSLTgRt7AAbVe/7eQhCSydwocnx5gkQhj?=
 =?us-ascii?Q?9RxVBfVWqkXjPHlvHYaaYwpoyUUW7+Jxoe4Fq9Hv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ec8c6-ab06-4091-2fd0-08de14fd9667
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:31.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbRJ2gTPOpN6rndOR1lSiscvb90VkyZNlMeeWbPtED+NvbI9/q/dEOFytgJS+4p6irDW8PRH9a/ga7PUvCbQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417

i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
can be used as a standalone network port. The other one is an internal
ENETC, it connects to the CPU port of NETC switch through the pseudo
MAC. Also, i.MX94 have multiple PTP Timers, which is different from
i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
the IERB ETBCR registers. Currently, this patch only add ENETC support
and Timer support for i.MX94. The switch will be added by a separate
patch set.

---
v3 changes:
1. Use cleanup helper (__free(device_node)) in imx94_enetc_update_tid()
2. Collect Reviewed-by tags
v2 link: https://lore.kernel.org/imx/20251023065416.30404-1-wei.fang@nxp.com/
v2 changes:
1. Correct the compatible string in the commit message of patch 1
2. Remove the patch of ethernet-controller.yaml
3. Remove the patch of DTS
4. Optimize indentation in imx94_netcmix_init() and imx94_ierb_init()
5. Revert the change of enetc4_set_port_speed()
6. Collect Acked-by tags
v1 link: https://lore.kernel.org/imx/20251016102020.3218579-1-wei.fang@nxp.com/
---

Clark Wang (1):
  net: enetc: add ptp timer binding support for i.MX94

Wei Fang (5):
  dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94
    platforms
  dt-bindings: net: enetc: add compatible string for ENETC with pseduo
    MAC
  net: enetc: add preliminary i.MX94 NETC blocks control support
  net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
  net: enetc: add standalone ENETC support for i.MX94

 .../devicetree/bindings/net/fsl,enetc.yaml    |   1 +
 .../bindings/net/nxp,netc-blk-ctrl.yaml       |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  28 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   8 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  30 +++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  15 ++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  64 ++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |   5 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 203 ++++++++++++++++++
 10 files changed, 354 insertions(+), 2 deletions(-)

-- 
2.34.1


