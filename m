Return-Path: <netdev+bounces-145880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591279D13A8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EEE1F236B5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44C1A9B34;
	Mon, 18 Nov 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM3SIzis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99A1A3A8A
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941553; cv=none; b=GvcCreFDJFZZ2lvWOQ0wEOvCsxxuFQiAOY558bu8/HcdQMP3HI+Fb8mJCAmz8HJlqwGVp9C59OnpvheMuL8TTWG/g5GSRCbg3sUkJRJKYcEckKfRiEDbYHXDDaiGY7sn2lAdscX0cgOKA2KwkDuHS/bW7Ugb9hUYz5A8LWextLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941553; c=relaxed/simple;
	bh=QPh03QEa0M8YEQs8GzmP3qJH+OhK905FKbbXXrN+B+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrOV2Qu8/S4sAM/u8IIHYxJnoTc8pVui4xtcJrOKCXdXhJkmBf7ZNkOTmFic8Y6nXxBi9GP//Pjh763p585jr4YuvN24YmC2qMwnFxUL8Jyt7HTz4SXxHSbISdFrPFG8SzIEMyV9VMG5/Pr+1aQ1xKy+NH6BQC8CVezZSk+eG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM3SIzis; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso4566466e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941550; x=1732546350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=VM3SIzisjJmnHnHLvor1WIPSlAJyk4KUQi5hYPu0MJ+6ipUPpJIo7KN8QA9igKrfB/
         P9IjYuhMxbYMVPZ80E/47UqtVOfqr8rOoSyAHjF6fO2nkA8Pcn3pQrJF8b4ozJEfAYpp
         NZ4v7dxT0p1TJVNjB6M/9Bh28yYQgslDeEDOI5iyuPgwpZZdYlWFXuQDBcq+GLWhWYKw
         //scrZMI9tBLJa0T0TNWPKVhKV9dlrMXf1hh7dhTwZknY2td2XqRwK8YZqy/cG1PfTP0
         IdUkHwqz66i95hZXHHNf6Xo/FaHgcDUW4+A2rLfJbyB5IvD69tDIWieo2PdCZWiWxvwN
         kOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941550; x=1732546350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=jBJQ/q+9smqi3NLGBuIdKBjM2kW9dFIedxscL1iLHeSFgNpEE0pplaqyq4vLKQ9fos
         BmU1UA+KXQR5W2jPOyXgUPytqZPQcQD1pOeMMyw0J/f/DbisTCkitbF9cPRrD+uTdBOS
         PI5NgdUtp/zlKC0T9Gj0Vy+2DDrQJyQqtyD9i2Ngrhdx/zJt8pgbXFGkEZysQqzg/gJ4
         YZOckvuP7lNc/XBokpzX2RM2BBNJ4Mv14SDREq6leUZTyfX+DUO/rFg9pVVRJ8kQ7bTf
         XK8nvC6NbkxUhPYRb0Vnxz9yzn++O6BSoiuRhJnfSL/yHz3ETYXgJNRR2phyVvwDo7Xy
         6J1A==
X-Gm-Message-State: AOJu0YyRuSNcwif9kkyfR+bmuHDGpL1ez2rfxnngxLOzraZbNpAFdxDQ
	B+C01jrLTAZDYQMaGH0imoa5h6IuA9izMK3Wn0TTM6fCCT4n7aCWzHcibnME2PA=
X-Google-Smtp-Source: AGHT+IHq0137p6ePJRsPXONHfsqeWNPPQPlzOmcS7VUqaeWp+U6MPAaLQ70Dsdb5IbbYcagE2JlX3g==
X-Received: by 2002:a05:6512:23a4:b0:539:fcb7:8d53 with SMTP id 2adb3069b0e04-53dab3b0758mr5321216e87.46.1731941549380;
        Mon, 18 Nov 2024 06:52:29 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E82D600957C45913C6586B5.dsl.pool.telekom.hu. [2001:4c4e:1e82:d600:957c:4591:3c65:86b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fbd2sm162639285e9.19.2024.11.18.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:52:29 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org
Subject: [PATCH net-next v4 1/3] sock: Introduce sk_set_prio_allowed helper function
Date: Mon, 18 Nov 2024 15:51:45 +0100
Message-ID: <20241118145147.56236-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118145147.56236-1-annaemesenyiri@gmail.com>
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify priority setting permissions with the 'sk_set_prio_allowed'
function, centralizing the validation logic. This change is made in
anticipation of a second caller in a following patch.
No functional changes.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 net/core/sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..9016f984d44e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -454,6 +454,13 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
+static bool sk_set_prio_allowed(const struct sock *sk, int val)
+{
+	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
+}
+
 static bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
@@ -1193,9 +1200,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	/* handle options which do not require locking the socket. */
 	switch (optname) {
 	case SO_PRIORITY:
-		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (sk_set_prio_allowed(sk, val)) {
 			sock_set_priority(sk, val);
 			return 0;
 		}
-- 
2.43.0


