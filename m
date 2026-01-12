Return-Path: <netdev+bounces-248884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1DD10972
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 05:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FA2130151AE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257A308F28;
	Mon, 12 Jan 2026 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS9iPDiS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQE5Yfco"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900072D23B1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768192946; cv=none; b=LXM2sogR+qR++JC2RJDgg/DYK/DtHZ2nFb/gtnNG1+xBlLCb15ylHKliKRxupEPFeU/h3krUzpgMapvfRHPglRPG85zJsZXJ7z/3f/u5CLpt5iefXL37okidUX6nhP6ZigPZnPrciR14RGEuDnB4qQNEnm1g583hD3ths3ndxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768192946; c=relaxed/simple;
	bh=2VltQBFJygJXWBbOcvlhVXQ2y5H6Win1bazyoi6YOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI6JvU/FgEZZtDf5G4y3hF4jKnCz/zmFsMDhJQ/NVMpjYALPx6M01pTs2Qe/LlckiSvZWKsuUd67k1WRQedkJg2aqsiMcPtXuLg9OTsz75SKKnpx5ZfiNfiXg8jAFb2o1VLqd5NaFpnUeGzyCkxykX0EZHZfjOJ7SmXEglb841Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS9iPDiS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQE5Yfco; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768192943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRnCSJo0TmvquSWDDIrpEWk/wUKA+CvYamy20zcpVrg=;
	b=BS9iPDiS6g/TN7mDR/hTCCd+7nZbfzhK6CE0+jEQK/f/8OBYBRn20kyLOmxSVkMqnm9ntq
	aeheU9vVL6D4scENC+KD1kox1uLOtNpH/kUTFB9FLu7Dg9UgOQMpPAngJckElhPb4xIhBR
	QOWJCC2htovAqhl01idenfE0pL58wtQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-6edHFUVFOcqi-D_e3BvnDg-1; Sun, 11 Jan 2026 23:42:22 -0500
X-MC-Unique: 6edHFUVFOcqi-D_e3BvnDg-1
X-Mimecast-MFC-AGG-ID: 6edHFUVFOcqi-D_e3BvnDg_1768192941
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fb8d41acso3904903f8f.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768192941; x=1768797741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRnCSJo0TmvquSWDDIrpEWk/wUKA+CvYamy20zcpVrg=;
        b=YQE5YfcoVGsc3kel5AZsPv+5MwoVhhFfz1JXQSX/M9CqPf9Sp5r28AoLrkLxNolKew
         VJvvJOs7OCcjc6DyT3IzQKB6lEe5n71/Gx1e3DBjkfhQQB0NOfp7CkFunWKVMj32/a3b
         n7NohkN93JvaCdb1VWZ3BsLNICjQbm4dREMxBgjJS4NnZ2D2xow+Fc/vuYgbCzUFcjQq
         k9oP2XkTPOBWtLXaMixyiAuh9IbWvoMR1t2kmPKoJxFhRK7/L4ihN2O6DBxM5avfOEVK
         ok1pz+Z2akl5/7aTvDO+vOo2mrPL5uIEmzK4INT9gIceZZR4umPSsAVC9iScz083ZsXG
         GhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768192941; x=1768797741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRnCSJo0TmvquSWDDIrpEWk/wUKA+CvYamy20zcpVrg=;
        b=Mm6MumuC0iz20QgdpFlltxorNf60hTtwSSbR4GE2YW0eId+2qTwapET5BPyQvEVGvB
         Sm5ZaPUdETRKK5lN1U0leXOAMeEvSiY9PW4BLzQzfGV4sqwD0OU0hZvAWhEwWXMa+3G/
         iqlzR+beWRN5ZFvubIHnpRJOIdp4IuN2GsNq3aM7Vq/XrqgRJ9z+OqbakxVs52JucQ7J
         g2RZQfjWlN2382M9q6vJYIMRtEwjGHeO/wg5rG0Vcqk95hCTtbQK2c96yEmsyVgUY1dU
         OO+xDBsSE7cUPb/gjDB+Rdw/DE+La/+sMtO81BAgU09koxswk3bVLTK9MOPgRScyZ+cp
         AtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnhL/1+rsgrpl0JRgBaLe1D3MKJ3ppJ7ldNdCvgL2N1vTJMQny70iu5uK8sHX0bGTZo6tKKoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQd7m1ADitFc8aXfhaqcEMIihl2nAQl0fDImeTDYW7pngzRQwZ
	XzNgc13zP+kbK9tmVmmpWZdxBnokxUpVe6PyNV8bZp0oGW2fe555dUpZz0OgTe7gMp88uLdaxBT
	ILy2BWDwSZhIISvfOY7THWp7XUHbfoDKFZK3af9P2KMbFnuLD6QgLddP3mQ==
