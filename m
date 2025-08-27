Return-Path: <netdev+bounces-217260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952FFB381E5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB9F1B27E0C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3B2FFDF4;
	Wed, 27 Aug 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EewT6W1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F4156F20
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296308; cv=none; b=iBnKRDvTOxDWQMv+k+x7kTb0GB00qm7u/9Zi/8aRMrqgcO5hh335BjIpQLCs/GPTbHaOzSZBiGllE0XjsitT4Wq7nfWq394e7iiBaCS8EMsyXIDDsoHtpslhaYAx0oKJO1w/NrE8vK6gyssQe4UKHswkTpAONEJw5NT6YQfictw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296308; c=relaxed/simple;
	bh=KXMFY9YTNPCXj/lf56pDCgXVPQal5Vv9yifEezczbL8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c1G4tP+TlcxbQhNRQ36MPkImBRKdy+D8UAzQuAk/G6Gd0amg0LkMoF+/cKCQMcwLBZK8VHAkk5+BDrq9yLV3AKL0wCGEgS1lGuip5Opy98Y4OHcNajOwKZi3wALKk1fGHax2E0XxC+MbsxCjyz5uSBNvREDPbgVDH0R6YDwjH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EewT6W1m; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7f6a341c96eso194163185a.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756296306; x=1756901106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZfnikXV+4SL4584q4EEX4KpHjVY2uu4n8CFV4aYVaw=;
        b=EewT6W1mQnURoM/sZZMKSDSHgkntlmusq/s44weQ+P0dguNV5bJUixJtewKEutmyGZ
         Rn2GYV3jmsRi3NXHmH+tUV55KiKGum7wNM8M+vUIXp0KU+eM7xDtoByQkEFqOWGyGcit
         umk4YSm+bb0+F+wpPyopOSdEiSLZcbx8LYStkC+YOd9wnu7JrFWPPKDxaCvgqez5N5jB
         nw3gYgqdaBw3r4ZeBudXauEaKkfZNrK39kchjQ6a4x0zzO0iG8wINI46I0OhdVkbeJdA
         SBOGErYfFbxWAzD0I5WfhV8hcLD3yFTNy33DZr+F7WSXYn7tC6ibDmhbVYNV74I/raMP
         hOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296306; x=1756901106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZfnikXV+4SL4584q4EEX4KpHjVY2uu4n8CFV4aYVaw=;
        b=SVNsdxhMQqG64X+1zDNxCnkb25g24oQ5U8sdu7AabTxY7bXjtzT9BI0641iV+ra09p
         jnV7EPuRk6s3lhzWCWfz1SjBQ9bE9djfUtT6/YFA6w45GMK1mabsOuVypP6Fy+AxqmV7
         nLnZ4SB0J3DfcdCax390+kfZg3LbF/Mr5F6zjh+9Z4fw4BaMg4mwOar/Rctnx1FJyMZT
         0e+M6SM+JeOu/dTfKJ/9Mf7vW3+X5HVITvN5mq2EbvYzbLQCmRNjX2ACflorgRzdbCjO
         V5dN8aWOPwkz7c3p6rMkx44985WPfxMq8+o01E/I1r7Q5vTqraQtdOh4tjU5OI55YkAQ
         dWkw==
X-Forwarded-Encrypted: i=1; AJvYcCWT1CDNfc5is7yZ9AddAOh4+yjzwYgV3NV9bnCFtngNWpXd1hJ2qXjsEhfBJJdaA+bb1KbQfTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJ/p++Z3Yf5/1nkYw4MK4ixirQmm8kAiwVt/qsj1qZbrkqHDX
	CfB1Go/sRNURT8DnudhcS42SYvLdJB9yGDBobyyo8J+Fv6miHH2pXSA8hw6RWxdvy01djvvmfF4
	1gKM1n7giMcXPwg==
X-Google-Smtp-Source: AGHT+IHkJFYIBkUXeYCc8O8vZNbQTnAyJZ6yHXt10rDzScbbininHkP/z8LPXyEOftOFD1PbYFNCyXw1P6xysQ==
X-Received: from qkpc11.prod.google.com ([2002:a05:620a:268b:b0:7e8:7b36:8d2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:698c:b0:7e6:7c5e:61a4 with SMTP id af79cd13be357-7ea1106338emr1643615885a.62.1756296305546;
 Wed, 27 Aug 2025 05:05:05 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:05:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827120503.3299990-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] inet: ping: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First and third patches improve security a bit.

Second patch (ping_hash removal) is a cleanup.

Eric Dumazet (3):
  inet: ping: check sock_net() in ping_get_port()
  inet: ping: remove ping_hash()
  inet: ping: make ping_port_rover per netns

 include/net/netns/ipv4.h |  1 +
 net/ipv4/ping.c          | 32 +++++++++++++-------------------
 net/ipv6/ping.c          |  1 -
 3 files changed, 14 insertions(+), 20 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


