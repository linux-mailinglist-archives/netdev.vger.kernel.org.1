Return-Path: <netdev+bounces-193440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD475AC40B1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D61416948C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D671FE470;
	Mon, 26 May 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAYHuV4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29F1F463C
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267443; cv=none; b=J2qSuaQSd8BksKZq5MXN+bJEmATgcsca4u9t+bSWaaO4D/mdTwXRCK81ggQRzRoqoY/Ws8Ay85hKa1YQLEip68jwkAX+1/HVFExQcRVr8Q119bWCM8QxarKN7FuEi0xCjDAHfJgN35NkY+iKAwZZnNaquuW1v/tU/7MJGuzQiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267443; c=relaxed/simple;
	bh=XyxC3/PqrdLJ3qfr9vuQK0F6dSJ6qsr4C43a7JY2NRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOwFg1a2GnApnhonb8VMKZDqSI7nSYMRRBJ0kXz71263hl+T1RT2PF/xIvm1tlIkN9LJ3P/sxk5YeKwLZNGwVcCKimOuIEo3/1IQqGZkL4vDe0V2FyByYR+adwisUsWAPNhcceNwvojGp+vEkEQhSzQ5I2tVqp0WeKCoy6mbMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAYHuV4x; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-48b7747f881so523051cf.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748267440; x=1748872240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vka/f+Z/vv4OannEtW8J/eskrPSAg5/7ofUNBbKMlGI=;
        b=aAYHuV4xCkz+VTvnLf+WSQHyzvtTMh2jWJVvhsejBpl3qgMYKv/PZpvwltVjHVZaqC
         XG8xXO1HUbI4WnHclryGS8+7508RIx1zRKtPFXt9VT+29K9s0ShN8InPuVa7OX17O+0x
         9gttfaZcN8eQCk7MoZ8zYMuwTyeudGN1RsJ6qXBFEp9Rd9CdGU97Lrw1th38X9LHrHLJ
         oAxU89d3Nx/kkULSFVt1KdfqlKId3URGe9jRgu+Hkn9eWcyWYRw+BVS6a2Zm1oWJGhWZ
         Dpqysv512+/GzrcvJWicH1fQR+5DJWD6belOYD3tbznzMt6BnWeHXRAymPod+dDtYMF5
         P28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267440; x=1748872240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vka/f+Z/vv4OannEtW8J/eskrPSAg5/7ofUNBbKMlGI=;
        b=cth4ZwmN3DZjt4htJv0s5zgYtAXaxDgbOFIJb29Wr+n6V6Go1lsMuPAWHWNg+UGa4R
         mmPjr39ZxlAeIC1n20xxepqjpHn7Gaw04kIZWnZcwPepVWGERIPJGlbaJjgjfihe1LiS
         0+js/XSX19sjZm+NnEQMXb26EZXTec+XwVIHW5KnHHWKuMvftub6eLY/ar7/0D9SYX42
         pZgrmm6WY5FHjraJE5KQb4vJmI9zw0jxl2ftT4R30U+om48BzzXqA24m3XGs+EL8Ujpu
         i9AGgJ97enENPXujHTXn9MN79PLdpDdrjcW5s0h2VG8q9NqtVlHjfn0FyGotX+h2KMnU
         EsnA==
X-Gm-Message-State: AOJu0YxBJVuI2ezVez+lndzb2//CZrF2tS9SBxWvXrRiY0dS2z19W5VH
	VC1nc7ecECXe8UTcNy8k0L1jiYooEe5FPvc9pmhaeugoeTq7u/0spIeHko8it1182g3wBwAG1LT
	1iiOcaIVyPVfAGmJchiygQt4kub9zcGcvh8DOlCsp
X-Gm-Gg: ASbGnctT+4FDeYeBMFBiNk7ZLaY1WD3y756YbSrOELGnmi49LqN9iw7WmndFcgVrKrI
	4Hb8HQdICth+vqBYFxUpZAkDJRgoZiw+JAXKwqTU65eTd80aRGy0WzkR9BEhmmrYjKJCPMkZBTt
	2in3H3kXUrJ/rbTIxaf5WqXTldSHXnVCISuWtPAMI5haM=
X-Google-Smtp-Source: AGHT+IEjv4Suc4V1qLiMu3iKXdg4HFAopydhUcXgFEN2Oj86j7gvGeezz2NJRZBFck7ypK8gzhr9jTHxh1HQKn1wcko=
X-Received: by 2002:a05:622a:8b:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-49f4b3f787bmr6380921cf.10.1748267439888; Mon, 26 May 2025
 06:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1dbe0f24-1076-4e91-b2c2-765a0e28b017@mail.uni-paderborn.de>
