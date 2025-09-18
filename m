Return-Path: <netdev+bounces-224519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2FB85DCF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9375176CBC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750E314D07;
	Thu, 18 Sep 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4KMm7+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81166314B8B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210936; cv=none; b=SqR+pBWCxB9Qba2VRaL5xtRT95XJF7bjXpLjwbxY90vz7HsJ4PDBgG0YMr6/6PUxgB47z1N8tg7BpAJl2ksEoSiY3qM2ArOA5X9M32CRJck1Uo3HFjZUrsBBXyGOxOKWdwvOy8BvoEjj/lZJQd79DRzG0iJYE5wAl9smd+sE9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210936; c=relaxed/simple;
	bh=OnRZRgpG954owCLPiQsCxTClmeZW7SL9TWCE27A999A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hpWkh80i4vhJtlY6e/motZIFqlxgH6yrHIxjelP0SXRY3lQcBeR/JEvcEz3fIbnLKOOuVjlxu9bGWCfmYNtJyMcVtmlwFXs8YjiGjrP6pO0Gsd9x5R3SxvDOlqAty8uUGB562DjVcVlr2exeh5dlJfrvVnG0q7OttkiXIcBe+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4KMm7+K; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ea5c811705eso1396454276.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210933; x=1758815733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKnDkPHYtZ1tHiuAgG+oCe3W4V+ayvmiQvwgC1kDgPw=;
        b=t4KMm7+K4cGLJWB6NcYAdxDCSRtxaQU2lX5F27BrOMYY2GpteZn9/BV3Nu3/8aKQwB
         ttvMLg1vcmJeCVt2kHPCdgw+65LrqJOKFzDomHLx1dtSDVN7a3oM2ocKlH2qS/ONdDN5
         aZJboNWPt6lKk1kE3jTiELkYyRdg3t50+6iERBG40JeyP7Iu1ahyDDmHvv2KKhFp4Z/W
         gpiQuAMEZd6iC7Ukhduvsbc9BsbRqjNIxwCF1NGol9yaKbC/hGeHD0GyieI7O3TRpgPz
         Mwl3ivbQOp0O+iEhjzy04FPMy6AwJ0gqBOI22daNj+B5l5FPeIpT4rh8p2C7UcDudo4O
         Pczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210933; x=1758815733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKnDkPHYtZ1tHiuAgG+oCe3W4V+ayvmiQvwgC1kDgPw=;
        b=qq/yb4SqXo/2ZEBdoGgCXHRI81+Rg3jn5gpetK7P/wQ4yoIpeFHhLn+XEjSY3RMzGG
         LGyJUkNB4EdkpU8GDao4WvRWZ69Dt4LZ9vjmzMOR/hw5iF8lpzpJ+yAikf+0i8Y1VEpZ
         tBm1v+bhYEVoKOc4kBGH3e1Cu+x28KWKy1vEItwDPffhOi5ehXttv+qFLSBJNCnsumDm
         vHWujKSrfUSO0Bm3fwMVmsJcbNn7v28ALxWyrixvUuUQ8FlsZ8jy1mOlChOZJY+j3la2
         iTE9sCTrKT2lSiNLBEG8ByiHokTn68PiwHdHWUW2/5LiAqbDIJeuztvDxxRKPed9yfYI
         sWng==
X-Forwarded-Encrypted: i=1; AJvYcCWg2FGseOF/uRaiUWAZDyIyhvWVBJQ8o/3cjcTVH6Oxe8iDuAgDfFo3x5+Mc6esSyLXHTs1kHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPH3jKXEMgV+dbKr12+l6ENpPnKQvsA/1ZqL8ZIMYizKYKj0I
	RPCamYECDOw0i+koEHXI7nCgdBYfDZbzLtlNYjaBz8jatPaYjC4u707qN4H4swZY2GhLeDIOGF7
	c36Y3Nah0dLUn3Q==
X-Google-Smtp-Source: AGHT+IHOpIDPRdgWVS6se4amRV9bgq1LF+eKvR6XdBuKYtKbo+A0rZIgEk2zAOOQ7eMNUxM+Ii7CI5/mh9MBgA==
X-Received: from ybbef17.prod.google.com ([2002:a05:6902:2891:b0:ea5:d888:309d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2a4a:b0:ea5:bdbe:1634 with SMTP id 3f1490d57ef6-ea5c056cc51mr4554761276.41.1758210933495;
 Thu, 18 Sep 2025 08:55:33 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-1-edumazet@google.com>
Subject: [PATCH net-next 0/7] tcp: move few fields for data locality
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After recent additions (PSP and AccECN) I wanted to make another
round on fields locations to increase data locality.

This series manages to shrink TCP and TCPv6 objects by 128 bytes,
but more importantly should reduce number of touched cache lines
in TCP fast paths.

There is more to come.

Eric Dumazet (7):
  net: move sk_uid and sk_protocol to sock_read_tx
  net: move sk->sk_err_soft and sk->sk_sndbuf
  tcp: move tcp->rcv_tstamp to tcp_sock_write_txrx group
  tcp: move recvmsg_inq to tcp_sock_read_txrx
  tcp: move tcp_clean_acked to tcp_sock_read_tx group
  tcp: move mtu_info to remove two 32bit holes
  tcp: reclaim 8 bytes in struct request_sock_queue

 .../networking/net_cachelines/tcp_sock.rst    |  6 +++---
 include/linux/tcp.h                           | 20 +++++++++----------
 include/net/request_sock.h                    |  2 +-
 include/net/sock.h                            | 10 +++++-----
 net/core/sock.c                               |  5 ++++-
 net/ipv4/tcp.c                                | 15 +++++++-------
 net/ipv4/tcp_input.c                          |  7 ++++---
 7 files changed, 34 insertions(+), 31 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


