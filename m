Return-Path: <netdev+bounces-164534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C8A2E1D1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E427A1F88
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF28F5A;
	Mon, 10 Feb 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hjl7By1F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A625;
	Mon, 10 Feb 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739148677; cv=none; b=jJoBEuJdGSoQd6IASVBAHZnBtjdtrUIUFKFATIVxUSSm/E/U2CMuJa6QtKiIjdjaLt4hAsdHp9rpl7OnLOcNVFLtNtBZG7M6VDlxq0jrNIPe+f7vhPWLj73ymRT8IatjmYMZiSSS16fceFhXvvcDSI/8XwZ9e0J+VYP8GZQTZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739148677; c=relaxed/simple;
	bh=eILT270pvzM4jbaoRVw8P48MfKj9xoblUNo+EKdFO4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaTjl2zQlshfYdj1ampyVnh8pdQvz0QHQC/9RiZl9nLWiJQYq/ivUFI8KKWH4OD6fkptmPpUVztQO+wUjx/7cm5UqKiUpHDN3ptSto/93a5rkqU0yXz+NxzIhLZmzdz2tN9XoD23SIoA5+ikQkceMKWQh3wItUhvio402UkeJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hjl7By1F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j3vRWvQMHc2s5jInJ/8urSWjoQn/Wzx4Io0rlEJSewI=; b=Hjl7By1Fnq9MbbLFKL36kQtdJz
	7D6cWnvbe1LuUEWpMTj3YBKFcbT2VEPStma3wE0IDo1guoesF3dgcHziPzfZCIee5+V0wgPb8KVcG
	gW+QVOxpEEaYGmdFcKWPj+kqr31dM90wVGeoDn6uxpky0AV20ma7mopFtz3IxD/UNl5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thI0v-00CYTC-N9; Mon, 10 Feb 2025 01:51:05 +0100
Date: Mon, 10 Feb 2025 01:51:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John J Coleman <jjcolemanx86@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Decotigny <decot@googlers.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: check device is present when getting ioctl
 settings
Message-ID: <db722f47-0b61-4905-a4a8-c0770fbf8945@lunn.ch>
References: <20250210003200.368428-1-jjcolemanx86@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210003200.368428-1-jjcolemanx86@gmail.com>

On Sun, Feb 09, 2025 at 05:31:56PM -0700, John J Coleman wrote:
> An ioctl caller of SIOCETHTOOL ETHTOOL_GSET can provoke the legacy
> ethtool codepath on a non-present device, leading to kernel panic:
> 
>      [exception RIP: qed_get_current_link+0x11]
>   #8 [ffffa2021d70f948] qede_get_link_ksettings at ffffffffc07bfa9a [qede]
>   #9 [ffffa2021d70f9d0] __rh_call_get_link_ksettings at ffffffff9bad2723
>  #10 [ffffa2021d70fa30] ethtool_get_settings at ffffffff9bad29d0
>  #11 [ffffa2021d70fb18] __dev_ethtool at ffffffff9bad442b
>  #12 [ffffa2021d70fc28] dev_ethtool at ffffffff9bad6db8
>  #13 [ffffa2021d70fc60] dev_ioctl at ffffffff9ba7a55c
>  #14 [ffffa2021d70fc98] sock_do_ioctl at ffffffff9ba22a44
>  #15 [ffffa2021d70fd08] sock_ioctl at ffffffff9ba22d1c
>  #16 [ffffa2021d70fd78] do_vfs_ioctl at ffffffff9b584cf4
> 
> Device is not present with no state bits set:
> 
> crash> net_device.state ffff8fff95240000
>   state = 0x0,
> 
> Existing patch commit a699781c79ec ("ethtool: check device is present
> when getting link settings") fixes this in the modern sysfs reader's
> ksettings path.
> 
> Fix this in the legacy ioctl path by checking for device presence as
> well.

What is not clear to my is why ethtool_get_settings() is special. Why
does ethtool_set_settings() not suffer from the same problem, or any
of the other ioctls?

	Andrew

