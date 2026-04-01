Return-Path: <netdev+bounces-274045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LNpEV/3zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CC3378BBB
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 811E630BF50E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245723F7AB9;
	Wed,  1 Apr 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/AvW6An"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8C3F65F9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039898; cv=none; b=SD0Sl7YTg2FIkB2QzAg8Yh0tSFrz+Fe3wzSEUKEv8Z/h8OIJVuHUXpVvt1mUkIdAjTVqwd7/HpXX1y/GadCviCH0RKmY/SKS1K/A05ds6AcJcLtCCWZlg23tmKBrBT3CICh/fv3yya6IqdLjIp8rZMZSCIX+ShFneCE2fuyl3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039898; c=relaxed/simple;
	bh=aV0DO7/aj+PvXyCCf/SHTTSqZO+vWSkTg4XiLMLoM/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WR+91vauDEMs/HWuEgWGFkspDX6WTlwijTYXKAuh6CosxjMD04NWAKv10YdvoEt3OFY2m6astS8IYqiSCOyVhI0bAuS/0Bd1j0oxQHb1KPzk6l9W5iBpig/LO8ANX2L88oTZINY6MvLyDE/3CUsiFJuIcCCmSsKZOOawL1MFVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/AvW6An; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b2cbe7223so216128571cf.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775039896; x=1775644696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6iOuQs0wGhLig+e/sPZbM1Q/3iaLZbufaa9j1DsaBE=;
        b=u/AvW6Anfc7QG6hE41w7X6+kzOZ/aLjjRwcuojQKCkjWnQUHTm/OD4mOfYtnwRtcUy
         VL+cApga7WZCgzc7pRVvykbCydo/lEcTZ6HJKgaDlm+f9I/6jFvZmDEEGRK+QEDdYfa7
         cuCYlf6jh0Lrk+cfd6D3EIbUdHCWSQwOUL57xxY2lvXBKHBZgE6J9q0lF4CYh6Hx/qp6
         qrLnOS1KYmIWI/wOEPWaEjFx3EhbLvKlWtLhNqGxnQSQnvbF5pMXLxpa/rJbyI3UVcT/
         tRajBTon0p2gyMmElMGpU679zzB/C6uUZ6DcHpcAmt6DIFidTSjyM3chAFPXQ2S+bQnI
         Xn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039896; x=1775644696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6iOuQs0wGhLig+e/sPZbM1Q/3iaLZbufaa9j1DsaBE=;
        b=LdKwYdM4pYo3UOXvRwO3TJa7ShMBD/9SXKzHarWkLSVrif5x2Pd5aTUjq75Big+6ry
         GdzO8IjNsuaWvvrdb4ws05kr6Os589DaEQWIjqt3iCFJY8BfwjIf/YGtbArGgZ4P0UP+
         SkHK2zpWcmbJhMMR4SlotQRw5901ErshkewHacDJcdR6XjLuaNByng6S/Nf5UkCnrnqJ
         N7ZcB+sSH202O2DQUsBZMGOQ0yO4LWwgiuEAGBQPQz2AlWpB/aKJ4tV64xhua9ZxFpDJ
         1QyGuWZIwECsyNAbBjSlGUZbYFOo+wcpfcjIQck8saZHiQj/xkOpZUYfA3WKhZfSJfsL
         8z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXixQySoxPL/Tr9yTzvzsSNkvPNKAbMQgRmjS2OzIbR5IfaEJmDLw1+cQzQm7/njJp8wG6+ZAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva/dYxMMVRwslQBRS4KblApxbqIG9fXS300s9bz+zGZ5clT8+
	Loq4iMFVZss1P5VXvrHLfajVHtxk92mhyj+hzPPkQ85Iny07G9MMu3oci+l/dqwG6mL6N1SJBv/
	GFcoGgJ2ib4fgiQ==
X-Received: from qtqx26.prod.google.com ([2002:ac8:4a1a:0:b0:50b:457d:a8e4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:7c90:b0:50b:4d01:fafe with SMTP id d75a77b69052e-50d3bbbc8e6mr27175861cf.1.1775039894947;
 Wed, 01 Apr 2026 03:38:14 -0700 (PDT)
Date: Wed,  1 Apr 2026 10:38:09 +0000
In-Reply-To: <20260401103809.3038139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401103809.3038139-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401103809.3038139-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] macvlan: avoid spinlock contention in macvlan_broadcast_enqueue()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274045-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9CC3378BBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Under high stress, we spend a lot of time cloning skbs,
then acquiring a spinlock, then freeing the clone because
the queue is full.

Add a shortcut to avoid these costs under pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index bbb5c32541f996fdf97caa19d2c6d99e5c994a3d..54c514acacc5e24fcdb88904f41fd1d29b1e34d0 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -360,6 +360,9 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	struct sk_buff *nskb;
 	int err = -ENOMEM;
 
+	if (skb_queue_len_lockless(&port->bc_queue) >= bc_queue_len_used)
+		goto err;
+
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb)
 		goto err;
-- 
2.53.0.1118.gaef5881109-goog


