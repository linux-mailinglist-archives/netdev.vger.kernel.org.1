Return-Path: <netdev+bounces-236071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8589C3839E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682B93B8A90
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274812F12C5;
	Wed,  5 Nov 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4zLD8SS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAC2DF6EA
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382694; cv=none; b=tQ6BLbU+f07wXMfGhponLOz72bwlt98b9rBbR3pc2hU3n04pk0eaQKQm3uNs/MGEEHkdEyWS6Q7Jjl/gaWF36vP99a69mfkTUAPqhTEcGer1m91z6J+1DGO3guthomtJzJ6sp7L3KhZO2jjlPd0U0YrxJ3q0SLKWRIgymdbcU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382694; c=relaxed/simple;
	bh=Rfcd32YdQrSKTTIJhfyQ2q3eg0O2ceic4Me1fRNtgcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLymf/iq6iS0r8cYjz85SiEiza3fvNs65bxhu3daJ2H8+uKyCN1Co3fKUE7XMUhhObtK+543slqLI8XwAA8uWnh5rBBo7LKji7KaKb+XGnSe5BIfppcLz1aFCreF6x21cPN5W91vq0WStBRxIZ30OGA+Fo3vsnZupqyfAKotwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4zLD8SS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-587bdad8919so3336e87.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762382690; x=1762987490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgIOheg/lLalcENSGd1F4iLfzJbxxpBaQERuk+3AcBE=;
        b=B4zLD8SS5Rm5amdzt/juFBvG8AnGemurx1bS2ROumoKw8D2k5vyPLN75/gp5/wwmMd
         60UmdLdv2XG5CBkqap7BeOnNp5ymrvvrpMK4uhzwNEyeBgbXW1XeD/jjDwFqxAROXIZB
         2t9D5iLOPplrRU5JYPPayILuszAOPmnbPswS2aINNlWiC7GCR0fwOC7DtAp4wUOl+BfL
         S4QmtiMxBea+U+qH3UEsSAZcF7i7Ghf0GsSSoJunSZk//J4Mz7c8futC7xhF38lUC527
         GVJ1ObwrlTOoSjP3ATYJsggo8tLGyGfAj/6DbAIblOvLd/7Hmgfc8MMi4sGS57hWvtO8
         hq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382690; x=1762987490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgIOheg/lLalcENSGd1F4iLfzJbxxpBaQERuk+3AcBE=;
        b=sDww6trA4X7WamDhKf6QITS0qmzpc5DrtL5OM3fFZkrFXLtmJgufpVxbHi5bh0/Ub4
         qP3r6eW4fuEAmTa3t6h1+Ff9fSyTBX4HS0OE98GpwD/SgASuYj5FQcIwIH5kxEr/NLYJ
         Z0wG1jHA6RCtbbIjPa2BS7agaPXorU3UWbcnSjedEc4Rygagel8jivUaXfw29r5DJdS1
         f2eeLqkx255pOdzXMu0QRhA4IZgyG/VBVcIg6kkOBfveAGVXY67NG/yFJXyqO8ji19Mi
         8muPLPrsTsvl7LCZOCNIcXaGQBlkFP4temrG648RvrtFxhRVbH9llDiBg7VqN0i2Z0hZ
         pZNg==
X-Gm-Message-State: AOJu0YyVd+6s4i7jexHPQySkOxuWj/oz/CR8vNHaok6oeTmSkLb6K/b/
	nIvKNb2l+ESP5tmS6PVqA8NWZiJYuanq07Mxwn6fZjK9FEn8tVNN38od5yUjYObqlyE/IWOb6lI
	rXXUH1VbYaJf0lkcucLJReb9JhnqHeHBCvWHhDv5Z
X-Gm-Gg: ASbGncsUQN3gc2YQnk4PAcWkJOBp/jcC61VpuFS9IhNy8w4z//0U14TV70RAqaJyZ16
	j9/e7O598uI3ha3WIAMt9SRj+Hdt3nkIIZoDcyUstLSD1gGC1dBPGL6v31nJihPC4g7ZkxLRHxW
	wlJ1ZPDp/vQ32BZLFx34may1XsURErMA6xv+4VVCcMWnuMZFvszWpazOAb6d5HuN10gPcPI8+7e
	xEgDQuoZ8SXXbv9oBT2YF/QKWzizig7dLWKrK4oFsTjEmIQAASl1VHCbeefaCV5TQMe9AXiTk3I
	hNfKQbc5mdeho11bdOMw3UPqqw==
X-Google-Smtp-Source: AGHT+IEwNDS7oXmRblTAtZDOw4CbfUPumRYiH6vlEKG5nMLy9B3pflCGWRq0205gorfW+S/l+mmsLnn9/oI8vbZ/kWw=
X-Received: by 2002:a05:6512:78a:b0:594:33e9:a7fa with SMTP id
 2adb3069b0e04-5944c837b2cmr37142e87.7.1762382690195; Wed, 05 Nov 2025
 14:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <fa6ace55-fb4a-4275-bcd0-c733a788d2b9@kernel.org>
In-Reply-To: <fa6ace55-fb4a-4275-bcd0-c733a788d2b9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 14:44:37 -0800
X-Gm-Features: AWmQ_bnGBOuR1d1ffOXzQatkX0qufbklhADtkuZMiEvw53WQAzxhm25wVfneE90
Message-ID: <CAHS8izP3phG1FzAztGM-6P4gXopBGdNEXGODuvPasU+DH+7reQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:58=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 05/11/2025 21.07, Mina Almasry wrote:
> > diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/dr=
ivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > index 0e2b703c673a..f63ffdd3b3ba 100644
> > --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > @@ -8,6 +8,8 @@
> >   #include "gve.h"
> >   #include "gve_utils.h"
> >
> > +#include "net/netdev_queues.h"
> > +
>
> Shouldn't this be with "<net/netdev_queues.h>" ?
>

Yes, will do.

> And why include this and not net/page_pool/types.h that you just
> modified in previous patch?
>

netdev_queues.h is actually for netif_rxq_has_unreadable_mp. I did
indeed forget to explicitly include net/page_pool/types.h for the
PAGE_POOL_MAX_RING_SIZE. Will also do in v2.

--=20
Thanks,
Mina

