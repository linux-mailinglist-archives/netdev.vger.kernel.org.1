Return-Path: <netdev+bounces-215047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDBB2CE4F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D16A7BCC05
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF0343D7A;
	Tue, 19 Aug 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ol3lVmlK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2090.outbound.protection.outlook.com [40.107.94.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013703431FC;
	Tue, 19 Aug 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636732; cv=fail; b=nR7FXx8Vp9JUrKc0lt4IsbC0yU9GDhQ+bONBG7KjWSwVYstVHCMA8rnb3dmr9MyNxKNmKBaG1NcmRPQX+OzoH9YEKSVRpvFbRXaDBi2RqMsFOHfW7K+IjQfHI4GwUPQ46QKdhaSvib9oZLBG2GZwZODk2MaoIvrdGU3iBVxUFvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636732; c=relaxed/simple;
	bh=PxJpdCrByYfFMp9QyH5BMpUy0pqPeuqJbZJniqm4330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XF3OkcUFXTlRrkMkH0dthIkVW6sYYaj2zWHl8JZ71deV3Mv5Y1UP13MNO686FSkZlfzgdAATFcVfNPI6bcaYAK4ondNG2XKhhWU1bM6uCfolm8OMZjlS7QKwKY8NlAOAL0CTiZ8SaAON8PauMfM9LuC6LRtws0zMSx9uOnoeCT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ol3lVmlK; arc=fail smtp.client-ip=40.107.94.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrFLaWwP/I8q+c8U9FkJrWaw6xNg+TrTz3l9Tg/W2akYZfAySFFxx/7ZNZzuDwDZNU2857dtHpnKFMD3mF+aXcLF+8xayjdSGzcBNvj84003uaNOgk7oQ3hvDzD6TpTOj/aaN+PrbpIY9ILzRjWRpjYSJLy5SYeZHInVWTaWSuNR+hM3BcW+473MHDvoza8ZXqduTr8s+vooTnErHOHrKnVqJGX/7Bf47rH4Tn3newln7mW/amG+LZX/PIfE5xWvS9sosEQEXFFmhfn7Y5I1cTE9r/2t+XgxHdIqjCcKFHAk0dpHgdi5w3pep9se2cDUqJPxEolIvnudinBmxWpKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es6F0b8nppw+OV8ID2NhFLh6x3mSLmeQIzZRkH6rJck=;
 b=jgjz7NBPa3eM+oADjSTe4pQe378Qxxmbl4HkMeY/gqseZ3S23P3h5jHrzczQTfLg7W7Xdbta3oaMAScVluRQd9rBQEqwdRIpVQo7GvXElcZ0v9HzlcljO1J380dHBI17fXo1TfICDroP1nygc0EtNGn2vrEAHMe6CvmHptOI9NrdTH/fGAjQ9eR8eNlgdctSEfrBqhi2dMInTWt8x5L5rIT0FaLtkWUmXXE/bTxC/Y8uugmZU/i2OCWPa1XQfUefPOUOfkciJYD5JSwSjC2p6EayUGUzRMRHcGJObsAyEH5bLyyrW7D7XcJzmH/ZOJx9qvx4Nn41A8J+oiihK03t5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es6F0b8nppw+OV8ID2NhFLh6x3mSLmeQIzZRkH6rJck=;
 b=ol3lVmlKnodY2rteJeTtCDiswZCfuDkjMwT6Q2oi2MKl5ophV6Z72UvJSM2zK5BCwhc+a/ahiYPmFUESS977TcK4cy6+17g4C9iPtUQB4xtVYSOfuh+RnrKpr2lRryeiiHSp2EGqVPWwGwcnn27oxb7LY9CD4TxaZL7T1htmy5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB7051.prod.exchangelabs.com (2603:10b6:610:10c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 20:52:08 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:52:08 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 19 Aug 2025 16:51:56 -0400
Message-ID: <20250819205159.347561-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
References: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:930:8b::17) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: bc77dc44-3711-483e-2ffc-08dddf6242fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhkM4a++Gyin/e8YNFxe0dZ7ud958tT1V1vtrNf4H40WlCjvyScoq0yR9hpl?=
 =?us-ascii?Q?hx76FGr7FyyXzcmy1IVU+YJYVCM4Dl4ssI6UtS3T+e84pSresvc4cpm15BMZ?=
 =?us-ascii?Q?YJ8CqDiFp1jXtdhnWb2+FqGWkLbykbQWfuPVvI/Kk4iw+L2m3e0M2jGRA/lJ?=
 =?us-ascii?Q?H8Y7nR6+KqKClux4RPv9T2G9kNoG7TkYmcv+dLdKer8k4VT5IdRoE9cczxSg?=
 =?us-ascii?Q?JUrs/cT/tTswLkOBh/B/CYUp1tJmjVMYQUfSG/5S5HG0yfnBEoU1DXpuZ3bM?=
 =?us-ascii?Q?MHoYh1UHcH5wohEznivp/xmzSXQUcbwsarpp9gm2rjQOCDqBzJJ0ny6YcbL5?=
 =?us-ascii?Q?KErXTtDgiA95md9VneenkbdfvGH+h0Hq57WpWNkYUkfqJCJNwyEuqXqJeeGc?=
 =?us-ascii?Q?0catAoqBda3FF0wa0daZYEE6HgduityczyfomuxC7/LyjVakPFBGgkJVxHHc?=
 =?us-ascii?Q?f8E0tGo7zw858e0YI1EHcoDOHzxuOGOC4zLmeUB38lT/4y67REmlIa5jJY3i?=
 =?us-ascii?Q?d0nRoB1SD5YcSNVk+mIpZawFlkXNC0M2aG4Q7Z8o9P8pq1wPtHLOe3RjKfMG?=
 =?us-ascii?Q?Q7s2/jybkVhrc+Yy7SacpebfeR8AwSJM/GJtLx/BXDGrSGhjM9FSDsXmC/Sp?=
 =?us-ascii?Q?bEn0i1DcKB2+pZG2scIzXmdUbqVhZOZN1lx+koowLFPy3gzIfd4aTgvQKHFD?=
 =?us-ascii?Q?XwM3M0f4YE83ZHrCS7Kl1Zq8K0pR+P4SEiTEcG96UmHf58wFfg3rZaMWynsx?=
 =?us-ascii?Q?xTDddm39DVd4vHhWLmS9WVL+LQv2k0ZDKpDuA0GKLbBYFVlEIzxrETRQKKy+?=
 =?us-ascii?Q?UdCWVij+0AkkWmhQfNi8TXu5cokSsZsbbN9XZvIjbv1KnoA8PrL0qRnWKhOX?=
 =?us-ascii?Q?aSgtaVLUN32oLXrv2w/6dEwJS8P4s8gYSjqwP1VyW5Wz2KXNudLtaMfaaORj?=
 =?us-ascii?Q?RmdRAZGoB8mjOjw6yto40iTSGexLnCkshdTI9hK9Q6bMNZBaKV0pmYvmHpmt?=
 =?us-ascii?Q?e7YKKQ1Sl/xW68V2VgGsVPxZT5eia5xY5BDWnpqws9Q/1x9clc30gmm5zkDX?=
 =?us-ascii?Q?BI7iLRqfDBpolyGvpbdk690KHzCqoq7JdiAQzyxHuY8WVDN2/yAuEiRYxH1h?=
 =?us-ascii?Q?Li6WH6SkfegMDPSHhLbpdORegwlzXEbFK0hmXYv3j2zxyOsikezAYVOPL9Pu?=
 =?us-ascii?Q?vzTW7XKPRuKpcX/FBzcLsDZFfLwLtYjTAbXJuP6dgBv5MhDK6avv/MFzIlMQ?=
 =?us-ascii?Q?wX8/SyUCKIeaZ3dVOWR2wV+YWHJqYyG0eGlqitvRietLF6y7NfkJ4Sg3z35D?=
 =?us-ascii?Q?BCIpeL52cs/JuhrK96sAdFldTQEy4SztFCQ2WAlz3v48y2/IiTVX1ZWHq+5J?=
 =?us-ascii?Q?iqbhd6kekke1hNJyJY9g/azswxo+XlUMoqzyLQ6w+TCCsQL3d9su99A7RuvF?=
 =?us-ascii?Q?dXz5FXG1fmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kEzWhQB9Bx/ovMZdtA3vfMr7NGY9WSQyhaXH1RnvFYp7cwVX30UPNgvbBPcI?=
 =?us-ascii?Q?UdiWeq60Zlt4xFk0IHmNgiWVQ7B/iSVYkGPuYZhcJwFapVKCsCAcXLWTs+/D?=
 =?us-ascii?Q?WGxRcO/cTcN9enzdYaBU1b2WySYChmdXYJ+obtxD/TdXu9tmzIYkmuqIGTtQ?=
 =?us-ascii?Q?EH5cpqiZMdRCATdM6DhvsAseNq/EJ+xqSnhXb5yM4nB3Amzqr4Q4RB9+7k4F?=
 =?us-ascii?Q?Sz+rpNYAQBOBDUyqKyzqHMDPBtp1ISNLyZBU8gFv12SrSnzcw3ayrVimNLJK?=
 =?us-ascii?Q?D0Cm2JSTmOn3vzQNyYIyVIxgeU86axlnGnb6VlO+swnAABy9cCeuPIiIeRW4?=
 =?us-ascii?Q?vVL6Fn3ifishya9eHmnKrNl1YhcG4N4/kGUhvSKphaR1urPaH/hkg9Mv1q7E?=
 =?us-ascii?Q?8RpxFCvPCkz/ygH4oVpagkBdUBLkvp8zKT+vzWkkVV13PZlLYjq5RJE7Hv78?=
 =?us-ascii?Q?Jwo1p06+ZR3Gym4GbCXnl1WlPUWs6q+tVTjs0mrfyRkOvGIoTC5p1mk/by8y?=
 =?us-ascii?Q?ke/wOA+wMhOHJPoRU8DI4zhVzyEos8QiOz0gPQNBzkZiz3NTVBGVYhqi8YXk?=
 =?us-ascii?Q?xF4fpm7jKtH2YgdvIunaCFwv3UKw/dMejoatUlX4hrdpDKOfTtDVdzYRR2px?=
 =?us-ascii?Q?etBYtP3uuKC6NeqkL7B8L2KDXCFBC7NYUHOdBrzrOGtXUqp68Fj7g22fQ5zY?=
 =?us-ascii?Q?JqsmK+bTy3ATLGkc5P4E0LbL23OycUF7HGylzqyhTh+/m1qIUZJuTQs8M/2v?=
 =?us-ascii?Q?oyUSsblyTOCxgSbQ13U2bgYHjg/UoJ7bASGGZy+S6eiHWAaHJGDAInWYPutR?=
 =?us-ascii?Q?gpos1JnAm3KqWhu0Mvw9bFL4Ar67Q5zk1T53AJc8Q7MdDJt/g73J6BDtrZ2z?=
 =?us-ascii?Q?NcbqBC99e+OPcDIaJpD51zCbE2+KwlZnMIxLqa3n+/XDQvKKWumvatq1ajdM?=
 =?us-ascii?Q?7YAJRbBIC2unqqXZsIezlx1zt75nblNPoSjW4CwUgDD2SjJWEMEG1cLqCoVX?=
 =?us-ascii?Q?oCHGZ2L1W0H7qfkQDG1gEC/dYSpaVbJiBoUi3LDnOKzBjOMro3cx5iuNWixb?=
 =?us-ascii?Q?xhsxGxgE0MdOPveHhrgLLbMw8+8GBNUPqM1KAULFFi5FjCDpuyjocAd8TBx/?=
 =?us-ascii?Q?48cOTCUV8hdcj//cT0rAzkMCsrHkSZvtgZHr2nG4TYJRXV5F6DWVvHunNgkK?=
 =?us-ascii?Q?sjRQrq6GdqA8dWUQSyfcls+yaWCCg/anEgMdZ1NDxSHfnJOgZ1PHMvIuZzmu?=
 =?us-ascii?Q?jCzEcUjVoQn9MW4ei603B4Dj6PaYRcpA9NNxesrA3I93iyC+3ULeVurasZFd?=
 =?us-ascii?Q?Dyzb3X8HnYBW707dlOVvR0cikXO5gWbUOVlIwLvkC46cZ18uYChn4v8rvLkH?=
 =?us-ascii?Q?4mEhG8eGsIrXKQBJo1t4ZV+EelPjOpvQtHcCWEnbuShh4AC8OHnlFRwEH2T9?=
 =?us-ascii?Q?auPW3ayJa53Q+rPiYUePH/EPZ9HKENmKKsC5ucs0qxhfWXkPFFoCbqtNJciL?=
 =?us-ascii?Q?hME58VCIjWrkItsmR5bZq/Rf07bw53vdpYYB5lftOsvBzRH76o9GFFQ+7Cct?=
 =?us-ascii?Q?+e9MblkWrE6/NxFJW0hPYmRFUWSP9JY9EC+MD6cmp1rr3Vt3ZQlvfLfez2N4?=
 =?us-ascii?Q?kD+2tEJF6/Zo56v/tjK6sWbb6UK4f5I+VK9H+iNUJKLC9kvcMzZPoMGkfhIU?=
 =?us-ascii?Q?ZSR9p4xIoM9nvUUMFbVl2H1DF9c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc77dc44-3711-483e-2ffc-08dddf6242fb
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:52:08.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLkNEcgg0td3FVJb5Iky8JH5Xfs7HBFUvvs7L97tdtUr/HL3PT22A4gG/K/kn2xxcbXflfYel9FiLebI7pFflxLHcI54YsCjxdzQJyQUiN5ilXx/l/D8pcGb+Fs5iizd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7051

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox buffer
management. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted  as a PCC message.  The driver
is also responsible for allocating a struct sk_buff that
is then passed to the mailbox and used to record the
data in the shared buffer. It maintains a list of both
outging and incoming sk_buffs to match the data buffers

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

with the original sk_buffs. This requires a netdevice
specific spinlock.  Optimizing this would require a
change to the mailbox API.

Bringing the interface up and down creates and frees
the channel between the network driver and the mailbox
driver. Freeig the channel also frees any packets that
are cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 379 ++++++++++++++++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dcce7a5894b..984907a41e2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14660,6 +14660,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..7f5d0245b73b
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/skbuff.h>
+#include <linux/hrtimer.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#include "../../mailbox/mailbox.h"
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	struct sk_buff_head packets;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to queue that holds a copy of the
+	 * sk_buffs that are also in the ring buffers of the mailbox.
+	 */
+	spinlock_t lock;
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev =	container_of(c, struct mctp_pcc_ndev, inbox.client);
+	box = &mctp_pcc_ndev->inbox;
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		return NULL;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		return NULL;
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_head(&box->packets, skb);
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	return skb->data;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcc_header pcc_header;
+	struct sk_buff *skb = NULL;
+	struct mctp_skb_cb *cb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, skb) {
+		if (skb->data != buffer)
+			continue;
+		skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
+		break;
+	}
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	if (skb) {
+		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+		skb_reset_mac_header(skb);
+		skb_pull(skb, sizeof(pcc_header));
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+	}
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *box;
+	struct sk_buff *skb = NULL;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	box = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&mctp_pcc_ndev->lock);
+	skb_queue_walk(&box->packets, skb) {
+		if (skb->data == mssg) {
+			skb_unlink(skb, &box->packets);
+			break;
+		}
+	}
+	spin_unlock(&mctp_pcc_ndev->lock);
+
+	if (skb)
+		dev_consume_skb_any(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_header *pcc_header;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	spin_lock(&mpnd->lock);
+	skb_queue_head(&mpnd->outbox.packets, skb);
+	spin_unlock(&mpnd->lock);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		skb_unlink(skb, &mpnd->outbox.packets);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static void drain_packets(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(list)) {
+		skb = skb_dequeue(list);
+		dev_consume_skb_any(skb);
+	}
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+	int mctp_pcc_mtu;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+
+	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
+	mctp_pcc_ndev->outbox.chan->manage_writes = true;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct pcc_header);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev =
+	    netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox =
+	    &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *inbox =
+	    &mctp_pcc_ndev->inbox;
+
+	pcc_mbox_free_channel(outbox->chan);
+	pcc_mbox_free_channel(inbox->chan);
+
+	spin_lock(&mctp_pcc_ndev->lock);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	drain_packets(&mctp_pcc_ndev->inbox.packets);
+	spin_unlock(&mctp_pcc_ndev->lock);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	box->index = index;
+	skb_queue_head_init(&box->packets);
+	box->client.dev = dev;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	/* inbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


