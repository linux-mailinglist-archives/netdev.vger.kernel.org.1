Return-Path: <netdev+bounces-217709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F0B399DF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27DF560B65
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4930F52A;
	Thu, 28 Aug 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXAkhHSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827930EF98
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376864; cv=none; b=satdpivbLGscY6TmLn4nr8dnVUl7NEGgk56ngafSbPL++GDdPp2a/gHekSTcaJheizAPAFjG7f9N8hdI9eHJ4T5Bhp5wDfDryjo5dZ4/rXwNN60IwOejgX3cYQ7qMDMrS6ULX2fpYv1PDU0zgB8Ld5GpUXtUpX9nA2BUH6i0E9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376864; c=relaxed/simple;
	bh=XXDzRhCcB469/bmrS6m9YVW+QtTQCPoQWJ4ZSo6rHf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8oL7KDhjkcFiMklqqU3iyobYp9pW6vIZNXSaOjMzHQOkeUvx83bEwU2vWBlzlgAmozzz0C3hnq+PAYd9sPE6NKqVkVc+G7+dmE5eKcGWetEKZ8Nd/lBoTcuOPIvXma7FsAQ365OxnbzEC1v3tTBSYwPyCUih5h5Fmpu1mwNOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXAkhHSb; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e8702f4cf9so193412985a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376862; x=1756981662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7oQ609H6WISfr1/8Dl6GeQvVR3Hqdc6fgpvbzg/S7A=;
        b=OXAkhHSbrvdiVkctLm/Dsuy9B5x1bpmnCaCg4x1J/Y/5icHQLfWLKI5I//JB/2LoAa
         4O7HfkHgZvCIcIt32QJAR6k51LDDLKeX0Kv7KX6H60yYqFfl0aOQh2BmJKYN2oCC24X5
         oKAHl7enVIqU/W1UvHkyW+Q+PnoLO4vZzYeXhk/XaVKU5J+L2wiumn5J4njfsZWEHGMS
         cMh9glURnGkTcqOc+dIuDtUaZ/foG/0jcQvGUoXNi6WCiFc4LfS9B+beESam8m93llaq
         ykBth4iuI8QQPYv5AFZiB6bSRfazBpo4eId6WvehDefi2Y/l/x52olaN6mSnmAOXS28l
         8+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376862; x=1756981662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7oQ609H6WISfr1/8Dl6GeQvVR3Hqdc6fgpvbzg/S7A=;
        b=QMvoSP2MSvhywmNp/wk5xYS1Qcgkq6ffqF0m4O3PedP0OYYCeK3+Zdyhedbm8Oh5CS
         O9Az7ibOGVdf7znSJo8uQhO+MqjKEc9pxo3lJRTdNfDDPJv/E9fTeSg9GqnD8sBNYl9z
         ywULtvDRWX3p8q2Ysa+UvT8ru1hPXRKNHYZZxZGiv2kmm1FblLQ0rnRZJEVEx+aTCNPR
         ObBQL86+EuNEl2Xi2FkacDvnlG+x8X068pB8Hfw2/vyMniPU0oSIBxF+Dg/Qj0TretF/
         yNwYMb0J/y2yHWIrt/EkFBInEUkZWq+ffagn0msuwGceiiqO8D+DV050rhUCnpwgr97p
         sAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXejxgdy33LG7TAcJgLQX71eTyyXu6b2iP5MvWLE7qHW6zpnzKWuF0z7N+wW7gpv27y6udGAYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTTcITKXYHi3GuybhyuBfzJ78e+9202+YQzd/8cP6SietFgfA
	DiYaNqYXp9UYcMSLi1+7lI3W8i+R4GPnOj5gwwYR8QUll3ahoF99B104P41UVUDA86LFI19W8eC
	iTGHw5mVrZpPeKQ==
X-Google-Smtp-Source: AGHT+IG7VXd2l2s4D860f5FqrM7g21dDVSbru0CvjsAbGDK8Yu2BtTyc1Zhoyh3DpQqaQrblpHUz9vdtvwVhXQ==
X-Received: from qkpf15.prod.google.com ([2002:a05:620a:280f:b0:7e9:e68c:c30])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a80f:b0:7f6:b518:f131 with SMTP id af79cd13be357-7f6b518f34amr721033885a.5.1756376861573;
 Thu, 28 Aug 2025 03:27:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:34 +0000
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] inet_diag: annotate data-races in inet_diag_msg_common_fill()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_msg_common_fill() can run without socket lock.
Add READ_ONCE() or data_race() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9d4dcd17728cd17e693b59cee03f37b75f6c923a..7a9c347bc66fe35fa9771649db2f205af30e2a44 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -71,25 +71,25 @@ static void inet_diag_unlock_handler(const struct inet_diag_handler *handler)
 
 void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
 {
-	r->idiag_family = sk->sk_family;
+	r->idiag_family = READ_ONCE(sk->sk_family);
 
-	r->id.idiag_sport = htons(sk->sk_num);
-	r->id.idiag_dport = sk->sk_dport;
-	r->id.idiag_if = sk->sk_bound_dev_if;
+	r->id.idiag_sport = htons(READ_ONCE(sk->sk_num));
+	r->id.idiag_dport = READ_ONCE(sk->sk_dport);
+	r->id.idiag_if = READ_ONCE(sk->sk_bound_dev_if);
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6) {
-		*(struct in6_addr *)r->id.idiag_src = sk->sk_v6_rcv_saddr;
-		*(struct in6_addr *)r->id.idiag_dst = sk->sk_v6_daddr;
+	if (r->idiag_family == AF_INET6) {
+		data_race(*(struct in6_addr *)r->id.idiag_src = sk->sk_v6_rcv_saddr);
+		data_race(*(struct in6_addr *)r->id.idiag_dst = sk->sk_v6_daddr);
 	} else
 #endif
 	{
 	memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
 	memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
 
-	r->id.idiag_src[0] = sk->sk_rcv_saddr;
-	r->id.idiag_dst[0] = sk->sk_daddr;
+	r->id.idiag_src[0] = READ_ONCE(sk->sk_rcv_saddr);
+	r->id.idiag_dst[0] = READ_ONCE(sk->sk_daddr);
 	}
 }
 EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
-- 
2.51.0.268.g9569e192d0-goog


