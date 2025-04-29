Return-Path: <netdev+bounces-186649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE9AA00E8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A281F7A342A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEC205E25;
	Tue, 29 Apr 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki6bYbb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326F1876;
	Tue, 29 Apr 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898774; cv=none; b=Jwu49Ku67cI8VLEJeSNVX2on9iOHQnaQGay7y026/rZZwS8B6LC16mkx7KxcA7OouoZiogovTe6m2lqN80zvK2ySjexfwzpE9hvCzdxyoS5xWmKVm/gCGHuG8QqUHQu2LQFoBScgeCOMISLmrphB9i2hj3syVZoYlqsuLXNSIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898774; c=relaxed/simple;
	bh=hHqvzdsTuzIMlvA7HoDNTV7xHO1P/qj1EWq5+5j7pPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT1mNbmRCLH3gpD0iATbsxx3YYAiasUWv1eeOmuMIyc1iudbh3eb+AnJwlUeLVbAWItnYxUyfWvrrjpN+5rwGJCTzlmyLqXn5PDxQesonEq4qgOvdOlrk4L9iPqBRZpkP/tobYqJP/juEOHfuRK7jpZKL0ImEbsJVxoicj4yGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki6bYbb6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso5536465b3a.0;
        Mon, 28 Apr 2025 20:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898771; x=1746503571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmezqW1YeoBrK/Hp7omIeEHWydcgRF3JWD7dlwVguIM=;
        b=ki6bYbb6BPQsLr0SOh8hjXqbzsH6UMWDTyOUUpdsyN4L4k17+flubOgUYLuhUuD0ZO
         gfAEerQimM5lZB+XSH60NHuklvNBqpSBPeOA8rzZ0/DwFNKOvrNRfaZLCaaU3706v3YF
         mF3WM6Mby03tCFpe28em9fw7vs+FLQ0m9aAqdqwYpWL665bLDWFWqnZM2qZEe0LJeTMG
         8CPQUOgjwWM/+7QLmgaBtVB2xgrTQyDVk4toG577tQoqe14ZjzFgX6eKnxiHEhEzvDmA
         S2rvuqaHHGdh3a1lZ1qctKkJSmIzkO6S8s8KXdG4xS8AU9pHdohfMGbYfDjjdlzYtoj8
         XeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898771; x=1746503571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmezqW1YeoBrK/Hp7omIeEHWydcgRF3JWD7dlwVguIM=;
        b=j373gXjDarubpz7mkJoQ3YnZl15GU5kewsSlwFJMrZzzLMbVdrFGviPs5HwLBmVArR
         2VSJQSTFdl1KmF2NGvWJ7sNzdwy/C/j57VN0B2X3rLWPDj4n0rvf+YOHvpPsjdJ+b6/e
         iXtsVZBGgsxq6JHMivrbIAhJTS7Eba7qHiIYfXQFZmDdyrqKEvD3X8YcUleJBo9hkqCG
         ukqGOT5SMt3XzYU5QZg2oMA9uqs/r6L3slUqcEJJ3RzRDKTm0hyYJE3u3sRmhMwEoRxW
         FUg6PWRs6nOOP603j7Pp7B3TonWrtZRmZPHjkRd3GbbsgSK2LXYKRFwZ8tHrNa88jEsp
         b/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi9ZY8+4HtOE/rgj+k80xyfMXptScP7I8llWrZyyFZ03920M/mtSf/erbRvqnErLIhD4z80iLD@vger.kernel.org, AJvYcCVWOdWB19fuX8eISkIfEwxGV1V+YaNCawicSHTka4j7O3iwDZTTKRZzIrNDSxhE8vsr+XRk1HeKalAS5VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMc9cH/wezZpW0SvQaZOnR5dGJvBPc8M9iZoU8vaLetL57JINx
	s5aEhqBtiunBGicXEq6r6D9hZtQDa2a+xRyMPGyEHucvyseZriYM
X-Gm-Gg: ASbGnct04Pj4+TNYtbI+NqNZndRXCCtF86+mK1btymp/SVBSvPrSmsk6RZwxzeeB4tU
	Gii2sg8CXC2h6hAa24HmpO06NhfrkH0q8NOl6Evc+medZMixhVL0CiwRe0fnCJLpkuDSRrqaUzZ
	Mw+N3kLiGKCvPEl/e1PhCd3saN+TU+eynF26JtcMFt84mTtwbqehpcB6SmUlBH8+GK7O0Gtju2c
	jW1JtSpyBCXtfwqWfEoAzur3vPMAdWVnrVa6uRIvFnc7Jq+uhXTxk7qxLsheIxTMdJKAg8uSy7J
	8GAahYZkPFumnk3TXRWHKliTlWUrcCi84aSC8v3N3HH/Gw==
X-Google-Smtp-Source: AGHT+IGJA9OLPgA1vG6BAHW8IqhsATbJmiY+nsWH5A89H1retTnvipH5EJniCl3fYfAS/FbOPCQwdw==
X-Received: by 2002:a05:6a20:9d93:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-2046a3abe8amr14500891637.3.1745898771504;
        Mon, 28 Apr 2025 20:52:51 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec1c4bsm6611476a12.21.2025.04.28.20.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:52:50 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:52:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Wang Liang <wangliang74@huawei.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] bonding: hold ops lock around get_link
Message-ID: <aBBNDOmGiuq_BXT0@fedora>
References: <20250410161117.3519250-1-sdf@fomichev.me>
 <11fb538b-0007-4fe7-96b2-6ddb255b496e@huawei.com>
 <aA7hwMhd3kyKpvUu@fedora>
 <804583.1745853040@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804583.1745853040@famine>

On Mon, Apr 28, 2025 at 08:10:40AM -0700, Jay Vosburgh wrote:
> >
> >What if rtnl_trylock() failed? This will return ret directly.
> >Maybe
> >	if (slave_dev->ethtool_ops->get_link && rtnl_trylock()) {
> >		netdev_lock_ops(slave_dev);
> >		ret = slave_dev->ethtool_ops->get_link(slave_dev);
> >		netdev_unlock_ops(slave_dev);
> >		rtnl_unlock();
> >		return ret ? BMSR_LSTATUS : 0;
> >	}
> 
> 	This is on me; I had worked up a patch to remove all of this
> logic entirely and deprecate use_carrier, but got sidetracked.  Let me
> rebase it and repost it for real.
> 
> 	For reference, the original patch is below; it still needs an
> update to Documentation/networking/bonding.rst.
> 
> Subject: [PATCH RFC net-next] bonding: Remove support for use_carrier
> 
> 	 Remove the implementation of use_carrier, the link monitoring
> method that utilizes ethtool or ioctl to determine the link state of an
> interface in a bond.  The ability to set or query the use_carrier option
> remains, but bonding now always behaves as if use_carrier=1, which relies
> on netif_carrier_ok() to determine the link state of interfaces.
> 
> 	To avoid acquiring RTNL many times per second, bonding inspects
> link state under RCU, but not under RTNL.  However, ethtool
> implementations in drivers may sleep, and therefore this strategy is
> unsuitable for use with calls into driver ethtool functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Device drivers are now
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> 

Thanks, The patch looks good to me.

Regards
Hangbin

