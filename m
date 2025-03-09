Return-Path: <netdev+bounces-173377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71423A588AE
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91ADF3A92D9
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26821E08D;
	Sun,  9 Mar 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quyVVZ/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BD1A3035
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557446; cv=none; b=SxAIHqiM6W8sq5HdWY+ep7pUCWktarmSs3iDQp0UqqJtGXQaDgdYeXrUjdKfn04BeuRhDI39rcepQohZWTZo7JxMv4l48t3VkRRslvGRExnT7dB2j+iY9ypYC6GqeBB3NAxCBzB//x+xQ3PVM3VBVHQCht5uBoYIPIf3mrOShAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557446; c=relaxed/simple;
	bh=IOO3vW5DRrzxB4mImWuN0bc3+CxEqFoHgR64CmSjBn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGjwe0WjfnieeC0pRlIbs6LDKKFiC8I0oCEag/FIvJUAeFrCH8YxUVlRtBnHwWtU3BYXggAlYvZzNtwF8PdYoXtYr0CmeLP+xVnhHrbmAKyQOm+1YGW12uvPM1X1w3CuhJTS1wg+1o1QwzGw5wUqFWqWyCcha/rbwLOVQu4nyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quyVVZ/s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242aca53efso152815ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741557444; x=1742162244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2wudePMKO0a7WgcqR4nia6eVNU+3LQ8sE3S2FURcRY=;
        b=quyVVZ/sTESWfkJT8fIlfwmAjnwee4s2uzpgVkdw0ISkG4tnHV6tkLBOCUS1hWcku6
         gTuVkMB/DqhfIAFjGObwqUa9Hy2yOkrj2/aPDfvfDA6ts6qjUMErLsYKL+pMaBb073QE
         vSTi+5W9KjGWORyoo0QgXu5kCeQlwhp+zHZK+zzXwdl07sRhPUKxNTrzjtUNQDo+1pmC
         4Zv64TzKNtVCZkqm6KzKI/iw7h3H8UH7J+0ZrOytEn3kjbf0T5Gd9CDNQW+geq3YWIOl
         WZgpMVLhHbHnuWdQGlICOJIBH9D6lvli1dUsQ/QBpftUxriL6F9ftCaYZH9IRW4M2Bn4
         Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557444; x=1742162244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2wudePMKO0a7WgcqR4nia6eVNU+3LQ8sE3S2FURcRY=;
        b=hnsOwB9LndWxdQaNEx0sol6DyNQf+BmE/ucKPRJjk/W3JuGPDKNnDItgxFEcaEvanr
         +NJpIerdijvTVIXdm1K3ZJF2bwOZ9iOsGcvOV4vlEf7faV4Sa40sTgmgHurvd79VD//9
         2xBjK9KLzZVSaCXFjnfTusCsBAQ+HlMKt6P6l7EDE20PBg09ljIjVicljPq6hAmVusyu
         CyvPixw9EK4c6f+0m2kScL57lZCvE6ezBWv7Fa1Y9xx9xeSRy/pdL4YSW8OniWu2Wt84
         i5TVUFiR+m6jkEiJKqOzlrVbs85tgCNntDxkjAi0u7NhrYZshfqRafWb8esvWA432Iun
         UOvA==
X-Forwarded-Encrypted: i=1; AJvYcCW+O+c79b4SzOGPPZoV/XoMGWvdKqify48VXNnESeUuHOKa+Ji8A8qYT6QAbzeiAI4sl8663cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEyiyGYctJmx/o2wmRt1JrAe+AkQ3obEWM8kJSetYiWvgjLC+
	giExRfg1JCkYjKI+TuIZ57wZJ3V1/W2eJ0kmdAPh+RpXiZqm5pS8zqazOK2HHPbF/m+cyJMtT2N
	n1G/MaACqnoSgYzy7ubJdmpv4CxpEnH5fnNxhb7oeByKXUYVJnhxB
X-Gm-Gg: ASbGncshp34tzH1CX+Lh9uDz3LwZd+I021nnJ/rVM47aFjZHzS8zYCskOBPGLOs5gTC
	PnBIEVkHrE9feTYIg73lnr2b9U1woH/JFbYRrG17NIDCwRGhoFQTNSQTstyxkzbJQcbTvk0NcpA
	zRQeyeWgA4OI5q2IapgUSfTwUJ6EE=
X-Google-Smtp-Source: AGHT+IERm+N9tbCUGGJ+MXH4US5kbkAUzDlwr9J2QPgizF7Pb9AOwPC7JLew53ElFzF260gr1QRtJjUsfw1DEzN1XTQ=
X-Received: by 2002:a17:903:22cf:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-22540e5a369mr2492205ad.10.1741557443599; Sun, 09 Mar 2025
 14:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307155725.219009-1-sdf@fomichev.me> <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org> <Z8uEiRW91GdYI7sL@mini-arch>
In-Reply-To: <Z8uEiRW91GdYI7sL@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 14:57:09 -0700
X-Gm-Features: AQ5f1JqrzUpfGFvobvIHXzlf0odrxpBbx4xi7Bhn9Q73KD7xZh-f11MEcgp2jP4
Message-ID: <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, 
	dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:43=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 03/07, Jakub Kicinski wrote:
> > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index a219be90c739..8acdeeae24e7 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >             goto err_genlmsg_free;
> > >     }
> > >
> > > +   mutex_lock(&priv->lock);
> > >     rtnl_lock();
> > >
> > >     netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> > > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >     net_devmem_unbind_dmabuf(binding);
> > >  err_unlock:
> > >     rtnl_unlock();
> > > +   mutex_unlock(&priv->lock);
> > >  err_genlmsg_free:
> > >     nlmsg_free(rsp);
> > >     return err;
> >
> > I think you're missing an unlock before successful return here no?
>
> Yes, thanks! :-( I have tested some of this code with Mina's latest TX + =
my
> loopback mode, but it doesn't have any RX tests.. Will try to hack
> something together to run RX bind before I repost.

Is the existing RX test not working for you?

Also running `./ncdevmem` manually on a driver you have that supports
devmem will test the binding patch.

I wonder if we can change list_head to xarray, which manages its own
locking, instead of list_head plus manual locking. Just an idea, I
don't have a strong preference here. It may be annoying that xarray do
lookups by an index, so we have to store the index somewhere. But if
all we do here is add to the xarray and later loop over it to unbind
elements, we don't need to store the indexes anywhere.

--
Thanks,
Mina

