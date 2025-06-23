Return-Path: <netdev+bounces-200254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720AAAE3E39
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B8F169179
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE023C511;
	Mon, 23 Jun 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxJJpEfT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F957219A86
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679068; cv=none; b=G1u4l/CAJmcVZF8QzDIZAtNFImudzDXbWCo3+BRE2ySZvs+2huS2Nr4HyXWKxuD6TewmOBYue23Z72oXCdfWsykZq6J3uMFVR5kVL8qB08adZcok1jP885MiagIYnBqHfhO2gbghqiDbSxBjrKRCMONjI/zo4YWBvIPl2IaamBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679068; c=relaxed/simple;
	bh=4ZqoQKdDvBPRQXyCngBAlFvRk74fScCEs9u1xA/pSDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1goUKPp2aFbD5nN4vmx23wq1oGv5ahFJ2AalXyUyVajoiFScjyql6j0QFwC3FlP/2fWqzaZkjWkvl5zZuf2P+0em7iD947kXY2645HnABDdWhxG/xpC2KxIAMHuL0gXsnQgVlfZpImnOV9pp1j0Ga9vSmkND6qRHZMoqcPaDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxJJpEfT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43d2d5569so55102621cf.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750679066; x=1751283866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrHTjhxlEVyzlxLPx8Yr8nFxLDqwxAF0xyp3qSY+qZQ=;
        b=PxJJpEfTmjLyvhiOKFI5GTh+dOTi/378xb7t37Pk9AAUUFK8wtVBYPCfudYu+CP5jc
         IQvtcFj+4+3CDqjUJskv8Xcth2KJ9abvvAeEih5RJaofDyZJaR38sOlcBlmgSbQ9rP8f
         Ef1BnH/c+ilX3BObEuJpOT3f8nO+dPOfO8MZzfjHSkm42bc6tGive6vKLev7IOFpqINb
         3p7tHB0V9CsOPca8+9r2IN+nZrwkbyNVzVPzNiEtIe0rea67x643f3MKeVt6OWOXMjzN
         VTNg14BdPTEbkTFoghnyezdyUgEljOdKMk1xAPipj77UVfna3cjaxrI2nlI05psfPVMa
         8oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679066; x=1751283866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrHTjhxlEVyzlxLPx8Yr8nFxLDqwxAF0xyp3qSY+qZQ=;
        b=cfKYzqLJRasRoOOf5DYFeKrrmdrW0tGR6XdWi7FB0I8okmj2x1xG5tUIaS+48hlKAY
         hewR+EIVe6vJOalQxXYqYSoQEMPQlp+jo9hauV2/YgduMJ5mmcN/ITKErcfWxoXujQTw
         6mO72PFvXpzkzxVG6Sq31s13yfY9LlNV3QswVr6qdjlVP8QVXSi0cur0C8B2Aq5C7wQH
         IifDbFcZpC04xN9LDIDMfGSDOnABjgT4i4y4wzggx1+8naYHo/Iq7Q0/1g0QFnigO7//
         iteDqtL05wtqiwLKAYmogc3LWSrziFHq9covq58xPiW4CTuJtJfHz8wkeXql5uSortIL
         aSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUY7n16mMWXeEUWGLMvy3DOVIa5YpwsbY9SZsQG59jaFgNWpAje6ajKLWQe43O84fUV5J3k3zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM8/RiZLOZvrAc1zsfNkQmrZJsqyQjRaxO+FNyR+wsenLdGU5
	zbLggB8cKK4Dc20zBoEbAwDoandl23WnauT+W4mbrFBasV0MsDmGh4Ks6NawrWfXf9chFJoKDMI
	1YUnO68Zu3rfJIdZcTRVIc8UxiRS3v69wxFMpxG3W
X-Gm-Gg: ASbGnctXYt//eUXmxoP7YIfCDYY7EIqAHiYcF2wM0EcABQoUP/xurYcWHp+o4Memgy0
	JZyNwlWE9jMXUlUet3rHOHBpDzkgVgrWOocAKVBG6rx7k6Je8aa4ADp35Xhcagp64ifhT6qH9xt
	5lacmkJtn23MMA+SbLJS6GCxXjPkENKxNP6fVwHLqCIoo=
