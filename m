Return-Path: <netdev+bounces-264088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULHXMDq+qGmXwwAAu9opvQ
	(envelope-from <netdev+bounces-264088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4C208EF4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DB63018766
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532A35F5EC;
	Wed,  4 Mar 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK/peZyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246A192D97
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666423; cv=none; b=SzTZPn6Yhqc5OTqng8TfFM4sybn7wvYVH3DXYvXMB2wwmNCiDorMzLN/HNxK2kXLTLFUc0ZMZmtCf3LAKP2mZ3PiniLvXSvqfPVdEOT7DsKnpWMfP5tlGXW3OH28WIVfRLhr/+lVRhlrSUf1YcCLrrbiplrpTtl0Jp5c/G9WHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666423; c=relaxed/simple;
	bh=N6CwNH/1Ll4E+iMrSDgBSxPjzIufeMMo9mlW5bsjSVQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SMU/1Sx1LLz9v8OzA8puOc1XPFUEydOEkVDCdJsHdRT/ivHz3rLhLA56jJvSQ9YY/eusNf/b2Vfiy2WOMqAFREDAQHp1PPT8RVt9KN1A+Q/kf8MLQk8ut1DnAdiCfqheY+enMmFami5OcrM09o1vHs4fmUMcGvzkHdH2Lbs7rrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK/peZyh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7985d11da10so75237217b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772666421; x=1773271221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ0dSo3OGPZjyaI48jtjgrlXUnJFsvfdLQ0sLrnrjMk=;
        b=eK/peZyh3Fg4Svq4yMvmzqa5oH+D0XmdXfPmqv62ghCbufCxh/ZEu6uptZrhWMklr0
         iCCyJ0vjHTiUqNFpWm7C0z+8GlvzLGKsZw0+uCECUK+gv+WZv8a6Hkt4ZuEW1NirWFNv
         iCZlxyhZIjQ6dc6lClzPzGZT/05Z3MOeLlOn9BnKYotplVmW/sHfXOqCzkeApmhlUE7/
         JOsPjq8OfD+j9vFcp1x9OYt+q85enPjhRr23ODyc5BMhIJsosv0YZ5f5XxMFKpSRC+GV
         whl5a5ONwgDeKLMVNhGyIgexcYgEzHAgTLhFk3gGoklgAyykmtOnEurozLgUr1far7/L
         v3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666421; x=1773271221;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ0dSo3OGPZjyaI48jtjgrlXUnJFsvfdLQ0sLrnrjMk=;
        b=uxkY50bPjDp0ZazrppI+MIVpB88R7Cvhq91BVn51Fx5rYy2PFnRYpWtp+lGlvEbYHD
         lhqovBojSbMSWBBwSAshzTCIBc0ElHvx/0j7vqBU7NEuaq5runXoPl7JNe5YxNhBFPJk
         dTWZHQL1JbsBhF7+GHvKN0gyQHBtwHv06wn/IsGAN8Lmx80UgsDCIDewnGTiOq1QoF4/
         kLJAGv5iwMo+1sWviJ++P50seVbwH55lZBsVH0MArro73M0qEy8LBidGB04hcdwOL5ZS
         NgXbcucpcGkOD+JKCMQA0YaA3MLZdnzpOcC5+l4f8kX5vp4KNJ31/fr997ClYEcMw9LJ
         T3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVZqFyx+OwwDwrUubRMO6DNbiEZ2il5rUEbHrTCt8gG25Nr7uBYdgcr7tO00VEpPX+C8dNMMnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJuPKIHVqap34TIx1RURt1BClYfCOjN3hh1Vgp5quoFh5VZwW
	I5Fv50bCIxaDom5EPpE22FzC3tsc0+aIGbQXgM7bEeKPflqpj91tYLPN
X-Gm-Gg: ATEYQzysdEK3+kBZSJxrTFfc3g+ZOGjqaEsG9L+TzSRKajvTv8lGPAg3jLQAPHpW/r9
	ObkjmyAhw+0KP0BDP8JVAM2SPEovklXdlFVWCJDuQs2LXw9FJUpkbdhMCQLXVA6mq6FS8xGBhS7
	pATh0TXizbvXIG62gGCQSGXYioTiBjy9W1pumc7u13pg8T/uLZeIXxYe64rf2Oo1kDhHuBCt2yG
	aVd47Ykp+BIN2KhPWHpidG2WB0zHjvkon/Xd9sLwz0dt0fMpKc2mbu41j1gBG2+SOc/sVxVibQK
	iCOwZBf3pr3fTj3lt08pnIMA9a8TA6VlrOps9gIJd+L6XFfZDGuZuJzSnduhIyPjt29wKz7Leu+
	Ny+A2TQXAbLvP1GUHONKWr+h+/0VkvetVXMVdrn+MSxnBHKneHichhJ93QrHd5lcxL0pwgN0Jgs
	d/OmtZvpNip8cE7zuAHUWjosOjYUAsqsfU6JC+ArVdtuhI3vRkh9rZcvTA1ctonUX1Z1KyJNw=
X-Received: by 2002:a05:690c:46c2:b0:794:7210:61dc with SMTP id 00721157ae682-798c6d0038cmr28467597b3.66.1772666421482;
        Wed, 04 Mar 2026 15:20:21 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876a8fe80sm81230677b3.9.2026.03.04.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:20:20 -0800 (PST)
Date: Wed, 04 Mar 2026 18:20:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1801cea2f62f8@gmail.com>
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
References: <20260304193034.1870586-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 00/15] udp: Retire UDP-Lite.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 29C4C208EF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264088-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,kernel.org,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Kuniyuki Iwashima wrote:
> In 2023, syzbot found a null-ptr-deref bug triggered when UDP-Lite
> attempted to charge an skb after the total memory usage for UDP-Lite
> _and_ UDP exceeded a system-wide threshold, net.ipv4.udp_mem[1].
> 
> Since this threshold is shared with UDP, the bug would have been
> easy to trigger if any real-world applications were using UDP-Lite;
> however, only syzbot ever stumbled upon it.
> 
> The bug had persisted since 2016, suggesting that UDP-Lite had
> remained unused for 7 years at that point.
> 
> The bug was fixed in commit ad42a35bdfc6 ("udplite: Fix NULL pointer
> dereference in __sk_mem_raise_allocated()."), and we added another
> commit be28c14ac8bb ("udplite: Print deprecation notice.") to
> announce the deprecation plan.
> 
> Since then, no one has complained, so it is time to officially
> retire UDP-Lite.
> 
> This series first removes IPv6 and IPv4 UDP-Lite sockets, then
> gradually cleans up the remaining dead/unnecessary code within
> the UDP stack.
> 
> By removing a bunch of conditionals for UDP-Lite from the fast
> path, udp_rr with 20,000 flows sees a 10% increase in pps
> (13.3 Mpps -> 14.7 Mpps)  on an AMD EPYC 7B12 (Zen 2) 64-Core
> Processor platform.
> 
> [ With FDO, the baseline is much higher and the delta was ~3%,
>   20.1 Mpps -> 20.7 Mpps ]
> 
> Before:
> 
> $ nstat > /dev/null; sleep 1; nstat | grep Udp
> Udp6InDatagrams                 14013408           0.0
> Udp6OutDatagrams                14013128           0.0
> 
> After:
> 
> $ nstat > /dev/null; sleep 1; nstat | grep Udp
> Udp6InDatagrams                 15491971           0.0
> Udp6OutDatagrams                15491671           0.0
> 
> $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
> add/remove: 13/75 grow/shrink: 11/75 up/down: 13777/-18401 (-4624)
> Function                                     old     new   delta
> udp4_gro_receive                             872     866      -6
> udp6_gro_receive                             910     903      -7
> udp_rcv                                       32    1727   +1695
> udpv6_rcv                                     32    1450   +1418
> __udp4_lib_rcv                              2045       -   -2045
> __udp6_lib_rcv                              2084       -   -2084
> udp_unicast_rcv_skb                          160     149     -11
> udp6_unicast_rcv_skb                         196     181     -15
> __udp4_lib_mcast_deliver                     925     846     -79
> __udp6_lib_mcast_deliver                     922     810    -112
> __udp4_lib_lookup                            973     969      -4
> __udp6_lib_lookup                            940     929     -11
> __udp4_lib_lookup_skb                        106     100      -6
> __udp6_lib_lookup_skb                         71      66      -5
> udp4_lib_lookup_skb                          132     127      -5
> udp6_lib_lookup_skb                           87      81      -6
> udp_queue_rcv_skb                            326     356     +30
> udpv6_queue_rcv_skb                          331     361     +30
> udp_queue_rcv_one_skb                       1233     914    -319
> udpv6_queue_rcv_one_skb                     1250     930    -320
> __udp_enqueue_schedule_skb                  1067     995     -72
> udp_rcv_segment                              520     480     -40
> udp_post_segment_fix_csum                    120       -    -120
> udp_lib_checksum_complete                    200      84    -116
> udp_err                                       27    1103   +1076
> udpv6_err                                     36    1417   +1381
> __udp4_lib_err                              1112       -   -1112
> __udp6_lib_err                              1448       -   -1448
> udp_recvmsg                                 1149     994    -155
> udpv6_recvmsg                               1349    1294     -55
> udp_sendmsg                                 2730    2648     -82
> udp_send_skb                                 909     681    -228
> udpv6_sendmsg                               3022    2861    -161
> udp_v6_send_skb                             1214     952    -262
> ...
> Total: Before=18446744073748075501, After=18446744073748070877, chg -0.00%
> 
> 
> Kuniyuki Iwashima (15):
>   udp: Make udp[46]_seq_show() static.
>   ipv6: Retire UDP-Lite.
>   ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
>   ipv4: Retire UDP-Lite.
>   udp: Remove UDP-Lite SNMP stats.
>   smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
>   udp: Remove partial csum code in RX.
>   udp: Remove partial csum code in TX.
>   udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
>   udp: Remove struct proto.h.udp_table.
>   udp: Remove udp_table in struct udp_seq_afinfo.
>   udp: Remove dead check in __udp[46]_lib_lookup() for BPF.
>   udp: Don't pass udptable to IPv6 socket lookup functions.
>   udp: Don't pass udptable to IPv4 socket lookup functions.
>   udp: Don't pass proto to __udp4_lib_rcv() and __udp6_lib_rcv().
> 
>  include/linux/udp.h        |  10 +-
>  include/net/ipv6.h         |   2 -
>  include/net/ipv6_stubs.h   |   7 +-
>  include/net/netns/mib.h    |   5 -
>  include/net/sock.h         |   5 +-
>  include/net/transp_v6.h    |   3 -
>  include/net/udp.h          |  86 +++-----
>  include/net/udplite.h      |  88 --------
>  include/uapi/linux/udp.h   |   1 +
>  net/core/filter.c          |   5 +-
>  net/ipv4/Makefile          |   2 +-
>  net/ipv4/af_inet.c         |  12 --
>  net/ipv4/proc.c            |  16 --
>  net/ipv4/udp.c             | 426 ++++++++++++-------------------------
>  net/ipv4/udp_bpf.c         |   2 -
>  net/ipv4/udp_diag.c        | 128 +++--------
>  net/ipv4/udp_impl.h        |  27 ---
>  net/ipv4/udp_offload.c     |   3 +-
>  net/ipv4/udplite.c         | 135 ------------
>  net/ipv6/Makefile          |   2 +-
>  net/ipv6/af_inet6.c        |  32 +--
>  net/ipv6/ip6_checksum.c    |   2 +-
>  net/ipv6/ipv6_sockglue.c   |  17 +-
>  net/ipv6/proc.c            |  16 --
>  net/ipv6/udp.c             | 305 ++++++++++----------------
>  net/ipv6/udp_impl.h        |  31 ---
>  net/ipv6/udp_offload.c     |   3 +-
>  net/ipv6/udplite.c         | 139 ------------
>  net/rxrpc/output.c         |   2 -
>  security/smack/smack_lsm.c |   4 +-
>  30 files changed, 339 insertions(+), 1177 deletions(-)
>  delete mode 100644 include/net/udplite.h
>  delete mode 100644 net/ipv4/udp_impl.h
>  delete mode 100644 net/ipv4/udplite.c
>  delete mode 100644 net/ipv6/udp_impl.h
>  delete mode 100644 net/ipv6/udplite.c

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for this thorough cleanup Kuniyuki. No major concerns from me.
Left a small comment about documentating deprecated constants, iff
respinning.

