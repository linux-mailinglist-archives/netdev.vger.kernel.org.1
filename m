Return-Path: <netdev+bounces-262465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLFHNevjpGmquwUAu9opvQ
	(envelope-from <netdev+bounces-262465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:12:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF11D23BD
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD0E93013A94
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B41E1A3B;
	Mon,  2 Mar 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFA0/fc2"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED5632;
	Mon,  2 Mar 2026 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772413929; cv=fail; b=tHDAl3dSrkIfSNV0ZavhZkbcIMdDGGoR1btZ85wtKFg+XqyozQmI2alwoe0f7KoAKSUuRIVVgzns82zd7waIYW8cWATu99URCf9MhpZdJMpuiFFL5AXik4YF5duul4dgm7Z0+h+Q5V+DuerPUXAcpFOYKrzaJyVxQNKXQ+MxPG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772413929; c=relaxed/simple;
	bh=Ah6REklwFDmyOIXBvdwuxt6vxZbkwWxWy+rAiLC7ojw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DRYL7eO5X/aDWu9uhHEXglxuSJxU42yVebEaABdr6uGWv7maB2Rl/Ek8VF5G2pw9KS+mhis33D8gXdVHQdaAUbSSBWromflWKW3RiUC1rOalb8+hv9Kvf0QnIR/7TKx036mQ6/pHNoTpakjtcoVTNRQesVeASg5vy+IilOIg/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFA0/fc2; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2PF5/HgZgGdfe3RcxgAFcqR858Wu4MJ7sqfYLy9BImyoAmdLyF1XDBAy8zri9zLQqh1UEeAeTppSs5kWQmqAR5QV4too+7gdk3q7BmO1EDgIKkWccPS/MKIPznUF8Gu98TuhMPcQy6Lf3CeNcnE1v3IGZTaiYHQ0bmp5xRodn3BcvEZb33PcuPA1pw4XSKt6mGsdHhAbQ10Emhnd9xyXewC4S6TVslrTCY/7JAyUarSRoIWOlauvflwQS++CH91EJdMH4TKwX699s3uvFPGXMrVaLXal0qA8VIvUD89OdYWQrW5q4kG1e1DCMy28EOLEnOsOy9wPdgmJIpG7en3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4tbw8NUukGoz166fJjNDQf4QJoPo9TRqkxvU3MOA88=;
 b=q+6Hc8YuOVI3Sxirg+15OiyXBQosSLZ1oG0sVv5SmpI1QGYQ7qboTceMvweko4Zextp8KhU/TEtkupTgSSh9BFgXHi4L4VjpNuzqQno9ppyCa+ygYaLVVxArVH4GQOx8tqDxSjcm2wdN/Xw7ikJJ9S52m6hEHPDrfHIzzeF4va2u3Zikst+QVK+7MqSE5e/AJPbItnb7dVswXJHbBbL9kD6k04tgAwYW0ZDeHE/p+RGjjN7XxrkVFaCkmNn6R3PN0n/hP7m+9raEnPXKkr+jRvCVcnsuq6dWAdCp03CFvrOUu+UklNS42SGeQ8NH50WERz2NBm235/suVaSxWxQ4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4tbw8NUukGoz166fJjNDQf4QJoPo9TRqkxvU3MOA88=;
 b=ZFA0/fc24R0NyWLGRdo/6UKf1usFTVX2bQsZ7mAcfW5jbr9C+ryE71t2J7DgSRB8C1WIN0D4CWcbLs2mnuR5USWfDcbmhPpGtDqlG2PFjQJ/S6paXwjtHLWFvv9h8Bfb+pvMj4VF1uRY7BrSvPBRUdBeiGoR7P05Wf/i0RkFuhCVwVnhz2DyxkYipNDfr34GbY78kKOdCnwROvuQ/prGLc+033M/qIfAckgM1Yo+FvzKGXLbbhuR/ojRm0hHzMnFHp9urvV5T4ShMDOg/VsrIib3oq9hls9ypPv8mVRjDfRrUQycfM2phgEUIGvFDx+UTmfaP+kgHbNDjLRrw3hoYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 2 Mar
 2026 01:12:02 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 01:12:02 +0000
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
Subject: [PATCH v2 0/4] ice: use better bitmap API
Date: Sun,  1 Mar 2026 20:11:54 -0500
Message-ID: <20260302011159.61778-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:408:d4::20) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eacefb4-204d-42b1-e989-08de77f8b622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	pMgV88tFcK1/7utVFrzhpxX1tsV9h7m7HPQI7sbmbmi7TOxP3kgbQb0WzJc4gzOS503jSBTaPq65w2Ox+eVzuCY7ujDqZqEvsyGc9Mlmfn2zG/64JTToc9BzV3Z9bO3Jcm3W+mpW9P+mbEsMfOJStnFHPLAAmQY6ALD9HtOoDLdOgJjXBeR2iqi9pBPcG5VYQeXgNWCybtnZQN+9TNr/LEPWP48y59vr+0ZB9s2O18Achvqfv1UZIjfkuxxy43Tq9cWaotLmW2xMrmKHu94nTScAcmCUY0JpfkVhOetCAEkb1TIcXgv5iwN/XeH7a/kFk+pwiIQG3jkDW0P6egWgxi4C5QTq69J5DCrr8/MYt1Hae8EKdlj2WLLkEFo4zOl8DxKIlLHkA9JykzoqMCjBzJTzdQJBkMjWRsXSSrtsGNQzUQizUi7qv13XG5j2QjyoZc6bY2zxVxwzUmfcu6RDQRYh6GFa4UL4daqtkbNFYB9tlUdNK5vb+3uM8E3QIf8rwV0qVlDAMqC2UMS8HtoybPX1pvCydqn5yIZdmvoeMbMv4DdEF5bdWRyawrOIs8Knd6hKkgNZkmxxA4s/8uNQ/bOThQKk80BOGxW0Ky3UR3Eo4A0p8egVEBfVSaCC72/Lv0C0/QtA6dboMb3xsromkLs8Ap+WjwIhG62cyr3RTwYfUoqYKjJ30R2rtPDdpCofhcmEYLtwwTtLw2HgSwAa1djy6QVCc8R+xyDNiYpk9dLFYLqrZsyS/Uf73MGn4+ZSYm5Ls8BU3dNI7oO3jW0153mEPYyFh8RzvruyQb7zdzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NdZaKTMFR4fZwm2n2hlIIEFrGD2kl3qY/j7vGw1CJGCm1tvVTUJKZ7z9vHzF?=
 =?us-ascii?Q?wFm/f2paaDrUuB8kSFWMFQQevMQaH0e98MDY5DQWDohOrb1Yz9yWnKrw5Kow?=
 =?us-ascii?Q?Gqzjidq67KZwxYo9GKoet1dwES5oUX+skIcqtUGeImV+/HB2BRkHaLnOMmv4?=
 =?us-ascii?Q?fPYmh3G8gaK91Rteh5crCRjkPXrwo/m7+pXUO6uOb91N7FDBnqqbWl9K5Jh1?=
 =?us-ascii?Q?5lIgk8TXaPiBunGJyECcEoMB51YlB2THZbHn0oNyN64bsj7y4Bk6LpiJ0NqN?=
 =?us-ascii?Q?KyxV1GV1ArnJY9oz6zniAic8opBteej8vSBKvEHXBbzthqmQpjYpi95BhOqB?=
 =?us-ascii?Q?81IwR4yQH892HLebUY7vALL9IPO9DpsulzyZ/MOTCemMni+AKlhwCw+Cn5X6?=
 =?us-ascii?Q?v/S6xD5fFjPtBvCxWKiVO6gmtoNaQj73FBR4n7vBo2waIJfbPsSHCpFNh9lt?=
 =?us-ascii?Q?sS/fzqPFgcKbcKDb6RKqS/cfl8T6yt8W7aZbTOyiEW8TM5pWNpv+lTVKBU2D?=
 =?us-ascii?Q?YYQIu8drxJEwkESNgKDG8yeMZBgEl9rzhtjm7lELlbFsSQykgZoh8yAVdPMw?=
 =?us-ascii?Q?Z7Vl2LjQ0J+j1V7Z0rlIDNRgzqpZRvkq/Ok7GwJouMjZ2gEUMjAW7ot7xNee?=
 =?us-ascii?Q?07ve8SyaEbyYMxvWiLOA1CPR0DCJzSgri7CyCMYdOSEd7cC3diLSjdi0yEwQ?=
 =?us-ascii?Q?L1N4BmQ/93ZJglehjm9iVYrg4cq+0OeiW7uFXH65SB5o8u3Q16UUTMig4mDc?=
 =?us-ascii?Q?PbjNsIPHg2L033QIEHy4M/otMDP453zEQCey+6fP7iZ5CNC+KRiL4J8cPASQ?=
 =?us-ascii?Q?W6/LekcSOl4X83DNmpUFtABL46afZQKxiVhJe20XD1hTqjGdWWzElXwGijhv?=
 =?us-ascii?Q?YFodx1NSdGWAHXeDi1Dkdf4SOITgWZuiol0oOfzLfrzLaLmPgp1eFuO3FVPW?=
 =?us-ascii?Q?58CRCvpxVoR656MiTisRzCXWQUN8mCa7hIUO8eAdJsMk7P6MyV2JlxeG4f6Q?=
 =?us-ascii?Q?12HY5PAoWQCmkJBRywFBjuHgBDzZXP7bvr27ILtN+twP4cTU3or9V4TLzfMP?=
 =?us-ascii?Q?CX3olBC42m9DjTPj78txaELOLjSgslKi65B/a6of4lgP4DsUzkHLE9XDHTo8?=
 =?us-ascii?Q?GLgeEIVJ1TCDLcZuGPKmxPhmj35aoFPVqt6t41WrXoNV1aPXfUYklByDdMXc?=
 =?us-ascii?Q?urcD4jTW3y8j/89ZPu4dn+SbtckB972pZ4u1xTfdaPopWRbQUzrXk5Gq3TK/?=
 =?us-ascii?Q?SE1JZN7c5Vn0qW6iDYyH+M/AVz56wvyBGFm1w4NFBOKxTZk4Xkt4geL8pOmG?=
 =?us-ascii?Q?yHqwdigGVuWsSk0GYIiVvxEcazkL5eKuhuPUodcsuxN8nWx+W5xdIvAenK0P?=
 =?us-ascii?Q?dO4VeriOq/sF+dpVf18RVxxDBzPmYcjC20aqfExFY/PCBv2JQe8ciSCNgaja?=
 =?us-ascii?Q?h+3afTeqS9KrCpxxXtsOP6TSyTsajeDI+gkVXd30ryOHqF8QfvYUMYJ9pxbL?=
 =?us-ascii?Q?4zM7ELjuJD0KJLvQYo1gUx08/gFX71bXmZlOTC9aO11oscx5Z/rpCKMl+5nJ?=
 =?us-ascii?Q?DoBaKtatmBUgK5XIFDIcPdguTLzNUXVYMrhzrwIRbo8QSoaVSxdrDiz1SuID?=
 =?us-ascii?Q?y4Fvm5eXXae+23XgNtsoajdzisuyH/aqwZVIn19wCrUd5+P0ZSoVi2HVathm?=
 =?us-ascii?Q?+8V7ycfjGQTKFVGJ/pXnH20WnPoqFZ26dJvnp0WQ/XXkgc++3JBi4gxI8Zba?=
 =?us-ascii?Q?NPQwDO9+goyFGvbQ6IpnYEx9A10o++u+weSAnQMS85Pzb0AwTGlj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eacefb4-204d-42b1-e989-08de77f8b622
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 01:12:02.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBU/dR4ch7jFNqNSXXvSk66sgtr0y11AvHmIWbXzdBLAQOZSf+beuP4cQtmG3Q9GopPujo395pAClUXTR9qEPQ==
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
	TAGGED_FROM(0.00)[bounces-262465-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 39FF11D23BD
X-Rspamd-Action: no action

Use better bitmap API where appropriate. Patches #3,4 may be applied
separately.

v1: https://lore.kernel.org/all/20251223162303.434659-1-yury.norov@gmail.com/
v2:
 - new v2#4;
 - add documentation line (Simon);

Yury Norov (4):
  bitmap: introduce bitmap_weighted_xor()
  ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
  ice: use bitmap_empty() in ice_vf_has_no_qs_ena
  drm/xe: switch xe_pagefault_queue_init() to using bitmap_weighted_or()

 drivers/gpu/drm/xe/xe_pagefault.c           |  3 +--
 drivers/net/ethernet/intel/ice/ice_switch.c |  4 +---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  4 ++--
 include/linux/bitmap.h                      | 15 +++++++++++++++
 lib/bitmap.c                                |  7 +++++++
 5 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.43.0


