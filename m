Return-Path: <netdev+bounces-228806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C2BD3F33
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FF41885B33
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01E30C612;
	Mon, 13 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X13y11mE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3213314D11
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367261; cv=none; b=s4chwnDlnhZ4rDnkMiLc+eMW/BsVkcNNdEKpccvyPfivyfPfOVktIbrGQbhkQHNUsSMWW5oKfvL8UuwQrhgwdRPBiyR1/HrGDC+xnaiZ5xOgeIwKnTbOEUWNihH1xJAfG1SloL9RF+W7mcdlmxL2aX+ZJ/cPjQq42xcGxAK6mBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367261; c=relaxed/simple;
	bh=7hDjwzjDX2B2/zfaoj9c5k8hNIOZiZRXFc+Xz9l8VaE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hTvqdQvJbKB2clb+ByPNnPgin2aW4efTqo0kFEp5Y+FbTzT9U2yEnw+nwiLQ77YIYvjWPUG5e0dYN8GJwBawI8WO2K4gqKl3Iy+fe1q9hjOWUrkBKPhTbPJGhyv11IY9B8ORGxdI/M6X0j4DykdrdaGVy92rcpt2dMJrQchA8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X13y11mE; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-86df46fa013so2865582385a.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367259; x=1760972059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yq9Lvl/uTobAz7tiEE6ppUq8K1CHU6Z7Speh05IsVJ4=;
        b=X13y11mEnecB031ZGOHFFAOSrdfp2e0Rcb8j4KPkv/RompVw9M2nsknlde4NnbrAjV
         Peava2iM5PeGBKgBIXzME1f+cIC+kdzm4Vkw4Ih1T8JJETIm9uBqUFp0Wi1iloHGC2UC
         OA5B+DWdCA9ejoIcFedLsr3ZL9+BKCnHChnM8tNifSnc1cdiLweXPfQSBeji/DCI0gNG
         WNisJ+mQLmo3lmY/KJyZ5+bVTtb5eFIMnWGDDRm8klVmqANCnj5Bb2E3n76RPG0I9W2z
         zse3z6ABWlunPdgu6dLyJv2b2LYAJyGDwmJLyImoNijRVefUGG1dATIZZ82b+FKm/mxF
         0KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367259; x=1760972059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yq9Lvl/uTobAz7tiEE6ppUq8K1CHU6Z7Speh05IsVJ4=;
        b=onQ5NCyydgGH9OSKL0Xy9bnSX2ghz4UDs0tM+QA2iUEu4tmvysavofRZhrsdbI8Lok
         FsUD/DrgQoEsqf4QigwI4s1ReflqA2K15QDEeMr3HDYNSleiV9Ds9RBd6joUTf/rrG2o
         Xfpym0YND63uKprzzp+RxsW2KBy8iyiRVh60R50GLc1ENOyYIcfIBY9mJA+ogADG8D7E
         IpE1npKBysKYXRZLwkoczFqxOPBEuz4kJt7iJdgABIzm1Y5qqqvCTY/SpbmSlC/EVjH8
         fQUEkLYguMY0qUifItUuwSCnoMZQJdpEpDfM3PnVmwWaDPWZr1bBPu7McENUBRR92WUk
         gGZg==
X-Forwarded-Encrypted: i=1; AJvYcCXQwsAtPz/D+AHBTCuuqYdGVk+E3IPaipMoaG+dQssQyEAjoSBjDwKhwzM3QyNW1CGxtRj32rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeveI+USgy91Ggw3+x0W6qJZKJn8sm456UleJ8g6geqS9GI7ir
	GENLGa08Eek8Q0ig5tjX48VJ8cm8ZkQQeOnPUtcrv6PTNiyquMG+NN8HqzjwF/SVJVstJ3IxD6e
	Hj0oTpxk+z8rTfQ==
X-Google-Smtp-Source: AGHT+IFpJprL9hJrxJAPpXQgxVt7EJ8HVERqaOl5F3hidazMZjXi+Tc0Tl+4bV7skitxXVqtuIYtYhAHvhdHvQ==
X-Received: from qtoy13.prod.google.com ([2002:ac8:708d:0:b0:4d1:8606:ab42])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:198b:b0:4d4:a43d:317f with SMTP id d75a77b69052e-4e6ead69576mr297672661cf.73.1760367258796;
 Mon, 13 Oct 2025 07:54:18 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-1-edumazet@google.com>
Subject: [PATCH v1 net-next 0/5] net: optimize TX throughput and efficiency
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In this series, I replace the busylock spinlock we have in
__dev_queue_xmit() and use lockless list (llist) to reduce
spinlock contention to the minimum.

Idea is that only one cpu might spin on the qdisc spinlock,
while others simply add their skb in the llist.

After this series, we get a 300 % (4x) improvement on heavy TX workloads,
sending twice the number of packets per second, for half the cpu cycles.

Eric Dumazet (5):
  net: add add indirect call wrapper in skb_release_head_state()
  net/sched: act_mirred: add loop detection
  Revert "net/sched: Fix mirred deadlock on device recursion"
  net: sched: claim one cache line in Qdisc
  net: dev_queue_xmit() llist adoption

 include/linux/netdevice_xmit.h |  9 +++-
 include/net/sch_generic.h      | 23 ++++-----
 net/core/dev.c                 | 94 +++++++++++++++++++---------------
 net/core/skbuff.c              | 11 +++-
 net/sched/act_mirred.c         | 62 +++++++++-------------
 net/sched/sch_generic.c        |  7 ---
 6 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.51.0.740.g6adb054d12-goog


