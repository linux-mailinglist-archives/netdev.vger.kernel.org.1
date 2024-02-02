Return-Path: <netdev+bounces-68539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FB84723F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322931F27990
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CC47774;
	Fri,  2 Feb 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BHLqHfXi"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2154.outbound.protection.outlook.com [40.92.62.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601D144627
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885637; cv=fail; b=o2E58FWnKOjeyDlDaP4mmCZZwpdmuvcxuMrYQQt2mYY8q4Wwnt4GoqMWCxi/+QL0Q4JMokKwIoF2WoYubwOF8ttgz/gfGh7msdXo1wAco3BErYYg4R+cq4X63ZUtEQpmA/fE77gOSz/ouSRn7LYz4SbDSKtWqj5OBftZHWVjAWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885637; c=relaxed/simple;
	bh=eP0IPjnyIz35Ul4J+J95+LtNPdYfoN/0nGket+8bPOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBGsEp2tV4GXggHJhKc2Ac4/KhSmnjYd7TDTFYuoTc9Xz9AgIHOlL4ai5HN7hwavU4X4JTYce2ogNpM4MaxZTwB6U+1VMEkKACNxxnKLTiTTMyk9Ul39J49LG504uNphVDKrxjWzsT/C1UXxcONe/SFKwT+hKCAiRMDh9ZGumz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=BHLqHfXi; arc=fail smtp.client-ip=40.92.62.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mskn248TQx6HFf0oWalbsqfzy2LcMGveOKzi8D5xguL04kQBkfCTRJo73ajcCEZjY529VmV5cNVPac569Ebzoh+3SoML4AEQniA5KiDwNg6lj9aS1QicqWplSbKwWezaobWWKbNxq7Sxf2sEJ9xB0c9omQpN9mG0+xoHxTMA38lmyLMq2Mnd5qai//sFdHWb7R+AYVw3v1/TmWs/ccykPtLhLWtXBBcjq4ZmUs3VQ6pyr1FpQ3CHoZMPUAD6NLf807bCwN4LDpGuWRBsgI4O0XNauLP7w83OOuj/8tYCVJqMU/p1V3I5RL755HGc4Of6msXnEuHcmGB/dAeu9Q3mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mYAbbfutHrBgBDBt5WpGcKTm5spMH211Sr98qYvO64=;
 b=SgbM3c3RB2N61cFkCQXi3Xid4VKxx+4E5gbjr9MmEV/FPy+rcNwof62HXoWSijKgtTe1U7YrfnBZ7QilK0enJKyxOWpkEyke4N7vbBFCTS7auFRVvjmPUeOwbti4eEWNP9OUEm0DvxMy58nWA1alUkrnCmmmmbtDdF/v4NuX8PwQNP7lMpWV0U3om8tkQeY52E6dcCfQFpwi62NSItMY/IK9rmmpklykJhHlwfcGBJkYygTSZsik7CPvNdMSB5yjQnfp9PtCKfyJFM8xIGpIVTINGzgFJwuh9ryhFanzw9mEyTby3JO/CAgL2iHUhn/5+aq72KVsI1goZgfNUEW1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mYAbbfutHrBgBDBt5WpGcKTm5spMH211Sr98qYvO64=;
 b=BHLqHfXi0HfRdmbXbYugVk30I9eXI5dRbXAPb8TKXJkRNxyhNvyZR5/HHnNZmwiFaqM/FgcoQ2NiDF2U/6Y444RAUJ6axGqLyJOziwMTaIJBAgj/DtvG8TE6KWIPpXtg4bE3XJycPSK37HF8QInf8vMqAotLsKFThI6c5HzLybCasox39/TDBm8J2diT7dwFPZN9DYGKlK9t5nE509qwK+ZSrzvu6ALgK9PAOTGlF1LHQoU6n4g2wSHriH2+gN9uWSFMDsQe92N8s6/8mi7wN5sRVXUifxEmn7X8Vm4UMXvO+ZA/+qM8towS/CZR7Hvkumfoo6TSq6AQv8FvUDVwWQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3821.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:53:46 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:53:46 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Fri,  2 Feb 2024 22:52:49 +0800
Message-ID:
 <MEYP282MB2697FD0314F064CE300318CBBB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202145249.5238-1-songjinjian@hotmail.com>
