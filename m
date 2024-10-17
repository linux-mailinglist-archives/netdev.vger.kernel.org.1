Return-Path: <netdev+bounces-136700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03E9A2B34
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C348283AA4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243021DFE30;
	Thu, 17 Oct 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="kYFcfArw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD11DFD9D;
	Thu, 17 Oct 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186921; cv=fail; b=ZJthyUK+rL60iOVUwh9QDfoEhe4jEwwhMf0tQfBn68m+dhgU7lI3a/NVXBpj4CH3rHGWe3kSLbM/yrPs+IyKr7tnIuot5GIG0OJuD40gfWqRr1Fl9WDZVNbJeAC3B3I/tHuPq2CrxGaQ4lA/jekJ1JPJMp1nGAkJ+pEmsHp/USI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186921; c=relaxed/simple;
	bh=Mqa3oRJvEYi4Z1BGXH+qlE37o8GuUaS5ggwk2PhoT0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrCLR48ivgehzXGvywc+kjvzn3lDvFo3+7IuqLfx1rnmP5SOVE1FxfqzaFZ2ut50HBvle0P6J6phvG4Hy6PYROhqzNKGZuG9jnXPZv4V1Voge/3y3Tda/ToGRhDZPNcGTRLNKVD+5m/bnC2gEme+B9WJUirSnkrvHX3fIP0q/GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=kYFcfArw; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1+8Kvog6kuRxbNvDLA5m2ajXFYXRkoQobdYZM9N2B2td62eg+p3KhUEDnSkG5aJdCttZLdMy/DaoPBtPHuCcAaEHGqHcAFCHsBnPxFbRvCkVMqYHVjLO+HMurKMfO7GafRux+BOwhq1DJ31y9Qui2+vvqKLyp4sje0FtfY7UDcefUgvCgjuzbVLiHXl8SP62GYWZjdtYLKoUFxvcEI9qX7jHtCUalYW8+Agga/7TIfiyT1u5YuWy7eQbWjQT1HqlziilCpKZTANcOfOs/7F/QA2nLGOwoBFeONIAZdVzapxF8WAfpohYOVag60uMkXx6wfiqOGB3Xxw7I4RJIHkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY1mh5l4i+G90c3YH0eEWk+Coa26tbSZkxfW6YbD+Fg=;
 b=mi+/7qUuYsAKKJS0t3Skpj8L4wKPazDN5SGSe1nOyci+KOC2cTJZ9BWV8r6FN8Wz2pka5/L018GLXehupJdT6f4rDn1BC32bcyGphl7iogq5qIvSNee+A6a41gsmiNN1CBnzpL5bZtnF2ovnNQpDrMUJdXQ3T91lA3ScAu5Htzo2bXk1GwMwJNlU9PXNYT5oz54vVLZOJ+Rhjnfa8Zb5onxiAayzStd58egKbu3jI0NkmhKYki4apkJZ/jOOKL+8OR/LBmccO/JuP9jS7a8ZYejo4o+kyOs+eNXbjIAaxF2Psufc2JKlcp9OJmPs7b5RAOmLpIpLN9sEWlHLO8QYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY1mh5l4i+G90c3YH0eEWk+Coa26tbSZkxfW6YbD+Fg=;
 b=kYFcfArw5f/ooqcBp0Nww2X7bC+xCRMcA1gWs4bVPDQjbWHZvrIvB0afJmz/Pbf+GNwazN6reThl4p5a39HI01rcBtjq1wuz23xU8oRYmFTIF6e/FMk6CtbDV+8IqZrad+TNoX7YPbh5gRXAhea7WS6+CXpqiyiDQr/2Pjy+mfDG4pf8X8HposwPvqJC+jUDT3LoimFLQr/YYynLtMC9cJQJWUFRWI//R7iIa7g4mLCqkwjp2h49OUWmAIqqKgSUci5YoWK53L0ILvPIyGRQQwMSARYTaSWFejP+TnScr+QKX0Vxeh6jr1lPaE796c8YIzDveeA59IEIwNJUi3ptTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:41:42 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:41:42 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 01/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
