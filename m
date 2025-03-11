Return-Path: <netdev+bounces-173835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60EA5BFBB
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB6B1899029
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34020241673;
	Tue, 11 Mar 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbEeA9k1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF914F6C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693791; cv=none; b=ETkEX7mnfHmTjgQfVq7Em/9MUAztTYJdrAlqPRXBljaS/sGmeVr9jawIVJh3MhClrKW12XELa0qNgu3oyVhr+x4A6y+3ElWS5QeqpD+heA1RHQsj8PQ72y0genwZWPLS7LhbwpFIseyV5OOzHCUdukoWtxWwKwagQeIB8+BYLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693791; c=relaxed/simple;
	bh=fgbasj5hwRehXvV9ikNUT53Ivwa9GzNojNgx3dkoU7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAdv2CLcb5/a5r31Lx+oVzHablXAHklAMjAFtzaUTKXQcw0rEu9/+8bjIPIbTWlaGSOJ5vlMnY2D+wvHRmjCyRJEnSf6e8NE3XyBZOxkzQ2TiUXwmXDKuTzOo/5qBLwONhPNd1zBUv7eQAA1foMANv68SSsGYacreBOM4LodvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbEeA9k1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso21826955e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741693787; x=1742298587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mYgyjyVt39e++noTUvi57inBqbP9SFAjQ4trkmDKvY=;
        b=sbEeA9k1TAbz1OyEx9MHSJ9XFJpMQElse+8xXCwxJSXHr0BN8SLDuaf/yHcak44G8B
         YGzE57RcJmB+p6Jnh8ZxwXZ9E+SsLWb1icrHrPIokY4/P+OEO/9q3SEKNtXCMY7D54Ep
         rUPunoN9LIg+xjPwTKmfvpd+KKR+rtRwXQ/qaeAGE5lOQ5iJlTiyCGEcDZ38wEJw7Y0R
         VlO2pqyHdjl3DC8uKpqFQIeHGdE9XjIGQWokR+1zgPAMumWECgkW4J5UQal0ZExkFO31
         vkkiDQXeWN1MCQd77B9Wj4U5Ns1lR/EM0O3XJZON/2FpGBL+cpnzN5EWbg3X47VfEbVk
         fiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693787; x=1742298587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mYgyjyVt39e++noTUvi57inBqbP9SFAjQ4trkmDKvY=;
        b=jDaXDTC3AoRld8bx/rvG+X1dj8/AqSGTxA+Kk/yOEIMxGG6pZzMYHEaBFdyeC5tX2E
         VALM3LCXJ2XjsJn2y5IvpPgI1xNdoSCdRwoGYgzmSmXn0J8aYcPSUg4sTxmEdeOtfLNI
         OVzi+RE62FScmmXb/VpygGdGE/ZZxsrbhBRKHHURDGMKyshtVOfbHawup5LefQ/EEBvN
         jiYa0GGfT9PFbELk4SdyZtw47zqeDilhNfShObmFIBjfVsant+satXaUjK8rFKBlSBSm
         KVIWDXxFljcAuvqiEX9eczEFvflbb1rxfUpaOeQyWMyvjUnsb3tarsAC9B85uBExDER7
         ITXA==
X-Forwarded-Encrypted: i=1; AJvYcCVCepyIlLzuO5kx0HbVQDAiutUTSeMqxiaFi5NuUK16ETp+Qu7HCt8cxBo1Zlv4nZZi8XSG5vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifE+2QK23OUKk9OTw48VkrEMMImDVm46o7wC/I+32Ua5TCY6T
	w6b9+Hzn0S/Dm72iA3IrcknbX7e7Vxg+WdEcs8bI1sctfqR8puBO4MPJ+Qs1F0M=
X-Gm-Gg: ASbGncv2rtEP7FL6xwiDJCowMZVVNOzsaFGrGf66KOtSj2GIIFv4lM7HUqARn8/BlN2
	iPTsuAwfqXg8KXeEQAbFPcEvtveukD+CLTOqRPpt0xIgWSfmBwqLKHTAuw3/Bx8Lhuh1hbx9cAA
	YJKJzM7QkUkiYuYBz0UbHiuqze5Xd8hIAYjlNVmIQcTTWpbd0a8SpShPs8vKT9PvEKPJeK8LHQh
	5V6D0zkpiG0WsKqkye0guqlabIHcF6NrB0G6epFYzPPc5uTNKwJkXrGE2DRZntZ/3nJoZQMuwJ6
	ijYjnrSgsrDs2MwqGa4NDf+IHYRYlnBiH/GzwzItkSZO/jALtZ2jwaIAVjRD
X-Google-Smtp-Source: AGHT+IFLutZShbEEA0xdtKZHonhd9EodwZw8GsnnqFvQtNzl6sYtDlZevMaqn3qT4K7I9XDIISMkqg==
X-Received: by 2002:a05:6000:1a87:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39132dc4395mr11386484f8f.55.1741693787529;
        Tue, 11 Mar 2025 04:49:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c102d76sm17651934f8f.86.2025.03.11.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:49:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:49:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Pierre Riteau <pierre@stackhpc.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <3ff973e5-5474-4112-81ad-46b745edd6a9@stanley.mountain>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
 <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
 <CA+ny2sxC2Y7bxhkO7HqX+6E_Myf24_trmCUrroKFkyoce7QC9A@mail.gmail.com>
 <Z8//h7IT3cf01bxB@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8//h7IT3cf01bxB@mev-dev.igk.intel.com>

On Tue, Mar 11, 2025 at 10:16:55AM +0100, Michal Swiatkowski wrote:
> On Mon, Mar 10, 2025 at 12:42:13PM +0100, Pierre Riteau wrote:
> > On Tue, 18 Feb 2025 at 12:56, Paolo Abeni <pabeni@redhat.com> wrote:
> > >
> > >
> > >
> > > On 2/14/25 2:58 PM, Michal Swiatkowski wrote:
> > > > On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> > > >> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > > >>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > > >>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > > >>> devlink_rel_alloc().
> > > >>
> > > >> If the same bug exists twice it might exist more times. Did you find
> > > >> this instance by searching the whole tree? Or just networking?
> > > >>
> > > >> This is also something which would be good to have the static
> > > >> analysers check for. I wounder if smatch can check this?
> > > >>
> > > >>      Andrew
> > > >>
> > > >
> > > > You are right, I checked only net folder and there are two usage like
> > > > that in drivers. I will send v2 with wider fixing, thanks.
> > >
> > > While at that, please add the suitable fixes tag(s).
> > >
> > > Thanks,
> > >
> > > Paolo
> > 
> > Hello,
> > 
> > I haven't seen a v2 patch from Michal Swiatkowski. Would it be okay to
> > at least merge this net/devlink/core.c fix for inclusion in 6.14? I
> > can send a revised patch adding the Fixes tag. Driver fixes could be
> > addressed separately.
> > 
> 
> Sorry that I didn't send v2, but I have seen that Dan wrote to Jiri
> about this code and also found more places to fix. I assumed that he
> will send a fix for all cases that he found.
> 
> Dan, do you plan to send it or I should send v2?

Sorry, no I didn't realize anyone was waiting for me on this.  Could
you send it?

regards,
dan carpenter


