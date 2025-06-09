Return-Path: <netdev+bounces-195713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED68CAD2093
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EC01684B9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193A2566D2;
	Mon,  9 Jun 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aFeZgd8F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D86210FB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478242; cv=fail; b=hcTpU4FZzHnuDkKobW/gPE0YC25sBPW/UnYMtIUNghdhx+B7GImIISnltI1lIIsKtL4qPLrM8L6WonzTBn1bMiiYv0r7Gv7mkxYHl5ImpOJBI6SvQKnVLzhLwkUgOZ59uwUbA1kSOzzHTS6AvYQZu96KkcKVF2JbkJJCFzclFxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478242; c=relaxed/simple;
	bh=zYl3K5CPUNUhtCEmqWVk9uGiOzq07Xfi3C2c8b7XzAo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jnq+yk3ttNr4f/EO8sRoLxDs20aP983uYqpRlrxPY00syGO3hauXVAHV4GikTvp3WXuDb/E+wFQRZvpu0IPJ7ybzzj+HEuvx6h8vgKf2glivJV7U34j3Wic2tNaoCV7WFEMz3WSbf9QYZdnhjExgrPayM4Aodnp6tAPlkvvYQGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aFeZgd8F; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfUg9V87J/Bi4+s4ksLuvnv+VttImlJ2Q1KQNQ1wGyD5pfvnsRmEySsFQ9r38wyYNVJKI5GEe5SSawniwDVBVjC3792iq73Za9YPqgliBY5OPOmfQgHxtywes5tah8y6VkONDKyCM6jMf19O5s3Ref6cqLybVPfVK5LFbhizi2FmuN5dSGsX6il893K+q+baOJBFVrOeP47EzvQtTWyIFcDeY9E74vFC71iumcUhVQbkntPN9EKhDy62Pp81SwlvoBZc8GFXGmawzJ1poq61nQmUHrWsohVXtifYWgd27+bLaVHvlbghogehmVMO55wqRPsh5iV1E06iotx0bgQM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhLsQYgpi69FOedHnruqaLAAe+lfMkr44d4MVTGc+b0=;
 b=IPmVSPLZ4WS0LVQ14q2PoIaucaG7ulTZmZQ9gouy2k8+SglUqrVnKJovP4yc5GNCnaF8BrPRPTTkhBpxOS5F/oaU88wMMFcAmKgQFVwV5l+RY7QQMZHY7Ftu6ms/Db8ZH965V7vfyEHWhOmI0Vpd8Ob04MNZ6q4iRhI1SsiB30VoMt2gswWb24h9/bvGjUdwWpTq9U0JKQU42nASXxAWesY+/Lfm0VzKrDzhVpJrDgfBcrmzPMLP1FBdJ48ggxByCNlOoe9VBsuRlOZ03UQD8uElbczjODYwbwEyua1JiFc++d56+LVuqNwDVGb7wuRpeUwAnINSMnEB5sQtMpmUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhLsQYgpi69FOedHnruqaLAAe+lfMkr44d4MVTGc+b0=;
 b=aFeZgd8FfosqjTqnWK4d6kFhVElAbQKzz33mEeusorFerEqli2V7EktLfmcjAoXX+NZkQmEzP3SojRJ9U4XdKbGkeKUk07brU99afQGmExd8hqJsFCyHr5I0Esm6+vgTeh4fFVOhwOl7OvSG9OReHm4HSbMOWFiRM8k8d0OKz9m66r4K/CRoMlSnGjgdqRGC29neTwvJulO/qcX0LsV03HHsvoDinc/OCRiZ/05lQxmAtZgqhbZ6tQbxVxyXm4SsKXU20btua46KDgZzGvOoAVyEYPJue+lvadyDADSH/ja61VghDBMeZm+GRKoc5DLDZ5I74JZFY86Ojy9mIAhCOQ==
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 14:10:38 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::dc) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.12 via Frontend Transport; Mon,
 9 Jun 2025 14:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:10:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:10:18 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:10:15 -0700
References: <cover.1749220201.git.petrm@nvidia.com>
 <fc317232104be45d52cc2827e90f01a0676441c1.1749220201.git.petrm@nvidia.com>
 <aEWc81vmd3kr57XP@shredder>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 1/4] ip: ipstats: Iterate all xstats
 attributes