Date: Thu, 17 Oct 2024 19:37:43 +0200
Message-ID: <20241017174109.85717-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9c1092-b5e1-4acd-f164-08dceed2f620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0V8IgfIG4Nr15OZNrxOSWfTmo6IWzw8TRHooFoaJiO44r0X2vX17Aiz3p3jp?=
 =?us-ascii?Q?Wf9mrv3ZlBppKPYcPQdrjY6l0r2e4EmbFbim8I8li6bP9eF0H2F1pplMRXBF?=
 =?us-ascii?Q?OLNAiRJr1PqrBrJS78Tctz7gOLRgr3OqJ8gQlVWgFPMzkKtULb8F981/CzFp?=
 =?us-ascii?Q?GNvgLqSMwRfQg0oYpl2ZxF6OZLvy71GiE17VsZ5OumCH9BZI7WKIubjnaOfx?=
 =?us-ascii?Q?iLAiN8W0MDn/QbtmrZXHhaiLLVvu19/rq9Hcxg4+CRYlGs+P39HbNzzFq6nw?=
 =?us-ascii?Q?JZxcuaqpa3X8wZEaYi0iafCnlIvHJRczhvBO6M1y+60Gecrs8o+dC2+5xfSP?=
 =?us-ascii?Q?yypAh/9yyhOri59MyaWF3swAz+dsGLZny56vigq47bbe5+AKU2rupJuQxPvL?=
 =?us-ascii?Q?D1TzfxM/zK3dEm6NWn51TA0Ngb40J+rgO3EgND48HwoIAM3WT/NKD5wj7IwZ?=
 =?us-ascii?Q?7zjALJEMRfyL1AGGfwn/bLL6sGdr6l1+Gr4A6PpWJPnC6E3DxUihz+FXRSQV?=
 =?us-ascii?Q?MHVKbVSz5cR8qYuH8br1fG+pWVZX3gYqAEH8D10Zj9PRZsj9AqL/ab1Y4q1t?=
 =?us-ascii?Q?abqAD0peRF+EO2Ua5ZOckF/4qiUNADx5fMZPXVu5Hk3G8nU7rZBH0hC+fRta?=
 =?us-ascii?Q?CHULKBOU3Jg1aXhg0TnrC7iArCnCabp4k2tyfgy1rD4wt9wzSRXVA7IehoME?=
 =?us-ascii?Q?LM0yefrsILWeSiLObpoI7JEehL7Bc/MUBn9amVOwxC7YNOxj2sEOCMl4tOg+?=
 =?us-ascii?Q?ZdMT2+T/ZH1vB9Pjn2FDSpS8tT3nZXDMfp3X8C2fTnBa1kpl5mP45N2jFjEM?=
 =?us-ascii?Q?jH01GI5E68kveubyqsTzMBlRX8F3Brg61ZxUKbNnVXdDImvmHHNvXECVhvXT?=
 =?us-ascii?Q?b4kyW3I4zq2hTB0CQp7VsgOBhOtTer70lTNuO4oJFx6B69Fhdc3fL3mz/fVP?=
 =?us-ascii?Q?ZNsmcWt023xrQjjf2UM5O9Hsos3lB4TIHfyedj6GbHDtKBdGLYLYt2WwGLqL?=
 =?us-ascii?Q?+sPC7xLD+b3jrrbnOTb+rSV2EnWdrOLOs1l4r/PRvbuzA2WPT4QXjZ4lRauN?=
 =?us-ascii?Q?hKC2ei2HEcUUit5rNbBzuHQsxCjxhqLVyFkSo/zbuZT83iW+vLHxKVcQUGgg?=
 =?us-ascii?Q?hbYFXwAn5DvZG2Mq3L/iEyjKQYEkFFn0QkkC087ATO/qYTsqXsIMTkbeE/Bp?=
 =?us-ascii?Q?561R6bLW5qfag4uS43YkUwi76IUV25XafKIGZ2BzN/12EqoMMQB6DEpNaxBt?=
 =?us-ascii?Q?eZF0iuTV9ILsws/bLVbeIe5n5XUNUM3+HtaPAbjST+oByUi29oQj8O6Vw021?=
 =?us-ascii?Q?LGE1S842UxdOsXkjl7x6wwc/hlt+bo85qQnpR3ZLD96wG+9Q09br5ZBX/wnu?=
 =?us-ascii?Q?Ckk4WE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjM3xnFyaqUXpWZmmpLzzpj5T0XBXSuhEQHGk0mHW9cYtmxv3u/sqRBMIyEW?=
 =?us-ascii?Q?VPom1SLOS2v+0uIl/ATuF/ANcxO0zGSFJVdzaH5meanms9+iszqibIkedA+O?=
 =?us-ascii?Q?ZDKoycTkz/MCqBa4zSmGd4ao2dcjcyODYWilpRJY1OgGQy3aS243YzVdMueI?=
 =?us-ascii?Q?KZneYRyPPZwuqf2NIm1xtUxemfsKaBfMdQmNuojJ2gHlngY1eTZ7CvUKN/ha?=
 =?us-ascii?Q?yZUk13jvDPIxWIn6eCjyyuPu8Q/Nc6V27qEZwenT7wnvjUCe3F7WdXVlImaD?=
 =?us-ascii?Q?ILcUKpOjj36GqKax4GkDqiw3dmJ5NvgWO6CLxUwzNcgycsYHl8bFUx6uBSXE?=
 =?us-ascii?Q?i3hTYxSd9sA70b2jVcl4yNrbYxXTn2myeu4J2MM3rNFYkU0PrgDwmDCtjwnz?=
 =?us-ascii?Q?R0d0gxc0MVrrkGLOyRI9Mo5FWWrlo60ZTkQAQGeIbzrUc9Oq5Z5BBbcfKCmM?=
 =?us-ascii?Q?e/XShnWEywz9EJnwi9EurNkYeCowGy076ahBNG7x0mcCXsvgN5UBr8AgL8nt?=
 =?us-ascii?Q?VEpeNLbHoV6+yhrgP1NZv9Cak5tR+PYvnOWExFNlduYC/YVv4l4xb40VLFNe?=
 =?us-ascii?Q?5kDYL15XyREYylQT1xyXmdtaZD3ryUov7KOV80QNeTbjIf6W6h/jlJfcW61I?=
 =?us-ascii?Q?8YavdJi2bnWDoFOmbVTa8mozgvwnuYInArRhRoXNWWiwJvx4Fmf3zXhFlqr1?=
 =?us-ascii?Q?yiInFxf9uiFU3nm5O+kZ45KaDHkQ0EiLVEva259Xry8oB/mctG6oaEm9KBs4?=
 =?us-ascii?Q?Y1PuC8qqF9id83+YRYg7DpGFxAYQdL/PMh0skL5x8kXNA6F+2/AHcLnbc+IW?=
 =?us-ascii?Q?xTP6MB1B6ap+mvq1PVdCb3mxdITb9bVoJ9cbNQWQ4SjcMruz1MYLLKfBftFW?=
 =?us-ascii?Q?T5h6pqP0zJdE4pRv1QUQJiWtzFMU3DtHn07XQuJZiwHIqRJsbHyNajn7fC/M?=
 =?us-ascii?Q?8TnG1D3ImhmsqklTZgkNEyxQRb5kt36gxvdBJkOsE0qLajyP2cHkQ6exHua0?=
 =?us-ascii?Q?f2DeipHgYV331d2mE0M9neUs9SKpZBxLFg2fh9bQvMXIyxoXEa1jYbKhH0Bg?=
 =?us-ascii?Q?igf5GNu6qEryNqzNgMy1RC+aeu8yT86g8HR1vTZ/nNeNFTm4e+F4YkaT0ugp?=
 =?us-ascii?Q?acKSaoNznPZJFlLg5IOC9BfkH1NuaK8YqH8KYiHeFRU/Rl6HpinMssanovXm?=
 =?us-ascii?Q?J1FEizqVd9porKgmvVuGdk0KFFt0pK2zFAHBBISb8DQeT852iBcSwJvJE6el?=
 =?us-ascii?Q?12q33yO9TRuhuVbb0nmusIinKc4h/oy3gvfSiCsIunQntac2GbRx31T5lW08?=
 =?us-ascii?Q?YYDLG4kpxPLGgSlnx3Hx9a9SDXOBydjCQ1QDHm8esFum3x4mwfG/pQTIq/oI?=
 =?us-ascii?Q?Osk7rmHUtLjbpov7H4hxkKUMDZMq3Q1OrjyriX792vZIUcBcz3LrsPNL3Nce?=
 =?us-ascii?Q?Qk9W8GyW+z9kvINh8iUiYaZAKQX4/LJfj8hs3ifTep+FynbgFsW+KE/cfSR9?=
 =?us-ascii?Q?PcHoz8jPWE9LhfVXJ4/gbfKWX/tzPyGtYfQSNu+Qeo5A8Y5/z685L0rapuCl?=
 =?us-ascii?Q?EqvL5k94xDvTBou3EBUjHDBPhC5HXyR6YviH13PWR0kLnfWOAHtll9TkfFBI?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9c1092-b5e1-4acd-f164-08dceed2f620
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:42.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4fHHyNBQChuCHrxHHdqTraVKRiBU+tKN00Wye4tSto+/pBVyD7/DGGM20wjBNBvmWtbT6/nKjzycytdKX0kZNlBjejZYL5u/e/u/pEKmIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

In case ip6mr_vif_seq_start() fails with an error (currently not
possible, as RT6_TABLE_DFLT always exists, ip6mr_get_table() cannot fail
in this case), ip6mr_vif_seq_stop() would be called and release the RCU
lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 76db80a7124c..3acc4c8a226d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,13 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
-- 
2.42.0


