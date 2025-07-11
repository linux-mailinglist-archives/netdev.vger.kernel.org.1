Return-Path: <netdev+bounces-206128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F2B01ADE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB91976510D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB42C3273;
	Fri, 11 Jul 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5H96pja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CF2DCF58
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234021; cv=none; b=ZaOcV/DE37Ci5UdxsKkik9TL53nzivQBqIzl/i1i6fUr4J4Ehwr5xL2mYIwTG1blAPtDM+MVi6x20ymqqvBuIyyPyIeWBI7AE0xaWAva8XJdysSFNUjQ8sje/StiDupPIy9tPVkdA3gkd+KLFK6qVvjt3Q3N58YCL2yjAmFL73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234021; c=relaxed/simple;
	bh=11veCuVfCwlerfP7WzrV6vOqN9EuqGYXUyf0jxReflk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DokMQdASesTNfj13aig94kLaPefBHLSKKeuajwAGLQCXQZz+6+5zPcV/1LsUZpuxg0tmh6z91m3+itl9dvoXI+2yo1BaNU/hQDB+9atZQkMMHSgQSf28NAxTB372E+9G6D31Ip1SgfpjOJSSyUGQPC13XdhpXmoGK1eavMYDKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5H96pja; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-478f78ff9beso55582751cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234015; x=1752838815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoY4cSvNqKq2rzCmD29r2ZE0mj2EsT23qIvSlxkuOvM=;
        b=r5H96pjafOIx/GSgjnmevvTAFVUyZj2NOmLwgdxtfpPuiZK5L2H+YOpGnFfE7MLrME
         oOpThR4Pa6ENYDqXYwE/owjqOiCp7l1wroG7QRkeAZ3G8NUMy4GVY6p9BPdshwBxKeKk
         Iy0dXdZFbH63SfIklinUd2SEkSjmuDu0KnggQVIebWI/7rE4qgOgK50pRehIXVoY+pLg
         ynN4dDm7hE/v5T7iGNbUbdMQ5ICz9OLzcgipOW2hds7MW2So+nJwoCWqnRnOELZVEH+1
         tqR84xnQOALJh8FwrlFXN5pyBBD7Uf3KNi82kNV6MAjj3oCfewydHso4qToKzaYeNquI
         aorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234015; x=1752838815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoY4cSvNqKq2rzCmD29r2ZE0mj2EsT23qIvSlxkuOvM=;
        b=fkcFMHvoAaTS80iR/OlZS16QgpiCbqB6xx30Y27uu7aMEBYo2z9FtIcstv5rDxZmbJ
         dDi/LbA9t2ovNgMR22dKM/TvU2EseRNaBkUCW9t0vD0MPnVFGewQr+cRH3cT5HpBm7LL
         q7Zuoexcx96dvOXIwnjAhEXudoMqo8yQh53e9as4apqcHthZwOxp5j0WoXpRn5Bf66/I
         MWF58R7KH+O2Frw9eONZ6196O18juCYOLr7/AnjTr+JJipid6B//wNmfTFu+Zmk/LfF9
         uFAVtipz6ap8B2HS8r4L4XwIb/7OKglIv2COKtjsVVgMAzQUm5vXpC95oEX7B6TY9vCH
         QBjw==
X-Forwarded-Encrypted: i=1; AJvYcCV8nz5Qjt2baH6gg5RgOPbRTj/I0+SUZrnqe2DgCdWh9QkygJIzoA3eiK2aw4R1zS/bZa4Amj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+On47HBg2RpXoDtaRa/Jh/rRxyc/0Ps9lfYBC6uHzBngwrqk
	JEe966dC1vv5G3oD9eHMKZJ+R45nqRXSoBI+HW7Vykh2MGk4ZXwHAu8GuDZ6J8S7RaHvG04Eorq
	RlUPunZ/HI+A9og==
X-Google-Smtp-Source: AGHT+IHSloZeyvX7DyLvGuM3o7vK9+zP//SmGBUBz/5krjVKWz+f9O8FGzZWGUM2d0uVlfKCWBsqtH9UNMdWOw==
X-Received: from qtbjb5.prod.google.com ([2002:a05:622a:7105:b0:480:3049:24e2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a74b:b0:4aa:ea4a:edd7 with SMTP id d75a77b69052e-4aaea4afeffmr13819981cf.0.1752234015186;
 Fri, 11 Jul 2025 04:40:15 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:02 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] tcp: call tcp_measure_rcv_mss() for ooo packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_measure_rcv_mss() is used to update icsk->icsk_ack.rcv_mss
(tcpi_rcv_mss in tcp_info) and tp->scaling_ratio.

Calling it from tcp_data_queue_ofo() makes sure these
fields are updated, and permits a better tuning
of sk->sk_rcvbuf, in the case a new flow receives many ooo
packets.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5e2d82c273e2fc914706651a660464db4aba8504..78da05933078b5b665113b57a0edc03b29820496 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4923,6 +4923,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
+	tcp_measure_rcv_mss(sk, skb);
 	/* Disable header prediction. */
 	tp->pred_flags = 0;
 	inet_csk_schedule_ack(sk);
-- 
2.50.0.727.gbf7dc18ff4-goog


