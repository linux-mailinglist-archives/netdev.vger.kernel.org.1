Return-Path: <netdev+bounces-178126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E948A74D42
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B171899BCC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB41C5D47;
	Fri, 28 Mar 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkrvJNDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD435958;
	Fri, 28 Mar 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174083; cv=none; b=OhM+kMjrrKPIX0KPo4zvrR1UBHNdigsVvrZMEovfQyMhLxhj3j36mCnsPbd8XHqVh8L3iZNZdEBCT9c3hqdB5HvEgJNrESDti4dfke8NRKDIYEZ0kjVP2k8DENO0IdGym2BJcAPplHEim5Rh6Nc6flznRlQpJihmJ2eeVO4MNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174083; c=relaxed/simple;
	bh=hWGRwXThMRAfJ9BxeTuCKZ6MOAIRdTzVOV/TwJD5icE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kG4Fd1rYYlA6UA3mGn42x3191WWKCbOjEDxGDhy6nNlulGMiwejFO+IszKZ5tj+Lt4HeMphi8rNS/XJmVvTxAPg2hYSR/PKemNSuyfFbVWnbPy+nqLfVM0nALGEzffynk/dmtB7OfSVl0C3G1zEOxLcBgV5+KYf07+tfBUAuIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkrvJNDt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e589c258663so2099703276.1;
        Fri, 28 Mar 2025 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174080; x=1743778880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70FUO1eVEV2+pR2LC9bPddI1as7LzjN+Yu6E72iZ2MY=;
        b=dkrvJNDtbNLDp0rj0IrLx5Ls0paftrjqWuMg+Mq5q5deWaPe/uUDbkjCoX/xlT5Hf8
         mbGZ1JMyJudOTcZl62PBDtnWcDn087YIIfe1/7e9PgT05czw6fa4T/sJ17HkZy1+hj5+
         4VLWecvsQgQDRjVWMf1KNPXy9yFPXt6Rcl7BMcQXECDWM7ad7tozpmJTyAIonfWfLOnZ
         eYMhn3KQJWPsHCTImYdVKxRZFaK7WXHLJ3GOv2DJEackXQPLj2YoqB2XRf1M+bMLeGth
         P2dVrQSY+U8g5K5hKUVHnHyo+OzAIz0RDOWLrhFTxTq8m/HIs27K0sRBAClpARyOyIwn
         h6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174080; x=1743778880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70FUO1eVEV2+pR2LC9bPddI1as7LzjN+Yu6E72iZ2MY=;
        b=sQldFd5Lok06Kc6pyZCPk+gJzVSX3OEiC9ftsTj3foRlE7RXl2XWmF2kxRMbeGEwex
         Cf6x+p2nveONhiyxVmGadMlBDR2lL08hFBnbmQ5qkGT8XqVfLBXEv6XkdWKzhQr3YDX0
         r3id4YMFbro9sv+vFOIiLFP77rysOU6WhucwXt/8fOURr9HZzqpKfPt10UruKRXx2FbE
         9epxvhVSVWy1vpY0UFzUO6DD2nRHoK+bZi+enipBtnNKhbh+zmwM0ZwMlwnz8o33FdAf
         4HU6SDzhFTaTWacAWfJRGInjYdDNEL/I5XhiMyujNt3POkLHI2kjRHkICxqeovjC7l6w
         k1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntkw62uvWBbW0iEKcpj7oZhfovBGFTC4Bkom5ePHX8YCcQpFgJ++VPeUWlBbLpZfzCOOCY+Mc@vger.kernel.org, AJvYcCXWkV5oRYeHFTGAD4pnMvkGdPv95R6dB2KEatCx7Gk4VBI8IWm7AACU88F8sRzvRNduTohy3fmKRQzoDH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJ7iyrJK84tWy7n4qi7wP+95MnHSmm6Xt1AD4/blkWknaO8Bv
	wYKEiENo9etS4ATOHgxMl+7xepT2Rwda1QdtpI3bm4AREGkkUuHO7OhztTR0+ly6+cpw2K6WqIL
	OrZEGJE5D3LTxg6hJUcwZw7l9Ud5lMQ0=
X-Gm-Gg: ASbGnctsF2DbHpQ0r3e0wbrqMuaSOdEFPjrZObMvbIk4PnvS/UunEcgyzHoZh6I36kA
	2quw0m48YWT0G4tFf4EsJ2GXgEGej/RCdUSvNec43xJY5fmJ8CazFizYfky1QIcYPnEEcfD8uBc
	k0U9fs5BGhLPIDOrTGOq932q+hpXMXCF8QK0q6/w==
X-Google-Smtp-Source: AGHT+IGvwA/RTJS+QtL98iMmIp3tAxEYgifYL/wsi3XNR6OUOwcrpua5ZQHMa9+selmzbLu62OeZThXZL8vruS2oqCs=
X-Received: by 2002:a05:6902:12cf:b0:e64:1002:f3a with SMTP id
 3f1490d57ef6-e69435b9790mr11253843276.29.1743174080012; Fri, 28 Mar 2025
 08:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313093615.8037-1-rsalvaterra@gmail.com> <2710245b-5c2d-4c1f-93ef-937788c3c21b@intel.com>
In-Reply-To: <2710245b-5c2d-4c1f-93ef-937788c3c21b@intel.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 28 Mar 2025 15:01:09 +0000
X-Gm-Features: AQ5f1Jq0wkfbfqjfCLs6fqF5zSz9oYz4p65HD7XEeRTa9E45Onxu1B4ZkjoHV74
Message-ID: <CALjTZvZYFEqSGZvSfthsTC5sOkVixAFyPg0Jj7eXZ0tac4QS8w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
To: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	edumazet@google.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again, everyone,

Just a quick question: this is scheduled for 6.16, it's too late for
6.15, correct?

Kind regards,
Rui Salvaterra


On Thu, 27 Mar 2025 at 12:54, Mor Bar-Gabay <morx.bar.gabay@intel.com> wrote:
>
> On 13/03/2025 11:35, Rui Salvaterra wrote:
> > This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> > iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> > OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> > VLAN configurations, as ethtool isn't part of the default packages and sane
> > defaults are expected.
> >
> > In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> > controllers, my upload performance increased from under 30 Mb/s to the expected
> > ~1 Gb/s.
> >
> > Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

