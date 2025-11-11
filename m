Return-Path: <netdev+bounces-237507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA2C4CAC9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C18E0342946
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F625D917;
	Tue, 11 Nov 2025 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vPH44lY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F5279798
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853528; cv=none; b=kcjsLZ6741vfP9NWZek0ZaMICOp24qnYjCX7WzQDLF3IsVA8nSGiONGE+Yoi/+GG6tg9j9kig8msAMeZEhpHLyMAjkMyI2QB+s/L8X0236lYm5Izf4JP5SVo5PWl/MarYaObtaEkv/lB3pOVcxc/PT5nvJaCdnPCfCGOMYSJ2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853528; c=relaxed/simple;
	bh=8GIAJZLI3F12yWp7qqygW+dpKsCgi1DjpG81oKEU4Ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wgs4+5hDUs+tGR8bYXr76w8i0T2lcnejieXO1uGMY4Bhv8vHi7k+2uvK8nTqF6SMN2PObky/Kn5Yx31WgXwJmGcNheHWAmogj+1PGseRV3I6PdavFkA+j0tFqiCJ190h50AU8AAxLiTNvByBabiFxJ4ppcg3LjJNOUB8t7FmcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vPH44lY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-785ebbc739bso65859197b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853525; x=1763458325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6xgxIjtltq7G6bIfyKRi1vLqa0bzUrszxAnjwbdCwg=;
        b=2vPH44lYg5OcTP1FXTLzHG3NbMropE31+nLgczlINf0vF9x1G9D4zpBfUKLu9WuuuW
         QTyPVmBbt+0KCPqpXDORx7Akg2Gf8V2+YB03U9RLjTK8gTFMSFq12sZEkzq4xq5idqhm
         RFSkGYwZJrbwrO2dIa3lkFqsxbzD84nhjVlN9l3/ldwl4Qdjjkfi1MHXvHhBzy2m0wSJ
         04uDJaad4xSuCrGuVUD489oXZEJ/6LC3VJlZpkJkz+gE44VHFKzkORAWkBWUDJkxsAWo
         MC4nl5mWWoJEvm5rSn7kvATfaBlEb4MGRGSGT4ox4sEgmsYc3LHHEooa9kJmqSP4k+ZL
         wqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853525; x=1763458325;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6xgxIjtltq7G6bIfyKRi1vLqa0bzUrszxAnjwbdCwg=;
        b=Hc705Y66WCKuKa1aARxO/sdB2LzBaC/hiMVhHROSCKixNTBIRgfxF4/MFjCESU3PoM
         TBd1lqTwQdQVhiS6QwYiJFY1pqCIW7eYduBqeZ2vHx6Xye1Yn6V0OT9TQJ9VctMgvvQ+
         Sx6AXdwlzZx0+5g1RaDnzroIr61SDVG4o63dN31Jb2w7jNRy2LPWlll9WLfJ95TUMvdk
         063wFLrHOGMeU+F2lttUxLG++36JXJg7e+RLZDWoD8lcF20RQm0NDycWIa8KN5tY5Jjt
         GOpO/doMpHdIDiPE2vkfIr3I0A06mNjGlrDQ2hXRNqCBq4+6F5mtlrmjo8o3xkJPH0AL
         2tEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXevimfhArdCcvrv0hOaxp+7FdZu4KKkEPq9Pkxpo5rG4rr8R2GU2naeWGUEPdNE3qoLlcOSow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbIlxDNq8XODvALh2pHpqH8R+htXwT2JnhbAU3b6SWSGVFtDG
	wNQGa2BI4nkMRm/UVN7prB7x6pJmfNe6ZqSk3LPXpNBdOuAXhT34gjBHe6FGAXNpmW66PbWPbTM
	U5geD1J/HDLhaUg==
X-Google-Smtp-Source: AGHT+IEj3wLoFgDMPUQgmw/BuvyMXg3p6jfXZm2rF4uiu1JaBQgYfhf1vQrkqjoDjVOCl9X882w/ayJ18GYJJQ==
X-Received: from yxr15.prod.google.com ([2002:a05:690e:150f:b0:63f:99f8:bc6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:ed52:0:b0:640:c75d:9a98 with SMTP id 956f58d0204a3-640d46356cbmr7798292d50.69.1762853525361;
 Tue, 11 Nov 2025 01:32:05 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/14] net_sched: speedup qdisc dequeue
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

v2: - Fixed issues reported by Jakub (thanks !)
    - Added three patches adding/using qdisc_dequeue_drop() after
      recent regressions with CAKE qdisc reported by Toke.
      More fixes to come later.

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
2.52.0.rc1.455.g30608eb744-goog


