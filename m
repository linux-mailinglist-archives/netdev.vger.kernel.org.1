Return-Path: <netdev+bounces-228008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D452DBBEFA3
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B33C35A2
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31C2D5C95;
	Mon,  6 Oct 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c2HHXXPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703401D618C;
	Mon,  6 Oct 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775494; cv=none; b=WQP/2CvcRQNU7Awniu1mvI1ZoaxIHR/MPipiL/5+ODVhUz4YRVLfztSa0qJ+9B7o9bBxOBPiJSXkU1J6nBuRRdVk8ErLTn/jmQWonvW2v7XALpEhvvv6oFdhB9ryNalAvj1wXOW3ueLm0XLiP6t32nFyfHAvSOWuhbR2mZuFrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775494; c=relaxed/simple;
	bh=LL1G7O8VUcD4wQVITwK1Fm4SqF5xB3ouLMy18HVPstc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6LXKFLP/cQvXAAAuqWaBCr2jMLFHK0RIkJ+hnFcjrbmBIQjObA+BCz42BJsP3OHxifqgfCA/XiLOeDGnOEXCJ7G+jy1FqwqxbtqGCMScy/FZm7rpENJqBwNmC00wPJV01DC3xExwX4lH9Ph3fumSnbvjtYkPNeGaN/t2/8e3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=c2HHXXPt; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759775476; x=1760034676;
	bh=Af3ZT38Ph2vI48UwFFuXqYGeDdiBpQbJJKF7ULiGeSk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c2HHXXPtaJjOm5BGxw5p0pl6fXmIJ4D6XRbfdlwazPCmzqQ/XfAW+TBSfbWhQeHUD
	 GOhlWDNCPD+hHwaZ9pU0kyRhNn+OApK1mhgTLOUG5pXsp3rSPxagdaC75TB0gK9owb
	 JkRF8kqXv/3vNCedihvGGpcQxJ7iqX9dzMQGttOGpzkB7Cf7r2fGHDXj6BJ1SyKI6U
	 b2j6HT2bHXA1jZ6MxBG2mYexEah8k3xPZJrwy6BS68KqqoK7XVGH4suyQ4f4FKYfJ7
	 uzglgTfB2lx3xnafwAMjPvy5MZr7frVzQLB5Tw+8UO2MyCr5P6mErFbiWp7n5pA512
	 l2S7vkfgooH1g==
