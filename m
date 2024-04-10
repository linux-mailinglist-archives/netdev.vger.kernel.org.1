Return-Path: <netdev+bounces-86702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7938A0003
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39282B26A07
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2003134CC2;
	Wed, 10 Apr 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5NlTlEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDD1DA4E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774891; cv=none; b=dclGDSVO9J3cMN3i2lhVkNdgdE69wZfIeLOMGpmcMCmcWiLzAkjVr/9GAzT+Jb9B0UTuq5elMoItDVnqjw9JyVcoIAsFDG61jcOKX2FjpAE2A0Bzdhenzng+ygwFtQlQPIxRcH11S41qGk70wrSIuZy1hB4HZZMTKS6JWxo97T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774891; c=relaxed/simple;
	bh=looug7Ay/0jmzKfLU458ETLtqGLap8V2gEuQLljHBW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6gNUFyaPK+QTGKYuDGvWC2xHiDJKTodrJVYoTggQ8NbCp/uqnQDMq2CoZIdrmQK2HOgvMsJJszYDTxxLlMFzJPCHvI+xT2nlmIWTlBCbp1vBWPHvdeQvXjvPYd0lVB9yqOg4ZFn9ODKSQWOba5bDNY89YXMQ4WHJJuTU0M47Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5NlTlEF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so17875e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712774888; x=1713379688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=looug7Ay/0jmzKfLU458ETLtqGLap8V2gEuQLljHBW0=;
        b=H5NlTlEFw5J+JwCB5JREadZDwEqbx08qGqSXW+fIS9hwCpQZfeJ+FbZu6cGuwlvAgV
         fFrDXwl1J48p3juy5bcAaxiGL1dl0YrbU+x2oxwCJVwAfjU387Auk+3AZkkUA2mn96VT
         PFnLBWSMxo4Hm692B/t8Pi1ykLWrzI77CvC7YOsrVOsSwRgIeGTOwlvs1kpbQ4cCnllK
         vBaVtNKnW37OXfDrv9WzF0xI/K0GBiCbNzfDDgoW79CxJO0/YR2NNCCSHQiR1LT3r2YX
         Eu4g3Ylh1oVTO6tQrPmCR4T4p7NlwV57kIz1D4WVXkhrWquYcgQhqN9T3eFGWeuIct50
         FttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774888; x=1713379688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=looug7Ay/0jmzKfLU458ETLtqGLap8V2gEuQLljHBW0=;
        b=rDqryxOi5TC4E5Krj4j5PJiG374zcB6cr/XtD5TIwFGEYnuQqQd6Lfz7QilorYvuVS
         W3twfoSlVQ2ykXzWMxcXdBi2FpJJbStzBNOLz9/nlEsJa+fI1TCzT/w5HSdDiqxBIXRt
         lJRD/0d4CabfbGTz7pMY0feQurrH9RosYxSnwOZjnPlzWX8yDcjInyiFp88WI7IvF222
         jtstiKGzbwLuBMuviAaSwxvDEosh2QbUZ2sojXbF8z1CxG6bHQdFWLV4L/Oi1SzRQ/AB
         zL8c+t29pGgVRbN+b0EJipfPIq10LHKX+vIavyzcgSxiuTGnWF7IG7U0HopKl8/b3Pc9
         gcwQ==
X-Gm-Message-State: AOJu0Yym2rWVubuo2TpHreVv565CkVcggN5krNmOKub5Z+MhPZ9RZJZA
	3t9wGKFEqZVLYTOaBGwiP5lm+r30HYGNyhziagGdKVWNId0cPqwJikQ9gLb4rzow4Y4ORP5/k4t
	E4BCqbAVfaJYu6feFdNMG1rtGPaRlmVaL7fts
X-Google-Smtp-Source: AGHT+IH7z8lptP7JKy4wrpagQTw52VvaLE7hHXC1NNuzZBl3Gcmr5/yahAwFD0edV0KnOTzspcS8LIMnWCGWfxLs4QA=
X-Received: by 2002:a05:600c:5125:b0:416:57f5:b426 with SMTP id
 o37-20020a05600c512500b0041657f5b426mr18781wms.1.1712774887436; Wed, 10 Apr
 2024 11:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712711977.git.asml.silence@gmail.com> <bcf5dbdda79688b074ab7ae2238535840a6d3fc2.1712711977.git.asml.silence@gmail.com>
In-Reply-To: <bcf5dbdda79688b074ab7ae2238535840a6d3fc2.1712711977.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2024 20:47:56 +0200
Message-ID: <CANn89iL+OgVAEmMH_eXNrj7+d1_pGmP-iCLOD3veVfo0j6zc1w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: use SKB_CONSUMED in skb_attempt_defer_free()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> skb_attempt_defer_free() is used to free already processed skbs, so pass
> SKB_CONSUMED as the reason in kfree_skb_napi_cache().
>
> Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

