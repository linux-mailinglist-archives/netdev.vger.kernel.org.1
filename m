Return-Path: <netdev+bounces-134301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB1998A69
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D830428A8FD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48A01CEEB6;
	Thu, 10 Oct 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtT4+t2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EE1BDAA8;
	Thu, 10 Oct 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571236; cv=none; b=tbkaSW4JAd3Fu/FLmhB/diy4YPwfULKXsmeJT4iJQtvEDDKS3OPYXmpBghKzAccH13j2YakpCDk50yB/Xxh+EPRda8EwPvkGZg5+V5gsCj1qbf25ztMHpRjNLv2S0eLqBvcIrRVtO4DlQYjA1rq8xgLLfmUKRY7IlSCxTDk0ZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571236; c=relaxed/simple;
	bh=Uw0PChq+ymcSS11ZU+ZrJfcdiLir1wxzbZaISEvDMGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8kGZKOlIgZ4+WhOXd4tfqGB6wpO+g5QiJqpe1cn+pNh9izEzI1Nk+yUsLJ0gcTG6wCi41+BeWnG2NeWDTbTHVJkfb5H5OhObryIAFd6Mu6wJv0H4K6QsNE9qTq1KWBm+Vvt3m9kpq79IS1UcLcD0Cnc+T+ra5J/p8LtDFx15AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtT4+t2Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so11223095e9.0;
        Thu, 10 Oct 2024 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728571233; x=1729176033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF/jWd8fGs8LeWQgkGFwh/5bqe8edHZKSnypA7J8f/o=;
        b=RtT4+t2Y/PyU50n40VCP4XttOhEcZa6XqISAxUjcY+CxbXZqGzkSFiiFrII/Forkj9
         A9jAPyVAimhvpBBFehPrG9QCZOkkEoQ/wrbdtrGPewWuB6WSFzsL8KN1+zpX98Y69JEh
         bzaBlVrC/Ohot5gPwUW7w49S43khjSJCnBMaykQzOOTZJtZiSiTg8e3kqJ2cNtPSHSZc
         GfyFT3bpFxwlAn5LjTa+gZhriWgYZzHmaxMckYMuZyB3gZPSpYP03oISo1SYCdbYhySo
         bWG9ul8QQDiR7nVU7bdIg1biraLik547PK0lPpYkjY3tueZgcei6BbsrPihdZJCJ7qb9
         P+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571233; x=1729176033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF/jWd8fGs8LeWQgkGFwh/5bqe8edHZKSnypA7J8f/o=;
        b=jeeq4jRxN0jFc/ZiVZVfbl6zMQWznm5/6I8V4B7n1VX2qu5DIEH7Kf3p+uHN3+UJZV
         TEk0loA8jZs2D+OE+FpqA8qRpZs6vWZalL3dvygL55jURK/mdEyGOG298PIYTgPpHHXG
         QtehDkjRfx9hk7YkF6dLGwWtAHCteJo2XpPmXZyAlnx5RkTWbEM8+NMzbpvnnW+nhJMg
         rEMm8Q0L52oOPTb19oiAOnev8LDtlK9zQhr5FGktJikauU2kII38te8M46yoJHZzr4uX
         8qYejdV6fbg+cdjqAh2HjXttAhVMuBraEyJ6o9x26Hqsj3+bcHJrL15561x9pAEi9t51
         8zow==
X-Forwarded-Encrypted: i=1; AJvYcCUbpSX4zwYFkfTTMNuX8CTw9Ps55pSoFNcZhFmPsv44p+lRJtv7kE7TaPxgtXrVLp8vijj3BCqiGlSl8MI=@vger.kernel.org, AJvYcCW/wXubmWbUDyUTZTuMspZ4i9BfFhCJr8KQ+DRtJs4sQ+jkSAsi4gVOar+ObhVfrDC24uzTpnwO@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7dt4p5qzB8EmVK/8mBTxnIt6Zbv2BwWFD5B0ifbIooh18zA+
	JMavCbfccaf/Xpos7miME/ZI4N69Y0Vn7a1xY+q990X5PaCPfeAG4AVUWviyXRz05l9ff0i+Ubp
	K5gLwG6ut/aYErvUmrCeXPqbGPxk=
