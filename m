Return-Path: <netdev+bounces-287639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHKwOcySBGqrLgIAu9opvQ
	(envelope-from <netdev+bounces-287639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D4535ABD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0260B3020EA3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DA44E03B;
	Wed, 13 May 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MKzKOFBh"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020083.outbound.protection.outlook.com [52.101.69.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABE3FFAB7;
	Wed, 13 May 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684348; cv=fail; b=KUHzgrMtlwPTAr3wDSPp/0mCHkqFD9DWUUfLFiU3EX9lZUGzdO3cIbGmkDxU230sRORthzUzLyypWzi1SMKNBxCT16M5stGrNu/fOclh5XSa3MPg8yZbK/z0a32zh3B4UHL+46Ymy/5Uh+8KIUZd63U082GW+eBsFFCnz7pinGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684348; c=relaxed/simple;
	bh=k50an/bzxA24sXgrQXvagovMHQyUnplpYZVKxL3mO14=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aJkBKbM4mGBsxm9TwLEqz9TV9bvu0QFr7hW6yBLVX0hTsgE7mzIlYK0txq3c4Mj+YDdRZ8gUZPG1MXwBElP0odesrCVHeCeN+OLTUtTR54UPeyy0B/mwvLvuCaykJlJxR844fjmzZyAEFkp6Lp/cmQqX8EeQPeZxjdC3CkK1H9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=MKzKOFBh; arc=fail smtp.client-ip=52.101.69.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dioxhRuKAENiZ3ls86Guij7svAjVOj25iQi86RFIQOaYw9f180LY4S9z/PoeNeK/LRJQxjmUlqxJJMJZvL6yeVPRuzABt0QWdQAk2zx2LfgDLL2G96UI2gV0pKatnEe+3Qts9L4NlYwyur2t/UhMwr4W0imnKwtu5/f+7muZAmNRtisjKRWlh2GkruF3Jar570GPQBrj4zAFBmkIcK0f23DTK49Nd1wS1FIEF/N9rRqOwLgW4ueBVrU8plk3NRDRkFac2VEgGoCz57WQoU2p6dhIhjrvaB/SiTOJ0GTY4nn+laZzzN47wCpJvTUrPRM2M2GLUeSUgKOyHy7fviY7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1WWIBmF231KEPRcdyUPH0TFIY8CYw/rtqxljMtCITU=;
 b=o5WGmJADSpGVxa1Bjq5ESCBglbBATG5CtljBHdbvOGGS/DdLJQ2teocfxEEbo5t9KPjKKqvhCueU+v1hQX5MCgkaej5Qr/7u2SC6siDshlN8Jmv11ZxzHaqc9t4LNUBJmamAryrS5Oy+720AI76sn+U2CYixPlx+G/d29yCnCQ31Iz7s++vWtMtAu9BSvc2NfJfSs4i5g8MpnG33XqRcDWo3uESPssG7A514TN/gZ7sRbvG9lNbkpdl/JxbG2BgIKFrOknJYULLKIRi+SWdQK0NNcdaLUXvjmV5Uojjij8+HGnsPNd4EXKVcXIQeHyx+5IJYn7fFez89Lba7lSvqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1WWIBmF231KEPRcdyUPH0TFIY8CYw/rtqxljMtCITU=;
 b=MKzKOFBhShDV9bRJaIK/Sb5PL10nBErLIM3f64fwvBo285DDVUWwTBqiq7tTV7ElmfgFE2Et5x3BLb6C+OwhplaQmDr0EvwrwAk17owysTxiKziQlDVDwQnvqrOlxRNHKDs5ys2/2ZUZyRVXc5v2NYrR5v4f8XrJ0DJKJBHsEjO9r+KebyjohSwdj6ZjQtHYrPXDOkfyu0jBII2jY0zvCmi2eKRBq3p6pbQSd+vtJaahpqHyerWsVbnSI7HcEsXIwf1vtnulD/WWNPIF4yoHTB1nENEaH7AahUndV4r40rpLgXoe04jpdE7fYjCuDIVutvuoHzqPGMg7OYeNPKQ1Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by PA4PR08MB6255.eurprd08.prod.outlook.com
 (2603:10a6:102:f1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:59:02 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:59:02 +0000
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
Subject: [PATCH v2] vhost/vsock: Refuse the connection immediately when guest isn't ready
Date: Wed, 13 May 2026 16:50:04 +0200
Message-ID: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10828:EE_|PA4PR08MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9d6540-7b61-4692-e636-08deb1002b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kESsNHiuSlvgr4bhxDlIF+fk+FVQCHt8mhrUVqVWkBpEdZcifs8hCmZ6X0WK6sgkql+RN8+kFux0o3UDecrqC0URqAn9eiKogwnLsfqow3HpSIJYyP0qObJF3Uw5on+5ZiChkVHKOFWaZyVO7lwlK3+LVh6f0ygvze2xzbK5qwgwnFu3EtieeRs3I9Uf6VwpHPBMcBNZAMdbMybCRGYgrDc4j4MEv3cmn6O0AZ82BSVgMjmieO4EXi+07SdE2FZSbpEfj5cC+TPwpt49Js8nVe4eSYHShtENpQf8hsLGy5A7ld13cgscGFkATRs/g2/Jbl/gSInfJAlYjM3Cyi3BRMrjb4s29CrTpYHOQWfkwx6MeJd9bjeOdn/B58W/oEBdmMEa6PWAdkW0+54H1gFx6Fp4tCk+oIyAyC72Pxd/GN9Ii864ib8+CaCfuudmsZ394sYI1hL2eB+FrQzAoXLsswkdXyb02cZdG6/vaW7cZGhErdiOVJNG/764OGHBxt1CiroQxL9CIihDDHrPpNmyHjbkkD1QoSwrhTufWYL3h1DBGqsnGyuHzHQjXg7+u292wDq4HcqOeJ5V9nMzXSR4pftO6RYc+cdAZkCsiX6RR1wTcmO3kguFXBBNWSduOKiuZVQQnemtx265N4ZC+hyGQNUK+8Qpphr2hsQJvzOmkoUBWX7xL70/HpYPxyBJdW1A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10828.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ik7LG6PDfUxiaTEt03utlDbBbe9kWnhl0bwTfjVJJxPetbMXTwt83U6AXsym?=
 =?us-ascii?Q?ZqnNQx5qAS7+QlU/4Z3wkfXDkSSWI2fyLzmCibU8lld1m6u8H4+WBbzNQSW1?=
 =?us-ascii?Q?01a9gANiDopf4X5z0EsaKcDH21PeQm5wDbC3TCLWNuObMMkMHPnkujDNLm0B?=
 =?us-ascii?Q?89AFQl6XuTT+XGLLg+ufZUIhHS6hk/VOW4fMuLemkVQBj6OcJ4Jbyfat9z3z?=
 =?us-ascii?Q?T3IRuVND6T9r+NLL8pVfzGIB6b5AnvvloSqEMUFdYNQAb1476u9n4W90iuvW?=
 =?us-ascii?Q?Lt4Xpl7U0bQ5Xa8F5rFLAU5Ed0CvWqxvM8O4XKg0i2lv96/bl91ylc9iQm4W?=
 =?us-ascii?Q?2L8Cm+WUzxYLi3Mzs5SLy9R4R9k6ic0MlUsqxGr4kWtO23PbVpd2HxSiMkVc?=
 =?us-ascii?Q?lTHhPTdXfLT6J2k0fYjLKaLXVO3WjEHpvnNytzkXtgqkabQgAT0uUIRzn+4C?=
 =?us-ascii?Q?qICJJ7YDDFt8fm3WBGFnMkuSqKn31lTOZH2q06gETuWOIHAPYlb0elI1RmDD?=
 =?us-ascii?Q?HzxNdDb293thxehFViU50ciX+BzG4noKpJGxauCjkvmtZrYOxBubXPD9NMqj?=
 =?us-ascii?Q?ccs4qj7oqp+HEjcyVg6vG+MDEC8dD8dT04+tFzp4Qf1JEofUbxPcOHYm6erZ?=
 =?us-ascii?Q?WF2SsJcNRb0urPEy1WNj103Rkh/RlFJ2gqPtgdISdPnHGtzu+bN01pv72JOY?=
 =?us-ascii?Q?krLl5EewoWcl5CnFiLOtxazNO7ldE3+EK6VUQEAUJ9ae473vj/vCfXhujK4b?=
 =?us-ascii?Q?H9bKUz5KvtRXXxW0veQeAfdd99F9drVkSWfJZAeNHx8/CkgUNL3s8M20hkWk?=
 =?us-ascii?Q?BdOJVzLbROoV30f7aWY/k/Y+gm2U2cnlw87BZNRvsqVXq6w6zzqMDfpz4viT?=
 =?us-ascii?Q?l3xH97f/NKNDP/J/U4RoIpYzN/v43ck8lLJAu//ERWg2WwJW1Tt4scPfHSGE?=
 =?us-ascii?Q?l2tOuKk8+l6n1m/C8uzq8ENCeRpGPkxL1A1Pi4TW4RtucbWzbZIFlzkcXleo?=
 =?us-ascii?Q?XC7Luq6K4t+8gkou9P2Rnk958rkIR/Cv6ZApYNlkBWuT5St8yBfiubx5bgfR?=
 =?us-ascii?Q?e52+Tr9whmmJi8bTdCA8oXE/QIQycb9jt/CGbgwfpN1Hrq3n01rVUoE7U5Bt?=
 =?us-ascii?Q?ZOxUfa1Xy9feIluflS9f0MohcxgxZr21sEUvbe9OES0U4/UUMiCS7NP8bZnW?=
 =?us-ascii?Q?7+KqUH6niqmCM4jTBXv/ylCYhynfK9PahRftH9+QUo8Zkmx9Q4c6KouA6MGB?=
 =?us-ascii?Q?VJJrBsOOW1NzUTwyPak6zlgj7spE2knVwr7evtX1xvmPHva6TOROBe1p2ybg?=
 =?us-ascii?Q?qb5knhMwXtqIWi2D7WqUtJyrvmwjpw7xpOwhZEYIoXt02WcDJVMNuxdh9joV?=
 =?us-ascii?Q?SJxASVydTHUEGdYSzcb87YBxV5vc8fG/X+yTKxHumLfSmOMZKIyVEkuXlmDL?=
 =?us-ascii?Q?GNMvDKlqtNJKGEMNXj3CHKj16y2mSRq3ecc34QaLou2WZlgoysrMtV09DD4l?=
 =?us-ascii?Q?dCUOQ/eOa5A1V+glK0Zo/+gew7OmNe/z7raCeILf1dQHQcfBt8zACBUy45iM?=
 =?us-ascii?Q?EE6OcIq1McL2QCtxf+r4UW7PU68gP2O8red8p2Zgu+XSNylSQblAg8kwDN3h?=
 =?us-ascii?Q?oSp2YIi8NnqMZa1vuUY8u8ruVjjnrc8kv6Srg9ep7WvrvUVCC9vfdjtilyIe?=
 =?us-ascii?Q?e95HsN0eDG34XYky4FZuL4qMEiIGt5s2v9qrWGzakVahMplGO8lqDn2244j2?=
 =?us-ascii?Q?LkKsVz4QJF3QrzaYHeiiyNXdWZJULMQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9d6540-7b61-4692-e636-08deb1002b7f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10828.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:59:02.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gCmM9W9e0hXKnqfbSh2kKazavrCfZmAqQE8TepG6IYU/osb7Yp7s1ijPs+Dx9D3GG65R1LZfKNAXUmlOmX+tjbcvyoSrQgisu8JXLGslaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6255
X-Rspamd-Queue-Id: 691D4535ABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287639-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[polina.vishneva@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Denis V. Lunev" <den@openvz.org>

When the host initiates an AF_VSOCK connect() to a guest that has not
yet loaded the virtio-vsock transport (i.e. still booting), the caller
blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT.

A caller that wants to know if the guest is up yet instead of waiting
could theoretically tune SO_VM_SOCKETS_CONNECT_TIMEOUT, but it's tricky
to find the right timeout, if not impossible: there's no way to
distinguish "guest won't reply because it's not up yet" vs "guest is up
and tried to reply, but was too slow".

Furthermore, this delay is pointless:
- If the guest doesn't initialize within this timeout, connect()
  returns ETIMEDOUT.
- If the guest **does** initialize, it'll reply with RST immediately,
  because there won't be a listener on the port yet; connect() returns
  ECONNRESET.

That's also inconsistent with the behavior at other initialization
stages: if a connection is attempted when the guest driver is already
loaded, but nothing is listening yet, we return ECONNRESET immediately
without waiting.

Fix this by checking the RX virtqueue backend in
vhost_transport_send_pkt() before queuing. If it's NULL, return
-EHOSTUNREACH immediately.

Callers that used to get ETIMEDOUT will now usually get EHOSTUNREACH.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
v2:
- ECONNREFUSED -> EHOSTUNREACH.
- Use vhost_transport_do_send_pkt() instead of raw .private_data access.
- Removed READ_ONCE().
- Wrapped the condition with unlikely().
- Updated the comment and the commit message.

v1: https://lore.kernel.org/netdev/20260511145610.413210-1-polina.vishneva@virtuozzo.com

 drivers/vhost/vsock.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1d8ec6bed53e..9aaab6bb8061 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -302,6 +302,22 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		return -ENODEV;
 	}
 
+	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
+	 * and making the caller wait is pointless: even if the guest manages to init
+	 * within the timeout, it'll immediately reply with RST, because there's no
+	 * listener on the port yet.
+	 *
+	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
+	 * the mutex would be too expensive in this hot path, and we already have
+	 * all the outcomes covered: if the backend becomes NULL right after the check,
+	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
+	 */
+	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -EHOSTUNREACH;
+	}
+
 	if (virtio_vsock_skb_reply(skb))
 		atomic_inc(&vsock->queued_replies);
 

base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
-- 
2.53.0


