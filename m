Return-Path: <netdev+bounces-282377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XI+DIlj+8Wl0mQEAu9opvQ
	(envelope-from <netdev+bounces-282377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:49:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B949444B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F9C301F99E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F913F54A4;
	Wed, 29 Apr 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rRMq7nFH"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A73F1665
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466828; cv=fail; b=oP8zx7n6UawOmA7exVwAi+K6u0iBxiKW6ol6l84UjD6uQm6/RHTS7EcRErCndtBUBw4nxq0hR6yOU3HG6KbI10SNu0XQpHnKe+0CSDJmHBk0ARPfoD7xDjfAOT7npw9BKI/YAjxYWdtRq/ZiTFxk+MW3aoAYY9mueCvXWf1kxZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466828; c=relaxed/simple;
	bh=wmwzEYzZGXuGj21Nj5S5oMoAwpAussKNqIZfLHFCOnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mm2YV1i54urP4LSLEZuIw2GM/MIhaIKjkPFw0GydeVW0Sjs+WpT0ybgAU+oGb6gaFPuj3jLa/emwG3kKsyB3D1Mc/bdy1hZ+cx/vC5fCme1VPL1uumFg7uPNXAVBHFKsu6rv+iUMGglZXNE3465XhVr5EhCJcD2rTUj+wXux+5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rRMq7nFH; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk6WZBwj5FnbDjg89vD5bQFzK6adqhJ/R9PNNnS1Tmimx3No91DeXsDtofPM3gOGpzSEaOD2lZSl7lCs+COtPNw0jPv/sNMvs5c7ReCF10XXutQUTrlaNVG6UEx+DKyXKL4h0iOodJ5+2MypEnDFO3sk8n6ZkxYYXjJrgVuiHRzCf2MvSojUEBTcEeYBoDUHfwdbQjHhyHstw19cRAxA7o3yozoWWO0/XMEIHNmArmpH6msNXS9zfelhGauJFA/VCha2kaMd4Zsh/wQydsm29OVqLyWxCI3XKd+0hDGr7dX/4oFbNtO8/tvoaika5dY9RX3vsiJ0TUkwMdyC2NZUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmvbZnF7gPLGCJ7d8CU7TMgbJzb1KTTEm4fTGXwQ8Lg=;
 b=j/EYUMnyRQdFCjz10Wy3ptea1Zjl8NBlBFNki1ibsY3ovUmTx6Uc+WX9ADoMtzSm5oVDLlqZd1zcMmrsvnsqShs/oae26yJyI0sUcPA7zhFUHE2qr4WkMDGFt8Wugcv2NHZU0FnsVpd1k4W1mbA+P0WsZ/ex9qEFFs4jXCesnMVn9kc6YuQFpT8TPzyV1HuOBkMvPPb8v6xtZjsB9y2OxWvcy7Wk5M6Tt2rplXUGhgjvwZ28VA61dQ+F9PdiJ4AOTPO4rIZxCGDj9ntd3+PEmoZQMLuEqcFP7w/zJO5bNUQst4q97e3dXur3u86Y5QImTl2DOgGgwjsdHpIZFQKe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmvbZnF7gPLGCJ7d8CU7TMgbJzb1KTTEm4fTGXwQ8Lg=;
 b=rRMq7nFHTOFziab46XMgUsENdV9Dv/M+ttX+34lDCn/OHR69I6IrmSb4Wo3CqondDf8Fg4usn/mjOoSH/mBay8mxj6BfJc+ALeqMrGgsPayHiDDs8BeVvZNXvjN7hj6OqiMABGJG7GsaZm0eQd0k81yoEGxFhIAYouEzpBCUgoaVEzjgfVpAhiwUlQmbRa9B7+9WDgw9Vojhskv82ZgfRFARuDnWS5Bv77UqAy9QsfSV8twp7UdOL49EOndsRfRhZBwCHH45hfarljB+gknv5Um3cB0UrZyDnvcTklraQ22BTHTygHbD+ddHvYgH0c2QXo6SsyRqZSLueBYz/iPFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:47:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:47:03 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/3] net: Do not unconditionally turn on carrier when clearing protodown
