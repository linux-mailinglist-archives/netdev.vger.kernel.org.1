Return-Path: <netdev+bounces-284682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM+nJye8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 099434D6048
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF84301BC14
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10282DAFAA;
	Wed,  6 May 2026 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="38Ca6/MM"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BB2798F3
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039844; cv=fail; b=cmeOuJF8GPIOQ+fdS9xOncrcP8pNHqKSdxiRG4iQ+AcQZj5XKzm7Nrn40zi8PHZTpWK8xN5UFp6zDZ4bkzFcCjD9wbFqgb2fa3K3TqWtpa+Z28hv7mXPfDZXzKOstczCsqoWEefCOA7DjWyKVAjAYByGB7EM0G6muA26+lP1tIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039844; c=relaxed/simple;
	bh=xJWJc/wDNpqQKQNqyTqpFydIkLbvR6Nx2nEMuCJtJEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e01WK7R1S3p2dXOwlPoTGURMcJDrU07avURXsbAjtGPPI+M1KzL+1rjxiyqUURoXwc3j1oh0A/AHeXOKrH0BxacD46ID/YsvHkUMrJuzy7pb8gGPxCcim0pKdHYLVTlpnaVatxguLiKYEe688oV9ViGZABnsbQ9Sz3buncebE90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=38Ca6/MM; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwv7KY72AuHBcfAnSJPSkUpNDs65WhdN9acDSc5YRuoWWBf/fxs5TrndLx4+xl7pJiK2uVI2BDyvpBN39yv1f7F7VJTWxAgqDoQmkK2/YD6NxuaY9osZk3d638MR7dNz843j5SZ55CmXUxibVgi2ucUbQW0BmJF9PdlBpavXU0ZmiO1XqFS8bHazdepz4nalNRFmZzD9g7hbSsdyAR60q5SKatR58Sn0ZZdiD3DVuNZpCcPdDgsq19zQWtSOj52vZbbAAlEcjnoxWlD46gujcUtnffKONcqVdv9AJm2FL6FFvTz+uRhjJFUyECDIshcgc4xFpO5jj3BXkUrhyx7SKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TJHB0RLmJYS55ZwN6+DaQ3uHlMTTKS/9LlJAc0QozA=;
 b=qQ9B3ifjqgwomQ83DexCQ/oissEQ29qJP6NQtTOWXToRz8iKWzkrW/gcvCcdpnE/9r7hVXS19thZ7GAU1Ctx3HrZHSl2OQds3lqRa6zyvnumYxUMhIuwCGL/dTiw1G1F0dBJ2s4iv3tihjzaO5N+IgAa3IHoOq6EiwRV/YZfoO7PJHcgq+HzQG47gibIIAYDTZXbeijkwHliRpICxFzzeCCQoorXhwTCHKBf9WoDd5PW0781IBDmPPm2Medz5p4yjMqyBNTL8cQAPJsxMAvOthcIu6VYn9fYWiJTV2JE72H42YMTHH9+dOZXvkPij122TdLSdmiQNOdmZR0tZU6y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TJHB0RLmJYS55ZwN6+DaQ3uHlMTTKS/9LlJAc0QozA=;
 b=38Ca6/MMtcEBXgE/Z+LK2eUFYhkoVLEibtPwiX0DCXEBH7igwO+YQ96ob/5oxY94A4VrjAo+PSBWX2G8348xh9g0DQe5XNyJBDPw5ywBg6akExmeYJLq2gxkZNkky1bzO6tJTKtk5fq1+5bxyswSKF9gwPpY+qi1GG2vD5DVniE=
Received: from DS2PEPF00004556.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::510) by SAVPR12MB999146.namprd12.prod.outlook.com
 (2603:10b6:806:4e8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:57:19 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::206) by DS2PEPF00004556.outlook.office365.com
 (2603:10b6:f:fc00::510) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.7 via Frontend Transport; Wed, 6
 May 2026 03:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:17 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 0/5] ionic: Various bugfixes
