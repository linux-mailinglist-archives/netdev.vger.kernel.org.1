Return-Path: <netdev+bounces-301182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2MorDMR3OWpmtwcAu9opvQ
	(envelope-from <netdev+bounces-301182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3A6B1A33
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=WxYff+vm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301182-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9023020ABB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB15343896;
	Mon, 22 Jun 2026 17:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4D343885;
	Mon, 22 Jun 2026 17:58:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151103; cv=fail; b=MPUxbAm7OxpJ758RPueYHvUukqc+CNNWZj0ycyuxgZlFrWy4ESabr9ntERGkR0vWW0l1yQITFkYRx3XzIA8RZ4anOKzAMNRvQr2d8Dv83wOLN6TXozcMaW1FNJF1h8QQGmEY9Zt6ehfxOZM0B4S1vQHFkVGQ2hYzPWvYQbK+ZZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151103; c=relaxed/simple;
	bh=CzE+kCBXxLU6z465GAQOgb0QAq8awcHFVQbr2PQe0Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dXS90mxlOH6YRqqf6VinmF+R1wK9E9M5UpHZF/hjwSPEpE2F3S41OYqEfuqJumBIF9c1QNgO9UJlui0iLrg3k5aTJx/PY3B3uJfWaMnx6DpLxv00SMdrJhadf2cMymJsrg/B7Cl2aQrrM+n+6xP7b3cQNgKXFovRmB0nsjehCgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=WxYff+vm; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go88Fx5kKH/cj2/NNx8ghJfdLv4AlDwrxqow1CwfrC5mLxlNgXB8Cs+M/iQXstvcydUX1k/pV56Y0U+zlGyHnnj3/a8sGBCAdwmnZApfyRWS/W+JnQmSK5I78d14PQnkEvFP3fHgYWlccOpqsMNs4wPFaJ/AC/wIhqGkIeOpqRdRH+4w69EMwKa19KG3Aw+ggAFnjyW2gwh4mzeuqeK0Rb1p85DoXwKL44buwSyhqH2AJKBgjUv/0Nvit0yqCsMfeai+qvTNTXZkogAyxGhIT5+g6lXiSTI2P2qY27R+Z9C1/pxcDrMesY4j/fBBWbLAZg6h4glPqQ1norco6SxgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo5zTAxteDAcCew6voc2dC5jew5kr2Jn1w1zPT0fetI=;
 b=Bp6oNT4kJtqYWXEacbPYdvHhPtIBS/X0JWx5SZ3+AHEOB28T0RIdHXF07OFL7eCtq5EnMqsAjLO71cU7hQ0UFf1mIc8WnJOgk6aarwitvCS0ISrPQUflOoXTJXBibb4wDBtjfeNF9brVARemWx2/ACBQvq8rrPQ5LI4mj4MaOK4NV1Nvt6KvhF47DjIKKqLic6UXgR10fdF6cmx/jI/ES6Xaj95O6xH95mbl3XXiP7AlOvm5SO1M6PNG5akprOVFrC6ObVPT5qlISGmfQBukKtlH3OnoGUK0hXenqFP8TAze3sPs5s3nQeRcvLDFZ9s1qZH0ky4a9soXYsGfl51KDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo5zTAxteDAcCew6voc2dC5jew5kr2Jn1w1zPT0fetI=;
 b=WxYff+vmoggbYF6s0MD3/pxIZbuNsIzF4m7jLZTp4smU8D9ix/jmaToKHz/RIa7UTiVlZjFmAzCXvuG3gxjZxunYrGvsC4NrKxnQ83zspiTT/y74/ANChVPsYFj5NUKn1EpIKX2al7vTGZfH19E0VdLpQdL62SsKTxGBLPBpb0mY1GS07F50MbZHAp/O9z31/5cBRmQDKhDI4ROZG3bBarfbDREoZJUis8/Lt+35vV56C0X2UPwrOBM/susXgvjCOHDkrPi6RkKQxvmw1GAH3XlKBcnq3aRPX0m2IVOvWVyAF3YvB75PZO/Bdad2MGkKgcEC0gN6IWdDl9ygzWCT9g==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:58:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:58:18 +0000
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
Subject: [PATCH v2 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Mon, 22 Jun 2026 20:58:04 +0300
Message-ID: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-Office365-Filtering-Correlation-Id: bff7e6a9-ab86-49b3-32d0-08ded087d6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|18002099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	nOBaUfevcC3GhOga5JoQp944dRRtO/N6elXCABmARHuqdb4jHxY3aePMHi+HyYVGZPfdplvTArbN6l6jyz5oBTgx90CZjqS40bYb9UYkzEV7Uk8UG0YAHOK4SGfAeeddLs+Zn+i1mCV3npAKvfaFbky55rz7hhz5R0v5p76Cjt4jlSr3EHNyQJ5ySTvS8w3RRQRu5awe0iRt/0m4DrsrfB+/ywSvvlvUNj3yiqaMMXLXAlrrklllEkHjqLLHVpjXs6OIWSclG135IC5kajd+lMLAfwLblgm4QmMCh1H7nFC21BX01R+8uxUtJR7+xmJ6YQt6o6vWKcThOu7h7h6oZmjciE+yneDpIGhDL+cNC3CFRL3VQEdL/iZlB6DsFO+XNDZJ4zekv4KOFg5vp+ByUr7vEB8plMHl3vV6Bkxb+niyzx7b0WlAZOlhz4LNZxrZjqQE74XY8NVZYzBf5JE7wDFkPrEnnQHtOX2cB2l5KAbbH4wKH+Fo+O3YsJ3heXbEscjAdtwNQF+vxhFkfUjQ8nCxBVILCUFHNArE4qjaPFXkTooOtyd36AbfIrSAWq9vmFNV/G1vHA5ZgNmUkrWZ1AjIz7diVFuKh+RHl/9unufMkRGKGrLBx4qFmhiSNWr34KScZpicWccMDYX9JNbHCbErgGiRSLjGQ3ggfnREoyrxicqcUfGAMzJsZ49KEBxp4PA+QKtSIpY5A54cbxhrnh1HDZZCAlCuCenRn+gTHoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(18002099003)(38350700014)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwu6Ega8NnBGe4lvgvHl8St9HbhmWeFTZOGKi0BnkEi4bcfznnnpCDs1h7EN?=
 =?us-ascii?Q?GCFW8Sa3vkZ+dMScUTjFkFHOFMPZIcVLe+MXvha76SbV1zhsX0k2B9Of7sgH?=
 =?us-ascii?Q?WPUe86nh4sv4FhQOSEZ7zV4B505G3oK+EOTjCuqL3isTVIRqOOswpaaW0GGg?=
 =?us-ascii?Q?3j/sv1a6tE6HsQLJIVAUUqH6SMPcjx+t/oYFZtfT46GR4uIdSbqAMNGEPJUT?=
 =?us-ascii?Q?bxj3seorJ0QK/lUDp7app3yWXlnmx162Na4BKG4hTEcd7g1loH3DrHMyK+s5?=
 =?us-ascii?Q?cLR+0ni6hLpd3Q/eulFM2d/6JvhEvsQhTV6za4Z8V/ea5S6QR+X6l9UixROG?=
 =?us-ascii?Q?07KZu4raLe7k+PPHRXExKxjNGvfN3tO+aTlolnvRFGveyTPgQpUGG3vAHLSV?=
 =?us-ascii?Q?jWXp7OyE61xy6+e625pZuIsyt8yVGD15GRuy9oyFBfmmVNTJpTq6WHo4kbel?=
 =?us-ascii?Q?K7i7kZyAOvdV0dvzAMjiKsWBHvNBjrpD400BQUcq2sqPa0REuhF2BsXPnpNU?=
 =?us-ascii?Q?AUBxA2gsAXvFiJC34MrwoKEShRnODQYGCb662DR3Z8FqVEEQNufOHJdHwOgl?=
 =?us-ascii?Q?XFv/O92CC03qR4bexUsTUn+9dnzP+5SQNFBkbvXM3dpKgSNrrJ8RB/Y9s6wX?=
 =?us-ascii?Q?poBlo1mcyDDKrHjEelUeOalmbssCQemBImWviE1jJMKckoOGrThjhr9KB+em?=
 =?us-ascii?Q?XE9ywidQk+QnOSKLZxyezDR+IigiHhe+VkB2Yxo8VCHYjJpQQPeKyc9rRVGR?=
 =?us-ascii?Q?UP0smdM3kpOg7tIJD+KL4Gja9zT28WfrSzoOgu0ClCxy+Lqjofk4fXcvv0u8?=
 =?us-ascii?Q?EvUAF6sYXhLINwiWOR4rELB/GmsskfY2b0QnYsp6uD86PLZF8j7GSZeEWNLV?=
 =?us-ascii?Q?WNHi+97F3TB/RgbY5N/HNKWyiy1EeCk4WToDu8nta9x83+EoYXbdl47wTmat?=
 =?us-ascii?Q?YPg5CbT1xYH1lCPLw2x1AxcElY/cMrfpjIV0muQxcwoLY4/2V6lAQNCbjICA?=
 =?us-ascii?Q?G+XoeO1t8aNB/gxswJGUIWTmPpEAm13fJil1VuFfkciajaVVvO0nsHmUEwVL?=
 =?us-ascii?Q?c+h4USWB2lnHdNwlFsZZEOMKxVxX1LSdV63pbpYzj0Sa5UX0p4IkpFmxVyF3?=
 =?us-ascii?Q?8iwhQz8+StxpnXnGEY6rApFdm5odaucT/KDjfUEgeznJzFXyOv9wweIDkpuQ?=
 =?us-ascii?Q?E0tr2nSAeeTz+cLwLh/8zaiW4mRlKY3I6Y1votyN+Y7Z2A7vnB0rLox7rbmd?=
 =?us-ascii?Q?mRTfI+Gh7LBKuBW9EbXjjKmvBEiFeE8lCrA2kUHqiPlSlvJgeioxL+jcyKs9?=
 =?us-ascii?Q?Tc4dtr+MNfAWzYBKX4nGasSGsOd4gir56B0h8IyeDU4RERfEP28O47xetyaL?=
 =?us-ascii?Q?EvG5n2CRg+Oi6tpEee26ZZyB5bjw3pa79Vb0ldy8VUOHJcm9zENt6nlns9QM?=
 =?us-ascii?Q?a+WMZGV4Jcy3abbGqF386m+AVDnh/TXwUayHNt7UiEB3GRs478hw0H5c2R9J?=
 =?us-ascii?Q?QhH006SPK1WUx7ARv8uCs0L52KzoIMM3hHm+38/va/yxzeoHUIeQA3+fs/uJ?=
 =?us-ascii?Q?AdkIKvbPfveFjDu0spx328MHZhsJXR/9u6s5NOl7V7gItG2YoB5kZ5utMdfd?=
 =?us-ascii?Q?LjdtJreValtuZgFcfbkkE4u/a4JOz7x7M05hq6FvZ9rUvZdZ1sKK8FxvUaHX?=
 =?us-ascii?Q?xPBebp98am0VwKntKwkrihhyCGU6/I3shgj56gz3lmg7UilxXBtJYQKwdtXV?=
 =?us-ascii?Q?Ad8rq/1R/R42FKGbrGq0Wn8IIba0aZA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff7e6a9-ab86-49b3-32d0-08ded087d6e9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:58:17.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfFOGkhEJ57xsoFEdD4KsXSMPqVpHVuGXODXSXa8d6pSRoJSo3QmgXpQb/gXIyGgtVjV9IY00ka79ObDUzCcCHW24ZkprqOAp4xgJ9VUpwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:mid,virtuozzo.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76C3A6B1A33

v1 -> v2:

  * Patch 2 (suppress EHOSTUNREACH): replace 'cpr_paused' + backend check
    with a single 'started' latch;
  * Patch 3 (re-scan TX virtqueue): reword commit message;
  * Patch 4 (VHOST_RESET_OWNER):
      - fix a vhost_worker use-after-free / stuck VHOST_WORK_QUEUED stall
        against the lockless send path;
      - drop the no-op vsock_for_each_connected_socket() iteration;
  * Shuffle the patches, keep RESET_OWNER implementation last to preserve
    bisectability;
  * Reword the cover letter.

v1: https://lore.kernel.org/virtualization/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

Host<-->guest connections via AF_VSOCK sockets aren't supposed to
outlive VM migration, since VM is moving to another host.  However
there's a special case, which is QEMU live-update, or CPR
(checkpoint-restore) migration.  In this case, VM remains on the same
host, and we'd like such connections to persist.

For this to work, we need to be able to transfer device ownership from
source QEMU to dest QEMU.  Namely, source needs to reset ownership by
issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
calling VHOST_SET_OWNER.

Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
such implementation.  Patch 1 is a preliminary helper.  Patches 2 and 3
fix the pre-existing issues which do manifest during CPR / RESET_OWNER.
Patch 4 is the ioctl's implementation itself - we keep it last to
preserve bisectability.

There's a complementary series for QEMU [0] adding support of vhost-vsock
devices during CPR migration.

I've tested this (patched QEMU + patched kernel) approximately as follows:

  * Run listener in the guest:
  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin

  * Run data transfer from host to guest:
  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999

  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
  * Check that file hash sum matches

[0] https://lore.kernel.org/qemu-devel/20260619105514.128812-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (2):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
  vhost/vsock: re-scan TX virtqueue on device start

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/vsock.c | 96 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 20 deletions(-)

-- 
2.47.1


