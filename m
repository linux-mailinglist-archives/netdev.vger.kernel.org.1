Return-Path: <netdev+bounces-91555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243AD8B3100
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4795281FC1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D713AA47;
	Fri, 26 Apr 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWYRcoaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDB14293
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114926; cv=none; b=XoKInK29pe9nykfizYSnlswal9/aPgCe4+4lVxssoq40Nk8WSeZgq1ID8qI1vMfoV8JzWGt86hmjbguUwP6Jg0dOVRJjdK4us1djcMxom/8YkybAl/jfZ+P0VxCJnLQ5hPUjWhBScdX6zYPrswxqYEcDbW5snbXa2ey+8br6o2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114926; c=relaxed/simple;
	bh=ejklLJtNsGTQblMByJB1RBK4H/XJdRFWIGvAV018c1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z31IEUPqHiMghN0pF6uUa2n5qDh+nd9KWGgqcdKQxMkLh8z0Fm3Zv0xX+Obb04WvjHENLHSEa+c2m1pk/CfeChC32vO8cjuMyU80z9K4aQroOe9L0lFwDsFOHRAVsy4Q/sy3KCF0XyCPj+X1kq8zbZr53DUXsbDrXZgo6fKhDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWYRcoaH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2635728276.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714114924; x=1714719724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xEBeY2/ZjUl5S/j3f39PheePhByHj0T/2MhT342eSsg=;
        b=pWYRcoaHZm+Blyncr2rorfkvjsdEKU0p2NgS6jGgQd0RfhvDy+q9WDFQVxya2+pZ9y
         w5KCNyLxWgEJEGbDwZAtNNUlUC1xP57UoBfS5DPV4NOYawANauWavYEJBOZMVPbQvf7H
         xx429zI45seZgaNgekppy7qbqkGKVVW+k6Wwpvb71PBjPXOOUrSAYTN+tCMfFtcCZvBJ
         o5be8KbuD4n27pGbdDPQkVJ1wRAfExIq1a0WjrNbZP8v2Xmwl6ozbZHmG3oL5q8pSozD
         HnsMaxC+pmjcKRy2BybnV4igk8D8V17+0PVxkVYLrx+XfjdIHB/+EiHxLdbI4zDeE4vA
         KedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714114924; x=1714719724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEBeY2/ZjUl5S/j3f39PheePhByHj0T/2MhT342eSsg=;
        b=rMPVZ7hlI+jYknxSfEGu9HDqLIuUlfyjyXN7CYkq0WQem6nRXZ2oXlCdQ/BbN9QsvO
         gcbFjkJDYJLOCUX7vrzquTTjpmrHIFJCpthwVYM4nd5OiN4PyqamL1DrFCfDak23JJ9x
         LDAHa1EfD5eTLEVj2RKN4gr/7tup/0/tSeCJNlwdzGVvxTXM8BEs5OB9PRGkq7FWhA6o
         vPLLg7FY2mRSbiVr5/yZZBGLxFHLt/VSNGe23e8IXyTlU5ZRfxq0KcrUKMOJzatuRD2D
         DsjCKzE0IxaIhSDU6N1/d3JP4TUr+L7NPNngobgiHVMnmgtBBjhO6QQwsu2OIT4+ayt8
         Zvmg==
X-Forwarded-Encrypted: i=1; AJvYcCWTdOiHb9afx+cHrL+0jL64YqiX8Tb/LVFwg19Azu5Zq9ebcRi8y1CsGv7WpwexnB1atn5PN3Cj3WC1DlfBsXPPqcFjIA4L
X-Gm-Message-State: AOJu0Yy10e0Y8OakQIpEv6cUF/jrFrkr8EP33M2umotnU1reCTxNW9n2
	S/R8nzZ3vo5aQ83daHs6YDrNw78vcF1TmgM2eQWifxA2Zl7YFdwqfZ6KJYFmv1ZvuNZ0N+aiD80
	hzgcDGDXvAg==
X-Google-Smtp-Source: AGHT+IFSGFfkVrSbxT93v+zEhEHWBQqcw7UNcC4FvdT2r4tUoNVkctRpoMQqDPIxfD1PSRizIQsVDUF4e73NnQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1505:b0:dd9:2a64:e98a with SMTP
 id q5-20020a056902150500b00dd92a64e98amr188431ybu.9.1714114923994; Fri, 26
 Apr 2024 00:02:03 -0700 (PDT)
Date: Fri, 26 Apr 2024 07:02:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426070202.1267739-1-edumazet@google.com>
Subject: [PATCH net-next] inet: use call_rcu_hurry() in inet_free_ifa()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit c4e86b4363ac ("net: add two more
call_rcu_hurry()")

Our reference to ifa->ifa_dev must be freed ASAP
to release the reference to the netdev the same way.

inet_rcu_free_ifa()

	in_dev_put()
	 -> in_dev_finish_destroy()
	   -> netdev_put()

This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7592f242336b7fdf67e79dbd75407cf03e841cfc..364dbf0cd9bf2f6e96a221317c88dad965209659 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -224,6 +224,7 @@ static struct in_ifaddr *inet_alloc_ifa(void)
 static void inet_rcu_free_ifa(struct rcu_head *head)
 {
 	struct in_ifaddr *ifa = container_of(head, struct in_ifaddr, rcu_head);
+
 	if (ifa->ifa_dev)
 		in_dev_put(ifa->ifa_dev);
 	kfree(ifa);
@@ -231,7 +232,11 @@ static void inet_rcu_free_ifa(struct rcu_head *head)
 
 static void inet_free_ifa(struct in_ifaddr *ifa)
 {
-	call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
+	/* Our reference to ifa->ifa_dev must be freed ASAP
+	 * to release the reference to the netdev the same way.
+	 * in_dev_put() -> in_dev_finish_destroy() -> netdev_put()
+	 */
+	call_rcu_hurry(&ifa->rcu_head, inet_rcu_free_ifa);
 }
 
 static void in_dev_free_rcu(struct rcu_head *head)
-- 
2.44.0.769.g3c40516874-goog


