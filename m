Return-Path: <netdev+bounces-121203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4995C2C9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23542813D0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9103156CE;
	Fri, 23 Aug 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KkruHsPw"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DF1AACC;
	Fri, 23 Aug 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376480; cv=fail; b=kYYp12gzl3wUQdzlonjaihts8OqBWgDzfbVfsapxlTbrehCV2R9Mhm3FO5QSZ/teJISxeHi8Ord90jGzr3odGM/84mBk2Ta6DeQBizLnlQcWlKpL4u235dE5g/iqEVuf0TZX2wgAVKfLZiL+PdZSYHZVlFkQ9QYDymJQp+FaIPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376480; c=relaxed/simple;
	bh=dkmwT4Dy4afitNnGWjnTcF+/pBMWp8S7m0PJ9h3SxBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TdIlaOUDbKDXMY8qJizhw4/BQr2wQgaNoIrXsWTZ6g9mGtmaN/BCN2OylahpNOgANNuz/+ERrFPYrYCC4Qxl70/xgIfoFJRGfo4y5DfvHv1CffVPMLsgFBUIJx0GpOzqAlFL8/zMOdEmSSnIhwktgxYqgaid8LboaS+Lx+MZLgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KkruHsPw; arc=fail smtp.client-ip=40.107.117.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHFHs69QCdZOTdjtWu2zkmILG9jQaBAOUmrAm/QmSMw6YUM4RW8dgTCRmkh3qeVGAqMyrYseibOWobCP+7cScPAbCQiRZOQ5ZtyJjADpzF+BAZD8HblLJ8nXTTKNMa4B9P0Xh+sGWdfFQavJUVh7893aG+eGqjN19uRyGxFhNwpwLhx5NdpijCVar5ItZ5krveAKEe9X0+f6gqgreA1xObQqUiI0fuv4QANIQpIB18iNNotFLUbzdQIR1XVIjiPlmwcvp4HmAJmVQfcg30oasXs+l4JcvwOVxkwqfy2HAJzD/EJQq4kgp8QPVZxdAW45NstSB/VgEvLPcYBFGCRfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8ufNyAtosAIv4C7qGOeKeNHwdlU8gkGju71jZBFKbY=;
 b=W+fM5m5t/UBMUKrXA39lwSnSgnCzrGdnWebHXcNdOs5rC5dmYzm/rCklEwvWwpt0kww9y2SHnK/FsZC3O78/var9Z929QdU2bz8gEH16i5xj3taJBu6VegpSY+q9bzseUyOVvCZ2BSq9jWR38f+a4UIKZpej+4iKG1koE+Vy7ROv54o6beNzpZrlO+45Zd7kmeFivS6OgB/HNvIGGiIDDRhuHRcNLlYF2NcgWwjBkIYqKWGH8aE53d9DQAGaqE0HQkFBmVnF6+ArabAisfSbRn3oeZKdiVBYObJ9oRtF7GMYNjsbTHKVqzxTRxvfMBlJjkHsJcelYxB+CwglfmJc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8ufNyAtosAIv4C7qGOeKeNHwdlU8gkGju71jZBFKbY=;
 b=KkruHsPwRHU90QXfFcsFcY99TYEtY13mRtlAUH6+mdbhlbjuQ0q57Lcvf9os5NcgLnIqXU3W4ctKuddFFqRfwm41WOQKipVjoAIC0uhNkefDz9v7FnhM5x5osP8MF7lik/oyNycPcJUfploHJ5X9F3biIBH8AAHkmu+0HVwvSTTD8wpvWJT9V2tJOJPkppJarmYtTN47iDzJPllqm0skn4VtrHkUyuWHFVcmuv9ldzo3UuOUe8OlNVQXoe7jYVZnYXS8A1kMp8O/LKW4V8IkXNq2d8V5zznMNdgTNbKHjLqY6iuVG+Lz2gV2UkwmzEuI0cb61zlQjUU9Ua3WdEH4/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9)
 by PUZPR06MB6265.apcprd06.prod.outlook.com (2603:1096:301:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 01:27:49 +0000
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6]) by PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 01:27:49 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: mark.einon@gmail.com,
	davem@davemloft.net,
	dumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH net-next v2] et131x: Remove NULL check of list_entry()
