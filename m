Return-Path: <netdev+bounces-150815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E59EBA86
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232D81663CA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FAD1925AC;
	Tue, 10 Dec 2024 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b="KIfD2+ax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE2757FC
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860816; cv=none; b=g54IOHQ9lPuQQwr4dmoO6alxrIHbTDiZzJCNQSXiLr8tHMzehVMZk2PbF8ieu25Ngjw2JaVQFdjDSwL+62L9D1gxSxiNxbh0p0KauZgj85sU3G5NrMRZOAVa1MHIZA6iVWwwZKD/Ey8dV9tj66SRc+NZGI8JPfhemhzCR4Msc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860816; c=relaxed/simple;
	bh=c3fr1wtzS/5jBuSSNHJMgbRfXvwPi88T4XC02rNSLKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm6lkvD5y+3h50x8dG2VJh7iLe9YB0el4YmbPBBoDlHQ8PbEXLSV258zmurXZcuof6lNdD2V7wGOoEZ+/XcUU7jNHX9aXzUdSVgvQs+u+g/jIDFhwTTPWN6h1nPBxwQg7rFzVlk6O4CEZBcOUork9jqdypgppaRuiNBI+SZCxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com; spf=pass smtp.mailfrom=yourpreston.com; dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b=KIfD2+ax; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yourpreston.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef9b8b4f13so58966177b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yourpreston.com; s=google; t=1733860814; x=1734465614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfQp0JlFTl1xmBKV3vJInXnCkVM3op5a/F/0dP17T2s=;
        b=KIfD2+axHfErkfb6MltoqVZx2ydexzQr8rWETsDgaIrx77v370ZVkwPCkJgXp3QUaV
         tIUjRFxWZzTr9avT1xyr93W/x0wuCXAfAm8y72NdsjemhVNNL7HBbbX14wYtHEYZ+/te
         yJi2rYfQ9LV/TjFMe7GAdh5gSfrUJtofYMDeM20oCAl4TtxGRgg7KuEwwDoX8IbF7oMZ
         ydgQR4882D2t2zr2uYrITCxm0GeiIjSuIwfKaoaTSApg65r2ym+TNbXLGNBaKweFM/Sa
         H3Pkzd9pzU85AnIYiqkPWd18mUeyI3j+cQADrFcpPi75sGROfiNt4/Kg86J/i5WNZGSk
         dX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860814; x=1734465614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfQp0JlFTl1xmBKV3vJInXnCkVM3op5a/F/0dP17T2s=;
        b=bd/UXWkoTLzKG2j9s5DEJ13Cezdu4VVdgEDkGeyKc5iPnfpBHNhrnhh+so4U+EN4mO
         1cjs09IPYB1o/tAUdva0HjsxbBcCXSLqZIIqMdMgVnaIx5vkQUPyADRP75N8lroAPY9G
         Y19G687ZX4CuXkOMbsQkHCj4JHtM6T3wmBVtMWWNHD71haPt9GDRgkIdmR5eF3Qn1rrO
         l9hNSt86450loytJ7QB3R1WCvosnO1YgVH2t9/JY/yUAqQOF+mG0B4DO27HsCOj92GUt
         LgPOFIPsqN7MY25zAfvyTgo0lwpkQ0mdOa3N0PUAZgr6Nm4UICV78g8JjGI52edc1rfR
         snZg==
X-Gm-Message-State: AOJu0YzoWsqiTLtMvlLaEFeYMS31tLztHprQmM3iy3kF3pC6Arms1bH3
	cOg+YRaTqIM/UcXzWPpzgk3Hkh1KEMLA0eOe5uxwQH86oByT83HO59KcKxd33lZkshK3uhHXf2L
	XzXXQAj+ukEm24iKjJa44RzU0TQm/ry0Qo/cY0hqk8OFAsQPz0WM=
X-Gm-Gg: ASbGncu3YhnXnXE3X2ieizp5loqfBA90r9j10JMplvhcGBnhIdEieRvqPj7Zw/qetKE
	ZzVfZJTRH6h0jJNUkrKBjpX9Xem60vtQRkXxorspf+qh8dW0SCBNjdzZ+18IeWyuEuA==
X-Google-Smtp-Source: AGHT+IGTlnRw6KwSWB29tMEmjXSzSCm7lkVWlBZScVgSlKROYYjEXtWXZTe9txtXqe+gHv+rqB1fjLELC+Qld+ePpNw=
X-Received: by 2002:a05:690c:6c0f:b0:6ef:6fef:4cb6 with SMTP id
 00721157ae682-6f147dd350bmr7640637b3.0.1733860813806; Tue, 10 Dec 2024
 12:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
 <3e6af55f-3270-604b-c134-456200188f94@katalix.com> <CABBfie=3+NBmjpVHn8Ji7VakEo9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>
 <ed0ffb72-3848-d1be-6903-d6ab21a0f77f@katalix.com>
