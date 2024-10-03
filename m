Return-Path: <netdev+bounces-131524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0198EC15
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C95B21C8A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15B13DBB1;
	Thu,  3 Oct 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeywwUpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C801126C13
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946688; cv=none; b=gRXX2riMN/nTCErHGeCY1H6NpSxRgh2wGRseeiYBpk+uNkou5Tj4xPFjBu/6d5JtP9oZ+Ze81p8DyC0lQW8x2P3mfB/saZboWkjvg8YzPO8yrz7jXBa2/p9oKs9GoRNQj/b4qBk/MBOuuPCnUgyP1e/PWTSVLgv0e6UAa2GPWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946688; c=relaxed/simple;
	bh=hZKUigBw8D+ZpxYLbA8nYtGd16ZA5hPjjzGxA5Cev1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfOLxcGAr1yMBP9gateursONG2ND/AWb4sYCHbUc5Vwk9VnSbqO9wxAz1zX8+gkGLkG89LzcWFX5jOh/E/OAV/FYv2zzLAJy6FeIrov/gPBKuwvmGzEucNg/T6C5U/qdHJzhgVCOteRqZSQQPuQ2dKVRijz5AUIQTDKWSx3v+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeywwUpG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso9388401fa.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727946685; x=1728551485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTKQxCfHPtSXNiiPYwZQOkZVi3FeeRKHQDCMag4brS0=;
        b=OeywwUpG1rE8v5s1LtW0Gtydd3UG//D+bdf7VdeWt+1eK8Y7lSaA6mzXxKnvIn+5Za
         1dlREg2Qup7pZoPGqUDwo2aJe0e5YXnG/9GjV/+akc/uuspsVsrN6zRvxK1NJDrqCx0U
         rocJ52srFHjXxm7/bU76LQlKXgbREHH/J2TTh0hJfyYI8XyQ2RmELQlZLa5xaQXxqwgL
         g1cYXmF8dyl97TeITN972ThwlE8x07P7vvSxAaGu0Kif3WUG5d3pJPWxAoG08/Q4kIAc
         xc3BU1zzJH25qLzSlatiZgR9TcKg8XGv7y2NRpubt87z/Qoe03i+0D65e1yNjnvbyhK4
         fI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946685; x=1728551485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTKQxCfHPtSXNiiPYwZQOkZVi3FeeRKHQDCMag4brS0=;
        b=cnatxXYhSvxqS/JLw40k4fPe33NvYuLgKSNsPxgqvlzm2K/xNAz5LB0hRm1jE8sPKK
         p+uezwA73Sw/NCz/yI000B/RuGsbwFnJtEI7binHnAMMs3jX1fNjbt3PBY20D+B4HMs8
         aOASTZeUC1l6QFTr1J8WPYbq/wz/obl/jGZJU3sHPuA4WI7i+8CpDdpUHcqkPxNHotpZ
         joqoTmTWIPI+Q0GAYjsNqQHkLnCM6YnYlzEotIhKGdIXn5c8QRpbAH453/nMZRgXSqgl
         3EdLyXMPUWzBtrYhgZHAiD8rNQXZpLCeDKxUz5oGgdPPG//izREW+adcYro385QszngY
         XXDg==
X-Forwarded-Encrypted: i=1; AJvYcCV+OZaJx/PY56gZeKCaRjhXS+HmYV9E1xlCE8/U7qr9NkbsVlW83YsEs69ycuMlew7sCZj6sVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnGRXTWUQYIKYy5ynDjKox4geo22E+ty69eFl9Bsk1XYR8aAe
	d7zWVwv+cFKP27VSedr+Kp/M9dRBJA+QL//L2Q2xO1q/+CbZNdbZ6ATu9CLClW1CoWgtwOymmO5
	nnPoH/d9OcRBSX814/kMZ7/EZokfQw44YDUum
X-Google-Smtp-Source: AGHT+IG53nskLEGK05cTljhOvdbby5Aye33/mxPsMCd+/hEpyeH9Lk7FlxqBBCpMdRW16nvmMc6sndab63auL4ue5e4=
X-Received: by 2002:a05:6512:6cd:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-539a0678f14mr3588507e87.25.1727946685329; Thu, 03 Oct 2024
 02:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com> <20241002173042.917928-4-edumazet@google.com>
 <CAL+tcoDNTLoOc9yZsCGu-tt7SqgbJf=hdfkaW_isjR7Cntc5AA@mail.gmail.com>
In-Reply-To: <CAL+tcoDNTLoOc9yZsCGu-tt7SqgbJf=hdfkaW_isjR7Cntc5AA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 11:11:14 +0200
Message-ID: <CANn89i+8myPgn61bn7DBqcnK5kXX2XvPo2oc2TfzntPUkeqQ6w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: add a fast path in tcp_delack_timer()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hello Eric,
>
        !READ_ONCE(tcp_sk(sk)->compressed_ack))
>
> I wonder what the use of single READ_ONCE() is here without a
> WRITE_ONCE() pair? It cannot guarantee that the result of reading
> compressed_ack is accurate. What if we use without this READ_ONCE()
> here?

Have you read the changelog and comments about this 'accuracy' thing ?

If you do not use the READ_ONCE() here, only concern is KCSAN might
trigger a splat.

The WRITE_ONCE() for a single byte is not needed, no tearing is possible.

