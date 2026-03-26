Return-Path: <netdev+bounces-272238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC1bHxWYxWmK/wQAu9opvQ
	(envelope-from <netdev+bounces-272238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71933B765
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9349300C399
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF935E923;
	Thu, 26 Mar 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TN3eRmju"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BE32BF5C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557198; cv=fail; b=solEjmp1J4o6r55AmRt2u9+H5dVw4KalxHdp/lcaTludeHYqVUJ6Eh2S4UujCj+X8LVvfO2cvwA92SfYdbc1FbgKDcSXzAmHK/5RlCnSlKZ0SXiOnWYlq7W1BPcZ7rgSlRbPkZQ7Bl0w236NbLMmjYXThbyDSAuKovKg6D59buQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557198; c=relaxed/simple;
	bh=o092VBlp4thPqDCRdueSeYLX28KjMN9FnsqQKLXvso0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBZ/JxvS+VyYxDQGeK0YjQl5LV4tQoxi2MpfIlIjyI2iy6r0v8+LzrnDsOfGRSjSvJemGe5miJpl/cpDcF3x4JBo8HTHsaJfciXSievcBERuCJ88bbnp42lDSq5rQRv/oqrJUPLMgOcorxN0J8W/jFrNRfV8VRPerN+dNAL63Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TN3eRmju; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdZLQXpuwBOCPt/uO4/tuvHW0Md0aFkh3QbOqLO2/PxG5re35tEaJknNK3+MA1jt8drhO861i6q2py5nxriYH38wv8wplQh+rfMPqdQU5KmkFB+X3knWkRCdwcE1WnATCFNhnKEE/pV5j593r4ed7UmdUsKlz4xYWRZf/L2oCQsrei1e7cN2oOiBsOVYg0YSinkL4Md3mQyJKZLYtkswh/q9xJFWuMIyattr8oS86HLGJF97FhTGxglmBIxjbRq+7MqJqHM//wsuU1Klg67yJl7tv7uK4jxoYwpKZo0rgeIBPqySI+scySwDWA6zOtAy9nKyncf5JIo5vTtAEtElbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh2ug0NaKbWvGfRFpkJt/5fSmw98Dx5NlU70TI3Mr0U=;
 b=tLMQ3zxi1e05Dsx33qKTeA+RMyoxSJ56kWhR3v4GRt5L7JHEaeyPdlwkttBQ9QX7eiB10LoJqghjzFWkxY6ULwfYjJv+8CNru+fCTyY8HU5OlbtSd/aHhJgF5qYTrBieYVAmk9TldnnBZT/kEh+89O2oFXQmtqw7BGNupfAmMJC2EVLGpB5ivW2ATeY1wVCUlM6GPcsPS5ys6PX5IaHcHZRHk4gC6uxupwbFdWFgpXmWr+p1vOx8LLvpKYB0JJzjdX78XuNmZkK25ucqFtgLbPAhW+2fSI0FwxJ4O2cisqNrVT4I/ifXpFMmJW0TOBGi6nq2u8GGc+etc9rSD9yZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh2ug0NaKbWvGfRFpkJt/5fSmw98Dx5NlU70TI3Mr0U=;
 b=TN3eRmjucUCe0zc0Yhh/HKHjVX9ngUE/QAzYjJ6L+ejWRIQyVyxL06zFs2hx8du8bl2KaTqkjWa33OJQWv1xX6sB9d2Drj1Rm7oBYbq1lBK3MrRe4ID+ZfjmdBb9hVfW34EcS2IkDH2+ZwXHkHKruPAtWadPAvqVCIo2CJ7lTROUZjzpn9ISgJJEkLkZ6zdHXI8DVhnpYr4a897U2EBVBvYE6EdAjFfccBEHiJf9svZa7pjBKsQdmg0wFOupB5Jv1WrdONVj1i7xf6XMOQ1bZZuDpjjoSeufGUnvCFtF5B5lNkfILXpwtD0NAnd5mkTqDc1rnX4A/smfkLkxTlbCig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 20:33:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 20:33:10 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/3] vrf: Use dst_dev_put() instead of using loopback device
