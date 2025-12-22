Return-Path: <netdev+bounces-245679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB72CD52F1
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F793006A7D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448531076B;
	Mon, 22 Dec 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibFuBbcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E630F925
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393472; cv=none; b=G8CjKpiilyeWLMfqseyFlISR2wbxZx9bY+RsGwSaUI5WzRafdRhPVxjDEL9+K1jAMpf31P0WsgBVR4YEkS7+4f4a1sy7KNhcy9glaScYbQLz5eKtEmNVP480oK+Ckpo8BLeoHC8D/lcskV8lYGGlE0lLG4x0ucjPzJf1i3652l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393472; c=relaxed/simple;
	bh=ruXs5/RFst6fuaU8dBOLXd+Sk9KuNS19f9hQyg/KEWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isY0/QibhEdmEAi/N81WVkm0/NC6F/J0H7xT/2UMR2D3DKGhyinJXN3PK6i4vfjAmSjQw2lVq1dQ2lXXy8+DnctU/VA+mhNHoEhpGE+X2A3ojqysBSuNf49C5CCG0gBostJOEwoao9PTLuN4MgZybXkOt+ZbTaxlb6fmiOTdYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibFuBbcz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed66b5abf7so48011951cf.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766393470; x=1766998270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTcRCL2LSV7oA+h6PPnW7Xs5s3C4m6VV54Y7cZ/iahc=;
        b=ibFuBbczG72CkBFTMpB1AcD2VzO8ZFJruEEyihmMeQ+LUHV4nLBAQ3PKRp7ZF2nhzQ
         q0v8uhR0DTO8N1vpd8UHV9SmrjL04kE2QOsLP62x9ve6fOkmkGthXLutTGrbIoZEWceo
         YlGuV/szMdmNxNpvA9wOvJxgBzjzoK2xmt2818xzwPCrizFRIqtwX3u2hBfnNVcNvbsN
         9Vrtf3L3p8EwMFFnm3RS2F8ZjScb8V67bZm0kI2qRoMPOh5mSI+F0Z+Nrqucrtx3XN52
         AdhkJRGNDGdJ6a42IaJ+xTdDZ/FtT8t+QzQR4zV6GRpPm5E4YGdbB3nRQoW/TtUTYnsA
         /qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766393470; x=1766998270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTcRCL2LSV7oA+h6PPnW7Xs5s3C4m6VV54Y7cZ/iahc=;
        b=xTdG+a2DdapAdf+e4AZNtAQmjVSscUft715IwR1EY2pSGBs43gbgzKvcy08gd1XxQv
         jWNWImB0Jqid5ytpbNha/BD1gdv2NrxOCD6cAm9Ndg/V6ZLjXfTZs09+9z7ABpk+pCwY
         Y5jj+UysMwkNnpFQmH2fi8eeuoNSX/c3CeqMdRqUFelvL+siL8s7oVW2SkVvc/jEVCDA
         95Hh2CJB1AEWD/14CgcAdOw+7lmhFnZdMo6LlRJ4AkLvoD4+az1ETtiG2qp7rBgDo7VN
         vNtsv+UUX3oAv75oGdX9q0K9c/77nbKQjZKpri7MkuTUn22CX6yKWFn5Vxv8BoIe3Cso
         jbCg==
X-Gm-Message-State: AOJu0Yy/fxrl35EC9/g/vFxQn8tbNUG+YBek5cNsyCxmJ0csxT8rEsOT
	vcYOcER1UST7AfxfpL/r8kvg55H5p9m7NZI14nrmqHe5GkWm8E1QctIVSwE7NICmUOiBOnL3Vhj
	cN11Hpy7f4AjqJfcEKNKnmuPWFYb8nKxkrc44UlG3
X-Gm-Gg: AY/fxX6GdwM4uTj5tfyydat+OWhiAxvIdZuXkD+EIgrGP5EzAMuv/B808j4B9dPYCG1
	wNkSeTG2UFNEbOU3zwxHI3Y/Q/OGQ3DvYjTPBqXljvl+VpSFGicOWWipY/LLHW67ej9+YJhZbU/
	kmnXVA1unr/DWSBuji/nlRlcZINPCwhj0h33yKd8dSnbJY1N6m0L+K+v63RGRarQ1SJ/JdZaIjn
	8L6dT6+pO9TM/wQvfS8x7hghKHW/pEACO46sXPZAm6r5HUKwI4Um10aKj/Xa+0ybZ9OlRGFTUSg
	mkcS7w==
X-Google-Smtp-Source: AGHT+IHpKtcGoaFcyM3/Nnwpgy7rFN8gVX4PgeFXdHVXhC+0aIRi5LCrcg4VI3/B0/Uxs1K2zrDKvlcc+64V830emrU=
X-Received: by 2002:a05:622a:1f8a:b0:4f1:83e4:70d0 with SMTP id
 d75a77b69052e-4f4aadb1131mr181306581cf.34.1766393469958; Mon, 22 Dec 2025
 00:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
In-Reply-To: <20251219025140.77695-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Dec 2025 09:50:58 +0100
X-Gm-Features: AQt7F2qlaUdi_Ael9gRYCKCL6sZMzKdOsY2sFDrI0SpdgEap_PpnZPFgW9I7Sh8
Message-ID: <CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:52=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
> current task can be preempted. Another task running on the same CPU
> may then execute rt6_make_pcpu_route() and successfully install a
> pcpu_rt entry. When the first task resumes execution, its cmpxchg()
> in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
> NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
> mdelay() after rt6_get_pcpu_route().
>
> Using preempt_disable/enable is not appropriate here because
> ip6_rt_pcpu_alloc() may sleep.
>
> Fix this by:
> 1. Removing the BUG_ON and instead handling the race gracefully by
>    freeing our allocation and returning the existing pcpu_rt when
>    cmpxchg() fails.
> 2. Keeping the BUG_ON for non-PREEMPT_RT kernels, since preemption
>    should not occur in this context and a cmpxchg failure would
>    indicate a real bug.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D9b35e9bc0951140d13e6
> Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")

I would rather find when PREEMPT_RT was added/enabled, there is no
point blaming such an old commit
which was correct at the time, and forcing pointless backports to old
linux kernels.

