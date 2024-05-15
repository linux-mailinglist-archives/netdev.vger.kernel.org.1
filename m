Return-Path: <netdev+bounces-96613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E498C6AAC
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036711C20978
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341FDDC7;
	Wed, 15 May 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7i8F6xU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BFC8FB
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790842; cv=none; b=jFcHafVTE5DVjx/4Cubi0VL9PwVAYYxUl+KJf1CibB8nzMuXQBbbxQjGB60f+9kC6qZxGy2oIS+zZEp+bfC/KwiR/QxWHQjThP6Yzh212mfYJgr98KaMTwYjCBi66lT6sk20iVEiItUuBcOtYONbUn66i3951oDMWrRjCYxX8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790842; c=relaxed/simple;
	bh=mRu/pSLbwCJ5LmXs7DG8OFhL5lFg6FC8t/oq/DH2WYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m9wXoe7T8TdpwZju0HzEen0+tAeIkQcfSRxyvUe7NApfUDS8oYMen4qWKpfGT2cwrmakOBgPyfNKFwWFJVkqK7xNBJ4KqErLtgOiAs/EVeWix6HSPVQRSIIwK5I+Gm+VDOFvbjUytbm3nLx3DzQubb7ZlqGBAjaY4Zw+s1A8XM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7i8F6xU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so124694507b3.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715790840; x=1716395640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftFF8d1FxfucMcvo7KcmkhroFKYJjqjufaU1dLr0oLQ=;
        b=S7i8F6xUkqdUA0RxneWXio+ZOBufOD2UjQRGD1OMS/xndYzDhVTF+4VjO+vN3jJY8J
         LNQ4ik7yvcj3tjC/EsZDAo8Ufju2D+MWW+SqPg0c85FbZvVotO9cbZpdk9TVY1HhnKDf
         6MNrmrpOMNkxjrL6IdH7fGWZDV5IspQgw3YQEUOpoQpOHuphLL/PYHMRTMWff1gehxcI
         pXxufvrtZuEgbWKIhFZCJcDo/YGR9nCgC6p4AD4LTzASa9/CCjFswgT6dqRCUnUsmu3w
         Lstgpjh1evjxsWjKYWpY9yiXFsyJ8HfIPnEU2AYRTGGiYofFGVCqzNmnzfRD8IRV9M/P
         Mm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715790840; x=1716395640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftFF8d1FxfucMcvo7KcmkhroFKYJjqjufaU1dLr0oLQ=;
        b=g0p1s/X1M2UBnQWXcTqBd/Xnf/FRpvx8TKuG9WofMOWRpo8m/RFZBri46NroWVfbpE
         QjS38L/wJSDs/x8S80KMmlsEBJ5ATiNmwIclEKc4fegXVOyJ2TlnoOIdCZYLorp677Bv
         h6kgd5SR5yMV3A9Ww2Y7jGIa/GL6Rq6shknWE906AeZEfOW0aJJMt9PQ4/Ziq0ZQgr/n
         sXJJ7I0KadN7FARGX88cgx15k2co2zuPIsMOPuJ8aW/Kp55xYkCbK+vhuzt4hGRvw7/0
         W5CVp+FqoZFiCA3v3mcAW5SCE1TPHT690lwRo6ZCmBqIzm7wu7VHZOF3NXZd7nsCMh7o
         dJDw==
X-Gm-Message-State: AOJu0YzhaVe2Q1RZQRhxEIk+SZSr8vBmgRrtJHnqdovPtJbbff8usQig
	yNEPtjQ0WdivlMMP9X28vZrIctexPEH+X90dM0FA8aAl2hajryEPJOFXaQv9K+EQmvMUub2c3sL
	1ssF1UP9CyQ==
X-Google-Smtp-Source: AGHT+IHT3N40tu4/+givLCEh2IR2wPLN04WaZVIGm2ZZ8ajUkjswgoQAKYy1MpmW9vnOgjy72d/l37C1BmTaVQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1546:b0:df2:eaac:d811 with SMTP
 id 3f1490d57ef6-df2eaacdf8fmr74949276.10.1715790839797; Wed, 15 May 2024
 09:33:59 -0700 (PDT)
Date: Wed, 15 May 2024 16:33:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515163358.4105915-1-edumazet@google.com>
Subject: [PATCH net] af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Neil Horman <nhorman@tuxdriver.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

trafgen performance considerably sank on hosts with many cores
after the blamed commit.

packet_read_pending() is very expensive, and calling it
in af_packet fast path defeats Daniel intent in commit
b013840810c2 ("packet: use percpu mmap tx frame pending refcount")

tpacket_destruct_skb() makes room for one packet, we can immediately
wakeup a producer, no need to completely drain the tx ring.

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/packet/af_packet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8c6d3fbb4ed87f17c2e365810106a05fe9b8ff0c..ea3ebc160e25cc661901717a755f47db927c304d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2522,8 +2522,7 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
-		if (!packet_read_pending(&po->tx_ring))
-			complete(&po->skb_completion);
+		complete(&po->skb_completion);
 	}
 
 	sock_wfree(skb);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


