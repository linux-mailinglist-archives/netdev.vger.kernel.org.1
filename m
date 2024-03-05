Return-Path: <netdev+bounces-77492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32953871EE9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FA1C22583
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8905A4C0;
	Tue,  5 Mar 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hrn+V+4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65E5A113
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641144; cv=none; b=Y4G1peOa7Q9fPp59+AhvcEQbWa8/3qg3CZHnfNjYaIUTXtjHmOge34EFOOCWyrHap9AqcA4bQjzX2fUEvdaQYQwCnQpz+dMekLFVZV+dK5mYFyEYDNQTx4DA0c94YdIGyCdnauQbEDPKf7UakV0kf9OVZTEpycnkrj9O8BiXvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641144; c=relaxed/simple;
	bh=tUqyXsGNEDU3ZrHwENeEwXGJKj94lgOzY+pkuprEKHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m027vn99bJDyPsUl8YTYjhirnBtrT+PjkiK/JmZXj+/Ak9Y2oc7+PDQC05FWKD/R/sOIkzdhovwjoXGvgC8/DwuRIMyWiYxQzOrETSP/cQ0b5vQf+FBV/z/CaerwSp1eYqkO/WhfTe2chySXgkrEGVB7TQtxPaNLijuksbkW9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrn+V+4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CF8C433C7;
	Tue,  5 Mar 2024 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709641142;
	bh=tUqyXsGNEDU3ZrHwENeEwXGJKj94lgOzY+pkuprEKHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hrn+V+4GJC0WghhsHE0LT69e1ZL/EwUKnuYsPbtMnk6G7wIZhZ7KkrWGX2KD/RW+a
	 xYtHiJ3qmygdZRIqUGrftQZsNt6xJvGYCrwo9iEKGV9KeXee4/TopUj0xIxajPjnxz
	 JKQM52K/IxPuYCENcltB4KUkTvcZFSmC0NOGWi4wWfLOPGfPkHaPuWeJ8yK2lxjqBX
	 WzGJHVXrJAoBMwlgSaDbSdyqvT6HWZ93dZMy3A2QbNQajMvVwdB9meOoadRC/HN68n
	 xOglQF0Buy6tRxgG/Tzhki/QVJj633HCjnLatold3tbDJIVDT231p+9IT/IVNZcN0o
	 J+GDx+OiQEUOQ==
Date: Tue, 5 Mar 2024 12:18:58 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 9/9] ice: avoid unnecessary devm_ usage
Message-ID: <20240305121858.GA2357@kernel.org>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
 <20240304212932.3412641-10-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304212932.3412641-10-anthony.l.nguyen@intel.com>

On Mon, Mar 04, 2024 at 01:29:30PM -0800, Tony Nguyen wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> 1. pcaps are free'd right after AQ routines are done, no need for
>    devm_'s
> 2. a test frame for loopback test in ethtool -t is destroyed at the end
>    of the test so we don't need devm_ here either.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

FWIIW, I did look over this patch and it looks good to me.

