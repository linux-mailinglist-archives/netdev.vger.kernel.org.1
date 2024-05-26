Return-Path: <netdev+bounces-98081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69378CF295
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 07:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4801C208DD
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 05:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8970A1849;
	Sun, 26 May 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="evPhrcd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893217D2
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716701513; cv=none; b=ojQE2k+Jos2wQY3Gx/en+NSPmrFDrJ55CSnPCJGHBlznAhRiR3hCyRQQIhp8dkPPpLcqdMoPy0iFAJi+YV/GJ6DIX0zpzGlaMF+Oej7ih70I4pGjJ5H3xH0XVf47zbt3eUtvEH5FvRthlE/D8FkFrVrwnbPK0tTyXRona88JjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716701513; c=relaxed/simple;
	bh=mpnfXpjAi2fDJsiDaipKOwOB8d+RQ8jngRsgQeS5Ud0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcgjlBlTZdSPEM0T7+NVwL0plAx6wZBMWMu2FohBis63ayo7oslWNtnRNWx/aXu3qpL6ybEFWtBfKrdqEr1HfezYDTExS0iJNaY3ZNy6/nOnq4fCrhT3RtQLLWg5LGtuCEQTzsFrQCKZpz/G6jwpVWlrbdvTU47PxaB3L1H5+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=evPhrcd+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57857e0f465so2146498a12.1
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 22:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716701510; x=1717306310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QoPb+xb5kS8JqRVBZTvBweTNH2JipcWtH42HkUJVj5s=;
        b=evPhrcd+OcZLbBvCO5JE5ICFukvwLhjhL4U6lcSCeyVtU+gkMMX3WtkzVvzQNsHkVk
         Fz+SVCxVRBKBlNhLbNogaNBkvp9KHf1ZXB5KTaei+cMYrzyHHM05jsZ4TKICJcZrfrWc
         zPn7ham1qoyCj+IgwkkLHQQaFrrFbIz/XB0WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716701510; x=1717306310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoPb+xb5kS8JqRVBZTvBweTNH2JipcWtH42HkUJVj5s=;
        b=LgCLsMntrE6/cI9BYlq+jUUB4z+Kyeb+9CHeo80Qj7C8t6lrA+CW0aISqu72jC3pkL
         dVkoxb5a+zdcBxEOWS/U6ZXPtS1g11lbBNMeCnt8WRa/lS/j953KqToQjppATu9qVxs+
         /ICZUDJK3/CVXAUh7p60F78bO7X3hc2TWhGGJTqpmIY0DFjDqC+FB72eFONcIpAZO2GA
         WRsvnmTVVwq9Td78gPNF12KDYhDdGo96ubP/3oe2RbLM5znTr5C5kEZXY1LWmpRiMd/5
         dIUuhP6rba3B+PuvvKThDdvZCI9V4LEbejKVQ3jxB5pvgNdFLOsBMhEpYXGOuUitaTJV
         d3sA==
X-Gm-Message-State: AOJu0Yz4XOzqp9w8KvZ7C4mjyAS45+XzJbLLDLn9JYiu9yHSbTGhHTY0
	5X8BvT4HpCVA4tuj5+LIJPBRErNunHQERtDYj50Tu/9yWYNyjdS97y4S12gaYu4Tkc8paDIA0kx
	EPd6enA==
X-Google-Smtp-Source: AGHT+IHTLU50e8IRhJiKkDn1qwTGlMe+X89LnAp6RBBBiIGPEkDUhXHwW2XVwGW68ZJ7gOPMG6AKPw==
X-Received: by 2002:a50:8754:0:b0:578:5ace:1c96 with SMTP id 4fb4d7f45d1cf-5785ace1f85mr3605667a12.36.1716701509811;
        Sat, 25 May 2024 22:31:49 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c73c771esm739721a12.65.2024.05.25.22.31.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:31:49 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so2202546a12.2
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 22:31:49 -0700 (PDT)
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id
 a640c23a62f3a-a62643e2436mr365879466b.38.1716701508955; Sat, 25 May 2024
 22:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
In-Reply-To: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1_Sfgr6HsfjsCg_B-5b9sGKuWFpWnkwhdwNaODekraQ@mail.gmail.com>
Message-ID: <CAHk-=wh1_Sfgr6HsfjsCg_B-5b9sGKuWFpWnkwhdwNaODekraQ@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 22:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, we could do something like the attached. I think it's actually
> almost a cleanup [..]

The reason I say that is this part of the patch:

  -static inline struct fd __to_fd(unsigned long v)
  +static inline struct fd __to_fd(struct rawfd raw)
   {
  -       return (struct fd){(struct file *)(v & ~3),v & 3};
  +       return (struct fd){fdfile(raw),fdflags(raw)};
   }

which I think actually improves on our current situation.

No, my fdfile/fdflags functions aren't pretty, but they have more type
safety than the bare "unsigned long", and in that "__to_fd()" case I
think it actually makes that unpacking operation much more obvious.

It might be good to have the reverse "packing" helper inline function
too, so that __fdget() wouldn't do this:

                return (struct rawfd) { FDPUT_FPUT | (unsigned long)file };

but instead have some kind of "mkrawfd()" helper that does the above,
and we'd have

                return mkrawfd(file, FDPUT_FPUT);

instead. That would obviate my EMPTY_RAWFD macro, and we'd just use
"mkrawfd(NULL, 0)"?

Maybe this is bikeshedding. But I'd rather have this kind of explicit
one-word interface with a wrapped tagged pointer than have something
as subtle as your fd_empty() that magically generates better code in
certain very specific circumstances.

                     Linus

