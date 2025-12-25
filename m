Return-Path: <netdev+bounces-246032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A29CDD33D
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 03:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B53F73019B77
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 02:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395223FC54;
	Thu, 25 Dec 2025 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUAXBxL/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSzMxfdM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7646238176
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766628823; cv=none; b=hu3Tfo+vAfystY7Y+s2jNbIdnU74F8nNKcX6CD8CPGxeYhRB6yS+O6cd065B/dDGNY7nVgTnfh7CuLiM4droEqPTFflWzTlxZFN/KqhvwfMN68DWzfvne8rSJx0KJvk6zzzj7nqFJCF2ii1E1jmQwxA3FEtR26iW6PEyrny2T48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766628823; c=relaxed/simple;
	bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4dG1C7MBB+a+moPBhncoI9EBFV0n4Nf8xVEt9tIturFbCJCWm5o6mfaGY2a8G8oalUgXYGfhV9sWONi3Cx+A1d8PN0wEqWQIupRkzyYt6AETgDXbJ3w5XTrvruAF0but7r1f79azK6IPgTkM1/bpxDLI6/MMpFIPBc+0pN5Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUAXBxL/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSzMxfdM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766628819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
	b=QUAXBxL/D/x/8Nm5E36UZfbqhOudhhUrrT+WPzF4bDSb3+3uSg15pScX3SUjGNjmn+FHNy
	DbpYy7wkY20PGJRQcgEFsHFbwmuY16HIMFLqx+IbwG8mrXoZU3kgO3g2mqJdmLg4U8l2Z9
	9xH1iPQZpEyDIBAwkjKUWHDVNWkSB0g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-AroNlCUoNBuL0dooMJTYhw-1; Wed, 24 Dec 2025 21:13:38 -0500
X-MC-Unique: AroNlCUoNBuL0dooMJTYhw-1
X-Mimecast-MFC-AGG-ID: AroNlCUoNBuL0dooMJTYhw_1766628817
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso6353813a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 18:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766628817; x=1767233617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
        b=JSzMxfdMJyuCsS2OBbrEAl+zrz6JqtaRczEID9eoCqvzYVhaDJwxX7yolyRTjueKSE
         gGhoKuN3bk1fehz3M7+kC/9kpUNlt3abGkxiVM7LPrWRsrYptYLfrgcp75gIPTNtgxF0
         OBe1sAw4BfegBgPc3GGLiKUxWdsMGB1CR3DZOqos2cB1D855fGBiRP5e/SFe8T6kb3z4
         FA0ofUTRi1m1Q232GXnMWgUGuqYfdaWfrJTsNpfWZdMsO1ZmgHrc7MXtZ7bj389jHGdA
         5PlR1YrvRoBzyG1qYkPQtvG9MoQYky0+gtPmHW7KCzEZnS7bEOaiguWRakghW/hqG93k
         KmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766628817; x=1767233617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
        b=f/rIFw+tVGn3D4He/sN76dDkx4zz+UWJCVdKA1Ra7GXp/DuxzvzjCRaQrMCJhdhX5w
         fY3TJGrk9mBMp7fOtG9i+8jK1oCTOJL5Ha4BOhUgcdoM9J1VfzsbsoidzNKYY4z4v+NB
         elP/y+MWG98kpurG2viAjI+IzPttcu6tnnqZfg/+Fa00fXyDAeHbkr+c6Hn5ka91mRgo
         ZDhLuH9HXjraFs45snjgxYlm3bLmVvzGXGQMgYc4hbIMV/HkCsz1SeYeisoSMnuH08Jp
         WrkzepjvP5MrjSSGYDIhoPnB75RLzce04ECWxXAai4pnryI8OkW5FuAol46SCMIG3vAt
         FOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3GyEPduDCY/XHgEmRpE7gmP5ClORpqAWqfV9uC8t3Jwp2b0zre8R1wjgys0utaO57T2kxws0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7b4cIaIdz48XkFb0S1HNWpS9sUWCt9xOi1yJykRnBmuwq3NIn
	JgvuWcOXNq+bw8xWrUkTI6M52P2tjfsnQN8MN4uUTaBrM1/YESaCNMkr4z/8mXVHcMCm1kv+xNK
	uu7wQJ5ux6xaOl2KN/AMhqGPBEQgflnMlY5WyEDLvgE7rRxgxPPZQfqD28KPN5KQfUu+YOIvJ4U
	3Sd31rZO2oDs9VquCfuspQnMqTfvlMuuRR