Date: Mon, 06 Oct 2025 18:31:10 +0000
To: Ido Schimmel <idosch@idosch.org>
From: Dmitry <demetriousz@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "demetriousz@proton.me" <demetriousz@proton.me>
Subject: Re: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty saddr before ECMP hash
Message-ID: <MZruGuax8jyrCcZTXAVhH0AaAMOZ-2Gcj5VeZO8xy8wS9FqwA3EMhPFpHLZs67FAKCu6z3GpEVeArSX2qGdSUqsysI-0o13dKK1ZmUhK_l0=@proton.me>
In-Reply-To: <aOPEYwnyGnMQCp-f@shredder>
References: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me> <aOPEYwnyGnMQCp-f@shredder>
Feedback-ID: 162354254:user:proton
X-Pm-Message-ID: acdde630fc2204899258cb235c8ae3f6bfa5a30e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Two more options (which I didn't test):
>
> 3. Setting "IPQoS" in SSH config to a single value. It should prevent
> OpenSSH from switching DSCP while the connection is alive. Switching
> DSCP triggers a route lookup since commit 305e95bb893c ("net-ipv6:
> changes to ->tclass (via IPV6_TCLASS) should sk_dst_reset()"). To be
> clear, I don't think this commit is problematic as there are other
> events that can invalidate cached dst entries.

I haven't tested this, but I assume it should work, since the IP header isn=
't
changed during an active connection.

> 4. Setting "BindAddress" in SSH config. It should make sure that the
> same source address is used for all route lookups.

Yes, I've tested this one, and it works. I was focused on finding a system-=
level
solution and didn't think about application-level settings.

> As long as all the packets are sent with the same 5-tuple.

The problem is that in the beginning the SADDR remains empty during hash
computation. It appears to be filled later, once the outgoing interface (OI=
F) is
determined.

Let's look at how to reproduce the issue:

Test lab topology:

+-----+   vlan=3D1        +-----+
|     +---------------->|     |
|HostA+---------------->|HostF|
|     |...              |     |
|     +---------------->|     |
+-----+   vlan=3D99       +-----+

HostA lo: 2001:db8:aaaa::
HostF lo: 2001:db8:ffff::

Host A has an ECMP route to 2001:db8:ffff:: with a specified source address
2001:db8:aaaa::, distributed across all VLANs toward Host F. I run git fetc=
h on
Host A to transfer data from Host F.

PCAP Without the fix:

16:34:40.875734 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 98: vlan 49, p 0, ethertype IPv6 (0x86dd), (class 0x48,
flowlabel 0xfdf8e, hlim 64, next-header TCP (6) payload length: 40)
2001:db8:aaaa::.44690 > 2001:db8:ffff::.22: Flags [S], cksum 0x064b (incorr=
ect
-> 0x5490), seq 827400610, win 64800, options [mss 1440,sackOK,TS val 13036=
83318
ecr 0,nop,wscale 7], length 0

<skipped>

16:34:41.566130 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 90: vlan 49, p 0, ethertype IPv6 (0x86dd), (class 0x48,
flowlabel 0xfdf8e, hlim 64, next-header TCP (6) payload length: 32)
2001:db8:aaaa::.44690 > 2001:db8:ffff::.22: Flags [.], cksum 0x0643 (incorr=
ect
-> 0xd980), seq 3570, ack 4031, win 509, options [nop,nop,TS val 1303684009=
 ecr
3265960348], length 0

16:34:41.567338 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 234: vlan 83, p 0, ethertype IPv6 (0x86dd), (class 0x20,
flowlabel 0xfdf8e, hlim 64, next-header TCP (6) payload length: 176)
2001:db8:aaaa::.44690 > 2001:db8:ffff::.22: Flags [P.], cksum 0x06d3 (incor=
rect
-> 0xce55), seq 3570:3714, ack 4031, win 509, options [nop,nop,TS val 13036=
84009
ecr 3265960348], length 144

As you can see, it sends packets through different interfaces =E2=80=94 thi=
s is a
symptom of the issue. In a real environment with multiple physical links (u=
p to
6=E2=80=938 interfaces), the same problem can be observed as well.

I put some prints around ip6_multipath_hash_policy():

PRINTS Without the fix:

Oct 06 16:34:40 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D2109163277

Oct 06 16:34:41 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D2001:db8:aaaa:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D3559450110

Oct 06 16:34:41 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D2001:db8:aaaa:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D3559450110

As you can see, the saddr field is empty at the beginning of the connection=
,
which causes the hash to be different initially.

PCAP With the fix:

16:42:27.624160 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 98: vlan 70, p 0, ethertype IPv6 (0x86dd), (class 0x48,
flowlabel 0xcff07, hlim 64, next-header TCP (6) payload length: 40)
2001:db8:aaaa::.43660 > 2001:db8:ffff::.22: Flags [S], cksum 0x064b (incorr=
ect
-> 0x174e), seq 1032224426, win 64800, options [mss 1440,sackOK,TS val
3603754981 ecr 0,nop,wscale 10], length 0

<skipped>

16:42:28.328572 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 90: vlan 70, p 0, ethertype IPv6 (0x86dd), (class 0x48,
flowlabel 0xcff07, hlim 64, next-header TCP (6) payload length: 32)
2001:db8:aaaa::.43660 > 2001:db8:ffff::.22: Flags [.], cksum 0x0643 (incorr=
ect
-> 0xcd3f), seq 3570, ack 4031, win 66, options [nop,nop,TS val 3603755686 =
ecr
3266427110], length 0

16:42:28.329511 52:54:00:05:66:74 > 52:54:00:8d:24:26, ethertype 802.1Q
(0x8100), length 234: vlan 70, p 0, ethertype IPv6 (0x86dd), (class 0x20,
flowlabel 0xcff07, hlim 64, next-header TCP (6) payload length: 176)
2001:db8:aaaa::.43660 > 2001:db8:ffff::.22: Flags [P.], cksum 0x06d3 (incor=
rect
-> 0x3fd6), seq 3570:3714, ack 4031, win 66, options [nop,nop,TS val 360375=
5686
ecr 3266427110], length 144

As you can see here we have the same vlan.

PRINTS With the fix:

Oct 06 16:42:27 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D2001:db8:aaaa:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D3025767165
Oct 06 16:42:28 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D2001:db8:aaaa:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D3025767165
Oct 06 16:42:28 arch1 kernel: IPv6: fib6 ip6_multipath_hash_policy DEBUG:
src=3D2001:db8:aaaa:: dst=3D2001:db8:ffff:: proto=3D6 hash=3D3025767165

So, with the fix applied, we populate SADDR and calculate the hash correctl=
y.  I
think it's reasonable to respect the src field in the IPv6 route when compu=
ting
the hash.

> I'm not convinced the problem is in the kernel. As long as all the
> packets are sent with the same 5-tuple, it's up to the network to
> deliver them correctly. I don't know how your topology looks like, but
> in the general case packets belonging to the same flow can be routed via
> different paths over time. If multiple servers can service incoming SSH
> connections, then there should be a stateful load balancer between them
> and the clients so that packets belonging to the same flow are always
> delivered to the same server. ECMP cannot be relied on to do load
> balancing alone as it's stateless.

Well, it seems the current implementation doesn't properly respect the SRC =
field
and handles it inconsistently - it is ignored at the start of a session and=
 only
taken into account once the session is established.

> as long as all the packets are sent with the same 5-tuple, it=E2=80=99s u=
p to the
> network to deliver them correctly

If the 5-tuple is not changed, then both the hash and the outgoing interfac=
e
(OIF) should remain consistent, which is not the case. Only with the fix do=
es it
respect the configured SRC and produce a consistent, correct 5-tuple with t=
he
proper hash.

Therefore, in my opinion, this should be fixed.

