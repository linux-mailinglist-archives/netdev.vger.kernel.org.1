Return-Path: <netdev+bounces-223217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C4B585DE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987CF4E1C0A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78A23D288;
	Mon, 15 Sep 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intrigued.uk header.i=@intrigued.uk header.b="4bMsOLyF"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021107.outbound.protection.outlook.com [52.101.100.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE131C5F2C;
	Mon, 15 Sep 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967391; cv=fail; b=IrzJJ0S3/DR+1tuBczzkxsGQNRjC/rxVUv35VQuJVMD43TvTnAjtsYHPLFBjvvdi1+DAr64jtp9YqFaas4zSOBP6wZoNEAZMgaBFxoFZVUbkhAYd0654UGutFjMDMIUovbV/XiUdZALH9u+C4bAkl6oHNz1ukrJxmjMUGcyEbbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967391; c=relaxed/simple;
	bh=IyVxXBqKa1o26k12/UnL+TMGi2GPnYGwEHXqazNsKzg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VXLVhHX9fKM86b6JyBTPO6jpOIQ0T8XhbAEq2ync8VL5FD8CaZC+6Zwy3VnPEQzIvTFL+CLO1QSL2nFkMV8bCBO20BbtVRDm73OCSQb8cA5eeVZi4M66NgrdYyBephmQLWLWRC20LstRX7WS/lDXET/VuRtrIYG+yqvudVqdx/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=intrigued.uk; spf=pass smtp.mailfrom=intrigued.uk; dkim=pass (2048-bit key) header.d=intrigued.uk header.i=@intrigued.uk header.b=4bMsOLyF; arc=fail smtp.client-ip=52.101.100.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=intrigued.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intrigued.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpqmqm5K8qHzFUmWeThSHC1ByGKjai2OPI0v0p5T+zs2NFZjYyMe6O1AqfF/tx1DHPvJHX6P/4k6lTdnfahM5Ne3pXphbNcG7CEkM8Kog6X+NzbCe0bI8w86uK9UnZ3fDSN0Li5/M3XE+s4CNicH6659feIpP1JKjkb6gYW7AfyVfius01jkxa+yIYGNDntfSvFANXPeXWM6392OgWkWfLEL7ZTnqlSn+xzAO7dNULeBzz03APBIgTJSYS1Mkz43OyolSJTExAv5ghFuQCj21kE+Z3IqzBXHwHW/pCblMsK+Eo9LQUsRUlp2XlDPrKL1r6YWZ/RUAadYsh94R33gSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXqUKuRTHyMVPm2pUSw5mCM/DCDKMDky2QAP1O8q7D0=;
 b=Ga+8C95VVoyFU8DsIoOJJkTv77hylif5KHGg+gmQRvgJF7oz+gsA6l54BUTvEu3KVvx6SxsRPGohUr2td1hidwQc96CX6RHkPHPmwsKhf2YulO9ioGshU9BEGcoMVx1jvxSKHiT7AzDDXW9wgSNjUjA+1Hp1AwlTNeVfeQp7mWiN7VAKUbeyJ9vOc2txwKqEy/XZxMM/7p+ovphWM8NEb1exM/uk/j2gQ2hrApFQIf2GLLBSGOELUi7HNKHXZJhOWhvXD6viTsDNQwZtvag21nK7Q0YVvEkoCplVyWv94QPeoqUOgpq3vFfSdpM6bDk8bPaUcc04hTqg6ZIO8tTE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intrigued.uk; dmarc=pass action=none header.from=intrigued.uk;
 dkim=pass header.d=intrigued.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intrigued.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXqUKuRTHyMVPm2pUSw5mCM/DCDKMDky2QAP1O8q7D0=;
 b=4bMsOLyFpzjy9AmSWscG2X+HtriO7dBpBMWcw+GTaDaVSIKeOo15Bb/TRS+My/yyDu9WKItgmbZSvnRyJ5PMfMoiSQrU9rRXj8bErlWPKvW76Vhi5LB3zTuYNlR1v/TuAtBNR57MlmrlbnHf9Ml/m0NMzQC8yo0seGx5GaBMioiL22EGx9GbFtSaoFc/gZSzVRZW0Z3e8e9ZAKkOuLSsuoa2YGFPS78fTXrVuwcvwMglryae+4AIRPwtSFWRPm6VyQnejSaovBVAeuu2HEkZrT4J4N9b4Yak6rZnGqPYBPAlaMcVURdbUJT59L9DifLiDZG41HBmSBnHLjANlQYklw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intrigued.uk;
Received: from LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1f2::7)
 by LO0P123MB6784.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 20:16:26 +0000
