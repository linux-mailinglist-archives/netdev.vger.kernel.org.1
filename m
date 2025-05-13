Return-Path: <netdev+bounces-190176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6778AB574B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FCB3AA1EF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C81A2381;
	Tue, 13 May 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCgofRGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1825634
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146980; cv=none; b=cjCjR3UQ5WLiXh8iBAnwLv7wP/EFNbVBWUH51b1ee4BDF6wqWmXnzuePd88K/waMsY0AlCWqhYp0P9+cGsCVWrnCou8QMqYXI+n1Ey7wRSOkP8GAxf+aDawO8IY2ZvDot2Lhbi1zY+fz+C45Ha2+c7EXT/X9QFtNZZL200ftbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146980; c=relaxed/simple;
	bh=tSPafprbd19d+77BeND/YIw+GAyqC5lHPBMsLo+NYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8ju67ihQs+GPPx/TLlUAxBrKeBNgW2BXl4W0gIyOQ+C3HYP8EiNb4Q3rFJO/+/d3Z35c1sEejDUE/6ajdSfUUXLdfHDC2GrG3Cj21kUSmZ3/tCXjOXwNotEdBh0KobSpET9Dkz0+BSe3YukH9KMqGFYqFGddypzyeGsrsRzV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCgofRGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E504BC4CEE4;
	Tue, 13 May 2025 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747146978;
	bh=tSPafprbd19d+77BeND/YIw+GAyqC5lHPBMsLo+NYAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCgofRGCq5KqCl6BNlZ/JFoaiu9VqwWASq9woMh+A5tXpZD074WOVWA5a6IE30DwA
	 9IZkaoBzt+cbqULREMHNzbFcVnBWBcQcLRF1EusHByJJYK3vbzz5Ii8iTyYoo3bXZU
	 0TLqYpSAIdV71TRLK3SG31YjEH1sDvsWgHpMtgu/YYS2gST92/hNzA983ea2qFty4Y
	 ywyZIDsf/wIiNBAwnqXLojVcpzQEgAobFJzJvyPIykalHvPzkeAw4myCum7mI5/p0M
	 UQkxiqnWzCNXV4i8pSxyf7MtwCwoSvY0lqPwpaIT2aZ2saqZQU1gBQ6IpGHYKtdN5Q
	 ++sYiFkhIORvA==
Date: Tue, 13 May 2025 07:36:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Gustavo Padovan <gus@collabora.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>, hch <hch@lst.de>, axboe
 <axboe@fb.com>, chaitanyak <chaitanyak@nvidia.com>, davem
 <davem@davemloft.net>, "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin
 <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>, ogerlitz
 <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>, borisp
 <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>, mgurtovoy
 <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>, edumazet
 <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250513073617.3a711fc5@kernel.org>
In-Reply-To: <253a57gzn1g.fsf@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
	<20250505134334.28389275@kernel.org>
	<aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
	<20250505155130.6e588cdf@kernel.org>
	<253a57gzn1g.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 15:56:59 +0300 Aurelien Aptel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > Thanks, so we have two "yes" votes. Let's give it a week and if there
> > are no vetoes / nacks we can start.. chasing TCP maintainers for an ack?  
> 
> Sounds good. Do you have anyone in mind?

Eric D, ideally. An ack on patch 1 would go a long way.

