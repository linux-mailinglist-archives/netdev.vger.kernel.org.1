Return-Path: <netdev+bounces-137861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538879AA231
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86F282DD8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249119B581;
	Tue, 22 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I//ipBvC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421845945
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600596; cv=fail; b=emfa5rsRq+DBu/Y+lQcj6/5gwrkcbqwQGi20nWIqh25+YRWCZifHggrIvxgPCnnv7exqhFI6jGliH9h4Jf7wMUAAetSgFofQVxN3VbQdGLhWps38MJT3j0IOCzmQIZfuHwKWFGEPiAMl5yM1Dtvv+S72kzIPlyJ2bBVhd0obQQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600596; c=relaxed/simple;
	bh=Bek6hZr8HEn5TxHUWrpjiY8jwe1B/nftrd7D5O4bczc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFf6HehGU0wCWIGrrHgxOKkOwYXUPlZB5XjlLfRPJ6oq2okC/o8dMuLqRyJWnlkZwO7HOZA0RIxg/x6U1IYcWc/e10bD3MLrT3A2VZYeEvy0ovL2tKSE+rlkNxS+r4D0aeHeti0iCrTbfD0LeTw6Lw1PxZfzQJMeR2eJ09zPKpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I//ipBvC; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLj0gJ7ym3+Lcv6J2o8HsyQY0kAKrljh6yl1xuBNtcWoIoHX1XSR8N/R/LroNB701mNcqdLobdKsNgWzmImHemn0tFzQLsE940JSPtIlZcQSLXorjuyUtUVJcl5a3jFZ8di6dGvg4O2dHqR4Nbv0xXdFnuneONqQyrRaibjBTTH2iRi/TANt9czfHTw1EDvlHs0H9ZU7eEUzQBF4ikkABlKDIqqtqncd0q+jd6MxpKvdLr+cnU/llBp+/F3ZAQxfVmw7N9zGMy3c+3UObs/CdoqhhA4XHXq+EU5PwskI9igu5IEK2AOxM38TEEW2A+gqJBvEqlrGxqXpCYVwJ1o6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NH+gRYB/idSy/YvN11zryv9vt3HGv13pB1QZDNPU/o=;
 b=NRFnnAE/OUaJDazoWvN166E6yKF1xq+IJCk0GLFdUf3LY0TIy0jLUIixdQpDHbjtpG0oVMIlkQjizYy//yT6H4NNoSMbPJtTayc9EROXVeX/s1YuZfv9af8Zkpr/pcKkxCCmTJV8tdgSK1JqVcG/qctAHttOMvtj6TW6qb4NOqaC1byFOXRWAwIeVClCi/QC7yO/1vsH621zXAnsi9TOD9Dzou8wAisrbV89KjcrfINpCwCEhzEvgMD8uohusYOKVCWgKjmmrOv1KZcI2GoUCTKdAbta2tbSzE5ywmyWNjDokoxR1XB+nhLSKmHUBfLAUnKxpHhrSHv0xgnSkFUSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NH+gRYB/idSy/YvN11zryv9vt3HGv13pB1QZDNPU/o=;
 b=I//ipBvCLum0gOy70FIEmOgcTnz6ohuzizmRz3PJ5omPv0y/dy0gjKqtlhChLg8RBIUmnCW3AQYpevmaGmPgc1dxI/pGZ+/8jRYhFZOAb3+G3ajjerdmT4uQI93r8CPEG1PtCeoZMVrRipFctm3ce3LUdszrVg6/8t7OVVZzjvEYO6OS+jy1HDuBqqNLww/4IB7QygOmX/H56JN1kY1uArQxbFsJnt0HgQOl1daiD5MFsq3fp8hrgBh1SEGJmfuBatoQsPGE+v5XSqlTb+Vcx+X++b8fUZkQHOOunoIHvfKrxYkJDKycwkP1gEl2f2ukfmNRiYBLZcOkEPEjgfL0hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 12:36:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:36:31 +0000
Date: Tue, 22 Oct 2024 15:36:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 2/4] ipv4: Prepare icmp_reply() to future
 .flowi4_tos conversion.
