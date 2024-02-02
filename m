Return-Path: <netdev+bounces-68414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CC846D82
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D441C268A7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE357A70A;
	Fri,  2 Feb 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBDpgw7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C575B688
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868847; cv=none; b=bikgO4jvPAVlAmyG3TsOSVeXhC1X7zOENVB2Fbl5DUMdb+jW0hm96E19cU2PvJnvy9DtW8TzRuv5aWMv3Pq/psMkQ+c6wSrqRqIA7ba6rh+J1CCxCL/fmBYU00XncwQ/hAtLzgghzJp5DBYqNG/QfDrWPP1XAaXlhMTuJV8VhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868847; c=relaxed/simple;
	bh=GGoZHDl7k06VE7vsfKH+wgAsHG7jeMnfyAjjaTV5zmo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bZiESZ8ZCyU6depZcyg+88PAoK0OZXJBUuYxOVlpcmzcnh3nqYzwMf3V6ZkO+GoMIhBWjO1CsI65XAFnR5ARuv0i5j8jBTAZz7BzUZxvFZKPX7p24nedadB9m7owZkJO2r4fpR3qX6PTk92bsudqyYh6u5J6HJ0SPTNZ+zcWKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBDpgw7Z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so3095511276.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706868845; x=1707473645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+gfzUpAM2GD9adjF6QZ5ipX/yy5ViMwcl6J4vglcx0I=;
        b=gBDpgw7ZVWQYlX9GSaoMQBT9hu8IVqx9X3cShL6UCh7p1aVmAuIg0mjupdMtHMdJ+O
         06knGp+U9sb+ka0Ukx9FWPwA1GbHD0E5NiAqsrYGXfWb74Z10bv59f9zxDSGZPeLamon
         FlYKhch9QhbIQcQBP3sFcCJmuBHP1kwIW9Xyj1cL1wS/R3uuvVYFVCO4Cx/S85kh74LK
         ESXT1q9Xi0F9XM3tt6ZSOMXyVIcGv9CsLKX60M4Pxw08CC1YSyC4dUTnwapvx6YWFESs
         BpjKG0gC0YWgUoNFG/9nHXY1Qug2pRi4uw/X1CXyjDD+rBNP55YEwHyhTdW/otpCYz7P
         bUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868845; x=1707473645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gfzUpAM2GD9adjF6QZ5ipX/yy5ViMwcl6J4vglcx0I=;
        b=R3vtycTbYatYG/K1ksuqtYSbIpQzQvInYszKGgu6xsC5fWKOOF3CtS2qheF4xqyiQL
         sjYeFnAcsiDrddYxfmc3F2kGtbzGWO04326/gXKvKU3E5U8xSRR9iFp8ENFjlPA7GC/L
         5mxuDQ69s13CWsCfYl+qIN9HUAWFeGRCN47zwOQvxPH8PMalUIMcSKb+1VNViAxY1gFv
         t9COPWu3fXK4W0GW7sp2IAqXR05kxcAvOZlmcdRx0S1UIz/uLyLESb5nA7kcb3PIB39n
         GLtpcJhDgMecu/ISciKYRTImfTE/Fi5E5Y6AryMCXl2sl220wCGXchncCgWxGqQHOPSM
         GGyA==
X-Gm-Message-State: AOJu0YwRs7WgEUwAzWeYsa8HXXI6S0Ff9jAFFujB8DmnkuqwQf96Ut0y
	ftvTBhop/E0ccUn5/v8yQVuuM0Nr2bKLcNdRQS5tZEA3DYh0O/SK70apwCZWaKaSS8Sikb86vnb
	IjEdYtYtfbw==
X-Google-Smtp-Source: AGHT+IGZsaFncB7fDw9f7CV8h8UdlvB79RTNKQkWPeMZq3lvSt52IGFBS+VP+jGlr5plydmr72+YQWByZBZfLQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP
 id v5-20020a056902108500b00dc6e5e9f3afmr731530ybu.9.1706868844861; Fri, 02
 Feb 2024 02:14:04 -0800 (PST)
Date: Fri,  2 Feb 2024 10:14:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202101403.344408-1-edumazet@google.com>
Subject: [PATCH net-next] sctp: preserve const qualifier in sctp_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

We can change sctp_sk() to propagate its argument const qualifier,
thanks to container_of_const().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/structs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 5a24d6d8522af9c814cfbb568c627777705051ac..f24a1bbcb3ef9442f4a739d8b25d92fae582a411 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -242,10 +242,7 @@ struct sctp_sock {
 	int do_auto_asconf;
 };
 
-static inline struct sctp_sock *sctp_sk(const struct sock *sk)
-{
-       return (struct sctp_sock *)sk;
-}
+#define sctp_sk(ptr) container_of_const(ptr, struct sctp_sock, inet.sk)
 
 static inline struct sock *sctp_opt2sk(const struct sctp_sock *sp)
 {
-- 
2.43.0.594.gd9cf4e227d-goog


