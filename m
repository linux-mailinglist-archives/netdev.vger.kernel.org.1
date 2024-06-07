Return-Path: <netdev+bounces-101687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CB8FFCCE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C751F2BC73
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB59156674;
	Fri,  7 Jun 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="U3F1oE1R"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F19156677;
	Fri,  7 Jun 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744081; cv=none; b=ad74I4V071oYF+9hFqHQqbMcBqBEiOqfGi+Di5hZPGcofkCk66BW9325E+MA+XzcGDjTNW+iL4k9xMqOs22432Z2lOHqdZfdENDhzgmLoInfZiieEsKMbi757c8b5TI+zoZ+nnbIXuFXrhmXa3/JmIuBUz5xOPvAnG8evRC5MrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744081; c=relaxed/simple;
	bh=9N6LBKuAH976EbATXvsJHS0pHP75Lcnbxv+IftIOUMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E1m5S5sr+6jNFuZrGJ/T1GUgXIulN+zIHsgA0oPLtY80udlankZQVn0QKoBUfWb1baVds8gV9ISUiUYm8dMT9+w9MBptIBtZ8+7nEvbYzDVOVYsFv/VMzW1CxI65qT2anL+S5R+Pay8aBtqzN0rivXeVBHc+l+zd7OUAR4Ax1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=U3F1oE1R; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 3E01A100005;
	Fri,  7 Jun 2024 10:07:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717744057; bh=DffuvnTwOC1bCtk873CFHVXscjLZcp4C1sofiMUwZvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=U3F1oE1RlUl4TTOFG7KP00bnlZMl3uBdi6cE7CDtxxWjoWVuf5jVzM2pjK90mCiUI
	 DJlgLd7Kt3a7n3X9CwRXk0MdyPeo3Z7kcyLJUmJITOUlw8H8OKCLidee7qsm7n7243
	 /NkPckSWmnSSGWROgrDb2vBHrUjOqm41uTuDRQALlqZQLKHQ4LVNQHevPPqiSc5VSE
	 8NfhdovgK30sTNbOkhXcihXhq36EJajDsqvsyGIs8V2jOtedsg96b+Ch0iVQ4DkqAw
	 8jH3BkXZyVCfdZDTK2Q2/m3UiSB3Ai+lvFkE8rXSOQjI9Pw2n+e6Bco/hsahCA7P3r
	 fw4QIUCgxeAlg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  7 Jun 2024 10:06:41 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 10:06:21 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Edwin Peer <edwin.peer@broadcom.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Chan
	<michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()
Date: Fri, 7 Jun 2024 10:06:13 +0300
Message-ID: <20240607070613.12156-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 185791 [Jun 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/07 06:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/07 02:34:00 #25498572
X-KSMG-AntiVirus-Status: Clean, skipped

In case of token is released due to token->state == BNXT_HWRM_DEFERRED,
released token (set to NULL) is used in log messages. This issue is
expected to be prevented by HWRM_ERR_CODE_PF_UNAVAILABLE error code. But
this error code is returned by recent firmware. So some firmware may not
return it. This may lead to NULL pointer dereference.
Adjust this issue by adding token pointer check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8fa4219dba8e ("bnxt_en: add dynamic debug support for HWRM messages")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 1df3d56cc4b5..14585ac476c8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -678,7 +678,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 	if (rc == HWRM_ERR_CODE_BUSY && !(ctx->flags & BNXT_HWRM_CTX_SILENT))
 		netdev_warn(bp->dev, "FW returned busy, hwrm req_type 0x%x\n",
 			    req_type);
-	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
+	else if (rc && token && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
 		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
 			 req_type, token->seq_id, rc);
 	rc = __hwrm_to_stderr(rc);
-- 
2.30.2