In-Reply-To: <ed0ffb72-3848-d1be-6903-d6ab21a0f77f@katalix.com>
From: Preston <preston@yourpreston.com>
Date: Tue, 10 Dec 2024 15:00:03 -0500
Message-ID: <CABBfienZDG=kFMfGe=Awa4ZhuhGTRRy7uGcPjWaZLiGi+XWBDA@mail.gmail.com>
Subject: Re: ethernet over l2tp with vlan
To: James Chapman <jchapman@katalix.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:00=E2=80=AFAM James Chapman <jchapman@katalix.com>=
 wrote:
> Please don't top-post.
Apologies, first timer.
> Are you configuring an IP address on l2tpeth0.1319 and capturing on
l2tpeth0?
I'm running dhclient on  l2tpeth0.1319, the DHCP discover from that is
the packet you see in the screenshot. The pcap is being taken on the
physical interface.


>
> On 04/12/2024 21:04, Preston wrote:
> > l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
> > commands. But since it's encapsulating and setting a new destination
> > IP address, packets are referred to the route table.
>
> Please don't top-post. It makes it much harder for other readers to
> follow the discussion. I'll repaste your reply below this time.
>
> > On Wed, Dec 4, 2024 at 6:48=E2=80=AFAM James Chapman <jchapman@katalix.=
com> wrote:
> >>
> >> On 03/12/2024 16:14, Preston wrote:
> >>> Hello folks, please let me know if there=E2=80=99s a more appropriate=
 place to
> >>> ask this but I believe I=E2=80=99ve found something that isn=E2=80=99=
t supported in
> >>> iproute2 and would like to ask your thoughts.
> >>
> >> Thanks for reaching out.
> >>
> >>> I am trying to encapsulate vlan tagged ethernet traffic inside of an
> >>> l2tp tunnel.This is something that is actively used in controllerless
> >>> wifi aggregation in large networks alongside Ethernet over GRE. There
> >>> are draft RFCs that cover it as well. The iproute2 documentation I=E2=
=80=99ve
> >>> found on this makes it seem that it should work but isn=E2=80=99t exp=
licit.
> >>>
> >>> Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
> >>> work with GRE without issue. L2tp on the other hand seems to quietly
> >>> drop the vlan header. I=E2=80=99ve tried doing the same with a bridge=
 type
> >>> setup and still see the same behavior. I've been unsuccessful in
> >>> debugging it further, I don=E2=80=99t think the debug flags in iprout=
e2's
> >>> ipl2tp.c are functional and I suppose the issue might instead be in
> >>> the kernel module which isn=E2=80=99t something I=E2=80=99ve tried de=
bugging before.
> >>> Is this a bug? Since plain ethernet over l2tp works I assumed vlan
> >>> support as well.
> >>>
> >>>
> >>> # Not Working L2TP:
> >>> [root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 enca=
p
> >>> udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
> >>> [root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_se=
ssion_id 1
> >>> [root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vl=
an id 1319
> >>> [root@iperf1 ~]# ip link set l2tpeth0 up
> >>> [root@iperf1 ~]# ip link set l2tpeth0.1319 up
> >>> Results: (captured at physical interface, change wireshark decoding
> >>> l2tp value 0 if checking yourself)
> >>> VLAN header dropped
> >>> Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png
> >>
> >> This should work.
> >>
> >> In your test network, how is the virtual interface l2tpeth0 connected =
to
> >> the physical interface which you are using to capture packets?
>  >
>  > l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
>  > commands. But since it's encapsulating and setting a new destination
>  > IP address, packets are referred to the route table.
>
> Are you configuring an IP address on l2tpeth0.1319 and capturing on
> l2tpeth0?
>
> >>
> >>>
> >>>
> >>> # Working GRE:
> >>> [root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
> >>> [root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
> >>> 802.1q id 120
> >>> [root@iperf1 ~]# ip link set gre1 up
> >>> [root@iperf1 ~]# ip link set gre1.120 up
> >>> Results:
> >>> VLAN header present
> >>> Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png
> >>>
> >>>
> >>> -------------------------------------------------------
> >>> ~Preston Taylor
> >>>
> >>
> >
>


--
-------------------------------------------------------
~Preston Taylor

