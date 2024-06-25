Return-Path: <netdev+bounces-106629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDB91709A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B681F22A40
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514017C235;
	Tue, 25 Jun 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="urg/lgtG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB9176AC3;
	Tue, 25 Jun 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341629; cv=fail; b=ITEvarWqen4iH8m3nXCJcTTDS6OHQEICNOaN2u2IXQk0BeMiYsWTcZJmcNkesnmNs6wg+uIqHdaSvRmKgGITfWOx4wKMWXObCwVbm+Vah+wPBMMe32SOk1KiepvA24wWIj4zg6Z733U86hM6ZdcCJvdS/99J9+wxBascdJX9DYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341629; c=relaxed/simple;
	bh=rJ0Ah0+yaRkW9V/R5FoRNEmao8+hzSMKL+9ewvam5kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1HfKr2I3t1dbG0sJRv7jokkJR5TxlhlvOSuKVwFDfucoL9d7sy6CvZseK8fkw8hfo9N8E0YoDovA7qGvz/MR6EMpHDi4ILShTe21HkzzyTZQcoC4toOnPPjOExW+CW4DJKV+5oYG9aRmdACN97aiby5bcrVNPHpbRlqDcPp4+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=urg/lgtG; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chzn5GSbSZda0TmxlAuhZb83SwidsqpvUcETB6mC/JN0EHux/MHdx7EVJze7N/UoesqaThUS2iddDpDiKbUVpk+E4OFz4CUXrgap/jrT/MFuImRmlUf4t8TH5bIsUddeUGZdN4Ohi64D6YV0sbSrErMnA9kkP8R789jFNPVv9A4/u7Jr6Ki4Z/jg9uHWH+JjTqUPzHQE8jwRmm6rlZAE0t5GWTxn3+LWSbn3jlBEEwiE7zKI1vIYgOlS8xGTp/6T3H55Tw2zWU2Rdj93IqnYY029CXtqXmiN+1YFuvbntPLl7nnGBj0Wmcy3m5ex3jiG3eamGYqzqrk/6/Seeazo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+WOaDSk156NwhVq0MysmqaV6S6YpMoV8og/ySkfqrs=;
 b=buw+tSBXD5fptQ96wkhYeH1ktqG8RC+hQ06jX6H+jGWt6gKs9yEGp1aYfwKyFpxIcuRAAXUhXYk4VeMipU8R85z9jpj2GP0d1hhf6ochUQZMesn+mu8m0qV2AUmndHjYHQAJJQvQliQvQ2OoC3yHXH+uS0ABycFkyYpopktU0KkDZ9H0KFZ587VPdOXlzRPST2XSpFtVdm+UC7jJ+5J3WVZUX52CkHJyqSRo8kuvGcNsKr2s+SoTNHQsmgMIBX2kJyOHS8TujYcYqv01HN4l2/+/lAfyiEiJ/eoWIm9pkT8eJstyvBFey4VtosVJIhFqyiqK74CTtBP80j0GvDXN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+WOaDSk156NwhVq0MysmqaV6S6YpMoV8og/ySkfqrs=;
 b=urg/lgtGMIXpRxFdRwfEgjq1aW7W3f1P36upatXBtEm0oJIKwNM23fOA5hiHBpLzQcW/ha0WvXsDjTejMJ3lH3ZyfJeYq00MTiX2jomvOrD7hGcj56yVtukN8uHE7dniTkiqfAKSMXFYIOpgceE3g1jVAIUw1lPUOmg0Pl4YU2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH0PR01MB8070.prod.exchangelabs.com (2603:10b6:510:295::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 18:53:43 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:53:43 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 1/3] mctp pcc: Check before sending MCTP PCC response ACK
