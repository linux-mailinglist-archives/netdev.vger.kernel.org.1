Return-Path: <netdev+bounces-92884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF88B937F
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CE01F220AF
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16317C73;
	Thu,  2 May 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRvkM+uR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681717997
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618603; cv=none; b=mWbvLFhTE9GMBT6eT8MXN21faiou/fV10Pspzdr2/9UV6eeyyffxh24siPkHRC17/5Jaqb0s0xBemq2ainflaKiDHgzjp6fbshgb/A1jrSsUCMTJN3Z+ICg3CtHcf8R9rfrCijPba9+L0aMsAgAIdM3EMGSPxCylMPP/0Y10weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618603; c=relaxed/simple;
	bh=P8hMAABtlFQeTmsU8WprlRKllUGsHGavPf2ebU3rFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WO91iUKB8x3gJAvjv+RU0ThguXcmChdm9qJEfTqNbUsMgLQJ98dwEHO52LVB9a4Doxm5oUrM1E+6gfTVQNxqA0/Oa4H7vk510brfemoYkx01GpOlTLongkbJMjQxn8kEjaVWILC68N85iVFS++HbgydLFh+WI+JBk3xFs7VhN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRvkM+uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A3EC072AA;
	Thu,  2 May 2024 02:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714618602;
	bh=P8hMAABtlFQeTmsU8WprlRKllUGsHGavPf2ebU3rFnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRvkM+uRi0975xd9p92Oupp1FsrOTbBMjUgud9G1EoB/xeNFOJj83keGmkvdtANz2
	 phj+IJM7KX4DvkB1kTWpnQksBygxlHoziREY/GEunUJ/EnViOeoy8/aTmCKla+NiuI
	 vaY60bShQRXQZfTicb3/SdajZjBlBcf5EwRjWr7ZdnOMSQwPnAAyoDhB5IqCT+rwc0
	 4CZDvDiIndpDQpS27rtSxtdw2bYhpC9mvUmxohzBLiG3HSzRrZZVJm9H6jeuoCHhlM
	 nA3pU3qV+8u1tsBHoqyBsj7mAEQOScSaGd6yzgBkrOy8YmxK2qr4kS+wlM6K4/m2Jc
	 nVd7MpYQRZp3A==
Date: Wed, 1 May 2024 19:56:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Ngai-Mint Kwan <ngai-mint.kwan@intel.com>, Mateusz
 Polchlopek <mateusz.polchlopek@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Simon Horman <horms@kernel.org>, Dawid
 Osuchowski <dawid.osuchowski@linux.intel.com>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] ice: Do not get coalesce settings while in reset
Message-ID: <20240501195641.1e606747@kernel.org>
In-Reply-To: <20240430181434.1942751-1-anthony.l.nguyen@intel.com>
References: <20240430181434.1942751-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 11:14:32 -0700 Tony Nguyen wrote:
> Getting coalesce settings while reset is in progress can cause NULL
> pointer deference bug.
> If under reset, abort get coalesce for ethtool.

Did you not add locks around reset to allow waiting instead of returning
-EBUSY to user space? I feel like we've been over this...

