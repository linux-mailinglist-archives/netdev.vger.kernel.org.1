Return-Path: <netdev+bounces-52440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083E7FEBE3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F634281C19
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FA38F89;
	Thu, 30 Nov 2023 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq3GgL22"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FCD48
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701336816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCExvHYEswKuEfeCmLnGAnokX5PwVgkIGHZN/pMhG/0=;
	b=Mq3GgL22Q6FV6vqhPcwn9miNG+2XCCwA8LyIvRHLVh3eqe6FIUkPUPJoni5yfia7D5pu7G
	iBb0iaqTHlPUQ+WXbKp7L0MLtJtzD/GNwRMdHOa4MAf5/kvFZgQLNqxkwfLnqbapjv+kBE
	elbqlOMZGmpKNzl8VBlBTLaEnEzfiUQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-ZFecgY3MOuyBw9OlKPjUpg-1; Thu, 30 Nov 2023 04:33:34 -0500
X-MC-Unique: ZFecgY3MOuyBw9OlKPjUpg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a18a4b745b2so4360566b.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336813; x=1701941613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCExvHYEswKuEfeCmLnGAnokX5PwVgkIGHZN/pMhG/0=;
        b=T83z8Ol2F71gVmKfjI8X3nzlZA1Y1YLFdYB6Wm/tIJSfOKWu29jZENFF97u/y8zQnN
         H3OHtkDMUq3j006zStFrFtVK2pmbEKGa70qweENFci8z6z2rh7Msm02fyKtwqLoGQDTb
         uEWAvFpmLfwsOghzi88cN3k1inbXkkf9OYUcuTGJSrmLPtgM7tRsWSmSLKwl87TlYzwb
         jljeZNAiN29n7sQ3S46LzAMqRWKi5COYsz/xNuapD6uVrzs+cWV+fCJStMdVXXO2hfCL
         J+voFqs2wa/DOqtJEhig5NjMjcDVeLAlSEqowDk1ngmbirRDp8jHxZ2LSen3y8wpDNr/
         oNkw==
X-Gm-Message-State: AOJu0YyxtotsniKMbiQK9myl75ojrwf824hy3ckxoduWIpo9wImdFCII
	0+UG91cawL64JWhDrm3UDY7K6uxWj7paZjEL2hW3LUJpf0QhJnRTAClP1qXSxHXsIcuweti5eqG
	i4ayFA1upZoe9rSXD
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr820675ejb.7.1701336813536;
        Thu, 30 Nov 2023 01:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP5pbMR674ut0hyknc6qi/7vtoWZqWf64ILFllSlxQGa/5LjZX7aHjzFBJZ0hRNM8lzBLUKg==
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr820654ejb.7.1701336813204;
        Thu, 30 Nov 2023 01:33:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-39.dyn.eolo.it. [146.241.254.39])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm463853ejb.150.2023.11.30.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:33:32 -0800 (PST)
Message-ID: <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support rx netdim
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, kuba@kernel.org,
 edumazet@google.com,  davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,  horms@kernel.org,
 xuanzhuo@linux.alibaba.com, yinjun.zhang@corigine.com
Date: Thu, 30 Nov 2023 10:33:31 +0100
In-Reply-To: <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
	 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 10:55 +0800, Heng Qi wrote:
> @@ -4738,11 +4881,14 @@ static void remove_vq_common(struct virtnet_info =
*vi)
>  static void virtnet_remove(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi =3D vdev->priv;
> +	int i;
> =20
>  	virtnet_cpu_notif_remove(vi);
> =20
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vi->config_work);
> +	for (i =3D 0; i < vi->max_queue_pairs; i++)
> +		cancel_work(&vi->rq[i].dim.work);

If the dim work is still running here, what prevents it from completing
after the following unregister/free netdev?

It looks like you want need to call cancel_work_sync here?

Additionally the later remove_vq_common() will needless call
cancel_work() again; possibly is better to consolidate a single (sync)
call there.

Cheers,

Paolo


