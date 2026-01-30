Return-Path: <netdev+bounces-255254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB+PAScefWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD6BEB71
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43821306A18E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585463859DE;
	Fri, 30 Jan 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yc9XvCdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105032FD7B1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806988; cv=none; b=r0N5rVi03R9Y43Uo9YxGLRV4bGTOJOefGwFVMvC5sEJrydCkwh7oMHLx1uBJEo37MV23tCktVzJLoKSP1gVbeKeLITXZ7z+0dNywJCCEObGYvHrayxfypIjHYXTxZobpIdWT+A7xy1yLHL3SAksiaxuZNk9JY60aESL6wZWCkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806988; c=relaxed/simple;
	bh=FYr93gd9KKy4aOGobJqE9uypPKJ7LIzV63OubYXh7JU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Evx1XiXUxiaxvI58Z+x5aF1bI2ESjzKMHoAD9zfhRr6ZiygowjVMWD1t3cT+p49IheiiHYPGIFYgW2R6qNSnhKUO2eAaioWsPxEnJ/XImcihs4fy7t3BR0+a0kEZawDlmcWStr9pAHuACX2SlW4PlKr5ZuEx3o6Hg99wk/NAzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yc9XvCdu; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5014ad65e3eso96215211cf.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806985; x=1770411785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+MqVQkI5017zGwEnzpLTgDysFhCEfqgSoHYzqa+HcBw=;
        b=yc9XvCdulfgmCG5Hcu6TBVnfwyrMg08hYFMWAaLuYbgZPw8822VHK8GFsH4vQI7JVo
         /+YXX4tP4LchirER0SGSF1/8afclkSOmbrtRewwxReSWVpaLmBP14W2pXD/+kKBiiUX0
         cFh/56iPbNna/AGtTIHuTZyk/5gtpcKnNNx0t/qMwFHH9FJdT2PjpS42objRBPowXrGK
         r+StpXStZvlUD/3mzRbIW//FJBVYWE7mktAHTbYFRuTc+qKHP8nZQJOK60u/j1L7W1xo
         1zWr06h2Fey7xEuHumT+byHH7VatSa7Ad0ss/jL3ImGAvk2z4G5QOB4l19iqyfBUFVwn
         dqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806985; x=1770411785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MqVQkI5017zGwEnzpLTgDysFhCEfqgSoHYzqa+HcBw=;
        b=HKC3AqjGKsfjixBEdJ/IqcrmJaqO90JP0nJF6v6NTq0tSvn7HNoUrSaZ3JwjLJbR8E
         L1lVfXK/QvS2KNpLShVAti4slA8tcNEq8AWi3Rn2sPa7nOl8VHG+aC5hwiWIxqkI8lIb
         v/yeaN4XIXbd86WbA5G8k8FsOw7Eodp3lc74AhJoQRNhSqxppHekVtUx42NksFkJwlEh
         aaZGefhVgq635B7vdyMQsFA6nPsn02viOlwA0bF1po3itAQN4lg1RUlGxgltd2q6uK6q
         cW86rLotFZXkhITBHt4wuimLqk3vNOeKRz6RVuGm2EWq5+Wd/f6KBDc5srf/w3fROXU2
         DL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAuxLieysLeOL0BX0zYuckVi0llK59Cn7ufogT2aoJ/ABP7XJMfr2p0o513NHBCyvdkkqP3UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DEDuiinOORj8Gik3hOg4WugI9kMy9eQ9cEj8Nf6OSPnBYjSP
	4OqIF+T46Ydui5hFs8SRTH7X0MfSjY9yDobtZrsRqQ2Y/WpOXP94vVXq9Pe1M3P3PJaPBrPNARy
	nKO8f6olo1hPndw==
