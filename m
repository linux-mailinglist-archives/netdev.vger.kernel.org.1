Return-Path: <netdev+bounces-243824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A14CA7FB6
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F1D30D69EA
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4047329C40;
	Fri,  5 Dec 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3u+V8aYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4532C3271
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945498; cv=none; b=Pq9bpw9OiRIDQg0RLRBy5IE0brJh/XSPa6iaiBeB42V9W1/YQrorZOHslo9/Z7oh5JjQiuq/pxk2AWnZtLsC+7DmkZtv0UkZsxQb9tVx2JENvRSycnTEPvs6nXeipI5Uqsmqoaw6geqOTWhA248uIiNbUcpbwHAO//xTo341ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945498; c=relaxed/simple;
	bh=f+qHGSfybIPqQcu5v4IpzPNGIxWA69AmCKdwVy7jx+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g59x57ZUZegqSKvnDOw1H/HaSm/RswRUy29DiaN8ikQ/l03A9o9FKdCm5CsOQ/sut0WycyC2uDv8h7o6CPTrq+ibzAETsyi9cFgmM4rsw6XUDhI/5VNE5RK0zzP2TNxVFCTxrKDx/7eNL88YaKAIGE+v/DzRYQX3AmojEBFo4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3u+V8aYD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b28f983333so224435885a.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764945491; x=1765550291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi8uYVXzKsvBXNrsYFQy4QQJs9C8nvzC3dnewuWAmaU=;
        b=3u+V8aYDV3uEUN5APso/63dG027BgpKK8XpXt6IijkKsihxAagYqtUN2IZV8eR4hHn
         cxLhMPfN/xxkLgS1eGzaM9+hXzA7+CkLJJ8adP+8Vuil53obenrEqbkh7ffVoGaWewxJ
         3DigD4KUl2gi7I42IwOfFB6GUHCSz3PQSOjYIQym/eMp8lC32N1PsYxB1Pnephq8MgGV
         XPsNKH/B27F23aRZzm7G6lX/yn5gx6Gj02FFE5x2GJ3MTQmU8zaK0bhi0E06hnhNhJ2Q
         cIoEj4P7K2/AEAzyGTU5d6yPjqrBqTmz9jIk0epnvl4YiI0K64P9EYLDlnxUmW5tsVRu
         DO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764945491; x=1765550291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fi8uYVXzKsvBXNrsYFQy4QQJs9C8nvzC3dnewuWAmaU=;
        b=FXa4KbWlqdyxQgrhpTT6hTs0Eq2aervut7ftNjXjWKqSiVRwbDUhKKXWJWSirjr/nH
         mKrhfKjhgoVnJd6CfQN49KQcXU6vRcNJzBbUc+uKFAcuFsNZg/7lUis74xwEpCcZ/cNx
         eOFm0RXCQI85ejqvN+zgct7uK86l3tgzULpC7kL+wOlg9NYtp1p6BmPyaZOhW0sw9gA9
         LjY3PAusLjzttYwXx8jjyp1fnl50iuHLdPs+VLqwuQvd8bKPLFMWsiPya/wdR+z/A2As
         TkVjQSYAecvyRneuSueo0jQ0qi/2ofQMHTJULAkvl0VbE7uVcDIdyK97+3Uiz39atTnf
         Vjnw==
X-Gm-Message-State: AOJu0YybWp0EJTEg4cAIODuJ9VcHHsjoG5nHPuVhDqhjMVN5hrH9H1ag
	jSF4CXV6XCxAVVZhR7E/dClUu0NOYhafL1e8EIejxKCwHJ3P3NNySr8owJnBQmAKZqK4iKuJBQB
	nP9GfOA87ebBYzNnRxTWqu92M27DZPUWiTQkf1wU3
X-Gm-Gg: ASbGncu/S2BvU7JG898OLBkwEEA1yPVzGxnyOT85++crV6YcPcZ8y0Uow0M3UatKODI
	i1HfYW1TLJWiKufz2if84sp9gKq8RISotc74/HVgYbiI11Tlnfm7q5yYQkq1kTJi7gSbKy5nvFC
	c5GjRPm5W5UfME2D9YXSMegd/2CssTG+fgnUWZFOr7FFgtcRkSoF6K/XXEoW/sA6Vsr5Ofia7i4
	KMC2SupiIIeQ9buOuP0g2RkBBxmlGQPRaMai1kf+W8YYigJgkdKw+vOpV40fjbPh7YDNXVMxEBk
	3sWvbQ==
X-Google-Smtp-Source: AGHT+IGZtL+R6JKQFwEnvlCPemaaPTcQdnio6Ws0LfgmyeEXz/ZqYOSYuP8ivHpnrLRj1AjafxH1VoL4PH2f+CWBl3Y=
X-Received: by 2002:a05:622a:1903:b0:4f0:21f2:cc98 with SMTP id
 d75a77b69052e-4f023aa1bc2mr96135221cf.50.1764945491060; Fri, 05 Dec 2025
 06:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764943231.git.pabeni@redhat.com> <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
In-Reply-To: <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Dec 2025 06:37:59 -0800
X-Gm-Features: AWmQ_bkSF4CuKXA0P2kg_b6-qxD3aymfvKmw-FkgyIHvwxXXHhMCgHvGARAw3jo
Message-ID: <CANn89iL3hp4Of_U+Yc34OrwVnTwn5j4j=WTq-yckGVcpptxcUg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: gro: avoid relaying on skb->transport_header
 at receive time
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:04=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Currently {tcp,udp}_gro_receive relay on the gro network stage setting

rely :)

> the correct transport header offset for all the skbs held by the GRO
> engine.
>
> Such assumption is not necessary, as the code can instead leverage the
> offset already available for the currently processed skb. Add a couple
> of helpers to for readabilty' sake.
>
> As skb->transport_header lays on a different cacheline wrt skb->data,
> this should save a cacheline access for each packet aggregation.
> Additionally this will make the next patch possible.
>
> Note that the compiler (gcc 15.2.1) does inline the tcp_gro_lookup()
> call in tcp_gro_receive(), so the additional argument is only relevant
> for the fraglist case.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/gro.h        | 26 ++++++++++++++++++++++++++
>  include/net/tcp.h        |  3 ++-
>  net/ipv4/tcp_offload.c   | 15 ++++++++-------
>  net/ipv4/udp_offload.c   |  4 ++--
>  net/ipv6/tcpv6_offload.c |  2 +-
>  5 files changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index b65f631c521d..fdb9285ab117 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -420,6 +420,18 @@ struct sk_buff *udp_gro_receive(struct list_head *he=
ad, struct sk_buff *skb,
>                                 struct udphdr *uh, struct sock *sk);
>  int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup=
);
>
> +/* Return the skb hdr corresponding to the specified skb2 hdr.
> + * skb2 is held in the gro engine, i.e. its headers are in the linear pa=
rt.
> + */
> +static inline const void *
> +skb_gro_header_from(const struct sk_buff *skb, const struct sk_buff *skb=
2,
> +                   const void *hdr2)
> +{
> +       size_t offset =3D (unsigned char *)hdr2 - skb2->data;
> +
> +       return skb->data + offset;
> +}

I would rather switch gro to pass an @offset instead of a header pointer ?

Rebuilding one header pointer from offset is fast : skb->data + offset
( offset : network header, transport header, ...)

As a matter of fact, some GRO state variables could be onstack, instead
of being stored in NAPI_GRO_CB()

This would avoid some stalls because skb->cb[] has been cleared with
memset() with long words,
while GRO is using smaller fields.

