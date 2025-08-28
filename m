Return-Path: <netdev+bounces-217998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B4B3AC04
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAE71898903
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891CE287250;
	Thu, 28 Aug 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI/77mcO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BB286D69
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414330; cv=none; b=gatqFD1EYowhqWT4C08H2V8tcwFhx288md8cVtIJ7xaCb5CEuAHuazgpsmvrm47uy1nR5nmGICvLmIR12RyZlxj5Bo4UL26Yeo/ti+EPtPsgkFHpnp9679eedO5wJkyntdcxxOzyEhrpW4Vf9amwA4K2JaT4sgT3Jwvkf+wejrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414330; c=relaxed/simple;
	bh=hegw8k7wXGBvKVVKoN1jMIqBeYzOm25lJFLQRxl7Szs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrThq/0PzttuZ9wquWX5js5Yf5L2ZpOzlN5HFHGu+bVfaUkfl72k/3aaashRFJescTKrvR8RswcMxl/c6PqXaMdIundjMedHTUxtFHTDPukWUeZwUVGA2jogvvR5Tj3gPNEJBJqGBHzHKdV3HFOKqhWDgjO1zZmFAiIrn9ztaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI/77mcO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b29b715106so34441cf.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414328; x=1757019128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hegw8k7wXGBvKVVKoN1jMIqBeYzOm25lJFLQRxl7Szs=;
        b=UI/77mcO+4WfS7PJAfcB1wqkNaMOxkwMjq2qocUNWSHYygx5tvdoYG6gKMjR7oYqW+
         OTCS6f2G8SzyWtXqaMPGoJ3kemvdFTH5pFPscpUC32ve5TfWjgNDaZWB/HAKQFM9RhSj
         E8NoISIqGfKALZW703ZIk+HQUU77OV35TbK5jQJT7Uon2PYPkRgkwhJU46uUBaA7ElLU
         yj9Kb2QadTXGuYttQZmij8kFmNPwcbT+pRH0KQVydzj61NejFpjwPszvXcPlfBzczgj1
         4I9h8gvKegV54GiP617GNxo/K6IHbldcE01ob0pBzygguRuCPS8jU8miSvgjiXPIqjx+
         Zo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414328; x=1757019128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hegw8k7wXGBvKVVKoN1jMIqBeYzOm25lJFLQRxl7Szs=;
        b=G96TKq+navPBFU4kbM1lAO9xKK5U2HKPqEmGvUzABrI9ciX7JGpLuH8LJFgpAZR7Jm
         Sle/aywT4FWT47kFkQUYB+E5ZUoMUUBUhxp+L0U/JOBQh+12LOMwm1W4TBiu+bZy1+m9
         JUUHb512QiOOsgRew/qO4HLvZwVn6gvRv0Ds8gGccr7PHHwec5QhdfEiQyD2h3SLW1w9
         ZXwSl5F84w6y1Lf85QnLrnADp1Fl5Wfn8PlnFsfPKqUWhfzUTaR7lUhScIsbAH1t7mpZ
         r44SLs6OTiLqBAgXMLihLT1vYbKyN2MtrVhju7vZDlqxH+hsWzAtL2CjcWek9i0DedNH
         Frvw==
X-Forwarded-Encrypted: i=1; AJvYcCVxI0KO54y654Qc2Uafvw4QQ0telVTH1hNtd+MkRQlHTqQkSfDKgrhfV1wntRXMDFpv7arSDUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHSnrb33CtuIOLbuZYAREet0crn2XAd+CA+Etj776+QVCDvx0
	Qqdqjm0FkRJc8k6ERyXSNUq1yIRXY2DHGdvMFJk4kL+w8QgJmuJzFP6AclU4byJXwFvGqHwtKli
	pj28/I0BZGLSUoc6xUBhzMYjqXuLxtGs6n5g1wofu
X-Gm-Gg: ASbGncvxkxyoCCqIK4G5xOlaE2GZ10A88DT8GCzOX3WQnoVrE18TPDv5oQT5I4m+KQ9
	OvLp9lFPc4nWHnxO5JYknDoy+Y9fa8lDghTbEfQria6gzdZFXWcU2NwDD9KCHZ4jORoUxUN1JGy
	W3i0NSmUq4SDHCnDEcGm5CFqUpauqIYl9UJwdnc7B0BvYTdkuG3XmXqJi5kEaJojd4vpSlvNSZo
	s6kioQu1awMpA==
