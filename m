Return-Path: <netdev+bounces-111803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C382E932EE5
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2B2831DC
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308019F48C;
	Tue, 16 Jul 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnBiVlKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4719B3F6
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149849; cv=none; b=S4v9SJYiqbtkA3f6lJMGmxQh75+KcUrw5+Qi0BS/m7i+k3Eyv5AHRFqCSUiTxVgXeLQe36F41OVvOHiiH8/Wq6edM8nBcr9y+mQ0khOmcPBpiMym5RJwrsgP8V1rHEi3A9CX/RVFGFSMODcbUVJ7ASCU2iZH6oZNS+61nipoXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149849; c=relaxed/simple;
	bh=0xm2gEdjj6FYriaeZDg/fqdJCgZdy3KQ0QTBbxR20dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cpLXeSg9MX+bv7ck83CXp+uTrCdanzRtBeedimHJZhvriDiVzXaQ0azRTbI+ItwkT3fDz/gEOTVXQnTI77MZy+NzQnhOdM58hNut5Smgtvgln15A8KVgAEOzUIfpOmocMtzIOgP3C9INHPUFkoluBnAKa4MTrCPYBMeGssqF+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HnBiVlKI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a7949504so10367350276.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721149847; x=1721754647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KLMFIxoY/FsgaWVmeaUvjZCj9SGlbl3wDphg2IliNTM=;
        b=HnBiVlKI+1H+7ZsssB4dGjyh5S9o/7RXZ+HMyVOr9B8QgVlfEs7oSykmi9+anoiGjM
         GwMh0npxw89okPx1MqfAUHxkqjJHXWWTfNDhPfnkwYxq2qo6q80UoymQZLHQx9VHFEDB
         NxG+z++k1w5rU1oY7u6zQcLecCRkp5gxAVlmGCO+Jsrib5sjvIyJ8LLdGg3rwNk7ZaXw
         LHIy3cbab5kRv2D9S9+oXHUuPuZRYqDFKXSC3XM5LDXhN1Rv5ImgWHNlvKhAE9srD1tG
         ZzMixhexE5N1KmtTMiXPaNPdZoh12MH7s3GQHAZ8//sH+ynCrIYHb7tQ3g+c/dNZ6ODE
         DjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721149847; x=1721754647;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLMFIxoY/FsgaWVmeaUvjZCj9SGlbl3wDphg2IliNTM=;
        b=RSYWWnkDONtOOJHv3X8td7h3zUgoDABhkYgQJalufziGcOvaKL+o7JuiAedw7NmH9k
         LKSiSUw1u/UDx/jYIZm/W0+WJoBXb4bio5imlIXEc/PhO70yta6mNhMljbtjCCtK42OJ
         /LQsbQqCUXSh0h2JDlHyzq8OhFAoPs7Hi1L83JgeYZeP5UY0TsBOxuoUq8Fr4KWtuFIT
         lWly6LK9dxKpCFztIFknSUQPWD6mtg3jrkflZnMnsWdHTXatpAljEzO2rVBz8IPOCj+6
         sqjFqJMn6dVA2n9nlpPk7EWABwcF8PaE6N7Qd1SCcb0+c/+nTJqeUQLN8ehoNIsf0Xa+
         nxug==
X-Gm-Message-State: AOJu0Yyh/ZLdVSqrJSHSJXQ2Mk+OlJ4kvHUl8PVn776/Ms3PNg9uzbDA
	m4ibD8wO6xlVmHCqwMJeO7WT78yMOmmVJgpRTXaxI7+oqDayIW8ENnyk0152fsqv6YyTiyhNyHG
	s30FWvLWYof8WBrieP+KeKVqh7QOBgxUPhPyrfhvBf1xj91JysncbPTOMEbITjve6uit2foKJNj
	nzv19YLLIcqB8LlKAPnSeClET7GZkj6hGvPnpDzY7hnJutSAmkfcni/8zkQT8LNLxu
X-Google-Smtp-Source: AGHT+IFXGcw0P7tMil/1z6L0xE3OD/tIXGJLtMu5VfMuXIMosFgCj5Df8z+3n7F8JXGKjEICApyT0b2XDO86ibw56wQ=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:a1c9:f28f:8d0f:e734])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6902:1249:b0:e05:e4e8:7ec0 with
 SMTP id 3f1490d57ef6-e05e4e88be7mr1166276.13.1721149846300; Tue, 16 Jul 2024
 10:10:46 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:10:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716171041.1561142-1-pkaligineedi@google.com>
Subject: [PATCH net] gve: Fix XDP TX completion handling when counters overflow
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: stable@kernel.org, hramamurthy@google.com, jfraker@google.com, 
	jeroendb@google.com, shailend@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	ziweixiao@google.com, willemb@google.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

In gve_clean_xdp_done, the driver processes the TX completions based on
a 32-bit NIC counter and a 32-bit completion counter stored in the tx
queue.

Fix the for loop so that the counter wraparound is handled correctly.

Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format")
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 24a64ec1073e..e7fb7d6d283d 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -158,15 +158,16 @@ static int gve_clean_xdp_done(struct gve_priv *priv, struct gve_tx_ring *tx,
 			      u32 to_do)
 {
 	struct gve_tx_buffer_state *info;
-	u32 clean_end = tx->done + to_do;
 	u64 pkts = 0, bytes = 0;
 	size_t space_freed = 0;
 	u32 xsk_complete = 0;
 	u32 idx;
+	int i;
 
-	for (; tx->done < clean_end; tx->done++) {
+	for (i = 0; i < to_do; i++) {
 		idx = tx->done & tx->mask;
 		info = &tx->info[idx];
+		tx->done++;
 
 		if (unlikely(!info->xdp.size))
 			continue;
-- 
2.45.2.803.g4e1b14247a-goog


