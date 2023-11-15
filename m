Return-Path: <netdev+bounces-48075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705437EC756
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07A61C2093C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADF39FD2;
	Wed, 15 Nov 2023 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEn3sIm/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1F381DD
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:32:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E71A3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDxzwxy+xxF/PMxFYwpdNaZjGAvKSu0B/u0+Ky5+OxnyBe8zlYqdjBRli5NKhmPnRBoPAkbXPHWmOwUo9MJhYV8m/heiNSBQWWD0owdO05/AXzi/05F1cb1ulYqOhV8Ot/rwEFXiT4wTYgZi4Dxf/aOTEpfBv0d1FJsuRUs5JlqfMdLTGF4qA/6vgDbHvOfRAy3tphUlbkLd7bNK4RusyIxbIlQllRTL1ogfR1IKpjb6R+2F8qPPRPMA3MNn09SH4eL47POS42JU35FS+msBGXrKtxWh/nW+1XBcPGMmpDLHWh0Sq4lDIERWuqZRmeG+xGKbdUKqQpSuxycXv0ZPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVErIqwH9I4O3Pn/juYAVelGuiimhPBsdkLvccznOTI=;
 b=mPnABtkpQVX0M7G57kZBjgoDV1SaEmZOqgkM0+BIRf/BCODKWNZqLObwFSCiZau2p3WxDohf9GfyR4Q/jhFewf72Gjcdgc+Tnx2N98qfRoSlUJkTAbAEjsBFaBlhYHn+K7lUsD95CESSj9pTBC1dBpbiNPA24W/6rXSb/R9aWyFbhPF/99o+5tglUfBBWr9c3vktEZA64FU5G4R0z5ZG5XB8S4ozH1/NSp5gUJbUNqGFtvnb50BdUewvE7WsMkmrcTEWCG71WU5oeNCu2xFTuW365/qYBjJi7VUBOnj3g+u6oXYZVEorJhFda4HH9k1TA1oukW2nTB9naJl1yfL4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVErIqwH9I4O3Pn/juYAVelGuiimhPBsdkLvccznOTI=;
 b=BEn3sIm/4r7ZE8y/dwFUlITnDRzcDmZXL63WUu0VA0cyi2S1UUp+sYFcEH6HikpNHKGqnBwSntFt1CXnxT2ERZA6ajQjicLXtWpimKRudlgw8KweQwcrJvJuK+YRkv4ZOxQ+D3NWvKpHTUgw/VknoO2AAlAUaDm5ICwQmyuaXlw9IW9+yO8J35ctt2OMWnlgubWluk49cAJeKELUlp3OHEP8lacSSXd5RMYRrIWVlloA0vNXnrscyW8CWe0af6CPhTUNhoJGghfADKZ+i0aARHpiXkSoDhiVnhLS7r83VFH/YA9oKhCzAT6N2JNOnTAlVNqaeQnVn7gMIyeginJ/Lw==
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 15:32:48 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:610:4f:cafe::ed) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 15:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:32:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:26 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:24 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 0/3] Change parse_one_of(), parse_on_off() to strcmp()
Date: Wed, 15 Nov 2023 16:31:56 +0100
Message-ID: <cover.1700061513.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 913d76e7-4a43-4f15-fb7c-08dbe5f01f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4TLcrQi6pmHxxGTRGi096R+/6MGWNi8iIFm1Wc8JZmtvmT61lMnsD3qAhRvCwzpLndVbh9ycuq3obgMdv5c7NKSu9W2uhjLU9U2BK518bQQCqwgHbfFFQ+RxDKK0zcFTvnW8ZSY+ntL4dovZ+ehRGL4+xCpHXj2/3XJ1aExRyoFhhM2kcn+afrK6KtUm7tKZUIjD7jgQyoAbaaDeh1YIsgUprbyIR8tI0zKyTo98eGEyyxuJ3SgxZ/eDsEv970R1yCA1ndgq704jNdAPehlhYwbFK8EYySx1QJxGuh+3sKitjsJuxvZd7ZYAnGdRf9wzDcSc5XVVPRJ9GwGm5guCp8HsbjBwgIkg9GmeWEs0EAVqc28QfQSQMto+ABLhcG9L7KfeQFeDsHaK1hkUtZKQL4Hn9ZGESNGeCk7vwgzBreUdrxE4D0PpbqPTotq4QBjtfZcL0kwfmWdu2IbhmToXDfwSFJGiwVFDmr4QpuvwDfLboluwkybbFBJpS7vpwOY8U/17LyM+sf5Ki+DcTnP7HUxjRlKyOvsfeTuGc8pI7ALvlH2ZpxPSmuX1VPWX86OcQsgKhyE5ZDm/jIj+Patu2R5pdkw7SP7I/bHGcmqIqBvYTQccYYs97VMiX3uKN121DYAzMUDkE56V73iB+du51I41BtkWKre8QHEqrqTC3B/FzQHHzo8e9D4MmyIKO7FGoCmikeeEgvu/de2VBdY7/u+TT3zi9y2PyXNfwA3bnyDUuRtHDExtInF6W7Xy+nZY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(8936002)(54906003)(316002)(70586007)(4326008)(8676002)(110136005)(41300700001)(5660300002)(86362001)(66899024)(83380400001)(36860700001)(47076005)(7636003)(2616005)(356005)(107886003)(82740400003)(336012)(426003)(26005)(16526019)(478600001)(70206006)(6666004)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:32:48.3314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913d76e7-4a43-4f15-fb7c-08dbe5f01f67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

Library functions parse_one_of() and parse_on_off() were added about three
years ago to unify all the disparate reimplementations of the same basic
idea. It used the matches() function to determine whether a string under
consideration corresponds to one of the patterns. This reflected many,
though not all cases of on/off parsing at the time.

This decision has some odd consequences. In particular, "o" can be used as
a shorthand for "off", which is not obvious, because "o" is the prefix of
both. By sheer luck, the end result actually makes some sense: "on" means
on, anything else either means off or errors out. Similar issues are in
principle also possible for parse_one_of() uses, though currently this does
not come up.

Ideally parse_on_off() would accept the strings "on" and "off" and no
others, likewise for parse_one_of().

Hence this patchset, which renames the existing functions to
parse_one_of_deprecated() and parse_on_off_deprecated(), respectively,
and introduces the new functions in their place, parse_one_of() and
parse_on_off(), which use strcmp() under the hood.

Petr Machata (3):
  lib: utils: Switch matches() to returning int again
  lib: utils: Generalize code of parse_one_of(), parse_on_off()
  lib: utils: Add parse_one_of_deprecated(), parse_on_off_deprecated()

 bridge/link.c            | 48 ++++++++++++++++++++++++++--------------
 bridge/vlan.c            |  4 ++--
 dcb/dcb_ets.c            |  6 +++--
 dcb/dcb_pfc.c            |  5 +++--
 include/utils.h          |  6 ++++-
 ip/iplink.c              | 15 ++++++++-----
 ip/iplink_bridge_slave.c |  2 +-
 ip/ipmacsec.c            | 27 +++++++++++++---------
 ip/ipstats.c             |  3 ++-
 lib/utils.c              | 44 ++++++++++++++++++++++++++++--------
 10 files changed, 109 insertions(+), 51 deletions(-)

-- 
2.41.0


