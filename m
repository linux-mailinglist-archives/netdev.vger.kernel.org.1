Return-Path: <netdev+bounces-224879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B9B8B3B1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFC3563B8A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CC28314D;
	Fri, 19 Sep 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dhBxTW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB629274FFD
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314941; cv=none; b=MaiAiO81igN8iVM7omC4uT5jaLUb3BzBoO1Ju1n6LTTCsXvUwQLK/uhmBREePvhriWpJTbIxBGyNNUY+NOWuLllcsEy2wFJ0yXCtaJEtGeZCivZNWeTt4DBPha0wfoNWJnd05kStMtRosUl0baCWs2ERkpicagW5mqdDfY5cZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314941; c=relaxed/simple;
	bh=i0K7Xc+twn6JhVq36n7SPj7f/F1K7y9G+4rUGu7y87w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nRdHz7xHoxE0Hq6eg8enSSBOBLKbkuS+i6J0cCOrsx6O4XlhKzn1Ltq7CtaJhw7E1SOmttPV24U/SzTkEegc0NjWls91VVifEgvUr5cn768m1Y1JP72n9u8jZ1UDY9lRzwjBTAR8pma0RWAfUjda5V/GIWkA7bjFi1VMg+xWGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dhBxTW/; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-817ecd47971so711612785a.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314939; x=1758919739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fxd1o4+hhpqtwZsEtysLCBzzqm8maE2Ldt6r5tFtMRs=;
        b=4dhBxTW/cBiBPbuczr0SZmzAZbU54WYMomPwcUrjCeQWOYD5PykulkeoIxdplh5k6a
         5l6EntS6/vkCmok/TDs1dcZ8ZOHHGSGKUriOxZeXz1VmlvwzMF7hRaEXtt2RNCTFuSE5
         HtyR0Drys2Ukdsq+BYXUVSbfmZ987SHlQjamd6MKCDVKBA04hIPGxU0brwGIsBwG88XY
         W09xY1R6Tm4yi8sXy2lGmHAD/QkcqfCs5zvpRr02WE7RCnIWQxpJQgSUee8RRG074174
         UJXMGEDRSMCWOoGcHUpJMx5UvkC2C7NMHIFBfCepiG5o1tVYtq7DrwRWQiZvZJS+q9Ag
         4llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314939; x=1758919739;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fxd1o4+hhpqtwZsEtysLCBzzqm8maE2Ldt6r5tFtMRs=;
        b=DqxOZ+UubBWUll44Fba5bhfoRrDde2thAm1mlCBvb0Njt0GbZhWvc1sKFNymgpelJA
         yv98KIZe+a/GSFm5jIPkTiPV/9Ug3NSudoCRcmVk1UDREOE3k6xFBjbBE5CyBV5/4MpZ
         VLOyswXaXLmWls4wsvSqHMUSGupnjz8J5M75y3ejvoyAzaprE4CEiqKVfI3JcKdoVv4o
         WFyxrawGrrNJQ3PaeIxbo53fUVzZ6qeVFg5RDVbSVPlwmP0g6/IvRc7MsKq+2z6UHfGS
         CFUqjMD8Uy6ChEw5zcWECebq7AoudPywjQORbAqNzrd4UmqhXPrLBX7/S06W8YIyHq+6
         7AWg==
X-Forwarded-Encrypted: i=1; AJvYcCVwM5GU3cPJlnmDZSOOvVI10vA+ww6XGMWgY71I2qTDCrG88Z6tENuw+9lhtSRiqZgS3sIOD4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiOvHUVHVIVX/6ORjseAM29+pU8uBhGgW9kn7iil21WSwdDsF
	AA3KPiqh2xqowb6Zy7hr+kn+BaGnWksvvb7GW3sCk0nj3lo6bj1zTKms+q4JZbnT469DGXV/r9I
	Bra9j16e48DPWLQ==
X-Google-Smtp-Source: AGHT+IE6Cpana8GBWfDQvzjMALWxdtaAU/gEJY21UluoJMRuPAwz6LxPpDZWQhtW6Aempz0ByMODd7PxEhrGaA==
X-Received: from qkoz16.prod.google.com ([2002:a05:620a:2610:b0:828:baba:187a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4543:b0:81a:bbce:6d39 with SMTP id af79cd13be357-8363c8bf97cmr999934385a.40.1758314938615;
 Fri, 19 Sep 2025 13:48:58 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/8] tcp: move few fields for data locality
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

v2: removed tcp CACHELINE_ASSERT_GROUP_SIZE after a kernel build bot
reported an error.

Eric Dumazet (8):
  net: move sk_uid and sk_protocol to sock_read_tx
  net: move sk->sk_err_soft and sk->sk_sndbuf
  tcp: remove CACHELINE_ASSERT_GROUP_SIZE() uses
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
 net/ipv4/tcp.c                                | 20 ++++---------------
 net/ipv4/tcp_input.c                          |  7 ++++---
 7 files changed, 31 insertions(+), 39 deletions(-)

-- 
2.51.0.470.ga7dc726c21-goog


