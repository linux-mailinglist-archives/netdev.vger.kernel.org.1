Return-Path: <netdev+bounces-139991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9E9B4F50
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4631428177A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49091D356C;
	Tue, 29 Oct 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ghUsIUbW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160C199EAD;
	Tue, 29 Oct 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219499; cv=fail; b=AwgoL2REHKybeekdq7kXnEuZAD44EOawTc59DluK51kj8riFFjOp/xNTf8Q9pMkvzqYRa+gzeyF8mG85AQfNBAxBt/nJvOfr2oNDfsZTRiQeDEn//66INWJK2U/cveulOrD+oZG1zZY1rmk6WjVvoWrl/mtdHGiX+8YtUGuf20c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219499; c=relaxed/simple;
	bh=qNgpOKqCmd1qmP4P+j3A5wr6wHSPd0HtciJ/9s9n3+w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BRbxgy980J9IfcnnwIwP4JfAzsfmhUcpxjAq02Br4qm5rbxZP79FZLW8iUstJkVSFEybXuDxQqqj1dwEIv/2bUfhCOZnWynUC4QS+0T3rcOHexwjo7O58pbByBw2xdAdkY7Msll4ELMfFXm54nOX1W10n3q28V0Yy9h0irbJxhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ghUsIUbW; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqmtNknw9jX1JDtxaxjDIqt3kEUwyQ+vtRysqdCorBkc/sd36YERzqByD4y2a2wVgLnhbnGk0KaRleLERpxyHMvmPJPMiYnRprn6f/JBpIkPbVjNkYA8clOGvh6Iki+yfGBNcpBF8smdZYD5eROXlgxfvpptmYwAUVfgj+ce1Ak/H8fa08FC3OSrHJi/xah8MGTA3a0p0R5d9IVWM5vy9Shxtu95CeMDkj7KuZFQQnfjlcMy8yVux4zzToaGtT4/r8Y8Xjo39N9e8ms6mRpERVDfqSVuLYrrFmYHRbLSWamRdX9Yed+Zz3s+e3ll5CbhWwIJdt+zuvtUL/zpGZ5Dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjB4Ch/Cad8OWIISs22V/yaCSO1WcXAZCu3R7vlETfY=;
 b=J27/y0TOyVKBFklFMRwupvHpOhor8AnRcnp907/rYhhTJKnygyAJhfe5Zmd0BGtnIMZxNAjP6goFkPoIkFZccJTro6AqHjJ5rlFq74vIo0JVNfG9Wk68WzKQDgXgP3JSpbeOKbCSQAQeusWsfPA9yNLtSYxdlSWPkc9Z/OrBBlLl7iw4yBIFg2qNg5tzXpbYIXO33si8Uqpf51CONQYzuwXXyTlbN6XCQKlfjO2JwGk9iS4n2B9HvhptenYqhci8UJTkzzyxrL3wo27+UxMh59usvU1mfA58G0luSpleYwDgZJgA30I+SHl3a2Jzh62OqrDEZLoeykTOzab9u3ZQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjB4Ch/Cad8OWIISs22V/yaCSO1WcXAZCu3R7vlETfY=;
 b=ghUsIUbWIE/8yZNRZMM6qfWOoR1GT9CXa7oK8vcKM/r5WPMlYm8UsUOfOidvs4vS5/SOe4Pk9sX383FhtiXLJ0MXm66GufgNtcE8EQPb7N8SpKoPrMGYyFdaR8vpHekpYfTJwpbnJhXBH7TZB2ejBhZlCMF6o3DtuxgpTu++oY3zjY1u+KW5B1lSOhYPiiPnonWYjb/4d7xz7JhlSguZlPAMvn6qyQhDGwwpgC5u/KhP+LOWC3HBtAwp+uXfrP1kqWBEwx6nCpK+l9CNCp8oURConuBvE2d9UJnGk46B//zta/FPUP1D7zDrXwbUQyd/muqbjWG8C0+SMJzCaLOKaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6791.eurprd04.prod.outlook.com (2603:10a6:20b:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:31:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:31:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	Radu Bulie <radu-andrei.bulie@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd tracepoint
