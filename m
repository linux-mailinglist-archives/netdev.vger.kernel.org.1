Return-Path: <netdev+bounces-71183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C84852907
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFBA2843C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6FD17738;
	Tue, 13 Feb 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9Wk6z8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DF17758
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805984; cv=none; b=QwSsO5EM+bAWtMLNNrWmffwqYxTJZ4dQdYai6fb3lzIfRZJ4RTe+vyCjCxXtEdlv5bOWlec5yrspiTOywkaQaVvJiwmGwIKjZkMUFrKkQP+k8pSmwow5/IcA8ajLxSNVI50SqAk/8LPC76IWjaRpBXHt4Ji6bXGyq3gLZwPxq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805984; c=relaxed/simple;
	bh=agQBBe3gGEuUVQmqiN2/BV7cXJovu98w3yyooCl1rCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnPPVEwyh3FXJuq37d/T7eCvGzZnIQ/f+jIST6eDj1Z1jfq2oicnYf6d/m6cZuhCFASkEbO/gduAPdNXwgFLVwubWW8yoXq+6n9h+yf/QjZWXlUVAq3XcwEQyJIoH6+nQ5Ch7vTSW6m/3i1GtR8kIjsQTHN6AeSAnJTRXgCpUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9Wk6z8l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so963020276.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805982; x=1708410782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHXOpWBVrruiE3l6dQqMCwanEDTCE2ZLCZC+dweAjwk=;
        b=P9Wk6z8lWLg57Nxhi6xH0lJuOV6apyssNaZ6aHHGuC0W3/Dq8dvrsGL0xjHACn4ZuD
         WBI+Ku3Grqdd4Jpb+ndIiSJXmv0S3VeEpUa+RNScY7QLaUYyyF1XkIvzLPMZuLXxbqI7
         19ngLwLpoOqsg3hWuyR2hrlqxxC2TfDRYtMCcHTqeu+2N18ZXVx98rQlCvx85TEUW2qg
         6ac9YArLavTIZ53nV4mRRzjehVFoaqMa3xIiQ8iAnBbzjtp/UmeqgYLJPlVvUohVueod
         fEdY+iCYjAQoGWQF8F2B0Z6Qos31m8/eNl4bqgA8mLLYOInIjkdCEAB8cqOnJdM4+sx6
         U4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805982; x=1708410782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHXOpWBVrruiE3l6dQqMCwanEDTCE2ZLCZC+dweAjwk=;
        b=q8qYiFNxTwLwAxTrPUP0hyjdsZlqjigif++Vrio/rM9pZC44HEcX5WDmXGIdpihBOR
         urx/cnWrY2bQS5AxI6Jr9STbTJvXfBn05MpxzPAW6O5dsfNLP562VBSihH4CYCJkOmq3
         6IH2xqPJG/1wM6k/lh9tKtr4b37uxIeuUDIHhnVUQmggNhGAdAM6bxCZEwz0iX/uXMiG
         dwcZuYcwKZvdebzGJ85uA2lMvZbBj0ukk2uwYatX56gw5xyX7IO+6jDZNgpFC9gSwv5k
         3ALy5/zr5/0Nm7yukAf7GQSHT1xI8OHa+DXVHTuEQ2nsB0LhJrUNVBQk9mXe1PhJBFCY
         z8HA==
X-Gm-Message-State: AOJu0YwKqRy6HsLespdsrKHom8EuZXjl8skEUhQhG9dwD5YT/OE9eLui
	28opnYr36Jx7ttLHBkOzcMlcx/gIr/O0jLOSA5E5tLpDFEQ41yf0bu1hoYhW7NS+BK5Ug4gDG+X
	gMmqwuC0j4w==
X-Google-Smtp-Source: AGHT+IHSIjDoqINqZN3QIGW1L7Y5FAncufS08WMI/kn63a+rvMzL3miYi+Jwgdvm/xqj1Hm5btpi4n7C3g7HyA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:124a:b0:dbe:d0a9:2be8 with SMTP
 id t10-20020a056902124a00b00dbed0a92be8mr325735ybu.0.1707805982006; Mon, 12
 Feb 2024 22:33:02 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:40 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-9-edumazet@google.com>
Subject: [PATCH v4 net-next 08/13] net-sysfs: convert netstat_show() to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_get_stats() can be called from RCU, there is no need
to acquire dev_base_lock.

Change dev_isalive() comment to reflect we no longer use
dev_base_lock from net/core/net-sysfs.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c5d164b8c6bfb53793f8422063c6281d6339b36e..946caefdd9599f631a73487e950305c978f8bc66 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -34,7 +34,7 @@ static const char fmt_dec[] = "%d\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
-/* Caller holds RTNL, RCU or dev_base_lock */
+/* Caller holds RTNL or RCU */
 static inline int dev_isalive(const struct net_device *dev)
 {
 	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
@@ -685,14 +685,14 @@ static ssize_t netstat_show(const struct device *d,
 	WARN_ON(offset > sizeof(struct rtnl_link_stats64) ||
 		offset % sizeof(u64) != 0);
 
-	read_lock(&dev_base_lock);
+	rcu_read_lock();
 	if (dev_isalive(dev)) {
 		struct rtnl_link_stats64 temp;
 		const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
 
 		ret = sysfs_emit(buf, fmt_u64, *(u64 *)(((u8 *)stats) + offset));
 	}
-	read_unlock(&dev_base_lock);
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


