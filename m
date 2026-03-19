Return-Path: <netdev+bounces-269641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBRCEB9avGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B609E2D2019
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 593333182D07
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75F3A16B2;
	Thu, 19 Mar 2026 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOnh3t8j"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117C3793B1;
	Thu, 19 Mar 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951447; cv=fail; b=m5BYiJxYGpVYO5Pt8IP/rfuZQd8IeMy7JB8SYJsVcUz/ZRMObFYyqk8nga2HdWy0XYfuW4XjE+fbnsB88G2WZ/qjGvb4oTR5YRDRDf+MZrY0Mp+SZjwOWmgE5LAXEPwPC9uuOzS5shVL0s9BntXlxjsaWgdhwDjFmlxkR0flG4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951447; c=relaxed/simple;
	bh=bTC2ADobIr6F+VckdIzptwj78XTRfMEK++rrWXYjpzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cACtfxTkxYqfvNoR2swBjNrwgvlta49Ehyliv3WVjU5KM9R8XDZ2JO/iZ1Ai0AWG5rWhbq2JoGlet/mL81N3j6V1RN2wcXTpHcXkVk5i/7RqffsImfER/CaDdyZy021ja1bjhkbENHJSu/kSZJATqgk1jFDFunNtS1SYrfeVBYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOnh3t8j; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v78KV0Zuk1gMHHm4OuBZ8CuYwVLLLriKAf8r8rxq7m02ucSa/R8whBrRXJPAN6/cl0kO6SNQHfxPvnPbt3sf96LYSfSweYwBTVWm2qdtqhlKuYlrzoqityFSWI2LpRVr+ESAJohywqJOSc+scrCmNPiDjN7xdLmHTbxykU968I17GwHByZiAI+54Yd76RzWeNR5ujrMDaE/NdX6C/hMG2X6WDpV8xeUhO/2i/iv+EGG1jAEMi0Pnv9KHiNelHUPEBCg190MPZwBwTVxEzg0dYetSYv2F+3QHHXBjamv+H3bINLIdfsuO8YcknhHg9gnpZeFzLpEk2x9vobJdq0XBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+pN98pjJDMWbBxTtZnAHlMdsbYeyIAq9BEbyfOoey0=;
 b=Rc3tB/o0OIFo3N++Xk8q6uUMIvl+NkDR3sipiO/cT/x3x3wiBPKThlM4SAMfIVDxuUni83Lp/JABlV/+gGL7UqHnLYMpLRB9x0mopyO5DWu09tqKmxc88k7pnjxXTssnrgvugNoXs4D0x9Dvf9O35larqKkcSGHK3WtWAblv+Wt476wYBZB7ACkuv2iMClXJUoVxBDNd+IDUGsI8w/tFSwSZFMK+PHaFdO+Kp0kW3w86l37PrkpyT3ozj6suHhcw0RlCQft6Y/FCylHBkHjF5umkmrwXomEXSizXytSkBgDmPBtsKRjChvmkK7lBMfKv/yfXdR70mGWv4Egjcyyq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+pN98pjJDMWbBxTtZnAHlMdsbYeyIAq9BEbyfOoey0=;
 b=aOnh3t8j5mIxJzeiHIjN8jOcuf2dA76Ed4cKEygC/uXJaz4sMngY18S22jcuVzOtreWfqJ2Jtaj6bSQB3p6/efBK447JRmA330cDT9VVyKvhMQeOfnhQYaPdy+1tLCmiyHQMPpfDOhWlZZOyo+JBzqwCayDz5DSdUw08tXw4nFNUDGBtaEeC3q27rAJHXg3UVytTXTOkC+vFBXZrDaHHSFyRlexsIVle0YZITODbVg0K+6CC721/HwJsENyvh3a4vK4xGwWS9VE0EhOGojBpmclWfm2mtDhMN0dpSkqw1qdK9y8nQyqqfqdPVNmAIrdGuCbYI0EqW17Yf/OGM4nEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 20:17:20 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 20:17:20 +0000
