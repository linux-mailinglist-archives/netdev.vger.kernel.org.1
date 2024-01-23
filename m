Return-Path: <netdev+bounces-65057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55973839053
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050CC289196
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96705EE76;
	Tue, 23 Jan 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8EoqhA0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030EC5F542;
	Tue, 23 Jan 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017228; cv=fail; b=kAbUMu/GUWC1aIx/DngZKH9uwXeFpY8mS8Uyg1Pflyl9ZQSLetsaYZEQNw9DS3h3fUQKt7y6RXjtQ2fcBX0Xk2hvEOcLB1QH2OtjwOAZtwiYlJz7veEKDGS8H4d58le8qC/DzuHtAyCCaQWeYgX7CGzUKAGbHBRuEwcO0+k5fXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017228; c=relaxed/simple;
	bh=3knIhSI+/riJ1vDDOu/ClhroYL+dtZw7PhX4Z85eq38=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LmLj+mZIG4deKwJqhtPJimZpa9DRfKQ/lwVjV0sh/VRT0xh2RvXu8BGgM+s3YLYKgKh/N0OGwrZXl2fpMhxcFrS81bq9tSxevFhcdZ7mRVhLM7fc5RkOWKQlBUzKU/pfxxNhelYzMgVN9gyUbTnacO5fmYrMfbKrxovElBaYU2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8EoqhA0; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUNUj+WdV/jBS+VOZgG/XYPKI191NEIc+tQvn204tYvWiY5Rj4t+fZPsR9VJ8d6L9/EyD9L5cpqAX153aFknZ4JF3fVZpvCLDVt7UUjBPvnQhPjV/syECZ35A+Qfas4BmHC9LTQq+lar9pzD8tCkqVp4/cxxZNMfRyunx5j+nJ3znmlg5Phqf+XTUId9+iUxaP8IqVZBJnd2pvbLcsR+iWmXAfDJt2YxjtmMDV6/lMWHogYshGss8HRxfMcp6iMPXesoMLB2NQQu3PbwTMTHTqPJOCp6S+QPVFgs38juVYKwtrpw4SoMTH0rib8RhOAbCJXKts/6n0SuE+8jHzuz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3knIhSI+/riJ1vDDOu/ClhroYL+dtZw7PhX4Z85eq38=;
 b=dMSya7ojci9EcECsEjoKIkMZLVeo6Nvl9BbFq6uBjQEsAazGcZOkQl05sCL77bTSwp/AXshkRoAlDCl0GlTzbrCBbjZG/ElpeY4kUbL13cSqq+zkZrQAVZSZ93nrNpgNNk5oq2QORyXHDJFqbmo9bMYsbw2hOuO9U8MSlh4VgXdOD3lw4eCPiT8nqzd7AcU9fRCfZJMARRpx9z9HjjezNNoIyJ1tRI6qurNDiwBefgZEp6CIp35P08Zzkeof+hMzx+roDlfvp4Ju9qL3zps9y+vfbu+bcm5Hn24bCMwykIBL8KpzkAK6g9le+DU3L+nV4Ee0dibGfyEtDe4ZEoDCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3knIhSI+/riJ1vDDOu/ClhroYL+dtZw7PhX4Z85eq38=;
 b=Z8EoqhA0cv6uVktHr2znAJoC/yI7azGlYXSbmgGubxvxr/wUTEVbsjJjRH1/3ispNiXRrf35F8UkXs4fEEiQvXHNsvQOtQZWdfhUuvw9lBd7qMm9rijm1bw0xX1hm9kpYiEzcaL/eNtt3VL6L3PnI48+doPJByi2gNWOsInjpgMynBdLbz4ruvL5w7rkAHFH0ExQyNDyS241q+biyHCJx6NsnC7HgFtrUC19nt1elWCcEizYxw2rrMwbO7E44ujLRGOFzpszfIZoYTkT0ki9CgXX2QD3uTc90Mv1BGxCwYFQD452O8WDTbZocOGZ0lJV9dSWsEzc0Y636NzunePxvw==
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 13:40:19 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e8) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Tue, 23 Jan 2024 13:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 13:40:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 05:40:04 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 05:40:02 -0800
References: <20240122091612.3f1a3e3d@kernel.org> <87fryonx35.fsf@nvidia.com>
 <83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Matthias May <matthias.may@westermo.com>
CC: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Date: Tue, 23 Jan 2024 14:38:24 +0100
In-Reply-To: <83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
Message-ID: <87bk9cnp73.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f29076-51be-44c7-7376-08dc1c18d6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FlqbESc5+EximS9S2daNERTjcTuzws7J/kyxNPoe2sLcKFfJXpbTyjsQEj+kDqTyOmzen7Yov5GYjgb3RLrI5drP1qQuNBYMMcDgUOZNySTj7qJgHhxga1fVilVgNzHtkRDLM/UvRL6i+TCqZ4yiRZFgV7uguOo5kkaAcolLyNV6Xz98WrqsiPlBkdIf9sZBXj4TpEQkHHnLl+J7AUW/QVPI4O72AzEnjadxKLXl5ki8hg7J8qrOKwEtKfRb732rvmlf7Tdh4KKHPWPqabjmLN6/Ezh78mA6mWPwfvNBVwR2QzbOwqIwhi4mI0wt+cHumiVBwKjJNmz6TYGyqH/CR3AHccw7x0lZPMHAurauylSDKI9NbvEai03plaLEMrR3ASrRBn4A/gcer3HkgWgg1dGpt/dBGTXFGKLnd87witGnH9XzDn75SMkMovoh96bONSH944ZPwpvuO7rLcVdj4T+cVihyl6XJFqGpUbFGJYjW3amofQElD+865T+htc19v7jeNr77fzSEcu4DQG5v3AJ7O0KXiegALcL+qMunSfMjTPZ8GZ9px/yXt4Au46NDE27mpmsXaHx3B4D4JIAv6CNQ8L5ikBlaB6NwXQDY70dSM+nDANpb+PzO4mrxlWH2WzUE42kCbu9mPHV7qiPMwPc181VPR6dfskVraaRWkpsXzu/Z5Z688itjMx8Sl3745ekOS2vWAjLWngBSlIstQaRDOcIFvoPBwyoKxymHAie79TlU+ksOJvUJOJeNGmCdbGjfs6DMmsXFx0hMSyBZig==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(426003)(6916009)(36860700001)(82740400003)(2906002)(4744005)(36756003)(86362001)(41300700001)(7636003)(356005)(70206006)(70586007)(8936002)(54906003)(8676002)(316002)(6666004)(478600001)(966005)(16526019)(5660300002)(336012)(2616005)(26005)(47076005)(4326008)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 13:40:18.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f29076-51be-44c7-7376-08dc1c18d6a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299


Matthias May <matthias.may@westermo.com> writes:

> Also there seems to be something wrong with ending, see
> https://netdev-2.bots.linux.dev/vmksft-net/results/433200/81-l2-tos-ttl-i=
nherit-sh
> The test outputs the results in a table with box drawing characters (=E2=
=94=8C=E2=94=80=E2=94=AC=E2=94=90=E2=94=9C=E2=94=80=E2=94=BC=E2=94=A4=E2=94=
=94=E2=94=80=E2=94=B4=E2=94=98)

It looks like whatever is serving the output should use MIME of
"text/plain;charset=3DUTF-8" instead of just "text/plain".

