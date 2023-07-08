Return-Path: <netdev+bounces-16168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD174BA7A
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A402818B6
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB410E5;
	Sat,  8 Jul 2023 00:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A710E3
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 00:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CBC433C8;
	Sat,  8 Jul 2023 00:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688775146;
	bh=ijIPQ+hptm0DWZFgQRUdBDKFLI/pxNjT4o8gTe1nWV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VejCWVV9U7psKJ3JrtNUdWwyjWoiPvzKVme9p7gPfbfghJgkdEX8kpkGiL6F7yYRq
	 r+oHGPOjOOtEgsSRr+bxii5/WgIRCwYDC+KZAQ6KasAjQnW4km/WeHSN0SS2oAFOfi
	 Jb/QD3EWha/3zssviaP/GAXjJgmyrYVZXUx0Jy3nzs/a0VKB/DBZGBPvPI+X2pHby9
	 wTXv07i+YK1VlXHk+N0sz2Zu51eiYvC0XuNpcG5PkG8QpfpF+zvHbSyLT8YN7kleIy
	 sPLoJG/Nle4Wwh+3OTtbo+SYbpJuMSd3UIKlvQAmVj9QwYr5LrLYdsg+d3VGfgG6lo
	 +QyOFXkmKXmQg==
Date: Fri, 7 Jul 2023 17:12:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hayeswang@realtek.com,
 jflf_kernel@gmx.com, bjorn@mork.no, svenva@chromium.org,
 linux-kernel@vger.kernel.org, eniac-xw.zhang@hp.com, stable@vger.kernel.org
Subject: Re: [PATCH] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <20230707171225.3cb6e354@kernel.org>
In-Reply-To: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
References: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 18:28:58 +0000 Alexandru Gagniuc wrote:
> For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> in U3 state. If it is not, and the host "disappears", the chip will
> no longer respond to WoL triggers.
>  
> To resolve this, add a notifier block and register it as a reboot
> notifier. When WoL is enabled, work through the usb_device struct to
> get to the suspend function. Calling this function puts the link in
> the correct state for WoL to function.

Would be good to hear from USB experts on this one, to an outside seems
like something that the bus should be doing, possibly based on some
driver opt-in..

> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>

Please add a Fixes tag - I'm guessing it dates back to

Fixes: 21ff2e8976b1 ("r8152: support WOL")

?
-- 
pw-bot: cr

