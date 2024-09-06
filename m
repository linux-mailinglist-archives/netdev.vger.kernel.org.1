Return-Path: <netdev+bounces-125913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284096F3FB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3609C1F25558
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951971CC882;
	Fri,  6 Sep 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZqdgOBs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369061CBEB3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624300; cv=none; b=P6b73hKmOn7lnNlBfMY7zI4Y2IvG0NXzuC+/jtnw095gd8nxq81dPWyEQlWisdPwr7Fq/I/m/3F9YY4BSoce7i0whoBqUhHHVRcAp7osRojwW0H3PusxP1tucqMb4KZ63sju4tRkjJFnOtMuzYY4WmDxIZQhTYED/Ets4a2wVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624300; c=relaxed/simple;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7Dj+tpLffMMLjxEiwzbqef22z25tYpWdPsVKBfk+QHLrjEhDRzViQQAmPbYQrSvulHxqwuKkb9CYyS7Q0V8xRm7ZZw6lFH3nyPSUek3FpDwZJux6fEKC7sbc2eBugZ+lIUl0KHApQM8CboFV9GbUxq7a8Z8s+5ApMGC/om5RxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZqdgOBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	b=eZqdgOBsO+QSQzGPy1MC8F+My2DdP020oYUbJCUlHfM4pgwcv7JIBECCvtFQJzi9o3pjTC
	0bfbE9EJ4Yh11Mvj74kIsiotAOjn6ciZSWKhXTykv2JwlNcc8qtGj/jfpiQmS1YKUKEGxq
	e6rGagNcD2d/yB/4h8vlwVNOYemLBJ4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-qHZLs44SMaqC9ikjkDyELA-1; Fri, 06 Sep 2024 08:04:56 -0400
X-MC-Unique: qHZLs44SMaqC9ikjkDyELA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-377a26a5684so1043390f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624295; x=1726229095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
        b=mYMCYwUo+8OBERUP2VBy3Ncp7QmWi4xMZH3mxaFdtx8tjeETm8ng9uXDZfgbHCjeAX
         NSG3UtFpz2eBzL+kr8u7k1ia1QcGaQEuM3ejxPcrLNZmPVpEm5vSaFtexIs4aF7X0/Le
         MOpD7zGsT4whEFYFkPusrZ1PKrIDkrHWdKP0TEN6DdNVpd0Vq9OxHVy5gZIRsNEu/W55
         HvtsesuhlvVkGmJglQK9GK+wffrHFx+8O1JyRYtdSN+PTlG3uTLEZIZqtktTvuBjnAc6
         5SX6NcZDFDnQNRwv5sSDh73R5u9hMRL4/Np+tEUoBzE8WgMK6EI1mYLebzl9iQNV+3ie
         1DMA==
X-Gm-Message-State: AOJu0YwvyxpSX1wysTihEcQsVT8Pmms2T7F+axvrOGo94Oz2gH0SltF9
	chE6m4I1YDBgdTYTpISaZmUxa9uZK/oaMCAYEga2aVGLvvTvM7n5wkUQ28P8+Q1z4YO9wihIjUf
	T+d1cLdaYgOvy0gcBGP6NW6tAGGH7qXopBGg5PmS9DnZt10KOFvmH4g==
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662834f8f.46.1725624294907;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbR87w40KjGE1b97gvsYds4sMcM1bBpW/FoDG702Xq5HctTZU+3n1iB0oeDTTrGblPjEdGcw==
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662799f8f.46.1725624294075;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bde83ebdsm16914774f8f.48.2024.09.06.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:04:53 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:04:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in
 sctp_v4_get_dst()
Message-ID: <Ztrv43ZxmgQRW+Po@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-13-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:40PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


