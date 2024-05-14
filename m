Return-Path: <netdev+bounces-96250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3148C4B95
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD0E286359
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904AF519;
	Tue, 14 May 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHpDKC9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E84AD24;
	Tue, 14 May 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715659857; cv=none; b=Sk5Pn3WlkWXgoOJul/HS+5DOh9giZDrriwS6AQiozQ8xy4KAapzUtFDc+FMBHRHn28R55g8o72mHm0yJ0DZNrQfYDLbPavcOE4txSHNvRZes7bgoM2AGhmEXkJhWibAYZUd5t7olDUb9/8e+t1ghgKN2xBIRkmlARahjVMZsls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715659857; c=relaxed/simple;
	bh=nYJVsMHjpPm6ySLWJRZtEodAtoJ8PsGWKFZlQoV7on8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAseSlEJmd2I1HyIynM6bo/c7C34tabnNUgYkxzlw4J2ANQeMxcjgKVWpqeUWbrlbX8TG1eLSHWKiCcR5cncLD7DN8xbHseOXZZ5mTDVmZccSPl/+VvYNu5hMp+97680dI+JiV7CTdaV5zQKzlWFQmd39FGJ24/LIiO9m/a030U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHpDKC9s; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so3324976a12.0;
        Mon, 13 May 2024 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715659855; x=1716264655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSfxmTXV8nxGh/b1Ev/VrDyL3v8i6n/5cPDbBilCR6g=;
        b=lHpDKC9s0lUpTE80xmdYKqy54Nm4TusS+jAlAYaHfK2rzkefUD5UHTLXlvtd74H9jK
         cbDUL0kNKl2A4L6hvUW/Y5JBB1/R1NqMFWTdBa+U4bTknrZJz/0V0ns3b+rLqTkJls3X
         gtqsp9mTjsJO2HHuJZFlEloTgb2QgaZwLYNfzM5ylYRNpQzmfmr2eMfRqF0SLSRda+Dq
         AWbrbSeI76mtQjJRheFS5z0vzvSIQI0LxaUteJE0VVgbcuGzhSO/I2CIgW6tB2ArMRwT
         ISjkZLdB4w/bC8xDQyZt81WUwe9QYxlmvKX+kg4YmqjsXb8zKH/ixz5eKOQZy5F7UJT/
         MSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715659855; x=1716264655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSfxmTXV8nxGh/b1Ev/VrDyL3v8i6n/5cPDbBilCR6g=;
        b=eqZvnaSRPd+11rmqMybzdlUlKoGIuJROCefzB/6OJ5riCyheq5uoGdpXlxEKmDMx75
         N95Du+SdT/G0zM89Qc83uWZihH/w/iULz5ZAEzPfO3lOmRpwgZFf1UwTelrjMjp7ppHz
         ZSou4VDG7KKcX9+VVUKnKYhAZRYdGuYWgzKqs4pYrkOkuSpGVIR/YkIG2kkxsv85LkGP
         uJWymm/ZBgLa0LJ8Iwoe5nSs7TYlHPhsaiebcfUdRFHj+nOiFqkRwIqB5xjXK+6VVVOT
         LdEqsXSikl+PE7qUTZ06bDyrINmnlNpDvZJbLa8np0tdk1qZAM/kJELZlOAqXNOApsHX
         lKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2VYi/aC5lLQBWTD2vm20l3U1jBLvT+LGNKmZjRIcxSnvJnF9zK5vQdYflUjVu+OS9m8qUb/3qOZSC6PwZze4aOWzONYIoxI5gks7HBQOH38Ddb9wLqzySwXJ6hxtG1d1qpBRO
X-Gm-Message-State: AOJu0Yz1q+R5WuHCSz4cwEQvEYKA1oBxW128zNF1Ggw1MHGPVGoBmEl5
	Ro+hTlaFfpeGzWdW3aGN1yh3XZl2Taf6VZ6yOUkh6GE3qV5d3pSwPekQucQp
X-Google-Smtp-Source: AGHT+IGposg/PQRW273bXsTNNULQfbZJ2aHIHG8nqkRv1QjSU0FAp1t99Zpj6GR4RvMktJSxnRZXMw==
X-Received: by 2002:a05:6a20:560c:b0:1af:fff9:30dc with SMTP id adf61e73a8af0-1affff9313amr3490832637.30.1715659855212;
        Mon, 13 May 2024 21:10:55 -0700 (PDT)
Received: from TW-MATTJAN1.client.tw.trendnet.org (219-87-142-18.static.tfn.net.tw. [219.87.142.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634105e0762sm8540039a12.63.2024.05.13.21.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 21:10:54 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	matt_jan@trendmicro.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zoo868e@gmail.com
Subject: [PATCH v2] connector: Fix invalid conversion in cn_proc.h
Date: Tue, 14 May 2024 12:10:46 +0800
Message-Id: <20240514041046.98784-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513175355.2b34918e@kernel.org>
References: <20240513175355.2b34918e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implicit conversion from unsigned int to enum
proc_cn_event is invalid, so explicitly cast it
for compilation in a C++ compiler.
/usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
/usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
   72 |         ev_type &= PROC_EVENT_ALL;
      |                 ^
      |                 |
      |                 unsigned int

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
change in v2:
	fix: remove space after cast

 include/uapi/linux/cn_proc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index f2afb7cc4926..18e3745b86cd 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -69,8 +69,7 @@ struct proc_input {
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
 {
-	ev_type &= PROC_EVENT_ALL;
-	return ev_type;
+	return (enum proc_cn_event)(ev_type & PROC_EVENT_ALL);
 }
 
 /*
-- 
2.25.1


