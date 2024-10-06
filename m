Return-Path: <netdev+bounces-132484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B932F991D62
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369D71F21C4F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA116A95B;
	Sun,  6 Oct 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoUFVP9D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F78A31
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204800; cv=none; b=I34aGL1Ha621b9jlE33s9KZMG3USzBFXcGRvdN89gbLW0wtX+88SZLiiI0LkNU+JeuciguIVmkVSk+C4Qng30nIrvrVeImaEG4EVnDeHhEGsU/hCPsHDq1fKNkM6dsTtR1pSIFvB3c9+zjPKDI4fkVzEIuvogwhEU822QbeNxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204800; c=relaxed/simple;
	bh=/2kG7far6V2fXoI/fHTF/tT/0KRJ0Hwr8/MaHXSfcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r41j1Ydg+EedMXuxHZVFnUukh68YRexP2IZGknOt4TCm/7pz9OsE3Bq1a4V32colrZVvtrNt7nqRfltuojSNU3Y/Cw9qq6yrJoVG3CnjvlXgenCFtOk1LOl/S3kBQztxnqXHOuvkNEcH2Erge6C1N96yZUDuA2yZCswKdcY0AFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoUFVP9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728204798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHj6OMuMnsa5+kbla/V2LZIR3F5CZcFmLCBZummd3Dw=;
	b=ZoUFVP9DtDEAzds21477K02POSN8PYff1gvXM/L8QSgPsAZNy+XMiNDS+9T1Sq8F5QcwJl
	SOx3eaEBc6nRJ7ddMPDgS1lkCDgVmSVETsxK/KBUndwe11otj2SZTBCzZTm6Of7il589kn
	zEQ/AOs30i8Zl+yucJ95Li7geGdcdvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ed-7T0VEMfCr129c0kuTcQ-1; Sun, 06 Oct 2024 04:53:16 -0400
X-MC-Unique: ed-7T0VEMfCr129c0kuTcQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caca7215dso19917435e9.2
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728204795; x=1728809595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHj6OMuMnsa5+kbla/V2LZIR3F5CZcFmLCBZummd3Dw=;
        b=RvdF4DhcX3pUNV26Qm47R8yVJaTi06BMaXShUa6i1jak4zX55RjWr5l2CbTIqCFDL3
         2fXplGD8wBbIt8UKMrqhD4nry2ogxyZ+Uijs8nfRWdWEsT4AwLcJUw9cFiibOASauCaA
         OXPvzdeTXDgSHS56Z958PWB8yMH0+5xkDfjObg6WU/xdgSJzjdJfpkVP2+laW3AQAli9
         0Q/rAkLaw20o6P1UEGXxZZDYl2lBX5KROn6hf5xrGBJBHx+qnBHutC0axO46X1kP+PID
         Mor9jipg2MciRTVxlhN8RKBhJ33byJMysaWA9i80TkTcam+zLjyUkKwJpV+B+YJLqrhq
         Y1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVp6XV+OHjiV2uRyimsxKf2bHX6Cz7oGL52QHl1trGWZmmn7g0LBSRMKIZqbD+lq/c/m47L7JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+b6MexGpwE3L3utRHFmDaD9t0TbuTR0dEoZZQtPTyz2fH8sv
	ubAbibdLl3fY8BfzWIk8Sh82g8y2vpbFHNFHB7HaVBWVpNoVTYIvWS4+yhlJgtmMyI0BDxxTiGJ
	F7yMudWrwOiw4hWYnmf5NqlGk8E8a9vvXjTH5DUgheXKhPgTK53ybuw==
X-Received: by 2002:a05:600c:1ca5:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f85ab471cmr59426535e9.8.1728204795452;
        Sun, 06 Oct 2024 01:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJcw+Cphbjs+ue5EupQli+CCu7PMJTmakUCn91rJnbEToHavqoOxx7zeI6FY3Ptz1Foh7FcA==
X-Received: by 2002:a05:600c:1ca5:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f85ab471cmr59426285e9.8.1728204795044;
        Sun, 06 Oct 2024 01:53:15 -0700 (PDT)
Received: from debian (2a01cb058918ce00f941c1979dfd74a8.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f941:c197:9dfd:74a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a894sm59746175e9.8.2024.10.06.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:53:14 -0700 (PDT)
Date: Sun, 6 Oct 2024 10:53:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <ZwJP+Jx5xHfWR2zN@debian>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
 <20241006065616.2563243-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006065616.2563243-9-dongml2@chinatelecom.cn>

On Sun, Oct 06, 2024 at 02:56:12PM +0800, Menglong Dong wrote:
> +	/** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metatdata
> +	 * reached a device is in "eternal" mode.

Maybe 'a device which is in "external" mode.' instead?

> +	 */
> +	SKB_DROP_REASON_TUNNEL_TXINFO,
>  	/**
>  	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
>  	 * the MAC address of the local netdev.
> -- 
> 2.39.5
> 


