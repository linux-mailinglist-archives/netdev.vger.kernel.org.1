Return-Path: <netdev+bounces-221855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF0B5225D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6834672C6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AC2EF67A;
	Wed, 10 Sep 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxM3JIWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253B23B607
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536640; cv=none; b=PUOLBMB6EzoVclSt5gKLQ/9UAUNtKJoT/Q06Mzi6ut93BHo2lGsPDYgYlUkHBl0S22tE/R0+ZISZEPR7qe+Ed/IZi4hcz+TI/+ZrzpF0fpK6GUSBtCVhpHpX0DFDv2887LU1XNdf1p8UlXl35KTc1b0xc+Y6XCt1DwjJkY4+TMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536640; c=relaxed/simple;
	bh=2BNuiEEYZAYKMxOPW5Czlvqb0Ows/NIzukJVzjuaim4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ri6l05Wryji1U9PIy7S7FmZv+amTmDbYrVEtOLgh4yTValUw1NjXBginwhPX03LKRVp/pcHCZuwangyLuBzG1TsZ66n/lOmOMB3eZMA5SFBMEJVQb0eEVQOYS32ObfalhIJXpx1iNm0uwlrLHXd58PKUUcZU60x0RneAo0zlCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxM3JIWa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f86568434so30830a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757536638; x=1758141438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzT78MV+zKBndimmlnrpRxYkl/EJq6HboGh6m7gKU/I=;
        b=cxM3JIWafFwumE8SGapoSTc3Sbky6pphFIqD/wj7HIGFBfQFAPRCTP2Wjl2ffdNwKb
         SZYkWjI7LDmwcP4pPDM6NLeIDy4noWUX3WToVYb+hcTCFPlmFu92dPMpdjgmLx5Krp+Z
         NrFpgQLCN6U74sNixc4Q0BbZJtBdTHnk6HtqtIBcPUA5r8Ui7Pwn+9KTCbSk+wU58wnW
         lY52qYlcFVhM+cFaJA8wtp+HxR5x6xRL1wm+QlnaXFINAaqxiZMnopfEZDyGLERQaZ2p
         0dnXANiyZjZXNULYgkUkZEBrZGbg6ODdP5c6i0Rs/XYhHXj3o5aO8r5vIM0CRDCGl32V
         z/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536638; x=1758141438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzT78MV+zKBndimmlnrpRxYkl/EJq6HboGh6m7gKU/I=;
        b=ZBBsVKgmjRcEK22P9toS93WOX1Pe48pE032LKuT7xWt9prXb+zJ9hsuH0S8A1SBXZU
         GY7UjoAJ7Z5A2emqP/YSwOOoqyteqM2/obikHfcKKaFfNIVL3CFAVGddKP+2KTNBvquw
         nnu8BUtIoPVia1sChHaTQaGeGHlFD3/BXes4Tv/xmBGUMyKEKgS44+W05ilCvG/kvT69
         Wy55MzT6O3RFuUN672e71xGmG4Xb8yeLUTBfGgceycwNfyrj7fl8zA/mz3U7IEde7Bzg
         s+8qMvRkoNHy1g+L2RhdbSDKP3s/JH1HPs8M3R5lJmMi9lk/nZ9P5CwX7RPjoZWuAwc0
         5SEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMQKDB+C9Z9tIImSpHMy9d/Q+WxjivOTKP59pS1tZwPNmkVR0JrPy4RKT9x3EL+jBQr/W3oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4EI8TxXZbcsPJGuUp3eIDwQfeaOgX1iil0vlMuI10+mCcWK9
	4or/r3i7D9he8p5+6mEHIFJRagTJSWi9y+ghB1eBHuJ8Jxyq4gzi4W5CjRJ3SoOIK2LnFuRw3m5
	tdeUrwJHHVQSoUQ==
X-Google-Smtp-Source: AGHT+IH8ebV8iH+3MOFITA7O3MGaCT9396cwf2zt0/OyqhqmGiOk1gqNp3i9qD1L7zZ2Vmza2fQRm4vp+6duEw==
X-Received: from pgbcu7.prod.google.com ([2002:a05:6a02:2187:b0:b4c:39d9:a0c3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:218d:b0:246:3a6:3e51 with SMTP id adf61e73a8af0-25346facb32mr24460194637.58.1757536637851;
 Wed, 10 Sep 2025 13:37:17 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:37:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910203716.1016546-1-skhawaja@google.com>
Subject: [PATCH net] net: Use NAPI_* in test_bit when stopping napi kthread
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: willemb@google.com, netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
before stopping the kthread. But it uses test_bit with the
NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
the flag is unset.

Use the NAPI_* variant of the NAPI state bits in test_bit instead.

Tested:
 ./tools/testing/selftests/net/nl_netdev.py
 TAP version 13
 1..7
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.dev_set_threaded
 ok 6 nl_netdev.napi_set_threaded
 ok 7 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

 ./tools/testing/selftests/drivers/net/napi_threaded.py
 TAP version 13
 1..2
 ok 1 napi_threaded.change_num_queues
 ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..8d49b2198d07 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6965,7 +6965,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	 * the kthread.
 	 */
 	while (true) {
-		if (!test_bit(NAPIF_STATE_SCHED_THREADED, &napi->state))
+		if (!test_bit(NAPI_STATE_SCHED_THREADED, &napi->state))
 			break;
 
 		msleep(20);
-- 
2.51.0.384.g4c02a37b29-goog


