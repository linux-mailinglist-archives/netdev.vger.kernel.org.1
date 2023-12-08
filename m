Return-Path: <netdev+bounces-55262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328380A058
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BC2B20B89
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390E114266;
	Fri,  8 Dec 2023 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jh+Y9DFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646731720
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:12:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d942a656b7so24154557b3.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030365; x=1702635165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIpCoOno9ID2pGmqWj8QvRoGYafFYaUQi5CquZyI9E0=;
        b=Jh+Y9DFnRWd0zBkOkIKyj0ikgI+Ezg9T8T5x9w+ZFqUCoaZdR1uGag8rCobocXUDs0
         NlQoPlcydX48dAag35l5T8iRTHgFm7Gwvw4XEY3UWj10MXnJFAiv0qBUwk4L2zRcJNkY
         eQbc7BEu6aGdsBVQErBENZ17keG22QS5DVh5Fa2SKZKPBMeh4ypQYYqRxQBcer8r9O3U
         J6x1PXm6zP7kqtX9eMWehmcfcygS/1AYYNrHEQ/Xw5MO/3HYL+b9HPesQbIHhM8CiEpk
         KWG5IxR9mQESm7nlwFdXNkjCo2pZsSV5LWCROc+YPBpVGc3redYEp10bhb0vI/xXqC0J
         K/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030365; x=1702635165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIpCoOno9ID2pGmqWj8QvRoGYafFYaUQi5CquZyI9E0=;
        b=eoAV/C/cWy/LXIsGN/F/7AxrPcVFL+jblsuNcI0SE7SyOPh3ipAMcMJ8akBXcaw6jf
         pX4eDQgLLTzHOoCqpX6cYc/Md4lp39QOlMZkIVSbbWt6+b/lSvgreoVTfJX5/pJuoVZx
         bCnzP6vHDm+iQVncnLWe+bkRDLKlGZNQXwGONgCLv4qBWxTO3GXrS8mXHGee2Cbf7CwL
         Av59Zp3KK85eDFA0zYfe+6KFzyYANsyigHTuEA1EhOsktQDLm+KVwRpoH7wLShMew9yH
         O7HT7ybFDM1tRwm87W4H3VJt39CufCpz7lVveokGUWDc/7Df/0b9Ac4WGqxY6HioU30B
         z7Ew==
X-Gm-Message-State: AOJu0YyglTvqvzfoXZvnnJ5EW7UhoLjlSdUWoUEdH70VJyGfw4+0KN/b
	kncCMjteLUI1KlBeKBFCDP+I4AqwiPn8hQ==
X-Google-Smtp-Source: AGHT+IGQUa1qoCjKY7FFnia3C8XoK3sBMkh1PFfr8M7VWKH+cnXiyyUBgsgwVsAP0HJMgkZTAu1wTV9x5+gU4w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3184:b0:5d3:7a2b:69ca with SMTP
 id fd4-20020a05690c318400b005d37a2b69camr46167ywb.8.1702030365545; Fri, 08
 Dec 2023 02:12:45 -0800 (PST)
Date: Fri,  8 Dec 2023 10:12:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208101244.1019034-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] ipv6: more data-race annotations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Small follow up series, taking care of races around
np->mcast_oif and np->ucast_oif.

Eric Dumazet (2):
  ipv6: annotate data-races around np->mcast_oif
  ipv6: annotate data-races around np->ucast_oif

 net/dccp/ipv6.c                 |   2 +-
 net/ipv6/datagram.c             |   6 +-
 net/ipv6/icmp.c                 |   8 +-
 net/ipv6/ipv6_sockglue.c        | 132 ++++++++++++++++----------------
 net/ipv6/ping.c                 |   8 +-
 net/ipv6/raw.c                  |   4 +-
 net/ipv6/tcp_ipv6.c             |   2 +-
 net/ipv6/udp.c                  |   4 +-
 net/l2tp/l2tp_ip6.c             |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c |   2 +-
 net/rds/tcp_listen.c            |   2 +-
 11 files changed, 85 insertions(+), 89 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


