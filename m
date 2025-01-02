Return-Path: <netdev+bounces-154781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B19FFCA4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7611883054
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E381547F5;
	Thu,  2 Jan 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrDt6lxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94CAD51
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838095; cv=none; b=MnSXbdrtwuk78EZ8H1j0uoqaa3E7Hl0kdJHvP3HMNosH5aEiiwcfYOmh5qHHeAZkevB3tv+i9F1HKJrVl+XqCTO6wOE74EcQUmy7ZhtxIqYCvkXWqK494tdVc+6Ry5I3SWXWywkDr9K3Y89AlqG2CUm44SBEAkpjpPyo/tK0O6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838095; c=relaxed/simple;
	bh=3wt8rTub4DrjhkpmMneXSs8bFpkhCS42QjNDK3jreF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrNuFEHUQWDlXDwZeOK3YnOFAjsoHVowrG9DBUBD3kecwTvkDaSIP9oGsRSFqWiXiNuNlJ/O+qoE53XIIkMb2CblcGJ4NY5pp7oHneW2EUrL8zXOWqNNJENWasrDnZy+DAjl7AWNSyNcG95Vkc2dVZ9k5ko27KGDQmeeckb2D3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrDt6lxJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21636268e43so70873405ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735838093; x=1736442893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmGENbGEhUENix6WOnM+hXQNfCbEieJCtFAsChFPcl8=;
        b=OrDt6lxJ2XOIdCyp2hNxX6YiJRjkM7fTXfWWs9oOG7ubK8VMMuz+rDLBtxidioP/gV
         0MIxI+4q2kz8PwP8P3+lZGHbnlKOmLa2K6E6RHX7lgTz0VEakL7V/nQKgCGH1Fn1EKWn
         cFydufNT1p1h45y9WVOyTw3yV/ZHh44SJlRhe/FQDgFgBlFpXkH0ZR1Ia8mvAKLQH9JF
         bXqCmAjL6hVIr5rDTY3rv98C9KIvYxcc4SjJ40Jrq4UxvTMDXk+vjgb4EUjkj4GBCuPQ
         7KI13BC8NT4db9GQvjUriIjflhKgsoeBZda+p2cKfHda7gTNTwR5+YMs3n6Bf1iKxbNg
         +D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735838093; x=1736442893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmGENbGEhUENix6WOnM+hXQNfCbEieJCtFAsChFPcl8=;
        b=Hku4hOAFid8O0ai6UHXyGVDMSlkEnelF+YSMi57zz1GPg6+SooSZmB6xlrgbkRpszT
         gNsfCm75Nro4qJe+5tgjupMxD5zVpaPAkrlU6pcx+LXypD0XP24+hNOQF1scZ/9VxA8T
         rScJhWFR7L6yFk8iIisdoPxoJvD99E77hirmMQP+RCXei/iLsOZUrsDspnwT/DmAMQ1U
         U8ZMr+cRqil/B+7gbP0nEASJjlty9CpHSd60EWeANbMjXs+1HxCzJNa1GVonP+fdpR68
         4sFmWJ1Yb9WQbgXpqR1NM2S1xj0vrBVwPbWannNXT887Qw492/N+mSb2qL0A2YpVWP6d
         JA/Q==
X-Gm-Message-State: AOJu0Yx1iwFOWxPncZk8PMHeaMa4az7B9/qaI8wuApvmefgktzlb4gYn
	r/1qgStE8PRrxILvubplyyd/TotkG8phfCtcZAL8JAxSkwAP5q6vYl89XldZ7Vg=
X-Gm-Gg: ASbGnctsAQn3jtPSzh1JMcXlb371nVC68Vdxo8CHZyNcZsawYG+A0FU5aqPS4LqA/Wf
	UbsCWAiuq6jFpvLL3S35irMq+05mfy6Lpj/TW8Mzf2gvyvYj0yMny2U0x4ndjV+dY5OXwPf9fA1
	xBDxoxZbYrbzY8/mIA0igpDG+6JpTi1YZaCFUy3tEzfz43WTnhl9o9ooQXTAYLW7KV15Q6rf1Zn
	o6CJwBi2QMr03oLHamX98L95zVuaWvMHKefSllqrmfjrPMxj9cSFU3WtbJUPZQbtw==
X-Google-Smtp-Source: AGHT+IGHET9XxT5dassWzk0fJCgs/UQtRz2rnmvPSFNv8BmVQ7DVUc5WgI2iZ2nd5NPj86bmoIP5og==
X-Received: by 2002:a17:903:944:b0:215:6e01:ad19 with SMTP id d9443c01a7336-219e6ebc9f5mr750499575ad.29.1735838092654;
        Thu, 02 Jan 2025 09:14:52 -0800 (PST)
Received: from localhost.localdomain ([220.181.41.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdddcsm229550295ad.158.2025.01.02.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 09:14:52 -0800 (PST)
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com
Subject: [PATCH] tcp/dccp: allow a connection when sk_max_ack_backlog is zero
Date: Thu,  2 Jan 2025 17:14:26 +0000
Message-Id: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the backlog of listen() is set to zero, sk_acceptq_is_full() allows
one connection to be made, but inet_csk_reqsk_queue_is_full() does not.
When the net.ipv4.tcp_syncookies is zero, inet_csk_reqsk_queue_is_full()
will cause an immediate drop before the sk_acceptq_is_full() check in
tcp_conn_request(), resulting in no connection can be made.

This patch tries to keep consistent with 64a146513f8f ("[NET]: Revert
incorrect accept queue backlog changes.").

Link: https://lore.kernel.org/netdev/20250102080258.53858-1-kuniyu@amazon.com/
Fixes: ef547f2ac16b ("tcp: remove max_qlen_log")
Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
---
 include/net/inet_connection_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 3c82fad904d4..c7f42844c79a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -282,7 +282,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
+	return inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
-- 
2.34.1


