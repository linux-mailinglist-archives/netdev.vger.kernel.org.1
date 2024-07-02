Return-Path: <netdev+bounces-108302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312091EBB9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39E61C214BB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77963B;
	Tue,  2 Jul 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGvh7TCl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0039449
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879463; cv=none; b=ljdGRChRoAB9U2Q0gYsICrADbVBvT9/xIEXgXiWL6Q3cU6hPvZmcx2eMJ3tkI2bxkrItp5fWuQilvr2jXnkNIxEOxKt0WCiui87nWHPN1zlpjc/HKhxj/SmWPDg5auXPkQg//F0x9M/gQCCFYMOKSP53cU0LXm/FlkQJJ0hU3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879463; c=relaxed/simple;
	bh=mED/zjSO5570ESHg0qdtHTDrK1ng0y8hJRuZVX/hUos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU8W4edlxQ1VwlzVEAaLVePWXBpEUl8aBt7lotNTEsOMst9tqVw0HhxRNoBcQdVOklhfEJOkitAEHZpgnsUPnFSKkikgf41A0QPe++BPrISe2FuxUsEGYL/Hx0SsY4qdrwYxRPk9Vkbu+1Ki+vGSuKh/sBKh1iJKu1UlqkDlf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGvh7TCl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9aeb96b93so24759905ad.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719879461; x=1720484261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGqMPNan9Le5pmRByGpFgMoNrRjO5/DSkiC5AQxkk/U=;
        b=XGvh7TClcCF9a/WPd9cjSfGSiZ+kERDGPFYCApag+4KI+0LF4x09AV5WAmXvP2qVMW
         P3lGLvBwc6GkVZ2nMUb9TnNadm9l+977czrYC5pVXG5iecRjs8cimmyj9EiP+HPeb6bC
         kgR3sg+KjK2w+JBDi5ZhifmdqNCh1PVxxJFSThmD/mHLFkVgJ0Vfp0y0lnaUOMBUKALN
         dLtZQXJk54xvBpT9kBL1B7MDXArdLxm8G+j5UiI5UZBOFSej/UP7IrsITVbxtCL5RuYY
         xdrev79guAFqnygKs9TpeQsbrOwGIEbiPvFJd4QsjS/+qiR22cO256Qh2VsYWXG245xI
         3IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719879461; x=1720484261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGqMPNan9Le5pmRByGpFgMoNrRjO5/DSkiC5AQxkk/U=;
        b=ORoLMkkKr18SlJ3jH4zWNMmGwDODchriJE9SecNRWsxp8ijnB7JTGx1IxwEUmyvnEV
         RNK7pGZA1m36P7icAIsbD/7lwem6S7C8M5xIoodmmv77hqgWX7EwlidJYqHWBKUUUegJ
         vnousiJe2zP59rd6qdcyAC22/3dHEaF4mX+lAryVObNkjLyVuFK6ffcgZfweERyN82Rb
         XFRtwah7FvvfQCtWwzih0iA630dYpBMrrU/HavpVNYX64O3YyVHDnYDsz2uNGemoBcHM
         gPHb4cXsLRK62tW2InSINUn4zlsuqBAa2P+6uIogJWWB1K8KMtn88L+oQrVR/7PYUseW
         cH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0z+yNJvg7jdoXSY4F1oqHKUYKEePovhzyzoTs/pCqUWBOcEK71ef31jtUGhOHLyXkGYQiHtkSXNjoYOX3A3TSLm97Tlw3
X-Gm-Message-State: AOJu0YyWR1at64wBi9W4bJpi7n48n17D4BNnLMJt7O3rlVZqt+0+1OET
	a/Yuux0NVkC27X2bYYW4xZMfspStFjtH9Obh4+HxAZ49zlql2XXAR6kXR+6AOkM=
X-Google-Smtp-Source: AGHT+IEW3PtrZaG8r9R7PF+VmNVnLz0eerLhL4Z+nGNGS7eseeKcNtJ2aeNHxqS24mqmEUu3jf7JBw==
X-Received: by 2002:a17:903:228e:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1fadbce7df0mr57826385ad.47.1719879461463;
        Mon, 01 Jul 2024 17:17:41 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:62b0:7aad:184a:7969:1422])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598cfbsm71063545ad.250.2024.07.01.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 17:17:41 -0700 (PDT)
Date: Tue, 2 Jul 2024 08:17:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Bonding] Should we support qemu/virtio for 802.3ad mode?
Message-ID: <ZoNHISwvQ_0QeIRp@Laptop-X1>
References: <ZoKAt6ZkoCR2roEx@Laptop-X1>
 <ffa1036b-fee0-4e0a-bb5a-791ff95c7142@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa1036b-fee0-4e0a-bb5a-791ff95c7142@blackwall.org>

HI Nikolay,

Thanks for your info. I will ask if the customer is OK to set the speed manually.

Regards
Hangbin

On Mon, Jul 01, 2024 at 01:27:54PM +0300, Nikolay Aleksandrov wrote:
> On 01/07/2024 13:11, Hangbin Liu wrote:
> > Hi Jay,
> > 
> > Some one propose again[1] if we should support 802.3ad mode for virtio driver.
> > What do you think? Should we treat the SPEED_UNKNOWN as 1 or something else
> > in __get_link_speed()?
> > 
> > [1] https://lore.kernel.org/all/CAJO99TmB3957Wq3Cse7azgBxKeZ2BV6QihoyAsjUjyvzc-V8dQ@mail.gmail.com/
> > 
> > Thanks
> > Hangbin
> 
> Hi Hangbin,
> Because of 802.3ad we added:
>  commit 16032be56c1f
>  Author: Nikolay Aleksandrov <razor@blackwall.org>
>  Date:   Wed Feb 3 04:04:37 2016 +0100
> 
>     virtio_net: add ethtool support for set and get of settings
>     
>     This patch allows the user to set and retrieve speed and duplex of the
>     virtio_net device via ethtool. Having this functionality is very helpful
>     for simulating different environments and also enables the virtio_net
>     device to participate in operations where proper speed and duplex are
>     required (e.g. currently bonding lacp mode requires full duplex). Custom
>     speed and duplex are not allowed, the user-supplied settings are validated
>     before applying.
>     
>     Example:
>     $ ethtool eth1
>     Settings for eth1:
>     ...
>             Speed: Unknown!
>             Duplex: Unknown! (255)
>     $ ethtool -s eth1 speed 1000 duplex full
>     $ ethtool eth1
>     Settings for eth1:
>     ...
>             Speed: 1000Mb/s
>             Duplex: Full
>     
>     Based on a patch by Roopa Prabhu.
>     
>     Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> You can set any link parameters and use virtio_net with bond/lacp today.
> 
> Cheers,
>  Nik