From: Yury Norov <ynorov@nvidia.com>
To: "To : Jakub Kicinski" <kuba@kernel.org>,
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
Subject: [PATCH 2/2] net-sysfs: switch xps_queue_show() to sysfs_emit()
Date: Thu, 19 Mar 2026 16:17:11 -0400
Message-ID: <20260319201713.941956-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319201713.941956-1-ynorov@nvidia.com>
References: <20260319201713.941956-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:408:e5::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5a6bc6-c46f-4cca-da59-08de85f485f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iJVJ/8tDp8IePdKMGv4Qt979qPfkll4S6ZaLj1xyoNCDMtoZ3pjxd5voEQH8uBi1MOpjmFHv+4sxirdU+/2tjsnY2poqOxPAbo8m6XFpAKJcjv84Ibd3+0XPoc75TwpQ2XSmGk0O7lRu2Q9JJeuiMPBUWbPkpol0rllvoUGCx+ORpPkXKnV6ZtI34kdhx9ycYKAjov+lvdFjPYXNqAGE1JwZKzPnhQoVvqCh4gL/P1EKcmZPyXH6iiy6jcV7rCYBsI5aEeZ93A0Uzuvjo8K1Kh0rhpurFYu537fNKncDD05yApSez1dpqgakU0BiW4TxgKweqg0TAHF0wvw0FqXitm92EFU7IUQSLVHBpQVQnyhp2RaY/4w2v4glRu59p0AT/R4M1fK3P5RobTdoFvhR3YwONRpNncwteXs67g0tBeIelrobkMKhbl4Nl8+5vv7EXmud1vdZshR9Rrjdi6A/ngKp9vcah1F3M0F4maFhgY5g5Iv5PbS7nc+tBid6N5/8o+tzy6WPlSevdIZ0reJrjchZUflMwNCAGeBIjtyEkYSEORmWs6uPKnAWJrDvkayXKHAFKKNnv5JrcoJrrJghbLidOvFyNjcTp+FneanYFKcZWEQI/7nEBbGI/uNv/bpboaQa+MzACfhMEsjCPhjmwIO9oJalqxPSCkfJbDExOP5rI9MbDek7EwAZde0z4YfIB87QFhpKiOmRvY5ARa19jdR1Fh47LHaw9KfMqstNuGh3vP7NIY/7Sy/ZCj0IB5EN30aoMsi48G5F+I36TfEqLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJIeHY5MzJTamRqcTkveVh6UG9hOXpJZE54WkExZmJ5a28zS3JwRTNQWi9T?=
 =?utf-8?B?SnhWU2cyQXp2aGxwM3NpVmw0dk95ZTdKdmt4dDJ1OGsvUWVMbGMzTCtGck1y?=
 =?utf-8?B?cys4S2VsVTBnMWV5Z0pCL1dMemozM2I3WWRPNElzQnpQcUdNOFhtUWhUMGNO?=
 =?utf-8?B?Ry9qVko3azg5MGU5djhYbFY3NUNwRHNFdW4vMzdoa3dWa2QvaWZQVWxwVnJE?=
 =?utf-8?B?ZG01ckVCNitEWG0zdWgzQlROUEI5NCtKdDIvUkhOMmttLzJzay9lbHRDSUY0?=
 =?utf-8?B?KytHdUI0cVlkWDZ4cXJmTHpwUFV4QlgyK0x4NENCNGRYRVM0eXlLM3pxRTd2?=
 =?utf-8?B?cEo5Y1NOV1AxaXhIVDViT3lEMVpjRWdLOEEvWERFb2hVR0RmeWhNU0ZKbnhC?=
 =?utf-8?B?OXRnSURtN25KMk5WeDh4WlZ2UWFaYXM0dXFaVk0vTGJGYW9BeTF0aWIrN05O?=
 =?utf-8?B?Mm5vVFR1M3MzZEdaSkV6aFY0OTFLdzkwcHJnSFZiVEFJNkpvTUVkaXd0YlVE?=
 =?utf-8?B?OWh5S1loaGp6bEVWc2tEWXdlbzVZQUc5ZFFMdkdrMHo1S2gzVndCdy9NWHI4?=
 =?utf-8?B?R3I0bTE3YUsrdXZrY1lvZlZoc2ZQVGhOYlRPM3FjMlVZRDBlTmJPZld4RjBO?=
 =?utf-8?B?Zm9UU1huaVZ5ZlYrem5CVmdMZTBYeTlBajdKaDVJRi9ZcGJMSnhvMmdJbURB?=
 =?utf-8?B?ajJXb2c0ejdhNXhGek11WFB0MG5OWnJ6ZVcxanpPY2tScGNvM0hGYkZEUit4?=
 =?utf-8?B?cUw4R0krZU1aVHYvTHlpLzlrVHpCbDVVT1hzUWg5U00yMWFwZ3E4UlREMWZ5?=
 =?utf-8?B?dzRlTGtXd3pmRmZzalVUcjJETDBhOW94QlFkMHR6MDNkQWZHajJDeWlLSUhx?=
 =?utf-8?B?SkpMVzRHbExKT1NGQ0VrVXFWd3pWSUlRdTFYTEJ5ZkpqRzJCcVpOa3NES2VY?=
 =?utf-8?B?Slc4TGZGUlZLUE5oOUNMZisxMXMzbi8yejUxSmRpU2tPeUxoSVFHY2c1YWlT?=
 =?utf-8?B?aldHVXhqd1J4MjF2SEFoSFVlRTd3VVZySzh4aGx4dlZmUDlKZHpaSUUwcUVU?=
 =?utf-8?B?czN6ZHRFck1iYWlNRndvejlKTStQSlBHejJ5MzJHZmhhY21yblNraVVWUTdn?=
 =?utf-8?B?SnRHTGNTZ0prZkxCM29BbzBucFNEeGo5R0lDNFVPOVFzQW96THlkNUEwWFor?=
 =?utf-8?B?UVordkhDUUNVckZXdUhqOXQvYU1EMEo4UXorU1hvRDFZZFE2dnpOMlR2czB6?=
 =?utf-8?B?bVlpazlKNGJaU1BLaFBPVUNRS3Q4NTNzcTVmVGpRODhtNEZZTGdHNjV1QTNP?=
 =?utf-8?B?UUkrN1BaUXNUZit0UVpyL2N0TDAzSTM5aXoweWJtVEZ3K0RvTHBnaDk1ZzNR?=
 =?utf-8?B?RUlXeVFkOWhmc085Q1pNbVZyK21SY3JsTTFKb0QvbDZUQWpYVTdPZlRyUk00?=
 =?utf-8?B?dGdaMWZRWHQ1WFM5dmdJNDFucUhPTTlqSkU5UC9KUGExdTMyRnNMV2dFYmgx?=
 =?utf-8?B?YzU5eG5LWjJKdWZ0MkJ1eE9xMytEbjFMSFBpU1FSQ0lWY0hNK2p1ZEFFZ0lU?=
 =?utf-8?B?VVlINkQ3YmV2U2NQMGJjUENrdWZzT24xZkJaNDR4MDFVd2tmVWU5U3hqUS9q?=
 =?utf-8?B?VXlSbnNkQUJUT3RJZFdjd0NZR1dqTGpWU3hqQ2hCSi9xbzJaRkVzRUdVR1FG?=
 =?utf-8?B?SVgxV0ROY1Y4blNFOE9jem1DbUFqMm04WWZLK3RmYWs5YTMxOVhIcWEwNXFM?=
 =?utf-8?B?S2Erd3prV2pCR2p2SXNjWHR0MnM0N01ObitFVWVNY3hUMDRxbEZsa2tCQUJX?=
 =?utf-8?B?NGtkdnZzcDhxdmQ3ZktkZ2RkWVlvd1ZTNlMvd0twa3VRbUpTRnBEZHVLci91?=
 =?utf-8?B?ZVdGd0UwUTdmWGxCbzVXU3hoTWhmdWRXNGpBNDRPUHVhcTJ5R3FvbWJQdnBN?=
 =?utf-8?B?ckxUaEc4YVpHLzd0azE5T3RBb2d0MEQ5YjBCRkFwNTNNbTAwNmhYNWU2d25Q?=
 =?utf-8?B?SmxNMXE2ZjhrQk5ZYmtjNk96MHpKMmduNmVUbVBzekx1MXNFT0gvN1JEWUdz?=
 =?utf-8?B?ZVdTNDZxdk1QN1lSUkkzOVhwVnlNdkc3Rmd6bE1IWE5hakpRcFdlNWtITWdS?=
 =?utf-8?B?cXlqbXNQVDNVbDlXZ0pXdkFBQW14djNFK3RnVjBwQ3V3N2RHTUp3NHo2NXVO?=
 =?utf-8?B?WjVxNXZqdXEreWdTRHpsYUdYSnM0SUV2WHIyWFdwaUtGb0dkQTJ6UnlHWlZB?=
 =?utf-8?B?NXZnZC8wVkhCWGExRlo5VmYraG5DQlUyL3puNUZBZ2RqQXdaN1l5c2hxcmxv?=
 =?utf-8?B?MFlQeXROM3BYOHFHeGNINmFTTkxlT1lOcGttRG11STNxcE1mMHRaQ09RVHlE?=
 =?utf-8?Q?coqkGwY6DgXYiCH2pPe1EiLuoU5fQPMRLwp/v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5a6bc6-c46f-4cca-da59-08de85f485f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:17:20.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rD9BUtQBDHF1n/rTKolSS9y6FetKKPfueoc3YOsur/zsvI5NKIknDM5O9qWqko+fDAVfDK7ovXJWAkeZrZT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B609E2D2019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch the function to use the proper sysfs_emit("%pb").

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07624b682b08..a260f8b4d5c6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1754,7 +1754,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
 out_no_maps:
 	rcu_read_unlock();
 
-	len = bitmap_print_to_pagebuf(false, buf, mask, nr_ids);
+	len = sysfs_emit(buf, "%*pb\n", nr_ids, mask);
 	bitmap_free(mask);
 
 	return len < PAGE_SIZE ? len : -EINVAL;
-- 
2.43.0


