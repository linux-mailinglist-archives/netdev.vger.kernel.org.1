Return-Path: <netdev+bounces-135239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E499D15D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5208E2816F2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C551C3024;
	Mon, 14 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="n7SitMhT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F301BC063;
	Mon, 14 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918802; cv=fail; b=mBaYlkySOctar7QpsWnftN1mCgEF9Afh2Ti0T8mh3NLImMpEo2DzNCmAI0dntM22bhXOo//1rBFTxFI8zeoMTn4SPdetRPSw/RF31D8j2d9irNOKgTN9Pd35lLdf8iFm2TyePE5VkTDCGbTi27aRRGWju6o3rosnnW/NI4Bs4Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918802; c=relaxed/simple;
	bh=uNPSrxx5q1hUk1b0BLN0tuZRsSWwhgD7UivxKUuvSqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7wAAeclj5CM87bEw9qRUpEGONlelKkHRdwM9Dp/rtLcLmhUnSlaHTf/yosRYKSx1yjUI0jbwJvnp+mpRWmO8ghX/Hoo1N5qCCXdb0QQ68GXT5z89waIGR4Z6EvmhaXf80CA0DxuGY4oi04h+R2Y8NQjRGhPn6K1E7wu2vhX2Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=n7SitMhT; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEXFtL6IVU+uhN6WQpbiToe7llt6DNtNSYyTm/UVpoHhdEQf7EpJvtvG07JQ6mW9kJ1OgTkbgrSsKRgeVI+I+sE0rCK34b1G+4jjW6Fd+Y88XljZX2rgv29EKy1LhSxdLDRY6ZbEJVyoUhyw2CBcWIakfTHAE8B9G+qJO4gO5hqVaLJN6rBW6VE0o+UM3ZfpUd1Dvuvcz/xOwLJ8YD+4zL67FgYHUsPf6ClBf4kZ24cKZI1v9F+MNrUe8tOIQMeK4mNmf4FRuBjbKUlhAUujgYEc1rzYNAiQTtdPl9DSmbf3a8xhTlNOjMof16F5BoR9H9W7z+CoKxWPxJdR/QsmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Te0e1NWmEHgDBxg3djRHVGSiYFJFAJHD9djD61o7I=;
 b=hA6ZBo2ATIGutQcvo4WjOR+vmp5eLpPzOC0ncu2An8fkxl5Z7bD3uUo1aPF4AOaDi+1I288E2d2LbHEPBjmlkzUuWkH+QLpdeRgPPgwbVps7m25L0lo0YAMwhhgFClvTMJ6UvCqjB5vlnPBXvmZkK6R9oAMC1T+LSOr7NIpfPME2HmL4Z8z2JAN5KVHC7jAy6cAZaknMb1mB5QDG84C7pIltyNEAA1p2zUwxuDKhCoDNLsThIUzq8rszsXLuJ4Z+2dTMLo/S65GIrhdmgQkb1ChQ1Bju5WtA8j9p1Mbep2MVlalOyswobYmbB1N5AzAZqCK1UP9QvUOnBlr0JPNvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Te0e1NWmEHgDBxg3djRHVGSiYFJFAJHD9djD61o7I=;
 b=n7SitMhT4LpnVmmYm/s6POFzdnUwTJVJ1SESzuIlsT0z4WrBEGx7B07tQloENb+peONOQUxHkNLA7CkCiVeot2O4E3ohUVVvKP22gJdn6DX+UdhBALYSbLWCdfVt9X4qtw9Q7vq3s4zyBRsgtzYOZK9MsNIjQ8qR3PYm3GR9b4Tg6aBrx9cPXM7rYEz+yCyI95buOIbZApEstJWQ43vL6TmtKpnDx77plVSb2IADFDYm6CwSyIURbas5jTC2VgCPNbVlyOX0sFs/lWGYyqSn5BlYdJCNZ8UgnyWsT1MEXU3izVn8YOy7Cy9GBXcd0v+rkeMiQD543i99Q1yUKMHc2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:13 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:13 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 07/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6_mroute_setsockopt()
