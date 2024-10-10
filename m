Return-Path: <netdev+bounces-134151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FB9982E7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014451C208AF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DF1BD508;
	Thu, 10 Oct 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoOGUrI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AF1BD039;
	Thu, 10 Oct 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554160; cv=none; b=I4EyX/gA1+rrPQURERWXKynMns7jT/D1nvLze7S1s8KcLGTkS03Q9+jNbfUzFZoei/5yOG5yRcYq/XLGOh4t77LZ9AuzFKJeaLpgEYdmGeIuvAOzf6WwAsZnlC6JNNiPjWbOzcx8Sd73d8iOKGQAMKj+bbd1rq3M/2V+T1yq9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554160; c=relaxed/simple;
	bh=T/HXc6fz+2YMncf6vponWtWSqH4dAt2B9V90Xi+T88o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvVbb0ZjkUeKEXarnz77x7qzlYvv3DXVgI3fdZ2fnp1TM4cW0Zzsu4w+7YyENWwHSVWPmRw3x92L2Ik/a/Ypk22O0T+QNPN87woO3CCt0aibGkzvyip+Y8W+rexCAcG6JERCVh/nXlIibb7vK16CzS0Kp7C+IDIYrEjqlMW+lVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoOGUrI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7452C4CEC5;
	Thu, 10 Oct 2024 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554159;
	bh=T/HXc6fz+2YMncf6vponWtWSqH4dAt2B9V90Xi+T88o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoOGUrI6bGAYIyuG56Vvp7bAXJ3/rdjxHJ35X8TvI1beB31gRFDN/2Z86x8xUlsyo
	 IJ9wop8VJ6zRFW7NzK0QxcbnXwpA5HO51pJL3+RrZiJrxD2YvQYy+No/CzSFqIrv+1
	 plCcegEad1YkPnFOfhwNXrgUQwdD/KRLUwLJPYvq8oDqpf9mtET1wbw+XLtL3YU0jv
	 nt0NFieDbGhmGBrbVFdued9l/eT/GOIY8r1kRO6qqcZgnR1xzZvh3k7SlTquyGvCSL
	 UOz6xIIa2IAizUP/z6cxaJnIWEI97HOilW7dqTZ8wh5mj9iKExQXfrCmWZH8jHQC9V
	 0YTdTmpT4BjTw==
Date: Thu, 10 Oct 2024 10:55:54 +0100
From: Simon Horman <horms@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, Abin Joseph <abin.joseph@amd.com>
Subject: Re: [PATCH net-next v3 2/3] net: emaclite: Replace alloc_etherdev()
 with devm_alloc_etherdev()
Message-ID: <20241010095554.GC1098236@kernel.org>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1728491303-1456171-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728491303-1456171-3-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Oct 09, 2024 at 09:58:22PM +0530, Radhey Shyam Pandey wrote:
> From: Abin Joseph <abin.joseph@amd.com>
> 
> Use device managed ethernet device allocation to simplify the error
> handling logic. No functional change.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


