Return-Path: <netdev+bounces-71468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54255853718
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F281F29DE1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D85FDBA;
	Tue, 13 Feb 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YrRyhCTP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206685FDAF
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844734; cv=fail; b=KFpuq5UqijECP0Va7IDfXo6gOfdOTGFWc1rbcyh/BGW8E3wg3UXaNnCbbXe3y3PEMhE0Mr4MDwJ/oFrAJFNbYSRIsCLcOOYaWOLRF0AxSQhgD/QHyPoeHC9CnN92rLgrOyjkN5Y97UbApC2sxHFcHhpCsfi3tHJDvwZISwhAkyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844734; c=relaxed/simple;
	bh=/Fkw/MLGrxGz1juy+Bvbo6tMmFVou60YKeFVkFmto28=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O4UIN7P5Mb7WOENzQZtwZ4JPTIgZu6zFgfmZPJvZA2+SbxjQP8GklB6/W3hiX/1bRkUFlsLjj9jvrM3fMyMruQE/76ddhlSSm/L1cngQ7yJ5vtvm2KywDeCvzn1IQwekEZQP0M+UcmQPdeunex6ObK2bOozy/6b3LoMf1jcyZOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrRyhCTP; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/hI/eoufFgqa+F2fai7r00JBx8umkY2/MXa1y61vfi18TsjNXXhR4JxcJSKCqIVmpVn5Hw7txrR3cXvSs4I1cMei6CE2YZDlxRK9WxAlb+huw77mjAcb6uxCCmsxsrCdrRNT2RZ588M1xDJ26aS98TUytoQ4GbGBhSfpG8WxRg6VQVVzoml1HvMNAmRwxzmuwG5/z5Ih2ANj++g56dB82mK0ooDwJ1sgoH4fmnjzJvk/37FVRL8WaAu/11Cy5dZAP/KwxXuwFVSl7EIUmKOm6sXwfkrEwlPwZKPp1eqUYPgMXQohm+OO6kflA5h3yJa2vcfeL3EDft5F8CsPXyRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLp01jAL3592x6L7qYo4/nheJVrVQCGOWpAt53qY5sg=;
 b=AX81XR7IIWk/sQrFBp3pZnTJzAXOQwO0nYWU05HE5RRp/rtuvzqgUZLvyKRTGp7x9Sxqr4DyJTyvzUFzm6Awjv9VRoLAuT3PiFAYjxpj7u+0oTMSpfz5v0se1oZKC26holdUeUZF+hvszNp6Z9mY7YInmnELnSw4tXDUyqSeKOSnUufJo2JTUsRxDig5Xk48oZPT8FerWHsggNCSS5zIOVS6IsNG0DMgYOwoS/5gYF0xtr7Fgemlgcl5XD81YBvBX3WFLo5U/xVJSWFY93MogLpDRUJaEUPJ/zmjTCsk91s4/m7J9lGzYG1QbTzMgH1AvIeBL5fKQVIOJfgN0ROz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=idosch.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLp01jAL3592x6L7qYo4/nheJVrVQCGOWpAt53qY5sg=;
 b=YrRyhCTPJlwdkeqyJleTE+rvhb7Rl5qjmPcgC1o6m/SiRGfdORqOt9UW4Hj+oircA6UqkpLYRAQE87poHAxQy/q+u3TbUulmkBcjdDIDc4WYfD0O1Gxw3YBvXR0/MgfpVRz/JiIpk5kSFlnBQahYTm0hPj+ldVHaENrDLIhce3uMAbmm/W4YQYiDpQKX9RvIKV/A9tLoommvdH8aaC9ftMBgmhw3R4QEbDuY9NW3AmvfHE9TP2sTS163mLqoozh7jo3kkgUrH3nSsBA7DS+IvsisxgNDyhhdhgSygIZyqYoklhwRiWJviPeapm9W2uZmKXOiJCc1u1gO1Evr8OT/KA==
Received: from BY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:a03:167::23)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:18:48 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::37) by BY5PR17CA0046.outlook.office365.com
 (2603:10b6:a03:167::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 13 Feb 2024 17:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 09:18:35 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 09:18:33 -0800
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
 <ZbkIFrruZO5DXODm@nanopsycho> <20240130101423.45b0e1c1@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@idosch.org>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config entries
Date: Tue, 13 Feb 2024 18:17:31 +0100
In-Reply-To: <20240130101423.45b0e1c1@kernel.org>
Message-ID: <87v86si8pl.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: ffca00c0-1868-4e0e-30e7-08dc2cb7d6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IPRByk77TKpD2PmRN0QrKdoZuLFWzklxDnEgCiJ02qYAG9YsWath3LZF+FTaU+VpPYtbFzl8j488wSHX4UWMh3lMVQyk+E/ExeynvYrx0eO5Wvb7X2ShCaY8Skpe7XHlLq16TMhyg5XUdHiPGPnbuVebPxtnGVmtWv2EHNRyBkvpIcCKOZiACqZ66hxoM6RoVHgcsl6lInj5l0UtRksc9jis4wFVCyP6wld/QPDg3aSwmxBvs3IPSBpp5X/zRB98YOs7yFDXEobi5GnskWBs9Sx7X/OoxAZrd+Takzz9Kf/u3LU1VekPy/Q7gMkJawcj8NF9Co7gZMeN0hozGOQh6YObX3A9j/DAQ2SB6MGBGyUcpB5mT5Qpv8niBuQ02ct5k566Ft9HpBZ6eOEdCcOmAm0Cz+ufeTfntWTTuVyieouIS4RByHbF7ze8UH0Hl388d+WPGgbPSPkno56VItLk4mWy3bF7YzIWXDflxZ/YG4XU7Rke9blqM3iqFqtHGmXdHsGZm7Gxe7+HRhkvuPaFs5sCIBTbUiPUduuV3NalQ5mLnq6nFZn+EB/DfisJX1uRzAcOx9O1sWtfW6OI1PzZkdWtPvd00nx2EBtKNciYIT4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230273577357003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(478600001)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(4744005)(70586007)(54906003)(6916009)(70206006)(316002)(26005)(83380400001)(336012)(426003)(86362001)(82740400003)(7636003)(356005)(16526019)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:18:47.2896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffca00c0-1868-4e0e-30e7-08dc2cb7d6c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 30 Jan 2024 15:30:46 +0100 Jiri Pirko wrote:
>> For me, all tests end up with:
>> SKIP: Cannot create interface. Name not specified
>> 
>> Do I miss some config file? If yes, can't we have some default testing
>> ifnames in case the config is not there?
>
> Thanks for bringing this up... I forgot to
>
>   cp forwarding.config.sample forwarding.config
>
> an embarrassing number of times. +1 for printing a warning and using
> the sample if forwarding.config does not exist.

I'll roll this into my selftest update patchset.

