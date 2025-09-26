Return-Path: <netdev+bounces-226626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E19BA320F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93827189F093
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E87272814;
	Fri, 26 Sep 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KRsYtMXc"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1B2264D3
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878758; cv=fail; b=fz5g1BpJdZsWGH1xG4UJIu+N7E3NZ4MNAz3mcpxxNdAcm3PnxfU2zKpc8Ed29reTBejSgdKZgqwdYqUgoDHkPmm60wnK6AVEMPrQ5WY4+rTBzusSsanbp/esgmMpyR8ZC4up05T+1F+hljb0QJIze7tAAQEaUl/ZkieO+LtAioY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878758; c=relaxed/simple;
	bh=/nqO/s0QFHq6c5e6bw8mUJ2ZHd0j5vJQQVEK/twRpFg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ud5tMazBK8Vy1F6qQvaleoT/GH/jbYCzmm/0+DO9ut/bygVgNrbty6T5mJCusqIYDyNYxjpNMgxPPdb9ShuSWiTwvafHDEdYdJUIPqXZi7WhgGxifxS8ByHtX2EQxC1Sn0/L1uusVe4eQjJuLMwuA+i+BlYC9kD+cwnRd6ghnKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KRsYtMXc; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA9YU56SqXIk+OtbcbmNDgTcYOoQBiA4SASCWnBcWsQ3omCNGVj3UDq/cNyhDn1WN784c+/8FCmli+vs5vwBbGstdmgUkuuo5wo0T1pYDiS07+8jhSPlSBQ0LJPqAg/xpOYL4Yh/97OMUAI3Hdfrj6LaBCFnR3d5KxvA0qks0HVW0ej0JJqhz9vphE4R2OHAZHjN2r6LV+WJX6WbYrg9xtxk1oN73n9TVFHbEWTyIR2OJFs8wsKNxMnH/UDYHQZ/saYIawZENvn7Hja0wwaF7OODLzWiL+00NSqVFZtu9eThQIW9OEBtcd9+Sf02nmT9HCcfCmq+4c4o2hiKusG5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1P4IJxq5htp83a4U4+2MYJSRUtG012ToMRl9beykAQ=;
 b=B9I4FYVquRFIrYRIN40R8MFb5W4P6bvPaf9B9fqVt+pZuRokJ3bzqX0jPH7IpeRWHKpZhQ3FW/oiGKnIvg7uWSxh03XlD1zCjKaRPhGUb62xXVxwt3hS9TOnnv6nZx7EmgwLsO11YVM0tMlIYpdQgUHL97OGE86Jhwp/K4kKghNjDtff67dgSzLv/8IzLtec168Dv+Bm2xfpgJWwI/SibFprsfeJ3SktSx4+99A5OCW/lSBK3rCUnZa4xQugwCL+4rFRJdW4JijOe7rWL5t3T/TTGNbNcMen+Z0flePGbnzTk2AKjKBMykNW/Od83XHYAlWroS09V+OOXe50nPGT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1P4IJxq5htp83a4U4+2MYJSRUtG012ToMRl9beykAQ=;
 b=KRsYtMXc5Ajq5IDP+w3HtnwIrhTs/dnPP2nNH6MzA7LN6dTLN3FA2yKf2/qYq+WyDiob/HtWFoooTroYTNx4Amhp/AWEtsZ5hNAF6TKhzOWBShP58/EjS8bzT3zn9CPG5iBCdKJWju7hXxbHczA7OpaSeKkK4lGTh0chIbaV0Hlend9hFEvlv6T2NObJxQQvu+n3tDhT3iX3oTGoqCNaBlvK5hF5ckxpFHObzJLhfKQ345xaH+xHj79YMCvxmX1zRt6+45o09ktuGL1dm4t4sX+e/0naItV7tQD4M0K1PY9ERD0BsRSNq8/AbD1IhleXqPm2V70jpyOBWb5p9OEiWA==
Received: from SJ0PR03CA0121.namprd03.prod.outlook.com (2603:10b6:a03:33c::6)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 09:25:51 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::8a) by SJ0PR03CA0121.outlook.office365.com
 (2603:10b6:a03:33c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 09:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 09:25:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 26 Sep
 2025 02:25:32 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Sep
 2025 02:25:24 -0700
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
 <20250924194959.2845473-6-daniel.zahka@gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Breno Leitao
	<leitao@debian.org>, Petr Machata <petrm@nvidia.com>, Yuyang Huang
	<yuyanghuang@google.com>, Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] selftests: drv-net: psp: add basic data
 transfer and key rotation tests
