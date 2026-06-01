Return-Path: <netdev+bounces-293582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6IJXEsHWplWAkAu9opvQ
	(envelope-from <netdev+bounces-293582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:53:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788C61A6EF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D648300398A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F73803FA;
	Mon,  1 Jun 2026 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrh4vs05"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3537FF7F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296813; cv=fail; b=IAkFVidVMdUBu5nkymD9rJEsG7xKc0knrmZ5Pcoxjer1gnqkFl8TZEhmIaQ72XvQwcDDQRYSwYyXMkvbSPvHjjgBKCrrXDmiWep+BNHY02x9f6ym+t7DX6L3Nc6frONOgEAVX59o7NBeGVFKFHSJpS1K6J/4H6lnjWadSIGAA8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296813; c=relaxed/simple;
	bh=ktvmEoJ6wpOApRD/xA4he+od4V+mAw3NqWmGegPKrbk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l9r+b9g5Tx3rYuA8Uk+PIAXVlrTW9Z5a8a/QXLaZIv1kvqcFoAcduvfn0PZaAF/dlv+YW10bFnzzlrjLg8xt0MeZAPHDzNMWBMYtwkVopMI1SiBT+kZ+CS1vdAa928n8mA6bWdMWgCCK3b6I34dpviDyUyc1j6YnlonT7RUBS0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrh4vs05; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUV6XAYsM8RsWa91I3Ehuz0ssYmy/8E6XRwTaZjoIGRECbiveDDGINBypm9L4odcadLrGoCTKS9mGCw+TnFnpsxMfrqu507BZXpItJOLAgdUMxzURXIXEHZALA8ADeAqDohwpqchm24VJiNsp8f7WJRiRlky6ppVSfOeGcFWeAcljZ5yVCBT2R6TJIFeuoODQDTT3+v6mCWzQ1cWfRcm9QZgG2qik8dvFbeukVjTsHC5j/kiArCozwZWPyvQvp9HTDFa0eOB0OAFzNuknqYhs3EM4yyLLYoFLqrmINjT1t2U5YNnHse37AubyX/lfMlE+CrOavbuxrsq0Dn0SH6XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwCLKGWYj7ku2xKaJRP1k24RQZaS6ROwADZWTJszJHU=;
 b=TtkUoyQDcKq0wxPs+a+Oy1wCNbVF5IFx206T2qdDWTDopdkC+aoEIwMMVtF1HpTliFqzwEmTKSExF/fVEG7QPGdzdJLMmm4Ymk4Wja5qyaT3AxYc/+wepqBN2RYZOS9gS9Qe2bDCZjwVb30DYplGf9bp+xQIF4RNyKrLYY0fqHHwnFzoTsnwVSkq9TmoFGrYKHVOlDwtMJ5K9fnf3ucHH6eFaAqHc/kr4UAlKd/Y/yGwayWvuXsycukw+OiRTY246voeTREp0gW2iym4IxRKM5twuLmW8m5FlyTZ92xLZLs643vslwPXbNKu31f0mjmW3bPi3nr7l3cO4N8yA01dvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwCLKGWYj7ku2xKaJRP1k24RQZaS6ROwADZWTJszJHU=;
 b=hrh4vs05L7wCl105tD0PFymUkjaiY2jc7Oc/QHDnua1SPE3juBTGR5MY8Vs5qjSJgXGYB1C3it60dLNlObl4IWKYjxvAGIJf7i0cMQz35ujXDkgAy25JMOjYpIVih/+C4bp2a2yMY0Q5DSoKn4UGLZr4xdeiqmJAx6pjtrothVFUJbhLBCiurpL+Ywps5af+emelJOvlfXYrGnrHmSrvRaa6y2dabVnxPV94txP3yceWb1TYW4PHp9SJnA+2zcJxY5ocLX70gKy12Hz2LefxnrF+AWmIhu44BlAERYQwa2Nfbl1u4JxNeUEz4KPINtsEzRkQip33XNPjNvQcGJUaYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 06:53:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 06:53:29 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/2] ipv6: Honor oif when choosing nexthop for locally generated traffic
