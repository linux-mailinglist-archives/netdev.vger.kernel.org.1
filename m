Return-Path: <netdev+bounces-199829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11861AE1FB0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73A1710A6
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3E2DF3D1;
	Fri, 20 Jun 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/gMlsrq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215922BF3F4;
	Fri, 20 Jun 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435333; cv=none; b=fOxLR4wpJkSzBWtm9R9xfx94k49VAxTMl1svydc5Q+KrCGn6V6rbU6epxrZZZ0fcwpzYOkLmYaX06q65oqe81tezbILsbCsUG/mQoHwui8Ikxw6k0MJkukEZk6eCvgUHMBsUN1oWTDW7RGCGkgsC+JhX9UqUjKAdk7Q+P/5waVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435333; c=relaxed/simple;
	bh=hwOS66AkNq303wqYtSJkQ76RAWd8KoMvwvGYKnWmxfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2VLocjWSwdGpqmBAkmlktFKedp4jT8+8fQu0oEYfnEIiPCRAPugNOEgZrCb0Q+MomBn1i9U5SaNx5WoTm22eRuTEGs41//+qajuNBNofepr3+M3dqmUb1iM9nq8kcgwdT5TaVGL3mgWRtr/45mrzgbBivnG62qSjR0TRV3gFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/gMlsrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B9AC4CEE3;
	Fri, 20 Jun 2025 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750435332;
	bh=hwOS66AkNq303wqYtSJkQ76RAWd8KoMvwvGYKnWmxfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/gMlsrqDHi7gZtcvoKK+cRorj30vVE/vQq9jaF87QRDGCIrc7NhyK2UNr0OWmNZE
	 AwPVfT89QpXW0fJC7d6g1VmB37aXCXlrhhVVtLbGhdFRRn6YNvPT9WiS0/SJ+T44QG
	 4nEZuRXSVt///a+m3Um5rQxFV/+Hh0kPb/dz0/u0=
Date: Fri, 20 Jun 2025 18:02:10 +0200
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
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
Message-ID: <2025062006-detergent-spruce-5ae2@gregkh>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
 <2025062004-essay-pecan-d5be@gregkh>
 <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>

On Fri, Jun 20, 2025 at 11:37:40AM -0400, Sean Anderson wrote:
> On 6/20/25 01:13, Greg Kroah-Hartman wrote:
> > On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
> >> Support creating auxiliary devices with the id included as part of the
> >> name. This allows for non-decimal ids, which may be more appropriate for
> >> auxiliary devices created as children of memory-mapped devices. For
> >> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
> >> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.
> > 
> > I don't see the justification for this, sorry.  An id is just an id, it
> > doesn't matter what is is and nothing should be relying on it to be the
> > same across reboots or anywhere else.  The only requirement is that it
> > be unique at this point in time in the system.
> 
> It identifies the device in log messages. Without this you have to read
> sysfs to determine what device is (for example) producing an error.

That's fine, read sysfs :)

> This
> may be inconvenient to do if the error prevents the system from booting.
> This series converts a platform device with a legible ID like
> "802c0000.ethernet" to an auxiliary device, and I believe descriptive
> device names produce a better developer experience.

You can still have 802c0000.ethernet be the prefix of the name, that's
fine.

> This is also shorter and simpler than auto-generated IDs.

Please stick with auto-generated ids, they will work properly here.

thanks,

greg k-h

