Return-Path: <netdev+bounces-286697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM8VA8zwAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C57510DD5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D30603064DA5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398A3FFACE;
	Mon, 11 May 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RD1y0lxb"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023133.outbound.protection.outlook.com [40.107.159.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9C3FFAB2;
	Mon, 11 May 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511403; cv=fail; b=BkhXuCD1z8crD7mvvQ8z+4m6hTObXnu2MBKSIXfuWvzQ99tRyOt9gWuYyMjzf3m+QYXJdCyfwQqpsqU4yDPz+qidFHAslMsIgyYOAJRb9jacxlfRHaP05rU3I/znU+hd0JK3dtP5Y7LtVsNha1F4A8vLrdcJgcB05mc9Tn1iJnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511403; c=relaxed/simple;
	bh=SO5l/rI81JOrleN5V2RKwL1ebP+hjOtnvZQtmB08iGo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a8MlCi8oylogRm/uiAk/9NEjA52wYScxsUTQ1Tvse4nzywhB0CdcLWKjIBcpErqwTc3JXyc3+QW3+S8Nqk3WgEu3QE8QS9M7Npi+GO7r+1jCPBuCUa5M9/QGK2Bv15LwsA57eTBd9CDeL+miEt7Mndq1ieBt9KYspkU2f0CfmSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RD1y0lxb; arc=fail smtp.client-ip=40.107.159.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRbr4i/J2yqBEbX0yzqlAvDyro1CICi0pX1nzrNlhiWuQs6/+qHNNgY8Hc6A/wEB6xYlbYbxoYUQGMRW9cThbfc20kXzJSg4TkGpS+dbx2rin2fvXkP6jfVzBDtUUP66nGJfPKW2tgIUkSiYrzhlMk2jL1b5ft8tS0WJLaj2ciFg7XjQXf6f5RbcOSvHHBElLHiugzPk3RZYm0ClvAfNxtKqpKe+1Fn14IjuAOBUbvHMiJ2BlcxI9d223UUuaNUJ2yPLROxir4ph+4b6mDcaEjIjp1RYpqE1iDmEQViZ4Jlcq255c+qSY9tdF9dg2/7L6N0r4nbUTarcNhla2mnAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYvEhkx6h/tJG6I6aisZI/btEkaYtBUQvHdJlvuWY88=;
 b=u0YMPS7kmghD0Iic8rZwoQxrqbEZuIVaPK+SS/xbZLDS+EM2Nm7p50zJ85HeThzhR+3EyMjvpyoCwwOcP1FxgJcdDVK1enN3bzT/7nG8fZ4HZY6YzQAUqnedBbWUKOadRKSoBdGYTTANgweBHmx/6jTMZFqJTCkVpx1Ng5wSp6AubkozsvBY2fsOI58WmXClv71oRqN0QvLDRqMWg0Dk2eyfyQ7BuqXXppH6zeaDknTV6vc+2zXXK/lwfNhJncU3oOef1pqWtQLICs3N+XZx/hlaQ5K+7zUG9LPzzyrY0BSWBCY1xcPDKzfaPk0mBmcbPHjUIMP8WJj2m02UCXRRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYvEhkx6h/tJG6I6aisZI/btEkaYtBUQvHdJlvuWY88=;
 b=RD1y0lxbK0QGk4R5gYyLM/zYBQj9acsECGraJMpIPhyu/Bp7TwPf7zCUieP19vYjqRDD2J4Eu5GI6mLZ75zAIDYQlRy0MAdp549UnBDTOHirfWzXTxGsVR6qN4ZPGs9TDk9KCSB94Ov6OQ/N3j7FKP7wCzkygEqaNyggfKuHc8G2AkPEDX6U3S4gd0+a/kbElc4W56f0/Opc/Od1D/xA0zPRGuI6bWQ2NL15O5e3lm72oa7Nso9BVRSqX9J9yJiMNFZsNMvKzAC8IjBQidMXZF8Qy/emQ0QDoQXwg1HC2MoDyNE39S2Imw7egL2s7J3seTxQwLWZ2HwEc0w1hfSyeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by AM7PR08MB5333.eurprd08.prod.outlook.com
 (2603:10a6:20b:104::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 14:56:33 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:56:33 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Polina Vishneva <polina.vishneva@virtuozzo.com>,
	"Denis V . Lunev" <den@openvz.org>
Subject: [PATCH] vhost/vsock: Refuse the connection immediately when guest isn't ready
Date: Mon, 11 May 2026 16:56:10 +0200
Message-ID: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::8) To VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10828:EE_|AM7PR08MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 02abc91b-8f6d-42c3-0e69-08deaf6d7dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RHf0K/4FEhkLgtLxnCODeydNGNSfEwju45hxp+xDqwEUDxcoxDAZcvvckS/bwyLiHsSx/MlX/TxksPpnroy0r15/2uohNgjYdlhOtgzfJdh2xIwJSIh9MO09rODVZv+rtGZHcibbn4lXEjLvD0zrzGT30u6bp/B5TzoTPFRMqvS1uKFDYZ7b4yl92nqKX/V4HuVBV8MvsLDrwFKkKTeuC+tWRYp74nlAoefrVj0eqX/eIe5CTQ1S4E8C2LB7kYLFwxLaIRc3xzUb9QdT9gMXgi0Pr5251pIMXf0GYBS12ioNW173+dwvvsBvSL6RRk9dmDT+0+5x/6kIgFlOtDYD/fdcOxGW4ssow4LC2wHDkIXY8P9amPo+to2HrxhbxNXZPmfVoruPF24Ib52SRUIiHRvKgTlBYn+WTTTTdntz7coz2KxCdgtIQ3+PBKgiO8QbVq4Ju4C4fuybdXnr4ZT+WCmKNWC78Rc31+QQMdioLjLUUxcQOMIwj30HeEAmzv9SEqjIwWjvEzQKZQ0XMbnTgYDNtkQ4DOIKqxQ5MITtHuJmjwqpL7+gARBeG0V+MptjvseV1YsgCWzGQIf4TWf7ebR97kpwoEO0/WiWuLi029OXH0JMBnoUcZgWs3rWe56D3OW8kPb6Te7tY8UHsYgogghktbMVoiDljLqxYULEPX7siCQZQLYpOIS6Mccbh8Gd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10828.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHzSHA7CMxute09PlwRZsm/7wXoYRcvYpvpV08cLSI6n1MVNuWWc03BuyEIs?=
 =?us-ascii?Q?IC7pgz80D/4FGGuPuYtKEfc6Q++PFyen/t45YNMWqqW202IGA/l3ywXKZ8ut?=
 =?us-ascii?Q?i6ome1t5cT1px24E0QZWeLDoWPpam4g5wToBwR1YpirDN2KnB7SLJNYKNBJm?=
 =?us-ascii?Q?63aoMfS7Tfp/6nN/yvh2ItQFLK+uGf84Y2eZabwLDc637MnXQwXGvM/VgcZw?=
 =?us-ascii?Q?e0nTalMozjxgz7S0lJRapuQXog4ODrXnt5esdfFKstFQ4mtSC66JhgKg/VQd?=
 =?us-ascii?Q?PcpXNOzPR45YA8/T99KDpl7HJKBkJYTztOYHE+QAsu4OOFWYcdpsfSlQag3a?=
 =?us-ascii?Q?Eq5NKyZmiK5kkt4Xz9MSToqguojLbxVKBtM963vqV4GGFzbNSfoljJrPahAw?=
 =?us-ascii?Q?3srezD73BYHmDsJvVgcE0BobJd1+VChnAnZsAzC9BPO3gVU6MwyoZ+UODFqs?=
 =?us-ascii?Q?eS7D1+OeKKetzIjjlTskNzV8rWw+Gu0TCPOpp3qBAfvznyNb1O1kD88O7l46?=
 =?us-ascii?Q?UNP0BIn9o3Au8dinP1cdYM40EI8+JYwkIdmh4JfB8F/UsgAnnZPAekmfjbYm?=
 =?us-ascii?Q?CvBeJXtPFcs0Sbd7ut7y3X6dIlx7nJyzIgmnkG+w5Yr7GgUKpsb1cHEAmpe3?=
 =?us-ascii?Q?djExZIGh+awmqlg8kUutSz14SZrUC0PZf4ZYhWePpjqRtojmtagElX0BaX4b?=
 =?us-ascii?Q?yCUP0S3kuVTG/6bCTcqD9CunN7ju+ZQjvJC2UyabrICsaGRNyGBVxKXHT+kn?=
 =?us-ascii?Q?C2rcGaJjKnAuv9BFML971sA18uzZp4dLXk3vi8PKGkVyAaXqTUpQkqDwKubP?=
 =?us-ascii?Q?OekJ3AwQwAiyGdK/oVkUXGfvfCUivMQIjFofkTAa9nWttJOabczYCPQQ77dJ?=
 =?us-ascii?Q?25easHTROioxOXZsY/XGtd6QVyVOuHRF1ejqHSVC0pH3W9z+s0l4XA5nLdR9?=
 =?us-ascii?Q?9h+ZiVjtZAEyK9MdaKm66KZUqJMUD/M+USrDkNmdro+3K15UpZid/fJlnAF4?=
 =?us-ascii?Q?YBwI1BsLcocBg0ECpG3aLI8i+MaVglSU0S9z4PT2eWjP4pFnUXvmzaPK9PKQ?=
 =?us-ascii?Q?7RjHjKR/xmXX713dF2UyerNxbWpZ4GabvpOdF03eSlHBEY4fKXxg0qbUOCIG?=
 =?us-ascii?Q?hQYMfEPFGAce46DEIhNRsSqurDcjM9TNd2Jyk8yK0/TwfaT23qJw/APupvzm?=
 =?us-ascii?Q?K5mgzOieqGJFM2R0lUsgCuO86iCtsNCLJGGV6qyBiNKkkhMH8sg2EH8dRfVk?=
 =?us-ascii?Q?1TKnyFmQDJwmVt2uZ7ruBoo2oZ86BAlkmrGLB6/m3HqEEtfLucH3nMP6cLui?=
 =?us-ascii?Q?JP907bBgd1bdmSWhIaD9t0GENQI1pEujvVlbKKJEcVlGwyFhqvnW4qWOjM8A?=
 =?us-ascii?Q?7wm43LSmiDt2oPwICj8n9FB3gjLBBt5xodNO/qDQiAr/sgXROjfWfhOts61a?=
 =?us-ascii?Q?7MrQnJ7aoe0EDGIuix3s136iIV6tZK37lW7qqt77Oi3717Rtfa+yzUIwYlDB?=
 =?us-ascii?Q?flEEiPxYi40z+eroZmtCgAvXaq/lP7FgcREbkAqb8NsECxF+QZcvCDCBFSNs?=
 =?us-ascii?Q?2zSzt1QyLyWYGPcXmIolNJPdNkJdduQh77kWy248mZ4g7HTPN0Up/FY3SUNv?=
 =?us-ascii?Q?BO3NDVvF3smo4GAGMzsGG2fIFT64GV5/HInQeINKLA9Zx7q6Jq+evj0Z81XP?=
 =?us-ascii?Q?aZMy+Y+GtmQgCf+kDhqwqPCsVyJmdYfyH3pJsHU1EKVZZDALYCLVQacGMslx?=
 =?us-ascii?Q?GxY0/HW3zDu+weqKDvyeA3hf+z/L9co=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02abc91b-8f6d-42c3-0e69-08deaf6d7dfe
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10828.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:56:33.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5Xp1Rqev8vv489NYoBzg0P0pt1oy5bUB1NOA4Z/JzYHbdLAVwYbStLzlZ9NSOaL29BtMiUy+K5Mc+9dSfOkF4JvkyQnr/ErJWJA/dFsqLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
X-Rspamd-Queue-Id: 32C57510DD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286697-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[polina.vishneva@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:dkim]
X-Rspamd-Action: no action

From: "Denis V. Lunev" <den@openvz.org>

When the host initiates an AF_VSOCK connect() to a guest that has not
yet loaded the virtio-vsock transport (i.e. still booting), the caller
blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
vhost_transport_do_send_pkt() silently exits when
vhost_vq_get_backend(vq) returns NULL.

If the guest doesn't start listening within this timeout, connect()
returns ETIMEDOUT.

This delay is usually pointless and it doesn't well align with our
behavior at other initialization stages: for example, if a connection is
attempted when the guest driver is already loaded, but when nothing is
listening yet, it returns ECONNRESET immediately without any wait.

Fix this by checking the RX virtqueue backend in
vhost_transport_send_pkt() before queuing. If the backend is NULL,
return -ECONNREFUSED immediately.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
 drivers/vhost/vsock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1d8ec6bed53e..a3f218292c3a 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
+	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
+	 * private_data without vq->mutex is deliberate: even if the backend becomes
+	 * NULL right after that check, do_send_pkt() checks it under the mutex.
+	 */
+	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data))) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -ECONNREFUSED;
+	}
+
 	if (virtio_vsock_skb_reply(skb))
 		atomic_inc(&vsock->queued_replies);
 

base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
-- 
2.53.0


