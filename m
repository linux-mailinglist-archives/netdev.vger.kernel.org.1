Return-Path: <netdev+bounces-212922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B454B228E9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B5A680A1A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E49288C23;
	Tue, 12 Aug 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dv3O5gHJ"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013059.outbound.protection.outlook.com [52.101.127.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49C283FD7;
	Tue, 12 Aug 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005580; cv=fail; b=LLq/wejp71BuaDA1nVWSBLAnlh1VQZM0P46Y9szdD2ph6UJ4u+E04GfcqQaZgcZE/8Wfjy0J37WApFkS2kObrFwZ6CD/FPlWh+C507kfd0r4h+Z1zTXXzdvQRqsDKGJ1yJVGeRKl4b5OuCia8it0ZINrl63n0kRvFhm2JoaoLOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005580; c=relaxed/simple;
	bh=0voutUQ9m1tIej1vnr901XwPpkV6SnwIcmi0WnGKBoM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIvc7jONlJiMIw0JV8x29n+xX9UXDe9EZoLijl0ubICSH/DXn6MIdkI1DdJktKpcXM7pHx4DK06V+4z4BbXCkm3XPkcdzQa4jqrvg4NC8HYw1h5rkOssfM/hhc29xH/WIAq3zFdYeDrccMtN+/T1iU58LPDNQy7xf/uo4Kr18EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dv3O5gHJ; arc=fail smtp.client-ip=52.101.127.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN/R0ZZRdZcMfnxoTJ+DDSkkjAOG9AVR/vrdFfpge3+wPEFP7f5PsJ5okLYwXBqL1gHjDE8j+Vz/x/SmhgJ9V1YtK2l3fmPK75KnJzprXA0uzOtAF6bzRFrGEDCDRrfVudnm7seKYNUS6m5F0HmaS2B3YCTD//myGNlk4gh3YYRFo1m2X8h64GQszAMgYr5tqI+CWfLH0Q2csgzcfYcqFKq70D9ZXbJNS3pVuJ0LNdyr+hUkv2PR/OlQHOYwJK7OnRnmVzL1Yu6jMQP+NBePwIopdswQrKBKqRm3cc6Sb0jsPzMU98XjsO+YWoUJwbIC3Eu4RWvScLwgao5tJQ0T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9L5CesIFU86Nlct0DDjcX78VMZVohBh464QTwAiNe4=;
 b=Hm+0k6hvF92qUShwQMRMlJuFIISQNsSCE8Y0Cwtsr243EOVjgthCYUFZykNKFRxyUDBcFUXITq02vRw3HaUMz+YhApL0LBfkMjmf3up0laJFvf6izDhvdbpgWvV25KlzFiwZofQCSTmpTSrmxNMKB0P+8fs5duETr37MTraXcwOCm/26w3BqKzGNNm/7wwkl6zE6E6MW24vFunQsMlJKJjaWOmmA42azKoKC3qHBZ653rb454awXExvQ2/LXcC0+4tSTM7mQGo2GwXtC9PMAh2caHfvOzbD0Z3S/9q7gAbustbdCcWu7GfdvTl+crPw6EYy8CYf8ZXWAzAY2AmGGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9L5CesIFU86Nlct0DDjcX78VMZVohBh464QTwAiNe4=;
 b=dv3O5gHJk4HS1rJjpnAIQF2DTEX8P92bfCeM4GQv5PhmzsrEWNbBPq9sMy6sKFngJTuiWPhTczYj2QNMvGac5cKNBKAIFaGYh11AeX3PoAzGCXQDfFT296vvg2kbrSO2zabyp7zp0DjP16TidDm6/2ULEkeifbqK7v9yfe3O1SboKMdP9SFpxOVz0SoHShQQ9XBuHjaq9jCSF4wUDiJeFRUo6dHAnF5RHybW1t3KjOKFvGrRTJ1N7f2+fEAtcbcTcbFamj8sg7Z66BqGcz+0HLdV8Kto2E2/AWyHpAsNmmFDCScVx0mCQaoehiA2LMIslvr4vfwg8HkFXW77hqE84A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 13:32:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:32:55 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] nfp: flower: use vmalloc_array() to simplify code