Date: Mon,  1 Jun 2026 09:52:58 +0300
Message-ID: <20260601065300.267960-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: f19b5565-6914-4fb7-a226-08debfaa7cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7byZ2nOdths77wdt9ZggAdWUYJY9W1YIUKPDwHpHcfGYRrhrudwePBwFFJNmXSretq3Q2eD6ltW2T8nf/CIu0iaVdAHy6XanZCca/JCQj28a69U22Bbe/Nw8NGhJm2KZiaZw4Z5FrPjNnCFSwe4CoZoCN7DKSJ7CTMemAb62q9XNTbaBKgR77DwXE3K0XxidrH3f6kXztF/8qu1ubF9YT0vxaBNI6WH1ufY3lvaLp/9oKz1ho6CdoB7Wt2pxiXLlYlCqXNyY2KZ+nsD9Ru1ac0MAQazLxBNzBJ8Usfo/PX94tCfSWDmG2kwPCEL8I1Qq66xzQv9j7zS61hu2PpPXZFc7COdfacHMpzXePUwDnbsOtHgWLKhpLlf2hl28AAv5sUbGG9Q4uYNosxVc8f6Z9vZScby8FbwkNupDrJCbyVasZshiqg6Sm0sekN0gjqdlVypnpXcxhRtgj/UszqtJujux+t7Szsc2ThAfcVFZ7js1X+kBSsuvuxgc7aPhk5qs69q8yJX2vBvfold4mA41P7+BdLHU6inFxlSrN/XGpCx39hfMQ/pS+awf8Tdz/QpFeaajmJApQiXO3/64f00dD0F/9uzNljB6MXFkQH4YIiC17m8bzAuhFhqN4c4BZ79pQ3LKIyRAahrATybNDkaGzcbP70RIk6iG8QQK0tBIUtnYEklLrj2qNsNwEVebZmoPPyGKeVc26Zp29hmyBWSIIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YK2BAtRrS+iXbr8nTdJEuxdPpslnmfyi2xV+oX1RBlA4EoKNUILzK9iYc4V4?=
 =?us-ascii?Q?ZcYXPqpJZiGS7nDaIMZRJ9zJKf4g3OUFaOahmjoZ/uFl9Q7/tF8qO2XXoamg?=
 =?us-ascii?Q?GP6EnLTLV7JgXjL9eXyPpz8UTm2DJFdI0ZKt/UXRAV5sADHi6E0stSdTuLUv?=
 =?us-ascii?Q?PGIAfzmjEb2XdhpNZppHjvRdj575CmfLwg24wRRDe/F6iM5P06uQuo9bAuxa?=
 =?us-ascii?Q?wxBLUR5Fezj7m+rPusOxYdJj66OB/NSGr/Bjbw8EXDFW17oYorZsb6rI6crq?=
 =?us-ascii?Q?rU32Q50OSC1eNJU2FXdnPYGllwdbKmTXgIVmLr6TboWZIMFx60RsRMB7I+B4?=
 =?us-ascii?Q?vEY5HVOSBlIYBTBNG/sCZRA6LPZRxOjCU8cSObf8MDZOk5rrS7L87GRRwt28?=
 =?us-ascii?Q?lQTfpwhYbMEAPdMFQgeX38f0OPqE3KHeuM6fxbnuhYTxwXq58COYTh8PIC4y?=
 =?us-ascii?Q?8dSD8kEZ3AcSLHJ5lUw88z1ePQznJErZn4uX2uqYuRaSw4XrKNdfqnkQlvwD?=
 =?us-ascii?Q?tQtrlFglus1g11eohG6CDb+8R24RYfdidno55h82/H30GjLVKHhiZe5RA6Ca?=
 =?us-ascii?Q?LCZU+WBGR+WaTmYwsquvyrR7dllmZ+8cZUAN+2KIc15fKMLFBq5jxTapIaMN?=
 =?us-ascii?Q?TQQvgNc+r70oCi7BZWGbgE9wnd59m/lMkD6rWTDfaqy2SmUkHEf5hmUyrJzF?=
 =?us-ascii?Q?O4l8qN+cjodpuwik/4qF51I5GIqtC6APr94I8/r4e++uBZrJKJkDSONnQN2t?=
 =?us-ascii?Q?WlYGBKFlj9wdONv/EUbQibr4JqfR0mzSNTGe5rEEC4oI2Afm+A/teZ/+NKhm?=
 =?us-ascii?Q?d45Fuwy2+FZlH5gT+PnfN7UcZC6KnV34QuSOACSK1A2arClSMSTgFwHXRZXW?=
 =?us-ascii?Q?sM/LSN+695cFlYi+xaHy9zM1Kd/l6xSlnYt3TYedzyj5VbxV5nnSDC5dF3pc?=
 =?us-ascii?Q?2j6L9KSFSucX7TrIT8yrIYBS6EsPulmykXKaevwaO9aXz7B0DSP6Dd5qd2aB?=
 =?us-ascii?Q?8yCNeQu6knizubg1rP6xUaWBqzSfwe5DPxEJOTygI3/lJAsWBWkpcWcDGc8h?=
 =?us-ascii?Q?QDBWX/XK4iUhaZ5o/vsWj7J614wRh5tdSHP8MCvdjPQfg+FodXl8B5WRY0Pm?=
 =?us-ascii?Q?bZAQAXUXlD+gv8XcQcVDqWoLmWs85DzOAkG1IqBu61tz8IIH5vyjT24oxLkq?=
 =?us-ascii?Q?dnbRMBFOzWKXZtZbBY/rhsfhdkWWENFv2s31gS+Na2NvX0fc8FQhxTVYna7n?=
 =?us-ascii?Q?nVpFKVbROIthUAsfKrAlNlh7FL4RoGQFMWwGJ0Vqlhryxo9pK8bXuos579ND?=
 =?us-ascii?Q?j+kPKg7Io8kTKacWYpeyXyCKK8oGXXqI5NqTo2W63ZvnUgkLnpwrGiTXc9Dh?=
 =?us-ascii?Q?eWHGwb8ag5DbIY49YxUkhzeV/ZjvvREAAfK93/CKndiUx8IIuJNJ2QhTI+/K?=
 =?us-ascii?Q?5132c6TZO3YiKaMtXD1qRq4tgLgD6Jl7ytYwdHGGfTaiEMA6XY9uDfjVv91b?=
 =?us-ascii?Q?vVpfAvbYTD0nsc6MELS/HClj/L06JViBQoTjHXqIcwseeo0++pxgkdiR9G8H?=
 =?us-ascii?Q?8yBUgUem02pnHpRUWMDKTsaGT8BmZO8SgOXr4bklEWU7hWnUVc03dIsdhJ3O?=
 =?us-ascii?Q?Nkigf6cZlJ4EtRgPimC1PFu+8E2vLGBiRr3TGEOkTBq2n5BwZobwwPZybIVl?=
 =?us-ascii?Q?E3czt7AzrZkICa8wGOlp0GTbmXOHTv1LBQ5+3T4S1u5yKh/G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19b5565-6914-4fb7-a226-08debfaa7cb6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:53:29.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY2UfArC11344hXupiB7VX582EZ094kPyK+EcuI1debbdkyTL9LkC5lg2YUDDx95h0GUSyhFCrMaImpGNwQXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293582-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3788C61A6EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch #1 aligns IPv6 with IPv4 and changes IPv6 route lookup to prefer a
nexthop whose nexthop device matches the specified oif.

Patch #2 adds a selftest.

v2:
- Add tests with VRFs.

v1: https://lore.kernel.org/netdev/20251224161801.824589-1-idosch@nvidia.com/

Ido Schimmel (2):
  ipv6: Honor oif when choosing nexthop for locally generated traffic
  selftests: fib_tests: Add test cases for route lookup with oif

 net/ipv6/route.c                         |   5 +-
 tools/testing/selftests/net/fib_tests.sh | 183 ++++++++++++++++++++++-
 2 files changed, 186 insertions(+), 2 deletions(-)

-- 
2.54.0


