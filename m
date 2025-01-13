Return-Path: <netdev+bounces-157753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8DA0B8D8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895201882FF6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4F1CAA87;
	Mon, 13 Jan 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffzsdBoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627022CF0B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776562; cv=none; b=CNfol0iDmNDdnu/JSBQPwV9X51BR0T5qpJA8twrU+2yVguWWhOhMbW+8uQETbK4VeW/pRNlzNHjePCwdtCpo81iGaiYUEn9OJ5LfLznl1PZAY+vV+Jvv8CuQCGM9rOH0ZxrIV4QWHBqZYU44gTZHw+9aQt3yKRMgFNYib5z87jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776562; c=relaxed/simple;
	bh=gC3FC+heam8mI1FyY9EsaKNRr6qC5sjuy+y5weDdrjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RkpiOe111J8n9u7dGUwmvlya0+iHeFzvaHe40i3ZirNcsggw4COFehG4ZrDDkJuDsY3LK7bjer3t/bNj9LhkkPHjoBGYPphOyDwSp8NQ40t6k0EatFAGAf56sHMTIsRYYFGqCAluxqeWQviOOwUQLA2O4mbiXULZGFyRAAWFfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffzsdBoX; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6f1595887so741011185a.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736776559; x=1737381359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqGFk442lnnLaY7k2bYSDuC9+0WaaU0Ge4ti4tQcCdU=;
        b=ffzsdBoX7a+6OwhD7D4RVy1oKwVuCqtS9hg6bFMChwTgaitChcDqXbdiK8lqXGobGg
         eBKRBa1eyiFvu1KwXPn06v47EFUK12Qu3DYJpXS+XD45dJCbesrk9lbkIYKRa4qq6CJe
         MIZ+Vpq4LRIYWh7KJ0Qa6u5eQgDEm4hFg6Zdmlu57A+MJKofug/U9Qz8DURb6R4Tcedz
         FjDvLpssBTkvdBavwuNjcM0t55f/789lgfRz6i88m1xbu0fq59rvufO01WfaPzi19pLJ
         rFG/Yr2+n71MFiW82y2Wx3kygPV98grhSZMOuzffxk5ZmQZsifua2h3UgrPnjmkilbRE
         CJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776559; x=1737381359;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqGFk442lnnLaY7k2bYSDuC9+0WaaU0Ge4ti4tQcCdU=;
        b=JE+I0NlAmlxFLhl3OK3iEwd+4XvCQ6XAe8iJEaikvECb6Kv1SQ33fc5NPI9xoSq9HS
         yagTWT/ohE5QN/joxP4/+w1w5lbG2xGxFtnAKwAaxIQk0P8yHs/iK9thOwpEJQ1T/HPs
         cLcxEb2cq0sqpBq4b/EQm8RLahz+4pa/JMoPMCz7KlMR3eNbYELPEqNKOJUSB6Jbq5aZ
         d3r3+VDqc0HAXepewrH37sEKzSdUcWqynQSlexQ2DFeCp4djlbRlyywRBzP60i62jDNV
         a8vUFme5xcQygLDsSlSnDDvK5GYhZOA7eZHKR44HmBi9zMA0VzsEgHXiHmCVasWaBVGF
         0cRQ==
X-Gm-Message-State: AOJu0YzP21KTzTJnZLBHuL1kC+75lB/qXa6AHS7kpByXNyYVOlcq+rOQ
	V3mePCHjc0Q3JlM9HGXUZW6v28a0kMFhjk5qMBLaC0e5QbkjmAzDrIybR9rcB53q7wt7451zo1S
	LJGveDDneXQ==
X-Google-Smtp-Source: AGHT+IE8NLA7kXYVWNzVDVmVTqb/ls5DmQq15jCSE1uhSUUeLOH94h1AcpXrEHA0KZ5BJcjny16kshfbhciRtQ==
X-Received: from qknot21.prod.google.com ([2002:a05:620a:8195:b0:7b6:d85e:8484])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a08:b0:7b7:5d6:3976 with SMTP id af79cd13be357-7bcd97d6489mr2994218885a.58.1736776559729;
 Mon, 13 Jan 2025 05:55:59 -0800 (PST)
Date: Mon, 13 Jan 2025 13:55:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113135558.3180360-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] tcp: add a new PAWS_ACK drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Current TCP_RFC7323_PAWS drop reason is too generic and can
cause confusion.

One common source for these drops are ACK packets coming too late.

A prior packet with payload already changed tp->rcv_nxt.

Add TCP_RFC7323_PAWS_ACK new drop reason, and do not
generate a DUPACK for such old ACK.

v2:
- Also add matching LINUX_MIB_PAWS_OLD_ACK SNMP counter.
- fix a typo in one changelog.

Eric Dumazet (3):
  tcp: add drop_reason support to tcp_disordered_ack()
  tcp: add TCP_RFC7323_PAWS_ACK drop reason
  tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter

 include/net/dropreason-core.h |  6 +++
 include/uapi/linux/snmp.h     |  1 +
 net/ipv4/proc.c               |  1 +
 net/ipv4/tcp_input.c          | 84 +++++++++++++++++++++--------------
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