Date: Mon, 14 Oct 2024 17:05:53 +0200
Message-ID: <20241014151247.1902637-8-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 71892a0b-665d-4792-94e9-08dcec62b923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IARU/QbAQTIEwMNgdMOx0xRy+lhv/1qLzQnYc4nsLEMhi+BQnHMf95o2RbOD?=
 =?us-ascii?Q?MOLM+RH0LGrmrgGLYACE/EnM5uEpxk+dyZEj+gWu8OnSC5uOSiS8ibyuoj1z?=
 =?us-ascii?Q?qxpDy5DOvIaUtbKzyMTcu1lJvMaMK9uirk3hhmWoizBvjN0WAQgG6olgDQp2?=
 =?us-ascii?Q?OF0rAlCX0X9EJp6l3yWsljd1J4FJJAZ87IRaMq+x8x7GEXQXTmHBfaUFSqJ5?=
 =?us-ascii?Q?YB7BUmegF88MiVJgqAf+YYSNH+ZPY4RJnajJjUo6nSObLhze+4IzUooHCEw8?=
 =?us-ascii?Q?3JGWS3cYL09WNr8mGUmj2gcsYl/emZcNk5yREgF56NiStR6f+zfo7W5UGvr/?=
 =?us-ascii?Q?BWf8Gs+ZJsx53EnTJNCffweAA5GrdoA5bWhOC1XnEdSAWrt3rWBTFQQhDFBs?=
 =?us-ascii?Q?8qXLK42G/gpzswOZ0QaMqjKj9wU94rbVpyRvzJKpYfESrpWQaHioz9BHBJ55?=
 =?us-ascii?Q?NI6169a9ivGqrLnFHDllGp8HkriV4IJTZHvgrdBTuE+DXa52dVWfilzpPVHi?=
 =?us-ascii?Q?WxKxNByPfugUl2gJTelujF5pjcE0jLjx5TfmG3UWg8eP4lgJD6TLjIqaMhxa?=
 =?us-ascii?Q?wINdKxd0MwFZ1EpGaU96W6Wklt4Q4T9wWPbY0wBGZO6zXoYYdllbrZYzCPYI?=
 =?us-ascii?Q?w4QZ4p2HmnYASA8+9mneRiBtHZRgpX1xbTJ/HnPNs3B17pl79hl0G2G6vZtd?=
 =?us-ascii?Q?IvpMOLkcDQKpyfPio5s8fTjm7tO7DicIvsTLdDGlFRVvhGxKQDVfIAvC+LL/?=
 =?us-ascii?Q?wXoI+OysYWE+mTWjTu1IYA38syWRMaaXjq/ys8mgebh2AzPHc3KCGJ93gxwF?=
 =?us-ascii?Q?NlwJR2sklQRDxZHtw27pw6TJQoTn/tAhd0wed38dyCJwxwEiNan+yaQvlQQF?=
 =?us-ascii?Q?m0dv7335q2YpImNTEBPxaiRnISeACVGrhdqrPJXPIaOpkloYLvsITYgUJlbS?=
 =?us-ascii?Q?SEGgggOBtIaYk96nl8kkCFe9ZvCmcYdROkm3MB2MO0r56qaWsJGIGouVUZ2s?=
 =?us-ascii?Q?fHycNevyfSVsqVUvYk5ronsJ2xhVWdLof3G8yp3OwcZGinPzdY9e+L3FJBm0?=
 =?us-ascii?Q?FWNr3n3nn3WfjJASyvDGHPrR/rePbSY1mNzeAFBU3XCApmG/uKTI2zJlat0q?=
 =?us-ascii?Q?rMHEJRLzNAP+eP8Dcj03gcB8UEqsH309bFivtxwa0TbTDCkyDcp0x/SjEF3u?=
 =?us-ascii?Q?6olhv1+9JZ3/olzg1FG0BsiM3qlEd+rwB4vpcDpg+BFaA5LuIHL4k4GEPbio?=
 =?us-ascii?Q?WvclWSfJpe4k9D2JxhV5B3WukEyT5wtSqsEKyKDAc+8e/xW3e/NLvksKnETt?=
 =?us-ascii?Q?dcPBltSl4WiDdQluAx0mIfrKuwl/iCdijIA3XTVERs2gdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7kVcGY1C3S18/8dSOonqD38ufdF6iCJJcZJSRVl/Kej74gj9Gmq1Q3q8Erfx?=
 =?us-ascii?Q?rdH3pQ0aHz0x0XgUPqU36M9aCQ3Ze9ok9tAQRcqwjSoXGo94aU30OV86du9X?=
 =?us-ascii?Q?4fxjQl/ZSwwDFNrOmVGC4hMlVIxyFRXh9sc3EAApCk9V2Fb2gE4T/bFoE4Ia?=
 =?us-ascii?Q?O37vOBJIyGi0trmrRG1gy6OpsEWfABkVgSGdaAh1RhcPHde2XwMYi/NdC7JK?=
 =?us-ascii?Q?3w9qPszruYAJ3y+604aBwFDU8dZQ3LF5MdYpV7wKiiQwYohOJOgsVwm7qcXV?=
 =?us-ascii?Q?mjsUujhFPkFCQvDQpXZ5xbG75d8//haEazufDKmFUfIeACEcM6TvBeP106OD?=
 =?us-ascii?Q?3YeP/jMy4zDnB4GYd7nXIm8M3ZulUKhcfeMHLZKfQnM3Kf+zEC3JE79vhuoU?=
 =?us-ascii?Q?pjrMdVMd7UGerVei9z/SCcnBXm+EIxYAfGgC12sOuoeVoMIWwRZ8tbaV9fD0?=
 =?us-ascii?Q?UVB6IP7/CX9nwr0nAsehxlEB0QrC99SHuUzL2EM7kIQPjgOz/WcMiGH5k/l0?=
 =?us-ascii?Q?JK/gI5IdP5OirxUk9twdOJicoWKjma7QhQMKa6E71RngEGQ07+bRsZG90ooG?=
 =?us-ascii?Q?eOTfrN1i7JYhmH2oxuzkx796nvCnWHPFWNp4l1wlLtuHiqNbsu+a2VMcd602?=
 =?us-ascii?Q?yFeHsvSkCf64GzgI4dtUMkoXPAcFypOOEXiJBpVvkQbvd4L2y8mbrELfblyX?=
 =?us-ascii?Q?ntQjD18l3ZtjEeQrCvyw82kLF3XMvq5mtU+h6MU1TLFTTHbVBDJ4t9BvXLi2?=
 =?us-ascii?Q?O+yAXfo5krXrM5K5cHf6flmlfMpRMzCPGy83/Txsh8djnw1t7g/fxKMTx23e?=
 =?us-ascii?Q?TgM5HeIerki6Di1FttovjN1SHGG9NfEudYJ9IBP+nOD5dGButAbF8pXTXTDr?=
 =?us-ascii?Q?aQUt3rV/y/dRxPFCv5BAMFA+LN5vDYHIxtXz3Pz1poWR1Ndhitw4bPe/XZJV?=
 =?us-ascii?Q?Qg8z9s8PPFR4AcXTKXFFJ1cPapk4zydeRr5OSvSKODI4Ao/L4WRbH/Sbq//n?=
 =?us-ascii?Q?FmyF+L4cCp38BHi0nZd/Mv8VxCejN7mYtPqTsyGxl66gfug70ZxKFifd1hhC?=
 =?us-ascii?Q?w8mOrIGsXMVP7on+qRQflL91J1k0aLtYnouqqSt0MQkmfEK57WfgZY5xC1d8?=
 =?us-ascii?Q?t8/zAyDHefO2Ubt8Mrh8dOePL2fvsDLHXpmHKa2YCa0eT+mlw9ydhjnTsSKf?=
 =?us-ascii?Q?DfSQcCFi9GDsoRLO903Z4Y8/3Fqqts4j4h/m0zdRHxFf9oKEi+gQlMI5TnIP?=
 =?us-ascii?Q?Rej0cGbteL/m/zaBmfAr/u+zA2rhRaoeVI1s7S44Cw61RhuwsUvaEJacc4CY?=
 =?us-ascii?Q?9I4Q5u9YWHgdvZRTY2t+6kj3QQvzMKuMyUD9zjjsY7RGXMYjWYiFhCiHjxrb?=
 =?us-ascii?Q?C6o/taKizAVnkfkEpV+m6ca7OSF6E7xujkO1A/RLYaa32yPeAIlWPeVx2Du0?=
 =?us-ascii?Q?ncmbllDgQz+qZbMPfLsHBcSRK4FDYwTs7Q41fnVm4kJ0+5WnSa54wFmkcXDu?=
 =?us-ascii?Q?hZeP/rGw/LIr9i/waXxRZmgfLJCX06rtRTTQnS5RtI6sUkl+UJC1TjK3Ih1y?=
 =?us-ascii?Q?D1EilzWwr20JZ75T1FoTRrEaqat9pE1zOmU5YlPUf4jUFjkcBaS0IsK5LfAh?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71892a0b-665d-4792-94e9-08dcec62b923
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:13.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC/+M4gwNIRAjKkUS1+FA5fs6LyzNvY+LwQuPeBWMVDvVSgFa1l6hG1qqpDhSrZcfqazfz0mi0MTlH5yVtjJPIixpG3LyAg/cvNYaZQ1jI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index ecb9e86fe45a..b54353bee2f8 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1668,7 +1668,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	rcu_read_unlock();
 	if (!mrt)
 		return -ENOENT;
 
-- 
2.42.0


