Return-Path: <netdev+bounces-117993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329595031C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353C51C224FA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630EB19B3C5;
	Tue, 13 Aug 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BT1RWm05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66B19A2BD;
	Tue, 13 Aug 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546667; cv=none; b=rVJvwntTzq4qioqs9rj5tH3//p+rXZMxxh62Q+Oq5BmGpP1T0+o5NBY1WozrOuc6ADWK1zTIz0yRwW+xEaZp6LCyaI87ESdlHwA7fFaKHUt5puVqeaA97nBzDZ7t/j51ZMSJGqTN5Tfse2yZEOnTgWeap/XDpIJpBX997cMJXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546667; c=relaxed/simple;
	bh=V5hl2VkMO6rgdQk2s5zwqazwuUp62vPKP4mkTn7a+b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To5YyzNHi3G/50BoI7x7q+kMiyuJ1uNzE6Q6GPZ7I+VwKXz0lSnzAGQ1WSj9KRMOMpo1XjAkccvcLThI4JiIA6dRzwxhSn9KrESyabDiLQsM692aoMiqLhUmkHjGgwds9P76vEWOoaV6O+ztSLEVMVkHVOSwN62wnKVpqRlXJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BT1RWm05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3ABC4AF09;
	Tue, 13 Aug 2024 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546666;
	bh=V5hl2VkMO6rgdQk2s5zwqazwuUp62vPKP4mkTn7a+b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BT1RWm051pHj7rei2TztKCZxk4OEok3dlUFAOjt4PMPW/KTXt74lFYAi3VqkMixu/
	 jaAGH3tbYJfxIIg/jrU2/Qjov2CajGBhQrGuz8GzhlRsvQ3WW1hypcIjcDt0Ge+gx3
	 Wrn0S57OcET5z7/IbDXfVMuisCUNEed2PVO14dxc=
Date: Tue, 13 Aug 2024 12:57:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] driver core: Introduce an API
 constify_device_find_child_helper()
Message-ID: <2024081311-mortality-opal-cf0f@gregkh>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>
 <2024081314-marbling-clasp-442a@gregkh>
 <3f7e9969-5285-4dba-b16e-65c6b10ee89a@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7e9969-5285-4dba-b16e-65c6b10ee89a@quicinc.com>

On Tue, Aug 13, 2024 at 06:50:04PM +0800, quic_zijuhu wrote:
> On 8/13/2024 5:45 PM, Greg Kroah-Hartman wrote:
> > On Sun, Aug 11, 2024 at 08:18:08AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> Introduce constify_device_find_child_helper() to replace existing
> >> device_find_child()'s usages whose match functions will modify
> >> caller's match data.
> > 
> > Ick, that's not a good name, it should be "noun_verb" with the subsystem being on the prefix always.
> > 
> okay, got it.
> 
> is it okay to use device_find_child_mut() suggested by Przemek Kitszel ?

No, just switch all callers over to be const and keep the same name.

> > But why is this even needed?  Device pointers are NOT const for the
> > obvious reason that they can be changed by loads of different things.
> > Trying to force them to be const is going to be hard, if not impossible.
> > 
> 
> [PATCH 3/5] have more discussion about these questions with below link:
> https://lore.kernel.org/all/8b8ce122-f16b-4207-b03b-f74b15756ae7@icloud.com/
> 
> 
> The ultimate goal is to make device_find_child() have below prototype:
> 
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> Why ?
> 
> (1) It does not make sense, also does not need to, for such device
> finding operation to modify caller's match data which is mainly
> used for comparison.
> 
> (2) It will make the API's match function parameter have the same
> signature as all other APIs (bus|class|driver)_find_device().
> 
> 
> My idea is that:
> use device_find_child() for READ only accessing caller's match data.
> 
> use below API if need to Modify caller's data as
> constify_device_find_child_helper() does.
> int device_for_each_child(struct device *dev, void *data,
>                     int (*fn)(struct device *dev, void *data));
> 
> So the The ultimate goal is to protect caller's *match data* @*data  NOT
> device @*dev.

Ok, sorry, I was confused.

thanks,

greg k-h

