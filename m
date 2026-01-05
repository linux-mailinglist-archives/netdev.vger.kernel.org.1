Return-Path: <netdev+bounces-246879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCECF218A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 07:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F99C300F596
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459B2727FC;
	Mon,  5 Jan 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ysmpa/8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AF234973
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767595660; cv=none; b=SM6wUPzIa2gVSvN8FtFWsoeN1/yi9v50TM5l87EzmA79P4ZY79J5uIcwSa/7lpphs5esNVcKBuq5Om01TlXs/PJ7wL+sz71SjzwDy3TuzxLVpTcMIV2M//9cHcxmQhM9hokF8F4P8QS05YwqqqRMKl5Znc1rgZFtbGNVyTArYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767595660; c=relaxed/simple;
	bh=ngDFzAk98zblziJi6NX9uVYDoGKo9Nrfyq4QFegNGU4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MUxeUFLywfIOd3gdm47NDlDUA2MnnFrQiQunJOWKFbeh2YHusC2PRjYbNde3nVAbvnDFIlHdJn1xWTUXjNvo25SZ3u5b+NaZgZrWz0iP1jrtHMFMOMZ1NkqD2/fXEi12dci5pZtCl5tUWTTu6M5dGJlLNkRQ+XMwvQ4lYDEWABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ysmpa/8T; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-be8c77ecc63so21311869a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 22:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767595658; x=1768200458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mjAQnRT+AxzqanaejE5B0HLUFAhnUu0WbGuSKAysFj0=;
        b=Ysmpa/8T5Puvbgoy5O73ylg2IPBPEGZtD8leJFHjM8PrZXHUfmkzQXPuWT9TZB9wr3
         zy1TMgeLEfXWM3SfifxfXXoRGo27ejbRM2/kYe7ztWludtuKp/1JwW5sdgQgM2165vp1
         O4XZQBELs2e0m6vZf3JmaZ/2eRUwKEhmRSYjHPsc3DyPXFT1NsQHAWEYn/YRvxuPM1Kb
         aR8UfPx4kqc8kkSt1FNUbk+9Sb63aAvXILvIQGCALq25iUYw/aADk0JIo8yjr11N6jDF
         olaJNks+MbEHBHYoT5X8iMml/cL+jVol75mLa2zRtJ8UjhirzMGC4a+k2cOAfb479/uy
         9WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767595658; x=1768200458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjAQnRT+AxzqanaejE5B0HLUFAhnUu0WbGuSKAysFj0=;
        b=gWVnH5ImL2gHvg29Rgp5iV4DBuZocSpW+SygZQo5u7EeWP4HKYG+mjuHjACxpgQx6H
         ttovrHgTLTo9uSEEBwlg26KjWofyDv3NjmBXgBO1134nBNYhStrOL57ytiXk6ivD4v32
         8A6cuWQ4WnFupqMtbESqis1TVUFTLjQQ/X9fgSmBzE7mTyul9glu12xeqTBL7KiHOM5l
         E4cFdn8iHYwKlB9MB93iyGEXA1Nb6HITaMN88US4vES34Oy8J2B7W0AK/0zkdV58N46a
         tKCnWfZ9iCx1Gc+CA3Rwb/OOE2GQ1s9xpR0mssHdCbDnXwDEikQpTGu9yuf2ocVHc3DJ
         MHIg==
X-Gm-Message-State: AOJu0YyLB7qD5bqkPIvDKDbEvEHRbZEJgVHvkuDnYNethPhjnVooNCzz
	8f+EDwDamPZ2ySH3G8S164JIjyqUNZLwBQSfByVsAs6o2e+IcQO8yTxgaxgxw/WXJ6OA/xGY9Ac
	AxwfqJA==
X-Google-Smtp-Source: AGHT+IGecM3V1/67Gd3XVwwfB7BDjB6Zhr/zQO+BcKcQf4wP5oFodn945+Se44z7byhEdWZJPiihQV1BfV4=
X-Received: from dybnj41.prod.google.com ([2002:a05:7300:d0a9:b0:2ac:3545:743c])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:240b:b0:2a4:3593:c7d9
 with SMTP id 5a478bee46e88-2b05ec34963mr39421255eec.25.1767595658236; Sun, 04
 Jan 2026 22:47:38 -0800 (PST)
Date: Mon,  5 Jan 2026 06:47:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105064729.800308-1-boolli@google.com>
Subject: [PATCH v2] idpf: increment completion queue next_to_clean in sw
 marker wait routine
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	emil.s.tantilov@intel.com, Li Li <boolli@google.com>
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
Changes in v2:
 - Initialize idpf_tx_queue *target to NULL to suppress the "'target'
   uninitialized when 'if' statement is true warning".

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 69bab7187e541..452d0a9e83a4f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2326,7 +2326,7 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 
 	do {
 		struct idpf_splitq_4b_tx_compl_desc *tx_desc;
-		struct idpf_tx_queue *target;
+		struct idpf_tx_queue *target = NULL;
 		u32 ctype_gen, id;
 
 		tx_desc = flow ? &complq->comp[ntc].common :
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


