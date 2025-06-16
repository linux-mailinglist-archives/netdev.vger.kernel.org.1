Return-Path: <netdev+bounces-198125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357DADB55A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A9016153F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D5214209;
	Mon, 16 Jun 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vk4oxjR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A620A5EA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087683; cv=none; b=E5taBWPFzpxHOrOx0cclOYmMncsRlXppJ8Q+R/MiaBLDO3lSO4lsKEPbbFLdvJPy9Z4aeH9i7UqrZksdRa5mldTBo+0v1VAeat8sDkU2+zSMqcaeqUfs8OOHMdB2EFyfonDiM7Gz0KOAUaxVHmEgn47e/tCdbQCv3FxzD/RjeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087683; c=relaxed/simple;
	bh=ZyleyOCluX3ICPpolozsSKMAqymTS5khx0/xk0Q4ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGaSSY4h8nc0GKUL1rNeJZ8m9NZW9C1GvmZvmtOHtNRYTxt9Djfk6LUtryXfmB3CqPdC84GbJ5BJhJRcck6oWOfAVHwZ3S+dwBg9cqa7go3q7WKzXdWC5S2ICE6f5FgnuLUWONtOINr3MpQzOu1ZkbrTDbIFyQUbpVsHbn2lVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vk4oxjR3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d54214adso36305145e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087680; x=1750692480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EywZQByriqxyaKItN5w0ENYjV/SBb1jnJW8uecqoy3g=;
        b=vk4oxjR3LzlSafyuqxcYuoMvu9bLeDTzxQ3o4SiE/WFs0LgeOhCipT9MDNFAzp+EZP
         +jEl3xK7lE4//cbJjAN4yVvioyRjTzfTmvUbeGqGpTlbqON7TBj4PWOdQ9z0gS3fLQE0
         RGdr5TXBvluQfZXIHbnFDq+gaLXQYPFqnNHs/t5R1QtWe/6lZjQketmw9aLnR+sh9ggA
         djuiAShx9lyAfx+TvSEDk01/vBHFOVBi187LnHCLIKDWla7VAO9FSPZtHGa7wXDHtzl3
         l6/E8iZtSlk6AyxcY6a6024V3qYz1331ANnT3zhuW/VjhqJzCesL3yVEuzCfCiFTgWjM
         tpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087680; x=1750692480;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EywZQByriqxyaKItN5w0ENYjV/SBb1jnJW8uecqoy3g=;
        b=RYPknS3OTpJpB7Q11HzHBEJjBjQVtbv4O0Q4MU8Q+DohixTi4o0nIQjxXkjMFKwoB9
         M6kGPeUM8IgT9J/YTPKhfVV7vpPz+JONzWk44TS7YUgkbwH8Q+/f0OyLrMt+5JSgzMEG
         yD3eSHxhNO4Viw1SZ/wVEA3oREVtjbd0WNiwTT+aaOXQVImGv6/dNob0NpyFDgudGqOL
         tRhghWm6oaVbtYPnHV9N0FWISl4+qMp3iQqW4eHSVlTcDpI+PXT0/EzPeUiE03C+4/zu
         /38hUdFG75W8vXd4mgo/3yTI3DfrKK4QUpIdL9blxaG6zroQooLuex1R0rb13kVsXb6H
         HXSw==
X-Forwarded-Encrypted: i=1; AJvYcCVG0hGCBIQYphVMVi5A0rEfPQIai/8vhK3bJACJ5PxbFAFTeQZEMVoAEC08uIC2kaIp9u9LyaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhjeh4+9nL9LX4ENh1p0Dud0Jydrl2n2uU3wx+x5k2wH+fXNpx
	VL1lCWXgbgVccHkQhvn/8jkRN3otLNJWEJlHxsYClmnAOYmGt1fNJUi7v2RtuTMwAH8=
X-Gm-Gg: ASbGnct7ZI73ucusUR2pzaJzXgTK6galHkTp/uBvxXST+kkcI46Rz7N1fhboL4f7NZf
	bOAfn30+HSWItInxpU7FagBmWrYNTEvytglUstdZ7pjwTeDxcR3eRHuoeoHcVthJMR8+HX8B062
	n4eG4c1BnnBaB/ExRLB7TQbVUtcquW1MG+2kEDOuZ2Hb3/PpWwXQ9GPNGj6+resBTdZmz6BKLXv
	r9W/m4CD4peAZPOf6tQ1HyP/MpGlibYYiCYeiCTMUCSF9RS7iZfXa8ufo8OhKGf4nhhiLjqa1zi
	y6ZMIoJEDCUsqLvSUZdTvFqQo8Cgr021vfTTwpr8GKqoowDJga4devjfPWO+nxj61Hs=
X-Google-Smtp-Source: AGHT+IFQ94WybWoeIXZsZB8kvlpjrnVoEs1KWw2ZohRTy2I4x2HUzm4lT9NO6WRU8shndKD74kYMXg==
X-Received: by 2002:a05:600c:1d01:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-4533caa6bb6mr91893515e9.16.1750087680082;
        Mon, 16 Jun 2025 08:28:00 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6ee12sm11379533f8f.31.2025.06.16.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:27:59 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:27:56 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 4/7] eth: fm10k: migrate to new RXFH callbacks
Message-ID: <aFA3_EErsL_9lLlv@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-5-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:04AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> .get callback moves out of the switch and set_rxnfc disappears
> as ETHTOOL_SRXFH as the only functionality.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 34 ++++++-------------
>  1 file changed, 10 insertions(+), 24 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

