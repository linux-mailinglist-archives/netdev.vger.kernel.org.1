Return-Path: <netdev+bounces-274257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGcJA7CGzWkregYAu9opvQ
	(envelope-from <netdev+bounces-274257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:57:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0E380696
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4251E302F990
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581936404F;
	Wed,  1 Apr 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6mijIx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52B32ABC0
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076648; cv=none; b=UK5cS8UrZ8MUc1bsjTIgovNdkoQoO6KXmmMeOrOO0MgAUL6soMkIf8fhQu6BcIqbh7RVcN0lzKT5LKog6LsvPAN9vGV8c5IOERGKBM0hX6NHNEEqGY8fRIeAUk3z6sU4IxlhjavGQLHL7V4pJcl7avOzFMYPTFHAGwfssOIElZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076648; c=relaxed/simple;
	bh=ktMqHT24bw1r5kmyz2JATopbIzzfJb9qr1AXckVYhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+3VwHFJrhCcNci8TNkRKcYPbxK//iI4UdYJ7yrjrdJ2EZNFja3QMGZIW86z8x8RobRnqAI7ScHT1W3RRQ/69D+yqMr+tGWnGkZRk3//E8sThRYZzfkiqAcA0raM3EIGJLu9xPUld54u6UN5OrqLD3rxxjoizJ37Z9fJKI1hSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6mijIx3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0c12be0ecso11945ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076646; x=1775681446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjEEKe36C/xvbCnEOY0kz8sYomKUfM5nFzyVZeOUVCo=;
        b=o6mijIx3cqA/UL1aEw1d0WqG9Hc41TsZRVSuWru/DEcuA3Aj6zJh8OvEjV8szaC/Cu
         50JrDo1RSZCyuBFiPw84AznFpDi8YXV5ZzUtVZ2+KIBNdUg6VprmEMX+hxT6zEV1FPla
         hhICInAVis25fZ9SQWPuCGg58S5aisQPJ3UGbTQRje4RIWl9HAEahkLuB31FwdEOxNAY
         srIOMhrJW8tIU1g8/s2VOU5orWLC0rK1XU/duB+qk4MCLdoo1XaEhTEi5a0UsqMqqdg1
         oJHKJooy+K+W8GNMut4XLqCb4W6aynIZmfWXWCRRMPNS3e1PVzT8JPJpeqCTMetTUAWM
         qYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076646; x=1775681446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjEEKe36C/xvbCnEOY0kz8sYomKUfM5nFzyVZeOUVCo=;
        b=QB/NwJjbnSXSSQ5DMeCOQfrnWLEH0UVV8HWh775aB+4VxSLRUL+8zYN0wD3dy9TexG
         aK/tBZE1TpBvsDf4wrLMc07DXEOkygvU3v8QpW4oMSO0yi2tg957NlpHRxcNCRxpKnBy
         5Nmp3hBKAO3ikQZfDT/OPnEnsge56mpEtdXDlzqf3Eyh547Lnbjvnaq6xDSEZbSJBRo/
         4RmTx8atQ6mjYZbrkTKQsRkUamRCDui3r8mC95iblSO/iPKOJF8O/yTYZWFNIwtTiZSS
         td4REtCfkN09tUemX+coMjD4M8vLAr77YvlVEG3LZ7y0znZKuzyrQMsl/GmiCnrOX4+z
         WcJQ==
X-Gm-Message-State: AOJu0Yzoogm9foII6JRAlPsm/WzJ45jexm7aA82uKOE7rVpChCqtwT0n
	pNXA6QSuzUyeY2+EtuZyROOdEpDXjeD0KLMzYrvk0JTbi+VRtn/jHZ2H9Wxhkp4YgA==
X-Gm-Gg: ATEYQzwBtjAIFaJRJtnzDlmzzFX4kXlwdL8OWoGhHjT5sYbI/+RAIGgPx2IRmfHA/62
	3e0/OoumKvBg2xDnR7Tik5fT+8+iHD+odmu8MKPmvwxsD3OTGeO21rpkAkilclFcOHHbgrD+d7Y
	6Ssh+4wzEnIJta7Ypu+qC/AUdlT471mUj+mXI38v/oUYu3dMdnIeeVcyhmXTlBEtrt54ANoEzeE
	qyn65OIAWFWBNsByuBcBqE52j0Gi8ElH2aeABA0aIW6kd1z6nyLuE4vSEwlu5FU3ms45wE6Oj9A
	6yJ5kTGH2kchXhXCiD+4rEOBjZ7oksAHujTXqJDnJOWfli+U2GKtuXulrvMOg7anknccS75NnOL
	9Cw1CIKPEh2UOok/7EFFiUBiSFakUTTVgINd0OgLWg9wV4nfjek8iuEPkziWLN4XOnv2j+5I3g4
	YhOsEcLa+8cA8lmaLqqnunNZ1ysFRcW7zLXKgT9fLCBchgWFbisCdYRuLCFLQrN7r/6M8O
X-Received: by 2002:a17:903:1ac3:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b276aa3b35mr504265ad.1.1775076645947;
        Wed, 01 Apr 2026 13:50:45 -0700 (PDT)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm831961a91.17.2026.04.01.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:50:45 -0700 (PDT)
Date: Wed, 1 Apr 2026 20:50:41 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when
 sk_state == TCP_ESTABLISHED
Message-ID: <ac1qqMc8M96aDORI@google.com>
References: <20260330215707.2374657-1-jrife@google.com>
 <20260330215707.2374657-2-jrife@google.com>
 <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274257-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69D0E380696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 06:21:39PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Mar 30, 2026 at 2:57 PM Jordan Rife <jrife@google.com> wrote:
> >
> > Adjust lookups and scoring to keep their results equivalent to before
> > even if inet_daddr+inet_dport are left intact after disconnecting a
> > socket (sk_state == TCP_CLOSE). sk_state == TCP_ESTABLISHED implies that
> > *daddr is non-zero, so remove redundant checks for that at the same
> > time. Note that __udp6_lib_demux_lookup already checks if sk_state ==
> > TCP_ESTABLISHED, so no change was needed there [1].
> >
> > I could find no discernible difference in performance in
> > udp4_lib_lookup2 before and after the change in compute_score.
> 
> What workload did you test the series with ?

These measurements were taken on the server side while running a netperf
UDP_STREAM test over a 100 Gbps link.

> I think we want to see results under DDoS.

Intuitively, it seems like the performance should be similar.
sk_state resides in the same cache line as inet_daddr, inet_dport, and
sk_v6_daddr, and we trade a comparison with inet_daddr/sk_v6_daddr for
one with sk_state. Of course, code-level intuition can be wrong, so I'm
happy to do some more extensive testing if you feel it's warranted to
make sure that performance isn't regressing.
 
> >
> > (AMD Ryzen 9 9900X)
> >
> > kprobe:udp4_lib_lookup2 {
> >         @start[cpu] = nsecs;
> > }
> > kretprobe:udp4_lib_lookup2 {
> >         @lookup[cpu] = hist(nsecs - @start[cpu], 2);
> > }
> >
> > BEFORE
> > ======
> > @lookup[11]:
> > [80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [96, 112)         364973 |@@@@@@@@@@@@@                                       |
> > [112, 128)         34261 |@                                                   |
> > [128, 160)          7246 |                                                    |
> > [160, 192)           215 |                                                    |
> > [192, 224)           126 |                                                    |
> >
> > AFTER
> > =====
> > @lookup[11]:
> > [80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [96, 112)         340568 |@@@@@@@@@@@@                                        |
> > [112, 128)         30753 |@                                                   |
> > [128, 160)          8019 |                                                    |
> > [160, 192)           231 |                                                    |
> > [192, 224)           157 |                                                    |
> >
> > [1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gmail.com/
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >  net/ipv4/udp.c | 20 +++++++++++---------
> >  net/ipv6/udp.c | 18 +++++++++---------
> >  2 files changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index b60fad393e18..d91c587c3657 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const struct net *net,
> >         score = (sk->sk_family == PF_INET) ? 2 : 1;
> >
> >         inet = inet_sk(sk);
> > -       if (inet->inet_daddr) {
> > +       if (sk->sk_state == TCP_ESTABLISHED) {
> >                 if (inet->inet_daddr != saddr)
> >                         return -1;
> >                 score += 4;
> > -       }
> >
> > -       if (inet->inet_dport) {
> > -               if (inet->inet_dport != sport)
> > -                       return -1;
> > -               score += 4;
> > +               if (inet->inet_dport) {
> > +                       if (inet->inet_dport != sport)
> > +                               return -1;
> > +                       score += 4;
> > +               }
> >         }
> >
> >         dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
> > @@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
> >
> >         if (!net_eq(sock_net(sk), net) ||
> >             udp_sk(sk)->udp_port_hash != hnum ||
> > -           (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
> > -           (inet->inet_dport != rmt_port && inet->inet_dport) ||
> > +           (sk->sk_state == TCP_ESTABLISHED &&
> > +            (inet->inet_daddr != rmt_addr ||
> > +            (inet->inet_dport != rmt_port && inet->inet_dport))) ||
> >             (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
> >             ipv6_only_sock(sk) ||
> >             !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> > @@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
> >         ports = INET_COMBINED_PORTS(rmt_port, hnum);
> >
> >         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > -               if (inet_match(net, sk, acookie, ports, dif, sdif))
> > +               if (sk->sk_state == TCP_ESTABLISHED &&
> > +                   inet_match(net, sk, acookie, ports, dif, sdif))
> >                         return sk;
> >                 /* Only check first socket in chain */
> >                 break;
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 010b909275dd..b93a9a3e7678 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const struct net *net,
> >         score = 0;
> >         inet = inet_sk(sk);
> >
> > -       if (inet->inet_dport) {
> > +       if (sk->sk_state == TCP_ESTABLISHED) {
> >                 if (inet->inet_dport != sport)
> >                         return -1;
> >                 score++;
> > -       }
> >
> > -       if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> > -               if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> > -                       return -1;
> > -               score++;
> > +               if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> 
> This looks unnecessary.

Yep, thanks. This is inverted. It should have been similar to the ipv4
logic where the unnecessary `if (inet->inet_daddr)` check was removed
after adding if `(sk->sk_state == TCP_ESTABLISHED)`:

	if (sk->sk_state == TCP_ESTABLISHED) {
		if (inet->inet_dport) {
			if (inet->inet_dport != sport)
				return -1;
			score++;
		}

		if (!ipv6_addr_equal(&sk->sk_v6_addr, saddr))
			return -1;
		score++;
	}
 
> 
> > +                       if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> > +                               return -1;
> > +                       score++;
> > +               }
> >         }
> >
> >         bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
> > @@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, const struct sock *sk,
> >
> >         if (udp_sk(sk)->udp_port_hash != hnum ||
> >             sk->sk_family != PF_INET6 ||
> > -           (inet->inet_dport && inet->inet_dport != rmt_port) ||
> > -           (!ipv6_addr_any(&sk->sk_v6_daddr) &&
> > -                   !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
> > +           (sk->sk_state == TCP_ESTABLISHED &&
> > +            ((inet->inet_dport && inet->inet_dport != rmt_port) ||
> > +            !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
> >             !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif, sdif) ||
> >             (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
> >                     !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
> > --
> > 2.53.0.1118.gaef5881109-goog
> >

Thanks,
Jordan

