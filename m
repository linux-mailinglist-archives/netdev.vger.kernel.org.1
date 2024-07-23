Return-Path: <netdev+bounces-112679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3C93A906
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F4D283634
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE2143C79;
	Tue, 23 Jul 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6lCMWhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D25143758
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772102; cv=none; b=Owx7XX+kxHXPgPAOrlual9slOzSA3RcRSUwqnxEM0fAZ7XCf47eW3taORhT8XF1FhGtkw0TsdFDJnDbdAD0EWSB8Fi/myILqUKhxpzXPGIyBbIFlZIQgafu2IzMzyt3I7feJmE1rGg9ORRYVWCixM+UEY+zCjHk7VbVI+rhVh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772102; c=relaxed/simple;
	bh=5xVlqisSBJYMgU9MzkbYusXo6EHS+CLhw7wKUYkGMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8Qpnuegm3wFewLjWQYgKDhsJ/+MYq8b8m4u6VKsF6peHrmiaQmVVSXF7LOfd3Bg6sUA729OqHRmvoKA22lB2QcqNowLQx7deyGXlUVAeFhDB8Xo7Mc05FX7Y6KYz4XRw5EF3QtnRYABnFCMO601sYavERPufmxuJBGtZp6Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6lCMWhL; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5cbc5b63939so3204199eaf.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721772100; x=1722376900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=m6lCMWhLPPOR0ffCQY6MJaTN4WtwShmCUMJMI7GFf6Go94HAjbTOZCQ/99OdTIQDfO
         Sea97itjk2lM7q9DvLAdyJzlZWwMRTe7Se4l4ClkbLbCAGqM7EVi47r6cBI7b4AbEe60
         S+Fdp1gWJAIe2mYbL74tDHt9xjMh0NgZide6trtBJDS74v0QXqvjBF3mP49yF7CPl22L
         nWFAyrVxs16/cFkWlJ2vj5j1oIZJ4GDX2AJac7HK6fFVQrQwLcRhcqfJdUhSkNvTTV72
         dEMRgEMgyoA4yzhV+QuqIDSOR5cyEy4OJwWKHuX0vBhXBtIzN/348QvDOKopqRNEMA6h
         nfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772100; x=1722376900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbOzRw1HgFS5DEp3YsvL3ixVExK5DUcKmrah8c6zUo=;
        b=IwMUb3kXHBZLNrkifG0rgvm0p2qh9qZYTpllxpAC4Aq8SfRtn9h1Maw6BoYnJ2u9iM
         efFgOBRPutM0i0JZZ6LXDKu4FgHBX1kg8lBjek0dNwyeVJ8daPoMQfcZ66ObfJWzO0vh
         Myj6JyMB+rMbzYgEv5Thc2VHg9x7jShrrNRaArnMEp33+s+SYC7UhIQh5q5YLEUVKKl4
         LmDO6w3QyzGF4WfJx+qWpWozPI3uGVH5sbzfFAh4vwqTuV4quM9RddhN0vi0TZ0DEpTh
         TO53OtaRzM4WBetGJMgV0D912lzQRB1jAIXLG47PJ/iw0YeW/l8MzO3aynUvg/w/eRBw
         oBYg==
X-Forwarded-Encrypted: i=1; AJvYcCU0j7hzlwXIDMPOe7S+i/jVJnAPA7VtOwzbmENpLk0l6H36DTc68NNGUQ+Fhd/PpFArUicGNYNuMQBth/fFarvnNY1TIXxv
X-Gm-Message-State: AOJu0Ywm1qAspScXjtbRRxfLnNqLxDviqrheJGSl9TrAsFDKJYx4W+S8
	gGE+/qC1i/5UCnCvbOmzoAbWB8VRlI0qMPgmq4TPulj+8BT/hsvKxWOJhI36IPbK7k4GqBOhO0/
	T7exE3SeOnJq+hk5SElfwD8pvKL0UMNt5UAcO
X-Google-Smtp-Source: AGHT+IG52jqWawXgN2kcOVQKAVuGRKQsz6erICJGp/9Nf2OmyPDQUG4y71nh5l7MhmNmqRHohI8zQDyyM5Dy7lSVDY8=
X-Received: by 2002:a05:6358:297:b0:1aa:c73d:5a8a with SMTP id
 e5c5f4694b2df-1acc5b10dc0mr1273554155d.16.1721772099135; Tue, 23 Jul 2024
 15:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org> <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org> <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
 <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
In-Reply-To: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 23 Jul 2024 18:01:19 -0400
Message-ID: <CADVnQy=Aky08HJGnozv-Nd97kRHBnxhw+caks+42FUyn+9GbPQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 23/07/2024 18:42, Eric Dumazet wrote:
> > On Tue, Jul 23, 2024 at 6:08=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 23/07/2024 17:38, Eric Dumazet wrote:
> >>> On Tue, Jul 23, 2024 at 4:58=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> +cc Neal
> >>>> -cc Jerry (NoSuchUser)
> >>>>
> >>>> On 23/07/2024 16:37, Eric Dumazet wrote:
> >>>>> On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
> >>>>> <matttbe@kernel.org> wrote:
> >>>>>>
...
> >>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> >>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
> >>
> >> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
> >
> > It is normal, because the SYN was already received/processed.
> >
> > sack 0:1 represents this SYN sequence.
>
> Thank you for your reply!
>
> Maybe it is just me, but does it not look strange to have the SACK
> covering a segment (0:1) that is before the ACK (1)?
>
> 'ack 1' and 'sack 0:1' seem to cover the same block, no?
> Before Kuniyuki's patch, this 'sack 0:1' was not present.

A SACK that covers a sequence range that was already cumulatively or
selectively acknowledged is legal and useful, and is called a
Duplicate Selective Acknowledgement (DSACK or D-SACK).

A DSACK indicates that a receiver received duplicate data. That can be
very useful in allowing a data sender to determine that a
retransmission was not needed (spurious). If a data sender receives
DSACKs for all retransmitted data in a loss detection episode then it
knows all retransmissions were spurious, and thus it can "undo" its
congestion control reaction to that estimated loss, since the
congestion control algorithm was responding to an incorrect loss
signal. This can be very helpful for performance in the presence of
varying delays or reordering, which can cause spurious loss detection
episodes..

See:

https://datatracker.ietf.org/doc/html/rfc2883
An Extension to the Selective Acknowledgement (SACK) Option for TCP

https://www.rfc-editor.org/rfc/rfc3708.html
"Using TCP Duplicate Selective Acknowledgement (DSACKs) and Stream
Control Transmission Protocol (SCTP) Duplicate  Transmission Sequence
Numbers (TSNs) to Detect Spurious Retransmissions"

neal

