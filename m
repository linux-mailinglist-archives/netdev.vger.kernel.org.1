Return-Path: <netdev+bounces-274202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHuTGoNVzWk5cAYAu9opvQ
	(envelope-from <netdev+bounces-274202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:27:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D512C37EA3A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027673047580
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE14779B8;
	Wed,  1 Apr 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jA0tHIfM"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522132E143;
	Wed,  1 Apr 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064178; cv=fail; b=ELenNvbZkDkmFVmCSu26EXf/2oMmhEdggQF/ETp5XGymtsxAVcks9UNGf1bit6W3EOT20uHTKxVNGEcgadO28C2hhCSBg8GLoOO2zvLqVg54f2fj2liBKzWM8NlhFmmI11fjyhsSmHVmDvvRg56v8LqEQ0d9b8GH6fycOX33kUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064178; c=relaxed/simple;
	bh=KMO7SxJO1IuIZTdZ4NK3ijMfLIAUTnFeao5ZnZc/Svg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ifV3CMi1f+9C7cWS9Mq7W1Y5EFl83a5zXLa0sSNafO0U7QX+7oWwz8wNMI9t0rfaWIuoE1DLkmn8Dq15UBrWJoVusqHiur/T1F4sGPR1m4lvJuPVenC/WlveLOh7oOnfEuIafWS5RDgvK+/U20roKd88QpBaWm2mugUvNr3g6PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jA0tHIfM; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwSU0bN5jf8hxNxPLw8tb6h+DN8wrdPsGKCIJpXbb4bcxkfZirAexHRkwDbZrKmzNS+PUx8bEj/Z2Q157Z7/BMQ/goRbvMrx3tfIR033HmM9xHbYOr8HCS2exORkuY6KFCLJib9Mpu9bB2lrwHesHY8V6c14gV0dFSaGH6DzPjQXEFpjQQnYJEddI0ebsPq0PyPDEn69fMyUPsHP31QGp09XMicekEnxz+R+GyJZ86sIeYspwsMEqxYwpIMmfErthmzFrdo8HH7+33+qE6sftDhnxHAtkEheFRJGXE8x2wKg1B6oQwPjtbeAbMKynUE5thMRYO1TX6jsABrgUhiVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snCyxZwsFD5ESy9yO5XgaqefWFmq9Y0dA4I71OzI9mM=;
 b=n6837p0goQAZjx+NwguXT7o+Qt8wLZpsRSX9dkGK74tJeqtf6IhrCShfOdS9fGfxJgdwFJ+HrcA7QzpuxGa6QOfYeV5RoFWuYNvzMp3hh26B1/y1AiwOyLWTJe4+LmRcjiCaKno8esoJip+ZnwqeB+8wVPhDjDIgYoJg0E9n9cQG9iZ5+U0s79zwsyMuV5W7cyiLCKiCTbL4ZvBA7oLxFVDlY4UsNaxebnNbFxTd42QtSOlPK4af4dEzlIR5tS9k2flsrj9fu35JrhESe/3G1CVth62Wj6PPJE4Qna/AxRi2xXns244weGvrcjOrd61S2T8MScERXb3LiZ2ih++zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snCyxZwsFD5ESy9yO5XgaqefWFmq9Y0dA4I71OzI9mM=;
 b=jA0tHIfMHgCBobxFOSB1VsJQzDUZ9jHpz6DvKOMm9oNEGeH4gqH6PWCPRnOww1szL/m8VIiE0cZpRnR5GyEiYAjYo3Se8hHzP+dpVKH4JM2qzQAz+MxTHbWgf6iHIs8shamQxYieLwPFvooyUAqqwndFYb42DQ0vax9ltaiRwkVuXJwBetOi7UOAx8vSB7y5F5DXVx/JXaJPZSkOXOLGzy5eUZ81rxYWWxva0b35HHio8wpmSwt4kTx/havSEi4x9Js5Cb6MYlsaXYGcr1XLo1EXGm2WClTA28wUxN9HvEP6dINLjeLcoDIO5Uz44N6vFlcTfoNLKQQH6p6XvxPVgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:22:53 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:22:53 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] Fix short frame transmission in enetc
