Return-Path: <netdev+bounces-53736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E08044D9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B388BB20BE1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2B611E;
	Tue,  5 Dec 2023 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnjCYzED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C36FB1;
	Tue,  5 Dec 2023 02:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB53C433C8;
	Tue,  5 Dec 2023 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743262;
	bh=K7+Z4PmTJherMA+QfJtZKMnSBDi8EWhFiIph/biZs1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnjCYzEDhafwXJKdGsMy2PneJB0YNeXvuZtnK43lHxTsfsr0O/w/N02fAfPr2x1Dx
	 UjJtyt5OUlXmFMVr9Q3zynakR8YrhStg5Oms6+KAnyEsSbF6iqjlfpYfzwuu+V9DBY
	 uvz4H7It1TmP6xGEo7C7dmYELcctCR1zAFxfM8oJLsPHo0S9Ft0MsQ8EW6ssDbmeTX
	 u0O47vR4EnSbr73fDqCR4Ip8i2rwNt6jcQmxPvtXBjzpZ4QZFsRPlq5UmEHNcrXcs3
	 S/sDknYjBde6i87gVOQVOLxE8HOTucdrfDkbKgM/JMtCMEFGLtxPBkMwTw613e544a
	 KdGC2/MvZRyLg==
Date: Mon, 4 Dec 2023 18:27:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Grant
 Grundler <grundler@chromium.org>, Hayes Wang <hayeswang@realtek.com>, Simon
 Horman <horms@kernel.org>, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
 netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>, Alan Stern
 <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] r8152: Choose our USB config with
 choose_configuration() rather than probe()
Message-ID: <20231204182740.62a49a14@kernel.org>
In-Reply-To: <20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
References: <20231201183113.343256-1-dianders@chromium.org>
	<20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 10:29:52 -0800 Douglas Anderson wrote:
> If you deauthorize the r8152 device (by writing 0 to the "authorized"
> field in sysfs) and then reauthorize it (by writing a 1) then it no
> longer works. This is because when you do the above we lose the
> special configuration that we set in rtl8152_cfgselector_probe().
> Deauthorizing causes the config to be set to -1 and then reauthorizing
> runs the default logic for choosing the best config.
> 
> I made an attempt to fix it so that the config is kept across
> deauthorizing / reauthorizing [1] but it was a bit ugly.
> 
> Let's instead use the new USB core feature to override
> choose_configuration().
> 
> This patch relies upon the patches ("usb: core: Don't force USB
> generic_subclass drivers to define probe()") and ("usb: core: Allow
> subclassed USB drivers to override usb_choose_configuration()")

Acked-by: Jakub Kicinski <kuba@kernel.org>