In-Reply-To: <1dbe0f24-1076-4e91-b2c2-765a0e28b017@mail.uni-paderborn.de>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 26 May 2025 09:50:23 -0400
X-Gm-Features: AX0GCFv5k7xMJSIGuQ90kC8dkAwpInWC0IhIk4EWuI6MjuEHTpV21EBa6eSBGWY
Message-ID: <CADVnQykQ+NGdONiK6AwL9CN=nj-8C6rwS4dtf-6p1f+JFyVqug@mail.gmail.com>
Subject: Re: Issue with delayed segments despite TCP_NODELAY
To: Dennis Baurichter <dennisba@mail.uni-paderborn.de>
Cc: netdev@vger.kernel.org, netfilter@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 9:01=E2=80=AFPM Dennis Baurichter
<dennisba@mail.uni-paderborn.de> wrote:
>
> Hi,
>
> I have a question on why the kernel stops sending further TCP segments
> after the handshake and first 2 (or 3) payload segments have been sent.
> This seems to happen if the round trip time is "too high" (e.g., over
> 9ms or 15ms, depending on system). Remaining segments are (apparently)
> only sent after an ACK has been received, even though TCP_NODELAY is set
> on the socket.
>
> This is happening on a range of different kernels, from Arch Linux'
> 6.14.7 (which should be rather close to mainline) down to Ubuntu 22.04's
> 5.15.0-134-generic (admittedly somewhat "farther away" from mainline). I
> can test on an actual mainline kernel, too, if that helps.
> I will describe our (probably somewhat uncommon) setup below. If you
> need any further information, I'll be happy to provide it.
>
> My colleague and I have the following setup:
> - Userland application connects to a server via TCP/IPv4 (complete TCP
> handshake is performed).
> - A nftables rule is added to intercept packets of this connection and
> put them into a netfilter queue.
> - Userland application writes data into this TCP socket.
>    - The data is written in up to 4 chunks, which are intended to end up
> in individual TCP segments.
>    - The socket has TCP_NODELAY set.
>    - sysctl net.ipv4.tcp_autocorking=3D0
> - The above nftables rule is removed.
> - Userland application (a different part of it) retrieves all packets
> from the netfilter queue.
>    - Here it may occur that e.g. only 2 out of 4 segments can be retrieve=
d.
>    - Reading from the netfilter queue is attempted until 5 timeouts of
> 20ms each occured. Even much higher timeout values don't change the
> results, so it's not a race condition.
> - Userland application performs some modifications on the intercepted
> segments and eventually issues verdict NF_ACCEPT.
>
> We checked (via strace) that all payload chunks are successfully written
> to the socket, (via nlmon kernel module) that there are no errors in the
> netlink communication, and (via nft monitor) that indeed no further
> segments traverse the netfilter pipeline before the first two payload
> segments are actually sent on the wire.
> We dug through the entire list of TCP and IPv4 sysctls (testing several
> of them), tried loading and using different congestion algorithm
> modules, toggling TCP_NODELAY off and on between each write to the
> socket (to trigger an explicit flush), and other things, but to no avail.
>
> Modifying our code, we can see that after NF_ACCEPT'ing the first
> segments, we can retrieve the remaining segments from netfilter queue.
> In Wireshark we see that this seems to be triggered by the incoming ACK
> segment from the server.
>
> Notably, we can intercept all segments at once when testing this on
> localhost or in a LAN network. However, on long-distance /
> higher-latency connections, we can only intercept 2 (sometimes 3) segment=
s.
>
> Testing on a LAN connection from an old laptop to a fast PC, we delayed
> packets on the latter one with variants of:
> tc qdisc add dev eth0 root netem delay 15ms
> We got the following mappings of delay / rtt to number of segments
> intercepted:
> below 15ms -> all (up to 4) segments intercepted
> 15-16ms -> 2-3 segments
> 16-17ms -> 2 (sometimes 3) segments
> over 20ms -> 2 segments (tested 20ms, 200ms, 500ms)
> Testing in the other direction, from fast PC to old laptop (which now
> has the qdisc delay), we get similar results, just with lower round trip
> times (15ms becomes more like 8-9ms).
>
> We would very much appreciate it if someone could help us on the
> following questions:
> - Why are the remaining segments not send out immediately, despite
> TCP_NODELAY?
> - Is there a way to change this?
> - If not, do you have better workarounds than injecting a fake ACK
> pretending to come "from the server" via a raw socket?
>    Actually, we haven't tried this yet, but probably will soon.

Sounds like you are probably seeing the effects of TCP Small Queues
(TSQ) limiting the number of skbs queued in various layers of the
sending machine. See tcp_small_queue_check() for details.

Probably with shorter RTTs the incoming ACKs clear skbs from the rtx
queue, and thus the tcp_small_queue_check() call to
tcp_rtx_queue_empty_or_single_skb(sk) returns true and
tcp_small_queue_check() returns false, enabling transmissions.

What is it that you are trying to accomplish with this nftables approach?

neal

