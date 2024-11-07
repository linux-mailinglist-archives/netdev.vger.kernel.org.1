Return-Path: <netdev+bounces-143081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE419C1125
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F02819E3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F32178F2;
	Thu,  7 Nov 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGBTjMmW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC761DBB0D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015676; cv=none; b=LrED9mFOu4JP6m4HynG+DuJIYU50XJIu9fR/8MHiR55ALDB7lqClfzOmGm5yfPqG+nBXV2aka8019izmwCGOb5ZIhpMHzeaCVlIx2AuZgSkicFrG5rITOB44uK/Z2M/fSX52fsw0J5fkNryH1mV6+felwJu/xfzR5Hl1rEJBK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015676; c=relaxed/simple;
	bh=fLdfZzo90PzNEL/By0BCWrAEgq+8ZAKgcUTa2z6seJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN9FAhaGXqoLULQyHF8TOvJRVe24nvJtxYtI3Tz5x3L1tE74g6cTmeFCfR2aXwlp42tzK7/tzoIxwdIkpp/FDm2GkZrfUb4iH7WM0RzSp08Khb/RLQBa1+zF8bgoaK0vzrMPOINf20X4/O7vT0ue8fS47uB7b9hw6EQSZWO4NOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGBTjMmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731015673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
	b=NGBTjMmWQP4Hn1pMsQYqy9OHZWfMkac+EJpjpDIZ7QuEIWsXF4L5qjVe8hJ60vny/3cQwc
	tabw2b+WwkGQ+SQHAs8nSc9KP801h9e/+Mh8Ld1SHREchtBF908DxnXQuNIWqjQBjr+khD
	DwF4/MA7QV2/Mj5WA4/ko/34AajESow=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-50uTZ-rpM-ejkCKbnJQj_g-1; Thu, 07 Nov 2024 16:41:12 -0500
X-MC-Unique: 50uTZ-rpM-ejkCKbnJQj_g-1
X-Mimecast-MFC-AGG-ID: 50uTZ-rpM-ejkCKbnJQj_g
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5cbadbef8edso1182359a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015671; x=1731620471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
        b=LJPtblpX58/ywZkx9BDVECe1ILwhPbTLYDL9xS9QAC544IRykcNqxi4O3U8fmPw0nx
         Kho/oTSDTQpwl6g+Zf0tv7WTnenu4gQN10O137iTCjg0lEJ0bvyVK4c5m83q4G0heiBi
         i+znWQwIR7J52mA5afy0BVFPYIQHvTOY17wk1jtFgRrEkfc9UfsHYAIHXYhZAlkGztRq
         3r9q/Y8AP7kT5nKQkRUG05YZz4tB3Xlg3l3TvbT5//iSJu6P2M7oVXDzgH6JZE2DpcGZ
         T2JmPKp5QbK0KGTf9qOkNpYWisw3cgFbsRMYl7skZC7GPOOOsZAw45W6J15cJmlnsQs8
         sTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyKIvEsR5VU//bnSiRG9iP7ltgv/g8ffgk6jnChaYZmvm0wp0ahA/RUFGje+3TBpIXLcYUdbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7eNr0rOIBnzFngeNVRQL8yGBt1sOVaJYRvHJTSzM+0p6xe4g
	FIKphs5XyekPLCySDwI+gslB/J+JJgx3da1Ym+zO69Pm+Cg3JWS19rlaDT1HYXsVzChvLwDSyD3
	nmtpyLKXHnvg9BecbGjs3FOMz6tXONAz3tFjT94BeASveqD1WuHWAJQ==
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242464a12.2.1731015671452;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnySyRq03iGTzTmiBoPn4BtW/0y8BdTVR3G/Nk4eaBwgb/hSu3uiHSIE0b1E3DZtVksWsI4w==
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242438a12.2.1731015671068;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb6dc1sm1292372a12.42.2024.11.07.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:41:09 -0800 (PST)
Date: Thu, 7 Nov 2024 16:41:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hyunwoo Kim <v4bel@theori.io>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241107163942-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
 <20241107112942.0921eb65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107112942.0921eb65@kernel.org>

On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:
> > When hvs is released, there is a possibility that vsk->trans may not
> > be initialized to NULL, which could lead to a dangling pointer.
> > This issue is resolved by initializing vsk->trans to NULL.
> > 
> > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > Cc: stable@vger.kernel.org
> 
> I don't see the v1 on netdev@, nor a link to it in the change log
> so I may be missing the context, but the commit message is a bit
> sparse.
> 
> The stable and Fixes tags indicate this is a fix. But the commit
> message reads like currently no such crash is observed, quote:
> 
>                           which could lead to a dangling pointer.
>                                 ^^^^^
>                                      ?
> 
> Could someone clarify?

I think it's just an accent, in certain languages/cultures expressing
uncertainty is considered polite. Should be "can".

-- 
MST


