Return-Path: <netdev+bounces-77023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A124186FDC1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62130281085
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9A225CF;
	Mon,  4 Mar 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alv/HyKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EC224E4;
	Mon,  4 Mar 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544585; cv=none; b=K2zBDUlGu2qnLdk34L6xwcoUY9eWDzKOoVWjwXWB9NqAGqcifmwaeA6K6os+mAhI8irP4+dZ1PN04XocafPBfBB2LFbgYpI0G6WArjHO5up0izVCiOUdfsQvgkoSqeSFFr2vC+dbKu/dVfqsyEzbmoN5ysFIXQmFgx+qGawL/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544585; c=relaxed/simple;
	bh=bRPzl5gdqsMYtpl/Nv3NDgIjvIzqDCbhGO4jph4MUgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cksqlu1AVQNpV9uR6QxNcb4WCFnH3s0QDHbuuWkkkC4FNQzANkKfChUsoYNT/VeUGmfU28FXRQQQf29baCYSIm7zGz4tsUTpuD7P5N5/5m5fsugfZJXUtDomL/B+3BlWmU9u3GWXg1yVroIwvc9CZMYLfnASoCJoDUR1CudcIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alv/HyKf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so15826115ad.3;
        Mon, 04 Mar 2024 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544583; x=1710149383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++FXFSu1f/+B3iYlKE0bIFGGdjIJfIYzo2uncjPj9lU=;
        b=Alv/HyKfCx/NXL7muMGchOgTaQvS7n14SBSmG3+9PkT/sSkrju1+Osm0SE/3Ok+qDl
         iSettFHFxsqRLC122pJNPlLyTPT2l9V87hSSYcbsQarJTW1cjxQjVUO9oD6NkM5iHQVy
         ABvwhUx4OVxFzxFU4GvHxvOdqDztglro/pnqfR14CKActu06wR1AZHHUUQTxEDjMHFQK
         UKJpoK5uu5lq7j7c6upB+SRuSl6qtVW8a6xlcuPrBNv1uwCmWSfajKkCrIHw32Mc0VEi
         SYQHcre5pQKAxs0HJGLvHDFNKzfABg7O1Hh8wpJNQ2OTE9EK9mebOAACBfZwzPZZapdT
         nlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544583; x=1710149383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++FXFSu1f/+B3iYlKE0bIFGGdjIJfIYzo2uncjPj9lU=;
        b=BjCtoo/BVKbrVy13JuhQjoicZqOqIPACdWcjdr8/e20Y7O0OAEmvuTuseLodn6hUUy
         IPSTNHteuMnn7qskdGGrz0LThBhvB9gKqVKHE2aVTjdH3J1hlwpygHSKQKi69kJlt9Fb
         LlbV9SBoiiJyEcL2mHrfyLlnXSpnA49s+3uSifSbV2ILQ563UdHgCP5ZYBZG+2/7zyg9
         DCsnWnJKGp7V5PmKBAKuG6leM16lYg/Y/s7VIhXxgJN+th39evWw4iyloNIYFr7EnOCy
         7veNLO3Dx/3SfpS4N7BQR1s/rbnV+V+JSQv2bl4Ug9gA4EBSIgjKpONj5nu7B3US4DPH
         jXGA==
X-Forwarded-Encrypted: i=1; AJvYcCV0kVAx/Eqp8hRbbVgWdIt8aUL2v4vTcJOrl5WMwEwlMR8b/cQU7VnC6QoL5rUnuoocG7btpQV0Hd9tvTjmvxLsrN9n9hUDUfXeDhFWOKOKSjaP
X-Gm-Message-State: AOJu0Yz5o7xFxvBlC4wAk3JNWQSlfEuZmziyMpRmig9vsTXWQ9ZfN6aB
	beVut89eIB/waTBbqw+dGfAlf6igID1jPybhN06tqR3CYBYS4pQp
X-Google-Smtp-Source: AGHT+IG9b3Cb3AWLcCsHehdu6BNukbK24/sW7f5GXOBAGOX8BRQvzhcBxyYGg4qYMhFAEMORMK54Dw==
X-Received: by 2002:a17:902:6506:b0:1dc:696d:6bb0 with SMTP id b6-20020a170902650600b001dc696d6bb0mr7737386plk.6.1709544583214;
        Mon, 04 Mar 2024 01:29:43 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001dcfaab3457sm4095507plb.104.2024.03.04.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:29:42 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/2] tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
Date: Mon,  4 Mar 2024 17:29:33 +0800
Message-Id: <20240304092934.76698-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240304092934.76698-1-kerneljasonxing@gmail.com>
References: <20240304092934.76698-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Printing the addresses can help us identify the exact skb/sk
for those system in which it's not that easy to run BPF program.
As we can see, it already fetches those, then use it directly
and it will print like below:

...tcp_retransmit_skb: skbaddr=XXX skaddr=XXX family=AF_INET...

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v2
Link: https://lore.kernel.org/netdev/CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com/
1. correct the previous description
---
 include/trace/events/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..ac36067ae066 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -88,7 +88,8 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+		  __entry->skbaddr, __entry->skaddr,
 		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
 		  __entry->saddr_v6, __entry->daddr_v6,
-- 
2.37.3


