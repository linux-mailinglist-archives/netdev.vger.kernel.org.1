Return-Path: <netdev+bounces-232944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44AC0A066
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 23:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D303B8646
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC26242938;
	Sat, 25 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOHEEaj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918E221FBA
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761427295; cv=none; b=KJswy9XBlhKR0TNOrkjXd4uayppAr96KBQPWNuzsH0+D7gvLVVlHYErIJY/4JtwJ8ebNd2QT6kqT2KXhNYfzBDE0n8PFpiVGoHQAkILEgkHDbAKUQsJ634xVkfpVbT1AcLIwJokuWcMzemDGXXBtdMXrnEnKlEnvPdeOKXI7IEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761427295; c=relaxed/simple;
	bh=THdk1P+dZgAcKvq2yxbgPcQ8y3bQnH89c1+NvJ4lHyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuqbKRg3LWLpGpnf1Ny1CHAeX9aiqe3FR/Kdh7qbEZ6I/nTs2O5w4Ub2tJuZjSU/sBy0BdWL661RNjP03CfUWopBnXVUc8dZ8gulmmpkeEqMeXgeiHWbpjWzg1I9a1z7DV574ItbRtueFwGl3AxahEGvY+mIopIkdkMeleIFLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOHEEaj8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso5076877a12.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761427292; x=1762032092; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykdHhey0gBwyd+qv76DGlWG3Q9ph2W/tZY1aBcKxz0I=;
        b=fOHEEaj8G4CcOdrCjPL4pwodaqHAaG/4AZYagUVtGmDrvBAAfM3batPxL9/HCqHIuF
         b2lP/wSXjw/XqV9AB0HT7oURmtyI4Z44JqQaLbgFKlvKEEG8aExuvxcMzXNDlQdXzPl4
         i7yzTFtmG7udWqoIoUJrHYr/+cv6HUOZ/XCBrjeCzWR6Tb4FH9lV85uZhhE0rd5PWSwU
         aUJFokZQGXFsH72oQq0cM4aUmoxOXg87N0MTQK2Ye4fRpTOgCQy1sE/L90vw8iY4Ew0x
         Mvwd0NXx9x16Q2KZmopi21IYZYVGB7xDJ9OJs6Up2NbknBoEz4/jFWBYqGkqLm1U2qyk
         j47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761427292; x=1762032092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykdHhey0gBwyd+qv76DGlWG3Q9ph2W/tZY1aBcKxz0I=;
        b=jotnYQ21kGXcglTTm+R3UFksMd/46YAKYGKD6MydNZq8zbxiIOtBj2eDs+aCqLfKJj
         Q9kqAMjHxn4ovIaO/ClsfDnFZt9Ymxmzfx+oF55A0uSNZ1ZRDpp2alkScXK9NAgcfrNr
         ixE46yvGoszxe6wkyPX7NzcRin2lC7EGx2qW9mrH+Ey2L1ILdox3iuLBKwbc3SO77M8P
         yU8Ng92ZWLLYajMceOBVzi9PXofR8YVNHQ/i2nzw+5BngQ/0TTcJ+nwrhNE9oR+5uDy3
         oql6Fa65hUHascCORdwivSy5g6FnOufC8WXpcoYVKZmCaKoWR1c8Hx3/bIBPa4mm8r+4
         54ew==
X-Gm-Message-State: AOJu0YyecgwfsLu4KzxWX+I4vVMjRW27ZFZyXoAguQTB0G8Smo5URHj/
	CUmo7l9Lh8gQjNxJB5Qe31OT2mQ1Dby4TObneKjcZJlqYS2AxShyo4rd4O0frVgA
