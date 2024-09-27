Return-Path: <netdev+bounces-130139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021129888D7
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B344B24671
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D6E1C1AA6;
	Fri, 27 Sep 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Sku4ooQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B41C172D
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453669; cv=none; b=lM5aECHwjhwCIPzpo8of696m+mlz8qJgpiE/Fa4/OlsmT29B/6Oh1M1naxMsCYiaz2N3t4tB/n0dAZa1ZC3CBOsJhQEeGg1U/kCw14HSeB/VOmpiuKJ7uCPzKC2+Sb5AW+zB17bDw61PsN1/TkimF40dGuDoZzPiB9cZ3M12e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453669; c=relaxed/simple;
	bh=3RIMFSBP6CNFy3ASEfaPEk9hh3pVcFi6cjnKVKez7w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdqS+oaZ1U72eKbQELOMKhCVGQInP5ztq8+/L3NM4yry7HZPUlkHzFzGWLK/GMdy2a8Yuh2WCS+GcISLineqlhymabp6OP3OTG8SlWrq/RcntpDEdVhxyANqHYhwq6VZXm+huAeN8Oe8ZYq9YAuf/6gYBz4g1WgGfwXwEwDv2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Sku4ooQn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20792913262so26760615ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727453667; x=1728058467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4so8gffKQiyHlooUmYMifdWdhzGqPHicjPRqtGrdk7o=;
        b=Sku4ooQnvMd7v+ZkQ+g/Sb7ndiqU2/kAUsjxAGjylkG3W2VPMvJX034xpepK/XfNwy
         5lmkcRXengxE/tEygD9fYoOV3ejxrl98AEOYAZIRwd17v7ysXkcewitTkg2Ezn+9Hpk5
         KWOumnvg5XaZqJkz+gd+H9D+pB10hh9mFa4Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453667; x=1728058467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4so8gffKQiyHlooUmYMifdWdhzGqPHicjPRqtGrdk7o=;
        b=K0QSdDJJTdVUjTLdu/HIUoiVSyalPmj6lvyBugkTwd/N1pq1M3NBZvagiqrcMfMwZQ
         NnBv87XGha7BSbxy5A5ZjXSKPM4g4qlieBzAZfGDEmm3sB7L8VNUAkjZ+yCQ13ZagwM4
         aHIsRf8AKL+hKnmGZzewcnNQcwCTF/6ctMNTyD8NpEXhhAEP4fE/9U7CRAwLCU480CiI
         HP7v053rmBNKSL/pR9m+PTTvmlx707U2rJEq/3EyPlp+8zHIjootVsvIvwe0lzqvCNOi
         WIxg1uT41U/qLwrhQqlBgGkWUKNACJW4F/M9WmdK5E53uSL9O4f6i/LDqDFcUy/jDkhz
         3qig==
X-Gm-Message-State: AOJu0YzoC2OBdEkbLci+J9qXP4nMMcmMmX3YUVNst5WLB+V9A2Je2q7y
	UxHMDBLXzHaCogaPrvZES1qccg9iHz0F98o4e/cUES4+EXTZzYuB0wCWSeIh1wU=
X-Google-Smtp-Source: AGHT+IEjXaqfeQRAXRfoN5D9VsgOXKzfJXTb1NEO6DmBY3dq2QmLox7Y5Qeb0Qch3l/Xg+VnTQV0XA==
X-Received: by 2002:a17:902:cec6:b0:20b:4d8a:290a with SMTP id d9443c01a7336-20b4d8a2dc6mr12777555ad.31.1727453666745;
        Fri, 27 Sep 2024 09:14:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8e033sm15407225ad.70.2024.09.27.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:14:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:14:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <ZvbZ33RYhTQAfBOQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
 <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>

On Fri, Sep 27, 2024 at 09:33:51AM +0530, Pavan Chebbi wrote:
> On Fri, Sep 27, 2024 at 4:47 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 04:20:48PM +0000, Joe Damato wrote:
> > > Link queues to NAPIs using the netdev-genl API so this information is
> > > queryable.
> > >
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                          --dump queue-get --json='{"ifindex": 2}'
> > >
> > > [{'id': 0, 'ifindex': 2, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++++++++++++++++----
> > >  1 file changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > > index ddf0bb65c929..f78d7e8c40b2 100644
> > > --- a/drivers/net/ethernet/broadcom/tg3.c
> > > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > > @@ -7395,18 +7395,34 @@ static int tg3_poll(struct napi_struct *napi, int budget)
> > >
> > >  static void tg3_napi_disable(struct tg3 *tp)
> > >  {
> > > +     struct tg3_napi *tnapi;
> > >       int i;
> > >
> > > -     for (i = tp->irq_cnt - 1; i >= 0; i--)
> > > -             napi_disable(&tp->napi[i].napi);
> > > +     ASSERT_RTNL();
> > > +     for (i = tp->irq_cnt - 1; i >= 0; i--) {
> > > +             tnapi = &tp->napi[i];
> > > +             if (tnapi->tx_buffers)
> > > +                     netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> >
> > It looks like the ASSERT_RTNL is unnecessary; netif_queue_set_napi
> > will call it internally, so I'll remove it before sending this to
> > the list (barring any other feedback).
> 
> Thanks LGTM. You can use Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Thanks, I've added your Reviewed-by for the official submission.

I'll mention this in the cover letter when net-next is open but the
only changes I've made to the patch I posted are:
  - Removal of ASSERT_RTNL (mentioned above, as it seems to be unnecessary)
  - Wrapped lines at 80 characters (cosmetic change only)

