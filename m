Return-Path: <netdev+bounces-102056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C29014C0
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902631F21573
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136E13AD8;
	Sun,  9 Jun 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="R7gKVuSY"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F73F9E4;
	Sun,  9 Jun 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717916628; cv=none; b=sxMCKp1gguXiScSHIeHP9h78iXbxPA1imyDBg+6X6A/Rtm1H+fLNtv0HQArJZOHrRnofb5XiGzKycyapXa+j5BWtszVqsPbLQ4TL6OQWDtgijmstpQZxP1Vu3RpFL0fvEeTMTS7Gi21pKfJN5FMbT3AQq4PGtj7HLiTVq5SJmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717916628; c=relaxed/simple;
	bh=G5jo3zUfH0rx0gxNk/gy1V61RaR8N0DTrBTT+oe6hsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4gHfTCSFnWMFE8JRNT93NPQCPGvlKX8nubnrCb4OSWSYzV4mhmlEh7Vnks5kKvrmkXpfElLMu8A9a3+xeVgC5YX2nmgVPd9Muhq62hUezYn++70VInsodX/BAeSYz2KjsxAxGjHN4+Qqa5FiDNlPDFnxf2rvm+Em+/jtAm60UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=R7gKVuSY; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id B3663100002;
	Sun,  9 Jun 2024 10:03:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717916597; bh=AyHJoAgjcoBVULg49ijh2T3fkhZTkVF+LRZzusXaTYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=R7gKVuSY45ptuCvbTSVZa6l7/tWbVKtXPVjo5UypK0tfPVLP4ueQonMq66NL05izr
	 QuxrqtH0NaIbqjQ6aX9++TgfkFdCDOm2+H6P2RSY9/S8opTLDxKBF9Ydl90rEsQ9i9
	 HG4eC/4upQ2zma79PoHeZrnLEHZdPCW4R6nwnlorvjlKjKaCW5ltouaXHadomRPr0k
	 G+oycShEil/N0bvDWfp7OPzEjS34OfztaV5/YPG333O7WqJQ9AsGT3nJPgAbNxtC83
	 qtonRXOEVgX6Vr4UPSkCS+adWrHZ4iun8SYufkEXKmJ1zIsG6mDFcOJs5W6ONLe7Dd
	 LbLj5Ko10Vycg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Sun,  9 Jun 2024 10:02:15 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 10:01:54 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Edwin Peer <edwin.peer@broadcom.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Chan
	<michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Wojciech
 Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net v2] bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()
Date: Sun, 9 Jun 2024 10:01:29 +0300
Message-ID: <20240609070129.12364-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 185814 [Jun 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/09 02:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/09 04:46:00 #25519876
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

 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 1df3d56cc4b5..67d0ba8869f4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -680,7 +680,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 			    req_type);
 	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
 		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
-			 req_type, token->seq_id, rc);
+			req_type, le16_to_cpu(ctx->req->seq_id), rc);
 	rc = __hwrm_to_stderr(rc);
 exit:
 	if (token)
-- 
2.30.2


