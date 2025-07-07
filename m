Return-Path: <netdev+bounces-204563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF7AFB31D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 14:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203CD42010F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1A29AAF9;
	Mon,  7 Jul 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aroYKfJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C728934F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890978; cv=none; b=FkCOsxZfzXGi41b15s6HYRUrlK2+SHIC65hE82pbp0hdTRxaN88uwexwdhABviL8lultM34hzeQ9HzBQxmL8R71hV7eiYfe2CZJx5BmeJy+DToUPKrtb2pHktnB4MiIjXL/8IHOXubDLYODfzz/07emWrhwKbLlorueWIcoOAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890978; c=relaxed/simple;
	bh=EbIwVWGrvCj/w9SGk7EAImBhD9ATPqR/BLUabvsyYm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVrHHMg0QNgcGYkZDOUsEOUEaov8Cq+aV11a+UHD8mZjh/GMoy79J5J2X+GJafTYMFDRc0cVMLSJEqGtj0C81hWppJjyEUPxT+mjl89kIARPcNUgAyxKPqJ8pQ6kxn+ZRGUf1omImNnjncRiYqYKxELtGXkNGCRbqbjjcODVw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aroYKfJf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a44e94f0b0so40553171cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751890975; x=1752495775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC2OTWmkGVSsuY5pTtvXdp/tUOOzmOOr9IcRB4wUDDM=;
        b=aroYKfJftD16ZuvOuV8wMdmzkvcDv2PXn2Rhv+hhCFD80ltv8cFTTqDY/4XBOaFDpx
         DJhoIFQu9cWEoVhDM25qYKgFNW5eCCDT7VZjPZosJt+LZqtnzlJmA068zRFPt5P3Y1FF
         4U0kwKlU9/NlERCnBlRkw8Ahjda0h8qX23W3cgko1NkOb88zMBgI00JyFdw99EOdpRqJ
         O+vmEd7VBWDgfpi35c+tGSK/JrFZZCQg7CGUFPfFPIvcOmQ1hfYZdoF8xsg3/1yJ2m7E
         eylWcH4bjEoPUqdlLRBMiCMSyaw+/q97OpJpIw3Whq/knt2IexzR0RjjQPiCAxkO3p8f
         lhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751890975; x=1752495775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kC2OTWmkGVSsuY5pTtvXdp/tUOOzmOOr9IcRB4wUDDM=;
        b=oXeL/RnjxSnmufbDkbz+zybouaok10uSfh3aVQ3IZ5WswCcAEeskbDkIGkZEuj+xgB
         DPr/diZEJnNR67nA44troGRGSAGsUXQgePYeRFMaOByLIPqsKc3Awpe7tLOBPH7hEYQw
         zK5pBmlaBGrHj248uIRzJII1HgYh5H79a7cqHs6PoCeJSBtqrlsQ6qPsQLEp3v5p8KcR
         FbWYq4gF+0XRhU3hWCbRBiIxHmK43C5SJdi06Nznds5Mzt2mUX6DtsINhIqcAtqYnnXR
         eN3437c5Nz3r7W3vOGUkM6MOffJv8LfOp2c5z4uctutTS544ve+JtpyhZC6NNeKpCmqk
         94IA==
X-Forwarded-Encrypted: i=1; AJvYcCW74L2spSX7b8SQXLA49PooLtFSbzna/y5jW4yg8ASvhGZ0IOWCfcXIOw3Iv9/SsGu5kveoPZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSeADqnd3fUtY0gMg9a9/shYDIemIQu+Ft0tn4pfiwrhgPjvj
	eq7Ut/0xAUVKcScoDybbTd3+f36o4auA8N9tR/KGRmsD71njLDbI//BlePuv4IVQxTh9/d9Thzc
	zL+fNgczCi8Nonu0bEMPh4tTuB0TN8FqK9mh2c5Gx
X-Gm-Gg: ASbGncvo/n7tYI1DWtn+jWsGVJBvc/EwF4k5Yi1YLmCY73RYa4L1XUsysMcc38nK4O6
	JeEsY5PD9XocqNCnfKjpGvjUVC94pJFnyma9vyChkRAJFmIizN1kThR36wzeRPvoibFt2zdcqh/
	pIupas5sLWRqLjEkxNtKWJoIfgyzayLgN9KLiAVmoJZeY=
X-Google-Smtp-Source: AGHT+IGmu1jMB8m9mV8Tvai9M9eqluKCKwizyfOIqDCTpHTFG9NpgFDmREZITt+nSs5e8TFauiHUjuiBum43hF1gaYA=
X-Received: by 2002:a05:622a:5e83:b0:4a7:1403:15c0 with SMTP id
 d75a77b69052e-4a9a6828d6bmr143410911cf.4.1751890974914; Mon, 07 Jul 2025
 05:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com>
 <202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn>
In-Reply-To: <202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 05:22:43 -0700
X-Gm-Features: Ac12FXxCIE-AGdCW1zPw0jMzjWM8tMZL_ZlRElWTTwxHobUT7zQ-ePBitnGFpAw
Message-ID: <CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fan.yu9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:47=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> > >
> > > -/*
> > > - * tcp event with arguments sk and skb
> > > - *
> > > - * Note: this class requires a valid sk pointer; while skb pointer c=
ould
> > > - *       be NULL.
> > > - */
> > > -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> > > +#define TCP_RETRANSMIT_QUIT_REASON             \
> > > +               ENUM(TCP_RETRANS_ERR_DEFAULT,           "retransmit t=
erminate unexpectedly")    \
> > > +               ENUM(TCP_RETRANS_SUCCESS,               "retransmit s=
uccessfully")              \
> > > +               ENUM(TCP_RETRANS_IN_HOST_QUEUE,         "packet still=
 queued in driver")        \
> > > +               ENUM(TCP_RETRANS_END_SEQ_ERROR,         "invalid end =
sequence")                 \
> > > +               ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,       "trim head no=
 memory")                  \
> > > +               ENUM(TCP_RETRANS_UNCLONE_NOMEM,         "skb unclone =
keeptruesize no memory")   \
> > > +               ENUM(TCP_RETRANS_FRAG_NOMEM,            "fragment no =
memory")                   \
> >
> > Do we really need 3 + 1 different 'NOMEMORY' status ?
>
> Yes, different "NOMEM" status pinpoint exact failure stages in packet ret=
ransmission,
> which helps distinguish which process triggered it. Beneficia

ENOMEM is ENOMEM. Honestly I fail to see why it matters.

If this was the case, we would have thousands of different ENOMEM errnos.

