Return-Path: <netdev+bounces-200413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF8AE51E1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545DF4A2CDA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0909221DA8;
	Mon, 23 Jun 2025 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCbVG8nG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D634409
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714689; cv=none; b=GabDIr5PwyuO5/sJ3xo2aKHoaFXytMs4fCle+JKv6dCULUYGp5mK/kRm5OjkeLKtT0X7+THAdWuHIoid5DZ82oChlsUt9H/wn96zkymGGmJ7eUrxuzXLAWu/IttQIMZwuSDnPBHgERfgV/e9N8mo3ANd6JNLFX05ZLkfjFg0RbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714689; c=relaxed/simple;
	bh=k/5E2TadVHkorJUCOeEe5uruf77ziZMMNq6c2udSYTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLKkxwVZ9Z3KpUHPiwdEh7k6xJyDC6qfZlkKWomSsFxIoj1YVh722lNJip1bbtPCHxgzWznP8vLCwjaxXY8B2TLsp4EMk14FcLQTyYpWj2jkuW50yYp6nQV6gsyf0Elc1wNx07NOa0emLr2RNfYsCskSUDaMK+r8bAUsKHPgEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCbVG8nG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2495071b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714688; x=1751319488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDP4P5E0brABsTn41Fi4MJa0wJUTwo4SoNbQrmaWoMQ=;
        b=UCbVG8nGJpT1ProcZw0Tv8LSYNMVpOLzG0KdNIOQl75Xmva3ReGvlNqsa1sighodXN
         hXMmFyNIKknuYyajA8vgV5uFAof+qU6/Wbq5kKElTYgulNeV/TYwtxedM50+tzNgOTSr
         5VfGUHqtGaIMv1S57C+KkoNC93MVLc4FQaaBKs/+VOZhxlSYzXfuHiBBjE4PMNqLsM9e
         nY6mbo1q9A4q6pwuefpBm1W7lT8PQMmM4i30lQggsKWsHggYAXXBKgywPFenWQkQbyAY
         KSYAVvwT+ka2iLVMFF6Kq+aaRz6ODVVLXNNOaC/873VkjG2oZkDclLcS8qsRInXoShF8
         pVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714688; x=1751319488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDP4P5E0brABsTn41Fi4MJa0wJUTwo4SoNbQrmaWoMQ=;
        b=ec8WF5lvDuck1jR7ULBrATCbhqXoPj+EQmTPx9aJb+uBhZV/tGj1gfjiVZmQQdxYcf
         jUHU6chns+/Ow50AmBM9rPo7rpGYlB7CrsmIrmnQcbn0jArz5u9qZ3cw+yTfjkf/rnyP
         UDS60/Ib6Kq1uwRsUlo4YTvLJlH6JEbfZinGbaAM213BZ0TLLW+OTuHENdB0Uf2E3KRT
         qRQQo+GrLNy6sUsoIxkHHbLew0XYB6BLMNeDnBTy3Pse90Uqo+Hp7PSfAofT6lSwVNOL
         SR/mKt1wIAbRYYAnyJUWaiENHPZFjxf5ONof1KheOF6gvP+dnyUNJmGhwP2UByHCJJ2H
         3wUA==
X-Forwarded-Encrypted: i=1; AJvYcCVwfxZKeu7LxtXYSpCw5bpspHW7Fgirw0yDrkbRA6z8avKWhYRf7A90rf0/W6nQoHIjxKgZMQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntISMXFQBDCuFXl+St+s0OwCPBs1y9gJ40KxOSQB3DmGLZFZm
	xyHH0LrrSooZs2PjGw9e7gugY9jmL+gP63DunIlPBNSedmcYuu/5x54=
X-Gm-Gg: ASbGncuH6PvxvvoI+wG2RzPZZT2LHjIdKwJ6qCPUIRPJWiyEdF7PpVhGbDzbvT2Tnc+
	jaeROMlz5jOoF/ESrDVPKnOF1PVijSS9wxkrmXSeDnGkEMr3H7be9SpL768Ci9/98vCD+OgSw2k
	WQ1yDZPZvEIrYa71ozLtfr+XHgdN7xtfrjuyBKzNc01TZAhMcjRQ4GDWS42hXu45c8RpquB/TjU
	WqStHky4FqyQYujKwyJtg0hXGU0NPVLhqKtyzs1R/wEORWzK8NcGweeeO8uLZDZTr/qIcdW+4nc
	r1qTOxj7UiZM5ZkHxJ3wVoKb9Zy1vmBOVraDLxvb6O3lH4ZxlAdI8M3sMA4khccTY074RHxViR0
	8R/0Uc5av7gjQY0qDv1PSQbM=
X-Google-Smtp-Source: AGHT+IHXdO06MyIEp5IaVdE2p6AE5zZeOJqizNkTusKIV32MKpKATKJiIQJTrCoocffnIV4gtQt5qQ==
X-Received: by 2002:a05:6a21:493:b0:215:e43a:29b9 with SMTP id adf61e73a8af0-22026e727aamr17897071637.33.1750714687573;
        Mon, 23 Jun 2025 14:38:07 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-749c8873126sm95838b3a.172.2025.06.23.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:38:07 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:38:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 0/8] net: maintain netif vs dev prefix semantics
Message-ID: <aFnJPlyq-hAJTaoo@mini-arch>
References: <20250623150814.3149231-1-sdf@fomichev.me>
 <6859bbade00da_101e05294a7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6859bbade00da_101e05294a7@willemb.c.googlers.com.notmuch>

On 06/23, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > Commit cc34acd577f1 ("docs: net: document new locking reality")
> > introduced netif_ vs dev_ function semantics: the former expects locked
> > netdev, the latter takes care of the locking. We don't strictly
> > follow this semantics on either side, but there are more dev_xxx handlers
> > now that don't fit. Rename them to netif_xxx where appropriate. We care only
> > about driver-visible APIs, don't touch stack-internal routines.
> > 
> > This is part 1, I'm considering following up with these (haven't looked
> > deep, maybe the ones that are frequently used are fine to keep):
> > 
> >   * dev_get_tstats64 dev_fetch_sw_netstats
> >   * dev_xdp_prog_count,
> >   * dev_add_pack dev_remove_pack dev_remove_pack
> >   * dev_get_iflink
> >   * dev_fill_forward_path
> >   * dev_getbyhwaddr_rcu dev_getbyhwaddr dev_getfirstbyhwtype
> >   * dev_valid_name dev_valid_name
> >   * dev_forward dev_forward_skb
> >   * dev_queue_xmit_nit dev_nit_active_rcu
> >   * dev_pick_tx_zero
> > 
> > Sending this out to get a sense of direction :-)
> > 
> > Stanislav Fomichev (8):
> >   net: s/dev_get_stats/netif_get_stats/
> >   net: s/dev_get_port_parent_id/netif_get_port_parent_id/
> >   net: s/dev_get_mac_address/netif_get_mac_address/
> >   net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
> >   net: s/__dev_set_mtu/__netif_set_mtu/
> >   net: s/dev_get_flags/netif_get_flags/
> >   net: s/dev_set_threaded/netif_set_threaded/
> >   net: s/dev_close_many/netif_close_many/
> 
> Maybe also an opportunity to move the modified EXPORT_SYMBOL_GPL
> into the NETDEV_INTERNAL namespace?
> 
> Context in commit 0b7bdc7fab57 ("netdev: define NETDEV_INTERNAL")

Good idea, will go over the ones that I'm renaming to see if anything
can be reclassified as the internal, thanks!

