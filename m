Return-Path: <netdev+bounces-101033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750088FD00D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0414294E23
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202B1991AA;
	Wed,  5 Jun 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDxo6vZs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDA19538A
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594684; cv=none; b=oIF5v9qu2oOQlBC7C7zgUnMdDZubiwLN4yxel0TMFIFwjc81m0JVNRuhwI/+7VZPWPVvr/wjyQH1c2sOWM9yKp3ZHR6/bhpXK37T+DnS8P0F9CxxYRAhbYzIv4SitAgeDSn01ocBk44IJeaIz4kht9Fr4r+PRb7v38OwI2R9O7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594684; c=relaxed/simple;
	bh=7Ukbld8wbbfMMmEvSlAke6dIL1ou1FnQO/yuJrA4p4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFIP+8f4lIZAcpqiqv40weDW9dwu9V8IsVsl8QDh7yR2l3Kir3gc6rwDcqCuqZZWAyAqCX5NylBfesQelHmxcT+dwqMdu2rffV0GeTLbfqR7XYCSq1/lZPOx1g4rmgof9NmnRpb2xEwb7FT6fAW4jqW0NBxKwIIGXasZCXZhO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDxo6vZs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717594681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5wZVt9qbLOqS7nWtuzzoZahF0VC1bxxd15JRdK6QGfQ=;
	b=aDxo6vZs60s9As0puikVXYfCarHpqYuhSP/wX/JXeQD46cPPAv/A89UeoAfYAmeHzHfLA3
	GZa39LWeay8b/se1QFyam5Zj4LM9/G8ORidKRxCa423/oM8Ks0KL4RicHsrG0zlruMMs33
	pijKUBl909yWMVfrieDetAejlSqvg9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-_oo-p4HRNietekw7AZCKqQ-1; Wed, 05 Jun 2024 09:38:00 -0400
X-MC-Unique: _oo-p4HRNietekw7AZCKqQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421580a28d1so4789305e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 06:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717594679; x=1718199479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wZVt9qbLOqS7nWtuzzoZahF0VC1bxxd15JRdK6QGfQ=;
        b=Sq+EyT1V0hWO6Ug0tO7dD4Dzh+fsN3lIxASph6r9g6lfQSc50dOB7H1YmVWcQm+jWY
         u67y/FfINK1bZHj6l82kPNjWQEaTbtyLQAz37rIwkoJSyndZqdzIaofdi6JoiRuq4jAE
         vN3D5IQc/ZTFOfWYmKntM+QhYDZwpGvOhMJs+7DINVjF25gfLnxF6ADnVClbn8beNGH2
         rAig3HrfRB7ujmoxyPTYQ/l2YmT2EJM5wnI/6Me62ZsiOUw1IRIuqPzhPeJUg06gnyGG
         SiVVBKK80sgjADFIXeM0O5caqAZduEh4ITpvOScZN9KQuSZwi2e0p4x+rKWbSJ6oCBPS
         MuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9C7Jr1eZRxnMex+eoX2u4+MxIGrra0akGH2VAoHeFgMeBFuADxzKRHdikt2spNuNUf3OzLLkjHtFTrlOIhu1snXg0B6B7
X-Gm-Message-State: AOJu0Ywyc0+VyWhU/qjDv+A8rSIcg4c580UGOildev2NRLgTmTgKRBYA
	/oYE8IB4Jpz1AM/HV8HuFvAraW+3H+mQodUDg6t6WZ2kMg3lcAx5VU4d8LO2h6M1GzztcDG9kdl
	OO+iOVoOrrxrFaY2sl3i25EbfVWwyQYGxIlXG0VZ1nRJYW6fyHeN63Q==
X-Received: by 2002:a05:600c:1c84:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421562dc3b6mr20178525e9.21.1717594678903;
        Wed, 05 Jun 2024 06:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZj+o86jYfEYsuyHyCzBdYzSE/Bcyq7nVwZnbFdSgyrM/EuhjKKL5kF0QXyXbHMcve2SMlyg==
X-Received: by 2002:a05:600c:1c84:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421562dc3b6mr20178315e9.21.1717594678464;
        Wed, 05 Jun 2024 06:37:58 -0700 (PDT)
Received: from debian (2a01cb058d23d600b0c34ffa6ba7fca2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b0c3:4ffa:6ba7:fca2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810826csm23020085e9.17.2024.06.05.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:37:57 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:37:56 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <ZmBqNPGtUA22yFQE@debian>
References: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>
 <942dec85581305f7046de9021b69a8dffa29eaf0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942dec85581305f7046de9021b69a8dffa29eaf0.camel@redhat.com>

On Tue, Jun 04, 2024 at 12:55:53PM +0200, Paolo Abeni wrote:
> On Wed, 2024-05-29 at 21:01 +0200, Guillaume Nault wrote:
> > Ensure the inner IP header is part of the skb's linear data before
> > setting old_iph. Otherwise, on a fragmented skb, old_iph could point
> > outside of the packet data.
> > 
> > Use skb_vlan_inet_prepare() on classical VXLAN devices to accommodate
> > for potential VLANs. Use pskb_inet_may_pull() for VXLAN-GPE as there's
> > no Ethernet header in that case.
> 
> AFAICS even vxlan-GPE allows an ethernet header, see tun_p_to_eth_p()
> and:
> 
> https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.html#name-multi-protocol-support
> 
> What I'm missing?

Didn't see that. I'll post a v2.
Thanks.

> Thanks,
> 
> Paolo
> 


