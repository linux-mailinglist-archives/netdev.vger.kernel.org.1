Return-Path: <netdev+bounces-38226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D97B9CF1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 05092B20993
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00EE134D2;
	Thu,  5 Oct 2023 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy1ZGUj8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591F134C0;
	Thu,  5 Oct 2023 12:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7865C32795;
	Thu,  5 Oct 2023 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696508268;
	bh=lt8rgcQEJlDrGU6JPLN6b36Bd1lxVPb7SqK2tFsmxNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wy1ZGUj8g0lZuAa/Mf5s6ynt8YbAA2rzcibqUjdO7aa9CUefrurLP6t6s45dA1Py4
	 baG81XSuv32pJeeVAjFstIrcutK6B75HC5W1dmsOVoYsxnOxyh0ywDrETvtEPNco3C
	 9Hj1KJN5u2Qf+PpJCUO5hTvx2BiG/Ls8oU4sauehQIY3nz+D0aicUDotR0DpbjUBoe
	 bdhnPMf7JgVwxlFb+T5vUIX5FL+dT6gjzSIIOqm7dqDRfOFIdeB7iPObGfXbZtDeLH
	 Y4ZH1t5ByOOOO4cYAreqSrDH0wGXgBpB6WoRvd08tTgZwiWERsQvxt31BZUAvm1DRf
	 DWJCziqm3INHQ==
Date: Thu, 5 Oct 2023 14:17:43 +0200
From: Simon Horman <horms@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 5/5] r8152: Block future register access if register
 access fails
Message-ID: <ZR6pZ5R14xHkW3zT@kernel.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
 <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>

On Wed, Oct 04, 2023 at 12:24:42PM -0700, Douglas Anderson wrote:

...

> @@ -9784,7 +9904,29 @@ static int rtl8152_probe(struct usb_interface *intf,
>  	else
>  		device_set_wakeup_enable(&udev->dev, false);
>  
> -	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
> +	mutex_lock(&tp->control);
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
> +		/* If the device is marked inaccessible before probe even
> +		 * finished then one of two things happened. Either we got a
> +		 * USB error during probe or the user already unplugged the
> +		 * device.
> +		 *
> +		 * If we got a USB error during probe then we skipped doing a
> +		 * reset in r8152_control_msg() and deferred it to here. This
> +		 * is because the queued reset will give up after 1 second
> +		 * (see usb_lock_device_for_reset()) and we want to make sure
> +		 * that we queue things up right before probe finishes.
> +		 *
> +		 * If the user already unplugged the device then the USB
> +		 * farmework will call unbind right away for us. The extra

Hi Douglas,

As you are planning to re-spin anyway: farmework -> framework

> +		 * reset we queue up here will be harmless.
> +		 */
> +		usb_queue_reset_device(tp->intf);
> +	} else {
> +		set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
> +		netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
> +	}
> +	mutex_unlock(&tp->control);
>  
>  	return 0;
>  
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 

