Return-Path: <netdev+bounces-125912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D658996F3EE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1091C23696
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E71CBEBB;
	Fri,  6 Sep 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCbbTZ4Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91C1CBE89
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624182; cv=none; b=qRZZSCNkWxHEvbQ4a3ODKyEwOFExDhPDLGUb/Qf9UVP87I8HbL/FfFtZOABJdBFLCwc6fHInlj/HGzlDD5kC8iaCuY6vgU95BrkMdAi7AImbpD0UWPDEFgn+4JD6IP4iQedxgFQvIhsnCJxOBoWI2s1t2LSugjtN5yeVIHTqilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624182; c=relaxed/simple;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGFWp+TAsC5Bk59sV5AllrOBIQ9P2utpcTZ5SkKwsGNo6QiyAJgekgG9oUkhC7jjTa2suW3xLcdDh75vsu5ue9nbAb2+VAuoYn9npyzcWMJEo8FBhn/8qaI1qS8JFkDmubZUuTBsZ/Qm/kTjfd/UHmW104GRtEm3vTuSnoqe2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCbbTZ4Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	b=cCbbTZ4Ypxqo5mGp+SjgEHdXAov3on4FYCa67PLCOq8NNDQLZYEPWrYjWOrtaIiP4VvtZy
	CXyRurLUNibPRU8z7erevNXQ1MdGNo9cX/JwF15MpqGtSRxWSEmhvfQGRJaG+riUmx/+D6
	FBKhjmRp7LU/XMAhYd5qn+9uP2VNqVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-29HVRMCaPiSwXH6giycrsw-1; Fri, 06 Sep 2024 08:02:59 -0400
X-MC-Unique: 29HVRMCaPiSwXH6giycrsw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb7178d05so15916435e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624178; x=1726228978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
        b=dsiV/Eza2ZF5g7kfogVw6cO/jZ+aTqRtKUptP9ybW0z1cFRlBik+BRCPdItCjMWSoj
         nFVg/IFTbnFwMCAfICTm+5xf5g2ZIBLqpTV4JCWijUjguf9OEKDNttXrxU1O6vUQukN3
         buPQV1S2xonMLCzDJIxAywCm1+LqHDiP+obKtOlQZKwhbLBgMT9vZnuEjZHTpEWhkM1q
         LVPqosnAMgYBrxq2A1JRPpNnx3CYL65iZF0MvH/00YyOlS/Sh/432uGBe1lyy8h+0O/4
         pxgQfxz7rJh67x92WDAY0n/3tBVL6TClhg7UCqAeuiEP++2EFNkVptmgcqjhJaq4CGYT
         x8XA==
X-Gm-Message-State: AOJu0YzEO6UZ19c7MToBu+aEGblfZUf18c2hXfdgcSEjn3wRFQg4l06F
	XlbCF6IsKA3dvXEj0mySeDjsRbKBlpzKvKxHmf1dgETJi7/6FP+nPguKL5FrQP6WMt3t3rWuWpY
	N070pE1JHh0KmqrQFWfLOoQhLhAJYGvdlCYeYipG4wPr30DnOflxwHA==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855455e9.24.1725624177994;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoI0DxPX/u6R3aYPAJ18qh/X+91B4iTbd+r7c0r2GHaqUyL4q8mSemuf8LpPqF1l3DBpiAhg==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855095e9.24.1725624177430;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788dea8eabsm1004604f8f.114.2024.09.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:02:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp_tunnel: Unmask upper DSCP bits
 in udp_tunnel_dst_lookup()
Message-ID: <Ztrvbx3qzXI2VCN8@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-12-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:39PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


