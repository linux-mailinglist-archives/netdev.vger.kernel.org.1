Return-Path: <netdev+bounces-70564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD884F89C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794A21F261C1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C173181;
	Fri,  9 Feb 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2cXNSt80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DD76045
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492675; cv=none; b=avBw/XockE0yNjPy8BXt2+rkYg/46KvyuELPW4hmKu12vw2/Ju1DKXDeNGvTYayYUFxSJv9x7gpbk9ynkPDBFzWGM04dsBodOwoRJcxAPsZs+y06QEGaOx1/0TORo/VNTvvLMoiuUclPIuhpb29CyIDBTi/9Z4HQwBJYgSwmtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492675; c=relaxed/simple;
	bh=hO0rWGzaTeiN2RWXkop3eT7hJWEzART+btUeI6ejcyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cpf6JrsaVyVJEtPmElrv0RqAuasEyFq+UilD8hz/RmIf5brqjOoNMKWoJNf00+i1GVP0Ok2OOCMLqDyFUZHstJxPQ3YztfnXP+uc5ldci9Ie58HZiMIBFPy9njvOnBFEnCZb8tmUoU8rfkr6H25r3Aa9aCbOHfJHQWyQid7iE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2cXNSt80; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc7441509bdso1356865276.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492673; x=1708097473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjpWggWqe2gImspe6r0zM4lPSKIE3p0oIvITQ8y4BCk=;
        b=2cXNSt80oUSm/S040+l0BqEvQdbg0QI0W+auGaRMJofV5gSjNxfIQYPBBSPL+ZQ7qZ
         jMeOV8g+bDbcbhFmy8wcA7lotWTy0grf6Q5Ug5ckgRegzdFgZa6K06KX/jxVniTO8oB5
         2SsxlZcZECXrPXcDl4dMm2L19ytDKqsj79jEKaY8j1Tjr8sT0kdxwBnuWlWgG1YuxCq2
         uG5hI7Y4Naj44UXgn0q1RC8q8pfwRJT3L/6hqqKoRdH8S93kfTPBIl5hGutrWvLfej4e
         4eMt8anY+5DzlLHqppm6R4PdPg3ANElq1NhS6wF5VHZ9heLL+fyLkRVjmSduEC5UjDPo
         IInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492673; x=1708097473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjpWggWqe2gImspe6r0zM4lPSKIE3p0oIvITQ8y4BCk=;
        b=OrgSXKr0Wxac8TLnwxAFb/32xsW/E40MYQZ0aKC4s617pSjKz1rvaEdjjUW+x7jmYs
         EQ/UGBy/QK1tGJ64qbiwkV5htDN9hUU6qWtwBnkSXshlRMSi8v+UeIaYRIa5O1+XCKjy
         L+jWaQizTVMut+woZSMCxezwKqb5zIyW0boHuCUYLrh70iNVM58C4Byml56oonzelHg8
         nMGNnTUI3QNM0KdmujG1vnSKLtMUzO+rPtgTb7Zo2VOXz/qCnR4GLjKwuf2btm+TCJYl
         faZ4afLo1onTsNF6Hx4+uvz1cj2RrIC6+pBRdM4NSMdGXlWCeJqBmiuaZX/4VleW7fin
         sdlA==
X-Gm-Message-State: AOJu0YwwkQm61aNPy9+5CHhISk00So5V3ODtjL7tZZk2Y+9bSiW47ESa
	Em5Qa0kBVSor7TtjU/i6TPtMTPcSrX8looPn2LCbumjDqVyqwmjNRlHqsLgMLtAgYnLaSE4fexs
	vc8bs4EK1Yw==
X-Google-Smtp-Source: AGHT+IGT3Mt/723ZeQaQPgWeFzI5DaEqZCmGaH9wg5aqkr/AVwnzOPn9b2Nnl3FYLisfWh9eSGN1UAElL4YUYg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1008:b0:dc6:e20f:80cb with SMTP
 id w8-20020a056902100800b00dc6e20f80cbmr56866ybt.3.1707492673389; Fri, 09 Feb
 2024 07:31:13 -0800 (PST)
Date: Fri,  9 Feb 2024 15:31:00 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-6-edumazet@google.com>
Subject: [PATCH net-next 5/6] net: use synchronize_rcu_expedited in cleanup_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cleanup_net() is calling synchronize_rcu() right before
acquiring RTNL.

synchronize_rcu() is much slower than synchronize_rcu_expedited(),
and cleanup_net() is currently single threaded. In many workloads
we want cleanup_net() to be fast, in order to free memory and various
sysfs and procfs entries as fast as possible.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 233ec0cdd0111d5ca21c6f8a66f4c1f3fbc4657b..f0540c5575157135b1dc5dece2220f81a408fb7e 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -622,7 +622,7 @@ static void cleanup_net(struct work_struct *work)
 	 * the rcu_barrier() below isn't sufficient alone.
 	 * Also the pre_exit() and exit() methods need this barrier.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_expedited();
 
 	rtnl_lock();
 	list_for_each_entry_reverse(ops, &pernet_list, list) {
-- 
2.43.0.687.g38aa6559b0-goog


