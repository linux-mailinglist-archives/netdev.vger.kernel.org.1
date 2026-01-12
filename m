Return-Path: <netdev+bounces-249163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69AD1536C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5339E300B807
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EABC3314B8;
	Mon, 12 Jan 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdJ93UMt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983731AABF
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249679; cv=none; b=q9weYYdAF296HKCzYoCVFZV4RGgzwIt+XpXLz/TvcvuJAh8xSGxDocZ4gXIkdUap33eCW7eAQjlyj3D+3AjsMk2FrAO4g6JbDzmdX2WyWPx/9giK9pv8r8A77o5bu230ePFdi2GtT37gPn9JTx+2gwZcg2uVci1WwGrarxWHkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249679; c=relaxed/simple;
	bh=yYKBaXuHlJex5adtLYzjB5U6dBGTCX9Zbt555fTGUIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQJ3Bgy37O7m5mh/ilHwqTRBOOSsk+6N68+L6a9pzEsmB32tYY3rL00I+ZH5MWrHkcUAFGUfD/+o38IhizkkvwtFqfiLEkXcmKpQbVU0TQBF5UJxU/lQST1h3sknyQ7tpGFTYiMJCcL9ckWjcQhztnlSUekQAGIEgFvclrLqeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdJ93UMt; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88fdac49a85so72318316d6.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768249677; x=1768854477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0qyuM/1cZ+he1ewqreZXoF87RWUYofuLre5U1znIs8=;
        b=jdJ93UMteaLrMUq3gfgUwb8FDANrR2BYFoDFwifEl/7j+2N4Vxg/dy6f1DeHcGBgPH
         1WwbMd2j9mqo67jZ/E8winseFuzF+76VvZHmmquAaXazlGiIvh2a+y9BCq8FQ1bDALo1
         g11dxLWkIYUnDLnFQwdDWx6u54sYJCJmoLfimwXXGPFXHrfoQoGdkpIZlHuLRhHuQchF
         Zd9uJLh8PO4XxftuAZtoF/aQzmQGVhA1em63U+9Gh1rxz116QpZxzNYQLzU1aG7QwYfO
         hgeTYtFe5r/rpUAM+GdYq2PBENsYA9GK5qI8UzaAoAayo2KnnXaL212dH4FFL4dpj+uV
         6vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249677; x=1768854477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0qyuM/1cZ+he1ewqreZXoF87RWUYofuLre5U1znIs8=;
        b=D9BxJdKHW/yQ09NTLVq/vS0xVfrrTs7fcyv09UYRbTiqnonyQp8KmQJBvlpmoXAHrD
         wwn+ydoAwSZrzrfq5wRpiWK2m3ctknH+MV3iUYiUTcfu62yIFLb8Zf71XkyDw10LU+lk
         RctYfJ/Eb+LvOTyjNiLlLVmXMOyV/nwXRyEmcY+YhbzymCoGpkG7TAdr1mkmbO4FenQ9
         b22bdB/4hFlwy/ZiEgHmlt4IetWB28hdrxoEurxHGQPpnaZV2V1I+zjxegKKqvnPFSAH
         ZVzbvxsQ4o4EfotXGH6t+zfkwtDbdnsiFGo62gYQcWNeqFyAwCis71IYXl9v6Jdwo8c4
         hFag==
X-Forwarded-Encrypted: i=1; AJvYcCX5lwyAoBqN7IvuP9zNwWD8nh1kxHeX9AZQyUPlkhHLf08Ne0e+UChPzUtUFvFwKtNpUSIaod0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjmdVobuDTgT6Oa7Hk3F6HOGfYlQ0HUBSHSSPMK3POtNPcLqz
	UPDWVfQR4qxPW3Zn5zYnbDMH/mWliBY5u9RiizUhCiwbKeHduZfF1kMY5yRF4WAOE9Sg2dVKNgX
	LQfprK4myVr8KNkB/KbtlcUNyhJn1L1Oygxk6FH5X
X-Gm-Gg: AY/fxX4CCLXnV52hfDpHK12FKVEJIZ1Fzvxr1GU3nu8tT5vA5/f1yfVEopEUXrSvzYf
	wYoo/Mrvs0Et927llEuf+AKAJXEvnTQrgT60Ym7GzSZtR1iYsB5hyvUsEdZxKiuRnp2fWF8PF0z
	9Vf/jNSl6lDsklmGGtkkjiM6QxYjqcbUavlmtP+6niJtju3LpdbPOkNPKU0Pg+gLtjJcSOr4wZq
	qUOh8DlxOx2VW7COhmymvrcvthLQ/hPWrusT3SYqIlMKCsl/XF2QS9pU+Hy5w4dEGVTJh4=
X-Google-Smtp-Source: AGHT+IEYafyHuRuL64gxoFkY9kSDJh4WXZM305FySLAwH8Q6rel7emD0+7d+AEfjg1Hv0218nBR3qQhgiIRTEeN4Kr8=
X-Received: by 2002:a05:6214:53c3:b0:882:4572:19b4 with SMTP id
 6a1803df08f44-890842d7bf7mr271817916d6.58.1768249676373; Mon, 12 Jan 2026
 12:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com> <20260112200736.1884171-2-kuniyu@google.com>
In-Reply-To: <20260112200736.1884171-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jan 2026 21:27:44 +0100
X-Gm-Features: AZwV_QjMcK_4atLK907zn1mKFuYc2rXQnC9-M5dIxKtYd0Y2VG7WQR4F6G-7ns8
Message-ID: <CANn89iJNZshgBXSRUAZeQMK3xt+MT7KqBO5qCZvjqHQe8kyWiA@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] gue: Fix skb memleak with inner IP protocol 0.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported skb memleak below. [0]
>
> The repro generated a GUE packet with its inner protocol 0.
>
> gue_udp_recv() returns -guehdr->proto_ctype for "resubmit"
> in ip_protocol_deliver_rcu(), but this only works with
> non-zero protocol number.
>
> Let's drop such packets.
>
> Note that 0 is a valid number (IPv6 Hop-by-Hop Option).
>
> I think it is not practical to encap HOPOPT in GUE, so once
> someone starts to complain, we could pass down a resubmit
> flag pointer to distinguish two zeros from the upper layer:
>
>   * no error
>   * resubmit HOPOPT

Reviewed-by: Eric Dumazet <edumazet@google.com>

