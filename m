Return-Path: <netdev+bounces-102504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CF903665
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37A7B23723
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E817334E;
	Tue, 11 Jun 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Kd07t7jM"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57044152178;
	Tue, 11 Jun 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094466; cv=none; b=hCPcLR8y1oSPLG+Gjv/3REPdg8GDhtztPOQvRR3FMbERA6ft38SjUMrPk+cGFgcBPQ02AkbsPSkcPGAQK9Gsljy+KL+x4VCW8XcPtzuhzWQYpLvt0QFnYdSFnR930/8Qffm6KIQi+511bF1hXajpfI8owVqIOClmgLOM6+++w9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094466; c=relaxed/simple;
	bh=S9etYCrjDhnD286GdZJel9VZyLYtyY1IIfEvrHkgZdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAdXdh8/ekI9CUs1XQO4tVV2YNE/MtgfNy2c/Td0LWs9rMtD6KwkMdMz9tm5BykP+gi6jwWR/bq7lkcXgC9sCD+w+WRYlLhFSBr9uB97BFBFk2SHnqhxFUk6GJx02PrzUck8VhAxs3qmDcjVUoJ632hPG1mAASbcar8979ZE6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Kd07t7jM; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id C2600100002;
	Tue, 11 Jun 2024 11:27:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1718094436; bh=oFr2YS8xOkbzW4Son0Mqyup2AFLMMw+xc2c2p9yDb7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Kd07t7jMBRIFed/W7eTPu1CdgJuCtfVSQNreUt0PqSJ1O3Ih5aRM3+1+MRpb4WnLr
	 ukcuhYepphPn0jHijbkF9R9uwDgEUfD6xftTW2KsmpARvacqeP+a/hVlc+flbvxekL
	 bMGvXEIoFMpCdJd0XF6jbb8hR6kAhErW5X2kyOKf4PcFNZLoW+1eEPYERvewqHcOXW
	 wrqKPg68KIwfsC9KxL2NfNFv9iuIV1jfG77AXDhrzqbIoJR+hTg9MzN86LtAkcO5or
	 nl1jZEq9sq+5FhoWbFko22nDCEbvz8pAK4UrxeN8ZBahfaoJ/WFRHVP5DIkrDKZdVi
	 ZfGAcYcAeh2qQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 11 Jun 2024 11:26:15 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 11:25:54 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Edwin Peer <edwin.peer@broadcom.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Chan
	<michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Wojciech
 Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net v3] bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()
Date: Tue, 11 Jun 2024 11:25:46 +0300
Message-ID: <20240611082547.12178-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185852 [Jun 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/11 07:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/11 05:58:00 #25560715
X-KSMG-AntiVirus-Status: Clean, skipped

In case of token is released due to token->state == BNXT_HWRM_DEFERRED,
released token (set to NULL) is used in log messages. This issue is
expected to be prevented by HWRM_ERR_CODE_PF_UNAVAILABLE error code. But
this error code is returned by recent firmware. So some firmware may not
return it. This may lead to NULL pointer dereference.
Adjust this issue by adding token pointer check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8fa4219dba8e ("bnxt_en: add dynamic debug support for HWRM messages")
Suggested-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v1->v2: Preserve the error message by replacing 'token' with 'ctx->req->seq_id' as suggested by Michael.
 As the patch didn't change significantly, add Wojciech's Reviewed-by tag from the previous version.
v2->v3: Fix missing alignment.

 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 1df3d56cc4b5..d2fd2d04ed47 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -680,7 +680,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 			    req_type);
 	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
 		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
-			 req_type, token->seq_id, rc);
+			 req_type, le16_to_cpu(ctx->req->seq_id), rc);
 	rc = __hwrm_to_stderr(rc);
 exit:
 	if (token)
-- 
2.30.2


