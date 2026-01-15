Return-Path: <netdev+bounces-250016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5AD22E82
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC8030115C4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65F32863B;
	Thu, 15 Jan 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4imA67K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0632825D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463031; cv=none; b=uAzKZpAfKB+oTorCYk+LLMcEeX9ZEWCgvF4/QF47bncQpYmLjTuW5R+BGEa7s/+PZsNiOxcCOiWUuh9giIYmVot4OCNX4GpHftGe3MKgoSVMzKHoMHYKhhjTu5QyzNlRT4iQup9tSyQO3iBp1uGxzoagLWQZdABTVDF60JqbK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463031; c=relaxed/simple;
	bh=4ZKMFzqUYnla7RqOdHYETkH39sGLPzWrK9jRFhTlv04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDowfbcxJ6Hcm1OazCpXj/pJ+6nwhlVCSp99UHjTGWi4XV8pn8nvCaC6FJfwRw2YhB0dpMuwvOJ8oMYDJOu1T2eAozr+l1qOpQC/AZN7ov5UghC7U/KGqULkk8zvolO82BaXjyUdn6ALKZ+zfZ2LPb61ccxLN/cjMV8fiylJaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4imA67K; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12331482b8fso2055081c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 23:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768463029; x=1769067829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG78mpNhTdrp/DWvaFu2sCfC8aNreM8Rt9E5tzcxfmg=;
        b=J4imA67KAyyx95CuKdPNOl78Pfa8voencyCIxGn5E7P6PKwOFRfKEEeUCIYfhM8R90
         sB4EWevHcDQKvGX3UZwRQ6i5EbbHpLer7VARGJtG89gatkhvIrmqeWIJkDjjZRaEBs7f
         YzA6U7F7IqWbmPiq2pThmtD3/JhsQ5wRCZzL/UWcQXCzwdw1u21/VsXqTyyRHO7jKdNx
         VRiRJrGBg9gui8ll5qxKFJ9AETkjTN6IFnSj0/IPjFksDkzrD+NI+gMMGRlKwH8mKjp/
         HY/9DoHb5zSmVkrdt21NKLMyKd48EJXsYDvLNUYQaKhgirwgxOm0DFEFO4ARy2BS3N9W
         AYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768463029; x=1769067829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HG78mpNhTdrp/DWvaFu2sCfC8aNreM8Rt9E5tzcxfmg=;
        b=JwlNZyGrbb3iQ6e1Koj0Mio1hMLmhehVnnkfUOdxnwWD3MrloIg1gSSlztmXHBxvi4
         nY4e/BxIHn/Jeyt5lBASd7tSCTzuTVLifDxOOQ3uZQ2/wjnwyP2viv0k1DPrYbnJp6IK
         4f0fecV0x3icaKEwmWVl4a+qSEtSgkYtgcWo8ZUiMzw5QxqKYnzP3chOhDOV/uhohkUw
         +NacSrq5721aBrG3ktVnMun260kf0FBfkYbunnc14sCage57hU59uUiiQba2qz9N+tqH
         DB1L0As8corkD42+cDOw7heAt77by/5a/1ATN/ml0VwRJds9AjFZMDCrss/QETCNvFyH
         ve4A==
X-Forwarded-Encrypted: i=1; AJvYcCWr7nZU89uTuNs/6+6KWw3ZZ/dIP7fNSOeQzVdCOeH1VdP4jrlIQGgeCI1b0bydWmSeFzejE8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgc5nmL3RyCV/K1vo+dy4En/MuPzBJFaiFLd5sCPhbt73TBl86
	K0xayvgZzLjuxPwSXjLNkGihtBjAXeYqwwSMUgDz346X7feZXMnH/CH0GPbFbmQoFf+p1ZIehsE
	TPN2W6tLgegDIUwtNhJJ8p17utXIEheXGX2A7bw/Y
X-Gm-Gg: AY/fxX4I/xJHDnNRq2ul25x0lOD/2u/Q0LxFpBa9On7dlRb+4O/HYBKgacLajFqYpXe
	VJFxVoM6/u6ll2e+bPWcOKdR4fFyAEOkyA9ALdVTDun+dSgqvZr1DNBLn9uG/w+ew2esauk+eod
	6p0z422fCjVI3r3zXWK5DUVBKwPbDu9jVDBFiIwK76SyuzI1dzDLX8PAff2LdO/2H8jUNpZPSZn
	HaOgAzAalXs6pfwJS48G2ixwFU0aewJ7zqTZcS/lKA9fs44rDAswOyT+F7aDWFOty1V9h3OrYtI
	rUxVxTf7KufjPCy4G6r9JMMEnGKOOK60kuVXkFIu8sWLnjp8IpsRcAY4FpvUfw==
X-Received: by 2002:a05:701b:2711:b0:11b:b064:f606 with SMTP id
 a92af1059eb24-1233775f708mr4935793c88.26.1768463028777; Wed, 14 Jan 2026
 23:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com> <20260112200736.1884171-3-kuniyu@google.com>
 <20260113191122.1d0f3ec4@kernel.org> <CAAVpQUD9um80LD36osX4SuFk0BmkViHsPbKnFFXy=KtYoT_Z6g@mail.gmail.com>
 <20260114194045.2916ef4e@kernel.org>
In-Reply-To: <20260114194045.2916ef4e@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 14 Jan 2026 23:43:36 -0800
X-Gm-Features: AZwV_QjXRi806zbqzI7XdTVzUP5gxwTsFDHxRFmMo2BNlZAM_nt5Ls4sSSh1P-k
Message-ID: <CAAVpQUAafpy7QC4bAff9Yx0utaoGkCf-L79Tc9C7bcqDrzO3ew@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tom Herbert <therbert@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 Jan 2026 23:15:42 -0800 Kuniyuki Iwashima wrote:
> > Btw I needed the change below to generate the diff above
> > by "./tools/net/ynl/ynl-regen.sh -f".  Maybe depending on
> >
> >
> > diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
> > index 81b4ecd891006..fda5fe24cfd47 100755
> > --- a/tools/net/ynl/ynl-regen.sh
> > +++ b/tools/net/ynl/ynl-regen.sh
> > @@ -29,9 +29,9 @@ for f in $files; do
> >   continue
> >      fi
> >
> > -    echo -e "\tGEN ${params[2]}\t$f"
> > -    $TOOL --cmp-out --mode ${params[2]} --${params[3]} \
> > -   --spec $KDIR/${params[0]} $args -o $f
> > +    echo -e "\tGEN ${params[5]}\t$f"
> > +    $TOOL --cmp-out --mode ${params[4]} --${params[5]} \
> > +   --spec $KDIR/${params[1]} $args -o $f
> >  done
> >
> >  popd >>/dev/null
> >
> >
> > fwiw, $params were like
> >
> > 3- Documentation/netlink/specs/fou.yaml
> > 4: YNL-GEN kernel source
> > --
> > 3- Documentation/netlink/specs/fou.yaml
> > 4: YNL-GEN kernel header
>
> Hm, I guess you have grep.lineNumber enabled in your git config?

Ah exactly, I didn't know that my corp machine enabled
it globally by default :)


> Could you see if tossing --no-line-number into the git grep
> in this script fixes it for you and if yes send a patch?

It worked, I'll include it in the series.

Thank you!