Date: Fri, 23 Aug 2024 09:27:37 +0800
Message-Id: <20240823012737.2995688-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To PUZPR06MB5724.apcprd06.prod.outlook.com
 (2603:1096:301:f4::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5724:EE_|PUZPR06MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d7da26-b900-4d7e-d4f2-08dcc312ccc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LGk0JauicQwifNtd/N/jxIH7qGeD/ODtcOp9Mcs9yBudDcBcwoJl1obLY9sg?=
 =?us-ascii?Q?67IDR32Hjh9S3dgkzNLF85rklflr0Y0jiIQ5PRNvFhPPEz+QozIvtirmtlH/?=
 =?us-ascii?Q?cov9vstA2Kbx4qhLHmOr01ZkTD0ecLT/PPeGSNYLDBknY5ftEkFrX2mhvW4b?=
 =?us-ascii?Q?xGx2Si++KA+Gu08efhWbrELhuryf/dCg5HP2erUCVV1RYmQOpHu2PpkYE+g2?=
 =?us-ascii?Q?loupm11+Z4dj+Tzs/ZUI95VIIHBm+AuMVVVExJU9I3D/k4XBf/vlwdSV084+?=
 =?us-ascii?Q?HDzU9s7pMP5OlfZp6P4R9bSXstPyu9ILk2O6mPx/t/cdxuIhxbsApLAwUXII?=
 =?us-ascii?Q?v86WlLZYB78rdQOKLYiKpxMy1A5Nhudncebo3NRWQWe5aWOhw4NtZq2MOG0m?=
 =?us-ascii?Q?in9DnR7O9gXR6KZpT9P2fSZj1e9+jR5x/XBSaYmFNOJXr2ueiNfcm9MccuAB?=
 =?us-ascii?Q?uTuiMRn+LlhTbhF7U4ZxOLbUnXizzdKpCYPcmdr1qEI+ygVBg+LDL5DxfZrG?=
 =?us-ascii?Q?SlRPggQ4azP9OSXr/o7iJ/BG+zzxmiuGi6lWpGyqgcI3A2+YXtkbXGKtZqkg?=
 =?us-ascii?Q?5H+DI00ggVolOH2HjYkkVWTt/fmqP8f4kN730IWn+U5hbX5W3fRzweEiutJw?=
 =?us-ascii?Q?6gvO94rJaO3SEQ4WIv4LCtX4eTJnlpomw0e+TGhlu3R3K90GeRq1KtWcDHqL?=
 =?us-ascii?Q?mCPTP1njD7wAZCx0iz8xVfbjuZmbiGjJkPYhhdwYRpFSLSHS6G3ishKz1O1c?=
 =?us-ascii?Q?v+hQ8WowNDBsx7n3Egvd4beQtwlxDY2XAaLdbemUJiGnv8JVSxowzR79vyQm?=
 =?us-ascii?Q?xrXjpexPFJEXm3XmBo7qAMcWH/D+7EE+K9ZS6l2JEUTV9XfxLS122yevDg5S?=
 =?us-ascii?Q?ODjPT4cQ8zQp+Eejhfurh5Cm7nZJWunXBtfTGZdpwYpk7AUe+efQU4G7Sb6x?=
 =?us-ascii?Q?EYRWR8R/xdgk+LZ/D9vK41JJnjoQohDRT3B6drlEsIpmQW73FQ1L0O8vJwzj?=
 =?us-ascii?Q?/f5elIXcsF75xXyLPhfe+CRKzLkSe9/qrL0hK6c2Hc8zeKSVvX1Us+DHfjwn?=
 =?us-ascii?Q?o+mV48L/Wvxymhh1c1G0k7yMyV2heKBc1EHuSU5/MqKcD/JH0B7aZHAhGRyj?=
 =?us-ascii?Q?L5YfFJKve+ze7fYv3aEeg9yycDNsHuovXzxYjkJIIc8yAZ+bbejFemYo3fbv?=
 =?us-ascii?Q?CbDrjQim0bUG88TPkWqqePhkU0objKB74pJ0hB4ohhyycGQYP7jORFuf9r/M?=
 =?us-ascii?Q?2J9pSLKP1RxC7CQG8gre0x62O8sgATPSRvOuHeR6/WRQ/GG4plPyH+8tUrVq?=
 =?us-ascii?Q?D4ebnpcSgfY1q1qX/jeX3o17E5t7wmzMhgEheN9g3km5eH18PM+MvR7Qg8a2?=
 =?us-ascii?Q?44NNk09zP5BiPdiNrAx2bfSdyIk0Cmt7bWcKtQmd0PePU1mkKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5724.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+RmwaufgoSe3wkVzzPs+btk654fb+iMZOQi6qQ42ejHjSEs+t8eHpV+UlAcn?=
 =?us-ascii?Q?1bvTsH3ia2SY19AU3ivL7vVQsiff+ttkIUE/5uGg8K7KShaUVoDZqmYsh+Zg?=
 =?us-ascii?Q?P/6QTk5PVq1t/au41gz02ZFZMdiZbWQDrfzW0ZkxAWTtR/LSfLDOQyc0XCfn?=
 =?us-ascii?Q?aVnBQ3ef2HmhOqjMgoj0bMOahjX4mFNRQjnut5swgzLrsD8cQilVDolddbio?=
 =?us-ascii?Q?tB0p6kb/MlI/t2JdwZ5cs17DC6ovzmWlRUVAOkm9rsP2jr3ezMtipNYuGwOU?=
 =?us-ascii?Q?Gz3mNRFXq4hTxQUw96d7Kl72pvlIoMczx9xybJmk9Z5j0p6xjv+dqSVG/V18?=
 =?us-ascii?Q?r+VsYz1XsWnBvViNCmJMG52pQcPecGzvXfkXEvd9Czvykvtrq+TYuv4/BY5h?=
 =?us-ascii?Q?+9FDB0B1MWoRHOIt/V1LfE1m7adYhDRez3Mvo0SgQVqQ0BOXqH7jYk/wGnZv?=
 =?us-ascii?Q?yRHzp8tdBFdSW5ZAqt/RRmTFjUq/JtbtXJXXq4uZRTw5R7BqiDYYr7nHbihl?=
 =?us-ascii?Q?TW/1iI4u3vfn+EGTVTxkv2Ogwsr6vP3K6d/PH8UwmzoypO4UdDw13yG3RcJY?=
 =?us-ascii?Q?sUBnfUr1ABkzCEWdmYZWFDInZBdPLmlSh2fp7CkrEjkbLcNVr/uGkgNu+p96?=
 =?us-ascii?Q?fPnvvv0DYZ/ni/Czgtf8DZKIdNU3VzzUYVF5bn/kBminfMk3fYJfl6okVJws?=
 =?us-ascii?Q?eSc1hnJWLbt8av8+6aNrBzf1Mg8/IYxJXdSezx2kGrdDnlspdu63K+BcVnbi?=
 =?us-ascii?Q?tc6bbWHsAJwUm/9OXWtMGUDd5dwolqMBt703oVKBFtZmTvJ6qve0bvJo0bFz?=
 =?us-ascii?Q?HCQqyC9m0qMr/Qgj3LhmFGAGMkVsUS3y7yNksn7d8nkHaXzOH7Hc3ZK+IHZ9?=
 =?us-ascii?Q?JJw2mOj8ftTKWcqAX0EYJ/ll7CEl02li3g31bzh9yAPinep8LHcQY+tMVdDS?=
 =?us-ascii?Q?Wo0YfSSa/PvaprR65LMD+uCOSXxNgDCVEcqjkfwknG3TNuCJ/9kQeyxip7BT?=
 =?us-ascii?Q?RiOWKNcac+tHZcLM+57DBP4t0x0Vx081TR++VgjKCIt6pAT56e/uB45Izue+?=
 =?us-ascii?Q?1wSqka1/xqOU6Nh2QJ1vxXzjdJalZVNcUL5iuDyNR2PBrCYWNRqmDpO4lfRA?=
 =?us-ascii?Q?DIgITGUaKMOWhZaBSWIpL8VyVOUlty6MlJckTF4ShN2C4O1a0l2M9XC7uUEA?=
 =?us-ascii?Q?WxeveOoJ7AuXOmMX4oZW0WJRvwA8FekGi+Y5KQKTwc6oWLcBhsMjqygkvlRY?=
 =?us-ascii?Q?CTIukJfFOjx90AbTbQfP+HRkQHh30V9YQRmGnaMdu/g+NPrt5TwO2IYhPylK?=
 =?us-ascii?Q?YPDdy1LCHxne0JsSvyNYqRdcTTeK0+xCuiAF725/YCcpywmQIigLQCOb38MD?=
 =?us-ascii?Q?7JyfNvAQM1bYswIUU7+3mRw47COob3ydhsKYjAMMHlWgLIYSIuoPIRMiQFwv?=
 =?us-ascii?Q?WSJ42EqiRQF/jnxDGBkfN4u2CR1JHyTjztqVpSfLquJR15o7JN88kLEcY1La?=
 =?us-ascii?Q?JHkfZpDOgD+G9DyUsIi5jGoNFAYqwbd8F36Lutg6zI/CdkFsWZIykOa8UcF/?=
 =?us-ascii?Q?xMFHTJ3X7PuDJXCqVFrD0KXU6F34n8ow4cV9djxn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d7da26-b900-4d7e-d4f2-08dcc312ccc3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5724.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 01:27:49.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY58mrJPdTfR9T5QwoKaAXqrHk0bvp/aJorQQEihdyYDmoS5fGklvQgGAoFB9vZq7fcZmj9br0sbVPtBb9OBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6265

list_entry() will never return a NULL pointer, thus remove the
check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
Reviewed-by: Mark Einon <mark.einon@gmail.com>
---
changes v2:
- update the short log and patch name
---
 drivers/net/ethernet/agere/et131x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index b325e0cef120..74fc55b9f0d9 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2244,11 +2244,6 @@ static struct rfd *nic_rx_pkts(struct et131x_adapter *adapter)
 	element = rx_local->recv_list.next;
 	rfd = list_entry(element, struct rfd, list_node);
 
-	if (!rfd) {
-		spin_unlock_irqrestore(&adapter->rcv_lock, flags);
-		return NULL;
-	}
-
 	list_del(&rfd->list_node);
 	rx_local->num_ready_recv--;
 
-- 
2.34.1


