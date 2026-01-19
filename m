Return-Path: <netdev+bounces-251321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E5D3BAC3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 535F73034FA8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4BE3033EF;
	Mon, 19 Jan 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVDDkFu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871D301493
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861211; cv=none; b=H0o4bAeLHDustE23kVQjPAwWkv8UobYurXMVtr/WE1KGkrr5j1sgodSr2XcAAt5mWZO8ArM3oC0QiZB2FtejhSszxEdRui0udrjFcf2mI3LLQ1pfd6wX/GmqHnwsWroCSkEbKkNBK0ArZaudYTx+3Axqf0I2HQyTjfXS1sxfzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861211; c=relaxed/simple;
	bh=fsdIm/oCjnyldCkQReisPaztgfV/TlJ8FGR/iOuL+3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHlRXUDY7LUXJJfT8zFNlSNfCBIUrtHQp6PnIngtp2on6uJ0PYCnZA3E8aD3P6a2NW1zK5Nv93nY5WYT5qMStftEsvdfEzx0J3DlH2FhSBBGiWT5nsWhO+YSYtxIhIwpYwoqCBAvTqyskmnedNNh0waZMw1h/LDBfQiLZdzUfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVDDkFu1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f38c7d4eso351028f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768861208; x=1769466008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeZlryM3U1QrMAzwU4eEOXt9CkUE2vp8KbvUXrxxH+I=;
        b=EVDDkFu1vy6YxJGFLChL/BvFoJGKy2duoju+Ik5b3SZErJRxx4oCEesLwC9y3cwnhj
         A0OSK0G3oqQ1KnpVx/iyr1xsaZl24GY9bfEg/674wQQ5+fCep0iWC9svfA6V9y5JtKAG
         isWyuGwZr9rMsjnx3IA4/28ntrV+UwjDwXnvvLgWKuHvaRHmMmtbZqkO0dgneXRY/Y0B
         SAyUpxXYE8iFAf8lpdJXT7r+JQNjeLoucVYd66BqhL3XljUtFNR4a+K8E3aaDZAWA/G7
         HFHo7MSCRinbb6GsIfP9CSo45ZCEpftr3uumzpFwumtQZYcYCet+EHFVVPqY3D2WZzNG
         C+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768861208; x=1769466008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeZlryM3U1QrMAzwU4eEOXt9CkUE2vp8KbvUXrxxH+I=;
        b=wqxMqIEIvmM2YgleoqlAA99utEaco8qm6niQ+IZDsk7txQsoKya9iKb6AZ+Punrf9Z
         +fjHrvkSaiERq/y4ySkcvxJCEhJMtG7OpaLzdzAhKa+0IaHzJrcpq4HMKxDPutYEM7s1
         ak1Kv241f4Xbn5GgSnkEU6GR1SUYvMKX5oTzgiPvGTN8Pw8hbiEXVeEWnLkfB7L14Wg3
         jGDg4SIHPV2izDN0zdN5YIgtcDzFDLuCL3BOx6iIYAm/ucYWC/gNmrKkJkRBYkfmvx3O
         bQ+Wid2nLF97E6ytRxJ9KSk2G8W3fY97xiOLiYXYz3MbQUXVO4QXtJy+trFv4DtuWnwy
         HM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8XEWycerzUXSEFMXPNJmwfhfNyas3ZmgcB2YUupEs/FqbcmXnBAwYoQDqM7BXMheSrq+KC70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgoF/nE3plFUFhm0/lGLn0WaEaY6Vu9lmDHKNM+IqpHTpuPxx
	amzG00dI+h5bjOFs93xfms3RA58essq+TrkG6KGB3UHUkhS+RtEV6g2T