Date: Tue, 29 Oct 2024 18:31:05 +0200
Message-Id: <20241029163105.44135-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: e11a0056-7d9f-4c9f-c9fb-08dcf837235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KuXckMEpku2gDh2YXNwkKVQZsdy8y0N152Sf5doMFC4P+WQyrWar3uocfFKE?=
 =?us-ascii?Q?6OoXifhRwmp7vMppwdEGeF5m6lyJcNSGCSyO6kUHzuIsBovf2aIUBmSFMg8+?=
 =?us-ascii?Q?vgfApjE/hSVXLxTcjI0vItHJl7xkwJQQClDh3+KE98vQVfRsLALTFUtRbJBP?=
 =?us-ascii?Q?Dvjrot6zckLUfyHlXy1ihHAeoz+5wP/AjPXMmGeCTOddWab7cojn4adEZ7JJ?=
 =?us-ascii?Q?qKUEmFLV/iHGTw3OTCv6fZcSkTb8KRHq4TRhEbTKVf/SLukaFIyr3PmiXD+f?=
 =?us-ascii?Q?ClRgpM7/8UGyE06sLybdQncd6oNP2+qtjBS9A6zFxcONNxep9qC38qpxhS8k?=
 =?us-ascii?Q?Kst5XYVgRWc8zfzELHPcw9mUKj117aafQ1SaOzpU72sXihlSRITJiWu7PDfU?=
 =?us-ascii?Q?HbOe0lLGHBUWefoJdLGkIZBYCFc4hTteSDyKNLJR8bVhh1fUNEI2J6h2h4N9?=
 =?us-ascii?Q?S12zQYDDk9pMXt4LDQe1UTNKQ8Rptg02JD2jBNKBtW2I2JfjDZF4aaAiKed0?=
 =?us-ascii?Q?gayQ/X6nxYIcPBrFxKbpXYvZ6fpEIkBOP19ko1CmcwuE9XZV97Kq+DQR8zPK?=
 =?us-ascii?Q?oFLOdsIyjLebAOTdtJyFoiYfL1U/4B0eksaQzf+JQ3ZP1SclKg3zdxWepvbI?=
 =?us-ascii?Q?VnYLQjm/Rxqf2a0zB0XHcx6j8WN5fw4RIc7u21r+Ue/gvxa3cT7Nvp1swP9k?=
 =?us-ascii?Q?6YGygKt40nwlkHuha1BEyMNM4hwCm5krE1+s09l2+T0ymjeoBqvIWH133253?=
 =?us-ascii?Q?CsWCj3Reds+HR6qgE8RZaptbQrpkSteJZp/IU/rJMSkkEbqTfGirL9pFCrxD?=
 =?us-ascii?Q?oJecIvaPrciKshWTLUEkkqxGDmEwuTW+W4YMAL/mVAX9Y237kaysOrp4uw6y?=
 =?us-ascii?Q?lUNiPkl3VXSfLlRhyJEIok++jRO8BtlJC7eb9Nta1b1zOkr+w244SEDryokZ?=
 =?us-ascii?Q?tA4ME0ErvhSAZyjbKe1Jeq6Ks/wmPs891u/21onZFGtCrRsR+rw4ZX5+hKq1?=
 =?us-ascii?Q?SrjfUBqamzXbA1oQbElW9qZ8bDSXG4Ux5kn77BGmlEdvWKxSBzYTcOC7ucQ1?=
 =?us-ascii?Q?R7KCmp/ZN3L6fk6FH31LnUCHj5/8iKpe+VLYpWbh+DrGwUa+OIrEg76x6Wsf?=
 =?us-ascii?Q?HuCWw/ub4WnRnr1sJEyGwfQdtmTOyDDbdjeJyHiSEIl5b7kKx+3kR8PmHDKW?=
 =?us-ascii?Q?/vpjuXW4cqkTBGn0+HHfzXayFF/H4njIvBZDgd5IciaZboKgISHW9apfbRjX?=
 =?us-ascii?Q?tFYtEsIg+Q1/CmKXHjfwmNT+B87rFezgqLH4u9u1ztFWjRk0QWSx9RBljezy?=
 =?us-ascii?Q?bnWZD48crdl9xii7JvqnJrVgvUPyosBdi+zETGsRmnxGCdyvA5Gp9BjV4hVg?=
 =?us-ascii?Q?7FspWYDx2RdaNyxtK9A8rfx+Sp93?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jpRBRxL8mCjqTJTBgzL+HyxtyLH9Wd0U1F5gVhd3o0tiqapRfv8mEalVnyD?=
 =?us-ascii?Q?hBz1xBJEx7K19ntgjFDo5xqNv7uTn3xXQsAFh3Pi7n+CAR+9sFg9Kpfld6pl?=
 =?us-ascii?Q?o06PWyGd397bcy941lnMgOBrNi2IwrV8PrwdF0riNAq2A56oZBh1wqtSKb4m?=
 =?us-ascii?Q?tn9Jt9BgBHIZqn7q+/dI4e9yxhyR93q7BHt0Vfks1mPQp06exuC8F2fXPjtE?=
 =?us-ascii?Q?AsDL3dT5o2DONY42u9S1z+XL5ozBMcNqrCAwvW9XRvlk56ktMaALvZAzbHGZ?=
 =?us-ascii?Q?iND+JtUxlNsv+byIvtVIzFibyEv2DOpK3GRV6hRVpeMxtjQGlgi8QHKgme6m?=
 =?us-ascii?Q?WIYaJeX3M2s+bynTO1DoK+ydoVhW0e/NTDe4CQs50zIsXDG3Qph9uJIHUFOI?=
 =?us-ascii?Q?fv20HIrsk1FU9q+4msOqiuh4oC/C3Rpbl/6R+MozdjfqIALxB2k5a+uyI0No?=
 =?us-ascii?Q?IgZGqV0sOSIyfPHcghK7GmDrbwxnKNoqIWW0ImiFgriHE03sSuMznfLW/Bdv?=
 =?us-ascii?Q?rwm8JD9Vj/I1KOLuIm9IbcgeTjTytiL+r5/rdLtwyYennNklyaupTA5EaSr5?=
 =?us-ascii?Q?q3XV55qKVaYFF/0oiPhdO7tas7waQjdqsEw0pd4EwHq2Dy8NB9Swc0nXGqfv?=
 =?us-ascii?Q?P0symhdUr4c3bQ9bWNdGa5fPdI3j5A8xkuWtj1GSD1oRrXy0bnSeJzKvczuQ?=
 =?us-ascii?Q?uieNPF5Ks3O+aXy1i73DeIJTPwoy5N0/EXUCIRtN3ymCmW7UipNoJyUMIZB8?=
 =?us-ascii?Q?JFTSjaOedsGcgVNWzfqpc1CvcDmQz6n8F5qmCjpgd5OhaubAFzPns/gSWLPL?=
 =?us-ascii?Q?NpDgGFx/vnzX0jJOFVTTt8DdFvaPll0ZLPjPkHtgpAgzWxcPpqq4na5dEsZO?=
 =?us-ascii?Q?jY/3t2fxhpQMf+Df0ucUO7wiID1eKbC+YB0er5RewMM1Oj8MnLtJeJQZS6iH?=
 =?us-ascii?Q?KByM3XEiZQ6Dd1sR9Y+R3CrNtSkbtq15y8gGxhMoMqfFKcChXnlUOqI3qORe?=
 =?us-ascii?Q?zaeZEjHJPiZIL/nitxuW2JGyH708+ehepoYIa5Js6fbjO9JxuGAOrJHEbjBL?=
 =?us-ascii?Q?0E2uXTTmnXT9bsYgIZ22QnWBUxebxqgkkTRy0uRhbRlqwxnUWQVnhbJa05sb?=
 =?us-ascii?Q?FluIXL8SeT849KeRj+kcAq9qougQADNQ/P2Syfu5y9pFNP7+maE1EckVQ1Ru?=
 =?us-ascii?Q?6UUO1aWyJLVeHFyN0/AKAwrRS7lShVFo7n2qME6fWjb5QhPjYK7mpaCzMwLN?=
 =?us-ascii?Q?HeR0tEu0w+6OFzFjBi+tMRXSiKqDgiiYrR3IFBXWQU8q/Yy/mtX0XkgzJkB8?=
 =?us-ascii?Q?Nz1Xt+0MUh27ar5zsojIeCwGdhnPykNojt/MT+t+x2Z58SU4l07LGmRAp1Ax?=
 =?us-ascii?Q?tpxnIDvhtD3TFDomPqCrd/hSd4HoISj1KBoy+FTNbmY6TTIC3rxeIxIBH0PT?=
 =?us-ascii?Q?7fNH1VyLEP3qcn2HdTp864nnoNy3r+hJVGiUtaDnD7S393PkZFmycCtNBeoB?=
 =?us-ascii?Q?PFCT3Cg2kVtn8me9u8bTovwATKDjLNHtaS1smHojby1exEcm+IWgOzdYooFO?=
 =?us-ascii?Q?o+IBet1MqpQ/49LDuAr78mEhfRuDYYpywFqhu+5PWsB1kSK/j02Xh13lBbAT?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11a0056-7d9f-4c9f-c9fb-08dcf837235f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:31:28.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8fSlAuYImo37C2NE1uRbRmFFVL2YQ4xqijlhfwW44C2mzXPMoAIw8OGSTm8uTkjVCW0lb3v9AC56Eh8w3DY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791

