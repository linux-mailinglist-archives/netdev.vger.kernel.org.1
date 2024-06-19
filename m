Return-Path: <netdev+bounces-105068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A755C90F89C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E241C203DF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AE8060A;
	Wed, 19 Jun 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evvl5HsW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610215AD93;
	Wed, 19 Jun 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834080; cv=none; b=MUqd2VBCad6/Y8PlQDh9uA22jDKGUKzQf9OoRZqARz427KtAo3ITQ8+qoOpXNxxihptDUE8f6cnjishEHwou9YHoXT4vtZoDmPv2zHwiTpjyDdf4gAnBthb/P+hvm9NS5VH7N89mNoodB53v3dQjIiDvH/Yjdo78uGU8dnrS4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834080; c=relaxed/simple;
	bh=z6G5Uf6Iyi4WqQORTIjD0jB74Kt0ewnl52JlqEwRn2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzegLW5cQY2YNfCp06ij9oEG8U+M8fAWuqn4Ol7vCLkncGWwdD24Mgu8468yDDQl/ySbBYbaG4PXXQMYr1liXf06kRLcspAC8gBF9zI+l19FcGb2x9EIwb6kcoA0Q0NOQM+LLzc83mfvepJWNbMSExLj/2oo3mTMvyJeQA00zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evvl5HsW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so177017f8f.3;
        Wed, 19 Jun 2024 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834077; x=1719438877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6G5Uf6Iyi4WqQORTIjD0jB74Kt0ewnl52JlqEwRn2Y=;
        b=Evvl5HsWywuMxsq0bCt46NDFWvp6UNp4mU3y9kZucC7KfhboKyAy3/gXhS1e7DMGOr
         f6X9pwcJX2JLV5yiYOAUjeh6mv1Rp973TNjBSf++FHP7A93xBk/mIuo0DovbiEGQsi1n
         7JXVMkSdyCJIocoCxXiuSIi0M1xHmJiJ5mSE2AKUtGNu+AEa4RGeUIh0+zY7mBQs8lNU
         dx2GVZyBj2/u7cA9Rnalb/J7nEafaiVaP6LKKUkkt73PJ+7y6XsirbBPb8IjC+wsPkIP
         NVzzb3v+0mXRku0A8UKsvXC+ZQcN8CqsD23t580x6enyTj5DvN8bWNQE/Fb78l4QquWJ
         gSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834077; x=1719438877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6G5Uf6Iyi4WqQORTIjD0jB74Kt0ewnl52JlqEwRn2Y=;
        b=pOqRN3Ar7r+0R8g8RV6rA2a/5JNMNSHQ5wAV5l/1aNGPUwhoLQ0QxbI2gUJcltypR3
         yvxUdEON4ny7r4C5B6oEmKEAijUMsWbDJzUa/YKfeSkESXRNb7yoKq7yfoYdUfp572HS
         qSoWOwL7hOsM8Ny2amFuXFo+NmzSsUpBgRVC3UVrFxhgd0XiLhVgnZGFmvjooPwYuuti
         qwxGcGrteenkx4ukfDHr4Gt91CcEL0EEzx9jWosjJ9eauve9gpbAg/WjCxH5S5ypx8JD
         8UFi5n8If72vSueYispZ3LqDNacmdPcFf1U2OlUntW4NwlEOm0sXsJJiB89fsAI1k9yc
         dN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0j56c4u2AUfPwjb2jtvFzqQ6AWLtFiKcgA+lnHSCzG1OuhJlAQK3OQ+52n/wBliAsEKBDUe6RHOVPRe5uZe4qB9gubWFp4DUbi7/fs/6vEK+Dqy0lgpoB5RqsPy8hbZvxETfs
X-Gm-Message-State: AOJu0YwamAh+dt3WV8JUP8d6rbQPxNnV+Mw7TpzH0sx3ffb6sx1oIDZe
	8jPs+xk85RrwB6MqtRCC0gUK5aU591iVAoJ9lrYAT0tUSZowj8BV
X-Google-Smtp-Source: AGHT+IFpU83wPBoQG7vdNoz5N9ED9k21NppCMsmGxa54FItrLhtOf3h5aGsmHXiFkiCuY6jjnhWxTQ==
X-Received: by 2002:a5d:6384:0:b0:35e:4f42:6016 with SMTP id ffacd0b85a97d-36317b79039mr2554677f8f.30.1718834076612;
        Wed, 19 Jun 2024 14:54:36 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecd666sm701447466b.135.2024.06.19.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:54:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 00:54:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240619215433.6xpadwyvudtybd72@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619154814.dvjcry7ahvtznfxb@skbuf>

On Wed, Jun 19, 2024 at 06:48:14PM +0300, Vladimir Oltean wrote:
> You would have to make hsr_portdev_setup() call something else rather
> than netdev_upper_dev_link(), because that eats the "void *upper_info"
> argument when calling __netdev_upper_dev_link(). Possibly create a new
> netdev_upper_dev_link_info() ("link upper dev with extra info")
> function, which only HSR calls with a new info structure. Then, the DSA
> core has access to that and implicitly to the port type, and from there
> on, you can apply the proper restriction.

Yet another comment. TL;DR: I think we should also make HSR use
netdev_master_upper_dev_link() anyway (as a separate change), and thus,
no new API is needed, since that function is able to pass a void
*upper_info already.

Explanation: "master" uppers are called like that because any lower
interface can have only at most one. Bridge, team, bond, etc are all
"master" uppers. So an interface cannot have 2 bridge uppers, or a team
and a bond upper at the same time, etc. Compare this to regular upper
interfaces like VLANs. You can have as many VLAN upper interfaces as you
want (including if you already have a master upper interface).

The point is that, AFAIU, the "master" upper restriction comes from the
use of an rx_handler. You can't chain RX handlers, and a lower netdev
can have a single one, so if the upper netdev uses an RX handler, it'd
better make sure that no one else does, or it does but in a coordinated
manner.

Upper drivers like macvlan do use RX handlers, and are not "master"
uppers nonetheless. This is not a contradiction in terms, because they
take care to set up the RX handler of the lower interface only once.

HSR is not as careful, and uses an rx_handler very plainly, but also
does not mark itself as a "master" upper. An attempt to put a physical
interface under a HSR upper, and then under a second one (without
removing it from the first one), would fail the second time around due
to hsr_portdev_setup() -> netdev_rx_handler_register() ->
netdev_is_rx_handler_busy() -> -EBUSY.

Nor does that configuration appear to make too much sense to me, so you
could mark HSR as master, in order for that second attempt to fail one
step earlier: hsr_portdev_setup() -> netdev_master_upper_dev_link() ->
__netdev_master_upper_dev_get() -> -EBUSY.

With that in place, you also have free access now to the "upper_info"
parameter, for what was discussed earlier to be propagated down.

