Return-Path: <netdev+bounces-209471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AFB0FA59
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22148584CF5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB232220698;
	Wed, 23 Jul 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOZiwET9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEE20F08E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295805; cv=none; b=YvKtdGsAu+jfab0sZddLSR9ieRCNjO3kRRAcn2pY49wWOQcnhDUcFkk9UTSjaZcINOhB25zEaVsBkTIAMNuzspsCmop+sMF3dgJ6Wj5KETlHVDmofqyNWuE6ggVIbXo+VMQi9EHfaIqoPenoxErQR5M/+53YxMcqucMKNyGVeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295805; c=relaxed/simple;
	bh=5hi4WrE71marHQiRuZkE2QbL/wCvNDBks+dUnwx2Lx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz8q3FYBkDWdeIxJ5/HQb28WHsH+iLQ85F2EO1ANH8s8OQ1qxB497H20O0gLinCSn0cpOyeDnl5XlTZGenXP2SO3Gd2gttHgi4OBYFFjVBjzDzULqGBxelbtBg4uim5BjqiN6aFsSbO0BZe5eVtaTj7gdt82Ag+hxsiq2l7c6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOZiwET9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so2974061cf.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753295803; x=1753900603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2895cOJRgjiK1NbActFOWQBd/8gPRhRvycIhI8MYzeg=;
        b=vOZiwET96MORBsApNWWOpr7w1eVjDMXmm2SGQVCnHMRJEByhzWu4fOxb0vAsvLN4zp
         Jojnb8gfSrL/9RqpHTMXip2f+EStewCSZOLrRFrbdTAZvxMK7+99RAwNY7+NfYbkfoa8
         tz6gp/BYjhqeHLubccgRnU6SrV+e1EDHS75C/4J95KnddF/Vk5b9qi2V+b1Bzf5AOqnP
         p8P9JwHePEqrs0V2DxQz3iBXvClLVFLH0yYrr9GxkM0jKsdY20xCAsTp6IN5JFV6rh0i
         9V/+c4q0ASlFe7EuHR85csDO8RKrU1CGhiVFauJPIawSuD34WbNlpk4AbkYPB1z/906v
         7oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295803; x=1753900603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2895cOJRgjiK1NbActFOWQBd/8gPRhRvycIhI8MYzeg=;
        b=LQ0Zt2ZeuhtKCsqzOFexH5x+NALG6834dbsV/560vn+QaQ/Xqbh0ARBWEoKfcUyrEE
         E511csZv6gw45clB9JPxx/MoB2ejHcmgp6rlNiWIyJvfNb/aURqT2VvmHe/bO3+shv9h
         xVrKDleQBWfyKjPohDteNE11ny6SGUH/mmfXS6oSJsm5cfTseaEZkcmyNPBLvf6QrOiw
         +duy1R7/pgU8Q424OVqMYinEXgmBQ45m59Vt/JxrIx5mVtpjxK3AQgXYPZGoHWSWrXt4
         prV1CjWmZLCsPf2hwrKtUkl1o0+9Yp6TwWM8L3hH/iW2IVuPLyN5ogXn8qXH5nQ5kDiy
         4tXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxhYSIp1ViFTJXWIBz08Vtjt/ZzX/OFl7t/SL93/rWgNTYGV/9nIWMHM2tDZFIgC30bDc5J7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXM0KpYoq0m1JJjC6hsAcz7WEd3fAvctOqidrXBHhulgX6ntT
	QFvC9+3OkOo36D8kPVynoD+zADICoYQJpiSrDYcMZdnahSrlyi7NxxwB8mj2qVEXDHWiV/bxe9H
	Fp7ossXllMrRRKEScBLRQUaTqa9qdFGjynQwiQHWw
X-Gm-Gg: ASbGncsPixaOZP0+E7xE+BnrE6EUci4rVrtoGYqf7dycprEHT1AmRlKR1sOqCIGey8N
	wsGmu2mpWhcB/EjhiNS6+AKbrIjSH79M2l6UQcaBLtfCiOAMrrMB1vxVNHf3kiyHfOBKzHVAd06
	Twl4WcnfHyZJL+lSla8WGr3uDgaSTP24FbZtXrhWgdw62k64oKOB6CadxUTGhD2UZAoteaigZUI
	ubo7dE=
X-Google-Smtp-Source: AGHT+IFt8r1/bn5aE5w+xjp/KZnjhjjB3CgH2KGrcYHKkd+BtH2rkKXI/86jZpijEYB+DXMkCkZr0IIHXXxPnA3Mb6g=
X-Received: by 2002:a05:622a:189d:b0:4ab:3ff6:f0e9 with SMTP id
 d75a77b69052e-4ae6de3d55fmr49370301cf.1.1753295802557; Wed, 23 Jul 2025
 11:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com> <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com>
In-Reply-To: <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Jul 2025 11:36:31 -0700
X-Gm-Features: Ac12FXxlhlhqW8vDJc_oByEs7Tt3_KF9XPplKKOxSHqunQfLKrXinLUbIUzJieg
Message-ID: <CANn89iKwrp0j1bYQ8yGsbj_B1+eEv8BaWavHAuWpYdQVg-dqsA@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:17=E2=80=AFAM Suchit K <suchitkarunakaran@gmail.=
com> wrote:
>
> >
> > WRITE_ONCE() is missing.
> >
> > > +               while (i >=3D 0) {
> > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> >
> > What happens if one of these calls fails ?
> >
> > I think a fix will be more complicated...
>
> Hi Eric,
> Given that pfifo_fast_change_tx_queue_len is currently the only
> implementation of change_tx_queue_len, would it be reasonable to
> handle partial failures solely within pfifo_fast_change_tx_queue_len
> (which in turn leads to skb_array_resize_multiple_bh)? In other words,
> is it sufficient to modify only the underlying low level
> implementation of pfifo_fast_change_tx_queue_len for partial failures,
> given that it's the sole implementation of change_tx_queue_len?

A generic solution will involve two phases...
Lots of core changes, for a very narrow case.

Most of us do not use pfifo_fast anyway.

