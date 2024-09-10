Return-Path: <netdev+bounces-127036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EA973C68
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA2CB261B5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79F19F10E;
	Tue, 10 Sep 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwzwE7AR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636C19EEB4;
	Tue, 10 Sep 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982792; cv=none; b=TS+45zRSMDvJ184C3i+BZRC5K7Ev/hQ35+HpesZ1lhL9qt7PSW7olecJzyoyW4jJN2oDE5mcGTBw81RNZz9i3tOm7AjMWkRWdil5maTp5Vo+aqzh5Aemgwtl9UDq+DzlEPZo30wXxQKWWqgYt4I8ZY6p56dYiRfR+wFYjEJT6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982792; c=relaxed/simple;
	bh=7Qji1VgSA1nNCzvjzaBfc/GTNDDHZIHGUqG0ComEXUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEgHpVY5fvhTGYanhTeY2ESJNzafjuHCb3wRyPVYpllvywYKRmFOlr7FZMHxTVhC727q3C1N2zPm02WZDZ2D53QarmM2RE5Jo/eQpmquaJkz/dI2oHI6qC40lXvNpcn1yR5Eag0+jQFx0meaUs+Ny1Xp8Kz05ZACKo1VHZ5QgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwzwE7AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C2FC4CEC3;
	Tue, 10 Sep 2024 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982792;
	bh=7Qji1VgSA1nNCzvjzaBfc/GTNDDHZIHGUqG0ComEXUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwzwE7AR7Rj5io8jluUSyQppr5TgiJnw/EoIPh/nj/d5Wp7ej7ISGGbv3iRTgebJi
	 +dZwpxbGpyJNVkTthyExgXEIFTl50n6OS6mh1BLxfdvxkbohHa2VE5wRqCvMnjW8+V
	 GJX4G2zgLLCHbzhqqS+ekQqIPR77ZG05WSBuOXMXL73uR1zi8Kr+f2iQ+PvetmnnN8
	 f6ue9SCmGURZXqdVeqXp8x4thf/+66xI5G24lcoMmgmpRNETfyla/DuNhNp05gErPe
	 J3CIpMLATtzCjnCWChMHY4f1psAqm2GjKzuOwHOoHFyPVAvLNyFgV32DHOsK0V0Xl0
	 G1OfOzZz0Y4nw==
Date: Tue, 10 Sep 2024 16:39:48 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v3 08/10] net: netconsole: do not pass userdata
 up to the tail
Message-ID: <20240910153948.GG572255@kernel.org>
References: <20240910100410.2690012-1-leitao@debian.org>
 <20240910100410.2690012-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910100410.2690012-9-leitao@debian.org>

On Tue, Sep 10, 2024 at 03:04:03AM -0700, Breno Leitao wrote:
> Do not pass userdata to send_msg_fragmented, since we can get it later.
> 
> This will be more useful in the next patch, where send_msg_fragmented()
> will be split even more, and userdata is only necessary in the last
> function.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


