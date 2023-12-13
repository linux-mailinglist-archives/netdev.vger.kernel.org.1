Return-Path: <netdev+bounces-56920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD948115DE
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE529B20ED4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F830F8D;
	Wed, 13 Dec 2023 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeC1Cg86"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A7B9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702480407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
	b=PeC1Cg86T813cTyTKLQh38RDl9q1rmAVFG9Tv9pA1wAG2X78hQh+uBkfbkGig06Ma9fgi7
	orJN6Z9sBo/pGVT6tuXdqxz12eW2j0iA+C3Z4IXVmxRCwBoDCo+5vp8RFN8rBASiln3k6T
	5s8uLnw+DV3Y86Dy1KqfVkXbnIa1020=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-WNjsTAFSPriSWpYSLwOOSg-1; Wed, 13 Dec 2023 10:13:25 -0500
X-MC-Unique: WNjsTAFSPriSWpYSLwOOSg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1f6b30185bso346174966b.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480404; x=1703085204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
        b=wq700uVIjDw19Nke8EbYjsvsAJw7sAItJVX1X4alsVTQa3AD+h8GbhOSq3z0wrnY/4
         sn2vpVrI3ofZyw3opdS6KcMeYTx0ba7chaM0LHQwBpLd29+5cOrkm7Sm/j2cVAwBLKJg
         sreLEKZzLPenPMWC7p2nLNs4GtQGiu23bA5TQL7eYSWF81+mOyRhtSIiFEoxwi9QkU0l
         2AX7tQzN5x/7VHbFB8/ud8VRHspk30kyOBqNvcLpB73VpWurbq0Lmw62Q/GJUXhn385a
         X/lOEhS5SCmZs0WZbqAOz9+BjbuSax4DkUV7Fvg1GcFoXVoveTeV1z2pLCVO/7pHTq1C
         SaOw==
X-Gm-Message-State: AOJu0YxSpBmhUfYf5CafPgz3eBx5oYn+71HRDPkIj6mNskAgMDeEb9Wg
	c6M6scFUiAvuN9pWluoXYmmXeI6roQ9e8YyfWbmgVqwdRnhp65WqyoCmDP2Z4X9Yz7wZdS7kQZR
	ybi2EDF251i7Qb+V6
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353774ejd.5.1702480404099;
        Wed, 13 Dec 2023 07:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVEHNhpEpNkKjGAhK/XWOUUTGGv28PciIr/kdbCXWcbETJTEaPRgwgaTCSAZtVYbJ3/DARkA==
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353768ejd.5.1702480403779;
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a1e27e584c7sm7934486ejn.69.2023.12.13.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Date: Wed, 13 Dec 2023 10:13:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <20231213100957-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213100518-mutt-send-email-mst@kernel.org>

On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> > 
> > 
> > On 13.12.2023 11:43, Stefano Garzarella wrote:
> > > On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> > >>
> > >>
> > >> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> > >>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> > >>>>
> > >>>>
> > >>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > >>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>>                                DESCRIPTION
> > >>>>>>
> > >>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> > >>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> > >>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> > >>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> > >>>>>
> > >>>>>
> > >>>>> Patchset:
> > >>>>>
> > >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > >>>>
> > >>>> Thanks!
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> But I worry whether we actually need 3/8 in net not in net-next.
> > >>>>
> > >>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> > >>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> > >>>> have strong opinion. I guess @Stefano knows better.
> > >>>>
> > >>>> Thanks, Arseniy
> > >>>
> > >>> Fixes means "if you have that other commit then you need this commit
> > >>> too". I think as a minimum you need to rearrange patches to make the
> > >>> fix go in first. We don't want a regression followed by a fix.
> > >>
> > >> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> > >> patch fixes problem that is not related with the new patches from this patchset.
> > > 
> > > I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> > > I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> > > for every bytes we read, so we should not have this problem, right?
> > 
> > Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> > 
> > Thanks, Arseniy
> 
> 
> hmm why not net-next?

Oh I missed your previous discussion. I think everything in net-next is
safer.  Having said that, I won't nack it net, either.

> > > 
> > > So, maybe all the series could be "net".
> > > 
> > > Thanks,
> > > Stefano
> > > 


