Return-Path: <netdev+bounces-186972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE9AA461D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E62B1BC6CD7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3C21B9F0;
	Wed, 30 Apr 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dlnNr65n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03D21D3F9
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003503; cv=fail; b=Q5Wf/cKRiDLA/iHpTtrjKaVU8ujm/kaF7BcxbYtLAtzd9ep70Xoxd+Gsf/mgYFlSZNumbCkiizpFTEUND/LvFgIMHiJ85nbGm8WhZIeqoJN4lRiX9LZfurh4p1ViQbjup9AgNby+MkYa+T5Jch3RKUlkwEqZgG9WAzwpkFcyyeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003503; c=relaxed/simple;
	bh=6iW92X6KvXqufz9yXv6O+8bD69vOIoGlYwOzfn8u+VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAv8wmAh9JfJ9LIr6Mh+R1XTMrlha1tbn2J4g6dHBCyHSQJaSxAeaCLtB+XIwiPV/Rj51MJ8yrGorkzibd1zOyYRUD7jN8+s2F0nvtiOkeVBnZYJkNRV++FEjHto8CzUMjpx3kyhG+PGZm/+v233NxVe0KjtOgUUubb9yT3UuwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dlnNr65n; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/OR1d6Mz7vvOOmRFrJtVcVGUxj4ktoUY3DWhTDGU5McLK2gmXG/I/wh+GdQGOExgC37FwIeM9w6yUBS7IOt42xE4YNY3QY3mYUbewORWZq8KZVbc9MbFobbPSqN3hI8lwliBfpTUXz1qbXKbh3L3aVVMEn0JfaC/6wVDFxUvRCiYKim0jVOY269ekzfmGin+PI/senQFjAn7QCAS7WPb932SJnI/pij9jLpDwRg3XCxk7l2wNvAdLxSGkyYKeaq4O27HgxduVrxkqCLbM+MzoTdv2W71XgkGSvnDJW6EpbFz6lohOJ39nhAwqm0mBPkBq1uHTByNA5fTuT0mSP3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66jfsz8bhDO/Wrs4hDwIzEFxl7DilG29NwEXeRKEBZA=;
 b=hdZMVBwKesd27lIDlZ8NfwJQaQUPE7EIS1I2vG9zwVBZT03ZcBDWpJeJPLIkPmHazo2NAAh0CJmrJyFDJjmO82+UBPFY5z361yb4p+Q3A7QklpjchYDKBhoj4CL+MXFuunqGErHBIZrplrt+oE8v3nrPWzUPSSHy2pJYWomc9VE1HjcA06WgX375eBWn0XCvcb58ldA9TFJuoZzUjr93bFOJ5n0w+NfWbnNu03kBzUSvzB9Va8RUhC29PFzCTjy6EjkSDBVBJdhJa80hhqgfsfZm+F77G9mHpMHeTQ3TjKRcRfFbSWn2YlBFmNXdg06argldYupWaUR8hT5TWfWIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66jfsz8bhDO/Wrs4hDwIzEFxl7DilG29NwEXeRKEBZA=;
 b=dlnNr65n2QtWuWW7He/MEsrZ5ZnpObsn0ZiNied3h4zVrea4rWprAcE5qumkX5hheBIUPILvqqLGBT7t+vKG3iDpFVeEXw7xPvUry/amWjVT09tL7NPRNiD3sSHu2K2u4VQgqMeEKTAnRVxZqMzg4lu7PDe7F2KWjWbfpU73BPl/Y/p+Odkte5nAL3LkxPvUpIEP+7gKCb2ZnsDAvs/U5p89P+GahsgIY8N4wb3JfQk5R5+5TA83zVCbhP2T69bILG4ptFhiQxk4zBWRr0stkAHf9u7sEBr6zw4/LrE4nxmgZlBvSTOWb/Q0ZqYKrRKpdvK3UKCWbAvB1XEPl++6eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:58:18 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:18 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	brauner@kernel.org
