Return-Path: <netdev+bounces-240684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C0C77EA6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D259234ADBE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B82D8387;
	Fri, 21 Nov 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiAypp7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B436D4E4
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713981; cv=none; b=cHjkqAmb5GcRrxYLbRMx4Li0e6cviC+kAaFV1FjH28LnmQeqwk/IVhnQhXtwGpKdAiOwjbL6D9LTufN3mQenuEghWmlVSTdkZKHRdkqjLL3Pg5LaeKlnCICIfldxnxiOoCTJOtzNLT0OJYOl4/nbwdw4gZI0JB1Awt7SnLgXlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713981; c=relaxed/simple;
	bh=R2qUGbLZEOrEk9/8VDJ2PNx1kfZV5IiJvCDY9I2yIm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HXfjxLN0cV0pW6nvlH4TvW8JtwH34MpwHc9jI1N0CGK8kwdCqcEgsVwlB2xB9nZ6b90aq9T0fpWS3NHqgttJaZDQAuECJ24Ff+uzlYV39uRNvsa1cRLuTaR+TxRT0pfzI+jKfrgjuxZoTIKbzzi/6oeCJaXcf77RoEwU0RqSfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiAypp7V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-787c89305a2so16089877b3.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713979; x=1764318779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3d1Q7rBqipLY7VRyEOhBxMC6HWCIeX/72MPSSFMOdOI=;
        b=fiAypp7VfmLV2UNPk15vKlG+OiNjMyezov2hSQCkv9fbJaO4mQSwrn5O74FuJH1x76
         rOpC3wTFbL3GvUabh546XfZg75VStaVyqg1vohhNvprR09jUKz//c4z5/enwNABoac7E
         G6aXjYldGNhW2XoKugEKKh8PWa/tnOn7cNZ4rZ9IFej+OqDYQHKEdNO150gSYHPP3jaB
         j95D2jHypG+FLLYcNGfq01qggoKH09HTOZdaJuaEfU80ttIq2Bh0imzU30Q0Gvlczb7W
         TAF+xSqRiwNd4YRdiXUPD6lPU2jvmnhTNNkjYXddHmohe0wzkRQWOtBFyIMlWBNp01eo
         xn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713979; x=1764318779;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3d1Q7rBqipLY7VRyEOhBxMC6HWCIeX/72MPSSFMOdOI=;
        b=YHHpvSKI3C7XwaWu+3NQ6Vrg27m1BTnmt1z39OyvMQntxZFXbAOxV6LshJHgZqaZGw
         MzjOWkY1TiTOFSwJhqgHT/K1eoTAsyesN65gLvftzkeRbgXx2ExmZiAXVTJxFZBhXIiZ
         +/+8/jA7houAfdImeYiyledRR72GMoOm0naXXhiggorP00d+2klZPQHSeI+NW9gLavSR
         UmCLPecfuc7uhIRvQe4FB3fcZ/hyNp7JZYbPsFobT/gix3y297gAbbzQcqaXFGalUzSC
         pj0C9KTu8Pq94SAgYk10u8GVKfpJ1maEjzldzSiT7umTp4os4knnbA69I55NGvJpfGWB
         T5xA==
X-Forwarded-Encrypted: i=1; AJvYcCVDG3HsqHjfdfrwh5RdfE7C4eJL4ZgUZAxS4mECSNdeU7mz03fkvGdBXUvv/HyxKdTDHBjFnfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/az2ufMCnWyjK0oYZ013ow/E7FNS0acaDiZ7fiZye/yOPxB2R
	ItuRcorn/2HJ3i5RU/OUwIbtN9QacL45ziBA+NMt3GcF0j7d+9/BUjukwyZmMcFdqHJPuu208d5
	fyetA+MMOjkkiZQ==
X-Google-Smtp-Source: AGHT+IGEeOOOUMRG8/2+i5lO4++QHcvtRtdhG7mIXiIKUbCybU+xEt7oA8jAUcCmDfPmeosq5qK5RTFh9yTRjA==
X-Received: from ybld3.prod.google.com ([2002:a25:8883:0:b0:ebf:6015:5937])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:2506:10b0:63f:a319:1c4d with SMTP id 956f58d0204a3-64302a1be93mr734753d50.11.1763713978838;
 Fri, 21 Nov 2025 00:32:58 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/14] net_sched: speedup qdisc dequeue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid up to two cache line misses in qdisc dequeue() to fetch
skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.

Idea is to cache gso_segs at enqueue time before spinlock is
acquired, in the first skb cache line, where we already
have qdisc_skb_cb(skb)->pkt_len.

This series gives a 8 % improvement in a TX intensive workload.

(120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)

v3: - Same than v2, resent after a syzbot report was fixed in commit
      4ef927436258 ("bpf: Add bpf_prog_run_data_pointers()")

v2: - Fixed issues reported by Jakub (thanks !)
    - Added three patches adding/using qdisc_dequeue_drop() after
      recent regressions with CAKE qdisc reported by Toke.
      More fixes to come later.
    - https://lore.kernel.org/netdev/20251111093204.1432437-1-edumazet@google.com/

v1: https://lore.kernel.org/netdev/20251110094505.3335073-1-edumazet@google.com/T/#m8f562ed148f807c02fd02c6cd243604d449615b9


Eric Dumazet (14):
  net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
  net: init shinfo->gso_segs from qdisc_pkt_len_init()
  net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in
    qdisc_pkt_len_init()
  net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
  net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
  net_sched: cake: use qdisc_pkt_segs()
  net_sched: add Qdisc_read_mostly and Qdisc_write groups
  net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
  net_sched: sch_fq: prefetch one skb ahead in dequeue()
  net: prefech skb->priority in __dev_xmit_skb()
  net: annotate a data-race in __dev_xmit_skb()
  net_sched: add tcf_kfree_skb_list() helper
  net_sched: add qdisc_dequeue_drop() helper
  net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel

 include/net/pkt_sched.h   |   5 +-
 include/net/sch_generic.h | 101 ++++++++++++++++++++++++++++----------
 net/core/dev.c            |  62 +++++++++++++----------
 net/sched/act_ct.c        |   8 +--
 net/sched/cls_api.c       |   6 +--
 net/sched/cls_flower.c    |   2 +-
 net/sched/sch_cake.c      |  19 +++----
 net/sched/sch_codel.c     |   4 +-
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fq.c        |   9 ++--
 net/sched/sch_fq_codel.c  |   5 +-
 net/sched/sch_netem.c     |   1 +
 net/sched/sch_qfq.c       |   2 +-
 net/sched/sch_taprio.c    |   1 +
 net/sched/sch_tbf.c       |   1 +
 15 files changed, 147 insertions(+), 80 deletions(-)

-- 
2.52.0.460.gd25c4c69ec-goog


