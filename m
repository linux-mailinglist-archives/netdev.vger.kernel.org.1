Return-Path: <netdev+bounces-262466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtSOAvkpGnFuwUAu9opvQ
	(envelope-from <netdev+bounces-262466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813E1D241D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AD79301E208
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B33253F05;
	Mon,  2 Mar 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8EI44zN"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126820CCDC;
	Mon,  2 Mar 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772413930; cv=fail; b=ra8mF34K83yfHQnA8eOr3r59A0vz1jJ0AvJl/3xjPz7X5bnfWBLhaZgBitUTmHZ9Rxd4JjB46C6HSsc6yGC+pUDjv5NvQ7IuaE92Gx9URR1XX0leu+IAiF5+RgfkxPQ7JjNp2ZHxEaTSLlCXKSA8ZSQ0nysScOqCj9q67y7Zn1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772413930; c=relaxed/simple;
	bh=SCPVCqlDfr943xdYC21elBEp6B8M9HdQqgrKLk5Kj54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JT/q7jeXOf01r749vUnygb8BpmzwlBDYas8j1hnNTa7NNNaOvRydEr9fPLIKPZK3nYPMstGgp8AF9oqVy1hBQgQ6kLHI07czjblqLFwLTU21DbeESQ0m4XzJ5cdvKfWbJV0pesUQ8D4ap4f62I8+IzbxXCplXBv2vTy/TbvHJy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8EI44zN; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU9NNPalVVeHpRbrC+wsFkMiuuwvOC06gbV86bJTiRV0fxFt1gSLT9P75eczTB5xAwPtVS3kQVyiAWJvtH2AAyKPW/PQHDVpNlkgz7mFsMZec/rMrjFKQfrS1Mki6LvCLbWnEyVHoyIcRVovUxo9OJfoaGubgKRvXNd5DhSA/YPsvGu190ucomtUmgWNgJ5/2BP49ZgERfbAingFc3Bk1zo+a5meJfTvlXuJZaDkYYHznDW5QW2BS86ev/SGM46uIUZS9jhgQmF2jv7SEMwUDZmkfqHzEf4YAcCAvd5Rf8ySvVfbXTUBSKQW2EyzukTTwWi3l076rFMB5PklqnTBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXdoeZXUo11GbYcgW9+O9sb+qIeVeFihPLc+0pKtR/s=;
 b=Vown2QzSlUnQmVEtmdnFDXkV4f5gNp4xyHCiJmicj8aE80004/OS4lvnozncIA3U7Y0/jXBNWQdjSpM7WAQDr8GALlT0tulqmWc8YmKl5ZnuMaFMB310pYb7uoOng/gnlzcRS0HAIJzW2MSSk56cuytiKR3UTHFtLy5I8uM7KEth2IEl+HUKRej/SEvr3Mf0lU5Y+twZ0ygn83k6wtkr9AN1rop9CRLm5tu1ElmGA4JWVImnJqcQxz5JrR6EKXivkGz5DKDeftzFUDot2RBxC8X5XfL/fDI6xP4zhVWukdl2YER9KGbCY5idDF1QYVUa3Fe3wf2weH/vnzYb8BXfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXdoeZXUo11GbYcgW9+O9sb+qIeVeFihPLc+0pKtR/s=;
 b=K8EI44zN439ma9xFJBE2Dx8cORuR0sYkIHL1IQFsbm9wkwCqwTCNhCdY8wj3cj95YHavQrXa20unhaVW+4CH58FgjuGuIP3k/ecwkpZhRApFF1RrCMb15rnzB6zdqQ+icvM7sQHv0cdNznfVpIE8noO0KAFl+CjirBy+6VdVweDJvz3jj2x1ZWY4bkRJh+0p6J/bvIXH7TLGs2mUYtGoz7sdyNekVhizos6MWx4daRStUd6hFm/oHbV7fdcrDVPQEMg9c0r7GzuRuPZfrNT+ckdnKXbgoGWDhI9Nchs2EFhoSA7aKLdjzpdU/696l40t4cul3Ir81E6SmFxUJXiCeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 2 Mar
 2026 01:12:05 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 01:12:05 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 1/4] bitmap: introduce bitmap_weighted_xor()
