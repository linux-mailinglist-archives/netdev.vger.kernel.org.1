Return-Path: <netdev+bounces-202360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526DAED8D7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789BE1638DE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEC23C4FA;
	Mon, 30 Jun 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWDShCdi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67306204C0C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276144; cv=none; b=pluKYMmN1EhAyJnT3Nd+zB6pdVh0XRJfnVR5VaGEnW4Kp81Edeg6oEWCdYltdm4p2HNTwKJ9RtqH6UDXLkcYNGbx1PIGSargOKlK7zQwkn5su3PQDoghOETwCExALXT40Is0keH0wimc0pyEhlLw9ddKw4NCPQ130bGlThp2LHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276144; c=relaxed/simple;
	bh=V0W3LhscVzTtTBQWkhmsO+3n4/Vmh1SFaTxfMx5+bNw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YnCBUCHBhwqmGa3UzPnMqTgcS+wyupP51q6FHztnnzW6TGOmW2zPLuBALY4XalM39lvVWqYZZMspXBNLrd6pDJ9EWP2bewxv5OJypxWl7smy4oHOc752v0fSfkLho9Lk1CRBzyJlL+mmwj17BMT6ImUBZBO5YnV9ExMwIM4uEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWDShCdi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d3e90c3a81so178048685a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751276142; x=1751880942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BhdgPn9J98Q7K9jKHb7eQgI5If9r8AF2olDO6DUfmHg=;
        b=CWDShCdiWBrks4qUEubLwwyN/zdtmRmyRH3SCD7zH1PqmIVActWKncIkTohZeFFsau
         3DiNa95hW5KuUG5lbeRUOtEC26uIlu5R2YwX0/sp1kuNUbUr2r4MElQW7051Xswr0lvb
         Bjr9rDo/uBkHm/YG18oVlGSMTtpv0NEzUVx6y7tlm5yfEARkhXil6TRnzRb6VQzuuC2z
         VfApWNd0+PzF5Z5zc+lb1XE9Apquea0fZPOhGBSGmLQGzl3rYvanTW+Lbsc3+ojMXmVm
         n3EqTQpueKkd7W0SP+OEHEr8uqNASbmtE17xBuie3Fi1T7xHMKaFptrUdHWPAF6OKREr
         DWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276142; x=1751880942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhdgPn9J98Q7K9jKHb7eQgI5If9r8AF2olDO6DUfmHg=;
        b=E7gnzl3myW1oZG8lcQ30VNET+b67EMlsMN/iEEx+qYTIGMNPaj0VjDDkI83jmJnGtl
         u6oDKBs6u9bJveaWMuMEC7Dl7noFJfxWwyP0T9d94s6Z4GUOVK/EVmAVUgDK0CpY59+h
         c6BfE0A4ryTTSAHYjx7VTTOeVTxoMPcUjnXobhZHFA8XFT6tYLlzodjetPsnMjX+WuqY
         tecuSdh2RI2h6HunJo1pYUnervzeaDix9HuPeNEy3tD5JQpzUX7Lxc9mE9554M4aDIzk
         4P+c+AhARVnBwGKZpWq/VOeBaqde92s1wX6AbN2LjxCn8aEssEOIZdptmAXlA5XTzs00
         sa4g==
X-Forwarded-Encrypted: i=1; AJvYcCWb9Be8Vlpcn5ILFw0tukYv11j2f5hzn3/cHnAMYUipXmjOvpv8g7R03SUbWwznctNy28M3Nis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aH+JIRN7ngTJ2ehTSs0SlFxYyOh6D8J072LnsWbgv8FvwwPs
	4FIMft6QJQHKXjlcqfQroY1VGW2g38YigQnAKla5sH9z/oPm2vEMRGY62P3OD6E6npdTxQdABM+
	6Ac7PfZT5mqcodw==
X-Google-Smtp-Source: AGHT+IEQPpRqyGm/atQWp4HsrUsMvYHnfFvxlMbtWbcLntRcRSNr1CfVJxPNxBkCt+/jjTgwL5fR27naX3bP1Q==
X-Received: from qknpw10.prod.google.com ([2002:a05:620a:63ca:b0:7d4:f7:3ba4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4052:b0:7cd:4dbf:3c49 with SMTP id af79cd13be357-7d4439fda12mr1753259285a.43.1751276142134;
 Mon, 30 Jun 2025 02:35:42 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:35:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630093540.3052835-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net: introduce net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

____cacheline_aligned_in_smp on small fields like
tcp_memory_allocated and udp_memory_allocated is not good enough.

It makes sure to put these fields at the start of a cache line,
but does not prevent the linker from using the cache line for other
fields, with potential performance impact.

nm -v vmlinux|egrep -5 "tcp_memory_allocated|udp_memory_allocated"

...
ffffffff83e35cc0 B tcp_memory_allocated
ffffffff83e35cc8 b __key.0
ffffffff83e35cc8 b __tcp_tx_delay_enabled.1
ffffffff83e35ce0 b tcp_orphan_timer
...
ffffffff849dddc0 B udp_memory_allocated
ffffffff849dddc8 B udp_encap_needed_key
ffffffff849dddd8 B udpv6_encap_needed_key
ffffffff849dddf0 b inetsw_lock

One solution is to move these sensitive fields to a structure,
so that the compiler is forced to add empty holes between each member.

nm -v vmlinux|egrep -2 "tcp_memory_allocated|udp_memory_allocated|net_aligned_data"

ffffffff885af970 b mem_id_init
ffffffff885af980 b __key.0
ffffffff885af9c0 B net_aligned_data
ffffffff885afa80 B page_pool_mem_providers
ffffffff885afa90 b __key.2

v2: added <linux/atomic.h>, report from kernel test robot <lkp@intel.com>
v1: https://lore.kernel.org/netdev/20250627200551.348096-1-edumazet@google.com/

Eric Dumazet (4):
  net: add struct net_aligned_data
  net: move net_cookie into net_aligned_data
  tcp: move tcp_memory_allocated into net_aligned_data
  udp: move udp_memory_allocated into net_aligned_data

 include/net/aligned_data.h | 22 ++++++++++++++++++++++
 include/net/tcp.h          |  1 -
 include/net/udp.h          |  1 -
 net/core/hotdata.c         |  5 +++++
 net/core/net_namespace.c   |  8 ++------
 net/ipv4/tcp.c             |  2 --
 net/ipv4/tcp_ipv4.c        |  3 ++-
 net/ipv4/udp.c             |  4 +---
 net/ipv4/udp_impl.h        |  1 +
 net/ipv4/udplite.c         |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 ++-
 net/ipv6/udp.c             |  2 +-
 net/ipv6/udp_impl.h        |  1 +
 net/ipv6/udplite.c         |  2 +-
 net/mptcp/protocol.c       |  3 ++-
 15 files changed, 41 insertions(+), 19 deletions(-)
 create mode 100644 include/net/aligned_data.h

-- 
2.50.0.727.gbf7dc18ff4-goog


