Return-Path: <netdev+bounces-119963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FC957AED
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D423B20CD3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36636B657;
	Tue, 20 Aug 2024 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8qz8ECH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83281BC4E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117217; cv=none; b=SwyIDGewIzPOnT44COqGszQVljuG+8gib8VnA2lmQ3npEofqvaVtAaVDfJzMT/KUeXzhU9hT7R7BjECir4mVlwZUOXdgDAwVLgvTv8xJMuTWj2XPNzySQeyZDl4EUcFicC4iwWMd1Rc+4nBbjTjEmzPxVEnK9Y4YUuID5dXtY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117217; c=relaxed/simple;
	bh=O/XM8deydUyOM9iCpgLMmSe6mWg6BQUyu0d8Bj/INN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK7TPxcIusvNjf/ISBaZ91jDAIqWtF6eQpYHGurczxQ1vTXX3FDWfe7riA8qwWlyNjTK6GjLUNNc/aGu+H/TPozdTN9wkhBv9Nr85r7/25CTCmB4oaBVAWnvrThtwHPrQjOGz3uQkp1vI0TL5g1gs2WlrHBp1Zv00tMdGyLpW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8qz8ECH; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dab336717fso3238991b6e.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117215; x=1724722015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0c9fktEHNsXJ0JiyK640CHmCV3MpC1DDAQsRsKt46Y=;
        b=K8qz8ECHt5pmrvSTW+gpotHvEPKPHYwzpotyEgeHMVzBOkuFzBPv/0xtWZSMmYl1vD
         CmfXldklre6e4m142q54tw04ChJAs092FsfyHjUtCOD+hn8/Mb8cVv+8rT6vbe1YX5X5
         7I0LgsMd9rgXRslbfbFednJ9wTlel2Wftn9KZz9xHDlFg/nuiROcKo6gxvKgPLmE5hg7
         wqTFFrjoVoqpty2+MLslLMeVfYEBcelxE75jmZ/VmEEb3DcSUKwP+pyBMqbpa5GBWlJR
         PgswpDBI4FlVeXsD6JPd7pLjZyztEMfP6EebAHB5NKDz3ON6rCKg9+l1zJ2U8NI4MeQF
         2Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117215; x=1724722015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0c9fktEHNsXJ0JiyK640CHmCV3MpC1DDAQsRsKt46Y=;
        b=wk9irGkn/co/lAsz/+YC9qgQqeMsnf5nOjmL0So+gkpR1YuUEyygfNNyd6n3Daj2Ei
         L9TqVfe1OkykEBV0BMzRAMCV5azhQ+i7baQrtHmJ5O1QSP8hMdipw2xBu5WJgxouoWy3
         6rJECU3Ok8ZFSvsxXaYAZ420pmJ7hXnPR0WGPoe6paafuhcMa9hsSbU/iYSLyr5kOKDp
         hbYhQnFlzpFi+igl8oz6Cy5WO9NgVwtcdpuSakb97wIXgoGQxYTuhRHAy/1lQyx3StX3
         haT7NDwcyi/dQgKn7hkp9wmxArZeK2mHPBCBA9v1+fcf+5PBb8IvwQjiveCEoQkSQRg6
         aLiA==
X-Forwarded-Encrypted: i=1; AJvYcCXWfA8fcnCaHZxNOSko9GHMmdMpgkTCanQtH46ZNFoV6DLcHi3kTSWBttsptRRSVPsPi/cs+J7kim0VCHgwfecM7/LNxtR7
X-Gm-Message-State: AOJu0YycNmR2POxI9XD/iKQBMZrUwwrlMed0urh4or8xkBHg9J1TJifD
	E9tJaox0p1aYvUCOUC4D2ywAHT5x9thpHOl8n2nRM+QwufYldqhb
X-Google-Smtp-Source: AGHT+IHUMfh39DYsVisdcvZCkCJnwykMRweH+BumxOpbIwZEDap514UPMIMzO6rDgLWjaeiqsPdtbQ==
X-Received: by 2002:a05:6870:4154:b0:270:2733:8159 with SMTP id 586e51a60fabf-2702733c0d8mr12769365fac.17.1724117214701;
        Mon, 19 Aug 2024 18:26:54 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b60a1122sm8280050a12.0.2024.08.19.18.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:26:54 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:26:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <ZsPw2W8nLR4azKLo@Laptop-X1>
References: <ZsPXnKv6t4JjvFD9@Laptop-X1>
 <20240819172232.34bf6e9d@kernel.org>
 <ZsPqS6oFNpRmadxZ@Laptop-X1>
 <20240819180525.5996de13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819180525.5996de13@kernel.org>

On Mon, Aug 19, 2024 at 06:05:25PM -0700, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 08:58:51 +0800 Hangbin Liu wrote:
> > > It's a hidden config option, not directly controlled by the user.
> > > You should enable INET_ESP_OFFLOAD and INET6_ESP_OFFLOAD instead
> > > (which "select" it)  
> > 
> > Thanks for your reply. How to know if an option is hide other than review all
> > `make menuconfig` result?
> 
> If it has no description after bool or tristate -- it will be hidden

Appreciate, another tips learned.

> 
> > Should we add a "depends on" for XFRM_OFFLOAD?
> 
> You need it in bonding? You should use select (but not that select

Yes, I may write some xfrm offload tests for bonding.

> doesn't resolve dependencies, it only enables that single option).

I didn't get which "select" you mean here. Since INET_ESP_OFFLOAD will select
XFRM_OFFLOAD, Isn't adding

CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y

in tools/testing/selftests/drivers/net/bonding/config enough?

Thanks
Hangbin

