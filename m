Return-Path: <netdev+bounces-123218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF3964285
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF6283B73
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59919007E;
	Thu, 29 Aug 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpapQYuR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40841917F4
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929352; cv=none; b=E0uuaKbN/WRCSDPy7o89Lror2ZaHpK6amlzkFty4Hm8o9Let4v0wZfY/XqKMeKpnzmnePKv+FOo7RhRc/LD8rAn9c0CZSrURAMdjBdiICN4FHZ4cvYmLtO2A3u+KSIfpXaKCwL2O0olLGMIlfH+kQty/Xh8iQbILqUZL9b4sE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929352; c=relaxed/simple;
	bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THAofzxP7RGa87yvAGi6Fv3Tbjn739MoBGjMfkpRFPuqGLasRO533OOsHoulMu9IhQALVB2Dv90IUraSYUfjl7HYe3MgPgGkt2qECj1MnkNMZlieu215/x4kMeBi7ZUm1dLz94xq2AVIL1Yu+hP9UjfmFkWehNyRDwUGr+yswyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpapQYuR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724929349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
	b=cpapQYuRzx14TH478/t5ab9csQzMzuB5u+rN4ydl/IOFrZWOjQ0q22zacxITUk+R/X5P7E
	7GXNjtUawBS9Um5jH2DNuL9+WDabWTsA9StWGrO8xzE/hMdJq2OdVAYD+36pz64AKqx41R
	LEI96amqfksDOpQ3OouEiA4pWX9scoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-9NOYBZ4BNm6SVmLe5dlwfA-1; Thu, 29 Aug 2024 07:02:28 -0400
X-MC-Unique: 9NOYBZ4BNm6SVmLe5dlwfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42b929d654bso5441305e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929347; x=1725534147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
        b=SodUzdX/10+gbqJfcrPt8EFlDM8fOOKABNxQPECdCkYlkDSnAdImtak5+XBfyMaFND
         xCIJz2p03Uw2LwDGKK34p1AgPuG8fsZ6HJJuhEmuLHGtsJcD/3LHjRTuHumKLFbE18EI
         kFsrcJtpQ0AwvSh7KrqHqR77f1F4YnNNxNtLj2I9S9WtkMj+xwLd5vlYi9pMekSsi6y+
         0VSbKdIc/Wd4FbSV9dFBP01eOShrsc8y6N/9YsohjU0BDDOn8EYiqekvZjTYU/o0Horz
         QzC7sI9kOcAxAKCE2HZ2u+eNf+VP+uAldstR50im5wvMy5jickykr3XJupX+oVKEDgwn
         cvOQ==
X-Gm-Message-State: AOJu0YyGVKX0DZ2OGEGhYElras4mxxXOnTY/YrZAtop0UVFjXMfSsRs2
	ZXnUjGy8+y3jIaBT3Ymn0Fc+qxQ8JjEfLqd8QpBJhFVroCuxhqdlBuohHW/LgGmWSAf5uQ86yDb
	He8jqFc2oCrNmpsO79T12KjMn/i0ZsEd9/LzOxzbbhtAaU0rp2x+Rk70Md//t9Q==
X-Received: by 2002:adf:f44f:0:b0:368:3f5b:2ae4 with SMTP id ffacd0b85a97d-3749b5615demr1637524f8f.36.1724929347337;
        Thu, 29 Aug 2024 04:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjFgXXnFysvtJ9yqzthz/bi/1l5irBWdODgggA8xXwvUbQyC2+4BF969CysEoAgf88vmUgRw==
X-Received: by 2002:adf:f44f:0:b0:368:3f5b:2ae4 with SMTP id ffacd0b85a97d-3749b5615demr1637485f8f.36.1724929346457;
        Thu, 29 Aug 2024 04:02:26 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee7475dsm1107061f8f.27.2024.08.29.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:02:26 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:02:24 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/12] bpf: Unmask upper DSCP bits in
 __bpf_redirect_neigh_v4()
Message-ID: <ZtBVQECYJyaekFZY@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-13-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:59AM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