References: <20240202145249.5238-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nowALg4R3F5bE96G3VebcN0ZBt1+NEUB]
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202145249.5238-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbef19c-d5b4-4338-c43d-08dc23fec1b9
X-MS-Exchange-SLBlob-MailProps:
	98ioH9+sI79dUwlKd00qEcozQmgouFvfHEjRtwg1JCOlc9TyRpmDuvKYpEdXGbEmgkm9U4UhA+nKX5ZE1QYFaxSWmewdx70VmOgMcd9ESmBRLJgFdHL7JvZM27ZFQ+TKhGbWhNLqu8duaYdE4k/ZpAyQwPg/MpmnJ9SXwdMenAX/mvnjMOA/cKck/HBi3tONWrjNlFG0GydujxVUbtKHEtMqSpfutBqMc3TyYvnDbVsgSzH2jbYZeQjFh6goOEqkz28n8eaz6BaMkMFts8tUQb14uZR/AWS2RJf5uL62H0sZ04AQXM/J9Xd7oDmIR/XZ29svxvnTQahw5B/JVzR3HwQhJqW7UJxlLF/03wqx6y91AY8K41o42ABeKSasHccNnwkjI9RDeq7kA4wEUNAOLW7GeAd6sI+5qZQvHxcWtgQeRLPFEMZ1gQE6qISbWDwfmoJ3wwTsyC8Oa7BpR58ni5bkizGz6k+qypXYuRvKDL3FNX1g3uLHHPum4mnx4qWCfCNkmQHyIwj+WFPRfzj0ycYiZL9VcOz2yKVQoePRhHfF4ufVHUPO9QozCKbVkKO4E7UqD4s8iP4haG5RsFLFKzZyYuy7bgGOH1BdLzis6EangV8+SVyw3V9u3qzRKejeu3zhQ78PjfC2yTekoH7NCuYaFCfnxY+37tJQqQefayMCQDeNYHoFgsvDFIcyPY3jb9gVU5kq0EykLcP6BM2Qdy4AiMWQKsFL5twpqnHEWQHdXLLQtVFtZAvaTcZ9jTcDmTwKhAd1YwRHrb85gl3tVMadHlcHt34282dWq7Il+z03p3tehxYP75HkxyBnrhoXQPq4ocS2rWOC3SvaulXfgbUaNa8MAnkb8wEYfTwSjD/4LgG+Mo1Lfw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80JRhqmdxKdaTQLukuOQzMy+iYzH/0Pm0v7w3bwSH95bqslO+OI07ANTyNOGZ5IFMhHSE/YR7RyCJRYrqGiIrQZsE95Q6UahrypOnJBbL7MBtrOGrCuOMPFjZ21uRmO39+Tk0iJCsKF2FkA9DT8AAl9LxWFunl/Mc0TlvBk6c9XcZ+R8LzUSpsPAFiKOdk9QZ5y2SbocB9u3Tco3dN4eMmokhmDEV80j5gmGrzZSPxaqQ6O+ZuBfNtU7GOQziKCclv5cKaGn6/uA+UGQ0xDrS1rpT2KeH6EIiQm6AXM7wB16OxaaXnx/mfPpwa6gf9dsKG4B1SlweBb6cgRjfPYh8DpM60/+ItUw9TlMdQ9Wk1sXHf2PjibwOykxKIktMT13kUHDJaIO61dG7cWT8bEYiydmjcqz3+KtupVjtSrAgMMvgKJn/GGDcs0vaChfi3Pn8CQQMdtW2JriiKkyRfeKY5UvLqxTHQa2f2jL+JiS4VuQRXbet0JdG6XD+StLDmRLyJe7JLjQrhr20C3FL9mpnQcuJa3NTfJszrbM1IFBcI9w/8ZyfVQeizcqkKi6+554NblbNrNawnmN6r4CtjFFeL05b2HlJRpeZAdc5n1LdzQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjsj35Ur8xmAIlve2hyx/mkT4FYfFQHIhz0v+96+6GF8xpNg/jE9pPuEzCch?=
 =?us-ascii?Q?7LfmJKRg1culbiDviq0QrfJnvNL45WHncRkKyqnXxvv2z9T0RFKLUJmVWg+a?=
 =?us-ascii?Q?FHi2WWyGW435CbzTZs97BNbAxlS7Buhi5d5tfTNIuoyIBVhlWnQC3sU2BNdA?=
 =?us-ascii?Q?O+fz9zCFves9HAngex+tCqXsQ5m88KNrUtl7KmeksLRyekEenUkzAoKeh6p7?=
 =?us-ascii?Q?0JKn+qHlre8WP/82Eda7XzV6TRgQZ9ERFKhCNKMu3G4htJPA5V+I5MOJdDkW?=
 =?us-ascii?Q?WFeaRFsKpJ5BjCddO3X19ynCkwGuhZHPKVrA5+d3lperSSgGndmMg1lKnl2j?=
 =?us-ascii?Q?Dk8ge5n9giD7RXUTWKOeKPTqPtbTh28nC2cReLY0AeNDFieeaNeLxSnKw9ug?=
 =?us-ascii?Q?V2uyYGso4rAbVqsEyx14lobZyG31fCyisTsXMMExluwK2/NJ90rl6VjKw0Cc?=
 =?us-ascii?Q?hVErTQg+4yWiLr2Znhr1EsTNrgrfeCQeqNSQO5HXtLzGi1AB05h60dOwrq8s?=
 =?us-ascii?Q?FPaG9p8bQ+lNLAFT1LbASlgfZjPGu/tpW1jTS/Vcs2kFvcw9wMWZBzwC39yU?=
 =?us-ascii?Q?rNe1kjrmP0DB6oGKMqN91HYFer2IkfGzy1xyndYBGOAGh7l3uFYCeHGqn8UO?=
 =?us-ascii?Q?M25Y8cFybggLDbCZXsk8XArAzqw/UrCIbI21jKtCzNDheCU37W1tcI+R0+Pn?=
 =?us-ascii?Q?XwpCwA59IgN++9jqyZVfokG+GcJzYVQEWwsfD7uda2jb2pS0JP5eCcsoF+7J?=
 =?us-ascii?Q?f5bf7znCYx5k0NMKDZ6S8BrDMZwsXxdUMCkXaKP+41FtNwhq0keIVt+XtbWc?=
 =?us-ascii?Q?1pOrfCCH0B9WCdcnJ2QnGkHxoopvEU6ZNfQIOlOi0RQ8VmV0ioS13Em6eghn?=
 =?us-ascii?Q?H+pFNJuVBh4aG+T/g2Nnd0rN+duOGf1pL2CEPzxQg+Dsq1CefvjFVSq3pvUi?=
 =?us-ascii?Q?9klOjmrTH8PIqAjEDGaTMwBmP5nVWQsSyeLFvJC/e/aGmApn882Qu2ppSR36?=
 =?us-ascii?Q?m4vFLtabVemBTPChbGBqDrc5AENJpdcBmoQNqwPAJe4JcBJqmXHpRB7cRBf+?=
 =?us-ascii?Q?5HS/dM0CgH8Ydb9ncN57nw6iQ/WCSApi6W8l/MFKK+6xz0ORrxKnEqiqh0/e?=
 =?us-ascii?Q?BUPWY1PUkx85AtTO1KiFV3WOxva4NB3frS81maFO5irYqLpMLdBLKYu8oBZ7?=
 =?us-ascii?Q?Y8LXd1WxZyOmWf+rKgEPQ6/bqsmzVnEnlLz0bP/as90Fyt16ghSrIOzHY5k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbef19c-d5b4-4338-c43d-08dc23fec1b9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:53:46.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3821

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.
E.g., flash firmware through fastboot port:
 - "download:%08x": write data to memory with the download size.
 - "flash:%s": write the previously downloaded image to the named partition.
 - "reboot": reboot the device.

