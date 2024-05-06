Return-Path: <netdev+bounces-93722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444428BCF82
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612981C228A5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F2811F7;
	Mon,  6 May 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XA0ICa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DC811E6
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003751; cv=none; b=E9EqKydY/7PswXOjn9D8kum94EEcCRs3L+YBPZW7XTq81nqmuvNRSnnFtoR0zOrl9I4TITuKou1se84+Rp0SkHQoUfdm+CyGycop3ojqLRSbh5lkoKcW9LWrB+1R/ZsQshc3vEhcuXeBZ1wfIdB2NjK9ZLnZvgeqPWD+mT+QTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003751; c=relaxed/simple;
	bh=1/+1gpC5SiUaqiBag3EG5uJaO0nuLI8By6Luh48RG2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZpD0aSsLZUZJIgfddaFm5ZLQ/FPmtMk1qaInjwmFZyIRJXfesfR7QP5OqpMqkDKOqoGHy3dtDuN6eXRtciPNhTa8OVrYy7FyOAVAnn6fge3yu2MhcnH0bc1vGs8yw/caql4Li2+5h+ojJpkNl84NsE46EWqM7l3AgFRz5ol1Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XA0ICa9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so3044932276.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715003749; x=1715608549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxcNP3ywioShrfPZ0tcZQrAjaXkGpEZX4O8+euhJTVg=;
        b=0XA0ICa9yfATLYsdFkqr1JQsyXz+cJRkTsuWo4vOLthWLTBe1i4UiEdPi0tPHVLvFc
         O8h/KZ5jMdhZDlQQ08N9gziZKBoDH9HGls+mSErI/30sjFqwvVYL2I/M0FSDPCZWjxhb
         mbP+LrA8UnVTqGs0muSb3vHq1msoImorUkzq0zxGDm3B6/j8N01HDRo/7O0Qe33cyHvH
         8IV1oIs+HzPc9ZOO19TPRWyF5+sWivJxdV68IyUDQlviUF4Mrmwgz2bVVz7BLqb1WaF+
         2Bh3MNCkvUGaIgJrNTRssNcFzDQwQnavO/k3slzNh2T+ieKJj/FTV93U+5U4mbRD/VsZ
         FBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715003749; x=1715608549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxcNP3ywioShrfPZ0tcZQrAjaXkGpEZX4O8+euhJTVg=;
        b=RVySY8F0PjriWGQXIUv57oA/07b5TRU5Q5CFx+8zNMxw3bQ51M8jQ2tNuwFVeMIWYC
         rVbYQxGRrTDOW+DgBzXMB8vmc+o4ZT3i9Cq6GzSLIJYRx7pm6iUgINB1YOXv/WAgBOiE
         VYdcl87yUNW4xXpywolQPEUI7WDNgCE5pCDpdPR1Qc4rcwU3WiRy24rJhoNzz4hZUmSb
         q1ujlnoKLfNxGhxQjE4QMBG020oRnjjOpRkEzzU2RqC9SZ+vleTStURUd4fnSM5NkcOE
         EH6rvGV7b4qOb5bqs/vUcotN+kXS2D+k8Osz+rrHTLS8YE9lsS8vD0Zd8q887xyADlYV
         sLng==
X-Gm-Message-State: AOJu0YyO1x/EN1cffN94uPU3O53ka5+3+prUhuOr/eLpr7mnxpqW+S95
	yJUHM7ln4FEZAGZVGY6aINWX8BQ6/dntsl1TZJwHsgAbS0imDByt6soWZf7wzgX+UW7G8dOwm7m
	i/GvkKpgHTg==
X-Google-Smtp-Source: AGHT+IGyiNP18OXGzKlmERTYoqwqtQhO1R8Yha1ihyxL9C3g6DhVsMHNELONfoYKBEIVHivVxgTwdGQ6NTHSww==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1242:b0:de6:1603:2dd5 with SMTP
 id t2-20020a056902124200b00de616032dd5mr1353321ybu.9.1715003748841; Mon, 06
 May 2024 06:55:48 -0700 (PDT)
Date: Mon,  6 May 2024 13:55:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506135546.3641185-1-edumazet@google.com>
Subject: [PATCH net-next] usb: aqc111: stop lying about skb->truesize
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some usb drivers try to set small skb->truesize and break
core networking stacks.

I replace one skb_clone() by an allocation of a fresh
and small skb, to get minimally sized skbs, like we did
in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
stop lying about skb->truesize")

Fixes: 361459cd9642 ("net: usb: aqc111: Implement RX data path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/usb/aqc111.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 7b8afa589a53c457ef07878f207ddbaafa668c54..284375f662f1e03b68f12752c76d6f1081a09d9a 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1141,17 +1141,15 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			continue;
 		}
 
-		/* Clone SKB */
-		new_skb = skb_clone(skb, GFP_ATOMIC);
+		new_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 
 		if (!new_skb)
 			goto err;
 
-		new_skb->len = pkt_len;
+		skb_put(new_skb, pkt_len);
+		memcpy(new_skb->data, skb->data, pkt_len);
 		skb_pull(new_skb, AQ_RX_HW_PAD);
-		skb_set_tail_pointer(new_skb, new_skb->len);
 
-		new_skb->truesize = SKB_TRUESIZE(new_skb->len);
 		if (aqc111_data->rx_checksum)
 			aqc111_rx_checksum(new_skb, pkt_desc);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


