Return-Path: <netdev+bounces-128238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD2978ADE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB2B210E1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641214AD19;
	Fri, 13 Sep 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDSOPrNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E26BFD4;
	Fri, 13 Sep 2024 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264393; cv=none; b=fMlFytZTV2iFcdEk5k+JIpjRr/myDBoM58I0DKmhxqYff81sZfDAqrXsMfZSQ2j0bLpaQ9cbn2oJ2UUTq1kamdAp74HQpWhdTAvlVftTUX5xm3i3Ckv7N3OZ7/SZwWQyQhUznMf2vsnu8OwDoR+L6Mkspsk7Uu9C2GFztTcbqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264393; c=relaxed/simple;
	bh=bROgI7wiehG5a7VPcOWWp+q00U22ejHaEo6jyat/eM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXq9P3Aefd+YjT7ld136V8gbUWVXmheCZjKjBvjAELJrILMd0p44XMtsuSxHYZUkrkCIgMlgnCg+PV96Wv35DSa66nwqWtP4KMmb3PIZoXxfSeGrk7iY3gzQBPn4ZGlQyJY0rlfy3AqPhs6dD32RWJ8iYL9L+2K4W+RvgAloIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDSOPrNq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71781f42f75so2217390b3a.1;
        Fri, 13 Sep 2024 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726264391; x=1726869191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo+N/W667eEINY143EiHKlaxZURxS+IB8LyZfXkFx1Q=;
        b=hDSOPrNqWT5CdrNjt6YsC5sV9S6ODgJ8fa4R1+E8Sydh4VogVXAfcsPBTKZcSlX+cd
         WsPuNMuQoalJk8hfkGZbCPmQsqjb0l0WzQ4s9S80Yj7XdQUJA4ONw0UWxr4JbZjsqH3+
         FE+KtfUTh/qfMq9q5CXr7GJqs72QhlJSGRVyxj8HRUJTjG4mdXaB+Q8fAA1BjD8yWby3
         KEEa5Mqj7vN3za2ngoemJCzYeF3VJS0mp1bTS1DWM4jqdT271atvPeVIvum/8estwzta
         hUpRdd6CwercqlMvnlTUazvL2VDwWQLGe8OtaeG8Kzwttmls9NzFywWqKGFf+fwMnHUJ
         j9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726264391; x=1726869191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo+N/W667eEINY143EiHKlaxZURxS+IB8LyZfXkFx1Q=;
        b=Uuzwop/vyx5PUqmYWT1F3m5ez0yZqxb9OjY2kNStVnjDTkSb28SvPbu9P22BqVSc/0
         9slCQ9wqWC4iffkhUtm/Xfl10H9EBQ0bu6/Tnp91t9p/HnczhHyhRDsLKAMRXuzr1c2r
         UCg/BsyhXg+KYfeLDQtlQnizOlClhSs/ja4Ll+QK4s43R3CJ4ereZWKRcoHXjwtcGFAV
         pafXH32h9WDP2Bj7svKC8zXwzltjjkikqW9QS5edgQhe9+GlDUIYGOn/G+nwhez3Zb7C
         Th4X4ktAVMdMXbZtqKHoDPplSvKQL8jH0ACcYYRAD4CU8zBrLfUe0jyN6f3+yug5rbEr
         jf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb4RZD5kzast1lVttJ6nO4eAZhDrhEJ1UiZSTgYMVtQsopb69JDUgOnASgzpIscpNVklXObCg9@vger.kernel.org, AJvYcCXFJwGP3KZvEuoURlIsv0TWcLQ8sbHCSDUy8nVEDFO0sUcOJ8S64QSeyS1OJvzLh6wXK/qDQGjZ7sJAE2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XU0PYKCBA565aR1WhlikTyN+zqtKt7inUrpJaLWSBqVEjLDq
	eCynDWlsIhKjJn9JRs3TEF3ifQl/M2JW7h4bqn1fkf3UIo9zHcU6IkU9THVUztic1+3OCytwtfB
	mbrW6nontRpHPfQyYxkXbzenajW8=
