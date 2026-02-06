Return-Path: <netdev+bounces-257577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFB0K7EGhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC73FFAA2
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7FA83004F28
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D33B8BBD;
	Fri,  6 Feb 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PltN2noJ"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D9346A0C;
	Fri,  6 Feb 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391213; cv=fail; b=gGsDfXTUIh++zS9pOBL92e9p42lvb4oFoJs58z9Dbce2w/lqOxQqturGkSDqTyDhyusXgOCf0EY7qVsEaLmdW1YIl7LkjOowTE1RobbhJK8VZBFlni+Tn5Yf90dw4l0EeaoE3/R61avmpELAkBEUA4xfTV4VnMwYPsoJmYZFxXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391213; c=relaxed/simple;
	bh=f2ImIQlgjemv/cyPq9Y2ZOAxcAiIYTqGSDYb5n9ALr8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OzSNBV3DMKkH1AiKCGwfqtxTVB6bXkudobNRK0DJ8VyS6dNwI5tZXGWGluXdbvLYeW51dKL8jsPWlw3ZPywHbG4A59h1sOd19Wh6xwWu9cWT4AGLIcXKFLXBYL3zRThVpOojV4CeSCP4Pky7maoHOKvpHQw5dpm1wTiu1in2dbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PltN2noJ; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWeVkx9Pg2UoHTfMr2aSC9jrN7wdrk0DNBIp8tuAU85J/GEb6XbZqg4rYs2PHh0imEUFfC9IhV2nY1zGr3UNrtjU+DRr4SwcUWAL/o4TQOn77pIh0RJW0hrSr3GCC9zxV/N4kFzLOrIG09gm+sTA/iXigdsZSoE8CM3kEDWoua5ad5klBtJy1oZgK4yLOoXXzu2tbn9Mzshi46zpAJizNyFGExF1a8rKIbncfsJ24jjlXgWqQPJS1GmnKFmoFJ4Y9xy37VtsOspyCgsI2nRr6gHLf8f+0GJ68O6B9tzYTeE3vqOpYQz3lf2zLxB//tZ6a+dlMd1WjN2tWT5ufVyR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2ImIQlgjemv/cyPq9Y2ZOAxcAiIYTqGSDYb5n9ALr8=;
 b=Lmyr/Vl+TiuPBj+ma4KIOFI3Gu/V1rDja+OS14DnuRJziS1gOkZ+CsW/qFR5jVAhG6u/JZUe6L/tv+Y5JKVky9ViNmHZvoVknT2WA5CubI0JHMdTBdsX92M9Np4BcPTa/34GI/8n1xnZFD24xsEfuZuO9azyewUgVFKZHA2CX7ndHcHkdQeCYhUJUtdHNxhQfluc/U3nT0wC0nipqGbqyYmbb82EhBPBtHl1JD2ittJN2Wf7LY0aTQqQm2qIyogbQMmEjdXnNGzKNC8aif763xQ6ZS/iskK1qVKbNBvhHQL2q85ef/fIE3FJZ4regrJgqwdD+3pb+9r1t4tSfiXbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2ImIQlgjemv/cyPq9Y2ZOAxcAiIYTqGSDYb5n9ALr8=;
 b=PltN2noJD7C8FO2X/N5BFM7qZFDHYe0xMH0UydaFez21i4z/CQgoUUNhgNmAqwOEO9qGkGKT0eHUFk0JZDv3yaBMnsuBbVzlTkA+k84a/diSPAjN0hTM99243N4vd7wIs7lEouQZqXxsd7aisNqRq0itBdM132fflKO5tN7TV1oxiG+LgBMJdcxRJYIh8ixv5m1uQs3y+l1jh9Cs5B4JwW/FbmQox0/9g6JRqAlKO1886gal0VHqRIHYw1/H2lyEF4AFa9lx66taHWn9buaMY9B9IuuyHu9KqLzgB7mvh4F+fdnNxNHidslcKxMAcr7RkqxusniR7Sn9Ny2MomNmRg==
Received: from BYAPR11CA0098.namprd11.prod.outlook.com (2603:10b6:a03:f4::39)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 15:20:09 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d3) by BYAPR11CA0098.outlook.office365.com
 (2603:10b6:a03:f4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 15:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:20:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:19:50 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:19:44 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
 <20260205220541.2992807-7-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 6/9] selftests: drv-net: gro: use SO_TXTIME to
 schedule packets together
