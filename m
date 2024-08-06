Return-Path: <netdev+bounces-115942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5169487D4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 05:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DEF1C22271
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2595B1FB;
	Tue,  6 Aug 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AqIjGFxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C857CB6
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913813; cv=none; b=Yc3ineMCQsFuLZPdu5Dp62nV2c7dRLr9NpaZI8D3E3/EIY5jNXotKAxAeo0M3kB6Wzovo7RB+4jFWU43FrM6BU/xgid64GJrFVlVtZnqh8qKqqXV+rcDMbXs99GVR+NcR7JaaTPsdCJf+Xotoic5JsprHL7z83ON34YsONiKFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913813; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/yfMsE+UMnAWCrdJtGTrxHIGok8gijREnxQhmivWym+ZihF1VbeDaI6nY35R0wd2WP6NLbPx7Svh9uNC4+N+Y3MpEJik/XQy1gadI1gIPqev4vyrTY/OPoEW7iQpS72aM27eGZQlQoQSTitX7vpTdGRpyxdWzLdPs79pJ0Rtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AqIjGFxt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so73022a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913809; x=1723518609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=AqIjGFxtM0nFjNXxOr7KDYCUIJeYxKS32lAgjemtmmhh9bvx3RgcyRhtpne9s7jhkw
         8JaHUpJqtcDLArsgJamUrkgkrJQk/mdyXVPUbfOYS9kY5bzsrpUHWNPaW1nz9o9qGaEK
         HB5VZVGmFKgZ0VFV6k1d4LmCh5BFz3eqoS5cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913809; x=1723518609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=w2p9PtAb4M65quqWNFLiHMVjlZaxO/XPGtqatI3RSUJwU3yygvXGuPuX+iPfH7Km12
         f+ivPl8XTMnsBWX5P6dG/uihkyTiGFEGTM1UZPdgcl/VKbZYGa6k0NnwlkHYTQC8044N
         +8jJZQ3Oy0mDVucE3jusaTf84jXnpVSx8El9/UcVP9H91p4sJjUEJoKH7AVS2iSymLrJ
         w/U2e58ow97ZkB6ONZhR+yJ0e9rkGLdYwVR35iPpbyloD6AE+zidyxyL9XbODiWkdUXn
         QgeqYysmnl2kZbFPmqgre7wLDYvR0+PiTX9y3Tz5/cXKvzvYmGLZz4DYUATfr0orJ7Nf
         aP2g==
X-Forwarded-Encrypted: i=1; AJvYcCWj0Ad/eTyawZMG5BBFPnEv9UZvZqKeAmr9bxuUP4xuunt3M5ax3Aiz/fHsFcrnAZ9fFLtinZ/AxltCl1t682vtfov487kJ
X-Gm-Message-State: AOJu0YzAq1D1PfGIETSqEhuAv+ONnLw7Ld3jtJ5DSMXUJex+TeiiMsvT
	Z9XKWDEbG7f66A1ibLkSToTbstmgR8lS0L9R7XZhOFm1CLOgjvOIkPBFrOtIO4bOboqYurLfwcI
	FRMGK/w==
X-Google-Smtp-Source: AGHT+IFJyDUjruK6U0c4vLl1gPyOrTxHXphzOMf5+yVsvxZ60Xw+Bqpb7eqeVg5EXSvLcz7nLm8Atw==
X-Received: by 2002:a50:eac1:0:b0:5ab:3174:9e1f with SMTP id 4fb4d7f45d1cf-5b7f3ad9102mr9349290a12.15.1722913809058;
        Mon, 05 Aug 2024 20:10:09 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839708c56sm5554512a12.2.2024.08.05.20.10.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso5245266b.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBzoOznhTnUNX6kR1W30ClW+Dvx9GlW23lM2GPk2cLwU8uZZGP0KYUGPFTIxnFu5sSVDb6pRECf71tUaTGqC5AVlX3Sokn
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus

