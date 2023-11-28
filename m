Return-Path: <netdev+bounces-51709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDF7FBD22
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE527B20DF3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC875475D;
	Tue, 28 Nov 2023 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IExYGU8y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878C1FD6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701182829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22m+uwNDeQ85nhwW3X1YZBKN3LWM6lkATmHUi09Mbgo=;
	b=IExYGU8yiTlHhXSwRgjyHXz2NXJAUrNa9z5zRX9/WBR41aPqa8NA9SvjfopWjWN4QYplJt
	Llz4GZ7GdbV7av69kgOAUnEhtCZ7FOPPvRXAEaD3WSTitHN6QolyvTtizbX8S+aLQRfw2M
	0XUF4w2V6y9WrmEO2Jbkk4DxYw83mBM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-JVGUMxUWM3W09V1ZxtptMw-1; Tue, 28 Nov 2023 09:47:06 -0500
X-MC-Unique: JVGUMxUWM3W09V1ZxtptMw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333137a04f5so26985f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182825; x=1701787625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22m+uwNDeQ85nhwW3X1YZBKN3LWM6lkATmHUi09Mbgo=;
        b=SOHXeSiR80bJyXeT0jsKWWPduiTnNilVglkKfjn+XXfNI142+twb9ur2oFxH9T93Gj
         EsLXB6rgjyumRKl379X+vTIskO/cIQdqiGPO49OShZ1KfKm0jtH7KtZJW2PydMUwOeKU
         hLy+kEVNHB7fR6LcM+QBnX6nrtGiqQYbKXjC0IZ48D44nF+fWNQ4hgGg61hf9Q1Eln3E
         guIncPUeujck4q8ncNoW68kQwXP8koISFONfzR6nU1cLbTqDVSX7mNj2H5BoZMmA5t9o
         pZghFQPEJmCZ6i8rC3r9UFdy1hvmJuoznPsISdvpjovR84b1M/0VeUIhddjTX+sqRIJj
         2z3Q==
X-Gm-Message-State: AOJu0Yxjp9sHNJUlPNQUKwE//Y2bN+lLEnP67kADqe+/UK+9Q/Y3sNN5
	G2BiDaVrhhnG/gBScRkEOsdRBfY0Ha2+vJCbdQI7zqagixzjcSyX3Jqmha3MjOtjbCmUcjqWRT5
	ctYPA3/nRD6CvvlVH
X-Received: by 2002:adf:a10f:0:b0:333:db:dc21 with SMTP id o15-20020adfa10f000000b0033300dbdc21mr4817318wro.3.1701182825338;
        Tue, 28 Nov 2023 06:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyFRJuLcd26Kaho3L5ily8/AsMGroaptCRNVxXUHERaZhGhd4jR7EtSkUcQgFaBjCX5q035g==
X-Received: by 2002:adf:a10f:0:b0:333:db:dc21 with SMTP id o15-20020adfa10f000000b0033300dbdc21mr4817304wro.3.1701182824993;
        Tue, 28 Nov 2023 06:47:04 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm15073897wrc.95.2023.11.28.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:47:04 -0800 (PST)
Message-ID: <b72a926a0752f28dbc5bd13e557d137e3bdb3426.camel@redhat.com>
Subject: Re: [PATCH net-next v4 02/13] net: page_pool: id the page pools
From: Paolo Abeni <pabeni@redhat.com>
To: Shakeel Butt <shakeelb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, dsahern@gmail.com, 
	dtatulea@nvidia.com, willemb@google.com, almasrymina@google.com
Date: Tue, 28 Nov 2023 15:47:02 +0100
In-Reply-To: <20231127070747.37a42srqxs6jqtz3@google.com>
References: <20231126230740.2148636-1-kuba@kernel.org>
	 <20231126230740.2148636-3-kuba@kernel.org>
	 <20231127070747.37a42srqxs6jqtz3@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 07:07 +0000, Shakeel Butt wrote:
> On Sun, Nov 26, 2023 at 03:07:29PM -0800, Jakub Kicinski wrote:
> > To give ourselves the flexibility of creating netlink commands
> > and ability to refer to page pool instances in uAPIs create
> > IDs for page pools.
> >=20
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>=20
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>=20
> [...]
> > +
> > +static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
>=20
> One nit which you can totally ignore: you can use DEFINE_XARRAY_ALLOC1()
> above.

Since there is general agreement on the series in the current revision,
and the series is not small, I think it's better to apply it as-is. The
above could be addressed with a follow-up.

Cheers,

Paolo


