Return-Path: <netdev+bounces-18413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D863756D4E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DDF281396
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F2EC151;
	Mon, 17 Jul 2023 19:33:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8F253CD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772A9D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixgNh5kb6RNVUI/NK6ReEHVrS2u5fZ5g8+vMPahanOaSzMDsamdbt9/VkGXQ2/cEN+0aIFE5/6Hl6dShay9mAJFkoLKBEKA9nTA1vd4XXhKl6CUhhjdYJIbDEneyeDlH/3YudX5Hzt9mcHs/Z3tE8LPObuPKuCOTSbtcuZ5y6Rb7Y1ygjZ/us4ylgavhy6XKE9XPQn/fjnhBVuffOMLUxq+sGOaQv9DEksRvCdNL8pe+kRjLPg/XH4WDMRJT9G0pUTyFrVRlAljGXZcnaVnRxjr43E8idAk3y+M+EzLqhJs2JC2aEsSMiVV5dojlhqdg6AxHUvlr0o4stREqKj/UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkibgF4JmXR5B2bbA2Ouc9uJWQ6x5PjNuNc6ctnc5y4=;
 b=Q6UBGQvWfuAC3iEMdo5QYrLIKAsqTQO8G10zNLRQU7UiVTcHZ9yU9W8IZG5vtvDF2IEw7kSibPtj2RfrgwYEZYIWm7k45O+LY7+y8CeDc+Np2TGcQD+Zp91SZO2Lo9X+LmeB6xyEhlxWA4wwAypwa9nwIQgJYUcuJLumj1zZEfJCB3Q+Sq3HuSEGrEmb1CCuVdkdEe8d2p3JuCcTZi8x09dQLk51IZWCILX3/17kjsmjMbMALknHC1KBlZP8Kp4aNW/xvI1lg+eiCcmOEO4fJKQeuzAcTxR72c5WJlNGyb+s7iWi5PXpjzpBPfzxQVjAODPY0Gemmwg0+uDKfNOSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkibgF4JmXR5B2bbA2Ouc9uJWQ6x5PjNuNc6ctnc5y4=;
 b=5Jh53sATw6A8vhmJ6prb4pj4vR9rN3X17CIDQWZ17B6gQYwuHrVh+mRqRZSEqbOuSDUwfCQJOygZWMEJeTjjM/jMNtCBdOUkvpujvcoAWy9/I9z6WiBdVUNVAu/nUVPAwicC/SfOjjmobBhAK71j2i/Aie45z9zjvSA24yhx8MQ=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 19:33:40 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:333:cafe::6d) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 19:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 19:33:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 14:33:34 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] mailmap: add entries for past lives
Date: Mon, 17 Jul 2023 12:32:42 -0700
Message-ID: <20230717193242.43670-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea9ce58-82d0-4b1a-818f-08db86fcb8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i/4VhKXPmRYWroRZ3Xjyh45CUiymKprfNrzq+MbD6mEnlVTyPrnRKEjXWXu6QjAJnYAs011O1n3mJlxFPWsGennGJAb63c7jrca3F88aq7D8yZ+XWRv+lnPD4KgF0A08uvZZBHwoj6tEHr5C4cnqxKs8WU8ClomIomiRd5Z9oIsjAW2C5APVYO8PRtbcptrXqA+YNbhpNJEmyg7ccyjnLmtpHio1rTVP6wKl9geNbSAaYPFEtojYkgAey/qd4OWnGhvg5bnm388HI2V+WkCltCoCSs06/H1bbSdZ9Yh6tKVCL/4AbPFYNmIewOMkcMsfJ7cauVRp96E00b7FYL5j5+n+lq4umSKLrMYRUl5Z8i176M33e2EhcMLr6VxI65YqHHXB4mq2vgWK4fizv4fcyMDzgGmVFow1gctZjusBzg9kcnN1t8biQQ7VP6XL5qt9+g7R1Gf9TTtVgHaa4oaZ6+RZluecxTjdXBn1klq7FSm2yXMLyKhqzA4Bms3kktxfnQ/clA8TDgWNszXRDc1ndm+KT3NfO+hHK5bpCDVP91mL52TYoxjQIQjw6DGU0O2/EYCivQoHPuJZ5fJvjESyIOB1LBEF5UdRml2WXCIE9HHkYyaR3oIB3QC+8zWOvqvnPUDqq38QKQhYvFmWav/aMhDB4Fb+Lsjg3gRDU0iurgmudnFj1abPQZgcpB/mj+9GZ1Y19+Ba7Wj6uY37NIxT9tq+4jbGUxyDqm7AkikxfAdGUdt+0apfAg+g42u8989/kzA6+oWNHuZRjTuPI76GVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(2906002)(478600001)(6666004)(36756003)(4744005)(44832011)(8676002)(41300700001)(316002)(70586007)(70206006)(4326008)(110136005)(82740400003)(426003)(336012)(86362001)(83380400001)(47076005)(8936002)(356005)(81166007)(2616005)(16526019)(5660300002)(40460700003)(26005)(1076003)(186003)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 19:33:39.4270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea9ce58-82d0-4b1a-818f-08db86fcb8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update old emails for my current work email.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 1bce47a7f2ce..3af557de8e73 100644
--- a/.mailmap
+++ b/.mailmap
@@ -453,6 +453,8 @@ Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
 Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
+Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
+Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@oracle.com>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
-- 
2.17.1


