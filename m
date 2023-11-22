Return-Path: <netdev+bounces-50101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6B7F4A31
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC12810A9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C194D13F;
	Wed, 22 Nov 2023 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuXwRLly"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C199A92
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEZ8fNuAD5v3XRV5OBt0fstjIaUAfSpFs6rf5u5bef2dzUKQWV3mnjsFFyeuferp2iIvNm+S0NTP0X4+edM4ZWpQqbdD5gK6j5Fht/aF7jUuqBp+m9zpQAS0RV55CjS9pCukLEhOrFDa+riSynLe2a5oWXZuvu2+MorJCSReMlt7Vc5jP+rtHotiqMXMR8EQ55sZQv/bL2M8aXUu+Dl6fjTpFT8autrvjxFpeVEpjl1Y0ySyXDS5Vx+PHL1V9+ygm2jD9MEW5j7KzDJtCPIW4gSoEClT1k0cSt53PEkUIXxms+9j7rztSzldIpCbVPA2hvT5xgxPYlV9jCYe+V46BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muGnjBFVzIrLGIqS/2voRoyfIIxj20G6CdC060tmhb0=;
 b=TMm7J/uvXIGd2+DHrpggQOiB3arUjAw9txqyxtv2Z5zaLS5Dpd4o5DwMhO8GIaiLULY1nIiqdyhhn6yGEQXTvYX1cmbE2EaYtwY2hxZIoltPV+M6vrzv3T2rhiSqOZtya558bUk4y8QlrIQYjczdPp/HGgja1tIfGJsLZagsDhzMXpL6tPm8e+c3DWMPPZN5shrVz2dUADEVdyeHBZ+llk3R4WhlYWS6I4Yr9+tj/0WwfzqUviGv6FS7+YrrqQobOozMX49ocd9pHR0DEWqLUKFJlqrODftbqIIaCtpfxZWV8iSOYoxYfCY+VimqwxDErNJ6oeoo8rZ6OsN78LEfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muGnjBFVzIrLGIqS/2voRoyfIIxj20G6CdC060tmhb0=;
 b=XuXwRLlyBCXQd7+sTfr/nJcVFYn/TE1osSc/CiVB/HEA/mLbSACW0HspTYRpmIU1ySJjvU6OJsfPein1QRhb/bCw9jdZHVB+A0JeP/X+wP7XdjVdrPtRbQkznvrHtUw+N9DSwfpGajUHLdPpdgcxCUk4ZwkucpiQVS/s4MOSeu6DtEve+SLkAgA7Jk5ne09YTcidk6ESrr711PTGcXgDPacJI5aPIY0kJl9xdT0XKCkEH7Gl0YK2GtaiHR/r0kN52Jpagg/WBL5y8LubmrutVLBNekYaMVqsRkHT7rLkEEMBtsCISLQT/I8L/ylhyd/3e3kA4xyjNHpSFnOnE9pzIA==
Received: from DM6PR02CA0125.namprd02.prod.outlook.com (2603:10b6:5:1b4::27)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 15:24:11 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4f) by DM6PR02CA0125.outlook.office365.com
 (2603:10b6:5:1b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:01 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:23:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 0/5] Change parsing in parse_one_of(), parse_on_off()
