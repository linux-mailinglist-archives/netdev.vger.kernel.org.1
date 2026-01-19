Return-Path: <netdev+bounces-251231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A954DD3B5D6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B9273001CB3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3233D51D;
	Mon, 19 Jan 2026 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gURMQjlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C3265CA6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847432; cv=pass; b=XuMQuZgo76erWFgsHhzMoEkQFTNkI8XzE5LdVQLcR+uBtFKqXTrOh/ToEZKMOAM51ODHEa1lphGAVn6Rj2mwOvOp472Kv/tJ3wVQ/1EC7gR2+2FZvbBYpb6zgrPW1jgNy8GKIJIqE2WgDxSWvkYs9UVkcGP81v0v1JXlefAtGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847432; c=relaxed/simple;
	bh=vgszI6cCZXQwOc9JkKqGmtOpBxXZD99wwJ+XMcxh7uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqn2SRUeYiJ41TmFRcwluHDd1xR3MiEMGWDmEr0UWTQTb55oReQbh1tV1HvK5nyUgv5KOy6EanM6kE3Bx+qXBtrJU4O9i/RYlqVBKE7OtbcusVRYuX+liYf3qVQODA/3A2+IR54BTzeE5ay7QQag++JAYel8V3lZm1+UzpYMuAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gURMQjlH; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014f383df6so33169011cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768847429; cv=none;
        d=google.com; s=arc-20240605;
        b=KnJ73+j/Ha0Tk+x32rRV3jYvns2WHaYvyukh1tObrUFI3kmgFPpnr4D9l5zIJnaw7o
         MY9ws2Yr0zu3hQNy2RI0p+2YBbgTP+ld+X8vN85lgajxkiawCled6odM0kWlHDQilK3K
         FLFjuyv2dia5NX+CbwTJP8bIWxl7gpBRR4OIa2+lDDG0l0e5kBIHyNDlAfaMLxzHyl0Q
         ip3jpZ1oHDTSgpePdcwbEen+5oVsY7WIS+A+I0XfJ8rjmMGiAJAyWqbrECK0TqyiXgzb
         to0VyppPVj5o8FLQ6iaxgCOp/Uj5CMfgDcz5I+D4Af/VLFahvqvSNP0RiSP58CZchBUz
         m2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftKLEjaQUbyuD7656IgMCQNfxU0K/tkhA/+X6cZNmLQ=;
        fh=g+1vq1meh5m4mr/jkC1BzoFTyNNXGxzlJwxUFzo+JgM=;
        b=KICTOcYpnYg9YKuxtxxxQLKsPRgrv3bGXVxdPqx+zK8FNJg/dYNmY0TDOVAPjMvaXN
         I/uN9bMcaUOOLoeRCBcQcrkG/G1jgweR0QA+pnrkP4ojfrEqOIIwjmeK5ws+LmqfwL4U
         azhU1fRQ1yuIbWfrN1731cULrYOe0/FtAIz7+f8tfwtUCZKF5QUCO26WZXyQg20dkoO5
         5jBn/ZfQENXdQJNsWdOYedvLpmYy1x6DbMMbZ+2q4EAGcymxlqjpyjcgZ5al5J1YvQHT
         ainvaw0bo246pbPQ7PaxJn6dDUelVvTjvL2lS5QSc9KbYV3S2//R4hpgRakeULLE6o8t
         XUyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768847429; x=1769452229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftKLEjaQUbyuD7656IgMCQNfxU0K/tkhA/+X6cZNmLQ=;
        b=gURMQjlHdAKMf1B1rb6WJZlsv61ud6R9ye1oyGoOo7Akx3hdZTWaCypwNRy+H81WbI
         xzWHYti2vKApwx1ol2FpCyRH/u1JXHV9UCNL1DqWcoCB3i1d0/PB21yC0o2+2GZhxV4/
         WnPTFaIpYjaCCyDSaaJ5yTeXcCsIAjIj5Iz9H2uFGMMw5LlQ20P0OZwZp6diKNzGtlNY
         gB+dooju+IgZmYjh3uK0y67rmHy6gNSN0OspiAljH2Rljh3eXqSXi4heC4bWio7Guu3a
         Cqp8n4tE4F1geif4Zk1UHbJRyAppQVfoCG8hdOqVvcp+wep0YFXeerhdToEI9EnLncOn
         7N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768847429; x=1769452229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftKLEjaQUbyuD7656IgMCQNfxU0K/tkhA/+X6cZNmLQ=;
        b=nNn6P2JTggXWgDi3ENhD0RRFCawMwzPMjYuU7bKdJtnZv2zIKQywJPckIBbL9WCE7b
         UvUQw245yM/rQJMjjGVUTBLpFtTJm63dHBU9zsVpmj2GWoXVC+tzQACaT0/9bqiQtOhs
         v02rOJ3x1QDO8WlIWxa3Vpx4fhxpRklNkD7qUzwTUYGm/eIll6aLIFneIAewCwXCUZXW
         fEakqBp/1Bqx46cJIzJiGEvm54ExZQ1gFoHZ7+H6yDeGLJLvtrYIGm5Xeua4KGTumnMm
         hT910YOOusnKoQ/f1Zqa6thi8zILDH111FC/+m9QJbsAb/6N7F0j1S2RI+2n4ZorNHwK
         vGbQ==
