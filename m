Return-Path: <netdev+bounces-160594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC795A1A73F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13E53A0855
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E0211293;
	Thu, 23 Jan 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NmgjGhkY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2044.outbound.protection.outlook.com [40.92.59.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21220E707;
	Thu, 23 Jan 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647037; cv=fail; b=WaU4+xWP3kea7U5Ixlhqq6CnaU6W7HOwnc25wYnJ7W1O1E60FGthg5VQQCfltGqAKHD5jB4DNPPaevTZGq+EdGiaj9Dk9EuZYIgNvP6cPEsLbb6oNtpPN81XRvyqVVaXFlylH9JKfWsuQ6oddODQP78Fln7UDo21imApCQh8xDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647037; c=relaxed/simple;
	bh=XG1oyU4PRY+BkJcwrg4azJz3VQuhrHm5h8wdKM4Rxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dU4YdkE4q5j1nH0POr5YPK8WL72BzCFTNGkrqtbBI5IApWQ6qbMvP/UpKL4/ejfuOk2+bWsOKIJ1jPkFkT5eNe5d8bciBnmkgP5dJjh7OqqJxXRygON1nJPgrRnbAYlAjaUB35zyELg4dIJykah6Z0pwzOcXKIN/j9SnxdX3miY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NmgjGhkY; arc=fail smtp.client-ip=40.92.59.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6gGvUquTUPVYRFW/08pI5NRY8JNz/HoiPRPaljLWdA8+RAk0APZmM2CF9tEVxRTKb3rgZ1AZT2Gco8v4UE7jLTRJCmaGgUwzIU5+yViUuxAWr5q0hc1QFZvLwSxr3FhikGW1pIe6fXOeerJORJ7kM/LoTyW4g8yWTeMj9XxD61e0Lk7qY1QSv7TJz0ORUSd895ir5oj4Zh+XfsDWVufkCqbk1WTszjwLd5u8Dd3kvySh3aCT/dOpa96wiutzMEoypCiy6+0qg7PCG5IWer6I6KuXn6HNED/y6+7tBNKa5tljXbpUy7SXzJhros6OqMFdFgDbbZRXdfBceH4OazkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBuK1/IXmirmXsSwluy1LRaZ3ofOXOku1XktoENFiDc=;
 b=M6pw+rGt9D6hov0k1rYPdsEPvJt45Ld/r229fC/IY1ot9CAbx2xWuTVqzpB/wy1j1A9fBxPb5t7wJhBfNmNOsd3EF73ioPmdOnrTltIXUn/JZwJOloUu8bT1NjYruLM96P160ioznYoBWZQLGjoVQfMskz1nxFkhCOaNeL7BNVM52nFcdTQ8sbMXdJQMSS6xRdLt9wA3mjQg5BrVwcDVWywDLiF5MjcipISPJbsZq6WJXlaSPTCp6odM6/VbzwAqisnAk8PEt80D5/u/bnQbioH3Jzc/ZEJSNKiK0xwdfCfqbiBVcJHkYkfz8WCOQgWTT/GA2xrx7H2uEKnMt+BZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBuK1/IXmirmXsSwluy1LRaZ3ofOXOku1XktoENFiDc=;
 b=NmgjGhkYufIIBnPZg5MrDmkDDoBYwgaM6XDg14OI2ln5Oxx12tC1xNQ6+wxD/c/wKkXmOHBBEZMX0td6/c1mvgRPa76mLM/X+MgJ0VDM/cdX5YsP1EPpdaXYwxm3BvdXOYEZ8fS8MsllQZhGxzZv2LRmB47qX0QfJdmX0uydZTBB7b5tySGoAOV0Vr6G/st0T3x/vkOgkYsEnlLMZE2iyBkQApTepG93GtCjqs8PIkgqQ3nasUsG4AY2Ununi/hMJgvOVGKZLSYoiEQFcbzp8I99ZcNizXi46AYYLFNcA7vfKSwGT+xzWBjytwBWHaPGLfQO+D1nPemqebP4Qiz8TQ==
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36f::20)
 by PR3P250MB0129.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:174::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 15:43:53 +0000
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046]) by AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 15:43:53 +0000
Date: Thu, 23 Jan 2025 15:43:46 +0000
From: Milos Reljin <milos_reljin@outlook.com>
To: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: milos.reljin@rt-rk.com
Subject: [PATCH v2] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID:
 <AM8P250MB0124B5051DF9B54EC325644CE1E02@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:36f::20)
