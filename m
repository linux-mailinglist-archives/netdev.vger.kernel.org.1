Return-Path: <netdev+bounces-167811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C304A3C6CC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428C73AA3F7
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166C2144A7;
	Wed, 19 Feb 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AWTkDZC2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AA1A7264
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987722; cv=none; b=hpJJbF2tL8s0HI2u5c3q0sExAGZIALOuKndMKz/yhDYZnFOelpj41fUSS2p+DiK0uUSuS0EPgweRzZ/zuE4al3OFWSrjSx87TTDw0J+IbhN5UdBoiKoRppOhh9eGwbMGYHIt4/Ef2yw4PdapUiARghxQXia/nJlNAPuuHr5g4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987722; c=relaxed/simple;
	bh=l21VrC0JUWIEUpgrrSz7Xu+rqGP73QVa/WlJL3mpSIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4fDNmfWQUb/r7eerkHUDyn6tH4PlCbMigEtM7ThXUjCiUrrvErE3Ior7ca0sdQ6L+7IPrj0Khmc/ajAOofMGk5bToHqSuH1XPYPKPZT0kqNh9P/fJGXuJMNOjoc27QAMG1O8P9+FiIFCBt7GG/4q5uxVqDI0rViPAzegS76nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AWTkDZC2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c07cd527e4so2614985a.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739987719; x=1740592519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+U4hlbRRkCtOivqiZ1mgI+iuEuIRsQgZ1yTe2Wwk4Q=;
        b=AWTkDZC2U33BOmNsq1RhLpI77ELes88gQa30ihQtVfO8mr6rYVoYRJ1DldsmDnkFS7
         zCYbCqX/H6zp6pBwecuQd+ZduWkI0gGXyvwSutdWbhZPhPvS1UiZ3HkYX5DD0D8yFfK/
         DWItcYTDG5AseywyeadDAQXb26cVVn1K+ALUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987719; x=1740592519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+U4hlbRRkCtOivqiZ1mgI+iuEuIRsQgZ1yTe2Wwk4Q=;
        b=gdJJ/Mur+8qPj6j36slrprcXLWNXX/MiefXSFf/NvOBIs7yJfKPw/5uR4ogx4BC1Kv
         UPpsapo21MlF0RTDM0aPdCrsbNpETU+S1bS6uebxCuhZT8l7L33grBoUdG5cD5MVOvG1
         ismSXoM00ux36HHuNJ0j70x0v0Z1tX3GaNdmMuaiHkowVlB9MvdmLrESDl+wjBlZwpHq
         AlbezemTr2Xck7iuL/slJjYjWEdgDlocqoYQi0yu2szgqKolGyGx6NzoFSFaVp9TPReW
         RvYfQB0ze9ebSzi6d+g/cI5rfatPleViM5lje8cwx/mKhR7hTSR5Jam5qqlD/uzTu9Na
         oMXg==
X-Forwarded-Encrypted: i=1; AJvYcCW2bQ9e3Z5ikXb8Jpp+Jya9Q4qhITk11iVpZI1/0lV58JyQ5kYUJOA30jUt9CxIIcYAyEzuZ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWM1fN7oBPkbzRPG0oJpyeua5X5FA8ZGgXCAuU+zb1+8ezSqR
	Idwwrsj4FO+k2zvcY6bI3fP8mhM1mkuvydMWu8oPjzIYa2xZB4Sf5CL3lBt1p2Q=
X-Gm-Gg: ASbGncsmoQ2LhlAHh/JddNtxqugSKqFiqYwpZV1RHIn0JBOdd5z4cwT6H4LASZW4B4j
	yFp92WSoBqvtXekS3ehZRD35xnfG91PpgeiazZmkt2UjYiTiRc/0JGkMgKwYw8lOCmR5xJJv6tx
	Y1XC/0rVXKsrbwGLcSA2LO7JuAZJFneOS6s6BefOibpRZwQ/bK1Df7nVCA+IuYl/RsDlYoK/v7J
	M/dx8U83lFXzVKlvO6L31NE+f7nsInYzX+I8+i5fpaSfVvgyuyIcnrgiJPfbDjOnrN2MWUX1idC
	262zSvRm8izHUlhM4TQTBfX2GVhvlGnPuuvzeYRAqAsXApXXTznwuQ==
X-Google-Smtp-Source: AGHT+IF4JWqBzCr9WxZgFH1oI0VmRy7ElF1B9/75UZ7FGlelL5kiY6+NLR0PHY+4Ssp1JO5WDWjiHw==
X-Received: by 2002:a05:620a:2491:b0:7c0:ab10:111d with SMTP id af79cd13be357-7c0ab10139fmr1386653285a.51.1739987719327;
        Wed, 19 Feb 2025 09:55:19 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b3bf7374sm146704085a.95.2025.02.19.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:55:18 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:17 -0500
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
Message-ID: <Z7YbBQqT4wOtmbgC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
 <Z7T4Cpv80pWF45tc@LQ3V64L9R2>
 <875xl62xgy.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xl62xgy.fsf@kurt.kurt.home>

On Wed, Feb 19, 2025 at 08:41:01AM +0100, Kurt Kanzenbach wrote:
> On Tue Feb 18 2025, Joe Damato wrote:
> > On Mon, Feb 17, 2025 at 12:31:22PM +0100, Kurt Kanzenbach wrote:
> >> Link queues to NAPI instances via netdev-genl API. This is required to use
> >> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
> >> support") for details.
> >> 
> >> This also allows users to query the info with netlink:
> >> 
> >> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >> |                               --dump queue-get --json='{"ifindex": 2}'
> >> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> >> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> >> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> >> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> >> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> >> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> >> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> >> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
> >> 
> >> Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
> >> requires the lock held.
> >> 
> >> While at __igb_open() use RCT coding style.
> >> 
> >> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> ---
> >>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
> >>  drivers/net/ethernet/intel/igb/igb_main.c | 43 +++++++++++++++++++++++++++----
> >>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
> >>  3 files changed, 42 insertions(+), 5 deletions(-)
> >
> > [...]
> >
> >> @@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pdev)
> >>  	struct net_device *netdev = pci_get_drvdata(pdev);
> >>  	struct igb_adapter *adapter = netdev_priv(netdev);
> >>  
> >> +	rtnl_lock();
> >>  	if (netif_running(netdev)) {
> >>  		if (!test_bit(__IGB_DOWN, &adapter->state)) {
> >>  			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
> >> +			rtnl_unlock();
> >>  			return;
> >>  		}
> >> +
> >>  		if (igb_up(adapter)) {
> >>  			dev_err(&pdev->dev, "igb_up failed after reset\n");
> >> +			rtnl_unlock();
> >>  			return;
> >>  		}
> >>  	}
> >> +	rtnl_unlock();
> >
> > Does RTNL need to be held when calling netif_running()? If not, you
> > could probably reduce the size of the section under the lock a bit?
> 
> All the other instances in the driver guard the netif_running(), too.

OK, I spent a bit of time tracing through the paths in the igb
source. I think the v1 feedback I sent identified all the RTNL
paths, but: 
  - I am not an igb expert
  - I don't have a device to test this on
  - It is certainly possible I missed a path in my v1 analysis

The above said, as far as I can tell this patch seems fine, so:

Acked-by: Joe Damato <jdamato@fastly.com>

