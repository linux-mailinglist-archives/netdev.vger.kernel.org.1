Return-Path: <netdev+bounces-285263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOeUHqN1/GmdQQAAu9opvQ
	(envelope-from <netdev+bounces-285263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BFD4E759F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9FBA300443A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB703128B6;
	Thu,  7 May 2026 11:13:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD82D1931;
	Thu,  7 May 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152399; cv=fail; b=mfnllGNUZkrFy0q4om9kBlCOe0pCP2JqWAlmFp3Oq+mFvhwKN3yscXZA26B/tlpsKwZ9FuMI7+2VPxkFO729fSLRSitVzP/C8nOQl05VXIOIfu6GRU8/CltOhbeFo/ucYKdOWFsDnSKpqqCe6v3RxQ99140GDN6MKjU1eLHYMK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152399; c=relaxed/simple;
	bh=nCnrTvzax/CALVg/+VUAEQl/BmR764vYvvy+FxRHtUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L16eZ7AZvyx5TGrkSSyjETYJ+PXu4u0f/5mGKqQLwvgCisbBlnY3ZVPwrgCfu8rk2AI5B/Kh984X1MVdM/MX8TN0B7Elqs6Hvtf28FzBc/9IulbficxkZIG53s4jo15qLQPOIIdTlvjAfrm5OJuomaEn/yiL41t97pBTVCXNZf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQPZvRKRoK3ZdRubD9eiwWcBS26Vw6kxFP1YIab5nmVo2ZklTrrX7YO1g/B53L1f7pUMuVQUHYrTVC1tYVLflFqScbJxO2W+rCONnIgXJ9tMhkGjuFBo3eqVzwBA1/bMIrP8NzT0C2pFMjRHIqfg/NBdR2Iz6CSgOwex0UbHXS2QnECtMC+4A5CJ7DVqCntBKUNegsTb2pEFe3esHykDLQIaGgvZSGwuO1LioE+Yo+CWgnX9RTOxEBDa4oY1jGVmFt9FPOMvQZAKenfvzyHVHk/v/ezO/R12PMmuh17aWKGT01WE7u6wZIFKWT3jAH0TXxtyBQb+bB+5a6l6QKvaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNRxJ9ND+8NrtjQFwg8Qo/jph/f8sCAees6AhSTwoS4=;
 b=UjlxBRBDsA3QFTTlCj2WQV+c3u+o30rH6BGpJpcJpZdJ1RdhyPLbwWPMP0mfevp40gB+E+GJ3YV186km6dtpM6Y/5RgYMnrWD32WvFYgEeHLH+VwPwRieHbzdwExzGGTl98K/DpqtJNMcg9ghXo7aHnmn6g+LPlQPjJeAROW4b8vPyCdCSvsXadKNiHF9jzFujQluq9TUJZvifEVuammfrXD9c5Kfy0/wbGBpu0pI8TDk9P8+xR1Skql17VKdbhvvdJ4CKyVz8LAinHdnRbTkLIy6mROFFlAO2wHgS4ZveOF75cpJAJ9d8Q2jnpDMSNXfXfY0ug/y/q1OuC5e/h6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0870.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:41:24 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Thu, 7 May 2026 09:41:24 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 0/5] Add StarFive jhb100 soc SGMII GMAC support
