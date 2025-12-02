Return-Path: <netdev+bounces-243244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D9C9C341
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055543A56A5
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECC298CAF;
	Tue,  2 Dec 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fpwHH3EZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A128640F
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692929; cv=none; b=ObiwvEXpJynOlPdezkuX91qeMDf04RQbY/X1nuT5mBe42sR23p31MtUaI91YaNFt1YcH3e9gpG077YJNiJkwTHHapWiXnwlTYMz5HDtWPfo5ragVlV/1GhZfhjhlyncBVQzEkVVTRB5f+Yb+iYHHBDr5M2JBsR0F7jXv5vVIFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692929; c=relaxed/simple;
	bh=kD390ooNLHbN4Jmys4fVkXFaVLOirI49yf1vt9Pc7mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jqszoYLsRob5Nsyv5ywZWcK1RcebJjlamyZMDbAh8Xcmss5nPZeeuyrerRgal0b9rni7hsifQFCOHFtHi9pbwpPgp7Y22OoHK+1YnfQaPVgs/FlbhG0egVh4VvkfCpKJzmulj95VUvCU7QKoWpdTN7SIKu9zadYk1yAH/GKaeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fpwHH3EZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso39565185e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764692926; x=1765297726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4N4egFc7xMOL4K643AEqRGrz/gWrW82OctMBiQ+vKY=;
        b=fpwHH3EZqwiM+FzWbWGlU/D2UMJ+2XB7RMPG7mtXF5RhcQmuUyk3KXSKMO8E54NnYi
         fNw6qY9TaJzYiNazHjZh2mW4wLMoaaCkt4CLs8iBR07fdMcg9RuQH8Kq3/Bh3StJAp2G
         FYRedz/eGbJTRhobAAFGkxWU2/99kEfCmAxfXjYeHhMSnaf+59l4ffxsRCEU9R3PX5qW
         PF0akTKsonKwo1fIkHOvbJb7BZgKd24RhRRv+u9E+CPw1VdzAGhauK1TKsFO19e04/cp
         ziaRxJFXtQbvHB03yMtZP2J4ut3c+Ke51QL91tsAG+l1tz6Qv9xTO4o81g4A3bVCconR
         J03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692926; x=1765297726;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4N4egFc7xMOL4K643AEqRGrz/gWrW82OctMBiQ+vKY=;
        b=fZywwIW1SRQW33bh7tfD5OWKYEas9+ZWdHLDNPUFyQYG8A3eCDQs0AM+Nf6goZGxou
         5WFKxEzZY+nBRUUaxUzUQ9M3VpfC6JM1Zd7xPBBJLrK1p2IvmylZ8yk0rRn3K2DTkQMO
         QAInEOfh+V8alOJYbibXUH84t3UCaCojCQvi8LOn0pOjTEbqfton05kQTVY4l9oxBOkN
         WQxGlXIDMSBcRaGb7qknxfKMDqIv4dR/yFHIgHRFZslbyAl+6+QZYKxcsXCVBk2aDNOm
         kEHlYxmYpxv670tg/JFTOfy2AgZqeh1id1lyqpo38oCQ3ClgqKLKYqCWcVLZ7j/EK8nn
         fYRA==
X-Gm-Message-State: AOJu0YwyKIZWbAmBRPQgLM/CS8OetMgqcr4juw3SRRYaxg/Qw7MxJbiZ
	e+2wOottl57B84fWAjcPhWNj1d2hBbo60a+q3tVTMXMp94/AHoiOg0JlsH4JZyJ2ZSU=
X-Gm-Gg: ASbGncv9p/hdm6ogU87rlejJCDNvwKtkiSeHdQM85+9CambqsLdr57vSRx9o7CGn0gz
	i29+P/0A3kL2NTC2EzJKv+2fsIorbjdY/3JDrHwwNvZEBWmt4sqTMKVSubDafN6BfK/1yPVncPe
	Jm+ZLAGSo1mALk1tZm13nccrA+l1SE8z9rrMKX/Ih2MCj4LnMMI0crgLGbpSWubCWcS4pIuNX/E
	WRQ7YXfqnQ+65zhorR+QBIwi0HuWED8v5w/XKCZsPLek3FNaNjOYLekPa7FiRZ3bfFBD02nkSqr
	YYS7S1k6WqMrYYIC639J0KTZ7n4Jnzz2tE+ElH73Rv6TKdoiBTEvzj2ONPeUE7v+aNyhuKIR5IY
	NNvcQjOIf2Oc02kuH/cj8B0dUbAmF41DlzUIog+GIfqfD+RtS7aWhf7E7k15PLXvzOR0WZIgPGF
	XFRmZBWaH/Fek9qAXzjoVX2vjYihKDEYDMu2WMYMil+lUStgT2yqa72q846g==
