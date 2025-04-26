Return-Path: <netdev+bounces-186204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A7A9D70F
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B609C1DD0
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243C1DF723;
	Sat, 26 Apr 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHgYGYuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9921898FB
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745631836; cv=none; b=pVNOOxVXQubsawVSaUdler+VkUKUtR/aznvTvFeW1cQ6/sZRI0uvMaW7vCp7X1xI8eL4UrkbubA/5lRWmj1WNznWOGCmSmw4f3iBZPH5WO9vAGpQ7s+feSxomvK6XxCKKNMfgozw9+k8hyHJEAq2KJ8f7o6EDz+RXXiIRdRgb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745631836; c=relaxed/simple;
	bh=N+gMMOk20h/SQws4Z9eCM/NAONuk1K7qTVF+eqzfn0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxIr4G9E4l/yZ5V/hCp7jkge0xDkjYDmv9aYOv+bCdL29ZC44N8uBfmfeYMjJHCsD2rD1m85hZYRtWrkf7MGLSBFzQXjkN78LuwGAV4oVkNyZ1zs3NbdL8T7uqHxUqu2uhVPiYyshXIrSvTKkBYwJvPbUFpSKk2xNYhjTHZxSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHgYGYuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EF9C4CEE4;
	Sat, 26 Apr 2025 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745631835;
	bh=N+gMMOk20h/SQws4Z9eCM/NAONuk1K7qTVF+eqzfn0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHgYGYuQUxzNcDPjCc90TXXEKorhEZUvRZTuvGfkDyQOWc2njlLHDk3pPyD0mz10o
	 1YOERP2bOaL3Ir5Hvym22VDuImt8D/b1HDHN7125+Hx4RsxORgbYG/741qR8mu25es
	 B0+L2PYP2PtX26ExISo9DKP7MjMrqFKKdNAPrEaDjzVdwhEUVpB3yVnuQJGlWfyG1q
	 jTN790LYs5M3l+04m16s0Z0WRvsD2zwXYIUgQ4WWBw1+pozWObXRQPIV7hUwthQvg8
	 RA16gVH/wlNHQhTaGtnDleXAplSEfOcMYqF8d9MtrXa67Bwz6qnMUqLyp/gB4lpsgg
	 JvyWJllQ+k2bQ==
Date: Fri, 25 Apr 2025 18:43:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] io_uring/zcrx: selftests: add test case
 for rss ctx
Message-ID: <20250425184354.3d863653@kernel.org>
In-Reply-To: <fe560d8d-a331-48ab-a450-5a43bf76be67@davidwei.uk>
References: <20250425022049.3474590-1-dw@davidwei.uk>
	<20250425022049.3474590-4-dw@davidwei.uk>
	<aAwSyL-N9g5p1z9o@LQ3V64L9R2>
	<fe560d8d-a331-48ab-a450-5a43bf76be67@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:38:16 -0700 David Wei wrote:
> > I wonder if perhaps future cleanup work might use rand_port from
> > lib.py instead of hardcoding 9999 ?  
> 
> SG, I'll tackle this as a follow up.

Yes, please..

