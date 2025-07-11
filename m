Return-Path: <netdev+bounces-206130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A19E9B01AD9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88ACF161599
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC662DE6FD;
	Fri, 11 Jul 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tB5TBH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA82951D4
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234022; cv=none; b=Bw/tck190TWR12Lzn8mf2UitkphM3CR2XyKGy/mtWR1ubP1Ed/M4x40N3yx2znuy667CrFkso53LiSH+72fOlMpe6DeNktVuktWdVXIxdH4D31rnPKBPgSVe0LyZ4O5KmNXBLc1EG1eFIfLbv5tKtG72iJiOPh5MYSXYLXlDHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234022; c=relaxed/simple;
	bh=G8rmjqBDBzKeqtTSs/qEUlXdHQ2n5Ih1MKgyF+ybnqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RgHgSUKMbRaKMTh5WO1yMnHaf+cUtZjZEiQ+8fh2OvAep6EBVuJovfHsN9QHrlGAuQM3vl/OuXLUSfrMw/UKD2tyRN555R9MWE9laZThoV69XzC1zpvNE9VZKCP3jOOL23arW43uDiCV5Y418inHIQtIUCIVtDkWSZ3hAnZKVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tB5TBH6; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fad29c1b72so28897596d6.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234018; x=1752838818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IycLlzcc4MgFlSuZ1ZaEmIedaHzTPqWoWqroxrMY27s=;
        b=1tB5TBH6+NHoKjSiMVx8PD0Q+7/ZZH3ZNpRP2t+QLIVfFJPuiXeGyraV30cJPwJaRw
         jyDwxedD1WdGh+IR/ZnGSwlHbVS6xjHSivQlkDTUjWo/xG4xQHmdm0hKfwkQg4lQtnb6
         wlteulGOj8M0o5SWfardo98mFnEXH86QPblI7QFHxe/ufTO7rh7TYJA6SoVldYxyviSu
         6M+zj7qPvQVZjyZ5x8NtnNMdV7zDZ9aG7rhbVM9esK9r11mdNIXuWsFX3lbO/mLkNZaD
         Pjn4JNSS5NsOAGoZC+ksXP00HDNquz9aQArIYAkfrMXhB3gtph2BhjeVasZ4kLuV8JBj
         hADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234018; x=1752838818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IycLlzcc4MgFlSuZ1ZaEmIedaHzTPqWoWqroxrMY27s=;
        b=wzqEbw8frD2Oad/nctOG5g3vxMa2ELZ7oqmo2SKfXfSrmwFnRm94GNJDpxegR2kvRm
         P9iHoOkBrzIve1OMJeXaD5QOWNmBRpWtROEsw9OsBP615T88lf2827SNjZARhZ1jpRgF
         mRdyRFfnvwewiq6pnLtjBSXKv4g9qBK2mue4usfQRWJBoeQucEEPRsN5igdie9izqO7U
         oeRgy4+AH14P4+Xx/ip7JvYoNlojbyUCwhcgV+6M1y7KfzbwY3G7JqzXzkbkoGWKBMx0
         K60vyZzKEnpAB1CiDf4AQq8TlXujrInhuQoyE2s4izEpGqdDwGY8NQ7+FeUa5a/mHrQk
         O7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHWbf2DV6xnx4LHSGHshW5fMjFa59pjv7jvj813lAxWgt8SoO28XtvZmH2rUacyyZ3tZbrh9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66PyQKGqvmgh/5yREXurJ6wHvQNGSel8auxIbyR2zvWB+qLBf
	kyDbbBRGQukyIYsFVz74FViRSmMec3CBlBskcvPGnMSWq1BLm/+ODx4KdeZ84hmNQbNugGB/gce
	I9aSXWdBkPWzZ5A==
X-Google-Smtp-Source: AGHT+IH4p568BgVM2BBbFmJXvsyuVOKIcrnnFyPnK2ZVRNkZH0NAV6a5x3ZKKywSjlmehNHbIWhevLSXwf/SdQ==
X-Received: from qvbob6.prod.google.com ([2002:a05:6214:2f86:b0:702:d3ad:7565])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5cc2:0:b0:704:7df9:ada9 with SMTP id 6a1803df08f44-704a38beb83mr55042976d6.28.1752234018377;
 Fri, 11 Jul 2025 04:40:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:04 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] tcp: add const to tcp_try_rmem_schedule() and
 sk_rmem_schedule() skb
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These functions to not modify the skb, add a const qualifier.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h   | 2 +-
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0f2443d4ec581639eb3bdc46cb9b2932123e9246..c8a4b283df6fc4b931270502ddbb5df7ae1e4aa2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1553,7 +1553,7 @@ __sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+sk_rmem_schedule(struct sock *sk, const struct sk_buff *skb, int size)
 {
 	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 78da05933078b5b665113b57a0edc03b29820496..39de55ff898e6ec9c6e5bc9dc7b80ec9d235ca44 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4888,7 +4888,7 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
-static int tcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
+static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
 				 unsigned int size)
 {
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-- 
2.50.0.727.gbf7dc18ff4-goog