Link: https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v8:
 * modify spelling error in WWAN 
v7:
 * add fastboot protocol link and command description to commit info
v6:
 * reorganize code to avoid dumplication
v4:
 * change function prefix to t7xx_port_fastboot
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
---
 .../networking/device_drivers/wwan/t7xx.rst   |  18 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 116 ++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 4 files changed, 115 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index 8429b9927341..f346f5f85f15 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -125,6 +125,20 @@ The driver exposes an AT port by implementing AT WWAN Port.
 The userspace end of the control port is a /dev/wwan0at0 character
 device. Application shall use this interface to issue AT commands.
 
+fastboot port userspace ABI
+---------------------------
+
+/dev/wwan0fastboot0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a fastboot protocol interface by implementing
+fastboot WWAN Port. The userspace end of the fastboot channel pipe is a
+/dev/wwan0fastboot0 character device. Application shall use this interface for
+fastboot protocol communication.
+
+Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
+port, because device needs a cold reset after enter ``fastboot_switching``
+mode.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
@@ -146,3 +160,7 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [4] *Specification # 27.007 - 3GPP*
 
 - https://www.3gpp.org/DynaReport/27007.htm
+
+[5] *fastboot "a mechanism for communicating with bootloaders"*
+
+- https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index e53a152faee4..8f5e01705af2 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -112,6 +112,9 @@ static const struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "fastboot",
+		.port_type = WWAN_PORT_FASTBOOT,
 	},
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index ddc20ddfa734..4b23ba693f3f 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2024, Fibocom Wireless Inc.
  *
  * Authors:
  *  Amir Hanania <amir.hanania@intel.com>
@@ -15,6 +16,7 @@
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Eliot Lee <eliot.lee@intel.com>
  *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #include <linux/atomic.h>
