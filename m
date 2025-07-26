Return-Path: <netdev+bounces-210282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CDB12A36
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935917B34B4
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BB2264A0;
	Sat, 26 Jul 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJDSLe/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD91E3DDB;
	Sat, 26 Jul 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527768; cv=none; b=OPIp5BK7McZiLWB4PHM9Zh7jku6j32O97XOoW0LgwKNmWv0nsIbJG1qnQZeo9erhN4TR5VcouOk+X4fbbLiURERquaeqdb+XpNjBP66OtxmRGJnVMy0YZvO5pTHq/jvkmphNbzfnguBunkt65SuDxCxM4345gOU4K0GVPUjNikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527768; c=relaxed/simple;
	bh=3HUha1BBOXbxMtlMVmeIcVVQggx5ZsrMvzl+M4e0FMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgF/felt2u71nQJDDG2+6CdQNrnOHj+MiTrlKWmNxuaZoqeXdXjgf3JEklfkmnDrRd2l//XqHq9WCJKWXtMPIzevh6XZ9Dwdeyd4lWP4IRggeTOWXwNNmwz2OiPdX0wCPgVVLOcQTKpL0yLqJDPwtC6oT5ILJhvfnLkSHoiVy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJDSLe/N; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-615913ff67fso1565230eaf.0;
        Sat, 26 Jul 2025 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753527766; x=1754132566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6N8u7i6bavRtncX2NloOXYK5MdGg/xlO/tgSTQhg80U=;
        b=GJDSLe/NpPjz4KeggOnMDxiXRngj9EG+EvpXIadbsDV+YwigffIWmYozNb4mF+n1a3
         +nprLQhoG/KC36xJ5r2j463uSYjBpts7gDakWmzxpPRWK6hq5Ly6JaB85SDcGHTT6721
         082f+jo701N10fM6cskVH+CcAKC8Hp4rps6yhHklNgik2/hntW1ZQM/OmHmJhmdSejcx
         JgG2WSVvoinztPSxd4ecFI5Se/H+KovL6g0RXUuyMQ0QYcr+ILazS6mzUbs3F78mdKdB
         1mz+UvtxT4SEu83RHXP4Ct9SfK8U7FOv2aoBkzK6fsghMCVWwljMDiTiy1Nj9yyMSXN+
         KgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753527766; x=1754132566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N8u7i6bavRtncX2NloOXYK5MdGg/xlO/tgSTQhg80U=;
        b=Wtm1htDA4p/l04BmpqeXyJu7qMicoNbqQAbJ3PBleGepVS48tnxyf0CK6fg5UAtO0D
         U6aTNynM1WmmsZoBWRbJ8uF8JHwLAsFpraLnSR3vwS/cl14thOf+7FOE9qQgUaNJffYr
         hkWccIXiqoenfozaaitHSJ94ErrBDdlQDo9H4MUpuZbhIETJ0yKrwQLsJbB3YkRURUUv
         wjJln5I5KN8SfclQgHzJmuvNx4Ktow9rJI+8sSoTIkZIdkeSLYUKSgg5R2Cs+GHDE6Ce
         IFK4JFqMOwNTA3TtrNCL+zxOMENQlFSBLp7mKlYESj1LuI9mJN6vzRu4jex+McArWMoW
         h75Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAxR+x8HPslsgaeTsgP87R8bgRZa5xYejSN6vZDtgW76D44/P19zRF7a+rRjEQeMmboDanoO3bLNHNP6o=@vger.kernel.org, AJvYcCXUXRiIaNSFXa+7gKz/4Lu7mJMqmlBa5Gm9FWun34Qd4bEYAIn2/OqCYUFULiVyuuADvcHj7l37@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9Z1n6GmZtpZNHIBIu8IPJll77TMQcaJ2f6zxfWiQahDRPi0i
	ymvyloKKCgR3e9VaqQYUTMT2tjwfKPPBmPivqsBAj0TWbhOhtXWruGwLFzE2YJFp6kFYDmIhOQB
	S2Xn4f26khlCCEwvq1+YoQMlPvEhBXoo=
X-Gm-Gg: ASbGncuLDrhlqEwtxJwE+Ss2gEyZUk+aEksSBQvSgzz6GXTalSo8Dbl2eJGgOXwWxhg
	7+ZLnc47K3zgDOlwk5oNXdjJbfL7IoFvArIhzDP6zqtuYdBRovPeFp+MBxGrI1yrX3J7CSS5TnK
	RPOukU+Ik37rHJpKIvq1fQyElEVVRQVoV0LnegAftcNpjSL5v3rRnk2S1Bi7h4sZ06sTWyuog26
	1jrD5aqwPwZRJs22Z8=
X-Google-Smtp-Source: AGHT+IEyf3AoHuWHzF2ZaG4kAT0T62PWcegvLkRfaxx91RgrmAJ6papxbmsO/hpAFgEyYRR1CiVg2Qo6LqpVshWS+nk=
X-Received: by 2002:a05:6820:2103:b0:611:5a9e:51c4 with SMTP id
 006d021491bc7-618fe208078mr5922202eaf.4.1753527765661; Sat, 26 Jul 2025
 04:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
 <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com> <aIPDLjCUHCf+iI1O@pop-os.localdomain>
In-Reply-To: <aIPDLjCUHCf+iI1O@pop-os.localdomain>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sat, 26 Jul 2025 16:32:33 +0530
X-Gm-Features: Ac12FXwepev2M9q8u7MIGx5HDPwylIpmw4JPzsJiwl_P_EHFyYCSf6GkndaygOY
Message-ID: <CAO9wTFhC=cRvJQro1g2SXiq4Zx-Oiu3Q3c8stbfHSXCA2fi7Bw@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@fomichev.me, kuniyu@google.com, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 23:17, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hi Suchit,
>
> On Wed, Jul 23, 2025 at 11:47:09PM +0530, Suchit K wrote:
> > >
> > > WRITE_ONCE() is missing.
> > >
> > > > +               while (i >= 0) {
> > > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> > >
> > > What happens if one of these calls fails ?
> > >
> > > I think a fix will be more complicated...
> >
> > Hi Eric,
> > Given that pfifo_fast_change_tx_queue_len is currently the only
> > implementation of change_tx_queue_len, would it be reasonable to
> > handle partial failures solely within pfifo_fast_change_tx_queue_len
> > (which in turn leads to skb_array_resize_multiple_bh)? In other words,
> > is it sufficient to modify only the underlying low level
> > implementation of pfifo_fast_change_tx_queue_len for partial failures,
> > given that it's the sole implementation of change_tx_queue_len?
>
> Thanks for your patch.
>
> As you noticed it is tricky to handle the failure elegantly here, which
> was also the reason why I didn't do it. Did you observe any real issue?
>
> To answer your question above: I am not sure if we can do it in pfifo
> fast implementation since struct netdev_queue is not explicitly exposed to
> the lower Qdisc.
>
> On the other hand, although dev_qdisc_change_tx_queue_len() is generic,
> it is only called for this very specific code path, so changing it won't
> impact other code paths, IMHO.
>
> Regards,
> Cong Wang

Hi, Thanks for the feedback. I'll try to dig more into it and will
post a patch if I find a solution. Thanks once again.

