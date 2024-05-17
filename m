Return-Path: <netdev+bounces-97008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0328C8AD8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E61C212AE
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19DD13DB83;
	Fri, 17 May 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bq+Keewj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2096.outbound.protection.outlook.com [40.92.91.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12013DBA8;
	Fri, 17 May 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966540; cv=fail; b=rrfmx78kiQPVRBR3vLKm5HvHKlfDOH91y9xxDhlSKPRdJHxj6CpILz+bPhEViVEMTyj0O4KF91CAykIruLjv4sidXzVEjn2cjBBLh0arwRi4a92wVjA2wcnJvaXtJ44byW6Tw9U0WC/qUYhVXd3VWsiVPaBXgFvhiVDyrxb+LVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966540; c=relaxed/simple;
	bh=zfGYCYCTsVjgOGh0USQRYsk//hl5jvLDFo/kHNWT1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nrhsbxX2V+9fJCyDLI9jEfbeC2o3rLpRZBYev8Dc+jcZxVmltRmt6OnR7RF9uX2B8AhyNb5KY61Nm+4F2n+udA69ZhpwnB4/1F+KDQVEzdp2XZDX/LBUUdQuBCDYcAKlJNe/em1nfwg3DVDm2o3G3ZlY/AFSVNkGEELo4JOD5dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bq+Keewj; arc=fail smtp.client-ip=40.92.91.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5KCxvMqplgO+zE2NRIAB9yjwCKNCqKET+pUyXrR6sO62eLKzMbRRYIiT4WuepvVvoArYuxMXl0ypf33XkpoJvuoErmIqhfjHzGyvfzQZ0G2qXIsz/+uAYukP+nRVvV/IjVwQJUMy3GAf5y2w16ABRMNVjYyUGjx8yjcliHna21YN4U4NS3upK+c3tpVfiwzJBs8l7IqdR+3bsg7dxzuNiS9SZSC93naqKHO81eL8e/dyFQi44KQJ9OarEVFuQwCYgh7tueoniF6oAeg8hw6u/0nD+rUFd4n2Iloq0/jy3qvL8D63Xd0YSuJiKogTL9au+9z3nLXYZtloM8Wtr/Nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brKLmGcjtCzC9NlGG9vJLiNdOEeQppFxJprMiKEwQf4=;
 b=g+x5bK3Uo7qyLRR84KGfS/Jl9moJ7ZNZHXrtNjJxkuyyFagw4qcpG+ROnfEeaTqDin6oLLhHDwDqpKhwWQXWJ7nPrAh2u1h+efLqiP1ZqXL1X2pgVah5ipzZT0mzs036N3dFRF/TTVivjoyWsmWGFwMvSiGV9YvuncO16TaiW6xJS47GvEsG72qykyF3YTeJbSvsB722pp766gwtiavZTsqpGYLtUTkM2UgHArjLjusSFDY+KO13TleeHJ9zXV4ixdQta8p85wtEts4rfclDfTPiQaMjLR9imChWOu23uJMq6LHwP3GP1q+8fk4FePHOt0zz+wtD4tH6gtdI5gPADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brKLmGcjtCzC9NlGG9vJLiNdOEeQppFxJprMiKEwQf4=;
 b=bq+KeewjLDpo0OTlRDOBI0bRYvd7GQ40/BtiZnuFp+nnYSHc1q9nOEtp4HfuiaGtmf46XhYznZChbNdIhoG3Pp2F1cdZJxhbPMcVwkt0JFpTJcqyqJnvzn3hU19WYXt27w9lfrSigvbui1k+4z1s6xdNWkwCiEdh3MgaBQiO94/m2w5b2RQTPVKRIXhk+FtEZpejsdJDybJLrU8+XnvbE4oKlJAaq3a2lFSpN0CZOHMOpxjVwVBKIGBTcb7LJ3TGZ2CZEQ8v0VV1+HOlrM6VgMVPS7HiWqgPReSyA7CKDP88rGtCAnTuCkUpuGWHSkgHTZJGE/k2uv50pRIOuo6F7g==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB6195.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 17:22:15 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 17:22:15 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 0/2] tty: rfcomm: refactor rfcomm_get_dev_list() function
