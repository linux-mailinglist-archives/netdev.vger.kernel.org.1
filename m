Return-Path: <netdev+bounces-218322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53446B3BF39
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C4D566752
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9D1FDA8E;
	Fri, 29 Aug 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtYMpY92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CD101DE
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481460; cv=none; b=iCmOuZO31pzI+yZd+xOb8TjsN2pZnIxmiXm4eGV/QYF8zFqkc4mwJo+GOzRluMc8FSMFe5bngLE8atKusBYXNhbi9JrRRUaTmNntFdDi2fIvcGGmcjYhbFRil1S3jnGVfc3XlqQ9w4oOWl3cqcl4FAKC08dcML1T22ZWLR7wqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481460; c=relaxed/simple;
	bh=LKgbD8z64zZQpAFGHteixM3duANVIbWZhwTvAHE5eC0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ToyH6iIc2rgJgrsHPVF7jWE/DcG+P5m2PJSIPT9SUHZ4kiSbNhDsieajRQDYopemCqstT7I/kUxWxrZlrE+KFRSw/oWTNyHY2As1jPr3U3SFTkuh6qPUV836as16BleAD4DVMksr2uXiXiZR3Z96UHjHOJszcDQ9uYS7T46U/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtYMpY92; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e86f8f27e1so505857685a.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481458; x=1757086258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8pd0EX0tPxarMO8QaDV9itMzDKzmci07MHHOPer1gQ=;
        b=xtYMpY92abgLt16R/uPFn1qu8ODGnHMtjfbMbBemC/TDVl8zuLOoPAzEzV9CYPmzLg
         3h4hTaukEAW4c+4ZN97mt1HrzBdhbJP9B7uHKFjGO6sZenb2VsOY/RZ3N5xFOa3aBod4
         Ml2JIs9Q3PvW9lNSz/b/idXzZFQjKX/3sRbweMApNDnhv0Wy+p426lqccuma615aVRpr
         Dr4wY+Yox/SWNJkq4Rw//RN4kp0H3CfMHm6k/5ldnwhUkFj8jrirDSd1/XmujPf06Sn/
         mqk+TioYef9E2589FNkR3y08mfYdIwXGAqs1GXedDLUJrFgGd+Srpf61WvsPjGCfL7w3
         zPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481458; x=1757086258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8pd0EX0tPxarMO8QaDV9itMzDKzmci07MHHOPer1gQ=;
        b=bzj6+faEcGaMRdMeAPERPTVC9crsmFe31W6ew9Avjd2nI7pbYuu7P7Q0Uq3d4Cq0b1
         6CgP9nTiC5azegguSmcpe7j4O+wHLs3LKo9SqctRMJOcIvHM/o765yROdTsd944EVKT+
         3qy9m2pIz5Fy2bsExrSy37Au+qEWd+hoYzt2k6fumF2/hoIMqcBVkcuZQW9lBn4ZdAS1
         CIAU14boDIQU8+MQvy0qGypfk/gszUFCEVO3Mh0dplj8yQTeCav8PQN8x03P5Qe08ElU
         ivetUE3L5J/9HqQLgclsxNtnbvOd0uQQpMVQv3LuLixj0TU5ItADVzUMZQ1ihlGu89YC
         VsfA==
X-Forwarded-Encrypted: i=1; AJvYcCUkiLg63aBn2tO6eCvKDSfVqExTlpcUwM2nVMpm52vqKYKM0CqWjWzAT4kzu3PYHJy/44UWJj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6j2RTgyT5gAtyWh3f0iu/Gf77WYy3B2B+KTHVeVp1UbwA1qG+
	jNug2WcV/6In5Z4ByjMrNj/Qj0yDdCKxhwpnk1VnzTjt5sFJGBduUPSAk/iU7UTEWfLl69kd/Qw
	LNr/xS+OJ8kwXPg==
X-Google-Smtp-Source: AGHT+IFcx4F8Jg3vbEz7r3V/YxH/8XUmdd0JHXBp/aVc/qrqGycYW+mNBJaJp67xXTgWQJEzyStHtZTfQ+vZMw==
X-Received: from qkpb28.prod.google.com ([2002:a05:620a:271c:b0:7eb:c997:f93c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:27c6:b0:7f8:e2d0:308 with SMTP id af79cd13be357-7f8e2df4cecmr1009838885a.43.1756481457907;
 Fri, 29 Aug 2025 08:30:57 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:30:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829153054.474201-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/4] inet: ping: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First and third patches improve security a bit.

Second patch (ping_hash removal) is a cleanup.

Fourth patch uses EXPORT_IPV6_MOD[_GPL].

Eric Dumazet (4):
  inet: ping: check sock_net() in ping_get_port() and ping_lookup()
  inet: ping: remove ping_hash()
  inet: ping: make ping_port_rover per netns
  inet: ping: use EXPORT_IPV6_MOD[_GPL]()

 include/net/netns/ipv4.h |  1 +
 include/net/ping.h       |  1 -
 net/ipv4/ping.c          | 66 +++++++++++++++++++---------------------
 net/ipv6/ping.c          |  1 -
 4 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.51.0.318.gd7df087d1a-goog


