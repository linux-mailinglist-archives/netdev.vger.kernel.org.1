Return-Path: <netdev+bounces-66862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C228413C9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B481C235EA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C366F096;
	Mon, 29 Jan 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQnxLtDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2166F074
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558018; cv=none; b=tXHpg1iiQuDPGyDHA+6wMTyrXnxPlVAA7MoSPIYQHV5rOuwd7s5Mg+Uy8e38qS9KEyv7nbAsJizvQVSKToJHpQZ5MiUEOZGQqSaRXNOH/9s/DOVQdwbVOUkM7uRz7dJX5ty4qEoagxifiCiMinz818yN7UyCKh1WcWvEaRxV1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558018; c=relaxed/simple;
	bh=51rOF9x2s7eTWoIYqiBwy9NHfzndK0PxG9EDo+G1SCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGU0szE/gzchkRye73VKsrtP/LIQQ7+3NPH26nEAA9jbMvUebMs6inEuOSiH4XHWWabf2Q6w167JvrSqwEhqWBQpX62Wxh15nw7lJVUEdG+1LlDx+3ymUakQxQgxmkUsfhBCSE8W1NSmwrJsb4B+bQ/brrzlkLq3scf4hUIzcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQnxLtDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5B5C433C7;
	Mon, 29 Jan 2024 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558017;
	bh=51rOF9x2s7eTWoIYqiBwy9NHfzndK0PxG9EDo+G1SCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQnxLtDuVq/ujmETXMkeFsahl3PwjB9SKPSirE9QVqMdRhUSl/QoioeWMthCjnoF2
	 soqi03+eHUyDGpVvviExb7SteID9NNAvmXEqxnWgcIw5SfA7oJ5StaOX7A4QuAE9c7
	 0+F2CMAP7yqA+ydXZxh1p44IoMoeUFhiU/ViYuhVHNSzPADc7yBV+VI5yCuU1c1TJN
	 fonao+92ISy7YhB4hbdK4xKU+3ZX1HAuvphj0/OLLR9ny0YnOeWO84EwYHhtzttL04
	 kPIYIrsgQI4jwqeAxKM/yON42iCaK4c3LUG1lmTOmW0bRYhQGaAbOeFygMGbH0RnFL
	 5zNHUxlmBmyEQ==
Date: Mon, 29 Jan 2024 19:53:33 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 4/6] mlxsw: spectrum: Search for free LAD ID once
Message-ID: <20240129195333.GO401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <903f25dbfc84fe1f384d92ea7f8902a2051bb7bc.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903f25dbfc84fe1f384d92ea7f8902a2051bb7bc.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:29PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, the function mlxsw_sp_lag_index_get() is called twice - first
> as part of NETDEV_PRECHANGEUPPER event and later as part of
> NETDEV_CHANGEUPPER. This function will be changed in the next patch. To
> simplify the code, call it only once as part of NETDEV_CHANGEUPPER
> event and set an error message using 'extack' in case of failure.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


