Return-Path: <netdev+bounces-174973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2ECA61C52
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3933B28CA
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409A205AA2;
	Fri, 14 Mar 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVw0iJ3B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2F2046B5
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983505; cv=none; b=uypIrHO04WhvnqKk8Bggm3tbeDt/51/duzBGbQ7yMD0w10iMsMajjJpf2yHADFzVwrGqj9OksRy/AjOaePKSn337oUDZet7aUL3NPEzIewuJ4iWk9ERQ3hvXkl+4iev32HIc5nzEJ5MZSvhXK1nhTFYU4VPbK4b8fIHq7NSleWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983505; c=relaxed/simple;
	bh=arg524YUJs0hjW8iyvRoC0evthQ7yBKgyzCWno2KEbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+1zZBHcQn4UUSddaJ8DHQplYjOqLmE4KsfknP5kKBJhBUworAqAbpdj3XTXOX164x/8v7wuoLcH9vHnAckTTvf8ejS9fH9e8bnXXAfrNJi58snScgFRdgZshweaP4lQvOuKofdufVUWC92hShNFR7A1TLhhSvM0lhzolgqhyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVw0iJ3B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so53018245ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741983503; x=1742588303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1zTPh+VSQYAq1rV44toqDFwaON3RyU/6InZ+qGuCfo=;
        b=OVw0iJ3BqzkCr5xKbjKj/JpH6C7wLgA6FGGn4CDUMXb0PHZNdN5E7C8DgOwzh9nQxg
         L5fA1E/0f1wfRdgftlZnaIZgt59/N7QUSzS4/891bcxC//JIAeTuotNw+jJ8sn+kUvKy
         SM7wTaUU2WTmRTEfqU35p2lPbSLva/n5dURgDzaOVUyLCj7VQT+Qt9rBa425yj72Dcyz
         iARdy/1EStJCdWKLk/bJkOWp8hMsA/2gKbs7eQAvSrGyhI5cT1ksg65hLN5yMu9+Ia4s
         70bjY0Y3LUJSequDL9GSKjcp3DNdnWlfYqWAIpf8+S1TptJby7CdZy/ax0hV6biYviPy
         JJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983503; x=1742588303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1zTPh+VSQYAq1rV44toqDFwaON3RyU/6InZ+qGuCfo=;
        b=ldqN8vcdyUpzzeguc/ERXNVVBFWPr/9DVusP2ggLSeJHFaKUXXPNeUfDa2JfmpMMnE
         uKXTwH7q0J7T+sAYVBjAvd/R4nVoB/bLvLvEzqfjFcb+LCQd6mLm5ceL6STDKjPGnGa/
         6+Lykf254KSWzZBAMqMGAMzDE0lFXtkZnxMiCgkTcvGlhqd5lneNkiYD6ABxL+6szONe
         BC+r9rG6i5BYW2cxx1Rrc8JTvtSzdj20yfUtGn1qscbdNb6BbDTh1zOpEXi5Y0LmLrWs
         +1A/qK/RHmU6Cs3ziP1PeEuvNuzPQ8QLHRdb6T+DFGptfvOFD3sV6U27IRK2ylrwrbx2
         /hBA==
X-Forwarded-Encrypted: i=1; AJvYcCVeMeWpCupNzNL5Ra9X3QjjgfLRZLsq+5eL/3eg2RgR9t0mNwzsIuS90cwr/y8OsAStWK7n5XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZehMxpcvRlwivAl/awwdKBEGJG7nOxcnn40K5LmRZJBfl1qzV
	MgRyZ4vcFX9gVnZsv9XhIrsE3gJ1AtNamPfpPENxWRTlZ7OO5cM=
X-Gm-Gg: ASbGncvyaVfW2GDtO99Rz0p5c11HU589GKpHyx/qJBxwEPz776Mr4F/IL9lEOjDJe64
	pzsiLMBxIaDJ4KGGIQm7S5iNosBTDiw8GQOcqQppLAFPM/EOfQ8ky8b7/Lj9A1nOeO8r8k4smVj
	Yk05ZM37HeY+Y+nw89AYCZLqcMHfsU+QXGw1dcrh/9iAwy0fJd+maFpC/FUoXX+e5h3AEAGbZGs
	evVeKHJggSDBu0Ki84JSh6KX0YoUxxkEr5pyE3BwkysiiGnYEiHFVUIQkAK4o0CZWxktr1O523u
	xYPoPC2MjghokT4SnimY+sJbVt1/899bzjCbS7oW1yuf
