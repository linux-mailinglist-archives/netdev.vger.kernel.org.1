Return-Path: <netdev+bounces-99563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CE8D54BD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4035B2218D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF218306F;
	Thu, 30 May 2024 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FcquoAme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC242E85A
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105619; cv=none; b=RmSB8xOIq6VO9QEuEAlTbyTkpV1bxeeYnWuhQwky+dtI5MAZqzyiWfV2zNB6X1blRMtrvOBKsvbrSGaHpqhbocYG145qzGSf6Ki4eQ0OT/FP0Xhb+enMSjHfGW3mUbOiSLpKUwEG62MnKMMSkONY0o5b624EbM8R8LBRboS3k3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105619; c=relaxed/simple;
	bh=PCtXbe0h4/GG8mxMBQ8PPq48bwhyZuUXEWugmZ3umHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YelYy0DLGMUvyJdUuhv7MTBuMmDIPR+auC/3nOTUUbB3flAeDa2pzfbcgoPjOWvWOAHLwVUUogLnzp7ZzwvE+8OgNRFDsKWwZw4xOUGc55hEz4CtY2rnQBm0escSQTfFsX8ijvGVS91O4TJp/sPJTv2FdrVzp3HopCIffJEk5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FcquoAme; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so7666516d6.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105616; x=1717710416; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+hGbEM+fsi1EeTk/F7iSCEszhWuMBnEsqNB1vusLac=;
        b=FcquoAmetY6eldxavbnVAF07BtjHgnzejL4f69WW+2gTxQEhHoDVFOINCpfMhvZRmi
         wC3LPS8yuv8BIYvcEBs3LgbcKRFGKgFoPWEAqrNAY+ORRX15J/0cRPrErK/dXOyN7qKn
         8QO6T3JHBxsxzDPLVEfq+bU8CJ5Q0+1XVurJiSQViNTgAoX19S5m5xmyejgpbvQP1j0k
         NEPKk7BW2O5XzTFXkgVg8KJjIW5dpnft0Mg1ih5osk0QbMKQyEJ4ueJX+VVxmy0wqzFJ
         JrgCF8J0CeZDEoWydJDvc/frNram9keTG5MWrkK66jYv8XX1dRYfpBFJTT11n3aAiboq
         AYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105616; x=1717710416;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+hGbEM+fsi1EeTk/F7iSCEszhWuMBnEsqNB1vusLac=;
        b=sXplIdP+huMwRup6qyR613yBfErru7FZNV6wf1qu74HL/7R7fa+Se5V8oOg84qn4ck
         W2Gux+edQBYR3nfJkLEEm4NQMuo3Onh3hX/EEOJGACawCNp5GrPYi9/Ol412D5lGmW8U
         8ZgNBJ8Zr844wUap1ludXLHXL+1il//V1gW0jqvuGJ9+9vqdUriO/5ZqbI94yYH+WPAa
         9e6iJva6vDs5w6doMMQTPZACL9o7NHf5r4xGQjYXJLbemLad1Dz72/l24q7iEW8tqfRp
         yH/Zoy80+zZmjRuf1iJDaDidq2nNc7ALNNfqTDDIrMCcxq2/aYAL+nBrtox4Pzg0Kzl4
         ql5w==
X-Gm-Message-State: AOJu0YwuHAmf2jxYLtYU6Tl+4In4AYcZgRebpVW893OBVJUXw21GxSMQ
	KcD8SfK4IhgL3LMUNP0QlgKnl+t6kDovIYOYsC8Tl2G4bHDZtHWUuVU/lBs/yk/kjrY6FjDaFpu
	UfbE=
X-Google-Smtp-Source: AGHT+IGA+5z8EvlVM17m7A1gpNDDe3MH79lfJJS0F7/GHSOlJrV/5W7j0m+nQ9GfYwwVDjefFUWvsw==
X-Received: by 2002:a05:6214:440b:b0:6ad:9e54:e70f with SMTP id 6a1803df08f44-6aecd6f08aamr1779126d6.50.1717105616070;
        Thu, 30 May 2024 14:46:56 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a7466a7sm1908696d6.44.2024.05.30.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:46:55 -0700 (PDT)
Date: Thu, 30 May 2024 14:46:53 -0700
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
Subject: [RFC net-next 0/6] net: pass receive socket to drop tracepoint
Message-ID: <cover.1717105215.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greeting!

We set up our production packet drop monitoring around the kfree_skb
tracepoint. While this tracepoint is extremely valuable for diagnosing
critical problems, we find some limitation with drops on the local
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

In this change set we propose a new 'kfree_skb_for_sk' call as a drop-in
replacement for kfree_skb_reason at various local input path. It accepts
an extra receiving socket argument, and places the socket in skb->cb for
tracepoint consumption. With an rx socket, it can easily deal with both
issues above. Using cb field is more of a concern that a tracepoint
signature might be a part of stable ABI, but please advise if otherwise.

Yan Zhai (6):
  net: add kfree_skb_for_sk function
  ping: pass rx socket on rcv drops
  net: raw: pass rx socket on rcv drops
  tcp: pass rx socket on rcv drops
  udp: pass rx socket on rcv drops
  af_packet: pass rx socket on rcv drops

 include/linux/skbuff.h | 48 ++++++++++++++++++++++++++++++++++++++++--
 net/core/dev.c         | 21 +++++++-----------
 net/core/skbuff.c      | 29 +++++++++++++------------
 net/ipv4/ping.c        |  2 +-
 net/ipv4/raw.c         |  4 ++--
 net/ipv4/syncookies.c  |  2 +-
 net/ipv4/tcp_input.c   |  2 +-
 net/ipv4/tcp_ipv4.c    |  4 ++--
 net/ipv4/udp.c         |  6 +++---
 net/ipv6/raw.c         |  8 +++----
 net/ipv6/syncookies.c  |  2 +-
 net/ipv6/tcp_ipv6.c    |  4 ++--
 net/ipv6/udp.c         |  6 +++---
 net/packet/af_packet.c |  6 +++---
 14 files changed, 93 insertions(+), 51 deletions(-)

-- 
2.30.2



