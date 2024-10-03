Return-Path: <netdev+bounces-131833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1898FAF6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C031C20D07
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297D1D017C;
	Thu,  3 Oct 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gby81PAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC31CC159
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999101; cv=none; b=YXT+NlkgXIbJ3oipKw6q8BzgWNSobkBQs0oKq/SwU6ww2M9t1i94slOZZtjrTrc/JccuOMza4+lPUQS816M2sjnK+UM9dWpCRNPyQnrPBSddJQwAfEl+NGVZ/lWYSVRJPFSFhxUstvBDzR+ODEerB2Hk+EgXaFen0uSMVnUfXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999101; c=relaxed/simple;
	bh=OZNx40HLrR5zXoybB7cBJ81wvCWz6Tk1cz7SojdfExo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XmUbXbyqeoc8l6bdmNNTAXoTAk4q5kPZhT4Yyp1JE4F18nx+AHZ+8YyIF88HznD3bNlwkzsYYWBJ/O0HluqHj4Bv8V2+A/BF2s7KjcjGrn+ue4kmnUPZGRKDgYxsJShD/Om/YK7IrCoIO7f1I9k2oRWqiD0k4n2yLts2+pdd374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gby81PAG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so200582a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727999100; x=1728603900; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jUfBdEY9mKQklvNAwHSTq9TqhGgu5WeiRM1PBeKfyw=;
        b=gby81PAGil32e49jL9GxQNr8Kk3iUE0hDwJLadkOKYszXJNGhiGQUNZ/+Z/CDoUW//
         vbChEyiADeb1UZapdmd5X0hMZuRAchx8nGuHb+Jg4+Z7Iodcr5LyVzlVvLMFzH94Dmpl
         53z0zG7redMoiPrZ/a9zUtmMY0xmgEjWo3xc+tWTyjefughOrXoVqOoovRdQ+0yOgcQ9
         gHHDeKXFv0h3LxAFCjcPZ7vkNJEZd6bSGdwGOgfLJsG+kc9SrMUx88ntOtYw7GXxQhpt
         87wnU44x3tgyCtUXW6rAfYjqWojO+Dtjv6/tYHm8LqmJiVxE9YrBM0iCzMaBH45t4P1R
         L9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999100; x=1728603900;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jUfBdEY9mKQklvNAwHSTq9TqhGgu5WeiRM1PBeKfyw=;
        b=P0g7GuwBAlEfpiyAmH0TaqvnYag6yJRKeW4DihP2xUFhCvfMw95RN09EmTzDbHQTvR
         LI6cnCgoYGHD4e2UvMomvFtGNkykCnyHSBlckuEGZwwrew8MIhER6au1KlLimygtahtX
         k5D7N6rL1KNohnrr7RvtLyNeqbkXm2MfMJHzLaBm5AIXp9i6BubqlEMjmJV+l0bJOTbW
         8wrv1QWksHSxVvn/aaNk5AdD7OIP4iEhUsoleGdDgQnHMtUHmzhqfRkVU5BCQJloMD5n
         ohVwgIx+9ukTkfwudGbmpi64i2b0Qw23N+QalEnPxwKLOtmFrMwoMLwks3Gcb5BeaAP9
         XL+w==
X-Gm-Message-State: AOJu0YwLNBq7V+MSPviw6cQtqgx5+9w87enX5UJhAI8QSu0eZ7i3r91r
	F9icLkTpxAH7vaPm0FBuXK55s65qgJonPgJH61bW4oyCsENxvio=
X-Google-Smtp-Source: AGHT+IE0/9mCAhiJ3opmnZh8gzp3VkyjfIRsei9Y3abavU8jc2T9PP0Udgvgf7aMZVqRymY4iynCxg==
X-Received: by 2002:a05:6a20:914f:b0:1cf:2be2:668b with SMTP id adf61e73a8af0-1d6dfaeecd3mr630859637.11.1727999099834;
        Thu, 03 Oct 2024 16:44:59 -0700 (PDT)
Received: from VM-4-3-centos.localdomain ([43.128.101.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d6e7e6sm1963835b3a.37.2024.10.03.16.44.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 16:44:59 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next v2] tcp: remove unnecessary update for tp->write_seq in tcp_connect() Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data") introduces tcp_connect_queue_skb() and it would overwrite tcp->write_seq, so it is no need to update tp->write_seq before invoking tcp_connect_queue_skb()
Date: Fri,  4 Oct 2024 07:44:50 +0800
Message-Id: <1727999090-19845-1-git-send-email-guoxin0309@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "xin.guo" <guoxin0309@gmail.com>

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746b..3265f34 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4133,8 +4133,11 @@ int tcp_connect(struct sock *sk)
 	buff = tcp_stream_alloc_skb(sk, sk->sk_allocation, true);
 	if (unlikely(!buff))
 		return -ENOBUFS;
-
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+        
+        /*SYN eats a sequence byte, write_seq updated by
+         *tcp_connect_queue_skb()
+         */
+	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
-- 
1.8.3.1


