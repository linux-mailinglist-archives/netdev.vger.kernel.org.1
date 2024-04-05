Return-Path: <netdev+bounces-85126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E23899914
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4242B229F2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5815FD06;
	Fri,  5 Apr 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxR3eikh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79715FCE4
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308306; cv=none; b=cRha9GE7HH9/TPTHElFu9w+VXf11gNELbFs15D4FCvHAoYU6sPDZf2s7Lxi2NsjoS80xN2U8Z+EeEN1+s23W4r1b3ZxqB2u2YusXf0G75LGqehB6ZktOiS+3nhaYHq+wDL8smyhKscNQEzAg9IGs+Cp6rVnOciZDKJZ+NDeTJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308306; c=relaxed/simple;
	bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk+HfBFA88KjSXjtjnQ0mdH5aQsOrhIBPUNh2zDPz6aLM7nJdI83tDQAhtkGZOGoJLVY8X+PdqaC4C2vKaA0g/GwkFZg6ifubLDhjnWdY3RK75QLNuwyv+eneevz4vyo47bSEItY2arJxLxyhOjrz8H78jGJo21XyI7b1B+uHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxR3eikh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45f257b81fso262331566b.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308303; x=1712913103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
        b=TxR3eikh1THgH4H0odSQS5LKAE884HJThIgXhsMZAhCz3SZlt1bxWg0B8K7e70lJLK
         cX6XZMdnEOIxLe1ftbCKCIlZtD4T4QtXSoCr+X25cEPMw+EhplL+TRUjsYgECDtOYFdu
         5Raa0Xzn4kLO6RcHlNDJvLPaD5Q3woI14PkRdyubxttlgkDAX5KvwIzdnoCjERIh5Zae
         37VKJxNO4q7QJmHnrtFrVusK1I7V/ItsLuDFQ9bmvRC3w/Zqh65ai9J96uI9TBdUVqi1
         dhq2ArF9rvuEGminwWq1hLVXZD2aosmelBqxDfWjp99WHhtaIZM3LxqtkKd8JNUoQrFd
         kXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308303; x=1712913103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
        b=ByDSbLg0eQr2CzwSFDmHNSXFneT7GUqv80xsbRART/rh2fwfJBtCvLTFYjgQRM1ztS
         GBOqv/cfB4mspFxb5MfsXiYxPYkSFB90+H/xTqsAuav7R667BlH1JkawzV3iUkjDIz+V
         A16h//a8ufZ0VfW3HMfacxkikG44qLa1JrCvdn7Vj7RwZvSGKSjQor/Q+1e+IOj9pCGd
         oT3gcEhizVG8BsAlk/9B9Z7KjYbmPhAGG3Uxph7L3026tuwVWi8d6qwGtzTort/lFdNA
         CK1uOyeZ649bbw1zWj9bknzsI6VvqoK1PAW4e9RqgMmaUgiQzLEitCOeAnn4QPluyALP
         eaGA==
X-Forwarded-Encrypted: i=1; AJvYcCUZWBcgT+AcfuAW4C5RXNSyY9ev7cDUtyTkfFNM14+v6/v1hz+jLoMsLfyUQ9K55QdBx3ktDZPi/P64yyvazaUTgIsbDRxA
X-Gm-Message-State: AOJu0YyspRk9iWK5kiS9OQVPc8+OnseEUDNrBCZJJ2vPWxWYysfsDJbN
	VJ/KzHFdoG1hqDrOhIEZHkE+pdmltPq1gbcnSwN4UNoCxWjFvUhfAhS+TKGzivrEGwkbZp+sk+3
	ulI0KnPJ0SPOiKilcjsyJNP9C9E8=
X-Google-Smtp-Source: AGHT+IEEPo8HEBxHiQd6Gt7/FDnKq9efCmeTXDQp0f/A+PCZoOWH/Nuodq5vo9IuIrQXcrOSGB7QK6gmH6ao3HKBn8Y=
X-Received: by 2002:a17:906:ac7:b0:a51:98df:f669 with SMTP id
 z7-20020a1709060ac700b00a5198dff669mr480152ejf.43.1712308303134; Fri, 05 Apr
 2024 02:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
 <20240405023914.54872-2-kerneljasonxing@gmail.com> <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
 <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com> <6b77ce4f71dae82a0be793cf17fac4fda0884501.camel@redhat.com>
In-Reply-To: <6b77ce4f71dae82a0be793cf17fac4fda0884501.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 17:11:05 +0800
Message-ID: <CAL+tcoBFS9Z-=H5g8hoyDVuvcmT+wEuAdT6GxyS-vh0hKdE8cw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Fri, Apr 5, 2024 at 4:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 15:58 +0800, Jason Xing wrote:
> > Hello Paolo,
> >
> > On Fri, Apr 5, 2024 at 3:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Before this, what mptcp_reset_option() checks is totally the same a=
s
> > > > mptcp_get_ext() does, so we could skip it.
> > >
> > > Note that the somewhat duplicate test is (a possibly not great)
> > > optimization to avoid jumping in the mptcp code (possible icache
> > > misses) for plain TCP sockets.
> > >
> > > I guess we want to maintain it.
> >
> > Okay, I just read code and found the duplication but may I ask why it
> > has something to do with icache misses?
>
> The first check/mptcp_get_ext() is in mptcp_reset_option() /
> tcp_v4_send_reset(). For plain TCP socket it will fail and the
> execution will continue inside the same compilation unit. The code
> locality should avoid icaches misses around there.
>
> Removing such check, even when processing plain TCP packets, the code
> execution will have to call into mptcp_get_reset_option() in the mptcp
> code, decreasing the code locality and increasing the chance of icache
> misses.

Interesting. Thanks for the explanation:)

>
> I don't have actual profile data, so this is an early optimization (and
> thus root of all evil), but sounds reasonable to me (yep, I'm biased!)

I'll drop this patch.

Thanks,
Jason

>
> Cheers,
>
> Paolo
>