X-Microsoft-Original-Message-ID: <Z5Jjshz+34gJ4fXH@e9415978754d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P250MB0124:EE_|PR3P250MB0129:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f58454-257d-4aff-f3ff-08dd3bc4bd2b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|15080799006|461199028|37102599003|8060799006|5072599009|19110799003|6090799003|440099028|41001999003|3412199025|12071999003|21061999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wouRgY9+I43lk9kIrwuy3xER5SL1xkN0FW2XPcfl4ZxISX23Ft7qT/Kuo106?=
 =?us-ascii?Q?m1Ke56Hvogur9lQ164GAL3Xeq4YH4jHWYt/N+ntUGbIiiYT+g9dijZBixjKd?=
 =?us-ascii?Q?yz+5xs1wLJ7NzyX10NOrju6NBs0ULV/ZmQh6xZQIwl1l11mFmyBFGpu1krQK?=
 =?us-ascii?Q?PCX6i7rqi7BBy6GX5vH3RG1OR4DpsBQWAihYrIznQ3X0u4f2qHUA3WlzmSTk?=
 =?us-ascii?Q?+o7LiOQh0vo1axIhdD+rZldeW0zMFcK0Kn3or3/gdEXCwENwBjdflGJ1CUyH?=
 =?us-ascii?Q?LuIrb6AGd318Uol302shBtxIXQ4W54DvUkP7oaTBm//nb6OvRPXDYBA0rqT+?=
 =?us-ascii?Q?UoHbewVAKv68Ll+jK+1HgOqw4YIcXo+OkP321EKvv8HFfeEPyOxeHPmmy32Q?=
 =?us-ascii?Q?vnkrtmJyinscs/UMtaKftTEfwjpGl69+12E8lXDdJzHHvAxbHl83Vkbe2mow?=
 =?us-ascii?Q?HKyd/yZ82I4rVzAwhmBNLwEMRJEcjfuKKTYGkS7QfjowONeZoTbLWzn0+IPJ?=
 =?us-ascii?Q?XbuDPUqMWQXe8zhLyDHRHMk4XvC1w060qu718TrcaAs3CryagLYdeqF2yoE3?=
 =?us-ascii?Q?k+0RXblTkcsI6jVnN60QVXEXr8UeMOdXIYj/u+dtyov/B3lGQebYltdU8YQb?=
 =?us-ascii?Q?/IUIf9QQyepHUFunyKSn1pn7oWmvc4HBjK4mDmxeOTwdRNsW9a1bHJ5mr6lb?=
 =?us-ascii?Q?TVgMMtqDzALNPCJHnXR3V0IsZGlwr5w8foJI+56AeQg8HSzFQQbRt5zu3Mrd?=
 =?us-ascii?Q?7X9lxU1obdVp4NW/BFX1E9x/P/xUEF3YdKLxRcfT8hltCWy/kES6uU7RKQsV?=
 =?us-ascii?Q?k7BiUs/8XWJyowcaJu7fiLyv/3QMTqHNMC7dsl5pOOEJcLufwpWXl+3+j//S?=
 =?us-ascii?Q?AUJVUrdNb6w1nFyOGMb0dhr1B3OiemtNd6+QG0OyndAG6U2YqocjOpGE+3QJ?=
 =?us-ascii?Q?uaCYa4u7bT5Qzoe+6qIw4GzXcc81M1kHROKUvEveRv+rNiOZRGwFVaJCDjPd?=
 =?us-ascii?Q?QHFOCwmWQWy8/PQkuIaZPhJiey0vmYzJ6G28dL86F/k9Q4XqS+AqyX3LVAop?=
 =?us-ascii?Q?MFAygrQ8TL8DK9K31eqEbUVk1kNxfiNpxc0ifTR9Glvd1B0Bs0GQhCFwH07W?=
 =?us-ascii?Q?eZQFocFKyUdR/iU2wMcjP9oe+mt6mjsEq9Fsng+rFsADD8IEUKQ2Jhv7Wt8w?=
 =?us-ascii?Q?xTSuylyWg1/9+KPHqoksfjXENTzYTTdowT95pLbmBVQpC8Q7W2bN2X7uYbQ?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hxc8lOqGHj4bvq/rEXhqMygOl7irgTll9/vzTdVeyVNgdDfq3AWPaDdBzLFQ?=
 =?us-ascii?Q?vKDxFqYsAxmTvrFrDHwp1bhK5vAKz8iu3syGmVZg0BKB3IePCbLa/5IiADqe?=
 =?us-ascii?Q?W0fkAcNKTIMrTf72+a8rGPNDU63eQ77zUc9XvNOmpWfiqhKtBf2PhmpfYzvD?=
 =?us-ascii?Q?FncUkWsuudjYeQ9N4bEMpztJFPlotbGRyDLpOv8uvsy1eUkBuJ2sOK6TotCL?=
 =?us-ascii?Q?mE/FqpuNhtgEe2/86EgmRCmYdqsPCX3IQQrGVxEzPQDm3MgdXqLqIEvSj7Fe?=
 =?us-ascii?Q?nJOkq1mUbWUekvFQu6GbjA9bIJRPkD/L6WVpFu95O0n5E4pyTz2fXF7ouuJB?=
 =?us-ascii?Q?K+rmNb40RVSxqIR5gzHHHRNcvg2dMTT5yZ9OP0NsgXBDAc8//p2KbxgtgqPO?=
 =?us-ascii?Q?jlFTVRYEUvsoWTHpjHfhJajxWVCli2zgogxfxddDyYlgGps8XGve+LBGS14K?=
 =?us-ascii?Q?NtHQIAD59ovhtdNH5VOcNdgIGKrzWOk2eiKET9shbXmaEvdyK2aXsEof0vyq?=
 =?us-ascii?Q?oZEMSoc3drwswCp+te/vZV0RzJxTf/144cKVgaenbAeJofS5jfsJzN6NK4T3?=
 =?us-ascii?Q?JYL6PHuIittI3IIHvQ6b23kqsyV1N02Zoc6w1K+h6J7r7nyUtoCCo8PAQ6d/?=
 =?us-ascii?Q?kYH19I1YhOp3Ee9meSU3TvFM4J2yJMvAmb5UC31hXsNB4s0NlV5EOh467ABV?=
 =?us-ascii?Q?rtmzKiaPKfxD4QYAKxBXLtu9Wy0rCw6g3kVYAOla0ZkhSr4pWdQUgP6I6mps?=
 =?us-ascii?Q?jo1oyklcMVCRTAthWg+s7h5WWwbQ+9TWKdlGnuvfd4Y3KQW6F2zApOXLa31d?=
 =?us-ascii?Q?/aW+UOR8xUTGEilva3pL5a0SQAw/gOI5xR0SWBDJ7DTy3c0WamzgR0kDepPR?=
 =?us-ascii?Q?GDfX6C0EOJ2hBvrfhqCMRATcMD+yM2BI4haCT/gTNRw4UEW2ELtZ1nWFVX5Q?=
 =?us-ascii?Q?y4fNwaI/zRv43e7QQCgjKSBY+Jl83qjZ+pq2NCCsAWL1Dow3t4YDyf6IwO+1?=
 =?us-ascii?Q?eXkRG3+J67CStQQwt4PqXxYgSoXofrZQ2zfWqrk1gAFO9YUPAd/xhzZA2ty/?=
 =?us-ascii?Q?DBzfIjd65DCNpmlJT8D3weNFNDX9ppzUtkJY8pGpgpcNBgnVIaOxNDdJbH+6?=
 =?us-ascii?Q?E8fSwy/fLxegJjvnYoYTIqaZtvrPRSxBRW7nXyloyuDbRIKIlxsvpZulKuZX?=
 =?us-ascii?Q?UyEgKraJTOXAEUTMHYKP7DeFP28FjdDxmKfhzI37z4idB1ZRBwBFvVCZ1vce?=
 =?us-ascii?Q?F2SZxNUUl3Zm6pYLd52e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f58454-257d-4aff-f3ff-08dd3bc4bd2b
X-MS-Exchange-CrossTenant-AuthSource: AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:43:53.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P250MB0129

In application note (AN13663) for TJA1120, on page 30, there's a figure
with average PHY startup timing values following software reset.
The time it takes for SMI to become operational after software reset
ranges roughly from 500 us to 1500 us.

This commit adds 2000 us delay after MDIO write which triggers software
reset. Without this delay, soft_reset function returns an error and
prevents successful PHY init.

Signed-off-by: Milos Reljin <milos_reljin@outlook.com>
---
Changes in v2:
 - Updated commit message to clear up where the delay value comes from.
 - Delay added with usleep_range instead of changing sleep_before_read
   parameter of phy_read_mmd_poll_timeout to avoid excessive delay.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index ade544bc007d..872e582b7e83 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1297,6 +1297,8 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	usleep_range(2000, 2050);
+
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					 VEND1_DEVICE_CONTROL, ret,
 					 !(ret & DEVICE_CONTROL_RESET), 20000,
-- 
2.34.1


