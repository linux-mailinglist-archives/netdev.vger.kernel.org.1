Return-Path: <netdev+bounces-37367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056087B508B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AC5212822F7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2DD51B;
	Mon,  2 Oct 2023 10:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AFC2DF
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:45:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C1B4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chvo8sL/oiZaEBzGOmu52XOMR8tsUogfiSEPrYI/4vYK7bC2ckrPKryDmjiE7qsmHakk0HgRojbi1JIfVn4cDJlV809he1xIrOS2rHAfNI6HdiltXpN09f82kgDNXtckzVu41P+/Ldd0dd/FPe1tMaXX1ksHz+bsDoSVP/APqsUV6FS4ib5yKb+hhjbks+VY4Z5OuIlf7BMFRPUZUuU98t01LQLV6Zb/xRpC3G4NF5awBTFO4gSwdqFNIUnezn0t0FEv2Tejmw0PIudhIw80WsCdb9B24cAlNFwzHtL7m7lUEI/8M08hoXUYJP4hvoPwvZHj6C1e6PITrzIB93Mb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3iDf/ouLwvPgEB9DwJWpPZV0VFYAr9dvQxYdp0Otcs=;
 b=D/sA8z/1ZNzagwgKidHiXFrnL1JB8Fjn8yCZKHw4/9X5Uq3RHx15VsCGjr7jkKG37GjGgoM6L0isNUXaAFz0LH2k0ykS3mYA4kP7rdarHPGEycBtypuewo76ou7npLWOXBjWprkpY2iCEaLH9A4dXkfeYPfzLkAwGRi9oriTA0ffovxIorP1W7dQjZf7oW8JeMRJCyDDMOz1cIXNfNtzCdeSCQIF83TENmhEmf3TcpIosBdvPXbqDJrOrjVAiKme5bB57ZRIdMZ7yaUG5ngfsFL+wEBxQzQ54zgQNhUy15AAiUukZP5mVmTFZT8mL09nhw0brNoCUEl0KNOQsvgNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3iDf/ouLwvPgEB9DwJWpPZV0VFYAr9dvQxYdp0Otcs=;
 b=U+Joh+XsNKDI724HafQyWXoBn2LK5ncSFChe0LqNRH7cI8hvwJdQHjPniVyKSl89pKNU7m+kZSz+bjylFo1Je/4ZxPApOmqWcFWgpBUfDp/zIv7PsO33cElXQL1JwP1XZmlt1eqV9BTFAghsgorqEq9lQkWr4YZGw2I4gIFwVWlp24kgzypBIUtLkMtuscypVNC/oUpedNqi5dno92r2B8g/dbRhej9/iuV2C1j/kH3Zukm7vdK15yzKCDADZvXr2LkBWX2J7r6mJ9HPRq0mQOyWBUXZLnqldw+8J+nzZmHupN4mOhyf8NY/rDtTzXl4OwrvoWM2Tp+THLbAeP7YLg==
Received: from CYZPR14CA0018.namprd14.prod.outlook.com (2603:10b6:930:8f::28)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 10:45:04 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::3e) by CYZPR14CA0018.outlook.office365.com
 (2603:10b6:930:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 10:45:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:49 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 2 Oct
 2023 03:44:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, Dima Chumak <dchumak@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH iproute2-next V3 0/2] devlink: Add port function attributes for ipsec
Date: Mon, 2 Oct 2023 13:43:47 +0300
Message-ID: <20231002104349.971927-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faf4d38-9ef6-4657-aa93-08dbc334a2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zaDel8JfPcyVruxsjqXiXrgXi6gOopdYd4qwAcpQCWN4f4318HGwR18UeXcO/P06EFpKzuKq6AxQSa9iPzLRkTrGn35v1O2dCaLPz46vTJYqusEImH7MV0p1EJvsp6a3tyhGokPDCS5M6KxuMNnmYEEGhlvxmBegeJin66qztahdaPes7Zc/JyMLEH8qTanDtHoaU+/04KWlTgMYumVbTM6nIruIgAckV05nUSri1pv1kG68cnggL/Ul5FLjPUJDzul0nQ0RtRlSI5fYA/Dy75UsedJHbTaYuz+hzmGXn5BL36ErCc6qynXuByT+iZD0G8u4x9nJepvvcJy7x93fNxCGzjbHMvuLhyisMEbfVfNCEtcX/NBzzdVpdBk1ja0dHuR7W5ZGNoeaGgxMKIVJN1fjf+R/lroM3bhdunQMKj1tZHsq8Til9Wqs5H15YVjSCe5h/9zrcKzRS6MmVBXqmQtA6L9Kny64GBILrTtEY+QKvibFRb7rP8iO3L8j847WuJWtiSt8kUv1VSU6fyYAFNdbm19x0TWOyDJpyv7E086SWiw7UmrXWG6OvZ266RxJFALarYEFL+ydiZQYDCGCl3schA929fMWb0/4WvHmSYJ9VPnrcuenstZF6NNcUjsiMsxUV3NcyxPh/O3wuGVczuRyUvBvMIgwjiMnVyYulNqihltbIv89ux0x2xflPYfTbyD4irPMGnIWPfyZbz6DdANDMMigPzBpfN7PH0RVSlkckHvk6wyJ73JYeInGzR3UAWAAn3Gl2KTeXABrL/LcwvxfBXGUTXYLo2gwxY2E72I=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(2616005)(40460700003)(478600001)(47076005)(4326008)(107886003)(966005)(426003)(316002)(70586007)(4744005)(336012)(2906002)(8936002)(110136005)(54906003)(70206006)(82740400003)(5660300002)(41300700001)(36756003)(26005)(36860700001)(8676002)(1076003)(356005)(86362001)(40480700001)(7636003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:45:04.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf4d38-9ef6-4657-aa93-08dbc334a2f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Please, see kernel series [1] for the overview of these changes.

[1] https://lore.kernel.org/netdev/20230825062836.103744-1-saeed@kernel.org/

Regards,
Tariq

---
v2 -> v3:
 - Updated cover letter.
 - Rebased to latest iproute2-next.
   As a result, dropped existing kernel headers patch.

v1 -> v2:
 - Updated cover letter, no other changes in devlink user-space patches

Dima Chumak (2):
  devlink: Support setting port function ipsec_crypto cap
  devlink: Support setting port function ipsec_packet cap

 devlink/devlink.c       | 34 ++++++++++++++++++++++++++++++++++
 man/man8/devlink-port.8 | 26 ++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.34.1


