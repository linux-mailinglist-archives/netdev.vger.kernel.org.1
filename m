Return-Path: <netdev+bounces-87256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48CE8A2553
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B381C211FC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD278C13;
	Fri, 12 Apr 2024 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkGqkjbH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F18C15
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897295; cv=none; b=dBotvK5kSkW8kiQUOKLzvIU7SW9/7c2NyaXS4WL6n65Vegxo71F6ZszSyGUHsd9QnoQp9DCUc0jy9tmCRBy9Q4dpfZamABm3XC1Ue5aDHtuTlM+2kQ/GmYUwH/YndW6K8ZmpJ3uhor2LEqeTAdNIxGX9sQxt2+R7TA73dVTCAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897295; c=relaxed/simple;
	bh=uw8Z855wH7YK9MlCNxEU1bYKZyaNxkchOp1vq3s0Kds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGSW7RGVwRpJ9c7ZuSpTVTTG1bgIbqWO3VnbJC4Frw3LGJUniOPS2ClORWNaLqAW5pYJsxKSFrRtefF83nKOPZMV/Y0/s1eVJrZ4XCA9vpLMSp+lfxfAkwAkPuzKiDnVJaYlT6CljQHE/DXoE/3PB0vSegVLSCbDBTDW3bnNZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkGqkjbH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712897292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vawxXXfazD0po5SWizFrmLAzOPEunL08S7b5tc+QC5o=;
	b=UkGqkjbHfZkATiaj/0ORLXDWrJN4RVANowdk5636/Q+34IzofUk/XoJCr1m/wHlXdJbej9
	HvrDfa4ozRYPwFHZYKBVPog65o640qiCg+2QkqINlFJ+/gYZ2n3aEjClIv9sIXmnUiIGjc
	c+JN7KAS0eO8Ts5WtQpGJLtSOuN84qc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-hbWhKfXYMKqAwuSk7zmIeQ-1; Fri, 12 Apr 2024 00:48:09 -0400
X-MC-Unique: hbWhKfXYMKqAwuSk7zmIeQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed58bc3d23so376935b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712897288; x=1713502088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vawxXXfazD0po5SWizFrmLAzOPEunL08S7b5tc+QC5o=;
        b=UYNZz9avvX5PUVz7axwKMHR6GKiojsqOSI1x06V+rmD41qxx3y6AQCEU4Z1Nr4gnZ/
         S0MXUhOI8gUo07Fc6R4tmxkFCL99fM+ujunC+3W7tvqlRs4vEgxpy+ilJguXCJgpACpH
         1qsrYCKnhoDZ1xxMfPoPmM3JGb2IxaHVfedYWnsu8JqerGVPaqUUomG0J0Z5ekjmki71
         HK05b9W5FHWJhbEXjIa37ytfOnIYPApJFWvF/jUj6brQtZfdinELFRykXoVuFxjgdFKu
         kIB4Wm2AoTiFEethvMhQuF7LmtTy1CLV2mN8E2qg4L7cOoZAXD9Alih2UKL8aw/Myepa
         qUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTgounM6lIYHfoAApKwk3lIfjuh4hent68aGc65CxTA9dmMiTHVVtXGl9WIFp3EQRLy8ko3B/El7mfx6Mulyj6sBKLJiU5
X-Gm-Message-State: AOJu0YzxakljzD4wfs1K71oSMeqDFUVsmv41OlUhK2/4FZFy2JmApN28
	HpQp3e5UqYrgWcdGYI2hS+wAlTjH3VVjqws8tk2TfA6TLigCa8/zrfBhCNCwp1j2diWRh7hhRfg
	nWvl6Z3KCJYXesoXQ5vt5tinAPOVhfemJRwmFy7uC4RCRJ0wvrWmXbQ1wEWXnuBBJjZz/HCz4Xu
	4/DF/531dYvvrYpVZRZ1I7eXj2VDCc
X-Received: by 2002:a05:6a21:3d84:b0:1a7:aba5:7ce9 with SMTP id bj4-20020a056a213d8400b001a7aba57ce9mr1699461pzc.34.1712897288410;
        Thu, 11 Apr 2024 21:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfSLFM5jIoiGUfY84S2M/snhX63jxnw3EVQYhrxaQoP9DgsKjdQMOLTfpqB5nASOgcWhtpTm2lPTdzBQI2ZFY=
X-Received: by 2002:a05:6a21:3d84:b0:1a7:aba5:7ce9 with SMTP id
 bj4-20020a056a213d8400b001a7aba57ce9mr1699448pzc.34.1712897288079; Thu, 11
 Apr 2024 21:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 12:47:55 +0800
Message-ID: <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we chain the pages of big mode by the page's private variable.
> But a subsequent patch aims to make the big mode to support
> premapped mode. This requires additional space to store the dma addr.
>
> Within the sub-struct that contains the 'private', there is no suitable
> variable for storing the DMA addr.
>
>                 struct {        /* Page cache and anonymous pages */
>                         /**
>                          * @lru: Pageout list, eg. active_list protected =
by
>                          * lruvec->lru_lock.  Sometimes used as a generic=
 list
>                          * by the page owner.
>                          */
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>                                         /* Always even, to negate PageTai=
l */
>                                         void *__filler;
>                                         /* Count page's or folio's mlocks=
 */
>                                         unsigned int mlock_count;
>                                 };
>
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
>                         union {
>                                 pgoff_t index;          /* Our offset wit=
hin mapping. */
>                                 unsigned long share;    /* share count fo=
r fsdax */
>                         };
>                         /**
>                          * @private: Mapping-private opaque data.
>                          * Usually used for buffer_heads if PagePrivate.
>                          * Used for swp_entry_t if PageSwapCache.
>                          * Indicates order in the buddy system if PageBud=
dy.
>                          */
>                         unsigned long private;
>                 };
>
> But within the page pool struct, we have a variable called
> dma_addr that is appropriate for storing dma addr.
> And that struct is used by netstack. That works to our advantage.
>
>                 struct {        /* page_pool used by netstack */
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
>
> On the other side, we should use variables from the same sub-struct.
> So this patch replaces the "private" with "pp".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Instead of doing a customized version of page pool, can we simply
switch to use page pool for big mode instead? Then we don't need to
bother the dma stuffs.

Thanks


