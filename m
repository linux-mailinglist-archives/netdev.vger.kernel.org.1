Return-Path: <netdev+bounces-68043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197D845B0E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F67285CA4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153B5CDF8;
	Thu,  1 Feb 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JQWx3uOx"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2183.outbound.protection.outlook.com [40.92.63.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6B62153
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800502; cv=fail; b=obuyGTraz/KOcAfi5axPUt/lUYLpKhi9kyOcA40stIP1j6BfwbzKs9JrnfbMgxLsMofcBIGv69/DlVyDWJH2M9RrF9s5WeRY8lAZ52wHjmUIwBImq+idAlQGjqVnt7zE7/7FYfOpAfvZN1bPpt4fQr32eXPVcKV6m63kqzNGjh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800502; c=relaxed/simple;
	bh=szZvuAb0HfB8tABgeWUdxPJSwHszHQKCCRKFqoglSvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppVwVI4u9o3TRVtDnjXlfyDhtVw4vALGn+SPWw74KmAvqsQyq09UdKdV65zSoJ+zIhfHdvIpUUELX8Y4nbhyYfWA/xSYWb5BY1PU9PWwF1dc/TbfoxhffbvPhbDu3dJoRcjKNEXGaRN2yY8pfWCoH98xTpeX9mQYv86rq/qd9QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JQWx3uOx; arc=fail smtp.client-ip=40.92.63.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR3hU7UwB2Fzw+wr22CkDCBG83PsacVUZ4P/c1SfAF2+iNm6E+/YXOsomQR+F8L/M+L7OAuT+SdOohcsapSe0/w8Dokb7c7zQExZPKSzZTi2wf+9MgaUM9+H9k2ta0+b5Cfsyc//eU79dND3UCXSALYYRdPfeBBFa3PXZ9d2ntXZQLJOvsuE3ipDmIa4hxyefjHJ53W37dJuoaXtjGr20nTQjZeW4YgvVxSGipEquD0BDt6pwZaPNd48uvk+UNlpcNbd2OnROwRsIeJY4TN+LgocpxN5tX5UQHJkUwk6cGdotJj50ndYdoemh28lvqaoEFQQTCHoXay4maRTds18rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vUWTCShSXPGbG92DcR+JdH2ye8eLQPd4n9EeDbUJmw=;
 b=h4tqAmORbYU2TlW0Zn35x8V9CzpkTYzmvBWhNpeqiNZeoQwWGmctyl4MfCem/KiL1W//SClUFrLhqa1JgMQys0kcncPThd6q4Epnrpb+nxipe5a0eE0rXBbGi520ihuLiQ3XkPs2vwfR5gkd7Ypp9+PvewV/r+AHMC+DckyQey5Yk3ZAZS/aE3iH9bx9J2KHfshAJ11fCFEeW1Eoxx97fjL8qS2u7UVbErsG2ykiOrjAVCVkeg/Y6CUTBTWXJ1vBsw79zzhpjdriv9QLFuev1a8KojZ99arTiYvULsGZg8Yk2V2aAI4utElYziBlEaB0s7AZDzBiDjHe2FABfl2+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vUWTCShSXPGbG92DcR+JdH2ye8eLQPd4n9EeDbUJmw=;
 b=JQWx3uOxanRH/vTgr6eyfMkcXw820g6k4Q8fUdmA4M+U3vkXpcPhY/WF8T2uzsGW4Ks7cHqzsPBTq9v6RQMyi12rWi7b6n/DVRG2T46xakLVR1Cg6dZLVVvFa3o6hWfuyIBMYKd0kzNeKWno1YiGP+sFgttd5QTtQwnt1l3LmRcOyTOI+beghfrBzzakQk4Nvt3eGbm9NfZqyVldvQspSrGK/4Ia5+nJL7hRpSU2xOysNo7UqlkcNt7AB0HJrBysK+HgkIGP0LuwuSNd+m6sktwrB6guqP+QYIsvcWP7B/bicDGjF/E1XXanJE/2vSHHwnEryTH22E6g0WqAiuTIsg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB1224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 15:14:41 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:14:41 +0000
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
Subject: [net-next v7 3/4] net: wwan: t7xx: Infrastructure for early port configuration
Date: Thu,  1 Feb 2024 23:13:39 +0800
Message-ID:
 <MEYP282MB26976F11604BFC53A7359E22BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201151340.4963-1-songjinjian@hotmail.com>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YqgnkqT1px4OiQAcQ/ChrBL7YoGH7SU5]
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240201151340.4963-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB1224:EE_
X-MS-Office365-Filtering-Correlation-Id: e43c7130-83f5-42f8-8e31-08dc2338834e
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3hb4GTTlIadAoOVXL722f/Lsqr7UCTumKGUvE0Eve5/6SFvbsHA6Z4Fu89eP0liOrhtHYQAFEFw4nlEjkd0qCNEkR7I2t9c++KUFqkBAdBbm+lPr3lxVNqRz0zgDT9RP9zOSCYbZBEhEJ7hx8LguKJ6iEomYmckH0IZCIYoO3SgZn/0jCKPQpMzqbEk1ktqTkwJBbRxzIMynyuoLQH2wvJnNBRgsHCH0z3IipQAeP1Z39ei2+ppmRPa4zVduookSLvl7uCGrOHdfZ6NAX83Hl2ImdmrQuQ83aUFELImar+6mEiWrYHwUa5Dui8EMUmcfMBbvWzsbPTmFEJBiaWcecalmtjpmWIaNgsQV+kIISK6NLXzId/+bkk53Hv/jWvAM8J40QjQQFR2r/lTquYIRRhEWlKsofogONLUkHiD1ZIp7JlBG263QPThij0OXtIJoUE/wZEdcTrpbRWAomgOD6B+Jdyk/jxp0FhiGDTCb/GaLKyOK6P3klPAqN6ESEgN2LKamcoYLuTQcj2UrANc5YiNRjb275FwuEu3zYM75Y/OqHEMut2FevIewrxyYVO6lAxEzl82VfKuepNjERks3ecxEJM5VmzW0jxac1tHmhe44yNdcQmI/5R9qPH+nI3A2nLp+PnRMAEsnn/RDDSDmuipnxY3NBPMGj0ib4PLs0Ogpv1OTRp08GzBfFCcoYLMd8Yis2f1EDeMAM8CU/W/b0XhO3dNkhWGKDSXcA9LI1WfuzQ61Smm3Qqn6QC6gVrAIZRJkxKtaF/Htw66aov0gRRRydi4rCC21Hw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xpcJ9z1X8UH/pSI8PmrzSkvirwUBboQhRmsLE6tRAJ+h5iVHsWu/rOzs2v7zwUzKre63czcvU+Qd1DS4h5SiBG48XDzbCczLxysfHxDkzEjNFqutAkXLLdfjmVnVqrWYWvvpZjLH3GapAbTRd7gBPQiNGn/ICRYPtSwSaH2lROGrYFwyh0rxzsiYDlHMAUgoo2RyBkE7l0tTUXJpMOxrX2F32HQHfWo9dP0Az0FvABLCmVCUMlrXeoUT9IAegXP1vyZdWE6hGPlUStnO6LaixYt3LlOWZRNNr9FbfqQHmmQnTRp8UviAABeDdrXJ8q5/R49rI1tZIjqLsHw3Pmd1cYbIg/bGG3aaLxi6EZhSqJoRlaiqGwsMDB2YS0vx6WyxMtMFJ5tkKoGiCyXmLZhvE2e8XT+u5wsr0fEycJVTB4c9kLx/Gf1rzFaoAPc55DTsX1XCPt5pwKlLpXA3unk9yDQRMrWUeCBwvjaRWg44VQD8hTxg3c7OXSVgp8v3ZAMzE9QW13VJcEb+SiCnwHW8BVYh2WJ3KAFbdifANRk34Y1tq2RbnpUyd/PgvGGfSwiZGLCLJjli2phLzUPHgM9cP/DIzb2n1cRLOt2dtfyP6bU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTCEblhdyjk12w5vcT3LQZCXYhzah+/ySPE5R238jhy1dqFEypP0UKKYePCX?=
 =?us-ascii?Q?dfQkeI2K7WeLmYEOsGOfpTSh9TBgD7JlxC1VKna5Ll+ghbYFBkxFEqQmfM2J?=
 =?us-ascii?Q?WLb8lRcvZ8qAXpoecdRKVyCTOXXHprUwTcfWJj2/psE6kHzgaL9i+oGyc19y?=
 =?us-ascii?Q?QVEAdyjqoSVKdtEfu7qPNOTst/wlWEz1o5VIrjkPzPUJTfvwFH6EadKvWzI4?=
 =?us-ascii?Q?rHXinyaPGMzI7veZd1wB4H++pqrpYxW6H9nyxbUFdzOnrh+DHHUvTsyWhTvi?=
 =?us-ascii?Q?hWUR7BwlO9GRuD8C2O4MQm2M4KxEkD9YkuSVfLbQoLxzS7v3iSuojPWWArjf?=
 =?us-ascii?Q?k1/iV+uppVm54LIMRrCMo2x9XHDuRITrgvV8L6bPu09VnjnPXEfRx+I7B130?=
 =?us-ascii?Q?3w5SQr4QH2O3oMLmMU8sWrvhQkgvHWb2PkKzoat0nD0YYC4lM1o1yuBBDkQ0?=
 =?us-ascii?Q?vmbM2+HEJg5vAIjHrONlyUWb0/vkc3FFtCQxlNTad1M6p3WXuK/6OenQJQFg?=
 =?us-ascii?Q?upin9d5B2u2koENDChISZAJxklpGdOqx4foQjhWn6TzR4PwWOihkD/Mca1ZR?=
 =?us-ascii?Q?zSyyhTCAJGmmTS3szazJvULJ+mlEEt7JkBlrbq3Cycr3XsO30y/cGE60oxwW?=
 =?us-ascii?Q?g24RByH7qNPslnbztXH34ivZ4OoqUSN92oE3i926YUgNSWYcZNBoIZD28aGV?=
 =?us-ascii?Q?GabTf2tpJ8YKEw9Qy+Pan9qog4G9GZgk4KWrgx3D8cXD+KRkg2cKRv08TE2A?=
 =?us-ascii?Q?yBDEahR1sxma/n0iTIGHfLYtCHWdhiPFDZXEl3Tmi2tkkg98avuAcdUTWKhP?=
 =?us-ascii?Q?bGrglRXrJflZ1GZQJtsfzSXpW95GDRuu3vsA5SXPZJZvaPjwYzcbVrkKvrWK?=
 =?us-ascii?Q?24rU3K+eoGjMZpxUhdBTu1++d/OZ7hJfFFQ6fvAQFEM8NVmNd99SX+w5aHHh?=
 =?us-ascii?Q?x7eQ1k1b3ZYDBhuK6nzR2jC29oFTJ+BrEZgyWjx/5AiNCoSBjLWh8jqqGcNi?=
 =?us-ascii?Q?vbX8BRMFygXkLKBK8br15dEKPXLDRd6GEJGb2DgusPZDfhkrIxUiuXCQgDAo?=
 =?us-ascii?Q?hA3gILy1+i2jMaf8G99j6rVCN/+Kx5NyW+Yt9LiaVxHXR9zNeEsX/uEjSmwd?=
 =?us-ascii?Q?FOzp8G5cEZ4QEItLtYVqKrTZfPwgzIQvySYfoXWeYOFsT9P8oSBLaxCQOfQr?=
 =?us-ascii?Q?g1/ycELkm5xecvTAkUlv1HWnKtXitMz8clGpvwGEQzsEzbH9fWdg7R+jq/U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e43c7130-83f5-42f8-8e31-08dc2338834e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:14:41.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1224

