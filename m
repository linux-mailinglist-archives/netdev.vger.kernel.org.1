Return-Path: <netdev+bounces-180247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C48DA80CC7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692131890C40
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29818784A;
	Tue,  8 Apr 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F9MMS6Uu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9417A2EB
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119737; cv=none; b=THMcg5haqgjFvd4vY3efVCaih/Fv6nNkmmmddy9wjBoiOWw8EH4r6qKrIZ5j/mn7SQgPSdvbAu6i+/CErUWRm++GN44iXSlHDzivWvJ7FHFUhbw/LLMsUxTRXX8R+bxbS4qHcPn4RzKXTR0kcKp1jNj3DuzfDoqts9CYBzeZQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119737; c=relaxed/simple;
	bh=eJWnd/OmhCwpynGyYYJCjYx7Kj46VK3b80d+loCXfb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyPaz3F0/5o0b8P8St9JV+gDT966ywKisc8L/25XrktjMrV2v7D7qMiORWOM5hg8moN6GHbNWW/CYwPz5J443o51OUY5QCrI4DXovI9acrnUFn4hOt1sdN+2ylE9DUZuhbOCd6bxWqpLf4Krb6d4SHpriVU/eXCgQuwGEFJyFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=F9MMS6Uu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7396f13b750so5703948b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744119734; x=1744724534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlAht3ua43SYRDsvjC/Xw7/mC3PyaO4jrkmwLyq9MGs=;
        b=F9MMS6Uu3UvJv7wWzKntcRuk906H7P+RxADTpqV5MJ0gHbc47Mi3HkdAViyXdhIAqR
         RWwqVT92uDNGy8kItWUfG731zzM/JHbtC5MhQLRxyoyF2rSQqItj99/Xo/cLFFo5/O9+
         ckqKDxQTyCUgRHraAEQZm7g0O+En3CY+nqPoDf5IYlzMtO3b8qdbXgPPq8G/pbWQ++sd
         V1sVlWhM/wWrxP8leLbe1qG5JGdcZPhTqd1KUV2zFqg3JHt4hTCWOFQ14Kxk1WlS5Ufe
         V+WHTCvGIca4YcQxlKBkpSfwHOyr1sSJfnzyuFnYgHn6upQKnYP4Q2HeTLSNyc616BRS
         pKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744119734; x=1744724534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlAht3ua43SYRDsvjC/Xw7/mC3PyaO4jrkmwLyq9MGs=;
        b=WDvTaIpJ9WFG7wMGHwQt8Budt0Yv8weBIo/Cv0J9QJBl+AcrLMRvGIZ7RF+pH/09lt
         QpMjhWGevua3FNS6sESb3rWAI4N/HmFzPQT4V3N1NKjiYulxd7rLQ/oWPAkUxFXXuNBQ
         fu5OmiW+LJpe+3UlTS5r4fJyctW8pBBya40Vh/DSSbsV48nCjiyp+iEscRxGOQ5HRCyY
         qqBY1fBGbKYpSf5mIS0jeDupP4f6sZm+sdZJqlJESWourZX2R+nX/HDKfr+mSdeXG/O9
         en6qxNYTF4sBcZM4y2ZeNp5xYIPiBTlVd4hA7pnvMbYgf1bSa/pJI2CUblt7gXhlkwq/
         vCig==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5epWabnvvCNlq/z65cofdqsAusrzNrcBpCGZPJjMVmbG2KHNdpf8HTSLvcc0K7bFr0lKuvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXclDxFH443AaJtk+FgmFT4rZghicKkXOw4+e9nI88Y15+eQtr
	IN4ba3vSonqYvqOSyjo8Ii+ugSK4K8RWtKgnkDDdnEbpgJvfl9Zo22AoNNy4rPU4DNHTGRiBJPJ
	c/46KvmjbycoKznJ3JonwzHAuozJpeYoTTStbW/kMqGZUeaLt9g==
X-Gm-Gg: ASbGnctoau1pUf+0MoWOdtYJHOq5V0yUi/vG/cD0WEP6ZU5gQ3/rUnhs7pwMMKMm1xZ
	z5/AyjzBQy/BR0JIXDPr7tLvWmGZZUIyeVFTFuX3GzOjLwInIxsgFCmH+8PFrhgDvYl+dXjpF3s
	mgEIcjKlymYN8QYosawBbdBUrL6Q==
X-Google-Smtp-Source: AGHT+IH/mWXba6dqamihVT4PJm8Uk3w+Ucw1L711UqcYSJ2XIUgM2nwUwcXfD/ao80vWnMNfhOGagWSPqSdwaoq4dm8=
X-Received: by 2002:a05:6a00:230d:b0:72d:9cbc:730d with SMTP id
 d2e1a72fcca58-73b6aa6bdbamr14984000b3a.11.1744119734278; Tue, 08 Apr 2025
 06:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407112923.20029-1-toke@redhat.com> <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
 <20a20b0b-237c-42d2-8d17-a07ec87347c1@ovn.org>
