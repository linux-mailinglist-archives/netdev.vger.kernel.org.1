Return-Path: <netdev+bounces-263374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEEQKKgup2nlfgAAu9opvQ
	(envelope-from <netdev+bounces-263374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:55:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523231F587C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 971963030D94
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D233C2787;
	Tue,  3 Mar 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rYL8QMSW"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802573B5314;
	Tue,  3 Mar 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564127; cv=fail; b=XzsqLWpphWcfq+uygeScQI+EP/pzGFsPp8bdoNI4FzLAmpEV6NKjRiIIfy5kgr+kvS3A1jA+72HoCv77IQMIBCfyAJTKYRTWmD96yqKx7Q6AcVw8FoVpV2UxJun+9FvHG+pgh856eq+XT7U6mcacRWw6vXyEzBubx02aAEGdHJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564127; c=relaxed/simple;
	bh=CqeoBi4LeYUWGs67NiKygU4mlFFyNpiUpjsnDzzg5Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMqb/4prqK/HTJ9GiV08jOR/uZFiKNrqG+9wVncCFYbLwgnxuVuahUntvYFH2TDH4dZdyxjgNCLx0BcAlT8zGkzsdTLF8BW+QIPtVsA6PsgH0xwo5meiMPh9OeBe/GqIbWLrNSzWnsrijOWJb5vesOhq0UUM6vBDZE/EmO1oNPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rYL8QMSW; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aly3fwQZMwpJOOU2cifVMQK4pdvtBj/pIE7twvwxavDLR9Exav8wtMS3dflvsNSZFKC0JKu2evd7TCPUbV7Rer/lG+PG8zu6C4i65Zfig5+pmioKl9YUH77hJ3OjcTOAkrU6CcnIlqm3qYLXipd/WGYpKU/MzSVbvpWHY9YJFQxBluir4j8vXIEwQsP9onSxjsB/U6vk/iwnBjO78xup2DfqHa7UyTg6LSX/e1lUF9ZSJw+2Lq53FTafDM3VnEn4MYi1rfBf5KUFP/Gy6K0EGejxJQ0PQDaWBqdei/uVN4A991KSpMbNpvGor1WiPawzYKvNxd27WLCpDrvBm+ICFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFt8JkiruWtHl2VrZy0hVEPXl35QYzXWag+N5tHx+p8=;
 b=ixha4Lq+ll0EfFIbNjcimsreiJaxvSp8CChk9E7hpmKs+yFuG/8ZGGtHCBg5o27+Tv/zWtDQN9Y7bFkaHC396JMUDsixvmccW918mAJcQ45v1annzTTbdq+xLBif1pBoScWJnIDQvoIgvC1iwoVfpuigolv89iucyf7XmGGkj/o+meoD8jTEa0kvGdpZ7e8R9VquZFREOPUvLXDAIlsRFo+FJlY8S0bvVcP/jPg06CwOpSEqQYpkUnwty7MqssH6nKE2bfM+NZVIAalATXFK3KLsNGkthWxXUjQ0sfGnLB/tya45uyhud+g8Ib/yS5CRvd2yMW17Sag65ji/1i3P0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFt8JkiruWtHl2VrZy0hVEPXl35QYzXWag+N5tHx+p8=;
 b=rYL8QMSWSNj3QCnHwikV/WhxR5uSyL7VrB5PpGdI/tcsTIMow30zNdbsDImMMrIC4nm6WM4hGUd4HrmMF/AlNuBNkeHgV2QOgBGQVmyZ34ccpHNffNwLFNmhxKJts0Xfn3IJEo/+ljLlxFc/EA5MJ6NJWDcqFiH0/h6UqEdn3YIKbLlYnOvydhAKkDVGqm0uecH2BXffOamoiGKqxW0BddNy+Wdu1kYgZrXrlSW6N4U1g1NqTT5E7QMCy52J/W46Rkh6Aiac9OqqO/Ju4L9B6GSM2GwyA3yoA/9LnDb3EXX56+KGJtj1jHIp4Tr57ajPa7IKu3CLvQ4RKqkRg9I2cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:55:11 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:55:11 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] octeontx2-af: siplify rvu_debugfs
