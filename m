Return-Path: <netdev+bounces-129417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F775983B06
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 03:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9771F231B8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5D7E9;
	Tue, 24 Sep 2024 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfNXCw6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878453A7
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727143115; cv=none; b=XP0vZBrEOjXtVSAYY+nvZVrZ9KllfI33AmcdYJp6fpMpHGzIUGriCUKZrk5i9qqlrTCU1WCtYsB2vHPTr7GIf2iyECb4FEe0IEFAfmmdKa/3uB5lCFT7FWa+5KEvUw48seiIBspqKl8xxWwKLhricZYHpk3iwwdakC0aWLqTwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727143115; c=relaxed/simple;
	bh=sUFUBi8d4dB0cObbUKaCOGpD5gStQqVaPOJN39D30Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FP+EnELilzXosUS8/XoilBLNOsG80XLN9WzzMWkQxCqwI356XQExV52LBQkqB9ULkK6ANVS9oC8K3qaRqAxgD9bMrs9l7ZGkc6VqNkygr4w/xAP88GcgghdPhqrT6UcDl1oyruYiR+Y3EhzMh1QRt+JxPSvfjByl00mJ70+lWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfNXCw6B; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45b4e638a9aso90051cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727143112; x=1727747912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vZgw23eg6kTXxQfx2vG9OxQtmWT6NYYz8gmrPAb5Xk=;
        b=sfNXCw6BErtK1xY59UdPRPR93XqNIP0iCVfrEXfUepOMhRFlgP+toukbfOL0dE87Ye
         nq6LVflp1xel/dYNqpK5GegOZU+P3AVobOaAX5ryKnt4gJxsqRdgBDqDjIlSdLylWZFl
         U00FPxvfkFDq9vT9lsrC67JcVr0jR1qhZqs+6MbMaL8me1DDNktxuqOF1V7W62lX7/Uk
         oiOweqWPFDWaOYBzgwKSDXBUPLcAQSx6RQVq1Vco7K3wwIzvuqq1wsVYxq0PQfLUknN5
         vJJNTwI5y981H6H75rZnyuL9BCC1ioQj2raE9RgHzv0m/Yv37ZAMAtR//OOeCsaL06o8
         6eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727143112; x=1727747912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vZgw23eg6kTXxQfx2vG9OxQtmWT6NYYz8gmrPAb5Xk=;
        b=vjdmi1hG6KKZEsTEmioJ2vTBz2zlgAmvbpRfsI6HXdVGLRZB973RWBObgQ4LMbu66R
         CnIJNtJtWFZ0rrZ6LL7OAGGtROKDgA6jVTmdu93XOmGGjq7+uE0oRInIPw+e2dGN1dZQ
         xni2jKHMnPDR1y0YvWyRkKo1nk0Z+eUA8eK9lBUlxPsz+26xx2o2+EVgm0gUHCiqoNqe
         TxoehQUUvbtAr8S1FqcjB3LHOlSayRi0IZBLStK6CWRPTLkxJQgKk0rtcDjJ73zRwxkQ
         2uPx7ZjfglxvIqQc57kGYyz4AAB5K75f/npp929stXNefbPRithkSCi7psTOoA/bN2v5
         bj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVY/S/PwXvKQng1ZiCQf3qk5IOlVPgdMgQxfXLUwQY4zTFC3KWN+N6NIeXMzaCdTxxxfEzBqVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIO6reKzfwFoBYswX6m/iB35Df7Xl+svWc6Uw9BMBo8FhMdWx
	YGSxQzFkhTt2k4vDdVb0Jh5xwAIcbb82AZMfgjhU25P4cJ6/8eFyMlcpEvgbGfrCyMtXCIP1irz
	LcQbcbubeGEUYckv7Zzko0ni29EBZzLoui8MM
X-Google-Smtp-Source: AGHT+IH1TVhvwHdSjEpZxLDp7VNj4WRVLlX0qgJ7fVUSoIYiEVbbvgIYI0X41OY9irHnivbEwntTJp1gI7OhbxSbWYQ=
X-Received: by 2002:a05:622a:1a20:b0:453:58b6:e022 with SMTP id
 d75a77b69052e-45b50a7a1d2mr1639861cf.28.1727143112311; Mon, 23 Sep 2024
 18:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com> <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
 <CADVnQykS-wON1C1f8EMEF=fJ5skzE_vnuus-mVOtLfdswwcvmg@mail.gmail.com> <CAL+tcoCMrENefD=55fkGRBAE9ZeuwgB7UG03JggSiguG-QVZiw@mail.gmail.com>
In-Reply-To: <CAL+tcoCMrENefD=55fkGRBAE9ZeuwgB7UG03JggSiguG-QVZiw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 23 Sep 2024 21:58:13 -0400
Message-ID: <CADVnQykJWYw=M8L=nXnkWN64a2=q6KRssmn3SK0hGFjT4V47zQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Josh Hunt <johunt@akamai.com>, edumazet@google.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Sep 20, 2024 at 1:36=E2=80=AFAM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Thu, Sep 19, 2024 at 5:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 9/10/24 21:08, Josh Hunt wrote:
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index 2aac11e7e1cc..196c148fce8a 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const str=
uct sock *sk)
> > > >   {
> > > >       const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> > > >       u32 rto =3D inet_csk(sk)->icsk_rto;
> > > > -     u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies=
_to_usecs(rto);
> > > >
> > > > -     return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > > > +     if (likely(skb)) {
> > > > +             u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) +=
 jiffies_to_usecs(rto);
> > > > +
> > > > +             return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > > > +     } else {
> > > > +             WARN_ONCE(1,
> > > > +                     "rtx queue emtpy: "
> > > > +                     "out:%u sacked:%u lost:%u retrans:%u "
> > > > +                     "tlp_high_seq:%u sk_state:%u ca_state:%u "
> > > > +                     "advmss:%u mss_cache:%u pmtu:%u\n",
> > > > +                     tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_o=
ut,
> > > > +                     tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out=
,
> > > > +                     tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> > > > +                     inet_csk(sk)->icsk_ca_state,
> > > > +                     tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> > > > +                     inet_csk(sk)->icsk_pmtu_cookie);
> > >
> > > As the underlying issue here share the same root cause as the one
> > > covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if=
 it
> > > would make sense do move the info dumping in a common helper, so that=
 we
> > > get the verbose warning on either cases.
> >
> > That's a good idea. It would be nice to move the info dumping into a
> > common helper and use it from both tcp_rto_delta_us() and
> > tcp_send_loss_probe(), if Josh is open to that.
>
> Hello Paolo, Neal,
>
> I noticed that this patch got merged already. Since extracting the
> common part into a helper belongs to net-next materials, if no one is
> willing to do it after net-next is re-opened, I think I can post it :)

Thanks, Jason. That sounds fine to me. I don't have cycles to work on that.

Thanks,
neal