From: Jinjian Song <jinjian.song@fibocom.com>

To support cases such as FW update or Core dump, the t7xx
device is capable of signaling the host that a special port
needs to be created before the handshake phase.

Adds the infrastructure required to create the early ports
which also requires a different configuration of CLDMA queues.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/3777bb382f4b0395cb594a602c5c79dbab86c9e0.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v7:
 * optimize fsm_routine_stopping()
v5:
 * using t7xx_mode_update to update sysfs t7xx_mode
v4:
 * change PORT_CH_ID_UNIMPORTANT to PORT_CH_UNIMPORTANT
 * delete t7xx_wait_pm_config() in t7xx_pci_pm_init()
 * define T7XX_MAX_POSSIBLE_PORTS_NUM to get max port num
 * define macro wait_for_expected_dev_stage to be more readable
 * change prev_status to status in struct t7xx_fsm_ctl
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +++++---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |   2 +-
 drivers/net/wwan/t7xx/t7xx_port.h          |   4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 105 ++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  10 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  24 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 131 +++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
 11 files changed, 290 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index cc70360364b7..abc41a7089fa 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -57,8 +57,6 @@
 #define CHECK_Q_STOP_TIMEOUT_US		1000000
 #define CHECK_Q_STOP_STEP_US		10000
 
