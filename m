Return-Path: <netdev+bounces-113675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C393F871
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8132822E2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E76153836;
	Mon, 29 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N29y3ieE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48518823A9;
	Mon, 29 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264094; cv=none; b=iwiCu8U6+bs5zzEodxh+I8pfY1FEa1L0P0i/GB/8jYT5s2TjbzFZgWHa9f2UsWDLkP1bCnx0bFdRLkqQlaORzsDws7gGtiDNemzq0v5CYnrQXvh/0n2vMkNRwcF9TG7NvYqKypjKntLz7tyZoF71yB6Uf8HXHw5Jx+t+n9z9CHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264094; c=relaxed/simple;
	bh=LIEatXoPX3PPwa0B7g/+kO3jB0XVTSWzB7ZiFawj36A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQFWFa2VRxtSi9wjfP1odFWsa2UNzcDmkXmTKEOF2xTVRHFKCbs6OjGOdVSheAOvkz7R+BBqhoAcKqOhCMZK2wvIyzUFwGFTYGwPRr6KVtIjOeNYuNPbTouGIVoSE7tnlwZ9YF3irB3dqn8B4lWKL9ujkPilcGzPvKZjGm6r908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N29y3ieE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D0C4AF09;
	Mon, 29 Jul 2024 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264094;
	bh=LIEatXoPX3PPwa0B7g/+kO3jB0XVTSWzB7ZiFawj36A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N29y3ieE47UcKCQJZ8+ef4Qs8TTtwQ0huJl60tRITQ16sfSJTYZRwBg6QjZhMXhp/
	 N5dMtI5eKw83rbeVwC/yFi713cunhiPMvxVjiTrFzyiqZsjrVEU+V28Ge6yERgoSlc
	 hgYPGh5E/58Q+lEk9UqwacIkKmxjXYNla9wIM+kSl9W301fy+z1i0JmRRopCcm/hQD
	 3xzDUuZ/VWbcuAkb+pVjeWmi4/BnQXt14cI7t+FsTEEZ67QaHe67uS3/YNjhaqU9kv
	 iRqJ8d7sclX5VlNp2dp9mqqStZniVieTzlOuI6j3uYR8WtH0VkwT/Ao1HtkwO64tE4
	 KgEFIb/sHSCjA==
Date: Mon, 29 Jul 2024 07:41:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 razor@blackwall.org, agospoda@redhat.com,
 syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] net: Fix data race around dev->flags in
 netif_is_bond_master
Message-ID: <20240729074132.6edec347@kernel.org>
In-Reply-To: <20240728105429.2223-1-aha310510@gmail.com>
References: <000000000000e9f499061c6d4d7a@google.com>
	<20240728105429.2223-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 19:54:29 +0900 Jeongjun Park wrote:
> According to KCSAN report, there is a read/write race between 
> __dev_change_flags and netif_is_bond_master for dev->flags. Therefore, 
> should change to use READ_ONCE() when reading dev->flags.

That will certainly silence the warning, but doesn't prove the change
is correct.
-- 
pw-bot: cr

