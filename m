Return-Path: <netdev+bounces-91665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2C8B35FC
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACD71C21D18
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FF144D07;
	Fri, 26 Apr 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSDM6goI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E0143C67
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128446; cv=none; b=RLTpc6Fd07TYj0DnR+VscKMAdrSoeHqOVFmqW5yk/HON6foVwe5HM+xOkDjR4KwmPPjBTwBKsn4dcZIaDamqJc8di06aBEy9tedYx/9WFW9mCsgIHddI/I+66P6TZbuVWQwNpVDbEXYWJCg5DzI0ConTk4ib6C/AJkM8/QUa4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128446; c=relaxed/simple;
	bh=+x0TTtbTFeSJ2aAxUwYEVz0P7kHhxwjxBr8tm/4D7l8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qKIXAp6ryH6vVuA2y+EHrGT/M40dH7yPpv9ANpyCihOhVbPpcvHdI+RDHgtt1HAM+RPZEXzfDB/PbaWvXe8VCiK+Cu0e5i0K7GkWwifekZpGh/5dePEu5Ukle/wmBu0gC9ex6xGbhVk+im2QEByv7nWOBwn+RrKfWUvv2JMZDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSDM6goI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so4028370276.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714128444; x=1714733244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiQEHuFKsDoR6yUT/ZR7h/b7KsBRa5O03elx5Ss59/8=;
        b=lSDM6goIdlK/lhb1j9CuT7qKK0iyF/bohEuwkGNd2c7hq+oFAEmZFzrft1y5ybslZU
         oGTL7vcT+/2beE4lHBMDsWVaTvK0l25SchTt99WFncAAEtdH+yhpAWeIpPXhfJLuUJBs
         R6qctnmFGR9TkH7TyZAyLPhdYtqBecEbcYPoU5yQRc3iSW5XWH5l0yFQZa0y/j1L9NxB
         qriHae4kp+wI1feSEnvmoQCrX8ZnIk8AvcmfuHOUA6QHzLse5yQAQC/y40rZonl82RL7
         tPDtSviXN4kz8TcDN2J60WYanXk8UqbguiA7KxO0av1iXQPBzRzzOXzS9FrAcCEP1fqj
         dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128444; x=1714733244;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiQEHuFKsDoR6yUT/ZR7h/b7KsBRa5O03elx5Ss59/8=;
        b=FfW0aUG1YROj93O5o52v1WAx/Py0bGxYbFLojhNLhE3NlfWW1sfeBPVFc/CxfR91Ca
         toERYm5gkqyPDVIaC0dRr+u+gDLtGYoO1u50cjb3USfRiRbCWX1kM36isqfZK05OfDNc
         KuFDY/qXFFSCZI/d6rO5XmPyzZ58Li7DQ2hx0syfy4DcN/4V3ZW7hz1/6vFqI2LRWcVe
         yoPDm/vlBxlndI/l6TK3lc0McPStHXE6enBOoUu9OLGWGvmSJ9lJjYH33ooWuJIf5xxv
         FpXQ191mGRAUmcNUAqYnCRjKlRb4L9L6R7alaLFNrzq9mi4G5Wr8jIfHn6MNMbUvdATp
         +HhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwj9NcR3Sc2ZlT5mCUKKiH+Gw5dkXhj2maSbv+JyHGR5D/6xqsuwQRfNT43anFI9cDyawumM6kMmOPXlaI7IxVsH/8vFJZ
X-Gm-Message-State: AOJu0YyptVD7z5Mq05XhkP14/fDYIagM2GqxWnNRxY05APuMpfBIW3nt
	KUz2O7mtCoMVPf4as0mLl8aOzJ8zj+N9haYR326oGIHOcUhLedPUScPk04awZ5+X+fPSSN/rekM
	U/tZuBhclWQ==
X-Google-Smtp-Source: AGHT+IF8QA+/3tE/pxZg8EZKZAzXTv5nvfnC6IQBOI6BTX/2MDZsFzfnZJdhYRfRekW7kMO6CjIba3Qcb7dtpQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8e04:0:b0:de5:a68a:d757 with SMTP id
 p4-20020a258e04000000b00de5a68ad757mr406995ybl.3.1714128444400; Fri, 26 Apr
 2024 03:47:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:47:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426104722.1612331-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: use call_rcu_hurry() in fib6_info_release()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit c4e86b4363ac ("net: add two more
call_rcu_hurry()")

fib6_info_destroy_rcu() is calling nexthop_put() or fib6_nh_release()

We must not delay it too much or risk unregister_netdevice/ref_tracker
traces because references to netdev are not released in time.

This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip6_fib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 323c94f1845b9e3eed52a2a19a4871cf8174d9c2..7834f7f29d3c9323e753be9e46499784a619de1b 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -338,7 +338,7 @@ static inline void fib6_info_release(struct fib6_info *f6i)
 {
 	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
 		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
-		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
+		call_rcu_hurry(&f6i->rcu, fib6_info_destroy_rcu);
 	}
 }
 
-- 
2.44.0.769.g3c40516874-goog


