Return-Path: <netdev+bounces-150796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64609EB955
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406651889F0F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721748633E;
	Tue, 10 Dec 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVskczC7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C7DF58
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855467; cv=fail; b=Ry1zmlwozFuz2xevY5npsGa/smnk6KNeptqu2Szv1C0stg5eOjdYGvzOr39UE5vIUn6smIKq0ac9Ix5xf450/QsdwD46k6nF083nBT26Ir43V8MLQnKSEWp/L92TpceCHdKXou4JYa3TALtCKgxmEtzv+TxSUqbHXW7j2hvf8qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855467; c=relaxed/simple;
	bh=zvaEBffluiiZHS7Y3s37ttjKCGY/H1tZDY9x5ldsZJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5cDk6HBtpO2CKe1lz5XuCdKvkfN8bm6D+a6hnWAXFBdY0ueOPgu3oSrRWGn/GgZH0chUW6jFKw3Sn3+vrIFjZYrwTBDu2jzSWu1zOHovG0XAMATtD0DZ07xTJlm+/8BL6rW9QWZB67Dmgnm9JuqBv5BFuYDQQvAwCsYPWUC+c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rVskczC7; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udrz3AKClWUbTV+G/yyiXQ0YMXV3KtX29/6jRAWD0L5G7hE53qVZPMPzpT8AFdigNnXq9NyyMQfFCQdD3q0LBzkh5uypmLho0azplJ0cVcY6Y4VGVWfN0DtWK9CKpwrwPY/NTwS46rgoQuJ+csqfE9VK0wCR65IpyBIAP5A7KQwVxq/xtU3QZO3Sk/SuAp5sTy2ctw8JD8hJAX4j5W5EPj1scH/wEkZsm75S4n/hmJwqkkvjp1DKizs4ih8Pe/5Yrl5GCcj4HQEOjD+wxxAUG4T9RGcXLRzxJjCop9Za49Ci+qU3gJIDvkQdEAjC6CvC+TJu44/NvkHTVtmOAdiV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3qNq0Co4BUycwtLbKfLGTEHdjMNt+qhpE+dEHCjzRg=;
 b=IHcFIn8ETedldU3smtJ6DN+c7oNBqa+8QVfa7Zi6EGMCiXZzcrGoCNxy/WODMIvsyQk5LYEpeGotla8olVmhb1bJ1ImVXW44+kVbjTeyBgWUo4Cim3KOTQv0w7ruQD7AfuAMU5RXhxfrD8UcKXGzSxC/4/MMsAgbDFx0w9ovAXXUjA1PjXdZtFo5HvIveV1n06kdHcurSL6xfW2uASaMOX3sLOW/qdm2iks/aohxhzmva3UZc7zoNkWXDWwe6gC0N2a8E08yyWom4sjlDrSwsWX8Hf3eR5QU2UJA0aKdNJx/eAD5xqC+3NawvFlYJZ2L5HrSlR7x+CvIUrR1WCfBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3qNq0Co4BUycwtLbKfLGTEHdjMNt+qhpE+dEHCjzRg=;
 b=rVskczC7lKUOCdHXQs71K81qG7/VTxCu+EZukcp+r4VrT/UUeCZzJ/O7SBKhU9O8pwY+0AgvKqMjdx+JjNBH6DHr5VDv8EqFfh+YEl/XkSxNePb6Pb9TB1DfDD6xBlHuTD9PY6goVJ++5Zg2+fV0YKRJSo3hy8yRZ9zGypGTipw=
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:31:02 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::fa) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Tue,
 10 Dec 2024 18:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:31:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:00 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/5] ionic: minor code updates