Date: Thu,  7 May 2026 17:41:10 +0800
Message-Id: <20260507094115.8355-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0870:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8851d6-7052-477c-9cc9-08deac1ccd91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iNdPKEr4FHG9j8+c9BddGy5IAB59LtjvuBuAfQWVab8opLQSWtE1CV8ASM9qtb+uo/hNxiXLsNFrA2gxFH0JZ99iA0hrT7GSboypkA3DqM4X2HSIhWx0A9vxJL+D0CBHlDXGSVf6Q3m3IPV5Rg+ntEYPUTK0WthANI23aqZOYA5WTyJlUQ2pmuBpkrc0Vd28EDVJluF5+BN3qD5DHGPweWhcXYaXq3zDto0GvsCS9b5CzikDtiOoYaQMGVnDA/VNa/AtEEBrdUYhnOzAvSM9FFCZAGBx6zw5JVtlOD+op4WTSQSwS/PKt9BDUDyBk3owwQy36nMy+RKv6W0Kw20j3viexakGEEshVCw74eiOev2xSnsm6vDnmtTu44w41ig2qJGlG52+UvNJmRU2VPt5Q6Wu/3mZUYNMceybURSDPqgz0UbWn3NVWDA9YN+byzv1mJszBmSZtaUbCWQX8bCF2B1JcaZyDpo0SeBt22Gi2GqhYl7Kq/xyvNr+N+mCZemsqJpN0f2FRgybM7WMPw7BL1KdgYdIGaZ+mKnSaw4ZO3B/3MTho5ilv09fqS6Yzi/dHnjDXa84BOAWQPBfgyLvHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTgiKbQtoIG4D6SNATsXuRjkY+QeztWojhbTulxc2EJexii8Iyt/qBRLCd6L?=
 =?us-ascii?Q?2Fsc0UW6cLvlPUUIjwOvdzh481Ymsv75ObOPLtk513QEy4q5xRs8WXpiSmre?=
 =?us-ascii?Q?F1mwVG+DZ2wcu0KTfhfKi9slQsET8wSWSm3xMGWMVtqGS9sxn63hgLhhghVN?=
 =?us-ascii?Q?HAMlFpyzKMpxLP5RAh6XMQzG8f0FJTcAK89a9w6kUkYmRQOe0K7FLXVJk3oA?=
 =?us-ascii?Q?wTFcj3V0HKkxw99rR+L6w+mPNbnBNaSb8SXyvi35N9Ark8opX+x4/sLZXncl?=
 =?us-ascii?Q?07YfQHXmWYqocy0ZMag9WtLuotsOm3bDjYdF5gADwLLUppHeX33goEWsnfAy?=
 =?us-ascii?Q?/99mmJa9SXXRVA/GfARADWFb3JZ8lt3XGs+aNLpPF52KsQPjXv4Iszyz1K2P?=
 =?us-ascii?Q?KoWI/OJG932SiWihk/kQql0Z9s/rGpwHnxfdcAuD1GNusw5MIaxShYOBvBdN?=
 =?us-ascii?Q?I15ErYxk1Z0QDjO/R0JGMLbCFume5ZFA/EFKBZfDWuIt2DS/lt6tFvV4YoKt?=
 =?us-ascii?Q?9kZ/xnoYwS0tyPwN/k86bqq38XhWEuAvhT64wg4b1vyuOYXTPodXk73Z3D9n?=
 =?us-ascii?Q?dqeESRVcS/4Q1IsYnwWUt32rzfJyfjyYgQ7q30sKabfI3yv5JRLk2z+6ej19?=
 =?us-ascii?Q?TZsf5VuMAAo4h+r1QRN3ODsaG1DX71BmSKsxUIh+a9VgDch7IBhDUvSp1EB3?=
 =?us-ascii?Q?rCF4s77I2rzCq/TFPZRQSDA8ct2HnoLLgK+A9NdnSirBECxYA6tOl538Lkxp?=
 =?us-ascii?Q?XfEjg/QhiFfSEt7poiRBeoKtrIBgMepC20dbpoARJlnXgXk38ZN+OmqDjutG?=
 =?us-ascii?Q?uUZ2kCsUbj+NuYJHkm7SlqIBb+pkpXB33JL+GIHkobtocGKalcQZmAuC6WFs?=
 =?us-ascii?Q?D8UKFEWl6QCKoNNqhaZeTfMy36XhPQXFou9H6neD+qbsNJ3BTj2DjceRA2MT?=
 =?us-ascii?Q?RtC6C6oYjWvvAqkd4Ys7Xv18UWxUoI05SIe3jbmlGvI2a4N+qefsHFELDlLi?=
 =?us-ascii?Q?TLchIuzwfHcgfsmiO1yTkmqRMdr0rePLFBHSwFJ26/ompUKibRUP+p6oJvEJ?=
 =?us-ascii?Q?d1kg+W7uiCO3Nfocr2mHONAhGhbR0ChYhuxYQE4JP0TPtGWxRSu3evf8EqEp?=
 =?us-ascii?Q?uktN9mpV5FRdmNRTIutL0SGODmaNPhfq8RoyAGYDI49pq9tPlOeHoXg+94TL?=
 =?us-ascii?Q?uwUp9kXvzuL20+2Ko1e+1rZ/+aPJzu84Vdp9AJztBeBnrbBuk9e2PKdsBQrM?=
 =?us-ascii?Q?pcDrFkoxuFZVLndzmrx5lfF88PcV2wNoXYE3BoY8zt9eN0RRxHktFWbLLU1o?=
 =?us-ascii?Q?6nYxdk0ZSCIJgKZ1erOW+Kcu6iMp0VjqaVKtHOBvDpK0czxTEblG9AF4fPvX?=
 =?us-ascii?Q?/8GALvWIDGgmURgoGVqTwZkKEi87IImLpDOsrIRWQJlJhxg5ISs6Cfvf5cNP?=
 =?us-ascii?Q?Cc3kh6RgqWq88l3Mk85S1XuBnZLjVCF9Aq9PrXPaN0nR1GlSmh9AULcWgPQu?=
 =?us-ascii?Q?1Svm/PwZp12FRgHXWbfQRS/u8bZ7QxP1bx4PVnwZrKV5pMuKVZ0wrOj6aYqu?=
 =?us-ascii?Q?GWzmISTlmrFWm07g7MFbH77ezr+q7SOx9t5QqFHCHSDydbKcMFwGiu+/fsuU?=
 =?us-ascii?Q?Kt7jeGOsq3YG6RaLCDVlfHi+egYgRtvGvqEBt6Hf7e0SehZNjz7grE5OfKJD?=
 =?us-ascii?Q?c26JcaXpH8OMKHsRmx+78UlV5p71Uz7sTwOL5tDtyVB44EmUkFOznPBOglj5?=
 =?us-ascii?Q?AkNS6RKKvuoo/bqUjMMjTeDoZ0e5iA8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8851d6-7052-477c-9cc9-08deac1ccd91
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:41:24.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZPzGByx7KePp/A1rRdTQTkk/1l42dUlh5MS21tk1DnSM/jY55NidFIkPobsS0qUKQ3W+Tjaq4ma9v/2O2CRCX7VNeYWD90Wy/Gx1i5oYvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0870
X-Rspamd-Queue-Id: 68BFD4E759F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285263-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.642];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid]
X-Rspamd-Action: no action

