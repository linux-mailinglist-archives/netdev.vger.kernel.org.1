Return-Path: <netdev+bounces-202920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BCAEFACF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D529444DE9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B627815C;
	Tue,  1 Jul 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NCM6brN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74C279796
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376614; cv=none; b=F2M4tvOSN+1ZsTMka87vTmf9ISs9fgPwI3ESwZG5Rt2eYCgbNpQoC/yQQCDL+gdH8uHecmEX/WAJW1XtH+u7O6fAn+lBlPgEqnPTTqcorErfw5mxS68hYp9sqT9lBlnZpiiLZy9JdaIWv1v5LryYzEzqfvBqru0K+t6lI0Ghcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376614; c=relaxed/simple;
	bh=SItT5T/q+tLDDjK7o+sVIPQerJrki7Yws3XVW6+/gqo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rkRPO5N4ch2j3PH2TNIQj17aAOH1YedFy0RgpfCLNKV6iUx/xlTunT0GeJ0yvcmiQRi4GjEW3qXRpAU1e2cctPT1fPIPvFwcFywGlccjIA4JPFuku2dhx+OiOuWNdncNP1nG4XPPAFRcEjoiq5Iw+e8fgZAqAJsDbtUbENK1+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NCM6brN; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d0aa9cdecdso257145485a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751376609; x=1751981409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pI75Qlc0dLpiWIP3Udc651G3SKDJdQAIp516vGCd5hE=;
        b=2NCM6brNZs2NYY5coVLivg5++FDvsdb9fXYggccy/bhnyBlBzpUZiXySEABIyUx9+t
         NcSzAlOo256zpyMxMfsQsQIkPlcJoedrozm4GJRXpNjX1eyWiX6H6b7H/Nj/dXT/r+9U
         OWUIs81sNco5O2gYRHUJm4UFUDMYSoQVWLtfZ1UaUOVXXpChC2wnc/Ng8MEtJYZgOmCO
         Wr3Qhi3U7gWNZZv1bniUvC+hPsqpVgfiOGrmPDiUkKlpYBh59j5/WWYN7ZZ/VKzv1kd1
         tmD/CQnR1H2qZb24bW86X3sCzk9z4uo6BFpXlf/X1hkBh7KlGCu3tjP7K21DFkpLEn0G
         RoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751376609; x=1751981409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI75Qlc0dLpiWIP3Udc651G3SKDJdQAIp516vGCd5hE=;
        b=cxVurECPq9gI/1Gst0VdaSNS2v+dNWBZjEUJotOOuEG/gjQHnRxc7f3RPfRYjum7L9
         5kIXyI3/afQD3eOR1OU59zcNd4SGq3pVxvtQnwbgOhk+D3lcXDvGE9eond+/XVxePpWr
         vDNAT5gQFvKBvommPgZbFAix9/rZItXjQm7TGFy74Axj0f6zcrZo4ENdnWw39RrZWSOx
         1Z9EnetMxTtAcre9mrdoMcmTla/T0mGyCw5Xwa6O5cdzyr6I5zuPmtZDiJlDWsdoXArt
         VpB4hBYUgfvxr6cDtqpzlTgx89rPQez7TngjzXapt5XarS3fGRO9NKPNOjK2iT/ohaXf
         0pAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXacC9mbwrzSuUNaPXS0CkehstkuiBI9YYovUuJ1Q6OoWD3lAYuMCCZMWisB6gKJCzUwatJpcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxwXYPPQmn80bH+qRbMwIi6CP+Nm7xsR/Bm4e95TtpjE5ov4Z
	s9RQAC0UyRJWP7ik/ttj5B8mMdHqsaXuHiwZUo3wrk02Y9jgDGCQmWJ1Xq7Z2la9LA5z8qm3EvU
	J3FiUoZ4MPqNwUw==
X-Google-Smtp-Source: AGHT+IGudUNuiw3zUfohJ1j7zpw4V6PjX11NjIBJ7AHw8t7GMNYLFRJ0cAl6QIvjFHlLD5VrwWQotmTuKA36Tg==
X-Received: from qknty9.prod.google.com ([2002:a05:620a:3f49:b0:7d4:1a6:3fd6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a83:b0:7d4:5b4b:530c with SMTP id af79cd13be357-7d45b4b542amr1184279485a.35.1751376608661;
 Tue, 01 Jul 2025 06:30:08 -0700 (PDT)
Date: Tue,  1 Jul 2025 13:30:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701133006.812702-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"

tc_action_net_exit() got an rtnl exclusion in commit
a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")

Since then, commit 16af6067392c ("net: sched: implement reference
counted action release") made this RTNL exclusion obsolete.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 404df8557f6a13420b18d9c52b9710fe86d084aa..04781c92b43d6ab9cc6c81a88d5c6fe8c282c590 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -170,14 +170,12 @@ static inline void tc_action_net_exit(struct list_head *net_list,
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct tc_action_net *tn = net_generic(net, id);
 
 		tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
 		kfree(tn->idrinfo);
 	}
-	rtnl_unlock();
 }
 
 int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
-- 
2.50.0.727.gbf7dc18ff4-goog


