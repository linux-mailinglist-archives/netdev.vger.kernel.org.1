Return-Path: <netdev+bounces-84116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F230895A45
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEDB1F211CB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA214B06C;
	Tue,  2 Apr 2024 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVswYCWW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE42AD1E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076951; cv=fail; b=YMpLXzn9Mqxr9TCuP0A6yE5N79DA8z+uS2FpeqER1AdxjdUy2JY0stYhMmWVVXbowHeMbRqz2R7pFsrKgZhGeJkkFMuJB/rnjnnuKp7t6zf63Z1CU9C3ZFE1sQFsSc0HMwFNdDot68BtYblXuuhBnEj7gEkl8bhr47GbS7OzfbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076951; c=relaxed/simple;
	bh=tzIxm237vBmo08MNPa0VX4IxFd45HrPHZXguTh1wtY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1RIklGC3PVMqpCx5ooRLNJkPcQOob0m+RidkaIZQ/GJKT2BoItDjDle6lvxJe9lUk5zj7FI+oI+3nYVZp0NgT4XRWQTKpBTb8cS/fKBeNtBY0VZ2zh0F/eZQr5akjFJxPolorm2FUZ3th6orRmEljz3uziWgHaVKfbv5ThZq+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVswYCWW; arc=fail smtp.client-ip=40.107.220.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvAPMUcX136HSZo6NAyOV8kZLAxh7OaMYCOLLQbvOss3qDonBa8T3gaAqOeYxVDR8Qfg0lTEheit905Qpn+kMR2gK7vkBaJE2eGtOQ//kFC8S2gYpPI/WTVrTf2fXWn4V7n05N9/OaQmbASiVHY3wsCBlQKn9Qe+MwAZ+clSwPXtqcrSE6M1RiVFm3ycph7G3DqGGjL++KkJYhwA0vzsU+GXFL/kMavr1ELke5Oq49Mwnp2nRybX7unTTRqHqSliohJwZOXDhjoKFDq7BNxpdP/+ZExv0q19euYS5C/Ry/fAr847kNYhG4u2dF/q8HFSlnHr+vqLIdbdscqtipOkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzIxm237vBmo08MNPa0VX4IxFd45HrPHZXguTh1wtY4=;
 b=BCwHaCTqX1wnanzyK7VXkoa28bAAU6r6AswpdwOZ/jNbWZLHER4MqakBT+QiWLzTriFdUyuFVUsOOG8f2GSUs4y5MVZn7+1Vbr3Y2QwJdTvBspSRdiwcqFKVTZaCxkqad0ehreZO3E2wmFDWA1gQpG/7KZt7LNfB4EKnxFPcD4Xqm2krSvbCjXISgm0TczJk3b4OJ8y5RccuLVdRXkTrdpeXnNl8WWJm5pSdbfeZG4yerzZnu1eOIsRM7DVYKQNn/exy4NHJdeulDPj7dCqBK9jYg7fW2LIITCiozH9eXFV5gOI4m35JBokvftotalNAgXoOuJGZrkGEj2WeA6nmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzIxm237vBmo08MNPa0VX4IxFd45HrPHZXguTh1wtY4=;
 b=NVswYCWWvXmsqnkfnskCu6lSdt5VT21A0+xojscOoUg14jXthf5EOixQvHwkCBhYv9ISb4lXgA1tdreqEjRf+0eOiY7ji+6T3+WfBlJ0J0HoD3PJ/RZAiv9jpTLghnBD4CEWx/Nr8L4I0jyQbD9Rimrg22AszZu7zFqLx4UtwOaKrKyGjTJcb1EGWHkHsirf+LUG6NJotPY5YO+6UyadSVJ1lICzcksiW1s2VPW9VfPC3gl3ZSpOJ14P9yiF9RfrnsmwTUZexaAHhGkTHiyp5dBq97sIE+P1I8T7Z+zyvWDXv58Haa6gERDES6V4dmEDKJpElc8rNaDnoQUFjm+IuQ==
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:55:46 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::e4a6:be69:860d:abfa]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::e4a6:be69:860d:abfa%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:55:46 +0000
Date: Tue, 2 Apr 2024 09:55:44 -0700
From: Saeed Mahameed <saeedm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next] MAINTAINERS: mlx5: Add Tariq Toukan
Message-ID: <Zgw4kKmaXfZOLpOH@x130>
References: <20240401184347.53884-1-tariqt@nvidia.com>
 <20240401205255.2fe1d2cf@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240401205255.2fe1d2cf@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|MN2PR12MB4454:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7C6YIaNCdyb9jh6T6nK6K3EgAoKBLR8d8VI7Z6jRsNp3ZCIvrKY0Nrhu3MSEjnS6QQ+bOQ6OeDX7TwZ+6v1P86k39wwECwHvokFMPmJS+yuNr+wlrt6dFq+d4j+adj6j+G+3gMedPgnnB0CECHK7sk/s9tGm9wa0g6UccQaHyyEar2lcJsd9sVsGufo6rIrrsnVvHqzXT8stSNvKk5VNsQZTATvJpoKpaM4DgZK0teTgBUvoyNUUsardopGwNazHA1QQC2TrCZW9dHTPK+kiw9ALeSPTdyzbdVceK4oKYzZg9RfdUKCoOqMooTSjhuoAAN+i8oUagD6uwEnOMaJeyrBdfsVXbefBlhsJctVJfjZUga8SChmtLcTZls5rppOwolC0kb14p/cMRurizT4san/529+rthh7ZlMrBNAbsjWbtU7dBbZrGca4KSuQ+nT5XUG0+aVUe72/k31rw7mPRQ/GDMFMUbJsEObZFJ41xAX1/5rNxk5jl3BLnlG6j3dI3blliABEwMWvAuX22V1KRZjNJ67VRglqGTy+dDgx0OISL1ef5/7JPFCvTGn1G6ghoCajqrAIyeUqaaeHVvP+i5txs6l2Z2T7dok1hJ5ftl3rF5+v7xnQKUz7yWUgsww/YQ8d6D3+OfvnOr8TNqZuNB4cQvhPbgBu5pRA79ZSDCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRt+WbQ2VXAO2809Qw6L7JQhHPGw6CZpcQ0RDPDTAv+sIZnK2QU7qoKQ6lhI?=
 =?us-ascii?Q?3g0etsuKJ8ArM3qT2FKR34+vhvfbHlWReaH3DUU26uzC4H9GNCjkeDbdKKXy?=
 =?us-ascii?Q?ooHx8u677IAPFUS0J1qRO1ncDWBDRw84luJZU3W3iQxfhWFSGKhiK5C2KHbz?=
 =?us-ascii?Q?dML78Dyo/CwygOvCIfP+zKp3gYiveB7O4Pr7kzoiDnjXcVoidYHSg31UBtmo?=
 =?us-ascii?Q?MFQBHRB9lkOvEBRxwCi5x+6VNL4F3FTE2L2TrplbeYolut2HzJdoa6DH1HAl?=
 =?us-ascii?Q?1Dbst2bunQVgA+bj7DGV17higEjZ0c1/O7bsLO+fCwMuudoq5mbnhCj+edA9?=
 =?us-ascii?Q?zRCpfgvoH9QtOIu7lXs+nw41pI2f96v4S0fry7IkVky1gdnU+fRbbcOEzBoh?=
 =?us-ascii?Q?5ko6RZ4pA1rkSH25ASjA95A7aZr6Qk6yLQH+N68ZgqGSs7Ct1OY5wJUNVii9?=
 =?us-ascii?Q?VZbyfWB1053plh1x8YuIcMzNI+tvwIkR2RTF7mvKVZ4CIeW9KUO79+G3bUMT?=
 =?us-ascii?Q?bMHEyaVXECkvPbGCCdE/ZEPk0hJEwPr/WbMzXGzDAn4sLNqMhfgkDt+299Kb?=
 =?us-ascii?Q?xKyMTLRR5xdicggQkMpz5bkO4UzsLcIkDMUVVebrDn2tbm80KyBg85j7IUy5?=
 =?us-ascii?Q?tWdjKcqun0Pj2i/HEOe0zyTGQUj/SWclVRNtSgJvxIv2PffDzc9ad3iXhJEG?=
 =?us-ascii?Q?FO8pDInppOqkwP1i+Y34D5TWB6DJOH6KiaGHXRmWhfI1Qxgd5jECXgV3hxNH?=
 =?us-ascii?Q?7BVBnUJ6tVnWIXKiekXuQlOeKrfOjtrHiLPDqsoJu3zVfQ2tSaAxz4XPBGhR?=
 =?us-ascii?Q?PkqP7LGGP1O1qwdlzYsezmZelWiHXWNYtjFlBgly2X7+E4TMpucnUst2QgXo?=
 =?us-ascii?Q?61GHdAvHi0KflgCkP8Flno4kO5EbHYbboiUTOnpS4f6UIxDMxWw21F53/0TE?=
 =?us-ascii?Q?ihl/UX3fgYHPIk8h9+6eQ/USSozJDs8Aly1cnCXobcgN1O6cd0k9gfUWr9CN?=
 =?us-ascii?Q?/o2OjL136yQj7tYelV9uN7ZPPxBv7h7MFi2I08bkLVUpYvY6CzewWmrKXgM1?=
 =?us-ascii?Q?usYcUs1s8CgFi7i0mJ6zPzCnEft3cDffGkVl7eiK0JweS0BGeLStq8A4O+Qy?=
 =?us-ascii?Q?C3mRl5zpjriVcXZuyI463iLzCwOMgHC4pScl5yvXLDMTnpunhCfud03NxfRu?=
 =?us-ascii?Q?6yHzPXM7GKNCHyW92OSI1b7ShzW352AaFfHKdrRv8wiBVTDz2cQaLYgVXPjv?=
 =?us-ascii?Q?TakVGifDN24dDQoJHi8+VVkJZMseT9+MMqvUXwHh/gZYlc+a4ZE5wvaIkJg/?=
 =?us-ascii?Q?asuLO7rqwP0qPyc/St1hW8IbTbty8OudPKpVPDLEmenf9jJI7LU1Glg9QstK?=
 =?us-ascii?Q?UbsTFz4wpPzLRRd9pj4DkqqLU3c+W0ISXRIGwANtGzOy43XmfOI5WrzgJHjs?=
 =?us-ascii?Q?xYfK92TteBZUMgU4U7ONiE4tBnHLlLFFIhi8RP3cVkQjKochd/OShQMzutIZ?=
 =?us-ascii?Q?3Tl1EYbJpXf8HpR/qWfKvKXt865oVrxXRZ824l1gDhGhwDKLCEC+YIjTuUGg?=
 =?us-ascii?Q?HlFxnJrYvdsfbgzF7fc/F9W0SaDqAG3F+D5Bt8nB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b039ae8-e5a8-4680-547c-08dc5335be1d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:55:46.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHB9KK/wTeX0FIGfAHUeViGpc7fj4ZnjqxRJ7R/mv1SBH+mScuOVZVxXJ9IgRW6WNF1LDFbmwcrFnCb7zuZqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

On 01 Apr 20:52, Jakub Kicinski wrote:
>On Mon, 1 Apr 2024 21:43:47 +0300 Tariq Toukan wrote:
>> Add myself as mlx5 core and EN maintainer.
>>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>
>Saeed, ack?

Acked-by: Saeed Mahameed <saeedm@nvidia.com>

