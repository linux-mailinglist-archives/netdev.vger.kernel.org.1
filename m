Return-Path: <netdev+bounces-135746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C099F0D3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FC11F21B1A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087A1CBA11;
	Tue, 15 Oct 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVIZiCEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC91CB9F2;
	Tue, 15 Oct 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005373; cv=none; b=o/JgkNKU9zeRMT+DGdDmNC+x1YUKyHQb+6iA+iOHgbZlvZbraGpJJAuCMgFSRENqUoTeHgug8+R7iQCSqTpaXBzOHGC78wQuYKymeMr5es8hXGon8oRWzi5enV5f3rugbkOsJ/0YfJqVNXAdoHSmIUdIv+tncr9H4qeQySA3qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005373; c=relaxed/simple;
	bh=1n63qeEr08WQPumy0zncbmGIU7vbuFzBcsASs7pW4Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uqFFWhs/Mp9aoU24aS+pqyE4ASG/V3QoPVRDcNgkFC2mKsnTKStzpAqtm9fTzC8oRBOsdzc4ihu+QQNBdhfft9xUSSNxeCh+mOOoByMHZfzrLCTcZw/oBkla+aPH+RPzSEr0Y08E+U8yPtlixNrl9pdGTUUK3UyPlCeTdOvGanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVIZiCEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E3CC4CEC6;
	Tue, 15 Oct 2024 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005372;
	bh=1n63qeEr08WQPumy0zncbmGIU7vbuFzBcsASs7pW4Fg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BVIZiCEossy3oj4CTO6JEd73Zqbs6UnsyI+oUU9raPUbY0olk/wLxBi0ke+eIgOra
	 ijqrBNAHTeh+QHHCMlvyrhB+4lIa336ThXWs2W5wTylB+7Io33RPNIVH83A1M5F/ic
	 7ySUJJGvr5KbmXwu0yJMQlXsRnhaA0+sF54YopGK4VhUJR6IDa6bKQMTW7kxGcZzzb
	 th6dJq4XASZS6nMydFezNCExP2CK1rvkdS8kxVogqxjf4J0NPuEEwK/etTFTlrunAu
	 hJttEAJw2bGZcSO1jf40CDfYrL6yWR/kbp1UzUT2wjbIB8vdE0MnK5he/T6Ju4oXj6
	 yfNOl8r7vtBgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949B1D2169D;
	Tue, 15 Oct 2024 15:16:12 +0000 (UTC)
From: Jakub Boehm via B4 Relay <devnull+boehm.jakub.gmail.com@kernel.org>
Date: Tue, 15 Oct 2024 17:16:04 +0200
Subject: [PATCH] net: plip: fix break; causing plip to never transmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-net-plip-tx-fix-v1-1-32d8be1c7e0b@gmail.com>
X-B4-Tracking: v=1; b=H4sIADOHDmcC/x2MUQqAIBAFrxL73UKKRnWV6EPqVQthohJBdPekz
 xmYeSghChIN1UMRlyQ5fQFVVzTvzm9gWQqTbrRRjbLskTkcEjjfvMrNndboDWznWlCpQkTR/3G
 c3vcD+1936WEAAAA=
X-Change-ID: 20241015-net-plip-tx-fix-822e94e58a6e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jakub Boehm <boehm.jakub@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729005371; l=1232;
 i=boehm.jakub@gmail.com; s=20241015; h=from:subject:message-id;
 bh=GSlzcLm/qPyuhys1asxJpTawVSorVrfA4ue4kauwzWE=;
 b=By9Huyk052EGor7HPwC5HMjk+iUzXISWFW4WNpJ9QtGtZf82sMIZfhCqPBwMhkofUmn/m8xv2
 D8Ztx+eNsrOD2NGjz4Id9B/Jf7ipoDiwVyclxdm/Siw5Do8PU6FgSJm
X-Developer-Key: i=boehm.jakub@gmail.com; a=ed25519;
 pk=Ec61DIB+jRZFEPPDlta4lWaV/69t+jWiuBU6SF909iQ=
X-Endpoint-Received: by B4 Relay for boehm.jakub@gmail.com/20241015 with
 auth_id=249
X-Original-From: Jakub Boehm <boehm.jakub@gmail.com>
Reply-To: boehm.jakub@gmail.com

From: Jakub Boehm <boehm.jakub@gmail.com>

Since commit
  71ae2cb30531 ("net: plip: Fix fall-through warnings for Clang")

plip was not able to send any packets, this patch replaces one
unintended break; with fallthrough; which was originally missed by
commit 9525d69a3667 ("net: plip: mark expected switch fall-throughs").

I have verified with a real hardware PLIP connection that everything
works once again after applying this patch.

Fixes: 71ae2cb30531 ("net: plip: Fix fall-through warnings for Clang")
Signed-off-by: Jakub Boehm <boehm.jakub@gmail.com>
---
 drivers/net/plip/plip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index e39bfaefe8c50ba72238d04f08deaa46ca650c70..d81163bc910a3bcaa770a10c0e2d7d9b334a381b 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -815,7 +815,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 				return HS_TIMEOUT;
 			}
 		}
-		break;
+		fallthrough;
 
 	case PLIP_PK_LENGTH_LSB:
 		if (plip_send(nibble_timeout, dev,

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241015-net-plip-tx-fix-822e94e58a6e

Best regards,
-- 
Jakub Boehm <boehm.jakub@gmail.com>