@@ -33,7 +35,7 @@
 #include "t7xx_port_proxy.h"
 #include "t7xx_state_monitor.h"
 
-static int t7xx_port_ctrl_start(struct wwan_port *port)
+static int t7xx_port_wwan_start(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
@@ -44,30 +46,60 @@ static int t7xx_port_ctrl_start(struct wwan_port *port)
 	return 0;
 }
 
-static void t7xx_port_ctrl_stop(struct wwan_port *port)
+static void t7xx_port_wwan_stop(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
 	atomic_dec(&port_mtk->usage_cnt);
 }
 
-static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
+static int t7xx_port_fastboot_tx(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct sk_buff *cur = skb, *tx_skb;
+	size_t actual, len, offset = 0;
+	int txq_mtu;
+	int ret;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		tx_skb = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!tx_skb)
+			return -ENOMEM;
+
+		skb_put_data(tx_skb, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port, tx_skb);
+		if (ret) {
+			dev_kfree_skb(tx_skb);
+			dev_err(port->dev, "Write error on fastboot port, %d\n", ret);
+			break;
+		}
+		offset += len;
+		actual -= len;
+	}
+
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 {
-	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
 	const struct t7xx_port_conf *port_conf;
 	struct sk_buff *cur = skb, *cloned;
 	struct t7xx_fsm_ctl *ctl;
 	enum md_state md_state;
 	int cnt = 0, ret;
 
-	if (!port_private->chan_enable)
-		return -EINVAL;
-
-	port_conf = port_private->port_conf;
-	ctl = port_private->t7xx_dev->md->fsm_ctl;
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
 	md_state = t7xx_fsm_get_md_state(ctl);
 	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
-		dev_warn(port_private->dev, "Cannot write to %s port when md_state=%d\n",
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
 			 port_conf->name, md_state);
 		return -ENODEV;
 	}
@@ -75,10 +107,10 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
 		cloned->len = skb_headlen(cur);
-		ret = t7xx_port_send_skb(port_private, cloned, 0, 0);
+		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
 			dev_kfree_skb(cloned);
-			dev_err(port_private->dev, "Write error on %s port, %d\n",
+			dev_err(port->dev, "Write error on %s port, %d\n",
 				port_conf->name, ret);
 			return cnt ? cnt + ret : ret;
 		}
@@ -93,14 +125,53 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	return 0;
 }
 
+static int t7xx_port_wwan_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	const struct t7xx_port_conf *port_conf = port_private->port_conf;
+	int ret;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	if (port_conf->port_type != WWAN_PORT_FASTBOOT)
+		ret = t7xx_port_ctrl_tx(port_private, skb);
+	else
+		ret = t7xx_port_fastboot_tx(port_private, skb);
+
+	return ret;
+}
+
 static const struct wwan_port_ops wwan_ops = {
-	.start = t7xx_port_ctrl_start,
-	.stop = t7xx_port_ctrl_stop,
-	.tx = t7xx_port_ctrl_tx,
+	.start = t7xx_port_wwan_start,
+	.stop = t7xx_port_wwan_stop,
+	.tx = t7xx_port_wwan_tx,
 };
 
+static void t7xx_port_wwan_create(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	if (!port->wwan.wwan_port) {
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
+		caps.headroom_len = header_len;
+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
+							&wwan_ops, &caps, port);
+		if (IS_ERR(port->wwan.wwan_port))
+			dev_err(port->dev, "Unable to create WWAN port %s", port_conf->name);
+	}
+}
+
 static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		t7xx_port_wwan_create(port);
+
 	port->rx_length_th = RX_QUEUE_MAXLEN;
 	return 0;
 }
@@ -152,21 +223,14 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header), mtu;
-	struct wwan_port_caps caps;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		return;
 
 	if (state != MD_STATE_READY)
 		return;
 
-	if (!port->wwan.wwan_port) {
-		mtu = t7xx_get_port_mtu(port);
-		caps.frag_len = mtu - header_len;
-		caps.headroom_len = header_len;
-		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
-							&wwan_ops, &caps, port);
-		if (IS_ERR(port->wwan.wwan_port))
-			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
-	}
+	t7xx_port_wwan_create(port);
 }
 
 struct port_ops wwan_sub_port_ops = {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 123f54b81cdc..35f9ee2a507f 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -229,6 +229,7 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
 	struct device *dev;
+	struct t7xx_port *port;
 
 	dev = &md->t7xx_dev->pdev->dev;
 	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
@@ -244,6 +245,9 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
 
+		port = &ctl->md->port_prox->ports[0];
+		port->port_conf->ops->enable_chl(port);
+
 		t7xx_cldma_start(md_ctrl);
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
-- 
2.34.1


