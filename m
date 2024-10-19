Return-Path: <netdev+bounces-137226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF89A4FDC
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83ECC2895D8
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FB42A97;
	Sat, 19 Oct 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCUw/ZUz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95513635F
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355539; cv=none; b=Nx09UWimgSFch2mN+nDiYfAX5r701uiSI0/T+0W1docOmyIvFTsCwALRiIInjETED9S93tyC2n3CSN6Z+7jhuJ5pblauog5MVI3zcBbP7xbmaTgWDhiC3i6AO1rJSZQhwQMY5NisqReGaONNYibGuy1zUVKic9rjyS8nuyjej9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355539; c=relaxed/simple;
	bh=hiK14odWgJ+69p68S7Ex9WYiJtchHRMGDUwfV7v7LL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQvegCPqhYEhbXy5o+6gIsht0QafL1CFL6hmbp7SHomDmPq4NdNU0azGgQh387YBq7eii59uZUTCY+VbjcMYTNic30wjx92GgOW6yJ+rTrooAUEJB55ARKQTBLuZ4meCsR3VE/YBKRTlqt72gI5C3Y3hLnC78LpqlwIX5WhBsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCUw/ZUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729355536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jri3A5/LqIxor8N+KDtnG79y3WkHLfs7EcB+rulVroE=;
	b=HCUw/ZUz2LaB2SDxn1FTznyywg6UHsbipbviUAYGSB23/wDQ7PeyM4jrEqZapYTmNVpj/j
	yjdDMu3k5xEspZAwJSBhAL0Gg2BBWIkOKhSP+mEF5cOMGbCKtnseavfJjgdKgkXFA/8Q1N
	0b23FFy9d7VTDkO9nvI28KrT8pdXSsI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Tp4t5lWgMhWCIkovEUjDBw-1; Sat, 19 Oct 2024 12:32:15 -0400
X-MC-Unique: Tp4t5lWgMhWCIkovEUjDBw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d589138a9so1624866f8f.1
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 09:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355534; x=1729960334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jri3A5/LqIxor8N+KDtnG79y3WkHLfs7EcB+rulVroE=;
        b=qTmQPecW9pm2VLok5mcIhow27KopnDJ2iz7136m67q8GxBHliXbnEPWu2O72s2GvXa
         QDkG/gS09+yzLjeSc6Iwd7JytdUY9CQJ8xOu8Gx8x373PDPrGgl7BrZtP3LHjXsE57cP
         XT0jq611CnXuDDlPjRRBdmLr/zI5ixHK2y17nszLPXR0VRp/cEz2Kr/8fWVAhIDBZi7f
         C+2Dtch/Ry77bjWRNIrTFD0uLJZmfdRECoN8ypw9h9+P4k9p7i1Q2FD7BgjtaHdM0dkP
         Ei4x5ZwrR84c5UNPEv4uZ2EPRjcMzHaAQPkUo+YQHw+Dh+A5VEad6QjysUuNofgOrgWh
         TItg==
X-Forwarded-Encrypted: i=1; AJvYcCUF8A9+Bi37aeO8KQ/CpkCE9zYvWLtCcwcc5L7EknPeIrVVtXzQxf40oMYwIH0kjKr+JajuRIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOrx+TrYuEojhuT+ig5VIlGWvT1moyTZ1/bwPt7qb5KrgxRTb
	qvpASnq9qe395NLJZQv2CbiidizcZx1jQ5K7qx+WgGnbF7BDRdvK9ZsjH1K0cOlBG2KpMXy934H
	bmMuBu90kWzhYWvKI7AMFFvmokpRViz07te3Zn8JFLaWDVhn73Bnihw==
X-Received: by 2002:adf:f883:0:b0:37d:529f:ac1e with SMTP id ffacd0b85a97d-37ebd3a6035mr4053779f8f.53.1729355534326;
        Sat, 19 Oct 2024 09:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT/wgWyBLryARTXkB+NHtmMEQqhlYTSaiwN1r9L1u+/9jvus81e06CIrU5Ii8VeRCMc6p79Q==
X-Received: by 2002:adf:f883:0:b0:37d:529f:ac1e with SMTP id ffacd0b85a97d-37ebd3a6035mr4053764f8f.53.1729355533918;
        Sat, 19 Oct 2024 09:32:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf1193f1sm4820164f8f.103.2024.10.19.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:32:13 -0700 (PDT)
Date: Sat, 19 Oct 2024 12:32:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
Message-ID: <20241019123159-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014005529-mutt-send-email-mst@kernel.org>
 <m2bjzkeb2u.fsf@oracle.com>
 <m2zfn1a24d.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zfn1a24d.fsf@oracle.com>

On Fri, Oct 18, 2024 at 03:59:14PM +0100, Darren Kenny wrote:
> Hi Michael / Xuan Zhuo,
> 
> On Wednesday, 2024-10-16 at 08:55:21 +01, Darren Kenny wrote:
> > Hi Michael,
> >
> > On Monday, 2024-10-14 at 00:57:41 -04, Michael S. Tsirkin wrote:
> >> On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
> >>> In the last linux version, we disabled this feature to fix the
> >>> regress[1].
> >>> 
> >>> The patch set is try to fix the problem and re-enable it.
> >>> 
> >>> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >>> 
> >>> Thanks.
> >>> 
> >>> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >>
> >> Darren, you previously reported crashes with a patch very similar to 1/5.
> >> Can you please test this patchset and report whether they
> >> are still observed?
> >> If yes, any data on how to reproduce would be very benefitial for Xuan
> >> Zhuo.
> >>
> >
> > I aim to get to this in the next week, but I don't currently have
> > access to a system to test it, it will take a few days at least before I
> > can get one.
> 
> I finally a managed to get access to a system to test this on, and it
> looks like things are working with this patch-set. So...
> 
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.

Thanks a lot Darren!

-- 
MST