Subject: [PATCH v28 05/20] nvme-tcp: Add DDP offload control path
Date: Wed, 30 Apr 2025 08:57:26 +0000
Message-Id: <20250430085741.5108-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8afc55-cd78-4940-dd06-08dd87c52690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EEFOJfL6NgH5jlH8WgBIliUSOiGVX1mEgoA4oXESLaUytzvFw8lGPwt508Yf?=
 =?us-ascii?Q?GiUoh2vcYkCzbxaewtMan7qHGUvZ7k5GXg3/AYrZxNHl41NRip90w6YjyEeY?=
 =?us-ascii?Q?8Xfg1+HQyiDC3v2c+rLDzQ2wbgw6869jjFBraD8we7dJzWBkC2GJM0VoJfx7?=
 =?us-ascii?Q?2HbSA2FmfZy2+MLJQO/9lpR4IyRACY+JiMfmrmuPuvEMfs/xe9pQClZMQ4lr?=
 =?us-ascii?Q?Wo4IiR1F8JzDx1SRz8+aiW0t7DR2tbLUQHWjPwkpH2NXdU9noPOmv9kPABdl?=
 =?us-ascii?Q?EPn2uYLqta82h8uc73hl0BalJhfVGZayKqA/85PDJtyI8F3ma8D/wRpnK44c?=
 =?us-ascii?Q?drIe4aby3HSB8rEWPc6BOJBbvvTWyE2vnB+xnSusNB463chPdT4XmV8QuGZM?=
 =?us-ascii?Q?o1fxFB6KTZqF9Myx3lb8/EUXLuSkH7Df/XMGgDfcEnuQRRAHE7SxNJWUatED?=
 =?us-ascii?Q?piaLfcNngLpLLAbStlvWq8nnCAmo+ZoPXCwoS7bz6Kii89hpC7W594nMPwOU?=
 =?us-ascii?Q?Zxj6u8KnGnZb7eWYPheGWlX4ETgZseaiE+qVSHV25zQElERTWAcPZZKlPH1W?=
 =?us-ascii?Q?+Ic2WcAB8oEDH7J25bNZnZ4uQ6s/4ZFq2KrulRbNy7J9BgqOXj1OcEKT3uwY?=
 =?us-ascii?Q?3mvFGC/rfs6qjPz6V8PjnED02HofNVSeEWpqKKMBgdCw2RA9Op4G66R1X8G9?=
 =?us-ascii?Q?dPzllLiIfPJq9SBhGq+D8ZID8dNX35zE7e12gi+VXVKRhFZW7kYH3qIexGRz?=
 =?us-ascii?Q?XtyDJ61qnGbiZ2FjH2p2W2HkWZ3l2nwvLhwJyf8Q9wHx9N5by74iIFLLKC1W?=
 =?us-ascii?Q?y/pOndxEcq2pImyE/NK21NZQh27D3gZ200OeAf5jJSEGuZe48CwxvlMSbtRI?=
 =?us-ascii?Q?u2k68OZ4oRpISmOqYElVWaCSX3ZWqG27ZS4RYsrWYEDKlcrjH+TClaV6vQ/q?=
 =?us-ascii?Q?ynko6RgjmAk2TqbLZAeCMlSYIaFvmw+/6nSyaQ0SsfJ7nsjyPQl61J1kLSIV?=
 =?us-ascii?Q?Y4epF7CW37BVp9BXMUdkU7tZJhZna2NHytqattqRAlWoKhkZTVdnaOc3FeZU?=
 =?us-ascii?Q?Kotgn3rJvudMlmqeVcfH9OVKL8rkfCRWXjz0rJ0tq4ugp+EVK2ilLq7sP0jr?=
 =?us-ascii?Q?LtVDKI2PSjiVqR1Y+VWWTEoSAkvIopRC24rPYR8YetVPEMmpjX3zlyk5AavT?=
 =?us-ascii?Q?To0oZ850qashhRn/R560I007JcHBIhQdoxBO6aVdALiDQrByl29ubDtaX9Pn?=
 =?us-ascii?Q?S2ROJZ2nogarMQiEnV4tACB+Bf7Tr4lNSxEaWSYggijygfll+ozq416Q5Kms?=
 =?us-ascii?Q?VL7cxtxi08aNIId2W8hiGjvUBWInsw7rhywQDeNztfpeApYgsu6YOlkDocao?=
 =?us-ascii?Q?c6CZ9uqwhZOtPeBHjaBza244UR9uI11K19XXE70oqiOtsvJ7pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUeyqD+3/9X4ssPw+zBMywXGZieklHqQZCux51EZqxlmrJtQRew9YXPS6sWc?=
 =?us-ascii?Q?U1Wmc+1oSPiErb7k+afwFuaBc2KO7w3N7RUeuj2RzbmW/s+J7hGn+UPHEvTx?=
 =?us-ascii?Q?7lyAU/LkXyxHDtejHdDSMxpEse9ZLQ00hKkFMNScaYaQArxeL4cmr1O3zjku?=
 =?us-ascii?Q?cWe2qODKY8RMxG6K7IreQtJTw56cpCP6BUykmSN/77DzA1zaZ0cGbBBOisHO?=
 =?us-ascii?Q?vTyn5NiqUelmZIwxPWZaK5PwIef2P4y9wQKhB+044djIILHB0TQlFkpTPiy3?=
 =?us-ascii?Q?ieQym/1YiWM4vdVwnVXrD4odHpNqr5KJ6Y4xIwvFJpqNWu3QAP/UlauExSBc?=
 =?us-ascii?Q?cwEcOm51akq2Th5I68wnsZja4vv+2pcZWaHJXrczYWQVu3qBiP+uKNDUwNxU?=
 =?us-ascii?Q?Mww1CETJ8wh5cWWRZFnnHVDdL4WvU3ocL9H9fmMuyAeTXMDLYhCtm6Uo2A+X?=
 =?us-ascii?Q?NYccWiUm6jr4TF/IAA2swcGc3O2MxTqHd4oY/K8Lx5plbOB9ECdG2lvo7gl5?=
 =?us-ascii?Q?C2J6Fw/Lczb0AX+ke+k0zaz/dP1uDAV94Xe4mNjogvZu/x/V6CNO5TD5LDYO?=
 =?us-ascii?Q?bXI2C1SZrNT/u9cht3EsqE0kqiMnNq8og9yrVwkk+XVEiv0f9zOzMRM49n4Q?=
 =?us-ascii?Q?8Wu3JRloTWlLCvLNt3i5PyAq43Tka4sU8K22o92eqL3p7HvisviRjebwnwGJ?=
 =?us-ascii?Q?068zVgTAmba+Z5bM2ym7SlkVzMXE1nqXoAlPWQJVwMDOsIyhXQM028G+E666?=
 =?us-ascii?Q?jp9VDG8d09EL7WjNOsMc2OReq06Ni1pn6vlFZ68Gxj3RjtC0mpDznou+0On5?=
 =?us-ascii?Q?2NNMLdyzVyhBFQD6wn1kQJPlpsJg4t/g+RrxKX5iTIPFGz1TZNiOGdDc00ej?=
 =?us-ascii?Q?ObEfE8B4cMZg+FJPNxJMIJdBkNZlt7LvDsN8LiDv2pjntb578nggNrG7iJjZ?=
 =?us-ascii?Q?dDzL2fG8Vaa+nNnokkbW3yVZGhxdWEttpcU5Ogv0R5QeA46jbDxGubVSET95?=
 =?us-ascii?Q?VuK+wpQrWGR/Hum/64DQk8DTsh+fDE5smW/rqpyngRjnbBwW5HkO8Dl083JT?=
 =?us-ascii?Q?HXK0g7qPPykJ6qmFkvRnVuYrULzzwMwxHWYUFYxtjmIZSQcEIQPxRdAwa/G7?=
 =?us-ascii?Q?GsRI0P84V69yYz2mAKDKP/iJQHXYIb62z0Uo+fK28JQJaDM9bfO8GyiQZTJn?=
 =?us-ascii?Q?W7Gk2VDklIpnyX424gHgQ+3s6RT69QatIjrs1VO/NpXwedwyVwmt4A+WlJCR?=
 =?us-ascii?Q?GQkpCgEFnFsEYwN3AcQfUyAom+s3eSzl/IcfkxcyUVFBhpUHg1ZSv1PozOpn?=
 =?us-ascii?Q?+rSK35vxBLNx6lthHzwHt15rK6MnTdRUot5x7ud0CzBM7s1iwC5TvycWdCM4?=
 =?us-ascii?Q?Br3Kq2q132UFjc1unv2E9CEjQWFw1bzw2Nnxq8flfvRCimj74WdtjMJFT+AT?=
 =?us-ascii?Q?NH1+pw6q5+zkN2P0GYtLTn93WB32NCyJVXdxILAiIMuJ0K99qalbUanC+Z9I?=
 =?us-ascii?Q?iQENeuAGOstlXAiOarkJ7A0jkE1erZUflLL2Obx/vP3vwI8MSAGwsCe0mBgA?=
 =?us-ascii?Q?M2G2/16erKNx1iZ8UUfIYAJxIva/yVgK3Y/gcVae?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8afc55-cd78-4940-dd06-08dd87c52690
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:18.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKiypTybzThr3tBESQspnqucNYHjwMSvvYiA31qNzSynOmhYUM2v09VMiDIvvx7/L7LH+3cHrXhuqxm7rpqFew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 269 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 72d260201d8c..fc9debd64900 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -55,6 +59,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -129,6 +143,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_OFF_DDP	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -156,6 +171,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -197,6 +224,14 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	netdevice_tracker	netdev_ddp_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -335,6 +370,178 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (nvme_tcp_tls_configured(&ctrl->ctrl) && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     &queue->ctrl->netdev_ddp_tracker,
+			     GFP_KERNEL,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
+		       &queue->ctrl->netdev_ddp_tracker,
+		       queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -817,6 +1024,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1944,6 +2154,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1965,6 +2177,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1994,17 +2220,35 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	} else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2260,7 +2504,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2275,7 +2519,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2618,7 +2862,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