X-Google-Smtp-Source: AGHT+IF5kV2pUZ1XiUud9TKj2tNTR9SEAoNNQmCmVFRsvipVAlraK0TiKwu3YUxPHk6k+YrS57Us+Jw/xP+AqSVLk6o=
X-Received: by 2002:a05:622a:1a08:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4b2e2c1a5ebmr20845001cf.5.1756414327396; Thu, 28 Aug 2025
 13:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS0PR11MB77685D8DB5CEACC52391D4E6FD3BA@DS0PR11MB7768.namprd11.prod.outlook.com>
 <CANn89iJJkpSPMeK7PFH6Hrs=0Hw3Np1haR-+6GOhPwmvsq9x5Q@mail.gmail.com>
In-Reply-To: <CANn89iJJkpSPMeK7PFH6Hrs=0Hw3Np1haR-+6GOhPwmvsq9x5Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 28 Aug 2025 16:51:50 -0400
X-Gm-Features: Ac12FXyvDBeQklfoMoIK0_vNln-9PtHJSNly0R-orr15YFB-LQfHAEl3Be5nLuo
Message-ID: <CADVnQy=+j339MteN3+aGqACngWi4Z7TMr+qsbcXF8Te7gDR9Dw@mail.gmail.com>
Subject: Re: [BUG] TCP: Duplicate ACK storm after reordering with delayed
 packet (BBR RTO triggered)
To: Eric Dumazet <edumazet@google.com>
Cc: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuniyu@google.com" <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:16=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 27, 2025 at 6:12=E2=80=AFPM Ahmed, Shehab Sarar
> <shehaba2@illinois.edu> wrote:
> >
> > Hello,
> >
> > I am a PhD student doing research on adversarial testing of different T=
CP protocols. Recently, I found an interesting behavior of TCP that I am de=
scribing below:
> >
> > The network RTT was high for about a second before it was abruptly redu=
ced. Some packets sent during the high RTT phase experienced long delays in=
 reaching the destination, while later packets, benefiting from the lower R=
TT, arrived earlier. This out-of-order arrival triggered the receiver to ge=
nerate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup =
ACKs quickly reached the sender. Upon receiving three dup ACKs, the sender =
initiated a fast retransmission for an earlier packet that was not lost but=
 was simply taking longer to arrive. Interestingly, despite the fast-retran=
smitted packet experienced a lower RTT, the original delayed packet still a=
rrived first. When the receiver received this packet, it sent an ACK for th=
e next packet in sequence. However, upon later receiving the fast-retransmi=
tted packet, an issue arose in its logic for updating the acknowledgment nu=
mber. As a result, even after the next expected packet was received, the ac=
knowledgment number was not updated correctly. The receiver continued sendi=
ng dup ACKs, ultimately forcing the congestion control protocol into the re=
transmission timeout (RTO) phase.
> >
> > I experienced this behavior in linux kernel 5.4.230 version and was won=
dering if the same issue persists in the recent-most kernel. Do you know of=
 any commit that addressed this issue? If not, I am highly enthusiastic to =
investigate further. My suspicion is that the problem lies in tcp_input.c. =
I will be eagerly waiting for your reply.
>
> I really wonder why anyone would do any research on v5.4.230, a more
> than 2 years old kernel, clearly unsupported.
>
> I suggest you write a packetdrill test to exhibit the issue, then run
> a reverse bisection to find the commit fixing it (assuming recent
> kernels are fixed).
>
> There are about 8200 patches between v5.4.230 and v5.4.296, a
> bisection should be fast.

Thanks for your report, Shehab.

I agree with Eric's suggestion to try writing a packetdrill test case
for this, so we have a reproducer for the behavior, and if there is a
bug we can create a regression test for Linux TCP with that.

Shehab, while you are working on a packetdrill reproducer of this
case, if you can share a binary tcpdump .pcap trace of such a
scenario, that would be very useful. From your detailed description it
sounds like you have such a trace. If you can share it, that would be
great. A visualization with tcptrace or similar tools may be easier
for us to parse than this English prose description. ;-)

best regards,
neal

