Return-Path: <netdev+bounces-157785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AAA0BB47
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EE11886AE3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDEB246331;
	Mon, 13 Jan 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwV0spQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862D23D3CC
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780594; cv=none; b=GZHdiWJ/I9Kc32SjwUgRqi2Jjo1rIJf3EtB6atlu/9uzmulisoLkwNDDHTlYyERkMYvIhfoMF1ngwTx/q/a63GvQYWETcjU2X5ewSIUmuG6xn/dIdkCugbxkXvdWTlyLzPP0RcwZKzbV9qtgQE/otoIEj8vpFSo0nM3PH3BH5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780594; c=relaxed/simple;
	bh=oR/7FlIj/E8fdQ4Zv56ZK8AJLDEtu+zE3mVa5RMvY3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo6pN5LYenjLW7WubahXOLhDmiWG7POIjnb3o+tZt6IDLIuGXU0QgwPtCPCAaC8ITyxIHcZkXkGmeMBO6i1pYMztPPUG0DC4uIV0/omyxUazRJw9nMtfGfYZnTWer+dC3L+QEXIAYGHRrK/OoTBy1xV2f5wEOQcU6FxX9K7BPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwV0spQ7; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-84ceaf2667aso224122139f.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736780592; x=1737385392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhI8lwzo961F7JHQtMov9XyaE8Gkm65/Ly8TNDtQyGc=;
        b=mwV0spQ7dC0/9cWzVgxuLiF61OXh6xsZWgc/cr8xXpsbNVNX48b7QnvkpTu7v3TiJz
         V1y0qOCi2mAb8WhzwDl1giSq3VVsSfl6/FulIS+dU0kveZsYFLCen3BnTGYpRO/AFfWI
         /aL6TDXCrouhmzO9tpHvWAywcWkIC5a+6GnR9XDB8Gd7AtF/NMaZE3C4nKj50LkggcRH
         pilqIenKamZc527uQ1gfP2bgY0HKick9qBwQYu1Rfc3V+2FpjkBLrolo1hWFW78poUfR
         WPR805/kUyRYTzzZpeBv6Qx1jcdENrofpoDuCJfo8FF3RIb0OW0UOoZkFqjTozAnp8Kx
         BDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780592; x=1737385392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhI8lwzo961F7JHQtMov9XyaE8Gkm65/Ly8TNDtQyGc=;
        b=af0lCE5rjE2RCojG38LyTdtkZqt/BsGPhK9JDRGFT2K/IymoEJni6Fdu9qBX+RgTmC
         2e1nBYfwHJwfH3Pw4KDNhgoYLbM5Y/GA5CHKBBRHf51XYR/uYitD0nWXmH+DCH4pI7F3
         rY3q3a7AyS2RrhC33YDHZqvTE/lypwvLRc9zBL2agkh7k8AcqA4YrBsEPG0x3exXT9Jn
         8riLj3F98HKs8b2dKWwldMtFM1K5txIH3Yjp0STTjLhTuLBTzyOYVn6IA5d7CrqZvsyp
         8Xjmt4yzRQYVsIqiksZjT5iYkPJ4lbEKntVb5HZyENrEO8bHnqm1LGrkWtYO1m+G+Jco
         F9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUVyA6tSoAris0i9Qeqkt89v2OO1RwqAoT+mBvWo/gvxhewq/6AyuPk7yFxezqDmmzsfOCnibw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUsMca57Iq/zjmrckLPY4qrv8BpGMvDf0a+8KZq8783AAlm1Z
	bqho8HHzeGOxfEOhoXnVIgMlH1v5ixeo5zR8vscggWqdDBR5c65z+SOLL/U5dvrOeBs7Oc7Wes2
	tgFJeLZvTVCibYZ5aMv2ciZPUuec=
X-Gm-Gg: ASbGncsyqQiiWDnkVbmwQh8c8UtNVWExRpaTxRD3eSj16rNaseNVUVyiobje2lD937b
	UjJvi+q06knLIxGLJ3My0E7V2NKF6aXlm+NYYTA==
X-Google-Smtp-Source: AGHT+IF7TakiqIIMDLYBqaIBqq2006p6aJQquQ3pzJBsLqRco32J6j8Qgg7UBM8Z+5n4eEZrfnCrqcUv7Tw/BkM7wi0=
X-Received: by 2002:a92:cda7:0:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3ce3aa71eb7mr166742925ab.15.1736780591770; Mon, 13 Jan 2025
 07:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com> <20250113135558.3180360-3-edumazet@google.com>
In-Reply-To: <20250113135558.3180360-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 23:02:35 +0800
X-Gm-Features: AbW1kvY8lXztUEgeY0oTxt-57T82IvTv5rt8txiuyF2Z64mAJhyVoeDdfF_BRLk
Message-ID: <CAL+tcoC4SqNZZ1tw3RHkMe1e2kdtwXK8_-=NFpiCAT9m3Ukm6Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> XPS can cause reorders because of the relaxed OOO
> conditions for pure ACK packets.
>
> For hosts not using RFS, what can happpen is that ACK
> packets are sent on behalf of the cpu processing NIC
> interrupts, selecting TX queue A for ACK packet P1.
>
> Then a subsequent sendmsg() can run on another cpu.
> TX queue selection uses the socket hash and can choose
> another queue B for packets P2 (with payload).
>
> If queue A is more congested than queue B,
> the ACK packet P1 could be sent on the wire after
> P2.
>
> A linux receiver when processing P1 (after P2) currently increments
> LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> and use TCP_RFC7323_PAWS drop reason.
> It might also send a DUPACK if not rate limited.
>
> In order to better understand this pattern, this
> patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
>
> For old ACKS like these, we no longer increment
> LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
> keeping credit for other more interesting DUPACK.
>
> perf record -e skb:kfree_skb -a
> perf script
> ...
>          swapper       0 [148] 27475.438637: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438706: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438908: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439010: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439214: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.439286: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
> ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thank you, Eric.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

