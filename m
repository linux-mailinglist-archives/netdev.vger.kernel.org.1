Return-Path: <netdev+bounces-263209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DxJBhrjpmnpYgAAu9opvQ
	(envelope-from <netdev+bounces-263209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:33:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 765FB1F04F4
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B74030848D1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA02405E7;
	Tue,  3 Mar 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgzo+OHi"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26829258EE0;
	Tue,  3 Mar 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544745; cv=fail; b=ES6xUsA/fDBFSpk0IxBBH+SYyFV1fHqrVv9YDK89Rfyh4Pr2oFNd1rsIOULQzVjKAEW4FdIOzaNHXReY/0z4XybEdo4weHUmQ3ZHoR0KhlWk0+Oh+70xixBSp/++6A7w9H3Fvwuaw1Z3Zzn8IfydFbwBW6zKCaiobGif8NJ6/0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544745; c=relaxed/simple;
	bh=YDADcnaSmSQXn8ztjSQGQgPTRUbAUGkcgHiHq7c/ipc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KxyLspGlDGFBHu8G/rPw3eliJmso27rYLeQMo4ybJYFZ4LhgYZ+C/8UN1tKvPvmRGLst0+s34olLb2q33imG4R0qRZ2jCEImkEPgq2nn6MgGPyjdSDnybHtsTaUrh9ZB7J2GOlX+PE1QsgFmjs32UH9vKkhc1DuiBu1wn0ccefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgzo+OHi; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLrk9VIIxC9Rdrw8rY+JBjHIfEkyi8wiXC8Zaf7N4EYQ0FWEKlCyG6KnQkEYnFsrN5YE4lHl/OgeSmVUs7i8POcOHNkfOePuAqv6ZSrcDjbOPNpeLs117CQx9/lLfsPpTpb/2kQmtHoERbArraGX0EL+yo5Eiqd1b1rzwosn9uufhtGAthxLOZC8cq1FSWTQ8yFIqtHe37vpOEsa8VwV7p3PObOiRaUwpkehBvvMLIr+QBv1x3w5cw6pVy1JtCnvm2UdWXNo8BjjZZPlHNaUBZ/GQRzAqkYh4dxzwk4e+5XBj8inxxEUbWQmt4+jTEXehMLgK7I9GtS8tj2l1r7qnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CNA2AfmFzYF7Eg+3PLhCO8ZT6Dy8qekV5duh3FlvWM=;
 b=xMl2EwrJY63qTeGm+akuKDV1x3gvN3tSkOoE/1h5dY4j0GAYfu6GHssvnox0OfkxBCKI7iGfFBs5ME+yzRusfKRlbUTQeLtmWxWAVa37JFwlvystC/Sqa1owkRkZ9hQu99770ZoRm7osBvjlWJ0B9jdMhj8pHSj13M8KhINcFcb1OTTddx9lf1O1e2+lDosgA5sTBwZRoleZhYYYyoPFAs3cehRQ+L+m3I1FZHInty64jqbHOcBGr0kGkhxX1svNwPU4sFm17NrphCT5M1ldzgNdqcl/eQUe0oRDObzxospQhKDVr7uwgjhIQE0r4N0M2Uk7dusCWRiqVUjAeKNahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CNA2AfmFzYF7Eg+3PLhCO8ZT6Dy8qekV5duh3FlvWM=;
 b=lgzo+OHiD9xjBarCYLIlsU2En1X7sUK/G4jzmcz90TuGZriM9rrjFKdPBbUjChSzt4Rh7qqItUqNzV0t7Ac05xfL1WCtbkPAgCkK/gU1gYXYnk9PJtQbIRKYGRspmYDK6UQ4L5oxxWqPuvnbC82OVmXsQNdUYC7b0z/6XzfpVxSFVke/hvVcg7R3lb+tBY262iN9NaSd4rSgIGX2mAtGs+nR8Efe6ET/3Zbx+bQEKGi6gKp+x4WV5Cz7NxJU8A1pBzLZCAwhajJGVuXeonf2k9M6l3IW+8rfn0rVMPkpYGBgvdTwxEziWyKi3QOHl92kwLUu9XB1ZCZC7rEOS1goXA==
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 13:32:19 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::4d) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 13:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 13:32:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 05:31:54 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 05:31:49 -0800
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <87fr6mf8gb.fsf@nvidia.com>
 <skvfdukic45r43yqw5wzzubqslrfdepcnghbspwvp7jtmjp2zx@6bqapqyjcpe7>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Date: Tue, 3 Mar 2026 14:30:15 +0100
