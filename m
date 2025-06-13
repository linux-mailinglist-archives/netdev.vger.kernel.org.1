Return-Path: <netdev+bounces-197583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214AAD93EF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AD07A2172
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845132288D5;
	Fri, 13 Jun 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRZNaE74"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848C212D9D
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836895; cv=fail; b=rMDw3zR9mXe1bDRIBUt+xhoEYZwDEm+Aui+aqAKuKyQ/IrRK/P14plkAtiPI3OPqT/wnzJ3etsv3yRota4lEXiIl3q4TKpRam0Zm/5F27PsQli0z+bYDnWK8ehRkBGRT0bNWFoM0LYchIoGp8LxxUHw8mZhXdN8zt0RVSKhjwaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836895; c=relaxed/simple;
	bh=YVHB1GxaQTY4nvWw1DDcfY2QD3FE7eR2EBREyo0z9L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smfyZYE0NA7nAJJeFIKASlpYgAwjJlfEE56h7vBaePYIcKyXkdouKA4k/1BJWcCwMJopjr1yTGuQkqQpqO6OvzjC1WIYN8vqQYwQD2SaG3hvZPXB1deuEJabBUpsiXBnhCqaia5FZDr202lQH3O6tDLXFRKFwnpgxw8WdfA/UUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DRZNaE74; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbXWn+rA7LGa336MpL/u9iRIs1LuDc9PHixKk/WxYHSk6dYpm4hIDQTRdbSC1Fkcd0SNEIaJ8dHFp9PzdJ+vrz6u+OFIUEv+2Chy2rg/tsYZkwom3JSOycQj6XVg9zQb+mRkk159k+76mscniqBbVmANH8N5ybz7Tx4Vaw+aID6Nvf2E/lAh4iZGpAiBO6WN7WHyZ+BRXpQJqbU8/s+PKNQQ/m88LsL8u5yEBlVGvfRSEn4fLkVsQwHc4SQIgpfJSMsQdsOhCaCqbzvkEkePAPMR9cSCTUiBNW5K/DH3OF7+D/wBok0F35nGZ/m6xRXhArRvgGEnbnaNUeFtwbfYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HMQR7dPAcbqhtxoici4yYB+NV2/3GaSHuHMuhUS60g=;
 b=si+qHI8WBNQuW706SuKRe1FMuTcOP8LLBaC+AQRaVmAlNKAPKQrxN90ehvxInG7xG9MMdfrwMwsHDNtTVWddLm52B9KOXw+H/oiFJJEZuDIhBdj0OXg3Hjo9w/+RS898kBMYjWY4NfXLlkgY5p1Da4qzWvq4e8NC2JWuZfniBTQZoBL42e3G+hCB+DYNGjE2nkc4gF/+46zkNYmMoLEXsOl6rO2Kgyeol0Ielzy1iQw2IFoeM0KOFRXYQBV1Z1UIrjoYPD3JGOhRWmi5Wq/nAufaxN3n+zppSVVo2V1Gc1Yq48X/gMGd8572N+d0YQet0BcOH7Xxkt2EfcK0aoWlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HMQR7dPAcbqhtxoici4yYB+NV2/3GaSHuHMuhUS60g=;
 b=DRZNaE74YZT50/b5yA6n9VKl8MzzIrtY5+EBo7/jLTL0SzuDg2FBVPW2tIyZ9knArGZhPpQmXNC9/ex4ybWlTIalOIihbBGkOeYX+bniKImblQXkaQi3ibKuirIXRJS8EEtqwr62UY7oPPA0Ll9g7UCGH9ot3yphhjFglVJL1EGd84dbK5iGxcav/HgQBtrYcjkFq0mYipWnrMqKzFQZo9Fac+wWvySTRUDPlyGnXGOMaxIsApQEwoW3GdKmaUXgDlrdkRaqkLV2uYNaZg4tsCZd6tnfa2tqyyvkyrA7TwYN9bAgJh/CEFZ7RoRHZ8tZrkVHxjimYsDSMHYpEUvnjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 17:48:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:48:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeongjun Park <aha310510@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net 2/2] ptp: allow reading of currently dialed frequency to succeed on free-running clocks
