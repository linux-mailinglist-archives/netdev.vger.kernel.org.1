Return-Path: <netdev+bounces-52509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F77FEEEF
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE42281FCC
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36547779;
	Thu, 30 Nov 2023 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsXqjg4m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB234D46
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701347036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojCHnr8hnl9vzn5jmpVcOLvs0B0NtK6JuMjp0WJjPDQ=;
	b=UsXqjg4mevsei9OMf0MpN7ES5eAURYiKROb2f5OrwV/4uh/2mtPiWWive7Byozjm0A+Tgc
	AendwaoY/N6NbWBlZD08gVzxMYFN0p/1WXCiREgZRn1KGrPVqwPnA4IeYrhxpdbysQitXv
	9ouOqCxrkwTaK+7QAz8Dif7Emucl31Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-05wIeT6QMjq90N40-X2O2Q-1; Thu, 30 Nov 2023 07:23:54 -0500
X-MC-Unique: 05wIeT6QMjq90N40-X2O2Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a183a3b682eso11892466b.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701347034; x=1701951834;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojCHnr8hnl9vzn5jmpVcOLvs0B0NtK6JuMjp0WJjPDQ=;
        b=EN+RkSpH5ZHMNdqtzQc3zgZKZrmEzMifC0iUALDxKF/b8XCFnpi7GegDAmF5wl3KmJ
         eOJ+p58HikDg2tIBzRj/ahSH2cmm+mddgg92WtoZF0nwVw8kTML19CmZ9zlvLm8zVa4x
         kmR1IBYxiv0nbg85cQD9ljESynCygM64RvlqW3v2A1q3PNg/l3bQQWk8yBupTOaLko6X
         6izwUwjFl0p+l8Fy62LemVLLEP/zjVixG0KE8KB7w2MZB5clkH6+bzAoAgUrNksFsTRU
         pPonPccWc65uZM2kcFYNqMn8nNLHdcc6C/YxvW+GvMATa4NW+mXO5WxNjfhmrdLrXPwR
         VwpQ==
X-Gm-Message-State: AOJu0YxUxwsdSnO4B1OZbYZxd77OLgUUX7EZ3Y3p5TE3pLCyu3Z32qib
	FQJScPLoVefRwCtmbeEeTQaljIbnEMES0L2fZ3REeWU1lO7g1A4ngUtyvNRIo6O/AV105UvZARU
	zbZpk+ks7RETnxET6
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr1149200ejb.7.1701347033788;
        Thu, 30 Nov 2023 04:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVCo+08P9h7dyyr7Y67laGhsIBhBb1dXj+96vvB7Q9SCiez1SYwd4H6YAPfKoCVD8l+ZR1zg==
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr1149185ejb.7.1701347033462;
        Thu, 30 Nov 2023 04:23:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-32.dyn.eolo.it. [146.241.254.32])
        by smtp.gmail.com with ESMTPSA id oz23-20020a170906cd1700b009ff77c2e1dasm609367ejb.167.2023.11.30.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:23:53 -0800 (PST)
Message-ID: <4608e204307b1fb16e1f98e0a9c52e6ce2d0a3db.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support rx netdim
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, kuba@kernel.org,
 edumazet@google.com,  davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,  horms@kernel.org,
 xuanzhuo@linux.alibaba.com, yinjun.zhang@corigine.com
Date: Thu, 30 Nov 2023 13:23:51 +0100
In-Reply-To: <6f78d5e0-a8a8-463e-938c-9a9b49cf106f@linux.alibaba.com>
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
	 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
	 <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
	 <6f78d5e0-a8a8-463e-938c-9a9b49cf106f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 20:09 +0800, Heng Qi wrote:
>=20
> =E5=9C=A8 2023/11/30 =E4=B8=8B=E5=8D=885:33, Paolo Abeni =E5=86=99=E9=81=
=93:
> > On Mon, 2023-11-27 at 10:55 +0800, Heng Qi wrote:
> > > @@ -4738,11 +4881,14 @@ static void remove_vq_common(struct virtnet_i=
nfo *vi)
> > >   static void virtnet_remove(struct virtio_device *vdev)
> > >   {
> > >   	struct virtnet_info *vi =3D vdev->priv;
> > > +	int i;
> > >  =20
> > >   	virtnet_cpu_notif_remove(vi);
> > >  =20
> > >   	/* Make sure no work handler is accessing the device. */
> > >   	flush_work(&vi->config_work);
> > > +	for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > +		cancel_work(&vi->rq[i].dim.work);
> > If the dim work is still running here, what prevents it from completing
> > after the following unregister/free netdev?
>=20
> Yes, no one here is trying to stop it,=C2=A0

So it will cause UaF, right?

> the situation is like=20
> unregister/free netdev
> when rss are being set, so I think this is ok.
=20
Could you please elaborate more the point?

> > It looks like you want need to call cancel_work_sync here?
>=20
> In v4, Yinjun Zhang mentioned that _sync() can cause deadlock[1].
> Therefore, cancel_work() is used here instead of cancel_work_sync() to=
=20
> avoid possible deadlock.
>=20
> [1]=20
> https://lore.kernel.org/all/20231122092939.1005591-1-yinjun.zhang@corigin=
e.com/

Here the call to cancel_work() happens while the caller does not held
the rtnl lock, the deadlock reported above will not be triggered.

> > Additionally the later remove_vq_common() will needless call
> > cancel_work() again;
>=20
> Yes. remove_vq_common() now does not call cancel_work().

I'm sorry, I missread the context in a previous chunk.

The other point should still apply.

Cheers,

Paolo