In-Reply-To: <skvfdukic45r43yqw5wzzubqslrfdepcnghbspwvp7jtmjp2zx@6bqapqyjcpe7>
Message-ID: <87y0k9doou.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6730d6cb-9bac-4f4d-7c58-08de79294af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	v9k8tCF9VeOfflJ/K4q1yifCVEgiRlVV3VezksLenVVfbvfBqNiyp7HAZs3j531ovyuDi0jX2WwW/GlU60RPn7c680metY6kapfWT5yN6slCkvBothpnjr28ES1BovG1tBRA+5VO1HNQaMIMd1BgWDTPlxARyc5X3MzCizFhHKDFiUhllim763F+EtnFVm6j6bwSsT0ggILY8OaqWJl/8lxuvgRptzQ0E3Gfz2GNjdCbTARcNjhBwuJSRB8pGOrKrr++0v1ZD6yDDEb/B/BqewLhxTPUmoIOA1x38V5pKZ6ZFYqT2pSSDTfVzqc+6PnhCJtZuovNBe0pCoCGDDNkrqrtOtpQGQPqAD8s6fenJGyJvg9lar5Xzsb2xMMfMx9Ajqbsnx4oeL1z2dRDE8j37BONEJUMDYX+0YZoMV3kZ70yxAKrppQ2h1+2nw345RToCoBQ3x9bCnCXo7fVyhv78IDciewsjbBAD+SO37ePalTit0LCyDWLch9lRLTJPvDMx0IEZ+6tYtuCayz6Sd57XfgksJuR8am9q/t7sfEclmtyjbzqnn/hUlrkhCXGLMP+LRntOTBvuz6qJKaN2d9Va0gJ4QEPrS9EpKdRJWt8Fhit5fFd91abrUX3pRDNoGrHfeh3wCzjuZNCt4ebPOkJZqEobl94K9fJOybhaJCzIrB7LLnrY26P/XMP2oBkfjLhQew5KfQ+fKhKL4973nRO9Ml2MzGYkL3YWq4wCMflFyHw6it0LIVmtmWqwyVCWsVV4D0iPkQzQpOsTN9ShQOwY0m/GllmKmSEWqhnko7WuNc6t2fCB23Dgr/U6bGXt5lmWUeyhoH9Q5Ipm9WuN98Npw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1PwxtYphOmcbiGu/CK8cAebJgXQFcUFwZ6g0XGtZy1fI8Lo4+Zv4CordE9OzDplqDM4y7DPOECAh6KZPEhY2DqOYuUUdvUACyYRY1TFgC3FzdFvUXTNgCRiSiwreyr0s8SBY5hbaoAbHMLjmPTpQgDhVC4+KKvS7l+Z9QIIFgOzThN8kZa2FIlXTEoXXg2XsFCL4MUnmxe0CqGSfFDljHbrJcYtydBzpqEbISFDlTmXQXx88zqrqE0vugpsGFCuCCx7mo+rwStSkt8SAyCC56nvHhNiCEeApOBgcajbDp2Hkiafv7vbMeR3q34rpg1nV7h/dK8fb61b5dRPkzoLAIHG0S0OXRPmKKsEdPNWLBB4Io8iWmIByM0By7jFp4YDFcSgAbv77YPZW5x2YqNZ9XaGajca79jiV7B9KPxqMqDPXkm2nCyGOsL3CuOX6Tw5T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:32:19.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6730d6cb-9bac-4f4d-7c58-08de79294af8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
X-Rspamd-Queue-Id: 765FB1F04F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263209-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Fri, Feb 27, 2026 at 04:45:47PM +0100, Petr Machata wrote:
>> 
>> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>> 
>> > +	for i in "${!counters[@]}"; do
>> 
>> There should be a RET=0 here, so that the check_err below gets a clean slate.
>
> You want me to move the RET=0 from some lines below to here, right?

My bad, I missed that there is a RET=0 below. Keep it as it is.

