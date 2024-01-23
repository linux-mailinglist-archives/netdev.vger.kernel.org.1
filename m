Return-Path: <netdev+bounces-65125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246978394A1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9288C1F2921A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AD64A8E;
	Tue, 23 Jan 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkWqc9DD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2A64A87;
	Tue, 23 Jan 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027279; cv=fail; b=Wn2SY5l7nzhxclTK5lFtlyQ5O2aVG/sWv2HYg6m6rAkE6wAniLs2FV/6KN3eSoVtnIIIImNNO2ZMBMT/zUgAeg5cWLawHz5zAMQEgyukxyYXMIGufuhX+iDuGvjfQ++BONAG3tTHeYs2TTDD+OuuhOy77XTpG1ca90Qg/T/C6W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027279; c=relaxed/simple;
	bh=MuloW8QIj+xxWH5JR0n9TUnLTN1v+kdTnRXO2BSeECg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dmiFUsRk0oyK+h5z5Ubp4mLs1bOkCeBAQ0mEt5ofLNDR80EEroBzXmRlXEeTcuUQbW5GJUILiOsVZOlrssz3tRjeKSel2YzdSEKFq9WONhXUIeHt/l7wBdEzke19FuDJN6njAK8NasF8tjROIg+scQeUEonfWqup8+W5oA0Sq10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkWqc9DD; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKZvpPavx4L/orgH67IukrIQWIFdq17A+4CQn6EOyiqVTWBaw/wyX/mOL7MMDkHOMKNZr2EpDzcgO7HLy8Md0OoCdy0RzOiC+1qfVCVnuQimiGA0ZQNMcOdrbsqtV2BbDDiC81vCoPOXxqVTWXaCh9G4qbiEmQdmiqLgC+7Lb/5zCLaE5IVjSxMbKIS4gg8e34wLPC7oW2Qr5cWcnNaww/3Td4wKaAxcB0NAOUaGGYNoV9cC8dezuv9/EvCFABBM8RVz+LRMBuzZOOOv4i98hjeIDVmgYeLiONE5cBlVga8JdBukDHLgPJhAxzgmKz7EL1arUz8vT1qzaakjirlgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuloW8QIj+xxWH5JR0n9TUnLTN1v+kdTnRXO2BSeECg=;
 b=RsZ4Lt/uY5jN+7vAN25ZrkbvF+pC5Vi6xwO2csPMvo+fjaFqhBy3wJ05/88IkOQu1A3ty58t+szdQ0dduf+bDHpsab3zROu0135W3UDg3JQy30bxANRFEOx63ufUNVrkcRU/qQNKfI+T9sCS+phrS6zsFP+TQGdkp9Gi6IZBzaMpRZx3fE5AnwxZLKPTMGpUT+RIOXHnZt3JkIB1pn+/RUZe/ykkw8J+XCU/IUbF42DzfIebNVRbNgT68msWZwDsFusN/Wh1J0aNOLtin+185mow0kX9pIgnAwvD7xrR0DTMyK4aQKJhV58YTGN+ptAk8UUFpmHbwJLyPpzZvtXSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuloW8QIj+xxWH5JR0n9TUnLTN1v+kdTnRXO2BSeECg=;
 b=fkWqc9DDYad1xOslIC0v7jzr33NM8aZIBtCh5BNr4a+fzFwZLAwrr/Rj6EQ1h9TPtRhik9kCXB8XpYs/TdIPa5cDlJRsqMidU66yBfI5qE50yZDREr4dt4KJcaYLb+2w62vf5ljVtp5ViwXBR750oazH2XUnjqWF5acVTblvl9h2AZGojC0oY9kYox4r0xXPrfFkXtuxZMc2/zcMGgNZ3gPGb86Ews9gbN+UW0l0m5MVko+2IpdLQhR4JoXGl+oIFsKAaEs0NOahxFRiOo9+Y/2VmNCDbkBEtu6JCQqQGLox6mQpwl5Ys1SFo7hiCZ3V7gjDZYfw7TpBeHq9rmh56A==