-#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
-
 static void md_cd_queue_struct_reset(struct cldma_queue *queue, struct cldma_ctrl *md_ctrl,
 				     enum mtk_txrx tx_rx, unsigned int index)
 {
@@ -161,7 +159,7 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queue *queue, int budget, bool
 		skb_reset_tail_pointer(skb);
 		skb_put(skb, le16_to_cpu(gpd->data_buff_len));
 
-		ret = md_ctrl->recv_skb(queue, skb);
+		ret = queue->recv_skb(queue, skb);
 		/* Break processing, will try again later */
 		if (ret < 0)
 			return ret;
@@ -897,13 +895,13 @@ static void t7xx_cldma_hw_start_send(struct cldma_ctrl *md_ctrl, int qno,
 
 /**
  * t7xx_cldma_set_recv_skb() - Set the callback to handle RX packets.
- * @md_ctrl: CLDMA context structure.
+ * @queue: CLDMA queue.
  * @recv_skb: Receiving skb callback.
  */
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb))
 {
-	md_ctrl->recv_skb = recv_skb;
+	queue->recv_skb = recv_skb;
 }
 
 /**
@@ -993,6 +991,28 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 	return ret;
 }
 
+static void t7xx_cldma_adjust_config(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
+{
+	int qno;
+
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++) {
+		md_ctrl->rx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[qno], t7xx_port_proxy_recv_skb);
+	}
+
+	md_ctrl->rx_ring[CLDMA_RXQ_NUM - 1].pkt_size = CLDMA_JUMBO_BUFF_SZ;
+
+	for (qno = 0; qno < CLDMA_TXQ_NUM; qno++)
+		md_ctrl->tx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+
+	if (cfg_id == CLDMA_DEDICATED_Q_CFG) {
+		md_ctrl->tx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		md_ctrl->rx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[CLDMA_Q_IDX_DUMP],
+					t7xx_port_proxy_recv_skb_from_dedicated_queue);
+	}
+}
+
 static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 {
 	char dma_pool_name[32];
@@ -1018,16 +1038,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 			dev_err(md_ctrl->dev, "control TX ring init fail\n");
 			goto err_free_tx_ring;
 		}
-
-		md_ctrl->tx_ring[i].pkt_size = CLDMA_MTU;
 	}
 
 	for (j = 0; j < CLDMA_RXQ_NUM; j++) {
-		md_ctrl->rx_ring[j].pkt_size = CLDMA_MTU;
-
-		if (j == CLDMA_RXQ_NUM - 1)
-			md_ctrl->rx_ring[j].pkt_size = CLDMA_JUMBO_BUFF_SZ;
-
 		ret = t7xx_cldma_rx_ring_init(md_ctrl, &md_ctrl->rx_ring[j]);
 		if (ret) {
 			dev_err(md_ctrl->dev, "Control RX ring init fail\n");
@@ -1094,6 +1107,7 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 {
 	struct device *dev = &t7xx_dev->pdev->dev;
 	struct cldma_ctrl *md_ctrl;
+	int qno;
 
 	md_ctrl = devm_kzalloc(dev, sizeof(*md_ctrl), GFP_KERNEL);
 	if (!md_ctrl)
@@ -1102,7 +1116,9 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 	md_ctrl->t7xx_dev = t7xx_dev;
 	md_ctrl->dev = dev;
 	md_ctrl->hif_id = hif_id;
-	md_ctrl->recv_skb = t7xx_cldma_default_recv_skb;
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++)
+		md_ctrl->rxq[qno].recv_skb = t7xx_cldma_default_recv_skb;
+
 	t7xx_hw_info_init(md_ctrl);
 	t7xx_dev->md->md_ctrl[hif_id] = md_ctrl;
 	return 0;
@@ -1332,9 +1348,10 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 	return -ENOMEM;
 }
 
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl)
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
 {
 	t7xx_cldma_late_release(md_ctrl);
+	t7xx_cldma_adjust_config(md_ctrl, cfg_id);
 	t7xx_cldma_late_init(md_ctrl);
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index 4410bac6993a..f2d9941be9c8 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -31,6 +31,10 @@
 #include "t7xx_cldma.h"
 #include "t7xx_pci.h"
 
+#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
+#define CLDMA_SHARED_Q_BUFF_SZ		3584
+#define CLDMA_DEDICATED_Q_BUFF_SZ	2048
+
 /**
  * enum cldma_id - Identifiers for CLDMA HW units.
  * @CLDMA_ID_MD: Modem control channel.
@@ -55,6 +59,11 @@ struct cldma_gpd {
 	__le16 not_used2;
 };
 
+enum cldma_cfg {
+	CLDMA_SHARED_Q_CFG,
+	CLDMA_DEDICATED_Q_CFG,
+};
+
 struct cldma_request {
 	struct cldma_gpd *gpd;	/* Virtual address for CPU */
 	dma_addr_t gpd_addr;	/* Physical address for DMA */