Date: Thu, 26 Mar 2026 22:32:32 +0200
Message-ID: <20260326203233.1128554-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326203233.1128554-1-idosch@nvidia.com>
References: <20260326203233.1128554-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d890c1e-d289-446d-b774-08de8b76e531
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iVSeiXCvya/rxoig11pt244RLYAxhIo5G/GjJQ8xIvYxCL09Q88YdKS8vyMBKw8fyWdRDy+foYOBOPV9Rlkh1yYqYd7tMpPNl1S0+7QJjKM9snIfyhS7i4g8vuIHrr1TH+UTGH2U47wmhXXKbJ9o/nq8LQNvSSxD2N0Ni+nCki5zczlqNZQy2XvSi3vGNUgE1qeun8Qiu9NBaOeodSSYN+3PdVh1LgK9Q8NPEwVp53JS9hl0az4T6e6xYyXG2GdnOpfBC2elwN2LZ1QJnjljDufYJIpEEcx59RgJcOPoWAhZmO0S72Y5jX2TlGwi3VOCuXle0WdgqAMFYw5pkGUS9kWtXQPH+zEl4II0rvomKg+s4bTWc0TraLfLCmuP9i4NLumVVk0TgUSydC2nLprJP0fxiHlL2FzMRwR3fJkORqIQdZwX9IjKk80qc4aSLfAfqomsYiBVjQY5cug4cRTijjjfifD2uFYgnu7Y+OxyDHvZDrA5Nt0PJmLr5838xoVgnsUJTDe64f4xqRK8gjS6+rPyS6uMIMFk5ZgHLChrcjfK2bhAUrs8QgQX5990u1gBkEcC51jUMEeFQatDx09YgZmJmS804D3w0a1sVRd2TSw5TS8kkdcGvZiauCGdx72PbijGKQbgY6qfseTtfJJtf4pcZzsVpDo+K64hMLJX2Phd5Mcc3spTwPx8no4DplzU/kzGC9URBgLOtdSSa7dUB4mWhwr0RF6UFodJM9PIZ/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cfYj57JLJ9Gdok5qiuXOoyqy9hThiydVrogqy1ODVwDo0QMN4doCzVBAaDUR?=
 =?us-ascii?Q?81Va5L2gTaO26nAc1xiIdgBzWDX0P/GeV/esQaoufcCqXX/wJLJUFvvPshP/?=
 =?us-ascii?Q?1U1K81e+yRHYefW2+kmcBDgvJIWXxkjyyw58DsBWdK2PRqGIa9lzsk7ucj18?=
 =?us-ascii?Q?FKrgV1NEw7TYXb7CK/eL8HDcet/geYp7ZZa6LvMpV+irSfcH8zMp9tejeJ13?=
 =?us-ascii?Q?n43QbOMgBSoSBb3QBih2Ng24/huJU9ikYMt+YOVWXQl/g2MslWhK9PGtk/K8?=
 =?us-ascii?Q?laKFOxckqmpzWAjgJalok8VIfJmcbq/MdbwCxJHgjZQsU1JqKiJlUYWuEG4E?=
 =?us-ascii?Q?zDctJpXe03aCauVBoi18m6qBYxP2PI7jY48EJX1mONbCl7hNtNI7fAW2YQjv?=
 =?us-ascii?Q?3f4EYYjCqXC7BnQP/FJ08L3xLEa5E+OxwbWAxQTAUhkAiL35aZYsig9gSHsi?=
 =?us-ascii?Q?xIZ/z90XU8MMnA1YpUJDfxQkbvDMAlXCRKOOEvmMDpt+NFGK3CKL9zidrM+r?=
 =?us-ascii?Q?F58MBby5fGWS4aO3pL8x3Zha4N7qS+E5rA9YIGj4iMaCaqVZcUC2WiiDdJ3B?=
 =?us-ascii?Q?ADrH31iL95kGUlukg+jrGIzyS3w6ReZdrLUHoK9i9lNCD6pBclJ4vItqPW+v?=
 =?us-ascii?Q?LFy8Gf0BiqeZKaj8jsefDbqeX2Udza6jX1cTl/W6w4FrtJnOpfAVeeycxaQr?=
 =?us-ascii?Q?s19zPKHFxEgBtvrUD4VWK1ZfnsMO/2VZC3R+MUBjnNk7YtE2EEXikpLxQxLa?=
 =?us-ascii?Q?+LQOp40eaEwhvHGfoZy9Mf3gRQa4PirZIK88Q5I0FaOM9faYKtq/inLg4ui6?=
 =?us-ascii?Q?EdANiHthd0aLcKwel7Ej/NFqbAPyVA+yuyy8z8CPtMosVY9Swbsjf1iwdgG8?=
 =?us-ascii?Q?BZaJn/cs9B6G/dAqi89N9wZ5ktXCXI37XA7BZQJvZimywDhmsS311zyM3ksA?=
 =?us-ascii?Q?EXAkG1wYUocxIcu9y0FESoMRkkAyBVgGnCUO5g1YvAhnfCZGcJuyg6nuW1tP?=
 =?us-ascii?Q?bwohNB5DlAza+lpd7fIu+9mGfAvaAYmMb1x/XHKsBAb105SIkie0Z31Ztnrq?=
 =?us-ascii?Q?jVTtCh2tD2pw53T2KfnH86pasbDrXpgVa0777f4fRZTLoqJ0O5+ktdXyPGqt?=
 =?us-ascii?Q?U+yEXqhFikD4m3TLTKLehSy2HIqCnTc8D0TqgkzkwxUB9uLl2fRoNva67w5C?=
 =?us-ascii?Q?cBGZFSt4jrj1MI3WO367J60zGaWbRywXpLh7tQ6jiJ5iSAaEQnOmDHzwBUve?=
 =?us-ascii?Q?JbLFgLFShQkfLCl08FozvnEVHyCMj7CFM6VvE/skjB1YXubxKvNm/2dBcWQC?=
 =?us-ascii?Q?dddwlteau8UlV1D+dDdoCbuVJM4JoZ+oMJscHF5FCC42tW/wc6APASZNfq/C?=
 =?us-ascii?Q?6Tpv7DjlcjJd2/7z3Xhwu90mJNrDVnaM+T9xWQh/V7ZMXXqvE+bswfgcxC8e?=
 =?us-ascii?Q?+KcvCpD095f41+B3iY12ZfCPTFPjL2FCADaqPN3FXvG1kM0nOZxO2AJdlO9X?=
 =?us-ascii?Q?R0Out5yg5tnUSaHel0vRYAu13UDEB8E+0tYWXr3AZcOtZrMFljDG8nm79AeF?=
 =?us-ascii?Q?adQq+ZPW0Rgpll8rZmlJ36qpr4oz6VSgxECGgBhCuEBXDPWYhVQh0YaGPjiZ?=
 =?us-ascii?Q?wLwyWu9Q3/lGiit7F5M9rZIWtdqt1JnwdbrzcjBfmjtPBSPplvUlsiTEK+dS?=
 =?us-ascii?Q?F5u/XUv/7OFgr6GKAsBa4tEbsbyQb2+yMsJyFtoQTZOUF8kCShM2/MngXcK4?=
 =?us-ascii?Q?8HPwOzyadg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d890c1e-d289-446d-b774-08de8b76e531
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:33:10.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LN1OYwJqdOxWeggVQqPp/8ExOLUi+5zgNyxRGnyBQ1/r9D0xjHd4fWoXLL5aIFX3D3k2pe4nvbP6/X6TXur/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272238-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB71933B765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use dst_dev_put() to clean up the device referenced by the dst entry
instead of partially open coding it. Internally, the helper uses the
blackhole device instead of the loopback device.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 0952ab6a2571..bfc9ea91ac20 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -751,21 +751,13 @@ static struct sk_buff *vrf_ip6_out(struct net_device *vrf_dev,
 static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 {
 	struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
-	struct net *net = dev_net(dev);
-	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rt6, NULL);
 	synchronize_rcu();
 
-	/* move dev in dst's to loopback so this VRF device can be deleted
-	 * - based on dst_ifdown
-	 */
 	if (rt6) {
-		dst = &rt6->dst;
-		netdev_ref_replace(dst->dev, net->loopback_dev,
-				   &dst->dev_tracker, GFP_KERNEL);
-		dst->dev = net->loopback_dev;
-		dst_release(dst);
+		dst_dev_put(&rt6->dst);
+		dst_release(&rt6->dst);
 	}
 }
 
@@ -998,20 +990,12 @@ static struct sk_buff *vrf_l3_out(struct net_device *vrf_dev,
 static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 {
 	struct rtable *rth = rtnl_dereference(vrf->rth);
-	struct net *net = dev_net(dev);
-	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rth, NULL);
 	synchronize_rcu();
 
-	/* move dev in dst's to loopback so this VRF device can be deleted
-	 * - based on dst_ifdown
-	 */
-	dst = &rth->dst;
-	netdev_ref_replace(dst->dev, net->loopback_dev,
-			   &dst->dev_tracker, GFP_KERNEL);
-	dst->dev = net->loopback_dev;
-	dst_release(dst);
+	dst_dev_put(&rth->dst);
+	dst_release(&rth->dst);
 }
 
 static int vrf_rtable_create(struct net_device *dev)
-- 
2.53.0


