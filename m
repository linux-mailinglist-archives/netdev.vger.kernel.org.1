Return-Path: <netdev+bounces-183407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130EA90996
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC30C3AFCE4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C66215F7C;
	Wed, 16 Apr 2025 17:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF221517B;
	Wed, 16 Apr 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823183; cv=none; b=dswdJ0vePdQTMzp8aWSZ320/DHlz91pcI9yyxAI/WAvE35OwH8d/LxLOadYjQJTFaPL2EjmDZCMf34afoewxkSQkWx4l0XkpxOtmYv3mGXPgl87H42OciigPJmT1Pp0bzuaNVvGAyi/9IkcBwaP3T+UF5+otUF+x0P7DB44iyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823183; c=relaxed/simple;
	bh=d0f/eZxJsYBPNzP+ypgNu+3Y2vNYtC0mQ/V9+GgyiiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QPPmP+UM6kowS2FyGDxEN4NAb+F5b/12TV3fLjvF9UBt98zL4qPjJR0FJOWud2mx1TV4xgk83VbaT1LIB8u+CfQC4OstpYlFuZSSeSEj03XxFxbtN/uGl+hEH0a5ed/kxOJnTgaCeD+Ahpa7ucHnsxZTuFAXEwQC4+reA58chhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so10322956a12.2;
        Wed, 16 Apr 2025 10:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744823180; x=1745427980;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT7KrIUQ+zDqya9cxR8Wwm/RYrGSzwBKh8Xo9H7htOg=;
        b=nEPOWlShfqahKQtNBeY3rucDmD9pzvxpSNvyKIFv9TR+UG7zHFv/StIR0NSdutM9cC
         vkHWpe0a0wSBKCuUHSkxsuUp/Lzlv8AKSqFh9/XDCwuO8V1ROvU8wqeX+AqZqfYzWQlk
         QE+o+E90WiBL28oM4UQ2ei+ymzZnAaCUHMvSrUtcECkyITAypjvF1vqREa7PsRyIf0+C
         HtHk9Ndmx66xOWMCvpZ95rJpLEEf103CnWCz1Oeb0Ik8bTwtFzidSY8G//EgC/bpY7UW
         i8V/o8WBiV0bOYeqmWVLiUGoAK2XmEk00Jwbo7HOtbhyeGeC7xjOyIb65xvM/Teq5ee/
         BtSg==
X-Forwarded-Encrypted: i=1; AJvYcCXGdIGZqoMUxziQw22zgG3F9Y9glJem6nOslDIsJQlAuYc1nGiaaYesJToLsfLTan7JZ1tnkOecsCrMWDM=@vger.kernel.org, AJvYcCXsS0cMUdRVhPPEr4fzkrerorfWjvLCXREKJmfeYJS2AHU0pnwN2FmTZLuzV18oJAczaIZZnDN0xovpiaC3o01+zbRZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/wixi7METYFxBmEXVBqgSubK3VjIVM1jaovNtKMp9CxmrPFO
	B7j0MeMIq5Aqk5q/7fJUs1VoJrq+eONUQ7Mas0kYCBr6PCEZpEyc
X-Gm-Gg: ASbGnct93a0x+LGZUtB/pIrNHakIWHLVkkLeMeDbl0ErhzbFZGJwxG+ve7p44hLv5Vc
	zHDySZEYbFHu8tqgU+inbnJUSQ164SaiB1eI4ofn8eh13OAC9XZxjTZHmVnCZef8tAQNHLCpuLJ
	3OarIFiQ40Ct2O1wRWmBAPVE+pCHsJ7oXV7TDdrPIc+bHJkWvz1PWC9id8t1vt6/gHrSJ+w2LJ6
	8nW3I6nYsMI0iVX7VYnElnO0hCVmdjV3ILMOm3kTM2pBI4jqKbxti2J2nVVOtgjlUzGGsz3Gg3X
	Pk0+LaDprfdTmdAtx9CjXaj7cyMMRV4=
