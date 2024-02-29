Return-Path: <netdev+bounces-76254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87686D030
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5628C281814
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAA6CC1A;
	Thu, 29 Feb 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8QZZ/d4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE836CC13;
	Thu, 29 Feb 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226616; cv=none; b=aILAPFBRv3z0mj23vCtUbDEJWyhQIwGFzuxNrU3g2AsaOzG9OTSqrR4DunUSq8wf7U12CSp6CKg04xQGiLRtiX91vwX2N7M904rE4BAT1xtWm71tCkW/9dZrm9MgCX0WXTZIQ2qWvoF1MR801pv5sKSEljXgkMFp6zik22/g8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226616; c=relaxed/simple;
	bh=hh2xGrbZZ4Dk3F5N0fj8r6Bv+x/QSzRK/Itfc4IDUvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fziDJuGTBQttME6dZoImyRxf+tfyC8B8dW5HdUPFdBw7Rsb2KiR39z78eN6cUXDkvKYF1Am5gIN18tyv4/wiYRxczkuzX8MPWAl933FA6We03xRDvJkyYUtAIAXxHkC5B92oqHQSY2ami/GXaNz5xjHz1KwKok+iti54T83bYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8QZZ/d4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so52711b3a.1;
        Thu, 29 Feb 2024 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226614; x=1709831414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNBJblrs1R1EDZXccyoLwxbpBbuOba2tv93Wdjf21h4=;
        b=U8QZZ/d40PxcOye4v6sq+gWOqBwiCz4diGCTHBYTkgDvKKc8GFnjOyHvPUXbBWXI+C
         wUMG6NZXK8rpXs7w0Xvp8mgeEbBIEb24nczCgyvvrjFMLEmx200ZyR+K/u74A/0t5Rg9
         8neoctPRMU4k3TIEvgXwj4VpEmTu5DyQCE7QOnhJk9w39WRmU1v64AkwurwzDwSjWI8w
         x2ibfRyqZhp6JDzGIT4Bvir/Q8MDis291giooHgxcofOKfj313W7dnsqDK3h6bDI9Hcd
         JRACBERXcPcbjRTOqKuzY6SH2dXW+uLrknb5Mbopk4U+tiDTSf9M4nh9pGFaywzCT/pc
         tFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226614; x=1709831414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNBJblrs1R1EDZXccyoLwxbpBbuOba2tv93Wdjf21h4=;
        b=JEzKdPCXA4aylFeRYa8RUpTP8RxzrAah51b9t6q8ZBpbk1zWVooMVWdZxxh1q1l530
         D3CRP9dPz8x6wpqgoo+YCPU9akhm5NmEnWRyE6S/kCoiLIosyhrUR0bGF0erbyspE3SO
         8EOs3FNGqV0v5iiUi5SzDpz0M1mAy/uZZ7BpjGoAouyf5zbIYq8fiEX45vPxo4MDxDvI
         AYmppCc9IwsXfWaBbK72oXGXgs03W0/uLtIY7kd1X9hqasX2ahKfXyjdbwo34+bjdf3I
         YNyx+tEWikyrfeNDq34MoT7xyg01/WeCFrHeNi++FqxLn7Eb+/0chitG08SZerWv+9Xq
         GJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0WpuogCqHiLeW9R3yzwg1htTwTOE2tz0zcIiVHgS7igppp72VyiHltUMMQl7DCV898zo27NEOVL5d6h1oaft8pxKhz3Urjmrwbe3GgK4qAGP
X-Gm-Message-State: AOJu0YyJ4NetGeii1uRpcVDUGjnFnGjRj2V/UzJyw+5Of2nEGaSKsrjv
	xo9QhVexUn/adSk4vEAIUZpgWyGdoPa0IRLWIfeWmotrnaKOKbxM
X-Google-Smtp-Source: AGHT+IEgsMUGjZ/xDHERSGar2NO2cN8ScSIcCpDgA3qA26z2QJLBouefkVGzbmbpzX2WKH2DT67AbQ==
X-Received: by 2002:a05:6a20:4f0f:b0:1a0:c9a5:8258 with SMTP id gi15-20020a056a204f0f00b001a0c9a58258mr2603088pzb.20.1709226613931;
        Thu, 29 Feb 2024 09:10:13 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm1558808pga.85.2024.02.29.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:10:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] tcp: add tracing of skbaddr in tcp_event_skb class
Date: Fri,  1 Mar 2024 01:09:56 +0800
Message-Id: <20240229170956.87290-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240229170956.87290-1-kerneljasonxing@gmail.com>
References: <20240229170956.87290-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Use the existing parameter and print it then. It will display
the address of skbaddr.

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