@@ -82,6 +91,7 @@ struct cldma_queue {
 	wait_queue_head_t req_wq;	/* Only for TX */
 	struct workqueue_struct *worker;
 	struct work_struct cldma_work;
+	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
 struct cldma_ctrl {
@@ -101,24 +111,22 @@ struct cldma_ctrl {
 	struct md_pm_entity *pm_entity;
 	struct t7xx_cldma_hw hw_info;
 	bool is_late_init;
-	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
+#define CLDMA_Q_IDX_DUMP	1
 #define GPD_FLAGS_HWO		BIT(0)
 #define GPD_FLAGS_IOC		BIT(7)
 #define GPD_DMAPOOL_ALIGN	16
 
-#define CLDMA_MTU		3584	/* 3.5kB */
-
 int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev);
 void t7xx_cldma_hif_hw_init(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_init(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_exit(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl);
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id);
 void t7xx_cldma_start(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_stop(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_reset(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb));
 int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb);
 void t7xx_cldma_stop_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx_rx);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index ca262d2961ed..fd79a2a1cc6f 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -535,7 +535,7 @@ static void t7xx_md_hk_wq(struct work_struct *work)
 
 	/* Clear the HS2 EXIT event appended in core_reset() */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_MD_HS2_EXIT);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS2);
 	md->core_md.handshake_ongoing = true;
