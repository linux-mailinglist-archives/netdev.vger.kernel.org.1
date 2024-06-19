Return-Path: <netdev+bounces-104777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069DA90E533
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A591F21578
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A678B4E;
	Wed, 19 Jun 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WRL1JEhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08E6F300
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784400; cv=none; b=Lx0OHI2TxkFRjDDenks8m56VjdTU0p1OKVlRLdsLEDPsHGrCAC+kwwOVz3C2WV9O9ZCe5imQWhgI38IZ+rnCuULptgtfRFqe0XtZs+rZnbREfHfebA7yAbzPdimvO9CMg/GquMn74B5/qk4pXSfoCrkV2KI6XtTk/0ipn/R5goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784400; c=relaxed/simple;
	bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqRaM0t/XW1WK8Vj0BniXbagxJNV+m+X/o4z6xFae7eiQMh2Xcz1tsGZnOARLTnFkMumESXZ4zTNwRUKtcVw2fags6TsVGGocH75RYIlBQ1naXbZTIfA6w7tJHDnfmLJOd7qdoJJVy2K4oEVRhcTKsU2NWpnuvcsEGAMPETZCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WRL1JEhO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424798859dfso1075735e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718784397; x=1719389197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
        b=WRL1JEhOrDBKRiz3zRTtrsYFUqECnIuaWnMkvdTWgVexu6aXMMANrcDZih4ZLb+z/D
         vd1mQiaY/3EcJ6WoTKP0E5931QWHT97oUpcKsF4lGVyO9n7YRrQ6MjrDL2Mg0Yiyjf7v
         4VnGAcoc96qkTXlgmJzx1Yjql4ugd3IxCln8GTWU9I9fuo3zbd2JdqSPg4dC43UevIis
         i4f5ytwmPItHilfiRj69zdHxdmV74CwMxXnOpPxUAci3G9BWQrvjAauGrVRm0GMWJF4c
         YgL43159qiKeDmmIDk0wXlGNXOMfmqKW8C3oSjmzHHSBZXIuxkrr1TDdY2iVGLPMm4cr
         vzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718784397; x=1719389197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
        b=L9D5FicD2nKB588qVQMLMXqQWb61W+7qcxS1kav9GoI9b6algJTZoKBUFtchGqzzl+
         NLFlGt1CE6GBbkCDp+oDqTJybE0TS+oe8St1fzsQNjDXFAI8vXqMb0pGY9IVX4gKkUBk
         G7EYOg/6shkaIsTYT+2Yrk/RPG2DIOzAZBTQcZCDjD/1+MeWBIKE+amjzJsPGf+ndj8J
         VYPAeWnz12/VTqOL6aGrrAaEECqzN1VMIX4oKHYhQTiA8jl26h7NZViAu5bjxAr3mRSt
         DVgVNd4i8MxOC/eN8Kpegp9i4GrtrIKrWc57mo9gvAUDaW3ZktJKdI7mjy7Q9QGoshx5
         44Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVTdrHdhnuTTIIwevtIAsgnzS8MajEvwRxk6kIlYqGUGXWgJo8z+/XezVNv3PkvKwVTmes+rDJBJnrNTEWunQcJBf8CSabC
X-Gm-Message-State: AOJu0YxPuMK+pSdRpwVL3BfS8nEulKsVcDTbNb9qKdMDRjO+rXVTge3/
	Myk3VmbbXqmC0SDGCVhyH45gmo2PJabQ/YxoCeHBFlpVtQG0VdHE7Qi8lKM10YU=
X-Google-Smtp-Source: AGHT+IGzOs2ulFgxkg+FZprEYB2KC36mJOMw5IsLgMQeCTrwaE19hcWY83ADjSMbQvpq2823z2q5VQ==
X-Received: by 2002:adf:e88d:0:b0:362:2e9b:f10d with SMTP id ffacd0b85a97d-36319990553mr1404317f8f.62.1718784397283;
        Wed, 19 Jun 2024 01:06:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608e6d1524sm10533654f8f.81.2024.06.19.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:06:36 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:06:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <ZnKRiSeXxXpPgqfC@nanopsycho.orion>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>

Wed, Jun 19, 2024 at 04:55:29AM CEST, lirongqing@baidu.com wrote:
>This place is fetching the stats, so u64_stats_fetch_begin
>and u64_stats_fetch_retry should be used
>
>Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