Date: Tue,  3 Mar 2026 13:55:05 -0500
Message-ID: <20260303185507.111841-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303185507.111841-1-ynorov@nvidia.com>
References: <20260303185507.111841-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:408:eb::7) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f1aca9-a30d-431e-bec7-08de795665af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	UiwhKgIoPXXx4gO+PjnfDORO/aE5rsHUTsa8W9F1grDjYemunT+jSvv8H3YQLNcBzL+KLr1FUfroS4+fa8r3mzVlacMAyyxCjaRZ3sgvv1ctD3RcOT8LdO0Ff2OLcAYRUofKHVJv9zOVNloCHAQxV4S8JZZFFXdWWtcG8O/BtCqvAMj7lpSQ2j0soVvSaz7aa5CMBktVTUKZNll3fvqRW6ajp0j9rZVVFZhs1t8zCmoRg7vChGIKGE3SGyV9Covd8+M5o+sTBXly3XYyNc4VR4Me63gZ/jtSvbDT6ta99mQWWZ0TokulI/b8vX8oAYPHmm9W4QqQKF46Dh48EJ1qoioo4q+f/5pYowrgrVLK1sFg6ZZGGPG6HCsb1SKW6DlPUeMjRH87HhY2dJEeM2nW2ztC+zpVLKUp9qp347/gelqVXcMr4Fk3xKoNH9H7ek/hHGIC1l8RMOTpjZedev13X6eH4GZog/w6iKEA43iXirlRciZkhaV4NWDiyUOpqZ+/7bfcF4BUKjHP+YFJFi95OqD/Y/eDYajFEdBTfnarBU7XOAZI9V/YnjbMeTW8HG7PgHPLYbm3+pTqYs6nbKIMTUStBrlukElxB2//KPv9cKh8AkkVziqTuskoHjnG+OkwE5WIoLUhMlGhMykqQamr6pJeWzYPkiGZzrMYlCKlXTEzDnQL2tJjbu5WP5ItoWk5PiWLH2DWJRifbEy3NBcsgtvBwpdAQ/6YwPESLXhzTCQiiazECGjCutTTxgaTVMOgnun0b84fGsN1FZRLStWXMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H83VE3u/EvaHFkBn6sMMnxigDo7Moxi1iy71bU6p3Zd4rSM/7p+9NPppXIGd?=
 =?us-ascii?Q?9QJWssRiSYgeG/WB1rHBWBw5yYJDKcptH8haLkW3LjjLVOc35ROpEoUa6cGJ?=
 =?us-ascii?Q?ck1fb5fs5QMmr26Gm3hQPVy5uKJ5EBxEQCw1jp2AXiF7uaR7mdVVsIvCja/Z?=
 =?us-ascii?Q?QOn2jisCHiS9M+pHgIQNJmAJbh5ipGed6lafHOXTYiKXFFyEdAXFnmDSiOjf?=
 =?us-ascii?Q?+BoETodKiPshwhbtvWJHP+MWl1+eCXppJPai+9g3V4daQmih9cpXeeFOnwkQ?=
 =?us-ascii?Q?dhknA7GFO7LnVoYVKfpGj7+GSNzLFx9Z+e/If9NVws1BTU9uCh6XS+IMXVe5?=
 =?us-ascii?Q?97K8ACSu7ccmH7OXnD1kxw/uffUWA4XvFADOmqGOoJnz1RXDbrwjKD4n1AzV?=
 =?us-ascii?Q?bT5P12lmFO+2AX/+X1xiDUeC9fCuR7C+aYtyfTGSGd+MziumeiQYpStyWh1n?=
 =?us-ascii?Q?+ES1FQ2nzwYSKP0G3DdSTJh3pzCAo6XxEpfJWa6gyR/irJ6zXlaq8LJwYcUs?=
 =?us-ascii?Q?PUH4So2GQfv2I+/yVfbwX4098zFRyjDfhLVkLP5Xj7K2AMnAL1gosc0hV/Q8?=
 =?us-ascii?Q?vfA2UuvjnPoug3dfKxyEyThD0WY+uX+H/+Thv06jU8CK8V8gbVriCBSD4ofs?=
 =?us-ascii?Q?QqIrot9OPfE027JrkeamR21GQlOJddU0WKobV0iWuRuefPzFUIKprmKaedUd?=
 =?us-ascii?Q?CojFrOHjPkcE4nRsyTswj251SHEGN8sW7U7toDgVxqLV7nhg2MsgwW1d1ZcD?=
 =?us-ascii?Q?Lkqx5Vk9gyy1QilZ7p/VFkLmkLjs1j12613rFwza77/o4PK/1DEWjpbfRdIc?=
 =?us-ascii?Q?ON1RE1Phm3UV1Ne3OYjNvJlRF8OBSjFN1jaUiJsb7vqKNkKC8WzV4GpB7015?=
 =?us-ascii?Q?zCirPsBUlIUzJy7nLRDZK9R9NK+Kdpnh9zIre3zsMu84Ec9E460bmcI3BSvc?=
 =?us-ascii?Q?SMA4vVfqzekYvUrawfnZjUwPJG8UKs6gdYHAtIqvF8isq3vxLiqZWd8QOAth?=
 =?us-ascii?Q?YzeQa10GN54biEVddH+venpyJed+zYzqhWTgt54FgrFIz0cAafCcucjYSjzG?=
 =?us-ascii?Q?m3WzwROcwqbpytBx+fje4FD0s61nXtPCFOXsgDwa2tXnAvNlmdK6jlT1Doq6?=
 =?us-ascii?Q?DX6DJRuT1YbEXnyIr2CDWnzrhgddOoz+tde7IhGhOf3Vaq4jW/yUCNTYZ52Z?=
 =?us-ascii?Q?mGtq2KAKicgQBs0thGhoRVYxphcAet0JI9thTA4Ov4frwvIlAdVsLGTwIn81?=
 =?us-ascii?Q?yhMRxbjWcVdZTvquXriK+7uTcc0wzR0X8V/VpUwh7jpUSjoFE8fKhMnDojZd?=
 =?us-ascii?Q?Fpu9uVFJy9n2tzUc1klYF87e2m5dYM6/B/2LxZw+HxGFYGsdCF1rcQ1xAvwA?=
 =?us-ascii?Q?jKgFOItgFoP32y78RQZIU6mUyDuAZaJ8Pq6nKaUoh+E5+lzX8C/DtmzFhUgb?=
 =?us-ascii?Q?LJLqM92rGRpjbkViyvY7VUWh782psV5+OCFVymfThCULQ5V4886vTtriTBC7?=
 =?us-ascii?Q?KZw8T9uhVesmZ96pkbpTvfwA4ZRAAZTR/LXEndnQIdsSGbxb1C4PgFltnGlb?=
 =?us-ascii?Q?iexaY1KpCqggdG2AQAk6iQyrAzlRhtDaxAPnckUD58PHRY5B1z3g1SjMVFVs?=
 =?us-ascii?Q?QAyxV/fcy5qzK9dO0hB3RggfDQPSRFIE/Ssa88y4WSXTEC+TScw+TKDnaTLd?=
 =?us-ascii?Q?cJn9+Qt9XRIQCnlJRl65TX3s8mBZBw3j3CBOxufcTjWHbmIi4EwlSaLNn+vc?=
 =?us-ascii?Q?VEKgVsjxRnHVs3x8Hwp5JSAPsT/VlQi4isCPM/9T4xTOEFJX/HIe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f1aca9-a30d-431e-bec7-08de795665af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:55:11.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0+f2oCQ7osfKjxSeF7WKwYYzrGo6+NLd8qas+7oGZ5V7kUebhlo0Z5ahqv7FFfyLVKQR7eocfOK7jWr4n3Uqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Rspamd-Queue-Id: 523231F587C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263374-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

