Return-Path: <netdev+bounces-125951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF996F634
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374AE1C20FF7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD21CFEBC;
	Fri,  6 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx4YBsIg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2E1C9EC2
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631473; cv=none; b=sfwrllELOK4ZJkXen5Z7qqdsRSyvRwjNvGQ/YNioZhm27yLxvvEbNELU+88tyojUP5qTnQPcDNZjeBKcSY5k/gDEVOO9K3RLlpM1NRWJ8uJUe/gx8aw0ehSAeL3NIpX5/Tw+qERsLR2v9Kw5UYvja+0nfUgRJgvn+NCIEUuxinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631473; c=relaxed/simple;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhbgVjfEEBsy/rrBcInGO7ccRqIMJ/1t5Oy/wr6n29ZD/PBdw97d5yLjNA2FYZFn4j21gC062W0d1xPe6cqPU8wOa1L5WPiVY6uUTi5Spx6u9IusETYXL4jd0qzj9uoGdImQUW9ZQKwLPj3v+fSlB7ZSKbJpOvva2ZdPyQ22Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx4YBsIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	b=Vx4YBsIgzZWwm5LHkZzAsX8POI0wfFGZyMiTYtWnKimj+iNwOovhqNm1Ni5xyJXllpCmjr
	tXDnfL5/luN3xPXFi9GsxdCDbQNgSjcWUHR+3EJWLLFt3X8ta8vIBTJhh7bYSklr9XrDUe
	IJ/TVOXCC+av7OVJqvoyMWjjjBgBjfQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-j5_w8SJJNOeXxwGujVY8IA-1; Fri, 06 Sep 2024 10:04:28 -0400
X-MC-Unique: j5_w8SJJNOeXxwGujVY8IA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53349795d48so1922292e87.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631467; x=1726236267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
        b=rb5kC/vasmWvCIODQdntE/uOjEAoVI1D+25iFo2V6lrxeUhlgpmsPC8wNTVm0Gq6Ja
         kzIuWXV4Oko1VKnsz1hNjByvxGdzK0BnIpMPT6iAf5LC0WwNyEeQMnwhcRL8zFO1ucjW
         GwQFyy19NYy8iHHMPNZv3wP70nHyYShImRSUDrEkpGvD0CuT8dBCWC336CofLzjuicFm
         EQyt6q54kyGCnmSaoFKIvF+4Q03RnkCUAlFnuiCxvPzasoWKTJhIxTGLxChStgUeyMlX
         yu1ZRfBpCLQDBsKX45okEF1kj6mSTIm293/WnGSiI8EKj0BO7GX4/assSwaCYNSDlJq0
         3OhQ==
X-Gm-Message-State: AOJu0Yx452i73dhOEKxFwDgWcUjWTnhZxuHEN7518ANe0KKUrGQRcbKt
	xoPiQ8XaHV3rFAwoWa9BP00xOD3//556SLQ3fQzDajbcbVVp4gYItmOrbA0rSs8bNN2mWlPFxaa
	7TboSbaECySeSiMlGqoStL1iKVRYHGxrACUdkbIFKz84LLreSNTqvRQ==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676572e87.38.1725631467071;
        Fri, 06 Sep 2024 07:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQ5/38TKV/Y2UqEsgT1myno6QGvAIBzgZWsQu6maWs8a2tVqrqi7GmjJ3p9IQvBhwQGLDzg==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676511e87.38.1725631466186;
        Fri, 06 Sep 2024 07:04:26 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cee8csm21366785e9.21.2024.09.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:04:25 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:04:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_xmit()
Message-ID: <ZtsL5+/aztO2HBuR@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-8-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:35PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


