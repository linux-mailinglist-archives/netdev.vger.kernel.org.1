Return-Path: <netdev+bounces-244590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28FCBB043
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 14:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850F43075658
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7598C24A05D;
	Sat, 13 Dec 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a62iKdLg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F821CC49
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765634340; cv=none; b=I+99adPtK8PvcWpVCtvdPll+xKxJ9f3t08vo0ifoRODVDcMDWP+kynb1DYNrgKMSNm6mTbf6I4IfFu85cbIKHiGVfLYU1ITpYGO1x2GgMOwpRkpDsF0wo4NH+9K/XXXKI5XzfJyjKGJbezuKEtp29AJPQTRgARA30k2LSfVtk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765634340; c=relaxed/simple;
	bh=OS8/bA21DIVh/jE195m28LnszNODbHbW2ZaxE7xVS9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbgL9w1xPx47ozaRRuhus5oqPfAO50pMJHYIOEWfNxiSMJJ89ZnwvBQNiL37cP6r9O2AnuROyW1pcYlseBLnw6IeeoELEdDpJnDd0PiApPy5SfQYqi4mIPgffUIZudklNlifWLxlMMA6hAzVbyry5OMie865emvoBw8IQFN7eRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a62iKdLg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so26894741cf.3
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765634338; x=1766239138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGsRL9xvdoN6Nu3uyTYTSI9WjXII8rdvZR3ee7/1ydY=;
        b=a62iKdLg+kXXWk7X7+00WCtcLpip00eruQaMLNndZ+Q++qtB2PefKy8okMepdyI6+O
         3XM9IzldeBTP/qdBo2vk8BP5VQbdvwFHSGyULqayRwfgco8eJ/iaFylQbhzF/mIQwPS/
         5szzfCMTaQSuhwwPCImNGOaSp31BmvP/FaFP30VZn37HIu1QOOEushtK6xZ7kPf+GN41
         QRvhAKKJE/Qlk0p2Z0/7TnmbKkSuEg3HUTmz2kMuBAjbDbDebVtFFpqJnWMkE3QLpw0m
         /21AtP2eQMyekGOsGSGY3HFy0cRmJGHoWtU0XpwYzRTSmzFcxpRZR/0qRHoZDFdSBX0i
         MCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765634338; x=1766239138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eGsRL9xvdoN6Nu3uyTYTSI9WjXII8rdvZR3ee7/1ydY=;
        b=ZzGvlDrLKxLaDfUp+LsjEIpDY1GZAEmN/g1Amcrd/ACKlHZyEcbsQiBG7+uHBUMgmi
         l5d2VwqoEi+QOV5TTxkxmOf7Bxxw9DC2AvVaxwyvOb0ntWiVHPdNz2B0wGbrKVcWuWFt
         sX04Rqr0VW/ls2beAatDHilRb4QnJ/Wd0Socecu3gfXf2PG/z533xpP8jg0HCIGIzdaa
         VEV+byiOse9pG2MGdV5NwvG46yN702ZV+OwWDIvVIJkyuLeth5jQ+CgIvNM0jw4xQocm
         J3IOlrRMx4A4HpKZeMCJs87T8gYUVxrYHMgWJtWr12FfPnMGiV4RE9IihOz3w9bqQkpa
         Qt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVCnd5dAjft8/OHRtkuBaUsG5cvRrqT7I1D8fDuNKlJAo9SP6d+dWerpWiB5i/v1NRKVUpBl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAZ5Unu/9eliCDrNQh+YM0xDmWQvJAXmY8HlA++InS68caKbO
	l1ZG15QimX6dF4ZjZanEB/3gIt8uwjPwMhF2NMyZqGdwJq1L6wthqgNYVuYx1u/XLxmkcsYIFBv
	y7moQNlTDYQdiUTkQ/3pBWL1DKj7tzSUEoyXeRyxJ
X-Gm-Gg: AY/fxX6887GFDtlUfmhrfAsDq0OnWzd6CfnA2Rj2+4gQybekZLBGQTfbKjgRiYV/pRU
	l2tmMQUVvYeUEHxnBRbt4jwwOGcD+UzFN7/oko7ZXNtr2F8cV6V/vhxGU+JaZGqB0y+ukt0v5DT
	CrLtwAxp9bpCAbOEVHUe7FO64X+en6CWN6qQlDmeJ5ohwZRCi9Ef70hTBYQHT6iB+zsm5yZ6DuC
	SbBisjvJhQJ98H1WwvGF0rL4abgWHECHXhte0sQAOrTjSAxp1qVF9DDn294s4ZxzYu/aQ==
X-Google-Smtp-Source: AGHT+IEdpu+q0erHGj2deqRm9MF4wNnxJTK3SohJhVUJYmXZSOmWySCPn66woJHfqew+wYsVhgEh5wWW/M4ySVKeSzM=
X-Received: by 2002:a05:622a:410:b0:4f1:c738:1fed with SMTP id
 d75a77b69052e-4f1d0479dfamr81954571cf.11.1765634337304; Sat, 13 Dec 2025
 05:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <693b0fa7.050a0220.4004e.040d.GAE@google.com> <20251213080716.27a25928@kernel.org>
 <aT1pyVp3pQRvCjLn@strlen.de> <CANn89i+V0XfUMjo5azSAkcr6EKucQFs6fv6mpNeL3rN41SsTzg@mail.gmail.com>
 <aT1sxJHiK1mcrXaE@strlen.de>
In-Reply-To: <aT1sxJHiK1mcrXaE@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 13 Dec 2025 14:58:46 +0100
X-Gm-Features: AQt7F2rGMYTMKwULp_shdo8qjWTSqqQIadjzIpezluGT_n2jI0V6gQxUo2QPHuI
Message-ID: <CANn89iKDFe83G4_bmzPVkKwVwNcxTX1pyjBqoHwrt+rk3A9=dQ@mail.gmail.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_conntrack_cleanup_net_list
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	syzbot <syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com>, 
	coreteam@netfilter.org, davem@davemloft.net, horms@kernel.org, 
	kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 2:40=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > > > I looked around last night but couldn't find an skb stuck anywhere.
> > > > The nf_conntrack_net->count was =3D=3D 1
> > >
> > > Its caused skb skb fraglist skbs that still hold nf_conn references
> > > on the softnet data defer lists.
> > >
> > > setting net.core.skb_defer_max=3D0 makes the hang disappear for me.
> >
> > What kind of packets ? TCP ones ?
>
> UDP, but I can't say yet if thats an udp specific issue or not.
> (the packets are generated via ip_defrag.c).

skb_release_head_state() does not follow the fraglist. Oh well.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a1b86c595183f8b131996e3d0afcc..f597769d8c206dc063b53938a18=
edbe9620101d9
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1497,7 +1497,9 @@ void napi_consume_skb(struct sk_buff *skb, int budget=
)

        DEBUG_NET_WARN_ON_ONCE(!in_softirq());

-       if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
+       if (skb->alloc_cpu !=3D smp_processor_id() &&
+           !skb_shared(skb) &&
+           !skb_has_frag_list(skb)) {
                skb_release_head_state(skb);
                return skb_attempt_defer_free(skb);
        }

