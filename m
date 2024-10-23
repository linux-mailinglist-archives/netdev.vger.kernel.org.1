Return-Path: <netdev+bounces-138095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AA9ABF10
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B3E2823FA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E714A4F7;
	Wed, 23 Oct 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmOi/QxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E114A4EB
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665832; cv=none; b=kEfX3lDLOQ/Ss6vc3jBul+ROM0eP1YuBYugmEOaKj8f0NNQENLQwnZie7+RxnQLBeESlkIEiKh+3NLPWzQYmMAzlCQZxK0dRMUA1H3K6/6V0Y97ty2FwXvLvxqR9bgYQ5O9tviOdmRnN0Ygq5EL3dWapJ5lRNEOhk6z2d9Q0qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665832; c=relaxed/simple;
	bh=hE16K3E7H12Wm7Jno6gGmVcperdV0RIsswFmt+g6fJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asGRypKfmgSYm5Or4GcJMNT1pxpepHYQjJso6hwkTvclt8qaZdOVMPR6m+Cz2oprvc0PnLorsvZZF6Gc31AViLKIdXXLqXErwU8vZVPJ6lZtE3/43rzNXLCSvIjp/z2KGp/X1jBGbHHISMkAQ3hhggvke6yD5cN+z69az06/BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmOi/QxU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso8057132a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729665830; x=1730270630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR8Js9xDii8BH4xir6aYosjpe9kbmbUf58ZCLU8Tfk8=;
        b=WmOi/QxU1dyWHrnh4n903jzK70piVtiyMYVLnB2LLfe1+CGRHeyMdXjL6bjS25CWn1
         zku2+LYtvnBb+62VzR6XzjySQsQTaXSFxCzA9077ETwE/dCY25uXaq4tll1Vx4+P9ynU
         Zy07wTf6BZivb3K78yC7HzEF07j8tKwm2zQcYgI2MyPmNaKHL0IztP4JhH1aUSa8rX3E
         V9dQ5TeK3a8iHGiSv+W//3ng85SQeBe+onPfbs2Hlt/awGYf0QscWZHaDNqWQs35J9PR
         0JBxcCRRU0f5BE2J7TRU2kvqMfG42IiYwGLbGFTKNRiCqJ3VB3uJJ2lUQ2K02bAZrNvq
         6akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729665830; x=1730270630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR8Js9xDii8BH4xir6aYosjpe9kbmbUf58ZCLU8Tfk8=;
        b=P5VSaXjIOyR1BuDq8UyxTGYdZTtuxbKVskK5d7lRUFz5/jIv6oBD04cXlnZQx9JIeA
         yuPJy0by+ul4wOQ7nR+ff9BLCSB8cThEi2DDHt1uY/vly4no6Pya4dvjORGhP6Tepa/i
         KZ0HPd5W67UFsOJsdiAAiHnsMcfFFwXr3x+mqSASJGCWESzgDRsjFbgY0MmGWVAORlLR
         5pNfWbw5F3sG3X299PwBN8YJ4h2P+ytW6Adht4TeCEdJ5FoPANgeLrC2GOj784VTUiU/
         Omlb0A9JSY9C66KsKt9zvLZnemWcXtZ6jtSM0gMGXngf3bjPo2Azgr6qOFw6sxGN6CBd
         zONg==
X-Forwarded-Encrypted: i=1; AJvYcCVl9GY9NKO2gkrECvtwymnrkHX/7yJuFVZaflvRD7M09/p23Un6Ob4dWBMQ8tsi0t4zsdca23s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzLUsuW4ZDEr++jISCjczTMGZPUrsxeoDNkqf01k7WM0E/tHk
	brs8uAXZSAOixYgHLOzYi9Euaz+AS9VbqAUJy/TY0V+cvjmt3j7xUR9EMAKF5Fap6NJFVXzfUQ6
	eJ6mHiUeVrV9/VNXZchfLXn9sVQbmHDzR5Yg7
X-Google-Smtp-Source: AGHT+IEFSLUWvPFdrt0U6HQ7IeRygWwKTZbtQ5TFk4Dq4/uOOQ5k7MFogvGu2vS+B5GpXGBigKZFzDIlwJIvBYnrQTI=
X-Received: by 2002:a05:6402:40cd:b0:5c9:8a75:a707 with SMTP id
 4fb4d7f45d1cf-5cb8ac56883mr1349139a12.2.1729665829370; Tue, 22 Oct 2024
 23:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023035213.517386-1-wangliang74@huawei.com>
In-Reply-To: <20241023035213.517386-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 08:43:36 +0200
Message-ID: <CANn89iLpMv8E0=VR=nEBB_AJqR74=GbMvZs4NdESpCjBv7x7iA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix crash when config small gso_max_size/gso_ipv4_max_size
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, 
	kuniyu@amazon.com, stephen@networkplumber.org, dsahern@kernel.org, 
	lucien.xin@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:34=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
> in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
> because sk->sk_gso_max_size would be much bigger than device limits.
> Call Trace:
> tcp_write_xmit
>     tso_segs =3D tcp_init_tso_segs(skb, mss_now);
>         tcp_set_skb_tso_segs
>             tcp_skb_pcount_set
>                 // skb->len =3D 524288, mss_now =3D 8
>                 // u16 tso_segs =3D 524288/8 =3D 65535 -> 0
>                 tso_segs =3D DIV_ROUND_UP(skb->len, mss_now)
>     BUG_ON(!tso_segs)
> Add check for the minimum value of gso_max_size and gso_ipv4_max_size.
>
> Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device c=
reation")
> Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size pe=
r device")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---

Thanks for this fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