X-Google-Smtp-Source: AGHT+IF9xkqEfidiY9IiYwG06jnEkp9ffCOs0EmNga4QvDAWT5QS7EZrH0PdsyEe/d46qFV6xdM9Jg==
X-Received: by 2002:a17:902:f711:b0:220:fe51:1aab with SMTP id d9443c01a7336-225e0af4f9cmr56753545ad.38.1741983502659;
        Fri, 14 Mar 2025 13:18:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68a6dfesm32816155ad.71.2025.03.14.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:18:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9SPDT9_M_nH9JiM@mini-arch>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9SB87QzBbod1t7R@debian>

On 03/14, Guillaume Nault wrote:
> On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > On 03/07, Guillaume Nault wrote:
> > > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > > devices in most cases and fall back to using add_v4_addrs() only in
> > > case the GRE configuration is incompatible with addrconf_addr_gen().
> > > 
> > > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > > address") restricted this use to gretap and ip6gretap devices, and
> > > created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> > > 
> > > The original problem came when commit 9af28511be10 ("addrconf: refuse
> > > isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> > > addr parameter was 0. The commit says that this would create an invalid
> > > address, however, I couldn't find any RFC saying that the generated
> > > interface identifier would be wrong. Anyway, since gre over IPv4
> > > devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> > > commit broke their IPv6 link-local address generation when the local
> > > address was unspecified.
> > > 
> > > Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> > > interfaces when computing v6LL address") tried to fix that case by
> > > defining add_v4_addrs() and calling it to generate the IPv6 link-local
> > > address instead of using addrconf_addr_gen() (apart for gretap and
> > > ip6gretap devices, which would still use the regular
> > > addrconf_addr_gen(), since they have a MAC address).
> > > 
> > > That broke several use cases because add_v4_addrs() isn't properly
> > > integrated into the rest of IPv6 Neighbor Discovery code. Several of
> > > these shortcomings have been fixed over time, but add_v4_addrs()
> > > remains broken on several aspects. In particular, it doesn't send any
> > > Router Sollicitations, so the SLAAC process doesn't start until the
> > > interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> > > ignores the address generation mode of the interface
> > > (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> > > IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> > > 
> > > Fix the situation by using add_v4_addrs() only in the specific scenario
> > > where the normal method would fail. That is, for interfaces that have
> > > all of the following characteristics:
> > > 
> > >   * run over IPv4,
> > >   * transport IP packets directly, not Ethernet (that is, not gretap
> > >     interfaces),
> > >   * tunnel endpoint is INADDR_ANY (that is, 0),
> > >   * device address generation mode is EUI64.
> > 
> > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > It seems like it started falling after this series has been pulled:
> > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> 
> Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> current net tree (I'm at commit 4003c9e78778). I have only one failure,
> but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> address generation.") was applied.

On my side I see the following (ignore ping6 FAILs):

bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>

TAP version 13
1..1
# timeout set to 0
# selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
[    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
[   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
[   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
[   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
[   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
[   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
[   17.559477][  T321] GACT probability NOT on
[   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
[   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
# TEST: ping                                                          [ OK ]
# TEST: ping6                                                         [FAIL]
# INFO: Running IPv4 overlay custom multipath hash tests
# TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
#       Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 1 / 12602
# TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12601
# TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
#       Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 1 / 12600
# TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
...

8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>

TAP version 13
1..1
# timeout set to 0
# selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
[   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
[   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
[   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
[   17.629460][  T317] GACT probability NOT on
[   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
# TEST: ping                                                          [ OK ]
# TEST: ping6                                                         [FAIL]
# INFO: Running IPv4 overlay custom multipath hash tests
# TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
# INFO: Packets sent on path1 / path2: 5552 / 7052
# TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 12600 / 2
[   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
# TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
# INFO: Packets sent on path1 / path2: 6650 / 5950
# TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
...

And I also see the failures on 4003c9e78778. Not sure why we see
different results. And the NIPAs fails as well:

https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout

