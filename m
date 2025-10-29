Return-Path: <netdev+bounces-233755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9CC17F8E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18AB535363C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62972E3B08;
	Wed, 29 Oct 2025 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OqXNmk+/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9F21FF26;
	Wed, 29 Oct 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703269; cv=fail; b=otYdptxQFxzHe70kVVCDCnC7TF779qXdVrxk1/NQHqv5XppaC2BJ6VjRWjDSJnetIM7ZG4rGndMWaER908iFfXyf3kWvQd5JRYHRtmcoALK4QBP6c4Pz+hxpucLMEfYaL9Ggf9vq7/jj9HiZfCf9Pu7qnFDMTSyLDsdS8Nb+qgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703269; c=relaxed/simple;
	bh=4dFtO1++b3CeXawMH6ykJBs2yHDKK5uljIdPi72en4w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KAPbxNA44JuzHUndbX4gikHmRRZQhQV8laMYPm16hbghEj7xeCri9nH9ZYj1q7ndi/Bgxv/0J0t7CkPtmFnBgHnfYMRKfzw2yLoOZJnZa4FXB62+zpjSbNgna1fxUyYX6SHMMUdg4K8cn7aqTfrZV3CHlJ8mtxnNkBtHjZb7iRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OqXNmk+/; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuq+DANxRG+JU6+MKvjCKWSPWqWJOCtGmy8iKUZ7M6+Z/N6wUzBzcSBtoJMejBEUj2ol46v70UHzAN3ZHmULyFEbgHJTga0LwOzaFtPvyyJJpW9vjpnoP69fqpfNjXoGb2HiJwH8cHLItKdFSKxvVt9NanfVm4QxrMuxVY5+fqjxpRdIOa6+msNhnUhC0+DbzbE7AUGQ+9oYjMFr0BxvWoasRHuah2CrICH2iu9lnr+ayIve66OExXXeZ1kAWYRBROP555NYo7m6v7Zr40aOJBv39r+4vNhzcWCP/5TWtdy8Vuj+55tzOAzoNyRorbJHsT1Qqd5yuvuDJ51lUxXLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI8jc7hy/sKuR6vYCMI98WhMc8w6OlG7xoH3FFJhyb0=;
 b=KwQPLQYkSgNFuAHtksu4Gxe6mjs7o4duN142JM5ZK7JyezkObMh7qZf/j54p+rXfaqWE5iWTBcTMRgy9DogcUkDtUiyUf7HXxtDBXXnefE6BXyzfeO0j84ZBvRXYY2svIGMCBV/7mEi1u6UqPw/EBNcpVxaiNQ+lVg/kSO/pI89FZR3PW0WYrDq8ft0U7Xd658T2q54KwqC/9LK6fN+dQ+BLiLV+ogMU6Qr2Zi9oPNIurVV68zY33DQcff27MIJt6uF//gjXHrnbmwfYQQgwaQb/AFaqeaeIbnP7JUrYS3qjqNhg8fG76XAYvhusfx0s3wYEZruUDOl99FiA240B/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI8jc7hy/sKuR6vYCMI98WhMc8w6OlG7xoH3FFJhyb0=;
 b=OqXNmk+/XNk5gusGoZQYelWdzx0xbO7HeSFQYOOlZZdleWmz+WJF1kCnettBqh3Y8rI/2ABT14WZILhzks2Wj7XGGM4usgRnBo7J3wRW9/yviuOPl6LOPTK3YRP1srXQlCMiMGgPn3E55bhRuV04snCPGmkFGx4Ycj6Ucp41x4JYfszThcrBBLkLCGDXHAuFM/0L2H6eLMo0r4Sd5HChOV2QHoa9gKovmXRkr/mqTCPLn9NNd4xI8+3XUk7gMX3Ib15CZ+Bwx1oMm3Iw3MhDBmNTZQQyjzAWaZ6+h/6Cjq/ApZs1bWwh/iNBxGmisvoebLip/c6vpFRu7N7BVswvug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:04 +0000
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
Subject: [PATCH v4 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Date: Wed, 29 Oct 2025 09:38:54 +0800
Message-Id: <20251029013900.407583-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7bbe31-b43b-41f3-be90-08de168f0450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tU/OlwWDONA+Nyjb0mly0eMhS2wOaYeltdgs/28DthtqMfDL+SL4gSIxKZ4D?=
 =?us-ascii?Q?pklfQMUiJEXGFn+D8SY1eD4tTbBg0ht1PmH9h0l9SDzNcPMR/EGM4XrH8EIB?=
 =?us-ascii?Q?GCXq2+sTiv06QdLp3Fheyvl9IRe5LXUUbmEETuWx2VhzdgDBHghsKrHcxIVY?=
 =?us-ascii?Q?KxtM+Er9uS4BwUYHNPe+OeSiZAYF+Kz0grJOfD2ttnV55DQbFA3Q6j86ccrU?=
 =?us-ascii?Q?5QQC/9ofSGwRvnyVf6LHMtXki33cx/c6LcwPyJ77+nFbATkW6FjcV48Qv+7P?=
 =?us-ascii?Q?zdUl5JKBxargylHnpobRFhnPPxFQkN2KMUo7YO937/ezHKZXoMNp0LhYizQP?=
 =?us-ascii?Q?RJz8xFmXDtXkn899Cpb9ZaM5Q0ZNNhVVYcl6ez6RnqgmS8Y9iy1+2MQdSlin?=
 =?us-ascii?Q?9eO5oqA/tij//Nn6rqdcOKcfIdzsB0BnwcX3l07pueSLF6mK1OwgNS6xlqov?=
 =?us-ascii?Q?OW7ituA868CN9jyulk4NY+ZqcrytwPiisdJl5bIkaOBYJQAO7qnhM+mPUA87?=
 =?us-ascii?Q?6H5fi+9DUxUs8NwF3kOwrbab29i+a24LdQMlP2MoYJy/zbKf2l1m8Vx7EqVu?=
 =?us-ascii?Q?9otSAmO7ngxYtEC5+ziDKi85OPwUL6d/hWdwvHIdluDPPkFQF/MdYQP2OGlU?=
 =?us-ascii?Q?G9g57LGx3ElEljaALlOSUC4QDYRzUJvca+W8El/VHcDrsZcdol3VZO4d8fxM?=
 =?us-ascii?Q?jbO4T6SJAk3SbtjNyeykAWgyzaHqLf1ZXKzlAlO0nER209cE27NDHd7Pse2X?=
 =?us-ascii?Q?vbdVFS+QqJVUzQMim/Fje4DbL1UrD5UWX7RzN+l5J6qry4PWV8k3tvs423vy?=
 =?us-ascii?Q?1dxGNEVsPWCH4IE4tL3HQCs/+gJ6Uc6yFUYEBWd8gvr4PLrZwDEXgUqBCZFW?=
 =?us-ascii?Q?hEHM0q1bEvSPdl0lNfGOhOmZXhHO2O9fQ6aZpetchTYMz5eOCcOXp50IFn2z?=
 =?us-ascii?Q?n/X85JNU16Hd6WQu45gLZeGrfkKlQO+GFJI4tKNNTvjr7V5wC/BzwT+8h+37?=
 =?us-ascii?Q?TdzTEvBf8CTpBcyzWmjoDU3rEK1g+2eyMXbRoUO7as1b7VEKIzQKX8T+cD5E?=
 =?us-ascii?Q?hJffUtqBkIyWOvwnnJo800HcG77sR1tiA+ccwPMdvGoAVnoW5DShgK1mJDkh?=
 =?us-ascii?Q?m5RdiD1HFtUJaDLQ9PbAFh8QONL5IsJg33ABgTJkGsCEXGTXxebTTGVPO7fv?=
 =?us-ascii?Q?rsW1FJuLV96o6TgKEkN8lohZG1xqCKiCOZOSIfom0jP8/wVd5H5P3jK4k3aB?=
 =?us-ascii?Q?Aa2bCvXVZjvA94RqQ3MQIHtRRDAVy4YMabkmzT2w+S6HYfUcIkSsThhGv9Na?=
 =?us-ascii?Q?doqc4eXATPHqVhDkgg+lwr18YxuouaI+UlZBvjSciwYMeCemxKLefeY2I0E6?=
 =?us-ascii?Q?1dmkpfLyJ84upI+x7476o5PVP7S3SGxFfmnMaPwV3IAjpehPPLxjpeiu42wP?=
 =?us-ascii?Q?/TduVQlT+WUXY7FiEzVvnJMt1alEifThY33UrydhJoLfaD/ocT74nMskSu0E?=
 =?us-ascii?Q?I0tV7nAARbfg/bYP4dDGqgKHA7nOfF2Im/V7WXwjamCHHC/jrSJj0jkxyg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VpyP2XB4uLgci1Wr0zaOBdIZ3iWSUPcGGPD/wc42qTaX1JTXbwu0APDXRjnC?=
 =?us-ascii?Q?PbdU8pSf8mRCrWxOzFKd2zAaKz0lcH/3Xw3qLDoHHZvPXEvBlX6/UdxD8xCM?=
 =?us-ascii?Q?3xqb3Uhs64aSP4Q4o7/TcPaBs3TZF+fWHNNJctew6ehuF00X2HRxyBbzyrRp?=
 =?us-ascii?Q?3eUhCU1s1nWT7zSrB9QAHRVySs2QQ+na2eCNg3zJ7JoLBVPBu7BIZKfza20Q?=
 =?us-ascii?Q?fU6eHlHq9HZqfcvy1XIbpmGVVUTmq/10tdYf7MnjzCaWdv0XvOW47UeZmRaF?=
 =?us-ascii?Q?WW0wVLF7CWX+2v27edZtMPfPqjUn5sM27RzNm62AsW+gp8JvDNdkmroglSar?=
 =?us-ascii?Q?kCCzR5bKF/7DRmm59ga7HCaFqn1orUPPJI7sVTbgqSEDtmjaLPwpCmnmrG+W?=
 =?us-ascii?Q?3jFXqdOS2Spi2uYIaGQ1ugOLTrVEgtPu9MFkaZ1bMRIarGeJqOcYwE1Y6WJ+?=
 =?us-ascii?Q?CzjYpvW909gQ0qP9e9c4PACM4TrD0IRzhScXeJqSe2COfjv9gD44qNTvvWPg?=
 =?us-ascii?Q?3SD9puo2+pu85fiVnBQxJVDI7KLy87tR3mQ0C675Orcot5IBWpyjctJu59rH?=
 =?us-ascii?Q?G5NhXxH51LNL5a6wKQbqVf0dJaHbEgZpjZqwzQd1D8hkMugs0HSHevlr5FPc?=
 =?us-ascii?Q?yMjv9rjTObYTK4KBB2hs7Hpt6vxr2Au3qKpS+kRa9I7J1VDnOTl9d0ckIxGi?=
 =?us-ascii?Q?P3xeIGTOMZwPNFU/VMxQaW4mxZnSv5fSlxRBv377HRi6H8d+JyyiFuUoXEV8?=
 =?us-ascii?Q?gf0IebNE4y6cIiX3Np6rSFkfzIHTVzryWOLo6ZJJgt2DngaLJs/GvJO3ReOw?=
 =?us-ascii?Q?nFoQtpURMUQEvtbDfnl/wkqcEWLfI7R9wi1bfjlCgtOnm90+OshiRPnWfOmc?=
 =?us-ascii?Q?0A1xSwBq6qcDmkjvjJSflD8O/sX/Jmyfzs55JoZvXqbH9ntV48BcXPFhCMAB?=
 =?us-ascii?Q?riGHRtlYZXcj1dFLiToXTH1TGxzUoro7PfEG2oP61UwsP31onajh4HbVfN0H?=
 =?us-ascii?Q?QZsurPZHwwK2ESW9Bf8YNDIjAxMgi44ItHRtEkf+FQlICCYAaATPj96dnoj8?=
 =?us-ascii?Q?PyK2HdWF77LvBL+gwn9V2LxzUc7hhW74gsimze5v51jFBWMMD+iB8WApxBVp?=
 =?us-ascii?Q?OLpRDQw3yshdhyHyCq5LKXKMi7aNL+SpVNBXn5WXg8wTMOqNrDEytexRsl9N?=
 =?us-ascii?Q?VofXQ8zCnaLZPbWN/CDQ2OVgAPBvYSYoWiujjMgw9WMNxGCz6rGpIfxvBnNu?=
 =?us-ascii?Q?YpK4XjcSlHjnwglfJITU4JF4ZJwuQZvNc5LX61N7wxL1OyW6AvC6J82f+0rp?=
 =?us-ascii?Q?cHugJBhsRQTs0m380YscVa5b8+YPK8HXpQukNMQjOPSD8INU1NuRQelBaRwK?=
 =?us-ascii?Q?v/lktOJ/8MI+fa899dt6xRaE6VNkcx+xG0aafoQfHFUcC59u5waDCx+Lcl6a?=
 =?us-ascii?Q?XUp3uaan/s24uFkeeFKM74q5RX05TkJoW1FT48S5j+A9Rdr6qh4GOnafPUVt?=
 =?us-ascii?Q?z9PY3rmEyZGN/JwGkHsBTGMSr6tt4Vwa++eh56Kc0kL8NR/n568b7mnqDJPD?=
 =?us-ascii?Q?/kBZcCP+uz01HZ3YELSGu2Qk4VTSEapRmCxqB0yw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7bbe31-b43b-41f3-be90-08de168f0450
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:04.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqlC2qYtjzUipRE6KL4QuT8klik9bpRCR2xvBcGJvxNZwVIQYn/C9ynyEfM1O9O43/FrEjOQTQQdtxojEC2LQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
can be used as a standalone network port. The other one is an internal
ENETC, it connects to the CPU port of NETC switch through the pseudo
MAC. Also, i.MX94 have multiple PTP Timers, which is different from
i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
the IERB ETBCR registers. Currently, this patch only add ENETC support
and Timer support for i.MX94. The switch will be added by a separate
patch set.

In addition, note that i.MX94 SoC is launched after i.MX95, its NETC
has a higher version, so the driver support is added after i.MX95.

---
v4 changes:
1. Revert the changes of imx94_enetc_update_tid() in v3.
2. i.MX94 appears to be earlier than i.MX95 in alphabetical order, but
it was actually launched later than i.MX95. To clarify this, relevant
description is added in the commit message.
3. Collect Reviewed-by tags
v3 link: https://lore.kernel.org/imx/20251027014503.176237-1-wei.fang@nxp.com/
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
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 204 ++++++++++++++++++
 10 files changed, 355 insertions(+), 2 deletions(-)

-- 
2.34.1


