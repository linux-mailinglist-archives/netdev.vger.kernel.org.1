Return-Path: <netdev+bounces-198102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630EAADB40A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2103AAD3B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6E207DE2;
	Mon, 16 Jun 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeXQ1Ez3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65C1FDE31;
	Mon, 16 Jun 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084682; cv=none; b=HykOL5aRcFb+m3pcgcBj2S5mXccawh11qTxd+9bnXPrS9wLYE1Ry8/yhhzwLuudjbHLRdyYQ61LNcMZmzXWUWrSx7s+CztqimK61CFhQF1Nz+R/5kzrrX1VjAttqktTz4thzzAQrMZC8Eq1sQ3BNYsC/BOImhleP5nqY5N8Z/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084682; c=relaxed/simple;
	bh=cLzVKcuo2jGM7owptZLbLhdR+MJzD8H9+3/gONLBy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sum3i54vSmCJfZSmEgjziKbu8FmWiJ+8f83GMgBy3c6sdsxapojiZ81QlrTA7h3BQgzE9tjHY4WO6Eu8Nq3jJNaRqv4WC6vv4/n91UEiv6qecCBuV5FZcYxQgwlorAlLyPfqYmOLyAd2uolWHlod7w7Wq7KwPI+hv3o4kTmOhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeXQ1Ez3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso4600879a91.0;
        Mon, 16 Jun 2025 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084681; x=1750689481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+ACrTU05OqY1Muf5ZfOUtQOxY2AQbFMjqsvwqLrJNk=;
        b=NeXQ1Ez3ral+erasIIi32P9ziLW9QP1Pbnii8XVoH+QnEv4KMlOmyTB/zuDLVrxkZh
         EsAuIEG82h/yrhUK4xf9Fk/h5ZqbNnv67I7CKtpwgGPC3wbpQn8flod+RMfk+LSdcIIj
         7mz9e6mAAFXT/gof/ZTMzwYsv9ULQ4EWQ84RvpsdRxvygO8nsrrfaMHFOZc485bPaSws
         55jFKYo003cDfS4M4AuzHUHtzMt3k8er2jTYZABWQKcm3xezoGOuZD6/t9cgc012VVLA
         18R6WiS4PWFUN68bfgyEU0k+L4zyOzfai8qUFaTs1/Vd6q+Bqh9ZLdOcF8cx0W4ZA3Z9
         Ln/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084681; x=1750689481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+ACrTU05OqY1Muf5ZfOUtQOxY2AQbFMjqsvwqLrJNk=;
        b=uZTO/9mnMkBZo3ZWx8eZliU+m77qN7oX8ty7ex2Mmy607P8XT9CZIMsQJcIAIZ391R
         pUBvYVoQadhKJvzptu+LYFcPP41Pg2KhMLJqL2DA8Nl95KruQG6nmEQLj4a5joAJdqAU
         bjANs3PdDMYRgDZacd9z6FZLovako9H7mJR2QFbHyN2lderbnAlIhRfeu6xzVzR13M7m
         uMwOyXiLT08zlHlGrPsmPoF1ZGroHrqkht0ENxG+inBxdSMtd7bhOnk3MViQhm6oMfzI
         Vwslyg5GZV83z9wnGS3tCNXg2ySe1FNeCWonUI3sCuIyrwhcMr6CS3/ImTnM/bSTj5CF
         JCVg==
X-Forwarded-Encrypted: i=1; AJvYcCXRnJUCgxG67bD68pq5zoeD2XPuFF27yPmaRu7kaux1NZYRj6j8G3sU92FtWZEFda/HDV5gDvQUvVZSmCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+0JhT/KlBFxVOp9P2ggZKjd77n1YWBtfFrHPj3bqWjJ22Dxn
	NZjpapb4bGdy/bS1xr5RRUx6YH1MTKS/YPe+jbuDSLZ+V3K3GHAPP5c=
X-Gm-Gg: ASbGncuT8oYdF0Gr4/6BSsTzC8vpEIPW4icgykgMJtPIg5AI7/z5ze/2CnowzEalofE
	/+nAjLtpYtmaXfZy/yTOAsdwmOJhz4wsqCxMrnTqnPp1MixckWCFVl8BzVdtAzE3T2wJwDSXVPj
	O7Zk9n/bY53Gw/G9jkaptE7B6Anxu8ofYyjDc2Qws5SbUfTF4kz3bGsdWC5MND+jCLwLj5+4SBt
	u6mjK6iNUDwBs/sHgJ7oKtsGL9w3MCLFyiSEpaQ4TFuaxpjl+vW1DAlsVAOiG9vbXTztuLPxsyH
	z8Dd3pyxaieggl0MOZHtUWC/8uh3IoyzWaw3mvTitwFxEgbgt1r74zPn76BmSYWT9frMLqbEoCR
	PrYLUGFxRnlDA2UNOAynUH+w=
X-Google-Smtp-Source: AGHT+IHD865TyBBXAhjmeTN3ICmhFosIa32e5E62uOAC6CLnTLRm1L4sgw9QtI+h7yL8wpjDdzoEaw==
X-Received: by 2002:a17:90b:3f44:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-313f1be8a89mr15233629a91.4.1750084680589;
        Mon, 16 Jun 2025 07:38:00 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365deca379sm61824765ad.210.2025.06.16.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:38:00 -0700 (PDT)
Date: Mon, 16 Jun 2025 07:37:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, willemb@google.com,
	sdf@fomichev.me, asml.silence@gmail.com
Subject: Re: [PATCH net v1] net: netmem: fix skb_ensure_writable with
 unreadable skbs
Message-ID: <aFAsRzbS1vTyB_uO@mini-arch>
References: <20250615200733.520113-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615200733.520113-1-almasrymina@google.com>

On 06/15, Mina Almasry wrote:
> skb_ensure_writable should succeed when it's trying to write to the
> header of the unreadable skbs, so it doesn't need an unconditional
> skb_frags_readable check. The preceding pskb_may_pull() call will
> succeed if write_len is within the head and fail if we're trying to
> write to the unreadable payload, so we don't need an additional check.
> 
> Removing this check restores DSCP functionality with unreadable skbs as
> it's called from dscp_tg.

Can you share more info on which use-case (or which call sites) you're
trying to fix?

