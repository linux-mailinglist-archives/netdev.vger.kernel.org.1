Return-Path: <netdev+bounces-195559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40096AD1296
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07DE188B64A
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4622B595;
	Sun,  8 Jun 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqi/cK5/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84591F0992
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749392826; cv=fail; b=KJfuXE4hUKVpKTdYCYOoykpkf8CeRzc15sRIdfoQwmPkbmsdLdlCufzrzNO2nNaQ93/qrWK8+g20mm6hcNlA9BjJvJK5YZU0/mtoAHR2U6zG6t6CY2XbSLZOkaeJdRrC3MMpNrJLc8oNv5vtblKkLR5pGch7CrxjFzA86TwdLLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749392826; c=relaxed/simple;
	bh=b4AqYhYxAKviN2oP8Yqw5skoVuFLDlTNYrgEKK8ikq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MELnnUE2/yrEwM6hBL2l39A2xYCeAjGVD3Keqa8sOnSV9sJG9muDo8qk8+gxwQsGmwLLkzR2kJxLyZRt5KXL7/Zm2SH/W3YQ+UlFbcxjvIKyQWxEaqLrNnyJDsSoEuOh5d1u/bh9n74oilorrnMoTIgdQFSx5Lh68IlePRfQbJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqi/cK5/; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGEqqi5c4LL794cJNzQNVrhWp40dxuHqWPb/OX+kuA0Beo5hrHdd5wcNopoXsK8smSQyCo4nEDGWt7lPyfcuCpgRH7kd6Av4TpKgbkuT/Dujm+TcVkUUj/V8qQzCUY5fxMEN4P14qFjpqSc1N6dIPXFAzfIFnTEwTUnM8b4j7SnyHc5nqrrjSvxIucjJByhrstRYypZ0n/bDuEK9qvSo78kh7EmZ+4fL7bWc/QmQoTU57ScVf9ZVWS3PmwVJCCVrgp8fmB6FrAFINZZEwn2u6Cpcr39AcQPviv4thlgZYz8x0I/4zMSz2R4bjUANo7/EaSx9RNsCuKivOED/6oCqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ52gUKen7Im8ruoWgBJ1LznRj6s9Bqm+apNDECAPW0=;
 b=InliltzA08KeSx5/Z56+0c8p1GzN3EhCHN0cifymIJi2PpQ5TVUXux8HPm/RlZ8kPg6qxYgqGaXQVTdxM2U0Pcku/i2MUi0hiVGFQOdz1Ny481TcmI8g3hpc7/8B9fEaymn5iTGiJG/0Un6Wfuhi3B2RdSJpJqYi4LsvOwt1SyMsArIF1wjrpy7ovYoHA901pulzsQk1tcEJlQTqQ+x97+1phK6KFybsp51+Gg52Ck5Lz6X/0RpDF86td80o2F6dLBcDvpgseipq57y12Zj7Cri5XsQg21u5NHR0H7D7rUb3+cl64Qfy8Qt/+4837xH//oLQ2A8FX+wyzJHUdDukuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ52gUKen7Im8ruoWgBJ1LznRj6s9Bqm+apNDECAPW0=;
 b=aqi/cK5/bjbxGF3nQfDNrYTOlJUcpa13ZK14eUQqbVxfE8g7ioDVys+gJSNTm7E3h4GZ6AdYfKljY8uYs4tKI7ksEsfx3pdwQp9kyLCCzFwjH7VTqHuNZk2wXhNJ87/2rh6Thb1nKFYp4lLPSygwqkDHGgsp4Z5kBD43TGD4EYSGwFPLiGdrWJ62E51/nGugbcwVLJxG1/itll6KRzq0c9Z8r2GdTZhY1C8xxiZcZTu4wxstVYYdltG6jJ1qa8BytmdXWR9vHKjbTP8lRGdcSWBRAG66b5s8YP1eph7EGhZfXaqPdZpocaPupqFFbs/1mAbk77ftAb7BPm8/6rbgCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Sun, 8 Jun
 2025 14:27:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Sun, 8 Jun 2025
 14:27:01 +0000
Date: Sun, 8 Jun 2025 17:26:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 3/4] lib: bridge: Add a module for
 bridge-related helpers