Date: Wed, 29 Apr 2026 15:46:22 +0300
Message-ID: <20260429124624.835335-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429124624.835335-1-idosch@nvidia.com>
References: <20260429124624.835335-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e35216-3f2a-4b0a-f992-08dea5ed69d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lU6RYtmpH71re0VI5YMVtzb2ZMa1egZkc4fPWRvJSc0XYwT1h18rSRUlW3WXdYybfsUEMF66IU2xIgFvnv1m01UgfhTx2gGmAC1wSOGOl6FubZ7luBVLzunPZ7fwbQVqwz5GR+SX2TU5DsvRtkQo5tQhtAdYrWFKbKraAgeAWH5bs4zPa8aYLU0UfhKrSWAtF/B7mcXDjCYL6NlQQqykq9XVs+Wqay9S6Pt85r06Cgv6wNvyIPUA0rKqYsg+L1Mz19OrCzbKyKOicqSPxZlBbtJlQW/qng/PCxgzFza4dfIjPKQZRmc9JPz/tB6uu2TUysBeqTXuPoIFDbWjvhWnCzNJmLUzd1/irCZDQgoaZ+pucauAQbHqb2bosG4zFNfuh7yI4Gnh/f0zNc9uWe0ZtYh6UOkDwpIZKXaAvxRFXMI0tuJVPg/+2T+4y9zB6XSRolmpPpVeXS151sd+BlUeQAg+170ooscHV7vd1th841szPS+5zS9XpnRHgHydDvk+qr6AjVcqZEEdbfIcKR6iOC1ONVLjJf9LEOxlDrl34I34DboNjgTe6XbXNuRCKs6eNiKOJTgMsmnaKS4SYxPxOT/eyCwRvHWH97oS+rukUIolumihSDUcT7cCOL+sm8EjJ1rTfamZ3Xj28mtTNfSlamf0zDjLt00T2fEfNH6r51aLbN+tsPhgrso81/CWPQfdxrYLtt6GR/A/Ie+V3X/NeaFoQfnpBA+lxz1GwBb2Pro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unm64YHU2W5588090UQL7ClCBxCXbcnT7p5+xrl3zRhrgTDfZVJBdbXkMURC?=
 =?us-ascii?Q?ImD92tlHTEKq3oAq0Br0TayJdNJQNydzazeklLVeGFvEg4SLNBCP2jX+JOa2?=
 =?us-ascii?Q?L8+eJDmOTyGI0ex35QoksS4WGYIcKilRoe5HDzeXCqhhHA+waVPfCzu3NEYD?=
 =?us-ascii?Q?A/kN5TC6XjS03femjm7QuLtiUkERnaLY4n/r7IKp+WaSJLC8ucWic9C2Mhnr?=
 =?us-ascii?Q?4CxYNHcbDk9OySMN/CU3j7XYj5aLSES3KlV0oAwU1miI/i2Ej3/C2yshujMk?=
 =?us-ascii?Q?L/TIa5gUMe7B/j0+UmPi9cO8xsqZJVb9jblgoV0Pe/yViut6BVZuLH/qa6m4?=
 =?us-ascii?Q?hMj0td/kDccrmfO8NRpmyI97E2O3Z1QMVwow2tG2/qq0PI+3acECONOzNzqQ?=
 =?us-ascii?Q?YBqzDeb6wtCZFq/WKhY6SCQfOX5SuU0LganUWUHSWgjqvhQsW9kfTjopI+Pk?=
 =?us-ascii?Q?H/3jS83i5YaMW4ndXVK+IDDfjnuoRtKSt5+qi9Mo/2JuwNy1gdB4YlbAb4Y6?=
 =?us-ascii?Q?KL1EuaQagsRoISxd6KlUpfOMr6wS+TelEG3RYcMkMqId7lk/yIb6KwoYAPQX?=
 =?us-ascii?Q?eSjk8YmOM2ibKtSqWLr+Jy+B8SjsfUm6zd4dlnquWK+fYUXo8+/puU1awQEI?=
 =?us-ascii?Q?GKtHY/xFvxZWaIKdJdN4xMRyEI78m3oPNK+/zULIqrTyEKfn/5WVV/NfNg5H?=
 =?us-ascii?Q?cCUjT5O/UNZGFkEJvHHdAFSaFRh0YJX510qLptkUpc0A+4u0bgK/YYVY0NH/?=
 =?us-ascii?Q?fSc0Nhhn3kWcI3X798nfmoHtMe4SYpYdJI1qYSw5KSNhtXjaqaTM6BI13NZb?=
 =?us-ascii?Q?0QM2nziNBhkN2pOG4a0f8Niv/7dwI5CN1jduJ0EEolWFGk0i6Krv39SaOwEE?=
 =?us-ascii?Q?4PCN9IynIIID7YA2aGsOKtRPQl6/cQZ0NVr0ZWaLcHuPY6etmZVXeKmf7YL7?=
 =?us-ascii?Q?ilGNxlQBZRGAnTJu0b4tENdlo7WSyYaO2MxvHIcuXcKsluLexCfpS3SjaoUc?=
 =?us-ascii?Q?e8YFYt2tybcEYP107wISnuiraoWGDgW+pyCWpdfkLhIjmvpPSQxbUBaLiRWO?=
 =?us-ascii?Q?FoRGffw1E3U5Bxm7lgdmOr3xc14hWqy4UYLhJKLE6ATSPnulKoJj9165Ksc7?=
 =?us-ascii?Q?XFiigztPtfUrteLJGBRC2iIzHUoVOUnkO8OJ5ifkcCOyQoQaN6/HDiDa/XoG?=
 =?us-ascii?Q?ul3JzxG6tdh/Wly5NEbA0MEA2KgiREqhrND/Vpb4aHmgDEABEh8wsVa+hXQX?=
 =?us-ascii?Q?s6uwN4SYZMWa5k15A3V+3eH4XqDpDCRqxhokqL5lW4JWfwWHalxM0nuwQlaK?=
 =?us-ascii?Q?cuvRddbXDKHh+fgWvI/pH4cvoebSp3Z6xEeFnV3mblz9iExVf+6LVbHUIJk+?=
 =?us-ascii?Q?WPFvOSqhFe+XA1y8nlxN+zTI702WMPOvLbAnexG/yxombycj/zwD9ZFujDoc?=
 =?us-ascii?Q?vdEnWLnqvH/Qsuf7M9fAchvNB1OSALORwQWMAk7lidTTqjpKag83Yr9x4l3i?=
 =?us-ascii?Q?aPiQie4QexPh7O4+SEkgxgJb9RLGZHiZbrI7yeKYoH/0pZ5BPbGt03zf5u2u?=
 =?us-ascii?Q?ogNnRPsRvHIqonwuv7+t8ECyHvGODi19vOHJbxiNSMCZCs7MHsVBupU6TnJn?=
 =?us-ascii?Q?s6ezMp7/turCerqg2BGdEy5f3VI6MwPClku5gbFLKUqfnhURMYSTec3J8QFo?=
 =?us-ascii?Q?gClmr5ruUJYe0hh1mPb2ZgQhkUD044nt1UyQsg1+xAw1Gk0P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e35216-3f2a-4b0a-f992-08dea5ed69d0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:47:03.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/W8/Tte/+7dZNTOtHKMEht/tTTpRk15/K/iXD4/VRAOfT3jLdhZV2rW+c3/6pwl7wgK5qe+KxKWErjnen8b/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
