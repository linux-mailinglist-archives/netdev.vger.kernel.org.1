Return-Path: <netdev+bounces-199658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E985DAE12CF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 07:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23E51BC3DEF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 05:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD920766E;
	Fri, 20 Jun 2025 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwXhW/3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B0204680;
	Fri, 20 Jun 2025 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396244; cv=none; b=rlcTh/DBKVBdreV9ximoVU1s7WlQ66Mt0bJQiXQ5M4uvwyUa0bsSOKaG+oi2HHtNYuTP70aSPTCOxCMqcIj/x1yFWrYHw8U65qCyONAha4eM6+B5gPJpmgtB8Fo9uywED8XTFLbMKtIz/cNRNTHF7zfNlamcOV9Z70KT3+G1Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396244; c=relaxed/simple;
	bh=3Owcc1dRQY1Z8F1XG3Fhvz1hyBv+3yD4Obr3vbxaSeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVBtXaoNwONst7Y7Nu+vNVMo28TY8VRtjk4mkfGJhtyfEhGGfPaI4S5zMEs+Gnytk1ZOvk9JFhIBpRxoaJZeOa9Nqf4ioSkoQjdGhoYXefpx8ndZMMkarcn1szelab8FcUKBQxd9JjkLNDfkEo1SyqKBz+XKujpesaRfWMEMWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwXhW/3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2586FC4CEED;
	Fri, 20 Jun 2025 05:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750396242;
	bh=3Owcc1dRQY1Z8F1XG3Fhvz1hyBv+3yD4Obr3vbxaSeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwXhW/3dW4NobnXVrDnuTj9sJWvpONnO6e13RC1b8v30Q5BZHyA5X3ixaqY+vERJb
	 nr0Zh0vWuZwid66smDuNUlz+GLmutwxaZze2SOUG5oh8nwy/AJTCVGfwt0fp72Yt9Q
	 U9MjBGLTf5narKknvYW6atYjvPurd6V4NfTaM6CU=
Date: Fri, 20 Jun 2025 07:10:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH net 0/4] net: axienet: Fix deferred probe loop
Message-ID: <2025062004-sandblast-overjoyed-6fe9@gregkh>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619200537.260017-1-sean.anderson@linux.dev>

On Thu, Jun 19, 2025 at 04:05:33PM -0400, Sean Anderson wrote:
> Upon further investigation, the EPROBE_DEFER loop outlined in [1] can
> occur even without the PCS subsystem, as described in patch 4/4. The
> second patch is a general fix, and could be applied even without the
> auxdev conversion.
> 
> [1] https://lore.kernel.org/all/20250610183459.3395328-1-sean.anderson@linux.dev/

I have no idea what this summary means at all, which isn't a good start
to a patch series :(

What problem are you trying to solve?  What overall solution did you
come up with?  Who is supposed to be reviewing any of this?

totally confused,

greg k-h

