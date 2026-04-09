Return-Path: <netdev+bounces-277031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLQEGju+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:56:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1183CC460
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2AFF3005D3A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412439023C;
	Thu,  9 Apr 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lATb/rHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDB33B6E3
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746589; cv=none; b=eTeVXZeyqndwmoFFG9nJhmbTD1MhErpA0yCCDucjjxhO8PYO7FaCBJdyGGOjugX4k23hwn7l8s6gzat+b4kuRlNWiyPPvkzjd8KQxMIi6utGA7+cqx77C9FMYoP64hf6zsCWKzUkUv3kys83r3ZbOey7iGXff0N3FKfhq/+4ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746589; c=relaxed/simple;
	bh=u8PF1ec+v/N8IcJVle0Sd5/C3Crk88zhJwwafrTigIg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dArBJtLs+ugO0m5zopv9KD/jswyU/zT/pt+6ijeKm/P4pYGJD8qMUEpTF/VENDCHR4sW3JA+z+GQcb1uBfeJsrc8p0uex9Cav54FI3Rqm6a7lzxfjH1tlwLIXCpKXdWToJ5MhFXoW8EayfLXIWsqJfz9vYQhrXaUno8RBvRMWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lATb/rHm; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8a965acd0b3so31363236d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746587; x=1776351387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmuqOO8HqIa9baqnmopbjyeFDVdfFUJmGwy3/vddSZE=;
        b=lATb/rHmybazAJ+Gw9yLqoczNEiCnYFezoayTnllkRbhjiB6A5aTR5a2iLVmGIORah
         eiT6SNq4dymxlFyND7omWs3HumRQmamLRSN7ijn1HLHpCedkPvVxayO0S811O0+90tgT
         BW5CAanmWR+EA2I1m7jAmJm3aijBw10krd0oieXkMucWpZxikJaLYX3dIQrrUyEozFlD
         pbZIFnrshWTpoRDKGQ71xn5VIdQULunGdGhun4k3khss1FQs8QhdJ73HLcFHgSv/M8Oc
         oFf9yGHbrlaXKWbUBNLV0pnMBaB4zWYfX/rquGtngp/CNK1iGeFaTbPGFEztMjkbGntD
         1yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746587; x=1776351387;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmuqOO8HqIa9baqnmopbjyeFDVdfFUJmGwy3/vddSZE=;
        b=eWp1rv/D6OBOqRTM4fU+TSnGSPV3c15sRVMctd/CD0pUqGK5l2gs10pendBea/CT/B
         PX8cqj93gwSSulJ18LUSiQGVUYsoxfpF3LiIXJ/3tsbWNVdyogU5Au1QgUB+0GcoayMe
         GDcjqIJouieyUmT874AJSQQmp3r/5ROZRMkQ6AKFIuYaskuJkHhpwgpBKShZ9aU1lxPk
         FME7t48VMTbbtCXMFDEBzxjWOmqgJOrTIWjCmzhwEQwwrfclAULwNPtEhrx0e//61E61
         c+48MjwY7qKv5h4YpmHUt6idDxyqWgBQ17X+UiMrnsSaMjb70jSjAzsx6nxGvuYxAXVa
         /UzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMRdKB5cGq7Eg/A92M5LOErDQVEoLvSTRv317fSze/kuVU91/ANfByi/iZLWMdv2gkHfxDWQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45fU+PfIwOLbquDyg5QdhoO6Nw8z/SHtoLjeEfT9s83gYtS5l
	QK80f3ZUWicwoTfcP04qU2GkGMZ4sxDSaUCCffdFgKu68VbtOKfuFF2igFtRH3HhDsMrAx21n/8
	R7x0eBxUfGJB/NQ==
X-Received: from qvbjr2.prod.google.com ([2002:a05:6214:2a82:b0:8ac:7d7a:56fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f0f:b0:8cf:da2d:d6d6 with SMTP id af79cd13be357-8d41d954e20mr3483997985a.36.1775746586615;
 Thu, 09 Apr 2026 07:56:26 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: reduce sk_filter() (and friends) bloat
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277031-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.final:url]
X-Rspamd-Queue-Id: BD1183CC460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some functions return an error by value, and a drop_reason
by an output parameter. This extra parameter can force stack canaries.

A drop_reason is enough and more efficient.

This series reduces bloat by 678 bytes on x86_64:

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.final
add/remove: 0/0 grow/shrink: 3/18 up/down: 79/-757 (-678)
Function                                     old     new   delta
vsock_queue_rcv_skb                           50      79     +29
ipmr_cache_report                           1290    1315     +25
ip6mr_cache_report                          1322    1347     +25
tcp_v6_rcv                                  3169    3167      -2
packet_rcv_spkt                              329     327      -2
unix_dgram_sendmsg                          1731    1726      -5
netlink_unicast                              957     945     -12
netlink_dump                                1372    1359     -13
sk_filter_trim_cap                           889     858     -31
netlink_broadcast_filtered                  1633    1595     -38
tcp_v4_rcv                                  3152    3111     -41
raw_rcv_skb                                  122      80     -42
ping_queue_rcv_skb                           109      61     -48
ping_rcv                                     215     162     -53
rawv6_rcv_skb                                278     224     -54
__sk_receive_skb                             690     632     -58
raw_rcv                                      591     527     -64
udpv6_queue_rcv_one_skb                      935     869     -66
udp_queue_rcv_one_skb                        919     853     -66
tun_net_xmit                                1146    1074     -72
sock_queue_rcv_skb_reason                    166      76     -90
Total: Before=29722890, After=29722212, chg -0.00%

Future conversions from sock_queue_rcv_skb() to sock_queue_rcv_skb_reason()
can be done later.

Eric Dumazet (5):
  net: change sock_queue_rcv_skb_reason() to return a drop_reason
  net: always set reason in sk_filter_trim_cap()
  net: change sk_filter_reason() to return the reason by value
  tcp: change tcp_filter() to return the reason by value
  net: change sk_filter_trim_cap() to return a drop_reason by value

 drivers/net/tun.c      |  8 +++++---
 include/linux/filter.h | 15 ++++++++-------
 include/net/sock.h     | 17 ++++++++++++++---
 include/net/tcp.h      |  6 +++---
 net/can/bcm.c          |  5 ++---
 net/can/isotp.c        |  3 ++-
 net/can/j1939/socket.c |  3 ++-
 net/can/raw.c          |  3 ++-
 net/core/filter.c      | 30 +++++++++++++-----------------
 net/core/sock.c        | 29 +++++++++++------------------
 net/ipv4/ping.c        |  3 ++-
 net/ipv4/raw.c         |  3 ++-
 net/ipv4/tcp_ipv4.c    |  6 ++++--
 net/ipv4/udp.c         |  3 ++-
 net/ipv6/raw.c         |  3 ++-
 net/ipv6/tcp_ipv6.c    |  6 ++++--
 net/ipv6/udp.c         |  3 ++-
 net/rose/rose_in.c     |  3 +--
 18 files changed, 81 insertions(+), 68 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


