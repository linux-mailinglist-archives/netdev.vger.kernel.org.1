Return-Path: <netdev+bounces-229334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B363BDAC07
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A44E1363
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C12246BC7;
	Tue, 14 Oct 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tY8oGsG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5F1EA65
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462353; cv=none; b=RGWvXdwXnh5EOO1fFzm8bnOzaOARuXjfOyQsgDQ57MkDV3fs4n2azOVHzAJUYYljjjPocFIpAg4mh8Dn8bxhD8ut86DsqHqWBow0bRiJjiNxA5BeA0Av53HWM1co0YLYYme4iNzfhx0iJ4ft3n0hFQQXuuEQsu2dqcWlPX0O05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462353; c=relaxed/simple;
	bh=qRnaY6juuH5n6ZlBde5DPdPSdsltchMavhZy7La6vnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rZJht88DRy18fD6iA2TdAzblWRS4DlllsFkuWHC95HIlDIBlWd7qxBawGM0yaa70ZR8sLSSzZNAybr0Yit7URpvz1Eqa8Vdq0ClywGVgaAwgQolEY+R+3CANZMDsBTszgTwXnEdPQbn6OWdTy8xyG2e6OhYPq8L/pafvnAumyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tY8oGsG4; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78e30eaca8eso413799856d6.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462349; x=1761067149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x760FAuFLOSjdD1/k1K1/299z7hvh77sPUKnARI9uxo=;
        b=tY8oGsG4J20jNLLM1iUb2wdgpCChR/jlK7F8GnEUY7NTTtxvGCi2enbbeS3TrIWSWF
         47+02m8UywOvOLlzNO/r4PZarYMYbpCufjCeBvH9j4R49aB2nFEocL9g3AeVTtRxo4Hx
         paZGjfyaNcQS6szo9miKEbLtDa7ngiwRtzmj4brBcKhXAUiV3cHPG43t7HOgthbG1jBf
         x3p+wODF+DgNjtQf8vtvYY7Sg1g2X6yZNJ4v3P6XsFzhvtVktCDyAUTUshi8uQmsKi7L
         pQYKhPAET4doIr/ZrA5cj+wQewFix8u+AUOHJNrrzM8JQ9d7gUkHZQ4bMYq0Fq6/OspB
         GtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462349; x=1761067149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x760FAuFLOSjdD1/k1K1/299z7hvh77sPUKnARI9uxo=;
        b=eEIOiNGXsO5iL6mdztubhtpoaoNSl6ErS+v8QvuzDRNNrdUMjbtUFkd96uasADquf+
         MoD2sHz9/RX66FF3KKKH+s2IL/9OfCptp1JGChn5ZAQgMMS30Lx2lzjpapLdC2GeC5rc
         Pc7TZucW3A6KAXxjjXmCEydyOV5Drc/TW0khHO3SSRVGkHYHtPPjXLZ0gMdbRk7Hxag9
         oe+Nfu9r7jXCOTXvtiITQC+u6ZWkGKKHNAqAN2bpYR1CTISQyEPp4oMyYzrpgefnqLrK
         xZlMW81dgY1X5bN8/aQ5Zj1gUsJ243TkQ7ZdKhguS9xA5sPkdFZxgtoEpP3CtDx8EpFf
         8Svw==
X-Forwarded-Encrypted: i=1; AJvYcCVpIBZMurd+HJbVxDf3U7D+FMrLM51r71dYOrdS8OEeajXBJIIxja6GhNq858uA+yff8YlH3FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykwys5JjxDKqHfrxBF7J0qGxSOnG5yU3ZWa/cq4hXF+W/PlxN2
	G4T+vWe+9jFC/Ed74rLUFVmsiDZJLD7f/VZg3XJwjeIgmNvYz1AeVES4Fq3CVeEh4Bkfdgujx02
	IIZO/D6CEJxnJdg==
X-Google-Smtp-Source: AGHT+IEifSyWMyF5NIfhS3BCDiVmInO6kgrizUmm/xITofXKEqJROoVE+V1V/PVrjGlSplgvqsxmxW7qZvkLaQ==
X-Received: from qvblx7.prod.google.com ([2002:a05:6214:5f07:b0:87b:ce3d:d590])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:590e:0:b0:4b7:5de3:3046 with SMTP id d75a77b69052e-4e6ead54268mr382146901cf.49.1760462349487;
 Tue, 14 Oct 2025 10:19:09 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/6] net: optimize TX throughput and efficiency
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

v2: deflake tcp_user_timeout_user-timeout-probe.pkt.
    Ability to return a different code than NET_XMIT_SUCCESS
    when __dev_xmit_skb() has a single skb to send.

Eric Dumazet (6):
  selftests/net: packetdrill: unflake
    tcp_user_timeout_user-timeout-probe.pkt
  net: add add indirect call wrapper in skb_release_head_state()
  net/sched: act_mirred: add loop detection
  Revert "net/sched: Fix mirred deadlock on device recursion"
  net: sched: claim one cache line in Qdisc
  net: dev_queue_xmit() llist adoption

 include/linux/netdevice_xmit.h                |  9 +-
 include/net/sch_generic.h                     | 23 ++---
 net/core/dev.c                                | 97 +++++++++++--------
 net/core/skbuff.c                             | 11 ++-
 net/sched/act_mirred.c                        | 62 +++++-------
 net/sched/sch_generic.c                       |  7 --
 .../tcp_user_timeout_user-timeout-probe.pkt   |  6 +-
 7 files changed, 111 insertions(+), 104 deletions(-)

-- 
2.51.0.788.g6d19910ace-goog


