Return-Path: <netdev+bounces-203092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B151FAF07ED
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1293AF3DC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934C1519A6;
	Wed,  2 Jul 2025 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPw7wWv7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB953A7;
	Wed,  2 Jul 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419644; cv=none; b=EssbtKVfEcv6VQC3q+12L0jOg1YtCsoURtFp/7tw5yldmiuKzTEYygIqkNaeZRUCTRfm/26yZFinOF3le2ZAsSHqZrSYfL9E4aKOct5UxQ5F8RnMDPUQBqhIhprtMGYBF73rn/8A/RzSc1SbPC4WWbeiPNd6g6RBbc+8k2kdpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419644; c=relaxed/simple;
	bh=R+1mg8IligI/moH9LFnLu6otCVRAxgcDDDleLf75u4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgisiv1CVKmLdd91xu8ch9WavLbgj1wMipjlt0tPrBDgqZjmKhdRupqAU8Pc0RzsA0kN/PHDH43kUiELc0oP1am0LCuP/f6VChfV4hwYqDBPhUIQOjR+t2w28YwDbvdY9k3qiKUORbktQT4Lj5WsNuxf1dta2FRfgy1qSMLO8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPw7wWv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF7C4CEEB;
	Wed,  2 Jul 2025 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751419643;
	bh=R+1mg8IligI/moH9LFnLu6otCVRAxgcDDDleLf75u4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VPw7wWv7o2Nf3onxmXPrIAA0nIgETrQMvQT4mX55sK+d2luvx7oDJ01xpEHijyHlC
	 hmrzkA4j3vnC/6NREzbrxZimc+Cfmk8Iy+BadiSndvUIFF0a2wmPvBEd3ypgAQ6/Eh
	 EkyN2Ph7G7qp2KGAeCOjxIt2SNMYhnYjHlYICDz3VbruL/rQSrQmnPUUVUfOpqGESj
	 37kN+xG6jD1fipyOkzkonzeeSrGl1gYgYg3AROVGbaBr36FQLiaQ/h+Xz4b6EnI5a2
	 arHBG7nwrzYGvV2F/BZhDDsfsg8LDNhAJfeOnhPk0dkyBl+hF/0CZ2pvgJbs9u/mpO
	 U8PLV+YPe4RRA==
Date: Tue, 1 Jul 2025 18:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Peter GJ. Park" <gyujoon.park@samsung.com>
Cc: pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com
Subject: Re: [PATCH net v2] net: usb: usbnet: fix use-after-free in race on
 workqueue
Message-ID: <20250701182722.1a932ed6@kernel.org>
In-Reply-To: <20250627105953.2711808-1-gyujoon.park@samsung.com>
References: <87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
	<CGME20250627105959epcas1p168bbbe460ee1f081e67723505e1f57c9@epcas1p1.samsung.com>
	<20250627105953.2711808-1-gyujoon.park@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 19:59:53 +0900 Peter GJ. Park wrote:
> When usbnet_disconnect() queued while usbnet_probe() processing,
> it results to free_netdev before kevent gets to run on workqueue,
> thus workqueue does assign_work() with referencing freeed memory address.
> 
> For graceful disconnect and to prevent use-after-free of netdev pointer,
> the fix adds canceling work and timer those are placed by usbnet_probe()

Discussion on the v1 thread is ongoing, please repost once it concludes.
-- 
pw-bot: cr

