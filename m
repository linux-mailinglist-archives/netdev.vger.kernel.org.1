Return-Path: <netdev+bounces-195675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782AAD1CAF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BB188C9E6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048F211706;
	Mon,  9 Jun 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hRXNhBDv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1AEAC7
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469977; cv=fail; b=fycN+IH97oLnMrOAp93vEG0beJXPyvgWvXMcfIRWNCtk6RUvuehLMFGiI57UPdV9+5Q6R8ouzWKfDDHkSPVYzxfSUfx/Nz+ICF9HVxtiv8kZKYbkf0Ha8vtbQxBfibCS+oHncWmCLLcuAcXL6pri2Qdio5iz8VPTCTrKThOWVaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469977; c=relaxed/simple;
	bh=8laaE/i1hQLalK9OKunAMYJaOJFR2QhQpGVApcWQMyg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rmYVPzORyQ3nXsLVERYKn/XGCZvd35VMDh52EpNSNsjbbXq8eZ6V7r18sF4LpfoaT1P5CCywr6JlTCQFwNlJa40rlow7tNUEvHw0jzeC47lVL0hAYwX84E6aaw/x6eC0YQTBtfxKB9VqUALFgJi1cc8JqHMGc3b8SePujlK+PGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hRXNhBDv; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PciltpEdDTcgvRa1Scu0brEhM5+MndzDDIqMf2zUaDaCw8N7PEteeTEgrpYoy1zRZ/p0jjG3Kp2PZAMJnWw7+Z2ovJOlCKJhSfRdN7vjcEp7gcFltNNq29Q9WvsD1Dhl75lU071D5YLa+2Z+VCE0fOXUtxqpXUsXt+P3h9QhXYoWiPGMVJo1rpoz1lkFeWjiZloKvOneUi1inuRfcTs3jFikPc+dlt5nIZIzTZw54Zel0qfC5HQAay3IYdKSpy3n5nkZ7CBOoXGvQFKvAa+dL6gjmMaLYAqZABO0hCCtLZ5I4Cnz1t+rmF4eIICVSphds3QtKrM9CETbSsaBq3wilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU0W+mxZZ5ZojF7TOsu7DiBwYVKrHsB8VuE6p0yphgo=;
 b=Rr9oS+/Qo6Iv3LTIyeHCEXvtZbjDzcfvkWp5aw61w+yLChB64gEjuItp5cl0yO4jX0sMypmwU30A/NgJ+ZacyZ1B3QCl6Mfevu1NPjqNCnBIG/yCMCV4+NfLuuQDFCah9NeVgwLV3DZyy/JTyowV6oKVdIhplO2D2faxQRaBtKn/jGNe/sYhjauMyoDL4RZKJ0Et6WwKZ/iznVFK1mKb6xRfKlG0vr709Zf/t6C/sh6g4v05jlqMGRjWU/mLNaHxbAHagxly0ScFkqozLg8LZLC8x8zQGcBEoSoDz36m3fSMNEa+Sjcxj0HHB0Sn94K6ZZLsq4Zr7faERKhqKPovNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU0W+mxZZ5ZojF7TOsu7DiBwYVKrHsB8VuE6p0yphgo=;
 b=hRXNhBDvdr2+1Rvx+tcXSyKvJ8ma7gCw2in4JNutMa+OU8648uPGyRbel4/9cFgKookRolG8+fzdp7ssMLt9ZOxi3cEe83bCOjrs0J8gHnTtAJG582MryZ5HDwpMJhrAqWsecnlgO5ANBs2inLwnR3w2Ox3IxDafwvn+i3nZXsbyN8kA9X0jqbdOP3xabi6g0fFfCebumP3EJ204nPFIDil46OrbEvOaTvLW/FKx0W+CGh0LeoFlOiUQW5Mu8UHizJCjE/CgqdoMAbfByoV+9qmtGVHiv1eDVu5Z2mYxBv2jYlg+Yp8jNPcIl5AbSwYZFu+7XreGVMIVnR6B0hndxA==
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Mon, 9 Jun
 2025 11:52:49 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c4) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Mon,
 9 Jun 2025 11:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 11:52:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 04:52:37 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 04:52:34 -0700
References: <cover.1749220201.git.petrm@nvidia.com>
 <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
 <90f37ee7-fd3b-4807-aff7-313a07327901@blackwall.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH iproute2-next 3/4] lib: bridge: Add a module for
 bridge-related helpers
