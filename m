Return-Path: <netdev+bounces-170441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B9A48BD7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19611891E0D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480426F469;
	Thu, 27 Feb 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxRqSjmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D323E321
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696020; cv=none; b=RLJ2p17Q5TrnxORl07I3oec8lL979yGqTaQ7WQ4gyLbgEwy2140tmymeAV+V4V1TB0N/QaJ9UIBKA9dvuIJeLs4D04annCsrFZ3x8PXRWf6QAu3q/RrbjiINQncLeQbNEhd6fQ1V2YM/eFltJzOap7M9mOoqf6zTm1sutseODTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696020; c=relaxed/simple;
	bh=ZhPNcGAzQwMmYBFIzmfd7WSYlpOdlcAE3rPf6BJ6eME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVlajxcD9X2CXqoSC8wdKZPjKXYnCx5rx/fh/JNt2K8VrlAiboW6iXcJYHF5BCCjAuw1ZfmGvkpwAA4LlIRJgBpAVkM3j7ijxYbiF4pA+QxFvP20eCnc8up0c24abluJW21gk5cJeAX06vdyyPtxwzp6lVcCubiUSbD2xh0TSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxRqSjmr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso1042576a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740696017; x=1741300817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6A36yIWCcLoxH3HRsKC64OeKu1/OybPRQcI7lmHV78Q=;
        b=hxRqSjmrz4+5JcYtcmu2GXkjEiAMC4S95FtLsCuckitfzguTCwow31FxuDA4cIeEvn
         vp6OSkZ0vrNwPxO8kaLbiSqOloKcgfU0ryRN9eNHYiVzwqf3+gfkN7gpMSpZ7GOGk8bh
         2Q8WxEpU/Z2d15ZroiRmNgTL1OfHuXYSoLtt7JtqsoQAGbFOfd7MlttVG9TcL/lqLrLz
         6IiHlrFw0YgvF0Ugl5FQG7+SJEMsGMnPy0ZN7APLFbJh2TPnna2s0dVDNp4zxb19zAAt
         fXtcvE0+ybNInGQK6zXZpkGGx/bxRqqtOY8+mVejIwhac3wcQ3kQv9BFu5iUR/mo+wCd
         9CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696017; x=1741300817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A36yIWCcLoxH3HRsKC64OeKu1/OybPRQcI7lmHV78Q=;
        b=UqleOW2Libay7pfV9zP+g5PEFZITqeyGQaCDbQQ92Ly+42WLf7t6VPMj6GcTA2cCPW
         DAgU9uLz391WhX7Zg9s00iCVwOf9gjcEYtlBBTYWdahQO/VUMeJNONrjz0xgBBRF1f+u
         Nz9Xrgxt2p7b6GcEjFV9Wg10ybzBp8BvbYJpkM57IWgPifvndlLzyph41dTqBUa5770F
         +IYTlhKyUWw5jOd9yuZ5HkEDetcdbhKqi2hAxX2W9SFxKqFpJKXJ3uMOBeoUo31DKMQh
         M1xY6wj4R/VSab9PT+nSE9NBRcSSydGw7y+hOZmdI63rR0RiAVYYcqMtB8QyGtLCaG08
         yWOw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ntrEbOHAUaWTxqBZSW64O2qjejzoMMYnxJ+hf7Y49NSYWZ1qMuxj+DS1XZC08GJH2+GmB2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3KGxSfHQPGKXHsBO+8tbZsw/ekmfvJS4cwfE4BAQJr7P5VZe
	38LsXby8mj4u8Ny0EaVPawYO8imPzI2qLmgmtcbyGqozrtNngvE=
X-Gm-Gg: ASbGncvUHG9rp/HloKul3XgfyyyIOI4hs3ePuj73QGjfd/2nVMtjWT09FhAxT5csqyE
	/kmA87jOX8AP7sS1iy+5MCp9pBsNcd34xFsuEHFLAGkJDPcfpDPSBnRFh4UbAIeNPUc88STLuYd
	HtmahkT7ZEv/diZHSvYUJ7qBF6ttpmn+pjWHdWVPhJqT4Rt9B/PjrmNuhkMchBN8DPpZ0bwitVV
	sHEOa/T+bvOx45bH3mWPtjphcwLagxK+rCKHW0L/1MO9sev9v+rzvAUNEC23XBqA+z6+CY+guY8
	6cixfsrqLyfaYvfH19c61lV8DQ==
X-Google-Smtp-Source: AGHT+IGPqIAoh/MidEvK9URsZxT+3GHD41+P2h6SVJ6E+/apXMYiZs821o6ZiaZkJnTZL9Z8TJHjQQ==
X-Received: by 2002:a17:90b:3c02:b0:2fa:1029:f169 with SMTP id 98e67ed59e1d1-2febabf406cmr1853899a91.33.1740696017520;
        Thu, 27 Feb 2025 14:40:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825baa4csm4429356a91.17.2025.02.27.14.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:40:17 -0800 (PST)
Date: Thu, 27 Feb 2025 14:40:16 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v8 08/12] net: ethtool: try to protect all
 callback with netdev instance lock
Message-ID: <Z8Dp0Cm2oAWxCxXp@mini-arch>
References: <20250226211108.387727-1-sdf@fomichev.me>
 <20250226211108.387727-9-sdf@fomichev.me>
 <20250227094800.7ff48a71@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227094800.7ff48a71@fedora.home>

On 02/27, Maxime Chevallier wrote:
> Hi,
> 
> On Wed, 26 Feb 2025 13:11:04 -0800
> Stanislav Fomichev <sdf@fomichev.me> wrote:
> 
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > Protect all ethtool callbacks and PHY related state with the netdev
> > instance lock, for drivers which want / need to have their ops
> > instance-locked. Basically take the lock everywhere we take rtnl_lock.
> > It was tempting to take the lock in ethnl_ops_begin(), but turns
> > out we actually nest those calls (when generating notifications).
> > 
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/netdevsim/ethtool.c |  2 --
> >  net/dsa/conduit.c               | 16 +++++++++++++++-
> >  net/ethtool/cabletest.c         | 20 ++++++++++++--------
> >  net/ethtool/cmis_fw_update.c    |  7 ++++++-
> >  net/ethtool/features.c          |  6 ++++--
> >  net/ethtool/ioctl.c             |  6 ++++++
> >  net/ethtool/module.c            |  8 +++++---
> >  net/ethtool/netlink.c           | 12 ++++++++++++
> >  net/ethtool/phy.c               | 20 ++++++++++++++------
> >  net/ethtool/rss.c               |  2 ++
> >  net/ethtool/tsinfo.c            |  9 ++++++---
> >  net/sched/sch_taprio.c          |  5 ++++-
> >  12 files changed, 86 insertions(+), 27 deletions(-)
> 
> FWIW I've tested that patchset with various PHY-related ethtool ops as
> well as the module ops and didn't notice any issue or strangeness.
> 
> So to some extent,
> 
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you for testing!