Date: Fri, 26 Sep 2025 11:15:15 +0200
In-Reply-To: <20250924194959.2845473-6-daniel.zahka@gmail.com>
Message-ID: <87frc9woqk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7d256b-f5d2-4b51-cddb-08ddfcdeaf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REjMs/QXzFGYfpN8tZDCsEE/KD6kLVtJxY+zuHeQquH0NwXP85RF1HVj1qTE?=
 =?us-ascii?Q?13MLLiMtn7dVQVM0xtyxcus8EWk8yz1BGglUwnJEOYeLvdSnkRjFu4xiL50d?=
 =?us-ascii?Q?8VWUTkp08EihrLJNOxmZ8PypIrSDgB6/++AbIqEiD8EtuJkGogT2DJK8LK9A?=
 =?us-ascii?Q?+/qQdrHHw7DmjfMdyNQERHOUrk7IQV44qJBJeP9yg+8//J6bUPUCaU5rcYUa?=
 =?us-ascii?Q?vcuffatNFOyt9jCdf+63KdxD8wnSFA2N45yqxpRp3gPp2LgclTTXBv7nFl5L?=
 =?us-ascii?Q?AXFG/HT8FKEL1ODzl4tyMqLbePEaXLZndrXMInCIdUZXGaqbaVv2iFrW6jTG?=
 =?us-ascii?Q?Qj0D6HCX/F6ENMsVWfVmXj1oil4thFJgEks8G4P/lYSTrFyhlGwObxks6RoC?=
 =?us-ascii?Q?FoWI6uplxewEgSom/yUorIPcCKZc/cQ+bryHAXDc9s67zNjq1GpjlQLBJzb/?=
 =?us-ascii?Q?jKyUhAwI1WqEd0uPeZ63LdY5oFJhNRK9ydDih2/l50YPzNoHk/rivTwk8CI3?=
 =?us-ascii?Q?ZjtAPqHmzrtUbxOKyxVk0sFJWnEZTXTNYCJsgPv18OBnV4rGwwPTKidxj+mX?=
 =?us-ascii?Q?RA5KlxgUtWXRqMjESyPFJ5knSjbRrNPALxAmSDqmdqBkMs+ZAxYbuP1e1pX+?=
 =?us-ascii?Q?4XJJyC73kGjSzwYo/FgbmZ5cW5RhwWLl5HzE6Ucbl9K1EIDQYgDnkG857657?=
 =?us-ascii?Q?eU8fHy6TEP58YTqv8x/JcQjozBVpEZ1gJihkDWamt/+y1jgUyNnSLx3IQTRM?=
 =?us-ascii?Q?NkAOke/b4H5DM1sR2eZqVFTOPrxPv4YvUwZPQIJdW9+ax7Cr0dFEQqnQeEYa?=
 =?us-ascii?Q?bClyKPWmARU3IZkcXQPojnKmakXKEjiJKplQUyGsXj3Uqn6cW8QxKelnn2jB?=
 =?us-ascii?Q?AE3Eyi+WaKUDKVJoOKBNOt+8YCd2fbnvBjT9W11upbD361xYOHZtCWnkxj/J?=
 =?us-ascii?Q?yhHILFJphelIB0t1gXMJh7vmHgNkGkrX1qTOmMQqM6odFwlcpxi5DMTGGwpz?=
 =?us-ascii?Q?AQoXUZROL0inlZKjuaixpl5qYjRGspabx7+Zq84SWE3fS2ejWSzkL/UAAQEq?=
 =?us-ascii?Q?vYl3aMm6aOdNT1VX683b22aGKxg4uYHKQiUdu3/hL10ZtPc92cPIP7NrWGzd?=
 =?us-ascii?Q?++rJj2fJJXYHfREgTIRd2HCxS0Ren4hJKMxO+wmdm3QPz9yq44dwg4tPya5I?=
 =?us-ascii?Q?s9we+8ykQfYdf2mDE+8whbZrSYa+1FIpC6Q2Lx5FQIs1ijWKs5ez64ThhX6R?=
 =?us-ascii?Q?9ZYVvtL8459yjJ2LnODWBmj6s9YB51fSYq6Wqb80x9mrbnQGeUMWMA7wMqd2?=
 =?us-ascii?Q?zuha7VUfNqNal3+42h18aVQae+o4DZp8M7wk8L2iqpz7gDLl0lO7KxmejONS?=
 =?us-ascii?Q?oss8Ro5AnBQpcSTLXbBjNpdwJ27Yu2W7fbJ5R6MBAIqOp2duP6ZrUgEnXoF+?=
 =?us-ascii?Q?nhX+PrCUqShZQuyoKKXK+Cq6oljQ+7u8Bb2bsjXZMhNFuBI/QaGI3LOA4SO6?=
 =?us-ascii?Q?4Z0fXckI8Gu7PFqm9fKBv3iIM1x8/P05yQCAu141Owe+YW6Tyww1hvpOP+d5?=
 =?us-ascii?Q?So3ehIbq8V3ucfPElSo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:25:51.4250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7d256b-f5d2-4b51-cddb-08ddfcdeaf9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321


