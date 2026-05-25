Return-Path: <netdev+bounces-291240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dRvXA2HpE2qoHQcAu9opvQ
	(envelope-from <netdev+bounces-291240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:17:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BA5C643D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A3563000B98
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE11E0DD8;
	Mon, 25 May 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pVv3rvWo"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD915405E7;
	Mon, 25 May 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689820; cv=fail; b=CMPd6FQXCZQVCbEQHGLnaqZjeG1Ga2zw+i+qFlWu0XWAsf+GelfaN+mBOUlqc5TXQGCc06ap7K1UrU8qAquyj05Dj5RAEp1TJgnlIKRoCe5NtfX0qywaOwSHdMSx/pHW7587Dv4MAWGrS4lW0puaf8udvXYijz24ZGz1EJhd/T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689820; c=relaxed/simple;
	bh=BfX0gyBVC86I4KG9VA6LCRV2b6KgEsdHV4tKi9H+11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i1hruWnsknRXjl890KYgFd56RkIovP7xUOtDUdRCw7iyr7UCO1LFNic84kuvUQVrP3kRSTshRkVr9ur9Od+j5estjLkTNlQh8U20G/K2Le029tQNVy7ViFNK/DtRPW+VQLOHW/5gWr2E+OJoz4T+4+7tH0WbkMiSYLyH8m09KG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pVv3rvWo; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrY/CqU1XdsJphoEZjRNlNGbFKD9luhV2l48MukYu+EMRHRrN+lytCaxzgY9xAy7TZq+BbhHZV37AI0dEzVJp7lX9JuH+VpQJmeZ/s4ud7uV5jP2dRcJJpipMezGQY0z6dsxQJptCXIxaG5uM5uV07VSCgJ4kN2bhbJGc8ktSrFT77wB9KrQ2Zt0ydAsSzVSU3Gaq+2yNXwQ+djQA8v6AI5kCPOTFZUGSLYdpcZyA8Q0SBSjvxl0O8dvPU0KJYLNv7NDo2R1Xph0ImrLiEV+hW9DAmU1Dds0pDu6OVJ5ZconAdo636PW+mS3hUMITtlMvAJYEd6H2JC3K1NKFnEW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPYOByuvTPG2+cNqGP4MwRHgirvm7Gjf/E3R0XCXxMI=;
 b=YyU4/fkzIfLpb3Bc9copuD3V8vbw4UijwSBBGHivdMYEYc2WORf7QjO3UMt02W2ZzNXQxmiz9Yp1nq8NwFZxlJaojXkJxfIHVfzY9K0owTVgKL9qPoCbGkgbs2qi5tYhE0MBRcB/yqhz8jd/QNKSqcW7LWCSnCsc/bH9ujQKN15Hr6sKJsXvX//sbYGUk72yN2YZqe87xGTsTZsYvn1HeMJ2D6qHGcQYWITwP8RI96GW3O29YgHQqFGqZAowtF8cqIaaHvmdQQZ1inSEIy45kNMmjNefNW2eDQFDMQcVlOFGsKgL8crmZHeywIeUmYjZD/fahz6BhKKb4r4o+03w1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPYOByuvTPG2+cNqGP4MwRHgirvm7Gjf/E3R0XCXxMI=;
 b=pVv3rvWoLLxJbD0rTJUHVPAfJmPyMwnPaON4w8+kvLw5gOq/H+u9fmGtb07iSSAjmcVie6yRPxwpw0YoIiHAwKMesdrAfNYMwJ+kotQDvWfDJ2L55x0A+I5tlpYwZmPqZkk3OrA2x7UcP+MP9hUVln1rA0kaktV8apPXwqpQcBSDUpH207mVqB0Q6YO/NfTGwiRbFFDW5alB16oHLES4Lypw0Ljs2SSARGgv/wnpoRBDsY0YqdJsbDS2OLsSb88NzobS7dLMA57NFO3CVM8926qImksynhraMg9UPAs3SLirRjlc7vdSkRMzdiFNmdlBBXf1t8cc43BnydX/xWlNvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5177.namprd03.prod.outlook.com (2603:10b6:5:22b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:16:55 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:16:55 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Improve Tx timer arm logic further
Date: Sun, 24 May 2026 23:16:53 -0700
Message-ID: <20260525061653.22548-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b622ef4-ae29-4003-03ba-08deba253829
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+KzQIR9TbAmeL4TqYLfwwGYYzZeUXE0pzSHg3vDGyPO0UnHOE4Fk8L+z9+WHLe1gDGkjr4OdkoN6vLsIrks/ot1sVXtKo6joK6HnHQi4dx9s0B4wcTxHSmbxTQk2KzQjJDjVH65Q0FnlU4O/KwEc3FukCDaCzVnOltXTulYQgk2/WiPxVVH95ujH0WdJa4lVn2fhmjvzM23v5qKlAsiUpaIF+R+jDBn/on/JpAx5+v2Uudtna55jSppfSk/Lxayyyd74Dw8b1I1tcHhPezJ1+9AZYCv0uUwqd1m41R9xgsgPgXBNwNaGBe6+/KKwlSThl9XkBpwstdhetAi5kmHPGJwSovAjHY0f4aCfKh5S+41v2nht6/OkGYKSEEA086gTlHQFpjX4BxfM/sZMFs2I6Y3zEaMM+F/xZ9Wm3dY46IpdDXiyXrJbLlH4FYS6POWv9rDq/btb5uRRi0ozKTMmU+sqIdh98KkXP3tu+tU9VqBhGI+N6Xi1yqo9JGsePdLoE/WBJGmj2RGL6S9Yf5MA0NoLq+KBrOM6KJiPduWpJXjCbcBAtrLpKUEvqCNtd9ISWGEEgraDY8Fe96ZyyQzJnulwVic/iXaoBoKo6TYTmsEC/kDfYx9urzRYKbDCpglg+vG2CVY1PTW71UfuOGi5Av72gwo34Y+CiX9we3io+Zk+tcT7MexXe9FjFDlmLs2p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ym/lamggAuIEqwEZlRKBpid02yyNIVt9aiDzPBGqc2aWZKK9OSa7KBuP4r0C?=
 =?us-ascii?Q?RteVnF7SwggR1KnDiQ4zSu634JJzc69Z1ZAVGSJNGVZMLg4slCCS7MyrPTOL?=
 =?us-ascii?Q?3r6rlnVIydFGBmlhRXd1uFF2ow7mD8P1a8P0E9QGtgUygq4r0jsvaGi+zO4c?=
 =?us-ascii?Q?VPNYdJngluWn5iBaFn7o9o3CO4141D06EG3wE/n/JvFJw9l1sjgromyCFsSu?=
 =?us-ascii?Q?JEryJZu7fGRR0Qzmxg9Cyys6nbBNrqUmYc0msvu2EO9vpccEqWsB8/SwsQaQ?=
 =?us-ascii?Q?XANf2fJj+yZlMkOc5Oveucciy5I7BBPynPCrWhVdm0QVyJrAaZpoeF1Dy0PZ?=
 =?us-ascii?Q?7XNmn+xqOyY+c58OnYdUkNB878y3hKD6Evml3tXAotvIrIeQLadBnvz7g7qm?=
 =?us-ascii?Q?mIO7zinezcL7hDjoxREjLMya7YFSJgreSvjhWGm1bYPokYho0evh1HGZzx1h?=
 =?us-ascii?Q?vHATMLsv7jUYJ5TifQwQS+8Xvy4RWn+x1dv+E0GgthTYnwFKuWitM0wa8SqT?=
 =?us-ascii?Q?vYYCtTMlXDMwd5owVK1x2ISiVJx1WvCMZpHck23zWtBOmdz/Lqd1QoHY/spY?=
 =?us-ascii?Q?ytuVZwMzpdHcaS1p0uPM4bZyn3mZd2KaM0DP03QbWug4i05wT/Dd8gCRavZD?=
 =?us-ascii?Q?08u1OJ2rsa9F2mHri03g40AKkMloFHZ0ZFSJQkg0a4YV5tCeu0qFL8is0OVl?=
 =?us-ascii?Q?ArF+FGkiWP+LZEH2xaMv9753J79ItcZoC9SwdUPIdDNMUVUb7k6qhhaH1rus?=
 =?us-ascii?Q?2vlNeY0MaVO9e/SKnQ0eWP8w6ySOD5OzoXo9nWaM9uW8zdCJGRek4sXSfM2q?=
 =?us-ascii?Q?sxUSnQY7odbzvkn9TCQP1a+6/t9kDdhpkQOgOCV1Mj/eZ09Jm0KrjZVc7xUC?=
 =?us-ascii?Q?YvX6wQuCHo6BjmC5sYEe9BOhMy8pALV6yKikZ6ZcphvT1QvZ7t/huM1/sPPd?=
 =?us-ascii?Q?DZdq+R1ALQWaefTnLmT3d4FlGaOad0kWxCiuvVn2KxJagKIKnuu7Wp30ueKL?=
 =?us-ascii?Q?Oc8YOjCoaNsYsPr/YvW5FmIzHDzTIF/NLSI+jbptQe0jJ632XACJTitFZjGu?=
 =?us-ascii?Q?ud76ymZh98Z7C7KWZD6fZefD7ssnEv2U7PI7DKDohhLoZKdvcklMcr/etvhZ?=
 =?us-ascii?Q?VLXn3t4gcyhO9LkOGzS1xjU6MfzC7cG3ekPNdmoCxkAeaFSOcXwD3C38bto7?=
 =?us-ascii?Q?SEt4Rhhl/g6UpS0hq461fWPTqZrcjrfGL0OlErZOkVW6c7fHdudFzMK2VxA2?=
 =?us-ascii?Q?CWl6cscYijfJbp/Auve0Tqn44ekzztIdkNkJlFGFgSp8Cv+9GxnldoQAqUEp?=
 =?us-ascii?Q?cmfrI/GJhzUFuIM3xtnA7ktewdBFtUHsprg8vdh0YnX/rphki3sPjxop4I+w?=
 =?us-ascii?Q?EoaD7S1pgJ5J1onJMolntlDAZKqxFyuTMtso7AjcqWuHshBQQoJF86SS3yzV?=
 =?us-ascii?Q?+A7gOvmfoM1yegAB2QSP06KDS59RSMvpCzfx3XYVViEyR5P7gnYm1+y97L24?=
 =?us-ascii?Q?4/Y5dCrU/rnEjstixFREjV3HkRD6cRzcuconJv74sh+qR/AjlDiRkg1vr7cn?=
 =?us-ascii?Q?+0YGZ9rw4ki6H1J8jJmFCSqsKe8chjsFeAaUHIyw5ZaVoNtBSuERTizm9obz?=
 =?us-ascii?Q?KCU9yXUaOiiq5r7yY0NWQglDg43Y3mn7X2qvavLo9mBUafgCqDIxEUoXK0Bb?=
 =?us-ascii?Q?eIOJSWq0hhQvGv/v9CqkugpBXDQvIGCZpSMWPHjYgVPLe5KrC4vfdNjH0TGu?=
 =?us-ascii?Q?4J5FVSZBCF60tTE1H76TfZeWkswz4nikC7o9klzZXrSU/uScTRqbs0TzsTsa?=
X-MS-Exchange-AntiSpam-MessageData-1: yJDdzOjMEasyBg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b622ef4-ae29-4003-03ba-08deba253829
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:16:55.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZQcPjxDcnZp8i7Y6xsI3X22mB+WKeWpf6eC3VigADi17ohCbMHAUPvTkon3KPO8J/NGSZ9wMR5gJ7Y1h1WXgjFGxd4v/0DzryEbF81R0csKuzK+ZTvv3IFr85qO2PZkCw9iAAxOUI04grNYEqSkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5177
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Queue-Id: 0C3BA5C643D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Currently hrtimer_start is called even if hrtimer is
active. This is unnecessary and expensive in some targets.
This patch avoids calling hrtimer_start unnecessarily.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..35da51c26248 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3341,12 +3341,14 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 	 * Try to cancel any timer if napi is scheduled, timer will be armed
 	 * again in the next scheduled napi.
 	 */
-	if (unlikely(!napi_is_scheduled(napi)))
-		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(tx_coal_timer),
-			      HRTIMER_MODE_REL);
-	else
+	if (unlikely(!napi_is_scheduled(napi))) {
+		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
+			hrtimer_start(&tx_q->txtimer,
+				      STMMAC_COAL_TIMER(tx_coal_timer),
+				      HRTIMER_MODE_REL);
+	} else {
 		hrtimer_try_to_cancel(&tx_q->txtimer);
+	}
 }
 
 /**
-- 
2.43.7