X-Gm-Gg: AY/fxX5yWIG5i2gGrqa6WlMrlN3am/RHl+ZH5xBz/gRFbc97Wnzd3AI0J3h2+1MnkEG
	HB8CdhEZQrbbeJm8uC9jK/l5TB3bjnKJrna6bYX3boBCivMXL2vZekNc4OjegpKxuR9mNFCs/zb
	NGeKyS5VAlqHE+lA4aJAw5wZQUdbupkqynuD7Z51SoAeAjQ5JSCWGsc61dhq0YQnpIxr30
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id 98e67ed59e1d1-34e71d80c4bmr18119983a91.5.1766628816953;
        Wed, 24 Dec 2025 18:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwhbsMVHrIOb+o/clMZRBZzzVHUxqhhpyOgjv8QLYkGMTunA2LZlvhWcPpsC0hOAXEzKg6bxSfXCXXoKtYoEA=
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id
 98e67ed59e1d1-34e71d80c4bmr18119967a91.5.1766628816541; Wed, 24 Dec 2025
 18:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218091050.55047-1-15927021679@163.com> <CACGkMEvbrF=g0_yedXKsccVN6vmfm+oQVbRkR1PGtQgFHH+v3g@mail.gmail.com>
 <3a4733b.8bcf.19b4fb2b303.Coremail.15927021679@163.com>
In-Reply-To: <3a4733b.8bcf.19b4fb2b303.Coremail.15927021679@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 10:13:25 +0800
X-Gm-Features: AQt7F2qv14pEjpotcQVKXINUs_y7jmmFmHc1_NfnTrxSaTXcN2AvZ9sBp2_RjGE
Message-ID: <CACGkMEtZUpTG5fG5+JvJw=4RGDo89xoXQjkLyLnWVXHx1gUW7g@mail.gmail.com>
Subject: Re: Re: Implement initial driver for virtio-RDMA device(kernel)
To: =?UTF-8?B?54aK5Lyf5rCR?= <15927021679@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
	David Marchand <david.marchand@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Kevin Traynor <ktraynor@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xueming Li <xuemingl@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Chenbo Xia <chenbox@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 5:32=E2=80=AFPM =E7=86=8A=E4=BC=9F=E6=B0=91 <159270=
21679@163.com> wrote:
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> At 2025-12-23 09:16:40, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Thu, Dec 18, 2025 at 5:11=E2=80=AFPM Xiong Weimin <15927021679@163.co=
m> wrote:
> >>
> >> Hi all,
> >>
> >> This testing instructions aims to introduce an emulating a soft ROCE
> >> device with normal NIC(no RDMA), we have finished a vhost-user RDMA
> >> device demo, which can work with RDMA features such as CM, QP type of
> >> UC/UD and so on.
> >>
> >
> >I think we need
> >
> >1) to know the difference between this and [1]
> >2) the spec patch
> >
> >Thanks
> >
>
> >[1] https://yhbt.net/lore/virtio-dev/CACycT3sShxOR41Kk1znxC7Mpw73N0LAP66=
cC3-iqeS_jp8trvw@mail.gmail.com/T/#m0602ee71de0fe389671cbd81242b5f3ceeab010=
1
>
>
> Sorry, I can't access this webpage link. Is there another way to view it?

How about this?

https://lore.kernel.org/virtio-comment/20220511095900.343-1-xieyongji@byted=
ance.com/

Thanks


