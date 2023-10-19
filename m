Return-Path: <netdev+bounces-42505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236A7CF021
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D92281E56
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B44669D;
	Thu, 19 Oct 2023 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr2qbAmC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2365C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:37:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF87BE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697697423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
	b=Kr2qbAmCo4oHAF9mr+k25JCc1BdLnBLWcj+cy9SeYkkacigs/rudVGVUZrHBY0ibcOpwMr
	k747LVBkz6371kj1xg8fDY9+88lPUFVBLcv1Y1/l1ztEretf+3zE5Mj1sP8virmlP1SLlq
	cjMOuir0f6SNSxHJOr9trUh0STK/iTg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-1-aM3PHnMxmHJkYFvSIL5A-1; Thu, 19 Oct 2023 02:37:01 -0400
X-MC-Unique: 1-aM3PHnMxmHJkYFvSIL5A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084163ecd9so5258115e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697420; x=1698302220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7YGdF4c/ZFxSg9nV/ChxJMQEFQk8yK6EpVnN33SpoY=;
        b=HnWT+qepXUki96W6k8MWA9JUwGuPTSwLV7xLFn/WXe7ktRDSs1TaZUtQTfXPJvCMem
         xMrVmwFJifck+vlFTmE7/6w3oR3xCqX13UvujexpfTh+bIJAk1odYkL5xE4Plr/NSoUF
         DXK+C0GixDAn1jYHkRC4gZRsOmxm/LluaSdQ92IGLHzNSVqbwkx0LASb2CKQ+KGpc9sz
         9ZKckz+eyi9OxWBuPofAGE+xK5T/2aa+0cGsXE5/6ZMVhs2vElD9LplqWm5bbHhc1eeX
         PjzimbIpakmVTkyYK7tXl4BhtbqAIkSNKykWb5uFiesHwDEvU9GYMTX1NdC7fR9+xfV2
         4Ghg==
X-Gm-Message-State: AOJu0YyP8kLipgRhpG8GF2TAi+KXGqwJBiqQ647k4eYu6UWu9A6vunlr
	zOf4XUEvBMP4yNbdUuc5+xsSaC1b/n81FxjdRr2jSimec4U160I/ZNc+/q0s6ER221rj9I34G8/
	Ml/sHL7Cs0KiJjrFQ++8A23rYiTk=
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id f7-20020a056000128700b0032db081ff32mr625914wrx.38.1697697420038;
        Wed, 18 Oct 2023 23:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8iY58YnHTQToYzw01jGs6sEhJQ8nc4mS2k2A0gX5GvAr8vDJCYQUcwBMyolUVLl/6NSgiWA==
X-Received: by 2002:a05:6000:1287:b0:32d:b081:ff32 with SMTP id f7-20020a056000128700b0032db081ff32mr625899wrx.38.1697697419713;
        Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0031980294e9fsm3684591wrs.116.2023.10.18.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:36:59 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:36:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 05/19] virtio_net: add prefix virtnet to all
 struct/api inside virtio_net.h
Message-ID: <20231019023548-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>

On Thu, Oct 19, 2023 at 02:14:27PM +0800, Jason Wang wrote:
> On Mon, Oct 16, 2023 at 8:01 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > We move some structures and APIs to the header file, but these
> > structures and APIs do not prefixed with virtnet. This patch adds
> > virtnet for these.
> 
> What's the benefit of doing this? AFAIK virtio-net is the only user
> for virtio-net.h?
> 
> THanks

If the split takes place I, for one, would be happy if there's some way
to tell where to look for a given structure/API just from the name.

-- 
MST


