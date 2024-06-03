Return-Path: <netdev+bounces-100139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0A8D7F3C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2041F23318
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFC85C66;
	Mon,  3 Jun 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9/0xdnk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393868595A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407734; cv=fail; b=lPbbqwLCRyHrIrNBfe7NJQw2QbkJqIGpwfJb6KuusjeqWq2uXRWcG2JRAc4oJY6eSbyGC9gUxOjlu0WNfS4iG4Q2epcZ5gbsotbszLZUx6xRi0jXlRlQyO88vfMliHn7KPDzB7xgnY5zXOlU6itfSKnaBcGcDwht4M5tlQ9IXac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407734; c=relaxed/simple;
	bh=I0vEK83CLygenKAQ34D0SE4wD2EdLCTfOOQ93GdJ/IY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BV1R2kUC3PktD/v1WKx1nQs7qLaE8W8ljX3343QHNT1ZhvzrRsAhXf3t90milqTaGnEcMJYSbyL9nQTk3UPtvD1PTbXluCLwDMqJ0lUOKe88CUZNOwG13p0H5U3Pob7bon+Y5rxVGfpv3oq4JVOJeUPBwGAmzF13hehTgkN9U7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9/0xdnk; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDHno6wvXefzKhd68c2w7ZUBrKdRSwgWC1FWR1LK8F/ecM2/mB2NoaS06/IPLQkXs9ZR5qFDBYLu87tgRyRa2ws4wYLi6ZrHxqU3/B8xP69mD2w9X9HEyQ13/uLFdeezOZhYJZ35LVLdjzY9wOKE/CiwFKbyerve+QbxYfComdLk9ZZlwQ6X5CJF+ZV4C7ycNbAwpudEtA/TKUpRIPKgHPnAF5Xo+cjtNW/sgkXKdEOpgjrw+ZPVn9qP7o3weZs84PQRNnvfTn7mufkKEfNYi/Q4SuPAWx8Ya/PIlPmRwCkdcoz984NNLFUgpti5fdy8t7wPoTUyXGtdluzikNHSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KrCbwi0Rw+NV2wcCOKhIM37+SLvug6UkHOwZLcFgX0=;
 b=RO7zGU4fdJ7uH1PgH7IbhL9dv/o7MMJ8DZf79ATSCiDYS/pZak8s/r0zScsv1l0WV/Dx8SV2g4Mn1reXMktzmyDEse3317FcIOq+OUN1JP+qp4BYqPx/GvLL04tPC5mWhI0JGuKoawhQIph6xyljeF6Vn1mxZfo/RqAUYjN6r5VReTgQfYG0yNngcjeHky9qEShG/0hpO4TBpLwwdceYcahGzJy7xA1/vc7m+H/tUEYpkkqJzJt61t9qzrcfTI90dhrvjXljXGizNYyNZWfk9nKtr7083NX5pvkREvFLAsDTSn9cxii4AfBRUX0gXlbUVy9DvchrMaiVa5q+3mpsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KrCbwi0Rw+NV2wcCOKhIM37+SLvug6UkHOwZLcFgX0=;
 b=a9/0xdnkOGfFFU1azJnjM9QErE/deuuFjme8ttKUut6AMY1Ly4MCncRvm/+4xeO7vLHsybSCJQVP4dAeOJIQgRzO5GqNLdEswrltV5qK5XzGx3Py00UetkJUTguHkOk/M7r7Ct+oFAX3hSKkcBfW8z4EtEI5+lk6KlQBeRhqTt9wSKs+srTodnx+2AN0JN/Xnjn7KS3QSd6uQl+5HJm3ww3u7CYeUKVeC2P9GzBj618Q553cvj66zSc6sekyviV01sUtArJ/qS2WTCkxfBgewPNd5kA5W6Fih/Rm9HWGdiD2bolS5Z+4Zr3+UE9E4jb1AQRTMmAoFBgTWOBZg9ywFQ==
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 09:42:09 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::9a) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 09:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 09:42:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:41:57 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:41:52 -0700
References: <20240529111844.13330-1-petrm@nvidia.com>
 <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
 <878qzr9qk6.fsf@nvidia.com>
 <a9a50b48-d85f-4465-a7b0-dec8b3f49281@blackwall.org>
 <4b67d969-b069-4e1a-9f09-f0308a25b03b@blackwall.org>
 <b4818488-a315-43bf-86bc-85cd6b854f0a@blackwall.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
