Return-Path: <netdev+bounces-50275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D247F7F52E9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F01B20D3C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9C1D548;
	Wed, 22 Nov 2023 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBYXk5RO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0C1D69C
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A03C433C7;
	Wed, 22 Nov 2023 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700690444;
	bh=B6ubj/M75t4aQip3J33Lxx65Rx6P8qg7WwiQ0NkRRh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBYXk5ROs6RAjSwrY1tWZ6sWE0J3dhhnS8eNLgYyEXCBBEIpnjzfTHZiRS/oRGS1l
	 cIuwvhaMTM1L5kIUb+oXJLYGu7hp3WiGFCZvXhJ/VE8meKIlpfZKtaCMTBytqdaMQQ
	 l/vgp0moT+Ak9SvgBlD1AwKQpp9r6hFrtSrqQmYZFLOK2+EgVTVox2oESK4SNwmLjk
	 S5Ujh1rY8io3RypW9YA473BbIDH526IYSagKmzNqPJWm02Dtve8m2l90UCCL1eGb3y
	 cu8/89hqXDHXwRmUutVwvW4y2Vi/Xcby7KZ+1SXhsduXJV1F2HxON3iZiFay/diU0k
	 BxEJUPmotbFuQ==
Date: Wed, 22 Nov 2023 14:00:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: Willem de Bruijn <willemb@google.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Message-ID: <20231122140043.00045c80@kernel.org>
In-Reply-To: <8658a9a4-d900-4e87-86a0-78478fa08271@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
	<170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
	<20231120155436.32ae11c6@kernel.org>
	<68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
	<20231121142207.18ed9f6a@kernel.org>
	<d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
	<20231121171500.0068a5bb@kernel.org>
	<8658a9a4-d900-4e87-86a0-78478fa08271@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 13:28:19 -0800 Nambiar, Amritha wrote:
> Trying to understand this distinction bit more:
> So, netdev-genl queue-get shows state of queue objects as reported from 
> the netdev level. Now, unless there's the queue-set command changing the 
> configuration, the state of queue-objects would match the hardware 
> configurations.
> When the user changes the configuration with a queue-set command:
> - queue-get would report the new updates (as obtained from the netdev).
> - The updates would not be reflected in the hardware till a reset is 
> issued. At this point, ethtool or others would report the older 
> configuration (before reset).
> - After reset, the state of queue objects from queue-get would match the 
> actual hardware configuration.
> 
> I agree, an explicit "reset" user-command would be great. This way all 
> the set operations for the netdev objects (queue, NAPI, page pool etc.) 
> would stay at the netdev level without needing ndo_op for each, and then 
> the "reset" command can trigger the ndo callback and actuate the 
> hardware changes.

How the changes are applied is a separate topic. I was only talking
about the fact that if the settings are controllable both at the device
level and queue level - the queue state is a result of combining device
settings with queue settings.

