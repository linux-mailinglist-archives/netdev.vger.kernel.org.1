Return-Path: <netdev+bounces-71629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283885443E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7416428D08E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB317494;
	Wed, 14 Feb 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0eRummk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D18B64A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900517; cv=none; b=YIGdn/BQNzDMA/EXRoo59Lcs9MN2Mh0RV3xlev2uAyz8P9USAzFdlRrTpM6prfC+vuRAXwGYorSdnfq27MAZGxyNp0+1SjWlnonsjdz5S3O2DPuRapDREo9myWjojblyU1QEvJQt6KNqQVQ/TMSLQ3BiQPcOKog/t9Gh+yMHBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900517; c=relaxed/simple;
	bh=qi5Bs7Cf2a/XS99tp48PJPpELPUcFcpZoHc9zokTEC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UhPbeYRfc6JnZ12pGjsMtz0g0MZ4HqkDtUMsjQOfO2LnR76F9/E/BW9NXYKtA0QaTQwBdWhHUJaKt/B0dsy0FJHZMeDMPH1eiP91WQ34ZhWpH8rFI1OYi995qQYlesjiNxYKazWJbyZR2da0eyPJYYkUxz2p61Vh5T+5vqNZIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0eRummk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso118116377b3.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707900515; x=1708505315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgH6jFYJlZcCO1muBwFlEgXGTqXSIAVOsixhgGigIv4=;
        b=Z0eRummkMIUk2E9fnjJZQdU8B79u2qa/JnVHPOhX4Qehn04035XMfLPxHE0hQgeGzq
         tTQi0UZfPFR9+kEM70ivoty+G6oh6RG1iGTzIxXOd1IPe8/KjBnvcVrSaGtNbChUr/FE
         90Iud7KZX586YdIUFMmOPrv3e8NNYf26LnXBmPyGm/Lksu09nIH9JFtq2WQYlzDCAyCW
         8N2x1IeU3H/igMm+hcbs02EDF314naiAo7OKSI1SV+XgUEOM1ZcCEm6hwBlUGt6Sh5UE
         iZB1EvB4i5H3rF/5h8y/ckxrMCO0SDVPgGfx6+04wLYlTpEIRzUkaLareE6fv6OuSoa0
         Pw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900515; x=1708505315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgH6jFYJlZcCO1muBwFlEgXGTqXSIAVOsixhgGigIv4=;
        b=qnthdHRD0MCNVQGCUU0c8hXPt9OOccn2HuGPpHDVGwy9iBqG4pNVx2rTivPKV3JwNJ
         ptEoNhERwkkwo+/Yjug91nwJXEVBqVBXB3vZ/W8drBZuDIsKQOj2VssKR2+3jakcONCz
         BhccNcU7Vul6nv8v4JeV/ZSQBy24DnAYec4eFl4FK5gT1aaMwMwgAXbptC23/0F04Tdj
         CRZAlLdxniTwpevTIcgwG4ylek7KD8nd5AkjfwSgChyNTECCNYoEQUzvmv+SZl9O9CZj
         O41ud0delalPS0KiQfyZAatMGOqTKZzWcRd3ATiT/6okk/33rPuLBf6u66MtXGeJMOeL
         FQHA==
X-Forwarded-Encrypted: i=1; AJvYcCVUaH9CyIImGRhvu3UwzhoP3Osq0OABhpjT8DLLE/zXF5h0f2mGUOh4wfpiAE09BNwMypt844snNfG57WlhpU3ybBBMXdyv
X-Gm-Message-State: AOJu0Yx8FPBEplwMyobM9INExaodym94IjX9TDFiu42a6YL8yGzlMIeu
	dscYkRc/z+LijyPU6p0lxPmLohfnI12FmbuXIghJjBpfIr8QQiYrP/n9Yp+jBAT+AYXjvNYMcYr
	e0vLarumCjA==
X-Google-Smtp-Source: AGHT+IELTMuQWEVV+IdSL9R1xizsS+OgXyKRcKJaDe+k6pK9UnxJHdzgSNBBRhcMXnwspNDYDODWTVgTed52oA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:70b:b0:dc6:dfd9:d431 with SMTP
 id k11-20020a056902070b00b00dc6dfd9d431mr391163ybt.1.1707900515291; Wed, 14
 Feb 2024 00:48:35 -0800 (PST)
Date: Wed, 14 Feb 2024 08:48:29 +0000
In-Reply-To: <20240214084829.684541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214084829.684541-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214084829.684541-3-edumazet@google.com>
Subject: [PATCH 2/2] kobject: reduce uevent_sock_mutex scope
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit a3498436b3a0 ("netns: restrict uevents")

- uevent_sock_mutex no longer protects uevent_seqnum thanks
  to prior patch in the series.

- uevent_net_broadcast() can run without holding uevent_sock_mutex.

- Instead of grabbing uevent_sock_mutex before calling
  kobject_uevent_net_broadcast(), we can move the
  mutex_lock(&uevent_sock_mutex) to the place we iterate over
  uevent_sock_list : uevent_net_broadcast_untagged().

After this patch, typical netdevice creations and destructions
calling uevent_net_broadcast_tagged() no longer need to acquire
uevent_sock_mutex.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>
---
 lib/kobject_uevent.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 9cb1a7fdaeba4fc5c698fbe84f359fb305345be1..03b427e2707e357ab12abeb9da234432c4bc0fb3 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -42,10 +42,9 @@ struct uevent_sock {
 
 #ifdef CONFIG_NET
 static LIST_HEAD(uevent_sock_list);
-#endif
-
 /* This lock protects uevent_sock_list */
 static DEFINE_MUTEX(uevent_sock_mutex);
+#endif
 
 /* the strings here must match the enum in include/linux/kobject.h */
 static const char *kobject_actions[] = {
@@ -315,6 +314,7 @@ static int uevent_net_broadcast_untagged(struct kobj_uevent_env *env,
 	int retval = 0;
 
 	/* send netlink message */
+	mutex_lock(&uevent_sock_mutex);
 	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
 		struct sock *uevent_sock = ue_sk->sk;
 
@@ -334,6 +334,7 @@ static int uevent_net_broadcast_untagged(struct kobj_uevent_env *env,
 		if (retval == -ENOBUFS || retval == -ESRCH)
 			retval = 0;
 	}
+	mutex_unlock(&uevent_sock_mutex);
 	consume_skb(skb);
 
 	return retval;
@@ -589,10 +590,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	if (retval)
 		goto exit;
 
-	mutex_lock(&uevent_sock_mutex);
 	retval = kobject_uevent_net_broadcast(kobj, env, action_string,
 					      devpath);
-	mutex_unlock(&uevent_sock_mutex);
 
 #ifdef CONFIG_UEVENT_HELPER
 	/* call uevent_helper, usually only enabled during early boot */
@@ -743,9 +742,7 @@ static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EPERM;
 	}
 
-	mutex_lock(&uevent_sock_mutex);
 	ret = uevent_net_broadcast(net->uevent_sock->sk, skb, extack);
-	mutex_unlock(&uevent_sock_mutex);
 
 	return ret;
 }
-- 
2.43.0.687.g38aa6559b0-goog


