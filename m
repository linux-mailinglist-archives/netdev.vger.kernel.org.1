Return-Path: <netdev+bounces-134747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF499AFA3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2091C2110C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712F4C80;
	Sat, 12 Oct 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlfOU/S7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFC881E;
	Sat, 12 Oct 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728692275; cv=none; b=N1PEgdJA+a97OHkWzZVXmRTXovoqV822tIKhOTX3dIbezecglTlX+kCXymDETr4k58EZgx0y3D3FAKKK/4HA/9yZ9GskapnR1XquPElOgwPWZw57XGF0+SbqWPg8L2HtVq4VcyaeeAes4AF2CLgpnn5XNqEPZz8drcd4Sz4vnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728692275; c=relaxed/simple;
	bh=MQ87IYp9mrRNBtzKIFOrG28g3sEIB6k0bR5kgwL79fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhabsEWfE6HM1Pn72XYxN+0E9SCed6/kzpHmjkT2i/H1jw1bKUrtHYm7MzABkdFJk3J9XFQ6GyCiPfcCzSIyBZePqdcsUEY5xm3rZ+qaKClb5iqljbWgq8LdelHzX0B7OHgwESiJ4L8Com8yUEtO1vkNYp3J+v2Bf8z1kakNNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlfOU/S7; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-835453714cfso105428339f.1;
        Fri, 11 Oct 2024 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728692273; x=1729297073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtEO9tfNf2IQiJPPJfLC/Txk/NhQko3rBAdDuN/LWyc=;
        b=ZlfOU/S7Qkjp28nzr7oeThZEX2rsr/aVPeCQc+pmxj0GAGcMG0lLW1b87PkJR2Hn/J
         G2iM+/NCI/APNQAZvfIRM9kMQi0mtTwKUZsTfnpLlaNZkfuKQeWg/8h84+Vo74AYmKCu
         Qy1TV80ZzVXDFHDBl0O7Vpc87wKalXnfvSntWxGkDg0trz9S1jN06tnr3VksEeP7fJ0U
         83wWnGxU8b8as278+rZBQN6tMdIqegzVa6xdiixjO/Whc1bjeNumGmb9uyOZ7UwjVo+U
         J2KR33KOYJc7pzGwFk8aptr36YTGRTugZhszNuA+piLkQVFbQcQYLKMm0MC/g2lWtuUt
         q3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728692273; x=1729297073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtEO9tfNf2IQiJPPJfLC/Txk/NhQko3rBAdDuN/LWyc=;
        b=dxlBX4mjjCSaKgsOqekJ3AtpZXjhNcXeBhIVnvA9hm4k2d2/TWyMCAtH7NcRX+Kyv1
         CsxTxlfOt0yOHM+TESB8l5neOLGW7XV2XVWAPjlD6hPjDWQR8ix+zqSCO2dmZHgBpp5G
         i/d29MzpsmMuTWMayd3J3sxK4Mc4Kp9BZS7rkqJBeM3UYMWd/5T4LEJJMP8UxAGfZBO6
         e93c+iUxF/VdIUcKS72MYxlrddR9rbhDOwibPKjwXJxFiDAlmi1PwpnzvPRn367UBVxU
         V54ZXAeczFRTrPjTEzBZiPXzCazdnJMsChkB7jX4bQejIXY4IZ6rJDLIsIGHpR3pJX5Z
         aNZw==
X-Forwarded-Encrypted: i=1; AJvYcCU6STj1Q7bfcQHIUVzQLYGbQDnzt4uPdQJgttH3ee9FxfyIrwIEU3YxLdRS9SLuvg8LXMLIG1fi@vger.kernel.org, AJvYcCUQ1kj6pUuyhMlrHI0tFK+hzZyW1Ff+DU84JcIIIMq8LvFT0NzQWRIR9eejffb4GNqlMp3OpBfjz1Eh7PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7Xcp/fel02YzhgH7mGdd+D0x0Pz70vYQCqxD2kdM6fbdXm6L
	RFSOpH0uUgl+Ykcp9u2qCKqdDeVV8qRIVkBdgG14wsZ8gGPw5CGy43FkNNPuwkhtLjtG5DB0u5a
	Ar0TTyWq33Sek8NfDEcTMRSc4Prc=
X-Google-Smtp-Source: AGHT+IHDkB8Tr3KCqhvuIsu291cz4oAwnyUsoAabe1p8ofAUDsxaaZwo8RyLKmLLMenrnZ+27NC0zzfIH3SRnup8tNI=
X-Received: by 2002:a05:6602:4886:b0:82d:835:e66d with SMTP id
 ca18e2360f4ac-837932dc7cemr331768939f.9.1728692273389; Fri, 11 Oct 2024
 17:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com> <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
 <1fbd0d02-6c34-4bb4-b9b8-66e121ff67e3@akamai.com>
In-Reply-To: <1fbd0d02-6c34-4bb4-b9b8-66e121ff67e3@akamai.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 12 Oct 2024 08:17:17 +0800
Message-ID: <CAL+tcoBCsfK0qkDe_CehmYzUzNk58UjiVj8Kk0qZGQT6gbvRxA@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>
Cc: Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, ncardwell@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 2:16=E2=80=AFAM Josh Hunt <johunt@akamai.com> wrote=
:
>
> On 9/19/24 2:05 AM, Paolo Abeni wrote:
> > !-------------------------------------------------------------------|
> >   This Message Is From an External Sender
> >   This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On 9/10/24 21:08, Josh Hunt wrote:
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 2aac11e7e1cc..196c148fce8a 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct
> >> sock *sk)
> >>   {
> >>       const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> >>       u32 rto =3D inet_csk(sk)->icsk_rto;
> >> -    u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) +
> >> jiffies_to_usecs(rto);
> >> -    return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> >> +    if (likely(skb)) {
> >> +        u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) +
> >> jiffies_to_usecs(rto);
> >> +
> >> +        return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> >> +    } else {
> >> +        WARN_ONCE(1,
> >> +            "rtx queue emtpy: "
> >> +            "out:%u sacked:%u lost:%u retrans:%u "
> >> +            "tlp_high_seq:%u sk_state:%u ca_state:%u "
> >> +            "advmss:%u mss_cache:%u pmtu:%u\n",
> >> +            tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> >> +            tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> >> +            tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> >> +            inet_csk(sk)->icsk_ca_state,
> >> +            tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> >> +            inet_csk(sk)->icsk_pmtu_cookie);
> >
> > As the underlying issue here share the same root cause as the one
> > covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if i=
t
> > would make sense do move the info dumping in a common helper, so that w=
e
> > get the verbose warning on either cases.
> >
> > Thanks,
> >
> > Paolo
>
> Thanks for the review Paolo. Sorry for the delay in replying I was OOO.
> I can send a follow-up commit to create a common helper.

I nearly forgot this helper.

Josh, please go ahead. Thanks!

