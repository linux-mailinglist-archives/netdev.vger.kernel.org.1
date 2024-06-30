Return-Path: <netdev+bounces-107929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DD91D0EA
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77935281CD2
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796E12D209;
	Sun, 30 Jun 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtZj+OEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBD12D1E0
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741005; cv=none; b=YhPzOURnjt0U0lETHxbztUrmVcKwmjCZr1BDq7x3RZ1x74kJx+1NWwbn0vi3pyppUjDtjZK6BBldjynDKrSjOi1ugysrUHweIHPtpk2FODYUki8FkZ5Q9mnvjNwXUxi3IvDg0sOo+oUjKVpittgFDftknWhEYFBSLTwyKoJJecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741005; c=relaxed/simple;
	bh=nly1ZJ2z/MkYWYCwjUPMUl3xmvVqlCtdrBnHWiE6mxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7OfmBFOqVwBXQMNSdZI462xZVfU//cnkf2zb5fE8psGckoDXDysE2FIotThX2E/GYnqy1LcmCNu41B/h/UcHNWd2jdz+l1b7598ke1T2YJaWBF9hVYo83YD0XFQS3nVKYvIrk7x9x7e+5/pZvQa7dibVEEdJt7c4937Lb51aNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtZj+OEZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b29539d86so17522047b3.2
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719741003; x=1720345803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ZVALEE8BLTBOPClplq0lzGx+lM/46UPAaOZVcXLWY=;
        b=HtZj+OEZCpHY4jqmB0o2P35uVpds05e57lj0tJ5r9OCrHJ7zzYSoVvnvS4B4BsRYN/
         Baq21ggEDqldIMG+cfFKbYuoTFlUCUche0hDXFlI264JNgYcuHcIGDvMaWHpQe7Fw2jO
         aDdBSeEkva1RG/84jhkHYsWr5orSZnlBLPrDEgICopdz8dQ0RYZrBGmGoLUov2E4IS7C
         u7yQZDRKwmYtOkKHOKSYqqcIdLLwbtQi/m6GRxOBno3z8MO4TAMnWM+DvZkTWjA56SFc
         4Fb0m3MWxozfKZ+oUj6r6QH+ivr3UZAEsNmaSY2hQU5Lqgc18o801mlgONraaWvw4gXX
         hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719741003; x=1720345803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6ZVALEE8BLTBOPClplq0lzGx+lM/46UPAaOZVcXLWY=;
        b=BOOHEjHmW185spTWlbOeT72iM8pAemoB46X8ily6xwO/sOI2oizpae74QW8WHb5Vkd
         TzboH8/xeB//TeibRgztpoeWkHjqqlTHaxJL0Y48hRTAxbXLPsIPdshCcXhtUrID+1GD
         GMjPRJ9nTDa2CDJVAcXLPYIxi8jGBMaGQSVHAVHgEI3yOMqofR3sL0Ppv1XlBe/qNC2Q
         WOyQFfcfRTQApbPJ/aBxcCVdbRgvpwJfjAiUaWC37oVgd+UQoZzH9ANwjZMX4Dd98GMG
         zY1wL+rE7fa17Uz37T0NhncvgXBEP4zO4km4zjWSGK2phyGYVMznI2J6Mh0hvVQfuo5r
         Y+mg==
X-Gm-Message-State: AOJu0YxeBj4H4xjrqetOkbR+UtTTe/9TXipKjfFsL+s0B/3d8bG4JVjT
	y41DYC2t8WX/kT33Ya8v4Z5BoTLCUzoni9jl0i9TqrB3BxLPr5yHKzPa7oa5UGwOs6yo5XShU6c
	Kl+oGfKY/r5trnwLhKTSFMFo6SCypayP+wrI=
