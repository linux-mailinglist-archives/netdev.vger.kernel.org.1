Return-Path: <netdev+bounces-128424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE09797E6
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6BE1C206A2
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6C1C8FB5;
	Sun, 15 Sep 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5+ttdVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D1175BF
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726420832; cv=none; b=kwSvoFfFRGteth+9rUZdmI8yc8gmq1Sngppg5AZOWOfxo0CHDuuUQLQ0HGJsuv1qfbH+nrDwmDc1Dqx2mV/nPynrGoAlaEX4EiWtvjo7AnJJNOzjK0tHV/kw0ezqAx/T36xTL/iOae/wvo1dRybaa2OuT2CCQVyIPN1jP921qeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726420832; c=relaxed/simple;
	bh=JPrbItrbZJtSY14boEn2pMVTc7f80ud8AW9dKydkH3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tzb8mX5gXDg0fxjKlX8r5lkCR4r4bVm4rdeIBLdB6Zepp9mzpra3ReQMtFi0tPFOJ1KA1g6J8qyccgbbcTiDVWw12R0QUgmwZ2OAkBnhJxtu6hT8Tc453NJde5sTlBaGE3c1XfZpsY7kI2rdzlHCSRTJXMFppJEJ4X/DPo5CpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5+ttdVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC10C4CEC6;
	Sun, 15 Sep 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726420830;
	bh=JPrbItrbZJtSY14boEn2pMVTc7f80ud8AW9dKydkH3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5+ttdVFYV4nYInlJ4Tl5wLfWY0fjZjhE0YKlBJSUx0Azt/EvXHvOF8mp7X2b9LTn
	 T1y/iXpHmHqD+ssA/Zp3RVj2LPvaKOy8Sy2YIEr2QqQEoyHvv2e2iiStq6W7RIPtcQ
	 sy1Ra4f/tl4rQDiX5QFhBTYmHXiPWOR0R4ojOs8LEcjYP2lWc3eBfJi4seNLB9I4RB
	 KjTXj0kEHacbAlgYP7FKTUMC0FS/fQsUHWrR49ZWIZm4c6j9/SPLPydILgCYV+tbYo
	 yD3IXTsDNdjaQ55bys1bUasg75x8AAVtnQDjPPUkINjsf1TkLCG7vb6E4EEMwPYx3I
	 RR8HoPAbISw4A==
Date: Sun, 15 Sep 2024 19:20:26 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: <davem@davemloft.net>, <xiexiuqi@huawei.com>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: hsr: convert to use new timer API
Message-ID: <20240915192026.11587b9b@kernel.org>
In-Reply-To: <20240912033912.1019563-1-liaoyu15@huawei.com>
References: <20240912033912.1019563-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:39:12 +0800 Yu Liao wrote:
> del_timer_sync() has been renamed to timer_delete_sync(). Inconsistent
> API usage makes the code a bit confusing, so replace with the new API.
> 
> No functional changes intended

We didn't merge this patch in time for 6.12, please repost in 2 weeks
-- 
pw-bot: defer

