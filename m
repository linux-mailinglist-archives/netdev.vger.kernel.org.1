Return-Path: <netdev+bounces-198938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6CADE659
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7826F3A4AA7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D127FD55;
	Wed, 18 Jun 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSX0dr/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135B27FB3C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237971; cv=none; b=ID0KW5MdwoNfmRE+HFS/D4gMASX/jTroBqIQ4Na4KWVFWpPTiMqvW7ueV+Skyr3XQgtHQCdvHwXowQD5GNUCGfxa1yBXuptqvh4bye6J2jJUXWRVZyigXEoQP6vD8549iRBD527zb4HmrPK0FS5pCpfUdUrIZ22YkjFBuiTgN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237971; c=relaxed/simple;
	bh=t2pxm20EYK1NEk7N8OBNO0lB8u3wCvWAGc5TfAuwAzA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sFnBRiKTxtI6rPpuzoxvQnKhduiKMnUwBTHMkeWBRkxAkDq9gXECQnKb4SPd94rFaZJt3IyzhHukZKFW5W+1+39KfaUJCeGkOd3v6JOHYidlI4SWUg7W2GZYk0san9vfkZS3aBpsuArLCpciGIJl7ehIh8Ejay/tLvcosCEL5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSX0dr/U; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4e8fe2529f5so554665137.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750237969; x=1750842769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CA8zH38USDmVdEW34eD/0nQwX97M0Frbjyk5UTzBNpc=;
        b=sSX0dr/Ui9pH0OCsAckeYzdd4H4T2p/ccFf5xK+vcU+vqFDhO7bNzNU4p2qHzTNHQQ
         sk4889KHLXnFLrwPFg+x5hQqbvFuCOWPZtOVYM7nbmBnkEjMgFhijEQulrAmqJ8VVVNv
         m9VWX0pCjg0wWuoi4+0ZnXgHof5jAmL6XZubliZWnVG/KGuuPYGKM3TAH1MSXqeiRf98
         vGUUsw3yF4IA7vS9GtWEIQXRjRDdlpWXpWdBKF+r1DPgWPPR1TCDQMMHQVEkB3O2CrU4
         QriHECcEMsKSRHsQYtevaABe82gZ9kMwAwhKKZVPJev1OIfWzptz+xX+677NRqrKsC+l
         f3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750237969; x=1750842769;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CA8zH38USDmVdEW34eD/0nQwX97M0Frbjyk5UTzBNpc=;
        b=Ce3vTnnxqZwac9dFFZlOj9l8xtXYB9BdS9cqJmmxz6aOFb/p4xochb2GdG2iXz/+Tj
         4SQqccMsM1IVqTfI5swKYKVIve7rDvzj42emPt2azvnfGXwPw+ltLqMVB8wA57fwKHZh
         THxXMv9XBOGh4hCXKQnvFB4sqb4PwQ5IuaoyKRpDtU933hJ0sBV63DvBveH+fKB1N2so
         YUHS94YtozIxjF1y4FJQWbQaG7AcyRgmp/2DfInys8AB9iEglh44Slx32KAZeWB3XymD
         LXTb4IT2v3HNNhIknJjq+JqQEvqNsRfLosE41ki/k1XKMlyQZ9ooN8NLySEyKfOO7/iK
         17rg==
X-Forwarded-Encrypted: i=1; AJvYcCVl6pjGqb1ba3edbJQZhLq0B/4meavwVCvAfDudo394TZ2tq5dw6aZEPwoH0KMtDTap6idm8zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHQCWUEAt915EblUqOBrOmpOxpI45VXYl733+e2CUcT2HYZ0r
	oYeywqoNBA7jJ03sF4sQaIsxUQv/7ZQ6AmOi8jGh5trO08xYcze32m2MxXDqOdS7vB8le8p9dSw
	kkCOqyYmWq09l7Q==
X-Google-Smtp-Source: AGHT+IGJLytDZk7JzkqbXxMhMHJbQ7LvbD744CtkCOSjXzwU2CV5jbW75dyd2eh66YHVQStSyAK/CUpYopDjAQ==
X-Received: from vsw3.prod.google.com ([2002:a67:f083:0:b0:4e7:e350:addb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4194:b0:4e5:8c2a:fbee with SMTP id ada2fe7eead31-4e7f643ae25mr11292470137.15.1750237969059;
 Wed, 18 Jun 2025 02:12:49 -0700 (PDT)
Date: Wed, 18 Jun 2025 09:12:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618091246.1260322-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: tcp_time_to_recover() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_time_to_recover() does not need the @flag argument.

Its first parameter can be marked const, and of tcp_sock type.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 05b9571c9c92599df800307afd9c655771425f1e..e5664e6131defc69f533860c480328d9ad433b37 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2336,10 +2336,8 @@ static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
  * Main question: may we further continue forward transmission
  * with the same cwnd?
  */
-static bool tcp_time_to_recover(struct sock *sk, int flag)
+static bool tcp_time_to_recover(const struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-
 	/* Has loss detection marked at least one packet lost? */
 	return tp->lost_out != 0;
 }
@@ -3000,7 +2998,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 
 		tcp_identify_packet_loss(sk, ack_flag);
 		if (icsk->icsk_ca_state != TCP_CA_Recovery) {
-			if (!tcp_time_to_recover(sk, flag))
+			if (!tcp_time_to_recover(tp))
 				return;
 			/* Undo reverts the recovery state. If loss is evident,
 			 * starts a new recovery (e.g. reordering then loss);
@@ -3029,7 +3027,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 			tcp_try_undo_dsack(sk);
 
 		tcp_identify_packet_loss(sk, ack_flag);
-		if (!tcp_time_to_recover(sk, flag)) {
+		if (!tcp_time_to_recover(tp)) {
 			tcp_try_to_open(sk, flag);
 			return;
 		}
-- 
2.50.0.rc2.696.g1fc2a0284f-goog


