Return-Path: <netdev+bounces-91859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2438B433E
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095112832E4
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217AA6FCB;
	Sat, 27 Apr 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F+lqUYr1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A263B9
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177689; cv=none; b=ZHATWGa7VqahMkLU8Qr4SqX7u9goFgMgQUuigIHcUULFgr2u5kFdcmMFmOstgv0rDM/xd0uN9i10r5zJEpq50K9AUOR5EoGsiE51JFn5ntp+tYlqnG0rjKJbVd98Gh638iXCVsouPjkqAqqWZSijtWnmhLYtMpMMlSVmVoYGT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177689; c=relaxed/simple;
	bh=TCybvemVxwB/PGZmuZrTIxFjueF9/NwMnx5uGPOboeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7oyEw3b696jhkm082sJtJQW3GziPq1r6T90SpFxY0cS1Oovkw+QLKb/acQEKlReVYFTBAmVmWLwaHmSpeD/GEce3hKZUUFsJs3ckij3V+Bn4bsF87JyUpEBsHIAuIbJ0h8l6hAmbk2NN2HeFpY6Z8uiFoHJ0D4RO9neDY9Duew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F+lqUYr1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so2283915a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714177687; x=1714782487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXAQF51sDN9F3aF1HpNficcqCGNJWrnMVz3YT4ki65g=;
        b=F+lqUYr1KyCNWBp/ddOuQhyGN+V7hx+KyTfubUCO1ttf8+6Comw8qRmfyb7ZvVjmLU
         cnWzK88yJUi6DbSreLjvYFHixGycdYdhKxZRn2USvTKLwhuJiLvrBxmJ9um9XOsS9fp4
         47bqJnmG0q0BUQzxkkcFSAd3/30t/ankJnZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714177687; x=1714782487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXAQF51sDN9F3aF1HpNficcqCGNJWrnMVz3YT4ki65g=;
        b=Iks9ah/RTZfWezUud2x1P7AuRwZ9qjODIsdy2YjMd+WSDs4Bu/LosCH2AjxSk3wX28
         NRdpAZTGrB1bhHgnFZUERpO/9QQG67Gl5zZdHex1mpGYPCsqbdCUDq2me7YmBETb6fau
         NZU9C9C7PxcyEVuYDo71OfOxfboVTAj/h5FEZ7Fiyq9YlKdf9kTtsM+0rpWsJ5ibaLYH
         MVGXuGhoH6TVn45eqWWIFyHnmXsTLolLxcmn0msEQTdJg+5nlufW5s5+w57JFD/f0JAr
         IljZ+IdKcy1dUKPiOAe/fNwtfQr8C4/fHbmmSb/y9Fv033bTyPH7A1k9a+50rUJzNqRm
         kptQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJEc5J5D0+CloenVRjWy91G7Jqgz4o0SAZUZWy7g+ztrmdFhhbwtD2JObqgqLQ4nmrIAwkEty4ta4akQOvXkYOuNywwjz7
X-Gm-Message-State: AOJu0Yy4FKOk/B6G9H08+Ummw8qeS/PGbuJvRl0iwZpv3+FcfZYwhiER
	8kEZXIzsbmozdxEFX8lygtJ+28aZkfxOa5BLlkjzxNTkcfFez4jcx+273ozosdY=
X-Google-Smtp-Source: AGHT+IHR4o4yryMFbnUCig8ibhs2v3Z88xO2pthLFr1r98nC18QTME8VAmDR5VIm9UjWSoHYu8QIxw==
X-Received: by 2002:a05:6a20:9152:b0:1a3:bdd5:41f6 with SMTP id x18-20020a056a20915200b001a3bdd541f6mr5212265pzc.61.1714177686907;
        Fri, 26 Apr 2024 17:28:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b006e685994cdesm15356472pfu.63.2024.04.26.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:28:06 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:28:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <ZixGk8dy8INWD6PV@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-2-jdamato@fastly.com>
 <20240426130017.6e38cd65@kernel.org>
 <Ziw8OSchaOaph1i8@LQ3V64L9R2>
 <20240426165213.298d8409@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426165213.298d8409@kernel.org>

On Fri, Apr 26, 2024 at 04:52:13PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 16:43:53 -0700 Joe Damato wrote:
> > > In case of mlx4 looks like the buffer refill is "async", the driver
> > > tries to refill the buffers to max, but if it fails the next NAPI poll
> > > will try again. Allocation failures are not directly tied to packet
> > > drops. In case of bnxt if "replacement" buffer can't be allocated -
> > > packet is dropped and old buffer gets returned to the ring (although 
> > > if I'm 100% honest bnxt may be off by a couple, too, as the OOM stat
> > > gets incremented on ifup pre-fill failures).  
> > 
> > Yes, I see that now. I'll drop this patch entirely from v3 and just leave
> > the other two and remove alloc_fail from the queue stats patch.
> 
> Up to you, but I'd keep alloc_fail itself.
> If mlx4 gets page pool support one day it will be useful to run this:
> https://lore.kernel.org/all/20240426232400.624864-1-kuba@kernel.org/
> 
> And I think it's useful to be able to check in case there are Rx
> discards whether the system was also under transient memory pressure 
> or not.

Ah, maybe I read what you wrote incorrectly in your previous message.

I think you were saying that I should drop just the

  dev->stats.rx_missed_errors = dropped;

due to the definition of rx_missed_errors, but that by the definition of
rx-alloc-fail:

  alloc_fail = ring->dropped;

is still valid and can stay.

Is that right or am I just totally off?

