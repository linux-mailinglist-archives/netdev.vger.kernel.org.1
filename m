Return-Path: <netdev+bounces-120627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCD95A075
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B4284095
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C31B250D;
	Wed, 21 Aug 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDuaVkYW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2253199FC9
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252015; cv=none; b=LYfq2z+9anFt4sW8GJae1p1OKU7rCWVDX6hJGRSia/pKr8Jm9goQFmftkXR5gmz/sg6d+YqX4y9HCGSzUEyr86EzL9LIwKJpI9gmxxEj/g7AIw6oQv30ve8EUBS7o7yPPkAwfDfgqNVC8Bk0WYqZ8gcB0TLRzMh0KVmgaQm2oBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252015; c=relaxed/simple;
	bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kij5SZ5JO31EzcLVu2Thz1G5Vr5nwvyMTPUux8Ypv12LCnF+dmHJQHQ9mLKYSoewamAZONIqgTBZfxaho+BznCnfNlYCXwnzrHUbbrYN0zaCiR10OB7I8ufIyZNnRbCvEIlgEeGJXfYeIM5VkYwMyECndXTRzkqZAYrRk++jG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDuaVkYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
	b=ZDuaVkYW9ebhghUiNuCuqZJyS7A/mV8zB9NP+pdRhtVsAIgknpS/GM4+lJGLvbs4eM8WG7
	O0sRYLyfkWrb2nwblkzNWWgL7J0DMKYHxU0TiAvqsrCgfuV0GgXQmdmm7iB1yjb+T08aPx
	Prhdapyxb+Omb2JXMAEKOvfoLiehW/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-f2XUDNcLPxiv4kcibEKlIw-1; Wed, 21 Aug 2024 10:53:30 -0400
X-MC-Unique: f2XUDNcLPxiv4kcibEKlIw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718d9d9267so3443193f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252009; x=1724856809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
        b=W6OokH6HctGYIcKU96M5vm3eZ55R2cJu6KVVzbUx9Z2FwXm1LyjHQP568MOtAC2+8G
         EvGHYpBSsmtnnnNd6nzqG9hLgCfzRAFeqhUDc6dVM9DsCGnhDUd84g8e6HST/vtAEU4Q
         4s31Nn03tfkdKnvZm50xxWkYmkYbi8UnZOSRvdI0d8D7mwnhs9uxPWLPAs6phE0Tmoo0
         7/q8sc7mrE4zWQ8aev6rxHZxfgwssMAs6S9ankOKAOrHKi46Ep0g2zd4kMPcpzMBwkpv
         SA2DPF1VbXBnXeKk+2GHfqfJncuogFH3R/FYZBK+EHLRUwbDmSwsPS3Wtofz0Wf+n5Ni
         0u0g==
X-Gm-Message-State: AOJu0YyxdxO3a9fTostIQ0bb58Id2DhKNeet7MYjCzKtINuoDlqWZ83H
	NUylzKkmkn7EVKzWxDxdZNrDRHk05U7Rkay3j8N6DCpbXeW3Im08jbTcFpwe3E9ZxeGNtscTrJj
	lSBwBNqZopRJafgdxbcOJ1mBEMmFW812nx+2CCwcZ5Bfa76e435djxA==
X-Received: by 2002:adf:f892:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-372fd70ce60mr1529928f8f.46.1724252009418;
        Wed, 21 Aug 2024 07:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZDr7ggR+/eNYCST3LZgSsI550O5ufyI8DRdkzvxCJn3F00o3+I4ON3GXaiIZw6yjPzdqQRg==
X-Received: by 2002:adf:f892:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-372fd70ce60mr1529902f8f.46.1724252008552;
        Wed, 21 Aug 2024 07:53:28 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed91071sm29081695e9.1.2024.08.21.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:53:28 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:53:26 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 05/12] netfilter: nft_fib: Unmask upper DSCP bits
Message-ID: <ZsX/ZlsFqN3YnQ3h@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-6-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:44PM +0300, Ido Schimmel wrote:
> In a similar fashion to the iptables rpfilter match, unmask the upper
> DSCP bits of the DS field of the currently tested packet so that in the
> future the FIB lookup could be performed according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


