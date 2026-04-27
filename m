Return-Path: <netdev+bounces-281323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGEIFuxj72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5DF473590
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1928A3000088
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F93B961E;
	Mon, 27 Apr 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/KF4E+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE530AD00
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296360; cv=none; b=dzNZcC/ahNuyU+sBHfVMsKipsFBj4E0GHLskrMF17Qellbq64/HLgPwRHzX5fURCZLkIp7CSaEU8arVnqbuNn3KR0ZjEz6Q9VJrliEtihn/7cbrESIZ0K7aF/3ZzTilO7TC70VC8B5o01Zl4T3uRz7SNDNxwqidj0D/aHHrXIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296360; c=relaxed/simple;
	bh=zt2iF+HM/WzsKRjfneRbPnPft+bONDAyu3qYhJn93Hw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GjebmF2YHwB148nNHBtdfjEPu6Xiwi7T1qMRtfZM0URGy1LR0fSnRjxbcPBG69QjTKBArOm0ZMPzHJ5v30p/uDyOKYPKL0TP61HL1HiGge/KWZfuEPl0O+aO5vFCAC3+e+iIGyXNlKSe6re5geFMhKYZLre2gZ5D+2oFdWn87vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/KF4E+f; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ac04b2fc4eso41257676d6.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777296357; x=1777901157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hP6Kt25Pfa0fJRQsy5s8BLsza4A6PD6QyQORKG1sofg=;
        b=V/KF4E+fD0JD2TbVCgM0ZRl33OqOhTFoW9YCDPCbyvF1v5/ic5nU0SEtdkGVhcxA0b
         tZblW5Rv4ezzS2MI9l+pdMHJQrzvtKmQSm9tO6atD8Bnogh7/bcMR97WD/twJGOfDBbV
         8TzpdPLVuhgIHeU9Lw7Mgniv23F9yTCxImJwiOgeG8V6CDyOqMOepkEEUpDDHR26bi4H
         2hc3KRpr1TwR6FVNL3fQiITKghLzmTkqTrsM9awOJt5ImipBT/hud6orqioZ4ygi/IOT
         y5gPrKbUGoNxSDhXFzWc64EeiurU6+Zd/YglTofcMBI1mS2T1yy/0OK/SFToHNb0MqVM
         3eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296357; x=1777901157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP6Kt25Pfa0fJRQsy5s8BLsza4A6PD6QyQORKG1sofg=;
        b=j68J75/rmRM/LjWxKxoWSOp7Cf7Mlba0DYxYYImhLuIvFTUq+eizyq3c41nWMz06bm
         7OLtYe0hn1U4GEmM3rDdHSrSJPM/MQ58Q+1a3u+tJTsSIh0UlHuVkw5/mbS8PT8AiKWZ
         l/6nkfCPVx2AlvS+xhEhR+SFlf4ykR59FKsCTihsNY32wQkwWomh/L2/HwKM9CRyfHBD
         maBzFQHaT/hj6GWnljZW+RZMNZ+Gm+JKONTWxnb18xgni5Nczp0IGixUtwsTQVNfe+0+
         2BXrmLWlZaZky4pVVRcd8zE0j1jbqYfvyYIiDI0ZiekgD7WoFwzWtn/aivFd1x+ghofd
         P+gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TzsFbRApuan3e1pnjdQ0c1xtmaia2MUlN2HVgGKHOSBHKIO3bKCovlj1KNK7R/Sr2ZQPgPjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8I1kesGtbvt6VXV6YUekHh93IwLyC6myGaZMh4l6UdhX9XDBb
	0Alxt9P1ncAxC+45YVNOCQ2eWKvMIWjhZsYeM2Pi4wV+2kh47N6YqCrbeJ2/P3Yu6ZqMIXw65mK
	Qaxifeu8RdcScqw==
X-Received: from qvab4.prod.google.com ([2002:a05:6214:6104:b0:89c:e4ec:1bae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:33c3:b0:8ac:b4d5:50db with SMTP id 6a1803df08f44-8b02818ec3fmr642304656d6.28.1777296357177;
 Mon, 27 Apr 2026 06:25:57 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:25:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427132555.1791636-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net/sched: tc_dump_qdisc() optimizations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1D5DF473590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281323-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Before converting tc_dump_qdisc() to RCU, we make the following changes:

- Use for_each_netdev_dump() instead of for_each_netdev()

- Only dump qdiscs of a single device at user space request.

Eric Dumazet (4):
  net/sched: propagate tc_fill_tclass() error
  net/sched: tc_dump_qdisc_root() refactor
  net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
  net/sched: speedup tc_dump_qdisc() when tcm_ifindex is provided

 net/sched/sch_api.c | 140 +++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 66 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