@@ -550,7 +550,7 @@ static void t7xx_ap_hk_wq(struct work_struct *work)
 	 /* Clear the HS2 EXIT event appended in t7xx_core_reset(). */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_AP_HS2_EXIT);
 	t7xx_cldma_stop(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_AP]);
 	md->core_ap.handshake_ongoing = true;
 	t7xx_core_hk_handler(md, &md->core_ap, ctl, FSM_EVENT_AP_HS2, FSM_EVENT_AP_HS2_EXIT);
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 1a10afd948c7..06e97778fd2f 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -183,7 +183,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	return t7xx_wait_pm_config(t7xx_dev);
+	return 0;
 }
 
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 4ae8a00a8532..f74d3bab810d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -75,6 +75,8 @@ enum port_ch {
 	PORT_CH_DSS6_TX = 0x20df,
 	PORT_CH_DSS7_RX = 0x20e0,
 	PORT_CH_DSS7_TX = 0x20e1,
+
+	PORT_CH_UNIMPORTANT = 0xffff,
 };
 
 struct t7xx_port;
@@ -135,11 +137,13 @@ struct t7xx_port {
 	};
 };
 
+int t7xx_get_port_mtu(struct t7xx_port *port);
 struct sk_buff *t7xx_port_alloc_skb(int payload);
 struct sk_buff *t7xx_ctrl_alloc_skb(int payload);
 int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb);
 int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int pkt_header,
 		       unsigned int ex_msg);
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb);
 int t7xx_port_send_ctl_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int msg,
 			   unsigned int ex_msg);
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 274846d39fbf..e53a152faee4 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -48,6 +48,9 @@
 	     i < (proxy)->port_count;		\
 	     i++, (p) = &(proxy)->ports[i])
 
+#define T7XX_MAX_POSSIBLE_PORTS_NUM	\
+	(max(ARRAY_SIZE(t7xx_port_conf), ARRAY_SIZE(t7xx_early_port_conf)))
+
 static const struct t7xx_port_conf t7xx_port_conf[] = {
 	{
 		.tx_ch = PORT_CH_UART2_TX,
@@ -100,6 +103,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 	},
 };
 
+static const struct t7xx_port_conf t7xx_early_port_conf[] = {
+	{
+		.tx_ch = PORT_CH_UNIMPORTANT,
+		.rx_ch = PORT_CH_UNIMPORTANT,
+		.txq_index = CLDMA_Q_IDX_DUMP,
+		.rxq_index = CLDMA_Q_IDX_DUMP,
+		.txq_exp_index = CLDMA_Q_IDX_DUMP,
+		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
+		.path_id = CLDMA_ID_AP,
+	},
+};
+
 static struct t7xx_port *t7xx_proxy_get_port_by_ch(struct port_proxy *port_prox, enum port_ch ch)
 {
 	const struct t7xx_port_conf *port_conf;
@@ -214,7 +229,17 @@ int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb)
 	return 0;
 }
 