Date: Mon, 9 Jun 2025 15:39:36 +0200
In-Reply-To: <90f37ee7-fd3b-4807-aff7-313a07327901@blackwall.org>
Message-ID: <87ecvtf7y9.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: eac250e8-e3d0-4cdf-5705-08dda74c282d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hfGomVaP6/w99M5vkZ6pj3w2eZLZNLtQea1uc0djmSYpYHrwngi8ZrunYPAl?=
 =?us-ascii?Q?uhX7ka79BJaoZiqDZaDMmwxTyT5/QS5fcfAYM68uDboCpJA5bcq1AGv8hlBp?=
 =?us-ascii?Q?frL8NaiWWjJn8Idjd9mcV5dU8hmtOAbYotFf+0fuRyYMf/qVnpzC9mZ2lfyB?=
 =?us-ascii?Q?dbwBC9qL9MeutUG6rKVWvplyhQ6K9ZELj92FL2Tq0xUg0dObM8esGhyNQjnz?=
 =?us-ascii?Q?VmsnZURnwoZHFS0sc6HX2gfz5SvynZ6CLthMFdleSjsRgQjtXpstffa6Q0PX?=
 =?us-ascii?Q?D3BNCPbG6kj3/kT9T4hxejWn4u6Y7IPDXwSClwb2XOJhr5+aYW/jHkfmGru5?=
 =?us-ascii?Q?j92iM+g9UkYc2h+LCgUTsasSwlr2s3K4Le/nWC8TgUmuyq0qFEWzOioeJewp?=
 =?us-ascii?Q?8uOdqTcLotIwcZegPW4eubAGlSVHlAKph4pBNTHOSQ5YbqNXGdQwrl3+6okp?=
 =?us-ascii?Q?NZYS0Zk/bS4+t15aStgpdlwPb6r+xvC9MRXqm0PqE81cf6jIz36b21iLQOUj?=
 =?us-ascii?Q?Cfc+slis9ixn+x4J7rADfWNDhcOLkFzQVnc5TTFfyu8+mbozt5uqb3fyR1QG?=
 =?us-ascii?Q?aO6DOE5uFivjru8c+ODS6aSDymF235oj3eeuXKd8LuxuGi4AzF1gk2wJC5a3?=
 =?us-ascii?Q?/2NPGQ6FJfPdHoPW0mL1nqaIdKoPs5w547j3BtKsc8jJbxysCV1J5jehNoXc?=
 =?us-ascii?Q?y0euiyNc8rBl9LpmSEiF5dOw3MeFIWIaNCQJffqAFeWAHXwvpPl7PsAuTQgV?=
 =?us-ascii?Q?xxdqkPAXklR/bahscJ6AYU8CtVuws/iHYumnkDWVID5lIceOY61x3LBzqwOt?=
 =?us-ascii?Q?mXn6/vkDoA9T+voiq0D/CtbuAN3gbKoCdqE8/QaloJBjTpKymCkEK5CE/toT?=
 =?us-ascii?Q?QQDvrUdSSQsmoWJIcu6OcVjrKiDqor5lNo4VcY6+6yawuhZBacFmTtvAcCnl?=
 =?us-ascii?Q?vqt3ydg1qsoH6CegG6zWBGyDQpSRFaKmHahYivHwd6ztIOvzBRkVkZD3qZPr?=
 =?us-ascii?Q?z8RXHUryA8PnthLxKNRW9osZTU26RfrbSPJTUqENZHEAztGH/aLNP+FMNdT4?=
 =?us-ascii?Q?0dJyrTO4I16+S/A58moAVP5PlxMaGyVFTtyOOVBVLeDLW9b+3isX0BrIDBSC?=
 =?us-ascii?Q?hMjjzQT7mAaXPPorhpoGaljatDC/mZfp9snkAoDbddplGoRNz+6O/IyaYKOq?=
 =?us-ascii?Q?7NmfM2PmCGt5xaxc4IyFYQjKXO+suTDVkPUZBuSIjVGAGFK5SU8SaPZWK2cX?=
 =?us-ascii?Q?xfMZ2CzIKkontG8llZc6OF/coh7DjVkMexKv7GJcBqOumNDt4iQd1kgkDi3N?=
 =?us-ascii?Q?O8yazxDKh5nsAbfRMkkh+Rp5hbsefUXnPvEvQP2+iaROpvrFGCjixGK98hxM?=
 =?us-ascii?Q?oYCGatyM1Ekc2bWJl72eCfF9HLv6ax4GIyRSGRFo4heXygkxh+NErMQQ6l2o?=
 =?us-ascii?Q?IBbTG3K3YQw+MHs/ZcTseD6pghE1ypSzu0ir7eow4so/uG+tBhpLlV998sPc?=
 =?us-ascii?Q?QPVQP1D4qLwAMVUc+R+KyXt1excVGp6SELURiZiw1KSrKgrG1zbwVf55MA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:52:48.9476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac250e8-e3d0-4cdf-5705-08dda74c282d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 6/6/25 18:04, Petr Machata wrote:
>> `ip stats' displays a range of bridge_slave-related statistics, but not
>> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
>> code to libutil so that it can be reused between the bridge and ip stats
>> tools.
>> Rename them reasonably so as not to litter the global namespace.
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>   bridge/vlan.c    | 50 +++++-------------------------------------------
>>   include/bridge.h | 11 +++++++++++
>>   lib/Makefile     |  3 ++-
>>   lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 65 insertions(+), 46 deletions(-)
>>   create mode 100644 include/bridge.h
>>   create mode 100644 lib/bridge.c
>> 
>
> lol, Ido didn't we just have a discussion in another thread about adding
> a bridge lib? :-)
>
> https://www.spinics.net/lists/netdev/msg1096403.html
>
> I'm not strictly against adding a lib, I think this approach might
> actually save us from the tools going out of sync and we can avoid
> repeating to people they have to update both places when they forget.

Fun. I really think reuse is better in this case. Or, you know, by and
large. But particularly having both bridge and ip stats give the data
with the same structure is valuable. But y'all's call.