Date: Tue, 10 Dec 2024 10:30:40 -0800
Message-ID: <20241210183045.67878-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 215e1be2-f990-4883-936c-08dd1948cc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Ww2P/BMObbl/tt1dBmWEexu56G+x0Y2z4xpA9YDlWqP02wXaaFarJnB1dHP?=
 =?us-ascii?Q?q25l9Hik/T9FHGYdD4uihBBQlAYFWl5lUgzKCnqds8Itw4o7DSHQKywuHEbs?=
 =?us-ascii?Q?v2wRpO6o0M59LLc+uycRkVH/D86ZgfNCjDc2QD7rCy7OMHH/qf4hH0P2Iqy7?=
 =?us-ascii?Q?F2qClVWgYiK4LjFT9LZlzJjmB8l7cV6PmbA2240eIeAfIzWhQjKiguSieMYy?=
 =?us-ascii?Q?yIIV1a7C9ZiicotDwDmXflPP72p7I41ouddzai0WyWoGzEWPLIkB1CWMrKkZ?=
 =?us-ascii?Q?bkd1CFNbi13my5ZkiZl9fxYbteUDcev/HHL03rBTyeSJSA2gRVEkwGMDyHph?=
 =?us-ascii?Q?HDzVENPy1/gqV5S/6QtpdjEgPZmTdrLjag65sunBXO4T0yMCymB6TTKo1br8?=
 =?us-ascii?Q?sQ0z6Hzzx76l7dXPkoCO8EeJNZRG4RxYwQzWkcYah95DcEqYra5sMnS7VYhj?=
 =?us-ascii?Q?O9gVU31XYxQN6Jx/KIRVA37V/41ToVUe8z9IGM7toEKPdTM8NW121/bNFekA?=
 =?us-ascii?Q?jvClRdifDqYJfDEssWr+4deBrnKN5KYuYChpR/jrwOcKJS8H8FfWJJcEnMZZ?=
 =?us-ascii?Q?R2xcWCkHMZ1/VvHo8k3wkcy31x0ES7EvDWp8tMSWzyCo1MTLZed01Fa1aCX1?=
 =?us-ascii?Q?PEnt4BOEX0+4VZWkKVw+cxVLUwqegjRmb+gZ/KXU3uwmBIcVwGmwP9S+qJ93?=
 =?us-ascii?Q?zPgLx727NUlmfPYkaNrrci0kzruVdyh0HdkQ+rM9JOeoTDkcqViijlfE/6bo?=
 =?us-ascii?Q?2k7/Q3PPmPjMo8/0QYqYQgi3r/iwIlRT1KWXWXNbaxCbX3odOFRm+mGmbI4C?=
 =?us-ascii?Q?vHD8Ckd8q3+H8Fw1Q56W9o0cEuvo73XeZXJNPKViUyor5VJEf50zD2DJZbfX?=
 =?us-ascii?Q?aWji8fHL/5jJCSjl/10AAE+i1+cNxJQs9PNH00hp0BrL1IjZ49e/iK5seZTN?=
 =?us-ascii?Q?NwxEV2q2jT6oDmxTOsc0g5fvHMYBD+sj6T5EIhobQlrJrI8oMh5asFjoLxD6?=
 =?us-ascii?Q?P8Zkv929k2Ih2m9L7DLkbVleh9V7nAnpB255s6IfVF4GbMWVea9WGJX8McWl?=
 =?us-ascii?Q?jeHbwwcWT+40XItcF9a08gCMIDYlzXnIt+XOdw0EYALDQeBblty0zoqWwaN4?=
 =?us-ascii?Q?J1WjS3Bg82LpOEtbEfTpYdnVO7LnSKkwdqlNStG1M+Vm/8m1toFwRuairs9q?=
 =?us-ascii?Q?IDCZyrzcv0pNIggyCHX3bDB14lXYjV9xr2DbLsCknx/a3JXUwIWABFQ17klH?=
 =?us-ascii?Q?JgFQia3xkefZ1YmYyY5UU4b3RL4w+Xb0lEWvvfpinprqzhzZyCQ0qQfOFKW8?=
 =?us-ascii?Q?37MfqwUK6FQcTGmefhQhMBb0xTEqVGh0vJ8adognMBfcyAzR30OOqUBuAHj6?=
 =?us-ascii?Q?PtUYiYXMxbPCJ8OocFGo/KYT89kIZ6+p8dm7K5lpgM2Gc5PVw1Hv+EjdLuBt?=
 =?us-ascii?Q?RK5KDjjC+7nTNOTKHUWjuEN2sXng7Rqx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:01.6603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e1be2-f990-4883-936c-08dd1948cc9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

These are a few updates to the ionic driver, mostly for handling
newer/faster QSFP connectors.

Brett Creeley (2):
  ionic: Use VLAN_ETH_HLEN when possible
  ionic: Translate IONIC_RC_ENOSUPP to EOPNOTSUPP

Shannon Nelson (3):
  ionic: add asic codes to firmware interface file
  ionic: add speed defines for 200G and 400G
  ionic: add support for QSFP_PLUS_CMIS

 drivers/net/ethernet/pensando/ionic/ionic.h   |  2 -
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 40 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_if.h    | 22 +++++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |  3 +-
 5 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.17.1


