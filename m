Return-Path: <netdev+bounces-99881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891428D6D4D
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E528189E
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C97E79D2;
	Sat,  1 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YZGOMqCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFBEC5
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206168; cv=none; b=LQbwX0JEvlHfRl3KEdLOU+yMvE/HjBK7yEgKbbWS1ymqUC2lbuQY6R9mFkikmK9R/9AFTL6tTruZaaoT7uS25oKgMEHC1eZqq+tFVDOJ6z+hOGj62mDDqr+s+NnSlAREd1dt+OjZFMC1WOfyasGaFjqcf69t7rp/9RFTbOKs2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206168; c=relaxed/simple;
	bh=RtPBGDrjxHAF9pAAHS4/V3G72zZ9pxbAwV6Wa1ILOXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rPPw/+w07baHyegGsnC7oJl7eBLCUvpOf+12DSUgjxgEb6r7PAFTmo1dTxVWoDUMo6gHiA3p5AUDWkoZdjglV/X4PbQrpgSyAglHYhIBLdgs36Rq1/46Dp7z0ja4tyGNdj0jfeGHV4c+nx5Wa05KsM5NZ9ovPm2U89H9nEnq63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YZGOMqCU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a2424ed00so29214547b3.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206164; x=1717810964; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cHPMeLcn44EVetD1HkMPMRNrtYI3nYnKi2QgdwWdQY=;
        b=YZGOMqCUpj0mhzwc5yc54DDa8OKa+pUngzFTy8bHBvKFF2M6l3tk6FAaVJWDLvPm0v
         9+gXSOOgYItVvXVeC7dVBU3kg9bsPxQQu0W0bXu1mhFGbafJZwx1UkmnwTN7gCu0+gfd
         fXc2XPy8FWZacnFjUZ4kYVI8cf9I4silQh5FjA3+qrN6kdGl1lUriH9Tkndta1cbq4th
         +buvxxQu4setuWfzA6lCmkbJhmv8G7eKqciiTzARQU3jEzW7om3aYhmJNMK/6/VvVKs5
         q5/U28/YR0GWrb2P88v2YL0J0dive/M6QUH7X5W5WroMXvpGqqQdMNLVCHMPRBrIcmcK
         uP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206164; x=1717810964;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cHPMeLcn44EVetD1HkMPMRNrtYI3nYnKi2QgdwWdQY=;
        b=C3JyRum2jB1oGaTW3OQq4aIG2bSXxmmYPlhUYyqH39bkxnw7BuEMZ9pEaAXw8nLQhT
         EwFXnUKEVbT5V5gyzJacJHJhbDzxrmxUJAB+4YrEPNYFBTqRRzxrMdHH/eOY7oqwGPnr
         LSsnM7FKPsjeoLaNAKYuyOUAK2ti/48SKlIsfPRl1GKPme33NmQtA5l+sK1sVY/+9Qk7
         6NSOpegopZK8cyH/oR2/lq4jzGkQX51QMLFHO6HY1KXc0pAHGstYoIdcjQZb7+XLjzUb
         8A+yUZFTj6oKlQuPKRCQHAdwKh5PCfWSw1Yvj2fiMYHH8bUqwGifIfb+d1kP24paxHsI
         oUTQ==
X-Gm-Message-State: AOJu0Yz4L+6AqZVr0Ctprm4T7D2V+MUK78cbVHt5w7KxIMFSS/YswH03
	AF1kchsuiHuW+EDPNjV5EkNGJgxlcFly6zn2ftc6karuyKzwQ8q/iY4I/L5EO9BmJsDSlz3gJLI
	9Xb8=
X-Google-Smtp-Source: AGHT+IG7sanvx5FAHKJW1bxvvxPFu/J+Chdp5KgLHMLXg3dhzqi/Xmmf5bGO2qo5XX/yN4elKZ1zBQ==
X-Received: by 2002:a81:400a:0:b0:627:dca5:407b with SMTP id 00721157ae682-62c79708770mr35288347b3.13.1717206163692;
        Fri, 31 May 2024 18:42:43 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766c9ca5sm5321317b3.143.2024.05.31.18.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:43 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:40 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We set up our production packet drop monitoring around the kfree_skb
tracepoint. While this tracepoint is extremely valuable for diagnosing
critical problems, it also has some limitation with drops on the local
receive path: this tracepoint can only inspect the dropped skb itself,
but such skb might not carry enough information to:

1. determine in which netns/container this skb gets dropped
2. determine by which socket/service this skb oughts to be received

The 1st issue is because skb->dev is the only member field with valid
netns reference. But skb->dev can get cleared or reused. For example,
tcp_v4_rcv will clear skb->dev and in later processing it might be reused
for OFO tree.

The 2nd issue is because there is no reference on an skb that reliably
points to a receiving socket. skb->sk usually points to the local
sending socket, and it only points to a receive socket briefly after
early demux stage, yet the socket can get stolen later. For certain drop
reason like TCP OFO_MERGE, Zerowindow, UDP at PROTO_MEM error, etc, it
is hard to infer which receiving socket is impacted. This cannot be
overcome by simply looking at the packet header, because of
complications like sk lookup programs. In the past, single purpose
tracepoints like trace_udp_fail_queue_rcv_skb, trace_sock_rcvqueue_full,
etc are added as needed to provide more visibility. This could be
handled in a more generic way.

In this change set we propose a new 'sk_skb_reason_drop' call as a drop-in
replacement for kfree_skb_reason at various local input path. It accepts
an extra receiving socket argument. Both issues above can be resolved
via this new argument.

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

V1: https://lore.kernel.org/netdev/cover.1717105215.git.yan@cloudflare.com/

Yan Zhai (7):
  net: add rx_sk to trace_kfree_skb
  net: introduce sk_skb_reason_drop function
  ping: use sk_skb_reason_drop to free rx packets
  net: raw: use sk_skb_reason_drop to free rx packets
  tcp: use sk_skb_reason_drop to free rx packets
  udp: use sk_skb_reason_drop to free rx packets
  af_packet: use sk_skb_reason_drop to free rx packets

 include/linux/skbuff.h     | 10 ++++++++--
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/skbuff.c          | 22 ++++++++++++----------
 net/ipv4/ping.c            |  2 +-
 net/ipv4/raw.c             |  4 ++--
 net/ipv4/syncookies.c      |  2 +-
 net/ipv4/tcp_input.c       |  2 +-
 net/ipv4/tcp_ipv4.c        |  6 +++---
 net/ipv4/udp.c             | 10 +++++-----
 net/ipv6/raw.c             |  8 ++++----
 net/ipv6/syncookies.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  6 +++---
 net/ipv6/udp.c             | 10 +++++-----
 net/packet/af_packet.c     |  6 +++---
 15 files changed, 57 insertions(+), 46 deletions(-)

-- 
2.30.2



