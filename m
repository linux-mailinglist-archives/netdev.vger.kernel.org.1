Return-Path: <netdev+bounces-280784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PxCElkz6mkCwwIAu9opvQ
	(envelope-from <netdev+bounces-280784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:57:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD48453F53
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45835302E85C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3EA344DB9;
	Thu, 23 Apr 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ndHePR4v"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917F3242BC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956186; cv=fail; b=bDRph7TEnPgfo5AK0KVLOUxBiXlCmFaErTY0KL4ipqItBlFGODBcoSI0RQhVf0T2bSFWGOPcXUmv0BKBIn9ZXeXgYzq4gJA5luhFHII9/VtsFN+bxrxL9SDIIKpLSnXbTZSwnQiAZsnqVs2YBrZYWr+igsY6ET49M4dS3OLrZVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956186; c=relaxed/simple;
	bh=JLDvqVki/AVaj7kcuW5AthWLharpGDYtMKYiQC3wKXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kll42nJaP4xN+AGwWDATaaE7muFYmdjruhSWjqjlAco+tvTr6DawAr85cFJ8huenTfB1IJWb3dOhE86OIc1+rbQ4KyApIFcZOxG15dTHM+XOchwbigfPGhhPvIucRFzqENys6qhsLn1T/2k6674ozeIeBs+GyTDKWa1d41XnE6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ndHePR4v; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O907jcTkh9vOFe0vwZ6d6dbakgf6054N4KbYxXuS8msHxs6ilE/cz/IBgjchfqRLs4m4Jstc0TBr0jEtwkaEoNhk0wcMJdeLCXRroack9nDzXi9UaMoEFR6JKQrPjC5WGhAhLEPMYnYAF16gaWU+ZsKZk9K+HD78H5OnDzVQkz9bfL5hPaOj8W3oDVcK5aJBtVKGD/pYuOPrFhIdK352HoEvtQ6N5xuSM+DiCAdcBX9mZDT/ee6wJDiunpQGNciXiDCK1ux/iGVeUsEO+IZe7n0BOsbfYf5CSM897s/BKHovEgEOeMhLtBIpl2wjqAQapGHS+2tPaRHAXXs+WlMgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6mTRVoNB9Dm/EV9NlVcqdaACXS8CCds+j8k3HSjIbA=;
 b=ZJVSx3uXA5UHHSyjBx5/OHovjq+LPp6+MHfy9FqK4lgGifLBrB1PdYWAoeWJRN28jD/F6N27Ipc6d19RgDEu3xJggp0Ol2k/0+TO0tKiQ0aqCKJw0l0OIfUJq9ePLDW/xQJIhrpg7nntjJd+R9td30T+ziaKZPPBUF7n/0GLherkxYI0FGwIVYJuTb8wPL4R2hQtBHHeXPhvdT3pgIvsXzxUdNl953CRguyoLFm8Utu35q4zjRTGln/Pa1gun39MZ9bLyIw1MBmWJwj93r4j4XvKbd2oYixACkS4tNAVue9P70MdATDoU1+3DhlYe2i/VW855u/7JUkauvMCDOEKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6mTRVoNB9Dm/EV9NlVcqdaACXS8CCds+j8k3HSjIbA=;
 b=ndHePR4vIBj5ZWhSrnXzwTjPEUsd0tWCJf0RhAyyaD+OscHte+OVq/uGnYa0GtdWtDw9fEvgUEbhoUaByfAZslNB1Bl90okrRuoeEG6qBa4U4MHhjxbHlZB8mI75KxXRClBqZ5SU7fw2GUxawWMTYcwLLb0LWDT4xEw9BG9eN9bEs0ldTdZSfsrtAp+CkXGMGl6iSbgBti7MfJcU5tYF0WBihiyJ+O7F3agBpVYq92ut27y2XMAcdjr0DS6mCfKyTyywo8zQeL/+FdNjL1rhjPtBhfQeezWyXHFyNVFHsoHbUWmafU9CPdQN9fJszbk/EvoqBStg8aq1rTeGK7EkFQ==
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 14:56:19 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::18) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 14:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 14:56:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 07:55:57 -0700
Received: from [10.221.197.34] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 07:55:55 -0700
Message-ID: <58a85178-c00f-4705-aa20-61e668bb9216@nvidia.com>
Date: Thu, 23 Apr 2026 17:55:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with PCIe THP on ConnectX-7
To: <bmerry@gmail.com>, <netdev@vger.kernel.org>
References: <aejnzWR_szvAOxkK@brucemerry.org.za>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <aejnzWR_szvAOxkK@brucemerry.org.za>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c34e9ef-1670-413f-5e0a-08dea1487a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y67QwLzVvDtQURvxtrYExE0WYNo+zElxZju1V3E5FD3DqktRBhkrYqG3YhNv1G/WAMQE/IzxEXgme9U3wTuXZVpsmz0Xg6L6xUKE9ZRYMTxZpSePGOzQ1hFzpUGk2XIdpuUxtixXui/ZNuyi9zwxgY5qqIscg1fEv961Dhmq4vSgnKDkKTzez+U+uC/iPxLq7gVyMRaxeG4g0R8JT9PG7zXs9MlHc9wr48MZD9oa59v499cLV4x0On+6qhu9R8NoMHkQsMhzPvuCHiQATeM0YaQPGIwzNHiD0Bdj0V0itVidAj671cXU5K5pw61av48C7R7ehfFPzrWWEcgS5XOmodJJCpO1wkGtbCALjSWaXOgCmCr2KE6Ielf8sr4KiMOu4eTHECtxJ9szhU0ZLqpf082tJs9uIZHgLRAUZJoTOXZfHMeNWef3+jk0KUulYG6H8pwp/RWEsvLrYjcc6fc9PHsxDbZjUeHaVU0F/gP3Z8m13lH6/nzNIVf4jTsIH1WZybUy21z9AMrCCf6nnaZdLJvQ/t1HDWtrWMpCs0AQMQ2bRB9g6otRIfQ0C0NillDMFpT9UshE+4QMhPx2fmXdSUB63FA9Vz+0DcfCRvETACwjnB/9tS+2MZVPhuz6yxyy6dZV8jKXm0JMrFiidQSlKpuc007zSL0/fPjCcOUt1Rb+d9fA+ltE5F+z3IPfxiKbCFtieEYCA3eVS6sO4EkeSj7dcuWpeCmMBfV5tfWy9jIhR7SFOsutlPRTdNsruRNvX1hhYW6Cjb45Dp+PwAEqhA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q8Mc2vD0gR85N1QmcgscuMS+0lrTEWpA76xYMN9gaau117WFYIrjmQkthOAqED7hs15egmuYp4QXlAkIHoMInXlcW6gvdM599TY3aypnlCfpfzQHXXdH4dUkSq/lT5H8AFrA/gc9qw7vpghi7NBFciZfpua1zyVuuWkSTwEuRQpGMUnEg4fMbeuQjoKiXrJrqKJxo1T3onQMHrPnK/k5gc/FYcGB9wz5VXuJkCO+Q3552XA6m7j/udxmFXYaDLjf/BQ8wK8SCYbSB2P0h7/0ZNw8xtY5k0XBAVD2qY0QQrQmu6FPybL/kanl1hQUz7ZbCxKbC/4/RGT9IF/+RsDavBnQCBT4MISwBo280i4oZpIDzdb8tvf0ctsDId0wbUyE+oONWJt4yqZxpGihjVNntpSmDskRQhbTtlymfolBmcNhqPLxu7LZ/vPNAFnNBh/D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:56:19.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c34e9ef-1670-413f-5e0a-08dea1487a5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EDD48453F53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/04/2026 18:22, Bruce Merry wrote:
> Hello
> 
> I'm hoping someone from NVIDIA Networking can help with this; I wasn't
> sure of the best way to get in contact with the engineers working on
> mlx5 kernel code so thought I'd try here. I'm trying to write some
> (userspace) code using ibv_reg_mr_ex to register a memory region using
> TLP Processing Hints (THP) to improve performance on an Epyc Turin
> (Zen 5) system. However, in the kernel mlx5_st_create is bailing out
> because of this check:
> 
>         if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
>                  return NULL;
> 
> As far as I can tell, that is checking a capability bit returned by
> the firmware.

Right

> 
> Before I spend a lot more time debugging, can you tell me whether
> ConnectX-7 supports this feature at all (I'm on the latest 28.48.1000
> firmware)? I see it mentioned in release notes for ConnectX-8
> firmware, but not in ConnectX-7 release notes.
> 

It's supported only on CX8 for now.

Yishai

> If ConnectX-7 does support it, do you have any tips on what might
> cause that capability bit to be false and how to determine what the
> cause is? For example, could that happen if the motherboard BIOS
> doesn't support TPH?
> 
> Thanks
> Bruce


