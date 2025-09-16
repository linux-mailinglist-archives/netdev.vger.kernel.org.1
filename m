Return-Path: <netdev+bounces-223652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08550B59D14
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DBF7AA4F6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21B31FECC;
	Tue, 16 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVNfF0fN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF83164BC
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039008; cv=none; b=Z7NAEW8QRVjHjJnPQhZgxjL5k+MQ2BgKX2o2TQN5uobB55rHlzv3td19w4FgcIq/QCpHdKXQsf0oMWvFjDENfpk74dqjtfsBYzCf4EeFRf0CY5DkjAf4P8M79EeWs+YSTfEoM1OroZwCPLerbxK5tCtjhP5C+On3W/prRShfxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039008; c=relaxed/simple;
	bh=Uc52KwfgAfbYQw6pb7h3vmXS/dEFRCA+TplzhmhhceU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCK0iatDQdPapgBaCj0GjglZoA32hdgFf6LqaIfIWbrMq7Xit+Y/4Fh/WSUvYgU+AIc8fYjyYnAS36BkBAzg97wsuyjZKgn9ybCYLPfnlnEDKjTSxgOtFid6fxpU0VZnCySpVC0HJL4V7O+JBs2qSvw6t2Ypf7rnd9r1iOl8udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVNfF0fN; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-81b8e3e2a08so674016985a.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039005; x=1758643805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrEA1TxQ3ZM8Dg/izsbK6OheMe9FTNtliTqrTtg6qfs=;
        b=fVNfF0fNZPXzp4gWpeCsHkAOXdM06XidWHOZVNl7sRme+PaNo1YJlgXQbXewZbZWAL
         Svkyz5k/KFGb6MtLpaWGOB1mZYJu0nUmpnjNCFA2m/HKuY1zGFieVtE+NLJhv9hNHzhV
         52pqllbbGo0WfGgM+6CWqSXNr2HSqHSP6/a9cJqsXaA2zvVXyXSA1PdkWNya4FjvMyUv
         9uLei2Th4E3eRjfG5l4sFdzfLuZO0MgrjwRTMBTWymVqpFLw2EROSXs9A6EGEUCeECzA
         Js7H819MiYXLd4F/tcl7KFuotYYd8KwGMC9Eomkeb1MAvUJ+pUSykuXWJOylbdZulbC7
         c5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039005; x=1758643805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrEA1TxQ3ZM8Dg/izsbK6OheMe9FTNtliTqrTtg6qfs=;
        b=oEib+bvtSaosUXsz29/75Aaax9xUkagn8Uk5DYUH2FWK/xUr2TafPuts7skWvUlcdK
         gk+bHN5AKjPM4C2ODdG8QIvbQgJY6Nqw9Sm2nXaD8O8+XKGm2iJUlrioAT5iel7QwfUE
         BuWhKWrHrwpI2MA9hp6NC0Yzqf2M7JZvkVe3IKku2/3gzp9ZvqUmtg/ZjLZnvUWAwUfF
         CvKHovuNnuE87HcWHmx5gEzOG3u8K/RaL+h/eI76y/XlAqkoMtbFCXeTZ/q/Fkqpn7rO
         eYbCt9HJ5q7aEsN/tGTpZxgUbz5WuJJdHOLlodmpa1n/b3A45YqX5bJQfESgm5uSOPOX
         5RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vFWCLoKAAUI4iPzLiQ+AFHTZQfQTkez+mshI4YJt9a3IVO1Aew4vSa1wqafgB3IujFH1MoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2aCehPDItMF/4swj0q7RYyxnPnVmhhQwQUw11Xa1TBRzThax
	iUlAsOgvU9MhrtyzKubIP1PPZRfRxFmXp1IDcffzbbS+n/Z5cUi6smzxY+OcDyLeh7gAx19FoRI
	isumcSvWJiOIJBg==
X-Google-Smtp-Source: AGHT+IG+Yw66zoYl62bDE/6Yf5UJ4dPlbeoBCLZOJcdPd2BdURx3CuFQ+yqNIRy5h/auLixZooN4gjDXCEYunA==
X-Received: from qkpf16.prod.google.com ([2002:a05:620a:2810:b0:82e:fed3:e3c2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:319a:b0:800:a501:a352 with SMTP id af79cd13be357-823fcb71f3dmr2227734685a.22.1758039005436;
 Tue, 16 Sep 2025 09:10:05 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:47 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-7-edumazet@google.com>
Subject: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock acquisition
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid piling too many producers on the busylock
by updating sk_rmem_alloc before busylock acquisition.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index edd846fee90ff7850356a5cb3400ce96856e5429..658ae87827991a78c25c2172d52e772c94ea217f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1753,13 +1753,16 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	if (rmem > (rcvbuf >> 1)) {
 		skb_condense(skb);
 		size = skb->truesize;
+		rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
+		if (rmem > rcvbuf)
+			goto uncharge_drop;
 		busy = busylock_acquire(sk);
+	} else {
+		atomic_add(size, &sk->sk_rmem_alloc);
 	}
 
 	udp_set_dev_scratch(skb);
 
-	atomic_add(size, &sk->sk_rmem_alloc);
-
 	spin_lock(&list->lock);
 	err = udp_rmem_schedule(sk, size);
 	if (err) {
-- 
2.51.0.384.g4c02a37b29-goog


