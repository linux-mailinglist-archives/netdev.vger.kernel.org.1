Return-Path: <netdev+bounces-101080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA88FD30A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0459D2868BB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541CD153BF8;
	Wed,  5 Jun 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GcvxvlvC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A782575A;
	Wed,  5 Jun 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605607; cv=none; b=IvHbitorp6mFBaN67PnhHWxu/Zo8KvW1cpdWmsrtCkaaY21e5Qb2R6erk5/iBkX2GCLwqvt1U3J68mYF93oV98tnyrOsSrGuCVomc8wHdwQSR9hi1+D8WZQHsEbhT1SHMeoCw5oha7FhykUEv2r91eoDwq/bpJe2B/ofvUpuqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605607; c=relaxed/simple;
	bh=O4G8eQ2hC0FwwtinYnY34YnV+5ukJLCh4ZVgQJRREHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPrrkyI7PuRyrcJGDQgpYLKJscmnbYBAR7RI/oVUFJzLo7Niys5KlfFY7PIxj+bWsJWpyqFVF0rjolltrFZ6W37I17WRABIL+5QoiAIJ82WDVN9v2UHmPqkJSMsuCJ+QfomVJtST5gQDJrhGpCZ1RTyihU5go2Z9U+9Op597DLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GcvxvlvC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XEQ31M+AQ32LiINcV0Ik8aCt65Mcjm7BZkNioozKiB4=; b=GcvxvlvCAtyy1QN8zJ1O28vL6g
	2Cdiorp4ffRMSuHOuxNhjUkTyBVLCxsTZk5hi5nj/ktx+zpcV4eV8C23yRVRNTSf8h2XbfWbnx+cV
	BZsCBrSX+DAEerSFWVIFd6Wl9suCEVv/bW9amoI7CK2xr7m289kRq0YMm9JwNZ0trzIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEtg1-00Gvlt-JA; Wed, 05 Jun 2024 18:39:53 +0200
Date: Wed, 5 Jun 2024 18:39:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	grundler@chromium.org, dianders@chromium.org, hayeswang@realtek.com,
	hkallweit1@gmail.com
Subject: Re: [PATCH] r8152: Set NET_ADDR_STOLEN if using passthru MAC
Message-ID: <f5d30745-fab8-4a03-8d29-3ce32c63c370@lunn.ch>
References: <20240605153340.25694-1-gmazyland@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605153340.25694-1-gmazyland@gmail.com>

On Wed, Jun 05, 2024 at 05:33:40PM +0200, Milan Broz wrote:
> Some docks support MAC pass-through - MAC address
> is taken from another device.
> 
> Driver should indicate that with NET_ADDR_STOLEN flag.
> 
> This should help to avoid collisions if network interface
> names are generated with MAC policy.
> 
> Reported and discussed here
> https://github.com/systemd/systemd/issues/33104

MAC pass-through is broken, and expected to cause problems. We
strongly push back on any patches trying to add more instances of
it.

Ideally it needs to be done in user space where you have full access
to the tree of devices, can determine if the device getting the MAC
address really is in a dock, is the first dock in a chain of docks,
and not a USB dongle etc.

Using NET_ADDR_STOLEN is interesting. It is currently used in bonding,
when the bond device takes the MAC address from one of its slaves. It
is also used with VLAN interfaces, which inherit the MAC address of
the base interface. There is a clear relationship between the two
interfaces using the same MAC address. However in the pass through
case, the interfaces are unrelated.

However, the code says:

#define NET_ADDR_STOLEN		2	/* address is stolen from other device */

which is exactly what is happening here.

> Signed-off-by: Milan Broz <gmazyland@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

