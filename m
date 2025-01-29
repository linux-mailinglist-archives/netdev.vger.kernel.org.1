Return-Path: <netdev+bounces-161466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC0A21B6F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02293A6580
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F091B85D1;
	Wed, 29 Jan 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lXflVJkF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17C1B4F0A
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148305; cv=fail; b=iXvlK3tZilw6wIuiNusbxn3zL9o779iwph6cvzhdtL0w1jbqv9UdAQwgfguWVaAr8xaspq8T/VIms5sJYw5br+a2oZpLyD+PUpPtkFzGqaHfgRr0uDHIpqa2RYrO7qmo4SpeGl0ytunYZfpjT+HTQ+RJkOwnkmmBuSi19i5rSEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148305; c=relaxed/simple;
	bh=dtwWJPpAsaM8ttVBEu+wLTb7tpkOQeKDhYD2LxiAbXA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RnL5rUmxNpGE6p7qVmtLiHQVw8W77wNov6KRzRPI3XwlLj65Z9UgmevxMwmQnWbZwirtjplTkGH5V8bxRFurIxd+jgNjJxIbBdmGQWZExQJF3bLz+rQ093rFSdbGCsRa+LaNxSOEJcRoJlTvxOk98kQfRTrFbbIrzj2RmEEPRd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lXflVJkF; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a49r8H1u5znJKfOr2gZGe7NIRxcjon9k29GWlPifiwQemjmPh8qFlQcycSMt6ATx2+rXTflkv0gKjhUygLxnhyyGytYs8iLAbbi7Kj2lqwkZw2kplvD0oZgoLSqVtQtZPWmCwtUb4tGCyzoenp3Dur8PotO2GNcfJGQz/m4/+yLLwnoI+kQuTc5RdemCvoDN26BvnHFKWNsSbDL9ieyj2r3ibXwBvc5RVNEUdssnbHSAf/PyYLHg8JQQRQsR4Eepr5YpeF6S1/XF89DV2o096QOb45HHteZ8y78moW5smtZmE0Cq+hfpi3ClxKNar6dpXNZaAGjUagNbtxEumXJZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc9qSDGJnaOEzFTGORVAkF7IGrOwuHgKVaQmQAn/sPI=;
 b=wOPwCsKEZvOOnQeAkVWudWa9k2cy2aAXPR6Z/+m36gIfr2HP90cYOruLuQV0PH3Wwo9QFCvkPXiBmle3wE9FqenRa2Xv2GdXt1LACyeYNxQ2tmwLPtHjXgHulrFN+8i0Buw+aIl6hzydluPLRU371u4K/gNPscUmFXjOP+VBsavrWNNq5Dj9By608Y5hvrShNYa+N5AdJoXZAcU8u4O6IT/nVIjSWbJXqviH6NClBRhiopeW3MDk5dcvqFRAQ5lL4Zyvstuonc+x9aVXn9pN87iZR2jEcXogpSQSbor2krNXciF3mFhLKt/cCymrGwy/TsNN+4jhgP2VEoZ2YlYyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc9qSDGJnaOEzFTGORVAkF7IGrOwuHgKVaQmQAn/sPI=;
 b=lXflVJkFfdBRDsEE7nFRP6numgO2ByarR7wAeiGKlq3LVW2jpQGGiySrXPTNGKuZAzi3qyRUL4khL0E3Z/oT2f5IuIIkbydtdv9pE9cAMXLedDFGb7L1JI1Rj1BS5rjeUDmhDNgQX4LRl1phfLc/H/LQNRPzESTxQ0LZEop8wuahkQ8ryubnNGPrte4LSB1VO0plwD6mjh8doIV9d6ofcwzfN8nIp9rfmY3RyBJ58YD/bPOqPazXYtiyMJ8KpmCbj2vkOklqzWxvEIaEBYMX6gNmLb9hOuU6lkFlOt2Xt4dHEb+1DmFEt3w6uy0gjQk2OepjBKh5hUL9s896lQb/mA==