X-Google-Smtp-Source: AGHT+IHEohgWVxrJC3wUv+1UfUF+h+k1su5DH7oY04hLernsePLI1x0ZeQB/gl1hU6F3ciGyD0yOMw==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr320424965e9.24.1764692926009;
        Tue, 02 Dec 2025 08:28:46 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm34377742f8f.11.2025.12.02.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:28:45 -0800 (PST)
Message-ID: <b7c7ee0c95241155dfa5f461d58b1bfd072a901b.camel@mandelbit.com>
Subject: Re: [RFC net-next 11/13] selftests: ovpn: add test for bound device
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:28:45 +0100
In-Reply-To: <aSg2L5eAAEhyHMxM@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-12-antonio@openvpn.net> <aSg2L5eAAEhyHMxM@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 12:29 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:42 +0100, Antonio Quartulli wrote:
> > From: Ralf Lici <ralf@mandelbit.com>
> >=20
> > Add a selftest to verify that when a socket is bound to a device,
> > UDP
> > traffic from ovpn is correctly routed through the specified
> > interface.
> >=20
> > The test sets up a P2P session between two peers in separate network
> > namespaces, connected via two veth pairs. It binds to both veth
> > interfaces and uses tcpdump to confirm that traffic flows through
> > the
> > expected paths.
>=20
> The current setup doesn't really test that, since it would also work
> without SO_BINDTODEVICE (traffic still flows through the expected veth
> if I pass "any" instead of veth1/veth2 to the new_peer commands).

Thanks for catching this. I see the issue and will try a different
approach in the next version of the patch.

> [...]
> > diff --git a/tools/testing/selftests/net/ovpn/common.sh
> > b/tools/testing/selftests/net/ovpn/common.sh
> > index d926413c9f16..c802e4e50054 100644
> > --- a/tools/testing/selftests/net/ovpn/common.sh
> > +++ b/tools/testing/selftests/net/ovpn/common.sh
> > @@ -66,9 +66,11 @@ setup_listener() {
> > =C2=A0}
> > =C2=A0
> > =C2=A0add_peer() {
> > +	dev=3D${2:-"any"}
>=20
> nit: no user of add_peer is patched to pass this extra argument

Yes, I initially considered using this function for test-bind.sh but
later abandoned the idea. I'll remove the argument since it's not
needed.

> > diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh
> > b/tools/testing/selftests/net/ovpn/test-bind.sh
> > new file mode 100755
> > index 000000000000..fd7c3c8fdf63
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ovpn/test-bind.sh
> > @@ -0,0 +1,103 @@
> [...]
> > +run_bind_test() {
> > +	dev1=3D${1}
> > +	dev2=3D${2}
> > +	raddr4_peer1=3D${3}
> > +	raddr4_peer2=3D${4}
> > +
> > +	touch /tmp/ovpn-bind1.log
> > +	touch /tmp/ovpn-bind2.log
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1 2>/dev/null
> > || true
> > +	ip netns exec peer2 ${OVPN_CLI} del_peer tun2 10
> > 2>/dev/null || true
> > +
> > +	# close any active socket
> > +	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10
> > 1 ${raddr4_peer1} 1
> > +	ip netns exec peer1 ${OVPN_CLI} new_key tun1 1 1 0 ${ALG} 0
> > data64.key
> > +	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1
> > 1 ${raddr4_peer2} 1
> > +	ip netns exec peer2 ${OVPN_CLI} new_key tun2 10 1 0 ${ALG}
> > 1 data64.key
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} set_peer tun1 1 60 120
> > +	ip netns exec peer2 ${OVPN_CLI} set_peer tun2 10 60 120
> > +
> > +	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}"
> > port 1 -n -q > /tmp/ovpn-bind1.log &
>=20
> Maybe add
> 2> /dev/null
> to clean up a bit the script output?

ACK.

> > +	tcpdump1_pid=3D$!
> > +	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}"
> > port 1 -n -q > /tmp/ovpn-bind2.log &
> > +	tcpdump2_pid=3D$!
> > +	sleep 0.5
> > +
> > +	ip netns exec peer1 ping -qfc 50 -w 1 5.5.5.2
> > +
> > +	wait ${tcpdump1_pid} || true
> > +	wait ${tcpdump2_pid} || true
> > +}
> > +
> > +run_bind_test veth1 any 10.10.10.2 10.10.10.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> > +
> > +run_bind_test veth2 any 20.20.20.2 20.20.20.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> > +
> > +run_bind_test any veth1 10.10.10.2 10.10.10.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> > +
> > +run_bind_test any veth2 20.20.20.2 20.20.20.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> > +
> > +cleanup
>=20
> And also clean up the log files? (maybe via "trap <function> EXIT" so
> that they get removed as well if the test fails)

ACK.

--=20
Ralf Lici
Mandelbit Srl