Date: Wed, 22 Nov 2023 16:23:27 +0100
Message-ID: <cover.1700666420.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: bb691728-edb9-44c1-85ff-08dbeb6f1456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	InUWE8YFZAK0Vjp942pN3xrwfNvUTsTN312vJNrbfu5142ZHsLC/I4rsonKW/eemMtgmR9ZiOG40f3OxMN4NP1Qtyhm+eHUTpl6KFOWEgxhbcPGXuCMWfG1EToA6QffkMwS4BRGCjT7lT0XI1Xn3mllqFI4YejJ88YW5LeY6ZtBcVP7P0bPpQ7kPktVIcqst5f4KLQfOuujw542bFxWA+4xSr26UaOBtDLKGDoH76gFcE4Xwh3gQY/rLk1u1pB6gaUa+6hrSiuRP3Ulv9usU+WPGZRGQY3OSlpJ1ghCNmV0fG1x6827MInW6P369g+HF8HdyKkiUlhIFC8WBo4qK00Sjv3C6BnWFTqocMlvRuDThGRQyxoKL677d2Ha1T/MuohwMWnCax5ArWJ8gtocnOz5fp+OzQMHgLnJCoIaWaebBN6JDkTghlT6rIUI2MSWmq/p6MafWk3ZdvC3oKBesh5DtgRm0OFCTFHEeCTg//kSoALvcPJBVUESpgC1Mmj67UAl5WTSsdVSjeRl0iU05YtuzrFpADl7DcmUFbobHz+qvmHG0Mor3UzVbUbF134wQ5KXKX03ci9rDEHvgbiyzSP3r2SzqVUAiB32cHrEgPkRxUja0G62oXjfBrCM/FEOGpDdFK46zOOtCwuFwKjAnbWT9eRPOykbPZTRrck6HDPs/BLzbbYroEatDb51qMeNeoLzxlMFHToiIjvY60DpkUqVVdBem52EZoU/mfcUaEtS9FQwumkvY9QdEz0QsB9O8wWTuV9l601kgnolM440tRWBbwA8gvEaH4S3EURodqZ4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(110136005)(70206006)(54906003)(70586007)(66899024)(40460700003)(316002)(6666004)(478600001)(5660300002)(86362001)(36756003)(41300700001)(2906002)(8676002)(4326008)(2616005)(107886003)(26005)(16526019)(82740400003)(83380400001)(7636003)(40480700001)(36860700001)(356005)(8936002)(426003)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:11.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb691728-edb9-44c1-85ff-08dbeb6f1456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

Library functions parse_one_of() and parse_on_off() were added about three
years ago to unify all the disparate reimplementations of the same basic
idea. It used the matches() function to determine whether a string under
consideration corresponds to one of the keywords. This reflected many,
though not all cases of on/off parsing at the time.

This decision has some odd consequences. In particular, "o" can be used as
a shorthand for "off", which is not obvious, because "o" is the prefix of
both. By sheer luck, the end result actually makes some sense: "on" means
on, anything else either means off or errors out. Similar issues are in
principle also possible for parse_one_of() uses, though currently this does
not come up.

Ideally parse_on_off() would accept the strings "on" and "off" and no
others.

Patch #1 is a cleanup. Patch #2 is shaping the code for the next patches.

Patch #3 converts parse_on_off() to strcmp(). See the commit message for
the rationale of why the change should be considered acceptable.

We'd ideally do parse_one_of() likewise. But the strings this function
parses tend to be longer, which means more opportunities for typos and more
of a reason to abbreviate things.

So instead, patch #4 adds a function parse_one_of_deprecated() for ip
macsec to use in one place, where these typos are to be expected, and
converts that site to the new function.

Then patch #5 changes the behavior of parse_one_of() to accept prefixes
like it has so far, but to warn that they are deprecated:

    # dcb ets set dev swp1 tc-tsa 0:s
    WARNING: 's' matches 'strict' by prefix.
    Matching by prefix is deprecated in this context, please use the full string.

The idea is that several releases down the line, we might consider
switching over to strcmp(), as presumably enough advance warning will have
been given.

v2:
- Ditch parse_on_off_deprecated() and just use strcmp outright.
- Only use parse_one_of_deprecated() for one call site. Change
  parse_one_of() to warn on prefix matches.

Petr Machata (5):
  lib: utils: Switch matches() to returning int again
  lib: utils: Generalize parse_one_of()
  lib: utils: Convert parse_on_off() to strcmp()
  lib: utils: Introduce parse_one_of_deprecated()
  lib: utils: Have parse_one_of() warn about prefix matches

 include/utils.h |  5 ++++-
 ip/ipmacsec.c   |  6 ++++--
 lib/utils.c     | 49 +++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.41.0


