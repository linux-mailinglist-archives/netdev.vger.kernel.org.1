Return-Path: <netdev+bounces-147824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E665C9DC157
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36C4162B2F
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5A170A1A;
	Fri, 29 Nov 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LB6a0cM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE21170A15
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871952; cv=none; b=JUAFSth8ga8SJssRkgm7bABYs73UtVkeCQ5QFaawsUdeH3taiJs1x6fjXjnRvAoH0RdHJdcora2ZSTxQIwnY5gDGyCy02GCO7E/hqFitnklLO1+sAdBHOOb4ZD0GSbKuc/mjloauh7INBF/GFG+PTAGFE/gposyO1gZTOje8Y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871952; c=relaxed/simple;
	bh=g79H7tIgDD6sOOJLZvjgc74BHN39nTif8XwYXNhWZPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOqg3Y+2kv4qrMuIrdZajzWJPn5rtJ/AYibpmdfhEsvP7ALocWdT42kRdUE0GDYo6YI/J7GE3oiXHK5Nh4gVdmgy48kOLn+IFsoKOt8bKrj/uBrr+fuxAfS2yR3Azh9fJMn5SVs85ai0tV+vVNxmfSE/dZUwbHWC3Dhm/fn2DYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LB6a0cM4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so319416566b.3
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732871949; x=1733476749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD+G31sh9eiAnBFsgKCay0J/mHjjzI9Np4ku3nZS91I=;
        b=LB6a0cM4GXWARyRqH1iNff1Z+PwmYV7oiTU5nuCxqnMdTcmUpFkVSLJehmdiklwZyW
         /PR+v44Vx0/i7mmB1dB0ZPoZw19LxpCTNLucUqqLIW2/bm2KE6Dd+DUm2u4BnH7l5pNX
         kjN79p3iGfhsbWpnHLcQn7JtlGjPeaAqVvhCrFZKEVKesGlwlKdvmeXdph1rOZA2Xupy
         hffcaF7IB02GYIEy6gCB/PAsV12G3sECTkpRXEh+PNeo1Immkidl1a44eju2pB1jPCNy
         k3k0wnux/WMybr0TdRoTtw7uWv6zfmK746j2ai394Ylpt7OgUfmMPRyr9LAm9TLFSdo4
         nPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871949; x=1733476749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD+G31sh9eiAnBFsgKCay0J/mHjjzI9Np4ku3nZS91I=;
        b=bPaOLQOhypB94XM9Jtgj9+QDZSrWg4EbRCdLUnarA/mPk2+DC8szPqO9KBwUfUZ+lW
         8U4dvfiGtdnrKzDjdh81shqI84a7njgWFGfmoq+DJNJKo4PISmrPtFLg/LXW0HsBkqCO
         SHLAIcOzcJK6iCkoZV1nY9wxaxPDaCCExjnJhUepx8iDH6r/BWxHf2S8RH5MmBvS/qV6
         Q0YF+3FUrceop2jyLn2aOilQH1N9XWsBWLwrxAHDz5cKeZcEh8L78l4P6LM5FHvCjdck
         /8Y2hXBYbJIjehigatC9by/jERsDEVze0fFQdVckp/jBAwbOnkgOq3A7tw1L4hD3GQvY
         gztw==
X-Gm-Message-State: AOJu0YywCsySaShXz8tE6h5mR479W4aALyJX/nc42qs8GQjpRO1Y91BU
	1mK/+6TiwXew+gSbc1/Cipfm/XpTjAvnrI77MPIIsLcGG5p1CjEUVjUclnRLErHqaYhlTjbRlvg
	hN+RW6F7JwoZYtNNfeglStXDSYxg0TRTCY+3g
X-Gm-Gg: ASbGncvR3bTX6Wx0UTr2a/NPkeEZW9rvL0U3mpDAO2dWcgpUW7zxn1NeD9nBtUt0UUF
	E/fsPtlWDy5dinwLumgRaUB7/Trjc7uo=
X-Google-Smtp-Source: AGHT+IHWERt/0pgD5kLacjbXchmlIltg6Ui9qU0nhvcGZ+VCsHYIfdH8hVFaOO0EB6DrOGFANRVTa1Tdu9myVnsa2RY=
X-Received: by 2002:a17:906:9350:b0:aa5:427d:b101 with SMTP id
 a640c23a62f3a-aa580f57d4amr1079397266b.36.1732871949390; Fri, 29 Nov 2024
 01:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128085950.GA4505@incl>
In-Reply-To: <20241128085950.GA4505@incl>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Nov 2024 10:18:58 +0100
Message-ID: <CANn89iKEbCKUxieR298R5-BaFQUDXV0o+J3bWjHqv4LyaYDMYw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/ipv6: release expired exception dst cached in socket
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xin Long <lucien.xin@gmail.com>, yousaf.kaukab@suse.com, andreas.taschner@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 9:59=E2=80=AFAM Jiri Wiesner <jwiesner@suse.de> wro=
te:
>
> Dst objects get leaked in ip6_negative_advice() when this function is
> executed for an expired IPv6 route located in the exception table. There
> are several conditions that must be fulfilled for the leak to occur:
> * an ICMPv6 packet indicating a change of the MTU for the path is receive=
d,
>   resulting in an exception dst being created
> * a TCP connection that uses the exception dst for routing packets must
>   start timing out so that TCP begins retransmissions
> * after the exception dst expires, the FIB6 garbage collector must not ru=
n
>   before TCP executes ip6_negative_advice() for the expired exception dst
>
> When TCP executes ip6_negative_advice() for an exception dst that has
> expired and if no other socket holds a reference to the exception dst, th=
e
> refcount of the exception dst is 2, which corresponds to the increment
> made by dst_init() and the increment made by the TCP socket for which the
> connection is timing out. The refcount made by the socket is never
> released. The refcount of the dst is decremented in sk_dst_reset() but
> that decrement is counteracted by a dst_hold() intentionally placed just
> before the sk_dst_reset() in ip6_negative_advice(). After
> ip6_negative_advice() has finished, there is no other object tied to the
> dst. The socket lost its reference stored in sk_dst_cache and the dst is
> no longer in the exception table. The exception dst becomes a leaked
> object.
>
> As a result of this dst leak, an unbalanced refcount is reported for the
> loopback device of a net namespace being destroyed under kernels that do
> not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
> unregister_netdevice: waiting for lo to become free. Usage count =3D 2
>
> Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
> patch that introduced the dst_hold() in ip6_negative_advice() was
> 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b2=
2
> merely refactored the code with regards to the dst refcount so the issue
> was present even before 92f1655aa2b22. The bug was introduced in
> 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
> expired.") where the expired cached route is deleted and the sk_dst_cache
> member of the socket is set to NULL by calling dst_negative_advice() but
> the refcount belonging to the socket is left unbalanced.
>
> The IPv4 version - ipv4_negative_advice() - is not affected by this bug.
> When the TCP connection times out ipv4_negative_advice() merely resets th=
e
> sk_dst_cache of the socket while decrementing the refcount of the
> exception dst.
>
> Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
> Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer ac=
tually expired.")
> Link: https://lore.kernel.org/netdev/20241113105611.GA6723@incl/T/#u
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks a lot Jiri !