X-Received: from qtxt1.prod.google.com ([2002:a05:622a:1481:b0:4ff:8ca8:43f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d46:0:b0:4f1:8bfe:e447 with SMTP id d75a77b69052e-505d29bd368mr52970051cf.42.1769806984929;
 Fri, 30 Jan 2026 13:03:04 -0800 (PST)
Date: Fri, 30 Jan 2026 21:02:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] ipv6: misc changes in output path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255254-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CDD6BEB71
X-Rspamd-Action: no action

Small optimizations mostly in ip6_xmit() path.

TX performance increases by about 3 %.

Patches 5-7: add dst4_mtu() and dst6_mtu() to save space.

Last patch colocates inet6_cork in inet_cork_full.

This series reduces kernel size by 494 bytes on x86_64:

scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 4/2 grow/shrink: 9/23 up/down: 665/-1159 (-494)
Function                                     old     new   delta
ip6_finish_output_gso_slowpath_drop            -     197    +197
ip6_xmit                                    1452    1595    +143
do_ipv6_getsockopt                          2855    2950     +95
kzalloc_noprof                                 -      55     +55
ip4ip6_err                                   918     955     +37
__icmp_send                                 1499    1532     +33
do_ip_getsockopt                            2573    2605     +32
__ip6_append_data                           4109    4137     +28
__pfx_kzalloc_noprof                           -      16     +16
__pfx_ip6_finish_output_gso_slowpath_drop       -      16     +16
ipmr_prepare_xmit                           1232    1238      +6
ip6_forward                                 1905    1909      +4
ip6_cork_release                             108     111      +3
ipv6_push_nfrag_opts                         489     486      -3
ipv6_push_frag_opts                           90      87      -3
ip6_finish_output2                          1446    1437      -9
ip6_tnl_xmit                                2639    2627     -12
ip6_default_advmss                           176     160     -16
__ip6_rt_update_pmtu                        1087    1071     -16
tcp_v6_syn_recv_sock                        1715    1696     -19
tcp_v4_syn_recv_sock                        1107    1088     -19
__ip_make_skb                               1339    1320     -19
ip_setup_cork                                406     385     -21
ip6_setup_cork                               732     710     -22
rawv6_push_pending_frames                    581     556     -25
ip6_push_pending_frames                      184     157     -27
udpv6_splice_eof                             203     170     -33
ip6_flush_pending_frames                     220     183     -37
ip6_append_data                              349     312     -37
udp_v6_push_pending_frames                   155     115     -40
sit_tunnel_xmit                             1957    1914     -43
__pfx_dst_mtu                                 64       -     -64
tcp_v4_mtu_reduced                           289     220     -69
tcp_v6_mtu_reduced                           209     139     -70
ip6_make_skb                                 574     484     -90
ip6_finish_output                            827     697    -130
dst_mtu                                      160       -    -160
fib6_nh_mtu_change                           511     336    -175
Total: Before=22584400, After=22583906, chg -0.00%

Eric Dumazet (8):
  ipv6: pass proto by value to ipv6_push_nfrag_opts() and
    ipv6_push_frag_opts()
  ipv6: add some unlikely()/likely() clauses in ip6_output.c
  ipv6: use __skb_push() in ip6_xmit()
  ipv6: use SKB_DROP_REASON_PKT_TOO_BIG in ip6_xmit()
  inet: add dst4_mtu() and dst6_mtu() helpers
  ipv6: use dst6_mtu() instead of dst_mtu()
  ipv4: use dst4_mtu() instead of dst_mtu()
  ipv6: colocate inet6_cork in inet_cork_full

 include/linux/ipv6.h                |   8 ---
 include/net/dst.h                   |   6 ++
 include/net/inet_sock.h             |  10 +++
 include/net/ip6_route.h             |   6 ++
 include/net/ipv6.h                  |  16 ++---
 net/ipv4/icmp.c                     |   2 +-
 net/ipv4/ip_output.c                |   4 +-
 net/ipv4/ip_sockglue.c              |   2 +-
 net/ipv4/ipmr.c                     |   2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c |   2 +-
 net/ipv4/tcp_ipv4.c                 |  13 ++--
 net/ipv6/exthdrs.c                  |  55 +++++++-------
 net/ipv6/ip6_gre.c                  |   2 +-
 net/ipv6/ip6_output.c               | 108 ++++++++++++++--------------
 net/ipv6/ip6_tunnel.c               |   6 +-
 net/ipv6/ipv6_sockglue.c            |   4 +-
 net/ipv6/raw.c                      |   2 +-
 net/ipv6/route.c                    |  10 +--
 net/ipv6/sit.c                      |   2 +-
 net/ipv6/tcp_ipv6.c                 |   9 +--
 20 files changed, 144 insertions(+), 125 deletions(-)

-- 
2.53.0.rc1.225.gd81095ad13-goog


