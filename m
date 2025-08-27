Return-Path: <netdev+bounces-217158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7024EB379E2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923F11B614CB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC63101B1;
	Wed, 27 Aug 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vi3HohOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276530FF28
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272751; cv=none; b=DweJsCH1yCGJ9oIfGvGhSNNA5ZeyPG2Nr0HJSthOnQ8xA+VQ0uZaD+HQuCB2os2bKGvFYukS+eGfhLBQWYjOTZ0VewR+IOhGAGC9zFqC33cpQHzxPPURJm5grbCHt7TpiTc1FZ2EZf/O3NvtLs5PzGLngfrJ+BVx5ZSjYKUBoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272751; c=relaxed/simple;
	bh=IuOE6DvLdmAB9Bg8vdPxbE1H2/sEScZ7xTqNTldRSPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axdj6IUW+NfbZN85UTqM5tiJdbx/3xVaiyjiVZXrdqmN3o0u9fNHqhCE8Sx9RDBs14n9ulLyh/ihnRU9hJLJ8FXT+shRB8CQJrLj2nXbtlJP9AFdWfkrxNb9/1c1MX5QtJ87+hyRpA1JpfbGspamOOG49elCGMtaAdSVxToB6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vi3HohOR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248a638dbbeso723695ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756272749; x=1756877549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gLmjZh/venVnH6GCSlm9clIp5vVYqgNNWYuz/K+IhU=;
        b=vi3HohORYiaRrPsXlmzcRNe7QvA6+8CVlXLkmalbwqHgmh3Zqrukn+u7Mx+pLqwrOj
         TfMmmdx1hu5/naHvFvzQ0/ZSiuVPYgcuyOA8eNOmhUG7JrYL/h6xQUcyZHOxvy2LyoMO
         zo1ZE/ckLAdG6fjr62cY7EE1HM46Nyq7fDWHk7rCH6bCnxQ8ZqDjps+sk5RauvyIUYS7
         VNHZ+DxuEUl8Q6NGbdG8OWXup+5OTAh9UsFVlrBsDyrF8G79in4l2cEmM4EVMGRUt3wO
         WaHXXAUd2dy5E1WaUZs+QRekd+5sJdARx1NH6hV8iY4cNqsU+dS4XqGeL0/z/gcxVNfe
         OBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756272749; x=1756877549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gLmjZh/venVnH6GCSlm9clIp5vVYqgNNWYuz/K+IhU=;
        b=RioljeqGpBqjs3TMBuI3KlNaYyeDXKUGKcdRDXapp2+g5Y7JOFTduxW2j1HnbBwobY
         n37DEDREfCqNfuHUxp+i7k9BNUiAmFDhuF9yOfJAf2zA32umEp7Lmv0yWAcg2QbBPLKB
         ybnKLGRbFyRGXm4xeNjRi7Gp8O7vWon5b7UWvjYrA7U10imkRt8RYuR8rPJ3innexSJ7
         Yd1+SyAXfnU68JK8DDz3RpqSa4qOk3c3YccD3kVxAogMUr+lkvOcoG/ORvTecoaDNBaJ
         LkLJzJzloK8AVffunDWzKMn6AbaKzen6BZwk0X/+v2/Zz0rY7ER17OZCTOSmssa94AaO
         s3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW3FDb7MA3cPDzk3xalQN8opwwUEHpmArXIJFHOaH5P33VO+wUptjvMufEFo3auvRfYtFisv70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHi46Cdx3JmA23Fiqze5YES38XSn5Or22B16w3/XNRg2mJcxg
	/6aNcxzdjATFbGfCv2DguECcSh7+SZ2l7naJgmHCpzjYRUlhbMMmhDj9aZgjk6LCINsIfxjiFuv
	xdbji3wiVsVzxJ+Lwc7BWh09hGsEJqTF+UE5ez4rL0Mu66VvnPNcuNanPd2k=
X-Gm-Gg: ASbGnctv9OA0T9U6Oi4fQ2RAAcwujiR/xtX9QylVWHuynwXxyp3JIq0OWZMmY/DplQo
	4i9YX6rK9kJp2ZqamuoFpn4P+pKWzMqz4/nNsZ2POfOX4Lsrod+tX8l20zVbnZFOzovM5nswhsK
	k1oWpgEJ0tx+6dzlvzZWR/snzmHPhc/qikwZN5kXIj92NpN5M9Cr59F2Deu3CZ5tx+wjpe8hkES
	S4EI5hJ/8SCuL1HzhDf0LD4yRyJhFV4H5vBGz4lJun/5eyNGioV+EHXIh4ZHDBZqjd0Rt+ykKm+
	ir4=
X-Google-Smtp-Source: AGHT+IGvFrcMIj81dd8CZYHa+RtRiQ/Zvc5iQwtBoUfye/Xpo5Jl6E5tLpOm32rdC4Cp9b9nYDevQQ/ciDQappC+JKo=
X-Received: by 2002:a17:902:c402:b0:246:570:2d9a with SMTP id
 d9443c01a7336-2462efca0femr229415515ad.59.1756272749013; Tue, 26 Aug 2025
 22:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com> <20250826125031.1578842-5-edumazet@google.com>
In-Reply-To: <20250826125031.1578842-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 22:32:17 -0700
X-Gm-Features: Ac12FXwWxSyAFY8GMiSqeNxZq6R0hUURBYI83QX7p84zEY-3j1y8jTuXhnvG40Q
Message-ID: <CAAVpQUA2ejs5QUHnL54uZO+BhiVn0yfp3A3aLyuJw79Udb_3ug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/5] udp: add drop_counters to udp socket
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When a packet flood hits one or more UDP sockets, many cpus
> have to update sk->sk_drops.
>
> This slows down other cpus, because currently
> sk_drops is in sock_write_rx group.
>
> Add a socket_drop_counters structure to udp sockets.
>
> Using dedicated cache lines to hold drop counters
> makes sure that consumers no longer suffer from
> false sharing if/when producers only change sk->sk_drops.
>
> This adds 128 bytes per UDP socket.
>
> Tested with the following stress test, sending about 11 Mpps
> to a dual socket AMD EPYC 7B13 64-Core.
>
> super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
> Note: due to socket lookup, only one UDP socket is receiving
> packets on DUT.
>
> Then measure receiver (DUT) behavior. We can see both
> consumer and BH handlers can process more packets per second.
>
> Before:
>
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 615091             0.0
> Udp6InErrors                    3904277            0.0
> Udp6RcvbufErrors                3904277            0.0
>
> After:
>
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 816281             0.0
> Udp6InErrors                    7497093            0.0
> Udp6RcvbufErrors                7497093            0.0
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