X-Gm-Message-State: AOJu0YyON9T2wk9HGYztyZf3FrTlu7Y+TkIbJFOZghfclG7GU0Hkg6KF
	nasRIwHmOXMKUBXCvasXBhPUc7yeeg8IHegHsWYnr+MFG+LpH+b6tVqAGhqY4NjEnM3xcqqCD5H
	xeHoj4EGsT4NJdIIRFQ/HpR3M22bn0nrKTAk+g1d7
X-Gm-Gg: AY/fxX4pzIIxlpYx62UOTjAKTnmn79E07+/sviZbk2WVHccb2zTH06j33Aa2v1H2ryH
	yCksEx8U6x3D2olSD6v/nZFltsSI6iiZpCmtKqcJUf9R3p1HfXRE4rGPeMZTBepl77BtuS8BKPj
	Pdbdwp6W2g4TTiG0VSaMk6J9JgUPR9eyVYsogqJFJBqSOT/Bw73kvXbZYOu4gnQklLa3NwpKrdL
	vK4bTjZL10D4kBfEMbHsK/W0FRPJEIcjho+ZeUKbR4XZCHbt7UqcAeXgw1qiT8yKjUkwj7n
X-Received: by 2002:ac8:7f92:0:b0:501:51e4:1ec3 with SMTP id
 d75a77b69052e-502a17af1a5mr185095821cf.78.1768847428917; Mon, 19 Jan 2026
 10:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119181339.1847451-1-mmyangfl@gmail.com>
In-Reply-To: <20260119181339.1847451-1-mmyangfl@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 19:30:17 +0100
X-Gm-Features: AZwV_QjKb_1FAZXii00c9IWa_fqsbrqWxRCzJ-O4G7AnyxJrMfXiqsPeBX31LJE
Message-ID: <CANn89iLviB6PVFw-KH1nD5uTdFWPXALpk05exH0+_iiqe2YE4Q@mail.gmail.com>
Subject: Re: [PATCH net] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, wangchuanlei <wangchuanlei@inspur.com>, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:14=E2=80=AFPM David Yang <mmyangfl@gmail.com> wro=
te:
>
> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
>
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packe=
ts")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  net/openvswitch/vport.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 6bbbc16ab778..bc46d661b527 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -319,13 +319,17 @@ int ovs_vport_get_upcall_stats(struct vport *vport,=
 struct sk_buff *skb)
>         for_each_possible_cpu(i) {
>                 const struct vport_upcall_stats_percpu *stats;
>                 unsigned int start;
> +               __u64 n_success;
> +               __u64 n_fail;

Please use u64

New __u64 only makes sense in include/uapi/

Feel free to change existing variables for consistency in your V2
patch (please wait ~24 hours before sending it)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 6bbbc16ab7780840c0f0d18f629b4747efe8f0e4..1c51f1fe0810976bbeece229be4=
370cad9a31c1c
100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -310,12 +310,10 @@ void ovs_vport_get_stats(struct vport *vport,
struct ovs_vport_stats *stats)
  */
 int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 {
+       u64 tx_success =3D 0, tx_fail =3D 0;
        struct nlattr *nla;
        int i;

-       __u64 tx_success =3D 0;
-       __u64 tx_fail =3D 0;
-
        for_each_possible_cpu(i) {
                const struct vport_upcall_stats_percpu *stats;
                unsigned int start;

