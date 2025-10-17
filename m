Return-Path: <netdev+bounces-230303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48441BE66F7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3E294F6EA9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC81DF75A;
	Fri, 17 Oct 2025 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9V9KCTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE410334686
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679195; cv=none; b=owkQDHUtW4umYiJEwu/TfSw09akw6gsyeEEx3qM1M9WBH9ApBoacH0xKTaTe35SFY6LXNC1bvIZ64cl1d4rf5adaTQ6kfNIPXbl7WVtcIgZVJsYyR0kIp/3pmka7CjLPw0yERTzaVAo9ZCsTRDY6mirbcJX2+f7mQP3XyOMOi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679195; c=relaxed/simple;
	bh=u8m4fczJ6sUAqpMuAI46IvMPYJcmheCQnOvLBryOJM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfNYhuBugtDg3FnIAcNBHZI/MLkOKO8oqKF85dtO9gHaQs65GPKfQnwOYYDirCeHC4jLhryI1n4jtmp7uU6s1sjG/8XGdyV+5iyBeuIBOidor7Rh8NRzp9DYt1QyG7Qr/lcnLEss9gns3tloEYdxRcfhZwO+bpgJLXvq8/JkT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9V9KCTA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b57bf560703so1054760a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760679193; x=1761283993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch1d5RT9KrAP/gkJZgTLJ1ri8YkpzdFfimJFNqlBEaI=;
        b=t9V9KCTAAFUGDdMBsuIntqFJrTAwq+/GxFnRKymTZMLvQMZOAhVKCBiSd+n3BQIl3t
         SwT2Yp9IrjFXeSjI+irrft8F2fO6XbVEw8Uzh9bLyS4mol84D63oD/LAcOdrBAPGOT+5
         Eol0xqJvYBf3ocV+OyFoxtgETb+eaTheCRwKx5wSic+PyVcdfKtoD8Nui7V+xceTDwdx
         CynUYV1irmgOwkl+GpeXwjbbyGYKYTEm64xESwhJAWnIu2G173OCYtwxAhaXc0T3ZkBM
         E7iuTNP9NCQpCpkWV0TgS2Wede81qFbEWzDBZ0yqdw2it+JgaGZZaSGDOvd+fMT0pwvU
         Jw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760679193; x=1761283993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch1d5RT9KrAP/gkJZgTLJ1ri8YkpzdFfimJFNqlBEaI=;
        b=lYQIFRmG+SfUf+sXHW28ipawtkhPyeAwWiHFEEP92pWKaRWJEfQJAhldN7XYA+f1n/
         9n/IoXTkVFXHAldipoU8S/iko7YqfKulo3h3A62IN1JKtfgqfJdKNhWUsJRzp2s2DQwM
         UgsP9RNjvRi+iAVRdU98WL2SBLNCCTmfor+ZVtSug/SK3yKtu5u1tO8AmsGDN6qfcEtS
         xOOt6hVeU4k3coOu3hqEM/zYNVwt6LlKZBWx9+klSkPY9ayLVzxxSr9BkgngLcHAAVDA
         8pi2klevZfnRup4ohuOZ8v+4KZJ6fIORep8kYy01rT2LyIgeLGriD+qxpXo0o+TUPnFs
         /cFA==
X-Forwarded-Encrypted: i=1; AJvYcCVKYCCedcba2bMheTvxRkypCuWXLG4d6rPmSVE9xQ4ywwVWej1b8M9PIc1INEnR0jGiPmaS1DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHIh1SosfEDMFka2Colu0peiIpevMMiw8qrOGVWCBcbVAQKpA
	ekmHdVwMvCP3RrX4OrHLrpUb1iaEdRUy2Z09fUlXRwS44/zp4smxagr3dYZYtDe1ALxtv0A9b4n
	G8XQaLvqCpXUmjMIr4aWiQNLDJLmi75tw+uGfBtzw
X-Gm-Gg: ASbGncsL4MSQEDFIkYxDRlvrVEbq/YZuf7fnOq3DB/1bnDug23mwpXbU9Hw48ahDEHM
	dYw6Y+CjSgmUdpbMf+ecA7a650bI//vNwtffZlAXoReag+5YuNpiN2JVJLG9X+OJKmr0wIq457P
	Kw2uddl5q7s4qXsxGxtC9IYC3ErB0pQaJ4mZi5a/zqN3Iwpx9OqYRw1SlztrPZI+K6AGQSm3fjM
	UjiStODbVQO6muUm7KsHvb2F2GSoM3fRNCLKf7Mxu1vG2bvYGMN7UOESGOylDWWmUE0rrOvVThQ
	AliZo/qw2BZpsRqxDIeHbOZEPk13
X-Google-Smtp-Source: AGHT+IG69XpO7OrmdnJwDtY+y+pZBA9cWlJ2iORkCmex62U+Nl7m2dJaQz9/Gigm6dM62Gz5NZ1Gb2LUwNFE5hfx1gM=
X-Received: by 2002:a17:903:2411:b0:26c:e270:6dad with SMTP id
 d9443c01a7336-290ccadb0bcmr23786095ad.60.1760679192647; Thu, 16 Oct 2025
 22:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016182911.1132792-1-edumazet@google.com>
In-Reply-To: <20251016182911.1132792-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Oct 2025 22:33:01 -0700
X-Gm-Features: AS18NWAnVhpDQE2q5CU3NIxK4xanOE8CxrrMol-WMsgZzwUJiTzwWJXNd9cQzXE
Message-ID: <CAAVpQUDz0B_49t82RpsH-Fdvukr9oVxur3TvDm8FNQyXgVTU5g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and napi_skb_cache_get_bulk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:29=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Following loop in napi_skb_cache_put() is unrolled by the compiler
> even if CONFIG_KASAN is not enabled:
>
> for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>         kasan_mempool_unpoison_object(nc->skb_cache[i],
>                                 kmem_cache_size(net_hotdata.skbuff_cache)=
);
>
> We have 32 times this sequence, for a total of 384 bytes.
>
>         48 8b 3d 00 00 00 00    net_hotdata.skbuff_cache,%rdi
>         e8 00 00 00 00          call   kmem_cache_size
>
> This is because kmem_cache_size() is not an inline and not const,
> and kasan_unpoison_object_data() is an inline function.
>
> Cache kmem_cache_size() result in a variable, so that
> the compiler can remove dead code (and variable) when/if
> CONFIG_KASAN is unset.
>
> After this patch, napi_skb_cache_put() is inlined in its callers,
> and we avoid one kmem_cache_size() call in napi_skb_cache_get()
> and napi_skb_cache_get_bulk().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

