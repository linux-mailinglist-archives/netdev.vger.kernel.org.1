Return-Path: <netdev+bounces-90390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDD8ADF77
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5237C1C21839
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D30482DA;
	Tue, 23 Apr 2024 08:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC145BF3
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859740; cv=none; b=KB74P6F/tak6nGb8C9Ukl7oaw/BbImC2WzWx4pxdlCLGwB1dNP65Xhqg8/WP8v0d9+uAs2QxgUyZPjfFw/xdSlZRWkGa5sKTjWDdlqycamy2yaPQUdQtLnjHR9HE1h39iOVynjXjPBATDAL+gXDUMng9Uby6P93yRGIGx6YMi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859740; c=relaxed/simple;
	bh=IKH2IIHWDSRgC9eQFK2vBhnxi4BvRXitPUD/pPPW50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8n4PSXwSNV0uum8eBlX4OYtFy6o5xoCZv3dMYI6xa5ZAEQ6vHPLX9LS77Y1ZIbyAIuSH0AJqchXZNoEpzVUwFktemet4aVm8ITtnXaC5IMf9XS0zgxJf+9RSoYV8RZmyYz33MZMQO7pCer9DKqsUNpjJiCVNS91QYEjB9U1c3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B3E86100DEC8D;
	Tue, 23 Apr 2024 10:08:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6E21248A0C6; Tue, 23 Apr 2024 10:08:55 +0200 (CEST)
Date: Tue, 23 Apr 2024 10:08:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, sasha.neftin@intel.com,
	Roman Lozko <lozko.roma@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Message-ID: <ZidslwZAYyu4RnJk@wunner.de>
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
 <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>
 <Zib0veVgvgTg7Mq6@mail-itl>
 <a356d2a0-e573-4e31-bae3-2a361476f937@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a356d2a0-e573-4e31-bae3-2a361476f937@intel.com>

On Mon, Apr 22, 2024 at 04:46:28PM -0700, Jacob Keller wrote:
> To me, using devm from the PCI device should be equivalent to managing
> it manually within the igc_remove() function.

It is not equivalent because the ordering is different:

igc_remove() is called before device-managed resources are released:

__device_release_driver()
  device_remove()             # invokes igc_remove()
  device_unbind_cleanup()
    devres_release_all()      # releases device-managed resources

If you unregister LEDs explicitly in igc_remove() before unregistering
the netdev and disabling PCI device access, everything's fine.

If you instead use devm_led_classdev_register(), the LEDs would still
be registered and available in sysfs after igc_remove() has torn down
everything, which is bad.

You'd have to use devm_*() for all initialization steps in igc_probe()
to make this work.  With devm_*() it's generally all or nothing.

(There are exceptions:  Using devm_*() just for memory allocations is
fine as those can safely be freed even if everything else is torn down.)

Thanks,

Lukas