X-Gm-Gg: ASbGnctRh6Z6vWMvSo2dmb3DuyGy2r76LDnNUvp3vxx4e8MSID3Q+DUf0V2zgZ3qFMH
	Hv+eBrntS1kzctYyG+L2XJNJXxR9DIzSzP2dKHKSDhku4yMhFkCkDXFy/P3k2e/f02za1Wj9iNR
	jvCOxbh/Z2XyD8uXJS4i7nAFrnJLZ2A1kvTqvH4SjhGeKjqyE9Utmmlw+G8evlV8faKkxD3H1Pu
	77Wg2ib0+vFAbxgjHOeLIbGx5xu2V2T9kOv/3CCl9cWz7vLdrTqpHsxo6hCRZ3QOwCNpkvT5mhz
	gPoep35ru8WUTPpT03RU7EUssgO9rkrQ9/8A9aKGYojMD0N+wWdIJ0FX8SRGud4Aj+Q/hIP5/hC
	V6wtzq8ls0VGZh8P6spcj/nRbZidUjHRCs48G4jMuSGbG9gY6xOTVwbvw/gp3TWffUFvpzdSd7O
	MXnMDy3eEhXOde+ww7SKrog8KkgPQ20EuB6S+R0Y60pIzgYToXCCeq7MDl6LJPRZhtA5zhP6U6O
	Mhi8hMyNwd9vtpEtEFV28jTLDJg9bAXGrUFuKuLavhxecCdKrODZQqy3w==
X-Google-Smtp-Source: AGHT+IF+LoOzO5+I99LeGXmo9BbnL3Ah9Cg6Mc4yDDVzNaVfvS8PiAZauvafp/N431Ba6FWAGvdsUQ==
X-Received: by 2002:a05:6402:35c6:b0:63c:1e46:75c8 with SMTP id 4fb4d7f45d1cf-63c1f64f482mr33804997a12.10.1761427291481;
        Sat, 25 Oct 2025 14:21:31 -0700 (PDT)
