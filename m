Return-Path: <netdev+bounces-185379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B722A99F80
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 05:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809EA446435
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5D19D07A;
	Thu, 24 Apr 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSa2P975"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDA42A82;
	Thu, 24 Apr 2025 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464956; cv=none; b=JZtReC24oXxpi/qOMZ9dYBh3Sls1MzjSRYwNDKZS7TacfmBZ/tFtjt3UWsTUBd20EdICYhMnZSNDNKdKFP7ZRYqhs5qQm2SYQmscXEo9YE5szxuNdGLEVKaSShzmboWtYink50HkCoMkBBWIC4JZ4Zi6w2ARhnZq8TjKh2q9Tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464956; c=relaxed/simple;
	bh=vdgInaK0zgQsVJx6BiUQjXFYztTVDeBQFXdq4XP48sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyyUSZL8r6jC3KCZdfaFSREXjOFjO7XHIxLY3nbwC2hn48pTonJdGFb6i7/pI34HpyuGe5ATOC+b4R5aStC9s9ZX8389+cYijM4pkuMYWC0p85AaoHC46XaXuBM28v9+7EXqzN2t+7/c/aHYlCPFIFKYQUMy5EGJB7iSAImbx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSa2P975; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af908bb32fdso477882a12.1;
        Wed, 23 Apr 2025 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745464954; x=1746069754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tiA8hgxcjhXyZluGTFINPezke1l2JWhQR23G4LvhXA=;
        b=OSa2P975eqvOpufW8GZdHVDR/il7BwyoGkk2tJZpiXu5kyHvIbPdTFxHCpdcL7Xr9B
         NWRv+8PyxhVVhF7TlS2qni+T1WIF474Kq0IpuKeGUvOwH80jBj4/qPv/CibD8mllDfay
         afDWNZOmAHZArrYV95uHlizKqAStUPVjpmA1+SzMx+dJcHfvEA1ED1LpnKseknBfrGlK
         IRyWPhtWE4rS7bE+ajauQ3egipqDwI1/TQzxBKMzJV9aNCgiFG72ULTXnwe6dL/AR2SG
         80HTPo4V9uVxh9//01THW/JgzPRI6nySl2/A70A5kbA166UGokK1l3EcwL5qS/XT0NAV
         n+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745464954; x=1746069754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tiA8hgxcjhXyZluGTFINPezke1l2JWhQR23G4LvhXA=;
        b=UMXg5Qggngj8hwe43m5RS0dEKRtARR5tk0Pm0bIfA6wND2SDMA+KdDibumOcsho4yZ
         wQ9QQnr92lJguT3aAZjRZrVzIpllM2Ma3x1tpaldNxxaj2O5RsYZ7w1ZIUwPFJacl5gu
         EpZMFpFDP+O/ksc6b/nCCZzOO2US3GJDcAhLu7WX1LEzpIK9YrXrcUQeVAVkRNp/wuVj
         dhL/mzJKVj7l8QMNDyNwYHd0opBgcaWVsl2CMJLvpzSF6l4ybQJEWZHFY22n+ccaY60E
         Oa77fgnbdpMIu8PYoDG+c9f3GvbKgPAuzwOHjePTx/Xo5Wck5Sa3+IBShocMac3E3+IG
         3Bgw==
X-Forwarded-Encrypted: i=1; AJvYcCVlMw2jVY7ucUXROk5O07s3OqvGPj90BlMbHTN6lNyh6XExGnErxcpjW49xj4reZiQWDwp4xRNCJZycdHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXtlujXP+M8rkgAps1fLMqslDvV/cp3lC0Aqeq52lWN2DGS+Y
	B89CrEDGWgt0UhFRTsfoLcNdINAvhS8sdjTnliyaZfEE6DDA3U7X
X-Gm-Gg: ASbGnctqK4gfR8D+6dzI3Cna8h0mxAFMXpMBKjkyH7au8FtE7P1dr4VpQS7wwidOrL5
	Lsp5Ak0IStoL1iSI9NWzYWVZGN2cxM8/RuGqNjNLL8ko7cIqiLS3q7iNEI1ke21t5b1W+fzJnoD
	cwQdP86yDKPWtylStMKqPDT9mt7DgpN3MzSIKDdtnyUWUAv86Gz1HqFgFyEUSFnlWDIZfghHtAu
	GMWGsztxqvuZuA3TNtAF1uKZvJEh5gGYadLl3DgJH9/Xbn2thZMKfPhVtzC5ZrrUdMKmrXuGQSR
	EIbJVJ88o2oXr19POnXP9vaRSwZPsLHHIFhfd2Y4E0fI2rji97G7pV0m
X-Google-Smtp-Source: AGHT+IGAWek2SCfcL/ppTRJDqmJDibjl7Bf5xjM/TaddgK9fHUFD89sVe/41ZP5km5qZ/J4/+Yha0w==
X-Received: by 2002:a17:90b:2749:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-309ee2c9ecemr1229434a91.0.1745464954068;
        Wed, 23 Apr 2025 20:22:34 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef09985asm182023a91.28.2025.04.23.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 20:22:33 -0700 (PDT)
Date: Thu, 24 Apr 2025 03:22:26 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <aAmucicgHHTeNTSA@fedora>
References: <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
 <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora>
 <155385.1744949793@famine>
 <aAXIZAkg4W71HQ6c@fedora>
 <360700.1745212224@famine>
 <aAXhiW6n-ftxAr9M@fedora>
 <511373.1745425660@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511373.1745425660@famine>

On Wed, Apr 23, 2025 at 09:27:40AM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >On Sun, Apr 20, 2025 at 10:10:24PM -0700, Jay Vosburgh wrote:
> >> >I'm not familiar with infiniband devices. Can we use eth_random_addr()
> >> >to set random addr for infiniband devices? And what about other device
> >> >type? Just return error directly?
> >> 
> >> 	Infiniband devices have fixed MAC addresses that cannot be
> >> changed.  Bonding permits IB devices only in active-backup mode, and
> >> will set fail_over_mac to active (fail_over_mac=follow is not permitted
> >> for IB).
> >> 
> >> 	I don't understand your questions about other device types or
> >> errors, could you elaborate?
> >> 
> >
> >I mean what if other device type enslaves, other than ethernet or infiniband.
> >I'm not sure if we can set random mac address for these devices. Should we
> >ignore all none ethernet device or devices that don't support
> >ndo_set_mac_address?
> 
> 	Devices without ndo_set_mac_address are already handled; they
> are limited to active-backup mode and fail_over_mac is set to active
> (just like Infiniband).

Thanks, I saw this.
> 
> 	I'm not aware of any network device types other than Ethernet
> (which to bonding is anything with dev->type == ARPHRD_ETHER) or
> Infiniband in use with bonding.  If there are any, and the driver
> supports ndo_set_mac_address, and it fails for a random MAC if they try
> to use fail_over_mac=follow, then I'll look forward to the bug report.

OK, this makes me feel much better :)

> 
> 	If you're thinking of devices that are type ARPHRD_ETHER but
> aren't actual ethernet (virtual devices, veth, et al, perhaps?), then
> I'm not sure why those would require fail_over_mac=follow, as its reason
> for existence is for multiport devices that can't handle multiple ports
> programmed to the same MAC, which shouldn't matter for virtual devices
> or single port physical devices.

Thank for all your explanations.

Best Regards
Hangbin