Daniel Zahka <daniel.zahka@gmail.com> writes:

> From: Jakub Kicinski <kuba@kernel.org>
>
> Add basic tests for sending data over PSP and making sure that key
> rotation toggles the MSB of the spi.
>
> Deploy PSP responder on the remote end. We also need a healthy dose
> of common helpers for setting up the connections, assertions and
> interrogating socket state on the Python side.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/psp.py | 200 ++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
> index 965e456836d2..b4f8a32ccbbb 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -3,9 +3,94 @@
>  
>  """Test suite for PSP capable drivers."""
>  
> -from lib.py import ksft_run, ksft_exit
> -from lib.py import ksft_true, ksft_eq
> +import fcntl
> +import socket
> +import struct
> +import termios
> +import time
> +
> +from lib.py import ksft_run, ksft_exit, ksft_pr
> +from lib.py import ksft_true, ksft_eq, ksft_ne, KsftSkipEx
>  from lib.py import NetDrvEpEnv, PSPFamily, NlError
> +from lib.py import bkg, rand_port, wait_port_listen
> +
> +
> +def _get_outq(s):
> +    one = b'\0' * 4
> +    outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
> +    return struct.unpack("I", outq)[0]
> +
> +
> +def _send_with_ack(cfg, msg):
> +    cfg.comm_sock.send(msg)
> +    response = cfg.comm_sock.recv(4)
> +    if response != b'ack\0':
> +        raise Exception("Unexpected server response", response)
> +
> +
> +def _remote_read_len(cfg):
> +    cfg.comm_sock.send(b'read len\0')
> +    return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
> +
> +
> +def _make_psp_conn(cfg, version=0, ipver=None):
> +    _send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
> +    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
> +    s = socket.create_connection((remote_addr, cfg.comm_port), )
> +    return s
> +
> +
> +def _close_conn(cfg, s):
> +    _send_with_ack(cfg, b'data close\0')
> +    s.close()
> +
> +
> +def _close_psp_conn(cfg, s):
> +    _close_conn(cfg, s)
> +
> +
> +def _spi_xchg(s, rx):
> +    s.send(struct.pack('I', rx['spi']) + rx['key'])
> +    tx = s.recv(4 + len(rx['key']))
> +    return {
> +        'spi': struct.unpack('I', tx[:4])[0],
> +        'key': tx[4:]
> +    }
> +
> +
> +def _send_careful(cfg, s, rounds):
> +    data = b'0123456789' * 200
> +    for i in range(rounds):
> +        n = 0
> +        retries = 0
> +        while True:
> +            try:
> +                n += s.send(data[n:], socket.MSG_DONTWAIT)
> +                if n == len(data):
> +                    break
> +            except BlockingIOError:
> +                time.sleep(0.05)
> +
> +            retries += 1
> +            if retries > 10:
> +                rlen = _remote_read_len(cfg)
> +                outq = _get_outq(s)
> +                report = f'sent: {i * len(data) + n} remote len: {rlen} outq: {outq}'
> +                if retries > 10:

This is always true at this point.