X-Google-Smtp-Source: AGHT+IHIIM3s9b0RG6Ya8X+Wu2PmJfg8oj1TJs0N7c2FeMGYp8eNLPoyuwqlUB21hchDOIuZd1ZV1F3l8aSKlkOEF1Y=
X-Received: by 2002:a05:6a00:a01:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-71926213bb8mr11895426b3a.28.1726264390946; Fri, 13 Sep 2024
 14:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
 <CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
 <20240912083746.34a7cd3b@kernel.org> <CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
 <656a4613-9b31-d64b-fc78-32f6dfdc96e9@intel.com>
In-Reply-To: <656a4613-9b31-d64b-fc78-32f6dfdc96e9@intel.com>
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Fri, 13 Sep 2024 23:52:34 +0200
Message-ID: <CAHaCkmfkD0GkT6OczjMVZ9x-Ucr9tS0Eo8t_edDgrrPk-ZNc-A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] igc: Network failure, reboot required: igc:
 Failed to read reg 0xc030!
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 09:02, Lifshits, Vitaly
<vitaly.lifshits@intel.com> wrote:
>
> On 9/12/2024 10:45 PM, Jesper Juhl wrote:
> >> Would you be able to decode the stack trace? It may be helpful
> >> to figure out which line of code this is:
> >>
> >>   igc_update_stats+0x8a/0x6d0 [igc
> >> 22e0a697bfd5a86bd5c20d279bfffd
> >> 131de6bb32]
> >
> > Of course. Just tell me what to do.
> >
> > - Jesper
> >
> > On Thu, 12 Sept 2024 at 17:37, Jakub Kicinski <kuba@kernel.org> wrote:
> >>
> >> On Thu, 12 Sep 2024 15:03:14 +0200 Jesper Juhl wrote:
> >>> It just happened again.
> >>> Same error message, but different stacktrace:
> >>
> >> Hm, I wonder if it's power management related or the device just goes
> >> sideways for other reasons. The crashes are in accessing statistics
> >> and the relevant function doesn't resume the device. But then again,
> >> it could just be that stats reading is the most common control path
> >> operation.
> >>

I doubt it's related to power management since the machine is not idle
when this happens.

> >> Hopefully the Intel team can help.
> >>
> >> Would you be able to decode the stack trace? It may be helpful
> >> to figure out which line of code this is:
> >>
> >>    igc_update_stats+0x8a/0x6d0 [igc
> >> 22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
>
I didn't manage to decode it with the distro kernel. I'll build a
custom kernel straight from the git repo and wait for the problem to
happen again, then I'll report back with a decoded trace.

> Hi Jasper,
>
> I agree with Kuba that it might be related to power management, and I
> wonder if it can be related to PTM.
> Anyway, can you please share the following information?
>
> 1. Is runtime D3 enabled? (you can check the value in
> /sys/devices/pci:(pci SBDF)/power/control)

$ cat /sys/devices/pci0000\:00/power/control
auto

> 2. What is the NVM version that your NIC has? (ethtool -i eno1)

$ sudo ethtool -i eno1
driver: igc
version: 6.10.9-arch1-2
firmware-version: 1082:8770
expansion-rom-version:
bus-info: 0000:0c:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

> 3. Can you please elaborate on you bug?
> Does it happen while the system is in idle state?

I don't know. It might, but I've only ever observed it while actively
using the machine. I usually notice the problem when watching a
youtube video or playing an online game and suddenly the network
connection dies.

> Does it run any
> traffic?

Yes, there's usually always network traffic when the problem occurs.

> What is the system's link partner (switch? other NIC?)

It's a "tp-link" switch: TL-SG105-M2 5-Port 2.5G Multi-Gigabit Desktop Switch

Kind regards
 Jesper Juhl

