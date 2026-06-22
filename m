Return-Path: <netdev+bounces-301186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DOm9Fqp4OWrQtwcAu9opvQ
	(envelope-from <netdev+bounces-301186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E166B1A76
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=kReoENlV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125543076B1C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200B3438A8;
	Mon, 22 Jun 2026 17:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94D3438BD;
	Mon, 22 Jun 2026 17:58:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151125; cv=fail; b=KM4T/r7sdJES2MBIG4lJ5J9WknHJ2WfPBAJNt/WkLqHPSAnqug4Nd6PTYl4oZEoVLl3NatJWSvjLx+LKIlIrhxOtW8/uN0eEzMnLw3908/U7aQycOrPT1QgrzvjnO75OM5MqyQY4Z5TzpqeOw8B3HlG/CEnGzpJvhiIaxwlrjgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151125; c=relaxed/simple;
	bh=yTLThcGydK/L17GwBlb2kwpMd68Gwnw3ouBaDoFtnT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=perfG2RuKc94S5oSqZNnjLTwAtrcFRKnkerXPQEKn90OtFyzBg1m87hv18ctNl6i1jzw+qMcc7/EAeRuaVIUZgseOr9u7k7dRQe6+TmNr4OyBn3w+pNwyEiAQV34uar9mY9PRd2JZ8i4fj1VK1QMSLsGQEOdV+1P4KFTOZuoXSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=kReoENlV; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilUQKc2N8bzuSshNIjsBBOE9TzYB/Kbg+UmCA0xTbc54RvszeRKKoCJRF06soNxy7tl7dM7IWA6DsGIIXAfIwBEKT4UorWIETds2/KZrCjive9y4VOeN0gTK3bhgLDGUO57dn8Iakx2RiOhZvhYNMno/AYbzl82F0C9o9Du4fvmrOHSUdtJ8GVWG/1+GVLQGdO2fMkHNW6ldOd+xTWc2ecCCfydcD/UnRDUPt5ZdOsnZLbjHAreCIypYY28iXWNmMWP1JZjKzQEwXnurzCGn9W5ZpP/ao5mSkOYakEeeBQ+poRfGM3OQfVkRh0Ie2AoBjHfdM6VSshaBH0pH6CVnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyUk4KHQqoGf6ePjt91ZfxwaLv75MVytLydysIqTSoo=;
 b=Jv0P5dLqQIrM91T8TdiV2ODEfdZjt5qdu6aWT4OD6EcOiX1x39mK6FXO8E8C5FdLKD7Xi5JE1YL3zb0rysB7gSgBEzM8cCQh2aOdQM7MJvsrrMoh6220Rq/XYGHMDb35AB6F0OMk1FLq1cOste0jJj2UGezcgNjERO0VKu2x1FiiIv9TN8r62DFUNnTOqt2iQT4g4vMGDv/L1cN0WTGWWs+wgtPqzKMzIhOqpo1FZR47uZxLe5Hfle5Ag+ds6t0v6ioMCoDLLmlP57/66IeWZQZGet7O+YOZk/AJRBjLz8SK4XtoQo4YmT9Rmvd/XnqmyAQfJH+nq3pO4cBNtD8A+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyUk4KHQqoGf6ePjt91ZfxwaLv75MVytLydysIqTSoo=;
 b=kReoENlVu1ag/4XzARVBTmmJmSaPsJQbLzHyQlqu0c0iin2xRZ8SVZoRtB8FN1Rj1RYG1HphWW+57CHnmZThjjrqa24aB8PutuQkxgPO05m97r8DSY6UaMC+9nR0Jh+Ep87WBmzKEDB9zbKg5DzuYBAYzOseO1xUODCNhKO4jY9nrIjp5rkbMgHrjOwJ4UG400czWsKGji5RhRORzhRsWPk20jEct79uUL85hoM5imZRRm2IImJyHmHH2GwSWbSihVEoeF/b9FyFZFoDga1wuUKMgY4nIPUiZaLbuuM2M3w0khPfm5YD34WcXMMQek4rjXo3etBoWchVKvI7Y+A0LA==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:58:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:58:20 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Mon, 22 Jun 2026 20:58:08 +0300
Message-ID: <20260622175808.508084-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2b2a62-e904-43cc-3647-08ded087d87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|18002099003|22082099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	j7osteW98XrjsI2+PE5nul2CQqNGhRJnZQfvyKrKMVQ7LkJgImFkEB9ccJVT9Y6ehre52/RHHsiGJMGHo0TcSywVRzLLTOSMk/UW667ug9sa4bcIsAx9LT19hM9fCAoTQLoXRxo96AQEJA+7q6VWYVRCZCwLWRpKEKu/26S4b/6rhoELLXeaFhH5PwtCO8WIeJAnQxWZMTK4008FL3HPCEBSUfHue34yILxoycy1740IwSIfPeEuIi8gGn/qEoE3j4V1JzzVa6GomLfCnfnftDHhEtat4vvApSMLftlonJvZK95U3N8CJZ6DOHs5Wnda3yGkRCScIe5c3ipucUNd2zJ2C6i8+T8C98dt9MSj955Cfqfc8fft/2IPbZ9IMDGzQUrs/U/BzJs3IloVxewKLNpmy1lv5Oy8XCiBDmWrgFBUKqml6QHaUUrsGrvIovKFWrhEdITEZQJgCMPf/T/TIG6eyFnaDfJ7qZyEm06FdesjIhVJ8v38+7S/dx1nIgXvaWl/lFA6XJhbfUfRqW/apCCbcZq542sU4k/LZyR9kT5Ffy8p43JnamQFWQPZJZNBcMIyv3mgsvjgDPbsdyalvzKMF7EzUi4mbUcT+AEfXoKnhzDNWnBVekdKq9RjeI9S+XlUXsklf40sK4w0vP87NNe/3XnsQWEl+whbpWFsV5NslcUTnCbRRYis0h15NmI6wfjetd9CbEu5/MJaMd6r3SZ5mBJER0+TfAB85EkTBAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38350700014)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LHAN1hg39CUYguVUDW6nfDpsBEzJjTqBv7b4UE98CLO4dYdvbHHEfxcFDV3c?=
 =?us-ascii?Q?5EirnrYq5t7KoEqIDFwGikpBuRGUZmeJayA43fg4O1pwbxpeeBbqLohNGhjR?=
 =?us-ascii?Q?LqYXgqrAJfsoMwBn6dEmJMfsxW7AwdnoPgHHA/mZ8eCKtEOJqIaROwdZS5nt?=
 =?us-ascii?Q?55VDpIwBZipKxWUzXEccisFfyBeUFx9dAhQlYaQ+KyfZ7LuJWuK4dR2BX3y8?=
 =?us-ascii?Q?lDgPuCy2S7d87GFo0idmEft3wAz2ap7K/Pzki04Sb1cDUgi6DFzNVMKuu5iz?=
 =?us-ascii?Q?+cqMEobeGKxuF3UEwf7qnjb63AonpCVMxizw3rAUdkZ52/ZzEZyzdU+yfVov?=
 =?us-ascii?Q?UfmQtIr1NcH92JJk/VRLIssdLJfK23ID8d6k4cLDa6Fx0ZfRIU2GpRf8eXTR?=
 =?us-ascii?Q?QtN7G+b+JIBWWAuMmqWghcW0TNtrl41rgCApSdNgZ8k4GekfDjWtBAkyPzmj?=
 =?us-ascii?Q?3ixlqCMgRJoMVB8gmeNpa18phWjK/fvEGswqJSsMLiFkZlSaA/4vMl6UWPcH?=
 =?us-ascii?Q?3bGXXAHZzMctIWdILhkWdmzdTYFWz97d0SHU9jj681ks9Cj2ETWy5Oa2m4yG?=
 =?us-ascii?Q?fhXzvGAkDUinDIufiCJnL8095RO53dRJNEdrWwSbNslIzeQpTBo8A7Zt0blC?=
 =?us-ascii?Q?GAOAcNeKkR0OhNbqtYciIRAYCOe4sw8Gx5zrTiXLXEoNfyKnFc0Qisap12d6?=
 =?us-ascii?Q?dNIcq7bMunRnYgT08npq68K5Id+sKnIPCXgJhOe4g7q/g/4FYW4WZsqk1LvJ?=
 =?us-ascii?Q?7IeekmOzlZPvV7yG9Ev7vZPl9rB16e1pwOBZo7zIGgOW7a1HKIAamnnjcofQ?=
 =?us-ascii?Q?SwpeT60rYGBn1g4WB/32Xr4MlTcuIG+q8AyTL7yFvd8caV9ClEXzKHPFPDQ8?=
 =?us-ascii?Q?rr370y5j8cVgO18w+jwiS7ADjtO7sURr2yOEElObz9ge9BcU0sS3mDdb7lg5?=
 =?us-ascii?Q?GecKNseCD6x/YX7V02/OSsFO136wS2oY59llALRZisanYzuvnZHxqCJAz4zk?=
 =?us-ascii?Q?uDweCbXMNnXZZYBPkxxLpel1deegJKfY+LnvEfl1w+JfNC+RfkWEtQLvrNPN?=
 =?us-ascii?Q?WLpdK6w+sSU4aroVnkgo4WUKwojpez3bSvL2k+mUTqxaUj5SE9KM9IaPx9j3?=
 =?us-ascii?Q?YfO3BQMROwEpVly3so0RaaC/7pXI/+P5nQ+z0LHGo9SFnTAeGcCMpG9sULMx?=
 =?us-ascii?Q?Z6fdb1ARZ90nIzQhHOEREmwnk2DCRKaGBhlOOdKlLTABZE/u/mZa3Lj+iGXj?=
 =?us-ascii?Q?TThu8ah26XNIYK7R9ECmGuh9pvOUEtzvQfzs9KoRSFjptmD1NKcHWg2PddM8?=
 =?us-ascii?Q?9d76YjqEntHuX7zqTpIzr7+sV53UrAvhNozx6dXftRBLZNHo3KETznQvkqsA?=
 =?us-ascii?Q?ED4yYYvQlyVdZ4CYmeF+gq0YUq2t7BThU4xf0MNkKiR4KRUVAWdDU3kEcK07?=
 =?us-ascii?Q?JhnZGe8LPYqXWXIOwOP/R23J+bq3MY0M484p2IdPY2qbNgzscyRbLGGjdZy9?=
 =?us-ascii?Q?5bt9n5IML+llvpx8UtgqJTfue5GzQ/XwB5TkJhJJXq/6c5KUjlj/xJ3NVxwM?=
 =?us-ascii?Q?ppAsfqb0/soh+gxs465k9UfLp0X7eNbDlWy8Zg0CuI+k+83GCe1gHLIx0f+A?=
 =?us-ascii?Q?Te9ynbdl1slvxrryNbaBe71qp372wzdDGzEr3TwIIkl+K3n40qoQpW/0EEA+?=
 =?us-ascii?Q?fVB8eypdZuVV0KTy5z4GI1fG6jtc2TPs7pF5YPtYSD5FXW+e/C1HNObmw2Yx?=
 =?us-ascii?Q?ONe75dWEz4XQoLWkhkIy0UIgzPdRvI8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2b2a62-e904-43cc-3647-08ded087d87c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:58:20.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4v03om3ZjR+BcLwbIjfLOBoCjgxFH+Vyr04sbFqDP1FkSqquuKSI0EzMh1T+CRFdnZbqgtS6qdBdbcs7Hgaw7ZAunlSXKl6WapqnloWn94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301186-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1E166B1A76

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
the guest with vhost-vsock device.  For this to work, we need to reset
the device ownership on the source side by calling RESET_OWNER, and then
claim it on the dest side by calling SET_OWNER.  We expect not to lose any
AF_VSOCK connection while this happens.