Received: from LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e23f:f6b0:a91b:4ec2]) by LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e23f:f6b0:a91b:4ec2%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 20:16:25 +0000
Date: Mon, 15 Sep 2025 21:16:24 +0100
From: Joseph Bywater <joseph@intrigued.uk>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: net: qede: QL41262 unable to TX packets with multiple VLAN
 tags
Message-ID: <aMh0GP2KFOi5FJrd@intrigued.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0199.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::6) To LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1f2::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO4P123MB4995:EE_|LO0P123MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9628fe-70a3-4092-0def-08ddf494bf20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZHzaQ6s6IhkltO6u2uvVBijZ8Xn+16YXnNNZwoOVjAhoDO1Y05nfOZlLDk4?=
 =?us-ascii?Q?rNZVvTfGTfxdAy/ZTy8TDHYTMA4S48K5mSRftbPtbLbk4gxMrIMc31k2k1Cu?=
 =?us-ascii?Q?0ZVntRdTZCist64tDfhFoD5XdQIBCwiNBvkJBpz3nPhjd44oesJdjLGKyN94?=
 =?us-ascii?Q?d2Tk7OCqrQgUJ9wh2iYTTZI7l0tO6HX7VsboMRHFMwCxMyC0zS7rFk58Bc2X?=
 =?us-ascii?Q?FEJ1FPd918Y152sm2TL+6LNQ+FhCAli2xo+FqtSh42UxMRfC02xaO/XZxXyq?=
 =?us-ascii?Q?69QKNULFbNQAVQ0YVwypL+kr9DIW2ycJPXTAjEwenb8fRpRe3FqqDB1n61NZ?=
 =?us-ascii?Q?kcabZ01QqbFgMTuY3HGdPCxsDOl+4VtTcto2AZ2pURC8pN5ooJ0p2sIB5yrQ?=
 =?us-ascii?Q?WmxjwVRYjaYlf8bfxlsLJSe9Te/ltkE7Si+ULMWhdXx7EUfJPQo2dbK77trx?=
 =?us-ascii?Q?iHuak5H0LCs60D8oXYQCD3T/iKmEbiUSM9z0Vg5UQuDBDr2YEkMfxrw8Zeq5?=
 =?us-ascii?Q?tS+0tbDjqrnC0bADw3l1EDBxqmoPl3OjXZkBMBFdCveiFR9Br075llJVs6r9?=
 =?us-ascii?Q?w/02F849MPKAkiKw92Irg5eZ+/EDx4l7C5hEJN5WA+TlirVuOSBlY5Pa9jNF?=
 =?us-ascii?Q?re+h5TQVpA2PmBBfz/p7k3pc0K6Qd8U16KSjQQXdRUxjxx42YdRJM3J/LISK?=
 =?us-ascii?Q?KiM8UQ/V+IUvAcxj3Y+Xl4CYFIFnegZUVfIgGcSu6OtryzgA5MV7S2rPLBlx?=
 =?us-ascii?Q?Tks7b5/1Msxh9TIrTiwTwKmPq6kEBWQ0DF8tlyvmk8uknGY7RbZKpN0yVvo/?=
 =?us-ascii?Q?x0UCq07e1QfDAN1QWqSO5CUevo01Csr07fUS4ucynBqQBTQCkK5kZv5P8Qqw?=
 =?us-ascii?Q?hofyZ13YDJ37c/fEHNxJm8aJEylL/UfL6tMH9RpLonovyCgk4rZ37oTunTuP?=
 =?us-ascii?Q?dhALv8pvmGTLMMLID7F6izVt5AvGwwwYE/+YSrSpNUSGeoCHeuQVyv/YF5cg?=
 =?us-ascii?Q?6pPj2pkgSK8jqZOqA8USADfXOtLn/B5UzeHNWrl/3DVlf6aycHiHVmpVQzA+?=
 =?us-ascii?Q?bxm9Ha85Huwn8sYGEBFDlGYT0l2ZdK4QMooTtbs4a+0S24k/b56oe2S1jzYt?=
 =?us-ascii?Q?GD0LOX/6FZ242qnpyo3rfm7xhVcmT7iwhPMQJ7Va+rQKKMwk/qXDr5XrJWag?=
 =?us-ascii?Q?t7VJOq5V9vMpGckxnTX5owYVam8y98EqlroqLVmVMNiLHrBCV+DWdqfwUCag?=
 =?us-ascii?Q?OClUKuX6afcyudCi2l6Se/s0AmbNRcwuiDJRr0/592G7lJtNEtG0jUL7li4j?=
 =?us-ascii?Q?FDoi6nGn/IMVsLzpjZ5xMKa81mmCH3mHSOOItMDBVnev2LgqTw6CC0XNRKgB?=
 =?us-ascii?Q?58GD5F8c97dEMShOKHgigviN5tVwNlssqg6M/qLSa0BOKohGxEakeCuLpEYW?=
 =?us-ascii?Q?QAKu1s0j2GE4zKCh4pMRJ2MmGy/bvIkHSMlxG714hs6CSJgnpFoTpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/GuT4KnBIXxQd7sshfCWPwQMR0AUSyV2HD4BdZqgFsnil3+yGrRk2SAYqIh?=
 =?us-ascii?Q?Y6oe0mwq5NM5JLjCmuxXIlBJNs9BTxhRMaBHYvRf+bVwLHu4k+rmuNkce4Lr?=
 =?us-ascii?Q?q1ZPej6QLkJFf3hiVJ9HOKu0ZC3KHct2X6btkqNUUclhTv8uLz99/jWIlxsN?=
 =?us-ascii?Q?yMrRr27loq1xHmnruQzB73jklfQScykqVsJnh8QYxgUH51QPRaSVoL+ZKHUD?=
 =?us-ascii?Q?+uov0a1g02s9Au1SXa+eo6vPfjD5LJmPIQMvZLFHi7/gqtl8yLDCfqaoU1pI?=
 =?us-ascii?Q?Tihi5yitQg5jx1rVPFZfhKGMHXmm0l5AVTpzvkiciGVRzeitKau3Pluxs8lG?=
 =?us-ascii?Q?U2TuKxPWYtd8d8wXyszT/8LNbU0fgeYk5HTnexDg+7Wf9XZMQEhetB1YhF2C?=
 =?us-ascii?Q?kCJpsvytQagUKlfR4uh2xha6MBnnX4vi22M9+ohb7mXLaQDvvsykXDwsuizi?=
 =?us-ascii?Q?FGt4/1O5b7obCb6HkaYbeJvJysGova5XHhocgWyoq0aMLAtPE5La3IrRgijC?=
 =?us-ascii?Q?Uwqz28rmMu+EVv3TCQi6VJ4RXBds1vdkPRH8TWa+B6siByxaTNDBfqi1BqUc?=
 =?us-ascii?Q?Ykh4hz3lPt9eiXL1IhS/MohFXq41OPCzITC7IEtcgOXDSfYjuA8YKUZfOX95?=
 =?us-ascii?Q?xNcR12qwEAM2Ry8sgmwPnIdiZYWHQyg+DHq26B1FTCgsU1y30kjPwQwC5lnD?=
 =?us-ascii?Q?MkLRWNzp+91zNhcYpfGtQhspfwVwLUe3uXxWZ2RZUc9g7H6RNs3c0LosVBCG?=
 =?us-ascii?Q?+UwG2UU9vOkLNZN9bF8Q0RtJmufrEw52xKORVBleHnem0RZton6X2sZqFYgd?=
 =?us-ascii?Q?oavDxhzTrP+vYG3I1HzibP6gJWqcpVqlKjjyoddz9SJ+8wO8qG4BGiikXWc7?=
 =?us-ascii?Q?u4nH70ERHq6SFokq2JdEFTais0cwOce5PxuZ3SnhhgMPzjj9geMkvWdJA6ge?=
 =?us-ascii?Q?ejjXUvyr7nT3/ihtAGvtct8/C016fTyCA+XglurmhcLAiHXBpvzXJ2lzATvn?=
 =?us-ascii?Q?68EI/I82/fgWIvtmMfBmgQ6U6Y/yuGrrvTOqCCTyJAEigXgrvhp95SNrWCpq?=
 =?us-ascii?Q?ihf/XAtrrytDDBa1cs0sO98hRx2ReRo8omaL25e0UOSKJEvDwKoUPGm7Mg/m?=
 =?us-ascii?Q?EH6roxkfFN0cWIZ/vR+3DDOdKScJio9Sjuiizg4bsBGMv5q6Jjc4RnSQmXpn?=
 =?us-ascii?Q?t6QhK+XdKFFje2uUVinGaSrL0c/mmRf0w1C5doTyCJUVFMawf20TU1AvtUIU?=
 =?us-ascii?Q?IgN0oKGaXgifDyOUAynHCPmaTuT6u6i87tjWi/eab2diswKX6XSomkjsC5MK?=
 =?us-ascii?Q?wxKBE58O6lvNDG9JC/CnuZoZzye7r9i+1FYaM2COSurQJ1RpDhCQg9b5I3oM?=
 =?us-ascii?Q?XxIzMlJaNo8gbB3f5u1qaFEnBLdg5kX8fOQVO57GPOy8/ChiEA4KL6VF8I7a?=
 =?us-ascii?Q?Uu6QvSZG98cJ1fTI7sywsCBD/mNgKRcH5KLk7Cc/52t9wBcQitl+deXx8PZo?=
 =?us-ascii?Q?IG6s+cagA6QUqyo0TP6HZhE71nMP/73jqZBV66OEbVpnLjjWPeRe88eamx3N?=
 =?us-ascii?Q?QXoSBQ+M1lceARRgC1ppJxTu297D8HzX6OuYNHH0?=
