Return-Path: <netdev+bounces-119587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F395648B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8223C1F2533D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0715747D;
	Mon, 19 Aug 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPBbYOT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044115697A
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052303; cv=none; b=rQUzEUUDhel7oDC+QIEz6gjOd/6H2ZaG46j7B22PJKMFS8h811xO4bZ2joMmeO3YR6vw1ZEH5mZPnlZ99yYuMOXs4COYPjh7+8znRpbwI0pEXoGWvC+acOvQR5wc2YDZll/ofZUg/LIz7X2kUg64jznmxv1GFDyeqoSOsxucsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052303; c=relaxed/simple;
	bh=GTouNxipXEag7bXMiVAAWO4b44iRhXnPCxPmfGhgmEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgAJczuM9SKDY8TDtRnK1Pvy3N+UWMI1JlFmrjuZF4M3VQ61mq48zMljjMuBjpETxeNXNLfr9Ae7ud/RZjEM7TWB/GTRC3Go95qf0qB0egMRvFFJy0bJMcwqud3l2xJbMNGhMaXb31n2J4U4s2W5wjGh0IieDyUn/ZWmRCjRRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPBbYOT+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a728f74c23dso522167566b.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724052300; x=1724657100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP6HHS2VU6GzIk7U8Un+JLDbecx8mdLrxhCWlHI62HA=;
        b=dPBbYOT+1qwPErzssg+g6pQ0nZYukLsQjCk3idVN9GO+gS+ItQ+RgCXTKU8PJlV0Mx
         UIF99q8bCBc7+se/endBgjWgU1b/Tx19UL7z7Ftz/0y3VrkHEGLFnqCxss/q95hyJ+D8
         6xVdc20DtvBs+hSECCaIeaAbKX1Nx3Ob4uuFcicPt3XzqyE7UfYtC5TiFmLhYGqlJPCH
         6di+1r3CbU4NyevNEHt9274xdhaH9qrnRv6ilg+zYigjkfw9JFEe4sov4q+sa1YPXp8X
         J3LWoxHoMvTz0ZwQN0kbSIMu6jJInqFOhMThYzKxYwalsHZPnqviAhetwoMDJ4/uunly
         IQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052300; x=1724657100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP6HHS2VU6GzIk7U8Un+JLDbecx8mdLrxhCWlHI62HA=;
        b=ri4z5J/Yl+sQqF1zbLgCXDfmyfbhcpUnrzypxAgnnFTS5IWr+VfcndDvZhY9LYytna
         dz6fLmnSXCqCGfvFtJaX2wrIjxr8Ojz1/SsWqPg2LxuIj+DfFTJ0ZPY6vtV0s56HkAbb
         mwuI1qO2AfdcCVbVDcW19+KCGNvy7A9IVK2k4RAylNVtRbm3vtcyuGsPTz8fhz8FkJdx
         Srs0mXO1D+JUi5A+B5ysvtqu5j7HKKoq8y4I36v/S/m9OiqiOOGNSEH6otUrepJqqd7s
         EEp8niUcC4OSAPWStw32qHdAhKVK9HcM8eh48chqz1tiLbI6kRLqk+wAx4duAT6cJUtc
         Lacg==
X-Gm-Message-State: AOJu0Yx1t2sA1IU8DIXsU9epaayUnLYOWQRcMDGxdrAfWHUIx9bYbk+M
	966IMjOFXhf/ILPCQWxImBIYKLaFY7M694dnsyGRw+jpstR8KR3GbYPio+G/ra1Ezof5SHXbd/R
	Tz7BBgZ5/yFr/MSac1afbpURIKNseJ0aUDRdR
X-Google-Smtp-Source: AGHT+IFSfpsvOWCc5TtH4zDfSVjYw0Yd+0Aq0f7P/Zan7y7J4NhBcHxkJoVAxbO9hB4wvmBf7slngQLPi4d3LNRCSMQ=
X-Received: by 2002:a17:907:f193:b0:a80:f893:51bb with SMTP id
 a640c23a62f3a-a8392a4c515mr668912666b.68.1724052299295; Mon, 19 Aug 2024
 00:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816080751.2811310-1-jchapman@katalix.com>
In-Reply-To: <20240816080751.2811310-1-jchapman@katalix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:24:47 +0200
Message-ID: <CANn89i+Y3m7fQhV+C5JKp+axhNez2fpH6TMewU6k+sLJtM8uNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:07=E2=80=AFAM James Chapman <jchapman@katalix.co=
m> wrote:
>
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> skb_queue_purge instead and remove the unnecessary lock.
>
> Also unexport ip_flush_pending_frames since it was originally exported
> in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
> l2tp and is not used by other modules.
>
> Suggested-by: xiyou.wangcong@gmail.com
> Signed-off-by: James Chapman <jchapman@katalix.com>
> ---
>   v3:
>     - put signoff above change history
>   v2: https://lore.kernel.org/all/20240815074311.1238511-1-jchapman@katal=
ix.com/
>     - also unexport ip_flush_pending_frames (cong)
>   v1: https://lore.kernel.org/all/20240813093914.501183-1-jchapman@katali=
x.com/
> ---
>  net/ipv4/ip_output.c | 1 -
>  net/l2tp/l2tp_ip.c   | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 8a10a7c67834..b90d0f78ac80 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1534,7 +1534,6 @@ void ip_flush_pending_frames(struct sock *sk)
>  {
>         __ip_flush_pending_frames(sk, &sk->sk_write_queue, &inet_sk(sk)->=
cork.base);
>  }
> -EXPORT_SYMBOL_GPL(ip_flush_pending_frames);
>
>  struct sk_buff *ip_make_skb(struct sock *sk,
>                             struct flowi4 *fl4,
> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
> index 39f3f1334c4a..ad659f4315df 100644
> --- a/net/l2tp/l2tp_ip.c
> +++ b/net/l2tp/l2tp_ip.c
> @@ -258,9 +258,7 @@ static void l2tp_ip_destroy_sock(struct sock *sk)
>  {
>         struct l2tp_tunnel *tunnel;
>
> -       lock_sock(sk);
> -       ip_flush_pending_frames(sk);
> -       release_sock(sk);
> +       skb_queue_purge(&sk->sk_write_queue);

It seems __skb_queue_purge() would be enough ?

If not, a comment explaining why another thread might access sk->sk_write_q=
ueue
while l2tp_ip_destroy_sock() is running would be nice.

