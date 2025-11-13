Return-Path: <netdev+bounces-238435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0DC59260
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D27502813
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BD2FB0AD;
	Thu, 13 Nov 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="xfx8k0sh"
X-Original-To: netdev@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F2FB085;
	Thu, 13 Nov 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050774; cv=none; b=ZLWdrwi4xH8L/vnFnuwlWHx877fqiqzb7DccikOfh2oErSXuXUy46lWtkzNWUw9QFowjP86ZsBBF9mQSH2rPjXH2/0cH0wYMWReY5VhkaEUoIb+n9EF0x3irjgT+XW8goJnQPh7iPlVrLnSfNVuAHxUV/uI6wnXcoGqWfj0IC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050774; c=relaxed/simple;
	bh=7wf/xOs7XuSmGg449lsqqvdQlHgd0WZoRwyEoxYWEsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuiLkKHMhbOmZh+AE7LtE1T0J5xrVZpn0u+YR0fTZhSMq0gIPWAUMje7R1GbZGy71Ugda/du5GEdyfudQU0BMDIQjfPNwvuB8QabDOf/uu0Djb9fg+Cg6O8JIDODgAIc0QEbz504VCJBFKpQFW5LWpCv9URw1o4i1uZWodP3LXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=xfx8k0sh; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1763050768;
	bh=jnA9DA8lX4Guv4D7cGrX3r5E4UpXiQdK0MPT7VSRILs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=xfx8k0shGB53wDM8+2laIcnxxJzhsneRVU96FJbJ16Tp21kzyB2ulgVkOS6U+hGL3
	 yxZgQ13iuRArXn4Yyzu7ImWWPYjFsLJz8jX8y4BT+A4dqeHnzl204HY8FexWbt8oPr
	 AHb1o7e87opw0WLG792Vzowde34Qj6dt3XFMCd/Y4V30ktfzIFZVm1lpLqzgXF5a8y
	 bI1va3pwqGIzaQkfnv4T2uWcr2S381F2LLAN5AslF/5MI4f1MQ4xIENQdzUU3QUxjm
	 1+TXeKSa821BruKSTmam+8QenBknWPa0qcy7vd6cYdS4/4spdi8SfysNajdez2RQHX
	 Pt+WbEu2/bQCQ==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id B43D93E2614;
	Thu, 13 Nov 2025 19:19:28 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 4599A3E4518;
	Thu, 13 Nov 2025 19:19:27 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 13 Nov
 2025 19:19:26 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Petr Machata
	<petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
Date: Thu, 13 Nov 2025 19:19:21 +0300
Message-ID: <20251113161922.813828-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV3.avp.ru
 (10.64.57.53)
X-KSE-ServerInfo: HQMAILSRV3.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/13/2025 16:01:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 198067 [Nov 13 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;zhigulin-p.avp.ru:5.0.1,7.1.1;kaspersky.com:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/13/2025 16:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/13/2025 3:25:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/13 15:20:00 #27921117
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The call to devlink_info_version_fixed_put() in
mlxsw_linecard_devlink_info_get() did not check for errors,
although it is checked everywhere in the code.

Add missed 'err' check to the mlxsw_linecard_devlink_info_get()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3fc0c51905fb ("mlxsw: core_linecards: Expose device PSID over device info")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
index b032d5a4b3b8..10f5bc4892fc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
@@ -601,6 +601,8 @@ int mlxsw_linecard_devlink_info_get(struct mlxsw_linecard *linecard,
 		err = devlink_info_version_fixed_put(req,
 						     DEVLINK_INFO_VERSION_GENERIC_FW_PSID,
 						     info->psid);
+		if (err)
+			goto unlock;

 		sprintf(buf, "%u.%u.%u", info->fw_major, info->fw_minor,
 			info->fw_sub_minor);
--
2.43.0


