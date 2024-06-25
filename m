Return-Path: <netdev+bounces-106695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD319174E4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5781F22C72
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2329135A7F;
	Tue, 25 Jun 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC4wR52L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A71DA58
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359240; cv=none; b=shb6GqNVpWWmBERIpZYWE1iKTs3A22DlFgotjPZQfxWiFnWYB2hBhmhngOqgNu0vW0cHPgV2wWqmwRXzF39S5PM3tReKtk2vHYfQ7TN5GV+59h30YGRELgVJxGJ6hWTg+HE/X91yhDqaHonaqBXs7ssvVIfEN28xxEBKrw7Q9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359240; c=relaxed/simple;
	bh=jTjakFCUwpEtm0m8XRoXcZjZjyJoddAold1BvBEAYKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euqAUuGhVM87wk/DBdXTjZLWvceDISq0Jp3GElfH5JGAUnop9zk83LFcuxjrvzGmKblwpqtzbf9MVjXZotDEkRjTAo0TF1KOouinUHdRLIQHIZozTCUqQphY5GNEtrl7xOSo2IE1fTRKJt8XzvMYok49Bd0VD0BkqyBu5OAnFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC4wR52L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A97BC32781;
	Tue, 25 Jun 2024 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719359240;
	bh=jTjakFCUwpEtm0m8XRoXcZjZjyJoddAold1BvBEAYKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uC4wR52LK8rZTrHSfFBmimH8EOisQ4uBO5DKM57QMmfiY8vLokzdvKS/yVacH/MzA
	 LFMrPwacn56GdnILtzZzvTVaV5phxWKbdQF8SZMbkWI4vF0aUAErABSXiISSvZRB+0
	 SdSlQggWT4JNxETt7KZSSDVG8jdljAG+ZO34wa+nNoiSE/viOZqUXBdvEePPc0Dg7M
	 UsSBTFpduZ9ywhv687wVIe8buIZPQW7MsH60Y4xONrs5Ed28mifYjv1o4mfB5ek70m
	 SzVsH6mQrAc46Hn3Q0P4rKGcwZixOmnPGhThwztL3U8p8kFyyxoNqrWAGHJnkSLCc2
	 F9S0merJejzFQ==
Date: Tue, 25 Jun 2024 16:47:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH,net-next,v2][resend] virtio_net: Remove
 u64_stats_update_begin()/end() for stats fetch
Message-ID: <20240625164719.513f65e4@kernel.org>
In-Reply-To: <20240625013407.25436-1-lirongqing@baidu.com>
References: <20240625013407.25436-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 09:34:07 +0800 Li RongQing wrote:
> This place is fetching the stats, u64_stats_update_begin()/end()
> should not be used, and the fetcher of stats is in the same context
> as the updater of the stats, so don't need any protection
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied, thanks!

