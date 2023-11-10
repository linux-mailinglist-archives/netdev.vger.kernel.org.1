Return-Path: <netdev+bounces-47105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299857E7CC6
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958EDB215FB
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE61B26F;
	Fri, 10 Nov 2023 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nqehZCSH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27F168BA
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:55:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9063821F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqGQP1ETdSfa/AWha4kOsuKIOrNZxHs1Wfd+U1eQA8mJG7/kg83fz65QuV1u4nj5iQAW4IO/hSGoCr7n6JadVdZw0iZdfUoXoQGNgCWteG1FkRE1Da0KFLlppVxDdXEeo9RdAyiSxz8HItU7IGzc7/by9q+BhhAlT/P5MWcnpglS070OGn94qfuxfWXtMikTcHQj4ctZUqe/wyyjfJZUvYTipxOpJaQ89sX4M8hf3mofYfbgCM/Xxa5F1DR9ch2Dg4iTEzRhYFqVnsUQwjq7adhW6zLAOuefkXqctaiM9Tk4gWtPgDdMK5JZbA79YlriTckhjkeUqNMutjWBDJe/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6hh4YNLB4xatMwYf3ayLxC6c/JdxDNMlA9rD5x0ZXk=;
 b=kkxlcCevR3hg3Qz8kBgnhOubsENFtd0Px4L/Frchm5x7G41dsp2lFSalDDHhPJ6HyKgyquoa46jyKOXGIBqzaOVmQZDGLAJ8wGUK/saHgLrA65XMfvmQiClC7HimvI8Wc+kxCY8pT7a8tTVx9DLOAsKLdJvtNkI/mvVoSVNS8MipWT2H2MQ15K0xAda1J835bT1SGOA0koxL37kVIAXd07R/CkSAbAycE9eCWUprubF4A5Oz5vywbAeExpyxFkHPF/chdXfbsU8c+jXh/ZmXgWS+MhuAYjDU6jLksmHDFKkA+2mXqApcnHR1aA6LXVR5A+1XVlTfvW9KwcrMyo2Qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6hh4YNLB4xatMwYf3ayLxC6c/JdxDNMlA9rD5x0ZXk=;
 b=nqehZCSHJrj3vROdRW0XGlWV7yk6EJ8oSZdWPlr1KAM9Xv/fhbRvtb+hDtgUWpfnhqLjTO5PmRzUvvCSMKJC6hU3AT1UNRkobgHVUW01o/h+oPsi9Ic2rRF18SZipZMwcA1SmqIFG8BqWAXsAyqGq+rujWuS71z6SsaFIYd5TWCoLEzwBYLzt+U6crvVbLKTMEaXAgQxCJvnoy+95B8XHjANmkqgiRXN4e0WlvtaEsyvMVQ1F6QgxeC0wReoG5ARbDsR4b1fiJObIX6nvWGDL+5ITjNMVRv+4ts0jx3mLNxZQjnMd9H1jQgEb2Pa1CjIa4L6IrWATFkEz1b635J2Pg==
Received: from CH2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:610:58::34)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 13:55:15 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::28) by CH2PR20CA0024.outlook.office365.com
 (2603:10b6:610:58::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 13:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 13:55:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Nov
 2023 05:54:58 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Nov
 2023 05:54:56 -0800
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
 <87fs1dyax9.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: <aclaudi@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, <luca.boccassi@gmail.com>,
	<netdev@vger.kernel.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
Date: Fri, 10 Nov 2023 14:54:16 +0100
In-Reply-To: <87fs1dyax9.fsf@nvidia.com>
Message-ID: <87bkc1yaqa.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c92be1-a0d3-4169-9e50-08dbe1f4aa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L/GDBAcuXse2jPMlOYDRnTSyXWM0FtEoXCPpeP9Pi5o73Zaq1APrARk3LGuncxEYrCAtx3iUw+tKYdDa41brpH89uL2Cm1e2EPtGz3+Rs6wl8NK7alIu6wpmoH9/8kknRFmzd1Hgo+Wg/S2Syl3ilswFbtg32ZNlZiY/d8cgkutyhpD7f1qyaC6UcD/Ss4Os2qnUlcr9GeCCfrSE52wbqa2BzgKRLTYRvCVp5mC93uEohWU03iOmsBhJil+REFnbJ8paG9mDDQf09kXb4qTW34Y0AtR0pDNRYeHiSmeH0ogoz/ZF+uduZE2tXXQTWQhyDmZ2nM8RJC47sKaqhDF3xFXAhIHi0jg274lrYer7ozR93F8eOmPy2rf3urU7G3+cmk6bb9Z04VjH8z+45G6qSyAB6G9y8I9iLfvmoP1e6lY0R6sITUDnxOBTcWz8Eq56g1V3sDwuBx2OwVi9AaBHzglxrDc+2Cmve34XmwM39kVqlbERR6V948afN97+TCCpZMzbKeoz7l8FfvczJv0UE8bBUcCr+1jmH9E5NasBXWfygECeDi9nDNZ0N9ft3O/OHPPss3l8KdfL9SGapf927dhy7p0fOm324LRk5Y9HvlIjAfKc9pp6EaovTOm6PolXl4tNyMqOjKuLezT6f+G7VTR3pPtEIwyfyY2tWFfbiIoJRmQwy8fuwv5Uq5uMQy2L6ag+HNYQ+XGZuQbaUP8aBkpQuT3F40ycG8y9Ic+7enfbQBn10S4M/SD58zAjyJpZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(36756003)(8936002)(83380400001)(426003)(336012)(316002)(16526019)(70206006)(26005)(6916009)(54906003)(70586007)(2906002)(36860700001)(4326008)(5660300002)(478600001)(47076005)(8676002)(6666004)(2616005)(82740400003)(40480700001)(86362001)(41300700001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:55:14.6388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c92be1-a0d3-4169-9e50-08dbe1f4aa44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490


Petr Machata <petrm@nvidia.com> writes:

> luca.boccassi@gmail.com writes:
>
>> From: Luca Boccassi <bluca@debian.org>
>>
>> LIBDIR in Debian and derivatives is not /usr/lib/, it's
>> /usr/lib/<architecture triplet>/, which is different, and it's the
>> wrong location where to install architecture-independent default
>> configuration files, which should always go to /usr/lib/ instead.
>> Installing these files to the per-architecture directory is not
>> the right thing, hence revert the change.
>
> So I looked into the Fedora package. Up until recently, the files were
> in /etc, but it seems there was a deliberate change in the spec file
> this September that moved them to /usr/lib or /usr/lib64.
>
> Luca -- since you both sent the patch under reversion, and are Fedora

Ugh, I mean Andrea, not Luca. Sorry!

> maintainer, could you please elaborate on what the logic was behind it?
> It does look odd to me to put config files into an arch-dependent
> directory, but I've been out of packaging for close to a decade at this
> point.

