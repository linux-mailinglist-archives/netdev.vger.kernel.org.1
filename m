Return-Path: <netdev+bounces-81508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A188A243
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2867B44F59
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2515FA66;
	Mon, 25 Mar 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="a9/W6ddg"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2025.outbound.protection.outlook.com [40.92.103.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB52137936
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345774; cv=fail; b=kOEopRffCWZr+2orPvPIKTzBdA9vzCzUtqNLTwMYRknmy0K+U59sX5kl0xD6LGb6Rpkjt9AFXHLZO1HZui6EIIuSYbimI7e2+kH+iXdqcdcUtJlGTDXqHzsuck2l2Y85fP3T2d1poxRk+xJ7aj/J2AXNYo3qCV8xkYEbu+AIfxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345774; c=relaxed/simple;
	bh=QbjnH+DAozCqqAzwvJr9/QHztvg3OqKYRXWbcQ/sMWA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DxZmYvFwNJPGXWS1YMt6IlK24UXb10nnU7QAsTO6jIVlPZaKD4PXg5dDUNziGIzz7aD1XIbSP7ArTb2gmXIIJMnAS41b1vQgMTWmtSl8EDA3cSOBIUKsWyOlOim5i5VcsaBvD82EA2nzxc1YoB3hSZJCHaMSJSEc8wbdcovTnPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=a9/W6ddg; arc=fail smtp.client-ip=40.92.103.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRjILqBWw8nsZuk5TVgnI4C+JOTzoI+xnLWNbIxS5hIBYQb8xLZmwsemuXgq5YO+f3De6iKuDPOXlQwLGH5wNmqvOn2Y70iGwhUtdWrdXnx3iwW2fvHonxIGSv/keJXEU1SK/1yP4NR1X/6hSbKyR72pvLAK8r/+u7V+tGtrpuNT1FmiVs0Sa2AP31myQveTx7C6Ypese2+BpZ/CoK+X1GoiWybwDwIUFMff7o6p8orArKEPiz88IzXwDBz6x/85Gi+iEB90vr38HsRhFTq7poNQzZfp8XFmXbuLCyY5fV5M7Lpbqr6rhajWRuhKVJtLo4onyDinLyxk2kIiytZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDQdw+lMgszPqs61GKLLtSpIuk0lkmz/kdR+j6ImpTQ=;
 b=gV4ryyqJZbaIwHF0Pgx4NZBcW8ueR4CF81YawrnwAuZLR49Rr7MnzfI626ei5p9g1eCIzgpsdzJDjyQa7VzAL9d0d1oasNnEF0snFSwwYXVXAUpB/Xyocx73DmBPUK6l3FDpFXo31Rc0X7PrZDtYmJv8XIAoF975glBhd2yb4qg7yeU8V29+NUApqehwUjDvx9MaPxGKU/vEab0pmEVtKQEm9Mv+8ANXrPihsAvM60JqrFyYns2S5P26+rnBVj38lo6nzDrcesWIHvAbDHdpA5hxfejOhN+Rojta3kqdzmp8vzgyD9rUpy3aFcvMX95Vz6UzbKuye7svjQUBDLw1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDQdw+lMgszPqs61GKLLtSpIuk0lkmz/kdR+j6ImpTQ=;
 b=a9/W6ddgF5TPQSo12Y/gRUS8QYZqSejLZzZZzNC1mGsD0w2O5A4pm6bqQq12JowOhz/bTNWjtnNcQ4vSp/fvS2jJkC5m4tLgXRIBuviYrFnsfEUvZHhc608r/6VoU0r6ZA5KV5nWl7DhpWzLe3RaEp+hR+TD83YUTv7VEaTJeE3ljfxT/qvMoQwLn2nqXWAUXh3aAFTeuwZbU5peZfg2NyEtbBU2kVK9h6mTyhZrOo+Innj9vIdi+IDEH0ursQOrTs8ZjAbKJRm1/qLu3IRq9OrtLulvRlEIVMzr80h6mU7hRVT2gGZ8L0fx4YP9PLWtacLIIKm8wSqOldn8lS1fHg==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN0P287MB0344.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 05:49:28 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:49:27 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v3 0/2] bridge: vlan: fix compressvlans usage
