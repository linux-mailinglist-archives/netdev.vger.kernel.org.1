Return-Path: <netdev+bounces-107642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01D91BCB3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C51C1C22659
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1A15358F;
	Fri, 28 Jun 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkSLfn1u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C71103
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570983; cv=none; b=D0MjRam73J96KpnikhK1Np1vNMIlrJ7nl3FF14LVAwGtsePpkAvZTDzTSqyecMMtckyCe4JAzTyEokg73pQqjcumlVEA9uq7dzeupewURuaZXX4AU97LtP3i3jup7POafev/nB9seC8vdVw+/qJqkNUjDiE7r25WMPcFrpr0qos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570983; c=relaxed/simple;
	bh=aJnY9QxRyi2NjkuCRfoqHpp2+f44ZQwBjSLLSX9n9wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r75Dc/qVOW8FurnANtPFjIUzvmwmaACLNUZDmqqRtwkFhPgQsec4v6DSU1Se/yfKhz9tGdiRX1vldszkNS0T9Hwy3zALsSjXIubpIKaNh2EiqsvaC5kwj1zM9a6fv1h3aMwOwZniwVr9HToqKaMEo0aFNGtD3G9hTbsHpp1Cxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkSLfn1u; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef7cf84648so169386e0c.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719570980; x=1720175780; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/8oDAJ8oHU6OB2hH49e0r55PxOtFfDMJPwUG/rjDPM=;
        b=hkSLfn1upIe7AVVo2z84QPUusPblp8aRR5qF3cfJRQnQBRLF8EOIZh1l3fV4ZugrtE
         yvNBZz3k/DGQLzJa+f/cWxiGglxMD7L8eog9kwa9ocmSGLirKl2pwR7el3SxpxbTag1r
         UZcuWNPzXFiM4fzAGSNckCg/OGFTRPs9Oze3gZ2FdzCeMhYfrVegvhFo/3Z8BVUw8yJ4
         QAt4vioRC2dJpjh2xDMXJtlwIyc3WelBNz4S98NrR6gPkayQzHZiDk0sSzyM4qnEUQyS
         V2J4nJPhSFbbJ5U4Csyg6zEoHPs1AMXSjfhIvfzd6EbFdQU5YISS/YG7TLeZ/KiTlgFr
         QztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570980; x=1720175780;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/8oDAJ8oHU6OB2hH49e0r55PxOtFfDMJPwUG/rjDPM=;
        b=o14CCzEV3KktgRw/bMegvfu/ojZWP269GFouD2uwfZCRO4DqQH9r+mD2h/m4mIHvEv
         DS+c+e8c6wrXgk8eZ6tOHLDDyGDNpjnu+AHG4tLO3p6Mg/vl7UDlZxMBrt9MkVHlwMMj
         IHnYIuZRufQ/i1xocFo/8YiGkMZxAh2NNxGTC5RXEXpVaZU9p+Vs6iLdZjk1AbkAw53N
         ltblEChfSdUeBt7uQ3SEK0VSoOdO2/YudW2dnvFXuCDZuTE8QVX/5JZBW8pOC/jGtTh3
         CKPzhfqPjVFE3l//9D8EjR48MNHf36tvnJSmZJNsgQI8nynDDcbEzIRWxGbKDxb0YqBw
         B1OQ==
X-Gm-Message-State: AOJu0YwJj9VxJmTzj3jBmxCxVKZ7xsd08KOKNZCty7hPkhcZSq5EUlzM
	FSvlxAASejW0tlV14vtoYJp5ZwnAGEmchJCDfnsAUPTN+5sFKFt/RvKhx4wtCXzE0igiES6hl2K
	brQ3TAwJQyva1C7y6X3XpKynVCLwfNhV0AD0=
X-Google-Smtp-Source: AGHT+IFE+5TL9VwtOjMM6r/t/Un6gePePBKW5/q1fMAOKXGUpD9twxD1pmFwfNEvLgq6Ry0tLmEpQCMaAgqKiBxZTwA=
X-Received: by 2002:a05:6122:991:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-4ef6d895f37mr15788608e0c.10.1719570980054; Fri, 28 Jun 2024
 03:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
In-Reply-To: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 12:36:08 +0200
Message-ID: <CAA85sZutqkV1seb3mV0exjLDNxN59jc0odJbpzejiKW--gAm9A@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:30=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> Hi,
>
> In net/ipv4/ip_fragment.c line 412:
> static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
>                          struct sk_buff *prev_tail, struct net_device *de=
v)
> {
> ...
>         len =3D ip_hdrlen(skb) + qp->q.len;
>         err =3D -E2BIG;
>         if (len > 65535)
>                 goto out_oversize;
> ....
>
> We can expand the expression to:
> len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
>
> But it's still weird since the definition of q->len is: "total length
> of the original datagram"
> Which should mean that we are comparing total length + ip header size
> instead of just total length?

So something like this:
 git show 1fd2bd1e3335d0aa43e4ef2f55c7314f419026d7
commit 1fd2bd1e3335d0aa43e4ef2f55c7314f419026d7 (HEAD -> master)
Author: Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri Jun 28 12:30:24 2024 +0200

    Omit extra ip header from calculation

    Remove extra ip header from calculation of the
    total length of the IP packet.

    Fixes: c23f35d19db3b36ffb9e04b08f1d91565d15f84f
    Signed-off-by: Ian KUmlien <ian.kumlien@gmail.com>

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 08e2c92e25ab..e55a771919d6 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -431,7 +431,7 @@ static int ip_frag_reasm(struct ipq *qp, struct
sk_buff *skb,
        if (!reasm_data)
                goto out_nomem;

-       len =3D ip_hdrlen(skb) + qp->q.len;
+       len =3D qp->q.len;
        err =3D -E2BIG;
        if (len > 65535)
                goto out_oversize;