Date: Fri, 6 Feb 2026 16:19:26 +0100
In-Reply-To: <20260205220541.2992807-7-kuba@kernel.org>
Message-ID: <878qd5292w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb51b15-98a8-450b-655a-08de6593370e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?88HiN1LBzhLMtZqX+Uu9posWtpprFv/42LxMo/W19LcEPccTct0MdHUBpg8S?=
 =?us-ascii?Q?1nE56Y3941DVhBpMxSIBlpy0mr+BHNvqV3WXgjsyb/1WV9dzgRPKowxrJUoT?=
 =?us-ascii?Q?bMSnj0wSdQ0R4cYYkWiF+XZNvyoKFHpn7zNXY+4FdSvIk54STS2zdfpcKLq4?=
 =?us-ascii?Q?sm5wOBBkN2moHFjY4qAmiDm8XqXD2ZqWE58jo0ZZ8ctajSDgGts/HGDowcbh?=
 =?us-ascii?Q?zhiEmiCGwjSLI7T/+xKqZ/em6iTzldr0SSx0mz4YWOuQaUivy+w+2Kch9DAm?=
 =?us-ascii?Q?Cf/K5a4U+rL6A+ES9aKtIytPcJsJ0543qArVhjp1SbE/RntObyM/uGarA1hN?=
 =?us-ascii?Q?oClp1kyOqQT5vCJ5mY5qIzhjFJzHHTGL/L76OmbJrA2/Rjxak6wOwR+IB3ja?=
 =?us-ascii?Q?2YpLLLZGnYPtamJ/uU++x7HG7hnhB0AGIoGPlh/oTCcGTpRyT/S86dJ4K2tZ?=
 =?us-ascii?Q?pGAXDvozhhUg1v/QOCW5v+CFSJwV4G70Bws7E+B33lVqPcs97bNagh45F4FY?=
 =?us-ascii?Q?vLW+I9zz8+ZdSyQO5lP6mH2Z90AZE2nepxCRQd9iCrhKq9QX/Wco9DZh5BJL?=
 =?us-ascii?Q?PpzIfVvvNWmQ+cIB547bMYA1yBUp9/76Nm9di+ipz26+0SNJDph+IfcrKxd0?=
 =?us-ascii?Q?+s8ptS2kMdEzzkOWgx2IWYxyZqjKBxtvBP5QazJqYiRhEJFJj743KZAcfK8u?=
 =?us-ascii?Q?c59Xex9UW9wbj7RqwyTllk2FYSFV1PVkSNG10BLlB8WU1F9o1m3fNcemLqLg?=
 =?us-ascii?Q?0KBAxHX8hIImeOMrDCP3ecK/5kuRWq8xHyDmiPHQqy4NO9NDN5tFzLgrY9BZ?=
 =?us-ascii?Q?gXzH6Oa10lxI5NsJ0t9v9gKF/nCHxxQDtRPw7PXdgftHojAWXwKIfbiuSm/P?=
 =?us-ascii?Q?h6oBu89Oa3Vv9LbYhSqoKl1S1bw5YhGmI0L+3s19blGNdt7WTb6Hm+J/H4x8?=
 =?us-ascii?Q?fvyfs+iSHr82ef08obBMN1851ISPrRf2acSnZuRAdOnTfMkJzgkjorFUBt2A?=
 =?us-ascii?Q?POZxCl9vJt7BVPJckXKi9YSVZDVQuIN7+z/wBroAGOnKfkwGZmKiGEC8xmIp?=
 =?us-ascii?Q?QPqNEy8bD0OpjQrRwinOcei7wqW5MYYZkHqDaUyeE/nszUlfSVrePw47AF+L?=
 =?us-ascii?Q?M+2lBt9tC7lYjiWnCkTnMjtJ9QSU8UFDPxwq+Jid+QMCE1xx+N83CuKHSamJ?=
 =?us-ascii?Q?9ep47J4mXLNX3bjj9AukDWSNWUcvMdvsIBj87w2DV3nCVIQuCebJuw3LmJWs?=
 =?us-ascii?Q?IBqXKFo4Qc1vO7AMP9T2AVyq8hP6Yo0zDIkmc0FoD1a2BXptLxnx/3B1YtPx?=
 =?us-ascii?Q?cSxT3pRJ4L8QOYvNVNccijErVyJtx4ueJaCH+JdAtEIkBrbi11QD9J4SMmVS?=
 =?us-ascii?Q?VX8pbBf8LnkeQcBuupGghj3NsaOTQ0oXVYswTlK5pBefc7knZPt+oH/iu5uu?=
 =?us-ascii?Q?1EbguTpaa+FwXjK0brihfP7PMA2P2+65HFj1H4kaN5GDejDbFnRphXBoduep?=
 =?us-ascii?Q?3c1relDOVeKZVJKg/e/nFE2B9IB119wKb0H6ARWxRnaIEq/6+nZEREru2Pto?=
 =?us-ascii?Q?EgNyR4T2vQ+zZsWXIkVjGPjxVEb5BN+rrbB2wmCCnxoS7uiAKurChr5JZBt3?=
 =?us-ascii?Q?xivslnIxkACqkcP+GSDlyuT7jP81wyl6125B2UZLPAxP1Vb2BdwrEooR+/b/?=
 =?us-ascii?Q?BWH4Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	juQwm2WZo/tEJf1QYWJwKn3j3LwqoX6vCF0yEITB5dmtmsCTNOnK0bH2ZxHLmDWTpxwEPdQgImmk1QgfYYqNvRNSUTnT3XBrLn4lcU8rk02rHAXe8ktJ4KJSjagMxR/1yZsNsCZWaR1ZwQvNyxLHfTcY0hffBU0mOOXVowjAmiXdghm1q9bjH5u9/NfPPqdgRbC8b50A8ZcNTm8U8IckaD+D1F/NQC0kID2vf64+2PbO4ErOj5G3dBSjh7+9gMHLfaGNRS2BcqQKYKYoQnnCqveP95D7jnJmoKhF+QDBOpZqLblhJPYVcRCo/yUfG7EjUGSkfG+46pxt+BH7ly/u7dUdy7uGRMcSoKSvMcOlGWyjcrepU6W41JlsR0bSs40/Cq1YAOunZzMsQdW+GylYsgXrn3Up4BVxCtpdf/iYexitO6KNSJoeyjrOAado2C8a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:20:09.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb51b15-98a8-450b-655a-08de6593370e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257577-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5DC73FFAA2
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> Longer packet sequence tests are quite flaky when the test is run
> over a real network. Try to avoid at least the jitter on the sender
> side by scheduling all the packets to be sent at once using SO_TXTIME.
> Use hardcoded tx time of 5msec in the future. In my test increasing
> this time past 2msec makes no difference so 5msec is plenty of margin.
> Since we now expect more output buffering make sure to raise SNDBUF.
>
> Experimenting with long sequences I see frequent failures when sending
> 200 packets, only 50-100 packets get coalesced. With this change
> up to 1000 packets get coalesced relatively reliably.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