jhb100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The jhb100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

jhb100 GMAC still using designware GMAC core like JH7100 and JH7110,
and contains 2 SGMII interfaces, 1 RGMII/RMII interface, 1 RMII
interface. In JH7100/JH7110 dwmac-starfive.c have supported RGMII/RMII
interface. So require to add SGMII support to dwmac-starfive.c for JHB100.

SGMII serdes PHY has been integrated in JHB100 and do not have driver
setting.

In JHB100 EVB board, SGMII connect with motorcomm YT8531s external PHY
and support RJ45 ethernet port.

The patch base in 7.1-rc2

previous patch link:
v2: https://patchwork.kernel.org/project/netdevbpf/cover/20260417024523.107786-1-minda.chen@starfivetech.com/

changes
v3:
patch2: Add jhb100 attach to jh7110 compatibible, remove redundant commit
message. just descript the jhb100 hardware.
patch3: Add oneOf 5 clocks / 6 clocks to claim the clocks and make it
pass yaml test.
patch4: Add review tag and unused tag to phy interface.

v2:
1. patch1 Add the remove reason
2. patch2 rename rx clock to sgmii_rx
3. patch4 confirm sgmii rx clock exist, or will probe error
   sgmii will not call starfive_dwmac_set_mode() 


Minda Chen (5):
  dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
  dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
  dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 sgmii rx clk
  net: stmmac: starfive: Add jhb100 SGMII interface
  net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag

 .../bindings/net/starfive,jh7110-dwmac.yaml   | 67 ++++++++++++++-----
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 59 ++++++++++++----
 2 files changed, 96 insertions(+), 30 deletions(-)


base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
-- 
2.17.1