X-Google-Smtp-Source: AGHT+IE46/jYtgnagWUq61/qNPpt6WU70ixrUVCo1T58uk5wl7XVhFk+rPViX3UF3CcLvypIq25TSA==
X-Received: by 2002:a05:6402:3490:b0:5e5:bfab:51f with SMTP id 4fb4d7f45d1cf-5f4b6df5c7cmr2542173a12.0.1744823179647;
        Wed, 16 Apr 2025 10:06:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d8fsm8850935a12.12.2025.04.16.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:06:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Apr 2025 10:06:12 -0700
Subject: [PATCH net-next] trace: tcp: Add const qualifier to skb parameter
 in tcp_probe event
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-tcp_probe-v1-1-1edc3c5a1cb8@debian.org>
X-B4-Tracking: v=1; b=H4sIAIPj/2cC/x3MWwqAIBAF0K0M9zvB3uFWIqJsqvkxUYlA2nvQW
 cDJiByEIwxlBL4lyuVgqCwI9lzcwUo2GEKlq1Y3ZaeS9bMP18pK66au+832w9KiIPjAuzz/NcJ
 xUo6fhOl9P8T7gqRlAAAA
X-Change-ID: 20250416-tcp_probe-004337dc78a5
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, pabeni@redhat.com, 
 andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=leitao@debian.org;
 h=from:subject:message-id; bh=d0f/eZxJsYBPNzP+ypgNu+3Y2vNYtC0mQ/V9+GgyiiY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/+OKru1t39LuwcXgqrOsIm8r8vW5na2pFwQVt
 k2vZ4db8NqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ//jigAKCRA1o5Of/Hh3
 bZEHD/4tWh2Qvw/qIU8EA/nnuzjl3TEwife+HTbot1I8APw8xLC8ySLIbbulMMtgd6jTvsY4iUG
 GMtaSGj2B2u6+o05sLaKiYDEnYcZrD9LGs10/+CSr14VnBGDFU1IaiEyr4yH4iYzD/gVkFxnQCk
 0sSpxMHUCxbOnFs1H0Lybc3Um7iKiJazCCRGSjfzPrW0U2WE2YRYYeHYqPE8mFq4zYXkhD65pGH
 lAPf6z+5OoE2PB/2yKvVtv1tpBCnjMRDsNW+/jfHD4eBTpckk0CYPCPJneT5D33uMi19BHB/EcR
 0FClBeTMqT2ZHRcE1mvdrYdZN5BsmH0JwdByhkISjkWQYQop3xEcgy52FJOAQ8jxxSPYb39MJjF
 zeeMSOVW9jDV2oEXceB+MzGgMKYOp0CJeVK7RpDNub7acKbotYRek60RjN1qw2dBF038mTMrCoS
 t41Rpd7IRR5eJKkXySNt9GNvs2hZuI+2ImUwyJaLznStPKT4efHYtsDDBTGj8igDflF4Pa8jX1m
 6itgrh6m9a0IR/tUIVQdK/4lAk2ziOJFNAgOba09QX2xe0kO+oErG79ZLtzx+L6FfrojI0MxNFp
 IJX+dRgZ+I3h5IgOQZE9G6WXkHZcUK7TmmAKgLlCJZNz8MMJwiYmlZRyDZzma/OGih2TAGOx4cz
 5NmmU0NU1Nr7xiw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Change the tcp_probe tracepoint to accept a const struct sk_buff
parameter instead of a non-const one. This improves type safety and
better reflects that the skb is not modified within the tracepoint
implementation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Sending this for net-next to avoid bringing this to stable tree, which
would make backport harder for not a big benefit.
---
 include/trace/events/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 75d3d53a3832c..53e878fa14d14 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -293,7 +293,7 @@ DECLARE_TRACE(tcp_cwnd_reduction_tp,
 
 TRACE_EVENT(tcp_probe,
 
-	TP_PROTO(struct sock *sk, struct sk_buff *skb),
+	TP_PROTO(struct sock *sk, const struct sk_buff *skb),
 
 	TP_ARGS(sk, skb),
 

---
base-commit: 40ad72f88a65814ffeb1ab362074c6f8c4dc3f61
change-id: 20250416-tcp_probe-004337dc78a5

Best regards,
-- 
Breno Leitao <leitao@debian.org>