Date: Wed,  1 Apr 2026 20:22:43 +0300
Message-ID: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: a7db7362-4136-4328-eb27-08de90134e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|19092799006|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UdQxU/+1II8ACbxtd4MOF19/xzQSYH5INqX/3LxxviIY8/Okbq6dsWGZZJoCNIbcNrsGvXQ0/sNVMmB9LmAW0Uwt+SB3ENbU1gQL+H3Mq+QUHG47eBP+/nC3GtuAvlRgyULDV01wyIlPzYU9B0AmLrtGDZhFx8A+7HYAsKgR4UfClf0ye30ILiyiTyzVeJSxHE/ULkhixWtWoWrpIMGx1iufrhQEjqxA7H8HNMAtVCEgjrwnqZ9eO9/UZyZ55Ce7IOJ+UDT71+N8ytjDtWRVMJqmyjs7Udna1xlGD39yAMQSgDeM6a7+mNMgzq0dFvAq9/yFrde1YE5jjwEx4aLwlqLezF+ZWKBX3cLDnoCQ69kJmeoFsnpgg5ytUGRaWHEIBM4tr8UWvvXaK3OkDzjQmkzeKbGBi516RUZCajxs6Q06bavWMw6DZ1CL74JXM3K0mW1EV0el218QItoSMn0BcjEqLdhe6oU1dYBx/SX2SkTdJyhv2zj+SfW5q7eLbk33/NqE4WXATiFuNxISvFp5ivgTo9+EseY7pbbf5zQHByQGexfrYMloR0ZVrxYGiXuAHhjwR7ZV2LDPZ4VQPcGm1Vn6g3Bhd4bJAoxRD2zpthOZFpaIanbAq2jBzWXhSK5ojjvO4fInmu3+PY6v+CHV+gVzoM+8XDNycq/YvHHzxviJAHLsNhWR4KbsSFJbi5NEuNFbkI3Rxt3q+H4a+ylNya5CQ/DAXFv9DtanbznMs68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(19092799006)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FV/J1BfxtvbZO09VfhcCW41LlDhFwEfvYX9+MyVS08JrQneU42lQJsIZ/ZJZ?=
 =?us-ascii?Q?KSbhFgFHS4BLBY+Qxl30jaMMF+Ws1VoKQfStMyzbe3QPHawWLh1TviMw4o1X?=
 =?us-ascii?Q?fETGdVvBtTouxO0P2XOQJhOZGeOnwaDeNLRZG/0FU2iyBSWBygYh9qFczw2x?=
 =?us-ascii?Q?Eci0u98AsOMr2nZjJA+OP9LxYE3uyKnbqXwSy+Nx1QprssEqyKxTFoCvbNVY?=
 =?us-ascii?Q?8F995KZ+iZuswMo7UALpg5RYVHm4dO4XP3li2WmUjICOMUBBtwAd0nnByLY1?=
 =?us-ascii?Q?BLjdsc3+lCGgh6Bn0U8TLGKbl+T+1JZL5oPQSsgcd9SdDc2gnvMZxFfybcL5?=
 =?us-ascii?Q?h7nD1cos3esR4mk6Ujj7W6VAeBwIWD3XPS9OS8byeeE9M8/TR8Utnl01Xv2g?=
 =?us-ascii?Q?hCbqPhziGb2IYxi2uUfodDDYjjYw391FisPl0sApzPjmpyRDQvYN3DbhOV18?=
 =?us-ascii?Q?biVemrlCc6U+kK7Wwhhym33DJr2G2BZjPmjToKuO6fxHFwFeAKWN8374qNVt?=
 =?us-ascii?Q?mY9+WO+0zpij7eivJidZxDOGUg1cB20pcsyVySMOjTV2F/PJMMS1Z8ajRUdZ?=
 =?us-ascii?Q?RhVa5Dwdb3aL3ATZ0AVl7u2uCBNeRvPomujUF2ML3Iv73rj/xVXOwpsj836j?=
 =?us-ascii?Q?UQ2JOPPlIvClik3hFP2LwVYDf3xxcpKkkW6+dSGoE1GM3qsW+jYoF2EW1WgI?=
 =?us-ascii?Q?DUMcPSTIhep5fBYiprN9qm1UugtCBLJhN2oBwz+/KU4lk2jj6sPc40QjZn5f?=
 =?us-ascii?Q?PmorblT/CtonK+vMVXjpDUq2jHYVx4KFSFiiUDNHyUiNKxy1l1pQSysF2ltQ?=
 =?us-ascii?Q?4eXq1OCjzNzsBNy+mJhl9w5gQMQiSvXhufezDhcp6GrctfV/++8FyqYMOO9Z?=
 =?us-ascii?Q?v++QQ3MmHlJ9kq/+t+j6CTLROUlswXno0O6XBgwzgA5/V+dYXkQkyn+Wlhdr?=
 =?us-ascii?Q?w3BUHtfV4PvpCq2y7Z7zk2077OKlvCSEiFXeJZBz+26SbI9pJXyd+XiF3kk7?=
 =?us-ascii?Q?Mq8uU8SERNgNIYxBUdgCWkFPD3eXffVbEqpcd+EjWL9tTT0f4isuMQKDHX91?=
 =?us-ascii?Q?Jm2K4DBNOYL5PTgakFT5Zue6Bwqo/KhcdYAKnDf+2Oyxc1TSlaz/K1DRC3c7?=
 =?us-ascii?Q?kUZZSnctH0h8rcl4idvIVwYibd8Xz2iDZXPXYJH5I0YlG00RTBIY0uUrX5ip?=
 =?us-ascii?Q?t9M/NZumv+Hy7AjRhvFTVRQe7Gp6a25HMZmtA77+8+Q9+hNa6QGTLvii/IqL?=
 =?us-ascii?Q?8aAuQcD6yayYq8IJRYNcS5a8vkRXqTiy3o2RUv6EnRztVvQRQsqG9yGjTWsC?=
 =?us-ascii?Q?v17ryffuS8HW9omvqC2gvvkHUI57jeeEIgm/OF0DHTQvPc2M22DyZsvZQq7L?=
 =?us-ascii?Q?bImmkVnFN1V3hDZPWth7MvOMknFhm67L5/8T5QoBc0OnuseEwcP69l/V47ab?=
 =?us-ascii?Q?l+2ZG8bsfcvTp8uN2cMWOvtk9Zk/Hu8U8/ai9D+PLnTf0RR+EqOwMR0Wf6eg?=
 =?us-ascii?Q?B0rTDTUDlMEOPlDLktKvcTkpdr9Z3oIeE2EN6oLD4K533H5xZAa8wTO9lH47?=
 =?us-ascii?Q?bHM+Yg5t/yWzptbNj8xrKVxB8lCjXywAHWB3AXW7D2bBQHjL4VILfx4CwPrK?=
 =?us-ascii?Q?xk+vxFMHkMFI+LuckTE1UUSOE69kXL9LyAfpbErJ8A2ceIrSaEY7PV2WT5NL?=
 =?us-ascii?Q?pwqP2T2JBLoRYbl21blkLYQo4TkWJywTGWGDth5eBzP1T29+25gmBqZtZB3+?=
 =?us-ascii?Q?YXInDoz0K1tSZrzLSUZk+vfkliO2jUvm4hRlkl8OvIvdBCmserXT51yRbgG+?=
