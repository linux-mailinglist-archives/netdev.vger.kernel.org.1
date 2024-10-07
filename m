Return-Path: <netdev+bounces-132889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D5B993A14
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E891C23D6A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763E18C92C;
	Mon,  7 Oct 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVJI2Vuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D93FB9F;
	Mon,  7 Oct 2024 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339762; cv=none; b=bNNtEtNZ6JchFjw3DPmGbANfeSyjeM9YzAeTMrQnZrvSFSOX/vJ6laFKmeao2eW6KlHUVrJPUgWmMsrRtTnIq1/ClNNhMPl4iYU3Qn1ieaVleZEy4tfu3w2doPTIXokwrHCPXNG7urPiDgHfUZtg2qEEGLiF5/N2kutXoJ+2WxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339762; c=relaxed/simple;
	bh=jA7657oYvyV3XrqSUBNkL19mW8/bKR0MnRg4WNj9tuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd+yCqhbxJE6XfbOiJ2kTegSGFzCsHZ6/+4bl3byjXJlZg4Uc7K1uFEAah9y9R98jUHkb4X1DG5ifvc6cQVzzdje7pjtRqxCSneJTj6V6YucfUMbKP3R9NcwpALEFUWeVNXIz+uN4gLiZbX5r3sR0ByJF48iAhVF2bupwf7DJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVJI2Vuz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso7254365e9.3;
        Mon, 07 Oct 2024 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339759; x=1728944559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTNOwseZ9u/i9eKVq4JVSJZMCNYcJLzLevMhGQTrMOA=;
        b=YVJI2VuzNQyZNv7UPLP7rPNErDR//Olh6MOZm/aomyOMBwKf0gsdvxV6Bva9r/HwYK
         h8KhKH6Kruw1rjX0/i0eJ8UzhFgp7Vg/tVvsfF58KBcvBoIDE+SO5IX59M4csHitlOLK
         TWyTDitjKqudG6C7dPEvThLyuADMzerhXA0uwVN/gSReOYSgQtIk8++wx4aSHunoAxWw
         5RmvvsxmpKQIXJDi/sCf9Ig7MalmN6qvKVI66iiZux8hyxYnnkP0MvLBNqKhJtYf1XP1
         0Hd3GLzSLSluGPZYmwDtYQ//WGm95nGcMY+gPuMFfv1sPb/oGk0NsxTqNNXxlrdZrWIF
         1FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339759; x=1728944559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTNOwseZ9u/i9eKVq4JVSJZMCNYcJLzLevMhGQTrMOA=;
        b=ukf6E7EwRCMV31X77nUtOwUNUNetZxFTCBKcExrzzRJTr3d27rJNEK1ps6RrweCFMQ
         PkneCNJEVfMqG0Pv6gI7oUgH2op39bfugKmRCHNzcamn8RPyjkVZh47XeP5us8oNs0Of
         H8OXA7BkGDxMPXntFP/GgPEwM4P6DTjlAsCy1fJqSh1da7KDbbzYReCws4BXEpOU433D
         PkX3KrvkPm2eI7eCCkm0Mwaf2ZqifnseH4yAaW6koLh7ImofcCe7U7RsSfCobRGLnxlB
         fWf5AJTUoySklTEjDdTA26fCAecT+chT325qwuu/fvrDUmc79/1T1uJSxMYYoDdBUX/u
         jBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM+FHenrEMYWddb+LfPF+jIcRmU4mCZBMZ3Kn/Olvnafn7e9X0P1tWnvKp/WRacFSq89fZmDj2cdQFoeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUSSUmTUZrfSrYIsnK5LqN98VmXiHzsyp6ME7xCIrKSB6N7MY
	mByqxj1aX2q0He7vrzQ4BbYFdNPtomYMP8P4cGy1alWgbdOm0USo1fgdkIEj
X-Google-Smtp-Source: AGHT+IGjQZAmF23AbTN/w+lhuQ1c9GUIAxD7wcnRobzNIzxsfCvllWOu5uNlCFxIdIlWAfX+RtWlIA==
X-Received: by 2002:a05:600c:1c2a:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-42f859b1444mr46373735e9.0.1728339758536;
        Mon, 07 Oct 2024 15:22:38 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a2052asm105048945e9.18.2024.10.07.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:22:36 -0700 (PDT)
Date: Tue, 8 Oct 2024 01:22:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <20241007222234.ekpqibldugchuvk7@skbuf>
References: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>

Hi Mohammed,

On Mon, Oct 07, 2024 at 04:49:38AM +0530, Mohammed Anees wrote:
> In the original implementation of dsa_user_set_wol(), the return
> value of phylink_ethtool_set_wol() was not checked, which could
> lead to errors being ignored. This wouldn't matter if it returned
> -EOPNOTSUPP, since that indicates the PHY layer doesn't support
> the option, but if any other value is returned, it is problematic
> and must be checked. The solution is to check the return value of
> phylink_ethtool_set_wol(), and if it returns anything other than
> -EOPNOTSUPP, immediately return the error. Only if it returns
> -EOPNOTSUPP should the function proceed to check whether WoL can
> be set by ds->ops->set_wol().
> 
> Fixes: 57719771a244 ("Merge tag 'sound-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")

The Fixes: tag is completely bogus. It's supposed to point to the commit
which introduced the issue (aka what 'git bisect' would land on).

> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
> v2:
> - Added error checking for phylink_ethtool_set_wol(), ensuring correct
> handling compared to v1.
> ___

this should have been "---" not "___".

>  net/dsa/user.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 74eda9b30608..bae5ed22db91 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1215,14 +1215,17 @@ static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
> -	phylink_ethtool_set_wol(dp->pl, w);
> +	ret = phylink_ethtool_get_wol(dp->pl, w);

Could you tell us a bit about your motivation for making a change?
How have you noticed the lack of error checking in phylink_ethtool_set_wol()?
What user-visible problem has it caused?

Since patches with Fixes: tags to older than net-next commits
get backported to stable kernels, the triage rules from
Documentation/process/stable-kernel-rules.rst apply.

If this is purely theoretical and you are not already testing this,
then please do so. (it seems you aren't, because you replaced
phylink_ethtool_get_wol() with phylink_ethtool_set_wol()).

Luckily, you could somewhat exercise the code paths using the dsa_loop
mock-up driver even if you don't have a supported hardware switch. It
isn't the same as the real thing, but with some instrumentation and
carefully chosen test cases and simulated return codes, I could see it
being used to prove a point.

If you don't have the interest of testing this patch, then I would
request you to abandon it. The topic of combining MAC WoL with PHY WoL
is not trivial and a theoretical "fix" can make things that used to work
stop working. It's unlikely that basing patches off of a chat on the
mailing list is going to make things better if it all stays theoretical
and no one tests anything, even if that chat is with Andrew and Russell,
the opinions of both of whom are extremely respectable in this area.

In principle there's also the option of requesting somebody else to
test if you cannot, like the submitter of the blamed patch, if there's
reasonable suspicion that something is not right. In this case,
interesting thing, the phylink_ethtool_set_wol() call got introduced in
commit aab9c4067d23 ("net: dsa: Plug in PHYLINK support") by Florian,
but there was no phy_ethtool_set_wol() prior to that. So it's not clear
at all what use cases came to depend upon the phylink_ethtool_set_wol()
call in the meantime since 2018. I'm not convinced that said commit
voluntarily introduced the call.

If this is not an exclusively theoretical issue and this was just an
honest mistake, then please do continue the patch submission process.
But for my curiosity, what platform are you experimenting on?