X-Rspamd-Queue-Id: 105B949444B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282377-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,dummy1:email]

The protodown functionality is currently supported by vxlan and macvlan
and it allows to keep an interface down by turning off its carrier:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

When protodown is cleared, the core unconditionally enables carrier on
the interface:

 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

This is wrong as it means that a macvlan can end up with a carrier when
its lower device does not have a carrier:

 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Solve this by adding a new NDO that allows different drivers to react
differently to protodown being cleared. Change the core to invoke the
NDO and implement it for vxlan and macvlan. Maintain the current
behavior for the former, but for macvlan implement the NDO by
transferring the operational state from its lower device.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Make the NDO only about clearing protodown to avoid suspicion that this
is about re-introducing the NDO that was removed by commit 2106efda785b
("net: remove .ndo_change_proto_down").

Remove net_device::change_proto_down since we can now use the presence
of the new NDO as an indication that changing protodown is supported.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 -
 drivers/net/macvlan.c                                  | 7 ++++++-
 drivers/net/vxlan/vxlan_core.c                         | 8 +++++++-
 include/linux/netdevice.h                              | 6 ++++--
 net/core/dev.c                                         | 4 ++--
 net/core/rtnetlink.c                                   | 2 +-
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..267af4957b0d 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -167,7 +167,6 @@ struct lock_class_key*              qdisc_tx_busylock
 bool                                proto_down
 unsigned:1                          wol_enabled
 unsigned_long:1                     see_all_hwtstamp_requests
-unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
 struct list_head                    net_notifier_list
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836b..61effa295c49 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -904,6 +904,11 @@ static int macvlan_hwtstamp_set(struct net_device *dev,
 	return generic_hwtstamp_set_lower(real_dev, cfg, extack);
 }
 
