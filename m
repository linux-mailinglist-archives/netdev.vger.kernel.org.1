Return-Path: <netdev+bounces-237811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAAC507EE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FBA3B0F71
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65101B87C9;
	Wed, 12 Nov 2025 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6TpItMZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUcDTRZ5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA71494DB
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921129; cv=none; b=bkxOjf+WaiNH2f+Elmlj/1/9hmlbClESKRong5s8t9j7oR7CYL8FYQ7Mxu0E4+vczCz9ybDvHEiKsq5ad2N2qyDYPOilLdfbde6JFYBRcYwv+6na2SKBwKzba5iw8ZOH59NCzIw6mryYPwLQej6+AeA9tX1SFXmuwKWsvhpcSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921129; c=relaxed/simple;
	bh=9IE8nIXiEWSBXXZ68CaiTh5yjeL/PHvQVU9lErYD0NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6RCx/hI1BQgIdMQl4pKr3N7MXrrakxSwZjn5pfQLTksKRGtniSOBEDv/FnskKtyf8mFIstKGZCIvTPLovhr510WkAh8TgmcFjTFt0mRRu500VQGurje1fd8xcgl1D855NxVdrWpfyvPQhv4RpFz3UQqH1p2oXMEDY5hxteXqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6TpItMZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUcDTRZ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762921126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eivNhWwruPOyJV5JjaV0gz6hcEE2lC6++XL21K7iprA=;
	b=K6TpItMZtQAWy1n+6H91AkWvUxDba/jBeb0t3CqELsV779UfjT3AXCqDIOBSh4S9Sp+Aip
	Sdy4JH1+nJFvbSKLzzglsDZshLGkM4Yh3AFVZqRKUzXv10E1sSEkJdk28zD+YkOfHmu2EP
	hvJ/QbyT1ZNkogJlYjI223Zg8yBlpS0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-5ka0c81MOaSg8eSZ6januQ-1; Tue, 11 Nov 2025 23:18:43 -0500
X-MC-Unique: 5ka0c81MOaSg8eSZ6januQ-1
X-Mimecast-MFC-AGG-ID: 5ka0c81MOaSg8eSZ6januQ_1762921123
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29846a9efa5so10543105ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762921123; x=1763525923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eivNhWwruPOyJV5JjaV0gz6hcEE2lC6++XL21K7iprA=;
        b=AUcDTRZ5xICj4tHLl0tP5MVkpDCgM1ovCbger3LmmmvinZ0iwBMRHWacEKP4b6+fqs
         7YiHJmnHFI7mGoQ5Jzatafv/2J4wSaIqyCBCn4pzFGUYtaPrWddbGCBgseQOYbUOqAeE
         rlf8NdWzISLWJe3loxi+3pFFRGCpYOa/T+zaRcv9zTaPAg1wJYE/Ir9T5kt1OTLdVLuQ
         ZOHkE4L+kvnSWoL+JTzkI1/sX1I6XnRxpQWgZ2sTmMtJ8eFAjlyw5a/WobrzipWZmpn5
         dGtdCTqOUkoKcuFpygWuI40n0UQe0SnbCYpJhuZLfuu3fMyzKtXVEu+L42y+56rYA1N+
         cvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921123; x=1763525923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eivNhWwruPOyJV5JjaV0gz6hcEE2lC6++XL21K7iprA=;
        b=VpvqCri5hRuxUmruWCu44I4jAflJQFqoqmm1zel4J1snYPrS1ti1CVkd5hLEzVCgrM
         IP60BCzOgDRK3ggzlH7UHSOlHIBy5URG4w0EKySkEZJ2NnlJLRAgqp5eOUXNOEP99WTX
         AFG8nykC0d1rJ0ac8kTvqun8LneENVZpd44ESUlLQfBDxnpTKt6KYsw4ANOu4IxDCfd5
         qT7KUFNMRUPasSLZW2kRYHDVOkctzYAxzOHAPDOsFwjtPXJcG0cgd+nJxkYWnnEeMTX7
         0uLr9DwgywIWwuMNnVdz+ezhUvaSO5lc8T2mZ/xZVapZgeA3Y4fqcHs5kLyojJbEZL9G
         lPkw==