X-Google-Smtp-Source: AGHT+IE8Vs8K43ARt7MqOWqeZIM6n8Nx3702w92YwSDo/4rpHrDLicRxwVzEPN/PRxhBrUYLPjb+axHQNIZ3ojqTMnw=
X-Received: by 2002:a81:7e01:0:b0:627:d92a:bdc0 with SMTP id
 00721157ae682-64c72d400d5mr34454537b3.36.1719741003027; Sun, 30 Jun 2024
 02:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc> <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
 <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com>
 <CAA85sZt1kX6RdmCsEiUabpV0-y_O3a0yku6H7QyCZCOs=7VBQg@mail.gmail.com>
 <CAA85sZscQ0f1Ew+qugkO6x6cL6OSuPpR1uU2Q6X=cSD2O2yUkA@mail.gmail.com> <CAA85sZu5S1WdJEoDWCEM7dr8CQf32M6S38Gz0TOQ5PpgHbgrig@mail.gmail.com>
In-Reply-To: <CAA85sZu5S1WdJEoDWCEM7dr8CQf32M6S38Gz0TOQ5PpgHbgrig@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sun, 30 Jun 2024 11:49:51 +0200
Message-ID: <CAA85sZsa2wuFAn+Ad3zJR+NaXKcO5zUAx7=0M5KE4dX-3wWgKw@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 1:51=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> So, yeaj, caffeine induced thinking, been reading RFC:s and yes, it's
> completely correct that fragment ip headers should be skipped
>
> completely logical as well, what does confuse me though is that i can
> get thousands of:
> [ 1415.631438] IPv4: Oversized IP packet from <local ip>
>
> I did change to get the size, and
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -474,7 +474,7 @@ static int ip_frag_reasm(struct ipq *qp, struct
> sk_buff *skb,
>         err =3D -ENOMEM;
>         goto out_fail;
>  out_oversize:
> -       net_info_ratelimited("Oversized IP packet from %pI4\n",
> &qp->q.key.v4.saddr);
> +       net_info_ratelimited("Oversized IP packet from %pI4 %i >
> 65535\n", &qp->q.key.v4.saddr, len);
>  out_fail:
>         __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
>         return err;
>
> Yields:  66260 > 65535
>
> Which is constantly 725 bytes too large, assumed to be ~16 bytes per pack=
et
>
> Checking the calculation quickly becomes beyond me
>         /* Determine the position of this fragment. */
>         end =3D offset + skb->len - skb_network_offset(skb) - ihl;
>
> Since skb_network_offset(skb) expands to:
> (skb->head + skb->network_header) - skb->data
>
> And you go, oh... heck ;)
>
> I just find it weird that localhost can generate a packet (without raw
> or xdp) that is oversize, I'll continue checking
> (once you've started making a fool of yourself, no reason to stop =3D))
>

So continued with:
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -474,7 +474,24 @@ static int ip_frag_reasm(struct ipq *qp, struct
sk_buff *skb,
        err =3D -ENOMEM;
        goto out_fail;
 out_oversize:
-       net_info_ratelimited("Oversized IP packet from %pI4\n",
&qp->q.key.v4.saddr);
+       net_info_ratelimited("Oversized IP packet from %pI4 %u >
65535\n", &qp->q.key.v4.saddr, len);
+       {
+               struct rb_node *p =3D rb_first(&qp->q.rb_fragments);
+               unsigned int frg_cnt =3D 0;
+               int offset, ihl, flags;
+
+               while (p) {
+                       struct sk_buff *skb =3D rb_entry(p, struct
sk_buff, rbnode);
+
+                       offset =3D ntohs(ip_hdr(skb)->frag_off);
+                       flags =3D offset & ~IP_OFFSET;
+                       offset &=3D IP_OFFSET;
+                       offset <<=3D 3;
+                       ihl =3D ip_hdrlen(skb);
+                       printk("FRAGMENT %u: skb->truesize =3D %u,
skb->len =3D %u, len - skb_network_offset =3D %u -- end =3D %u final? %s\n"=
,
frg_cnt++, skb->truesize, skb->len, skb->len -
skb_network_offset(skb), offset + skb->len - skb_network_offset(skb) -
ihl, ((flags & IP_MF) =3D=3D 0) ? "yes" : "no");
+                       p =3D rb_next(p);
+               }
+       }
 out_fail:
        __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
        return err;

And the result is:
[ 1764.949410] FRAGMENT 0: skb->truesize =3D 2304, skb->len =3D 1472, len
- skb_network_offset =3D 1492 -- end =3D 1472 final? no

I never seem to get more than one fragment so now this feels more like
an uninitialized variable?

