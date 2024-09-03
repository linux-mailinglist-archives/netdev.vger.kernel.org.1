Return-Path: <netdev+bounces-124613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981296A35F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4831F24173
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E31DA3D;
	Tue,  3 Sep 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvXc2p6F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097042A1C5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378887; cv=none; b=VZkDZeD8/Ozq+2M2FW0DgXWwx6mIhOypESFKtPoelXDVLASaF6luPJE45Tjs5YCaaCfOCs8/Vo247v78RydTiThTunPXk5udK+7VEW7zH55CJmeNzc8eptwfHr6klTPmCb0TSzuAM40EiKYjBqm/H/ucSCYDwdIOwmeCqTtw4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378887; c=relaxed/simple;
	bh=jWmz3+gD/jm9rpRBMYC7WWVR+9QsOWmXHjfISGuBrZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxbDH1DEGPbsv8f0NvRldOii22IJEP+p9m4Pw/gUYVD3G50inf9L0ZeZ8OBe+fKSuLO+xtp0dnxjYtaenCZYOJw/Jv/SxGKKtodSiDczl6DCOaI2OfisqGLADDPcpvB0tYzqmwPeRRNTzIK1GU/kiuepeag8vwdYVjxN/MNV5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvXc2p6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725378884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jWmz3+gD/jm9rpRBMYC7WWVR+9QsOWmXHjfISGuBrZE=;
	b=NvXc2p6FfTEOvcabmGSma1W8F2dkgCscv36bpTn7YxIba3CO4rLVxNQ4jUeslhajKcg26g
	rFq5w+j/RrKXSu8xDBAxS++VZBTNSxXJWuWfm811UE5E+T9jHqwR7UcVKupjCHDarfk+o8
	Yr1NHv49vyYjLbwiVUj3HIUF/0Lys6w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-UkQEvqvnNwawUZv3ik8k1g-1; Tue, 03 Sep 2024 11:54:43 -0400
X-MC-Unique: UkQEvqvnNwawUZv3ik8k1g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb68e1706so50702475e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378882; x=1725983682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWmz3+gD/jm9rpRBMYC7WWVR+9QsOWmXHjfISGuBrZE=;
        b=hm5C/H0ntaxh+dMxlskI3L7RO8GrER+EHsl6GzW8DuV/HhB0gVs0CsIozr+JvpF9ht
         Z1+iSvFEyw8lCtmuFkrZLt3ZS048roBIcAqX2scjDHq/Vnmq1s/tDySxojCduWhitPqm
         Gn6JBYRyVVQzw343i7QLshkoSKFdJW/4ftDE+gW4j6N/dLkItE251gNwZIoTtmjnNnjy
         068ptVglzobEp0l5sv8GX1EREL+1mefSPI6d+0UT0NR4n9lHmPuiQ6udP2otXsNH3YYz
         9ARrRjUoYruWaxbgHcfkXU4lLKqIwiI8J0wb6/RHbnZb8MnqW4cSPznE6qVpo756XWuT
         T/Jw==
X-Gm-Message-State: AOJu0YzVUpoG0pI1mXOktriCSF/++dyBS/2obRNE9W9HHkQVMxnD39G6
	IjWSoo/RIy/2gEvhInEH4aAfYzltX5fjvunnHy/NMRFMqmJ7zr3GktW3aKh3t0pBvyqUO/5uYEw
	uyh2NgwQbIqcqrts0RGdb8T823Q03KHzbFZV/ieUQK1aGi3Vu+w01kfn9G1widg==
X-Received: by 2002:a05:600c:1d1e:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-42c880ec5famr35256805e9.4.1725378881806;
        Tue, 03 Sep 2024 08:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWQxl6OXPmIx+uulPWXW3RwAEXabX/qXr4o5+jYRgrBI5yVndamaHgSzq8Pv9CUGOPXaSRaQ==
X-Received: by 2002:a05:600c:1d1e:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-42c880ec5famr35256495e9.4.1725378880960;
        Tue, 03 Sep 2024 08:54:40 -0700 (PDT)
Received: from debian (2a01cb058d23d600f5dfa0c7b061efd4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f5df:a0c7:b061:efd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0f36sm176086545e9.16.2024.09.03.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:54:40 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:54:38 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 2/4] ipv4: ipmr: Unmask upper DSCP bits in
 ipmr_queue_xmit()
Message-ID: <ZtcxPpXD3sqxkwhq@debian>
References: <20240903135327.2810535-1-idosch@nvidia.com>
 <20240903135327.2810535-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135327.2810535-3-idosch@nvidia.com>

On Tue, Sep 03, 2024 at 04:53:25PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_ports() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