X-Google-Smtp-Source: AGHT+IHfB/vZlIK9/FvjHWffL16LexUgBodwMHiN20SOOnfFPs17HBBf8UZjdusDwWuVV6zghVMq4F6HwMqGXNnWlks=
X-Received: by 2002:ac8:7f87:0:b0:4a4:4165:ed60 with SMTP id
 d75a77b69052e-4a77a23a330mr188912371cf.3.1750679065927; Mon, 23 Jun 2025
 04:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620125644.1045603-1-ptesarik@suse.com> <CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
 <20250623093604.01b74726@mordecai.tesarici.cz>
In-Reply-To: <20250623093604.01b74726@mordecai.tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 04:44:15 -0700
X-Gm-Features: AX0GCFsucZXpCrOv00H7hp6ojejTsrZfYjmXvKm7wa1_ILtb3HSf82YKGy7NqRQ
Message-ID: <CANn89iLKuzbEq=7A-TnB6jZypx0mObbLSNA=HmLjj5CBooBYPg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp_metrics: fix hanlding of route options
To: Petr Tesarik <ptesarik@suse.com>, Willem de Bruijn <willemb@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:36=E2=80=AFAM Petr Tesarik <ptesarik@suse.com> w=
rote:
>
> On Fri, 20 Jun 2025 06:24:23 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Fri, Jun 20, 2025 at 5:57=E2=80=AFAM Petr Tesarik <ptesarik@suse.com=
> wrote:
> > >
> > > I ran into a couple of issues while trying to tweak TCP congestion
> > > avoidance to analyze a potential performance regression. It turns out
> > > that overriding the parameters with ip-route(8) does not work as
> > > expected and appears to be buggy.
> >
> > Hi Petr
> >
> > Could you add packetdrill tests as well ?
>
> Glad to do that. But it will be my first time. ;-) Is there a tutorial?
> I looked under Documentation/ and didn't see anything.

I came up with the following test (currently working for IPv4 only).
Neal, Willem, any idea on how to have this test done for upstream tree ?

tools/testing/selftests/net/packetdrill/ksft_runner.sh does not have a
way to make a test family dependent.


diff --git a/tools/testing/selftests/net/packetdrill/tcp_cwnd5.pkt
b/tools/testing/selftests/net/packetdrill/tcp_cwnd5.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..e28b63b696d200ca447f613c300=
03571c1ff1ae8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_cwnd5.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of RTAX_CWND routing attribute
+
+// Set up config.
+`./defaults.sh`
+
++0 `ip ro change 192.0.2.1 via 192.168.0.1 dev tun0 cwnd lock 6`
+
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+   +0 bind(3, ..., ...) =3D 0
+   +0 listen(3, 1) =3D 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) =3D 4
+
+   +0 %{ assert tcpi_snd_cwnd =3D=3D 6, tcpi_snd_cwnd }%
+
+   +0 write(4, ..., 20000) =3D 20000
+   +0 > P. 1:6001(6000) ack 1
+
+   +.1 < . 1:1(0) ack 6001 win 257
+
+   +0 %{ assert tcpi_snd_cwnd =3D=3D 6, tcpi_snd_cwnd }%



>
> > Given this could accidentally break user setups, maybe net-next would b=
e safer.
>
> Yeah, you're right. Technically, it is a bugfix, but if it's been
> broken for more than a decade without anyone complaining, it can't be
> super-urgent.
>
> > Some of us disable tcp_metrics, because metrics used one minute (or
> > few seconds) in the past are not very helpful, and source of
> > confusion.
> >
> > (/proc/sys/net/ipv4/tcp_no_metrics_save set to 1)
>
> Yes, I know about that one. FWIW it didn't help at all in my case,
> because then the value from the routing table was ALWAYS ignored...
>
> Petr T