Received: from ?IPv6:2001:1c00:5609:8e00:d43c:e712:50a6:eb5? (2001-1c00-5609-8e00-d43c-e712-50a6-0eb5.cable.dynamic.v6.ziggo.nl. [2001:1c00:5609:8e00:d43c:e712:50a6:eb5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9739sm2524941a12.29.2025.10.25.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:21:30 -0700 (PDT)
Message-ID: <a25e2b7e899b9af7d25ea82f3a553fcc32c12052.camel@gmail.com>
Subject: Re: ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are not cleared
 when static on-link routes are added during IPv6 address configuration
From: Garri Djavadyan <g.djavadyan@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, 1117959@bugs.debian.org,
 	carnil@debian.org
Date: Sat, 25 Oct 2025 23:21:28 +0200
In-Reply-To: <aPzkVzX77z9CMVyy@eldamar.lan>
References: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
	 <0df1840663483a9cebac9f3291bc2bd59f2b3c39.camel@gmail.com>
	 <20251018013902.67802981@phoenix.lan> <aPzkVzX77z9CMVyy@eldamar.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 16:53 +0200, Salvatore Bonaccorso wrote:
> Hi Garri,
>=20
> On Sat, Oct 18, 2025 at 01:39:02AM -0700, Stephen Hemminger wrote:
> > On Thu, 16 Oct 2025 00:12:40 +0200
> > Garri Djavadyan <g.djavadyan@gmail.com> wrote:
> >=20
> > > Hi Everyone,
> > >=20
> > > A year ago I noticed a problem with handling ipv6_route flags
> > > that in
> > > some scenarios can lead to reachability issues. It was reported
> > > here:
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219205
> > >=20
> > >=20
> > > Also it was recently reported in the Debian tracker after
> > > checking if
> > > the latest Debian stable is still affected:
> > >=20
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1117959
> > >=20
> > >=20
> > > Unfortunately, the Debian team cannot act on the report because
> > > no one
> > > from the upstream kernel team has confirmed if the report in the
> > > upstream tracker is valid or not. Therefore, I am checking if
> > > anyone
> > > can help confirm if the observed behavior is indeed a bug.
> > >=20
> > > Many thanks in advance!
> > >=20
> > > Regards,
> > > Garri
> > >=20
> >=20
> > Linux networking does not actively use kernel bugzilla.
> > I forward the reports to the mailing list, that is all.
> > After than sometimes developers go back and update bugzilla
> > but it is not required or expected.
>=20
> Garri, best action would likely be to really post your full report on
> netdev directly.
>=20
> Regards,
> Salvatore


Thank you for your suggestions Stephen and Salvatore.

Below is the full report that was originally posted to the kernel
bugzilla a year ago. It is still reproducible with fresher kernels.

-----BEGIN REPORT-----
I noticed that the ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are
not cleared when static on-link routes are added during IPv6 address
configuration, and it leads to situations when the kernel updates the
static on-link routes with expiration time.

To replicate the problem I used the latest stable vanilla kernel
6.10.6, 2 network name spaces, and radvd with the following
configuration:


interface veth1
{
        AdvSendAdvert on;
        MinRtrAdvInterval 45;
        MaxRtrAdvInterval 60;
        AdvDefaultLifetime 0;
        AdvDefaultPreference low;
        AdvHomeAgentFlag off;
        prefix fd00::/64
        {
                AdvOnLink on;
                AdvAutonomous on;
                AdvRouterAddr off;
                AdvPreferredLifetime 60;
                AdvValidLifetime 120;
        };
};


When I first add a manual IPv6 address to the interface receiving
ICMPv6 RA packets and then receive an ICMPv6 RA with the same on-link
prefix, the packet is silently ignored and no ipv6_route flags,
including RTF_EXPIRES, get set on the static route. Everything works as
expected.

However, if an ICMPv6 RA is received before a static (manual) IPv6
address is set on the interface, and the RA route is installed in the
IPv6 route table, along with the ipv6_route flags RTF_ADDRCONF,
RTF_PREFIX_RT, and RTF_EXPIRES, only the flag RTF_EXPIRES gets cleared
when a manual IPv6 address is configured on the interface later. As a
result, after configuring the IPv6 address, it does not have any
associated expiration time, but the kernel still treats it as an RA-
learned route, so the next received RA packet sets the expiration time
again.

Below are the steps leading to the described issue:


# # Nothing is assigned to veth0 yet
#
# ip -6 addr show dev veth0
#


# # No fd00::/64 routes are present in the IPv6 route table
#
# grep ^fd /proc/net/ipv6_route=20
#=20


# # Received on-link prefix fd00::/64 from the router
#
# tcpdump -v -i veth0 'icmp6[0] =3D=3D 134'
tcpdump: listening on veth0, link-type EN10MB (Ethernet), snapshot
length 262144 bytes

14:01:46.682452 IP6 (flowlabel 0x945ff, hlim 255, next-header ICMPv6
(58) payload length: 56) fe80::5c7f:f5ff:fe03:3b75 > ff02::1: [icmp6
sum ok] ICMP6, router advertisement, length 56
        hop limit 64, Flags [none], pref low, router lifetime 0s,
reachable time 0ms, retrans timer 0ms
          prefix info option (3), length 32 (4): fd00::/64, Flags
[onlink, auto], valid time 120s, pref. time 60s
          source link-address option (1), length 8 (1):
5e:7f:f5:03:3b:75
   =20
       =20
# # The RA route is installed in the ipv6_route structure with the
flags 0x004c0001
# # 0x4c: RTF_ADDRCONF, RTF_PREFIX_RT, and RTF_EXPIRES
# =20
# grep ^fd /proc/net/ipv6_route=20
fd000000000000000000000000000000 40 00000000000000000000000000000000 00
00000000000000000000000000000000 00000100 00000001 00000000 004c0001 =20
veth0


# # The route has a positive expiration time assigned as expected
#
# ip -6 ro
fd00::/64 dev veth0 proto kernel metric 256 expires 93sec pref medium


# # Now, the manual IPv6 address from the subnet fd00::/64 is
configured on the interface
#
# ip addr add fd00::2/64 dev veth0
# ip -6 addr show dev veth0
4: veth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default qlen 1000 link-netns server
    inet6 fd00::2/64 scope global tentative=20
       valid_lft forever preferred_lft forever


# # The ipv6_route entry for fd00::/64 gets updated: the flags are
changed to 0x000c0001.
# # 0x0c: RTF_ADDRCONF, RTF_PREFIX_RT
# # The flag RTF_EXPIRES is removed but the flags RTF_ADDRCONF,
RTF_PREFIX_RT are still set.
#
# grep ^fd /proc/net/ipv6_route=20
fd000000000000000000000000000000 40 00000000000000000000000000000000 00
00000000000000000000000000000000 00000100 00000001 00000000 000c0001 =20
veth0
fd000000000000000000000000000002 80 00000000000000000000000000000000 00
00000000000000000000000000000000 00000000 00000002 00000000 80200001 =20
veth0


# # From user's perspective the on-link route looks permanent, no
expiration time is present
#
# ip -6 ro
fd00::/64 dev veth0 proto kernel metric 256 pref medium


# # Now, the RA packet is received again
#
14:18:13.920115 IP6 (flowlabel 0x945ff, hlim 255, next-header ICMPv6
(58) payload length: 56) fe80::5c7f:f5ff:fe03:3b75 > ff02::1: [icmp6
sum ok] ICMP6, router advertisement, length 56
        hop limit 64, Flags [none], pref low, router lifetime 0s,
reachable time 0ms, retrans timer 0ms
          prefix info option (3), length 32 (4): fd00::/64, Flags
[onlink, auto], valid time 120s, pref. time 60s
          source link-address option (1), length 8 (1):
5e:7f:f5:03:3b:75


# # And the permanent route turned into a temporary one again
(0x004c0001)
#
# grep ^fd /proc/net/ipv6_route=20
fd000000000000000000000000000000 40 00000000000000000000000000000000 00
00000000000000000000000000000000 00000100 00000001 00000000 004c0001 =20
veth0
fd000000000000000000000000000002 80 00000000000000000000000000000000 00
00000000000000000000000000000000 00000000 00000002 00000000 80200001 =20
veth0
#
# ip -6 ro
fd00::/64 dev veth0 proto kernel metric 256 expires 113sec pref medium


# # At this poing, the routes is still reachable
#
# ping -c1 fd00::1
PING fd00::1 (fd00::1) 56 data bytes
64 bytes from fd00::1: icmp_seq=3D1 ttl=3D64 time=3D0.115 ms

--- fd00::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.115/0.115/0.115/0.000 ms


# # After stopping radvd and waiting for 2 minutes, the on-link route
gets unreachable
# # while the manual IPv6 address is still present on the interface
#
# ip -6 ro
fd00::/64 dev veth0 proto kernel metric 256 expires -969sec pref medium
#
# ping fd00::1
ping: connect: Network is unreachable


In some environements, in which RA-sending routers are present and the
RA processing is disabled by the interface init scripts a race
condition may lead to automatic removal of the permanent on-link
routes. For example:

1. The OS boots, RAs are accepted;
2. RA with Prefix Information option (PIO) is received from router #1;
3. the kernel installs a temporary on-link route;
4. the OS's init scripts configure a manual IPv6 address;
5. the kernel removes the expiration time from the on-link route;
6. RA with PIO is received from router #2;
7. the kernel sets the expiration time to the on-link route;
8. the OS's init scripts set 'net.ipv6.conf.xxx.accept_ra =3D 0' for the
interface;
9. the installed IPv6 route is no longer updated by the RAs;
10. the installed IPv6 route expires after N seconds


The problem was first noticed on a Debian system running kernel
5.10.197-1 but was replicated with a vanilla kernel 6.10.6.
-----END REPORT-----

Thank you.

Regards,
Garri

