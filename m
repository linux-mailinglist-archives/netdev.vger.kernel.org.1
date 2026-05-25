Return-Path: <netdev+bounces-291319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vCFPBrFGFGr0LwcAu9opvQ
	(envelope-from <netdev+bounces-291319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A21845CAC3F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E92F3300753F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321003839B1;
	Mon, 25 May 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBeT0W//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC24382F1D
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713711; cv=none; b=ewjb2Yz2FdAytNPrj2rhhwMMoKyGK5tvUMzAl4Y2PeECoSaEiMVrUuylZJsNaOMibVoOfCQkBAy0wmMbXFaMr+cplUuk9EyC/hh3sQ2e2oY+98qX8dknk1hYN6L8BvPh4/zPO3txzieXHeTrKTncJQzxevrEal9969iKNnLAeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713711; c=relaxed/simple;
	bh=+Oz7xDaxomFksO6PbaUmq2PUrf5hi7/v+LsIsPXXlUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unnhqBGjs4pkEVNTzGjgfy3BE7QmoehajxdegbXOzgf3XjZ6vFvjpHr5BW5ClnFbpGp1k/mBcynvMbzzP0gpuUSwy54BW8gGmUiTk0e8m9AFCwAUnNxsE6Cn2gqbttvktNmHRhXB+xx6NUs2jgt66HhWdy2S79FYD77oMiapvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBeT0W//; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso46016935e9.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779713708; x=1780318508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEkEytmYFd0grw0gd0pRtaK1Cc0zf7E63qdR1+4KD44=;
        b=GBeT0W//M2GA2Jh/ufGh/ZU+Exkt5EvJYX1j9CPEcz8j1HJbhBrExFcJe/hYQ3fa0W
         EFucSQw12vM1MWZ3h4bOK3bbMYUW0wHKtCNgnqNS+kugqMg8EGSQZp5C+g4JUwxHB+2v
         uwnh9GrvMDXQGwjPDro0Tid/jNKg4JEuRL9LhUn54YA8RJvr/NvOB91SGkYMGGAASEAG
         3W7t9Hbx1Mmf+XgA9qpxd4tcooogza8BePJXtMFZyvJkQlK5I699RABnAq7GW5JkQDgc
         JZVdD0tRBxV9O54kvUCBXiJgAK5zRaVJReSiPYQ46SN2k9Ou6UhUGwudLqhi/pB0bDtz
         TOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713708; x=1780318508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEkEytmYFd0grw0gd0pRtaK1Cc0zf7E63qdR1+4KD44=;
        b=G8jnbyke+EjEizpiezPvEKXtAnboqD2kCgO4UZBbOYpWxpSeZ5w+3ljI6e08i/vmAp
         PpfNLS9NPixZsQLm4kMeFOMllhe/GsegSLngwVTcONTyryQaPu4WxaCG896cAahSggS6
         LLGBwJb2uM7kLGwGb/FNRrU3I66xOsxeNvHLMwaOXBsFe1/hPaKzKPrduqIraUnNW3hb
         0p80ZFj/tHhWa0RKHUkMOYn4LWh6tq66LZnObaip1f6N/RoSvgoMMA47DPnlcyyHApQI
         DGrlsVmmbgn4IJAlygXQmSHI0MO4WiPtDb1Ad+sFP2KPBE1xMGqu0Kq6l3ugHpdrABul
         /Dow==
X-Gm-Message-State: AOJu0YweHyvmqnmPfTQfMQISDeQZCjGnFXM0DO371dhap6eKFRT1yN0Q
	1HAnl9wknUAe5rsS+j7zlVpVHsEJHsKOix4MsS9OYLdww7g0weKIozCU+siNZ3Tm
X-Gm-Gg: Acq92OElq7rRlxAwXcVnokt7R4E5SnDyISNr7Tkp1/fozmjEfFtvCmUYc7xi+M8e7cp
	Mdy+pWtPMJ1ItDPU7C+THqIR/OTCsiwlrU5P+AOCfvb+6N2bA51ceSBGXZLqA8Gt8R1l3nTUTGp
	zMfO/ABtDgUv30tCEamkYfYPgpG/WZCaFVNmv11IEjDrnyX0sE4yzl0uIKGQDeXEKWsu6HngtHj
	TgyGRHQhDQehhmucmQLys7xCoUf1QuDPDWrjiY04LHviBehWVChqMbmXlQSwEyB/9Xh/2kCiRMb
	Y2x9O5LF+1XyxsngnWN2tgk6+gXCM4N02CKgVZzIJK2Er2w5WZ/HHGK+ANa8TIvfIziXfROcDMh
	wqC7a63+UZDaYejemgdgLM+5LpN8vvOrEFfz3CfII9UjIOnFDO9KMT0Z82pcnNmv9I7KMW/xsdj
	OQVx5RpmVUTYhOjR9YdOTD
X-Received: by 2002:a05:600c:8708:b0:490:505b:512c with SMTP id 5b1f17b1804b1-490505b528fmr177536475e9.19.1779713707580;
        Mon, 25 May 2026 05:55:07 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm258009565e9.12.2026.05.25.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:55:07 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 1/2] pcnet32: stop holding device spin lock during napi_complete_done
Date: Mon, 25 May 2026 14:54:36 +0200
Message-Id: <20260525125437.4061-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260525125437.4061-1-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A21845CAC3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_complete_done may call gro_flush_normal (though not currently, as GRO
is unsupported at the moment), which may result in packet TX. This will
eventually result in calling pcnet32_start_xmit - resulting in a deadlock
while trying to re-acquire the already locked spin lock.

It is safe to split the spinlock block into two, because the hardware
registers are still protected from concurrent access, and the two blocks
perform unrelated operations that don't need to happen atomically. The call
to napi_complete_done does not require external locking.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
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


