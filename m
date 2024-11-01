Return-Path: <netdev+bounces-140923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83F9B8A23
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 04:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC1228308D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50814145B1B;
	Fri,  1 Nov 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFyqusHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACC4C79;
	Fri,  1 Nov 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730433538; cv=none; b=egVTDHXAGpZWlj6gyy58jr9Xe9t35sm+FK0gIis5x+fhDtR5LpdvnzURMu9UNbjDdae0qTnRX9IjH9HlHTSXi5CvnbwK88Xmfl+ESwACerzStrgUks596oUKf2gPBW/h1NTHt5hhTCWgFO33tsvgC9J9Tb98g4jzY0b2gsGraCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730433538; c=relaxed/simple;
	bh=aat2SRLBzqfpOO0tUw+f+240+XOG0Y2UqKNqUXsRKzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qg/UQZQFoEy6eknsN8U78irbGjqnwHo6gkm+AGV6ncdzfMJHPn8ycPvRgvhzZQyJJ6xf171o6YeuLi3t5lz3cO2EM/MVFXqj4o6tPcwUz0NqlksxAusfuh/hiFyrt7F/Q3n6WxMM0nYBvJwrLeOac9wqDNZIzm80CSGTRvLBqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFyqusHe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so1238556a91.1;
        Thu, 31 Oct 2024 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730433536; x=1731038336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFSmtqGbfIT/4iT0z5PLJ7AcPQYB66rGXOxJKiMBTHE=;
        b=VFyqusHe5D7wHAonxzHvfSAkB1EKSSblWWGBY1iy191+xPdQGpn6ZjZZeMAITshw5b
         6VE1R1bDVS1/pq0NkpbtB/KEDTRPNTRwiLtJ3DTCU8/sJu4SaKORdIwLh1G4+u5RnmUI
         b8xhdbm4OTfUWGXasxKbkP+1PCLyuNj3C9NPyDwlomZvYrjINm8dq/vitvYOkdeO2kDM
         zmlIjI5eBrBX0fo7M3MEkYm2951/frdLX4R6yTual+yJNgiNoWRkzYH5z2SvtsTjEZZi
         0L4YDceXivjKvjoC9bGwKnsRLQ/js/9atHYZbvgSSedzCjw+M8QkhJT3W+ZFc5TWCuPW
         A4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730433536; x=1731038336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFSmtqGbfIT/4iT0z5PLJ7AcPQYB66rGXOxJKiMBTHE=;
        b=I5eUw7+S8mCO/C0ILPq7tZpVYV8a9cNLRtlWWJLnClbgvhbdEQ1fiYUdGW94P0hGq4
         jqp8M26OnjQxF9SIqDoBpSlNyp80nnUl8g8BRrRT60u2buq9nzbMLBJKReHTiL30+uAV
         VMnD4NyllKdp178kBVduwnPKYnB8vTrzCe88eotEeLYWZ0OX1uLDPp76Wn9yxHGmEHsH
         JkGKpeKNp2/Y65x8kv38lfdspQ6n6ehFI40zY1jjB/Jkh1YY6baZK4mkHpZnjLURYXJN
         OXSu7pXOrDY/+bmQ5+Ycq32xTAFSh3uXosP1q0/Vm86iYQz+4MShxSPe2PT6gIZWohX3
         SPsw==
X-Forwarded-Encrypted: i=1; AJvYcCWrF1IMuD1N3PRkAk75NudJ0gHwRcg2jx7SZiVQ5IligTng/X11XwttbkQFrJjBdUM/CpmXSanjuUphhvc=@vger.kernel.org, AJvYcCX+04Uj5TiZ0eixdtYyhOp1yLFa5USH1pO30zQihMbdP9AtK37x10rxyqL9BY4Q12bzy5ZlewQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjg2na/mznxGo3UPc97y+iRCW5yeFDEHsNlZHaSALq/waXVFOz
	RqYYaCIDVeuLwDuaCdqgIDqh6yumS/6oNZNin2knAgt3UatkHie5
X-Google-Smtp-Source: AGHT+IGkBJL8wRX4GxtDQsr/iacArADSVmyqrSK0Dwd0q8ln8OL6ByY2OLyV5Z2zg2+SpXa9fsi5AQ==
X-Received: by 2002:a17:90b:2e43:b0:2e0:a77e:8305 with SMTP id 98e67ed59e1d1-2e94c533088mr2887836a91.39.1730433535731;
        Thu, 31 Oct 2024 20:58:55 -0700 (PDT)
Received: from localhost.localdomain ([101.94.129.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa2603fsm4146844a91.17.2024.10.31.20.58.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 20:58:55 -0700 (PDT)
From: Yi Zou <03zouyi09.25@gmail.com>
To: davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Zou <03zouyi09.25@gmail.com>
Subject: [PATCH] ipv6: route: fix possible null-pointer-dereference in ip6_route_info_create
Date: Fri,  1 Nov 2024 11:58:43 +0800
Message-ID: <20241101035843.52230-1-03zouyi09.25@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ip6_route_info_create function, the variable fib6_nh is
assigned the return value of nexthop_fib6_nh(rt->nh), which could
result in fib6_nh being NULL. Immediately after this assignment,
there is a potential dereference of fib6_nh in the following code:
if (!ipv6_addr_any(&cfg->fc_prefsrc)) {
 struct net_device *dev = fib6_nh->fib_nh_dev;
This lead to a null pointer dereference (NPD) risk if fib6_nh is
NULL. The issue can be resolved by adding a NULL check before the
deference line.

Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..919592fa4e64 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3821,7 +3821,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 			rt->fib6_flags = RTF_REJECT | RTF_NONEXTHOP;
 	}
 
-	if (!ipv6_addr_any(&cfg->fc_prefsrc)) {
+	if (!ipv6_addr_any(&cfg->fc_prefsrc) && fib6_nh) {
 		struct net_device *dev = fib6_nh->fib_nh_dev;
 
 		if (!ipv6_chk_addr(net, &cfg->fc_prefsrc, dev, 0)) {
-- 
2.44.0


