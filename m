Return-Path: <netdev+bounces-138007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C199D9AB751
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5451CB231BF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D7153828;
	Tue, 22 Oct 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CUx72Qx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB713AA2B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627254; cv=none; b=mtgau4SPFpgeFE4WrGKlj6k5uUrKF4bMuvYQyrX6EKwPZfVi+8+dZ/a8ihtFzoAvQq/6U1OUOZ7s3IKnmFkK9qGIf11kaG88PHeQvNc734yDy8pPBoGcEimqZVff3h9c20G1tqAagiAeFaq8cE4E52yzkw22+8EqIJLYvb0x4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627254; c=relaxed/simple;
	bh=R0HHZZkkZmBHPKqt4D7wfQOkyAXUc9i0cW8k6fPcLfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfKiX1ZQZ5V2PURfgCm94D47Q97UKGXN2HVHyPsrWbowLdCIADvhYugtpmMpnThaidXtRHzBSVy91swOIdw8/Rpn+KXm+os/mJWJ6ZSygUFeBrfgkgbhegr3SObsMHeh8Ya5wB7uIrOJLcOpCWP81on5L1908zMDGPLWZS4RgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CUx72Qx/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caccadbeeso66032625ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729627252; x=1730232052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf57IdvfhRrsCh7RnxCCaHPG51VLTTsW/2BLHH3AQ0E=;
        b=CUx72Qx/sLUGECyNTGJFdTKHsJkefyqud698DJnjA5HqGqXhL+oMijxGs27VeTCAte
         opR02CVRn54NsyRB55ZM7D+lqrgBEQ/6YV8FaESwsFmmafQVZZi0VQQD+B2JUW8+EFUJ
         O2F3/9kIpEQ//xyVHVcCFLPez4jGldC0uasj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627252; x=1730232052;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cf57IdvfhRrsCh7RnxCCaHPG51VLTTsW/2BLHH3AQ0E=;
        b=PMGgHUq5HOyWXMwP8f99rS2xJQ2VzXmW6wtVpLZ1a4PuFRXf8JnhuhlYyr48tpvTeK
         fAv3OMTeH3Dj6yGeb33O+2X3FhiUU3ks5cuIkMYpz0EHr0LcU0OceGJ9mFtG30RmlFls
         xRxdL1t/WSrbjl+oaHpJrt0FlrdPRbeTgkHWOAP21uQMpycsckh5MjJI/RRTEzJwywGZ
         YAHqS/Eru3Hi7BmczEenBkIQXUd0szR9uIGPQOfXJshSAB08gHzVtYFS1b9Vwip1DJSM
         dPv4WmlyT+bVeZ6K8S9NB77908hHJo+crn5FpNa78HAoNslPlCjnr9Dxl98vGGQhovwG
         6nwQ==
X-Gm-Message-State: AOJu0YyIVU5ek3iz4gKE3FTUmgjKmfzQgi7r0pH6Neepp7wOrnzrU0DA
	rgNdYN583i2sXj97/4+lqHtaIrc+qFVsdySPo6wWQp2FbSIK3XmzCIi4YLEzBZ+eKLDuDhBXCj0
	ktdFYqEDMgaGkWu49wdW/j88FWg18FUyC2ONnu2hvz2WNlefEAG8QgisZNZmYshwdNlUa5n38hO
	OaleDezicJwedXWbQHbE+woyDlcTqIZvaWidI=
X-Google-Smtp-Source: AGHT+IHAhsM57JFqrnl5WExxOcZT26xz5WKpMt8kr/USHG17C5v6KjFuSb/JdmQAVaMNBs5fRvraBw==
X-Received: by 2002:a17:90a:b383:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e76b5dde2dmr122577a91.13.1729627251084;
        Tue, 22 Oct 2024 13:00:51 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad368b25sm6662797a91.24.2024.10.22.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:00:50 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:00:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: dmantipov@yandex.ru, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC iwl-net] e1000: Hold RTNL when e1000_down can be called
Message-ID: <ZxgEb0N0cJt1BRte@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022172153.217890-1-jdamato@fastly.com>

On Tue, Oct 22, 2024 at 05:21:53PM +0000, Joe Damato wrote:
> e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.
> 
> There are a few paths for e1000_down to be called in e1000 where RTNL is
> not currently being held:
>   - e1000_shutdown (pci shutdown)
>   - e1000_suspend (power management)
>   - e1000_reinit_locked (via e1000_reset_task delayed work)
> 
> Hold RTNL in two places to fix this issue:
>   - e1000_reset_task
>   - __e1000_shutdown (which is called from both e1000_shutdown and
>     e1000_suspend).

It looks like there's one other spot I missed:

e1000_io_error_detected (pci error handler) which should also hold
rtnl_lock:

+       if (netif_running(netdev)) {
+               rtnl_lock();
                e1000_down(adapter);
+               rtnl_unlock();
+       }

I can send that update in the v2, but I'll wait to see if Intel has suggestions
on the below.
 
> The other paths which call e1000_down seemingly hold RTNL and are OK:
>   - e1000_close (ndo_stop)
>   - e1000_change_mtu (ndo_change_mtu)
> 
> I'm submitting this is as an RFC because:
>   - the e1000_reinit_locked issue appears very similar to commit
>     21f857f0321d ("e1000e: add rtnl_lock() to e1000_reset_task"), which
>     fixes a similar issue in e1000e
> 
> however
> 
>   - adding rtnl to e1000_reinit_locked seemingly conflicts with an
>     earlier e1000 commit b2f963bfaeba ("e1000: fix lockdep warning in
>     e1000_reset_task").
> 
> Hopefully Intel can weigh in and shed some light on the correct way to
> go.
> 
> Fixes: 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs")
> Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
> Closes: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
> Signed-off-by: Joe Damato <jdamato@fastly.com>

