Return-Path: <netdev+bounces-176496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA3A6A8D5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD611600C5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6619DF98;
	Thu, 20 Mar 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daWDCXXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C27155A25;
	Thu, 20 Mar 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481797; cv=none; b=gSgcV/s2ZBMUTJ9oOkEHLfnY0sfvokzsH36dC6uxignq47+VLE/n6qF6wcr7SqZ5xKU2zD73gRpMpgVNYm3zhYsGSQcR3wdO+NyEWTI0+fA2/kd2UL2bqy0mvMkCaGprMqyYa/N+FCgJLuk10wIxBO0v/l0mTF21N4icE9vGIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481797; c=relaxed/simple;
	bh=xdTfcSk/e8jyJr0vBxzXrOtHZlW6oDVogzoYsC5f3M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j33zs+zo4aMpWas3MrSJqRgyaX+Muaz8j/jA2mdPuB7CUm/sk/QK8Pvzdns1dP5rq8YwnUipRLJMUPD3xv4BJ+nxSPkwDhFlPIyEGKU2C1YsUImu2h8Y5j+Oe9/EgzWFD5IOjHRTGk71r0ympGJeN+iefD/yG9impcE8QyJMzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daWDCXXJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307bc125e2eso9972201fa.3;
        Thu, 20 Mar 2025 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742481793; x=1743086593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zawsEvfSPE3Ae0ASL3bJZhMYC8bn/dwArZppWUwszh4=;
        b=daWDCXXJEENpfv+tMWCA3n5gj3aZHncNns9zul9aZhPKJZKDQ6aPHLeS6XSx9+ZP4T
         Lz3jq+2aXLfj8Hry/pMO5YwVDV1IQdsVIhRbSo+yNAOc0gQXrhCiWvFVCfHmngurEJ5P
         OZaVYWAG8AV/tqLjqQ2XEEM1yp8cY/TaFzZnu7mvZbNy3AZ3q2IjeyyEAG7lHP7uGCo4
         5RU7TnsOm8qw4pD0qdoDMWqEJU+G7m+wLEF2ZgUteVlYwXbQHePBv1PL0k6pBGt6y/kj
         zmcjePLojvgezb8kLeURD5lracCpgLlFP/cwjJKJME9kZfhLFCMM8ZCok3Gaw9hQjZf4
         9W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481793; x=1743086593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zawsEvfSPE3Ae0ASL3bJZhMYC8bn/dwArZppWUwszh4=;
        b=GrZhNRO2WVUMt7EQ1ECvCcs/YxcvQm/93j/W6RvDvq10i5MhzYguATFa/2KpX/TsBp
         c5Pd38wyr1MH6PFNluSo/kjVsR2s2seAxp5c1cj4IFEJLLwIugriCKMlMWrMxgnUTNtk
         /NtYyyoHCoUxIwhCzhSccLWLfKIuhKBAsyWp3BqCazI6f3+65mQi/m7r/yc8bl8Z6zpr
         ZkVwtZsD5FQEEKG3qu74Xu0CDNIlvN4Tvv8oPtUF10BS4uxiLD8O9BmQyRszp0FtcnCb
         ZZHf//AySbsPHHml8bRiO7rF2s7yvexdFhzJLqpwrAQ51sQpQ/DUaq/CLfFIxqMdWY6Y
         H10w==
X-Forwarded-Encrypted: i=1; AJvYcCUhg5NDVzOuz/nNcmDlIMOCnM2Kw95nFjUF2EyhaReGPz6ZH3nTBGYxBVr+6O47qwVY4jsd/rsw@vger.kernel.org, AJvYcCXsK4k9plQ/6e7PJHbtJ8HBCR9Zo6MMzEhtIjNJiEHFYQ332uCQjich5SkEpEc37bNjP35tict5L0E1d9NAkQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZn9UHjb6t4VxkyDdpNUGS+wKtks5fKwwffLxGQVwCC07SX7AD
	fA5iEEKxOwGN5ZnYPo6CSxgCnde2cv8KXzJVd7zSAlIkm39y9Jmu4S+Mok9i2Fho863YIykVX7A
	KSmabOogmZeBMaAYSYPAuhUjS+HE=
