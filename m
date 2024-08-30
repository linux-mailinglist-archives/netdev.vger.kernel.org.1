Return-Path: <netdev+bounces-123720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53696966457
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868D81C239D9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685671B250E;
	Fri, 30 Aug 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="evV2d7YE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F818EFEE;
	Fri, 30 Aug 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029076; cv=none; b=S0ug2LVri8djxlITfqCRBVVsB2veSNCxEE6y+h/67dnY/C1qKeJaIL+hAwY9cGiz+siI2Hkexe8pepDojbchn48h+7Vc6mblVDhfJHVc7OuRPdUdxkVBliCjnL/HbFUnKZDLZMHJ+RqLJ+mFIu6e0QcRprcx8Hn+w3q98NudwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029076; c=relaxed/simple;
	bh=7wl+thORjF0Y6L/S5sUZHW4ylajdJ6ZapD69iZrkeW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn8ER/mEtFjmhXMtQlrHeOR2iWAT1Nwzvsgz5/4EPgfnUttDSSSH9LZsnLgFkbNXSsbbzjyL6/kc4P4puQuC1TRwIK66lU1+WT/QZLGOwOFB2RJQmBUcL5KzeMDDe0DEoABjAluGYE+GlRQVmINwCZUINg5dnnEclBRZaJXu888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=evV2d7YE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ePSsImcwiAxPSpaJDzzqvu+iUKhBBnuFAM2nw1vKYU0=; b=evV2d7YEmY6ow5HVDRfRiY+dyk
	/wM0Fk9DZsJt6E/acwgqDJxxDhX0avJ0nxqy9OWVN2ozYoBQwc3O6yHl6UCsYr/VXgnLEsZRZSnXK
	EGo0t/GaZ4BhIx6yW/DCZsK2ea0HH3a/t2vFi0RhzafVm6xjg6cCC9uspVsjkiEKWULY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2rO-0068Wl-IE; Fri, 30 Aug 2024 16:44:22 +0200
Date: Fri, 30 Aug 2024 16:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v2 RESEND] net: dsa: Simplify with scoped for
 each OF child loop
Message-ID: <a7a985b4-d22f-4918-a837-893c4e7efe05@lunn.ch>
References: <20240830070037.3529832-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830070037.3529832-1-ruanjinjie@huawei.com>

On Fri, Aug 30, 2024 at 03:00:37PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v1 -> v2 RESNED:
> - Remove the goto.
> - next -> net-next
> ---
>  net/dsa/dsa.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 668c729946ea..24f566838621 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1264,9 +1264,8 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
>  				     struct device_node *dn)
>  {
> -	struct device_node *ports, *port;
> +	struct device_node *ports;
>  	struct dsa_port *dp;
> -	int err = 0;

Why?


Patches should be small, simple, obviously correct. This change makes
the patch more complex, harder to review, and less obviously correct.

All these patches have questionable value. Most probably don't fix
anything which is broken. They are using up a lot of
Reviewer/Maintainer time. Don't make it worse by making unneeded
changes.

    Andrew

---
pw-bot: cr

