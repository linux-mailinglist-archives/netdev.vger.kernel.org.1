Return-Path: <netdev+bounces-281401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OQXBY2G72lPCAEAu9opvQ
	(envelope-from <netdev+bounces-281401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6B4759A0
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CA9031A6B29
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46F340A62;
	Mon, 27 Apr 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gso8sbxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045663382CB
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304339; cv=pass; b=nKFWSSjj/R05VVtcmZzsOs6e8DUBIuKd30m7f6qr4k3e8BNHypgb5pHkhqLOmSaTpy12Ge1QQ4L3a1n6WNruP8Qua4oKcrN1UAOKjmhcY8JM+6iEiMxbIXe0+NYGZNyPfO+1rPhcR+hZYmYRxuLpJSYVB08jzKZZuqUHnk62q8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304339; c=relaxed/simple;
	bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKBzgjIlZvKp7JdZurB+ULSq9u73htR+toy+Z9z1qwIE+sIQ/ERp2Jjh3gGBU7l6QJW11Fg4VGfPZ8XyYnFm3WPuKs1R3tmZ7eN+/ZxhRKB2KCld7AcwZh46AzPN9Y5p0/A3HZW76O5B8YRd7UWKWimBwwIWuzCqL6GDKCWakPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gso8sbxx; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d7c12e48eso100508721cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777304337; cv=none;
        d=google.com; s=arc-20240605;
        b=C07lFcghGwg17l0jTuM3Ybv/AmG27uq/Q6EKxVhIAY/PKH0xa8D7IiccqrK+a9s6AJ
         tcRPI3u5u30o+FmICrKdGn9Xxe1hoDNuXaS+nQjiY64DAG3l2duTi0aIbzk+MuyMMgx+
         xHmEokG2XweApvhopBpBSjqHhiZmHtdyM9DD0ok9WyTrjoNNa9Tm4F3c9sLa2kAmySLH
         FjxTJJdBqjlfSzxoBwZ4TG4AnrWJ81LKLbdwS8OnQPzLBakCYaFQuckSFgiHvetlvVsx
         BFFSGo9ylFaQ6ayexMsXxcJOOKoLIQOF9n6duV6Xn1oUNjb8G32YL+IuLwuNP55PtVxL
         c//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        fh=ZGMeduppMsshvXdWF3WPZbHCQVhU45A5kefw+aujyYs=;
        b=Ex3kUS+779E0qvz6JmseBrf5bT0Lo99Gxsma6Mj6dlclva63EWzO6RsJ1mQY23ZnZN
         gaMiPvAIElrsXdqbfW3jZeXWLd5ZqMc9AJfgu7bDQneVvAWaKQLN3vEVy76qxvu3r6xC
         DQC4C5OkqOIu8P0EzDOidbmADcJQD5KdepAyQiLia/eDr8Q4gp1RZtDUl7BXLv2de7PL
         kBbK4/ve8tSUSv29rXX3RyBov3X9U4pimHYA0kK7Qcq+f2aoyWU3or5IdGuLuXAnF73b
         D/PNCcz6FuWxJkLK2p7Ut1ZxaDWNsOpFRpiqsCRirUm+39Ffi1X9tNMfzmlnphuP5/VC
         YZbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304337; x=1777909137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        b=Gso8sbxxdC1A0QODfkzXX2isVSjO2Ls2XkapJ3pPR9Ypy5slQJI0Kz64b5lKX/9uQm
         rZlNjBmqOzIIAVsrqfd6tGZE7Zit2odc3hNMC89hqgQ33cpkFNtArnEKh5fmNGTiKzwh
         WU0BM1PzF72aHggDkHZ5tB7F/nmduLF9VcUFZqwYo8GfkJzWuBnXEb51LP9JGpw0Ntf0
         XARU/UCVmvQz739zViYz2QRxGg5Q05dJ2UIXqfws6VJr55O/ySWqrCJJu2k16axFxXq/
         GjmKpsesZrZx6LI7xdw4p5NlKC/eLjtQSY4sy8EBO069/VM7BOFaZJXWNqMwxZFZ6yKj
         yhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304337; x=1777909137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJZLfHYeasFj/n+WkgckJg+glyIiZqPAIbNFaCiLTY0=;
        b=l5k5/RrkABSxTUgnxkkwEiN7F6TERa9H6nbFozqfOgSYX2LG3QBPOwJZe03Subs9hu
         a3OEpPhhk//5Z9Oy3xybeGIQt5FQm2nib5b9XjX/Ie9DKGiFHObCJn7xfRDsozQf0W8X
         6pvyxtN7p6ZAqjMpGq173XclOH+ihdxDhpODkkfSuufjq/uwl/uNU/ZnTNUQxN29Tpxz
         T0Bsggl9dpCO4Zg1EEQA+tsmKwpE5g19rrr0/TRMkkZyX7IKo2sewt+3vKVbFkqAdrGs
         SJnjLXMmRJs/KLgLv+UkFzCexDWwNgyAaCjpdHzZdJ8nduUgljPCddBY93neGsPObwk3
         tXFg==
X-Gm-Message-State: AOJu0YwNFOdA0khBLWQYxuY1kdUPWOzlUjM3M2aprnw23aXUcou7ruAe
	D2zbetL6GmChxLrDdKa6PuXBaVySJ+mnaOaIqyvz/vLVWC9TRV1gJ7D36ttWyNT+SWVn0Nnkepq
	xKGmwGJN6D/g8yIp+dYUFgyPVG8SNdLefFV7+iNXp
X-Gm-Gg: AeBDieu5JF+YcVHDqY6fr/1iGIzxNAhb5RGyVtZDYXIv1xczyh4am28OPO5dZFAl3c1
	82ytta+zYxO8+OHlcKXwadJafh1t5Z3u6ocMxj1S0EUZBx1kG6ItlBarOWBc/fwN5uVedz0tWQe
	qvQGqMSZY1VAjyqM77YwWURVVY6YVq5DI0CE5BedvFDWATsDkmfbR0wuBKwFRbbOEA0vqD4c9Wl
	p1Ds8ThyjK4Acmjek4V/88vgPnOoz4j7VS5Q17f50QKbuc7QpyNUP+PSObehaSzmnhh6JhK0omS
	Q00aRGmdZ/d9qlXTdiHXmfhSyKY9C6UQwPY9jeoJ2+mtDbLRRBcpgiBo888LiwX8efoHp3EK7U3
	M2GEJjiEq
X-Received: by 2002:a05:622a:4cd:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-50e365f889fmr531349701cf.6.1777304336427; Mon, 27 Apr 2026
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
In-Reply-To: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 08:38:44 -0700
X-Gm-Features: AVHnY4KchnTjsLKiFJZLY86Lr0YZy6QaUQU6xemXPVc-qJuy8UrVFn_1GVaQpw0
Message-ID: <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, quic_stranche@quicinc.com, quic_subashab@quicinc.com, 
	linux-kernel@vger.kernel.org, karen.badiryan@broadcom.com, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com, 
	tapas.kundu@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 80E6B4759A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281401-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 8:32=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadcom.=
com> wrote:
>
> When an application explicitly sets SO_RCVBUF, the window clamp should
> not be dynamically recalculated based on the memory scaling_ratio.
>
> Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
> down when it sees a poor skb->len to skb->truesize ratio. If the
> application explicitly locked the buffer via SO_RCVBUF, this
> recalculation causes the advertised window to drop severely.
>
> If the window drops below the interface MSS, it triggers Silly Window
> Syndrome (SWS) avoidance on the sender. The sender defers transmission
> and drops the connection into a perpetual 200ms PROBE0 timer loop,
> drastically reducing throughput.
>
> This is highly reproducible on loopback interfaces (MTU 65536) using
> Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
> to 32K or 64K. The bloated loopback truesize forces the scaling ratio
> to drop, crushing the window clamp to ~26K, instantly triggering SWS
> stalls and causing gigabyte transfers to take minutes instead of
> milliseconds.
>
> Since the application locked the buffer, the kernel should respect the
> clamp boundary and not dynamically crush it based on runtime ratios.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Cc: stable@vger.kernel.org
> Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>

Make sure to add a selftests (in ./tools/testing/selftests/net/packetdrill/=
 )

Thanks.

