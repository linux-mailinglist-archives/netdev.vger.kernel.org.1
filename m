Return-Path: <netdev+bounces-180028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B674A7F2A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0CB3ABFAC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85A262A6;
	Tue,  8 Apr 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Dot4y5ES"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65281C831A
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079408; cv=none; b=Vdw4Q6ZadmBvvbkqzIMwynezFaM2QDotHLzR5/LfkWL4jPCxDy6bwZAfZixKJgaJ952ZwH8xru+oYnFijBFNL/3mkEjEh6qWKdIVhkI5USirz2CDf2AODu/g0KensFMEmM5BPTlcj3FWUQgZmad/zxf6LqrgSkeWYB1net7tdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079408; c=relaxed/simple;
	bh=PTybTAUsNJKljYkzE/bXw79cIaneUKMEkF2DizB5axw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5T/jmVgska0F09Hjilp4UVI7RTfInjr/Ri8YxLdSW/nwTTrwnm+oCiI1bMvtEsNw9SpRNwIPgR4c3bUbyiU9nuU271Lme8gsHMT4Bt7sNcUClMwcbdSgvt72At0F7y2GbTH39gYpy3AJMHecuZDSDu9/VJb+GD51EhPiyogy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Dot4y5ES; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-306b602d2ffso2391036a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744079406; x=1744684206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8EufVU++wUAfh8W2x81SHeePxUKKV4BCOx3iMB/3iA=;
        b=Dot4y5ESNbRlan8hOMtivYyBnG8GCO9/UyWxUoeGO/6xb6VtvGUBrhJ/UtMSRaFSMs
         xvPqJBSbjwctjjrsm5aE3b0parLq0MxkABpVBTK+eftbULhy9Tw+UUiveG22pl2xehps
         enXcOdcEC6DyLoCbtSSdNz/7G009s479DoF2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079406; x=1744684206;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8EufVU++wUAfh8W2x81SHeePxUKKV4BCOx3iMB/3iA=;
        b=iTz1hWYXVKaW3er/Gdp35vjnSYeFQKTyGAn6G6Bd815PMPb7I7liTYZ9jlS28twb77
         SWQGgG+xsKGZvWglYB3lw1oo43Wonx6xMBp3SXi2DliHk4OVhLtrusuEmlBK/oD+e3QG
         +YwuopnhtZjh2sMQrhA/tfOvCOniUsd13DSnv/CgA+NEuP9QEBr2oPloC3pBqxMTzquK
         x65fhi7uTCwEFBHomHo3DXV+FBXXismpf4S/536W1yPj5cNzzvBjbgyrPi2PsEXv8xwU
         /a9+uP/eSLciSWyE1j5uEboQfGtPM2e50PpZnUJITradKvUK7UpFBHjafzDCmPkpuJad
         wkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDD6etWNGvvkZyUXNb/1YBeaNIzhP1AP7cUUFnziyuffKNpKmWfIZEIc+JWCY960edAo4kdpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8x9Ci8+9DvzqwnZfr3jfoSU4OZKC01AeA1uhgJE7BXO+plaU
	6Kltr8FLpwnuKwRWDzQGn6FYx2rlfRZfSQV9tSldYLcSQdiX81lYy2vQKvhE1eQ=
X-Gm-Gg: ASbGncu7zK1BiG12ZZdwO8HbwVosOCbTLVKCclppgQOxhFJCN1g9X5mC6bN0U0Wxt/7
	opmSBNKSB4XsnPIy0HEgdQ3cV/V4hKyXfZW0MDBO2ioR2po16onVnXyCOs9PwDtUFV/bFtcYqNj
	jtXyoPZGdG3ziQR0I240muzWJQdYIuEvFjYkaaj6152/9WUjXDgtp5/aCl9l0I0K4SgaEN/72EC
	Izzfpkjw+sa2TFpw3XsHtXrZTRNLwWKxpy2u37N4kr3KyWEctaQ0OIASntCJc6A/vTZ4U6kO8vq
	yp183xKjqnBdwNCUcGRQHVLveqHr+NH4p5f1bb2J9Gb9kJTF/f6ZSXQWNRyooWqh8feQF05yjrt
	WR0Ddd1ACQ2I=
X-Google-Smtp-Source: AGHT+IFm/5wjMWMfzbtal0zS2Stn2Ya5Tm/ZE5HYQQTmZrOzSHzXWaOgtfWrVlJEYYVhCUP4lTxhuw==
X-Received: by 2002:a17:90b:2390:b0:306:b65e:13a8 with SMTP id 98e67ed59e1d1-306b65e13fcmr9602742a91.8.1744079406033;
        Mon, 07 Apr 2025 19:30:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca8cffasm9874273a91.26.2025.04.07.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:30:05 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:30:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 5/8] xdp: double protect netdev->xdp_flags with
 netdev->lock
Message-ID: <Z_SKKm2Hp8VomG-G@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-6-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:14PM -0700, Jakub Kicinski wrote:
> Protect xdp_features with netdev->lock. This way pure readers
> no longer have to take rtnl_lock to access the field.
> 
> This includes calling NETDEV_XDP_FEAT_CHANGE under the lock.
> Looks like that's fine for bonding, the only "real" listener,
> it's the same as ethtool feature change.
> 
> In terms of normal drivers - only GVE need special consideration
> (other drivers don't use instance lock or don't support XDP).
> It calls xdp_set_features_flag() helper from gve_init_priv() which
> in turn is called from gve_reset_recovery() (locked), or prior
> to netdev registration. So switch to _locked.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: bpf@vger.kernel.org
> ---
>  Documentation/networking/netdevices.rst    |  1 +
>  include/linux/netdevice.h                  |  2 +-
>  include/net/xdp.h                          |  1 +
>  drivers/net/ethernet/google/gve/gve_main.c |  2 +-
>  net/core/lock_debug.c                      |  2 +-
>  net/core/xdp.c                             | 12 +++++++++++-
>  6 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

