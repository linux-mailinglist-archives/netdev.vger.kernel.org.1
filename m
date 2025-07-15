Return-Path: <netdev+bounces-207127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C68B05D25
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D516F4A29C5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C642EA145;
	Tue, 15 Jul 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZZs3Tt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD212E9ED6
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586396; cv=none; b=Y241D5UlqD7G0GMlavWwxqWR6qVYdOL8trnxnCQA59HUlSPGb9AbzZqXQVBsiZO66i0ptqSZ+LQmJ6Qnxr8fBRxjAY3kw8Efbp0YrlJuHN+RXKy6yi2KdNrmyIOAF5GCfFVllrfIU9GvGzwgByNLZZ+oFQnVsO6r7fb0YYFxDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586396; c=relaxed/simple;
	bh=SZ212o1gkv8AQmIKFrNlmJiKHd7N7YPjfMTiE25+Qms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3v9snHzM6j+7OF1gOYMhRsQwyhD0A2jLCdYEV7x9hxgpjKl86j6GUI6/q4oqTL5MZv3E2uqllbtid+yWO9KvMUJSP6U0z8Na3dVe+vjzBEgVcTZVgmTA/tKMkuyITIehXYjQlw0h1MrOzNfhi45Q4wJ4QwodQuR+s40miTd6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZZs3Tt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABADC4CEE3;
	Tue, 15 Jul 2025 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586396;
	bh=SZ212o1gkv8AQmIKFrNlmJiKHd7N7YPjfMTiE25+Qms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZZs3Tt2PpWd+0ALpo/esFjStq3+ZzNL1QHL18f74Raf26qRmAhUPKvOiZWJt6Qcg
	 EEtlJlaESRPQ4PZ3iu6GbUPAFwRFOD/VOeatq4kfDvr1k69mqZ2H9jOp2LI8DvDAwX
	 CsB3/AmVIoH4XpflfrnyyKSeotNfeK7SUIEUgI4hzKRvIJJjG8n0xGl78pJE7xUqUr
	 QnRCfLAv6GJUZsvrIxkbpHIPaZNCorY9JV1dn9lldoaOYLn5bhbDqPfzbXxZqmnIn/
	 YP3QV6P9vCMia77OzyH6rTM2isKv9pZx+AaQoD8WvTkC50GlMce/OQ8auhmGFgqlM7
	 yngfrjRwczEfg==
Date: Tue, 15 Jul 2025 06:33:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, "David S . Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
Message-ID: <20250715063314.43a993f9@kernel.org>
In-Reply-To: <20250715062829.0408857d@kernel.org>
References: <20250711114006.480026-1-edumazet@google.com>
	<a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
	<d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
	<6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
	<20250715062829.0408857d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 06:28:29 -0700 Jakub Kicinski wrote:
> # (null):17: error handling packet: timing error: expected outbound packet at 0.074144 sec but happened at -1752585909.757339 sec; tolerance 0.004000 sec
> # script packet:  0.074144 S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
> # actual packet: -1752585909.757339 S.0 0:0(0) ack 1 <mss 1460,nop,wscale 0>

This is definitely compiler related, I rebuilt with clang and the build
error goes away. Now I get a more sane failure:

# tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expected outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0.005046 sec
# script packet:  1.230105 . 1:1(0) ack 54001 win 0 
# actual packet:  1.190101 . 1:1(0) ack 54001 win 0 

$ gcc --version
gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)

I don't understand why the ack is supposed to be delayed, should we
just do this? (I think Eric is OOO, FWIW)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
index 7e170b94fd36..3848b419e68c 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
@@ -38,7 +38,7 @@
 
 // If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
   +0 < P. 4001:54001(50000) ack 1 win 257
-  +.040 > .  1:1(0) ack 54001 win 0
+  +0 > .  1:1(0) ack 54001 win 0
 
 // Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
 +0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`

