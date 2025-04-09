Return-Path: <netdev+bounces-180878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1782A82C8E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7E019E77A0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7712E26FDBA;
	Wed,  9 Apr 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8oSJIx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFEC26FD88;
	Wed,  9 Apr 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216465; cv=none; b=BlkvQxSihgp8QzsoxZ1ChZ2PE35+P9YpcOFjFAt8GWshyVE0Tk4jWET9xVchHbo4fCMCBDoOX0kBlZk6UH6OkjSp7YgDKtUGYN7jnRtJGTz5JoHsPRo5T5dYgMF4QCUdjcCvzG95KwUa5O/6wh9nqOw7PgQJWx/RtjK7kpv8pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216465; c=relaxed/simple;
	bh=KUSOrC3kQlzRFWiHQEBlZK0RJi5JxZP1XqiNKlYYsz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRq7vEtHV8UwiF+igTH+UwBXUecWFLTEFEKK5uGQFqZL51RvOIATXrFc2KDOYRw0XU8493O3S+21Gt4HYyDPs499+VJmxNADQdpF7intlEOwR3//XYEjzWvcKxtji6v13NyRSbFKaCcFLwSkYWxRb1ofuahKAb+Db8uuiEBrHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8oSJIx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9FCC4CEE8;
	Wed,  9 Apr 2025 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744216464;
	bh=KUSOrC3kQlzRFWiHQEBlZK0RJi5JxZP1XqiNKlYYsz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8oSJIx1C4XXsWMenVr/IMUa8Ef7s9ZakT7azWCRPE23fdpyz3ZEEThRlIiKch2bc
	 O6TnZZwbGbeGxe1HDSdYOvQzEwwQOtE202uE8TtexpEXXpgWetBi6kDbbCc4mqErEE
	 N8ThmgZo8xpg59LF0XZe0wCiISxixEXzAaJStS9Ph9Dms/LYZOAo6YggbQM7tv2ojl
	 cSbnqiFldjS3wVK4D/ZcIICl9zYJg6wqlUZiPHKj0OOJRBJZ2wwCKUxI28PIFpwy6K
	 atMrY/3KzVQZqGokeSeiP2hlm1m4TnfT1IDOrcCaHSYPHagdgIfPi447vWL8iSnek1
	 huT2zzsMpOqDA==
Date: Wed, 9 Apr 2025 17:34:20 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 3/6] pds_core: handle unsupported
 PDS_CORE_CMD_FW_CONTROL result
Message-ID: <20250409163420.GL395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-4-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:10PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
> the driver might at the least print garbage and at the worst
> crash when the user runs the "devlink dev info" devlink command.
> 
> This happens because the stack variable fw_list is not 0
> initialized which results in fw_list.num_fw_slots being a
> garbage value from the stack.  Then the driver tries to access
> fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
> of the array.
> 
> Fix this by initializing the fw_list and adding an ARRAY_SIZE
> limiter to the loop, and by not failing completely if the
> devcmd fails because other useful information is printed via
> devlink dev info even if the devcmd fails.

Hi Brett, and Shannon,

It looks like the ARRAY_SIZE limiter on the loop exists since
commit 8c817eb26230 ("pds_core: limit loop over fw name list").
And, if so, I think the patch description should be reworked a bit.

> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

...

