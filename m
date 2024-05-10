Return-Path: <netdev+bounces-95249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A38C1BAA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97D9285D5E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82048CF2;
	Fri, 10 May 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38gz8D87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEE3233
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300355; cv=none; b=RvUnkWtQEjENZ4h4n1hK6Enc1ZD0WQwWmtw78vWLfuEABLxP/W4C/6fMuhjjfc6RMPafZXG6pLjUWwnj0drIv4MkF3iR7nvAkvDQ5saCJHr/U/DAplfIlVBSF5TiuDxahyAyih6LjbBh+0s3Najt/J07aa2nrF3au1+soUZR/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300355; c=relaxed/simple;
	bh=0XTehdgnUAu0DffyW0Hg/Nc8qFCKbP9Br4UL88WMW8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4+XnG9xGc6IDUia7bwhiJvVyr6X98RMyyGxFqpfBHbWji5NHUUrUNBKQtp4D7pp14V2/uLZtwpuUj8oVyUpSmE1NMjrQZnwkkNvohL5U/WMwNsKFZ7nHIWvKnLWzKJoVf7JVyuM/2mPXXY/TeMEu4kU7RHof8R+FzgZwUAQsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38gz8D87; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so11698595e9.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300352; x=1715905152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDkg740tjVRPA7muszLKzifx+lB1m07et3SmwF5+y0o=;
        b=38gz8D87AKgDP25titIU0RdCBhX5qbc9/dtCMMNs0YHRdy9f7XQwahJ4mqJwTr0ilx
         QoVW4Idwe9XkVXtNDRsuMWNLXWvgkCdZemQDVL0ZJqlAkce2DTieFpT5mkyxGwMFsQOZ
         QmlvEtcJrAf/c4JL/2Qn3Z4bFRfoPojF6GZmqmHq5VnkykdPqWKnH/KuM1JliGfMypo/
         J8PK66W0AB+NANa9IJw5vbchEslM4SSHlRxxb9Ug81uhdEui5ESadoP3EM8xBTMoSzAQ
         QBsiebr37SFDVxW75PFUa8o2TRsyS+5KhR82VDbt5n+bYcKNm0ivkUMMm9YssMH6XS2f
         50OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300352; x=1715905152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDkg740tjVRPA7muszLKzifx+lB1m07et3SmwF5+y0o=;
        b=XsLtaqAZAmLhSMDCiWnsF9UsgBvZ7xYWLe+CdalJevZE3maWyhE/LZVcRp2nd1wMJW
         s3IAJCAAhUG4xHZPeGUyZp2rIO6IfcB1ekvbw+0AzeBLwKHaOYMr0NuT6mnWZtIGjgtO
         SdbsovNALoo2U77LuSFMHL3zXs2bRMhKh1bELqVdy3j5aftGVbyG7ExMTgm8T9/rlJuX
         wtwV0YN5yOLtcIZjA4kyHkbf5jgXF2NjczMMwEKUuuTWLT9xfh9YJaHceh2mtzCdIDMH
         OtE3HPwCQdKrQsk/FxWf9TH79tlALnEiMQCRvShyt0umGZUdqNlL3129YSmddBkXE7Lb
         ZDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpwCvi+hj+ODm0RnF+n0kKfmHR9Rgupy7w7lBu0bH6I03uN+Jk8sIZ+6PqOUkVzD3k3F3tloXK7PCr5pkmQjjzE1fjN5mU
X-Gm-Message-State: AOJu0YyhNH3JhamlOes6ARSavzPL6Gz69b40an3in03gIXVHionWj47x
	nS3F7vHwD733OArot6Sv0LNVsLvKjuCD1RpoqNI4pW8yy5kjai9fDVu+4H4NorUQ/U/IOi3+AMa
	OKFvT9pMVUwo6V28CT6aD4ptP9kBwtUHBHol/
X-Google-Smtp-Source: AGHT+IHoymcx9p+FVAYDd+bxTKN3u67a8ICRxPdR9lToM+b7TuJWleoDYOV7HKWLMYCbcEXS6FL9j7W1pp3wwxvc5ms=
X-Received: by 2002:a05:600c:4f42:b0:41e:8894:3f48 with SMTP id
 5b1f17b1804b1-41feac59d64mr8641395e9.27.1715300352187; Thu, 09 May 2024
 17:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507225945.1408516-6-ziweixiao@google.com> <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
In-Reply-To: <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 9 May 2024 17:19:00 -0700
Message-ID: <CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shailend Chand <shailend@google.com>, rushilg@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:09=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> =E2=80=A6
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> =E2=80=A6
> > +static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxn=
fc *cmd, u32 *rule_locs)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(netdev);
> > +     int err =3D 0;
> > +
> > +     dev_hold(netdev);
> > +     rtnl_unlock();
> =E2=80=A6
> > +out:
> > +     rtnl_lock();
> > +     dev_put(netdev);
> > +     return err;
> > +}
> =E2=80=A6
>
> How do you think about to increase the application of scope-based resourc=
e management
> at such source code places?
>
Is the suggestion to combine dev_hold(netdev) together with
rtnl_unlock()? If so, I think there might be different usages for
using rtnl_unlock. For example, some drivers will call rtnl_unlock
after dev_close(netdev). Please correct me if I'm wrong. Thank you!

> Regards,
> Markus

