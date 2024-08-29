Return-Path: <netdev+bounces-123333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABD9648EF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17FB1F216CE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DB1B1401;
	Thu, 29 Aug 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAqJ6Pxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0018D65D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942808; cv=none; b=WPqrVbuXDYZXo/h6aBJadG/cIjjRj6gY6UqAdghjzH5tIeHLZph3rnUTUNpXIsy6/nrDHEKYjLwR+bIrjX/eEtmDDDz9mJ2ZGlG0mFX5YcXYMYQj8ZqLdj0zxFPr8nSgdeX3f83FxzmvwmFjKJbzLWKBgE5HNR3+JqyAJVdqo1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942808; c=relaxed/simple;
	bh=jSLIez+zmerEIQdBPA6OcDSTzrcDLlqdnIMQAYqwjx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oFMY9bHvQLvUJu7+tUgSUZD3MxQ1gWPSretJHooxupgYxrxIPorAjDGii5j2yc344gS8SaKhw7B/mKTXvOigW4xnZF4nTW0aLpdS/70sz2r1vhHQNdtuLbt5QEzHwZ8PCsRUQByPD4DHiOhTRmD6KpOE7rtbozSCE1V6GrkVwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAqJ6Pxi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso1358725276.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724942806; x=1725547606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8wn7O7cFac7LddzwbykQVCocowbm+YYpFtrQeIGIqQ=;
        b=OAqJ6Pxiibqqty18xyAAG9MznR2q91N3sN63TOruyNdpHNJ1gPqkoD1dHhD5cvjMAm
         m7e1aNX3D4Dpb365y3ykOSSV9vI/6dsdJbjRa4vsTKZFUzKHPtvK9jPNv4bOolcjikbi
         fM0Cscn5GZCLtj4Qxb2SxPH0cYbWal6+T9IMwEzWLQ50z0bGn+eZfKj0QY/lDry0QRfL
         pm2mSGgCEN0xcc9l/Is+cIYsJYUy3gwOui3HvBZkmBptMGLcsaTLiR1bT8jDwcAJWPld
         wpl1k2lIFcaygfA8tnbXmBb3z7utTqnFznEiqpkH7XCeJYkAVelav1Ag3nvPWagB+pLy
         qGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942806; x=1725547606;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8wn7O7cFac7LddzwbykQVCocowbm+YYpFtrQeIGIqQ=;
        b=i1xM1KzHO4oUM54oKkhskws077sEuOXWizrz+9y8gzxUACtOpRg+0CvWBZgU041cxN
         nQVpts+7NMa53o9FSsgGLtttzx7+3L1pMlfEkgba8f6OHq4rKeEUBO2Da1YkI0FqHL/z
         W/VaCwq0v6CUjw5eGApHtbZ1a4CuQfFnrP1t7/jSGz1e5VuJ8TE61UUMVH75sM1IRCDv
         kp761OYh4ojwjipPsqZEgfq1nda51nrEBDwiSkPBtiC7bIadNWw1OcT1hvkNX47okOFC
         256T3AtD5R1JuJOllPv41F61HickBmEZmgMTD2QUrt+u/3knQG/KW/wBwHzjd6Sr0gdc
         uxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xstqrjcsrbPMxaqoqShgopCXtNH2HfqOBWdigfRdN00kuFqrHCPtIj8HZw/PA74ReR7K7/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LkMrnVl4kOEsWjEeOrdmIbugBYIw47L5+r32uOsu/LL9IFnj
	ILfCXKHZULotpvfBc1Dv5BNSitDJRiOFjeeqBolOw0jCeYWNVUH5/ZylbEgh9U7dQVBz/VDp5hO
	QRc5JoBeGrw==
X-Google-Smtp-Source: AGHT+IHBYJsout57+K8JOfkdKzUeQ9aozbtZw+/oC8Hg7DI7pm3bh974t7stGgycSuZebZM32smh0IwFpw2qSA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:81d1:0:b0:e11:7a38:8883 with SMTP id
 3f1490d57ef6-e1a5adeb455mr4411276.7.1724942805791; Thu, 29 Aug 2024 07:46:45
 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:46:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829144641.3880376-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3]  icmp: avoid possible side-channels attacks
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Keyu Man reminded us that linux ICMP rate limiting was still allowing
side-channels attacks.

Quoting the fine document [1]:

4.4 Private Source Port Scan Method
...
 We can then use the same global ICMP rate limit as a side
 channel to infer if such an ICMP message has been triggered. At
 first glance, this method can work but at a low speed of one port
 per second, due to the per-IP rate limit on ICMP messages.
 Surprisingly, after we analyze the source code of the ICMP rate
 limit implementation, we find that the global rate limit is checked
 prior to the per-IP rate limit. This means that even if the per-IP
 rate limit may eventually determine that no ICMP reply should be
 sent, a packet is still subjected to the global rate limit check and one
 token is deducted. Ironically, such a decision is consciously made
 by Linux developers to avoid invoking the expensive check of the
 per-IP rate limit [ 22], involving a search process to locate the per-IP
 data structure.
 This effectively means that the per-IP rate limit can be disre-
 garded for the purpose of our side channel based scan, as it only
 determines if the final ICMP reply is generated but has nothing to
 do with the global rate limit counter decrement. As a result, we can
 continue to use roughly the same scan method as efficient as before,
 achieving 1,000 ports per second
...

This series :

1) Changes the order of the two rate limiters to fix the issue.

2-3) Make the 'host-wide' rate limiter a per-netns one.

[1]
Link: https://dl.acm.org/doi/pdf/10.1145/3372297.3417280

v2: added kerneldoc changes for icmp_global_allow() (Simon)

Eric Dumazet (3):
  icmp: change the order of rate limits
  icmp: move icmp_global.credit and icmp_global.stamp to per netns
    storage
  icmp: icmp_msgs_per_sec and icmp_msgs_burst sysctls become per netns

 include/net/ip.h           |   5 +-
 include/net/netns/ipv4.h   |   5 +-
 net/ipv4/icmp.c            | 112 +++++++++++++++++++------------------
 net/ipv4/sysctl_net_ipv4.c |  32 +++++------
 net/ipv6/icmp.c            |  28 ++++++----
 5 files changed, 98 insertions(+), 84 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


