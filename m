Return-Path: <netdev+bounces-75743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF01786B0EE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E34282969
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFC15697B;
	Wed, 28 Feb 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u73Oylkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED33151CCE
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128489; cv=none; b=AAGtrRy+MoygXTt8N6BrRgoTsvdOPXfBF8rtfpmtWXyeRwW91GOFSF5WdS8Myx5d5g3eUZctViSZEA41/X3FM9q+GKTAujZCja53k3V5jZH3YLPSjpgNKakEtMck/ogjR9149BlfUH+75gx9DfWxLVv4D6OwL4CN9ocZqqDmwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128489; c=relaxed/simple;
	bh=91soUPvOOzq4xldWAfV/U6pdkQlpdyHqmLksGJvHONI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kgnB5HoH+M9LSShpvQH/PQ8Yob+y8+KnnnAe+wJKpZyuMIggi2gZSFnswa9gK6g8PV5McZdIxNOgOnkkyQLmAUsi0FyVkDNRyMnBujXm9tH0lAlYpwxN9lGn0OVl1o2+j1sic5pv6QToSCnPfuHrtGoqPT2uFkDNY3Kikndv880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u73Oylkx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e88ca078so55622737b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128487; x=1709733287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1W1+/hYZA4R/xgfoHbrrNnSXBXPqK//ZxmcYEZfFWQU=;
        b=u73OylkxuGhJYuSvALGVUPLhoCry8BZlKpURKgOKSdUtH7R6w4Att+ZRL7fJKL8Vvh
         VdcVfu/feHS6m0RKuhXqQAA6gqtvSf8BqHQJH2ftsswK6Wax/Ec9zGZdfaN8QWFXCxGQ
         7Y8FghumrH6skPNf43un/9yDIBgEY/JiaWidH27nBGHFl4E+6ioDb13RpfmHZlOWYXcA
         VD6QN+20FGr9C1UXpt6JxlsM1cP55nIHgkXm5J+VaroK+NUunVMTYq2+8Ackh2RlQSET
         KLNOSrq9zhO+T8jppwsj8yuVYgD1gCxIQYpIafv9jjrI/tYJK6zUWwHr6tnmxgWm0Ui3
         L5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128487; x=1709733287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1W1+/hYZA4R/xgfoHbrrNnSXBXPqK//ZxmcYEZfFWQU=;
        b=EDjBHt1PfSLFyQwtk8qVmbsplgvEO/lcWYEGsOKFOipfWaQ9RunmtMi0avdsbxB0Kz
         04yYU0QIEGmef0jnBKUz1keNRC31MmQ5mDlqzDk3dTU/SzcYYraFUqtOs4ZYrTTXwkk1
         4FIzITNtiTxl8nVzLniHAqRqSPtUJr6Rfnd/WOzhLwG1xQC55gs4/1lD3YPugc2tg2lA
         5aX+6ovz/Ow4zAou70AGQ6PYcWhauj6kglymEbdwicxRCSCnY6gDJaEHjF1Q6rhAVKrJ
         iSkD5XCbLIHVEu1Z9DKa4xLQpm25oM2XCkwOXnGWGKBA40PtLHlhP5AzKLqKff4dLDAe
         JEkw==
X-Gm-Message-State: AOJu0YxyaedYg3Zhw6jBbJTA3WdqRpoDELjt1W55uSJdg6fwKPixHwcA
	Rt7feWuU/h71NBv2NLPGO1gmODVieLFhnWxmrCz/3cc/5xreZDP8ze2ehtBQq6I8rauj8zQdf7G
	xLCKorSR8Mg==
X-Google-Smtp-Source: AGHT+IFhwptjYoG9LwH/IyVNlB3dmHEAe6ndc+qHvhw/i3eXjRMQKNgcMmxjOQ6tPQWSISG3j66sBA5v0xg8Xg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100a:b0:dc7:53a0:83ad with SMTP
 id w10-20020a056902100a00b00dc753a083admr715157ybt.5.1709128487086; Wed, 28
 Feb 2024 05:54:47 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:27 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/15] ipv6: addrconf_disable_ipv6() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing over /proc/sys/net/ipv6/conf/default/disable_ipv6
does not need to hold RTNL.

v3: remove a wrong change (Jakub Kicinski feedback)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9c1d141a9a343b45225658ce75f23893ff6c7426..9a5182a12bfd7719fa6d5f0537835e0f0bf37686 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6398,21 +6398,20 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 
 static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 {
-	struct net *net;
+	struct net *net = (struct net *)table->extra2;
 	int old;
 
+	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
+		WRITE_ONCE(*p, newf);
+		return 0;
+	}
+
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	net = (struct net *)table->extra2;
 	old = *p;
 	WRITE_ONCE(*p, newf);
 
-	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
-		rtnl_unlock();
-		return 0;
-	}
-
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
 		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
-- 
2.44.0.rc1.240.g4c46232300-goog


