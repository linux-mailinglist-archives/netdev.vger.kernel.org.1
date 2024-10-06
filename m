Return-Path: <netdev+bounces-132511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97150991F97
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5961C21667
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7607189BA5;
	Sun,  6 Oct 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7L9grI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111281A716;
	Sun,  6 Oct 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231531; cv=none; b=ORkk7hG5jcwu5DxvefXYddwMsksOk2TpnLHKKRbqNt/N87OFZ/El1qFObF2oD+TbvJLBJfliKPJ7r6jbHOAL8tQZ82CMsxBTboigjqdjZAFDoiMIuf28REg7l2IyOcizQ/D4/X9OOt8dl58jQRaDfAPeCb/a48HynPKGslAj9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231531; c=relaxed/simple;
	bh=+qFjgY7ZDjTKO8NSejOLDLGXwd8G0b3932ovhS9QYqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM1jQyFYv1bi8HAG3cA2xbJ7enDGhWFcl612YcVUlg+FaTw4tTq2cl8nr6MmAnOxhUI/1Ca1BWfljHNt4LaO3Cx/wr7hnyLpHWjnenFKlqgMocYhxFjtC/YmeXPUCC7q5HaYCo9iBuw+YoK7rR1a1QuGip+QWePBFl28Jvig6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj7L9grI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so47870135e9.3;
        Sun, 06 Oct 2024 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728231528; x=1728836328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRVG+gyWmN8+ifPSsxxwB0Eoyw+2tgUBVTIx9jYehCY=;
        b=Wj7L9grI6fznnprjg1AaTbvaM2f2wNuOE9yZymI6TBifpmnicPR45q2HnuZAouu8S3
         4V6lPxGGzFC+0wL/eroOF5f02AUtO2pgRFJgcTTYscY0hlfzk4oVjdbL+P1nen5KzfDM
         xejCwP9wpqVluUNJqTCE/hP/Xay2oyJsC0tRalnps63DgyZSm5KrePyHeJKTw3dBkF2F
         nnI6rVqQmluEHOAHY0iQdVF2g68ZXnVXXaZ+RSMSzYQa7PFIZp1FVFVfjgtngWNr5/Mq
         xb6z19LAVLzqDWLCuigE4x4WeGLu282koLMtAJAM6cpCPBo442Dwp+MlGE0wANUcuPH3
         qt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728231528; x=1728836328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRVG+gyWmN8+ifPSsxxwB0Eoyw+2tgUBVTIx9jYehCY=;
        b=f0siQMC9eho1zxIz0R06Xnx9sATDg/6F4rgXg5WvLmIqQnXUP5XHnLZliggKxllYCB
         PFSH62L1G0r+z/SB0RBcxLUo8vitDmDQd3CbkHeP42KQ4cHMoyZ45X+ulfZT5lceHgzI
         9krRNwsPZTCSDMWVUPtQlq+g5U0kTIx/cvOPmSjJhJYIcvRHcvt+t9Kv7MMRy5c5ZG/Z
         AhZRAWuhroTsonaOyXZ8iwfyBdG8HD+/21io99CmBRQKjY3kYOfYso0nsfLIYJ87bmCv
         1CLFBLIOhhJHK24CPfkrpWxm0ijB+TCtYHd1oE1k8Yr03OKlXV/p8FYPG0V5/rPyMVMD
         1xag==
X-Forwarded-Encrypted: i=1; AJvYcCU8JlGfUYNgj7u9DlGal7pJxvG4/lW+Hx1L+MomUBcYQsP/iuioDL7lqyOm4yNjCctr0cQsBhFf@vger.kernel.org, AJvYcCVA+hpwkYUygHjq9u6RswaItZdvevMqoKvJUVJAIe9T3QJI2g6fakh41a227fIfpzbJdloX+/vWxD5LJpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPTVi62c0h1OEV1+1f9mhKV0gsDU2SBeaux41FriwdLBviYhO
	3aIQ099RO4rCprSq7S5qUZdkKLM8Yd9dCYTUi3qfKsiDR3sOxjqCYC1b5rIqGMBvJBj+Y1EHgY2
	MxWiT9Ptr9xacgiZOG/qrvlmWXTShZQ==