Date: Mon, 25 Mar 2024 13:49:14 +0800
Message-ID:
 <MAZP287MB0503C1F5A47200C144773F6BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [i2KhRcSn7J0tWhhiqNhdc7dpb59T1r1vPeTOTBgYXyBeqBf2Dhg5jhY9mVScwSVF]
X-ClientProxiedBy: TYAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::16) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240325054916.37470-1-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|PN0P287MB0344:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcf7c42-6dce-4624-b7fd-08dc4c8f5541
X-MS-Exchange-SLBlob-MailProps:
	EgT5Wr3QDKwnUYJPhqA/guHYz8JO0CG5VGjgqXl/y2V7ZnvP+arGvF6aAA91iZiCNS5kT8Jm6YwP1uIfx08ZafjNIlnCSEKxyVjPhJb0TRNSn4E/+kM6VI7MLQBGIYHF5vD2LixZLpPIoutj6aGSj5qGt7axDL3xmpAqzSJIBhF1kh7yI8D57hhoGUcrN1+Ti8UZE183mtULyZYUMZXeJ130h0WHqxouc33c+wddhDa5WtUmKRSFhZhMliCDs5tYeqPNpqsVVAy1gJ/7NwcQGEQbgExFVuG4Mu7euvUbikWhqzpLNSvX9l7EYghMFejgT5fQO0o5Pyf586gGomNVa4RohqdLvr9NyXJpfYGzo3FDvMHhl6APccybFiooJnjX18COjZpxRt9qtjH4k5Z/dIczpedaCjF5cb997nkVw6q4QK4EGBK7HkiQrTYtthGXd5zW8ynv7MkCmOcPKe48v//rcbDBgFbtAshx2ksw1bPKdFIxSQmoj6NSrDzgd4U4TJfwMucUFDPapjHy55J+BvPz7RVtKnX/93x51Pa10V5XcQ3MAgzQeNT1VvUEzVYKzeePGy2K6DTyh4ummVtDZIVV+tuWOQ0xTKhNrl+x0WGN6k68PXuIKBpXlWgtPErPV2fIHghHyU7F+78MCQTDN4PYl9j/hY/Dnb6G1Jnv1YVS+3q7eq+z8GVSAJTQBPjxPBEWnKVgu29BaMCVda55s6rA17Chh1XIm78jlsn43So=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EXab/U2ba0aMFwanPYkZId5vRaqhmb+Ms6TkjpzL+YZW4cLlUi70Q4V5zviqoJSX+8K3KHO6eOvMxFuelHetaG3t9uFI3/upnz4NljVPsIHxbv59N6FdNzVxD6eGInyR1ScibrGwuHTRrtJ3NvlNMrn4VOg8CHWEbI60rrGlCWvjMvic2IW69GMWuHO3blSihQoAg8Jr8Byf6sG7+yGP4KtF1T7WcdLzElmtAKYKIN/ntFjsK0iHOmlxy1pl2Jybt6y1Vk9uD6FufodX5wevbnVXcVH8vcOmxUkvSv1nYd+E6NP/OcCZp3reh3phyuaOcFX2YOd0uDFkE+3harJWNfctePKzSysrdDBQBVcRUfnFi8eL4cxSgEQIyDPGGSM+8BwZfNQo8AI/1jUceRFCcalNzfyiGaZ/ipFFz2WRI96Evz+gKp9XsL+X+NdDX+FQHwf7eyoe13Y/xv32YnX9r6D1eg58GQ7n7qBf1NkiVKGrgCQzIOLSJBE/MutGzWgW2gRZtmQMVUxWONmwtn7PfGbgFG4C03R+nh6e2NQACFwlRlyrRgG5Qf6H0NeTJA14mT9oTLdcD94T63sphRVpuwubEkViMFzb8J/n1zeYSQZ8TeUPeH1b4pOLytQageP6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJudXCqzSbuPDbw/aVX7JxOjOYJB9hCnol6EOqoqiVxVM7PWjZo82RMroDMH?=
 =?us-ascii?Q?RAqM5I8FFsC25Mbt5jvZqEuwqCKDU5008+/9+tnJyWFdFEqqTRPPYbSUnGW3?=
 =?us-ascii?Q?JRwebA3TURf0O1nr9guSB0TkYWRlrWsD3/Z6ZuzF4JZ67arF1XFidEa593h5?=
 =?us-ascii?Q?VKu0vxrfQwAWTOdQ+V0iaxwsMjfXayMplVVLcquX4FoTWh+7l878UxtxESNF?=
 =?us-ascii?Q?HI6nWl3sCbcVcKQBbHXSjVJrLxSb9SE5nQqC/jktZB3U3XDQiYUMM9N5xFBW?=
 =?us-ascii?Q?7c3XuVJwGmkq8A/QCTm/EuZdaL8c8YrzGiF7DwFnJJf3fgbI4L0UGjZo1tiY?=
 =?us-ascii?Q?XQVN/VvvSDG+Tr9ag7FniCZKlErsC9b5WQXt6txZaVO4pQ5kR/nxNimJNDBW?=
 =?us-ascii?Q?9oC2nPU7/XdoZ3lCdtscjy3bMiifU9mwtqV3nYVWngIZRcGv5E/JPaB2s98/?=
 =?us-ascii?Q?K0TW3bzkzMSNIMVbON2uWKPUe8yyYF2rARTMrnRxDFRlSd2dPL/v4BOpVPSy?=
 =?us-ascii?Q?8Gg+97DNhmDX1gYtECpJ6oHdngb5hoCpdfI5wWFa/xYpGgovrx4O7m4g70io?=
 =?us-ascii?Q?gWhxXK+bdyCU4x1iMsNMuZoQfYqeB2lEcFLOrOC9tVOs1iCunYiIEuWlDuhL?=
 =?us-ascii?Q?eRwOME+8KWe+Njmr/wfVapLHxFVnkKaPIfNey4cjJlntA7I1wfyu8XjFNWLW?=
 =?us-ascii?Q?RNslQaflQ2UGuM01Hxcl9Pmxs2m7i1p2UEwLVspSEf1rYdrqhGK0cXXqZiMc?=
 =?us-ascii?Q?YVhJURZExLF+pdppNuGKpJb/d0T8TRogwwjhYwPbWQ5KbmoctxlTwjnCyPjP?=
 =?us-ascii?Q?1qOpjDwUz6ZDJq+kGs6j1mZJrncHN0DjtfNPn+2lVDx2aePuCpzDniHfDzya?=
 =?us-ascii?Q?BwRZOVZfFPiIShvY7NUME3kGDXA3xeOKcfhf+ugc1pG+iJmUh1zLxqK6AUU2?=
 =?us-ascii?Q?A4orpXlHx8nv50xrqSjLdehZ9ecxZChxwkdYqsxcMNSxxlpRlpmogyXW+ueo?=
 =?us-ascii?Q?DE+pxuRbGQdvtYp6/aDopVc+q2ouGEg1T8AnCuUzFmYszpMLRFf/8DkthxTx?=
 =?us-ascii?Q?IkbutvZxUBn7Jp72m9PEQdz0AYcc4vkPMwVzhZ/udVfEf38MhBx0C/f+EDkK?=
 =?us-ascii?Q?tyz/BaXrlNjFy59LN4u70CgIt7MzZ8gRh7MgbAEDLEQQqYoMCNo7uIm9eskU?=
 =?us-ascii?Q?WPxJDzyYXytymLTj0Al6dn4AN7yDF3rjdBBes3ZfeNodlyxeRa/8RP+eN63L?=
 =?us-ascii?Q?395kImnodCqFPjqcX35/iDTygazlZKuGQekDqfGa4MzvVKVMl0lOvlKqhwz0?=
 =?us-ascii?Q?Xgc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf7c42-6dce-4624-b7fd-08dc4c8f5541
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:49:27.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0344

Hi maintainers,

In these two patches, I fixed `compressvlans` usage description.
The usage said `-c` implied `-comressvlans`, but actually implied
`-color`.

In man page, `-compressvlans` was missing, and I added back with some
description.

Thanks,
Date

v3: changed the man page description in patch 02
v2: split the patch into two separate patches
    changed the option in patch 01
	changed the man page description in patch 02

Date Huang (2):
  bridge: vlan: fix compressvlans usage
  bridge: vlan: add compressvlans manpage

 bridge/bridge.c   | 2 +-
 man/man8/bridge.8 | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.34.1