X-Google-Smtp-Source: AGHT+IEZh2f5YBV8vDeLvSvZJmCD2xo8a+aoiCMWJF8PtiqRHvFXdJlI2MOO9msJDL9SNb4AdAWznpPBrsEechU7Dvk=
X-Received: by 2002:a05:600c:19ca:b0:42c:bbd5:727b with SMTP id
 5b1f17b1804b1-430d70b3d31mr69737805e9.25.1728571233018; Thu, 10 Oct 2024
 07:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-10-linyunsheng@huawei.com> <CAKgT0Ue_mp1JB2XffSx-9siR4V6u3U_jEyy91BUqTS9C6TJ5mw@mail.gmail.com>
 <fa578d46-d898-4d29-b42b-cb93c57bdc5f@huawei.com>
In-Reply-To: <fa578d46-d898-4d29-b42b-cb93c57bdc5f@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 10 Oct 2024 07:39:56 -0700
Message-ID: <CAKgT0Ue-P-P72HCOTYXDTBBxNE1CSxNm417_LN+XcizuaaFN8w@mail.gmail.com>
Subject: Re: [PATCH net-next v20 09/14] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:32=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/10/10 7:40, Alexander Duyck wrote:
> > On Tue, Oct 8, 2024 at 4:27=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> Rename skb_copy_to_page_nocache() to skb_add_frag_nocache()
> >> to avoid calling virt_to_page() as we are about to pass virtual
> >> address directly.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/net/sock.h | 9 +++------
> >>  net/ipv4/tcp.c     | 7 +++----
> >>  net/kcm/kcmsock.c  | 7 +++----
> >>  3 files changed, 9 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index e282127092ab..e0b4e2daca5d 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -2192,15 +2192,12 @@ static inline int skb_add_data_nocache(struct =
sock *sk, struct sk_buff *skb,
> >>         return err;
> >>  }
> >>
> >> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct io=
v_iter *from,
> >> -                                          struct sk_buff *skb,
> >> -                                          struct page *page,
> >> -                                          int off, int copy)
> >> +static inline int skb_add_frag_nocache(struct sock *sk, struct iov_it=
er *from,
> >> +                                      struct sk_buff *skb, char *va, =
int copy)
> >
> > This is not adding a frag. It is copying to a frag. This naming is a
> > hard no as there are functions that actually add frags to the skb and
> > this is not what this is doing. It sounds like it should be some
> > variant on skb_add_rx_frag and it isn't.
> >
> > Instead of "_add_" I would suggest you stick with "_copy_to_" as the
> > action as the alternative would be confusing as it implies you are
> > going to be adding this to frags yourself.
>
> I though we had reached a agreement in [1]? I guessed the 'That works
> for me' only refer to the 'sk_' prefix?
>
> The argumemt is that "skb_add_data_nocache() does memcpy'ing to skb->data
> and update skb->len only by calling skb_put()" without calling something =
as
> pskb_expand_head() to add more tailroom, so skb_add_frag_nocache is mirro=
ring
> that.
>
> Does it mean skb_add_data_nocache() may be renamed to skb_copy_to_data_no=
cache()
> in the future?
>
> 1. https://lore.kernel.org/all/CAKgT0Ue=3DtX+hKWiXQaM-6ypZ8fGvcUagGKfVrNG=
tRHVuhMX80g@mail.gmail.com/

Sorry, I overlooked the part where you mentioned skb_add_frag_nocache.
For some reason I was thinking you were going with the
skb_copy_to_data_nocache. The issue is that adding a frag has a
meaning and sounds similar to other existing functions. By sticking
with the data_nocache suffix it stays closer to the other similar
functions.

