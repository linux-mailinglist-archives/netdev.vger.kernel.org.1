Return-Path: <netdev+bounces-225804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04292B987C2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218071B20A64
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461026FDA9;
	Wed, 24 Sep 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvRQHn7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742026E165
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698328; cv=none; b=p6Y0lCo34iRmjGcD4Rn7CyXhz/x2mYv200v2zeGyq1JhatinWGbH8PLhn1tlUS6EEazMvpj8kx3ZuXSyhKPBijVCzUVxZ4ZZ7+FE2+Ub0+eN/4e2fY55JZdMAOgg7kqd4umITwfV26Ltz9QGiVioYAjxKJprlX3xpO0EpjVJMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698328; c=relaxed/simple;
	bh=vFGV/5SdrXTqAjDg1Z+qtUf7lXuT4QgHCPVLjdBhXkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7fO+CiLheTHW4KYEN3RwGEassoDs3Q9MWVwEsukmH1I6CJfm2jo7GQlBkKLt0RG0erf9iMM9oaElz8YDZ7qDsjnVM415BRsZ5+d5SEdhzssQXRjU8pN99n3DmyH/f5CEIQjPZWtfxe3NT1hzSAUdfDRcXh7wEPyFwXmY2myyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpvRQHn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758698325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
	b=BpvRQHn7cNZq5pWuP49RkKnIJZSwSvxbcsKmuYQldlXbAvde6XqEptmVyzmZH/r09K5D6H
	+7sgFaxferELr0RINM2gvyMLzHBOnWvWwHhcEwdmK8ResiqFRH9VTfBpPHIKlCUJ1AdI+E
	UZBC0o+0lzXyX8gB/7//m/MCdrOGCes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Z7QgNu6PNyacjYUgYKum6Q-1; Wed, 24 Sep 2025 03:18:44 -0400
X-MC-Unique: Z7QgNu6PNyacjYUgYKum6Q-1
X-Mimecast-MFC-AGG-ID: Z7QgNu6PNyacjYUgYKum6Q_1758698323
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e19ee1094so23831675e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698323; x=1759303123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
        b=OQoCvBw1qAwn04cmZBbOda9fOASNz+HfLrD10CdNNFRR8kcP2o+v8+ynH5pwB6Euiz
         AdAoejGXd4WYaqmFEJfTSJlBeMiCkj1M/FYE++Px1uVg6qakPy+MiAEjYexdIc7ns2IJ
         UdXQl7j4vnScSC4wBjfCpsphLvAsiDXJGmvZ8BpK1Ib05ASNuw6evmXnv6tM0HEAYinZ
         YAZ9W2U3iFRGnvoYXu0EMDW3ZFaC5Qm9+CmZBeCe15DfslD3FD0K4TWa/plDXCUmlYvA
         CGe6Tp7mK08Oscci8h6IzC8vTVul6QHPgp66Uf9LlQUBTn/IV1UAnQVc5fuZL3AzA0A/
         5w5g==
X-Forwarded-Encrypted: i=1; AJvYcCWJz0CfTSmo6edFjbpr6+24FouhKLU4Er8bJ1i7abcTjzBNkbPO5TsQRJTM+038i7yRx+HPBlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41rUPqnGdEBNgiO+l8n7BT/YBi4/nF/fzR4AFN0rkiYI4VQ/L
	nNblTsIEnRALcsc22bV//NcQjsXt2vgUU1XDsPsCl6NJM4GSQIPNegdQXB1bvLA9G9innhpnFlS
	JsS48DgQ30tf4QTQsxNLSSkPhsO7N2OvEaK512TJgDbpirFxkrJ01XrdbMqe8OsyUKw==
X-Gm-Gg: ASbGncuueqEaWoISrLBn30UbVHf3+GpDW2Uha76z3RoELuoJB0mBAKsefRAjuo7e5js
	Wz954MquwXmfaAx8idh22NL7vaZEP4qwDLRBE2VulxD+dfYhlCh58/613/ag23jSJKIt2ms/Uce
	ScADNf+eP3V85Bd01f2vE17h8xjbTgN3xGKwVh8m4KC6piaMKsb4ybIarJs4o6M8GupFYksNZsP
	A0Me6QKrKl1hBN99d7JoZS1vl/WemMok+GCxyIjqpS5utJ3X8Dx6kPcnJIBDGfo6VhXklqXRXef
	Xn4guLgT2WoStCDGmE2Ts5KJjZUIf3Jvky4=
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641455e9.3.1758698322526;
        Wed, 24 Sep 2025 00:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSI2vy3Xtfu4Q9BvlHbV7J5LuaePh9VoqJOvv5JsIaLhsTV8uduTMFmV9uZ4PhlaEw7WBrw==
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641135e9.3.1758698321969;
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b1dd4sm18905645e9.8.2025.09.24.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:18:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924031105-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>

On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> This patch series deals with TUN, TAP and vhost_net which drop incoming 
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped before this happens. 
> This allows the connected qdisc to function correctly as reported by [1] 
> and improves application-layer performance, see our paper [2]. Meanwhile 
> the theoretical performance differs only slightly:


About this whole approach.
What if userspace is not consuming packets?
Won't the watchdog warnings appear?
Is it safe to allow userspace to block a tx queue
indefinitely?

-- 
MST


