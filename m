Return-Path: <netdev+bounces-91224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB938B1C24
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455EF1F252AE
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7371B50;
	Thu, 25 Apr 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUUSGQTB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F056F076
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031262; cv=none; b=UF3/Ht5ojSBWWIYUtT3FN9eYa8wjmw6Gj38jTEFV7ZG9qtSF28ud8dC/i+mdhcBdhad4Pd99J1oWQXxrjLiL16NIFZQr0g2a2p796eTNf6rGewqO5K8+Clk7LxuASUqStwbS1eqpkvl3FS7ngln/xn81AX25ioW/tb4o72p+NoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031262; c=relaxed/simple;
	bh=IGabuA64NnpKP7f5ou4CdSEhvaPSr8P5eeKBc/hOv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4aU+y323R0MuWz+ljP6ILla+BSIDtJ4IsvcH1NgQXFEwc052SxUQR2hA/UxIW97gFseXSkHenqjA1L12heeS+SlrBr4KuvjFpfG3Y9NA4H/NSAvg9/ST8ERjzGE2WS9kHHwC6VFIFMLymMI5Ljc3mWUCBOeI/VUY8gGiVQyKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUUSGQTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714031259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6u2GQrZIUPc3UtWj+HqbRZ4C2sJ6DI8OwDGnwuEGQw=;
	b=GUUSGQTBz1UFAP/JIAtepYX+/e/RaprOzVmUuknbNAd9aNDc7m8TQasX1BXu+UzkxaPZD/
	j56+EfpLa2LphT57XUgh0sxHpDXeZxox47qYZNTwE4BBYzAE2YwARuWMNswiiCJamGeONl
	DHSu1Ilk06OD2kynSpWCI+l3HsGrP0o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-McY1q1EaOMCsVovORRBbHA-1; Thu,
 25 Apr 2024 03:47:35 -0400
X-MC-Unique: McY1q1EaOMCsVovORRBbHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 806E53813F2E;
	Thu, 25 Apr 2024 07:47:34 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FDDA47B;
	Thu, 25 Apr 2024 07:47:34 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 25647A80BA0; Thu, 25 Apr 2024 09:47:33 +0200 (CEST)
Date: Thu, 25 Apr 2024 09:47:33 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix a log entry using
 uninitialized netdev
Message-ID: <ZioKlQR9z8RWGFAB@calimero.vinschen.de>
Mail-Followup-To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
References: <20240423102455.901469-1-vinschen@redhat.com>
 <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch>
 <8734raxq4z.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734raxq4z.fsf@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Apr 24 17:06, Vinicius Costa Gomes wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > On Tue, Apr 23, 2024 at 12:24:54PM +0200, Corinna Vinschen wrote:
> >> During successful probe, igc logs this:
> >> 
> >> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
> >>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> The reason is that igc_ptp_init() is called very early, even before
> >> register_netdev() has been called. So the netdev_info() call works
> >> on a partially uninitialized netdev.
> >> 
> >> Fix this by calling igc_ptp_init() after register_netdev(), right
> >> after the media autosense check, just as in igb.  Add a comment,
> >> just as in igb.
> >
> > The network stack can start sending and receiving packet before
> > register_netdev() returns. This is typical of NFS root for example. Is
> > there anything in igc_ptp_init() which could cause such packet
> > transfers to explode?
> >
> 
> There might be a very narrow window (probably impossible?), what I can
> see is:
> 
> 1. the netdevice is exposed to userspace;
> 2. userspace does the SIOCSHWTSTAMP ioctl() to enable TX timestamps;
> 3. userspace sends a packet that is going to be timestamped;
> 
> if this happens before igc_ptp_init() is called, adapter->ptp_tx_lock is
> going to be uninitialized, and (3) is going to crash.

The same would then be possible on igb as well, wouldn't it?


> If there's anything that makes this impossible/extremely unlikely, the
> patch looks good:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
> Cheers,
> -- 
> Vinicius


Corinna