-static int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
+int t7xx_get_port_mtu(struct t7xx_port *port)
+{
+	enum cldma_id path_id = port->port_conf->path_id;
+	int tx_qno = t7xx_port_get_queue_no(port);
+	struct cldma_ctrl *md_ctrl;
+
+	md_ctrl = port->t7xx_dev->md->md_ctrl[path_id];
+	return md_ctrl->tx_ring[tx_qno].pkt_size;
+}
+
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
 {
 	enum cldma_id path_id = port->port_conf->path_id;
 	struct cldma_ctrl *md_ctrl;
@@ -329,6 +354,39 @@ static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
 	}
 }
 
+/**
+ * t7xx_port_proxy_recv_skb_from_dedicated_queue() - Dispatch early port received skb.
+ * @queue: CLDMA queue.
+ * @skb: Socket buffer.
+ *
+ * Return:
+ ** 0		- Packet consumed.
+ ** -ERROR	- Failed to process skb.
+ */
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb)
+{
+	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	struct t7xx_port *port;
+	int ret;
+
+	port = &port_prox->ports[0];
+	if (WARN_ON_ONCE(port->port_conf->rxq_index != queue->index)) {
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	port_conf = port->port_conf;
+	ret = port_conf->ops->recv_skb(port, skb);
+	if (ret < 0 && ret != -ENOBUFS) {
+		dev_err(port->dev, "drop on RX ch %d, %d\n", port_conf->rx_ch, ret);
+		dev_kfree_skb_any(skb);
+	}
+
+	return ret;
+}
+
 static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev,
 						   struct cldma_queue *queue, u16 channel)
 {
@@ -359,7 +417,7 @@ static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev
  ** 0		- Packet consumed.
  ** -ERROR	- Failed to process skb.
  */
-static int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
 {
 	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
 	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
@@ -444,33 +502,54 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops->init)
+		if (port_conf->ops && port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
+{
+	struct port_proxy *port_prox = md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	u32 port_count;
+	int i;
+
+	t7xx_port_proxy_uninit(port_prox);
+
+	if (cfg_id == PORT_CFG_ID_EARLY) {
+		port_conf = t7xx_early_port_conf;
+		port_count = ARRAY_SIZE(t7xx_early_port_conf);
+	} else {
+		port_conf = t7xx_port_conf;
+		port_count = ARRAY_SIZE(t7xx_port_conf);
+	}
+
+	for (i = 0; i < port_count; i++)
+		port_prox->ports[i].port_conf = &port_conf[i];
+
+	port_prox->cfg_id = cfg_id;
+	port_prox->port_count = port_count;
+
+	t7xx_proxy_init_all_ports(md);
+}
+
 static int t7xx_proxy_alloc(struct t7xx_modem *md)
 {
-	unsigned int port_count = ARRAY_SIZE(t7xx_port_conf);
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	struct port_proxy *port_prox;
-	int i;
 
-	port_prox = devm_kzalloc(dev, sizeof(*port_prox) + sizeof(struct t7xx_port) * port_count,
+	port_prox = devm_kzalloc(dev, sizeof(*port_prox) +
+				 sizeof(struct t7xx_port) * T7XX_MAX_POSSIBLE_PORTS_NUM,
 				 GFP_KERNEL);
 	if (!port_prox)
 		return -ENOMEM;
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
+	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
-	for (i = 0; i < port_count; i++)
-		port_prox->ports[i].port_conf = &t7xx_port_conf[i];
-
-	port_prox->port_count = port_count;
-	t7xx_proxy_init_all_ports(md);
 	return 0;
 }
 
@@ -492,8 +571,6 @@ int t7xx_port_proxy_init(struct t7xx_modem *md)
 	if (ret)
 		return ret;
 
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_AP], t7xx_port_proxy_recv_skb);
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
 	return 0;
 }
 
@@ -505,7 +582,7 @@ void t7xx_port_proxy_uninit(struct port_proxy *port_prox)
 	for_each_proxy_port(i, port, port_prox) {
 		const struct t7xx_port_conf *port_conf = port->port_conf;
 
-		if (port_conf->ops->uninit)
+		if (port_conf->ops && port_conf->ops->uninit)
 			port_conf->ops->uninit(port);
 	}
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 81d059fbc0fb..7f5706811445 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -31,11 +31,18 @@
 #define RX_QUEUE_MAXLEN		32
 #define CTRL_QUEUE_MAXLEN	16
 
