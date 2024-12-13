Return-Path: <netdev+bounces-151843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0369F1448
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9421167F88
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2E157E9F;
	Fri, 13 Dec 2024 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPtBsdHl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19A80B
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112039; cv=none; b=WNBVDJW/SHkAG7hDYnlacV/590oOqaXU2YDuHJ0Gu51C8TjmLz5NQpQW2HJoLt2O0jHdZhAgiOUjp8NtbFonpI8DCoyfO0x1NUkkluzi7eSuf8ZYkgNs2ylzv+XDuouR+fB1r8Vx8Fk94+W6xM+cJZEXl9gbOmsvqyncWuh74+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112039; c=relaxed/simple;
	bh=wXzZI0ytxwVwzIBINluZ7b8Gru+8f5SBFBlNHB5NqpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyxsFDo142N3xj6tkR3B3vbs7e6HrcvsDd+Cqf/zUcak0Fgh5RQN3EDwGN8MNd/3miHy7S/5OV+H4NsKioEraLdu3r1GxoP6p+rTHphRn+GzS3ui4s5OXGHbZV5taSQftEuIblrX8iiDCg4yQDZYPAQH0PAykcBqq0tUqq3H1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPtBsdHl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467896541e1so5511cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734112037; x=1734716837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXzZI0ytxwVwzIBINluZ7b8Gru+8f5SBFBlNHB5NqpQ=;
        b=YPtBsdHlbHaEXLc1QcTMZOOdcdjJAYxjqIkvqoYGuBxUUKr7bxCuZcdbBHmSV1BJV5
         uFGhlEwpwRnovbbKZby/GGmTJe9fzb3WRHrdUBX7JVgJ6gk/4/LKYa5+9VGtmUwE2pyl
         1xL7OL88Ay9eg4NZ1PNjX76XBxuZCkMZb6hTQSyotlxzFs7D1DDB1R5yB5cjPvpFJYvr
         Fwf+gee2/ogM9Mj6senN5eiVKw18kRTHxj3xNDPj9U+mJR6UTZ9IK77wEtGhZg/TrApJ
         82PGS+NK4I/nUGUwIh3/XJ0TvBvgpaDL/47M5YRaO4/Ths3eC095p5EZ799AxdTsV2Fv
         YTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112037; x=1734716837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXzZI0ytxwVwzIBINluZ7b8Gru+8f5SBFBlNHB5NqpQ=;
        b=jkz8QqCEn4rW6o3cinQA0uH4CPbuG7pO1UuEDTOraWV+jw3UZEmYi55g42MlXDlWpt
         WC6+tqjbxIRvnruTDLg/ObL9vU6rlafssD3PFJEqa9NW3uDw+TMAVePCOkkzE+PWM25h
         +K08oHCUbAgBIHjaz1cyUr0sWdKI9emdha46dgN08bxXTVIB7Js3kmYo2HdN12P37WdL
         zuF7FCDuzsXnv/yspgxPoHVOehJA3BWWNWjILbjpi6KRvE1mp6j04DA6ex/H3YK8CSIs
         AFgxVygbtAZGlk6+Lnc0g6nMSrHwpZu1Y+7JW8Bvjb18Rpha9UDF+VNLqvYqL7hYrVa5
         QMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWK8WfponpvqZu19J5qdfFqUGj19N6elg2/68eAXp0o+jqZdu1cQ+y2xdeQXOQjDE7PDGUtTbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hEQ23ZR4X2a7YVcxH/yIgwaujHCDzz9FndGcRiD6ILIzyr8S
	Pr7w07RoeKxthUAt6x2sfH/SS6BpsIWYF1brp81UvX8NDRCxf77QC9HWzAVzW4J0j1u1YiCEoo/
	9bwMevYkDuXjLt3f2PstMMyys3PRPkVikD2TI
X-Gm-Gg: ASbGncviXap7jhj0kztN3C/dTZWCvRKrWdZQOgS0ku67eVapG+DJpVBERExbSu/iZBH
	JGlEeR3njy9PmtlT8vPLYGwBUA0of2pZAKJU8/Q==
X-Google-Smtp-Source: AGHT+IGS6+d2uRYYup3mVYQQsmrfUBS57cKOSQl/nu46hz99B2kTLXXHDIOiYXtqwLf3/LRiykknd6ZwprI5WjWzWn8=
X-Received: by 2002:a05:622a:2299:b0:460:f093:f259 with SMTP id
 d75a77b69052e-467a43136acmr4418311cf.22.1734112036558; Fri, 13 Dec 2024
 09:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <ZuNFcP6UM4e5EdUX@mini-arch>
 <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>
 <ZuNgklyeerU5BjqG@mini-arch> <Z1uLgXIA8HApli8v@mini-arch>
In-Reply-To: <Z1uLgXIA8HApli8v@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Dec 2024 09:47:04 -0800
Message-ID: <CAHS8izPAB2Vr0LoVfvz4SBpSdvmXv_CYSj7Z0ZX2Cngx1ooC9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:19=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/12, Stanislav Fomichev wrote:
> > On 09/12, Mina Almasry wrote:
> > > On Thu, Sep 12, 2024 at 12:48=E2=80=AFPM Stanislav Fomichev
> > > <stfomichev@gmail.com> wrote:
> > > >
> > > > On 09/12, Stanislav Fomichev wrote:
> > > > > The goal of the series is to simplify and make it possible to use
> > > > > ncdevmem in an automated way from the ksft python wrapper.
> > > > >
> > > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > > to print the payload and the python wrapper is added to
> > > > > make sure the arrived payload matches the expected one.
> > > >
> > > > Mina, what's your plan/progress on the upstreamable TX side? I hope
> > > > you're still gonna finish it up?
> > > >
> > >
> > > I'm very open to someone pushing the TX side, but there is a bit of a
> > > need here to get the TX side done sooner than later. In reality I
> > > don't think anyone cares as much as me to push this ASAP so I
> > > plan/hope to look into it. I have made some progress but a bit to be
> > > worked through at the moment. I hope to have something ready as the
> > > merge window reopens; very likely doable.
> >
> > Perfect!
>
> Hey Mina,
>
> Any updates on this? Any chance getting something out this merge window?
>
> I was hoping you'd post something in the previous merge window (late Sep)=
,
> but if you're still busy with other things, should I post a v2 RFC? I hav=
e
> moved to the mode which you suggested where tx dmabuf is associated
> with the socket; this lets me drop all tx ref counts (socket holds
> dmabuf, skb holds socket until tx completion). I also moved to a
> more performant offset->dma_addr resolution logic in tcp_sendmsg and
> fixed a bunch of things on the test side...

My apologies for the delay. I have the TX path ready, but having
trouble running the performance tests unrelated to the patch itself.
I'm going to send the TX path after a round of internal reviews,
likely by the end of next week.


--=20
Thanks,
Mina