The driver uses bitmap_print_to_pagebuf() to store human-readable
bitmaps representations in a temporary buffers; and then feed
seq_printf() with it.

Switch to using seq_printf("%*pb") directly and drop intermediate
buffer.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 15d3cb0b9da6..159b910eef84 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -960,30 +960,21 @@ static bool rvu_dbg_is_valid_lf(struct rvu *rvu, int blkaddr, int lf,
 
 static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
 {
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
-
 	if (!pfvf->aura_ctx) {
 		seq_puts(m, "Aura context is not initialized\n");
 	} else {
-		bitmap_print_to_pagebuf(false, buf, pfvf->aura_bmap,
-					pfvf->aura_ctx->qsize);
 		seq_printf(m, "Aura count : %d\n", pfvf->aura_ctx->qsize);
-		seq_printf(m, "Aura context ena/dis bitmap : %s\n", buf);
+		seq_printf(m, "Aura context ena/dis bitmap : %*pb\n",
+			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
 	}
 
 	if (!pfvf->pool_ctx) {
 		seq_puts(m, "Pool context is not initialized\n");
 	} else {
-		bitmap_print_to_pagebuf(false, buf, pfvf->pool_bmap,
-					pfvf->pool_ctx->qsize);
 		seq_printf(m, "Pool count : %d\n", pfvf->pool_ctx->qsize);
-		seq_printf(m, "Pool context ena/dis bitmap : %s\n", buf);
+		seq_printf(m, "Pool context ena/dis bitmap : %*pb\n",
+			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
 	}
-	kfree(buf);
 }
 
 /* The 'qsize' entry dumps current Aura/Pool context Qsize
@@ -2545,17 +2536,8 @@ RVU_DEBUG_SEQ_FOPS(nix_cq_ctx, nix_cq_ctx_display, nix_cq_ctx_write);
 static void print_nix_qctx_qsize(struct seq_file *filp, int qsize,
 				 unsigned long *bmap, char *qtype)
 {
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
-
-	bitmap_print_to_pagebuf(false, buf, bmap, qsize);
 	seq_printf(filp, "%s context count : %d\n", qtype, qsize);
-	seq_printf(filp, "%s context ena/dis bitmap : %s\n",
-		   qtype, buf);
-	kfree(buf);
+	seq_printf(filp, "%s context ena/dis bitmap : %*pb\n", qtype, qsize, bmap);
 }
 
 static void print_nix_qsize(struct seq_file *filp, struct rvu_pfvf *pfvf)
-- 
2.43.0


