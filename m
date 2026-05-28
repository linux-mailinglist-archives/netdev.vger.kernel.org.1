Return-Path: <netdev+bounces-292703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE0RDqlNGGomiwgAu9opvQ
	(envelope-from <netdev+bounces-292703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:14:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A85F37D5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F7730ABCC4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB32DAFB0;
	Thu, 28 May 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpiwwusP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1D2D8793
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977037; cv=none; b=Hv2jU9Ep86B2oZC7ADkqWQis3rzZpiDdlMo0odXGuGpdKrUlr4HKyNtXLtpSsaMifOr8P9jOj2EMaA0hSemotuo0w1tHZ8UEQI7U1F9rOuDyF+FzUwGGYmJV5GugbR4Ynzle7iueicQ8ax9hEcHTp/jabM+RACzAm5A/ohGFGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977037; c=relaxed/simple;
	bh=J17mXSA6Oe8eBAQLMX4fgFo8ZaEX2UnL/Vjqi8sZMZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5Fm2/yXF/rWASei1jZ7mG1YP1XeJutuu+PN9qauttSzeXVc9Y1kIz+DnliYAACqxes2p2ZI2sNJbuwM/UgwM2ztAeRZKcnTPSdp3ZN4N3Ichyb/wL3f6Ki9zPrAPMb72b6/R5BrkxNRHF3Xr9DcNC0a60xX3aA5FY0gxeGDFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpiwwusP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-be4344dde59so225409466b.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779977034; x=1780581834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Z//wfpA5Gl9EfpgcN16YNbfavUdoFLfDddjZXAiPI=;
        b=NpiwwusP/qO8kL9HRkRctS6BbjR04vmwHssaZoK8MYvkMoc1fKYbMoJQHgtYnv9RL4
         M6Nb77WHXJjI3RJ83FIW4Tm0gvq63gFmcraurtmvTU7xrZNqeoZJhsjWMRjzJAqpnmBC
         RtdW8O2zEpZdWOebkarh6EXOb4q+8VrP7tO2KSfwzTsdk/Jg9HhZ2YZWVlA3KUwxVimM
         jekRi8HxMGaiHep874p7YOyQLlnifk5AOWUquDKV+5kJuCRYcI7+9qcn2YF+rLI+3Cv+
         OI6EVbK6bRWohlj/4B0TK3J2he4sjdEaD4RZDLyvQJ49WJS1bmJRFd32ugPSneZqLgwy
         p4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977034; x=1780581834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Z//wfpA5Gl9EfpgcN16YNbfavUdoFLfDddjZXAiPI=;
        b=CvnDcyYzRbyScOsljwG1GQmvuFGaDv8kcxVJx5N40Yeay3j7aOxjJ1vuoSFPh3Gqn/
         Hr24y7zaWdv7NQDV1zrCe4ULexTcXJHKlSjpjvBDq5moah+2EZgNT4fZ6l4ubXCuz0Wa
         Xf7KRwKk3t9XcpxS+Wt9/IPiUBMXcNleNUgs9Oiykv4V8P2+m8osCII1cnWC54noRKWa
         QirAtwBg1kBKNOfRgKTHltkFk0QfOXNHQGniTBehvGxS2mCnD3cfNpwSl0cnPglJxe2Q
         OFN76jPMjMrQLbVdR+vtcDlZSYvxkX0zpV+Qm4OX6yCnNghJrGZSsvGuWWJRPdYSy/H0
         hYNA==
X-Gm-Message-State: AOJu0YzRnMSWL5pq8y9+sv/oG/e2XuAw8Zsi948CZo9xMl39B+R+MLue
	U64P/yjQ9BL1dHx/5V3nQ8/XRDIuj43tXW5I0droiq7YW905ciD2xjMhz1yCaQxY
X-Gm-Gg: Acq92OHIuxrdN6T+8qZH9HrHQuY6IALgDmkWxDbLgLGg/iOWrU0sAehWcV/UddZIehZ
	PlNJAOC8FAZEtDINKtZZk/Vu9ZABWpbMA0gRn4qBpqty1nj+H1NqVDnl5Zr38lOBXxGuZp10H4z
	WepV41sXVNczjjF3Ugn6xjEuz85fcGVVUSC64LvBmJ0jM5IMbkVg0IgkUaailMZ5CsSV7BtBY5l
	rmKwPyINtFumbId06AINl49E6KNwSelCTBPJQRccg49tWFB+m35f4wAQt6Xv0LsgFoPv8z9aGGl
	x5D4iKS4CUJPnA9AUUz+UNL9JyN0uaFNIMrldRbi1husGyM+UneseRD7ig9y7Z79p3gG9Ik2zwZ
	fA3F8QNRLpAur1oXMciWquRYXzkZJt4oNV4QVrUspkMAR2Vj5DUHj0vPgWQ7mUfbjFg8HLWSag+
	eGFffh+rYeP5GR9ZQtqGsgg4b3rcNIcx8N
X-Received: by 2002:a17:906:c112:b0:bdb:7c37:183f with SMTP id a640c23a62f3a-bdd22944808mr1746438666b.4.1779977031811;
        Thu, 28 May 2026 07:03:51 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ece286sm724263266b.40.2026.05.28.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:03:51 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net] pcnet32: stop holding device spin lock during napi_complete_done
Date: Thu, 28 May 2026 16:03:20 +0200
Message-Id: <20260528140320.5556-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-292703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: B59A85F37D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_complete_done may call gro_flush_normal (though not currently, as GRO
is unsupported at the moment), which may result in packet TX. This will
eventually result in calling pcnet32_start_xmit - resulting in a deadlock
while trying to re-acquire the already locked spin lock.

It is safe to split the spinlock block into two, because the hardware
registers are still protected from concurrent access, and the two blocks
perform unrelated operations that don't need to happen atomically.

Fixes: 5b2ec6f2be51 ("pcnet32: use napi_complete_done()")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
NOTE: This patch was a part of the following net-next series:
https://lore.kernel.org/netdev/20260525125437.4061-2-oscmaes92@gmail.com/

 drivers/net/ethernet/amd/pcnet32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 911808ab13a7..4f3076d4ea34 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 		pcnet32_restart(dev, CSR0_START);
 		netif_wake_queue(dev);
 	}
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&lp->lock, flags);
 		/* clear interrupt masks */
 		val = lp->a->read_csr(ioaddr, CSR3);
 		val &= 0x00ff;
@@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 
 		/* Set interrupt enable. */
 		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
+		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&lp->lock, flags);
 	return work_done;
 }
 
-- 
2.39.5