X-Google-Smtp-Source: AGHT+IFmPiSjCYXvhQ01Q3DZ4dwhdOGOHllc3+uTO1QtqaB6cWFrFE0gffa/KHUs4xaUTO6LmuDJ2Gpu6H+bvPAVek4=
X-Received: by 2002:a5d:66c9:0:b0:37c:cc05:7a56 with SMTP id
 ffacd0b85a97d-37d0e6ead0emr7716968f8f.10.1728231528118; Sun, 06 Oct 2024
 09:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-10-linyunsheng@huawei.com> <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
 <c9860411-fa9c-4e1b-bca2-a10e6737f9b0@gmail.com>
In-Reply-To: <c9860411-fa9c-4e1b-bca2-a10e6737f9b0@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 6 Oct 2024 09:18:11 -0700
Message-ID: <CAKgT0UfY5JtfqsFUG-Cj6ZkOOiWFWJ3w9=35c6c0QWbktKbvLg@mail.gmail.com>
Subject: Re: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:44=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 10/4/2024 11:00 AM, Alexander Duyck wrote:
> > On Tue, Oct 1, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <yunshenglin0825@g=
mail.com> wrote:
> >>
> >> Rename skb_copy_to_page_nocache() to skb_copy_to_va_nocache()
> >> to avoid calling virt_to_page() as we are about to pass virtual
> >> address directly.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>   include/net/sock.h | 10 ++++------
> >>   net/ipv4/tcp.c     |  7 +++----
> >>   net/kcm/kcmsock.c  |  7 +++----
> >>   3 files changed, 10 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index c58ca8dd561b..7d0b606d6251 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -2185,15 +2185,13 @@ static inline int skb_add_data_nocache(struct =
sock *sk, struct sk_buff *skb,
> >>          return err;
> >>   }
> >>
> >> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct io=
v_iter *from,
> >> -                                          struct sk_buff *skb,
> >> -                                          struct page *page,
> >> -                                          int off, int copy)
> >> +static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_=
iter *from,
> >> +                                        struct sk_buff *skb, char *va=
,
> >> +                                        int copy)
> >>   {
> >
> > This new naming is kind of confusing. Currently the only other
> > "skb_copy_to" functions are skb_copy_to_linear_data and
> > skb_copy_to_linear_data_offset. The naming before basically indicated
>
> I am not sure if the above "skb_copy_to" functions are really related
> here, as they are in include/linux/skbuff.h and don't take '*sk' as
> first input param.
>
> As "skb_copy_to" function in include/net/sock.h does take '*sk' as first
> input param, perhaps the "skb_copy_to" functions in include/net/sock.h
> can be renamed to "sk_skb_copy_to" in the future as most of functions
> do in include/net/sock.h

Maybe "sk_copy_to_skb_frag_nocache" or something along those lines
would be an even better naming for it. Basically I just want to avoid
having the two very different types of functions sound like they might
be related.

As it stands it and the other 2 functions related to it are an outlier
in the header file as most everything else in the header file starts
with sk_ anyway as it isn't skbuff.h so it doesn't make sense to have
skb_ functions living in it.

> > which part of the skb the data was being copied into. So before we
> > were copying into the "page" frags. With the new naming this function
> > is much less clear as technically the linear data can also be a
> > virtual address.
>
> I guess it is ok to use it for linear data if there is a need, why
> invent another function for the linear data when both linear data and
> non-linear data can be used as a virtual address?

It isn't. If we were messing with linear data we shouldn't be updating
data_len. This is the kind of thing that worries me about this as it
can easily lead to misuse.

The two functions are different in several important ways.
Specifically one is meant to copy to the headers, and the other is
meant to copy to detached frags. In addition the
skb_copy_to_linear_data doesn't do the skb->len manipulation nor the
socket manipulation.

> >
> > I would recommend maybe replacing "va" with "frag", "page_frag" or
> > maybe "pfrag" as what we are doing is copying the data to one of the
> > pages in the paged frags section of the skb before they are added to
> > the skb itself.
>
> Don't "frag", "page_frag" or "pfrag" also seem confusing enough that
> it does not take any 'frag' as the input param?
>
> Does skb_copy_data() make more sense here as it can work on both
> linear and non-linear data, as skb_do_copy_data_nocache() and
> skb_copy_to_page_nocache() in the same header file seem to have a
> similar style?

I could probably live with sk_copy_to_skb_data_nocache since we also
refer to the section after the page section with data_len. The basic
idea is we are wanting to define what the function does with the
function name rather than just report the arguments it is accepting.

