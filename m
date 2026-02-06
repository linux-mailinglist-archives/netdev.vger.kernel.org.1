Return-Path: <netdev+bounces-257569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJFcFW8ChmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:02:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B6FF668
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AD923003358
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9C24A06D;
	Fri,  6 Feb 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FrB8w3lr"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B7188CC9;
	Fri,  6 Feb 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390123; cv=fail; b=Pe01aN8VFdZv83MN1nx4W1s6eiooWiiOZ5seXB7XitvSCoQCC4NGJ4GiaZTxZgnjakux+k8Ss1uFRMVI4zxQEC7G5OWifKnYsIVI8Nves/gjPDu9foQkCbGCQ4UV/sLFe0hKolEA7GW8JxSh4S8MS2u6bI3Nx7E2Toqk3r2UjBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390123; c=relaxed/simple;
	bh=CemqFQDdEeO5b01qf5JnYpPk71NXxu/0D5hmZDTt3GI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kjCjPUZFBLw8s4e4f0gjz8DxzVgFEJDokpqLnBzy/OBfZ8DkYernYcYZ4M4IxkkEP3GD1X3Bc9k83rE7iccz0vI8j9KdeX1kAuBgXEDSerM+vP6L33YcjPbn7sux2F8CzkOAx8mHfPiSlvc3mCY/9/adkb2GsVYepnhDupu/Z1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FrB8w3lr; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYCUDaEtvbV5kgDvUvTJ3BjPzuH8i0m8jwiytn9BvB+ysIPpkv7IYGHGNNUN2JaLU/M6q2rHncQELQatiXJoYaxuO0plecdqDTkrHezncNgSRFLBTpasjDtXLwhlbFs5o6SSv6yEBMFgO1ArAS3S9t7/HtpyWHYEcpD2gb+yaEFMAiuIBP0ACFZIW00Ng7LwPWiIQGRJ8EXZi0OcTb/PRZO2UWkd1J+d+wxdJKr9dVTwmE25fn5WXotXBNhdz0lrCtNTGl/LjLhzPeNDqmIuZ471QarZuT1pRSMfFpZiyxV5AqO5EOzZ6tbgCRlEl9iv6e7qkxP7Xm2V4aKKHg1DbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CemqFQDdEeO5b01qf5JnYpPk71NXxu/0D5hmZDTt3GI=;
 b=Be0ZRybpmZMb13Inecgu7vuW3TlI9P205i8ynxUFRBl3+0H51wRlsnhqnOdfg2GXVQVcw/9LDt7TsMiQZ0eO4h5virO4wpo8O/Ccuhvnp4BZkuacOll4GAObleDw8nsphJVEEWVJdr97BYjTM3wmRqAl+dOEMTmeoJ6GnxhSWUlfDna+RdaeepWttdkOdjJ2GIKqOgj5fOaHTTPcxDGvjA9pSlcQHkvuVqicoyG8erc5e++qaAF9Dxej/cHZrywxg8dnhDcsvYQGvYjdj0O7ndX+p0IPh2fvZnGMlfy9o7ReGOP9vFwS31jTmpfoQaVVNJdERy+05+SzbIDxPdTqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CemqFQDdEeO5b01qf5JnYpPk71NXxu/0D5hmZDTt3GI=;
 b=FrB8w3lrDVlFnZbgTiNaZJLi0s9e24Q15V06wif6Ox9H7y0EChml0/oXw75dHYBEE+hTpjWMYYXTF2G/QevkgM8oNZTqM3ua4UGsy2h7l48Gt9QWAA9SKsB/KJv3AozQw02Cys6rAlf4VSFmF4JpHtdQhlMzZdZfAXiYkpciix1CK6p/YClLbsHrBGy88NScqCRdCoPLDPEW63XIJedli+hAG/e+gj5CMGg441l6iOCQUcgXqjLGOsOIpdt2/tJxi01fenhf9oYdc/ajwRMoMDSpdKfpWMjuxUf78LMy3z1YEovjXCkN/VDy/m/lowPnn+fHCJeHqEYyv2OHFeJvqg==
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 15:01:58 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::e2) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 15:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:01:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:01:37 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:01:31 -0800
References: <20260205220541.2992807-1-kuba@kernel.org>
 <20260205220541.2992807-3-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 2/9] tools: ynltool: factor out qstat dumping