Date: Mon, 9 Jun 2025 16:10:07 +0200
In-Reply-To: <aEWc81vmd3kr57XP@shredder>
Message-ID: <87a56hf1ks.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: b7aee5eb-a47a-4d1d-a616-08dda75f6914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8pHq8okq2Vt6kO/u9iGN/9FfSrlfhYFnxp2cB16Q+pT+OXrb5pDHLtuIV0ge?=
 =?us-ascii?Q?W/9aufFxaMRabRQW/9Wgnut0h1hllLTlgQmGI0vWUoxsBEEibYSWtPWcZAcX?=
 =?us-ascii?Q?z67BAvG4WYTBjhwWR6PzSwnERUhdbuYso1U4Ao8SF8aZtg5YEt/5KuTLddeY?=
 =?us-ascii?Q?5iGb0W8ZBf8wFUIgBN0aIf8DoZzRym0JXIj7xddVoQdzDM4aDTkkCQ3erMT4?=
 =?us-ascii?Q?242sgP6To/gXDk1ZO5bIlyhnm7X9QOohBh1wp2ShwCJshtXZ+xTToBw2YvI+?=
 =?us-ascii?Q?0/pgZl95fQSCuFhkjMt/66jHeNS1Y62cyvSjtXVqrP05t5+PYFUuBCq76j9l?=
 =?us-ascii?Q?xxW6rT3i78WwBbv5gZu5rLbb/P1CoaAinyzY4hPQ6Gex8kU9/2ini01NU21U?=
 =?us-ascii?Q?BPKic83Gyl2ym5nDdHvi1JmKTlztEAOS/kdLpLlI6/cooPqkRbQ/CCpMLmta?=
 =?us-ascii?Q?7C9xlOVQCMda1QY1cbtpTZrGM23I+78cley6FKVy2iUn4+wYOApqSxZnYtNE?=
 =?us-ascii?Q?hU/z7penrtXyVSwDs2hhxU1mQQW4sSoYOwLWw5NOdxTrzJNTvE3b0m+hXPsa?=
 =?us-ascii?Q?3pD4AxSU6hkrGt1h6EZ3WVEsesXO8fgdNDZPbB9bn00lOf892YOQFLSDOx/y?=
 =?us-ascii?Q?KBRdRXNj+OV48/RXhqN8TATcAwol3bit/SVVG1wi2X1haPPf8vEe2A6kus9r?=
 =?us-ascii?Q?ByqraMeK8skBbHLm9EKU5W6Zmh7US6hSaBWuxpd1nV5y92uPE1ajk/PfIAxu?=
 =?us-ascii?Q?VkPRIEapxiJlrK9YZO3tkkFj6JQcNW4HCVr43q6LY2YgO58EauSDw43lsmol?=
 =?us-ascii?Q?VpABsjnHsWsRXdY+BB/kBlT6tp4mLPE9IsTxPISBqchq1+MzMxttVkMHnyGQ?=
 =?us-ascii?Q?by/SVTzionxIaIAZAmkAd+UphJ1yPqsoQLru7vf5sH0iigaQq9KRi+Nh8319?=
 =?us-ascii?Q?y1zUQIetnOF8f/El49Si6ZFL3NkbDczmVhpRhAL+mqCquUZsfgdF11w7Tnd9?=
 =?us-ascii?Q?4BMwkcP76o58eCsV+aESgCjUzguj9mLKwAtxbfD+47fUmD0REpO6H7a7yR4n?=
 =?us-ascii?Q?RgXEGiSwPd5GBkqea/sQCR0QgsL7bS8ecuzf8U1KrgeYLA5CcXnJ3VRardgo?=
 =?us-ascii?Q?aght5wOLwWKglj/YlouVSaUxQx5IagNXWpbxIxcR7aSJVPxLtPOn07KLA+4B?=
 =?us-ascii?Q?6zdyuvh7SaOcJfaE24PaOfiNEmvZJBxuJoGIrDSh6u8ku5suZspVauwVd3f1?=
 =?us-ascii?Q?xDDvXr3gRJlYKeRBWFEFUyR08wkxiKpH57X4pt8ynOroVLVkUR3HkcWrDaZC?=
 =?us-ascii?Q?grh8sstxu8pZnegzWsL+UaPGcT3ndJnC0zzFWNS4z5LWook7LrFPf84gu9op?=
 =?us-ascii?Q?hoyd1OzoVk3raYaXZwrWFv5PiPWAZERkxIrag4F9JJ3mK15YQCv2+xdWFMSy?=
 =?us-ascii?Q?c04WTYyQCvjx90Qcv6TeeQ4PAZC9MlWRvycwG+3ugZUFgeK51ish8RUR6106?=
 =?us-ascii?Q?4hhDhExIUxeJW34AWx+nTx7PPbvHd4yzlrDv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:10:38.1672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aee5eb-a47a-4d1d-a616-08dda75f6914
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613


Ido Schimmel <idosch@nvidia.com> writes:

> On Fri, Jun 06, 2025 at 05:04:50PM +0200, Petr Machata wrote:
>> @@ -600,15 +601,14 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
>>  	if (at == NULL)
>>  		return err;
>>  
>> -	tb = alloca(sizeof(*tb) * (xdesc->inner_max + 1));
>> -	err = parse_rtattr_nested(tb, xdesc->inner_max, at);
>> -	if (err != 0)
>> -		return err;
>> -
>> -	if (tb[xdesc->inner_at] != NULL) {
>> -		print_nl();
>> -		xdesc->show_cb(tb[xdesc->inner_at]);
>> +	rem = RTA_PAYLOAD(at);
>> +	for (i = RTA_DATA(at); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
>
> Use rtattr_for_each_nested() ?

Better.

