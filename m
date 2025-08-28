Return-Path: <netdev+bounces-217970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D194BB3AA90
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DF4E3319
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC230DD30;
	Thu, 28 Aug 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FplN2nLi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC75BA4A;
	Thu, 28 Aug 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407987; cv=none; b=P1HNlVKjjI7PUoT9iKe3+gxYmbfLzSvm35eK4dddvLp3vD8Rkys8ad3FJ1AWcu8+WHeH5o/4iqlqqJx+/kCXn9mOoNN8HInADIEuPFG0R3YgcoMVUIewzoLLUpypUTF/STz6RQoGseeO08rTkPUqKZ2/4QA5zF7je5Ox8Yf2rXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407987; c=relaxed/simple;
	bh=mgFTh1FH1GyIoU4P8h+8CxVEptEUOOB2qHdxUqZDiSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXj/C6Uu7vy1L8mO3ezgBX9etL5rRwXp4Wal+oyDkZOap7J7UO4+RXbsZySMqxyK0xhfqOcU1wqsLQkYpyqbyQ8heMpssQNG+AcTFiwPb7uUzK02G2X2C3fSoIzZA7EbVzMIb55+hEYJa9VKmVMW7UYTwf07CE+gl/vc3mE0JSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FplN2nLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A090FC4CEEB;
	Thu, 28 Aug 2025 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756407986;
	bh=mgFTh1FH1GyIoU4P8h+8CxVEptEUOOB2qHdxUqZDiSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FplN2nLixgEJaJUR+NK8nQOW8mdcu+b9xHYDVh05pYSxU4vSCGDsXgNRyPUkl0wyr
	 6rlxb0UN4xlForprwmdjSzf2sEKOLsVErXvLya+LmPJasevW6WDsAjAeD19n1JOo/a
	 vPhpV9S/bjlPAnbhuebDEmtu5w+GAK/m3pb9k2KFKwAg4RNzsIPnlodoZuakL2Q+St
	 osViYjpSK8s9GDQZpTzA6Hjfatb8iyljm2KDex2G4pLLsor6cZz18alyg321iVi6m8
	 pxoHp8JSIrVBSx8TWjVSeWHBgU9hKV2q2KUQVaZgFww7xAlsotJ+fhaL8a+WmmYCfO
	 NhranDjtx+ocA==
Date: Thu, 28 Aug 2025 20:06:22 +0100
From: Simon Horman <horms@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH v2] selftests: net: avoid memory leak
Message-ID: <20250828190622.GF31759@horms.kernel.org>
References: <20250827161230.GB10519@horms.kernel.org>
 <20250828020210.25475-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828020210.25475-1-min_halo@163.com>

On Thu, Aug 28, 2025 at 10:02:10AM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The buffer be used without free,fix it to avoid memory leak.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
> Changes in v2:
> - add the label to use instead of directly to use on each case.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


