Return-Path: <netdev+bounces-86222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF889E0D0
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67D41C22780
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4014D2AB;
	Tue,  9 Apr 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCyJh3Cf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22113A267
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681556; cv=none; b=kG6HJ/LsKOx1h/huMKY6+pGLmj6NNzP7egKPGUzfBcYrLza7AvAa7n/kPFwXv0teLW+3NTgV6+J+3MgR8uFENf5sDiHcX4MZtwYpjGYMBrjUdFXDgw1qFO+YaSJVw4fpxz6k0uoLRZw6ux/qWt5xbv+bnq6GrJqjvotJNx3RrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681556; c=relaxed/simple;
	bh=PQU+JhWeo04G7Bjdqb10OIJaBKHQn3tfed0b9wf/7Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3up2g8isX8TMStzeYcAhCGeNKdfGEulTyFnKh9YkwFVL+bJPWzuSOvBfUh+Hk7UHYC2tbud0BopJ9M+aJwEKmiT1Yy8vxkGvpPXFkqtxtVVox3Lgecyygf37kfzN5JdHaJFCDvteKjaasl1EnCDTolKDt1QHXPBMGwRlb/bEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCyJh3Cf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-416c1d65038so734435e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712681553; x=1713286353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cug2zylk/leTsnzlIu+NCzRbE829VJUHZn6+nNMC/AM=;
        b=BCyJh3CfXUC9qACcfmloSUOxiYD6Dypafj3yaxZciCxHZflEtP9pjJRZH36y83Feyv
         OwYWmxoNCt7eTkpDdPtCtYhRzyLbd3OacgICedXtt1NyGT90T5hwp30aVdazD6u/U9xl
         DgPp3Mif6WPEPCaGo877hdPHnRLutr0L3c0UdmzrVU81mZUzdEGfxhYdKMjbKbIoDSuL
         tkuAirwDAZSL4LxHohLsiSw8RA3ghMrWwRp//wnjfImaKqiAwjlOzfuEddwKa2BYuZ+8
         IUgqkxuUXl679YBNnojNUe540JbwUW1d60VvyrmkFTR5Nk2Fx6TWpcCBcQ/gzUn+EDp+
         KVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681553; x=1713286353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cug2zylk/leTsnzlIu+NCzRbE829VJUHZn6+nNMC/AM=;
        b=TkM+A8dC/JRzDwnO1NmOniF01dYXoAY0c/LFpyra3lZKSi7gcgYJ14l7ktsBOk226Z
         dZ14p+3HsAs6aXTzQl+NX5ll9QvF29FTZDu8oGsHq62boz5m0Vh0MIiW2I7bKDkiGu6G
         XfsQDwv5qgypc+f1EE7ACtOvQXj/VYX5gtBj8MCWJJqJlAZH908Mzmw5z7r9/4Fe8BLM
         NH7waRKtErT+19KwQJPO9NNgvwGyDsqYXfBslq9n6qU0ylxwlMFNUXnq68CjyjpD1Dkn
         4OZwtMl0O42nQR1PS35Ov+5S59iAoLNLPvmv+hHLiz4LSsk7lFkPvp8qiLw5gQpQCb7I
         TWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWpq+rFN4FyfJJuLQdmA+zWP27Kk7vNDUW+Lv2oKtC9atC4mzqST9s7ggEw9R6hB7FyxLSlQXjFDzEu/yzEi4dC8+79Yx6Q
X-Gm-Message-State: AOJu0Yy7Uf0YGHHhnDR2Yk6E7u5pFlzIX1M5YABvtlYGlN6GH/tY7LGF
	HzyKrdU53geccy4XkWIEYjav0IMax7JBnPRFQNUUBuVMHadoeX5g
X-Google-Smtp-Source: AGHT+IFomyvdG7Lu4aX9MAw/Lwl0WrzcqpjznfMdHIipf1MB6MEUZEZ8BbVLS/1SHyXx3hAUN75ZHA==
X-Received: by 2002:a05:600c:3c8e:b0:415:6dae:7727 with SMTP id bg14-20020a05600c3c8e00b004156dae7727mr208111wmb.11.1712681553337;
        Tue, 09 Apr 2024 09:52:33 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c321300b004167b0819aasm2495635wmp.0.2024.04.09.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:52:32 -0700 (PDT)
Date: Tue, 9 Apr 2024 19:52:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <20240409165230.eznwc4opf3mq7qkl@skbuf>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
 <20240409123731.t3stvkcnjnr6mswb@skbuf>
 <20240409153346.atvof7b6ziaf2xr5@skbuf>
 <ZhVs41dODkA/B7JH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVs41dODkA/B7JH@shell.armlinux.org.uk>

On Tue, Apr 09, 2024 at 05:29:23PM +0100, Russell King (Oracle) wrote:
> This changes the logic - it allows driver authors to provide the
> MAC operations, omit the mac_link_down() op _and_ an
> ops->phylink_mac_link_down() function. This could lead to buggy
> drivers since this will only happen in this path and none of the
> others.
> 
> I want this to be an "either provide phylink_mac_ops, and thus
> none of the phylink_mac_* ops in dsa_switch_ops will be called" or
> "don't provide phylink_mac_ops and the phylink_mac_* ops in
> dsa_switch_ops will be called". It's then completely clear cut
> that it's one or the other, whereas the code above makes it
> unclear.

If you want for the API transition to be self-documenting and clear,
it would be good to do that validation separately and more comprehensively
rather than just a fall-through for one single operation here.

If phylink_mac_link_ops is provided, the following ds->ops methods are
obsoleted and can't be provided at the same time (fail probing otherwise):

- phylink_mac_select_pcs()
- phylink_mac_prepare()
- phylink_mac_config()
- phylink_mac_finish()
- phylink_mac_link_down()
- phylink_mac_link_up()

Hopefully it makes it more clear that the following are _not_ obsoleted
by the dedicated phylink mac_ops:

- phylink_get_caps()
- phylink_fixed_state()

Then (after this validation), the simplified
"if (ops && ops->mac_link_down) else (ds->ops->phylink_mac_link_down)"
would be equivalent, because we've errored out on the case which has a
mix of old and new API.