Date: Tue, 12 Aug 2025 21:32:15 +0800
Message-Id: <20250812133226.258318-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812133226.258318-1-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0feef3-ce7d-463c-e6ba-08ddd9a4bed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNtpMYkMo5mbMIkGJDNoqKHL0up+uQpE22TEMsrJBaNUQIxRFfaTWqg7Ocjt?=
 =?us-ascii?Q?nQN53/creiYTXBxTIRXiCntrE6H8QtAZHWZnLtXZZWi8SmZS2MXch3RD/Y2t?=
 =?us-ascii?Q?Bym/cD+jgeT850SWsYVr+OfPuSohW0/fNmaTYiehelNu/ttMdYtyxZhM/f1/?=
 =?us-ascii?Q?SGXSUjPIhFqUmuEkAM62IVrbhCy/Yekn9Fz3S9hYYLIaYty/RLfKW81pJeHf?=
 =?us-ascii?Q?GdN1w1vx4smMYASoLg9EYliHfTiAKZdEyHU9Qq9XArNHPYu5rAq+qOxGWw7J?=
 =?us-ascii?Q?vRApcQaGdpp9ona+DDAQkiTvb6FLKt0iYGF1PV1/oaOg7xWujVERWcKzllSz?=
 =?us-ascii?Q?p9P/IhlqjjcK9mqbovD1tvIuIs81/2qm6bmWAAhmMfCOi0Y26RgqylNJ5jva?=
 =?us-ascii?Q?QuQAAlKt/eWWnjPaqPXLaL9BUmMtDlO9YZtmIWhAy7Kgc8bsfIeBmPqtD0Kf?=
 =?us-ascii?Q?3Y5a5IzNWkLhMS0uBzZHOsNSL554ZSwCqs03nf8HWUvckh1lKh7hB/z/3bu4?=
 =?us-ascii?Q?kACKuGF2g23L1DSqwgMwa2vxlAviUAejN0uU7qHRG32wSo0rExz+58vyGsqy?=
 =?us-ascii?Q?iUbP4+YOpLgk3NGzlnpIiK7uovDiBzdxccjkCJ/JiYdzfMRFBWXY5CpmYqzp?=
 =?us-ascii?Q?Hz9EipSwNwjnaraq5RdL6oaGa3xNxtgLfvVegQqRoTVjbVMRMEIzzCftsp8k?=
 =?us-ascii?Q?5QorU+67IwZVlIQY7MNTUFz1b2/MjsbD81WHXKh7sBj8bLZslErsviRY1sjg?=
 =?us-ascii?Q?6hjbf7zpTStfJCi8Ikkju/ReUjIbPuuw3Cxh3SWnVT+gekoNyqPkZIp1uo+K?=
 =?us-ascii?Q?oUwTeTpH/o4dKYgjg8gfTLJtFhvHt50ADKS/qLV6k/lu8LFWu0iSHW0ffxyY?=
 =?us-ascii?Q?QaqdMMLhnsTPXOm5tRx8o137EJQ3driShQvqfzxxjj31UiC0cEFoDgFhPd9H?=
 =?us-ascii?Q?KYVq+UhasWZXIQdoCWtnoSvr/tYZX3K+xgcClHZRJBgOMiCKWphnsHWjTPvx?=
 =?us-ascii?Q?GjVDjfldMCz18uKC3tQoiBefjWtVQwbyXoAONLFeF7PU2UDxkRowyQtjzK+i?=
 =?us-ascii?Q?r9Fz8+cV9Pf7NMLiGflc5kaJW7uOePxAlN2hqKANxQUmJaszpOyKL+6AYyO8?=
 =?us-ascii?Q?EOgLQxVXDXfL64r7+ldYf9JfGwaKGhacIm78l4run6oG1cy5v8fCtp3YgrMq?=
 =?us-ascii?Q?FQO1tspfddGtZUhryZLQde3K+/doi13FYunlqLpn8MlZ4pwDEWwOMDna/dBr?=
 =?us-ascii?Q?D84DnESrndUqq6cPjzdxAT5qa8tktO/4msLS0EftrU4zltNM7XOD/gPMw06A?=
 =?us-ascii?Q?mIVA51dvrALJpQX/tl8w+sio7DWesGQ1j1eE8UuCXg0/Pj3Gtfu+yGNnd94Y?=
 =?us-ascii?Q?msrm9W6nn5QjeAlWwW9wy7uhKb+NPDBoqkjQ/gDVKfG09HVygQFoWdpc0Ujq?=
 =?us-ascii?Q?fJsbSUAU1VhZOtVPnYTYNev8fmYNX0fhFrEQayk0aAkUBdSCFIUOjKDPaxN9?=
 =?us-ascii?Q?cjl/4qVPwRQ9cgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FzqeykMwwFkFo1KJ3rtEoGi4oLLyDZ3XWmA5M7WyiIzPplPepYgUKM1OQlUQ?=
 =?us-ascii?Q?S549k1wZ6rqs3n38anCsmDWnjVCBGH7/I04I58f7aUEhulApfSJNE4960Ukg?=
 =?us-ascii?Q?PYMDgMOWDBVztw0JWP+pL//wPxmyCMGRoVzfbozaZLCUoTtq7P/qpQC40f9H?=
 =?us-ascii?Q?H9cELguZybXKul+K2wNBH8G1c4M6W5IIXndty+GH/99cHS3hg3kFMw9VCE+R?=
 =?us-ascii?Q?zQAhwhBTVH/bsxUvEDiEzPHKPUSgwEX41374Wtyi/z4AbKYCv0TuZtUUVv80?=
 =?us-ascii?Q?nx+zRTWBAEwX6n619COO3NDI0liK9JEBV0xT+7rMMZCNKM5XHnO2Dl17XDex?=
 =?us-ascii?Q?IGltMeb86bR77MF+V3yqtdy1MU2aI+pgkastBJqN029LL5v8aR6qGCeNJIzR?=
 =?us-ascii?Q?MCc5lNY4A4HcTQRb/PYxOYn74hAt8T/oq9WWF0EEfos+Xk3thXlmc44YO/qL?=
 =?us-ascii?Q?G+ai47R2QrCeGWXQR4IY5wjICMegD6ZvRVyZo5uj1mPT+lFzSbYh+GeJKmBA?=
 =?us-ascii?Q?wRvygZMHrvdK94If4gZcl5vYjbkopE4SHZpilcU6rBIV8z90c6WCE2akBGla?=
 =?us-ascii?Q?hOtfP54kyPtOBv7JffLVOVWM/gRY0K2TVM5qsyZHXSMa+EjIwRG0VkrHu98Y?=
 =?us-ascii?Q?2EdVxghPskCnKJcq5GmO5KytpcC7AVO2sXED7HN9c1kXvkfLOxVNJ84nGniN?=
 =?us-ascii?Q?TQuj5OwCstuR55XMomMlu8izRZk0VyphL1KIwAEjwcLkB1fzOV7c3wSriDyv?=
 =?us-ascii?Q?3WYYf5mfPpsnTql0rc8uXWg/zCLdo5O5mKwMkBZG1IFKFT2EwA73yKFT6cLW?=
 =?us-ascii?Q?h1CknoVUI6InrcoQ3sL9wSdPs5/8L0bTqz+H/clbicI/ePQynCy9zf3o3Sxt?=
 =?us-ascii?Q?ltD1pkWC5kkTuWPluv0rcyFrDmFla26KzX0PowRLjRuRr3u0d1A61V3Z3DY0?=
 =?us-ascii?Q?CC0Qa8ItzGFh6QqPk5J2sRLZJqu3nwoRVYr95gcVGe8mRKGDA8+gloLx6QLq?=
 =?us-ascii?Q?yHlE0wnuo3nMG4sNBYSHJWe5J+gBST+5Ul4QALsJSvn9c2Uc7l80TW1egR4U?=
 =?us-ascii?Q?Wq2oq7Y90R6X/7hQXwNlpqn7fevsRtVDjV7PqO38vYy8Gd8oCa3mhjZ/QTQs?=
 =?us-ascii?Q?4DoZpv6OdpwxXR6HyAWHtHg4AvvmgieuiJDB14Dc/RQxXPVXOlhI468Bhh6Q?=
 =?us-ascii?Q?prxOxe62Vd2K6QhnfQ/4dWlxNURUamKUg3xncAt/NTiJV/w8xlWiA4VVceQo?=
 =?us-ascii?Q?1CW0uaW7dfKL1xfLMY3Ew5VL0MvxxPI+GrwyP5UNZioJHssOX8oqbI8EPfoz?=
 =?us-ascii?Q?GaBRR6FWeHcItMGY6sPYsTofqcX2Bprv3NrnRtrlbGSTHfIJRZECxmzPgFn7?=
 =?us-ascii?Q?F96yspFIHMaihwFwhMTk7n5X9EYgoXEksBT6Ky2BDCtAy3sr5rmDfeDTMjuK?=
 =?us-ascii?Q?e4Y36113iXSMPqIeGJDAUKPyaSaWpf7wZpIUMkKiDNwsOnnkA+IObj27NgNp?=
 =?us-ascii?Q?eWWEu1li6K05EadWCvPjnpYskcntSwVk9DQbfubRDqEGTfynmtlZHOfU6eqK?=
 =?us-ascii?Q?WmJltSNjnxYV9DwYptrKgZmPi08Lr2ZvkFkY9JUV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0feef3-ce7d-463c-e6ba-08ddd9a4bed8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:32:55.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRnESaythbbRrNiuQs2IpMo1lnO70LZraNxqqZqokVsW+KCOsAGJKyR1+FqP3vr8+3vPr7xoabHaQJV2N2ynAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 80e4675582bf..137e526e2584 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -564,8 +564,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 
 	/* Init ring buffer and unallocated stats_ids. */
 	priv->stats_ids.free_list.buf =
-		vmalloc(array_size(NFP_FL_STATS_ELEM_RS,
-				   priv->stats_ring_size));
+		vmalloc_array(NFP_FL_STATS_ELEM_RS,
+			      priv->stats_ring_size);
 	if (!priv->stats_ids.free_list.buf)
 		goto err_free_last_used;
 
-- 
2.34.1


