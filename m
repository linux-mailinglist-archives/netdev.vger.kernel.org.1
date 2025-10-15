Return-Path: <netdev+bounces-229581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5DBDE884
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452993E437D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544615665C;
	Wed, 15 Oct 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7UUZl6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D417BA6
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532402; cv=none; b=lImDvNcnCXvJ6Zv8yj7kyMmsnlEgfHkDRfovtFQ6jeeYNKxR5H42FlATs2vSw5eANus6n8tiuM4MKPRd/uiDvJYjpGR/P5b2TuAp9LeZsc6XuHr7gcqWnQRBABo+zYA0ITseLeXbuKfQeBxjjH96Ths+gUdJnIeOU7i0ODMZ1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532402; c=relaxed/simple;
	bh=Jh0tj9ZkC0zPi8b6J3yBdbYZIhDvoIvdJDPkDf1+eLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/vJVZvtTTf+x29c6ITI01aH5BR41jtdZHcNvxxe5QIphTfQEFnW9tssUPsw9Z9bDP4ZiNvVYFdRxy0crFTooaYIz0psd1DFQfIi+pqqOp7nirv89ErH9xzc6mpGa83e3gqYScptQHvU0cTea5sDliomwgXHn8s4jkwSWFYXuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7UUZl6G; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-883902b96c3so552574785a.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760532399; x=1761137199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCAjgjv6l7JeR4hWHOpz4ssqo/B4/EE85fNDTY6Z7KY=;
        b=O7UUZl6GfIg3y4QBIU8G7SyZTSpfBniuqt4G6JL+YL+bvv/KEbojfxvjkxZiz6TzBc
         WqAEj3MMXFUeihKnezF0YHDmQ3pvCzhnGoKNddaUz0DQsw8kpm8SdyOkr+b99veZHClg
         vXuFU0OULN41sOzxvUFfGTD4ER39EyOm8apITziPMUVOiVfw4Yeyl+aBxDGf8bDAXPYx
         jc1M7qsKTd3BqFu49KHSe1ZUlFG5w7YXiAVrdiTAQLjAJPBP2Iu6T3vw7LQcqMM7Lbp1
         DSe8qJYcBZPB0AlmSGHFssqavP+mZS/6RtS6J+WsSl9JUl63RXAyU5riwK+4H2uMw/1v
         Dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532399; x=1761137199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCAjgjv6l7JeR4hWHOpz4ssqo/B4/EE85fNDTY6Z7KY=;
        b=KnOsDpcRkgzlY+dgqGXSBYbepnmjUxMrybMw39+3I3DehS1YUiFpF52TQRBw1mP9pD
         NGIon3UtsFc3q1+FOc7YPKluUxNd8cy/qgwPChbfCY5rCan+5K5rEUGu52JIlj8trA9w
         OW8AnoKi8ec/PSSHfyGvfQL4MV81404YmjtLeTpCZ8wJvqV3k7LiycX3TcRtyb1B2VJD
         cFHgPM2fPj0tfercWCAsx/gID/e4C8+CN70/Ov8ptUdny1kU9G9hi0dzQuWCHrWDgANt
         sqE9zb8VAJrSRm754b3sibTjZeYKTOxNWx8zsLebvKl/jNe0igVp9QY6rQVfgYmjMzc/
         QVRg==
X-Forwarded-Encrypted: i=1; AJvYcCWzsGApP3LfM8+HUDnUT07bdKA0Dd06ojdYlSaDB9TghHJiQcllwcjWLAzAHrCAGmiYEYpY9dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HlzXCukRfQmOeVVaQmpHblA9u5uOU917raiCfBI/89JNKpNl
	FdcbcWS3KjKocYIxe3KzqPrS6DGHX2lSJFYo6IQxkjLD7R2hHNIkF/g2cituGGmtYNyiVINv7kt
	/4seO72bQYlP9vZkezV4+nbs+zPrPZAvP1huuC3KQ
X-Gm-Gg: ASbGnctk98Kqmh+uRsE6NPo5fxqSftZJUSHOW5H+JWp7mjcr2QIzD/qn191ny/BB6yA
	m1ODjx2sil/HR5c5p0YUk5pKuFok5iqQUh6uH5AVRyWPHfpB0VwlVQKd8yY109vPwW7U+5meuw4
	91ZjZXdyNglWpCSsp0+9H4xgfWngfcMxXumPQ5k7v6RD2E633jTrmx1z5X2IklHGWjvkcv2yjK6
	XVqfbxW6AvYcbI8M889q1RHSTZyS6lbZQ==
X-Google-Smtp-Source: AGHT+IE9bpahITkch8iBOAQcKCnR+mfXGhWbH45TMQpYbzvTfO7SDo+5SfUVGsx4/ErF0qUHMorCuMC8ONdF4LseKiE=
X-Received: by 2002:ac8:5914:0:b0:4d8:372b:e164 with SMTP id
 d75a77b69052e-4e6ead59591mr354236771cf.54.1760532399058; Wed, 15 Oct 2025
 05:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com>
In-Reply-To: <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 05:46:27 -0700
X-Gm-Features: AS18NWBND0SFbIUTHs1Dd5UfWBjo4n6wz0c2ZQQe-kCzCBxC33j8DptYusUhK4A
Message-ID: <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:30=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 15 Oct 2025 05:16:05 -0700
>
> > On Wed, Oct 15, 2025 at 5:02=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Tue, 14 Oct 2025 17:19:03 +0000
> >>
> >>> While stress testing UDP senders on a host with expensive indirect
> >>> calls, I found cpus processing TX completions where showing
> >>> a very high cost (20%) in sock_wfree() due to
> >>> CONFIG_MITIGATION_RETPOLINE=3Dy.
> >>>
> >>> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() mac=
ro.
> >>>
> >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>> ---
> >>>  net/core/skbuff.c | 11 ++++++++++-
> >>>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index bc12790017b0..692e3a70e75e 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *sk=
b)
> >>>       skb_dst_drop(skb);
> >>>       if (skb->destructor) {
> >>>               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> >>> -             skb->destructor(skb);
> >>> +#ifdef CONFIG_INET
> >>> +             INDIRECT_CALL_3(skb->destructor,
> >>> +                             tcp_wfree, __sock_wfree, sock_wfree,
> >>> +                             skb);
> >>> +#else
> >>> +             INDIRECT_CALL_1(skb->destructor,
> >>> +                             sock_wfree,
> >>> +                             skb);
> >>> +
> >>> +#endif
> >>
> >> Is it just me or seems like you ignored the suggestion/discussion unde=
r
> >> v1 of this patch...
> >>
> >
> > I did not. Please send a patch when you can demonstrate the difference.
>
> You "did not", but you didn't reply there, only sent v2 w/o any mention.
>
> >
> > We are not going to add all the possible destructors unless there is ev=
idence.
>
> There are numbers in the original discussion, you'd have noticed if you
> did read.
>
> We only ask to add one more destructor which will help certain
> perf-critical workloads. Add it to the end of the list, so that it won't
> hurt your optimization.
>
> "Send a patch" means you're now changing these lines now and then they
> would be changed once again, why...

I can not test what you propose.

I can drop this patch instead, and keep it in Google kernels, (we had
TCP support for years)

Or... you can send a patch on top of it later.

