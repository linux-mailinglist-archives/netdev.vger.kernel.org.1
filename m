Return-Path: <netdev+bounces-165372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F6A31C29
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B1D1883B6D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9696088F;
	Wed, 12 Feb 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE0t9QcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD31CDA3F
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327858; cv=none; b=izny7NAq91Neytb+TNUFxe1sdz5Jaxf8Tf82JN4TTAG3bKnlcqwFQWuE7Sg3T38mWub8rZV8pwLPz5f+aQZ8g/VwECw5+8awzjVH2j5Mh1xMCt7SjyXs3mMFhv7IuaPdWgo/sD0RF1dNPq+dxJi9vmY0DUZCSW9nzBheglMVOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327858; c=relaxed/simple;
	bh=AVN3fq0fK8td22J9STtE2VkdJuJXh7A42TYyuGhWLO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atNkLLqIu1TWiaLldGEv8Uj2u8Q8Nt41qr1Mn+jxYGLsrjV+CW2lu7AK1S741d+xtLTJxQTbHlF4yjfvXmb3KVVAv66HpWz1d0GTMAjgzgCq5S2NqJ8+/LhIQTZeuJ0LyF9UveHsGfThF7mUKYnylNWMw1d50Nlr4ck7IBP0wGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE0t9QcM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f032484d4so86765ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739327856; x=1739932656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtwBPxIBW5ZYQFBSkC6Tdxc8rD2cooruZFJv84hKkIc=;
        b=qE0t9QcMh9syiWMTeraljaZOxlI7oPOXXmbbg4rP8vvmtOTKF1xXJthJg6hT8Z+Sdv
         QAavO32ijG8b8s3ZmXV9N60mB9S0kKkITaLudJ7+kTrk4QdX1mJbvT6C/87iqKPf2oge
         iXt6KbOykbqdIbW68SovSAOGd3b8Phr2vkMy4pXSco2L4vosDJCEAExMRzIj+cMJalCc
         FjSfgtH7FNz7ctesPVquh+//azr4SIVkcY5ysU1r/eN/PbFSh7tsLxC+b3c9IruvZElc
         HcEpDHs7OlYbQEF9Ot+qMHn6XCqQ0ruyP7GT+3b0VOcJhLKEUu1AP1O1TpcFruAZTqax
         d+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327856; x=1739932656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtwBPxIBW5ZYQFBSkC6Tdxc8rD2cooruZFJv84hKkIc=;
        b=iLmj5KxMYoR5j64tPSOr/9tlikGpFRO01NL9W4PPKJ2mX8j9CCFWJ8u1yGgaDZphMv
         o9XniH114t7at5igcuKXqu4ZncpE6NyPI7RpDD6y8pvApnA69stXnkXWgwPlwTrlVJRa
         ldeETuYrADX56fIBUd+X5kdrH8d6xJXG8zJFN1OyVZNbA9MxmEAMk9eKrXeN6Fz+GKSD
         z0Mz9R7pdLj3pgTCPgE/2BWsRvgLyi1V6TOKwoPVioEiBb5O8AxUFqD7cmPkRtZ5TP49
         vBw2a91JBOindDDYsrbhnjpI9eK21ZYP16C86w2K4Gl5F/g9XzONtsjJZ3F1bMcr/A18
         3A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQdUp6rDqY6hsu/9H6AXsSgOkRac37kZoiV6yQt89GIWEdTvF2qDN81D0IcELOESlo3ivyNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Fy5HpdJvF84EJZRYHR2OZftlNIc7j7cLka5Ur6Jl3EKsVR4o
	ibuTnNllGw6Zf4O101aFtZDkITY2mTdwOxGMmsi9NfstsbZPBwxE3IlPtCemmOIVR+DbV9PpXxA
	82RxeEeSAmaVJGORua0tejzf4piCLVFLY+3Nx
X-Gm-Gg: ASbGncuZKRhaE0vCYrOyUKqoM6jOKtv5agBeKXeaSvGKGb+QGoP2uCtVneosiRVhUeW
	VZHAeQL5fFmsmHSzpbyc1GxALFZtWvCoBpMf1s877HXQ7cm0QJLg4AgkHQNZudGpcp9UbIqFd
X-Google-Smtp-Source: AGHT+IEuXE204G5qn+n2x8FoYbwoknYJeRvyrebKxrwSDGxlGD8/pEYetMzZRjMZIkkz6rR7w4Oj8swQ67P9OFGN8Pc=
X-Received: by 2002:a17:902:9a44:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-220bf1b786amr865225ad.1.1739327855745; Tue, 11 Feb 2025
 18:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250210130953.26831-1-kerneljasonxing@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Feb 2025 18:37:22 -0800
X-Gm-Features: AWEUYZlufc4G24yesQ9j4Bqckcs_zvD8v4cNyRg3blxwk7qQQfeQcsxiiWw6SdA
Message-ID: <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> If the buggy driver causes the inflight less than 0 [1] and warns

How does a buggy driver trigger this?

> us in page_pool_inflight(), it means we should not expect the
> whole page_pool to get back to work normally.
>
> We noticed the kworker is waken up repeatedly and infinitely[1]
> in production. If the page pool detect the error happening,
> probably letting it go is a better way and do not flood the
> var log messages. This patch mitigates the adverse effect.
>
> [1]
> [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> ...
> [Mon Feb 10 20:36:11 2025] Call Trace:
> [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1c6fec08bc43..8e9f5801aabb 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *pool)
>         page_pool_disable_direct_recycling(pool);
>         page_pool_free_frag(pool);
>
> -       if (!page_pool_release(pool))
> +       if (page_pool_release(pool) <=3D 0)
>                 return;

Isn't it the condition in page_pool_release_retry() that you want. to
modify? That is the one that handles whether the worker keeps spinning
no?

I also wonder also whether if the check in page_pool_release() itself
needs to be:

if (inflight < 0)
  __page_pool_destroy();

otherwise the pool will never be destroyed no?

--=20
Thanks,
Mina

