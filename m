Return-Path: <netdev+bounces-246393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E0CEAF15
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 00:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468E53019579
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 23:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8102FDC28;
	Tue, 30 Dec 2025 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cp+gMj20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF92E8B81
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767139026; cv=none; b=gcm98omwfRMNK/AK21YjVxSAoTnud7MI6BF3T6aENGnXhGSajpjHwSmAX3pGJ46lG447ILIbSXkn6vPgnKP06IXphT1hG/7yAFCgiBsQ6wPCmUNcuqzxJhgQxPJ6snTrUTwrVRsmit/er0Vd8EwyDK72gyFUH5y/7gD3/DNFdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767139026; c=relaxed/simple;
	bh=gTyDjneYMywgzwOsVojtgReBKWldGAntIvNhEE6gK5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gxGLlHk7hpN7WJ3phFAPyNLOK2ReAOslzWnQQdEiLC41KtZxsGGBhHloHNmJca0xarfmPmyyALMmHBQ5Hv9XX537Wf0AArKHuzFdrttiN/bkFPvZk8GQNQD0GlAxmgu5EVPVI2RXtEisL9gVKYKENZNq1f2GsKG2aBpNHz2YBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cp+gMj20; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11ddcc9f85eso19818586c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 15:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767139024; x=1767743824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0z+YZ2YNsMdoMFE7LSlh6yUmpOlG2Vk2g7LqMYQuv6I=;
        b=Cp+gMj20HXKQi81pmNJKhz42/WS+RyIXlzQnaTxFZHxj6/P37/cvu8Mfh0QZ2Ud321
         /UHwLAFnc2YrgsOgy/XL5cIU+IEpNerWB6yKo6rHBd/KWA1WUwE3B1yEnK7BagJqB5y2
         hgnPNTMed2LJvzaxX2jlfTllYvEvIgOdol4w3p2CmhQnIAgrQ2kno3wA4aHYkM5ikrO3
         vW9Ng826qi1gNAgXA+1lBYgj3HpUNbf8Gc1oJzirUXmgcqx9XIbQAoeIkyL0vvjKyzCf
         r/L8DDQSlNjjI+yRDeDoROkh4Ohc4G7qjEY8dvojj9fVMZHStC9hjLfCkL8qcKpH9HCj
         v1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767139024; x=1767743824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z+YZ2YNsMdoMFE7LSlh6yUmpOlG2Vk2g7LqMYQuv6I=;
        b=mxTjIfQ0wTXPZHovGEvFfDwG4K1L+f3kAlTtYDCNsbQvr4CoYIUiAOag25kyxvSfML
         yVv5TzFfqXe/Ams336G8QjxkSfDPhshAsV4AFgXHFSHLGDYbXLP5IpAAjzPJOZWoX6xP
         BqBbW2KuOpE1w3CtLTZNTPNVUg3YSavDz0VzFXhMXu5KBRxSb6J6ErtiKOXA1rPEQal2
         7K8eAVkyJ+VhmMCvVst9FqmgHUqBzh+7R4OI0wRJcoDvkMSLIZhTI8QGsQoDBM+6wNcP
         Qql3hA/jzTngBD6hYc+wIRzSHfLnHlpmbQWAaF0nZLOhhUKR9J9flK10G43ZMkU+l3EP
         Zxnw==
X-Gm-Message-State: AOJu0YyPCiIq/31YrxVwiljrtTyD/q3zRl3TczqOjvGQBuKx/d7C5A3P
	wldxh3R0VQSfIu7Z0FF3TyjQCrPLAYzMbogmS6/O7heBw+3mAtSqvEiWVE7IAaFpYSEusLMezof
	AumrMqg==
X-Google-Smtp-Source: AGHT+IHuKsYSd2kwNPtEc4XiZmk+kOE4LhPvJ+nztAMwJKOGMzdDI0Og5UaGs2DvBeC0wc83yh3yJySPuis=
X-Received: from dlbrx13.prod.google.com ([2002:a05:7022:170d:b0:11f:3fcf:58c])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e01:b0:11b:f271:835a
 with SMTP id a92af1059eb24-120619277e0mr35739751c88.3.1767139024417; Tue, 30
 Dec 2025 15:57:04 -0800 (PST)
Date: Tue, 30 Dec 2025 23:56:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230235657.2497593-1-boolli@google.com>
Subject: [PATCH] idpf: increment completion queue next_to_clean in sw marker
 wait routine
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, emil.s.tantilov@intel.com, 
	Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, in idpf_wait_for_sw_marker_completion(), when an
IDPF_TXD_COMPLT_SW_MARKER packet is found, the routine breaks out of
the for loop and does not increment the next_to_clean counter. This
causes the subsequent NAPI polls to run into the same
IDPF_TXD_COMPLT_SW_MARKER packet again and print out the following:

    [   23.261341] idpf 0000:05:00.0 eth1: Unknown TX completion type: 5

Instead, we should increment next_to_clean regardless when an
IDPF_TXD_COMPLT_SW_MARKER packet is found.

Tested: with the patch applied, we do not see the errors above from NAPI
polls anymore.

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 69bab7187e541..4435dba27a24a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2346,14 +2346,14 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 		target = complq->txq_grp->txqs[id];
 
 		idpf_queue_clear(SW_MARKER, target);
-		if (target == txq)
-			break;
 
 next:
 		if (unlikely(++ntc == complq->desc_count)) {
 			ntc = 0;
 			gen_flag = !gen_flag;
 		}
+		if (target == txq)
+			break;
 	} while (time_before(jiffies, timeout));
 
 	idpf_queue_assign(GEN_CHK, complq, gen_flag);
-- 
2.52.0.351.gbe84eed79e-goog


