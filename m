Return-Path: <netdev+bounces-273046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDIFJ4zeyWnM3AUAu9opvQ
	(envelope-from <netdev+bounces-273046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D0354C2F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF69F303011C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B23921DF;
	Mon, 30 Mar 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9egv9jD"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63543391E44;
	Mon, 30 Mar 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837277; cv=fail; b=uDn4ZgYOfPnrGC1UABAugKOtq6BSM5QkBlqd/Kt/XmfIY86jKhZDuMFqpqUlOoW+8nRFgSaLwf1UIgWF9XTe+RXLeTshrYr+ZEyBdu6hiBgm5nB5q8HqonXQVbDYV2hyGhDzsELxPeYGX7/bhBv2O48F/JvE7zY1SDRASWJzP/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837277; c=relaxed/simple;
	bh=QYBJzJH65YB8tQo0SMmdHNgsWXD7WG7GicaFpOLQCjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RGPZmkv7CSb1GAqJfWCEWcgE9bcQtQceEQhh68udreGSIQM/a+U1qC3u6olgiIe5MiBmFe87chRaF8hlRoBe02xEciH3s1bcc4De8LW3UIi52RCE+re4X++UbzK2EFoFaO18pp16/o6GHOAnRruI6x7tDUGPyruTe2G+rMQOlGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9egv9jD; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phdv1ARULRfIl9MdRe3yD36OWvgvPUfLgixKQYYtjpZIHP4ezRvgdK4ajVbdtuYC6q/DTtmjjV28Att9/fCvG0ULQeO34ETJdqIMGz2jdyXbjbYr6aY/e+ZP+Buyi9TMxGY9OPMrQiXd2yC3VU8WVKgrYELdSAehjKbaXVUCjGRQJe8lQ+H04IXYJWw1710iLVfpHH/uiLMu8CeiwUyzSnAVDy19Yr/LzVgQsjcg2k1RkRk5b5M6NeA7hm6agN18kE1QVKm8qWFZgnoYrLYqKY+cIMhbjYQ6UiFQBKQ9q9hDuIgutYSq6k9dwmfU1pFNTWHb/a9/5sUB3QLIOa+6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD8PZjXiC2vGg6dm1rUMnBsWJWEIsOc5KZEgfWkMl2o=;
 b=ZIlirYWelZ3ToxTSJw9eEooFFDAtK6yCStXZtBn3T7lGwFFe+sD122EaK46z31TMKZ1R/312JsSJYtat6JEARV303meljiVOWzaDzNpm6+W9KjWQ17thmfFiJwg8aN4RjW1kOQuiB1LlyCDRgMmGK2Cztf/sgLNp88MO2/zTu5F88ksmO8YFgppC7jYsnON44zS9m139lmdZz4QRMJBy30Sn/0GtmahngSBzZMiSRY4TWRxyLUc02LcZMAlsEdmFzJv+Ma8YxFfALYMfDO7mVCM5fUZ+/68HjU3+Sn5Zi1GAQ/j4vmkOijOyCi6Me4ZrWTlEN7hbgacQEurlk6oueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD8PZjXiC2vGg6dm1rUMnBsWJWEIsOc5KZEgfWkMl2o=;
 b=t9egv9jDhobp+xSPll65NUOykXLbcKgEgUqjClPnqR8OvnO2aiUs7VYwA3UKHQM4Zc28eRN77EvAwnPEICdmLniA1EsLndOHW+FQZYl1rksUHSb9NRG2iTUhskpSPIMIkUxwr5Helc+4ubMmCfNvMnubPwUX/jLwipjXEG4hPFhSqI610G6f0bgLg/QTIqvgkP1yw/b4+lhJbsJUwhXvokg6qnlTXpQsdvzKiuWMS0fwQHCJ54M1MysY6x7uxjAM1lkF5rY+bRy/B8UDzoZrzCWPs3zUtiEb9BfdNcAcKVXt3hlLjDhlgyw7jXiszyNpPRMCC1oSQNg1/zRqg13vKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:21:12 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 02:21:12 +0000
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
Subject: [PATCH net-next v3 2/3] docs: net: bridge: document stp_mode attribute
Date: Sun, 29 Mar 2026 19:21:06 -0700
Message-ID: <20260330022107.670566-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330022107.670566-1-aroulin@nvidia.com>
References: <20260330022107.670566-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8ca8fa-67e0-4ac1-9be8-08de8e03035f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GszSB0XDsw0cQIvoBIMShlT1kLzpLIt+yRTYIHVjcPLrySoZpwL7DQxRGydwUDALoSpXK26fSqC78tvuAO6OXgf084k/ft2SOCpiVtdkMWJf/MyBn5csZ7jpfUxztMmF65bcOr/EzuQMy3Y2VwdYMXzX2KVep+zULTne/XggX/KCIC5WH8McqNN1cggymqKQSIqLu/Cqh5I21SXFliVTEw8EJSCEL//ROz5Fuo0vf+hFEcfpw7t1OP/IGboZsTL2FM+BoKWtpuLy0WybROj883bLHheSBRyED/HW8NF8AgIL556GwdkS2SIopfA0JU+cppmyIs3O1W1jL53xzWz4IhsbRfSkaK7c+NMrTLg9Exz1cH5oxUgy5qHi7GGl82zbXLK8nt/1W0ShEtFUc2YO886K7/Tt+xRd4SChw9h2aBjagLI3ITYBsaAGUjNvA2lzxNzEQaamJH+oeHGjnSdkucgFmGfBpskqce10g22dy7FjDTFMfO0BPYMKruEcWxsX2/mPlnXbl5A6E0pC+WPKuzABLYIHKtVuc/9QN72pz8ivGWlM+GoMAqy8z5l5I+S23qpcsT7v6apNwgLHewISTf23kU4xZzxtCNu25Muhq/5gg72x9YMXNlNvhrCKqcnLdMFzg+rDkbFYVOAsluOtfWR0l+q/odZK7InU1We3m6gvaMDTzHMBpM0IfAU8F4GHaVGv7Zg35t1BM5KnXHjIhZ4Njt4TtjPD5GwYfIo0WME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3hLwheW95N2gmjxxocrVYRr3f1rpIE5mim1YLKtxJKl7D6I97C2UN1t2ywl?=
 =?us-ascii?Q?qGAyoQv/P9S54vb3JQjilqPBYws9YCl1hCycn+d9SoT2aOha5vk0USlVIHjo?=
 =?us-ascii?Q?43Y91PKN/avwMqlkV/CieC3cDDX5csr9OTP6N7ZwtEjBf8nmWm+IVDiA6w/h?=
 =?us-ascii?Q?3uNEdTEOztpZTvdKD20WIXBJ399vHhU1Ox80Gdjb3hutXmwImoAvIfzUCXe+?=
 =?us-ascii?Q?FOLaIlvGMSZaTcmP9VnvJSu5CX2i/WqwI8UWWSuykVESLF5M5TZ4vIAI4PFv?=
 =?us-ascii?Q?0XcasR8HCKYEkt6mfqtsCLAASuWk8TL+tv8nGQahFF0ARH9SYZGVOWllGtl5?=
 =?us-ascii?Q?mGPYzM3MRK+Ai8wunlRQA6wTJox4tC96VZ88rkyOncq/F5l4KSc4jRajFg1W?=
 =?us-ascii?Q?1aig1LLfCod2RQNzgV/VPJKLhQ723oMjGe/5vpudBBcw7bmFdacMUrwpEJp3?=
 =?us-ascii?Q?WBga9wX731+bnm56PH5+Qp4FlhS91yYjqQjTXPV411obJRgTGdpBsMSrnd9o?=
 =?us-ascii?Q?c9kUQpunsqlAkiZASwvF+CXvDOXPyUSdthuHQhl2TxABgbK/KQYmESOXmuSN?=
 =?us-ascii?Q?osbMpg2AX4ajkNDAeoL925Bk/UIlA7PogN0zenM/sCvaoGj7bXizCrd+4XRP?=
 =?us-ascii?Q?BgU7DUy/zlyRkJbBBahz61f1qpWV1h7lj8p5NoKKErcs/7Hx1/aweZh2UHxq?=
 =?us-ascii?Q?BM1qNa1hmcBsNMe3cqR1Rm+0HpWzrWMR06A1DBPBUTGNE52mvXC5tMB5H+ES?=
 =?us-ascii?Q?0Fk8Vb0lAx87Gjh/AhE9LlXAqpobL6fT0IM8RWZbEgWAxkQHhDz7YRPzjHJZ?=
 =?us-ascii?Q?QQaUBo14aXaH/5APthedMWjZP60qpDUcNOPHd2200A416YeARRJbL3bwICJc?=
 =?us-ascii?Q?sy2GM3cw7TlcUrZVRtdDdtb6TLZCFoGlvjbEmUxNe4N2LsKSxbFpjhMZcv+l?=
 =?us-ascii?Q?7pRtXAqRF3DASCGtIcqk/Osw+IHJREARM5bdxq5n7ifDPuNh4Xfba8BZT1bp?=
 =?us-ascii?Q?A5cUBEVFFSLCEZrc0nOLH2/meN7JA93BiIyNxj/8XhbaULaIDVgPMHbuUIWj?=
 =?us-ascii?Q?l7NZAbfS541/lbxZDN+lpt3R+kLMH0nAzlZ7Pp6+zHIBUNGy3vBe1DuZGUSd?=
 =?us-ascii?Q?sg00FikiD4+nMwqXe4aPrKYzct53AdlqWuZFXNVpkggRyng01W7hEh/weH6K?=
 =?us-ascii?Q?/Ygkld4FndomL6JkJ9HOvnjgeObqRBIyXf8fKm/MWinCU4GKt8Z5WGeueMkV?=
 =?us-ascii?Q?VkxBLlEFNEAZavULyQcxwkGbyp6+EzM2PMPpY+9FfdCvOUfUpjpahPuKKf5e?=
 =?us-ascii?Q?ZV6Ik5i0Qzj/q0tdND4p7Z5FyWqkIOOymYkzPuk+U/5aUvJATFajNoAxasR6?=
 =?us-ascii?Q?m9TpqqubQKk2qZyn78XmiLrIW/UBh/pyFzGA5tehhpf/5VWvG5Qxl2EdGoDC?=
 =?us-ascii?Q?0Pjmxpy3CwKXg3hzU4I62+HU+AfitsY6YuWnIiqyB03nC86mW6zH6oJM3TjZ?=
 =?us-ascii?Q?6ZJ5npQT6FPKfBw79lPa8g/eJPaisahi+Pmkz9nBBj/XV6AXS3WnkilwhZ6z?=
 =?us-ascii?Q?J2FftV/BVMbYQE3FOO86OrX/IgwYFLl+Xj15670jT6PNLqYxrw+Qd3JnKJrn?=
 =?us-ascii?Q?hDWsd6cXZIf66LlS9gliikTh5Ij3OfoBf8RAYUTIOWoERILL+bUjfWIlEXXS?=
 =?us-ascii?Q?scZJf3cHlnvMw9aIP3m7DXdkJzF9kxNZoZOmuqqyfoyR4Yl9C3AWZfvhpblu?=
 =?us-ascii?Q?ccqZwfFyXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ca8fa-67e0-4ac1-9be8-08de8e03035f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:21:12.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKg+X/M7Y/tkkH8yyVo6qEbV/zIj3qJdl5ynJQQPUxaIQxDCLEj8fasWVRTG0DXk4/CwqAbJEw4GWdNhbr6KOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273046-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 448D0354C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add documentation for the IFLA_BR_STP_MODE bridge attribute in the
"User space STP helper" section of the bridge documentation. Reference
the BR_STP_MODE_* values via kernel-doc and describe the use case for
network namespace environments.

Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 Documentation/networking/bridge.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index ef8b73e157b26..c1e6ea52c9e59 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -148,6 +148,28 @@ called by the kernel when STP is enabled/disabled on a bridge
 stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
 0, or enables kernel_stp mode if that command returns any other value.
 
+STP mode selection
+------------------
+
+The ``IFLA_BR_STP_MODE`` bridge attribute allows explicit control over how
+STP operates when enabled, bypassing the ``/sbin/bridge-stp`` helper
+entirely for the ``user`` and ``kernel`` modes.
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge STP mode values
+
+The default mode is ``BR_STP_MODE_AUTO``, which preserves the traditional
+behavior of invoking the ``/sbin/bridge-stp`` helper. The ``user`` and
+``kernel`` modes are particularly useful in network namespace environments
+where the helper mechanism is not available, as ``call_usermodehelper()``
+is restricted to the initial network namespace.
+
+Example::
+
+  ip link set dev br0 type bridge stp_mode user stp_state 1
+
+The mode can only be changed while STP is disabled.
+
 VLAN
 ====
 
-- 
2.43.0


