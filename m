Return-Path: <netdev+bounces-285747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNHbHNi0/WkXhwAAu9opvQ
	(envelope-from <netdev+bounces-285747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A50F4F4B17
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B67A73026375
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA323C9EF6;
	Fri,  8 May 2026 10:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751023BED74;
	Fri,  8 May 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234465; cv=fail; b=jlO40FkF7tK2JoIdrWoVfB3BXlTjJdMCz3EAgKmZnFE1PbsXmFRLnVNOvJoP3P7CcGTqx4o6gbpZjbDgkDl3xAui0n0Dp4zbY10ydkuLr1JlCsXoq0QKwyAtaKM4F2GJ8ZouvT8oYFU+s+//VH30ala9Lz96Wk/3LTIY/yM5Bsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234465; c=relaxed/simple;
	bh=W0uT+uF8V6N7ZHTNbD9mMmbOaitdPsZj/jRSB+ylGF8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HtbKnJSO9jfwB1/WTldN5bl8z7TtZjJYwJ+ARWRoBQOGGx9+xceBFWxUkgOf+B8/vpMvOX3J60ueQSUuyjI0JSlxSiusGRSN5JYxOVXyY5V4Z+hDhtiTYtaEEWcgCYwULKv5D6HDCp1VjV7d78uUki10p9wt8pH1WLfRViN0BFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmXBR1fdVi+uFG1RMR6H0vZwCQtXToTcdzbAPZeth8H6o409S5eOhJHVL9eqyoRi3S3010YM4xc/soAmlRxjr7Jl8uFK+qWm0IiccP6RjcFoArgFu0Iits5tz7PITXiREwbZkC6Pi8gzUWPba9EFvhEdN/XGeCKnDO57Ieecet/eL/x3C+LRyw7J4Ug37D+ftL7clU/oOm9LiKWJ3XlI1sJwY8wcaZOWwhmgtWCxmRoF2RGyWoPBZPp+Eg0ssSuS+Jpbm41wmSa7cx7zEqrS6Q0+3cACGL+q6VXcx2zNYlTapjNka6yJm37NZZPEN+lUhdT8jnM1ZjP4jM/mDhsbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QBrYpL3C5ioDYZIyTJpLKT2M9NiIPlPUvTC4DkQE+Y=;
 b=bE0MvUNfbuHpjPjSzNIgWbmB/o1JDRj4B62EAkLKRdtekgA4Vo88NbsWa9aSlO1hq3KmW5nVeEANGgTT9yi9D0kKPJnxJfHOURLkDynD1aaIN52S9H3enH9wtoZbA+iwJiqWSSUYKAhNZGXiyuVOtIxxSVU88pLfqkN/8hSc5sKgCsgCpkZUO+OZxJN/YnGWPZxU8uWcKCjyC5KbFmrlp3qXLttJk2G4+1y+VpgJlzT29HRNScAG7rs24QROJ4J2bsFlfnru8Vv9epjubtN2lczCUXss8Q0p0jI1pE5B3XSnphfAnIRoOdUS7ji0oFy6ZiyZ9yQlIgp5d8qHycrQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0696.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 8 May
 2026 09:45:31 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Fri, 8 May 2026 09:45:31 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Fri,  8 May 2026 17:45:19 +0800
Message-Id: <20260508094522.3952-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (10.43.109.83) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0696:EE_
X-MS-Office365-Filtering-Correlation-Id: d37282e9-e32c-49b4-cae9-08deace68b20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 bhSi/MgOXalzQdL7jo9FIS0YXrmKcxaSiqnwMWV1+CsK1s22/UQnd0cRSWtVyG/2xPFJk1Hm44ao65Dity/BRK1Pfv1FYb4AIQjjlCv2L0NFgig6h9CLp19jiIJQAGXaUVrXJ6zvt92metifi/e9gQzMaHf+70WKLJfhVlTyPjMHmLLDEg/NmLrcAie4/Nq0Sx/qWgNC4YIFe4//z/a+1PUld9FZUNOvV24LnCzXjnncEbRl/AeG/6xamRelWnS8uBvivWtMvDhKLHRR9PRxLCyuFckwBFVJDvre3YqrTLHRYbY8xDj7uINZJ2Sz/XczCB1QPsrOmy45zGSqnYFAat0Brwe3L+sSMfjIrXXiKlx8tDHbBAybnCI8JF+kpZJPuPg5HZtRtgj3T5MkP6yr2i7hMyl07jJRAKhWr3eL+Ge9+tLbPCS0BJkynks1llmbb4q1iA9JEbyUZ+gw3idGd9pktVUHIid4yX2/bvdkIcPnf20FW2Hwr0vhq5c7WchnUBLBYT8w1kn+wJglP6LPe+JPqqWDeWSs072U5K26pf6/n8XKiuNY/1ewxNTEvADC
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8VbobIEKpshkA5FcDmryLX8okiHAMQ53Ibq6iB1/LIPpExgQY7LqeVuP/KC0?=
 =?us-ascii?Q?dKGUlbzpob94diQxQhrtWG6fx+CtxDJZ8m5g1FRFjtqxbS32bBU1PWflYJqe?=
 =?us-ascii?Q?qQWHY1w3qlewBfyIKDhM0dA4Zuxv8E8i4ZNsGoFHlDcflw1aJmxMRnRGs8RG?=
 =?us-ascii?Q?e14WSez0J/jPyto8Tm+UU02qPR9h9n7V9c3zxOLAh4/5012eaxeozjzMAHVH?=
 =?us-ascii?Q?qF1fZstBXo9lWj6FMiQj2HlS5iy0YISYsEVBMZ7AtFDzqrKjPN06IETmYZPl?=
 =?us-ascii?Q?a58Oe0+dT/CN+SPeWn9U1C5URaLvxt/sUyToGcH44WdGV7ImG6QaFre07QzN?=
 =?us-ascii?Q?3MSoQExPEu9GqkMJbMjOAGNEhSqgHsTdZLbvk4YwUJq8DmqSltzsgVI7hBxZ?=
 =?us-ascii?Q?G3nc5Iyt05lE7dyemF5LiP/Z4JmEf2DTB1G98kLL9u0MeUpib6CO7T74Yq1b?=
 =?us-ascii?Q?PhsA9Jq/prIVWiMvcaysXwTMJR1f7nMMHOyq4ZUj/+yQsI79IVClSPwoDNGz?=
 =?us-ascii?Q?ie/vYg20MEf6JU1ktdzE6okjXEJEDzxbqHJkoauWukdU+WlTyWSze7+U6ZdJ?=
 =?us-ascii?Q?w3607u6qZcsYs6AU6uPUi1wDsFb+kuCCHjmdfmN13KNH6BToHIy7NonDxqlY?=
 =?us-ascii?Q?I0UPvxT9SMVOEHj/v4GZV3y/t+6NPx+EyrqD3/ylBJ7bUsJSB83SRwH+ixp/?=
 =?us-ascii?Q?scyHL+8nh3pga8IY8/BtG9IRbqrLnCRGqIUYJMZdzBSeGqc935HxRG6saiNO?=
 =?us-ascii?Q?HBRUvVO40oT1nOF78d7OCL0zycGnbcw18rEH3Ix7zh+DCy8J1nY7lTBVVg/i?=
 =?us-ascii?Q?elNB15zzKNu1cuksGFN9LLc8LfGLyykiRxik3GK4heTISwjIs/L81EdST1nr?=
 =?us-ascii?Q?79ty8OeZleV471dvyvUxhX+x0+wg69oHu2XoTkj9JUGBbEqCshYHez/mJ0BB?=
 =?us-ascii?Q?hQyB/KVq4cy4TnX1l5+7D3njvg29vaDiU65XiTK/+elRWvgRjFRJxBkpkmZV?=
 =?us-ascii?Q?lL6O6emtjqJc3H51FaxlgKNGmZ6Sgdbsae5Fu/1ASy7OQOD1W3tRRF5bcg+x?=
 =?us-ascii?Q?hFUPGJ82yTqCF2e2F5BL41JS2T6l51cFiNcrjRB7v0Q+VK1gvq3+7XuFsOMH?=
 =?us-ascii?Q?KVbm9/cTYwSu41nP1qAVF33aaCna3d8RRXnB5yqpS0Zdp3e6MA8UomJ/f3+P?=
 =?us-ascii?Q?UEwT4JX7kf98IuRhNw+xxViR6xzOAnj5+eTSfMzENgQ1FaF+zygnhGzGpEz1?=
 =?us-ascii?Q?CWw/BoUqf+tKHaUYwFHlayGMMRkwF/DulnPOe5SYvtavyRsTkz7amVajNoVq?=
 =?us-ascii?Q?Fq/jpB3thwN0XyGiTrw3TfJMCdM+5ZmGEwV7lj1DUyFOa4z9XLVxSWq4mpcc?=
 =?us-ascii?Q?efwuywEsJ7YYQ3xNxbfjeBB6YglhZmJv/yjrFolbIMdysR8E3rjI7On/oqnQ?=
 =?us-ascii?Q?TzUpeAZLJPUjJI4gJ72rRMTfz0Tkn90/fFC30Pd4jpQDQPHeyjgN5EFG43/+?=
 =?us-ascii?Q?Xpp4E03fL41QJ8eo7y2Em2Yo9SwZMDsemXDXaO59WEiS5cr4qmATmuG28iXS?=
 =?us-ascii?Q?29kZVPt7RKOM1wuFHBnNWoAxWmfxNNd6zF+fHc0ky0n2SdnQnBQDCIGxFVzR?=
 =?us-ascii?Q?Ida21pYame8zs7TiZJeeBiZDqNDNOvxQ01qzM4jxwUYxmONUuYfQ4RjdPbk2?=
 =?us-ascii?Q?miGIWIHRCAUgtvld5phyXNkd2pVktDBdCC9glmkTu1G98lU19DOXAy3WTs3I?=
 =?us-ascii?Q?Wk2UKyGDjmxdFK2HN3C035NtfcVA6y8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37282e9-e32c-49b4-cae9-08deace68b20
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:45:31.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/ln9EZMj7K9/bTF0vYFvt78uMImfvPkiAUlrXyYGPBRAJheBDvADuwBaPO/Nhw1FxpIIVu3KR2sKjg4RW7X+J8lR61+/debe9BfTADmV4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0696
X-Rspamd-Queue-Id: 7A50F4F4B17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-285747-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.719];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch is for Starfive JHB100 EVB board. JHB100  contain
1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
interface connect with YT8531s Ethernet PHY. RMII interface connect
with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
patch 3 is RMII is for RMII interface.

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

The patch base net-next (base commit list below)

previous commit
v1: https://patchwork.kernel.org/project/netdevbpf/cover/20260415092654.64907-1-minda.chen@starfivetech.com/
v2:https://patchwork.kernel.org/project/netdevbpf/cover/20260422083255.29692-1-minda.chen@starfivetech.com/

The change list:
v3:
1. change some commit message.
v2:
1. patch1 move mdio lock out from  yt8531_set_ds().
2. patch2 changed to phy_interface_is_rgmii().

Minda Chen (3):
  net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
  net: motorcomm: phy: set drive strength in YT8531s RGMII
  net: phy: motorcomm: Add YT8522 100M RMII PHY support

 drivers/net/phy/motorcomm.c | 77 ++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)


base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
-- 
2.17.1