> +                    raise Exception(report)
> +
> +    return len(data) * rounds
> +
> +
> +def _check_data_rx(cfg, exp_len):
> +    read_len = -1
> +    for _ in range(30):
> +        cfg.comm_sock.send(b'read len\0')
> +        read_len = int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
> +        if read_len == exp_len:
> +            break
> +        time.sleep(0.01)
> +    ksft_eq(read_len, exp_len)
>  
>  #
>  # Test cases
> @@ -38,6 +123,75 @@ def dev_get_device_bad(cfg):
>      ksft_true(raised)
>  
>  
> +def dev_rotate(cfg):
> +    """ Test key rotation """
> +    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
> +    ksft_eq(rot['id'], cfg.psp_dev_id)
> +    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
> +    ksft_eq(rot['id'], cfg.psp_dev_id)
> +
> +
> +def dev_rotate_spi(cfg):
> +    """ Test key rotation and SPI check """
> +    top_a = top_b = 0
> +    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +        assoc_a = cfg.pspnl.rx_assoc({"version": 0,
> +                                     "dev-id": cfg.psp_dev_id,
> +                                     "sock-fd": s.fileno()})
> +        top_a = assoc_a['rx-key']['spi'] >> 31
> +        s.close()
> +    rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
> +    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +        ksft_eq(rot['id'], cfg.psp_dev_id)
> +        assoc_b = cfg.pspnl.rx_assoc({"version": 0,
> +                                    "dev-id": cfg.psp_dev_id,
> +                                    "sock-fd": s.fileno()})
> +        top_b = assoc_b['rx-key']['spi'] >> 31
> +        s.close()
> +    ksft_ne(top_a, top_b)
> +
> +
> +def _data_basic_send(cfg, version, ipver):
> +    """ Test basic data send """
> +    # Version 0 is required by spec, don't let it skip
> +    if version:
> +        name = cfg.pspnl.consts["version"].entries_by_val[version].name
> +        if name not in cfg.psp_supported_versions:
> +            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +                with ksft_raises(NlError) as cm:
> +                    cfg.pspnl.rx_assoc({"version": version,
> +                                        "dev-id": cfg.psp_dev_id,
> +                                        "sock-fd": s.fileno()})
> +                ksft_eq(cm.exception.nl_msg.error, -95)
> +            raise KsftSkipEx("PSP version not supported", name)
> +
> +    s = _make_psp_conn(cfg, version, ipver)
> +
> +    rx_assoc = cfg.pspnl.rx_assoc({"version": version,
> +                                   "dev-id": cfg.psp_dev_id,
> +                                   "sock-fd": s.fileno()})
> +    rx = rx_assoc['rx-key']
> +    tx = _spi_xchg(s, rx)
> +
> +    cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
> +                        "version": version,
> +                        "tx-key": tx,
> +                        "sock-fd": s.fileno()})
> +
> +    data_len = _send_careful(cfg, s, 100)
> +    _check_data_rx(cfg, data_len)
> +    _close_psp_conn(cfg, s)
> +
> +
> +def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
> +    """Build test cases for each combo of PSP version and IP version"""
> +    def test_case(cfg):
> +        cfg.require_ipver(ipver)
> +        test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
> +        test_func(cfg, psp_ver, ipver)
> +    return test_case
> +
> +
>  def main() -> None:
>      with NetDrvEpEnv(__file__) as cfg:
>          cfg.pspnl = PSPFamily()
> @@ -55,12 +209,42 @@ def main() -> None:
>                  versions = info['psp-versions-ena']
>                  cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
>                                     "psp-versions-ena": info['psp-versions-cap']})
> -
> -        ksft_run(globs=globals(), case_pfx={"dev_"},
> -                 args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
> -
> -        if versions is not None:
> -            cfg.pspnl.dev_set({"id": cfg.psp_dev_id, "psp-versions-ena": versions})
> +            cfg.psp_supported_versions = info['psp-versions-cap']
> +
> +        # Set up responder and communication sock
> +        responder = cfg.remote.deploy("psp_responder")
> +
> +        cfg.comm_port = rand_port()
> +        try:
> +            with bkg(responder + f" -p {cfg.comm_port}", host=cfg.remote, exit_wait=True) as srv:
> +                wait_port_listen(cfg.comm_port, host=cfg.remote)
> +
> +                cfg.comm_sock = socket.create_connection((cfg.remote_addr,
> +                                                          cfg.comm_port), timeout=1)
> +
> +                cases = [
> +                    psp_ip_ver_test_builder(
> +                        "data_basic_send", _data_basic_send, version, ipver
> +                    )
> +                    for version in range(0, 4)
> +                    for ipver in ("4", "6")
> +                ]
> +                ksft_run(cases = cases, globs=globals(), case_pfx={"dev_", "data_"},
> +                         args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
> +                cfg.comm_sock.send(b"exit\0")
> +                cfg.comm_sock.close()
> +
> +            if versions is not None:
> +                cfg.pspnl.dev_set({"id": cfg.psp_dev_id, "psp-versions-ena": versions})
> +
> +        finally:
> +            if srv.stdout or srv.stderr:
> +                ksft_pr("")
> +                ksft_pr(f"Responder logs ({srv.ret}):")
> +            if srv.stdout:
> +                ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n", "\n#  "))
> +            if srv.stderr:
> +                ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n", "\n#  "))
>      ksft_exit()


