Return-Path: <netdev+bounces-125900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC9296F2A2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80C3284EB7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148AF1CB332;
	Fri,  6 Sep 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1w0x/uQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848411CB337
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621414; cv=none; b=dhjtzEovk6JzmD/legYOsShw9KgVawmjmoWCOb8U2wQUjOpLlCfUlZ3gpWpL55cQhTNGa1N1DsKHIsyxyRZ52zGSl3v0JfFW0yEivadCLXaUn2D8lqIwCnFkM9rYtwMUL/oXnKo+otyYn2BVWLG6bCv1h5iY5CVhiBuNEYf8rXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621414; c=relaxed/simple;
	bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knh/NpJKR50rqs9MZL2NGO/wf/kbqtokYqzNIekjyC9TpMM4b748ckMmaxBYosOf4EQg3vf+w2pNiRBxIc5YLmQNK/Gpv+yZRWTnYfrUl56LZQ7rlwtEwm6PcII19yl5icovGpf+yfXxbucs9SX8Bf8R80tp/vueL2IA7Kubqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1w0x/uQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
	b=O1w0x/uQJNK3dblmr+ObGyemkQigF3IC1AjNrBoKWG0mKap/3SRvEX7PxwS1BhCFcV6nGG
	fWyvZzGz9bl+Xqh0Yxm4ATZ67I9LlVqs3LyNPMdqI6puKBZAhLuZ48grTKKyTQ1pDzKH2T
	y7bUuAVd5gP83JMdYeeh1svtvih17hU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-vD2K_bzAOGWv_GOhFW7yWw-1; Fri, 06 Sep 2024 07:16:49 -0400
X-MC-Unique: vD2K_bzAOGWv_GOhFW7yWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374beb23f35so1263362f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 04:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621408; x=1726226208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
        b=AqPnWewO+Bn8y3RH6sOuQAoWh+RFfiYizcQHYZQcyzPJybS/oeSd90K7s9rzzwAAyG
         FJkUQu7RT3GHbZlQyFUPDwpuFWcQxUXLBqClUalp+5bepyh1+a6BN87X8r284fHICz/b
         XeKpw/H+LuryzGBhwi/dI3op1Qz0TICT43EzFGXvrRCICYNA7M04n1zQjmTtOgY3rli9
         bK/Es1LWVnHakx0nLwFVKlvNN8lBverN+iv9p2EoqzzspnhaoDlGeCqulLJIOLtRfkl+
         duwxCLyspwaqUDFD/yYD4r+PXzLmruBDvz076OAhl/FVKQX1jbeu2D+2h77y8UvaJn3k
         okNA==
X-Gm-Message-State: AOJu0Yy/ertPPoBU1WUUJHmIXqNi3fCO7PnS9dwOFka6nAUsaQtoaxaT
	voAgOVkxURCEjPhSObsUIUaz8ii52t71D0S3ZDkE9d73B7R2avlJbbg/UK4gfuiep24SDxkTLLD
	ERAq4MmYmoDSI5AUVazOLqMDYmc7iAq+T+0sUjeP3QI2EAisflIo0HA==
X-Received: by 2002:a05:6000:50d:b0:371:a70d:107e with SMTP id ffacd0b85a97d-3749b53169bmr20678070f8f.6.1725621408235;
        Fri, 06 Sep 2024 04:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPw/OgFFvEdcRZzS4cx+Sw6c3PFJDCcVrZn3G7jew1sCdpWo1/ODYEzc7WVrWFytZcY3xxPQ==
X-Received: by 2002:a05:6000:50d:b0:371:a70d:107e with SMTP id ffacd0b85a97d-3749b53169bmr20678030f8f.6.1725621407632;
        Fri, 06 Sep 2024 04:16:47 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4981asm21687261f8f.24.2024.09.06.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:16:47 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:16:45 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] ipv4: ip_gre: Unmask upper DSCP bits in
 ipgre_open()
Message-ID: <ZtrknS7zKAKP6g6l@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-3-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:30PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_gre() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


