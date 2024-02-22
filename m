Return-Path: <netdev+bounces-74141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA32860368
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 21:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2821F24FFF
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7C6AFBE;
	Thu, 22 Feb 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S21aCnUn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9166AF86
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632172; cv=none; b=V7fHWIwXaF7oPddCB3hoMBlSHIH3K7Ix/vV6t93GLKShd9GFQo/ERgjQS9FYKH6bFsVp1kD03Y0QgkgaglBCNYIBoRvQ5Y0EdOXtvE9auFUQZW+yckjgOPB/EjzT9SgGCaT74oWyMg6Df8S55piSyv5KX8fEgiQxcheeLIP/ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632172; c=relaxed/simple;
	bh=aknFNqqxJry03mMtGqJFoI/wKDCcG2OQaTtQxGeRRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k02KehHdSFBAMbgsbL+7RTLQjyMmloA2wdd5Wo35HzKvrfM1TD9iwEYgstzpY43E4W/EA7hs5nKdYgDIJik3nuvni0Es+N7nfE2zcYyZl0QraUVo93vjxv500TN7H0c9ZZwUE8ZiN6aYiiyP4zblwuC3R7llu3tvmyxK2/JHPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S21aCnUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708632170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
	b=S21aCnUn86z6lXnROnz6zQFhwE5wuDStvNT1sCROM2Z70fZqVSHvuHIrAyFWq/7YiVjccF
	DbAlzjUedDj3lydIfnqqEEZgYiNYBuF/fLPWms0Cc4+kRlj7OaGOL0PoLRX3Trg7IEuhLu
	DLDebTY9YWvPMDA6dbJSn9CbZmBNj/0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-IUYa4SznPkWVfIEyCzrO6w-1; Thu, 22 Feb 2024 15:02:48 -0500
X-MC-Unique: IUYa4SznPkWVfIEyCzrO6w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d4cf786a2so46314f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632167; x=1709236967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
        b=SKqCF2XDzl57y9EOIZuXpXrtGajoTK+z218Nx9t8UX3X+YYp6e9aplZSrMIk20KDDY
         nfcZ/ToykqyXH8Z/5uBP9fTK6vNa4PXveQ0XeDs9GCxHKaMhuHCNEvI5PTIH4EMPQZaH
         3kjXNN1+YY2mpbrLqouN0+FaGZPNfzQ4RhJrQw797+e02fjGR4SYZks2uIsipWPioO0j
         8KNlgIKM4lGlJyUo0NJwcTn+CCcGpHeQfynsUvsfUooqEctBZrmXSJrHvlMYVahvSVwX
         4kRuHUfyvhJ5ErKeBbENqfYMTO3FHCidQ7dgEUqHVj4nyo23izIgGPCjiQfKICrCE+f8
         1Mhg==
X-Forwarded-Encrypted: i=1; AJvYcCVApgSRUe7sURgeU59wOkW7gVrCS9VXLquROE3vNvSy27FFP5ErEsEJ9kem1Sz82x6V6EvaYDqgyV/oISaW0Z9jrW9kEO/x
X-Gm-Message-State: AOJu0YwGA4oqPMHZDI5OBMBAUsHiqeSynZBstSxifyZdxia5HaY6s8En
	u0jng3kYGDbl6oJyxQdw+QGtKgZ7zqF9rrRuwIZrofImdP/M06bkYQkm5tuieoJFS7VOKtI9gls
	cfwzVwXAXwKSCA5sUTp7tSX6s7K+ld1QDuRudtJsDBmNomc7pDAjlyQ==
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114024wrq.18.1708632167130;
        Thu, 22 Feb 2024 12:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGY5xEB+oirt/8WYolwR+t/b3r7Lw8iYBr645QsLpjupov8MKzMLmF73APkFMsTjyAiTEk6A==
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114007wrq.18.1708632166787;
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004128808db91sm3049224wmb.23.2024.02.22.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Date: Thu, 22 Feb 2024 15:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240222150212-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
 <20240115172837-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115172837-mutt-send-email-mst@kernel.org>

On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> > 
> > Qemu options:
> >   -netdev tap,vhost=on,vnet_hdr=off,...
> > 
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
> >  	hdr = buf;
> >  	gso = &hdr->gso;
> >  
> > +	if (!sock_hlen)
> > +		memset(buf, 0, pad);
> > +
> >  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >  	    vhost16_to_cpu(vq, gso->csum_start) +
> >  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> 
> 
> Hmm need to analyse it to make sure there are no cases where we leak
> some data to guest here in case where sock_hlen is set ...


Could you post this analysis pls?

> > -- 
> > 2.43.0


