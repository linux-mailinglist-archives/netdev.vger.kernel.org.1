Return-Path: <netdev+bounces-164048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88089A2C710
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F9165E3E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356923ED56;
	Fri,  7 Feb 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wVy1Iz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0341F754E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942114; cv=none; b=X/dv4T6+Fel/8w8bLDf5kW7lXHHUW6H3f6/zeMc0JR9TUGrWbVVn71AVenUbV+farDwA08sErBs0VHZjCWaqTGwm5iuRKaxv57mpp0tHxInmgyeN0yxvTdokF+BeGYvz02g7hst6Wm0YJ87peEf0WzkHta4yw990xoWjtaPA9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942114; c=relaxed/simple;
	bh=MNg5t0obD+l9VfmCP+ew1a4B7cWNxQ6zs40edflxk3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mNeKruVRbniylOz73yhVSaR0/hjGn1iO9ht8eU9SEnYzo4uO6t5zOgxs+0z/1yoa+w+gZrN1+G9u5Kc/tCI80B4oBLihybKX2l+ANHe+p+ZmHQNkhDLADo5yms3XqIhaHUhHI50phmYC0VB0cY+nsIRYXC9fiMdlU7C8G83rC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wVy1Iz1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6eabd51cfso332574885a.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942112; x=1739546912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ph0dcDx4Idx2qj7S+NDNtuss91kI7EPeBUIj57hyeYM=;
        b=1wVy1Iz13Bn6orM6yWERNeFDgJlx42+L5yCq724H8bmQ2SHnWlUGWGAhlpNgkYESKj
         hyAHWnsU3MwW22F1ZXRo3SwAWfoHs009W6Kydf3zTq3B5Wm1pDGV2GDfCpM5EVaTvBVA
         SOvbKwubHZQ14EwrPD6mAmObt2FbxXdkmqTT94Nmrg/KrDi5TOoLhsabPPenbbvJpV12
         Ic9292DvJ0czznygJnXt+OVvu+dePZmhY7SWRETsU15iouwJKX0I1RyzLFHyCC9EznX6
         sikrSn71RWEGsxE7Uj4EHoFW1D+VxCiLU3u5Ub9UoZH53ylq39UkJoc0305aW5E50nyV
         avqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942112; x=1739546912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ph0dcDx4Idx2qj7S+NDNtuss91kI7EPeBUIj57hyeYM=;
        b=hL5d23bgQkjW9rv7haaYFTl+WM+cJJ4jHRCrBx/rPdyayr7/WMtfJ8E7Gcqfin2jnJ
         Js3Y5VTAwYILN2lzDKBljI2no09Q77szGNyZBgdUGrEtaZ0VDA+YIP6sfq/LZMSrzB88
         ezwvYf11Yowy6TfaCnY/ORhIDOBmYFfxqfWW8pdhTpFJvbWK3OLUntr3XSagyzls6y/8
         sfnMRykUdaIhykd/kmAxxUnxw8/CYAxzfeuqUP48yZhOsCfl32RXomM5FkHAc64KuE3G
         Do8liY+Hd7IhQRWMnVy2Uw8FEUrj1pKSLj0gYyNnejk+ySxwgPewioGU1a4zZnTA+RYq
         lyvA==
X-Gm-Message-State: AOJu0YwE4dEZNJmccgKzOOUqrC2JA0wFcx23a0UNQhf4aZXNyWsohCPG
	Z1UBExdHk8jRO8L22LDXjenl5PrQkmTUX8NTMK2M/Vwclz7COnmInxLmXtfJEtBeKaJ3UBG6yqs
	OpA2ZAkj1Mg==
X-Google-Smtp-Source: AGHT+IFlbyR0jp/xhYfajHRqCHuy21beiJ7tXSEu5fPiB74msenRkeAe86AySLEHNwniWzBLs+icLc4Bl0t90g==
X-Received: from qkpg3.prod.google.com ([2002:a05:620a:2783:b0:7bf:ff35:5ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:488f:b0:7b6:6765:4ca6 with SMTP id af79cd13be357-7c047c62d56mr525960985a.34.1738942112159;
 Fri, 07 Feb 2025 07:28:32 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] tcp: allow to reduce max RTO
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of a discussion started 6 months ago
by Jason Xing.

Some applications want to lower the time between each
retransmit attempts.

TCP_KEEPINTVL and TCP_KEEPCNT socket options don't
work around the issue.

This series adds:

- a new TCP level socket option (TCP_RTO_MAX_MS)
- a new sysctl (/proc/sys/net/ipv4/tcp_rto_max_ms)

Admins and/or applications can now change the max rto value
at their own risk.

Link: https://lore.kernel.org/netdev/20240715033118.32322-1-kerneljasonxing@gmail.com/T/

Eric Dumazet (5):
  tcp: remove tcp_reset_xmit_timer() @max_when argument
  tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
  tcp: use tcp_reset_xmit_timer()
  tcp: add the ability to control max RTO
  tcp: add tcp_rto_max_ms sysctl

 Documentation/networking/ip-sysctl.rst        | 13 ++++++++
 .../net_cachelines/inet_connection_sock.rst   |  1 +
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/inet_connection_sock.h            |  1 +
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             | 23 +++++++++-----
 include/uapi/linux/tcp.h                      |  1 +
 net/ipv4/sysctl_net_ipv4.c                    | 10 ++++++
 net/ipv4/tcp.c                                | 14 ++++++++-
 net/ipv4/tcp_fastopen.c                       |  4 +--
 net/ipv4/tcp_input.c                          | 19 +++++-------
 net/ipv4/tcp_ipv4.c                           |  6 ++--
 net/ipv4/tcp_output.c                         | 17 +++++-----
 net/ipv4/tcp_timer.c                          | 31 ++++++++++---------
 14 files changed, 93 insertions(+), 49 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


