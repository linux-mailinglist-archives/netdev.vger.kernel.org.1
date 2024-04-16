Return-Path: <netdev+bounces-88481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF578A75FE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD91F22EF3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686F43147;
	Tue, 16 Apr 2024 20:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968C2375B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300931; cv=none; b=VM7OOubazdSvyu+uUG9hYvDM9N7C7zz3vWHywVNjnjJFloIhRDL7ohOJ2tIipvdXOHR21AbAo0uIiJQUMP7uSC5tOmE0orn4O3145nNZU5f1LkQkxk1JAqi8GqyQFv/MWTTtrrcx7z79j/yKDMt3qFn+hQO/Zejd3FJVHeRy5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300931; c=relaxed/simple;
	bh=wGwJzpcMh6WJgwflNIZwew7EYrOklHa755izNe2Rfw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZpphPRuwGz6lupgl5UjPNe1HN2t36QzBj4cVowQ5ea2Drthm5jRq6WieHzI4CdMT4SnXbLRg8dz3XLvHidzFk+03PZiA6c1/0PORq3e/hc8+Fm01NUfJrJtHqwJVucmmCo4z8mOMKv0+IhaRnMtMby941tnnra/O/sZ/McBAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CAC463000D5BB;
	Tue, 16 Apr 2024 22:55:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D1131E063; Tue, 16 Apr 2024 22:55:19 +0200 (CEST)
Date: Tue, 16 Apr 2024 22:55:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Roman Lozko <lozko.roma@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Message-ID: <Zh7lt_A6LvBro_ti@wunner.de>
References: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
 <87plupe70m.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plupe70m.fsf@kurt.kurt.home>

On Tue, Apr 16, 2024 at 04:06:49PM +0200, Kurt Kanzenbach wrote:
> On Mon Apr 15 2024, Lukas Wunner wrote:
> > Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> > Reported-by: Roman Lozko <lozko.roma@gmail.com>
> > Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> I think, the first SoB has to be yours, because you are the patch
> author. In fact, my SoB is not required at all.

My understanding is that the commit author must be identical to the last
Signed-off-by, so I put mine last.  I've seen Stephen Rothwell send
complaints whenever he spotted commits in linux-next violating that.

I carried over the variable and function renaming you did to match
the driver's (or your) preferred style, hence the inclusion of your
Signed-off-by.

Thanks!

Lukas

