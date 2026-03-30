Return-Path: <netdev+bounces-273044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nh7Ix/eyWnM3AUAu9opvQ
	(envelope-from <netdev+bounces-273044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:21:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82525354BDD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 737383001CF0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AD391846;
	Mon, 30 Mar 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+zMyE7n"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D7390984;
	Mon, 30 Mar 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837274; cv=fail; b=toOnCCdZU1/urqkT506o4I4eHzd4VzsDDVpK4lc1nXE0ZBGCmv/ig8CEtIMKzsmnRt7FdlOzPGsJpzaGv4xRZYrBFMBtupHKpTibUf9cvU4iIpZIfv9DRTm8AMFLaFbh1NaVFdL2paZFzCVyxxtZUcDsN72PedMwYoAMqpuX7dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837274; c=relaxed/simple;
	bh=STBy+CVC2Paz9kuoEAY+W+4SdS1l2+WKOdm76jcUKas=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ES6K/P/nDt3+1nMwN4xl6M1XrGzAQhBWXerFmHQJ0dvrCvUcYaR/SU8HEHcXiM/teMuv7qkEUfn2lvn5V3dEO5aDXnVJ5CJUAwKfZqQ+j5ujMbFGNX4a/MrwfrfY+9rHcXZEAKel6LeJDLu3eX2sCfwLQG4HP7cTHsFitQGehGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+zMyE7n; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQFPBu2MhXVpwAqf/BvJsKm4REpCBnWGRxtoNaH7gRotlbYCxLRvGv979UUjvTWmRdQq/R2HeVPNPvZXXno18FXCAGv9c8OiCeuaM2xdoi2S+ElYufE0s5Z1OUcX5dt+wl34R0OQVCLb4n2brjt0e3+NLUcwWBfDIfwjfVnLrCZivF7UwJEgujsaBMb2/Q1B7CMMaIqI2NkUQXJRjAerEb1exr1mGn3eA5ElMc67bbv+a3GUE+2Hd4AlkFeTW64VFJoE8uS1iozYPsvopotW+ux5y/CbjKbIxcvZH3Q41Cjbx1GRx7mGyAghFE7B5DbWWluHdiyZbJCt1OVlKNCsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGneJA8Zg7tSEzPHWj/NnhJwRQbmBhIpGIueo6AxwyY=;
 b=FZ5Rjv2K/eIwoB5MTUMUhRlGLEK8pVwukXaBbN9ctp6G6Gm1JIvqmA4lymG82BgRhfvAW5CCumlhQXLCSSJ7Czl+HxNBELT9eZzV1Kyi5a+BqK5dqstUQzAMvdUlrRoix1Yqe+Jwghl4obqRyy2N3Q+zLHoKe0nyj91DS3uHAk2h6bS9u8oFXdwRJ2elkbuPnZqSdjJLBvv/hso5TVrsi8xLu1wA+aBrVcD6iSX1ryWd24uYY3a9ymHah0n2YCndJ0ycVIJEyNMkvS5YsVAJ9W4Ou/n9kPmMY4b3qLbC+bvdV5jHVXCmXWoqqy9TTnC5eVv/7qflLMs6AkS16g2U0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGneJA8Zg7tSEzPHWj/NnhJwRQbmBhIpGIueo6AxwyY=;
 b=g+zMyE7ncxzJRK9EDFxVHaChEOQ2DB5v4pu0srANha4ieE5dSEERjW42q0qvM6hE6iSjWgRNN7yG27SKlR5W/9oQysblSwqNZ5dQnmeLhEnwaSlkhLHXI+sCCSHp3h9XxCqUieKYdxiUKogNjzdZamcNl/JCjZWKLpuHX9uu0SBocHNjiDfR6N2ZzmohSACQgdCiVGWnOCq1d5JZmNtuWhTQbegF1l4qpsSzu0MCVtPLGeVLoui4AKgdbBPRAKX3resc3sxlCegnAiw88/Q8cXAoB4nMnJhrHcMVPplXyCfJKy+mKOU3etqHEXqmG792Jv/63I/EASJMy/7fqZTFQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:21:09 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 02:21:09 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v3 0/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sun, 29 Mar 2026 19:21:04 -0700
Message-ID: <20260330022107.670566-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7950f9ae-46b2-4323-5ca6-08de8e030173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VrobU0IOodD3QOejf+Bs/29pcW2rZuv/E7xWciMsximif8jT3Vae6Qr7AixYpJAxaOSWqTiDe9RJKAKAAq+fyagWHzinVGoWK0VGxiaddrX1xUiQBZSKfUG/hdLpw9MK57bn0EXP0DA5I/ol+FmDo+4oRuGR1BgeTFPM1/EJ8eATPZzwrlxxQ4QN0iNVliReLa9zlzWEBFXOfLxrm+mrP6Qx7bodoJPsxrX86iHKTmJTnQBwuXNy6IkLTGZEwTApOcEP+CoGUi7/wlWWJFRBbIhDbhsL8jcIjFPDJnNMVbbdG+imJY9+ZqAbXrl0XDTPyvfWR2eg8F3QlFxcSLFSVciMFotjpe0xQSo9L/JqJDqtO0sv2GHThY5ppxdwWNRI+5sBzdp6LJ3Kdsj05fO+6S/uiFSoifH9HowSP1mLd8h5QQ+ThEjeOfVnV47dCLkPJAvxJ4Kh5efat3m8n9olTnuPATZoXS8c8GPsITWjxMrGv76eBoJWWkMtoAuY+NaBDW7PermTZot6u45hYXQdHAuMvsatGFThwzIXwJlGbRwPVu/mJb/WqD09LEiPNfx1OdlzQTxUweln+SezfcUGpzh0DPyG6J+SNHiFFhjwXzRe7HKMy5MzeFaOj5WQtYgW3XqC3bBruqfrrbEObNdDP2BXjTTBB9CXwawtJ3ahZZb1tHKXhmFuGNQWguEkR82WYQEKNpReVepiQGYAxEs/IgEEt/soiDrYrh3rA+fBpBaF+7Xoj4bZY3euA3KWRTZ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F14LzEXpBevav3pGP8pDXnwJb0pExLCbp7dQy7NY/pWMb9Mq+w4UjKBD/nVQ?=
 =?us-ascii?Q?8ja+tbPE2FyFov7wl+RV2ElYwvnvWnT8COPwiiT/nKbiPQ03+eTRhocKq0Dr?=
 =?us-ascii?Q?k+x4Bi+QxcsEuECrg202usjyA+tuSJ6xtISSXqpDOE3pu0HDxToBZ//0ZTDU?=
 =?us-ascii?Q?chT+nPkNJnC4tGGUqn1GKzRmCwUtz2oD8uDkHKcsEuiI64P9bHvCnQ8X5DeU?=
 =?us-ascii?Q?Px/g9c0D7WU344EUhcgWZSUuKXpoShkNnFv1LgoogMjUq9oK1iKP2QZz++uF?=
 =?us-ascii?Q?01E80T1jgY3fSXoRUtxO4IskY7IjaXkFXv7zLr67Na+JpD48Hd246lrsHrCW?=
 =?us-ascii?Q?WYclHEXZBh8bDxJsfsBszxu7FFowVR3reGoxGMO+UxFc+NUqNeCWJyJABBVx?=
 =?us-ascii?Q?HMKkm7k4dNU5rFGldAb/K3nVhQj7KmYKJa2BNzXTZBqpdwivG+bauqY9kEsE?=
 =?us-ascii?Q?HYEso53ogFA88+uGikUl6xXlsgngBBXHL//E3DIyereZV5wn4L79R5Sg1E0m?=
 =?us-ascii?Q?u+KntmvCMv+3939v7AnirhorRgqoTwcCz5IURhPfTfSuI0DoQ5vHnQbEmtyu?=
 =?us-ascii?Q?+OxIpAWi6UsGeINNPAoAQugVr+dT5m3n0FSWCht5kwRqQmw7XFlGCbp1s58Q?=
 =?us-ascii?Q?KfEoPrwm0qcIRThsrOH9Nl4cOFnFbUURKX+CoD8qfXdWdvL6qLwTAEhikyTE?=
 =?us-ascii?Q?M4B2JbWfDev5LygeqpCCTjEUlo1j3r/im587i7/5TKqjysAFgGX2iaM02jvY?=
 =?us-ascii?Q?DZyDnCx+908jBNt0XwA8ygrlrUDXnGzBEQHTx4V3nHwrELza+0CiQwb+KPO3?=
 =?us-ascii?Q?4upQRz21fJkmr7dtYejEAdLYJFE7PvmijCp6vjc4jjdtEAsBFQiD/wrN0ErK?=
 =?us-ascii?Q?wbbEfcUJgk3zcUk3had9CLmp1KEDdo/HnLN2lLQNtmG1S4hT7i+Y+T1Omo0W?=
 =?us-ascii?Q?LeSwNLX97xVOCYB9Kkerjo3iUo7xHyvl6ueYcfj2OM3w+HpmdD+GJahGOe8L?=
 =?us-ascii?Q?GPbKOM5h9tMeHwvEbiYZG7t1OpCaNyMI3sPLL0v0HwNWwpHW0ilPx8lM6kkK?=
 =?us-ascii?Q?sdmbl5cpARiLkpBIMFn5xl0zfODMmwOq65tkDZAt84CbTty6RmbVVP46DdRI?=
 =?us-ascii?Q?Wpzgsmiau7UY7BZ+DMGKVuu4GYpfVYBSBW5rDxNkAYYIZWYrtfpK1LFdlR6p?=
 =?us-ascii?Q?VavrRcyP7hJDWTJ+pzHiRei1C40qFc0YjIwdiOw4SA2c4860TIaCdOKRArw0?=
 =?us-ascii?Q?wutjkuasl7Qr23CF5QfUi2S9p9ksQPGGZfTCf82mJdp1YH8TON8TsBe24pnu?=
 =?us-ascii?Q?PMYvoIioJRzXKnxoYeEolJHgXXDwxnaiSFjXYvI7tbTvrG9XycJUE23vlJia?=
 =?us-ascii?Q?geh1/yfUuIGBjv4N4vTi2Wa1xTd3p9aycqxPRRdUWkOgHG2RKTlCRsGia2pl?=
 =?us-ascii?Q?HsUQMXPbdZ1EpZzrHD/+2GcBdii7XTb0eHFtbsZK0vMkXOiCQO+ZMWkU23CY?=
 =?us-ascii?Q?5x5JKbWW1VH8T+h90VYXyJh9PhBLlNq8L84Q9Oqiw1XxgENVVZ5QKGlE0c8V?=
 =?us-ascii?Q?qzlD32qLvumQUF2q6hHctGljs1f+rzYKamMkmYpBbi4uCCr72AGO5k+Gu1B8?=
 =?us-ascii?Q?BxW9uk4bMq6l4GnQkMBvsrYXz7syB9cqQw0P+McgepxLMfJPuk9BnU0TbDCp?=
 =?us-ascii?Q?AfN9axhVFTG4V+HCxtMgl3WBGTHYTOJxoZxDmvAvMhhCrYzlIUOaHIhXnzAP?=
 =?us-ascii?Q?EfPcDxE5Kw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7950f9ae-46b2-4323-5ca6-08de8e030173
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:21:09.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL6kzsyHjqpWUbAM7OFcnQ7OQ+zbYsbdeXug7TN8Jf5br9In/YdW2KRO1rM2WJYJGysWBDp2VoWCoUT5TaUFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273044-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 82525354BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons like mstpd from
operating on bridges in other namespaces. Since commit ff62198553e4
("bridge: Only call /sbin/bridge-stp for the initial network
namespace"), bridges in non-init namespaces silently fall back to
kernel STP with no way to request userspace STP.

This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
explicit per-bridge control over STP mode selection. Three modes are
supported:

  - auto (default): existing behavior, try /sbin/bridge-stp in
    init_net, fall back to kernel STP otherwise
  - user: directly enable BR_USER_STP without invoking the helper,
    works in any network namespace
  - kernel: directly enable BR_KERNEL_STP without invoking the helper

The user and kernel modes bypass call_usermodehelper() entirely,
addressing the security concerns discussed at [1]. Userspace is
responsible for ensuring an STP daemon manages the bridge, rather
than relying on the kernel to invoke /sbin/bridge-stp.

Patch 1 adds the kernel support. The mode can only be changed while
STP is disabled and is processed before IFLA_BR_STP_STATE in
br_changelink() so both can be set atomically in a single netlink
message.

Patch 2 adds documentation for the new attribute in the bridge docs.

Patch 3 adds a selftest with 9 test cases. The test requires iproute2
with IFLA_BR_STP_MODE support and can be run with virtme-ng:

  vng --run arch/x86/boot/bzImage --skip-modules \
      --overlay-rwdir /sbin --overlay-rwdir /tmp --overlay-rwdir /bin \
      --exec 'cp /path/to/iproute2-next/ip/ip /bin/ip && \
              cd tools/testing/selftests/net && \
              bash bridge_stp_mode.sh'

iproute2 support can be found here [2].

[1] https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/
[2] https://github.com/aroulin/iproute2-next/tree/bridge-stp-mode

v3:
        Patch #1:
                * Name enum br_stp_mode for YNL codegen.
                * Add enum-name to rt-link.yaml spec.
v2:
        Patch #1:
                * Add rt-link.yaml netlink spec update.
                * Allow idempotent stp_mode set while STP is active.
                * Move stp_mode next to root_port to fill a struct
                  hole.
                * Rephrase BR_STP_MODE_USER doc.
        Patch #3:
                * Fix shellcheck CI: add SC2329 suppression.
                * Add idempotent stp_mode test.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>

Andy Roulin (3):
  net: bridge: add stp_mode attribute for STP mode selection
  docs: net: bridge: document stp_mode attribute
  selftests: net: add bridge STP mode selection test

 Documentation/netlink/specs/rt-link.yaml      |  12 +
 Documentation/networking/bridge.rst           |  22 ++
 include/uapi/linux/if_link.h                  |  39 +++
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_netlink.c                       |  18 +-
 net/bridge/br_private.h                       |   1 +
 net/bridge/br_stp_if.c                        |  17 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 281 ++++++++++++++++++
 9 files changed, 384 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

--
2.43.0


