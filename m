Return-Path: <netdev+bounces-83184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473438913E1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE00F289A23
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF33987C;
	Fri, 29 Mar 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z8+1mjeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BB3FB83
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694673; cv=none; b=qqBLerspzX0X+UNqPMhHSnCbVIeeRnwSieBsDwjEfzFL8RZVsF8s3T5w6lukpUHhpiTrY0z8NiXb5vI+9SGLQ6GquhC/K4TZBz/K6zdiou3rklt3tLuoN3nTXRKXV+h3b8iUUkWnWZvXHKx51dxf+A4Tj0AF2vMnvLkcYeyaggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694673; c=relaxed/simple;
	bh=QyLhvbLzZNaq7OaMKztfAUffp1QZkQXSTFw2VopRYpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgF537tVvtIbbelSEoV366h5MzQklhBe6HaLWEkVrpZDoTztuuCopi7jasXFIMeRu3p//32hN1KL2x5lq22h5S4/Qt5KoShFu39Bg2Yq/XHTjLushvNK3BzgaY9roU7CczJ/Apud2ilek1Myrk/KLLIKqv0l0bUG2AxLsIMmVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z8+1mjeD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so11760a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711694670; x=1712299470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGtOLe+p4kPumU7ZPJUBm+R9ysxptvXaYficGvhxUEQ=;
        b=z8+1mjeDUDJ0MDTNnEV+Vc15HavA/PmRiyLRCAkotwbNkpXMus8C/lTtA7W/ndiakb
         IsJnEq79a8d8MAW+0z953JQUl2ieoA5qGAZlwASCEJ9pyyQCjrFWwHKCQ1pXTLufH+41
         3NJEMxcjN+n+9LfaYELTfwIgKht0xxLhXZOODKS2jM7pijMKLIAVBPzYcc6Wnqkafg6G
         DkYHd1HQPR0OB30ny5LB+xh24q9Uqtao5KFEsPQt62QTp8MfGiYnWkBWBiY+9EwqTyJi
         gTNktoTMzEAiQ8YobmS5+LhjBgM57Q1ttRFRsbJQAJpoHXWfiZFQ9c2/QRqR4YJUDovs
         fNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694670; x=1712299470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGtOLe+p4kPumU7ZPJUBm+R9ysxptvXaYficGvhxUEQ=;
        b=VO2twK0MEJ4hPeiAvvFN8zQMY9AsLZMuuaIBF+xwYutzGyaNn0CvMb4spYHWyqknY+
         AYcKVuG1HslMZt/WZWGfT49hUbaBXeitLG6vNLY+FMYrqxGTnAiZDyTkDsDJrmRZkl+/
         /33owo9X0ZcWi5WOguCf1mwF9XEbzad80VSt+8Zm80Jf0CV9avpN9vNaOWOqaRalMMqf
         c/ygxgZByo2ATfcw/0UXGhJHVpMslXj5lPPYmzKFulwFTcuJOfcdCkJfyiUa14EQknD2
         iFm0QowYY/ySA78y2OryXyCLEUEmQ0TghccIHLYDAwmrjBxBp7fRQIo6xDHJ2mlAG8ev
         xg5w==
X-Forwarded-Encrypted: i=1; AJvYcCXbPMwyJhqO6VLo8DeQnvGM65f67tTE9x4nDrXQKROJDUaKutgx3sZ946dphB96eib/T2c2mhzFkY5tO7MIHP8fRvagxo1L
X-Gm-Message-State: AOJu0YzDDfVAqH54j8C+jBzO12NT1PrmfKq1N6sekDfV2MV9991p0zro
	MhYJF9CqxmfydACymnD8PzBaN5tPrgpkP6LLRorNTFcfqlMIl7eoVkOifs6twYZUHOctbP3StbW
	57Ymx7Tww/ZpkfL1fdoN5HEunl48zG450OF9j
X-Google-Smtp-Source: AGHT+IE6l06H6ASrtDHQ5sbSRhOzGC2TtoYAv79eogrZT7Xav5ecmdxIOT2uETAUJUG8SziNDIBm1+YaYPl7APtfYOg=
X-Received: by 2002:aa7:c445:0:b0:56c:53ac:b34 with SMTP id
 n5-20020aa7c445000000b0056c53ac0b34mr65057edr.1.1711694670197; Thu, 28 Mar
 2024 23:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com> <20240328224542.49b9a4c0@kernel.org>
In-Reply-To: <20240328224542.49b9a4c0@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 07:44:16 +0100
Message-ID: <CANn89i+m4sj9X96WRrkUZXr4MFvgsG+TY15W9ghGrT11sR+GkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] net: rps: misc changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 6:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 28 Mar 2024 17:03:01 +0000 Eric Dumazet wrote:
> > Make RPS/RFS a bit more efficient with better cache locality
> > and heuristics.
> >
> > Aso shrink include/linux/netdevice.h a bit.
>
> Looks like it breaks kunit build:
>
> ../net/core/dev.c: In function =E2=80=98enqueue_to_backlog=E2=80=99:
> ../net/core/dev.c:4829:24: error: implicit declaration of function =E2=80=
=98rps_input_queue_tail_incr=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>  4829 |                 tail =3D rps_input_queue_tail_incr(sd);
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../net/core/dev.c:4833:17: error: implicit declaration of function =E2=80=
=98rps_input_queue_tail_save=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>  4833 |                 rps_input_queue_tail_save(qtail, tail);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../net/core/dev.c: In function =E2=80=98flush_backlog=E2=80=99:
> ../net/core/dev.c:5911:25: error: implicit declaration of function =E2=80=
=98rps_input_queue_head_incr=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>  5911 |                         rps_input_queue_head_incr(sd);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../net/core/dev.c: In function =E2=80=98process_backlog=E2=80=99:
> ../net/core/dev.c:6049:33: error: implicit declaration of function =E2=80=
=98rps_input_queue_head_add=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
>  6049 |                                 rps_input_queue_head_add(sd, work=
);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~

Oh right, I need to define rps_input_queue_tail_incr() and friends
outside of the #ifdef CONFIG_RPS