Date: Tue, 25 Jun 2024 14:53:31 -0400
Message-Id: <20240625185333.23211-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH0PR01MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 430eda37-1673-4467-5fa3-08dc954822c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLnuVvpG4duRGnViqk45aR24WOFUlmPPGx1qUqrwY4VLg3JHFs63mSdfqEZE?=
 =?us-ascii?Q?4aAxCEQyYN2nxqtkqaRfnwIJ8NA1EgNs2RzncL/0yw98EHG3B+PPOE6fSkwX?=
 =?us-ascii?Q?fkU6GGdMCP9FGxNTCMdiFpU5msBw4+vJpB2b0huc6VEUDzxLuEtvfk68OEcx?=
 =?us-ascii?Q?m/4oXf4MibNuMP2v8mEyi5VBKMi3/mtWT1WZN3gOH0b0WBMtnqKTRxaRX5iG?=
 =?us-ascii?Q?uPTPUrHR8neHoCpKu5QFqR0OYAyVZR3aeokhh6tAuaHplscdXBiEDGbm7YhC?=
 =?us-ascii?Q?YjxNajs3RTIVPjkmLsR69sYcjyvNABr3xUkxS/5mGpieh1dMW7Eg5ElYucHA?=
 =?us-ascii?Q?i0FzYlUNmi5nuxkXZo8nJZsoZJEtQH92JD5Ny0vu172Dkrat3WDfh3Pi5pSU?=
 =?us-ascii?Q?aKjTbh4pULu0J7QiZCNCwjf38pOrh6OVulDcwCJaww42GWImcYCcC5PV5JCY?=
 =?us-ascii?Q?efhQaAWtSDYZZM+ZUHelQSUEl2LiPjY4LHhOlN/3aT8ZMpa0GlxDgW6phvSg?=
 =?us-ascii?Q?7g9BJmmUmrrbM9a2Sg4prfdGptoKVgESD0+P0Ego246G/BQk3L0ywhydEBGA?=
 =?us-ascii?Q?8XpWmpht0v1dH/jNf5s42LwI1Jb2HwjK7IsmCHnRfaoj5yZzNG/VJqa3PxwM?=
 =?us-ascii?Q?mHQNkwRK6/fui9GRwHb0PQGPL6qeItffr4cOQ3QDYvgT5tFw8oOdanbiTOG0?=
 =?us-ascii?Q?GO+MP93EqKeaLeqluCQfczJgONvSIjiFpw15lFDJpIWoCC+ADjJOSf4CjV3m?=
 =?us-ascii?Q?/rP5p96ciPwYPHikfRTXFz1SLHhFnnFHVRsk0QIumbmxKBfQy7sHEn81GWeH?=
 =?us-ascii?Q?Mdx6KCSBnhRrCsb8M2H896dwOcCYeKBj0rQ08wgnPg7+g2EDE61sVdc0g0UN?=
 =?us-ascii?Q?wQhjMQMYjqUaIJKQ6LemiqK1X3fju6tkHsJ7DsMe10N7w9Oc0nvWxEkfoPFH?=
 =?us-ascii?Q?xIsvkGmrvRwPct7lyYyaHx5xnnEGn8XhTl32Pp+fpPBp4JKsKzd/UjNoZd3N?=
 =?us-ascii?Q?TJf3660GKeMyP+fV2NgVjtAp9Psg1aBsuVgXIKk8aW2niFRWLnkZMG/CRKV2?=
 =?us-ascii?Q?K1IgzonNocvnc0l7YSkYVZpHJfK6ajpvQBT02UsYddtiv0Rla603bGpP6NF4?=
 =?us-ascii?Q?yScdwW/l5Hqeg5jQF6KNP0hqJhHdfh0mDQ4Zs0H/3g+xN3p5ezTvTWB5BAmS?=
 =?us-ascii?Q?oEfSwWEhJGJieiMDI/JBdOtZVQFfw+hVXFRKqz8G3oENXJWYdz4SKE+hzCb1?=
 =?us-ascii?Q?Zak2ZKtO9Lfn/jKTrM/5zBjuztc0nbj6yzFt5wedPe0NZ9exnFqLLD+ThNAZ?=
 =?us-ascii?Q?YykfIUXxDrKZ8QaDBQP7XYX/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cD5/E3GswbO/zYLFVK3Vyom/DQGiLkyNeY2jfgg5E4vHtdDcQLmhkbIa+q4B?=
 =?us-ascii?Q?mN7C8wIwnJ3pikD8tlI6+BK4UnckZ/nCTb983T6dLfNxOsrRmKlrJL7cNH8K?=
 =?us-ascii?Q?RZN6rEY2P5my3LK+OA5AXh6hdjNQrLk3s/wQlXQzXsLcq+Vv+Zs7UnGgCAU1?=
 =?us-ascii?Q?BcttXMlQZzkwGyABAJvkrEo3t5Gwrqa2xUZNP9DoCvhWLfM6hTgLyxFPymhF?=
 =?us-ascii?Q?qt0i9JwXzlFL8nU+qIPa+7enfHmkz6+Llm/BQ3/i0oRrdnuiPU+s2pKBjK7G?=
 =?us-ascii?Q?s7sdYnhBvgdlMNu+SfHNQ03NQtS8RILM7Yv1VuOBgyiILvdj7z4BaYNNigo9?=
 =?us-ascii?Q?9gBIADI1vvsYMx6ZlR/qMbyX1E17uWZr4axQ1HqINFL/9MR2TjAyfF2RMBf8?=
 =?us-ascii?Q?bOwuYAKjU6svef4mwganJEerJAjJ+8xv6wSAV/xwmKCsyFnSlg2JwgMmqkyQ?=
 =?us-ascii?Q?SSjWTyw2spsi6delnWG/2DCJ4RNEoowX173VjcXrAbowkkUGORpwUmyeA+Lw?=
 =?us-ascii?Q?ilNCcnda000mZQmGuNcie2QO3PQ25FMQAxTVlTR7YqEG0er2Ll6ccVtu2Wyq?=
 =?us-ascii?Q?2Yz8tNUsP1+iWHwJVEq8iu3MPBuAuNm9R4hTtSPHeY6To7W0jKQKDl4J3Exn?=
 =?us-ascii?Q?dVtI6Of4UBteoMWk1mgPxy6R1p8nLez/J9ADFK6GBcfvdMBnSCwo4gl9tGtr?=
 =?us-ascii?Q?GCpU0BF3NXU2PGOH6C3GFPQpuqVkDvvPyE+PK+X85MvQuZcD95WBDgGRFVyu?=
 =?us-ascii?Q?cCUUOKYUtVot7r9NcmaEFSnS+9giaTjYIOZ01/+/QHguUW+rzQwsoCCbUn+5?=
 =?us-ascii?Q?ePkARn35X2YuXU+GItmX7PBz5MBJiMVcuvHCQJOjJ8f14WPYJZ2ixve6CDMF?=
 =?us-ascii?Q?7PKAR1i3sg0dQKMmd6XVPRApjUmxM13wQoYE7/+JmWZcglemRXYzwSZwqKzo?=
 =?us-ascii?Q?236NgzlbAnJ47hE2DO8/E1K9sfJSrnNRrk/O1/FH6gvlGLfP/koAAGsxUJA9?=
 =?us-ascii?Q?S6L2numGnB2yedGRma8iJOnRH5eSZXdxQau+uw+S5jYBAPntFslU2VJyqge/?=
 =?us-ascii?Q?xGxaYgzyUfDoy4K8u7Wsiti0diC1lov5C6JVCzuMkiQO4Up2qVynqIHxxY1T?=
 =?us-ascii?Q?Sd9gaSnZ6w8mka9VGpp7vmkLP9MZZ/aasmQLHgAmTEkRubwaYLocZNTWctgP?=
 =?us-ascii?Q?qktyTKFD+CUJV+I+8BBWQNEg2KY9xS94/ptue6V28OyjwuERHht+0YeeeJLc?=
 =?us-ascii?Q?gcOzWs3JyXEoofgxDmDKCQp8NJKcdTbsjKl4HPq3bWatzGJw1D+WEGz8LABI?=
 =?us-ascii?Q?c8ZIkC7uBI7g4E+r1TGqfjSNsUbMOuqnWndj97f2NoXCQHbar9mTIJYXgapp?=
 =?us-ascii?Q?x4J3WaNDA14R47DR5o/IExCDpd0R9+8tFOQwbtCjjtSeVm6TZJq/th5HvfE2?=
 =?us-ascii?Q?vvMt+k7/JEIgdY5vyc0vdcwVxfrCRindqRc682qcKrN28DdZe5WVmGlWksQo?=
 =?us-ascii?Q?5o8MuDYvZ1KqFH0aiHS5zL1+jZc5IGhMVsgktwF28uu4gGdyO4yqy00zggHL?=
 =?us-ascii?Q?oLAuuWLR55YP5xKsgQfuwfBeGd7Jt/2Bv0JHVDDAJYl8b40BPflZ7wWAtft4?=
 =?us-ascii?Q?2FiYQa830FJu8KxcIthymWRlbRFALnPhoS+RdvomZivqCR9WFYuM6Y+BXz/+?=
 =?us-ascii?Q?t1YaNmJKN/YwOzefPHyYkXsRHYE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430eda37-1673-4467-5fa3-08dc954822c4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:53:43.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0aeKdb3AiDNggR7y9mz6TzynqR+v3p7A8EDlxo97juKIi1A6mcCxx1i73+nuxKWT/4mC/BTK+CkbAlp0aR8zOCGnQhn+7IVkTCd2HbPOicz6jSOrWy50gqkjF3UI9cn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8070

From: Adam Young <admiyo@amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.  Since only one message can be processed at once per
channel, the value of this flag is checked during message processing
and passed back via the channels global structure.

Ideally, the mailbox callback function would return a value
indicating whether the message requires an ACK, but that
would be a change to the mailbox API.  That would involve
some change to all (about 12) of the mailbox based drivers,
and the majority of them would not need to know about the
ACK call.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 6 +++++-
 include/acpi/pcc.h    | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..5cf792700d79 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	struct pcc_mbox_chan *pmchan;
 	u64 val;
 	int ret;
 
@@ -304,6 +305,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	pmchan = &pchan->chan;
+	pmchan->ack_rx = true;  //TODO default to False
 	mbox_chan_received_data(chan, NULL);
 
 	/*
@@ -312,7 +315,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 *
 	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
+	    pmchan->ack_rx)
 		pcc_send_data(chan, NULL);
 	pchan->chan_in_use = false;
 
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a77..297913378c2b 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -16,6 +16,7 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	bool ack_rx;
 };
 
 /* Generic Communications Channel Shared Memory Region */
-- 
2.34.1