In-Reply-To: <20a20b0b-237c-42d2-8d17-a07ec87347c1@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Apr 2025 09:42:02 -0400
X-Gm-Features: ATxdqUHMgrEpIpaKtPp-F2np7wLO_zsJwiKveW8wj2GGaiv6LIWWrkyfUb0hMxI
Message-ID: <CAM0EoM=ntVF3JOdi9DgCrDsdoqW_dxF2bRaQPvTVcozNoobVfA@mail.gmail.com>
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: Ilya Maximets <i.maximets@ovn.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:14=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 4/7/25 9:56 PM, Jamal Hadi Salim wrote:
> > On Mon, Apr 7, 2025 at 7:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> While developing the fix for the buffer sizing issue in [0], I noticed
> >> that the kernel will happily accept a long list of actions for a filte=
r,
> >> and then just silently truncate that list down to a maximum of 32
> >> actions.
> >>
> >> That seems less than ideal, so this patch changes the action parsing t=
o
> >> return an error message and refuse to create the filter in this case.
> >> This results in an error like:
> >>
> >>  # ip link add type veth
> >>  # tc qdisc replace dev veth0 root handle 1: fq_codel
> >>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i i=
n $(seq 33); do echo action pedit munge ip dport set 22; done)
> >> Error: Only 32 actions supported per filter.
> >> We have an error talking to the kernel
> >>
> >> Instead of just creating a filter with 32 actions and dropping the las=
t
> >> one.
> >>
> >> Sending as an RFC as this is obviously a change in UAPI. But seeing as
> >> creating more than 32 filters has never actually *worked*, it could be
> >> argued that the change is not likely to break any existing workflows.
> >> But, well, OTOH: https://xkcd.com/1172/
> >>
> >> So what do people think? Worth the risk for saner behaviour?
> >>
> >
> > I dont know anyone using that many actions per filter, but given it's
> > a uapi i am more inclined to keep it.
> > How about just removing the "return -EINVAL" then it becomes a
> > warning? It would need a 2-3 line change to iproute2 to recognize the
> > extack with positive ACK from the kernel.
>
> The warning is hard to act upon programmatically.  If some software is
> trying to install those rules, it would expect a failure code if the
> actions cannot be actually installed.  It's also not common to handle
> extack in a success scenario.  Besides, TCA_ACT_MAX_PRIO itself is part
> of uAPI, it makes sense to be that violation of this limit should cause
> a failure.  Truncating the chain may cause unexpected consequences for
> the user, i.e. traffic handled incorrectly, unless the user happened
> to parse extack, which is not really machine-readable.
>
> Throughout the years we've been adding extra validation to various parts
> of tc, and these would also technically be uAPI changes.  I'm not sure
> why this change would be any different.  In OVS we've been struggling for
> a long time with various kernel inconsistencies in tc netlink API and
> are forced to request ECHO for each request and compare rules we request
> with what kernel actually installed [1].  This is a significant performan=
ce
> and complexity burden that I hope can go away eventually.
>

This issue aside:
My experience on building a control system as such is that it is safer
to base on the philosophy of  "trust but verify". There will always be
bugs and quarks and it is advisable to be defensive. IOW, to not
assume reliability/correctness as guaranteed. So nothing wrong with
doing the ECHO if you take an approach of  "I dont trust the system at
all and performance is secondary to correctness"

The alternative is to semi trust the system and verify when
programmatically triggered.
In this specific case I would argue that a warning is a trigger to verify.
Another good example of triggers is on events - if events get lost
netlink will set an error on the socket which should trigger a
verification.

On this specific issue: the culprit is batching and expected behavior
on failure to meet the batch "transaction" - to be specific, one of
dealing with two independent systems (filters and actions).
Unfortunately, there is no consistency in behavior across all users of
netlink because there is no way to signal transactional behavior - i.e
what should happen if some of my batch entries succeed.
Example, it is totally reasonable to say "dont worry about failures,
just go over my whole list and skip things that fail".
Decisions so far have been left to the judgement of the programmer. If
we could codify expected behavior then it would be easier to follow
some rules - but that would mean big changes on netlink (which could
be done incrementally if there is desire). See for example[1].

> To my knowledge, OVS doesn't hit this particular issue with the number of
> actions, at least I've never seen it, but it's still a problem that the
> kernel behavior is inconsistent.
>

My 2 .ca cents above.

> So, I'd vote for adding the proper validation and allow users to detect
> those failures when they happen.
>
> Best regards, Ilya Maximets.
>
> [1] https://github.com/openvswitch/ovs/commit/464b5b13e6d251c65b3158af5df=
16057243f1619

These seem like serious bugs on flower, no?

cheers,
jamal

[1]https://www.rfc-editor.org/rfc/rfc5810.html#section-4.3.1

