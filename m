Return-Path: <netdev+bounces-189778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C330CAB3AB2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DC317C786
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49644227EA7;
	Mon, 12 May 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLxzjMkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0681E5205;
	Mon, 12 May 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060395; cv=none; b=e9IU9dR0+EAgPSiS4Z7a5dR/bwALAYWHqgZxMLnJVYPbbyNBqDqewQMRxSY1v9CCLehnYGjINzJK1cC72tVT4SDbRoyq7s9pVWmGb4oZeP84ePeW5Fyiuavv/eJ9HVE+3VPV+MHt5eL8w42cGA+otM9MX34Wm7PkkFvBMCl+pHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060395; c=relaxed/simple;
	bh=qDIgZBXylcWvM+XU4heHnv80NDfAMxTLhLVoh8ihzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz9ANwwYF4QKrk4e8t+1OsbwmoR71KzxUzSAqCm7SD1cNRJfxv72QAm7JsadTJ3eTar7R4DqzjL0j+OCMlhUG87p5pdJI2F/4Wia/gmiL6L3w3ysWJkEf0QIYyaHKSsAjjWnxIhNUj3qdAlo5DzQdCZb1SzRRYOT2oLsX2DjUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLxzjMkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21363C4CEE7;
	Mon, 12 May 2025 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747060394;
	bh=qDIgZBXylcWvM+XU4heHnv80NDfAMxTLhLVoh8ihzho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLxzjMkArd7nEwe6mVwkWibR0BrKCZ9hfalM2bHdQJK02U4t+Bok+aGoZkTjQrFG1
	 03ilWlVl4stxXxy07K1iSfePOkdc5/9K5R741CJxyeH2WVm427w1R5fYSH9YnwOL0K
	 Ba/0dQVq/WKRJ+RVOtiezCE24c8OSIaoQKPelufePD/DWxWeE6dZKk3VAQxT7VZJpD
	 e2BcBMuUArjN5zxjwcy1HLELq6RK4Za/lr2ywy2fhUzRHbY4ciXZm/Ou406DF9D8gK
	 FK6XptNlC5NbssU0tRJgfFTSSsvy6D44VKsi5V0whi+hLdnrKDzktpDdu9r6WxBBT7
	 iAjk0MMRKpekA==
Date: Mon, 12 May 2025 15:33:09 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/5] eth: fbnic: Accept minimum anti-rollback
 version from firmware
Message-ID: <20250512143309.GL3339421@horms.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-3-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510002851.3247880-3-lee@trager.us>

On Fri, May 09, 2025 at 05:21:14PM -0700, Lee Trager wrote:
> fbnic supports applying firmware which may not be rolled back. This is
> implemented in firmware however it is useful for the driver to know the
> minimum supported firmware version. This will enable the driver validate
> new firmware before it is sent to the NIC. If it is too old the driver can
> provide a clear message that the version is too old.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


