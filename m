Return-Path: <netdev+bounces-185691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E2A9B677
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2C5A500D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E728EA4A;
	Thu, 24 Apr 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEkR48Nm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C228BAA1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519842; cv=none; b=LI4VooP0cMBbQ/yyScjKV0qF8BdM1jHPc9znC0GZ0Rm69mb+OZRXBQjbH4jvFdBXZDRwUYRb79vr2KsKRh8d0qZgWghP3R6nLE1TRXdjIuFGSWHqZTeN9k6g3Fy2a312ypOC9cwMJB3s0u7CxE3firpVSNaEfyr3eSbnNLHYZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519842; c=relaxed/simple;
	bh=+ObrAILT9MkV5shE5b54uVUAUE30hCzzXTVkWGYXhw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmsfQZgqAWE6Llyh4XESMeybefctD6EQD5VRZEISGYQK7FyS/9JM83mbx/iMMtGSNzHJaYFKwyw4TS+JX/BDF5wYvXpZsmvvNzLM00Cu2NXENSiA+lFo9hf0gl6gXTrOfNLrjGbXnT6PO7tLjz+sXLMp+WJTRPkEBajSRTykYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEkR48Nm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso5355e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745519839; x=1746124639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNqctYL3THrGPUgjPioxVFaahQ/pztGGq3mgBrGdeIA=;
        b=KEkR48Nmw3ARC98RUya/+7ej53CBzhGZXZN0R9eQHTvrufmKK2/FzYklC//bw3JciR
         yK9nYiEKti2OfipZrKXr5p7sDtaNfWYGKisfDTTUCdiaSg+Fjr7JC+Mxbs3WrsVdETJn
         CuekIjCAkY6kpM1bkcZHlralAJJ4mhl4F0kTpv52gOAUi7FmnXT7LwG3yvtde7IVv004
         qju9AU+8x2Xcc0XZ3tzlm3GlxmBYHsc1CzAe9ydNcNciqhlyMELZ5OdibRNnqAjo72DA
         rIQtFovm1ZhjEwjIoCp6tCFIcZnXmZiftsLuULeHe1LJ2L4uQ5BP+MApJ3EDROSEB/HB
         ySkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519839; x=1746124639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNqctYL3THrGPUgjPioxVFaahQ/pztGGq3mgBrGdeIA=;
        b=wBDxS48UcreR/wtUreZyEWZ72xbkR5jrbAbBCrs0pNZ2gnsL2jlPVi8N4nvsWbp22q
         1Z+RbVTpGfI+U8FhfCXJthl0Dy2+7bL9yvvUgUxjCw1ZD9+MR3fj+48d6nKRfWTL3a3h
         Yy/DvBy/4NHh01re3etDLU2BTpub2utzSrl4R8Gz/pp/DXRenD5zjRRYS0oeyIYjBp3O
         lUJKG4/C0Xh+tRQvws7nQCT8ZHIaqRmmMdKyYm3rCNqCH6lXF3FEj2qbFPgM9yO4fnEW
         V44Ptq0D4ULkzVMC/zSEM4VbdRCe5toJy1k+KQ5z9OTbhvBSwblyhDo8Bgb8w0xjrQP6
         6Xiw==
X-Forwarded-Encrypted: i=1; AJvYcCWovR1j+OnSwA7x3Gg5t2POe+iIsyOnN7y6UNWvU0rqqbfAyrTOBRyuchmqRDI7t2i0mGHNL70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPY+w5T2dMzwuZ0VinyRZ+XkbXhJurbg/a6j+OxDFoellIlp7I
	BfqmRbT4koyg6X6ZqgBS4Pig/5lAid9yNHcgGYWcI2Auqk1zgeP+LKdh8R2OcGKk17xU/cc7jcB
	yaG95PmBuHLO1h62mL2uV5tAU1eDH7HgRQN43
X-Gm-Gg: ASbGncu7G28LV0+Gg+pn9/6Jc9ri1+g8eqCNZPYYvZWEPmb2Fp4p2U04SWQc+c3MeGQ
	CrQdXnxG19XyrCrk90DgYSOrxD2iBC5TD1Wf+qgPR64dxdggFKYdVBg0yXG0NAGsGRAIVHaTPK7
	x7ITCH4v0ODIwAzJHd4pMlqH+9F0dT27bczsmHR8nhOrms/mau1pAr
X-Google-Smtp-Source: AGHT+IEHp5xBpPTtWdZMCzH+i0q9BEJGwYBYE7/dAlz0v4nOND8LIunN0ki4CNECu8NBZl9yPLxj0Z18YNBl1Z62spA=
X-Received: by 2002:a7b:ce10:0:b0:43b:bf3f:9664 with SMTP id
 5b1f17b1804b1-440a44c1c39mr72835e9.5.1745519838948; Thu, 24 Apr 2025 11:37:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417204323.3902669-1-hramamurthy@google.com> <20250423171431.2cd8ca21@kernel.org>
In-Reply-To: <20250423171431.2cd8ca21@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 24 Apr 2025 11:37:07 -0700
X-Gm-Features: ATxdqUHZZkXp_HEGK61LJUBhezgIo7ojwCvAQNi8CpuLohtbOPKgVVzGIJimasw
Message-ID: <CAG-FcCPexBHubfzRcVUsBXRYkY0v-ricG-yqLd5q1j051cbEoQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Add adminq lock for creating and destroying
 multiple queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, jeroendb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	shailend@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 17 Apr 2025 20:43:23 +0000 Harshitha Ramamurthy wrote:
> > Also this patch cleans up the error handling code of
> > gve_adminq_destroy_tx_queue.
>
> >  static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queu=
e_index)
> >  {
> >       union gve_adminq_command cmd;
> > -     int err;
> >
> >       memset(&cmd, 0, sizeof(cmd));
> >       cmd.opcode =3D cpu_to_be32(GVE_ADMINQ_DESTROY_TX_QUEUE);
> > @@ -808,11 +820,7 @@ static int gve_adminq_destroy_tx_queue(struct gve_=
priv *priv, u32 queue_index)
> >               .queue_id =3D cpu_to_be32(queue_index),
> >       };
> >
> > -     err =3D gve_adminq_issue_cmd(priv, &cmd);
> > -     if (err)
> > -             return err;
> > -
> > -     return 0;
> > +     return gve_adminq_issue_cmd(priv, &cmd);
> >  }
>
> You mean this cleanup? That's not appropriate for a stable fix...
>
> Could you also explain which callers of this core are not already
> under rtnl_lock and/pr the netdev instance lock?
I discovered this and thought that this applied more widely, but upon
rereading it turns out it only applies to upcoming timestamping
patches and a previous flow steering code attempt that was scuttled.
Current callers are under rtnl_lock or netdev_lock. Should not have
been sent to the net. So will send as part of the timestamping series.
Thanks.


> --
> pw-bot: cr

