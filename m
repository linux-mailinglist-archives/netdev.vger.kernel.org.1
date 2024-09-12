Return-Path: <netdev+bounces-127793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE105976817
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61E92825DC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610D19F414;
	Thu, 12 Sep 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzPu0j66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3535589B;
	Thu, 12 Sep 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141670; cv=none; b=VHKW0VV6rTTltVtxFIHOqhynZfzE4jtra6sJ+0CBthk7rrimfBba1ojGZ/S8/DASrR4dRvAxtNoBxVflFhUgEuO+Kl0InvlCMmHB62o8aQamQ1h9Mw3vlzZcvGabdVGbqZm/4z9SvVs7ws6Nje1Fz83K+GfxEArH16BsjKWFfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141670; c=relaxed/simple;
	bh=EZ3Rxl3JSiJ0edgOZuT4+y4jBNflX5WiZMFnnCqvjBs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lOarOF4o4UcZGmRPX0MNDsqNz+sPBJDhf5d3tI1bWz1D1ua+pApMNpbHbJkhdk1obYAVS0z8+KcDUySyx//LByUCOQ4u9ZeNQSvxhbrq0CgG1TTLqa2StTPSz6GNF6FDI0B907u5b51dtyOstkBC4SdomcVpgcXEpP/hxU69dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzPu0j66; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so6888695e9.2;
        Thu, 12 Sep 2024 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726141667; x=1726746467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2kNGhCnrGOXb3dhnJBFfVh1SEq/09AjMxbO/Rc4C48=;
        b=YzPu0j66PqYUHjL6uOyX6WcPdI98ofmj0glYJPhIcnbJs5Qk2inAFLM6cvagptDOea
         iMTosGKhgvvI7oRSgGO873lyqKngJYTQzx3IOH1O/epSnBtJUl6YZFQrAYXbRx3zV4pJ
         ZIGg9cCmtSNICOpeCsHgyWhngxbhNSsLHT+FzSl1w0BnfHVCUWyTUJd+QeiMOlxYcizV
         nKiqEiN576S10msGvUvk2oZpWqRDZh60LvyszuQAzN6RA9b5sckM6dcyaz3TaJL0YfRL
         FqnpgiFCyOfsf2H/9hQjgo1KPlpAUmiIx8HfXlSrscp98PRGNPGK3bEi7Fma15Ng1uh9
         u8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141667; x=1726746467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2kNGhCnrGOXb3dhnJBFfVh1SEq/09AjMxbO/Rc4C48=;
        b=YmmlD5wNNWXcwSZXUklCCUUBaCSvxuEm61SatPsnVR7CcfUWcd8cfyovbDl3JAyzOe
         bSHA/3nLqFbxWfcMtwpm5CcAWPaeWn2QUJuXCdRxp6kL0ssOlM6RU3bslnAyMUjRkeOw
         1eQR6ZN34accycPsTUuX0pM77Wzbo41BYulueLCXmYE5szSjqNYeFj44tbzGdIHhG/VK
         OENnh1pSDcDGLXw6NIbuNddQ+ilPfQOuWr8CuD23LMtZRx5whdhYcNJI4BkLEpEfaa08
         DE4xpoTNG0zOBfUCXaexKoQTrki2qi1cH7Ou2jrdrtGpaxIzLRT71xDGlS1BhKrWsYM+
         j1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUdgWsqY2ah10gyiBGZVjKU+ZUSsghsTsVTnT9WcfKfnLwYCim7NV9SZpZQK7kAn9dXJKEWwj9vsTuHZLY=@vger.kernel.org, AJvYcCV7q4+IdFtnRrIVr7JVi8enuc1yiS2o887+9HnP/H9wCijlZRbH5ikMez4TgYF+d6iFFMtbLZGc@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWqOZ2HvS2/Yuow0I8+ljaoDyq1iGThInmN4nQtJUI0dBn+1n
	U3hjAx0VWZRs3HdyQ2aR6q4F6oDYqJ5mHJbzgr1/nRpJ0uyBoHs+v3WJFf2P
X-Google-Smtp-Source: AGHT+IFpvVJ8mjIj4ZycMn1gUOuuWsb0C9eOPZqchfy3/VBGRmjPQ8d/R0EX14tHM56NsC2WuPDfCA==
X-Received: by 2002:adf:fc83:0:b0:374:c101:32 with SMTP id ffacd0b85a97d-378c2d4caaamr1379760f8f.46.1726141666764;
        Thu, 12 Sep 2024 04:47:46 -0700 (PDT)
Received: from ubuntu.localdomain ([46.121.16.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb322fdsm168090545e9.11.2024.09.12.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:47:46 -0700 (PDT)
From: Guy Avraham <guyavrah1986@gmail.com>
To: guyavrah1986@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net:ipv4:ip_route_input_slow: Change behaviour of routing  decision when IP router alert option is present.
Date: Thu, 12 Sep 2024 14:47:42 +0300
Message-Id: <20240912114742.310392-1-guyavrah1986@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an IP packet with the IP router alert (RFC 2113) field arrives
to some host who is not the destination of that packet (i.e - non of
its interfaces is the address in the destination IP address field of that
packet) and, for whatever reason, it does not have a route to this
destination address, it drops this packet during the "routing decision"
flow even though it should potentially pass it to the relevant
application(s) that are interested in this packet's content - which happens
in the "forwarding decision" flow. The suggested fix changes this behaviour
by setting the ip_forward as the next "step" in the flow of the packet,
just before it (previously was) is dropped, so that later the ip_forward,
as usual, will pass it on to its relevant recipient (socket), by
invoking the ip_call_ra_chain.

Signed-off-by: Guy Avraham <guyavrah1986@gmail.com>
---
The fix was tested and verified on Linux hosts that act as routers in which
there are kerenls 3.10 and 5.2. The verification was done by simulating
a scenario in which an RSVP (RFC 2205) Path message (that has the IP
router alert option set) arrives to a transit RSVP node, and this host
passes on the RSVP Path message to the relevant socket (of the RSVP
deamon) even though upon arrival of this packet it does NOT have route
to the destination IP address of the IP packet (that encapsulates the
RSVP Path message).

 net/ipv4/route.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 13c0f1d455f3..703dbb337d90 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2360,8 +2360,12 @@ out:	return err;
 
 	RT_CACHE_STAT_INC(in_slow_tot);
 	if (res->type == RTN_UNREACHABLE) {
-		rth->dst.input= ip_error;
-		rth->dst.error= -err;
+		if (IPCB(skb)->opt.router_alert)
+			th->dst.input = ip_forward;
+		else
+			th->dst.input = ip_error;
+
+		rth->dst.error = -err;
 		rth->rt_flags	&= ~RTCF_LOCAL;
 	}
 
-- 
2.25.1


