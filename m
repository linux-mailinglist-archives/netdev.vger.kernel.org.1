Return-Path: <netdev+bounces-173427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD583A58C29
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2623A5854
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1391CAA74;
	Mon, 10 Mar 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXrQYb07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26935234;
	Mon, 10 Mar 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588941; cv=none; b=OHDXTv8wCeZ5HftX2d/WHD39v2jnzSE83ztO0jHRGG/e6VTQzXETtq9dwgVUyTE3Vz1omg8FzkWZZZ9rKXIKDyceb1sA/51dr0ffQngZ1/9KT5mw+SNAXk618sOlXZJJd8vAB5xK5MUsJm+gzPBu2lyJWoc7RMTYw3APCdXpl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588941; c=relaxed/simple;
	bh=BhEp2otBEAZgsY5AnuTfKAh8evygs7P0yNQfOxDfU+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuNZPRTxwIM3QKS7ewi14FeaDkocgK1hKiHAk933aA/jS1qG7ioKjquY1ZOtQJ97aesP+xSLVEpJWn1exvu9uAzKyu+nZEYemLvn3jXe5E25HE7dcFHJcToMJwC1gS6sl6gHujt/VKzHteMlagyPrx7BZkhfi6nPW85wf3x9qVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXrQYb07; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso5297912a12.1;
        Sun, 09 Mar 2025 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741588938; x=1742193738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8lA4cpPVQxdRgBTTfOuCwlEFtyztx6NlgWBRBCJqT8=;
        b=TXrQYb075ldzwdiZ+x/kYbfhc7vc6+pwJdImWeYmgWGBhW52SrCbSt3Ytapvz1Xgtv
         iR1yKqN1KQCchFQsWgTqeCjRe7lZmSwKMnVFqcml1v8NrXTYT4ILg2z4yEsnY3iUKgUu
         aI9D355/XEdUmQt7NAWqnoj99JdP8FDvxcHsMiicK48Gxp9k22fZloIY3DyEp7TDtniE
         aGBwBSHxGgkU4sfae9KjxNoQOHB3onEE3V0axa/jRX9638oSGvuIUduxDJpdxl3K7gSN
         Xka2xq5mxlQaAThxfpkgLWFh8zp3c00XBm0SKTe0res4pFNUbXQm4PVVHHYLYc5OSnoe
         zutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741588938; x=1742193738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8lA4cpPVQxdRgBTTfOuCwlEFtyztx6NlgWBRBCJqT8=;
        b=agXkQvIRl6/3ToOJrVKI31vhI/beV+bXoj48n6u6F6WoNwZwXGXp4FHpv45DjrTYXk
         ldLrU5vREVmbZxLt9f4Up9aWnHiWF+pIDYHRiJnSZKVSBPzeyzK9Vvb3ER4dtnk5OCRu
         vZLvJQm2mNG/JgLfQRVNt8vseDHS4DdvLnnEf+Y+G9LtCyoWbAN9fKNwbT+G3HZfLvnV
         ctfXnSCkuSQ3ioOgI6wjauXawkRNyjwFyUOWiItYYB8xcWRuD3NAvbgGl6haF+McX0XG
         cWpZeFGpe+H1bmj23VzoxOUKkprq68uRSrk0LJV/wPVkrozIzQCtCdczCxHXytKnXe7B
         aqew==
X-Forwarded-Encrypted: i=1; AJvYcCUbBv8Et0TRYExv2RIa5fIhX99PnNUlGa77xVQRl4fjKqFLqupgfr6SHb4CxkUkOR9RW5zdUVPrq2ktEZE=@vger.kernel.org, AJvYcCXZ+JJmYjCPcBWcQSWyTHpDKjpCodsyAblO/J8OLrQwAzS8VmVxGEjCD83pOkuLMOI97W5V8D1b@vger.kernel.org
X-Gm-Message-State: AOJu0YxMf/pVM+UCNWFHAIcflsN+m33vpIIaBP3MmoDKO3uSPOh+HBku
	viQPLlV0Gh1Hbq3AXsgAMGdl77PCgbkn6D4TBm+9KbJHVsUqL/sNAfN8bcoQ7DkTREg+Mu3Drjp
	lc3dCPqg/Y1fBj0VEEOhFPJuMd1KlRg==
X-Gm-Gg: ASbGncutbO8Ng8nflg+95jChL+Z70jVnOv3C9EhmgFelzG05W+lkht1adp0uc/V1VMv
	GYowb/787gybjlFF5/b/R6k43GQJavPs15c0vv8mM3L3hYPodTd715pi1dFH3p9uvOJ8OV0i2KQ
	ebdxzA0nCuSo6+lB1wrNbee63I+DG6MpbkUxyY4Sr4tCN1cO4oZdnGuZZHdYddvuVcFy6V
X-Google-Smtp-Source: AGHT+IFZg/tJDNBkL1fJAvQiGPS+hyqYdlF0rG31bobPwJRS9V+EWuFhJM4WT5ASl/muzEcD+1aHLyv/fiUdZDOG8qo=
X-Received: by 2002:a05:6402:1d4d:b0:5e0:348a:e33b with SMTP id
 4fb4d7f45d1cf-5e5e22bf175mr12513948a12.12.1741588937834; Sun, 09 Mar 2025
 23:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304104030.69395-1-jkarrenpalo@gmail.com> <20250304104030.69395-2-jkarrenpalo@gmail.com>
 <20250306175219.54874d3d@kernel.org> <CAGp9GRaAHRW=a2yT42e+_TACic+keVeNkeuUVRY=n67dhjt3jA@mail.gmail.com>
In-Reply-To: <CAGp9GRaAHRW=a2yT42e+_TACic+keVeNkeuUVRY=n67dhjt3jA@mail.gmail.com>
From: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Date: Mon, 10 Mar 2025 08:42:06 +0200
X-Gm-Features: AQ5f1JpNNtYpTcQobJ8O0C3zEVe6fWGxPcNuKIW8KmEwWhtp7DLuTqRyGwNMjcQ
Message-ID: <CAGp9GRaBiaFjRDWHi2J2_O9Om789M_CTr9Cko7oBh5YpJzg_HQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: hsr: Add KUnit test for PRP
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
	MD Danish Anwar <danishanwar@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:04=E2=80=AFPM Not Teknology <jkarrenpalo@gmail.com=
> wrote:
>
>
>
> On Fri, Mar 7, 2025, 03:52 Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue,  4 Mar 2025 12:40:30 +0200 Jaakko Karrenpalo wrote:
>> > Add unit tests for the PRP duplicate detection
>>
>> The patch appears unable to survive an allmodconfig build:
>> ERROR: modpost: "prp_register_frame_out" [net/hsr/prp_dup_discard_test.k=
o] undefined!
>>
>> Guessing that it ends up built in and the function is in a module?
>> Maybe a depends on ?
>> --
>> pw-bot: cr
>
>
> I used the wrong CONFIG_ define with IS_MODULE(). It should be the one wi=
thout _MODULE at the end. Not that familiar with those.
>
> I must have messed up something when running the build locally, because I=
 did manage to compile somehow.
>
> /Jaakko

And sorry about the previous mail not being plain text, gmail decided
to send it in html-mode

/Jaakko

