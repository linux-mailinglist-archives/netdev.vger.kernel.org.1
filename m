Return-Path: <netdev+bounces-231531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01CBFA14E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E22518C73A8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C672EC55C;
	Wed, 22 Oct 2025 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGIHJrXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C02EC0A6
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111619; cv=none; b=q720nsdK3ukSAIgxHSNlpKckQ2dIyhJYTkoPZmQH5lAZ53sBgObkKabPVn3OvDHamXXEY3IACR2lfjUU6zXcK71G4eQlWvPAidrO786VGraAkH/3wqFlZzHxM1ESUpMYBoFS+45y4kZd4qa5KPFxtrZGCBujnCIWdWNJP96IjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111619; c=relaxed/simple;
	bh=wNbDK8xMGMpbverciSaIdpOrFhl3NNGtxfN+sqFv+NQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZhtyrtjETHRJeu/sSpcJYPBnVBlFe3rdHKOP0QtB0s7FXFaZAkC4jbdP2MY0c7nIEGoZbobL+2LH6JpGBHIRqHD4153rkH769F4Rh1JDLyGKCkie5Aox3kK3AIbGCjV+FsDeg9Dzlp7GVm3CKXeq+8u1meJqZpB8P7CbYVJ/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGIHJrXh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so10977411a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111617; x=1761716417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAgIYysVi+jsULzap/nT326gpcKDyuomxjRt8q6FxCA=;
        b=eGIHJrXhNluI6sjABevxPCjHEgoZmwl3Y8aORAAN+3lrZgMs6xc6yUSrOIenSlArSu
         MxhU45idJH1wEpxizHvmALiJR3mpuMuRVoMfYji32oxiEFEtMex8Zyp9a9Ij9nlqKY+a
         9ykWQjBN7yeks6p8320X8lStLikqIPuNjJzpBNa6YPPyK2P0otiY7POF/6yIYxYLiM24
         a49g23i0AXHze8ysGszaJH/kBB/FaacEDRtxWLbSqS187poiBvSPvNBXtfJj5rmysIUL
         VnM/+7cQmUDrR2G7IKFYaVTFDHMLNAPdGJABd1LttUPS4kglUv2hGgj1esRmNQ4AK1wS
         T7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111617; x=1761716417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAgIYysVi+jsULzap/nT326gpcKDyuomxjRt8q6FxCA=;
        b=ZBYaev2Yyz9T4h22eMMgttQdxDdVPn8Hivudn/mikzBWvjU6iljJKURE2f0TlRu3Dw
         tGA+5QZq7gnv4momfdYFnZBbDipnP8c8jcnbltClyJhm/ARrWYkEwtOExGWQytHOtM6T
         PME6X963Q6BR3GjrJ/Koj3+4mR3W7FvYafo0Lpvfd/nt0cjvXFV+U7qLC3osP+QWLwVp
         TyVghCQrj+LBTHcrqZFA0GdANkHqblHPdheV79ifm8+NRFvU4rSs1K6a2b98Dk3cbSxw
         tPh587F37Hxf9pA/PROguTYtHyw/h/ykepRQufxxkrGzr+4FoE4OlEaBtfp7x4KEsIU3
         D1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJAStwT0cB/EGktsXoBG2+qO7t9ynLMB4NVPb0RNzhusUxayG8Yh6yo9MsQ2uPfTTxBKbXE/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzosRvBwyl6FLO/WumzKW6mHR/BGJDrbdY80UhLnpVd2vqq+mZ8
	8kfB2igLeRgtyedtb3ziXvtvz9Qef7ASBY/jfjyELRPDrdbVp18cgjPlz12K3hL6Ge/hCsgODvJ
	ltTCRVg==
X-Google-Smtp-Source: AGHT+IHEYYbpv/cg76LWEPhF2lm96PfYblNJfkpuNjhbE08PR/19SuSst2+zI9UK63mD+xCKgDl0FvYEBWc=
X-Received: from pjbnc14.prod.google.com ([2002:a17:90b:37ce:b0:32d:dbd4:5cf3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3909:b0:332:84c1:31de
 with SMTP id 98e67ed59e1d1-33bcf913ebcmr22861958a91.25.1761111617177; Tue, 21
 Oct 2025 22:40:17 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:45 +0000
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/5] neighbour: Use RCU list helpers for
 neigh_parms.list writers.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will convert RTM_GETNEIGHTBL to RCU soon, where we traverse
tbl->parms_list under RCU in neightbl_dump_info().

Let's use RCU list helper for neigh_parms in neigh_parms_alloc()
and neigh_parms_release().

neigh_table_init() uses the plain list_add() for the default
neigh_parm that is embedded in the table and not yet published.

Note that neigh_parms_release() already uses call_rcu() to free
neigh_parms.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index dfa997c996896..56ce01db1bcb4 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1764,7 +1764,7 @@ struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 		}
 
 		write_lock_bh(&tbl->lock);
-		list_add(&p->list, &tbl->parms.list);
+		list_add_rcu(&p->list, &tbl->parms.list);
 		write_unlock_bh(&tbl->lock);
 
 		neigh_parms_data_state_cleanall(p);
@@ -1786,7 +1786,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 	if (!parms || parms == &tbl->parms)
 		return;
 	write_lock_bh(&tbl->lock);
-	list_del(&parms->list);
+	list_del_rcu(&parms->list);
 	parms->dead = 1;
 	write_unlock_bh(&tbl->lock);
 	netdev_put(parms->dev, &parms->dev_tracker);
-- 
2.51.0.915.g61a8936c21-goog


