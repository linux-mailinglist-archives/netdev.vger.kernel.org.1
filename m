Return-Path: <netdev+bounces-99659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A892E8D5AC7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AB51F25555
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872247FBAE;
	Fri, 31 May 2024 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xsv6f/Op"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FA28DA0
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138305; cv=none; b=SN1bpbEiWI63ilio5SBf0/2xppEcFOrK+Ttlyj6I+LYdMG8jefbAF2QvjYHvplN64GOgnL9H0mc/gBrb/+9kNTAtIxeOSaMfXf0gRqJVPzi90A7AFsvQqNqu3zdIiknf/bJIByexdwG6FMXxJc8fFRQZTRtQ+baFyrfPwl0gV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138305; c=relaxed/simple;
	bh=2RWBcRuI5JRmtU18wBQ6q5Z+twyv3/m4zREUwhLt8aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxlPqHDy0zfeSrYVosQYaoR7QsRQrKOmSwALmG494FDWm7oPcgnEXIsmpN6fFY3AQ9JzgMDm/eYwyXovCM8M60prRmaSBH2NNEXF7t9nZfWevF04KA+1t5AsApAD1vTlbz4SmpZGY3KI20nCoHHYZOmDapnQEOHQ1JA0cEY/ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xsv6f/Op; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso6301a12.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717138302; x=1717743102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzIT2VZ2rHX1hVdVcuQEFyKfNmye58PO7QacsBxeUlk=;
        b=Xsv6f/OpEAe5AB7rOSaO9c/z9YCyRGH9nxMzAQB7TyP9kQQ4ff0Rbv3nPr0jUQ1Gcv
         712pVKf2kdIj647G4j/itl3f09XyqNI3yG3bNTPRCINJs6xbJDPWKZHJTie2jNwZp3ul
         d1aOWBD5xhaQBaHqNN11S4XTF0drvnKIo7m6i9quATCgzsGGVnNJs81P4ZYXwYDbAtDk
         2VVaDMlnOSaGXQmri0bsllSfAuXyY/4XB6BygkbTBPjVosbUBtsiaiXMnI4Shynk4FxP
         lRQdFu8Q4YWTe0wDkEvqT2dCL50NCHk6+45wwUtqxD5y/cWPPFZqa+PXYtLbf9Oivagw
         z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138302; x=1717743102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzIT2VZ2rHX1hVdVcuQEFyKfNmye58PO7QacsBxeUlk=;
        b=rwe9mLyDGp4dCE5i2/t2eVN+vdjGsIqD0hpnEd0fBkCvUDiBzEUpLVQp3+SoTTOm/G
         i7yS2HRj7/rWA9MMnKXcCK8bO0ovCUzo+juyAsrjLxJOIA7ZT5DHLgYKnIrAEMO+SZKN
         37C4aAwtk0+xRLAbrL37Cs+0nW4ANVZW6kPJVFADve11jvGhgQfJMIYrIz0qwyW7uIi3
         Hc2CjbGM6yVchUaLDV8jaUEEKJxHE6CE9E5f/IqVYdz1KfY5LLetZ6jV/aNbIzpRi6U7
         pQ0I99P9nuo1gW/0ovHPqELiPGfp+B9kU9WAjnTrWJCAWaUikIxqHRzDxZi8vXGaRIb1
         n8gQ==
X-Gm-Message-State: AOJu0YwujRw2pYBylaBT988Ji03pIVE5JaOPy0WCYAFBBK/iiWH7Wdsy
	iaaPnFr6IDyMqHGVGj6jkt/pxbfGLJI8CHTBxFhUVqOXGhpKgU1/yWpko9wARuWq5YCfuKNedvN
	SGUSgV7pXxPtnsNGQX/nlQ5J7T/27zrYEz62xFsGDtGG+VR3TQWxe
X-Google-Smtp-Source: AGHT+IH9G9rpU2GQq3pusZBiY8IaNqJOBhMA/IkgHi7CVpn3ZjSHl66WTw1UgNcvmN6jqwIJfWjhNJkqzIDDj88OcPE=
X-Received: by 2002:aa7:dd06:0:b0:579:c2f3:f826 with SMTP id
 4fb4d7f45d1cf-57a33c78851mr97467a12.4.1717138301997; Thu, 30 May 2024
 23:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
In-Reply-To: <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:51:30 +0200
Message-ID: <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrot=
e:
>
> Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
> local receive path. The function accepts an extra receiving socket
> argument, which will be set in skb->cb for kfree_skb/consume_skb
> tracepoint consumption. With this extra bit of information, it will be
> easier to attribute dropped packets to netns/containers and
> sockets/services for performance and error monitoring purpose.

This is a lot of code churn...

I have to ask : Why not simply adding an sk parameter to an existing
trace point ?

If this not possible, I would rather add new tracepoints, adding new classe=
s,
because it will ease your debugging :

When looking for TCP drops, simply use a tcp_event_sk_skb_reason instance,
and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.

DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,

     TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
skb_drop_reason reason),
...
);

Also, the name ( kfree_skb_for_sk) and order of parameters is confusing.

I always prefer this kind of ordering/names :

void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
to expand the rationale
              struct sock *sk, struct sk_buff *skb, enum skb_drop_reason re=
ason)

Looking at the name, we immediately see the parameter order.

The consume one (no @reason there) would be called

void sk_skb_consume(struct sock *sk, struct sk_buff *skb);