Date: Mon, 3 Jun 2024 11:21:47 +0200
In-Reply-To: <b4818488-a315-43bf-86bc-85cd6b854f0a@blackwall.org>
Message-ID: <871q5e9xd0.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce74816-cc74-452d-1aa9-08dc83b1705a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjuUHHtxpGuj0oS3PkZBHPT7Ru9trIjWQ5hObkYkRZS5KCa6TehNfmfku8A0?=
 =?us-ascii?Q?MCJkNmCKTk7ogzQ0M+51iskTKI+C1k8PRHqRKgPVkKax/K5d5L2UzLoGWDFf?=
 =?us-ascii?Q?iQXVgWTYHuWNNqQj50BKcHcCHTZ1Vk4Ll4JiO3eHwX84hIr+jUEB0D7b/A8L?=
 =?us-ascii?Q?9nqFTzW24qdQGwGIp8Wi+YenIwanr/+aNhceSoZTYxBOFIp7l2at+wdpXLuc?=
 =?us-ascii?Q?vVu+VqQMwczlHYfsYjay9KUzqHqolU3wY2t0aJ+ZrYT0iLd0japXF6ITJNcw?=
 =?us-ascii?Q?F/9NnLJrp7rqyMKj5IoKbTPUm2o7qt3dzr4Vi4Y6WKNUmBnGLYqWf0fiojgL?=
 =?us-ascii?Q?U+caZ1xPgKIfwWbyndnkYO498aHd6Wv5PjMNqrS6jRQ+sm9FqxkcFy4TjimD?=
 =?us-ascii?Q?FmrNAFAq2U6850yY5m1jGu4UN/dEtzpVKiohYNZa77z5XaHNWHTl+x9d65y4?=
 =?us-ascii?Q?Ke6VTK8BKvMW9zUZl6oRDLHKSdeyfdQAf5y0wam4tvStKdWZZ1eysr5n2YU3?=
 =?us-ascii?Q?b6Os+P7RqNDvWrbMShApkZqAox9MV3Siv0nIQ2qJpLhZrpeAlhzvtSlCeUZf?=
 =?us-ascii?Q?BMti5MSj/DlWwJILMUFOn2aEQ9udmuHfvSufYefmnCrxNuHob0o8kGmNUz67?=
 =?us-ascii?Q?mERE6PSm407edpwerpAnkmGRla3wBRD4X71qDMxUPc4lAvihH1tNMKXUhn70?=
 =?us-ascii?Q?2bHQUmvT67ClU61zz/AfpHxquilN6qvUFRWqCZnBOQLasegC2BiF7yhbNlNy?=
 =?us-ascii?Q?tnvVNUr0esAZzA8rjqnFsYFEDB65vDAK84+vHmFlnQcsq7uz/HUr6xtlU0F4?=
 =?us-ascii?Q?UjOMK3bhp4hHYIj9Xxc+o4Efg15AmYCK8pdBfoq6uSDY8MZyuKv8qgQNymVp?=
 =?us-ascii?Q?PLjQ4BeQrPE8Bsa7D4GgpZTviQF6Zb28xdOOz9Hj7uVyQus5yZfJctzAalh2?=
 =?us-ascii?Q?4COW1TjfCkSRGkR1alDJCtgO6cKFZs1nMtZXJe/n6QRyub861iTQhKjYyZBb?=
 =?us-ascii?Q?ENNf4US37JYIHs0usOG4XNLnwSW8mP45g4d02SfHFgyaRHtIs3sSc3vEXivb?=
 =?us-ascii?Q?N1oDKU9OCuRECXjjHE9qQvTZO98JSLlZo6MiAy7qqwz2uZUCrNYHxtFJudGs?=
 =?us-ascii?Q?vouUPLZHaM7+oG92dWmIMU6UTtenvayg8re26UN7WwwG94sDPvlWhnDj3V04?=
 =?us-ascii?Q?tHD+FxIcGD4znEVAIlSlmKuINQmUurfx2JkoIjJx/nzy/Pf9BHUX0wLLKkpT?=
 =?us-ascii?Q?09bCzK2ExakuC7umCVK4lz29WqWLmBoOz+OyFm8w6ejLNCsYQo8t2Ej6Kr+a?=
 =?us-ascii?Q?oEPJt1VyChuYTpfeMu3pNXAmaJ2IayIppr7HDbMU0ZLJAt9mDtmNK6pksnEJ?=
 =?us-ascii?Q?CcGiLCM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:42:09.5608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce74816-cc74-452d-1aa9-08dc83b1705a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 5/30/24 21:07, Nikolay Aleksandrov wrote:
>> On 5/30/24 20:27, Nikolay Aleksandrov wrote:
>>> On 5/30/24 18:25, Petr Machata wrote:
>>>>
>>>> I kept the RCU stuff in because it makes it easy to precompute the
>>>> siphash key while allowing readers to access it lock-free. I could
>>>> inline it and guard with a seqlock instead, but that's a bit messier
>>>> code-wise. Or indeed construct in-situ, it's an atomic access plus like
>>>> four instructions or something like that.
>>>
>>> You can READ/WRITE_ONCE() the full 8 bytes every time so it's lock-free
>>> and consistent view of both values for observers. For fast-path it'll
>>> only be accessing one of the two values, so it's fine either way. You
>>> can use barriers to ensure latest value is seen by interested readers,
>>> but for most eventual consistency would be enough.
>> 
>> Actually aren't we interested only in user_seed in the external reader
>> case? We don't care what's in mp_seed, so this is much simpler.
>
> Oh, I misunderstood you, didn't I? :) Were you talking about
> constructing the siphash key in the fast-path above? If yes,
> then sure it's a few instructions but nothing conditional.

That's what I meant. I tried to be concise and went overboard.

> I don't think we need anything atomic in that case.

Hmm, right, no competing increments of any sort, so WRITE_ONCE in the
control path and READ_ONCE in fastpath should be enough.

Thanks for the feedback, I'll send v2 this week.