Sparse warns:

note: in included file (through ../include/trace/trace_events.h,
../include/trace/define_trace.h,
../drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h):
warning: incorrect type in assignment (different base types)
   expected unsigned int [usertype] fd_status
   got restricted __be32 const [usertype] status

We take struct qm_fd :: status, store it and print it as an u32,
though it is a big endian field. We should print the FD status in
CPU endianness for ease of debug and consistency between PowerPC and
Arm systems.

Though it is a not often used debug feature, it is best to treat it as
a bug and backport the format change to all supported stable kernels,
for consistency.

Fixes: eb11ddf36eb8 ("dpaa_eth: add trace points")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Context: https://lore.kernel.org/oe-kbuild-all/20241028-sticky-refined-lionfish-b06c0c@leitao/

 drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
index 6f0e58a2a58a..9e1d44ae92cc 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
@@ -56,7 +56,7 @@ DECLARE_EVENT_CLASS(dpaa_eth_fd,
 		__entry->fd_format = qm_fd_get_format(fd);
 		__entry->fd_offset = qm_fd_get_offset(fd);
 		__entry->fd_length = qm_fd_get_length(fd);
-		__entry->fd_status = fd->status;
+		__entry->fd_status = __be32_to_cpu(fd->status);
 		__assign_str(name);
 	),
 
-- 
2.34.1


