Return-Path: <netdev+bounces-167519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECEA3AA91
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E9B3A5EB9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4F17A313;
	Tue, 18 Feb 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MW12ljdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F601CAA6D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913231; cv=none; b=I2OfdNDlfCkHuITUDLOoUysqTfRgxH1cGSSC4PifrDAb+4mz2JultwZ9KYkb25nlx602vsJTDQ1mTXgB5upPElThfo8uBbwzPOb0HHa0Vp1w6grqQZX9J2zVLtBXJWcW8yxiuI5deqiL6F2/bIQGON6NyxYBE3iUCwTXcEsoFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913231; c=relaxed/simple;
	bh=i91gtUpMUwNf8HF9iqCWkr14SMP3/7jCM/jNhNhhOQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJiOGY0Wp8+4cNfV/ahGkbAHWtn4p/jnqu7YFqlwSoTHLxh+VApOpCzyl0g4KUS2z6fs1mb5DX97xLbcr+KBaP9DSqWwGOQa+/s+mHQdqA8PExd0MFqNTkB9QY259yMN/DscYAMt/SiYCOm0WDs+9tuUh1W9w3alG7RfXDST7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MW12ljdt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0893f9aa6so328966285a.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913229; x=1740518029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOwo1uSBN0fsJpKRiwOTcWgM6AA2XJnPbleDuraZP2o=;
        b=MW12ljdtYz/JttC5dSorWJ3I/VQY7HivPt/rRlPbRaRGZ9Ps5FAHAgAOwjIOV8+/4I
         wmQKNmIvb+9/0A0GMJc5rkBdrKrsed7KOj4Xrm+a8TVfyxhwpzQpiL37RW3UKtHNKBF7
         9ennkOToWTrrozZgZ7Dd9fJfalW4HP/X4LYQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913229; x=1740518029;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOwo1uSBN0fsJpKRiwOTcWgM6AA2XJnPbleDuraZP2o=;
        b=dTDAUmnZxUYHE6B5vywz/733P1biGr1UhdLbcatMrO76MjmxTJDu8V4tDdTzmfXuuo
         F6U3iStDl5fj3LWyQER0CVQMnOL1+AWfBlMaraia9o6yJQ3tI8Gpnq87Zcjq5IOGVffH
         LZ02ERe71SIDRV+JqniSsyQD+Xr5ah1Yc2FeHJqVqfDeHn3pPVJoXVMGzUgTm3V1lRL4
         kVEW2nl2k5gajW3wcDiItSwHuqnZjuhNnQqgB+L5gmvm1ZH19iypgqxj7hgASwk8PMWz
         xQWZJkj5kbzm01gT9elp+b5rhw+K0Gg6HNlHht6QJm8FA2zrCe3ybg+qr1/emI49ejfw
         HOzA==
X-Forwarded-Encrypted: i=1; AJvYcCWT7jlmEihEtCsPvR9Uy28sw0nfoY2rkhUfHF6Byf0lh+tw6CTXosnyoCRzJeSE5MkR4/px8zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQI9/47gZif5jXH6PGa/A2preZp40tqqSkq2T1uJAdyy7cjkje
	LMdhPco7KdfVOxlRP3zCo+4Ocl6aybp7V5NbWxtY1xbdBOL2dqZdNhfLaDATzCI=
X-Gm-Gg: ASbGnctnIAzWYy92a8CoNwcrwVRab+oqj5RGSxHKegXNBuYk0ZV1+kjnCG63MQcUCFz
	FigDSYEFeFtRoHMhIBd6JnSB9lgv2USk3a/ecYqMUtNN438XpAidzhGD7eRXjBp1JF1fmHzaVRw
	Tf+543Ymb/OGEEbcwXLxeGmNwRBeyF3kDq1lwoPsqn9wl4TaZyfXARlYpOdVhNQfuRaZlHaGeQ4
	0waxI9SQd0Mr/NlmLOvhvqzou7RZwHnRrN8/9HpRtNbBeJrjtTTdhP/UxuTiYJhqxjW5GrqapJJ
	orcErhoGAM9GoWptlE5btx26AFmL4S9w1NWQYTDhK9u2wLLaKXMoIw==
X-Google-Smtp-Source: AGHT+IGesKCuK0/R9g56om9VpqMiX07LesHz+meBhAJvZ6v1OlIF4KCjzwJiIbP6w2H19/Dx4Y4i2A==
X-Received: by 2002:a05:620a:4403:b0:7c0:589b:2f37 with SMTP id af79cd13be357-7c08a9dd0a1mr2345321685a.31.1739913228928;
        Tue, 18 Feb 2025 13:13:48 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1027932sm84051985a.115.2025.02.18.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:13:48 -0800 (PST)
Date: Tue, 18 Feb 2025 16:13:46 -0500
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
Message-ID: <Z7T4Cpv80pWF45tc@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>

On Mon, Feb 17, 2025 at 12:31:22PM +0100, Kurt Kanzenbach wrote:
> Link queues to NAPI instances via netdev-genl API. This is required to use
> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
> support") for details.
> 
> This also allows users to query the info with netlink:
> 
> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> |                               --dump queue-get --json='{"ifindex": 2}'
> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
> 
> Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
> requires the lock held.
> 
> While at __igb_open() use RCT coding style.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 43 +++++++++++++++++++++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
>  3 files changed, 42 insertions(+), 5 deletions(-)

[...]

> @@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pdev)
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  
> +	rtnl_lock();
>  	if (netif_running(netdev)) {
>  		if (!test_bit(__IGB_DOWN, &adapter->state)) {
>  			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
> +			rtnl_unlock();
>  			return;
>  		}
> +
>  		if (igb_up(adapter)) {
>  			dev_err(&pdev->dev, "igb_up failed after reset\n");
> +			rtnl_unlock();
>  			return;
>  		}
>  	}
> +	rtnl_unlock();

Does RTNL need to be held when calling netif_running()? If not, you
could probably reduce the size of the section under the lock a bit?

Otherwise, the commit looks OK to me, but I am not an IGB expert and
it is possible there is an RTNL path I missed in my review of the
previous series.

