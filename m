Return-Path: <netdev+bounces-101071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B88FD21F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09301C230B0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C478145340;
	Wed,  5 Jun 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1fbtgLV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20247CF33
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602827; cv=none; b=ZMYTkvCcIrWig+NatC3s0VpMSReh3qgeEQ6XFTcahPte0nH2Y3C8DvbG2QwSTEvP81Y+JjzFtuqxQKW3z+IrmQmtmUF5ZABkyLy/Z6dSjYGj5Yry+sdCUVoGv6cDckaJvEtG9dLCfpDU1+pKtSHnYLxFuun+XKn6yTnl4fj1wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602827; c=relaxed/simple;
	bh=XMkqIUdRUDqDnjCj+FfnPhlp1HWqpbyvEoxs7PKN5pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTq9re6ej7b+0Vg8jhmtYehfe72539jb6bt6/0lio6+ugpCakMSVP2yMrBPASqKQmd6OmRe6TCVNS8ZykI+UZ856opFubK9jnbWD5MxAyT0wq4eCYCMcrYPIwOypFf5vcLx2Q4nFvndGfkZcy4kE5eM0s9qQdPFVSSY+nt4eTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1fbtgLV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717602824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEUUr1YH7ewe7AaucKGw3ExHptiL4S1eJ/EUXF1qYas=;
	b=A1fbtgLV2sMqnsFKiNLSgF2JAFHO1Xg+lE64o7F2UGZe3ps7r5nGiG7yrB+beY6ThuOm8O
	pIEAcFZgC+Ljlp/w6wnMqMMySRGft1246Vn4i7Ov6ZI8zAUZtQGMIoPNVa6ahxw/aOnbeb
	ME/SL1YkmDdSA22n19e/v1O9rqXK7cQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-mGWk1fKZNryYOHIkH1i87w-1; Wed, 05 Jun 2024 11:53:42 -0400
X-MC-Unique: mGWk1fKZNryYOHIkH1i87w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42135f60020so33445775e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 08:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602819; x=1718207619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEUUr1YH7ewe7AaucKGw3ExHptiL4S1eJ/EUXF1qYas=;
        b=IprNjRGvwpw6ztikC2m7XnodlP5wlcyZoF6ul32Fu/aO5eD1K2myPbUFJ/QW8n9H1Q
         A2gwf1i5meXaE9ezmYwNjvacIwGoAxLWj4VcRW9iIR9JAYFkydA47EeQXn6pYnH+irlY
         8k9/4Av2i6CG453X0XgORTCTZGkFTY6+bJiYNtRQjVPhL9SIzSIeQpCQCXMSzR1N0S3r
         GuhnFFfQCJNpkKTyUQmrdMZJeiExaJMK7UbNKkVOZkmGr+pL01NTAXi9b7uAWa9/xLue
         aYrK3o18g7jBY9XP5o5cfwbltEQRKfodVOWh4D2hvd+GowNDjWnlq8mVxF2Ur5m5YKpE
         WJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0sN7QvBIL8+ThBWI7hkFXYFjvblqJf7KJzFMyLjemEBCqgFPRTA+e2zay5e7j+HyX1ofl/waGiF6pVg21QBhA9S4iks7H
X-Gm-Message-State: AOJu0YyQVRsRKlZYbOwQrQg7Z5zm2yow5RuZe+t8cxQ6vLHtKV9p+fvG
	KxsDOUWhW3iCBo67xmGoF9sWNm+O7o9C05kh4e1MPQWK+DHzI6sK6l525/b0PT/yL5afuPrBKGg
	VrDYDzaaN/uG2ns/WXYG1/dyb4MvdzZ3Bm+6XsuJjwixDrLH+7CbWzI/A14Hy9w==
X-Received: by 2002:a05:600c:4f49:b0:41c:290e:7e6b with SMTP id 5b1f17b1804b1-421562e959bmr21593025e9.13.1717602819338;
        Wed, 05 Jun 2024 08:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk/gdZTPlLp59bUUIcBAGSKIvjMteQWFzUz17zkr2H/sx468TELSDcZhPFDmmvXXHPytrh4A==
X-Received: by 2002:a05:600c:4f49:b0:41c:290e:7e6b with SMTP id 5b1f17b1804b1-421562e959bmr21592915e9.13.1717602818947;
        Wed, 05 Jun 2024 08:53:38 -0700 (PDT)
Received: from debian (2a01cb058d23d600b0c34ffa6ba7fca2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b0c3:4ffa:6ba7:fca2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813c171sm25443755e9.40.2024.06.05.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:53:38 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:53:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <ZmCKALr0oxmZdW6q@debian>
References: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>
 <942dec85581305f7046de9021b69a8dffa29eaf0.camel@redhat.com>
 <ZmBqNPGtUA22yFQE@debian>
 <CANn89iKrqnzP9Zkq0r5S_+7i33edhs-B4WT7YLtv5f3brm_XYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKrqnzP9Zkq0r5S_+7i33edhs-B4WT7YLtv5f3brm_XYg@mail.gmail.com>

On Wed, Jun 05, 2024 at 03:49:47PM +0200, Eric Dumazet wrote:
> On Wed, Jun 5, 2024 at 3:38 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > On Tue, Jun 04, 2024 at 12:55:53PM +0200, Paolo Abeni wrote:
> > > On Wed, 2024-05-29 at 21:01 +0200, Guillaume Nault wrote:
> > > > Ensure the inner IP header is part of the skb's linear data before
> > > > setting old_iph. Otherwise, on a fragmented skb, old_iph could point
> > > > outside of the packet data.
> 
> What is a "fragmented skb" ?

I meant "non linear". I'll rephrase in v2.

> > > >
> > > > Use skb_vlan_inet_prepare() on classical VXLAN devices to accommodate
> > > > for potential VLANs. Use pskb_inet_may_pull() for VXLAN-GPE as there's
> > > > no Ethernet header in that case.
> > >
> > > AFAICS even vxlan-GPE allows an ethernet header, see tun_p_to_eth_p()
> > > and:
> > >
> > > https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.html#name-multi-protocol-support
> > >
> > > What I'm missing?
> >
> > Didn't see that. I'll post a v2.
> > Thanks.
> 
> Also please add a Fixes: tag

Yes, I forgot it in the original posting.
I added it as a reply to the patch email.


