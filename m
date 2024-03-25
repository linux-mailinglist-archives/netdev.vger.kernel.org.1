Return-Path: <netdev+bounces-81465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89441889F26
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C31C2CDD6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA715F3F4;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+kFxnev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B622317E2;
	Mon, 25 Mar 2024 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338252; cv=none; b=VL3Fv+eYR9RnOSlPmPr3lwmH2lbRvQUGD0E+ZEtUQ1IQ1vdkhfg2xyc6ytWoAPwCFk+CEpjW8Q/mVy7dUqoUgnKbcQmuxJIrJrvYn5scEZlbsJ2HhCNUg4Km778PvgeCa4Bi2/+8dgjv1CJfspAI44PKgQH2Kv6L+I2moae52Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338252; c=relaxed/simple;
	bh=HBFH2KOlP2HSSSU1VXasxhtjODXxUMZmoTi8xeyxyHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xz3XZKPmPAr8zPyEut+iMMeVyjqc3UudzBt5MXjPVBF5XDVBaxvJiIRT10BcCHrwrzpq0wrD9LEpHwKtI2/7GeiwWmIe+5g1eKNLgQarAvnWEvpde4j3VujtH3CzBDl7QJiarmsMis2abjhlTuNHIycHvBOGkfV1q/nS/Mj6M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+kFxnev; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3ceeb2d04so225731b6e.1;
        Sun, 24 Mar 2024 20:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711338249; x=1711943049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxa+WSij7JIs5xDL7CTBVLsNlWQfBNLOi+KNiX5iofA=;
        b=V+kFxnevAy+zjPsTNMoZ38haKZqkvrM+WhU7pFw+AVMoMUSYqS+RBAEFPcDZCeSuNQ
         U+rWDYNKN/ihr1C0vEtW+IZ5HGyJaUb0sJ57eMMh8v2UhCKunu36b4GSEDLnrTT2S0uB
         KCuI3fmqUGKuogz1sgs2d8WE87hipQR5oBEo2Bb5GhrldF0MMHQGSDzHdnQpJsOQxDdh
         9ZD6EbB8o0a/U33ArdnJMVg/LIXaDiLqT2zFYOA+cvBNeFTlk1l94WD2VfDjQA5j2YKG
         ijXW5ZA1yLbjxJj3tLccL8+7XrPPCFyj0KFgPV6ssux4vqZrTW9Sq5Ts5yaxOlLDRlDY
         YX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338249; x=1711943049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxa+WSij7JIs5xDL7CTBVLsNlWQfBNLOi+KNiX5iofA=;
        b=bMAaGu3P25+yn20SEOdPjB4sAiLhxuqcb/L4KaQkTRprlhebaIIJOw6T8AnN+6qnqh
         7twqe9tlziUHziDkFWFMgh4M7yqO2J9zhSsrh11LKoF7EMtzKE7LPcO8CpmcL6gXqnpW
         3/sVmcdsvuoAz/a9o+8wdTQs9/vx3jHzmGpyHPJbvW54ifnRQa5DsajETFDAFkcuguoW
         lrP7rqUszXqRpjkdHDx37yJj/jGIpWLqwDmuwxL8F/tuJ/325shqaMDYUln50jtzZhxd
         vK3aIzVla8WGwWZhBbQMMxKkQn2yilvEEGqdh5rlEWpqqg13klLBm94FIT53D3ksCmZw
         /s+A==
X-Forwarded-Encrypted: i=1; AJvYcCWR9qJr5/VWlFrpftX/3Kz8rB+okS6WTrlqPJZhdd6FWw/H6/CXyzoHeZTz7njqxdYAG+kEXMD9OdAIMMWzfWBkd5NB4DKUNUzljA8BAEEVjU9k
X-Gm-Message-State: AOJu0YzLmMpDN1ZyHAD6DhcMfbWwdBAgmP/A04jhbfnik/Eie0j7pKBu
	/nlHRrEmcMm4kGLA2bAEWDAK+1EPWhB0dYftpQOTBAyiId6Bh8ju
X-Google-Smtp-Source: AGHT+IHUyOOuhWoYDVL1CO50oMAW/4u/8jHC208YNu/haaOWLs1xLeksht3KRVWWw8j44CE9LgsgYQ==
X-Received: by 2002:a05:6808:640e:b0:3c3:c251:58ee with SMTP id fg14-20020a056808640e00b003c3c25158eemr7259805oib.4.1711338249456;
        Sun, 24 Mar 2024 20:44:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056a003a9a00b006e6bf17ba8asm3300045pfb.65.2024.03.24.20.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:44:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/3] trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
Date: Mon, 25 Mar 2024 11:43:47 +0800
Message-Id: <20240325034347.19522-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240325034347.19522-1-kerneljasonxing@gmail.com>
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As the title said, use the macro directly like the patch[1] did
to avoid those duplications. No functional change.

[1]
commit 6a6b0b9914e7 ("tcp: Avoid preprocessor directives in tracepoint macro args")

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/sock.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 4397f7bfa406..0d1c5ce4e6a6 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -160,7 +160,6 @@ TRACE_EVENT(inet_sock_set_state,
 
 	TP_fast_assign(
 		const struct inet_sock *inet = inet_sk(sk);
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->skaddr = sk;
@@ -178,20 +177,8 @@ TRACE_EVENT(inet_sock_set_state,
 		p32 = (__be32 *) __entry->daddr;
 		*p32 =  inet->inet_daddr;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			*pin6 = sk->sk_v6_rcv_saddr;
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			*pin6 = sk->sk_v6_daddr;
-		} else
-#endif
-		{
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_daddr, pin6);
-		}
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
 	TP_printk("family=%s protocol=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c oldstate=%s newstate=%s",
-- 
2.37.3


