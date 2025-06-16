Return-Path: <netdev+bounces-198130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A1ADB584
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AC3165D91
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AEF1CD21C;
	Mon, 16 Jun 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="gMH4M1fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B4213E85
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088036; cv=none; b=mRu/A833eYtbBNvEzw3R/lcMikHUkMcpfFKJEmf4TvkTsxiun946BCVp+dC5SI10lrND5ltayoPiyJMjPOSPkJ3UPaQjRUPJfjvmqUSFirVOCLqdd6jPv6TaIhcyXyEcxrND91kC47NzlnsjEB437kZ/NkpEx9J1RdvrcHzY8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088036; c=relaxed/simple;
	bh=5aWpUGagYS/BgiDuRQNL+r01UapDOsscZDSY2bRHr1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXQvYHGd+QT4w91CWQpFuMwz4wGjsUcWw7NwGTrGjCVIhADuERyE9ESyS9ODMSy0RIL1NYkxa36ECbMSiyAA31GPXOm7497IbDQhhf1hy5irko9R+fjSbE1AzRwyRTL0iCWoqnStNv/2dY+342Bi+/FYl157LWjeK2kSPVKWTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=gMH4M1fw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5096158dcso4046598f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750088033; x=1750692833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8OkHQgLnKX71RiA9XfFls/QVC13WHAM4qgo7+lq6bg=;
        b=gMH4M1fwrJMq69VBzRJEmSlD10q7ILVKi45FMa93xwC5kirWMP6+XlsGs6AAxuGsh5
         VBHEbWVKguFoLaeRx4dwCnYwlC1j+c6eWnGm20Gq/4HhPDZH92PR8cVjzzV5a62QHN4h
         Dfd/S7CcaGbw2ITR2UW8/KkTzWFd/nbY7lq5W3rJiu9xTTwqtyTxbitlFvp0fnhnFFYR
         nu49nh0CvJZElz9YAs6HnoOHAMqIM311Y8nzLb51sQs6r7xABqJNGEO+g1zmOdZDQixS
         DfFJcqqYHoq6mgRoRr/1lyOdrkzOYkLmGY/QQlRSDudysXHBnHWic70cTlei3vyUrqxH
         sueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088033; x=1750692833;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8OkHQgLnKX71RiA9XfFls/QVC13WHAM4qgo7+lq6bg=;
        b=ddMvQF46ZdDEab61kuke0VHGYV8G8guJD/de8RecIMNYlC0eR+vP+bq4zqox7OFhzC
         8rWmEfiI5MC4JQ0ADIG6s+gGm5zEnQNwhWViLSQUwP6I6soZ9WAERxcNnX91Mh/01AFT
         /nNGaockeajpSiKStEt/KJyHJ10l+dIAw/7/v/HUsK/Y6iQk3qFGlQv8V1QjOUhaD38/
         hk1X5VZQDKWenHKRbSpx/2KFGVUjkRs82edaUCqkckvZYvNynitLV8HHSab6Xe+tfaah
         NFkPYIgdXaLfEIuv93xk3MrqM6bp3+2WbpkcVbEjC9mQ3yU/gcwZtMsrGASZPZRaVBQL
         l+4g==
X-Forwarded-Encrypted: i=1; AJvYcCVZxJkw+Y90wXwLpIrQL+14/xnsqWUAYYpQbWuZI4XTRJc7oW1C70xUd7Tx0f1K8MPiOOfJNd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwP93R1AMTKqPpSfJ2bQscFRX6LXcdbKl6jNs9Nzw5X1PCIAp
	eMsCcRK987bPMQJFoHgh6VMl0XUE0vq+If68PAaf5w/XIveDuoAVLJYAHyzj8oX0EpkFAijGT9P
	bwW1xb5E=
X-Gm-Gg: ASbGnct4+RfIaIqOOgej6B4gt5QgXFQbvRv/yJ1dJ3OjBTyhrRuCT3DvYIrPsCDhV4w
	jJPB3JPdF/a01B88PoWkL35f6EhTjEab2hCjLThxLm2sE5FHhLc2WnBMFr2dmxFwShg8kgFGnU/
	FvUmmhX1jT35U4UTBb674eBeFBYKLhKiIaqLSkcHlMayJUDCJBCF/APPTwXwWI5fm8/F6KDc4s5
	YWEAgqoJYXlzn/6l/lnVeUHS8XUhHa1xvT2M67ox8IgPLrBRkWy1OLTL4bD/23IvJ3UcEPOYzr+
	kwWo7g3Sx4lMLoy4JSgufU8qksj/VRwhivGTscM89vXMdzotY9TMtTN/VVpwGLllyMc=
X-Google-Smtp-Source: AGHT+IH73sFPX2zDYfqi2GACrqKQGK85NM1X0g9SuDONa61gyLCjlz/mTGneeN6QucqRHBKm7Tn9XQ==
X-Received: by 2002:a05:6000:4702:b0:3a4:f7e3:c63c with SMTP id ffacd0b85a97d-3a571894b7bmr9067251f8f.0.1750088033001;
        Mon, 16 Jun 2025 08:33:53 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a5407csm11533107f8f.12.2025.06.16.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:33:52 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:33:49 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 6/7] eth: ice: migrate to new RXFH callbacks
Message-ID: <aFA5XYpZgBg8HbWD@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-7-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:06AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> I'm deleting all the boilerplate kdoc from the affected functions.
> It is somewhere between pointless and incorrect, just a burden for
> people refactoring the code.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 59 ++++++--------------
>  1 file changed, 18 insertions(+), 41 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