Date: Sun,  1 Mar 2026 20:11:55 -0500
Message-ID: <20260302011159.61778-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302011159.61778-1-ynorov@nvidia.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:408:fe::26) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1480c59a-7de4-4fe6-14cb-08de77f8b783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	bFCYY2D0QCm7JzyyrsCGEiKrJAZDt2R+snq/uQg/GkndWIxPxTayJTpiKxLSsrP6mkQt2A3iv1jIfJ3HIfiTeMMGpRIaBSiQRLtQjckDsjc/ighA+FpdXSvhqyL67SMQ7oCmF1Wgma3n4xia1EL4E5kixHdTnHCV8cPdgfy5HeiREGOkCVWWeZe02G+JbnGRmlEgiLdapJCVa/svOY0oXjSk0ght0cO8YLTlSlQZp/9zBk2aTAH0IUJLWkLaZcTWOH7V55QflD7T0EWP7OcRrccQ1Qzq/qRq3VVmMPonlwea8FPbUb/rp7EOkCBZxiLXotxHok55Mj8pVB8ayaSlpgOfnGOMC4GJaeuMEZ1l8zTcaoP8vMqSqoEJTxPc9oUjKUhaIEVuTInilTsc/Mra8Ntgj/4QHvSpbP6i8C2AMpXhqfd91lQsJIMuxuI9C/qoh8pRCV+Txpt+5OViJPuTG80ACWCmL/nLPGjtfwVADsP02JIS9OHI/pb1+D0CmeXJZH8bzu9KWE2CjoZN6VVKboVDRdR1qjs55dXRiPGGn0bvfjQVEJuhlOLq/NZ3FzYtRHRwRWiNk1w48GfJeq3UNjbakStYfoNuylVKlb9gM62b9j/fIL6N9SiRMm5tWTuD2HtIBWX+KIpbqDjO+qwOLwWXU7LV25Y4YHTYpkVDE3zF7kV8qM9LfFLeMsEGkRzRk2VP3wXwDAvDnNXMvD/tpbcTGcSj8fmhwMGCOAM14yqklVXHyr9Z0yhkMt6dyDJrViewf0MjG1yBWuHyorj88Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJ9Op1TpW5T4OHGrN/iibjwC4AIF6soHn2hyZG9GaeWjw8FUEHXxrwdtaBZp?=
 =?us-ascii?Q?1Qyq01Ujjz8M9Q8249gXhiWIAvN7leURrHftMmxNmhuAi44rjx0F8cph/V6v?=
 =?us-ascii?Q?DjPud0MfgGZGizgUZC/3rZv7vMD3LmBZPyw9wjMPtU7GyATApTTxI0sKPX1S?=
 =?us-ascii?Q?b4ha4iaitnH5uvYiL2IuM7DrYEf84qob5f/fCEvOUQl+8EXXcWJcrWH6O2Eh?=
 =?us-ascii?Q?D1Ry6oV7EwqsE+4eQerilie/tbiS00npO+Gv0SnB89Dz06W2a9s/63kZFMvy?=
 =?us-ascii?Q?mU9l23IdLA+9oaqhDkpvw573BUbEnTDB1b/5yk+YmaNJ3XN0LbQMWmLY/iQb?=
 =?us-ascii?Q?QmeMPtfHzrwrSsKCYRkm5B+txBGInOU0bnAHoWWhXuR7awTMECi8scjIgBqA?=
 =?us-ascii?Q?1ivNGGTC4EygxbRc9s3jDL1aZrq+mFf4ohOiRA1hWYOuWR0QT0kSx20T6BRQ?=
 =?us-ascii?Q?X09/j08osK4385fAS69X92D+eEayxX18qkCdcEVUtXJYjCT3YBsJXnq+jH1y?=
 =?us-ascii?Q?G+HBETtkE0E75upA1DVpTotf+1g7JS1YwTjMFFCYyG2QNbd0FYdwI0r0qSdJ?=
 =?us-ascii?Q?7s0PD0QSaft42YOLizA4zhIVeBAFA8GGjQbA5pdw1/h5/tekZyp3QTmzeAkI?=
 =?us-ascii?Q?QFc1THB6uZ8+wEQF0Jqkmd565Is8QOSIYjEBJO8D8XaDXhOw2Hil7EjG5eo8?=
 =?us-ascii?Q?n6F4r3aXXof7XulbYzKCg7iRWy93/qDEcgbx9ZjSS0RRQMxWN4oxl7vsoWXm?=
 =?us-ascii?Q?QFOhFCWO4XlLNnHb6yutV71sWtyo5iIzjQNDfibm/IY8WJkazW3WNGIvnSTw?=
 =?us-ascii?Q?PrcNBep4g+xM0u6QAy9hsJs958/a3kV0KFtG1oqQrtXY2NRy4K6QXh31HrHx?=
 =?us-ascii?Q?99UPS3xJWZskXPEKi8qtpJAczt7N36oFcfz/+DgI3RJLykLbl7uP6mvtfl5K?=
 =?us-ascii?Q?PT80x+TkNuWMtj7lc9N4zPrNrs+RADebwJEjpFWCvg6fOQLCOtLynLz/qT1B?=
 =?us-ascii?Q?o6kixC3WSoAtOruqhdt5kXfShYN04fdO80RT24gGj8h3tiTB+GtaWqAPP31K?=
 =?us-ascii?Q?oL6k76DMzsU2CjtxgPKreFL3sKCbGuuhDPvoPAYvJITfuFZ9eCcnCkKy68ca?=
 =?us-ascii?Q?J/hqsvWyAcLmZ83gDnoqu/fLM8CDoMo8TXa0O7j+N3oKlpI4zN7ZXYMsIgtf?=
 =?us-ascii?Q?Q0p0VARqrkyexBr9PVr6yI7UxFA4pSVv8UnJkbUM6Mt7ksJR1x2MW7zznWJ8?=
 =?us-ascii?Q?MTC6HK5v1QvRPNxnWhA6rvYdsrb/XAv0RhjL/cVRl7fi9uCGs/vcE38eEoAC?=
 =?us-ascii?Q?ZgQNzx9mcslSvxNWqGo/R4HeZAKF7+AvyKadAeC57okGT/pfgiXcCISmMN6V?=
 =?us-ascii?Q?nZm1SNRvgQN8olO/Zq3G77TzH+d/d10k/UWbK1USx8lUCqCxJ+zwscxVfSyk?=
 =?us-ascii?Q?jv97wGVglbOY7msrm5GUceHnGPDwPuxWQqyKYNsbd8hv8bRTDgMojNmGMDe/?=
 =?us-ascii?Q?z3YQtvuJMSN618XMg/TwPm+TxQfZl5aJpGpxSD2uUdkCyVI8D8IYh5djYhTe?=
 =?us-ascii?Q?QxtBuwrYc/duFMkc7g3J4+zhJxVOnrYUXkYRO8d7hXHvfZQTx5jknfngah5o?=
 =?us-ascii?Q?ETd7h3oTOD9KfRLA73U8WjQ3kx56MW1NBxUH6QMP0AXR0OMvT5AVbyxsIV6n?=
 =?us-ascii?Q?teG1i54XdV59Xb+JewKA01XAmgR1pzVsgG5W5pjsN0trpQSqxV8J27lAvlEg?=
 =?us-ascii?Q?050Bh+7MmXmlw9ZE1akWV2BwYLr+lad2+SkVbfMHh5U8CI5wgLrV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1480c59a-7de4-4fe6-14cb-08de77f8b783
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 01:12:04.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ifmHJS3s6pdnDB+VahUQ+LPpWzzEq/usT0aUJOhuxyCNb5OThSvwwm5dSTXdHyUqK4ql79FFBqdMq8ub1wZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6813E1D241D
X-Rspamd-Action: no action

The function helps to XOR bitmaps and calculate Hamming weight of
the result in one pass.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h | 15 +++++++++++++++
 lib/bitmap.c           |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b0395e4ccf90..874f744870ef 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -46,6 +46,7 @@ struct device;
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
  *  bitmap_weighted_or(dst, src1, src2, nbits)	*dst = *src1 | *src2. Returns Hamming Weight of dst
+ *  bitmap_weighted_xor(dst, src1, src2, nbits)	*dst = *src1 ^ *src2. Returns Hamming Weight of dst
  *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
  *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
  *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
@@ -168,6 +169,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
 				  const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -352,6 +355,18 @@ unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
 	}
 }
 
+static __always_inline
+unsigned int bitmap_weighted_xor(unsigned long *dst, const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 ^ *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_weighted_xor(dst, src1, src2, nbits);
+	}
+}
+
 static __always_inline
 void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9dc526507875..a2bcb5b1fe99 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -361,6 +361,13 @@ unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitma
 	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);
 }
 
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] ^ bitmap2[idx]; dst[idx]; }), bits);
+}
+EXPORT_SYMBOL(__bitmap_weighted_xor);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.43.0