Date: Fri, 17 May 2024 19:21:48 +0200
Message-ID:
 <AS8PR02MB7237393A039AC1EFA204831F8BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nejQjQ7PGntaNje7bd61MTfW/wdD94bC]
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240517172150.5476-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b413c75-aca7-466a-aad9-08dc7695e579
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	PS0ryx0K+03RjK2hh+H8InpoCPjSfi1BsuprjpJiltVlocEspQqEzpnzB7eR6r/S24hPW5kr83wuuFu79RPVSNqcSA+YMmZa2uzRpALydXpbVGGvHXLHxeIdJ6F/p0lCUJTm/BYv4+QiXQ/QsNZH6jw0ovArqtNri9ZrTmxidZqCEBTxw7YIxQtTzpgPa4VDH425x7fZZ0ewd6RI02LOhRAGgu5tf0DHuL+va/hlvtduLtBhvmUIhbuyVbDpM6gq8E/4leGsuUP6gPGi4mszsU4uQ28isDo5BN/K1LtimnXVWcst7AyemvwyVZwvvVMIRQN52XcVJBJp0Pwh3x15XclHs5W6HKGg8S4D2oJT1mBWFOsoXa7wX4L9G5eNxUBIVTCdOKqPqNGn4ipEFOlgNgfnKVtSp/by5yDG+nVGiNfpDPK+hkj+uY40IOT4F3FEX/Y2g+EABY5xq5DviQpT1gDvq0GKictCcolKWP6t8gICg+gPGtToqGEaXlW5w0BtUMWiE+WbQ5Jg9j2Uo/feQXUm5+5tEwvPrvu6YIdeUNT/UkrKFdU8pZzBaF9CQNczbbVWHV8hl1vTTcVeZ/7j1JJOjpraUMMSnRsThRZhm6iIzn1oqSQGcuZjvkjbyU6wx9aQ5woikaKfDMURK0R1ph6xuoE5SuJXUHlgcNeYbcns+HsjVBtdBflkov8AsWoZyXu7msSwH1pcOF263D9iVA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXKqt8yIOX2R3/CRFUomQ2eNt50LQezZv1hSuAgR/jIa1YAFQ9V4dtga+7Yd?=
 =?us-ascii?Q?lStZBlWTdfTS3jhbFWVHKyWtTbHsVPxqR7zudTyjQ+flVGjguLjBN29Pd1Qr?=
 =?us-ascii?Q?p4qTlBZTxhU/IKMgL+yMu++lEamlnrG+15XqwS3g9W1J3xIuRYFDicG6rKkn?=
 =?us-ascii?Q?iUR1sdmgj+xk8E6amJW/cvNK9b7uT3CLFJnN8Wpa8W8EN7ME5xLCDJxr9ct3?=
 =?us-ascii?Q?Y1y8EKICEQHXdlfTc0XUmtWasFu19Ax/HTtvwFNwH6CNRYb4tfEIJNCcUJve?=
 =?us-ascii?Q?rgtVtHm6Gg3tfEXiuOcQy9VJYUHKm/mCLuZmtewY0yUaz21gr4cTx4Bf+JNj?=
 =?us-ascii?Q?S7QEM5hqs/wALr8O4nvY8S2g1vD9Mv5DVSh44ryjNmgTTTmNt2u+Put5kur+?=
 =?us-ascii?Q?neFayCH5pihKCzAqwoEp59OaJys1uzIAFUpIa/IvtDt4KnNpXbSV44Jk0LK7?=
 =?us-ascii?Q?p7jW04U0lsf8dFpGHOLq6APMN+a1bS5SKSh7Y53ybHkN+YT/IHf8qehoh+pj?=
 =?us-ascii?Q?lkCueEgTNIcjmGaaTdJDgFVk7McA6g0YoVaThBi2tW4RBS+8cOgQ7LZ5uHYc?=
 =?us-ascii?Q?G2iv2gdF5PVT6/cANh6mP/uKxW6sDuXGJWc4vb9Pta83wb3jKBg60rjHM8ng?=
 =?us-ascii?Q?5FWgiIzuQwhq1KyMPDKJcemuYcUhgC5IG6TYDMm108YU2um/pUd5mgz9LK4R?=
 =?us-ascii?Q?LDs0XwIVY7UDRbkWOlOB21Qz+jopi3sRFIHXZ8twQaAr6pVCgR1/tSDzpNet?=
 =?us-ascii?Q?qphaqTls9q/NnMzl/eti7TDglixgEVKPr2qFsB206PWglU46HxlTEhaQ+glF?=
 =?us-ascii?Q?+Y0YUd6QK5/C+LsFcUJPkC2g6702E206R7aZoA/Z5ajH2ns0YDJ+qBNq3wgl?=
 =?us-ascii?Q?ZgvTw0vk+DHObsgElxjMj2otLhCZ4x8r1o7SUMoLd/mcgR8wBMKERDnajrrZ?=
 =?us-ascii?Q?cEB0Tv+fjV+OXC8hIkOu9NFwLChBCl8DOAUcSI13Pb35gcL1D9N5t8J4F4zU?=
 =?us-ascii?Q?wfiPOyhrLJNUXIhy2dlepbS5mO/BjmPYmjzs9vFjlczYSGwqxqDKfQals5l8?=
 =?us-ascii?Q?7mbOqXpI2HyjDLL8TuI3tdlP/DTxsavb4tT7dx1G0d4aAk7Q6Wpy59Twak1H?=
 =?us-ascii?Q?SRnpsn2+Z8CRNdZL3ExmgNbmgq3o7H5/73F2FcMD6db7mlciHr/vlXU9MXkM?=
 =?us-ascii?Q?JSLZRJrlnEeGslrnhiQGoKhwMUNUpwyoo4MMQmN1vRbsTfbpdgCaI3XD+0cv?=
 =?us-ascii?Q?TRBFGlDL4ekREZmmO+J+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b413c75-aca7-466a-aad9-08dc7695e579
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:22:15.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6195

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
this structure ends in a flexible array:

struct rfcomm_dev_list_req {
	[...]
	struct   rfcomm_dev_info dev_info[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() and copy_to_user() functions.

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

In this case, it is important to note that the logic needs a little
refactoring to ensure that the "dev_num" member is initialized before
the first access to the flex array. Specifically, add the assignment
before the list_for_each_entry() loop.

Also remove the "size" variable as it is no longer needed and refactor
the list_for_each_entry() loop to use di[n] instead of (di + n).

This way, the code is more readable, idiomatic and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Specifically, the first patch is related to the struct_size() helper
and the second patch refactors the list_for_each_entry() loop to use
array indexing instead of pointer arithmetic.

Regards,
Erick

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
---
Changes in v3:
- Add the "Reviewed-by:" tags.
- Split the changes in two commits (Jiri Slaby, Luiz Augusto von Dentz).

Changes in v2:
- Add the __counted_by() attribute (Kees Cook).
- Refactor the list_for_each_entry() loop to use di[n] instead of
  (di + n) (Kees Cook).

Previous versions:
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com/
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com/
---
Erick Archer (2):
  tty: rfcomm: prefer struct_size over open coded arithmetic
  tty: rfcomm: prefer array indexing over pointer arithmetic

 include/net/bluetooth/rfcomm.h |  2 +-
 net/bluetooth/rfcomm/tty.c     | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.25.1


