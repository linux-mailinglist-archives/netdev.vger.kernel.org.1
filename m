Return-Path: <netdev+bounces-152541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1E9F48AB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97675188B776
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F41DDC3F;
	Tue, 17 Dec 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1AYVIgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615414600F;
	Tue, 17 Dec 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430546; cv=none; b=SjwDmnVNy8ycFfI5tJBMWWO6b2B+/IEVCh59Gx1CigL61qdNT9hSpXOx4iKYafK/t229IucMObUVDdSAt/mJ8f+CNnZpcEYNaiP0nlOSBRB3nvcEtqfvIvf/i3N029CmN7BgMX8mxvFsw3y48ZvA7mJiC7qF/lAZXIKvTMIsBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430546; c=relaxed/simple;
	bh=jZX8lUKc/UgfB+9dJEtSbzk13WgwgDyifsp35CTq4F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goHUZyvtS72Oc+0o0RowYbU38LymhsAtRv4WvWRYfXZdj9oTxuMMv946/i2ImN1rdsKHKxFNCZmJ+Nkre6Sj9egxPcXDkXa3saWww9uXQxZEXvUODO7RzI9LMInmcowGWtMyf34/uPS5w+sSstZuryK2OQTY6gz6F/UDva+gy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1AYVIgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C29C4CED3;
	Tue, 17 Dec 2024 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734430546;
	bh=jZX8lUKc/UgfB+9dJEtSbzk13WgwgDyifsp35CTq4F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1AYVIgj8jrQSkMS5JKeDTtKvtWOFUUGUeO/mdLp1YB1wS62odT1SC+TRTJJeHJbw
	 FMJ+vHxeDrx/TJ0pHgGR9tCkVjArSCB4zdq7gnhGJv4tlCRQkZKVtXctHtQyFdo7XV
	 7H8amWouNq3poCeZud1n+fipQus3A2BEogYsAmepkVCfUcxYthcqTEeV1ZgwuL2x/y
	 0OLfh6RW+Cra3dmjvetjDyBtSMfh4tUoCaf4hGirBE/RR6zm3uhjgCjOA54y4H4jgO
	 LqAh4N3WYVlGscsDwPWqiqA89yLABfO0mFwCVmJm4esfoo0C6SNH+uDWWUWmUh0boW
	 Spx1OJKdARcwA==
Date: Tue, 17 Dec 2024 10:15:41 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Robert Hodaszi <robert.hodaszi@digi.com>, netdev@vger.kernel.org,
	claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
Message-ID: <20241217101541.GK780307@kernel.org>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
 <20241215170921.5qlundy4jzutvze7@skbuf>
 <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
 <20241216135159.jetvdglhtl6mfk2r@skbuf>
 <49d10bde-6257-4cc0-abaf-3bffb3a812c0@digi.com>
 <20241216144831.yh6w7mtyaywypq7d@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216144831.yh6w7mtyaywypq7d@skbuf>

On Mon, Dec 16, 2024 at 04:48:31PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 16, 2024 at 03:39:17PM +0100, Robert Hodaszi wrote:
> > Actually, what you did is exactly what I did first to fix the issue, but it broke my setup when I sent VLAN-tagged messages to the device. Now I tested again, and it is working fine. That made me think it's happening because it is stripping incorrectly the VLAN tag. Probably it was just an incorrect setup, maybe something remained set either on my PC or on the unit from the previous test.
> > 
> > One thing is different to my change though: you're calling the br_vlan_get_proto() twice. You can tweak performance a bit probably, if you rather pass 'proto' to both dsa_software_untag_vlan_aware_bridge and dsa_software_untag_vlan_unaware_bridge instead. So something like this:
> 
> The patch is going to become stuffy, but ok. We also have to update the
> kernel-doc of the 2 untagging functions to document the new argument.
> I will send a v2 tomorrow after the expiry of the 24 hour timeout for
> other review comments.

Hi Vladimir,

As you are touching both Kernel doc and dsa_software_vlan_untag,
could you consider also adding a "Returns: " section to the Kernel doc
of that function?

