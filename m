Return-Path: <netdev+bounces-138021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC889AB844
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9431C22622
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923801CCED1;
	Tue, 22 Oct 2024 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UdkfIDp1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79318DF6B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631564; cv=none; b=I/H546CMNyKCVmUMO4jBPOzheLWorFI4Xl6ftsanQhWl5zj8aDAyp/tfomLj2+/3rJRtFrGG7DejTXfhrr0bPC10LyM8dlOKMdbaFhe5ws88XzE4bujUyDMvCLtSWjnq7bQH67TzZzxZvbqB+Ka70Bnr10guc0R/HSzvkuZcZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631564; c=relaxed/simple;
	bh=Te+RyFu7Rg6X+sYJG795/7SRNvOJxhJGi91ohHDIVv4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdpAFJ4pWdKJBYkuVWfYVzACnDcfEptQORSNdHWWJa3OJkK7fucq/EvpI3sNFMKwDw8fWyw7EeHCFM54uA89a3FJj0u1DbHuk6uFM6BhtKtdpeSL3cHqtrozgidHvgDm4L5QKt6WkChY5kH9ubhDgEuBXizU7P5RIm0mDwifR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UdkfIDp1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so4286470a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729631561; x=1730236361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMX9gc1p0scgCF3QJqOJTXzbE2PMMPwt5sFvxZKTl0I=;
        b=UdkfIDp1xloy+4W33XMse/ywg3coxJyhcXGV2bxd4zRo+7ycznRAR3rvtH32GQe3tY
         x7wSTejXrpA/fPesGX4YIpxSH0Kcez/pMXXGhJtmQucjpN4orVm3J2oUjnXStCGDbeFM
         p0sTkTyIvcPJ/XWEPHpX/ewHGypCFYUP/N/QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631561; x=1730236361;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMX9gc1p0scgCF3QJqOJTXzbE2PMMPwt5sFvxZKTl0I=;
        b=B4ls+BDFdbKMUVDbM51OqsB1ginu+lJZCTXjeUwWoQL5Z9LHksP6KPoNpyPQK8TZWt
         UvdO6njBtm2RDEHdEjwDhAqyMiMlZZxMTdiV9tN7CNXFH/OcHeLH3gqiH3wQsDY3f0cD
         +zDj0u6ehjiocHZVxSTtMwmqpjTqG3EWgvOR+2T5E51AqK3KQtU53xelttjiQmab9uOg
         Lh5rp43cAM5CNjdcyRe3NjntuvNPn+0SP9MoIJILz54drSbKhMNpElq1tK16ucZMojSk
         tR4BSN8Go7QkXSNtgqJkZu1N0ROoScRBOPFBgBYZQ0cHpeO+KSb6W2mGClEv0d9F6ETJ
         ncNA==
X-Gm-Message-State: AOJu0YwPkjO+1kzHI/Udhue5qR8e1ENvXaSCpla7H4ThL8bKhbGt3OTz
	I18Obu6RNvp6MXQx+mWDsOklW2C0g2OmzJo/9L66tCqx1dgw2fgbESwimx2fJsAYUGvqQk0W4FF
	iMeJj0CwAKRC0Z/3pzcNW7KPlxnme2s6NKyrjTjV/Y8LEbsGefteoLMdPhsDeB4yyY8/XE9aDJx
	KAreyDPEZmIlUKJE8d4FX7NkHDht7WnUkAkZs=
X-Google-Smtp-Source: AGHT+IGnHEnhTMneQ9LqXD5cZl6RxLBvruNmPl3/b4r8UU6lMQb/3OYEEgp7HkqliD+NZqBpTRuusw==
X-Received: by 2002:a05:6a21:2d88:b0:1d9:2a8:ce10 with SMTP id adf61e73a8af0-1d978bae730mr364398637.34.1729631561291;
        Tue, 22 Oct 2024 14:12:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb642sm5323487b3a.179.2024.10.22.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:12:40 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:12:38 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org, dmantipov@yandex.ru,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC iwl-net] e1000: Hold RTNL when e1000_down can be called
Message-ID: <ZxgVRX7Ne-lTjwiJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	dmantipov@yandex.ru, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241022172153.217890-1-jdamato@fastly.com>
 <ZxgEb0N0cJt1BRte@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxgEb0N0cJt1BRte@LQ3V64L9R2>

On Tue, Oct 22, 2024 at 01:00:47PM -0700, Joe Damato wrote:
> On Tue, Oct 22, 2024 at 05:21:53PM +0000, Joe Damato wrote:
> > e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.
> > 
> > There are a few paths for e1000_down to be called in e1000 where RTNL is
> > not currently being held:
> >   - e1000_shutdown (pci shutdown)
> >   - e1000_suspend (power management)
> >   - e1000_reinit_locked (via e1000_reset_task delayed work)
> > 
> > Hold RTNL in two places to fix this issue:
> >   - e1000_reset_task
> >   - __e1000_shutdown (which is called from both e1000_shutdown and
> >     e1000_suspend).
> 
> It looks like there's one other spot I missed:
> 
> e1000_io_error_detected (pci error handler) which should also hold
> rtnl_lock:
> 
> +       if (netif_running(netdev)) {
> +               rtnl_lock();
>                 e1000_down(adapter);
> +               rtnl_unlock();
> +       }
> 
> I can send that update in the v2, but I'll wait to see if Intel has suggestions
> on the below.
>  
> > The other paths which call e1000_down seemingly hold RTNL and are OK:
> >   - e1000_close (ndo_stop)
> >   - e1000_change_mtu (ndo_change_mtu)
> > 
> > I'm submitting this is as an RFC because:
> >   - the e1000_reinit_locked issue appears very similar to commit
> >     21f857f0321d ("e1000e: add rtnl_lock() to e1000_reset_task"), which
> >     fixes a similar issue in e1000e
> > 
> > however
> > 
> >   - adding rtnl to e1000_reinit_locked seemingly conflicts with an
> >     earlier e1000 commit b2f963bfaeba ("e1000: fix lockdep warning in
> >     e1000_reset_task").
> > 
> > Hopefully Intel can weigh in and shed some light on the correct way to
> > go.

Regarding the above locations where rtnl_lock may need to be held,
comparing to other intel drivers:

  - e1000_reset_task: it appears that igc, igb, and e100e all hold
    rtnl_lock in their reset_task functions, so I think adding an
    rtnl_lock / rtnl_unlock to e1000_reset_task should be OK,
    despite the existence of commit b2f963bfaeba ("e1000: fix
    lockdep warning in e1000_reset_task").

  - e1000_io_error_detected:
      - e1000e temporarily obtains and drops rtnl in
        e1000e_pm_freeze
      - ixgbe holds rtnl in the same path (toward the bottom of
        ixgbe_io_error_detected)
      - igb does NOT hold rtnl in this path (as far as I can tell)
      - it was suggested in another thread to hold rtnl in this path
        for igc [1].
       
     Given that it will be added to igc and is held in this same
     path in e1000e and ixgbe, I think it is safe to add it for
     e1000, as well.

 - e1000_shutdown: 
   - igb holds rtnl in the same path,
   - e1000e temporarily holds it in this path (via
     e1000e_pm_freeze)
   - ixgbe holds rtnl in the same path

So based on the recommendation for igc [1], and the precedent set in
the other Intel drivers in most cases (except igb and the io_error
path), I think adding rtnl to all 3 locations described above is
correct.

Please let me know if you all agree. Thanks for reviewing this.

[1]: https://lore.kernel.org/netdev/40242f59-139a-4b45-8949-1210039f881b@intel.com/

