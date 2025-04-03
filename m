Return-Path: <netdev+bounces-179179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E4A7B0EC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D1E881403
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F81C84A7;
	Thu,  3 Apr 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZzdIJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975181C5F07
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714656; cv=none; b=PDg7VOkHHV7qs2S8dtVijXGnc2PqZ9HXSZI2ETAW6hDq9uk5G4XXrIOz6UhHmqjhjRFAmlmmLBpAFLZQlW9ZncwV61QViiLv8qkDWn89OSRuxJzv2/d+4od+GQHhySgx7upLSliAYYAgUDxpD3c4f0wPxfWDJJLuDyYW8JiQVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714656; c=relaxed/simple;
	bh=hHIYHezDOoxCNpJNOVopdAZG9dE34xIK63RE3y96P7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lP3iX1JBadOrrbMymljQyGEJkzOtp4ngNC246mvNhWcCYiG02YH2eWYhjzjhYY3z3iWPexteOVdY0/PvCUVZmDgS0M3XIgawY3WYzN6SfC7UjQnlaupBP9Zt0JH9k5jRiz1QN4ggHa8b8qgSJhaZEvogk7d2OFppv1MNAtVas8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTZzdIJn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fd89d036so16404715ad.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714653; x=1744319453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwt8GGRRu6e4+a9i4CGYtv0iwbrJOPzYW8+muO/Prik=;
        b=GTZzdIJn9Y/6/Bb4GRpsZ2Up8SxqE45BWHa106+zKylIvVUIOZy/WnqVEemLip6F4G
         2vVxMZ+iHNG1HMIQeACeJuRv+8qqA2yLcmfaZFbzxEN5clZKFuzLnRZz+87SmQHp+4sQ
         TDGegPxMN4E8iL7RD4Xu+XvKABP99u9jhZ3b6TAjqFArBO69tSfeQYx7oaoRzPdcZQP1
         Sm+/YrtDimEyLI9JnZcyDUNlFnBp0oTbgxMBb089OoUVrYKcLdzGuRN1Nn7OoAdy8K/4
         o7TPXN0+McUxTTnY1j3qRhe9W6od9uA9fgyHCjioEZc9DvCAkg43QtWEHjLhCSUr3muM
         UofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714653; x=1744319453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwt8GGRRu6e4+a9i4CGYtv0iwbrJOPzYW8+muO/Prik=;
        b=Eajqa1+jVwNHwwXLww4Njc6dlgX3e+lVapZb0n2PpvCl+bAlwJ/JBsLzNXfoei8U+k
         AEb1efz+TIn8dtR/Vt/YMyQo4Xe4JQKWj1Yyj3x3DaCDkCRa3rci1d3QUIKfFILWYX5L
         LPTrVvFzk1YA/yYhvW69mKrrKPPHDnCUUTCvb4n7JOZxrD/081vTbws6iX962toKZK/b
         xK8rUeJHY0yxuCB+ptSMAXWKO9deH8FiqgBW43ZfSKn7hzRV2t2Sy3BTrVf7rFKGKWhJ
         rQ69Hb2/JFPcBAu6g6Qf10gM+L5+0URVzAA7rdYam62f7wuy95TZ2ElxAJCmNZZtcDUx
         X4Jg==
X-Gm-Message-State: AOJu0Yz64ZaX2hMwJRZktRaSeguoYdLqUBcUr+K0SZauZAKtkwKlhSpG
	U2WgFDGjvKWdtuFzIdA/uMraH/AjNb81D0zSzGXFq/WHJG98zSVeHtYnoA==
X-Gm-Gg: ASbGncuP4R9nL9j3Asp28naHmJ52wp9a98Cz0MJDQhLsZjEtz36sNHHPxMLqsQi/2N5
	AJC0HSTgtzW7ve9ksQTDVownHdPxU8sRof515/NAY0GrMwTH6kjHh1ccW8cwaXUmoJkSnzNIXJB
	J+3c7DSIrDcCGZ9o9Y/8qLeDOH3wWrpRtcJJxD+JlQQ7nTTo6ko9iFhmwXSawK7I3bMZpcwm3ps
	UHCDkjBfSftjKQuVUxQuGt6TqLP9YSztOZkfoa6JbF2ydk3zHDMDYIVmyvKD43cWxsDeFLvymko
	0iw7CMxUhmdqHKBUkBTGQhHlIMz+6eXUuHxiweO5RxRLmFW2eqlLtr8=
X-Google-Smtp-Source: AGHT+IHHjbUjF1qaNw2bGPlzT7rka4ZjhLZHFAI8BJCgckyv105tnHYFvhEcgj+beE6HEwxDGv5YVA==
X-Received: by 2002:a17:902:e552:b0:21f:3e2d:7d42 with SMTP id d9443c01a7336-22a8a06a041mr7912135ad.23.1743714653454;
        Thu, 03 Apr 2025 14:10:53 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 03/11] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:25 -0700
Message-Id: <20250403211033.166059-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsc_qlen_notify() is not idempotent either and not friendly
to its callers, like fq_codel_dequeue(). Let's make it idempotent
to ease qdisc_tree_reduce_backlog() callers' life:

1. update_vf() decreases cl->cl_nactive, so we can check whether it is
non-zero before calling it.

2. eltree_remove() always removes RB node cl->el_node, but we can use
   RB_EMPTY_NODE() + RB_CLEAR_NODE() to make it safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index c287bf8423b4..ce5045eea065 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -203,7 +203,10 @@ eltree_insert(struct hfsc_class *cl)
 static inline void
 eltree_remove(struct hfsc_class *cl)
 {
-	rb_erase(&cl->el_node, &cl->sched->eligible);
+	if (!RB_EMPTY_NODE(&cl->el_node)) {
+		rb_erase(&cl->el_node, &cl->sched->eligible);
+		RB_CLEAR_NODE(&cl->el_node);
+	}
 }
 
 static inline void
@@ -1220,7 +1223,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }
-- 
2.34.1


