Return-Path: <netdev+bounces-103586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC0908B9E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37B51F22494
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EE19645D;
	Fri, 14 Jun 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF+S4Snd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA87E574
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367959; cv=none; b=JZAGFylMsyc8MhfIQSUblvGoU44OC9nRPaPleW1uk/gJNdez4OvAAVaFx6Jn25kaYaW6axQp2oPuF5WqyXLqPxBAFrlAB43C4Emb5PpnWVsZf6NO544nDackxBJcDdgM/GK542QJ3foMNX5NnX6vUYrOIHw10UwbpwlPg+LRWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367959; c=relaxed/simple;
	bh=zBo3bqGgm0RaQpbXbGk/SOlHxp85cTcylTQkETcy/5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DlM6wkypXzKjy3QeEIfBoswUThpg3/Kj73GCgHmhmzRdDwGlaxm59wAVtT54SHyY0Z3fUhxX/8JEGuLzmqHb7NNISK3EzCan7ISdBpCv4lx7iTFyeRqCKJL8o/5A3guIUoDro0tYIPX7lWrXfiET2sWyxKGcLVq/S3KlamKqSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF+S4Snd; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254764f5472so1044793fac.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718367957; x=1718972757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAy5wXZs+dYylYNG1ljfbw7tOjvppqMYxPO7nJLvPh0=;
        b=eF+S4SndSg3oc5ZtC6Aoxvsm7bjWDJb3lkOcQqbhFpzlE4AzI77FuAQAY0FOdGSp8y
         GiWl201hfNyuStMZcRbvNp6mVhxK9DZ7CWVVIE8KOEoiMPwnAewtV5SqZwpk9Qm/9IG7
         Rr2+7pJlkmTcthkgznpSHzls/RAmy0D++p5yPHAwsd/ZJkbWXclUzb/55eBy27K14RRH
         J0x9bjzIeC9cnaGm4pf/dc4RxRIFRQLVk2z95ERs+VVGfMaLFEJcZ0hZ6F337wK9j1bM
         nGQpng5pf35MFOJV+4wPmp05odr65ke/nXrSDuS4DubXzVkJMGSdC1yoZtS9rQVfurMR
         bkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367957; x=1718972757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAy5wXZs+dYylYNG1ljfbw7tOjvppqMYxPO7nJLvPh0=;
        b=biGb3/lV9UYowQKNkmQ2+eXWyQ7tbGVcG+lcEPEmuAi2i8vuIku8j2EkanxRDAJleM
         /n2bF4dHyz4Xf/ijxKqlbq8Cf6xSwfKUOcGn2WdKxaz+xPhtEmXVc0FgkNcP/5S7ACCv
         1XE8hM6kxtSLxncbuGtLWPWk+nxdQEnrQkvxpM+0MOchrmOXvrOtpcvxosyu+KD/Nw5/
         InEc7ptbJMVaWSYGWsyMNGUht7f+093OTZCrW0kKzRIExysBZRh6ntOXAheoTwKfbepi
         TbLWli1feUngZKQB5Wqzun03DEKEbVt+Utc/sNG29hZ/A0oIjXzFTn4exSmP7c5+6GFR
         d0AQ==
X-Gm-Message-State: AOJu0YxHtcfBo1/Gsf8uMfjt9IkcdLw4N6BkrS4+YvXWjbZ6pcYqoQra
	5BuNszpUcYBMgdAnauDpqJGd9OY8Uy4Pm5oR3TipF+ddk+fcCK3ZHZ4ChZEA
X-Google-Smtp-Source: AGHT+IGNVnWKbnzQhLSexOHjxsTOJvky96CNIncBPshhq7QUmW4cz8Hjpp3Ya8WzwfCmEXbpVs3oHQ==
X-Received: by 2002:a05:6870:1488:b0:254:8e90:2d19 with SMTP id 586e51a60fabf-2584288bdb7mr2596998fac.4.1718367956672;
        Fri, 14 Jun 2024 05:25:56 -0700 (PDT)
Received: from willemb.c.googlers.com.com (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4f1e26sm15569071cf.23.2024.06.14.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:25:56 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	tom@herbertland.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Fri, 14 Jun 2024 08:25:18 -0400
Message-ID: <20240614122552.1649044-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
not known or does not have a GRO handler.

Such a packet is easily constructed. Syzbot generates them and sets
off this warning.

Remove the warning as it is expected and not actionable.

The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
proto callbacks").

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/fou_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index a8494f796dca..0abbc413e0fe 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -433,7 +433,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.45.2.627.g7a2c4fd464-goog