X-Gm-Gg: AZuq6aIPZFXbMHgBfzsseE3ZWhO6Ft8tQybcnrph7b38owwhi8jsZmZ2iNZFvlhL3KQ
	6yK4vAYK3+Eo0v+T0UmIOVqChCeC3OAorxwOVRCm2uNTqOCZEaj+cZwCN6xltHsBkB3Wp7Y57yP
	RcUFZAXh6mMY57TF4lNpCwVA50c+npA0Jx1DyHOc2nu5w/dWvK/ajxJD/oHX1rJybZFla/K2pvJ
	kHmCJ4vXjwDYZ1Tv/Q/i9n0JN4Lk0oGndqb7zG2Rp0NCGoFyMEeidO6JFQXEapR1GKxM0WJpp4C
	mh7gBlWrv1l53YGtDw6cQHOkP6xeGIWQ7JKfZQme4xtf2+IsEdWgJzBihH92L40JPxOAc4ZNjfc
	pqFjNIrLeF3EoDoAvPMROxavor3yP7itCR5YbuYIurM3ei494m0wyV94DjicgMRkJFfcWCwx+b8
	ehrLI=
X-Received: by 2002:a05:6000:2483:b0:431:38f:8bbb with SMTP id ffacd0b85a97d-43569bd3147mr10304650f8f.6.1768861208491;
        Mon, 19 Jan 2026 14:20:08 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm26538256f8f.42.2026.01.19.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:20:07 -0800 (PST)
Date: Tue, 20 Jan 2026 00:20:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: ks8995: Add stub bridge
 join/leave
Message-ID: <20260119222004.o62uvpobnmffus2r@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-3-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-ks8995-fixups-v2-3-98bd034a0d12@kernel.org>

On Mon, Jan 19, 2026 at 03:30:07PM +0100, Linus Walleij wrote:
> Implementing ks8995_port_pre_bridge_flags() and
> ks8995_port_bridge_flags() without port_bridge_join()
> is a no-op.
> 
> This adds stubs for bridge join/leave callbacks following
> the pattern of drivers/net/dsa/microchip/ksz_common.c:
> as we have STP callbacks and these will be called right
> after bridge join/leave these will take care of the
> job of setting up the learning which is all we support.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/ks8995.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> index 5ad62fa4e52c..060bc8303a14 100644
> --- a/drivers/net/dsa/ks8995.c
> +++ b/drivers/net/dsa/ks8995.c
> @@ -461,6 +461,26 @@ static void ks8995_port_disable(struct dsa_switch *ds, int port)
>  	dev_dbg(ks->dev, "disable port %d\n", port);
>  }
>  
> +static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
> +				   struct dsa_bridge bridge,
> +				   bool *tx_fwd_offload,
> +				   struct netlink_ext_ack *extack)
> +{
> +	/* port_stp_state_set() will be called after to put the port in
> +	 * appropriate state so there is no need to do anything.
> +	 */

Not directly related, but reviewing ks8995_port_stp_state_set() I
noticed another issue: the driver implementation of the
BR_STATE_LEARNING and BR_STATE_FORWARDING states should take into
consideration a previous call to ks8995_port_bridge_flags() which has
disabled BR_LEARNING for the port.

Look at ksz_port_stp_state_set() to compare how it first tests for
p->learning before touching PORT_LEARN_DISABLE.

This becomes a problem with this patch, because this patch brings
ks8995_port_bridge_flags() to life and makes user space able to turn off
address learning for the port. So it is relevant, and it would be good
to fix it before enabling the feature.

And yet one more potential issue: standalone user ports should have
address learning disabled. At driver probe time it is the driver's
responsibility to ensure that this is the case. After the port joins a
bridge and leaves it afterwards, the setting changes are driven by DSA.
I don't know what the default setting is in your case.

> +
> +	return 0;
> +}
> +
> +static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge)
> +{
> +	/* port_stp_state_set() will be called after to put the port in
> +	 * forwarding state so there is no need to do anything.
> +	 */
> +}
> +
>  static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  					struct switchdev_brport_flags flags,
>  					struct netlink_ext_ack *extack)
> @@ -635,6 +655,8 @@ static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
>  static const struct dsa_switch_ops ks8995_ds_ops = {
>  	.get_tag_protocol = ks8995_get_tag_protocol,
>  	.setup = ks8995_setup,
> +	.port_bridge_join = ks8995_port_bridge_join,
> +	.port_bridge_leave = ks8995_port_bridge_leave,
>  	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
>  	.port_bridge_flags = ks8995_port_bridge_flags,
>  	.port_enable = ks8995_port_enable,
> 
> -- 
> 2.52.0
> 

