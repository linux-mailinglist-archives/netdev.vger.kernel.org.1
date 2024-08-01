Return-Path: <netdev+bounces-115030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B5944E95
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF6283B80
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4B1AD9F5;
	Thu,  1 Aug 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYRDvaWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93A1AC442
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524113; cv=none; b=GjjhwUOyLK8uqzps7iTBgx0jKaJOJynaDd78DDZRv96qSTN/6I8r2bWQUNxMkyU44k9jp77a64Cnxz/pJVkLfx4tmfCaykk6xmvWrTA9f5BDGUeqkVhWsEyfgLWIOQ36eu4Y2RqIb6Eo0qhKlZI0vNWQMzPQyQ6Br7jAeeIIII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524113; c=relaxed/simple;
	bh=TJhLBE/1dDFmQcXMCrFDSflxqCoEQKoFBZolCz3PYeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kV66rpXSgOSIy16+z1w5Fzknz4ey8TFKEV2PEq/aFiCtwwkUeE72917IDT9Xf3oECycjXAYTteF7T1EO1hMTjAoC1SRXFxZAqTFW0BrlL1V6d721fVQLenP235bBKqFLnTdXWT8RE2vaBBaqBFD0egxE4ySAydJbjaLVlcGqlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYRDvaWJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b703eda27so4546863b3a.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524111; x=1723128911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=XYRDvaWJvDc/78QidRB6woDAyhsd3rDbIljjkcnG3dKZBwdgQQ1WvFk0wPfO3SVTdP
         Ay/5YJTQ8XmlVIzvx0tr17IR/fdS/JknN9pM/kIgEo3ryszYq7y4AyRUlsKGAoazFhmG
         v0MQgOqHzopq3Ka1SvfHu6QA+IL9UUv1624dY90dFgSl1qXHzPcVq8muJABYr2vyuuKE
         uxPp6P87UmWN5A9o+4bvI1SHw7CeQrRrftWEmAkKxT2rLVhUkubBo6oRwn6kpM0jW8Eg
         CxtqjVCjSky44eHOMLVaCGbAJnHMVfvtY/Ee+8PQ6kRhIWXLeB+rSz5kZXNNG4aeo5Af
         1gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524111; x=1723128911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=PQobonuFViZ1FlcknYfC4Qp8HLtv1BtYeM/mcjEQgHsnW6fFv6HcUu8CRcVMclTAAm
         PBPLJUofx0+TOkqzdYHo2Hos3ZPkMgVGOrpS9iCamwyB/Tl2dhKx7JL2ijgXiZcUuoqj
         8lxOmT2QrVdUKIULrVJzwejf3ylxPzmdHz9iMyvXD9UrfHb8wO0K5Bmmhu1sQMkbaJg+
         S+Kcya82lARndYlIhEKtJ3BVB4ZT3BCbU+jd61tBmsDqu/Zq4d0bP8i/5WwyNxjmtp1E
         Q5RILjKaKbUfAZHoTiyU2ul6A8+woWPA7XPByVoDEOotTkdgyvy2eW/eyQEzk4FYZkHl
         lXPQ==
X-Gm-Message-State: AOJu0YwaDbxQpqVs1VgccAF0QU+ejlsyAUFnB9kxbuQD5fHoUkCyOaRq
	5Vr5lXhYfTcSMkSd6/hzla/oVp/bYYBEwBEU21IpasJHLWknxJOv
X-Google-Smtp-Source: AGHT+IHajkU4oU+FKFJ2XtUm1UsJVmIOT6dTTQqFRX/q/P21f7AmoFlQfLzQAYRdQRPpm4Ki1pVlgA==
X-Received: by 2002:a05:6a20:d501:b0:1c4:81a0:3783 with SMTP id adf61e73a8af0-1c699550da4mr427605637.11.1722524110900;
        Thu, 01 Aug 2024 07:55:10 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:55:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 7/7] tcp: rstreason: let it work finally in tcp_send_active_reset()
Date: Thu,  1 Aug 2024 22:54:44 +0800
Message-Id: <20240801145444.22988-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to let it work by using the 'reason' parameter in
the trace world :)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..cdd0def14427 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3649,7 +3649,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
+	trace_tcp_send_reset(sk, NULL, reason);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
-- 
2.37.3


