Return-Path: <netdev+bounces-82818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B078D88FDE7
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D771C21BF3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592A7D06B;
	Thu, 28 Mar 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+KV14pL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD759B73
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624716; cv=none; b=Ab3xVsHsRwocN1vKj15zZn91Dh2a+inI0twWM6Fkx8SG1Mo3j3WqfX3sWee7IvNXMoMM3TsRwmH7qudvcW9bCSdmJDlg2q9tRs8fe0fJ8xGtPe7B1kohuUmHbbyBfmh1xApqDlyXvNEwA0oWjMx+gLqBs28lOOgR3oh53kMZshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624716; c=relaxed/simple;
	bh=5PauIIVHMNXgeavnW7nooR7T8Bim4kUHPz13+xi2Sx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYJdwpmZ0uHDtcrMYHIgYoEtA1SVWliqVdpeKCdkv5EJOXIyfG3MhAMzx1zlwmRdh7RjETvLgYmmv3oLRzuqZlg3qhSCEl6XMTovn38+O1kuU/b6+bbWe9qk0SdzbZGpkhEmrfZryjjFmezqHcPOcqXkePmy6or1Rqms7+N9lQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+KV14pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED0C433C7;
	Thu, 28 Mar 2024 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624715;
	bh=5PauIIVHMNXgeavnW7nooR7T8Bim4kUHPz13+xi2Sx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+KV14pLBJcwkIkICG7Y5ASfJ3FP3bZCsYyexq17sp+l1RYAMoUx1IRlgnM/L/efx
	 nd8cPeexxDICux19LHatRzmSoWLET2yL+CyxaMzCwwr7it9rLxftyzVnWtwKqD93LP
	 Ef2Mr0YzWRepPUUel28D1GMxpL0uoqGeRR7ji16wf25h27IWKpA7FaTTUga+ZGZGNR
	 0gOgvyZOcc5VD1hj+30o9fAlxHL/Nq0V2/eBo9+2C5HHzRZZeXyriiP/I2w3HYq1W0
	 cLwaKLp+PP1dOtHmM1SUGh1evsKmtE4WcF4oZcWd5tla3JyzaHR3JAwfnBgQcq0G58
	 8k1xRiGxGqz1g==
Date: Thu, 28 Mar 2024 11:18:31 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>, Aya Levin <ayal@nvidia.com>
Subject: Re: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop counter
 on the representor
Message-ID: <20240328111831.GA403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-6-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:19AM +0200, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Q counters are device-level counters that track specific
> events, among which are out_of_buffer events. These events
> occur when packets are dropped due to a lack of receive
> buffer in the RX queue.
> 
> Expose the total number of out_of_buffer events on the
> VF/SF to their respective representor, using the
> "ethtool -S" under the name of "rx_vport_out_of_buffer".
> 
> The "rx_vport_out_of_buffer" equals the sum of all
> Q counters out_of_buffer values allocated on the VF/SF.

Hi Carolina and Tariq,

I am wondering if any consideration was given to making this
a generic counter. Buffer exhaustion sounds like something that
other NICs may report too.

> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Aya Levin <ayal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

...