X-Gm-Gg: ASbGncsGqpAubJlCSmnJGpKIHvlF2I/0ENTL2JapeGeIn/rAvqq3VECD25OG/a5BYoT
	GXPsgs8IM2dORmG7CX3m9q8p1YarDnjf2mrtcdcMPM889DpP7T02P0QOjfI24/eeRx9r6rIC8ml
	samjJ/EgbvOOEwUrucwShOsL/Z
X-Google-Smtp-Source: AGHT+IHkiFY9/QFe4mg8V1fWWKKLgWuX/l2HgYGY/LfxmHIReYGicT7Wk3zR9k9bZGXdwWYBMWVeVFq23+OMEspxbN4=
X-Received: by 2002:a05:651c:a0a:b0:30c:160b:c741 with SMTP id
 38308e7fff4ca-30d6a3d5ab3mr25588321fa.6.1742481793104; Thu, 20 Mar 2025
 07:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
 <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de>
In-Reply-To: <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Mar 2025 10:43:00 -0400
X-Gm-Features: AQ5f1JrIJNLT3MvHXMnbcByEP50gDRiAnXlfZCMHT5d20iPY_LpbRuGLz3fQ0P4
Message-ID: <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Willem, Jason,

On Wed, Mar 19, 2025 at 11:48=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Pauli,
>
>
> Thank you for your patch. Two minor comments, should you resend.
>
> You could make the summary/title a statement:
>
> Add COMPLETION timestamp on packet tx completion
>
> Am 18.03.25 um 20:06 schrieb Pauli Virtanen:
> > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> > when hardware reports a packet completed.
> >
> > Completion tstamp is useful for Bluetooth, as hardware timestamps do no=
t
> > exist in the HCI specification except for ISO packets, and the hardware
> > has a queue where packets may wait.  In this case the software SND
> > timestamp only reflects the kernel-side part of the total latency
> > (usually small) and queue length (usually 0 unless HW buffers
> > congested), whereas the completion report time is more informative of
> > the true latency.
> >
> > It may also be useful in other cases where HW TX timestamps cannot be
> > obtained and user wants to estimate an upper bound to when the TX
> > probably happened.
> >
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >
> > Notes:
> >      v5:
> >      - back to decoupled COMPLETION & SND, like in v3
> >      - BPF reporting not implemented here
> >
> >   Documentation/networking/timestamping.rst | 8 ++++++++
> >   include/linux/skbuff.h                    | 7 ++++---
> >   include/uapi/linux/errqueue.h             | 1 +
> >   include/uapi/linux/net_tstamp.h           | 6 ++++--
> >   net/core/skbuff.c                         | 2 ++
> >   net/ethtool/common.c                      | 1 +
> >   net/socket.c                              | 3 +++
> >   7 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 61ef9da10e28..b8fef8101176 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
> >     cumulative acknowledgment. The mechanism ignores SACK and FACK.
> >     This flag can be enabled via both socket options and control messag=
es.
> >
> > +SOF_TIMESTAMPING_TX_COMPLETION:
> > +  Request tx timestamps on packet tx completion.  The completion
> > +  timestamp is generated by the kernel when it receives packet a
> > +  completion report from the hardware. Hardware may report multiple
>
> =E2=80=A6 receives packate a completion =E2=80=A6 sounds strange to me, b=
ut I am a
> non-native speaker.
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

Is v5 considered good enough to be merged into bluetooth-next and can
this be send to in this merge window or you think it is best to leave
for the next? In my opinion it could go in so we use the RC period to
stabilize it.

--=20
Luiz Augusto von Dentz