+static void macvlan_clear_proto_down(struct net_device *dev)
+{
+	netif_stacked_transfer_operstate(macvlan_dev_real_dev(dev), dev);
+}
+
 /*
  * macvlan network devices have devices nesting below it and are a special
  * "super class" of normal network devices; split their locks off into a
@@ -1211,6 +1216,7 @@ static const struct net_device_ops macvlan_netdev_ops = {
 	.ndo_features_check	= passthru_features_check,
 	.ndo_hwtstamp_get	= macvlan_hwtstamp_get,
 	.ndo_hwtstamp_set	= macvlan_hwtstamp_set,
+	.ndo_clear_proto_down	= macvlan_clear_proto_down,
 };
 
 static void macvlan_dev_free(struct net_device *dev)
@@ -1230,7 +1236,6 @@ void macvlan_common_setup(struct net_device *dev)
 	dev->priv_flags	       &= ~IFF_TX_SKB_SHARING;
 	netif_keep_dst(dev);
 	dev->priv_flags	       |= IFF_UNICAST_FLT;
-	dev->change_proto_down	= true;
 	dev->netdev_ops		= &macvlan_netdev_ops;
 	dev->needs_free_netdev	= true;
 	dev->priv_destructor	= macvlan_dev_free;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e88798497503..a3ed9fbd60a6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3271,6 +3271,11 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	return 0;
 }
 
+static void vxlan_clear_proto_down(struct net_device *dev)
+{
+	netif_carrier_on(dev);
+}
+
 static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_init		= vxlan_init,
 	.ndo_uninit		= vxlan_uninit,
@@ -3292,6 +3297,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_mdb_dump		= vxlan_mdb_dump,
 	.ndo_mdb_get		= vxlan_mdb_get,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+	.ndo_clear_proto_down	= vxlan_clear_proto_down,
 };
 
 static const struct net_device_ops vxlan_netdev_raw_ops = {
@@ -3302,6 +3308,7 @@ static const struct net_device_ops vxlan_netdev_raw_ops = {
 	.ndo_start_xmit		= vxlan_xmit,
 	.ndo_change_mtu		= vxlan_change_mtu,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+	.ndo_clear_proto_down	= vxlan_clear_proto_down,
 };
 
 /* Info for udev, that this is a virtual tunnel endpoint */
@@ -3368,7 +3375,6 @@ static void vxlan_setup(struct net_device *dev)
 
 	netif_keep_dst(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
-	dev->change_proto_down = true;
 	dev->lltx = true;
 
 	/* MTU range: 68 - 65535 */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..3757dd6604b8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1432,6 +1432,9 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * void (*ndo_clear_proto_down)(struct net_device *dev);
+ *	Enable carrier after dev->proto_down was cleared.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1683,6 +1686,7 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+	void			(*ndo_clear_proto_down)(struct net_device *dev);
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	/**
@@ -2062,7 +2066,6 @@ enum netdev_reg_state {
  *			ndo_hwtstamp_set() for all timestamp requests
  *			regardless of source, even if those aren't
  *			HWTSTAMP_SOURCE_NETDEV
- *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
  *
@@ -2476,7 +2479,6 @@ struct net_device {
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
-	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..ff66762592e4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10143,14 +10143,14 @@ EXPORT_SYMBOL(netdev_port_same_parent_id);
 
 int netif_change_proto_down(struct net_device *dev, bool proto_down)
 {
-	if (!dev->change_proto_down)
+	if (!dev->netdev_ops->ndo_clear_proto_down)
 		return -EOPNOTSUPP;
 	if (!netif_device_present(dev))
 		return -ENODEV;
 	if (proto_down)
 		netif_carrier_off(dev);
 	else
-		netif_carrier_on(dev);
+		dev->netdev_ops->ndo_clear_proto_down(dev);
 	WRITE_ONCE(dev->proto_down, proto_down);
 	return 0;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b613bb6e07df..30951e5a9555 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3009,7 +3009,7 @@ static int do_set_proto_down(struct net_device *dev,
 	bool proto_down;
 	int err;
 
-	if (!dev->change_proto_down) {
+	if (!dev->netdev_ops->ndo_clear_proto_down) {
 		NL_SET_ERR_MSG(extack,  "Protodown not supported by device");
 		return -EOPNOTSUPP;
 	}
-- 
2.53.0


