Return-Path: <netdev+bounces-207107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD540B05C9D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A62416441E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB2EA46B;
	Tue, 15 Jul 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neiGZKl3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF122E7F1D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586109; cv=fail; b=nCV96WNpdz4JyB+JWbCHmmWSL7V/I9eJ9qnGlUt6SZMRDh2q9OJ03nkLMi0XT7zCXu/3zOY/XmDGoFJ56xvnwzw6IJJKW+Za3kBUGOdAgFRsXg+Ey5SrYXvMvazQAp9V5lVBZOlb4oEZBhMf9Gati/q7UN5WpilvRBUsjYrL5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586109; c=relaxed/simple;
	bh=af181E0uIMIFuPdMMIjg+uynYFzH6YOutfpN+REt24Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShHgZz1kXmL8yrwLVTSfoVpFfXF6T54WEv/Ng9dAhQrKb8pJIx9aezL05xRmY0lhYc5A38yRXTik/kci/nd9V2rQdhA91lJ14AtsEITjb52e3NrfHNQxfG5gAwXjHLozrfbIt+xG9ITgwA3jmY2qqA6y1R/tc5CR8U7jKYX+nXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neiGZKl3; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG39yz0PWn6d8agqCL9MlD0412tOs15SjPxofh/IncBik8QXR6ZkJ13DRaCLZS7Lnc0VvnlqZRLjILN1ojP6K3AsZh5gt2971NcjRnRuaoI0I+1DDr1LrbjkpYd/nfD72FKIu/7GVuoQHiBU/4QXKJJRVgkJ4E8mmmUaQBNV9GUvdvKVWEZnHGM5cLiE3hVkdzLpXWq9r8NEt8nzwhboAP5Kt0XCXGkUz7VLjQIWuilYvMMSSx5wX807r68At2YWVpOiT+pnqv9EzW14riy51JwD6WrBHMvoC1YEoSCQZjt7Gn+Ob76bf6WaYS6UCk1ztGq5RZWCT9CUwpaotA0PjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ccRODhn5P7nG30Y3bDnYpBr1lFKec57v/MTuQyCRP4=;
 b=hwYjcfFKVMOJd7j0bI0kUxWa1XPIInpOII2cI2DwPROlv11pfh2eo9YmJtUdSZlnJ6rk8/5Bfa903v0CclFOdB4B1w5Djlg49Xly0eHeplzE9E42EjnNRtuVv219GMd/uA+T7/qiDoBqHpkhfsUcECNDS1ulxa0DvLZVq7xrzGPt51kspa60rOHEBlyEEKgGOYNzlgJoZUBnyohZl9lNcWPpkWbYTeml7GiEofy1CNxo0mTH/7P4osYYhF5TahAhPUrCMnVBmvC/LW4cnnQYMhZ9Tl3z38lf7tnB/WxNQVZFfJTnfEi7JLqjDXlpj7GG5ce3kG6IPmeiBkCpTB5qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ccRODhn5P7nG30Y3bDnYpBr1lFKec57v/MTuQyCRP4=;
 b=neiGZKl3oEwBKzdyZXZRcRhpc+Mu8Rh1aB9AtB5ddZwRO4e4HGhj9DrQe4i/mF0Oy388WoG/Kpl6/2yOxKtQNJCGXnsZiyocgQbJl2zqZMyOHUlF6Z75MuBRc2PmC0LKjWvH7cZ5iCd9fYtfJQ9Lvimo3G939rEsUHiFUmYwuPQu1OE6LKxvw7a19q/c7KbxkA9D4KSOGuklB6wRdea9Dl+hD2Kd9ko9/uleR12y5QW8APzuZQGiZfu2B+1XTV9tyrUYv1GYA8JvxveedeM5aj3kWxlgPg6Q7BZTlC3qLwXnZKftHYKFvnsCU39qScV3Qdle7pbSC2RTftt3TsLXyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 13:28:23 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:23 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v30 04/20] net/tls,core: export get_netdev_for_sock
