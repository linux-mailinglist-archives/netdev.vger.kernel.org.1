Return-Path: <netdev+bounces-128356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A99791CD
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474B02843EF
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A791D015A;
	Sat, 14 Sep 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXNdi+dW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DC4C92;
	Sat, 14 Sep 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726327997; cv=none; b=HZoUBKxK0kh9SLc9rft7AhPd/WjC6GYQwIp66gs7EK9QpaB7D8Gsp6KNWRdVbM/BHOngJoeLVSjELN4kreI+tncWbbMd9VERRoPP4e3VJS/udguJTzI4z0BZmSB3z4V+unHytdQLCr4LQiZjS88+2MaJtY3ZoZXn2d7bv4b3F3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726327997; c=relaxed/simple;
	bh=irG2ZvLex5ubZB79jar/ygEFO4yemcD2PPyp9Ezkvvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZpVDJygMiSUsQccl6Co83QElXDH/6V7lZcIpLwru1cIOoibK2XZU+TCm8zwms/WJZfhH5tYqs2NVmvoc9OdNwouEpJpUWU0EgeJEnY12MZCtSbdFcHJSDpQpFcwR4gTnJEeMKqezK01Z/YESe5ODfu9EmURLIyEQ7FiOkB85PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXNdi+dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464A1C4CEC0;
	Sat, 14 Sep 2024 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726327996;
	bh=irG2ZvLex5ubZB79jar/ygEFO4yemcD2PPyp9Ezkvvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXNdi+dW+AbaS2se3S2XvOZVG/5Oc+AUPphhIT1gvw7FIoqJfhYp7RVpMW3+rPL+M
	 tQAluj/s1ltg6FkefAGjMW52D5qYUyPbCWQA6FCq285b6c+QefT1zv2D7XiilxPQts
	 Fz98bLVvoEpt8ocaHVpIvfyv1BddXlZT/tBN+goejGtqtk7U7qSpoysUYZLup88URU
	 /HHr0t/ipSsKnARkYwZ9IoqXTzroYBUCHpnUPnBfQt3YVJS2EogOwz355KwF4XjN9p
	 jI75uD0PcRnThJkz3otNMctGaWNoN0jLSYviLYakmlpZUDhZA0pYCRhCvgrt7EZByc
	 IRVXvpVIvrugg==
Date: Sat, 14 Sep 2024 16:33:11 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] ice: Fix a couple NULL vs IS_ERR() bugs
Message-ID: <20240914153311.GD11774@kernel.org>
References: <7f7aeb91-8771-47b8-9275-9d9f64f947dd@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7aeb91-8771-47b8-9275-9d9f64f947dd@stanley.mountain>

On Sat, Sep 14, 2024 at 12:57:28PM +0300, Dan Carpenter wrote:
> The ice_repr_create() function returns error pointers.  It never returns
> NULL.  Fix the callers to check for IS_ERR().
> 
> Fixes: 977514fb0fa8 ("ice: create port representor for SF")
> Fixes: 415db8399d06 ("ice: make representor code generic")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