Date: Fri, 6 Feb 2026 15:58:38 +0100
In-Reply-To: <20260205220541.2992807-3-kuba@kernel.org>
Message-ID: <87ldh529x4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 79024e5b-89a0-4627-f757-08de6590accd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CM048rrUyajE9wKPZLYlmY6huhfUKbw0kvJ1PvvgoYxuNzQsCcwmRe3mI0+c?=
 =?us-ascii?Q?5ch2Glm4j6Dp/RzRIjd4i456dysriNHUVRTu7bGJNBxmAqfLJ4zduBTplG8V?=
 =?us-ascii?Q?127B9ANq5dMIoXflajJ3nxISmik0dfIzhH2Cn5/nR7IU8KllcDyfFFGFYKjF?=
 =?us-ascii?Q?F7rl95AWEOlC1NSp64c9Enr80rdmHu4svxDgClXfhPil+79wOSdXCH+pNxoN?=
 =?us-ascii?Q?g9+ZVIYt4CBqQ7m0DoAVL+ZmsWrovNoLHApskjENsLmmO3us5OZSy5gMVbOn?=
 =?us-ascii?Q?jaTR/Xe0faBT5jWvMRQuwXd4BsgnI00utttWo8FRxYBajuIWh7uUE5GWmAnJ?=
 =?us-ascii?Q?RAVYajJ7brajDn5E1m1j4u3+GYo14nvcqUsD69gXoV9F6NPrm1UkYUcHLhnd?=
 =?us-ascii?Q?kNKnzmD0MdVooRE4U3avmsV6Ni+FU/588dx71gCHSafVk/DlHzzmF2iamQT/?=
 =?us-ascii?Q?Rdmyn3PymqGvTqWkUEaBkSBbt965A1T+c6mrF2BJvjHkdjnIgv2SUhzAfRoM?=
 =?us-ascii?Q?/LKMpnyn+63mRvH3oNTlhio31k6sZX6kFHLU7RdUhtFQ/Af3TJ1J+C0p8H2+?=
 =?us-ascii?Q?C5N7IydUYG3DAEwAwmK2cVYxZsV/jyRDUmg8wnvBL7gJNXycW18FXrUR/7EF?=
 =?us-ascii?Q?r3CbTdCSJVQUvZm9nBXm5b3eOJVIck2gc7Bz+PGLlbNiKBghg2P1v/Lw1DZy?=
 =?us-ascii?Q?oFBGhwkjn048a0gLO8766gVhmhf87mr9JCsuGyEwh3rZBiiItl9xT9lrP3KV?=
 =?us-ascii?Q?R3bl98NOJ8y4iXIZVE88Su9RL9Tk5iiyMKUuszBnf8ybrpg4JuamPmyAoTeG?=
 =?us-ascii?Q?KEzRgNiQsYxZcKeORFUfO8v/ezb9Shfl8HP+Eq+CHVGooWlVMPQZMe1a7Wi/?=
 =?us-ascii?Q?YMKq5SQfAkHfnPRbnDBr9fqF7XcGD41xGkvoo+PRk74c2u/srVlq4+tpzIOA?=
 =?us-ascii?Q?oYr8+j7GZQ/7bNHtaQsPZQkesSPXvg+SYELFrHkqBxyizQlbWHb3wy4jd8A+?=
 =?us-ascii?Q?BV4SiYg5Mz8TDB25G3QF9hMxxzuibWHglGXwuWx4T475QisLjVr6CK8F/b2x?=
 =?us-ascii?Q?Yf832usJJGKRsgoDimOlxcQ6BqDQfZ1qJ0nk8UkYs28ArhSz/37jv0CfcEHf?=
 =?us-ascii?Q?bXoDo1UPqBRh87j1+EWzDs40p9ci6W89LH3mGRK+zqZCt60geVR3ZYhDA2xe?=
 =?us-ascii?Q?PXiUxr8kJaefJv68gHK6Mo4GUa8zp49QAHuA2vXmo6Ut/m5s+AzRfyHYx1+W?=
 =?us-ascii?Q?S1c8fjOZFjIi5kgs61SMAAeWVTuEXEy8k3V1BfGMMMxT9j/CZDL2NCZy3aMn?=
 =?us-ascii?Q?sdPdnCYjx3zmE9M5/0DN9jKqlQXxJZzmfow/d/44lSkOkvnkeDcl4aBuTIp4?=
 =?us-ascii?Q?vKXSPFyKXh7aynYFNzItInEMe2Lp3it0S++DkHQ3EiH1jne6B17RZfVJOcyA?=
 =?us-ascii?Q?hZCEtu+7+Gs1YkFY9/AC3gYnywLhlWlMzYb3dVGfbjRwz9kDDgErBxXwMyFw?=
 =?us-ascii?Q?qKRne90fUZaTE0R317o/d1vTIM/w8UqDV/3Yp0aN0S/wQguq/O3lJKdKNRvy?=
 =?us-ascii?Q?kqOhZVynuE/adykAutVU5wMITgDbJvXOAvYUOkJkUpoOyQ71PdJFs1Q0QkIC?=
 =?us-ascii?Q?5dS+k69I8CUXHM6qFZEQHnQ/8Sd5M7WKzD/WFMVWVotJHO4e/5VNnsJ2tjqX?=
 =?us-ascii?Q?0gWSbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CV6aSkgEOu5+TOPAygLlltKkULYk3KP3mGZY5l0GDmNH0O/PKTnAC2ONZw32VZ0UUTR8VnVovJFUnaa6e5WVqS8ALdB+slJysdCqM/E/2CtHU2WNitJT8eRYC4bBG3oY06c8wPv8QcQcDf41j9DW+CRFJjseHicHxPPUo7jBjtbPWqRPeVv9p0lazPuiAY+uBG7iTYq988A8JQGZ5TZta75QYunCKm7stpnzgU+YNiQb/+mzjcLcfT8G/uFUPRtOirWN30EkKFkpEkDjFwEmV5pYcNfryoGvkUj7fgGFj7EqDXXS6+N10NFPNKvrvD60LtMUb9ZVIoPk/vF5Sh2Dvcy/xR1GYOXpStNaiYMnxwWj7z0dVgr01SD5MXhjxV/SoezcK/nqZ827czvOo19ISGlfrtgdLW1a3aSO8/QN16Kp1y/IC1R+jUYx249XKrJ6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:01:58.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79024e5b-89a0-4627-f757-08de6590accd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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
	TAGGED_FROM(0.00)[bounces-257569-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9E1B6FF668
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> The logic to open a socket and dump the queues is the same
> across sub-commands. Factor it out, we'll need it again.
>
> No functional changes intended.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

