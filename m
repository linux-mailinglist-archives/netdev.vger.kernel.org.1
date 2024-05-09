Return-Path: <netdev+bounces-94785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B98C0A88
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E848282F30
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9E148858;
	Thu,  9 May 2024 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiLoH4iD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CE10E5;
	Thu,  9 May 2024 04:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229813; cv=none; b=NQhCgSAWxjrPoQ1kckrfusIB5llQWjDDsQ+6AdyqHLmBypiwwZlhjT7pkO17w9WIdMuZukuOAJt5Nefj8lm6M8nkEwI4do9JhXE6tDsJwJoGNcbqdUcix4SADLmhi3o9nYEDzXsPHSixjjvs6Of7Fg2rzpS4ZHnz/9XcYJ8MZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229813; c=relaxed/simple;
	bh=0APn/GyB9C3LGDrLfnj/FpbTqKbd0+K519YfKo41k2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1CpODbr2bzgCi+ZB4Lght4Av8BijBRXO/UCWgaZDqrC0rJW+Ii4EwzGlDvNQ0NNnlbqqyhbGPHitmNrD7mfpA35mUaWwKxxL1LMqL8lYXMP3Ro0GKhArEYm2QUz3iFY2iXMV+aAo+uLIitr/tGlSc+yss3sigsxHQNYjJA5ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiLoH4iD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed96772f92so3633815ad.0;
        Wed, 08 May 2024 21:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715229810; x=1715834610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVSe9gUHjI1t4fahoHDRMA+6pIokvYwYsfwP/32CnUk=;
        b=kiLoH4iDV7Pga/RjT/ze4teJiXf5gIpPqa2RJBqqf5mdJRDoQFp91kyojmOa/7ByY7
         iLF1yI8MC8zKiMCbn8hH8agtBuO8QggRL1i1gA79dEuI2zDMfXw2jgal7CchUqXnh8N6
         tWM1FIX0I+yV6bX3Yhvuw945dGVx4THCNgvJziGGaEr9Ve+AkmX5yUenwxfgAmLqmiBc
         i6UUcgSBy3sRluuQjAzEm2muamXPErQHdGFC1A+xYgbXUK/sY47Es41tEONkHU3hp2z8
         BcC9LKOdK1X7Vs9CqL3n17esdUOZRJ9miL8P6j/xl/5vStDa3Y64H9B052TWmtNLafEo
         DOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715229810; x=1715834610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVSe9gUHjI1t4fahoHDRMA+6pIokvYwYsfwP/32CnUk=;
        b=XOZmBOdZW4/TlKXYJBbjirh89iTkjiGjgtJmh16NQkXRy8m21GIShW5nVOt9/ID/U+
         vPSuQS/tqJLJCRGLzmcRU0F81FIndAC5vqIlK9+zuf5TBXh+cRCUadsxJpivTGrXKPpu
         AtTegTMlDLc2F5bCRu37r3k9qFuJITjTr3jUa3N2W9a5JoTYtpCOn3gLsrbF3ge2/75Z
         HokabYsEph/nnDzVkawLMN9fRtgtURrkm+m5CwV42lVdFjZTxk8uDUjWKuCjAyUB7iYN
         Vfu0Kf0AXs4cf8B3Tli2E/xuSdLA559bewFZOvnvHirITLg/aGAnPWZzdaSv5fyUzmxz
         Ij0w==
X-Forwarded-Encrypted: i=1; AJvYcCWMoFCrOn5vYA5zJhaYDNhHfHVpWYN1ETrKUl/ERXgoQYn3Jy+Ry+07RlDrBc3nRATQZ42kxwgtlpZox2jNKKwRs/EKXyJ/E/NNRheP209P7v3gb3Qe3YZnuWClnswZCDkPmQZh
X-Gm-Message-State: AOJu0YwJpRxeAeq8UyYp37nDoHGWdn4Qcp3x9G2bfI7yYRvlmkyggU/a
	jpVUj8MxUAIu1345RQC04Q/TGLJui97LMol2aYa7f24yXheNdVUxqOwSSfs+C2Y=
X-Google-Smtp-Source: AGHT+IHNdDrS9k9IuPXnckeeqensFTS1LNXyuNEjN/yggcXbLkUhtE/ySxtJjrqcoC9bCQ/OSUPquw==
X-Received: by 2002:a17:902:f64d:b0:1e2:a162:6f7a with SMTP id d9443c01a7336-1eeb05a17acmr54663635ad.43.1715229810355;
        Wed, 08 May 2024 21:43:30 -0700 (PDT)
Received: from localhost ([117.32.216.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4613sm4264665ad.44.2024.05.08.21.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:43:30 -0700 (PDT)
From: Yuan Fang <yf768672249@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Fang <yf768672249@gmail.com>
Subject: [PATCH 1/2] tcp: fix get_tcp4_sock() output error info
Date: Thu,  9 May 2024 12:43:22 +0800
Message-ID: <20240509044323.247606-1-yf768672249@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When in the TCP_LISTEN state, using netstat,the Send-Q is always 0.
Modify tx_queue to the value of sk->sk_max_ack_backlog.

Signed-off-by: Yuan Fang <yf768672249@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee5838751..70416ba902b9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2867,7 +2867,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	__be32 src = inet->inet_rcv_saddr;
 	__u16 destp = ntohs(inet->inet_dport);
 	__u16 srcp = ntohs(inet->inet_sport);
-	int rx_queue;
+	int rx_queue, tx_queue;
 	int state;
 
 	if (icsk->icsk_pending == ICSK_TIME_RETRANS ||
@@ -2887,19 +2887,22 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	}
 
 	state = inet_sk_state_load(sk);
-	if (state == TCP_LISTEN)
+	if (state == TCP_LISTEN) {
 		rx_queue = READ_ONCE(sk->sk_ack_backlog);
-	else
+		tx_queue = READ_ONCE(sk->sk_max_ack_backlog);
+	} else {
 		/* Because we don't lock the socket,
 		 * we might find a transient negative value.
 		 */
 		rx_queue = max_t(int, READ_ONCE(tp->rcv_nxt) -
 				      READ_ONCE(tp->copied_seq), 0);
+		tx_queue = READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
 			"%08X %5u %8d %lu %d %pK %lu %lu %u %u %d",
 		i, src, srcp, dest, destp, state,
-		READ_ONCE(tp->write_seq) - tp->snd_una,
+		tx_queue,
 		rx_queue,
 		timer_active,
 		jiffies_delta_to_clock_t(timer_expires - jiffies),
-- 
2.45.0


