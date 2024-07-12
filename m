Return-Path: <netdev+bounces-111150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06693012B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4048D1F23BFB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB333A1DA;
	Fri, 12 Jul 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLTpUb3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046518E1A
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814265; cv=none; b=dAXo0AHZRo9ZrW/zpUhlz/ceYpN1jonqyY3LnXQRkY2hQeUjYSQigeDh0M2YkzyRCZuY3ipiGaF/aQWMA8m1E+tHsZtyeYOK1a+zxotsiYzUR1q6eUcVgVHIQNfMw/bpN9WrR5nbm8gn1qEGpZW2u+s3Xrnqfo2XVuTnsCT10JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814265; c=relaxed/simple;
	bh=wSshsgGED8HPu10U3N0UkRgySoxyARkIZVNYAB+8/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOhIKFMRaLKwe63GFdVV5W12BX3Fi0RcwoJr8yqFOAQS3wc8SY2GBzVH/BuOe8M7dJFAX+J/uDfOEOx3BvPrz0BtlnndjQiJf/xKLe/cj9+bPmC264Ttd8xC9urUEfMuTwJJ4FdiHY9yF7/U7P2mUBDEy5eSM4H0eVKL+KeZc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLTpUb3E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3678f36f154so1290679f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720814262; x=1721419062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMYxX3ARgmF2dcWznWm0q60TUYZFPMB1J4kCza84kA=;
        b=vLTpUb3Ei5ztAUUbNjTzjnIlYunv1QsRvbuget3Mj93eoVDSUBzoHIbn3z9GyqNy7D
         hRpdwWPoHvFcbVox7gzK1T13z1vBxD9fBAszMl0VeH6G3mJBqpFEBa9B8oWh/jfp1jcE
         tr8y0DLkKeCVvN3CLVJM88lBI78VM1qo+yFgqPZWsh+yDOREMEOOnYbv7tGgRVPaiNgr
         pt0aBnARxEWEosMYedU9/q+YXHvXl2ZoanyNVPukFLs6RkuAkfIandmns8t4KwWZfcdT
         mzq4ORxFRSFgxT4raBdiQXzGpiCzeHpiNVrcHmBGxF94+9ojH+couhECa8Ht3p6XNx9i
         F01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720814262; x=1721419062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsMYxX3ARgmF2dcWznWm0q60TUYZFPMB1J4kCza84kA=;
        b=t694iBRk8Ut366dAHXG0XPm6UzgdxOJhUb3WqdnRdFd0MEZ8tE/7UCB8bPJKqm7uli
         +wRPSN9XjJs8w1TVZCLZDnwIbxQlgLGiKxGTt2VrPsMVIGGAn9TdMefNre93Ul5remCe
         havd9McKqyEaiGVhMkKEcRlhnwJdUG2bBT3bl7OV5Mr4fIzWY0Xb0c1nCIB6DSXbw3xy
         A0exYMmXPyoueN69eXxPhtLD/mztjeAYCaDyyPBh9SyOSTijWpN19jkbB6wXMtcITYP1
         V7F+Le9P/vsz+0TK7gRME0zpPdB2NMqmbATgLVuNFBfRhdeJoP3JDhOnwBH6AOVGManZ
         5J6g==
X-Forwarded-Encrypted: i=1; AJvYcCUT9qa4Eq2MwQZfaDDH4ti5DQ7u2Wd+UqB0YJlrNbkDhrmTcF0+yR4hDXisSsE3JH837QJaZ/EgqXseAsWyCnqAAyvwnmdU
X-Gm-Message-State: AOJu0Yw8GpHI7E6ity27T17JSCjj4kN+iZlneXxJ+vGIqEqyyXGZWjfW
	X3o7efrj4Iv9gRx/ZJqr+QTf6D40tVD78LcaWhPyemEYbqxdZ/SSWyGPFq07phk=
X-Google-Smtp-Source: AGHT+IG3l5o5+v6d2/YWNdG57jy0GH9496uZjsVKZv+F5Bh1e+Q20sQIL9icSK4kLKf/YCbIMoS55g==
X-Received: by 2002:adf:e7cf:0:b0:367:8f81:f9fc with SMTP id ffacd0b85a97d-367cead1615mr8665684f8f.50.1720814262341;
        Fri, 12 Jul 2024 12:57:42 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab815sm10819916f8f.110.2024.07.12.12.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:57:41 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:57:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats
 initialization
Message-ID: <20240712195759.GA2972562@myrica>
References: <20240712080329.197605-2-jean-philippe@linaro.org>
 <20240712064019-mutt-send-email-mst@kernel.org>
 <20240712182021.GC120802@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712182021.GC120802@kernel.org>

On Fri, Jul 12, 2024 at 07:20:21PM +0100, Simon Horman wrote:
> On Fri, Jul 12, 2024 at 06:41:34AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 09:03:30AM +0100, Jean-Philippe Brucker wrote:
> > > Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > added two new fields to struct virtnet_sq_free_stats, but commit
> > > 23c81a20b998 ("net: virtio: unify code to init stats") accidentally
> > > removed their initialization. In the worst case this can trigger the BUG
> > > at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
> > > random value as count. Initialize the whole structure.
> > > 
> > > Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
> > > Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > > ---
> > > Both these patches are still in next so it might be possible to fix it
> > > up directly.
> > 
> > I'd be fine with squashing but I don't think it's done in net-next.
> 
> True, but this patch doesn't apply to net-next.
> And 23c81a20b998 ("net: virtio: unify code to init stats")
> isn't present in net-next.

Oh right, it's in linux-next but it looks like it came from
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Thanks,
Jean

