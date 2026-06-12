Return-Path: <netdev+bounces-298738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xdriGLs7LGp2OAQAu9opvQ
	(envelope-from <netdev+bounces-298738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:02:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF867B2D3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:02:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=SR3DuFzW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298738-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E51CB3181E38
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D5E403144;
	Fri, 12 Jun 2026 16:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F344028E5;
	Fri, 12 Jun 2026 16:57:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283454; cv=fail; b=hWChEPmvpV7oH3VO8EnDD37K7YqnTXrntZ46aT6FNEZoztlAqN5CYE3UJ0/H6z+qvfZzNumgtPYpCuLQYkemHnnjhAmvvRHrjMfpeRAZc7Sr2FvFWGSmGuCfHliqhmd07LaDm+qSYE2tHQvObjZJCqOlPSpQ3qF47bXCCNBU9R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283454; c=relaxed/simple;
	bh=bemiylHqnc8NrVqOv5wVTFxPD7TO7H40worxBz4bJYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwP4xk6Z62cTdh6/sACbfFmRSEKRIJR+gYcTEDKA4u4hkFx8fS7/X6hwx2VP3cQ6xb49kwePrLej7SG5JWQ2P0wlCYGFaustKA8Z8N09CbvJbJ6ipSFgEcX240Ry6k0wyatKBUQMUvAm0cmGzhOgxIwLFT38DK7TQq+taY3TRrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=SR3DuFzW; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4+Fuu2SDK0mBwshs+pDMYsIUFl/yFnsALZeOg/dAC4Tvcx1d06IiCvMe66VeyoCnt7TWE4/G9LKb4cRCEwz+lDoZJ5iRYJggjRwdULr7M8Ugex8fPPs3iun53fvVlq/ESIsr4Mwbmc0BQkEz09uWSfzsojEIQNgg3d0KgkYmeJOYOrQ/pJq/SikcpiRL0fAE27tAP9xESkEzg1MVH83Py5PspesyS1BrfLzt0HF6GmOTfP8lv07l8PUzcIBKNEfcIDMtgYkz8102OA34RSCvA5r4d+JEx+yCRR9peMK1xziZSXDhKPO59GlQhD/241Wy1LZqmx3dJjTmBcWbqJk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PREMhLRdYgC38yw2gUwocN4kmXEPm+B3lZhnujtPkk4=;
 b=WhSNHvjIaP/wneEs1SbCNT6Yq3PB53I+fRGGo6lVGgfpKBEBvIaRoMI0ZCMAzhlq9SZr8SpaljKFGHOKzCFzulYitg8m5Mhf0UL1OkxIZUAxWdrZromdDq/7mTPeRoDdwfCHvb7yqitOuwnuwB9XBqtj4cJkn5bkKaaOh7uyykqK1OekF2p+axkN93Bp+v+kCCGsNMN+PFT8qvWed17A6VZW42dHt3j5A+48wBRoLdBY7czasLvo+kiu5VHNjRlOElQHR5Lzv6jL/dSlCdJjDBOnhiKTJksv8gsCD2zgCpY+Ul2rZB/v8GlqQm1p205rUTejOvWxGl9d1AF0lfVAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PREMhLRdYgC38yw2gUwocN4kmXEPm+B3lZhnujtPkk4=;
 b=SR3DuFzW/K0G76du9y+UAqM+Hbuekc0VUbSiO5l35DKzz+zqEPCZn9ug8b7VHzgKLhgVc7fLEALVlvOlF5rPw1UTOVj9sKAKtrNoVmcmPp3hOhjx3Nnio7UbVhIMeaOgiOt1VQvZptUYQ7EtSZiOm1VHCUwUa6NXBx223OinZTMlzFLwDOSgJRZSMKOPW0LDucrDNZy94j9KzlIygRlB4V3gAAgJR7T8ljwii4lIJby4B/c7DXJZhWIK0l0+NYFMhBwRYV15wa+Y/DZ7Wy3ZbdIwejGFu+sBOsnmvuejnkyvmYwAWYqhSjJ/Yfjm0yEuQQza9QVDHP1hEjfTdqiMBQ==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:57:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:57:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Fri, 12 Jun 2026 19:57:16 +0300
Message-ID: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b15e59-5b22-493b-cfbf-08dec8a3aea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	A4QIo5F7D+g62uGUsW4o+MIQATl2aKFtmr+fwP6wp4qq4R/Qfko9c0mSSTnCv+O3U43l06YGyJvTCqFWz47H1j2DsNaXVW1AgcA9L/h4JiAQVx29lvYFcpPwcp9vGud5WPhYz8VKO/iAgfCY6/rqjeKe7Kl94uJ25oNSSpcrdoVscsXTxG0gouCj5IgPfA560WUpOqvBEKUgapJQ/I7OzPoOMKWECErv4hyi0XauTdVorn41/QjHWORDFSK1QJuY2q3KnaxG1omZPxVfmMcAYlqtYrEaJiVwhDKxfR4mmvn99DL1ujdZ3C+kTzeY/f5kvPmjBgUpMCwSPQ3+2hyfXEmP+9ikQjH8IdP8vHjNq2Yf6Mo2wNlq6QLRAzdZR5JY5VbGWS5Zgoj9B6ZMgX9VM6VkodhjCYL4CoJXDYsJ2SF4w/JeFkpnwbhO4rcgjmZDNL9DcX7QoV7CszP0PD8gLZ10mxNvkpflkKvvKqsdvm3OZ7kbFg0fH1vvm9m7y7lcg7BToz2xAJnnNNkTyGo/GBwCm8bq+4trcBk09fRFrSSF7ikrGNq/IjHKkR95aa7plpOM0GTVFh0Hu8qyKCjIDENnGDG/qE1ZaCXHXCblmP7SjT1om6NSK4iXJBqTBfViaQ1jH5fQI5+d1DkOwGBccf1udnIqJ19qMHodC6Bdszxir0OTXUi18ROaZzoasxY+cQjxwpldkg6LOqf4a5boJ9yKql77ECuKsVxfiSFYmGfrqKZ+9AYpMyWEc6D7e8K3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOZilVEvGo8oMLbab0Hx2/Ia7aRcuRHRitzD9kug5jtDF+bZnfAH0NAzOQwt?=
 =?us-ascii?Q?H+UXfbB3ns/waFF2JWVvXC6Ad7EkcDroenCTlUEKBrag2whUVXodMmhvkDZO?=
 =?us-ascii?Q?7uUZH3GvgVjXaimjb5JgCj6vblLDdzqmhhi1gnIRq3GU65CV6I7G4dCzb5dC?=
 =?us-ascii?Q?xkBlVVpGu8niNYz0hiB72+IHC6bAS59NrqhOjtdarIo1udezDdzhajfFCe5s?=
 =?us-ascii?Q?CMQg3BQkA1OH+Jw1QYwkiM74mDKz7+8kH8iBQlvP3gQDkUiyZaprHTuKzLLk?=
 =?us-ascii?Q?xCP87ZIHRdWKPmvHYnWODs2WGbzTRjvl3uVwK0jo00jkjveyWoH9IaOw49TU?=
 =?us-ascii?Q?odmrmLGcr/V5MUto+S1+IbIgj13TW10rS+YRPrfNFUmVBNA0tQRQx6euJ9xj?=
 =?us-ascii?Q?l4CchFT+ONmElT+N5tl8C8PnX9kebawWB1RQxnN4tjUpJWcAvk4wmzkY8n+u?=
 =?us-ascii?Q?Zr0HEYPjwnsyfqPOt46S7aa4kUxZ1oh8vEaRpJZsb7ujNhm9P9CUjybXtg7p?=
 =?us-ascii?Q?53i2n04vtCvLTaMfyf8XYo5WqhsHXj7onLu53MIxknogbm4vWiypt4mkpTpb?=
 =?us-ascii?Q?azUjwixJCz16/AsjbFyJcsMckrYoSTjeIH9K0dOlE9o8ckqHvpQ+7v6S+vwc?=
 =?us-ascii?Q?8iAyOIKVvANbTb3u9EmItmcB8dYLW/I/MfSuxagcyAiSBOqx1EscIJLB44mY?=
 =?us-ascii?Q?NtTdcAWg4QsG86ZQpL+n/0JUW+JovMJ5elfAbf0zojzf/qWZV8wUHlPH6h+a?=
 =?us-ascii?Q?bqR9pm5GE4CWtlSUnlwARH8bYJU6/CZkAXg/0eiE0YxhH6iPmPI51pO3a6U6?=
 =?us-ascii?Q?CMJoQy9wbOmq0ZCGOMenigy8jobUUwZShJcB2e3n2h/id2kQAEg9IfaO7r0w?=
 =?us-ascii?Q?f2YWmiUy61TBDtu/oKXSOHbGQidmLWe5eWCNmKCanX71NYlFWqxQ3XnepzZG?=
 =?us-ascii?Q?BEGEZuCuokUgYmFRpqXGs8e7LZ/S2fhGtk8Vs0FMu88yRTyqPnh2dYXhIebk?=
 =?us-ascii?Q?gLMoiGCTqCbA1cDS0onnpX3vNrlMMrOQRu8+nZDvdgxr5kpXsBQBno1EPKAZ?=
 =?us-ascii?Q?oUIAKDIAkpnyww/leNm7Fic2xEKsIU3e91HB8fBhhbIPgLzofoFYsgUjd75J?=
 =?us-ascii?Q?NnTHAU83iM5o/nDts6UH34GwPxd4ivq98e62huoI4TupTrbW2TfyIrIIvndf?=
 =?us-ascii?Q?THpLVW0nfzDYLlzhMVOTSBXnksPGPjb6L5b8NURVrJjlytd230qviLSo4fU3?=
 =?us-ascii?Q?UM8MYFtERevsXj5AMh3DvbZD8kHowp4lAlAjFOffl3JyMf9xGfb8h0s2BfKj?=
 =?us-ascii?Q?MgAe580jAKDOkLCLZXOVJFhXE9pD26NEuMLSjXs1gO4tKuODc/2DVk7WYAd/?=
 =?us-ascii?Q?iMznTtqqglQQF8h+0ybqp8O0kKYu7E+M28cYeWOJr/BemmL+0O/144TjIIpP?=
 =?us-ascii?Q?puzp3LAJAb7qdScEJhWXEh51AQM3JlFQHUkkZaj5MlPcrK9isjmQBVIDxd3D?=
 =?us-ascii?Q?phYAVg6lXhjmobBMa9JEnWb/pbMnlUqzJk/2FnTaMJoK51MYo1aMnbOWx8No?=
 =?us-ascii?Q?d3Ez+2iFKjJRygxpkHM9hSADf54Hfa63gSnC0qDzCoxbgfabO14MohB1Q1cx?=
 =?us-ascii?Q?ATjDQrt037ShVxzOYrIX1zf39auQ95q29RSZQBkMqDoszhq7/TGU/xQEd+B6?=
 =?us-ascii?Q?WGGtDgBIzrTeSq+SpkgoHxQSatt9b4t08Cd5VjNKTEExKkzUbW6aVub02IfV?=
 =?us-ascii?Q?nVVeBoraQdy0afW9XbGEfXGCi+M84Es=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b15e59-5b22-493b-cfbf-08dec8a3aea7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:57:26.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq4zrMHdevrUsd1BLcjhrmLX6LVn2mjIeKV9/dU62WzJVoUWcasT63RgvNOur0qzOo+midVEJ9zVqG2N8xD+XUZU5dTd9dYIhCjey9CVPfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3FF867B2D3

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
the guest with vhost-vsock device.  For this to work, we need to reset
the device ownership on the source side by calling RESET_OWNER, and then
claim it on the dest side by calling SET_OWNER.  We expect not to lose any
AF_VSOCK connection while this happens.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b12221ce6faf..e629886e5cf8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	return -EFAULT;
 }
 
+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
+{
+	struct vhost_iotlb *umem;
+	long err;
+
+	mutex_lock(&vsock->dev.mutex);
+	err = vhost_dev_check_owner(&vsock->dev);
+	if (err)
+		goto done;
+	umem = vhost_dev_reset_owner_prepare();
+	if (!umem) {
+		err = -ENOMEM;
+		goto done;
+	}
+	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
+	vsock_for_each_connected_socket(&vhost_transport.transport,
+					vhost_vsock_reset_orphans);
+	vhost_vsock_drop_backends(vsock);
+	vhost_vsock_flush(vsock);
+	vhost_dev_stop(&vsock->dev);
+	vhost_dev_reset_owner(&vsock->dev, umem);
+done:
+	mutex_unlock(&vsock->dev.mutex);
+	return err;
+}
+
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 				  unsigned long arg)
 {
@@ -937,6 +963,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 			return -EOPNOTSUPP;
 		vhost_set_backend_features(&vsock->dev, features);
 		return 0;
+	case VHOST_RESET_OWNER:
+		return vhost_vsock_reset_owner(vsock);
 	default:
 		mutex_lock(&vsock->dev.mutex);
 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
-- 
2.47.1


