Return-Path: <netdev+bounces-217984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E58B3AB2D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4179878D9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F112848AE;
	Thu, 28 Aug 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOLel3Hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4DB28751A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411128; cv=none; b=T9ZupxJSwhahjZh6eis3Sgl496F1JP3XuYqavHS+EWcIuoIpToX4F0pz34EYuFe857r2BiRuIChLlYctHQVVBuu8CYp/jwZH2DqqdJTNro6WasvkNZpxuXbkkp25dsEmdwWeFgxWCxd+PWEfe9r7BoQahgzrAkya8evR2FEs/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411128; c=relaxed/simple;
	bh=mWZkUI8Rhf8apzfpjtesbD1kebF8fE0HZhGiLCTeWXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unocEaMkeAl3jjqI+qNZNMdrEIEbOXWKAxXzGWO/XP/Mu62GMzvlkWVGfZFPbc3Ano9vi1c2BwItSWwaKYcOBqs6yxN3uwOk9UBVMqZv/Vu3K6gEUvmkSt2pfQq8e6+FVASErbVXp4jB9Us43JuqAvN0Z8twNFUCE7j+unITVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOLel3Hz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c229e2a42so1006820a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411126; x=1757015926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+k3UMGDkrkQ2OT6qCaqUHaE8YI/51xWsSFXyOAtaKg=;
        b=gOLel3HzkTDqovkJWq2p1jQmPFAOrsmXUddQCvSh2V7Szy7BGW5qCPPk7pL4vH/nNE
         LoP8xhzaJ8mi0JpHOAp//PdQ0hRHzp0AYxb5wan1FO2defDgsj9BXePyjNzy+HW+t0+/
         34HUVytOXNOR8EQ6dnQikq7NTeA7+GRyHtTgnQG+AybI46Eu847MmqypHEFlxaurwzEa
         7iLAjRJzXERCtDHhVxSL4ZWzysRHpD18irL19eEhRw3p0267AnR7JJ16vnEbp3DpWICN
         E/fkp2UyTFB0+Auw1+2sx22qeInJBGZfHENlFA5lRD/T35Tofwdqwv/Xro49j+6soCJr
         QFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411126; x=1757015926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+k3UMGDkrkQ2OT6qCaqUHaE8YI/51xWsSFXyOAtaKg=;
        b=nL0Wy9GMhcxqKzfNh/vaHYFqVLpWs3ZAYIr474IJAUoZSReDWoo9FmTB/l+ysMxtC2
         4YMdP2edkbY+qCPUuNe5s63MoAfujJyxlVoEwD6Fct0dlYP5PnA7OZzaAnNHQ3OoHRn2
         4LPQOXqijJdnEYj2JVm6ysh5EC2W+d2w6OubCqdb9tIFP0AP8rMqTqYxasXC9DAzpmIL
         Kn2fJ/11fTARe6drVaCB9vooDrbpxB1y99X1fusdOnGMJ/arijftcgnA2F0I5lqlm+2N
         4cN4n6KrScIazp1cYjzfTKxs/1NlnW2ecKoewJGOooYoHfIGA5R+3PtntV+LeEfPqyMT
         t7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbYbP59RHajPGHmC/N2GbTgaJXoXOtL9G+yu4mUm/4D802e1k59xH+h+o0c4vw3zwnhsm4BFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/TNI4PqvVYnwQ3IJDYkCbvWc4LHb4j52unuiC9NCSeBQmESyA
	v9ny78oJ2r2sPkmY4W9lcyffCbU1lCoQlewDTBmyRMBrYk7THU5qNe+eqSNOYVxnR2ky/JxvySb
	1Hbo1ere1hdEjlw==
X-Google-Smtp-Source: AGHT+IGEQC02Bp0TzFaYrNlAKiL0W1T6nUcMmBBLjZ8d62f5otLrXgomnaJRlnCaU8m4A1YG0IGVUMMaG7LiTQ==
X-Received: from pfhx20.prod.google.com ([2002:a05:6a00:1894:b0:771:efac:345b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1491:b0:243:7743:f92b with SMTP id adf61e73a8af0-2437743fbd0mr17504150637.27.1756411126376;
 Thu, 28 Aug 2025 12:58:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:22 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use RCU to avoid a pair of atomic operations and a potential
UAF on dst_dev()->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_fastopen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index f1884f0c9e523d50b2d120175cc94bc40b489dfb..7d945a527daf093f87882c7949e21058ed6df1cc 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -576,11 +576,12 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 		}
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
-		dst = sk_dst_get(sk);
-		dev = dst ? dst_dev(dst) : NULL;
+		rcu_read_lock();
+		dst = __sk_dst_get(sk);
+		dev = dst ? dst_dev_rcu(dst) : NULL;
 		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
-		dst_release(dst);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.51.0.318.gd7df087d1a-goog


