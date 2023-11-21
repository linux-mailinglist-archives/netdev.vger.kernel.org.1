Return-Path: <netdev+bounces-49503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B988A7F2377
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7456028233E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F850CA51;
	Tue, 21 Nov 2023 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TYkx5l5H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F19ED
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-332c82400a5so1018926f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532087; x=1701136887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb/w+BKw85BILJP8CTg75niZjZVcbAJYfunsL97APOE=;
        b=TYkx5l5HsPBsUxmethudoPU7KItkL6Z9NbWPNmRDNR2pNDYb6J60Tkwn6HqGhmaC7z
         xP+PYJ8qvTY3R78qTa7IkP5NvASc7cQTwFW+b2Dw1MikmusEOyg/KsD4FJToWSxgnbJ3
         tcBUPfJWPe3uSECiyqljJIRoYa+lGZ0cNIsSp/00GqTTiENcXvfXo7i9tcCr96DqLbuW
         VoZ5NLlbeXNIQgW7A16Yua+K/BwfsKwzEaqp8eJcZ1USLEQKAIQZrj4rymtnRJ0WHnXo
         Kbw1ABYzEkL/GbqW65tKGak+HgORJaqx63J1Y7C9n8X2vHclhflswHuQfGus2etuDWja
         CUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532087; x=1701136887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb/w+BKw85BILJP8CTg75niZjZVcbAJYfunsL97APOE=;
        b=eG8brUbImZVSX674yUQW22cmcC3G3LuVeHoveRqblagszPVXKStUVA/pkLZwRFwRd8
         RjnvwKDkH7F+o7Pu/+CuvC3CqpweDe76tLQDBoxQF6Hjbb3kh4vav/11XnXO0Q7+59mQ
         tEFz7aUp4S8XOLZVtsxE49X7K8kRp2lxI7TYX8RjCDUdXL+4WoNgQQwQQVjq7DfuQfFJ
         7Ylo3FTRyDhslEYMVHAQYZBAMFXe7LNt6tBBj09jqnCxUADycwxauPvsTs8UBXeHe71a
         z1RyUOm+BhA3c9UuGHBVBcuIvZSVB7XfePKOilVlTnx8drxy1QCLwmCLSD1lkW4WzF82
         baVw==
X-Gm-Message-State: AOJu0YzXDaE27g29mq989jxNtm+aJBPCdzwCIsOOo4PknCVGvw0Oe5XI
	xFw2DX64EfFNBUNpKkfnZmbWUg==
X-Google-Smtp-Source: AGHT+IEVaDa9ATxoPYSGDjhsp5Kzj85OQPWhli+6R2u4dfdYhQZgJKQrddrShkTsXOzgbH54ov/2qw==
X-Received: by 2002:adf:f0d1:0:b0:317:4ef8:1659 with SMTP id x17-20020adff0d1000000b003174ef81659mr5885838wro.28.1700532087011;
        Mon, 20 Nov 2023 18:01:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:26 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 6/7] net/tcp: ACCESS_ONCE() on snd/rcv SNEs
Date: Tue, 21 Nov 2023 02:01:10 +0000
Message-ID: <20231121020111.1143180-7-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SNEs need READ_ONCE()/WRITE_ONCE() for access as they can be written and
read at the same time.

This is actually a shame: I planned to send it in TCP-AO patches, but
it seems I've chosen a wrong commit to git-commit-fixup some time ago.
It ended up in a commit that adds a selftest. Human factor.

Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c    | 4 ++--
 net/ipv4/tcp_input.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 122ff58168ee..9b7f1970c2e9 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -956,8 +956,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
-					 ntohl(th->seq));
+		sne = tcp_ao_compute_sne(READ_ONCE(info->rcv_sne),
+					 tcp_sk(sk)->rcv_nxt, ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..78896c8be0d4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3583,7 +3583,7 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && ack < tp->snd_una)
-		ao->snd_sne++;
+		WRITE_ONCE(ao->snd_sne, ao->snd_sne + 1);
 #endif
 }
 
@@ -3609,7 +3609,7 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && seq < tp->rcv_nxt)
-		ao->rcv_sne++;
+		WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
 #endif
 }
 
-- 
2.42.0


