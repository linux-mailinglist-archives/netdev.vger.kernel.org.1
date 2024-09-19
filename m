Return-Path: <netdev+bounces-128996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76F97CD1C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52303285574
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE791A0B0F;
	Thu, 19 Sep 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEJYoNfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3931A0718
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767378; cv=none; b=r3XoVVMk+XP4Gki+CRbcefDBQdb/GSeHgczxxT+w44xQXaFmd2Ruor2zRJMJi3A/Espfn/RCPlP3bUuZPB/dplqOSk3gQuseJEGgvB9/sj0pBskxX6a9wBSMl6C/OGLnPYWuT05iodYglyjZru9BE9p2gfyhJTB6ZTeKI+hU1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767378; c=relaxed/simple;
	bh=NGZ4cEDKAvn7ZD3WWvdQS9L8ilhpi9slNO1H0XzN1CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnLAa0o4IRAVzZoutA1HAbw/IkEg09RTE7rYErVFu8U1qPlaHbBGMwIHwy3pVrS3J3If1FkynMm5vOI8w+ZhDmwRPH9rfowsDQyklReZs6PinBcwEeGkoGrTxbCR4GzwdDWb8gJD4hqjrZrp0gg/Xt/4U1ppu2GqVTf5EfTQdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEJYoNfW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582fa01090so24481cf.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726767376; x=1727372176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks6hub/TdeqrDb2IvtnQkOnVrN63/vk43ZHL/AB1aig=;
        b=NEJYoNfWV7a9Hl3br8hvbvBChQgdnje6D61a4fFF27DqOLBa5p8WWkUrXqIYdIrOai
         8zX3mhni3zKdaq4rglczz0/fHPsvCTO7fU/ngvm6gD7g/pYzK+2x+kV9a+a2MBiwlQ/e
         2abTIyE+3jdfMJBBH0qvWkfJ1TPcIZuyfNwY4NkXZp25z7EGRpk2h4KWfS3JiDkFGYiF
         lMM/Cy8wk1lanIarJ6k+zT6C3TYXflS/NBfCB9pxtSQL7Sewzi1d47k/9GnYQf2QihzR
         XSHQL7TJIhz3TM9jCmOhE9+eUK7sTGMFSvnHbSvQAT7avExeH4fCJI6THQHW7ZcVTpID
         Q+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726767376; x=1727372176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks6hub/TdeqrDb2IvtnQkOnVrN63/vk43ZHL/AB1aig=;
        b=ifsE7cpNbzmsEsV5IyHq6x5Dw45rAZObksnry9jJghgX2VfseXZDZLbqJnP2abdd06
         G61wt3eQ4HIEtE64W8Z53r98hBGeKpNVsXrI8in4yMo3ZWGFoppSBcrjAbcYAkFbLrH9
         tPW7ahf4OqYpdim0ESguxpmHLdsh2Q0VN7x8zRV4i0bUCxo0EGdwiVkYAY8gIIR/Dco9
         OKPA97kgErGYNRNSifxtHuzA+6AEBwuOZfSxXAhn2BEGW3s0ZK0EQQUCHGviSvFSCUa8
         dRjqxwS8ojVoqR6+ZCWd5NucvItFDBW+rflkg5ctLSk82hVlh85blf4Ix3phSAfrCDzq
         Cgrw==
X-Forwarded-Encrypted: i=1; AJvYcCVFUD+2pietIY2W1uTjYW9TQjB9zvLiK8SkFfQ7//RJf+dlQMiTVY6vv3TlJftAKXzXMSIxUqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcY0Lx7lQhLo0cN62guH0wSSjeAHJl1oVVp0z18v5iBUpvTW2
	dUtS5a34xTCg81ysfyVVrm128YIlRrXtud2S55kMcQEJafeJ1UAPWy6kjOROOQA9gjtI8M9/d78
	sbjSYHFDCdf3/kL6aBuhreLV2YB0scGEkLfbq
X-Google-Smtp-Source: AGHT+IGxyDPePzXZ5vLroJBfqbgC30jhg2JJV1is2MmAXIBPxoPSMK7odDR6y9hFSTUVM8bALQXxpktoCrqpSIiFWqs=
X-Received: by 2002:a05:622a:24b:b0:456:7501:7c4d with SMTP id
 d75a77b69052e-45b1960caf0mr3575561cf.9.1726767375970; Thu, 19 Sep 2024
 10:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com> <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
In-Reply-To: <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 19 Sep 2024 13:35:55 -0400
Message-ID: <CADVnQykS-wON1C1f8EMEF=fJ5skzE_vnuus-mVOtLfdswwcvmg@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Josh Hunt <johunt@akamai.com>, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/10/24 21:08, Josh Hunt wrote:
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 2aac11e7e1cc..196c148fce8a 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct =
sock *sk)
> >   {
> >       const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> >       u32 rto =3D inet_csk(sk)->icsk_rto;
> > -     u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_to_=
usecs(rto);
> >
> > -     return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > +     if (likely(skb)) {
> > +             u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jif=
fies_to_usecs(rto);
> > +
> > +             return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > +     } else {
> > +             WARN_ONCE(1,
> > +                     "rtx queue emtpy: "
> > +                     "out:%u sacked:%u lost:%u retrans:%u "
> > +                     "tlp_high_seq:%u sk_state:%u ca_state:%u "
> > +                     "advmss:%u mss_cache:%u pmtu:%u\n",
> > +                     tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> > +                     tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> > +                     tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> > +                     inet_csk(sk)->icsk_ca_state,
> > +                     tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> > +                     inet_csk(sk)->icsk_pmtu_cookie);
>
> As the underlying issue here share the same root cause as the one
> covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if it
> would make sense do move the info dumping in a common helper, so that we
> get the verbose warning on either cases.

That's a good idea. It would be nice to move the info dumping into a
common helper and use it from both tcp_rto_delta_us() and
tcp_send_loss_probe(), if Josh is open to that.

Thanks,
neal