Message-ID: <aEWdqycUQBuevEtZ@shredder>
References: <cover.1749220201.git.petrm@nvidia.com>
 <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f2af45-5c63-4612-7a6e-08dda69888ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnMdNAdlQTSwrUCRXkmyvdCr7hZO4V7oMq2sqtli2eYWjbiZQAhhpwMpL/T8?=
 =?us-ascii?Q?yJITO9BjEVwKZi5IVst9w2SHC1/PvzXkMNnN6QIOYKSh3313iW4t3p+lV+T5?=
 =?us-ascii?Q?RuijmhWrd7jLjWy7/msMvJiG0e50KnKbQLe75DZGCgKlIDObqQiZKf+MkSPi?=
 =?us-ascii?Q?o2KFm89SNOs4Vla1kOBMgY6VtLgrZCjXQxScKwAWggfIpn62ElG5GoDr/xAk?=
 =?us-ascii?Q?DqSvFviTAnEepAn98Bq0VuGMBq60vajqQEkIc9c8eMduFkSy6sBW0EsAWl0F?=
 =?us-ascii?Q?l6aXmnSG3bgh1xCOydhUNW6uttRrTQGHsHg//VZg5RgOErPSbEXZ1fFjYmlp?=
 =?us-ascii?Q?NXyRjJkq0/sMfCxL0+Zw79hTuUlvQGaDYYd+OyqIOTcFePc9QhJG2rWkgrt/?=
 =?us-ascii?Q?Qsh1rHsHOT5OaxGddfOMp+4T7K9gsD1wv6J2mza2KsWVEqFqg4snwBr0MPD/?=
 =?us-ascii?Q?KLdcGVA6rYhD+MARcZk6+FW5tBkazJV0D200rhJtifO4lqBeoXoW5DOY/E6J?=
 =?us-ascii?Q?uFvXuNZFxUiTN7MznG40i9RL44ZSA8yWJVZUYb3HaD3tjUM5mNeKOr6s0snP?=
 =?us-ascii?Q?cd+uYh7bWk194kd5X3ffzwKv5p2Xm4h8LfIR0YXpcaG1pW1ZMRpi7TZ2iaHg?=
 =?us-ascii?Q?QUKqbRS7RK7dtBlxGcN0apm/jWUFlQdq6qXSk3b8ykL2DT8jusz5EtxV32uj?=
 =?us-ascii?Q?epvLlTm/zwilSRA8POrJ69mb1lQ2wYF1EHvEdwTth5BTZ6spKS6+ynk8KuE6?=
 =?us-ascii?Q?u0uUe1y6FuMPkNQIvkr0XH33F+zoPJ/atwLh2ZH00kOUpRatvFJUwCJe/S1s?=
 =?us-ascii?Q?lVKYoFYRX1/dLX11ZCOeUwshlDozsne6xNV+JRj+LnSCIbyg9L4FOX/fexKk?=
 =?us-ascii?Q?KlzcEPR4U7Bw40XgkeeEFrZZAXv/5Kln+oVI+YrLDMCJwHUxJtHHe/nzzl5k?=
 =?us-ascii?Q?JGRUY6qYZjDrBCYFcJXDrGglsEUlC76rW02t8lzpS0Ug1T0t33/ZS/9uBsDl?=
 =?us-ascii?Q?fCvIx3PBo41oKqTnKWeR5FoehhSOQKvqtyviIKNqGoa3VJ5b80F8nHgN6nnh?=
 =?us-ascii?Q?t/FthEgf90Ur7e7kGtC+u332p9c1UhPgzobwDfgkjPteQBjFDw59evY9JdiL?=
 =?us-ascii?Q?bUo2TTu+vHMzODqUwQeqWrH5r9eQmUanznB8Rb9cFGKPdO1g6bzHrXAwM3X3?=
 =?us-ascii?Q?xpbdQbN4uqAlwTeGpqIMv7r9MYcW1Ca1OZntlvXmGq5WQfsrBIlyn7YJiJ9o?=
 =?us-ascii?Q?GRx59C7UpaJ4T6vHAT/qHdPJDL/bgeUeEbYjMzf2L3tlA2jiyzPxa/NfqDDu?=
 =?us-ascii?Q?inORujv4JHOrRM9MGsxBbyjmWBGguBUrkyKdbgJJGVakhkSgOA0WG0D7QAO+?=
 =?us-ascii?Q?1zkuvbPeIGKU1RVsmZr4Kn1d3D8IWpQldVcfjxbJ45N17KGJLzEg2Lc/gozn?=
 =?us-ascii?Q?UAmbgLUButw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?intMLtAq0+gxALfPSksUaC6zB4s+K7keFOcuiVUNSVzjDGvVU1nUme8ZGzvD?=
 =?us-ascii?Q?UVDyfOO/pYFR2QF6d7EgftCWS1T7bAda6T25JaJxwrPJMAgAzQ/8+Xr0a/ug?=
 =?us-ascii?Q?Agiw/UvRqpBZSDKUNaDJ4srHfkxdPqicXPlZ83DwwyttfKGj72RPTbjToIBw?=
 =?us-ascii?Q?jTOTCprHSYmXw38i7pi9UOmf0QtqZhP4sMEqPQapdH9h2P/8Teo9EetbZQkw?=
 =?us-ascii?Q?tspKVqZ4TSR5zumWErAKUINhsd9m0KFHBdMyOgLE11KNrsqV9z/Al1ugahVc?=
 =?us-ascii?Q?Xkd8JVZtfrmgj8/07XCFNzchBnDqS5Z0UiCKrXo1lYBgTv0Uso8RonNoK/VA?=
 =?us-ascii?Q?cEMMkf6oTlReo213JQTU4BnYWVtI4LIcgzCmjb5QZJfA01KGAjW6aqJZj/l5?=
 =?us-ascii?Q?kvYG6HAIamZ5+jAh6+3EkYc/cxHlgPrtdD9N+ogq3dabUpwOdv4C/FI8r52F?=
 =?us-ascii?Q?kqCV4dq0MpSbKkPyd3XVT84L5Zii8bjlqu8ic0/CIhOKuQZrnuapH0UQVKvr?=
 =?us-ascii?Q?8L/yYoaGOhRNTJeZm+Z33xS8ZNNlS8+eMhkrj0J/Afv0gYMNSLIx3BKmyqsW?=
 =?us-ascii?Q?ixKMWJynRVvcxrxZOCFl3vZFslKhUM0RqFE0iagxC6V8OYm17az6dE3Gqjug?=
 =?us-ascii?Q?VTDsXjeFU9Sb3+/wQUytYhu6vGmeHcuKfPQuQw1JNvG2ZmjM/vjPdRnVfynN?=
 =?us-ascii?Q?Tn581dLjlhW32zp9BaidG35+1vzvIBozDAOj9roVNXZUYmUP36f0dpNHm47m?=
 =?us-ascii?Q?BROTssltrsrg+gEIUbIpaooA7pHO/wfk9z7mOBqReVe/ZNy6byKJY6n84mYO?=
 =?us-ascii?Q?jCCBha3WmCZef8P//uw3fksNTCoaxXol2RdwCfIloAF4NDSBaC1xZ9tMIGU9?=
 =?us-ascii?Q?Bq9Rpmb49bDfboJXxXP+6TyaDhH1OqtmK/6wuxF6B2EAKqRQ9f+jWpSjXLls?=
 =?us-ascii?Q?/UXyh2egyZ2apGUaoGoYn1JZzXxhBBP0c+gq73d8idI8iGiRmv2dhsoV3uKl?=
 =?us-ascii?Q?A8+YDNkl3gJEFNGPBAQIeOqBEHmWHkHX5ttrcjwluvvs0c52GLQKvQUpu5+s?=
 =?us-ascii?Q?jqQw26bMl3T5FIKWcIDWb9nVNDL+vdbLqnHJ77Z8DSZG0GJ7Qbu//BIOqeyq?=
 =?us-ascii?Q?0cO9nnCtp2nCOed4nWEbcxZ16eJ4IFxFv+FFy10wE922LuM0LgaF1zL0GqyQ?=
 =?us-ascii?Q?TcnKyK4RdNoD375ttou5F1B5ZKu7t0QEnUks4I+uxPshbUcW7gCRGDdn5wNM?=
 =?us-ascii?Q?kneYKEzhboxke5UQxJBi6jGTO4a4uCEZDCPySXXCDC8xIvW4n2uLNkFDaBA8?=
 =?us-ascii?Q?C8EWvSkAURmyr3FYPZSv/OGL6MFsHh1agxH+YgmwIHh6Iqo7WDm/Dg6OK1UJ?=
 =?us-ascii?Q?hVHQPzRmggsjrxIyr+1rs9kkQBzz3ddpBkHisd4hEn6XGQod7OHJXWMsF45G?=
 =?us-ascii?Q?TfCzouGHCrUlwAS808zOqI42FaFlMGEv1lhIBpO9b480qFTOGhiyn4+X15cQ?=
 =?us-ascii?Q?UwmkAbv5LDX7pwMatGLzI1/50dFgapzOkFanZR3gvvqKbfk6sGLMCW/rRFGY?=
 =?us-ascii?Q?OXc2/vY6UFEOgeX4fbsyM68SJhpBs50SnZ1h4IKi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f2af45-5c63-4612-7a6e-08dda69888ce
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 14:27:01.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC93W/8/+4GoiuZjXYyK2+ONC99MBMA1W7UfcyhPD2QYEMoiiFCLDZY1wDnRo4MIIGqkab/TF2eijA+qS1WKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

On Fri, Jun 06, 2025 at 05:04:52PM +0200, Petr Machata wrote:
> `ip stats' displays a range of bridge_slave-related statistics, but not
> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
> code to libutil so that it can be reused between the bridge and ip stats
> tools.
> 
> Rename them reasonably so as not to litter the global namespace.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  bridge/vlan.c    | 50 +++++-------------------------------------------
>  include/bridge.h | 11 +++++++++++
>  lib/Makefile     |  3 ++-
>  lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 46 deletions(-)
>  create mode 100644 include/bridge.h
>  create mode 100644 lib/bridge.c

Add file entry to MAINTAINERS?

