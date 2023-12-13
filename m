Return-Path: <netdev+bounces-57041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F575811BAD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89811C20FB8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CC59E31;
	Wed, 13 Dec 2023 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHMf34fr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3071E8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702490180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEKtCaZo1O9cfSPgdOwxIJB9fsJXHh/ahknjK4hJAXk=;
	b=jHMf34frnpqwik6b7pQQIttM7qC/F1KRv/ZQDg6JxC/KK+WizLARndQnaNwHt4jkCPEefc
	OYCtq5PqzWmKQAnekoIJULTZVc5qcEmGy5IZtgOaSvvJkarSCFGGyuKLFTAn2jvmPjDPB3
	SkbTUVMfObbzDFE1gSd83GtfVOB/prQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-4t6lS7QTNua3YlY5lashBw-1; Wed, 13 Dec 2023 12:56:15 -0500
X-MC-Unique: 4t6lS7QTNua3YlY5lashBw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d7df84935so423996066b.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490174; x=1703094974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEKtCaZo1O9cfSPgdOwxIJB9fsJXHh/ahknjK4hJAXk=;
        b=cCTvnnSdwQqUFjLSnI8ov3IMV0uwioGYqIvNJZ0K9/gXpem9zfEyQL+V6kne1Iu974
         n+28oOSarUdDrp9Rcz5tXt3SEeyvIc7xNSARl60gT8WkjOWf7XmODJF1T9WWCfUfBkqW
         FhOYCMAxEffYG0NrEGpwkBVHtz9g5+STEn3hozTtvAygK0bHHUABoBf2woEUZtm2nSDH
         eVasV5Xr5nPdKX0zxeJKV35RvJmB+F3+9Lz+3nb9TUpM3+MsTUzQWc1Oc4MGJiP63Xen
         jO88FKNtQHzmT8vLioA2TKvLVCWsfg30rqnK7yejDtg1nEyhv65BBn6rQuav1loWfG+P
         xhNw==
X-Gm-Message-State: AOJu0YzVHmSM9X8IktO96iwK4e2jJGC/ZEz4M7j9xeUv48hnCHTWhZVO
	7H2Kn9XFyMfL30vXXduOzD+MjYcr8wysFycJQ7rBxosuLfY20Q51bw8ILrOXxd/aOsl9EsTeUV6
	aZ/MDhbYewft0XbRf
X-Received: by 2002:a17:906:51c9:b0:a23:94b:eb76 with SMTP id v9-20020a17090651c900b00a23094beb76mr66462ejk.110.1702490174199;
        Wed, 13 Dec 2023 09:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc9RJlOVWyo0HyAiFTcOk5Wfn8VDPbQGBmpAhf72fm6DauJ3ApY2N3w9RPj1ICyK7MuA8IVA==
X-Received: by 2002:a17:906:51c9:b0:a23:94b:eb76 with SMTP id v9-20020a17090651c900b00a23094beb76mr66447ejk.110.1702490173843;
        Wed, 13 Dec 2023 09:56:13 -0800 (PST)
Received: from redhat.com ([109.253.189.71])
        by smtp.gmail.com with ESMTPSA id uv6-20020a170907cf4600b00a1e443bc037sm8258684ejc.147.2023.12.13.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:56:12 -0800 (PST)
Date: Wed, 13 Dec 2023 12:56:08 -0500
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
Message-ID: <20231213125404-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
 <20231213100957-mutt-send-email-mst@kernel.org>
 <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>

On Wed, Dec 13, 2023 at 08:11:57PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 13.12.2023 18:13, Michael S. Tsirkin wrote:
> > On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
> >> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> >>>
> >>>
> >>> On 13.12.2023 11:43, Stefano Garzarella wrote:
> >>>> On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> >>>>>
> >>>>>
> >>>>> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> >>>>>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> >>>>>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>>                                DESCRIPTION
> >>>>>>>>>
> >>>>>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> >>>>>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> >>>>>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> >>>>>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Patchset:
> >>>>>>>>
> >>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> But I worry whether we actually need 3/8 in net not in net-next.
> >>>>>>>
> >>>>>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> >>>>>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> >>>>>>> have strong opinion. I guess @Stefano knows better.
> >>>>>>>
> >>>>>>> Thanks, Arseniy
> >>>>>>
> >>>>>> Fixes means "if you have that other commit then you need this commit
> >>>>>> too". I think as a minimum you need to rearrange patches to make the
> >>>>>> fix go in first. We don't want a regression followed by a fix.
> >>>>>
> >>>>> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> >>>>> patch fixes problem that is not related with the new patches from this patchset.
> >>>>
> >>>> I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> >>>> I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> >>>> for every bytes we read, so we should not have this problem, right?
> >>>
> >>> Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> >>>
> >>> Thanks, Arseniy
> >>
> >>
> >> hmm why not net-next?
> > 
> > Oh I missed your previous discussion. I think everything in net-next is
> > safer.  Having said that, I won't nack it net, either.
> 
> So, summarizing all above:
> 1) This patchset entirely goes to net-next as v9
> 2) I reorder patches like 3 - 2 - 1 - 4, e.g. two fixes goes first with Fixes tag
> 3) Add Acked-by: Michael S. Tsirkin <mst@redhat.com> to each patch
> 
> @Michael, @Stefano ?
> 
> Thanks, Arseniy

Fine by me.

> > 
> >>>>
> >>>> So, maybe all the series could be "net".
> >>>>
> >>>> Thanks,
> >>>> Stefano
> >>>>
> > 


