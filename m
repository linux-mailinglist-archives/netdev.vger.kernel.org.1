Return-Path: <netdev+bounces-229824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4DBE114C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966C94E5577
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6F3FC7;
	Thu, 16 Oct 2025 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHRWcHCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4C610D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573678; cv=none; b=WTSj44NuPnU+y11uq19F1iHPE+T5OQlySQhR4v4kVxKLT2ygnP9tN6PYMtxyL3wa7jDO5d6Klzv+eP/oN01fEfpMZaLUB57c5AjIYmBdatw1GmCDeyVgrLk/CJvyFQOv0yWw5uZBNE1BE+ihJILwGIix74Zd7+lKhmSflf2qGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573678; c=relaxed/simple;
	bh=IXl+OEhS64sQ2ZK2+Q0IM9wz4tp8MMKhZ9emgeUNqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVsTaltBJ9PwSA9G8Rm3MGuTUv+5iuERJ6/LrdWeTZHHGy64V8T3pxtLwfO9A9xGLD4CtE3kum3kM7SJMYoHRppWC+nxCMURGQdhI8r1sWJaarmy2FNCI6+Hs4P47UnfU8FbGozpF6evKVYNGJ2g36agLaXrhUMOJjisCgLLABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHRWcHCz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63befe5f379so141452a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 17:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760573675; x=1761178475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEQ3NRFfhuWbR8QwlzPhUPkCn4cpDdbL+zo8DqY2eTk=;
        b=KHRWcHCz+PQfgxpK5vLMblnmDJ2oPapGLN9h/eWALeU7k8YR9mxiaXusnu/U+AssHT
         qjMVF20ycvbfMF1QnZz1WK3rNWwmdAbAzjEz9qIFq8TPL+VCnf8pZn4o2J9neFSRpwHM
         B1jWCHBIWIJSs9yzuw7WMuqC/3MMaCnZfKibKVBr9kxWXwo4YRBhda0g3OdaCbNAflJe
         zAd4GhjQzSw7W1IIxAFKbC4q8QS6F0vMLjSSPWxoDyqo/yuSKRwIsfoigt2M4lzI68El
         HosaqbdiudsKTK2vdw0UMrSOGb0x6NaoDGymaxvskJNgJzVFBDuZvu0SIqlcnAsan325
         JfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760573675; x=1761178475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEQ3NRFfhuWbR8QwlzPhUPkCn4cpDdbL+zo8DqY2eTk=;
        b=AKQLEu9t7pKK5aDh/y4hingFeWoGdko/1FJdN1rWIDnGwVhHP+7d69ywLWX7GHqR/v
         a4//F2Qfub/lmcWE08toIW/YXbmGTFz9QGMAdvsos2EUnEUHh74MGkDVdAgInuROFcGg
         rBQt3XiZzPjO3sUsGadYvnHIYHdVEuNv58TGlCeuv1wHh41z+oUSGj2dP1q4VM7Z1KXj
         TZ+h/Umynus06LuZi9o979/Y25t5Cs7JViQUL1gF++NCf3FVQtL9gDUng23SE+Yjlmrt
         HoqdY201YRtNMPJBnhg+d7oDIAI7t8/cQn/5lwDMWRu/0Cu6zLdEKotPP3iN7zjhGYeg
         jfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWk4sV4C36hBGisvu8XSQPFZsXm4eATLSn4YS/yxgWe9lObRF9CfcABvnJnUuX8omZ31CrGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQs7ms84K5+4Sb5f/06DyJFSWubs34MU/Lp6MzkxLRLaliIKET
	gzfCITAVoo0T8fnTlOqh6GYuWw3TeSArIKrbEXN1WnRGkTlzID8VNTt/NItbpVc7jgSVpnCuMHR
	oc28uq5BUpce1AxGkIK95qdIMVwwn2grJ3f5NNvUx
X-Gm-Gg: ASbGncsxwmUSQJ5ccv6/Oo7VA5rj8hwdMvMvQS1ykrki8UqV5XnsIvCLuhCIC4pfudw
	47WddQ9wrdFxmnn7aqEeYlc3Yybgc3Sf4zfBlL3rDQmeUKv0fvPjAGC6e/smgKjI5X8klXPtGRk
	ECFA1ozZmZzj0Ybu2EWYeuii2eZyrvicNhrcI2AN5b60+9Hl7Qbz6CfRT3yMaVmK2t1ztihCZjE
	vRkqG/tWVf7eE8bjZOnt3PZRICtdLouGa9NKzKv3IlIcIDYkxJUbm2wMg7/pccUMLvGnDyVhW0L
	e8egeTvpyxyl2kgO4eX6gljEYw3Nlw+ArM1YJJhaTwI=
X-Google-Smtp-Source: AGHT+IGA0gDPAGV4X0oXE9Ikkd6WtJDIUlnaxjVZDTFOHP22H+NHmHUxM+X3FALIXk8QzG9kXEZoblRa1VChAhSzB1k=
X-Received: by 2002:a05:6402:3552:b0:63b:ea10:a0d with SMTP id
 4fb4d7f45d1cf-63bea100c82mr5183823a12.15.1760573674695; Wed, 15 Oct 2025
 17:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015233801.2977044-1-edumazet@google.com>
In-Reply-To: <20251015233801.2977044-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 17:14:21 -0700
X-Gm-Features: AS18NWBjlTgqjuqQXigZaL4XOWB7Ycf72ruEtEgwBgMg_to3USm7I4XBPPhcqD4
Message-ID: <CAAVpQUCsYsvZG76xvR9iCdd_4bjo0iLCRXPmHMidGOAJQc0Jhg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:38=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
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
> This is because kmem_cache_size() is an extern function,
> and kasan_unpoison_object_data() is an inline function.
>
> Cache kmem_cache_size() result in a temporary variable, and
> make the loop conditional to CONFIG_KASAN.
>
> After this patch, napi_skb_cache_put() is inlined in its callers.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Oh exactly, it's interesting that the compiler cannot optimise out
unused retval even though kmem_cache_size() is a single load :o

$ grep KASAN .config
CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
CONFIG_CC_HAS_KASAN_SW_TAGS=3Dy
# CONFIG_KASAN is not set

$ objdump --disassemble=3Dnapi_skb_cache_put vmlinux
...
ffffffff81e9fe10 <napi_skb_cache_put>:
...
ffffffff81e9fe40: 48 8b 3d 89 bd d6 00 mov    0xd6bd89(%rip),%rdi
  # ffffffff82c0bbd0 <net_hotdata+0x150>
ffffffff81e9fe47: e8 a4 79 60 ff       call   ffffffff814a77f0 <kmem_cache_=
size>
ffffffff81e9fe4c: 83 eb 01             sub    $0x1,%ebx
ffffffff81e9fe4f: 75 ef                jne    ffffffff81e9fe40
<napi_skb_cache_put+0x30>