Received: from SA9PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:6e::24)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:58:17 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::46) by SA9PR11CA0019.outlook.office365.com
 (2603:10b6:806:6e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 10:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 02:58:01 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 02:57:57 -0800
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"matt@traverse.com.au" <matt@traverse.com.au>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, Amit Cohen <amcohen@nvidia.com>, NBU-mlxsw
	<NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Date: Wed, 29 Jan 2025 11:44:26 +0100
In-Reply-To: <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
Message-ID: <87ed0lq43y.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cec8f7-01b9-499e-f1e7-08dd4053d5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwHCCMExuC7wee2T0FuMHc4LFbFbrrPgHwmPbH3bzBC5sgRMvwK4k/QSRXps?=
 =?us-ascii?Q?cX9Ay0pCNKmunRv4s6cphzumuae30pg9zVXxFbLo6aqaYNEvXkm9c2P3SLju?=
 =?us-ascii?Q?Evb5WLucUF6Yxl36gnI2TDDcBjPFG1J1WMjLgkVjesDHYRXNC2Zxd9yoZvEO?=
 =?us-ascii?Q?ERNcpwIdkkaUuD4bPd4Ug5jrSVLVY8NclKEsWwJxA3FdL73aFMArE8NQ/oKS?=
 =?us-ascii?Q?lVYbjaPX91XESBzIapnXD0/xGOVLTSMMESujaMqw/vG80veq+PEGOhzQyY8D?=
 =?us-ascii?Q?1LHJwSteG7eCcbpX1NEi7L+ViL+MwVS6GwbKF6fInmq8rVJLfIUKmYprAtwC?=
 =?us-ascii?Q?xDIHEkoLW9eHg/oD5RwkXecIxRD4v0iBt26qj/hVomxg9Gq9kd8xWW4QOoVb?=
 =?us-ascii?Q?4ERjxnz7c7xnZr6Q3iACr0RxJnulgovXSGv2ojShcmBUsk31Ej80AFNmz0Fh?=
 =?us-ascii?Q?59CbTTzJQmKJFwk1V37wiV3JMjuTWDTwVIQ9tHnBPg5f9NOFCQ0W7eFKbkIE?=
 =?us-ascii?Q?FQGstJbWl2EkXKM/1gdKXZP1OQObL+Vbey1TpNuPmjr/u336lohoc8+R9cFR?=
 =?us-ascii?Q?Y0Q9jtRb8/dpK5bhQg5E0qOat2PTy4TZ/PVVCljeTXnoondjtF2E6Rj34TdH?=
 =?us-ascii?Q?ic68C8Hv2ruIy+/p3bWbMlSrwq+GkmXeU6xXHfUObEEWgXOUvIMJErTDLU4i?=
 =?us-ascii?Q?58617zMXge6gzxyUPs7fZvrS6JCWgWVmCSGNz1OTHqlc9LqQLBrNEtsWhqrZ?=
 =?us-ascii?Q?JTT1UjYkDnqtHijHUInyeBGeq8M/XEN2FBtRbEdbIJHep6x24cAWyoJEcfXH?=
 =?us-ascii?Q?JaQR/ACwL5yV/BLHoc+zLFqSnN0bTeFFszJeMpPXzF+F6kJOzNEgBkQNINYf?=
 =?us-ascii?Q?OilF9u/vW9F7sQljtY+Z/C7y3pyY89X7f5mS/XklZv51nhdQ1xddCqIh0zVq?=
 =?us-ascii?Q?V8UQimDH7IQ1CM6GUpBhx6wwlQkVwStGmVRPldBJ0PsdzO2C77IofeL+7hmD?=
 =?us-ascii?Q?zk5jfQfM8F7kCux7cEwdkHgxzqz5AdCct97qmuu73LElzxU8MeN2iFSd9bLS?=
 =?us-ascii?Q?YaM7PfmmQYKciMj9ursH+oIMLybe/nAS2XxonLTFtjpUliHgn+3Dr9kFGaIZ?=
 =?us-ascii?Q?eFYS+RjrF8HBW5km/dJym+AjQIuymKVblk9R/LLQazgYoLgyPrwSYNQKGoy0?=
 =?us-ascii?Q?WO9mojc81LkRK2YUBhFWf8PBWzd+zfBSJfbwbuWznhrIG4pXIQuAz7/uAr9N?=
 =?us-ascii?Q?f9ygD2f3VN1oZhTSrhPTJFLrGnIzzQwtTMdMBVA94rYa4GbESBJVX9+LXc+d?=
 =?us-ascii?Q?L8HWiB2Py0QP1xAAC++EC2lpS5GTFyxYsB3nc2UFH5qemm2ELU8Nk2x3eyoQ?=
 =?us-ascii?Q?UGhWAAfQqpxLcXAm0d5OPwYIhjkG/P83TSjuhwckCj/Qse8TfVoYvqFpuvnF?=
 =?us-ascii?Q?ZRLVO0X065AG5Kuw6rOjMnlkXCgISefv+MerQejGNNZnfv7a6fgRvEz0hLLh?=
 =?us-ascii?Q?LTSjxs3cHOFw0RM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:58:17.1528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cec8f7-01b9-499e-f1e7-08dd4053d5fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278


Danielle Ratson <danieller@nvidia.com> writes:

> From: Jakub Kicinski <kuba@kernel.org>
>> 
>> On Sun, 26 Jan 2025 13:56:30 +0200 Danielle Ratson wrote:
>> > +		open_json_object("extended_identifier");
>> > +		print_int(PRINT_JSON, "value", "0x%02x",
>> > +			  map->page_00h[SFF8636_EXT_ID_OFFSET]);
>> 
>> Hm, why hex here?
>> Priority for JSON output is to make it easy to handle in code, rather than easy
>> to read. Hex strings need extra manual decoding, no?
>
> I kept the same convention as in the regular output.
>
> And as agreed in Daniel's design those hex fields remain hex fields and are followed by a description field.
>
> Do you think otherwise?  

Regular output is for human consumption, JSON is for machine
consumption. IMHO it makes sense to reasonably diverge and use the
"correct" JSON type where available, even if the human-readable output
is different. So numbers should IMHO be numbers, true / false, yes / no,
off / on etc. should probably be booleans, arrays should be arrays, etc.

