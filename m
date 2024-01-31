Return-Path: <netdev+bounces-67596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A1F844353
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847621F23D6C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00181292F7;
	Wed, 31 Jan 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZWs3Qgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1901272C2
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716054; cv=none; b=C8upsLRC/pPfk6CCqqqRq4CseILWDYvHxtOc3yChRAw2mo8BYhZyLG0VMWGYhVTPBA1HlM9WEzHxrplfLtvhygT3Qakz87k45+zb3JmTP7E/YeiASeU2c5DZgsJCF9Z32MJAgicoyMycLF6KzTgS8fC1a0+PGJZwdpb5iK4ZH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716054; c=relaxed/simple;
	bh=EXcXyeANmJmgvfw8azKOBTTXAU2Cs2bPyOWuEk85O1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiM+Y3CA1dVwacgZTZ87Ao9HMuFe5w2mNIi8n1jh+VO7saaTTiKTltZC7dvUsMsTIQ84uWijGMKGtWCFjEOa1MLp7TibUk1oHTA9MCE1StI6rrK78uw/8CdW1oaGEKWHOTeVpeDTAvgSsvwCXy7ZA9ZwEyNQx6otgMvy4GZFkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZWs3Qgf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so57793835e9.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716051; x=1707320851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6bRnIXwTFaf6OBoNqtFX0s+pTAlpakYMHMrYTjwpQ=;
        b=bZWs3QgfL4qb4fs/WvjUhR6QEZt9aixyF/8x4wCRlm/zgj4Cw6Uk1YI8NOYTsUcdN9
         LnaLb7UPOb2cEUrZ4pggRL7be6aCsi51qWoX/yU6zGi3KKPMr0267L+v3stgKq/ciN4K
         J9SYpR23Uo1fAe6bJPoU4OyL/ch1U8DxvAjHLkd1OTG4vfrGcYVX9Hh9xcSrNMhwnyCx
         SSUNFEVvKrtUPXkChxXho02dwP7LnfDJc9zmvRZmtGUK+nsnqc42Ll4y4Jd3CAXOY/bh
         7yVuV0ElsEq+028WJruw0FAvLKuLzVTnsXHwdQrsG4OtoTD545hwHou5ywvhboKE1MiT
         whdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716051; x=1707320851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R6bRnIXwTFaf6OBoNqtFX0s+pTAlpakYMHMrYTjwpQ=;
        b=Odf4k72k8ag6HGXBzxWbRGfYBy8lcbk/P/DjULgfS5UUOG7PW+IKwfRVWdKqX8GOrV
         2OsOoiNwVqTm8OJkMgT8wMkGC6AWBE6NtfRIt2a2hCeBO6HO6Um7Eh34BtudABJq9NgX
         b+0eEonp0w9e4Pko0P1zfGGFTOoMgjA5hgwuwOIgqdAQZn8TekaK3qdqBt7rE6KEIo9w
         T7Qia5+GyaIjt21oWELCjdnsGzA3xF7BPtHuYfuKLy3lU854xqwkzYW0h9ITFHlHtTwY
         cdkJPvQ9pz+Li6qtu92Uoyp4TNUOdipR2L7A3ZNKCgA9Bt3hRaQ7eJPOdUhB3qFwpx1Z
         8UDg==
X-Gm-Message-State: AOJu0YxBodELnZ+FmyKd+cFVjmzqp4r7LO8ETz7bcTYgrklhDkYtSXmJ
	rdyVhbRVZxM/nfBwtP/kTTjWLDMQG0Lkhq7gsT6/to4iLk2h9j3w
X-Google-Smtp-Source: AGHT+IHUI491lPMA6eaODzik0Gih2zVI4wOgoLFn4I/Ko6V5bjkYg2ZGvY99YHvrpc0RtNmUiLIKbQ==
X-Received: by 2002:a05:6000:1006:b0:33a:eedd:c892 with SMTP id a6-20020a056000100600b0033aeeddc892mr1386447wrx.66.1706716050842;
        Wed, 31 Jan 2024 07:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGulGP+rCmZq4e8Ik5k4f4HqC9/tJk7P0cV3z7xY08fvjBZRkr+dFiJDMWAjNDT/vO0XQm6HEkZ1dkSOEhkYnERqYrHGUs5gFuTHJmFdkh/uhkrV6PcFJg4DDPsFbX5HfTBDwbCstoEK6LFXdWC8J9u3rEHT4whfjF9VsZLb7RQgwExI3paSF609LzvOUEbGUWwqm18Po85OCsTe1ec7uYjYD1w+ByvGfdpCZK2UIGH8sjG+XC7rcuzlH4Y2dYkLExH3GPQS9ZgdWxmujQOC/PROtZU8hbih0Zgdp9Ysh70C9tfCwB3BGzPu+3SwDL/wa6N1l8BHo9oFuapgSylj5xfK7MxqBtd/Tc2Hk0qybR7YPrbYkftNCrCFx+WSZjKx5j78s3Ki0Tnybl
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056000080300b0033ae6fa7f20sm10906120wrb.65.2024.01.31.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:47:30 -0800 (PST)
Date: Wed, 31 Jan 2024 17:47:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next 02/17] net: switchdev: Add a helper to replay
 objects on a bridge port
Message-ID: <20240131154728.fnw6pnib6l7x3vzq@skbuf>
References: <cover.1689763088.git.petrm@nvidia.com>
 <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>

Hi Petr,

On Wed, Jul 19, 2023 at 01:01:17PM +0200, Petr Machata wrote:
> When a front panel joins a bridge via another netdevice (typically a LAG),
> the driver needs to learn about the objects configured on the bridge port.
> When the bridge port is offloaded by the driver for the first time, this
> can be achieved by passing a notifier to switchdev_bridge_port_offload().
> The notifier is then invoked for the individual objects (such as VLANs)
> configured on the bridge, and can look for the interesting ones.
> 
> Calling switchdev_bridge_port_offload() when the second port joins the
> bridge lower is unnecessary, but the replay is still needed. To that end,
> add a new function, switchdev_bridge_port_replay(), which does only the
> replay part of the _offload() function in exactly the same way as that
> function.
> 
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Ivan Vecera <ivecera@redhat.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: bridge@lists.linux-foundation.org
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Danielle Ratson <danieller@nvidia.com>
> ---

I just noticed this commit in the kernel, and the commit message did not
really convince me.

As unnecessary as the second switchdev_bridge_port_offload() call may be,
it does not hurt either, because it just bumps p->offload_count in the bridge.
And with just this justification, adding a new function to the switchdev API
is equally unnecessary.

Even worse, switchdev_bridge_port_replay() is a partial misnomer, and
will become a complete misnomer soon. Out of 3 object classes (FDB, MDB
and VLAN), FDB and VLAN are not actually replayed just for the given
bridge port given as argument, but for all ports of the bridge. And Tobias
wants to change things so that the same will happen for MDB too.
https://lore.kernel.org/netdev/87bk927bxl.fsf@waldekranz.com/

Can mlxsw not use the same replay code path as DSA, through the _offload()
and _unoffload() entry points?