X-Forwarded-Encrypted: i=1; AJvYcCVcuH4IGmJYMYZ6Wz+7CjbIWyjpIx7XZIhiUEz3B0AqEHAZnVEhOOXD84CoyQDLMFn4LchyI+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabYxAnKKy1zWAOC3tFdq9CNG1IdiVmcDc7WFA5EJn1zuW5R7z
	gwbSaG5pJPzerbYTaTrZxqv6ytSMDo0gvQVp+GzTIPWsVTud5U1ZN++fkPKjEJf74VjhlKsEBfc
	81bBvWSffqFiOY3XG+Nz+5kxXzCqV2B1yEowmDNLkWCKIStxDjPY9hkei8xPYYLcWP8guX4+R5Q
	iR7hHG5+g4XhstHtahUQ2xeFofc9Fmt/v4
X-Gm-Gg: ASbGncucr0RDaH1P1/KPEIH4Z9xZcLpzSkg9j/6qCF75hYd181MC5vqU/m30JPVu4Fj
	GPAMmi3+tzNPtj0IM6P3SJD3OQZE84Gr1N6Jql4Wk8i3cxIXO49kRv+r9PUICJnqd5H8xinXVzm
	LUi3hYQZlefUVWOi/1XL5AesoijNyE7bq6OzPqzRBbsFCT9W7qBjajLLw6
X-Received: by 2002:a17:902:da8f:b0:295:7b89:cb8f with SMTP id d9443c01a7336-2984ec7cd40mr23356095ad.0.1762921122797;
        Tue, 11 Nov 2025 20:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESILra4ewxIe3nH6ffWXaekvytV9hW/5+bzDzS8duVHEbPHdwG317ziSru+7icCcrZ0vO0wEgPXJaHoTKIbrg=
X-Received: by 2002:a17:902:da8f:b0:295:7b89:cb8f with SMTP id
 d9443c01a7336-2984ec7cd40mr23355825ad.0.1762921122401; Tue, 11 Nov 2025
 20:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com> <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
 <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
In-Reply-To: <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 12:18:30 +0800
X-Gm-Features: AWmQ_bmlbBUx93bV2lthjjocX_fnCnHJp0eUq6ipUa6aaey2HEa7eyVusHutp1E
Message-ID: <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Dan Jurgens <danielj@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:02=E2=80=AFAM Dan Jurgens <danielj@nvidia.com> w=
rote:
>
> On 11/11/25 7:00 PM, Jason Wang wrote:
> > On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> >>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> >>>       }
> >>>       vi->guest_offloads_capable =3D vi->guest_offloads;
> >>>
> >>> +     /* Initialize flow filters. Not supported is an acceptable and =
common
> >>> +      * return code
> >>> +      */
> >>> +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> >>> +     if (err && err !=3D -EOPNOTSUPP) {
> >>> +             rtnl_unlock();
> >>> +             goto free_unregister_netdev;
> >>
> >> I'm sorry for not noticing the following earlier, but it looks like th=
at
> >> the code could error out on ENOMEM even if the feature is not really
> >> supported,  when `cap_id_list` allocation fails, which in turn looks a
> >> bit bad, as the allocated chunk is not that small (32K if I read
> >> correctly).
> >>
> >> @Jason, @Micheal: WDYT?
> >
> > I agree. I think virtnet_ff_init() should be only called when the
> > feature is negotiated.
> >
> > Thanks
> >
>
> Are you suggesting we wait to call init until get/set_rxnfc is called? I
> don't like that idea. Probe is the right time to do feature discovery.

Nope I meant it might be better:

1) embed virtio_admin_cmd_query_cap_id_result in virtnet_info to avoid
dynamic allocation

Or

2) at least check if there's an adminq before trying to call virtnet_ff_ini=
t()?

Thanks

>
>
> >>
> >> /P
> >>
> >
>


