Return-Path: <netdev+bounces-289289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AzuIfAHDGodUAUAu9opvQ
	(envelope-from <netdev+bounces-289289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:49:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233E57858B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE05930EE5E6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F71399360;
	Tue, 19 May 2026 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="kbXdHB8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8939E6E9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172843; cv=none; b=IJmIKOBqwCi3CqXpDNNoyApDNCW2XG/YkTnqhBH4z47b2giHXMAQj5bxU7HgQTSJqPzJlf/tPaQM/DNaTKXiptdJSSO2MvnrFQdzD4e92EuhFXSWTN4jTuW1+jCSyhGjLAnooGmNpL4kmn4aPYB5cCZPYCN0/Jzw62KmkXss2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172843; c=relaxed/simple;
	bh=MQCFbZ3T0Cv/Ph/FRR02W3Cr8hDPWbgSkEbNklJIDjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbOmgm//40uul399I1wpdG91okXP5C94D0TyuB3eDKD1PXHUXfy4/vT2RcpMNLhr6ZIxTwAi9gPuqCCqzP+nLi3CQ4WN3naSb6B75yiB7fxeh/ABu2M/99hkhf3o8PHCiDR7FZ+ed0M3R8lMfGn/+Lfd+o6U4T1hrGmL/gQtSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=kbXdHB8F; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c795f441ff7so2558178a12.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779172842; x=1779777642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilstlfRPhBZeYWhJ1uRBmJ2rJZHG0b5shZT6RRPeE68=;
        b=kbXdHB8FKTUVidwzRYhRX4F/IMXm39wwq7483muiFfSgX/7rJoyq4Z4XdRohNgPCBO
         NKeW5rE5Xpb8BMX5ame8X3QUDN4W0xAm3CLFhEs3eaqb9fYMitYvUNArxSP9PMGWRWNk
         jsRYPLW4Jj8HSFoNuyImJlT96VxgPeTOOLMtcpC77/5R7f4E2/5cusKNnEJcaQYXmoP7
         A/W6PExLTdkFTkOiEIziZu8HUs4Ffd2UeNHE9ooqPxaegKrQhU/KdqA4Pqyj187Nql2p
         L4K+npTTPGw5R8eIpawFJGrjhjhWexJAeKLCNQ7saqcohwvwxnP1mm8XmmiP1FQATNSS
         FqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779172842; x=1779777642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilstlfRPhBZeYWhJ1uRBmJ2rJZHG0b5shZT6RRPeE68=;
        b=h1P/N81/aNuqmLhLpXf9oADVB5lzjgfz0O8krCF3bBGDini/uNYiVgugcedQCrZNrl
         Llk+kuBwU7xk8AbuYUMh7+mzG9zPT2Puq0/jLQDMBO5R29b/2avqhx2/Wlcnrx9/dqu1
         j4Whv7DCnv5V1+xVx2CFxnCE5sI1+JJ5tC9zbT1C+h3E3gbJbFGEej4/3QCohTy7ysCW
         dqY2iORYfk9orrebNaAql1Xv+FKjlNfN6vOdrU+RHhHcxyFJ+nrSrhQS2IvcLfKEA9aF
         E6bLwtEYfoGOk7v9+q1IIrZcZWdafH89vLqzGsn4aN0jAPmgltF8u3XblOcPPV13M1SH
         QPvA==
X-Forwarded-Encrypted: i=1; AFNElJ98UvoIy7AYO46XERJ+IgLIzzy48hB569tzhXUUbOQxBrXInFDWbGiXU+YvCF/CM51U/YDDAmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsLdXBQL0NBtCk1d1hFlAuGW51DFS7UmuaqxoZMITvO/V9UgM
	oRq0Quj4J9xlGxeqNioyli2zxSjYGN2GS/veKy4cvuOGXCOi2ni6GDl27Uwze1eNiOYvYCLWZnh
	DHCpjw+s=
X-Gm-Gg: Acq92OGQFETJ9dvqrwZSG7F+sgQB9haB4fdVF035W8Iy4Q9AxeR4S+MF9X/VWd/VXTw
	QQb4tFic7n4V8tZvbcfFaKDzcrm9WBJN/KFvdZF6dOyUJO1K9KBPuO4n8S3zNFo5DQFul2sjrhh
	ZdUmLnuKm1pe1XEq3k3Wd5PC60nGdXmDMDsPJJn5sLzs55bWgxxItmcaiu7n9/3Eu5h/wQg9DRl
	EQuaJMTiKwiQ/EKT35SA0N2eto9ZDBYe0rkSlNk7oYimj1SnAVQYL/QAyuDEOTytrmU3/LhRUEG
	zamCP9Oey7+E114v/YNjATOthBQxEeSzLGL1TG7T8CIAOEzJwNCD9T5ad0iqlQHxicUjkQ23OHE
	8Aoiypl+Z50egRi0CoV/JJ819Y8LiAPBj+xvhrDW7frFKusQPUPNR6x1mZW6KOaEheKfnrOu4X6
	hyVuPQwnMQ2DJ1I77Z/yXHf4GC1AJ5EyDNHcC3Nu02jO//viA7M+5lQp2g2hbZC04Kcnb3nEd0w
	QSElzjvLu7sGa7A5CdDJE1dhC2Lel4OS23Muza7X3pOh0cwQdurX7Bx9Q==
X-Received: by 2002:a05:6a20:3d1d:b0:3a1:90ef:7e37 with SMTP id adf61e73a8af0-3b22ebe1b1amr21126082637.33.1779172841901;
        Mon, 18 May 2026 23:40:41 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm16016589a12.20.2026.05.18.23.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:40:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: loic.poulain@oss.qualcomm.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: fix potential use after free in ipc_imem_cleanup()
Date: Tue, 19 May 2026 12:10:26 +0530
Message-ID: <20260519064028.60992-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289289-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0233E57858B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During cleanup, the ipc_protocol_deinit() is called before the tasklets
are cleaned up. The tasklets may concurrently access the memory
allocated for ipc_protocol and so it could result in a use-after-free.
Fix that by moving ipc_protocol_deinit() after ipc_task_deinit().

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Not tested on hardware.

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 4405c8531888..939364daf5c7 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1256,8 +1256,8 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
 	ipc_imem_device_ipc_uninit(ipc_imem);
 	ipc_imem_channel_reset(ipc_imem);
 
-	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 	ipc_task_deinit(ipc_imem->ipc_task);
+	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 
 	kfree(ipc_imem->ipc_task);
 	kfree(ipc_imem->mmio);
-- 
2.43.0


