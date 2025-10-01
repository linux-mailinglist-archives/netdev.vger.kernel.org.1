Return-Path: <netdev+bounces-227516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0312BB1B23
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7C8189E9F7
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35F2EE5F0;
	Wed,  1 Oct 2025 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6RXH8LA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724526D4D8
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350756; cv=none; b=l6sawgdxABkQfyp9x+FDr0ys7fVbU1ly/HoYfbb7NtyyTOknC5U+st9o4fK42P3x/VheinTLt+kwTafpttHgMJlpDz/LLtrKPZP9/NW5kSRyXQEhJsvAKZRO6iAYZNPrgpIlJeOtJJzwCCoOGePR2L+13VQRsbXuZALqi2cFhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350756; c=relaxed/simple;
	bh=G0rSyp/sRdiQNj5upgrqgaMgmPTfXN51E8qhsVMMm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5ccsqJ08oK+hqqc8c/KUAhStlwsd2GxkD4+Yg/8lgxkY/Tr6iXsRFYnaTCV2es7RlZa1d1fBiXVUyD8v/5YbtCGuYcGWlWh/6PL9RRCYbizBlc3jVjkoiH5ilAsWW2I7S1ElYtGVbsC8CYS8YAn+Bq/QAA20siyEOkhD9nQaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6RXH8LA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43f8116a163so197938b6e.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350752; x=1759955552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROkfBcmvVJYkILd+CGDVg+7arfVWHonkG/mlRIhc5ZY=;
        b=P6RXH8LAz+3RVbixlliNsVnWAP3CJurJv5Hg+idSGJcbUEcks8ZxT6gwI4NXFFP5LR
         8QHAZhKXcRHZQt3A77kuELA8sV4fRgrEgetziDOZjwuDjjRA8eA4YrsfmkBo5Jr9NXmP
         UAYeUvqTsqCofmBguvuaL3Nt3hTah/CSj+ID0ZtcOeD/JvT99Fgf9xAKHg8vZqU6PHDg
         zVy2L19T5OMuh6ELzPNI7Msc7cq8arM674vdk4vV2aL5hEiYiYi5tXTlUo4QV2ID9gib
         y00BOQ1872TtJqohhRleAhLBP9CjNJeRNET7f5FErl5P75VYaAnopcUOO5/l+9E3zzTm
         FQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350752; x=1759955552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROkfBcmvVJYkILd+CGDVg+7arfVWHonkG/mlRIhc5ZY=;
        b=VpeWAw9+pyGsTRExNOBKse5GpisZE+PvdU6sTXcJb0OzhrGtaewDm17kolXAddO7H2
         XDb/Hh5oH5wKNrweQ/a24xLt2hUQ0j9MyQB31BbWGi+/VyH/j4UZG/cjmqv0ogsr23HY
         xInU+T//SpKeq1Lxp4+cbOom4UJg8Rj3O/x9aoCJH3qQ8FWw2igzDgWgU5hgHe8SDWWq
         75fh2e8BO2WfMOtaazP4PgGwtGrA09cO0YoWeGVWRt4RjWSQ/zFJthOaZ6KxMA7TJYGq
         r4wwK6PaciP036NxBQDsHGLgdfRd2Z6RhH4lHUR/xYdFcbEl4QOVq5UyX44FkmxNi8+9
         gufg==
X-Forwarded-Encrypted: i=1; AJvYcCUi0SiAOW81XIzCorvNd8RYw8n5YHbbcoX9Sp17LZdO5UOGBAGnxyjUELh1Y6u7p1XBvZqZ77w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86uOu2eGXE/8CUzsx/G3DbW7uKYY2AG8A7Squgt0OdsNKInW9
	KJ8ir9K3pDfF1YfrP+iBizntr1aYBuhNlRrtTgyWyaDnfyd0qpI+cJE/vVAWvoMI9QpgmrLpf2P
	BqdWfGmSMV0ZZ+eWTxpeABO6isMm0Op8=
X-Gm-Gg: ASbGncuTk5xuq82WvxsyhLojfHj5nqaNJYGvZs2xGM9iSqAfS6xkd+kd2H5mvOQaqMQ
	SDXrkajI4CDoErwY748by0bZHR3xmTk4/rqRflD7dM0XC7M4ohsy+7i/oSDuuwuOuBVlcsLx9LX
	H2chlxOkNRL5pY0jqrY99+DHugVofJVk57FjGkkX4/cNb08+Cw8pfXLdVDRszggs3J17QsUvDYN
	glx+VFxJQ2ClvvIVeIKRImpcNrid+v0
X-Google-Smtp-Source: AGHT+IEwaEQOnGsnARBGr3xeupMy2phTmZXTuGJEZCsj1Dp52mP6s7xhLvUlFO8i94FavDtGwYr3+FXKGGQhYWqnqRU=
X-Received: by 2002:a05:6808:f0b:b0:43f:3d56:4dca with SMTP id
 5614622812f47-43fa4337201mr2833617b6e.50.1759350751961; Wed, 01 Oct 2025
 13:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com> <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
In-Reply-To: <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 1 Oct 2025 15:32:20 -0500
X-Gm-Features: AS18NWBsc1WeTorEJlVcceR4cL-NZe4hvZlUCilIVOfDJ0iEb3NXj0ni2aLcMpA
Message-ID: <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:25=E2=80=AFAM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
>
> On 9/29/25 20:19, Jassi Brar wrote:
> > On Mon, Sep 29, 2025 at 12:11=E2=80=AFPM Adam Young
> > <admiyo@amperemail.onmicrosoft.com> wrote:
> >> I posted a patch that addresses a few of these issues.  Here is a top
> >> level description of the isse
> >>
> >>
> >> The correct way to use the mailbox API would be to allocate a buffer f=
or
> >> the message,write the message to that buffer, and pass it in to
> >> mbox_send_message.  The abstraction is designed to then provide
> >> sequential access to the shared resource in order to send the messages
> >> in order.  The existing PCC Mailbox implementation violated this
> >> abstraction.  It requires each individual driver re-implement all of t=
he
> >> sequential ordering to access the shared buffer.
> >>
> >> Why? Because they are all type 2 drivers, and the shared buffer is
> >> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
> >> for status.  It would be execessive to kmalloc a buffer of this size.
> >>
> >> This shows the shortcoming of the mailbox API.  The mailbox API assume=
s
> >> that there is a large enough buffer passed in to only provide a void *
> >> pointer to the message.  Since the value is small enough to fit into a
> >> single register, it the mailbox abstraction could provide an
> >> implementation that stored a union of a void * and word.
> >>
> > Mailbox api does not make assumptions about the format of message
> > hence it simply asks for void*.
> > Probably I don't understand your requirement, but why can't you pass th=
e pointer
> > to the 'word' you want to use otherwise?
> >
> The mbox_send_message call will then take the pointer value that you
> give it and put it in a ring buffer.  The function then returns, and the
> value may be popped off the stack before the message is actually sent.
> In practice we don't see this because much of the code that calls it is
> blocking code, so the value stays on the stack until it is read.  Or, in
> the case of the PCC mailbox, the value is never read or used.  But, as
> the API is designed, the memory passed into to the function should
> expect to live longer than the function call, and should not be
> allocated on the stack.
>
Mailbox api doesn't dictate the message format, so it simply accepts the me=
ssage
pointer from the client and passes that to the controller driver. The
message, pointed
to by the submitted pointer, should be available to the controller
driver until transmitted.
So yes, the message should be allocated either not on stack or, if on stack=
, not
popped until tx_done. You see it as a "shortcoming" because your
message is simply
a word that you want to submit and be done with.

