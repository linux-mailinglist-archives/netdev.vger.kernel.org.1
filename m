Return-Path: <netdev+bounces-103087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053190637C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAB41F227F2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AA136643;
	Thu, 13 Jun 2024 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HUsK3+Qk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E53135A53
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257107; cv=none; b=c5EnBlhcKvdSYqPWGAeFVVdtsq8aKZh1YK/XBTYMDl2HOhE0ahlm7M/Xb+yMjjlkT8JBHedgFSeg5K0ndYH5wwJja/gOqd+sts24kSfYW7RPHcrqKlHXJeUWjHo23vdXcJHPdHqn/pTF1hBwvEG0+g+Fx5+7G+qJwWNZaLDKr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257107; c=relaxed/simple;
	bh=GgQ20cHpk+tAp0Fm34ztqoPZ0U/eOHRU+4zAOtD3Dlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7+T0wMl56sDxnyaOig6lGLR/2fYX7ik2k9ozivraiAkfaJ6sr9omZy4PJ2Qg1JA1eaVJUmiodnZSanZzdN70KGbS8R6G/VTfhmbS14JXxEVlVdbHxH9B3aG5t+p34CvgiIAJsb7L5E4wBcvAHi8e+MsypcjWmKVSOS5T3zaAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HUsK3+Qk; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so113037a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718257104; x=1718861904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgQ20cHpk+tAp0Fm34ztqoPZ0U/eOHRU+4zAOtD3Dlc=;
        b=HUsK3+QkOSkpuPcri636lMgplglksxc4UufXjH/ItsBq8+N+VdElR40PxVXKHSUhqK
         E4NGm+nniQGHeEYDmR/GKElhrusg8VIRDsnHfUMrBA+QOdORLhYmgYe15Z/bU9/qWUpD
         AxO4DI+rvDbnIuU99OzmdIWy4JC+IwM/uPDWS+lEEvetYzAhdFne9V70uywc+VTqbfOw
         yy6zMTWUFKLcz09edHPenhreqVsvCVpNaqvsrDn0f8IVJ9BlQ+779//KubebCKgNlJQ0
         1j3swksmqWIuQ3jIaylVzH3FTv/3bxfPD/kyqNfTEYtBZTHIc18XKFZ+nG7aW7cxeyeI
         9qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718257104; x=1718861904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgQ20cHpk+tAp0Fm34ztqoPZ0U/eOHRU+4zAOtD3Dlc=;
        b=DfSSuAjt/FkBpswC3Bm3UNXil+WaLOgROlxiOtxZK7TZrhGg+9SSME2HMeXpR0TxDF
         2PqqiNHdXQjhj6ZLH5mln6JM3TMcZkNhhrPGR51wRTFIQlp76Z+RXfReu2Ryi9K1IZgF
         ms3SiC6GzpTVzQG6LMrQ4veCLVNbzkk1J0XS4SL0e/HNM66wWM8lqgZ8/0gZcdqvWh3b
         +kUNVRjbPSGjp4S7NvLWQCRRz0IdWK/w8/7KWfuriyRmqZEMtt6ExYkCDTpOiCWmjeBD
         53l4I5EL4nMN77viuxx7my5v269YXraA9LPEnhTb2URvhjNSZ+EVKtpmO4Vre/QjOB4U
         8yeA==
X-Forwarded-Encrypted: i=1; AJvYcCVRZODUPx9mfiObygLu0e7WIjU3FpDwJHCydzVnIaTXEOuVXjT/RRVbL2iS7BSNCTbtKye+hwBt5x8K81ieJu4uzNGTdLgv
X-Gm-Message-State: AOJu0YzKLkcHS0hs2aNMiB/05/tC6eqYQgRT8QF+/wl1OBVGkKr41Uye
	PS9acX1FRWxIcNqe8nQBSxhFWznR5Q14Zn6nRMoNSdVM6z1KmcmRMYp8l6AZDno=
X-Google-Smtp-Source: AGHT+IFY05lLpoksusFINswslkm8+fMavMNTXJXC5h9004mF4RNBcjGiZ7dFzQUGN1oGx1I8tbtczQ==
X-Received: by 2002:a17:907:b9d5:b0:a68:b159:11ee with SMTP id a640c23a62f3a-a6f52403808mr115597666b.12.1718257104198;
        Wed, 12 Jun 2024 22:38:24 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42d25sm32721566b.174.2024.06.12.22.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:38:23 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:38:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613023549.15213-1-kerneljasonxing@gmail.com>

Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
>From: Jason Xing <kernelxing@tencent.com>
>
>Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>BQL device") limits the non-BQL driver not creating byte_queue_limits
>directory, I found there is one exception, namely, virtio-net driver,
>which should also be limited in netdev_uses_bql(). Let me give it a
>try first.
>
>I decided to introduce a NO_BQL bit because:
>1) it can help us limit virtio-net driver for now.
>2) if we found another non-BQL driver, we can take it into account.
>3) we can replace all the driver meeting those two statements in
>netdev_uses_bql() in future.
>
>For now, I would like to make the first step to use this new bit for dqs
>use instead of replacing/applying all the non-BQL drivers in one go.
>
>As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
>new non-BQL drivers as soon as we find one.
>
>After this patch, there is no byte_queue_limits directory in virtio-net
>driver.

Please note following patch is currently trying to push bql support for
virtio_net:
https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/

When that is merged, this patch is not needed. Could we wait?