Date: Tue, 15 Jul 2025 13:27:33 +0000
Message-Id: <20250715132750.9619-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d068349-178c-445b-b11b-08ddc3a378f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRitoUqNF5tBwt7VIeFOCV772rc1KV8td3PBw9Wob2+tgl3nOGWLPd4ONOQ+?=
 =?us-ascii?Q?yvtmo0NYsubMrrl/G9ps6hoZui9WgkeCflKst7FQLpC5lvTB9OmVIfOklgq8?=
 =?us-ascii?Q?ySx/y2LFqB6NwmPIAXMEl6LH+nRIX+t4YVAf6j+5nQoedcQHmmc0XXfHMcc8?=
 =?us-ascii?Q?ttpBDOQZW2HA+D+on1E5QMRsTHWhET1Lu7b0T7DEzWFj3tyt3jdIBbvQCBEV?=
 =?us-ascii?Q?WplrOKzqYk1D1FFb6Zl0xbmSwde69Ws1zxWaWcFlLVoXaUyHvoXQnXB0/nPy?=
 =?us-ascii?Q?H094RCXlf4z4Av24aWNUMVyiG+LbakbfJo1gWotEc/fYTl+0YcY1YcV0jGnm?=
 =?us-ascii?Q?RvVdYhgP1EM0Apz/YZmmv9U+95vGke8/7QdUqhRALvMjO3Oh2Sz25xAxQuEU?=
 =?us-ascii?Q?KS0fcu7R6h4o3yaR6l7pZ/XC9j53didchDFqzSxEDjC2+qgYiGAEl/L9q7DF?=
 =?us-ascii?Q?Q4FFfBvmPdBA1QTB5Vx9mQPWIy8rcT1qsyCr5wRFkkttYYdV640OjhN2J11C?=
 =?us-ascii?Q?9bxlnR12ut8ngEIljxss5TppWwVec7hKRVznLVDcDZhIOKDQa2HuPJ0j3/p7?=
 =?us-ascii?Q?rtvKmnY9G6V4gjk8YQ+s5qajMckq1ywMndtklkSEMEsZuCVdX28y4YrzkM/Z?=
 =?us-ascii?Q?M9YYLqXZZxkTYcmpv5B7AqKeK9nL483R4NurWt5A1/Uj93mbs1D5ULwJFG6d?=
 =?us-ascii?Q?AUOjaWMQlV+UQcCg/DS4hGwZ1y1Yzd6/GocrjfyVgBrxT48I0T+bJkl62ijy?=
 =?us-ascii?Q?4r11F3P+6i3RWfyKFfOUdkzt7EmYZk184zJsHPp7vWxYt3LUC+1TG9EYdvqb?=
 =?us-ascii?Q?GYtoaCQzr28FBoU1rem65Nik9ouyzPZ80eqZNLEnDNAkmyDkvVDs3XavLPla?=
 =?us-ascii?Q?aGLK1Cy/PSjN+8EHhvWIxh6EW6f8YP5PTk9w8Iu4MpH2UuTqn+mnA2SQHbof?=
 =?us-ascii?Q?2lqxx3Tu3unIHPb3Nt8CRgW+9KOqTmB4SZ3Vnja4hiWZjShpQwHlW3GY9ZDX?=
 =?us-ascii?Q?XVMNnG+rxtZSmqypt4hVcCxZLegLxN5A83Z2qY45KOEw6le4Kb6wzKMLXVPA?=
 =?us-ascii?Q?cP25gZ4f7HZFW9MIsskEoUUmn8fNOUtoxsku1xEXu5lj29x17BcHBvs+XT9+?=
 =?us-ascii?Q?o0J/wodh7jUkHeY1buYIc9daZ59BQvupT8RE49IwvMu+pD/tXYgZrlZJyPv1?=
 =?us-ascii?Q?JU+9kjH+4c6/3xVCdo44CJtzNZ4qZI7Kn3tmNcIAXnpcBmovSyzUT9ETNf4f?=
 =?us-ascii?Q?VVxi9zrOWXBja+giNovdvNCW6O5Ppg2dwPJJDHdZoQ4pgLvDJy/2Ceu2NLWe?=
 =?us-ascii?Q?c/E1fhzSI7laRPdL2c/uHcXW723auXE2TaPtcs4ZmW8loKmwGu+89m9KiQ+Q?=
 =?us-ascii?Q?hANlMuf4649QtWFRNBWQU/1VjRhjAf7Ev8g7LoWEyJVEbn3khdQNl5yrlw+U?=
 =?us-ascii?Q?kHAtZzPD41E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mlUk6xqoBBltM/aRxhb7pb6934zTxthMFb3dWTUaW9XvqjI22Y5LQ/W/tSu?=
 =?us-ascii?Q?oWgaF/DC7+vLePEe8jv7thxIXttg7GgGudHETqcMHObPae6KNdETO++QHDTz?=
 =?us-ascii?Q?YpFVrD3X8zQLATv4B0qAZnMgp3psI4QUKFBKNTtMxE8xi02MkZ4tyMTtmoeu?=
 =?us-ascii?Q?hzrgLeFHOdRGDOLcvanU/FAXDLrFDR96Vf4KAuxCFDWAzz46/61bFNauygvI?=
 =?us-ascii?Q?n/gWjPpSc25wnifhDGU8C1XJLkYpiIcLwixh7Et6U/2GyQtFbRiYqu39LJiH?=
 =?us-ascii?Q?6W9QYFT9NHkaEVwfTPzhmA9UuLQlkwcQpVuJjVwlF2P5RzSqSSEYUOrzjBK9?=
 =?us-ascii?Q?slSAd0AkaLUnMxs/9ePuq+g9lgxs4hR6SnmD/VTdgPr6TlwO/540pV4o8CBS?=
 =?us-ascii?Q?k7EqfBNfVGqSKR1fZe8ung5OiJCRjeuV+oxHxX+5t7NokDiwOpcQJOlg/Jnt?=
 =?us-ascii?Q?mhpLm0BwL7deDN6pM1R/4AaK3MbQZ7IdOSpSTOVr1jJHGncNysETLph2Akzm?=
 =?us-ascii?Q?uJ4gQwN7/WNO/cgrPBqZKnFyT0tsNuGccFApame90mvdv6ofXi6S+kqLC5Cu?=
 =?us-ascii?Q?Z8NZQH/3rxGtnBGguRreZ6jQ1dh2aZ05LGnEp4XfZoHgOZRKSfF//W35kWpx?=
 =?us-ascii?Q?mcBmzI/rkGxpLSQvxCvyeGTa9Ld9Tu5mNSJqdhdzpPqHOJ3s+h/VelUOLUcT?=
 =?us-ascii?Q?rinjGi9XRBQCgyh/LMXZ75oZFEU75hw3rKNF0OoF+NkkPCEmbeFYKJ4JBtv3?=
 =?us-ascii?Q?Ovk0FGZc1n35LbzSQvcaUPmfP1+PyF84+LibxNU2Yg4CZPaP88+vJQtGIF46?=
 =?us-ascii?Q?T1hSMc6t0zljuWAEdiV3pYIh3QcwE6LXyVL2mfGg2hmwUMApKElbkgWYv3l5?=
 =?us-ascii?Q?GKhmQPSL5d/DOZpVjo+JEQp6u03reAE7eLA6vSK+5wkUow/9Rf65AUtMUFdr?=
 =?us-ascii?Q?z+xIj+AkhjGZkdTFYkU1RIzDce3iSkgUgdDFkF0l1AQO+jBXKenvaNIJZvYc?=
 =?us-ascii?Q?BiT73cAOD0aRl39LxXlOgIKxeCQpLBs/H81gh9ogJuarMurBGsS2tgeBC0MB?=
 =?us-ascii?Q?9UVpWbQ7J2iNJWrq65VWqI1R6sHV8/i5TjEUHOrzp08x238VjZ/VXn/Nz5CX?=
 =?us-ascii?Q?TVbwkgM2kMAZTeVRcvSBE4rUHfBRrH5GyikYUX/HBHFA2EznreHaDq9hFlPi?=
 =?us-ascii?Q?IcSQv20HamXI1/yaT0tIxV8BIMY/BZmd5qJO8Lf8Yaui5vM46cHTwhtdm0dZ?=
 =?us-ascii?Q?xCKoeQfKX9nBwXaqRiYzHnQx853qI5JxP+HV9WnyajxFYyWVwjEG1dqQ3n+l?=
 =?us-ascii?Q?nypa9G2BwRECf6VxBSVAeV4sW1fa+ZZClp0BgrX72PO/EufaNFh1SE8F03iZ?=
 =?us-ascii?Q?jsz2ATfSlpl44XnWNIPdXuxwy7HRWAwZ9dyBkUqpx+41DrVf+mXYlRGJroZD?=
 =?us-ascii?Q?HDAhaWd4MAZKqlWlkmYH0hcszU2W43ozyTsMNkJgPv3xZPzOD2Ve9/mWV8Hu?=
 =?us-ascii?Q?Q7fwWeN/fnUzz95IOsohmxtl68prrc0ZMckr2fgNcBQ+yOQ5LFrw+D3McBNe?=
 =?us-ascii?Q?Wy65GoM9YoAXwDIZmKaL11q+ZMDlthNKRxq8vRki?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d068349-178c-445b-b11b-08ddc3a378f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:23.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Trhww2Rnp1FvwrouTpBBliyCNXzC/cCpv9yXyncnJkcEo9El8ofMdJ0RsGnTmXxz5/rx1pmI8xqDGixbehNX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core
* update existing users in net/tls/tls_device.c

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 32 ++++++++++++++++++++------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9897e974d7cf..ca455636069a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3392,8 +3392,9 @@ void free_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index 621a639aeba1..8825eba789e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9161,27 +9161,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
+ * @tracker: tracking object for the acquired reference
+ * @gfp: allocation flags for the tracker
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
+	if (is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..150410ee2c6c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -120,22 +120,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1060,6 +1044,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1072,7 +1057,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1166,7 +1151,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1180,7 +1165,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1188,13 +1173,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls12_crypto_info_aes_gcm_128 *info;
 	struct tls_offload_context_rx *context;
+	netdevice_tracker netdev_tracker;
 	struct net_device *netdev;
+
 	int rc = 0;
 
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1243,7 +1230,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1256,7 +1243,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


