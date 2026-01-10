Return-Path: <netdev+bounces-248709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A5BD0D8B2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08505300FFB5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A6347BBF;
	Sat, 10 Jan 2026 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nyVEFLX3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2C223322;
	Sat, 10 Jan 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768059537; cv=none; b=KrQZA5+r5xGySSFzPPWtKjZsYeKZ2iw927GVBPH115Ly7omiZ6AYojYbtgrUkdw8CqWelWW0LQVp/kKEeAqiQHNKsEXJB8et6aOzUHggDQnmUmQ5nAqcIEhNhPu2jiGVC6Y5z4XjJaB19t7kORQvK05SUHehEUG9+Egw3mVJ8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768059537; c=relaxed/simple;
	bh=cXe0qNe2/VD71BfyBKCtpFLt0YqV36TO02t7+UvGqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgTopf2IULqT52YTDnKQ91mTLObfUGZNJA/ol4GXeOWIUZfr+shnXb9xstq+O+cxhHdTwgP+CSd1Y29lswXrdbkHGbj+/85yuoascfUchGpZUdeETb9dswdOb9MZz+Y4C/kDKskerBuactLS0X/CRiKBjJmAI5wb3PwbibccK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nyVEFLX3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oID0wUZHDRCqvv2/HgkTSYGaf3n/ZUFhMZikyKllnAg=; b=nyVEFLX3oZVGGacE9ptyVBiyuk
	1tM7GfI+3ciD1i9j3bzLSnGAtBr4iFT2Lp10TfqTO6fCqYAdb5GqxnF5/QtReKeGgdurjCAkGzQG2
	mm0vHCY4Rhwn45/iN0OSPex8IRrFhQLAyd6naU/pBPAY0rqatU1FcXF/1zr20EbYOTqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veb31-002Dk2-BX; Sat, 10 Jan 2026 16:38:39 +0100
Date: Sat, 10 Jan 2026 16:38:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Palmer <daniel@thingy.jp>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jacky_chou@aspeedtech.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ftgmac100: reduce calls to of_device_is_compatible()
Message-ID: <36cebaf0-2d1e-41bb-aaf3-b57fc45cae18@lunn.ch>
References: <20260110022827.2067386-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110022827.2067386-1-daniel@thingy.jp>

On Sat, Jan 10, 2026 at 11:28:27AM +0900, Daniel Palmer wrote:
> ftgmac100_probe() calls of_device_is_compatible() with the same arguments
> multiple times.

Please take a look at https://www.spinics.net/lists/netdev/msg1145959.html

    Andrew

---
pw-bot: cr

