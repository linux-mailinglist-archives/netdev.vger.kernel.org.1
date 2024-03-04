Return-Path: <netdev+bounces-77024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BEB86FDC2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C41281058
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD622635;
	Mon,  4 Mar 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPuWT3+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7313225A9;
	Mon,  4 Mar 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544588; cv=none; b=bZJAeRnqWFLY1rP+AIBBOHNQDVDoyTSYqc7mOhClgmW7uLUOl+pEJmx73bDcPK0JiolPDEWqbSCcGIqyeOxhL3tkx/GfGC5G/suekuw4stUbAKIcd3SIkibTar704sOqbtyci2X/tUJu7JJVJ1Q+j+WNGwppOT0mXtYS2yIS+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544588; c=relaxed/simple;
	bh=iJTItG11gkiARdyy87rNAgw+ZiiGfYjsG4PzEBniTEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8EGKex5CGMFW5BA3OVI6a+sBX6qiBRVxfL6HqJf0/n+D3pDNEFPZIrNR1LDwnPgM6lQ+aowC9dfB8t4WmZen7tvLk2Rlb8pbRwOFqCbY9EOmIUHjh6ECfo2clBzK86Q6y2+H01P/I6o/Z25d0gKIwGwgcbljigMh1DvfrVkVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPuWT3+9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd1d9daf02so1834525ad.1;
        Mon, 04 Mar 2024 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544586; x=1710149386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl6o8UE3w82+M7lesEF7LGBh/FDfGMT+newu/A2hbmk=;
        b=aPuWT3+96/JSwXSqCgyxt9a5pdSmv5kI3uBmc/ZOh6HdTX5nK332maHwDKNVPyAn6/
         m4uDq5FelB8GGUG4YuTaJcOnRDkD8cAXlgievGix6neKh0RShof277EK/gYI8PW5HZKi
         9svuD6s11gSbUd6sROgBhuKQCvncjjMg40a4xddWsYiacA7npWhWNdVdgi2hIq8WIaBQ
         /QKUU76QejBD5EWgH88GTTSbiI3YfgcCWSIHuUAFP5JwDuw863GhJU3pURNO0sdU04Q8
         5USHjKivuKcOUShgdAm1zDPWRiRIj1qlzRESHjTRI+7OYgS6ecjtW1vNqHqWaX1f2LY+
         ZEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544586; x=1710149386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl6o8UE3w82+M7lesEF7LGBh/FDfGMT+newu/A2hbmk=;
        b=NY/QAqmXmPNCiRsVsceDzcWKIASfCtQPwgo4gehyRhWwUurfQhKtbD5hJo4TWtHMda
         ScMEXkigH8hRymbR8TDPrgSEcxFcOdF/bMOhWjsv9/Hi4TqBtzoZP/HOZqnuHIpPSK7e
         RybBNy1pDhFIIM9r74iH1kO2Ma4syyolzbVX4vICl1fAfHZHjbTU9BbW7EfbgPedBlQ2
         GcIQNIguLNnfq4ADuJobpKeSsSZ3oWK4DQVzXnvDfHLHKat6nMk6e4YCcXiuly2sbHbA
         7BEDpbErEFc8xa4GtpGX/c+3oACvVBz1sH/3Wdp7rW6ok1tixyMAwpDwzZB9JMWCEDxH
         cQTg==
X-Forwarded-Encrypted: i=1; AJvYcCVVPtj+iaVlwQdUoVnQ5pGKqpPeT4598pvIJPIj/SIwUQx2O87vllCRHasJNLcMDSrxGjOeVl2xdKzr5DUTTO5W7MeiaEZpzBwnbr6cxhaqednA
X-Gm-Message-State: AOJu0YxTrWJ2mR92l3XXW4CxY6FEyFgXHiKte4azDS1CgbxjTqma6oTi
	9XA3rSQt8BpByjJZh2y3m1G+0uvvaYjF8UZcoqZjxdMQ7gScC0LA
X-Google-Smtp-Source: AGHT+IEpaaABTEjnUrYb01kAX8wZsNQsIIL/qrFCJRXKOJidQzHlOwx2JR2CXoixIqCYTIJhw4ugVg==
X-Received: by 2002:a17:902:d491:b0:1d8:ab27:d76c with SMTP id c17-20020a170902d49100b001d8ab27d76cmr10220615plg.51.1709544586175;
        Mon, 04 Mar 2024 01:29:46 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001dcfaab3457sm4095507plb.104.2024.03.04.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:29:45 -0800 (PST)
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
Subject: [PATCH net-next v2 2/2] tcp: add tracing of skbaddr in tcp_event_skb class
Date: Mon,  4 Mar 2024 17:29:34 +0800
Message-Id: <20240304092934.76698-3-kerneljasonxing@gmail.com>
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

Use the existing parameter and print the address of skbaddr
as other trace functions do.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index ac36067ae066..6ca3e0343666 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -362,7 +362,8 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
 	),
 
-	TP_printk("src=%pISpc dest=%pISpc", __entry->saddr, __entry->daddr)
+	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
+		  __entry->skbaddr, __entry->saddr, __entry->daddr)
 );
 
 DEFINE_EVENT(tcp_event_skb, tcp_bad_csum,
-- 
2.37.3


