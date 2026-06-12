Return-Path: <netdev+bounces-298740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RO5uOdw6LGo2OAQAu9opvQ
	(envelope-from <netdev+bounces-298740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4667B239
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=hqBvvFAh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C9931BCE23
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E440627D;
	Fri, 12 Jun 2026 16:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB9404BD7;
	Fri, 12 Jun 2026 16:57:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283457; cv=fail; b=tZUqfaUYCXpiollboE9uFFLAU++mNuO91vtx9E+0eUUiBnItF/Yi8t2FLhgVyDApznqAZFEDs71ANZZU2G1Dnl/vI5zBEGmGEuanyRzki7DZphGuBYOOMICeVn+4aETbctx21yij6UlecWaxxEArbVZYG9sqvhhW+GUDbT1qlNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283457; c=relaxed/simple;
	bh=hUC/KShmbN+6yoieJbYxc9dNyQEv3s5BD6TpqCmjS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mOtlQSEzNfUSHkBJZtJ7vnT5CHY98XJrMw5VqwkmOJH2poIGV0rzyekPxmIQtSegfMhYFnNhWf8bWGjzV0rRLZjIjSwd/tdCyCb59HNd6VMUx2MY1C+DRruqCYXHqKwjdK4m7ERM8xMbW409z1JY2iN/MbXQ4oCHuuP7VU4ibuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=hqBvvFAh; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq0HmvO+L0Jt2ec1EBo6D+u6a07o1s3MUvHaVJJSbPPXaDDIVQ0haB/O6tuloBXv30R962Y8v0WmIHj/fmvO19MbDmVgFIr6aM+JEMclpxgSApZ79nZb82TL2ICOgMKCyNE8AYyY96w4bxXVRmkuMyLK1goxqPOZFnQmizQx6cWe9OZXH2k6TPppdW/W5PCdVfqT7pbW3bFAp/nFzRGMgp56MWmdhkWsbHg9SrQBhZARTWi/V8z8iqPzdPAJZorTph9nQ3HyVSLi7jdqc+aL8yRUYeNuH9HGKeEH1hT/SiFMrFpo5cz6Dk1g85zgnStfLlc4iOARy0N1MFRVpZiRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gySx8ma+VlhEk8MCLNl2Ow7Mqs2pdkDHVchqNvcKSlg=;
 b=A5dxoInRyjTf4/+ARLdXW/A31Szj8J/olzuEcUWC5IiRvPjrV3hAb4IN76HSgG1bur2bZ65PH8Ga5gPnYdjV5ZI2HpDu3HCPb5loEQF+pkZ20gsCs72JEjPcTQ7INNvgjrFd7f2YRcooYCQT+VUrRjBd7Y9k2HQLRyXyN1yw7s0n0CTEJe7EbS4QZ5RRHAussj+1hmFz7bW2yeh51n2Q5OpKPtViQ+qtbqB8nTCGPgOw2zR/w4qJMPQeZa9//Uq2fCcG3S0gMpPnYBaSfH3IELdGc3turRsB56cKLYJp4IazYqA0k3gaBOqj7e2m43dfOKkarFEodX5AP6J95SoQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gySx8ma+VlhEk8MCLNl2Ow7Mqs2pdkDHVchqNvcKSlg=;
 b=hqBvvFAh2OEnPLFdzsUgpkARY2z19sV3j3M1DkFETCfCp0yecDM65XuNioHZx1iQiQToZe/DtHvCckgG6FakU+wyizZnkGoLHuluekc+A73iWKoJW4UkNLA8eZxSlfuOcoFS9Cavu5b0uC6hfygedKqov6Ux9jeBRFM+87xysjQA72I+w7ulD3AMBRP0j/gFofWgN+Us3Qc2LyfdZ0eGoGNxNljFT+LiXDAfU8xJKCN/KsPbxXjf3++iMNUUH34WJ7DOcSml0gA18UgQ/0+uX1EbyzZE4T8PAbpykibzdk2USMiTTfRodrM/QrvVZd083EHfx2RMHNkIgbdcANoyoA==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:57:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:57:25 +0000
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
Subject: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Fri, 12 Jun 2026 19:57:14 +0300
Message-ID: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-Office365-Filtering-Correlation-Id: e940afe5-db04-4dfa-09ae-08dec8a3adf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|23010399003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	IcLrER33xHye1r89PM/tP2Ar8odAANj5nqTf0gmimNDNN7csEa9anQEE2S/6e4D4TJNsoHVgLc+QWpF7pWus0e/V2N7qav56QrdPTxR1BONQdBj7vaWNycwzRife1bGjHC9JQ+CJomRu6qp7FQ+yRqdWYZXiCC3tTEATq2ZLn4ob1kp2Dq295IDHE1T7O5SYWc1thBe3nfflzeM/Ed69Sh1RgaSvNbcP6Yl9mRwwETlqPgb7fWi/NmAUGTJfjQE9icgYD4yuFOr1W2n5fC33YtcQEBUjijWApx6sH7bXbaHFAaAx7lf+DLWUI9qMFwe9Qc1Z5RNXGgO3LecN5o7Yqesz9rL0yFWRKUkkf86AQMMc0TAmLGz2zaoT0ShF3/8X9qzQ0OA6GfoZt6HtDRdunx/ugcrzlR24VOEgWPIexIHhDFHkX/KfaZcZqPiGYpzKPxuyiGmXnIMPLQPfGI7jm8WZ3tnL2j1+jGt2446lwh9mTm0a/48NfoIqj3fqNYtt0Uz/Y2iwwr1GIWR7jw8ehun2JTlTtnYq8ep9VLU9XwyD6hcZTNOoIhs+rfC37ImSrA8bl63YNtO5gvaZsfZvK7VoWKXDPW/8vGtsHu/XY9MgTT/gLB1FdJOmn2ZQKf7aljzpai+oq610tM2tK8LFYAyWWISw6zFfj70GspE1k/5bm67yPhxSX1X0YQs8xQA4WjxywE+4zGS0qo7bW6VoXD3My501y+3enWjTCyRrWBE+A8GGBYYF1o5zZLbhziu2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ay5Ub8xs+ns8HliYEA5aoYYFc3msQKZlAfyeGm3B+m1wOKY6oF1qgvn0ce85?=
 =?us-ascii?Q?k0Ds6GoWQJCpFEosPQgl6QH8b6um5yAHaogkJKtXgLhII3JdzsDQWwVkVOl7?=
 =?us-ascii?Q?KcFlxRS1QNYBR6FSxm1ALZqmYzDG5IirQs2qat4GYbOCuRbLMx3lyxKFXjr9?=
 =?us-ascii?Q?uC4J8tBAQYH1YyDGZHHT9oQQqP3pI8JksKnGzT1u3TTplIBBfmQO6pO197Hv?=
 =?us-ascii?Q?v5yoBbVpRYWynaD2U5cyVsgYRCoDyGhQ/Rfxy64XYmnjGHzmHKJBzDNLP0aZ?=
 =?us-ascii?Q?EVbZlt//y7MLXslY4cS8h5ipWYrRCNcNpaFzqEydF8B7WVc8sg1AmbvSihQr?=
 =?us-ascii?Q?EdPFsy7UbrlL+/bqrwvabGze/tOVU1XadDeGUUMptSomWCIjuwuL8OSqHjG6?=
 =?us-ascii?Q?oQFM1IiCihToYxrbz7Er3tpWTqjWkiytL95jy1BwhNFKpYFfKZGriZ2sR7qC?=
 =?us-ascii?Q?GzomEKTlYhN03rL0inGnP9e+Ov/Fq0XBfLGJbJf3R2XXm3h/iZy0teyRB71B?=
 =?us-ascii?Q?6Rz+x4XhjRMYTGDZl4yuoqOaHr5i8WwSGJK0obUvAILG+JQ+TVAIY1L6bHfh?=
 =?us-ascii?Q?3NIKXdKRnfyVfQUr0mEq45KX2l1t5hYc/1kKx7UgIhKnh9k3xY91cGw2knAN?=
 =?us-ascii?Q?zwMgWu1bvvOuQdBNSPKSN6OU6lAM17Ruz52TbGauIw8tubc8KLpR6mjwEJgT?=
 =?us-ascii?Q?mnYmzZVhk7Tv+BNxBKx+Q/64Kpis3I0e8uLKknLMqE9H5IYj+lJob1+GoI4z?=
 =?us-ascii?Q?QjktCsghImWIoUAumDBuwA+xBfPPiPhV2Jog5tg0FjIkXlV28eOg4Xx4d3tm?=
 =?us-ascii?Q?x+7azGmVIHWhhXyoqyCiwKUMnk0SI8T3lkdBsxfeo0L8ANpKThSkCgeF3zlL?=
 =?us-ascii?Q?8LjRGHixtlcBdlTaB4Tpouj9GMOajOxRhlLj1xLMfFNfH+sI0tBywXvFcZ2K?=
 =?us-ascii?Q?vyK5Re9KsM/I7hu005ZN4t+Xw2hIqpnDqPQtRonXxTc1Q1sZrEPQ8QpquwbA?=
 =?us-ascii?Q?fWDqjjezxn8nZcq+g9ac7sRB6ColQRD/ndJLjTtFTSdzG3f6jfx6d1Ee6PoH?=
 =?us-ascii?Q?DGq3/l2jLDAbc5PFt+bj0SOhUL9gj/+/saJIuVO6zy/MaZL9sKHYqBQqmxiQ?=
 =?us-ascii?Q?gYwAPoamWmoYwAkkM4K5tpFMMpoZdX93bVL7hWUvjZIjcsHwuNGeRRCp9V/z?=
 =?us-ascii?Q?UPto5zW6DjEaY3gGutX8c4nBYLyYryx6nZ3k1akF+RXdnJdxae6Rf7TH2TGs?=
 =?us-ascii?Q?G7Qqnjl0cuDzy22UitsylVmoxG5leS2AcgYAkvhKDpyOXBW3UoHrZGO93kw9?=
 =?us-ascii?Q?Gp2bo+lo7mMsKG0X+D1A59BF0Q9kZr+q4fbGH1Mld5VlvWCIrajBed45m7t9?=
 =?us-ascii?Q?aOLDnUx6c7Vmhs2wrJ4IQcx9wm8YUq8GwNp9BwcLtqu6QWvqx2zh18u6JPtb?=
 =?us-ascii?Q?zZvosESKPAespdAM+YcyD3eYPNEvC6FHHZxK6Z1577QtX0qD8jSZ0Cwd7CfX?=
 =?us-ascii?Q?xBREkAZGgYTzJtk9IDbjKL2tF7MTXn6G/1hgPEq0gKrcs8fFD9ve+pTzKbCA?=
 =?us-ascii?Q?Tg6mD4lEwjvgmgKqn8Smwont9RlTpGxDBpIvC9F9uw1P6k4hNqfNowXn0kIj?=
 =?us-ascii?Q?broylMHyMG/t2dJKXl8hBHchqMkxV58CabCXVzE5vqcwlDThvL4F3lLlWFJE?=
 =?us-ascii?Q?+UDYSki9ja6b+3M/hRRlko4ChL8tcA9U6m6WYJ1pME/BMotrWPUVpcmuL92M?=
 =?us-ascii?Q?4hoqxmiAs3u4giaY5gV7lLefNWeOj+g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e940afe5-db04-4dfa-09ae-08dec8a3adf4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:57:25.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEC+h+Juxs67KAR2lccGsmaE3SafJ1IVFWe51oagjAwjHkHns4GVBrmxykmiAynaBnRTBZRv162g3QYZoKzMaZpkUoQn7khebKLM5YgkcPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:mid,virtuozzo.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BD4667B239

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
such implementation (patches 1-2).  Also fix regression introduced by
the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).

There's a complementary series for QEMU [0] adding support of vhost-vsock
devices during CPR migration.

NOTE: this series needs to be applied on top of Michael's vhost/linux-next
tree as it contains relevant commit [1], not yet present in master branch.

I've tested this (patched QEMU + patched kernel) approximately as follows:

  * Run listener in the guest:
  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin

  * Run data transfer from host to guest:
  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999

  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
  * Check that file hash sum matches

[0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b

Andrey Drobyshev (1):
  vhost/vsock: re-scan TX virtqueue on device start

Denis V. Lunev (1):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 11 deletions(-)

-- 
2.47.1


