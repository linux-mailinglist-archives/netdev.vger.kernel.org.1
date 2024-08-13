Return-Path: <netdev+bounces-117963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF395017C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624F81F23525
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3F16DEAA;
	Tue, 13 Aug 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x40ehJjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168013AA2E;
	Tue, 13 Aug 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542349; cv=none; b=Sr1vO233UvUnTLC3XEdK54Wd3BCXEEWnHBpaBC6WcLfRLpE2HBE4xh0oQMuhnviUy60+0n533txWUtVzt/oebGTJbbqArfrp17ddfbggFU7e1MYehqP6RBKCiHbpitqhFwlMV1FgYWk/HQGH2zTo7WIek999Ec4x3eLope/cvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542349; c=relaxed/simple;
	bh=dr505emU6fLKiiCedG7OK03aaqdZZc69vWq72dXDH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdUSvg2r5IUOmWYnijAAZSPwUxFEuh02iChwreZbb/7NifBuJgDk4q73KiXh0lET47q0sbe4u/tUo1EeriiSWpl2GjoXMnuV+tIyoNLAHHHHRs30zfTERfmiJaE02uDb3x5rBLTrw4RVoj3Qeuu1Q5s4/cOu/KTOSVtOizlivpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x40ehJjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0343C4AF0B;
	Tue, 13 Aug 2024 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542349;
	bh=dr505emU6fLKiiCedG7OK03aaqdZZc69vWq72dXDH44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x40ehJjgu9UfDoqGkEtY9q/RLv4J61FbjRspEZDI9YV5/utHT7lbsmPuaGdvS6f6j
	 /fIM2HSrAO9NVcrxadGa1PBEBM+VDWQrglcCWPpxMCXqI6jGe+SuIfLVjZDglqX4p7
	 +uzyeqIsVvborBa3U8LWD+T1Yli0if9AyA6RS+Nw=
Date: Tue, 13 Aug 2024 11:45:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/5] driver core: Introduce an API
 constify_device_find_child_helper()
Message-ID: <2024081314-marbling-clasp-442a@gregkh>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>

On Sun, Aug 11, 2024 at 08:18:08AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Introduce constify_device_find_child_helper() to replace existing
> device_find_child()'s usages whose match functions will modify
> caller's match data.

Ick, that's not a good name, it should be "noun_verb" with the subsystem being on the prefix always.

But why is this even needed?  Device pointers are NOT const for the
obvious reason that they can be changed by loads of different things.
Trying to force them to be const is going to be hard, if not impossible.

thanks,

greg k-h

