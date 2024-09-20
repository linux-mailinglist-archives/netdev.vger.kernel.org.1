Return-Path: <netdev+bounces-129094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6897D6B0
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A1EB22066
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6717B50F;
	Fri, 20 Sep 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcES9w6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C117B4FF
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841490; cv=none; b=uih6uMajuKU+O8FKXxv07NrTG8hgJFZjg0O9xy0z4j2AahN8wrani3jWtBitxBV42VtiY8Gaz8gIFlP2r3SlOsDuP8Cuxn+bUWkF+FA1lv1xzDW8p7/5zW2FC0rXIa/nkIitQDamgQgO/3W6MlRrupPUFl/5KIahqMExx2iyFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841490; c=relaxed/simple;
	bh=GljccHyKuqWeHiqroiadC2JlWwPocgDHUuaMVtOWDrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqizDLbwgoRCVLw/4nfMo/m118tmTaYBWIlwRCw8aD3coP0wJxgfhoRpGvsXo9ZHMHNUWQ894kdxEAOPWJkhgYwYr6nnYXLdyvkjMgZv3jzEOyQxDSEsAM8ky2e6crS/pc26HJuscrlWHa1VMVDw3rSeZ+rF+QZ1MyLf1dcMJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcES9w6Q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so2702624a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726841487; x=1727446287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkvvAINKnp4gHKhBNwjSA5RsRysHIe7Gdpu4Y1Gmlig=;
        b=HcES9w6QH6UeUXh5YDpD7bOS+GwHGfAn2GRxnJv2ZyViwfkCUsMf8AbHIZ45V0jOf9
         jmrqSWe4Wt1dsWR/XrL4w9gK/fshMWIA8tlopollI0RZh0paNcnUlUgsAHAQwH19IvOr
         HHw1X6mbuDb7YOUKYxZBnHPlQOS7sVnrpd7QXsWKT6eic+pY29YXJ4SSxWpXalWzUqnG
         CVnnpagNA6a6KBA97jM1itOB3mV19amK6Bjhwxf49JgYBqKrV4PchGJNNfirmP+QGvyX
         Yxp3gJye4OCHpxu4WQh1GXiK1f1ej/CqyOG9qy5WuUiWj1spNEdXkv68/saQvKFDK5d0
         ArIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841487; x=1727446287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkvvAINKnp4gHKhBNwjSA5RsRysHIe7Gdpu4Y1Gmlig=;
        b=YkfyQtqqxpwdi8DUMYQA95qaLzXBOrVzR0boRx5mwsLa9s/Fg4va0v6xohcntggFsY
         9IKrQ2IyNOpoF0nakYfZqJaoGCFP8TeezSTCBAMJclsGi/+hBhthPTduCO9z7N4dzLy5
         QL87xfBE8oRdvk4rJ6jjoEE/UHiBDn+RVkNsPojUzSG4xr7jfapBOHok0FHyEa9LYuXB
         hi8Vw613e/UFMn57qFqdTudD0d/rJKlSOR+fRxlPa3JgBPecY/1zo/wCF/GLGEKacpHb
         3FacQCX5QfEud1u+HBtSaVwEEOhoKVURNhQNfROIYMPdB/yssmpXsAc/sX/cj+cX3vmF
         cjHA==
X-Forwarded-Encrypted: i=1; AJvYcCXGEnL/ih4cE7ImPQGJjjiqSzeZSEGL8lzJxk+9hEzemmnLq4RADeQL9zjz4cZa2fSH/ajm3Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxqRSVWwuCCVAb+3giH1uG11OShwEecSUJw2P7eoTXXExe+eJ
	nN6zYKVYcLDkM6P/xX+XkCZ8O4bPkBArGe3h36fHwo99PGYGW5Vqg7ojOVwbmb/mbH+v5MHnxat
	ofoqFNJU0hJ5+e/m0LLvbhB0KphsYTZxwyPS5
X-Google-Smtp-Source: AGHT+IFB3W9di4StZxBvli8zuI3/dd+Y8297X0YH50N4LsVL18C6hp6ei3clTAIpNP3lLpt2MId9OxjATUCGVnN8Pr0=
X-Received: by 2002:a05:6402:40c8:b0:5c0:ab6f:652a with SMTP id
 4fb4d7f45d1cf-5c464663952mr2393809a12.3.1726841486797; Fri, 20 Sep 2024
 07:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2A17499A4FFA4D830F7D2F72A95A4ADAB308@qq.com> <20240920093539.GA8490@breakpoint.cc>
In-Reply-To: <20240920093539.GA8490@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Sep 2024 16:11:13 +0200
Message-ID: <CANn89i+E4RP+gJghHZujmKUJbCgYY_L20ssVmvmRUT4a8FvunQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix potential RCU dereference issue in tcp_assign_congestion_control
To: Florian Westphal <fw@strlen.de>
Cc: Jiawei Ye <jiawei.ye@foxmail.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 11:35=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> > In the `tcp_assign_congestion_control` function, the `ca->flags` is
> > accessed after the RCU read-side critical section is unlocked. Accordin=
g
> > to RCU usage rules, this is illegal. Reusing this pointer can lead to
> > unpredictable behavior, including accessing memory that has been update=
d
> > or causing use-after-free issues.
> >
> > This possible bug was identified using a static analysis tool developed
> > by myself, specifically designed to detect RCU-related issues.
> >
> > To resolve this issue, the `rcu_read_unlock` call has been moved to the
> > end of the function.
> >
> > Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> > ---
> > In another part of the file, `tcp_set_congestion_control` calls
> > `tcp_reinit_congestion_control`, ensuring that the congestion control
> > reinitialization process is protected by RCU. The
> > `tcp_reinit_congestion_control` function contains operations almost
> > identical to those in `tcp_assign_congestion_control`, but the former
> > operates under full RCU protection, whereas the latter is only partiall=
y
> > protected. The differing protection strategies between the two may
> > warrant further unification.
> > ---
> >  net/ipv4/tcp_cong.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > index 0306d257fa64..356a59d316e3 100644
> > --- a/net/ipv4/tcp_cong.c
> > +++ b/net/ipv4/tcp_cong.c
> > @@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct sock *s=
k)
> >       if (unlikely(!bpf_try_module_get(ca, ca->owner)))
> >               ca =3D &tcp_reno;
>
> After this, ca either has module refcount incremented, so it can't
> go away anymore, or reno fallback was enabled (always bultin).
>
> >       icsk->icsk_ca_ops =3D ca;
> > -     rcu_read_unlock();
>
> Therefore its ok to rcu unlock here.

I agree, there is no bug here.

Jiawei Ye, I guess your static analysis tool is not ready yet.