+enum port_cfg_id {
+	PORT_CFG_ID_INVALID,
+	PORT_CFG_ID_NORMAL,
+	PORT_CFG_ID_EARLY,
+};
+
 struct port_proxy {
 	int			port_count;
 	struct list_head	rx_ch_ports[PORT_CH_ID_MASK + 1];
 	struct list_head	queue_ports[CLDMA_NUM][MTK_QUEUES];
 	struct device		*dev;
+	enum port_cfg_id	cfg_id;
 	struct t7xx_port	ports[];
 };
 
@@ -98,5 +105,8 @@ void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int
 int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 17389c8f6600..ddc20ddfa734 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -152,14 +152,15 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header);
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
 	struct wwan_port_caps caps;
 
 	if (state != MD_STATE_READY)
 		return;
 
 	if (!port->wwan.wwan_port) {
-		caps.frag_len = CLDMA_MTU - header_len;
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
 		caps.headroom_len = header_len;
 		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
 							&wwan_ops, &caps, port);
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index c41d7d094c08..9c7dc72ac6f6 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -101,11 +101,33 @@ enum t7xx_pm_resume_state {
 	PM_RESUME_REG_STATE_L2_EXP,
 };
 
+enum host_event_e {
+	HOST_EVENT_INIT = 0,
+	FASTBOOT_DL_NOTIFY = 0x3,
+};
+
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
 #define MISC_STAGE_MASK				GENMASK(2, 0)
 #define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_RESET_TYPE_FLDR			BIT(27)
-#define LINUX_STAGE				4
+#define MISC_RESET_TYPE_PLDR			BIT(26)
+#define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+#define HOST_EVENT_MASK				GENMASK(31, 28)
+
+enum lk_event_id {
+	LK_EVENT_NORMAL = 0,
+	LK_EVENT_CREATE_PD_PORT = 1,
+	LK_EVENT_CREATE_POST_DL_PORT = 2,
+	LK_EVENT_RESET = 7,
+};
+
+enum t7xx_device_stage {
+	T7XX_DEV_STAGE_INIT = 0,
+	T7XX_DEV_STAGE_BROM_PRE = 1,
+	T7XX_DEV_STAGE_BROM_POST = 2,
+	T7XX_DEV_STAGE_LK = 3,
+	T7XX_DEV_STAGE_LINUX = 4,
+};
 
 #define T7XX_PCIE_RESOURCE_STATUS		0x0d28
 #define T7XX_PCIE_RESOURCE_STS_MSK		GENMASK(4, 0)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index c5d46f45fa62..b98ad4a1709b 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -47,6 +47,13 @@
 #define FSM_MD_EX_PASS_TIMEOUT_MS		45000
 #define FSM_CMD_TIMEOUT_MS			2000
 