X-Gm-Gg: AY/fxX6YAepvRTt7N3AmLjrpdmHDsogdBgsPWQik2V6KJmUFp2VY4aVxzu33caQB+7F
	P2nUFq9uSTmiVnSdoeZ9aHDBkXG5tlAQ9JTh8cYUQZE+oJoK+HBZamXclQuq3KW8bAUKkuzC2Pg
	afoVFfof8Mkrbvlmj88Z0Ac8Ag7/uX0CRmQyxN5Y3JodNi5x1ThQXuZQyFyJTmkU0MuAhZdD/4p
	lTdAGON4YId/vLiOJs0wAKw1lPBJRCU416KT6WyLVes7Kj4TtWc8SDSHLgOj48eKJCSXHkmxDH1
	D61PsYL8jBdCG4XMYHkHY69zCCcXSgtkHIEFkXO8GIjNUma6RJplQkq/SF10lL/xMFckaSdgWpC
	bw9ea5vbbMdxnafkpmvLkkc4YoOjFy58=
X-Received: by 2002:a5d:5888:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-432c37767acmr20558553f8f.60.1768192940942;
        Sun, 11 Jan 2026 20:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGksWsEOp11E7do7kSJe9rVBAth4jOqGHv4mw3q8StsdQQPY6PxltAQTL2SJSNkU9vJyWdeOw==
X-Received: by 2002:a5d:5888:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-432c37767acmr20558531f8f.60.1768192940549;
        Sun, 11 Jan 2026 20:42:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm36985010f8f.43.2026.01.11.20.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:42:19 -0800 (PST)
Date: Sun, 11 Jan 2026 23:42:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
Message-ID: <20260111234112-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-8-simon.schippers@tu-dortmund.de>
 <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
 <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de>
 <CACGkMEsKFcsumyNU6vVgBE4LjYWNb2XQNaThwd9H5eZ+RjSwfQ@mail.gmail.com>
 <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
 <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:54:15AM +0800, Jason Wang wrote:
> On Fri, Jan 9, 2026 at 5:57 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 1/9/26 07:04, Jason Wang wrote:
> > > On Thu, Jan 8, 2026 at 3:48 PM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> On 1/8/26 05:38, Jason Wang wrote:
> > >>> On Thu, Jan 8, 2026 at 5:06 AM Simon Schippers
> > >>> <simon.schippers@tu-dortmund.de> wrote:
> > >>>>
> > >>>> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> > >>>> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> > >>>> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_NONE)
> > >>>> and dispatches to the corresponding tun/tap helpers for ring
> > >>>> produce, consume, and unconsume operations.
> > >>>>
> > >>>> Routing ring operations through the tun/tap helpers enables netdev
> > >>>> queue wakeups, which are required for upcoming netdev queue flow
> > >>>> control support shared by tun/tap and vhost-net.
> > >>>>
> > >>>> No functional change is intended beyond switching to the wrapper
> > >>>> helpers.
> > >>>>
> > >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Co-developed by: Jon Kohler <jon@nutanix.com>
> > >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >>>> ---
> > >>>>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++----------------
> > >>>>  1 file changed, 60 insertions(+), 32 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > >>>> index 7f886d3dba7d..215556f7cd40 100644
> > >>>> --- a/drivers/vhost/net.c
> > >>>> +++ b/drivers/vhost/net.c
> > >>>> @@ -90,6 +90,12 @@ enum {
> > >>>>         VHOST_NET_VQ_MAX = 2,
> > >>>>  };
> > >>>>
> > >>>> +enum if_type {
> > >>>> +       IF_NONE = 0,
> > >>>> +       IF_TUN = 1,
> > >>>> +       IF_TAP = 2,
> > >>>> +};
> > >>>
> > >>> This looks not elegant, can we simply export objects we want to use to
> > >>> vhost like get_tap_socket()?
> > >>
> > >> No, we cannot do that. We would need access to both the ptr_ring and the
> > >> net_device. However, the net_device is protected by an RCU lock.
> > >>
> > >> That is why {tun,tap}_ring_consume_batched() are used:
> > >> they take the appropriate locks and handle waking the queue.
> > >
> > > How about introducing a callback in the ptr_ring itself, so vhost_net
> > > only need to know about the ptr_ring?
> >
> > That would be great, but I'm not sure whether this should be the
> > responsibility of the ptr_ring.
> >
> > If the ptr_ring were to keep track of the netdev queue, it could handle
> > all the management itself - stopping the queue when full and waking it
> > again once space becomes available.
> >
> > What would be your idea for implementing this?
> 
> During ptr_ring_init() register a callback, the callback will be
> trigger during ptr_ring_consume() or ptr_ring_consume_batched() when
> ptr_ring find there's a space for ptr_ring_produce().
> 
> Thanks

Not sure the perceived elegance is worth the indirect call overhead.
ptr_ring is trying hard to be low overhead.
What this does is not really complex to justify that.
We just need decent documentation.

> >
> > >
> > > Thanks
> > >
> > >>
> > >>>
> > >>> Thanks
> > >>>
> > >>
> > >
> >