X-OriginatorOrg: intrigued.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9628fe-70a3-4092-0def-08ddf494bf20
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 20:16:25.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 42dcc6dd-439a-483c-99c4-86bd4e2f0f10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUWO+kj1BvHpONYKDDg9Iro7m88mSuMvTvpto2QujTe2bK2lw0XbzCkmg/AQyPWgW0qg66U8N69L627M1B6dDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6784

Hi,

I have been having a problem with a QLogic QL41262 NIC (using the qede driver)
that is unable to TX packets with more than one VLAN tag. RX works fine,
even with more than 2 VLAN tags applied. 

I set up a test with two servers, one with an Intel NIC (ixgbe, .101), 
and the other with the QL41262 (qede, .102). I created interfaces on each server as follows:

ip link add link eth0 eth0.10 type vlan id 10
ip link add link eth0.10 eth0.10.20 type vlan id 20
ip addr add 10.50.10.<101-102>/24 dev eth0.10
ip addr add 10.50.20.<101-102>/24 dev eth0.10.20
ip link set up eth0
ip link set up eth0.10
ip link set up eth0.10.20

I then attempted to ping from the Intel server to the QLogic:

ping 10.50.10.102 (single VLAN tag) -> works
ping 10.50.20.102 (double VLAN tag) -> does not work

In the failing case, with two VLANs, I can see the generated ARP response
using tcpdump from eth0.10.20 down to the eth0 interface.
However, I do not receive this ARP packet on the server with the Intel NIC, 
and the packet counters on the switch do not increase.

Here is a truncated output from ethtool:
rx-vlan-offload: on [fixed]
tx-vlan-offload: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]

I have tested this on 6.8.0-79-generic, Ubuntu 24.04.
Additionally, I tested a similar setup with other NICs, which worked without issue (drivers listed):
- mlx5_core
- ixgbe
- ice

Is this a known limitation of QLogic NICs? If not, are you able to
advise on further tests I may be able to perform?

Thanks,
Joe