+#define wait_for_expected_dev_stage(status)	\
+	read_poll_timeout(ioread32, status,	\
+			  ((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LINUX) ||	\
+			  ((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LK), 100000,	\
+			  20000000, false, IREG_BASE(md->t7xx_dev) +	\
+			  T7XX_PCIE_MISC_DEV_STATUS)
+
 void t7xx_fsm_notifier_register(struct t7xx_modem *md, struct t7xx_fsm_notifier *notifier)
 {
 	struct t7xx_fsm_ctl *ctl = md->fsm_ctl;
@@ -206,6 +213,51 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
+{
+	u32 value;
+
+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+}
+
+static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
+{
+	struct t7xx_modem *md = ctl->md;
+	struct cldma_ctrl *md_ctrl;
+	enum lk_event_id lk_event;
+	struct device *dev;
+
+	dev = &md->t7xx_dev->pdev->dev;
+	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
+	switch (lk_event) {
+	case LK_EVENT_NORMAL:
+	case LK_EVENT_RESET:
+		break;
+
+	case LK_EVENT_CREATE_PD_PORT:
+	case LK_EVENT_CREATE_POST_DL_PORT:
+		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
+		t7xx_cldma_hif_hw_init(md_ctrl);
+		t7xx_cldma_stop(md_ctrl);
+		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+
+		t7xx_cldma_start(md_ctrl);
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			t7xx_mode_update(md->t7xx_dev, T7XX_FASTBOOT_DL_MODE);
+		else
+			t7xx_mode_update(md->t7xx_dev, T7XX_FASTBOOT_DUMP_MODE);
+		break;
+
+	default:
+		dev_err(dev, "Invalid LK event %d\n", lk_event);
+		break;
+	}
+}
+
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
 	ctl->curr_state = FSM_STATE_STOPPED;
@@ -226,27 +278,32 @@ static void fsm_routine_stopped(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comman
 
 static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
-	struct t7xx_pci_dev *t7xx_dev;
-	struct cldma_ctrl *md_ctrl;
+	struct cldma_ctrl *md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
+	struct t7xx_pci_dev *t7xx_dev = ctl->md->t7xx_dev;
+	u32 mode = READ_ONCE(t7xx_dev->mode);
 	int err;
 
-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
+	if (ctl->curr_state == FSM_STATE_STOPPED ||
+	    ctl->curr_state == FSM_STATE_STOPPING ||
+	    mode == T7XX_RESET) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
 		return;
 	}
 
-	md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
-	t7xx_dev = ctl->md->t7xx_dev;
-
 	ctl->curr_state = FSM_STATE_STOPPING;
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (!ctl->md->rgu_irq_asserted) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
-		/* Wait for the DRM disable to take effect */
-		msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (mode == T7XX_FASTBOOT_DL_SWITCHING)
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
+
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
 
+	if (mode == T7XX_FASTBOOT_DL_SWITCHING) {
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+	} else {
 		err = t7xx_acpi_fldr_func(t7xx_dev);
 		if (err)
 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
@@ -318,7 +375,8 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
 	struct t7xx_modem *md = ctl->md;
-	u32 dev_status;
+	struct device *dev;
+	u32 status;
 	int ret;
 
 	if (!md)
@@ -330,23 +388,53 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 		return;
 	}
 
+	dev = &md->t7xx_dev->pdev->dev;
 	ctl->curr_state = FSM_STATE_PRE_START;
 	t7xx_md_event_notify(md, FSM_PRE_START);
 
-	ret = read_poll_timeout(ioread32, dev_status,
-				(dev_status & MISC_STAGE_MASK) == LINUX_STAGE, 20000, 2000000,
-				false, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	ret = wait_for_expected_dev_stage(status);
+
 	if (ret) {
-		struct device *dev = &md->t7xx_dev->pdev->dev;
+		dev_err(dev, "read poll timeout %d\n", ret);
+		goto finish_command;
+	}
 
-		fsm_finish_command(ctl, cmd, -ETIMEDOUT);
-		dev_err(dev, "Invalid device status 0x%lx\n", dev_status & MISC_STAGE_MASK);
-		return;
+	if (status != ctl->status || cmd->flag != 0) {
+		u32 stage = FIELD_GET(MISC_STAGE_MASK, status);
+
+		switch (stage) {
+		case T7XX_DEV_STAGE_INIT:
+		case T7XX_DEV_STAGE_BROM_PRE:
+		case T7XX_DEV_STAGE_BROM_POST:
+			dev_dbg(dev, "BROM_STAGE Entered\n");
+			ret = t7xx_fsm_append_cmd(ctl, FSM_CMD_START, 0);
+			break;
+
+		case T7XX_DEV_STAGE_LK:
+			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_lk_stage_event_handling(ctl, status);
+			break;
+
+		case T7XX_DEV_STAGE_LINUX:
+			dev_dbg(dev, "LINUX_STAGE Entered\n");
+			t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_PORT_ENUM |
+					     D2H_INT_ASYNC_MD_HK | D2H_INT_ASYNC_AP_HK);
+			if (cmd->flag == 0)
+				break;
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_NORMAL);
+			ret = fsm_routine_starting(ctl);
+			break;
+
+		default:
+			break;
+		}
+		ctl->status = status;
 	}
 
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
-	fsm_finish_command(ctl, cmd, fsm_routine_starting(ctl));
+finish_command:
+	fsm_finish_command(ctl, cmd, ret);
 }
 
 static int fsm_main_thread(void *data)
@@ -518,6 +606,7 @@ void t7xx_fsm_reset(struct t7xx_modem *md)
 	fsm_flush_event_cmd_qs(ctl);
 	ctl->curr_state = FSM_STATE_STOPPED;
 	ctl->exp_flg = false;
+	ctl->status = T7XX_DEV_STAGE_INIT;
 }
 
 int t7xx_fsm_init(struct t7xx_modem *md)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b0b3662ae6d7..7b0a9baf488c 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -96,6 +96,7 @@ struct t7xx_fsm_ctl {
 	bool			exp_flg;
 	spinlock_t		notifier_lock;		/* Protects notifier list */
 	struct list_head	notifier_list;
+	u32			status;			/* Device boot stage */
 };
 
 struct t7xx_fsm_event {
-- 
2.34.1


