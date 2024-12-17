Return-Path: <netdev+bounces-152701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183D9F56E1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171B27A2E04
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3B1F8F19;
	Tue, 17 Dec 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gh6eMMS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC41F8F04
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463677; cv=none; b=RF0OB00OFKbf+7GEJ4kzprQaggVFa/29YOUXfRxLeC1M98NNFzPfgZxkSMhVbfJBdpei8z4JiGG+U5oH5QE80P9ndTt6JnTT7lz9Jxh/fBxToYDEMlPD3QCo9IO6TT3HzMfQUDE775c32zHVr0OMRkBo1IJf7W+xrVdei6f8Fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463677; c=relaxed/simple;
	bh=GcHsa9SwtAURqsudps8fdJc5GEP0IcsGTswOKdl9sMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdoaWglXJc1+GIYfrJkahtx0W8ydD2zr/2F9k9etamzvrGH//RcfmzVcBwVTb9zuDc9BjKnVc82eK5DqVKtKtEbJHwvkHEwTMpcxTF0WmwXm5XW1IfcvYMmnwdN1e5mUFFh51g8i8T3ZfveVmjq4sQpQTwXff4pslUa2GyDKrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gh6eMMS0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467abce2ef9so42131cf.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734463675; x=1735068475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMfmuLpatjPgkeRV/3Vx6kZdgTCq1HzVzde45FIVRGA=;
        b=gh6eMMS0iRIyBHJJ47Vl0Sxfz4Kcce91Xa1nndpnoPjUTM1pU1ABJeCvX0ET9OW5Z9
         0jzGROarLQDJP46bihloOvWgvvyAq0YW8As1VAkzgW7XFm/41RYzS/BTUzHVIYisuymm
         VlOMqkvoJIBmSmk/++MtAOMiyYHnwPMbNoeYPBItq865xeaEvoFvHMpYceIbkxc2yJA2
         5gpjWPaBPnBkigLRqIapgzp++zC3GGZLK2ZrQfAa5YiDK+U1K9ASUEnS1IH7rbPXZyBB
         6NkEvnfLapHN4+YUMUI9YjDx3uFQk1ZVne5sa0faOk8a8sGVmZmymBcY4DMapbqbBV65
         1iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734463675; x=1735068475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMfmuLpatjPgkeRV/3Vx6kZdgTCq1HzVzde45FIVRGA=;
        b=OfmzoGs96bY8OlA3g2JaXhOA/zag+qwV8muWC/RNlzstRpVReotF78pk20vmFNYCkk
         FtEMUXkzmmz35Vs4G2AZ1Gr9zujD0aAC2onLv42MC/gyuW/Ss2kBgcj4kAe1Uvh80lk1
         qq3SpO0ezmLzPs7uBtNZxcwaemBQbRWuRMO3Vd0vHqP/AN9tzoiOb0o3i29Z5HFeBmE5
         6jf11aEGexHIFxBuDF2vGCecQ36HrY02Sl8pYiJ71Fdq0BU4xcFu6/SWeU4/k7YJ2bT0
         /UrGMbYs+rpx6PrAPmdFriYGol/QQDk24RbkrMroWJaAL+hYc49d7y6hbzj3oJQk/Km6
         gXmA==
X-Gm-Message-State: AOJu0YzAcQ/w9znGpeFfwAI3x6r33I8SAK2IQb5yAGrjw5YF6XROcYU8
	AdQrz0QD2np6N3aoavH0fxKzNQZzVKcIWErt9I6+gOHl1bmo9UZhaHz0FWF0U7CusIvgjC85BFd
	h91HG+C1wlODzvyckhlXjk8xcmfZkDxM5xPN3
X-Gm-Gg: ASbGnctBLlL2+RDMTyU9nSnuk1amXbCqSiZdce+td9LH+m/WAJOobbQmlqWoV58qRtr
	EB36wYlj7zcJQlwC3VOvTXX3cuX5m82bkndA+k5NjKdglPnXPorVb7RbKNfcbzbWK7fOc
X-Google-Smtp-Source: AGHT+IF8bC7h94TmuZb823CnkSdBd580iuNZYNRH/Tz9n74u0sXk8cAyPQbFO6c80ZFajgdCusnxzR8p+3c2zO/VZpc=
X-Received: by 2002:ac8:5a45:0:b0:461:67d8:1f50 with SMTP id
 d75a77b69052e-46908e9cf46mr3041cf.4.1734463675125; Tue, 17 Dec 2024 11:27:55
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
 <20241211212033.1684197-6-almasrymina@google.com> <b706bede-3ca0-4011-8b42-a47e3d3fa418@amd.com>
In-Reply-To: <b706bede-3ca0-4011-8b42-a47e3d3fa418@amd.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Dec 2024 11:27:42 -0800
Message-ID: <CAHS8izMw4m7Bv5zD2eT2MwFzk0QGFx1gkPu6wig7Uk__tpjW9g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: Document netmem driver support
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:58=E2=80=AFPM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
> > +
> > +Driver support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. The driver must support page_pool. The driver must not do its own r=
ecycling
> > +   on top of page_pool.
> > +
> > +2. The driver must support the tcp-data-split ethtool option.
> > +
> > +3. The driver must use the page_pool netmem APIs. The netmem APIs are
> > +   currently 1-to-1 correspond with page APIs. Conversion to netmem sh=
ould be
> > +   achievable by switching the page APIs to netmem APIs and tracking m=
emory via
> > +   netmem_refs in the driver rather than struct page * :
> > +
> > +   - page_pool_alloc -> page_pool_alloc_netmem
> > +   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
> > +   - page_pool_put_page -> page_pool_put_netmem
> > +
> > +   Not all page APIs have netmem equivalents at the moment. If your dr=
iver
> > +   relies on a missing netmem API, feel free to add and propose to net=
dev@ or
> > +   reach out to almasrymina@google.com for help adding the netmem API.
>
> You may want to replace your name with "the maintainers" and let the
> MAINTAINERS file keep track of who currently takes care of netmem
> things, rather than risk this email getting stale and forgotten.
>

If it's OK with you, I'll change this to "the maintainers and/or
almasrymina@google.com".

Reasoning is that currently Jakub really has reviewed all the netmem
stuff very closely, and I'm hesitant to practically point to him to
all future netmem questions or issues, especially since I can help
with all the low hanging fruit. I don't currently show up in the
maintainers file, and unless called for there is no entry for netmem
maintenance. Wording the docs like this gives me the chance to help
with some of the low hanging fruit without going so far as to add
myself to maintainers.

If the email does go stale we can always update it and if there
becomes a dedicated entry in MAINTAINERS for netmem we can always
remove this.

Will address all the other points, thanks!

--=20
Thanks,
Mina