Received: from SJ0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:a03:3a0::29)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:27:51 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::b7) by SJ0PR03CA0264.outlook.office365.com
 (2603:10b6:a03:3a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 16:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 16:27:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 08:27:36 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 08:27:35 -0800
References: <20240122091612.3f1a3e3d@kernel.org> <87fryonx35.fsf@nvidia.com>
 <83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
 <87bk9cnp73.fsf@nvidia.com> <20240123073018.0e6c6a13@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Matthias May <matthias.may@westermo.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Date: Tue, 23 Jan 2024 17:05:12 +0100
In-Reply-To: <20240123073018.0e6c6a13@kernel.org>
Message-ID: <8734uonhfv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c815a1-4859-4865-340a-08dc1c303ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z55Qg4vPUx9hoKZ5uWModTSapvue94luHqvoE70Js9ZydhTdDhKpBOc+GXRF/Qo6P3mrhHz7TcoYqNhuQZXtZ4n1B3G2KN+c0apU6vWbSKYKh+/KdMWdPoiHid3PnYXaaLn2350VC69pjgA85M40ZVEVaODVrtBoWFJ6aQ7FVCUMV1H6XrNvSIOeh7p3AhAd5ioW7bmuWsTeSCXs6JM7MkRs47t7w8dvlFvY5bFXMXs+j6IdB3N5dW2FHQ9bMxeN+mtbNTUOjbWml5lE3mE49OrrjZ2DcygtafSMTn2CKdoKHuCTddLLHk241h4ExaptNsyo2X/ALDfI/XV62XXHiHwsTsmvKyV4aCZZvPqBHlX51kKGZrtapKalE9xTypzBbN7RKrcPbO48DD6kDCSz2oBHGEFTzhj9n2TKH1Vi9OgY1oqWeRQAeO/Fbu55m6VLsX+pVLCK2Vo3GtSpd3r/hJOJ+hkTQ95ZQSBpsUBZhgzAMeUvgEegzgrAtGvp5mhYJU36wvoNnrc68S39g/V+QSN85c5+b4i0Fv1BG7kEWlWWbS+RVhsb8l0nq/Vih4cSww5rW3weLx1AfP5e5T92Izd5znOsqPwOGMSmiuE9kvLuf30ppJJzzK4uW6VsEzu2QGyOMzjDMUG8uwlJNfE95xHt503yNrJ1TNPyY/2EivpIzDzw4sfm9BBYBRRQXGh4HPqC7E9UJQRM/tHlGFv8wXNgVj1RwH42go4HTfvHCPWGazX3S0nKbjzfGBdIjyDU3hpdTj7gMSxQ2WSomKWEcA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(6666004)(54906003)(86362001)(7636003)(70206006)(70586007)(6916009)(356005)(316002)(36756003)(2616005)(41300700001)(26005)(4326008)(5660300002)(47076005)(8676002)(8936002)(82740400003)(16526019)(2906002)(36860700001)(426003)(336012)(478600001)(40460700003)(40480700001)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:27:51.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c815a1-4859-4865-340a-08dc1c303ea7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 23 Jan 2024 14:38:24 +0100 Petr Machata wrote:
>> Matthias May <matthias.may@westermo.com> writes:
>>=20
>> > Also there seems to be something wrong with ending, see
>> > https://netdev-2.bots.linux.dev/vmksft-net/results/433200/81-l2-tos-tt=
l-inherit-sh
>> > The test outputs the results in a table with box drawing characters (=
=E2=94=8C=E2=94=80=E2=94=AC=E2=94=90=E2=94=9C=E2=94=80=E2=94=BC=E2=94=A4=E2=
=94=94=E2=94=80=E2=94=B4=E2=94=98)=20=20
>>=20
>> It looks like whatever is serving the output should use MIME of
>> "text/plain;charset=3DUTF-8" instead of just "text/plain".
>
> =F0=9F=98=AE=EF=B8=8F interesting. The table characters are not part of A=
SCII, right?=20

Yeah, the table is UTF-8.

> So it must be using some extended charset. Firefox hid the option=20
> to tweak encoding tho so IDK what it actually uses :S

My guess would be ISO-8859-1, but dunno. The developer console shows
Firefox has had to guess the encoding, but not what guess it made.

It seems weird to guess anything but UTF-8 in this day and age. Maybe
the logic is that modern web has correct content-type, because it needs
UTF-8, so if it doesn't declare encoding, it's something ancient.

