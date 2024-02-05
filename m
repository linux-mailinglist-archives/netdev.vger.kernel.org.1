Return-Path: <netdev+bounces-69129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5D849B0C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C179F1F2646E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6AD48CC5;
	Mon,  5 Feb 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGC60rRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61D2E63C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137298; cv=none; b=AJ9IeXY2QF2XHJrf/VgFLT3MF/PoF+NHqSnT0ZVPWm3SvB3oOY6bma6W+lgZLnoNE8eX/P+jd3JC7vd4TV+V1wQBG+kuU32j8HDiCeRIKLuKABZVu176hlzC/jn6qIXHJ/6J8ZMt4UK4oX0gJ8aTR3/P8G5XTEAtG+jXuWqw9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137298; c=relaxed/simple;
	bh=JMN+6+qy7+2YBgl8bpl2o9VZJSrVMjIkLeNGM71Q5u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HG3aowDrRkbI1Vds4pZ5kX+ond0CB+siuh/bIk+eJKxAIGgCAOViDtQLmYY7doIucMtdm6vxffgJhhO5mwN9lnEPwinuNEi7VZkj/49uqZYhfwl+ci0INqUHFbB4wwmmHHUVBfkhnA8Yje9ejSInKyY4hWRuikjueg0aJylprmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGC60rRY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bea4c8b9so6315084276.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137296; x=1707742096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=nGC60rRYr5wmRS6bFMsPujoJto3WwPirLqftFWRDfOdMTLhrM83TdSetktXJpn0c46
         zKYv20aCgIZqNw1pAqv7Mq9bNoFSds+p9gsOx/+xV+JFAq6Zksnz/4tDUsBltNnX4w1M
         QFLRiJUQj30MHN/HNbwWSi30NUb/uqJyTA7SiZ8nuspJHDzDUrzW/wH3gQMBxZxXuTAl
         Q8ka5bV5jx4IQBwMaAQtEwoD+LO6eSKOzAdlJ5H4OpyjkRswuGe+oeFQvZE3ahIXqhHH
         roGfhZhYcLipkSfNwZN7gd7FkYVLzEC5azBscBYzuSZmTju6HM667sn2F9OcgUahPut8
         e/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137296; x=1707742096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=El6Fa6u5oOmqy5t0Tn2fhQqAxjo1OzhnHK9JXEi2+gO9qV1sLjycVWjXXQXXU0Y5Eg
         vs8clgdrtuYhxyAS1AJsf0pH5fhUYKCd8zvqfN+GErqDwEmPGI8B8qb6X3DEyO+rSCmo
         UJcrqhsyfGG7ZwHX9x3gJV4chAZrpQQO8dEdu2kyAfqS/GgSFG45KCAngYe3/X8T4WRE
         FkVj+pkhcA7vUv+Inyek4L0/NBjWI8N+vje0REyifPpI8Rbh9xNcHXEu4UNyea7ohBMA
         sQc10fG7RhozzYBka1C0vLnboTag90ULnm/eI/lWaiKOoRSbSCx3Tx5YQIyP9s2zNCor
         94Vw==
X-Gm-Message-State: AOJu0YxdK1vfjrb/DFr0HsNEFpwLIjNeBsQi0EJx1+7A+emKNbE42pyD
	eDgmXhrpS7XfN1XPxn8co1QQsFJIOe/HALovEg7L4o4ixyCf4KmEiR1prcwVdV5I9gtjreiSMLC
	+DV2ssiAKaQ==
X-Google-Smtp-Source: AGHT+IGHxTlQabdB9VxaeiU9/OZLaQI6umRdHRq5fsskchDMII+K+IzZ9DCO1TCsUvz+tMZ793IR1//PyYbriw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e0e:b0:dbe:32b0:9250 with SMTP
 id df14-20020a0569020e0e00b00dbe32b09250mr472646ybb.0.1707137296004; Mon, 05
 Feb 2024 04:48:16 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:48 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/15] ip6_vti: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e550240c85e1c9f2fe2b835e903de28e1f08b3bc..cfe1b1ad4d85d303597784d5eeb3077383978d95 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1174,24 +1174,22 @@ static int __net_init vti6_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit vti6_exit_batch_net(struct list_head *net_list)
+static void __net_exit vti6_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
 	struct vti6_net *ip6n;
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		ip6n = net_generic(net, vti6_net_id);
-		vti6_destroy_tunnels(ip6n, &list);
+		vti6_destroy_tunnels(ip6n, dev_to_kill);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations vti6_net_ops = {
 	.init = vti6_init_net,
-	.exit_batch = vti6_exit_batch_net,
+	.exit_batch_rtnl = vti6_exit_batch_rtnl,
 	.id   = &vti6_net_id,
 	.size = sizeof(struct vti6_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


