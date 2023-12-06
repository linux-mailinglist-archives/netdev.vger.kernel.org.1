Return-Path: <netdev+bounces-54333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD4806AA3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2B28198A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E01DDE7;
	Wed,  6 Dec 2023 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5DdQEHI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A9D68
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701853877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXI9sUJnTAuH5o4spKWiLopVZdAAXUNFoXFFeQ8snuE=;
	b=O5DdQEHI3JyqpgajP9Tcp0lfDKfg4WiJrO/as+oc4FgPoJCVNUVN2LkF5P/FunIiEtiu10
	jVzf9y0WlmRv48c+QhN4BnXKIlcMf3tTSffNXqfupfVe7jv1fH5KN2A0R4lkz6/rr4ZQWy
	3XLrfT37B8DdW4a/3nUy1v8cajUkbVQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-emIgwCbiM9SSiUERr2gStA-1; Wed, 06 Dec 2023 04:11:15 -0500
X-MC-Unique: emIgwCbiM9SSiUERr2gStA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50be177a378so4196437e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 01:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853874; x=1702458674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXI9sUJnTAuH5o4spKWiLopVZdAAXUNFoXFFeQ8snuE=;
        b=B9SWPzZYpWiMIECxXsUZhAWEm82csAN7yetc6EZRSzyBns76aRSfCs58tu9YrEjR9T
         C7OLYBLug5XzH0YRtW4FBn2JKCscSuaJEYSbwuXEXJZmQB3EsrUzCUKUPoru4ZRAv2wA
         M5zXKl6QCMhkFk3IuvEqbg2HCGIP82vQGuu5U72zuueKL1lP+hNFwe8H0LyBEOZuDPRf
         hBnzT+ZtFNDp0AcxKs5a0ytIUt1+j8sLLSm+kAWi2W8JYVWe1nQHe2g2AA6C6FrtjMQt
         yQ4S9OEeeRAEdfCDWW+fHUU+ebwgGBcYY4QkqjhQqYDcA0JH7hdgFoStbogWBudxixx6
         Uu0w==
X-Gm-Message-State: AOJu0Yw25y+c+aKA+ufk2kpagi1i+oB31wCnaNdM+iwqlMaJOpST9kRk
	lxf15/r9MKrafrkkP1NqiTQgIrJeJJ+8er1nFGljvr+g/3dDicfqMaAzLexO4Mcq1Q86S3uGo7X
	swbSYZ4AhhmLrl9OErQPQ49l5Hh+7F2ne
X-Received: by 2002:ac2:5486:0:b0:50b:ef21:7de4 with SMTP id t6-20020ac25486000000b0050bef217de4mr147837lfk.181.1701853873951;
        Wed, 06 Dec 2023 01:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnlHzU9sS65aeZa1sMgyX7CZTG0031E6RKQwdQI2ftq2TEJGgAwCsPHOK5SE5N3zhzEj9h14UUjDOWhGMiKJ4=
X-Received: by 2002:ac2:5486:0:b0:50b:ef21:7de4 with SMTP id
 t6-20020ac25486000000b0050bef217de4mr147827lfk.181.1701853873618; Wed, 06 Dec
 2023 01:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com> <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
In-Reply-To: <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Dec 2023 17:11:02 +0800
Message-ID: <CACGkMEsf=c_fodNUgX1idwRa9Jsd1_rsYgtZaYH3DuASJvfTog@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	mst@redhat.com, pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com, 
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org, 
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:06=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=81=93=
:
> > On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> >> Currently access to ctrl cmd is globally protected via rtnl_lock and w=
orks
> >> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadl=
ock
> >> may occur due to cancel_work_sync for dim work.
> > Can you explain why?
>
> For example, during the bus unbind operation, the following call stack
> occurs:
> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close ->
> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs)=
.

Can we use rtnl_trylock() and reschedule the work?

>
> >> Therefore, treating
> >> ctrl cmd as a separate protection object of the lock is the solution a=
nd
> >> the basis for the next patch.
> > Let's don't do that. Reasons are:
> >
> > 1) virtnet_send_command() may wait for cvq commands for an indefinite t=
ime
>
> Yes, I took that into consideration. But ndo_set_rx_mode's need for an
> atomic
> environment rules out the mutex lock.

It is a "bug" that we need to fix.

>
> > 2) hold locks may complicate the future hardening works around cvq
>
> Agree, but I don't seem to have thought of a better way besides passing
> the lock.
> Do you have any other better ideas or suggestions?

So far no, you can refer to the past discussions, it might require the
collaboration from the uAPI and stack.

Thanks

>
> Thanks!
>
> >
> > Thanks
>


