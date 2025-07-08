Return-Path: <netdev+bounces-204740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A52AFBF1F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AAB7A8E60
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D710A1F;
	Tue,  8 Jul 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTFcHDKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1CBA36;
	Tue,  8 Jul 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933480; cv=none; b=lsK3GvTQE5JZHJBI1KPrlJZHLbbdzsxIJz9tiAk+7I1KkWkoVgydVNHT5X9IpQXLuDZDezqnYT+2FfkA8H5pT8Yxv5Bp4KFBe+S8Bqzpt+/b+vlAthbz3qyEEmHMQ0QKAY6pyZ4NrGvnEGPRAB/Ezli80yQnPkOYCY2O/zSAmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933480; c=relaxed/simple;
	bh=GarBNNY3/ohcGTjKarTo/qMjZh3kzliQIrpFHcgEDxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC8Oc1tmjwgeNHQpsuyPuG0QN9E2BcnR9d8EJmu916QBB9mNmWGCe+ujkCc9CSJNTCUyCf98tKbD6/6FgbxJONHisd6HS56VTL59zhFpAOa0EY4Rmw5/IMoatPU7QZjT+Fc7MnSmbQVaDYUYD6Zm6dbCu0mdbcS0ywET5k/y1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTFcHDKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A32AC4CEE3;
	Tue,  8 Jul 2025 00:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751933479;
	bh=GarBNNY3/ohcGTjKarTo/qMjZh3kzliQIrpFHcgEDxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oTFcHDKKi4K27tOsGM+TaD/MmdlRhC4Jt9uXvAFMUjzQgI4GiGgtyVku/10plAdw0
	 iGSV17RtLba9YlHuJOp2DaYEbciPVS69Z2VifNZ8PKnRrHJl6ybtHhHB1ubfkVztGm
	 DjYaw3TFAPlYhqBDUHUlBrMZdYo53HLb+Olix0IB+rMg2vCGekLe0/YyCkecGDTGy/
	 +s3cCKvzi31upkwVsW2XT118ttmXvutzmC4cN+YHfT1+vUgiB3/kSSd59tEeRz6CJw
	 i61ZBk9WsM/+juNinSZ8GzLD4ihyfAi+NKdP67iOd4v1o4G5sOSQwkDNwISPnjYmyB
	 Ztxsl/84ZiS9A==
Date: Mon, 7 Jul 2025 17:11:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250707171118.55fc88cc@kernel.org>
In-Reply-To: <20250705145031.140571-1-aha310510@gmail.com>
References: <20250705145031.140571-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Jul 2025 23:50:31 +0900 Jeongjun Park wrote:
> ABBA deadlock occurs in the following scenario:
> 
>        CPU0                           CPU1
>        ----                           ----
>   n_vclocks_store()
>     lock(&ptp->n_vclocks_mux) [1]
>                                      pc_clock_adjtime()
>                                        lock(&clk->rwsem) [2]
>                                        ...
>                                        ptp_clock_freerun()
>                                          ptp_vclock_in_use()
>                                            lock(&ptp->n_vclocks_mux) [3]
>     ptp_clock_unregister()
>       posix_clock_unregister()
>         lock(&clk->rwsem) [4]
> 
> To solve this with minimal patches, we should change ptp_clock_freerun()
> to briefly release the read lock before calling ptp_vclock_in_use() and
> then re-lock it when we're done.

Dropping locks randomly is very rarely the correct fix.

Either way - you forgot to CC Vladimir, again.
-- 
pw-bot: cr