X-MS-Exchange-AntiSpam-MessageData-1: svfHd4cSZnB0sQiKRsyLXROkZyOZMOquAJo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7db7362-4136-4328-eb27-08de90134e0a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:22:52.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ay1gl+X2w+00xTv8UUwjvh3BYhlSshAi65izFLpvdIPwckUBkUPuKbIU6xVh8i+F6rRICMzyZ5onjijsbbL9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274202-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D512C37EA3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a belated follow-up to Zefir Kurtisi's report:
https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/

My analysis shows quite a different chain of events than the one
presented by Zefir. What is common is that, indeed, the ENETC misbehaves
when transmitting packets smaller than 16 octets sans FCS: it sends them
but does not update the completed index in the transmit BD ring.
However, I did find a sentence in the reference manual explicitly
stating these short frames are not supported.

The main patch is 2/3, which Zefir already tested and confirmed working
in the thread from February.

Patch 3/3 fixes a similar issue which can be reproduced from the XDP
path.

Patch 1/3 fixes an issue I identified while reviewing the code w.r.t.
TBaCIR interaction.

Vladimir Oltean (3):
  net: enetc: fix bogus TX ring consumer index after reinitialization
  net: enetc: pad short frames in software
  net: enetc: pad short XDP frames coming from devmap

 drivers/net/ethernet/freescale/enetc/enetc.c |  9 ++++++++-
 include/net/xdp.h                            | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.43.0