Message-ID: <ZxecQ972BXAr6h-F@shredder.mtl.com>
References: <cover.1729530028.git.gnault@redhat.com>
 <61b7563563f8b0a562b5b62032fe5260034d0aac.1729530028.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b7563563f8b0a562b5b62032fe5260034d0aac.1729530028.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7f467d-c1a2-4269-4afa-08dcf2962864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lv4k8rEJxqgli7KpogaJUpfV1XNXUAp9QX7iE4OFnHMm7gncmVlm24+Z5swB?=
 =?us-ascii?Q?cx72nM2ven3aKuO8F81MUVa86NdmmqpO+df3BGPX8jN7LC4VJq+xItzahOb+?=
 =?us-ascii?Q?ht8xTWmq9d2tHtTG2gKxHTnLALybrtyk7ZnQkVQD1WX3BpGZOM7W+y3T6dmY?=
 =?us-ascii?Q?9GjmEwQM7hRbroeQpSki3ustiGohzVSlo/ilZhywxHzPh4kwyTn2eOTyx8wD?=
 =?us-ascii?Q?utKCtTzCKQTsk3QL+GfmDJZTaSFt5OPrnEoAOxR8z5cJrZeuKb9ImCzMlw7o?=
 =?us-ascii?Q?g6HWqZ+N/aWewt5nMfHurX3E9R9sU7dZ1aYp/JLZFrMaz1PGaGxfxwK7Wn2l?=
 =?us-ascii?Q?Th2O05OvR2iGuE1FWqF2s+K14Hq/9ARN8kemfrZjn/NAN4uVzDwGTI5iW3Uv?=
 =?us-ascii?Q?T7xMVPOp8a6W8GiiznLiqS+7rL2jwSirPP3C1pzf3m1gtIK9/IVyKLn89DMC?=
 =?us-ascii?Q?Lq8yPhMIKvTo5HfQN2EMNlpzPE0xxIj6ef0UexSH2G6T1fbtMXyTyZzeLhMk?=
 =?us-ascii?Q?c/HG2ASOvP9HuW905jB+Ewr2y+1asqKx00tRnQw6Rm6m93c3pSRrAyau3ZZd?=
 =?us-ascii?Q?PhGE4nTPAr/pfs94+uuivh97+7bloLiwdsAjtNw7y/trHrY+4d16ettRzCQL?=
 =?us-ascii?Q?UcTXRhcnhrchhyVOOlw2aK7NWXvN3zjz6MDKpajDs/HKmVS0vtVPMcPaDIRA?=
 =?us-ascii?Q?QzKN6B0XmogSTvmOAaOO5EQ7z7Ie4PDMyfPCEOgyzvfMc2Y9cB43/m7qMkvj?=
 =?us-ascii?Q?SMbe26kAFBN9qD+578Vfc69HGof8yewLXNhdj3lJmhlJJjv+BawEPAWX42FW?=
 =?us-ascii?Q?kg3j7tgA5bYgW6pCnRuli2gx/KnnSEzgoaAFu1LKE4ZzmlAybXY2VW7I+CnV?=
 =?us-ascii?Q?2L1BgwBY5dCZwXTkYxYGfLe4fFlHV1XY1Gr2QNi18VkdAw2tCvi4sPD2Ny0P?=
 =?us-ascii?Q?jl+EDQp3EmvxkuKlhrJJJHL5w0Gn9rk3vDjMGMLqE+V+g8Q0u/dViGYhzRli?=
 =?us-ascii?Q?gNuy0XWDhuJgY4/ty4zZPTIbk+ppSAnJutPTIgKHI+SffForHBnKIISHHaZe?=
 =?us-ascii?Q?xuhZpQ3zfwnJ/vMy7CC6lrhkJjVIhdYbPNMz9qt+9bRxv8dTjJHMfUHEkmoy?=
 =?us-ascii?Q?EWAmyW7fGmpZLuC/JsxBn94R3FAkkrKe+smthZMMp/FOpjdA8u58htFWvhja?=
 =?us-ascii?Q?GgfwIoL+W7fXZFQLEMFVsyZvzu5UA2iP2Pp63rsoOpV5lvdwsxK4+L0m5WHZ?=
 =?us-ascii?Q?Cb4Vt9KhxSfF98KhsqNCFY16gbOaBY5ZSXCoR93sLmVZsKnRu8SatwKs23Rm?=
 =?us-ascii?Q?y/EUv28cA5/vIzHWsKdU+l33?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQ5OGBcIM2ejIDisYjFCZYFyF0xRr89puebtkjT7YexNllHNsQjFFkx4D17q?=
 =?us-ascii?Q?wbke9+ryslgJDn6MVTcjI6WAAXw6dND2v5IoK3WZ7bGgkQwVOpmf7Pl4BlDv?=
 =?us-ascii?Q?Qo4TZ6hDeCpr2+/hpGWeSPeesFIwefDkNfcyhuEM9HIpuE5EXAjxKuslMEF7?=
 =?us-ascii?Q?RlRNFauSreBVNUP1KOFOqz1oCVIhWJaOEehEFEMu7MSU7uTsOR6leRVF3dre?=
 =?us-ascii?Q?03U282OG0lJP7OxNEXZ9Q8XSXRDRECkCETdptg81cvBg1cKJ/8TlBKBHzKHo?=
 =?us-ascii?Q?ytXahf6zKkcd56UbTJeRyCPevLnwUhyaQzFDr8e6b/NvgoPHa6fp7OxUM60s?=
 =?us-ascii?Q?zgLpIFkSsURSh6+CCZKjHtVeL5A9Nj0wq4VdHCpZiwEsOSKY3LPXjMac0pja?=
 =?us-ascii?Q?R1swYtelMt/56KXqumtROvFfJvqPAztyXblfaRTp37mnwXrBaQIR7bQcsf1L?=
 =?us-ascii?Q?/F3J+Rsh2VxDXO81xJvcyASGDSZxLjp4pfVk/GOA/m6upLS4uX6+g5LkVuZl?=
 =?us-ascii?Q?jPYtezDynxGra5hR7GDjjFEgjt9MNRrkMPBYDrnPolKwjWMHNHakqY/HI3Db?=
 =?us-ascii?Q?p6JXixfY+Bsug+q4TLYbJEpgHt23IpMBtBrO+YGqtjfAim6hkrxfYmzClNDo?=
 =?us-ascii?Q?XTCK0d8eCkUZ5EXkOek5NlRr5OumaP13Mr0vBLGOsbAA4UO4aW3rWKOhQVH7?=
 =?us-ascii?Q?tUOueDwq1pnhYApZkKEQi+1LmFjfCKh6S9XC8zou+lzonKxJKn3pDDixqC7n?=
 =?us-ascii?Q?s0hfH9SKkdxjfE/mkaji1+nYIsCi0nEZ9I68vHvrD+st1vItNuII1CeUZEoF?=
 =?us-ascii?Q?tZNHZp4r0Dc2sdYRO9zi+7evMNfbi3AAIVKEdl74lV4APzmoKW+muWghnCzk?=
 =?us-ascii?Q?Mo7j7/MKZKSlMjYSftp9jNMZd6OaeSvhi0XriFP88V/GNf/ss/K3MPCVI0KS?=
 =?us-ascii?Q?B7R/xMNC6bisb+WJclHVNGmkgY+EpH2VsGfyfsd7K445OhIp4HkjkD2up4Uf?=
 =?us-ascii?Q?DmLvm94oxTAolH9pRDOUexXJGAycvXSwdiBIuBgEscKtTzxKY4hbqkpf9ZBt?=
 =?us-ascii?Q?NlIO9wE2ydExdNmEOJdIWps/p69MhGpbl3ZquRa9hlFb82Lv8VYjegdW0rVo?=
 =?us-ascii?Q?SPi20h2uPFS1Ryut3elsAfKWm1togMCSOTDxgDtU0L68d3Dzy/ajjPIjD+nA?=
 =?us-ascii?Q?rGsGzdCQlcbmrxGdI0FY6g2NSjhR7UniTVTT/7YHv8SFRIkWiqjzQGggUmxN?=
 =?us-ascii?Q?3W3mksPWpC+Ua3iGCeHN6hdLXNr1Ynt44mYVcky1LX1fSMOYSS9QjzT/iLM6?=
 =?us-ascii?Q?usO+XepX1Q6Xs5qYynZiLkz8mTHb2fE4myoLPXgwl/BE3PI8FN5Yfja33XnT?=
 =?us-ascii?Q?bqQvC3+O1P/8s9swZgON5mLmpYKYm+8El1L2+lkrkBYV100aDZJ7MDp36/XI?=
 =?us-ascii?Q?W/EdfGNCqRk2j5m70AGeTiquLm7SYnLyi9LX2LtOdlWzO1lSjRxe0c3g5BNF?=
 =?us-ascii?Q?6F8j4U3MuvF3ssI2IOOZ06CCKwTu735+KfQ9zgzlDDDo1sva0PrDeuuGgtpj?=
 =?us-ascii?Q?7xsbTL8odt7tQ1rqbe7ggItaKkCRBqWwN9AZkgG/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7f467d-c1a2-4269-4afa-08dcf2962864
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:36:31.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/0kOP/uKk921iR+wU2/Q9tf00IR0oyyXiEnncLriEzA3Aw2QQ92Zlv6cjQb92NCfOyNKwvrXzxc5TCDgYWjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Tue, Oct 22, 2024 at 11:48:08AM +0200, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