RESET_OWNER keeps the guest CID hashed, so that connections survive. That
leaves the device reachable by the lockless send path while the worker is
being torn down: a concurrent vhost_transport_send_pkt() can call
vhost_vq_work_queue() as vhost_workers_free() frees the worker.  That might
cause a use-after-free of vq->worker.  In addition, any work queued onto
the dying worker leaves VHOST_WORK_QUEUED stuck, stalling send_pkt_queue
after resume.

Fence the send path around the teardown: send_pkt() only kicks the worker
while the backend is alive (otherwise the skb stays queued and
vhost_vsock_start() drains it on resume).  And reset_owner() calls
synchronize_rcu() after drop_backends() so in-flight senders finish before
the worker is freed.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 81d4f7209719..7d0146cd38d2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		atomic_inc(&vsock->queued_replies);
 
 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
-	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
+
+	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
+	 * stays queued and vhost_vsock_start() drains it. Pairs with the
+	 * synchronize_rcu() in vhost_vsock_reset_owner().
+	 */
+	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
+		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
+				    &vsock->send_pkt_work);
 
 	rcu_read_unlock();
 	return len;
@@ -903,6 +910,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
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
+	vhost_vsock_drop_backends(vsock);
+
+	/* Let in-flight send_pkt() callers stop touching the worker before the
+	 * flush + free below. Pairs with the backend check in
+	 * vhost_transport_send_pkt().
+	 */
+	synchronize_rcu();
+
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
@@ -946,6 +983,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
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


