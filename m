Return-Path: <netdev+bounces-129782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4AA9860AD
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339E81F20EE6
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3818C35C;
	Wed, 25 Sep 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRPvY2/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E618C346;
	Wed, 25 Sep 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270511; cv=none; b=K7gPZNrGlhPbeRlrwm461m0pIGAtZAxvPt+QVdTVsFoa4UZlkfsJ/yUW8s6/AB/5u3Uc4Krq3lTNdoK5XlyZKExH5Xfa+P5HFWkUfmo/psSeKR7fYHqrG9m2KLY6XVbX0jtpIshiJd81nUMwwsooAv4BaOd2NVLHp52v9yEMNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270511; c=relaxed/simple;
	bh=ADWhj4hawUK5zqCZtBb23jF4SLLGjipPS8iBDdBffmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1PLiZ6VrjTSfVxUT4hEpl0j5UDu82RJ0vKCrZZVdU3XYhcr43BxJfoC1ata8hcmPfpVTaso7ELZbjQEfsotlb6V6wAi5ZKXuHMrCsDGRLzms9KA3RfePLYlcuJTXD5wjXQvBXXBL2/b73IJPGqVs19Xdu4GqtvZOEayN5Zm8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRPvY2/h; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so375181a91.3;
        Wed, 25 Sep 2024 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727270509; x=1727875309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08og8GdyLKkF2dSHAd4GnLHF9zkB2zM8Xt85XEgBzYM=;
        b=gRPvY2/hN8qWYlaHDoOOz1bMxohZuqQ+SW6vZlS6W5UX8sp94LJKH7BEYs0ywiO+hA
         zW3UzAz/B33GTJG1smPjeE1E8p1cEF/+x72Qm2ZqW5TDpxzVsvoPD4IGXhbMadKxZ+Tb
         MtqFdSC32mtEHZFUFGHaSgyMJ6j+hQauMo07LxjXRWZWrHRMME7sHvgMI1fS6hmfcHBE
         0MWCOKlibmyGdcFAH8mKJQqJfgfhw1lQ7gtWivtTbIMYu2hl/brevsWtJkPEdZvWV5cg
         EnFqVyTYB06UbR4x6FansaYu7Yy3mYRepqlF2bDHy6cMen2oNCoCaI47ekrim1OfoZRl
         6LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270509; x=1727875309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08og8GdyLKkF2dSHAd4GnLHF9zkB2zM8Xt85XEgBzYM=;
        b=aawu/FOJQE6ys85EMDRZZBHZTZMFx2z07f2A/9xLmcGgyKw52dVlp0M2o1YHFaoUn5
         uII0WykBE+sXShKhBdFFwSTwvWnkMmjlZ2vWOhyk7RdeEoy07rODnfHohfYrJGQuPAV2
         eDG7fChFxnICyi8yO6+uPYyLVFHt6SmY1HXEOeqhuuH1fNa5Om7TuTlwII2gn3Lw0kEv
         /Ukg3Vm9kVbzQRp+E+dRp7dt95xvBmv9i4Q58r/H9TiKGU5bhgIXNcPAvib7tabJkqyR
         x0Zo04SZ3zGSr1hynF1TyrZT5OD2WWInETQcKqUSKiKMSzV3xhstsRCr2jmxlTWKnBXf
         QM7w==
X-Forwarded-Encrypted: i=1; AJvYcCU2YTsNhcKjeAcEU4e2TCdw/uLX/3E4tGOdvDYLd2KDPWP/Sl6nnwhTyvcmizzlx8T758kzihZBzgDOi5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkGw6RVNXJvMrcA42/fe69eVY8AwuOBRPVtm3e6QQkCUYEbat
	McQCn2dmecB4Yj4TtRgvSYKKMFN3qk+9cE6Ijh1DqOLVD3GcrlDi
X-Google-Smtp-Source: AGHT+IF0xU6qPmtya1IlfPDznMVXsiAYGi4ZyN0qrGa+SRlPcyZXmzAV2KUtZwXwDSKAFeaxKDLp7g==
X-Received: by 2002:a17:90b:1e50:b0:2d8:7561:db71 with SMTP id 98e67ed59e1d1-2e06afc413bmr3065034a91.25.1727270509119;
        Wed, 25 Sep 2024 06:21:49 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16fef3sm1509878a91.1.2024.09.25.06.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:21:48 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:21:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jarod Wilson <jarod@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Bonding: update bond device XFRM features based on
 current active slave
Message-ID: <ZvQOZALIQWOcPRAn@fedora>
References: <20240918083533.21093-1-liuhangbin@gmail.com>
 <1b507e18-24a4-4705-a987-53119009ce3f@redhat.com>
 <ZvOx95zrrKonjTPn@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvOx95zrrKonjTPn@fedora>

On Wed, Sep 25, 2024 at 06:47:27AM +0000, Hangbin Liu wrote:
> On Tue, Sep 24, 2024 at 03:17:25PM +0200, Paolo Abeni wrote:
> > 
> > 
> > On 9/18/24 10:35, Hangbin Liu wrote:
> > > XFRM offload is supported in active-backup mode. However, if the current
> > > active slave does not support it, we should disable it on bond device.
> > > Otherwise, ESP traffic may fail due to the downlink not supporting the
> > > feature.
> > 
> > Why would the excessive features exposed by the bond device will be a
> > problem? later dev_queue_xmit() on the lower device should take care of
> > needed xfrm offload in validate_xmit_xfrm(), no?
> 
> I'm not very sure. In validate_xmit_xfrm() it looks the lower dev won't
> check again if the upper dev has validated.
> 
>         /* This skb was already validated on the upper/virtual dev */
>         if ((x->xso.dev != dev) && (x->xso.real_dev == dev))
>                 return skb;
> 
> Hi Sabrina, Steffen, if the upper dev validate failed, what would happen?
> Just drop the skb or go via software path?

Hmm, I saw a similar commit 28581b9c2c94 ("bond: Disable TLS features
indication"). I will check the history and see if we can do like this.

Thanks
Hangbin

