Return-Path: <netdev+bounces-68337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850F846AA3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F4E1C26CD3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EFF33CCA;
	Fri,  2 Feb 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJJBKi3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1818643
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862140; cv=none; b=S2Yp10yrCXvtBcoeptLut1d0CRYX82twvVquLy6g5c4ChEdSKlwtKnr3kg8QzZ8dxvw+PzKJcWewA65hZ+Ogc9DQ9dmc3iIime4eWr0j2/KtY8BDlny+og2ev+yqEu+i+HzD6w6HB7CDVV/NZ4oiEpON6AcD1CA+183IfL+2ZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862140; c=relaxed/simple;
	bh=HpVbHkeOqkF/1RYJWf7zKLBWQVQE639n56ds1nqcRNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRmghGo4m2w5QDIeBRyjFe2pllnzZ4xQIVHnBdqPtMTGBFB3msTXE5UYr/oMOstlT2kDIA5l0DDjRErI+DOysA8GBeTLkOrvhgVF7364hchS74PAQpK8pBXX9nz3OcXEHpRUX0FwzVGX6Bs/jrCqkGPH2LlJJaXCekc335ukk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJJBKi3E; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6040d33380cso19077347b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706862137; x=1707466937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmiXWwm1UAq4DNGfUdAw4+QPa0CLlToqX+zE/vJCLA0=;
        b=cJJBKi3ELIHtV3Gw+mfOYs7tll+0MnRV0ldes56aQhhgqQVVS7IBFndDT9JeMuINLn
         +K7l8vtlh5BuvGFG189uxX8IqES6Vrjg8GxGK3LA0hSt7TEFSk2UNrYHsJvdE9lHEGc0
         vr7yKdrvRFz8g7tb3mJVYoGiVkE0vV9j9EFzKKRGaw+uDqv4XH7vFVH+JsZbp3bGozGm
         NHGyJOkyGE1yzaby+wbeUWOL/DlSTd76CasRz0zRffoBG1GgMLL5myeae6YMVtfqc9rM
         q2OtsuCWj3Nv6RyuEwRo+k7o8Pwrqa5Q1a0+XTQo8hN1EzhSRyRZImjM7QuPtDg0HPoW
         Kbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862137; x=1707466937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmiXWwm1UAq4DNGfUdAw4+QPa0CLlToqX+zE/vJCLA0=;
        b=dCK+0k1L7+tgj3jcdRZIUVON35u+p3ZDaNzepdf+lIZDj5BZQa7mbeI+uxKcpXAU/l
         IxEUj0LpqJggPAzh+KKfIV/HjIlWdfWUkhalFI1Ti/uSUns3OEHttQPTdvKVbjZ7brv+
         yNr23xeaCd3XV4+cwP41m6ssSgJ7M+dEI313Bhfr7QpMpSJtA4MykqC5Pt4ay071sPaC
         vaesNkkU//XIaWMA9T5GNnRpvk4VEembws236q0ksEAnz8sPRAHhIQ/eNmhgX3zCXK/4
         33P+BY9yub3oV8e1h7b/q0U6fQOrSnobKdLVlGkowAcwASLY5Syl7NJb+kGbGzhiDGsw
         OJfQ==
X-Gm-Message-State: AOJu0YyFyspM3Nhk7w3YyDp9tzO1B75AV4/5NCsdwWcXXxRYO4bsrc8E
	KnL/q+NMHifZr3jcN5uKUQ4x/4iP3cu5WOEpLfOO98v4GP6/oMKbkZHgpQOx6Nw=
X-Google-Smtp-Source: AGHT+IGnmLQd5h3tEgohA4gFtUZOQbPQHhbvRatbJpYDx8nC3k89H7MpHjS03gbrah7bcGuPrv0hwA==
X-Received: by 2002:a05:690c:f82:b0:5f6:df70:bdda with SMTP id df2-20020a05690c0f8200b005f6df70bddamr1900130ywb.32.1706862137122;
        Fri, 02 Feb 2024 00:22:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWl2EMRhDHFMHS6L78h/n6vZ/5UclrlAQTqUUqxaBJgAyEC9l1RfouUsLwDOxJkMpXXOtKVV0zK4DL+VLAyuZsignhH4YVmBFgv9SRl2tLGJ0EPdksUqAcnAsvKzH6A2naZA9Ry22RMBSG+0K7i6glYuqQ2JFEdkk8kHiahoBAXQn+aS6H6hnY4Cj1v6tIsmmvwzjiucB3WsuUzXoLt3023qwYjaS71y+92+g4FFgYDeVF4eQ9sdBWoE52U5xrWapuP5Nn7A5qA3m4gf5Mg5fGYFBspsCQ1j7SdWodnflUnv/oH+XdBWqSNDWQYHJWqun0h7JHSkGKxEhOEZUJkA5+IULhS4a+QL0wuIA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1486:7aa6:39a6:4840])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b0060022aff36dsm299679ywg.107.2024.02.02.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:22:16 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v3 2/5] net/ipv6: Remove unnecessary clean.
Date: Fri,  2 Feb 2024 00:21:57 -0800
Message-Id: <20240202082200.227031-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202082200.227031-1-thinker.li@gmail.com>
References: <20240202082200.227031-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The route here is newly created. It is unnecessary to call
fib6_clean_expires() on it.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 98abba8f15cd..dd6ff5b20918 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
 				clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