Date: Fri, 13 Jun 2025 20:47:49 +0300
Message-ID: <20250613174749.406826-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613174749.406826-1-vladimir.oltean@nxp.com>
References: <20250613174749.406826-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8254f7a8-750b-4800-769d-08ddaaa27506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pP0+W+NaH1jKqfxaFbphW4m5HryE5m7TfunUfxI0csWuws9XVC8F6oMEr+xs?=
 =?us-ascii?Q?OQs2C8KFzDUD7NQSHh5wETwiE9wbbZtRMoKsVQYop46+xx+kmL6nEx5laBTD?=
 =?us-ascii?Q?V76ygUTlN7pqZpfm27yUjDd/D0yDFh4DSX5hs9mKDhf7qi5D+8AhOu+TPlCQ?=
 =?us-ascii?Q?7GY/wmSkaP8Y99IIbtaK+FZ9iNNfoS22hPYsfPNVHKtZXZdS7Xe/9sKUWWqA?=
 =?us-ascii?Q?XUsbSGuDAYkj5VCdN7PbSZZghsvoBuGUkHOeLSpAQJ+oGgFQVUqQA4FumnSR?=
 =?us-ascii?Q?6ddhbt+cBozNf8wpsA6NPT8QM+HdoukF4CrW5Ulzze0+Rb1HQFqSgkizr1K7?=
 =?us-ascii?Q?HjHkw8d/E0vTSM0xMdYq+vRITfwryT0h7/bUVHg0milx7vsSnQ1y1NY/nPh9?=
 =?us-ascii?Q?jxE7Ka19KUfIaSjTKa0NkmrP40p0bWXtj7f3VMLeovwfd5sl8SEjb51Xd0SS?=
 =?us-ascii?Q?rk4rzXfIb17TuLWKTN7m9A9PtSg+YBlwWAsKm2jIbHqElc1c2D4SLp8z3O+h?=
 =?us-ascii?Q?u6h/nyMLvgbkvNjDnZ0U+8C9aGgW5HStiD4G5igToOceh4FXfYcd3rkxhupg?=
 =?us-ascii?Q?ZUUEFugMklQJix4qFVKf/YRrw7zEIJJsMYqp9ILurgmVCcDrIdWhi2U0avTW?=
 =?us-ascii?Q?M49x5pgbjVp9ao2kuQsF4KP4r4sIL6scIzCrD0xt4nrJp7J3NIh7TJhE9PhN?=
 =?us-ascii?Q?Po1ISHG/HzC9XzgYbEMo6bn6vzGWSmqenK0gSquHAxWHn7cLQSD486yELQqV?=
 =?us-ascii?Q?gRqXexY3/SOt7UovpYiHrbUgCxzRMYV339O74gAsOgLj7PEb7B5OUnmkWAWs?=
 =?us-ascii?Q?8q++3Xl9mhYri+r2M/zQHJgoTQFG5x7jB/O6SbDCyO4DLxD4AqD2fxyPV14o?=
 =?us-ascii?Q?LHge6ueZ+jQZRO8VQbE85cURbZpgXRntxk3gx/ex36ToioSiYOpooeMv0e9R?=
 =?us-ascii?Q?T6IMXHiqL5TIXvjEueWl3NI0cwfYBq2gfqMeDQAWiiuE6Ug9ydFSDHw3WTRu?=
 =?us-ascii?Q?FJ7CwQetNltuxGrobw3mLPD+KQgKYUBHckPqW3xQgK9RXfO7TstxReoxTuoz?=
 =?us-ascii?Q?e2jy4I1TkWpSTOi3w32aUEduxmuc/Yt49t5GgMi6+WzNgi3aHAppX0kvZ+RO?=
 =?us-ascii?Q?GBlvPxo1t66OljQsVx7EQUHVwu23vCRjQzTXnIQ/bXLJTiMXUx9s9YoesVlY?=
 =?us-ascii?Q?fjZTFk2W35uD5rqY8ZAdqJmEL/cNKXNPQNxCv9802kwRLeBDiLdkhaJaermv?=
 =?us-ascii?Q?BlUsBYQqYOMDmsu6R6ixFH3RuN0QXxgC3NMuoedWIETOklvlm46c8T/9Wrya?=
 =?us-ascii?Q?WLk8d4vQ1+Q+9CrlbEdTO5q55LwuUPQObq1Y2iQ59lpMiTMjBa9Aos229NQq?=
 =?us-ascii?Q?d8sIAymS1iDoh9QAF8Dp6Kcin1dZ2n9RPuF0Q+LvwoNRgbAAydKXf857Cp6r?=
 =?us-ascii?Q?YeYmY6JOvSLgqGCuxUPu6Eg/c6tq9uMwt2QESTo0Znu99E2S7iG7Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvLjBGKpSHTSUO6v7sOIIr7IxAynfJzcNFvAB6BI1K4VpQEVkIdzwHyaSXfr?=
 =?us-ascii?Q?C+5WjjF70a6QW7MBXTg4WNs+rrXwec6sF9qocalqyFfiPorj50bR+YyS8/tJ?=
 =?us-ascii?Q?pgGYYnIRAgJikNN39XOsUW45LxPXh+4kHLAfxPfLdRYKPqkTPT7O82khsRmw?=
 =?us-ascii?Q?8RlWsXRjk4JOZu3jYGzsNWL7ftFslx0MhHKx0hzTq66NYjR2DmMOzEwNjv7c?=
 =?us-ascii?Q?KMvXH0FEX/YQCriFLAHN1xMtgFFuMw+fWPU6xcARqnIxZ6nbQ7z1A2gJzPFU?=
 =?us-ascii?Q?xjZ/76BcLJeGpdaiHaPqajNwPNWF9fbDrl/+X5gIFFTqvpin5pERtVCQKHNO?=
 =?us-ascii?Q?8Z1TNqLXGR6YqqDPiiA/6YIioftDvKGNKAMAM0XYrl9lF7kv//HNNgt1YeEg?=
 =?us-ascii?Q?/U2xs1L1EgwOAtNGZRfAJ7vYbMpKQWF+9xz2rGUCzDU5sHsKeVZebv37KI9Z?=
 =?us-ascii?Q?oTDnC4tJSm9d0oSdUFE19eUCfFeO0MLtDGRX9pLKnZYoZAhBkZcX2yYeIofP?=
 =?us-ascii?Q?Tt2DTr7aFo1VLglXV8IpqrsxMFTvmKhz5YOpnqjNEyylsSy45KMdaCNgF3DL?=
 =?us-ascii?Q?FpKZ6H/MDzBOdzTM5dlVZB1Xbd9NZIZ99dADT2+be6JTXLtCovyiKSkE8J8B?=
 =?us-ascii?Q?yGZ6sirQJxhjTVDXsQDCiqW1Va0xABjCkspRlV4WGRiX5FibgcuJ/d3Wx1Ug?=
 =?us-ascii?Q?lnZ1Q+GuWWuk4fo0SNZ1QhZpnokH2sygR2lOO+T1vW9AlT0lVmTfHWpaoU1v?=
 =?us-ascii?Q?X/7DoRox7ybs6oLLFcICNQZD7VZpD95LbUk3xws3x+T/1fAfC55Seb29/Kye?=
 =?us-ascii?Q?8E62gcgY6kWjWccfVG6VIgf39BOUB6nKiI324x5X2ukyx9406xDpBKm124/h?=
 =?us-ascii?Q?hk6DHsfncNB2tpEwUfqeMJ6y24+Ngi1hU8X6jr4T3e3IvTnk7DaNQUR4Fu7L?=
 =?us-ascii?Q?rhJABbOP69YBLTt5OrIY924p6BkCPYplxG3hQeIdBw3CYx9/Rggv/vSuoGJV?=
 =?us-ascii?Q?Eg5HA454tfdGiftEZ2EWpsxC1uV8R3Hc1TutM45pfKxlUk5OKyYoKQoqnE9O?=
 =?us-ascii?Q?zAucnJYkruejrUu0JefvbueYQQooRVMp4OWckucaOv6GBeJk5ZDXaM9EXdL2?=
 =?us-ascii?Q?vtSZuiD4WWBHslb7Qh5w1l5/Vd0rXDuiZ9d4RTqh05MbxaTL8VI1dZdH3YjS?=
 =?us-ascii?Q?feUUTaDEiOu7hGtEOgBJh9A2Kcpb54+OThl1LRUVUk7iqzTh7bPZeeezvTT1?=
 =?us-ascii?Q?s02c+5rJc43suHkP70+FxRqGfdOPbjQjU5ujebyay7MrXzdMcl9JkcGEKc53?=
 =?us-ascii?Q?R2RWc3cjKR98mIQwS4Aawlmenft/WfdDOELVRZydOB2eLQ0wFdA70UUT4NQ4?=
 =?us-ascii?Q?i+RA8nIa+DdscF5lkr2oTbDJJkO12+xGI1HZETnGg+6qJ/IJDWZrNg1CbpJo?=
 =?us-ascii?Q?2YdQK+oQA+rj+vlW1Uvk6eIjkojOWOOf+wPEut6rYS977o0oDWwhEEHg2xIU?=
 =?us-ascii?Q?qosJmwhBYAxLXmQ73Wxu5IQoOWWvQDx5lZUSm64t98+oEXzLaKCf4dHKT5RA?=
 =?us-ascii?Q?8d4/i4vMHZ6Izn5JtAQ2Xa3fSZsC7cH1xTQszSPhIz8Bo8mGtXdqgGtBiOG3?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8254f7a8-750b-4800-769d-08ddaaa27506
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:48:08.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pD4WH3vYtVvPtS2Djj2XhVVQECXVAxDrImaC1XLfMO45aw64NrAvorOMCbvYyAN5gmHGjjoE63EAccqiCSMCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694

There is a bug in ptp_clock_adjtime() which makes it refuse the
operation even if we just want to read the current clock dialed
frequency, not modify anything (tx->modes == 0). That should be possible
even if the clock is free-running. For context, the kernel UAPI is the
same for getting and setting the frequency of a POSIX clock.

For example, ptp4l errors out at clock_create() -> clockadj_get_freq()
-> clock_adjtime() time, when it should logically only have failed on
actual adjustments to the clock, aka if the clock was configured as
slave. But in master mode it should work.

This was discovered when examining the issue described in the previous
commit, where ptp_clock_freerun() returned true despite n_vclocks being
zero.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/ptp/ptp_clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 35a5994bf64f..36f57d7b4a66 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -121,7 +121,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	struct ptp_clock_info *ops;
 	int err = -EOPNOTSUPP;
 
-	if (ptp_clock_freerun(ptp)) {
+	if (tx->modes & (ADJ_SETOFFSET | ADJ_FREQUENCY | ADJ_OFFSET) &&
+	    ptp_clock_freerun(ptp)) {
 		pr_err("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
-- 
2.43.0


