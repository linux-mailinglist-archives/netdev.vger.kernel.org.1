Return-Path: <netdev+bounces-78475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41687542F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3030B23158
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2A12FB3E;
	Thu,  7 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABJoJdEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E412FB26
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829028; cv=none; b=C5vJXmFhBhnAg95xFT8e5kmeuSYbcknXJoppkgpkqxEETqEfKaVSaEOYbyt8CtN6wioppVORC3x+TbLMk/5pt3uxL1sl4In7F7+JVyBDNS2JoRmDWswuWxORRTnhCtPFZiQUjXTcsopuSq7ZsCLqoFeYK5ptKVkPjmxNwincb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829028; c=relaxed/simple;
	bh=6uiPcjcY7k1wkVn9aK3azcdlMX5qVV2a9uarFGtTIdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VuJ8VLUHvy71JRTJz/imtSSwskT6nqZg+GYFxZwjKtBy1bOkSPitoYy6t6SBSYOR0TRlnA7x0i5kQ3IpuN3D7TfZJqjaEQF89SxI5CUMHG8njvY8oPtuloIyIABFbFuUmFwN7jJj/FO/M10sOrn5Y75stmqIAo9Qqo2/oIGorAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABJoJdEM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so1778294276.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709829026; x=1710433826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kChSkBU+Kb+oWtsOPLZZCKTPYxR26zsMSU8ZffAYZvQ=;
        b=ABJoJdEMF3YvXWELtkqnR3fU2rrqzJnz9C/nWK0tPl7vq/UFT19owxnbq2afJTzrqg
         bS2Ul4QT5cfrl50Y1EZ5NsGtq3waPkyzYC+QxjADmn76EHytq6OZStkqfU6ZOK3UbS6F
         1/5g0pRNfFJe6cKZff19bwLqcXdtmwQ+hBwC7H4uTJkK3NXpe9I2xhs2452zATrBNq13
         TzPoXi5XhE3PPgZQZEd6JX9wbZu2mALnESYI2kkO+B7EaCh7KkQNjLiTkV9dFr/RCRqQ
         uVYkRWDAkT6wbj7BOwzsCh6pnxdWZewkCb0+VWIDwZ6R/Yui+yMGZRLxnTUrf4cUIqef
         qjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829026; x=1710433826;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kChSkBU+Kb+oWtsOPLZZCKTPYxR26zsMSU8ZffAYZvQ=;
        b=L1I8MdPYJmT/qEkMaeXUit2y2/hEXsLF/DF48PUMqIeAy7xzplcmsjRSx4FmLVzaRX
         JLqnJIUXuKMZSEWrCxwGnKGUywfYdjb1LxX04XgvOsSUTYk9ZSejnQaS8WDOb6EdskoO
         gW6pP+dBk2Jou+/CwLcidxmoMmgLQTZ4ddncLR3WMJ/7GhuAibR8vIHtkt+/cPbBjI6R
         twYQ3XEFfUko2DnrYaQNDtFJ3tGHYQi8mfsCYQ99/kFHQDcgPwljqRgSa9EI8L6IS/Zz
         vBy7aGg+J9Cchjo6VWRQc7zam9NncqowIDGBnHNmzUCpBZELpujCwOFpD060H93T3EQB
         Matw==
X-Forwarded-Encrypted: i=1; AJvYcCXhTICbQcVapy+35yc2Mbq6wOCdPb8FCmqJHA6+ufxx3rRTwM4sJUcD2lef5aTPcatWQwBaQwrsVqp5Dn52WvWMekcYVCht
X-Gm-Message-State: AOJu0YwiXJ4uF3A2eK+4Z6rgJzU19s+8p08NHpbyggzIaH+0TeufqG0p
	xnaTf/3cEwaUFZP/j09YBISWGYCh3wsRvmk8NSIqMTPQ9WTYeKi+ibT5JXKM3jw29K4U1rb55rr
	4GrtfWu0nGg==
X-Google-Smtp-Source: AGHT+IFb09uFcWqAnPS6lTXCsgB6au2i6BbCxgmYrB+HEURd0T5IwSvai4AsCWEt2YA6idCtSUDV3gvF5593EQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1741:b0:dc7:5c0d:f177 with SMTP
 id bz1-20020a056902174100b00dc75c0df177mr4651978ybb.6.1709829025841; Thu, 07
 Mar 2024 08:30:25 -0800 (PST)
Date: Thu,  7 Mar 2024 16:30:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307163020.2524409-1-edumazet@google.com>
Subject: [PATCH net-next] ipv4: raw: check sk->sk_rcvbuf earlier
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point cloning an skb and having to free the clone
if the receive queue of the raw socket is full.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/raw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 494a6284bd7ee346a4fca7a161477e6dc5ed5021..42ac434cfcfa677ee58408297f4d3ac05d98b546 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -175,6 +175,13 @@ static int raw_v4_input(struct net *net, struct sk_buff *skb,
 		if (!raw_v4_match(net, sk, iph->protocol,
 				  iph->saddr, iph->daddr, dif, sdif))
 			continue;
+
+		if (atomic_read(&sk->sk_rmem_alloc) >=
+		    READ_ONCE(sk->sk_rcvbuf)) {
+			atomic_inc(&sk->sk_drops);
+			continue;
+		}
+
 		delivered = 1;
 		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
 		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
-- 
2.44.0.278.ge034bb2e1d-goog


