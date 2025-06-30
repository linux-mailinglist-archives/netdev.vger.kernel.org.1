Return-Path: <netdev+bounces-202451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCEAEE023
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495233A821F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76228B3E8;
	Mon, 30 Jun 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="twHMHLdX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263C1E5B7E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292480; cv=fail; b=Btcm8CMlDeMJAB+OTBepeUCPGJfpqj8S92pZhjZRCf5TkcV+zdNoHMHrpAthj8HET63zDbhFCKl5faOfC+Ho+8BSdjjCfFvWc8B+Asp2hqiz8kQI+aBJ/wprUoNJnNMpQmaWLH6oQ+ir5t4yR1LidPy0Hu5ZyOmCOYdCcilllFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292480; c=relaxed/simple;
	bh=EPyMmK/2T0bUjXd4IyQyF4HWsP1x9xwI9kfqvNFGhxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQr01WFtUkiRgN6aeC1cjFxX1hqHZIFGp005kAoOP5kJRgWk5RmDPqru/PTQpzrDBMfG7fe9Ad/GmWhcxjxjGs7Ymr4HEqUUhTcAjYt02qtgVQFNQ66mzuQS7bHkScz/9wcimJ5xQ/evDUG+ApS0/L1Ed/xlGmXtAUTqswNvQpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=twHMHLdX; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHnXcEPHM4+t2LuIR5l/zgnSWGbQ8ZzwYtFtzjkdLOPLX++KIVvLzj9/jlyVcfarzC18PixrbbVYgb4XFd7JU90Pa8m8PAzhTj2oUog6hFOo70W036j7YapfOl6vOLlCQCH/YXhrLnADNFIeslJ96lf4UPFxP9K1VgLduAPwIzOIeWRBZZRtWlfjfHRrm4/ZsNhW0gdHKYRgrYUGR4FfrQCX1XJx/g++rJidttNE6o1Wpt8pQN0vWNSHDKcy+h+TxmFTHJV4b4lNquDESPdGH+3+sXIzPRyxJq7/c2DvS9E06HOdoDQl7N58SkFvRCRKoVjW6o4gmfx6ej9uoEGadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzIxcQTsAlmCGgWTKCFz0OqQpY+O/jgg3/skE5+NzP0=;
 b=jtjBhNcdFU7ANeY6y+3x3ckRiUoZeoRcx5Exf9xyvAbm1W+2iBotU7x3FhCk5XhEPQaWee7rGbpGm28RO5hCojXu4Pzu1/QVljeFpA2JG+pSib2MvEYqQD9MrlIl1SzupWeG1goD5k7eX2p5uViL2WK/t+/eZ32IpdyxU8kKAyxEAdLsTAAcIMLqaZNkYqhMP6ntEWd45ZDZLniTBD3r+sx8HqomzsrBTKqRdS3FbEZMDXoZWQqwfWpNSyhO8MeQ3RAqP8w2Fusetvw9dBm0gvDUsRxCB5cqA4+Re7D451E4KP5n3jFs5mOEH2otR2uj0Hi+yYNJwv/4Bc3IKl+9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzIxcQTsAlmCGgWTKCFz0OqQpY+O/jgg3/skE5+NzP0=;
 b=twHMHLdX/iyTcffyYViFk0VNfYiXHqxp92+5mnRY1JrBTnnNAtNl9xqQkezQa5SPyB5ZsGCOB2+B7Dj5Y3dFfxcdBqz7zefLz/7SkmrE/56HgycZ85eJCtpLd/edqkHM7ppwPqMOfYIS9LXnHLXJvrx1aGiaQVkELlzwZiWjygL771VfaKd8BybuHDzvCSzRBtZeqUzTfgXz/RwbUKInqY+LAcssaJfO8nmvMKNDwjGtN72LfId77jApSjtnRkSK54ZgQd0hl5dz9AlObu4yDVDJ6UhgNHj3ar8ozZHXmXHdjPuXNlDUt2Ii6nThmsPZ7+PIEWKwczDNB43fwGDg2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:07:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:07:50 +0000
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
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v29 01/20] net: Introduce direct data placement tcp offload
Date: Mon, 30 Jun 2025 14:07:18 +0000
Message-Id: <20250630140737.28662-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 3459fadf-609b-465c-44e8-08ddb7df7f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6dGgC3Vhb6O/NOooh5pH+jc/lsQejwNGBi0PHPgZlcr5j17+VFkMeYjysQ1E?=
 =?us-ascii?Q?gY5q0buGcn5wBSPIJADvn1LrZzO/wnAx+zdbWS+EPbxR7/z3FmpzjLIcT3Gs?=
 =?us-ascii?Q?9+AxHW+RTkPDiGtkUiPTNo5gJOTIrMAbaGs1MxvhggCHCC20ycZ2/iIOBQDK?=
 =?us-ascii?Q?Bh8WYkEx9jBgYli0qb7FWZI9X0Ko/PqRDZwvs0T5kfz5wGAPWxCCn58++LSO?=
 =?us-ascii?Q?TAWV5XxzMbNz1BFO4Av2PHM8IQ+EvR0ROG+KfOL0diJMjLFxrvDcKiX59U0W?=
 =?us-ascii?Q?gv3TaqKuuGCEuYS1duQlNhFKmKy5QLXbGdI1N9ir4gxM6mFnUIqayR0PGdCP?=
 =?us-ascii?Q?ksgx2VoVKFtaIAW7ydyzp9rL7Yo6qSD6ofj2oKTyVLav9+xIWxvrFOJGQZih?=
 =?us-ascii?Q?4o9G+Nql3DN9CPDASqKZbXwSB9OYzICim2UfFxtzjDG/3A7j0zztXqay0ptS?=
 =?us-ascii?Q?25O52Fv7k4IDarrAHmW4Sxv15W3VSXmADQG1mYBVKEObcII94l7wqvklLB7J?=
 =?us-ascii?Q?zfuw8exyq9gHlx74SB5ubKi0XG4i+TrJ2UuyOILIr1HTh6XwKyKHIpzjA0wC?=
 =?us-ascii?Q?sFVWteqJMgB6RW2QxIX/IMjc4yL2XMkxk6DolNdihNoAaG1woO3HYWqoyfKz?=
 =?us-ascii?Q?I/8TlHSqlAapxketH67MU+PnYfcPWH5hmo87kOPTOoV3/0K9GzrPwHGdGHQj?=
 =?us-ascii?Q?Rod1d8FUFm+L/YI5RjjFhPpo5V7teBcQxxlmXr9OrQsluY8Q+hV9sYXXb5B+?=
 =?us-ascii?Q?4c0D7V06QRLKBlHzZQCBc84vc3p0S8CZi6a8KqYqn9Jq26ZfxlJwAk9E1dUC?=
 =?us-ascii?Q?A2AQKU7WQiX8AowFxvmbx2miBKh+6kBBNCYgEh9s6MQYSES9Z/pZgd6dsTY9?=
 =?us-ascii?Q?rA4JkWeSG53AeP9JC2UnyUskoW76tl3Rpv+r/fplPMIBVm6XRagvD0RDesni?=
 =?us-ascii?Q?wM0Ank4ln/scoH0dvN1zc7d5Qdtv8PAqE1qBBDFreY0pfkWywzbXDTL1AO6b?=
 =?us-ascii?Q?UkegZ/Rl2ls81dy5Fdob370YEdQC+hUC8veuzMSiI34IDeqENHsaA5IRy7pe?=
 =?us-ascii?Q?t/eD5daRQLUzl48k1sTZFcwrDfYbtZqSBxDs4YwhworvKs/x8lnFOhU9yti7?=
 =?us-ascii?Q?ouLOUJ/nwXvBu4fS4nCBQcrvDCoE/Uh78a5l4c5hvnp98+BRhT4La+VmjGVb?=
 =?us-ascii?Q?3lSyrVR/vVcTiFsHWnMGL7KE1ppymVJckMLuhOBbLeF7BHjrcYRIPmiQ7jnc?=
 =?us-ascii?Q?Ctf9wzkMRaOxrJYwOegSZZDhlU/Di5+RZkTas/sRjUtzA2oqrI39ZkCr1DSA?=
 =?us-ascii?Q?Hhq52dST0RI/GV5g7cHTdNRWMCxsO5HrtlJeFvebGybnjDuZVrfVLG4ARQ8R?=
 =?us-ascii?Q?7u/IqXxpcRn3PHKIDefZVDemmX8yjIXdrUDpSZeRgA7KHzRII8WSkXZShL/h?=
 =?us-ascii?Q?OgouNelDCc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?48g7zWj6piDPYvI68GvDygcI4Y/Cb1dFO+mN/tOkXSF+fMEymJUNQOYx9WAZ?=
 =?us-ascii?Q?5dT6BS/xynolO7aMDzZE2De0ww1onN+1uBxx/k6dsclZEXvQZYHCfg1RSyHW?=
 =?us-ascii?Q?n4hQYPzQ0Pmj2toz6zI+IelkGWhfWojGhdtZkkcIydA6gG3zEM7831y+Pc4s?=
 =?us-ascii?Q?ugkYvE0/850w2e8xqcxyNRbMi+ITRpBwzXaYbx3zn8qWlOrbDFO0zNmOe0fu?=
 =?us-ascii?Q?Yyy7fwGSsouQNwPA2ud3bUJzkw3WIep/kV5M3+uBVJnkLhJATmtKJHIN6gGg?=
 =?us-ascii?Q?7iNUfdipmRg44AN0tSzcFr7oZskK0zl8Szc5lbKFsIdQG4oQUEzjRO3yRscw?=
 =?us-ascii?Q?FpFwCMKM/GLOWp002Yi+iWRNyRnUbKME/nSg0zZoYJvvrKciCQ2IfGS9Pp3h?=
 =?us-ascii?Q?WTDXegyCc+r3M6crXphtQ4QY0CwOtyu3bQdhCS5Ck1L1mhLhXf4auIVy79zT?=
 =?us-ascii?Q?Qn/lqb2fMIksS7tnZr3+ZtKldQF3DSz7E30XBdB9aLdkQlrE95ApgkKbbaom?=
 =?us-ascii?Q?P9svCRRc1ZUdujtz7hKNP7rNX76W/TgHNQNihMRAElebzLQjeYo1KjEQbzU4?=
 =?us-ascii?Q?XF6ghYGLQuX0AO5dzjdZevsY0TcAuKvFKabugtxgEidmInkvwLrSjbCd1Awq?=
 =?us-ascii?Q?bH7yw5/rmodm+CZKo+5tRMwSfKNEjv+HTspKQZVfKTLQIpMlFLlj/haZjxTM?=
 =?us-ascii?Q?UbLkKteQa0Rh4Gp7Dap6f4HM4CEULBH9cMBY0UzWV6wS6vJE5QX2RjncpD6B?=
 =?us-ascii?Q?isgecnsoUEK8BQKCLSqGoEIrYFv5d/FhcU4Rq5r+P56xxWfYtgxjmD/7h13m?=
 =?us-ascii?Q?pudzDB6oeTr5oy7+hH9qvIchCrQxyJm1JhcSkSOU6qn36XcfcMrNyJCZwTN2?=
 =?us-ascii?Q?QjSJCXJ9zKY2oZ/n0QFe6znfqfsGptv6qke96mubc0DC/yG+NReyBsXoW70R?=
 =?us-ascii?Q?lV9AL9M7Zt9QhkFFrI9UDHtFE0h7/V5gjaabVh7d+jxYm/tjD2v5JqEz2SYU?=
 =?us-ascii?Q?9zMlUvOhGgzSABjDB698GWf0lgOSevpkOkVNRdYkKXeGBBxomUvM6/awGBRM?=
 =?us-ascii?Q?pm6vIxo0i2PjHSg0+MtPKm6nTWt6xHCIr/m1wcd6ggN3+aT5+gsta31/v25M?=
 =?us-ascii?Q?4DDFbHrhux5jqFHxjX5trVuYVNE5CE9vYTO3bP7DfCfKBuObIon00zOpcU+x?=
 =?us-ascii?Q?DBazjP8BXOUR7COmLM+tx9Mn5FQmBxXuZeprFpV+vYOPVFH5is7gf2k2kF/J?=
 =?us-ascii?Q?RTZXXlybq6eW9DvG/GXrNM6jl2ZIwK2Pd9xhAurA4dmtMytyVQ1ezMfJme4e?=
 =?us-ascii?Q?mgn95WaRnn/cg0C70+vND9tAUygwxYmk/MFc4iO81+WAzUy/cg7dJOYjhdyK?=
 =?us-ascii?Q?WqV10jnpkM5axlSWFGTVKsHwY/Vfo/kozOdKss5l5EUVivjdlFAgG3MOeLEq?=
 =?us-ascii?Q?MebXV7JjnU0PIJtx1t1ZUCa29RfIZZCOtJRLlr9aa9toeS2ftijkW2RsXzzD?=
 =?us-ascii?Q?9unmtWBFqzNP6pIJPQXXnksl35KX2HQy4MiCB5F6Fx5EJtSWL4xGr92mCY1H?=
 =?us-ascii?Q?tl4KiKr9u8J3gnx0YXuphknt9endJXMXGj2rghRm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459fadf-609b-465c-44e8-08ddb7df7f65
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:07:50.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRpzkdq6UKvm0JzPNVhsZdn1rJzWA1c7JVwHMkbXGdThvt728Q0FaaCKfhsvjPXf4LOPIKxim+geu1fbsOYToQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the sk->sk_no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  31 +++
 include/net/inet_connection_sock.h |   6 +
 include/net/sock.h                 |   3 +-
 include/net/tcp.h                  |   3 +-
 include/net/ulp_ddp.h              | 326 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   4 +-
 net/core/ulp_ddp.c                 |  56 +++++
 net/ipv4/tcp_input.c               |   1 +
 net/ipv4/tcp_offload.c             |   1 +
 12 files changed, 454 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db5bfd4e7ec8..fe510ba65c7b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1401,6 +1401,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1656,6 +1658,9 @@ struct net_device_ops {
 	 */
 	const struct net_shaper_ops *net_shaper_ops;
 #endif
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4f6dcb37bae8..a9e8fc6582e2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -847,6 +847,7 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1024,6 +1025,9 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+#ifdef CONFIG_ULP_DDP
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5267,5 +5271,32 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_cmp_ulp_crc(const struct sk_buff *skb1,
+				   const struct sk_buff *skb2)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb1->ulp_crc != skb2->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_copy_ulp_crc(struct sk_buff *to,
+				    const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->ulp_crc = from->ulp_crc;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 1735db332aab..65cca0d4d6c2 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -63,6 +63,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_af_ops		   Operations which are AF_INET{4,6} specific
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -92,6 +94,10 @@ struct inet_connection_sock {
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/sock.h b/include/net/sock.h
index 0f2443d4ec58..c1b3d6e1e5e5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -507,7 +507,8 @@ struct sock {
 	u8			sk_gso_disabled : 1,
 				sk_kern_sock : 1,
 				sk_no_check_tx : 1,
-				sk_no_check_rx : 1;
+				sk_no_check_rx : 1,
+				sk_no_condense : 1;
 	u8			sk_shutdown;
 	u16			sk_type;
 	u16			sk_protocol;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 761c4a0ad386..389906e53df4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1148,7 +1148,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      !skb_cmp_ulp_crc(to, from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..7b32bb9e2a08
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @affinity_hint:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     affinity_hint;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 netdevice_tracker *tracker,
+				 gfp_t gfp,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  netdevice_tracker *tracker,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index ebc80a98fc91..803c4bfda43a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -541,4 +541,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index b2a76ce33932..6d817870d7c3 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c..fe5a9df175cc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -80,6 +80,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6940,7 +6941,8 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb) || !skb_frags_readable(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb) ||
+		    (skb->sk && skb->sk->sk_no_condense))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..c02786ed5aeb
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	netdev_hold(netdev, tracker, gfp);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+	sk->sk_no_condense = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	sk->sk_no_condense = false;
+	netdev_put(netdev, tracker);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 19a1542883df..2351cc06d458 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5368,6 +5368,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index d293087b426d..77ae71ea25f6 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_cmp_ulp_crc(p, skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