Date: Tue, 5 May 2026 20:57:01 -0700
Message-ID: <20260506035706.12373-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SAVPR12MB999146:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adb389d-b50e-4556-2af6-08deab2391ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S/c5WXBeoGgy71YAD0fiNbKkYkACqTiH6WRwd2oAPGJrhi/nHDgy/z16hkKO/xvHnpCCT8L4hOGqgjKBFnkOuLUndkI6k/ZiNyDrVfSZj8gpMqYqXibue+i/Eh9DiXW4249OUVHzrgB81hZohFOmSGgx0lxVTRuYIT9u5jEyH/4IeoGgoE0kSLvnxXQR+BGj83PNQfcCaBsfdKrxiKXGyA/E7IvWb/JFPQtwjRoWbVaJmx5tld0u8YnBcHr4rCVA7av6iBedBFxNeGs8wh+hJGWq62kUvDgA6M99pPqGyU76SF/8WrQe+DCnlNZY294veGCYzUYVlCMry+ol82gL6EA4UIhyrzS/f3Ml+LUiI39dR+in++FA410YNciDh9WS3HfHjLXnytJQAlc7pjMuBPYFrNclZBG7EFvloRdaHuqL4hj9FMgCpRsfucXfCVOgAMBZZaL6LE7CtfHB3of48EanVBXorFMrl0JgpW0yB/FFmtF4rTvVgu8U5ZOYwA4oj8zmxncYTSliEdnzI41Wt4LigNi7eZysvD5kLLpLk7r+bPkAoNDxFdPTKLxohvlDtZHYNIfbdjUjZHn1Xv0DKFG+IR/enHCKjMJ79blgRLqjxCFd6oJelOKCQUeZ4QwUVlXAMFR0HwTYupOj5bnqK2+UprMTTyB022k1I4Ot/dc8LBZqxxcsjGVnhbeENsbVMPS1GK+yOPan2YkHkkH/XqZ9u/J2rJ4opIaU2HMGQ1M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sM4KAjjhev5zEWCIydHzOeMlsSadgNVK+aK/yanwtjstbnnM6eFy1DzeUVqqH99+mb1qSZSuINL7EfLIf4BkRj4mkScAuiSEDAxYKZtpq78Q+gm4GWOfL1j1FmG5WuW0sui049zqoh2hGT6kh5ZybUoxx7rtjN+cer7sHWfAtpAXLlK//T9Hbi/hX1AfD/jjvJ9/kuIEAttI0A2CsGv3m75PTsBuecwlalrORgtAjHcQ78tep6XUrfajQFUrLDb/Xukg14OADs6MHLDLVipHTCPxMjwuCaltVVaofIh5PdrBeI2wyYHILzZ8XOmDO9o3d4tmVsIZ9mTdt36U67s+0H8JiSBz+Q4eq0J81gTarnHq0xqr17Fa1l6fzywb/xg3gxA3OwJSw73Bj1dBzI+JnKskNgm+aXD2QM28Gs3Q1dfo0+GNzwPyxcwh1lCX2aKy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:19.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adb389d-b50e-4556-2af6-08deab2391ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999146
X-Rspamd-Queue-Id: 099434D6048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284682-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Brett's patches mostly fix issues around communication and configuration
between the firmware and the driver. The one that fixes the check in
ionic_get_link_ext_stats actually makes sure the stat is reported
correctly and is a precursor change to have that link_down_count be
derived from the FW and not the driver. These are all fixes to issues
that we've observed internally.

Prabu's patch is critical for enabling PTP/HW timestamping to work
correctly when the completion queue entries are double-sized; the offset
into the descriptor to read the HW timestamp is incorrect when in that
mode.

---
v2: Drop Admin Queue fix patches from v1 pending further
examination, and add more context to the cover letter

Brett Creeley (4):
  ionic: Allow the first devcmd to trigger deferred probe
  ionic: Handle failures from ionic_reset() when relevant
  ionic: Fix unexpected dev_cmd failures
  ionic: Fix check in ionic_get_link_ext_stats

Prabu Thayalan (1):
  ionic: fix completion descriptor access with 2x desc size

 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  8 ++++--
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  6 +++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 ++-
 .../net/ethernet/pensando/ionic/ionic_main.c  | 12 +++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++---------
 5 files changed, 37 insertions(+), 20 deletions(-)


base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
-- 
2.17.1


