Return-Path: <netdev+bounces-252636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLBeFeAGc2knrwAAu9opvQ
	(envelope-from <netdev+bounces-252636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F2706FE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A969330086C2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 05:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B53915D5;
	Fri, 23 Jan 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jE+cV9TP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EA38BDDE
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146074; cv=none; b=V3mVlPc9yD9hClElY738t5TqCM5blVpKK3zOZCctdfL9GQEIa3qaaIIPvxKtHUqjGWBPD8mJ6l7QT/HlZVVRncKwW9GDX2SIdUN/YmGUt5o8TQ0v2y5pWia5L7YNFhwyZIWKZGcDgNNk6L/jTmbCV6vgskMGGlXcKZ16DD1JLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146074; c=relaxed/simple;
	bh=t+YS0IFF12k/AnkeFlvc6z2MlqpKmEJZch2QYMhzMa0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D+Ok/SAb0kH2NwwNFJRFTHEsMhza/7x1JV8smvp/B78rPh1aZUKY9TGXjgh9CuR0hTMmKK5t5xtTbwFrFGabLUZJEu+WG+UoRF+rz2EIULzPwthT3+0LFESihcSr+BdoZKhCH3aGrurwmbzzS4xpTZTseiZF0i1SMAteQt5GVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jE+cV9TP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b72a9a9715so6226494eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769146066; x=1769750866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAZSzyn91YlrkG1tCKbVc9M2F6+GonYziUiLWmXHc7s=;
        b=jE+cV9TP7FWGbvoJek2TzcrIQ/RyTLYRDpa4YKwB1jjGGHrtRUP5oxm6H1Ea4h/lNe
         W9aJY7rut8VnLqwRyuQDkSNlswtS7jCV26CUBTxQ1PJHH6NNzTSqRohK8owflqRP6clI
         lyMjpBf1W56wYjmitozJ2SDbaZ3Hmj5QJ0tewVFTs55uO5zYzxhsSE79MEE52vJHc1mP
         8DZd7RYzUH6NdfX+Y3+b+M41YOlX6Dt0ALhMIzNe1d0c3m59B1DLL2nY8Qo0I9vHsM4B
         ZMhHRbNWHedCsLxd4dQyUJ326gMUXcx3Xiu/KlRdL97D3aUJaoH7r9i0twGBW+xdRX/T
         cAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769146066; x=1769750866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAZSzyn91YlrkG1tCKbVc9M2F6+GonYziUiLWmXHc7s=;
        b=C6W7FX+JEkF2JohUvsEVxH2c7j/KF+GTAimQbNGOXNktry6UzjLqtHgNpjyGgGDpic
         DlR9XD4iXH4T9Eboc/38liw4sQP/kJOhUL2oGc9xrq8Op7OcpCEp/UZUdDhJz+iRMoy2
         lC3GrQT3qJ+m+jdSakL6NAdVOx5ZaEWXvJNyCmZEhvC+0P3mEypH4N+5DKjH9D/FrqnA
         ucK6ZJLnn/IU6BR+ENqJOQuB56xz2GeNCywIUpONGpgAx4baklnNy+SjWSNqkmSTpaH1
         k9A85rcADFBh6ZhY96YuFCKj/n4hmwKB7ssZolLv+A3Cbjhf92cHL8MabV8Jq7ON23ZE
         vD4w==
X-Gm-Message-State: AOJu0YwUwqLIvu6fR4pKdwMsm5fXjvYWRa3MiFCpQF210ZOFiFSRLEiW
	3rlRSz3kOSfsJ966PmMQlS+B/nBWIGAd1n9VjjCi44mpb91R2G2DP1XCqWds77s4rcc1Ky4BlH9
	TjAYk3g==
X-Received: from dycmg13.prod.google.com ([2002:a05:693c:250d:b0:2b6:ad52:b359])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6425:b0:2ab:9f55:d15a
 with SMTP id 5a478bee46e88-2b739bbffb6mr874638eec.29.1769146066294; Thu, 22
 Jan 2026 21:27:46 -0800 (PST)
Date: Fri, 23 Jan 2026 05:27:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123052721.3765743-1-boolli@google.com>
Subject: [PATCH] idpf: nullify pointers after they are freed
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252636-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC0F2706FE
X-Rspamd-Action: no action

rss_data->rss_key and vport->q_vector_idxs need to be nullified after
they are freed. Checks like "if (!rss_data->rss_key)" and
"if (!vport->q_vector_idxs)" in the code could fail if they are not
nullified.

Tested: built and booted the kernel.

Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
Fixes: 8a558cbda51b ("idpf: fix potential memory leak on kcalloc() failure")
Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 131a8121839bd..7af4214ec44de 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1308,8 +1308,10 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 free_rss_key:
 	kfree(rss_data->rss_key);
+	rss_data->rss_key = NULL;
 free_vector_idxs:
 	kfree(vport->q_vector_idxs);
+	vport->q_vector_idxs = NULL;
 free_vport:
 	kfree(vport);
 
-- 
2.52.0.457.g6b5491de43-goog


