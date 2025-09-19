Return-Path: <netdev+bounces-224888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08290B8B3D8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD697C25DF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12A29BDAD;
	Fri, 19 Sep 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZ2VUTJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA62571BE
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315046; cv=none; b=Q+OFVAENoQcfJFEWDgvqUPn+0C6ppEb3IT/F+7BNoUKnjLpwF+JGEhupUlas9uv4PKXDxAtoUc3hJ+Yo5+nfd2gbqKeJpi2g8V6JE6hqIJKlMzqGIBKygpnPExKcSRiMUtLEIRgTz5DciCZ7Q7hkAjKTMJ0JDuss8UysRHImnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315046; c=relaxed/simple;
	bh=P1hw5Yf/IClJ9aitO1VqOvHmT70CjzC/qs4xt3xLGUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0+x9kAaa6FNBpqPt25N64G6HxaNJAKrisv+n0iQzKaufvkFdqZOJBrnuDEjaN9yxh7ZJ/kG0xezU43Pe9CIWK1kBH+HtcaNlBM4RrwiriMdMpFl3gufeRgemZzGZEpbW1S6A7SNQuFAB3urFcusYRIFfsZjdW0wJsMSNcAhfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZ2VUTJg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b60144fc74so31472811cf.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758315044; x=1758919844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1hw5Yf/IClJ9aitO1VqOvHmT70CjzC/qs4xt3xLGUA=;
        b=FZ2VUTJgjmVVv/HEmeYo1QGRzEuyYR+pcRBZTJZ8c2XXJ3729objG7BpSLur6fW88T
         782B0VnYZtnbm+C2YWU6vnjMWIyy6ovGNkz7/E5af9NG3y5rhcddP0S9WG5tuRHL6+P+
         x7f/L4kkQoXxDRAgMD5EhQf6gU/9kErI2id670kfzmfhDwihkng258CviTFi1TqByZme
         urxi6/cMpjHDk2LNmc5yIxLoFyWeU8rOHiuXk62+xyy+4SZR1PazKoKoRSmLy78ro668
         xfQncVTyEI79YLCPM/ihcURTrxLSrg4KsckLHVwTGJKDzp8EiIDGu4Nc7j/uD4nOs/P6
         S7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315044; x=1758919844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1hw5Yf/IClJ9aitO1VqOvHmT70CjzC/qs4xt3xLGUA=;
        b=ddD22J6dGdv5GI9RycbsGi371WeLhWOVm8dnWuiKdVZj4DF43enmPA0EX3cd825Ivo
         ofouYolgvxhDU+npoYAyWHMSQacimCdBvbN+WP1OpfdtcOKIPX5ezZtaS2DymTHW5eRu
         6aQnbF8DJNXoVfejA8Jz39brZRrO5VY5Q3zcPOQSigDbvApkdB+iWMvgAgqDPfoizK4+
         m6xrmkCsq+1kFW8HAJwHQ7V619nPwLFU3pGJVHV9FVxNwxQ+DIpJsO8SRTFzvRDQufzS
         8fbjV5twebnR3Zp+WOKsxEhE/77Rey5aoW8vmmX5pCNsD6Yqe0d128QGbyl2tyNB9V7n
         XTUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKKNT6ia+bTgU6V6PYkVbNh56Rx48pNfMqU0mpHOhFsjuAuJS68MaqgU7WVJ4OrpPdhe8oUyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QQPWfp24ks9wScvsiZZM0L8SLf6zjbOQ/xzLeTvfmDl+XPlu
	SaSTf5QxSZEBsltvN4g63bDxPh+qoiETYz4/QjO7onbRvOYpOt/zjNpUBXxQHpvdZkXE0kgiM1p
	UW9WUO1Xsu/Rj/U2tbWGaOfeJZ18GQ6wJC240voG8
X-Gm-Gg: ASbGncso7gLvuTsNo6HpMGU1cfs9mpTDp+CSRkJWuipqr9IUAJZAFFPGcJcQ7Gpnzfj
	lgt/NvK/Gaw0HqfSW79v9OwebLs2BO9+KrmDBhTQZd6ajwNN9ZjM+G+CeI3OGp/aOmob4GuvSEk
	lNS2sfL4OWB8fREcUYqZ53leRqfEJtVAW1XFbVG5JzEb2CjUw9TyVk2ZvS/LdyWvWR6aCQSW979
	OeBYA==
X-Google-Smtp-Source: AGHT+IE+mwlZltiF5uYDheIIJ3SojjuDmKfW5a+TJvMvMyqqDmk79WtQj2X89Nqi3dBdKT2RBHp0dPwBbwXwH933KtU=
X-Received: by 2002:ac8:5e54:0:b0:4b5:de12:4c34 with SMTP id
 d75a77b69052e-4c2217ad2ebmr31188121cf.75.1758315043759; Fri, 19 Sep 2025
 13:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com> <20250919083706.1863217-2-kuniyu@google.com>
In-Reply-To: <20250919083706.1863217-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 13:50:32 -0700
X-Gm-Features: AS18NWCt9VIiNo6V6P60aHN0ezXq9LvMDaQ4NrwOtO1xpXTgixfhnCloHhTP9-w
Message-ID: <CANn89iLCC=dg1iH7FaXXBP9pJa9ZPQMug2DOxGwd17T7=cNQhQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] tcp: Remove osk from __inet_hash() arg.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xuanqiang Luo <xuanqiang.luo@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> __inet_hash() is called from inet_hash() and inet6_hash with osk NULL.
>
> Let's remove the 2nd arg from __inet_hash().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

