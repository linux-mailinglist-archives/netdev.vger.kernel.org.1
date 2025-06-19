Return-Path: <netdev+bounces-199319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36048ADFCB3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A71179734
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C724113D;
	Thu, 19 Jun 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfKMuq00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4F18D643
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309575; cv=none; b=tubysgu4u2Y+d8vQGXAlKriF/2QdfVnajBpI/5F/gGeXU0LtX1Pzc3JxyRwYQoQJk+mfCVUT08to2HZLdAHH3VEixcwtasu2Wbe8xSFvQkyn+IM+hw9kw14ePHWTbCJ+2mXqx1QVpZIlAzTLsfTyOG3HIQeu7AVgAhueXg7nf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309575; c=relaxed/simple;
	bh=HVkbK34ZFRsXi7DQr1RlsriiH4K+niEY0Ep4oDee+ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVLLhRVsNmJpx+OCbp7rFdTfbZ0v0rfQDrP3bcSGVFRV0J9WGAldEmPPfUhA3Ubi7y66qpmJvbI5RQk864JH355GkeJuFupK43YsB8z0kXM4Q/xb1KHbzUPGTGmmoLag/UrGycAy3iZOkMhfTXITYHkmTp2hWQtTrIImhnSwyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfKMuq00; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so625068a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750309572; x=1750914372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvrMtzEwyC94H5ymp5DpvZlN+qTBeXoYp2uIaqheg/I=;
        b=NfKMuq00ds75l9LuufA4NFBr+tGWVVw93dZdiZ5EHZ4FsWYsV0dO3qPPErl9LppsyE
         1wn5e8pje+8cNvfWVLVSlB9+pguXxJ3AFbyvKhY596t4Cslqdh+iGrcaZCJuxRf8slee
         ch8S6TTK+YJoeC2xcwFf7WzwY/D3oueBCgEm0Ff9bF5MUEcJNaVhYe5FhjJP1dAGucHq
         NJFL1cjXGYaVpawWn8ZwSI4U9wX5/3pTM8NnF4HA8GdVabg2L8QqtUN+RJd/8P5gcq35
         N7seuFAOU2iDLPBLdZCzK9wtX+QGOJrGshxqzp1OX5n8kzUxhI4MQL3vOsS/ti7VZwpY
         AzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750309572; x=1750914372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvrMtzEwyC94H5ymp5DpvZlN+qTBeXoYp2uIaqheg/I=;
        b=t8JCg9WKGjJ1Dg8a0D3zoxZ/G42z4AzKXQ8bzeIBGOe7q3ZLokEWPwhE2YB0msWdmR
         wxVoAiUFfPS38BVc2R5xSNvtjxnE9a4hsKzoehAcUDChgZSaON9P9NpApU13e62AhtoX
         jNZhxfeqhlsxDdSfKUXXjJSUTVFhFW5VrxJlxRPhf8CAX+6b5DoxtEKtkKUPPwaV2Y1I
         70G1yqg/7D1VOiNXnoZNQyKa1v/LUhr2V7HdT7Qf/w8lD8JNWyU1F8iw7+a5KXkzoGVE
         YADAoJqF6zpz4W87z0SiGqDzPvobESU4zRp5Bby1SDKPK4xTcrsKNK0cG0yVQm+u7nJv
         lkEA==
X-Forwarded-Encrypted: i=1; AJvYcCX3PPGWH7AaRf0S2VjOP63uW8goyvyEijJxboM2dAbroxZVzb3xBRLm9jufvuJMEYZeQOq2kPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcwZTYH5A61ruGWJJHy5NJFs7YmKYPzN76CMZLg0lv45nZNGU
	T3p4ZgsQjy3ETDEUjmR9Xxky2Z+/ZgsaV5q6fkCf3OFZAx+uBLef1mFTMDAmZ+q6at6fvAxgs46
	eNu1P9fQAQgWeoDa/hF7bXuE9zuJtkfmMYcN9
X-Gm-Gg: ASbGncuQHM5Yv+vybYi3wJZ51YBlUENEzofPmcyC6AghLCRgUG2efBqLj4LBwNh7wvn
	PJGgtrcB+n5GVe+4wrxTrSEbt4TTQf/KCMTEO/IZkiQyF4w51vvSWJX0wo8O2WXeyVKjj1j3ZFV
	2KhPkd1bLJXXAmEw2IJK4tW+UFJ9yahLftyeMDq5t8yvlw
X-Google-Smtp-Source: AGHT+IGx8Ay0YzyYOh2FDvmed72pneE6x3GL/vZC0CzNbh8MXTg77eaaZw/dIqfIbYVFCx3HzhCV+9T/nlA5V7lC+sk=
X-Received: by 2002:aa7:d04c:0:b0:607:35d:9faa with SMTP id
 4fb4d7f45d1cf-608d08e97d0mr14477159a12.15.1750309571707; Wed, 18 Jun 2025
 22:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618135335.932969-1-ap420073@gmail.com> <CACKFLik9ZSytqhq8Z=G=ob01J5nDd32JxKcMKrdnxt5R+-gbAQ@mail.gmail.com>
In-Reply-To: <CACKFLik9ZSytqhq8Z=G=ob01J5nDd32JxKcMKrdnxt5R+-gbAQ@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Jun 2025 14:06:00 +0900
X-Gm-Features: AX0GCFulPG_ZThUhoIzcMONq2_VKmFrdQMSwEfqU1s9mXeff747Sb-T0ga-G7y4
Message-ID: <CAMArcTUu3juzMzWUime_ipW4cPiW7Dt_pmgnjfMTgrt18dC4Eg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] eth: bnxt: add netmem TX support
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, almasrymina@google.com, praan@google.com, 
	shivajikant@google.com, asml.silence@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 2:21=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>

Hi Michael,
Thanks a lot for the review :)

> On Wed, Jun 18, 2025 at 6:54=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> > By this change, all bnxt devices will support the netmem TX.
> >
> > Unreadable skbs are not going to be handled by the TX push logic.
> > So, it checks whether a skb is readable or not before the TX push logic=
.
> >
> > netmem TX can be tested with ncdevmem.c
> >
> > Acked-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v2:
> >  - Fix commit message.
> >  - Add Ack tags from Mina and Stanislav.
> >
>
> Thanks for the patch.  At a quick glance, it seems that the netmem dma
> unmap is missing in __bnxt_tx_int().

Thanks! I will change unmaps in __bnxt_in_int() in the v3.

Thanks a lot!
Taehee Yoo

