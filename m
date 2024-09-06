Return-Path: <netdev+bounces-126090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF596FDC2
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CC51C2156B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87DD158A00;
	Fri,  6 Sep 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/rh9wNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E11B85DB;
	Fri,  6 Sep 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660154; cv=none; b=bglzXqUZL55bS1EF005oz+Xe/kqZrWCOKy4Zx0M1b5MyGh1aHex+hbmkus2wg9QHOq+uAl003d7HBhWmoFjdSq3nJLUMXB9sd/Y2o7GZEEzw/8ItSftYtUqNpKdJJngj4neDFpCeD3xG13SyvrjeGkOVo4buEG5fWlNlR3if9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660154; c=relaxed/simple;
	bh=WGuwnNn1p6v9mY4G4k7o8PhCCfiaToFY4ymgit/+v1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NquRUKpu+DQmEaPvDXn7eOqD8n1BGO/idtQJT6vx3tbj8k4Nm5uXa5A4aVBq5/CYtXL7rl5JYpM5lEJKB5s91xj1TAgB4xLJHysc+F1Y1E7LmOWOei7SQqB5LeoddkCLUJ2mxL03cYo4638f92TKOG+aeOuJf0JA28S1WHjYy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/rh9wNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848B6C4CEC4;
	Fri,  6 Sep 2024 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725660153;
	bh=WGuwnNn1p6v9mY4G4k7o8PhCCfiaToFY4ymgit/+v1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e/rh9wNz88GAK11h79VsQMcJb9paOgEoNmJsC2VkhXYWa0XCbXECxqrMuF4s8AGsB
	 l67uND4qfkyoUjc/88dhBgf9xhArWyoYj0qV4alJ3BBXtAgVyb7qPeHe8eYFouYQzR
	 eJFSOBRJwIyG+DO4/8RKScZkeII+GEo36Sra5zW75F4plgRwkbQuGYfY6dBWqr8gA+
	 bbb173N4emVQ7f008wJPX27pZStC3uWOuexmyYa/EKgsRfNcxhVoY/T8OCbg1PN7Ax
	 pBSgMVYS4tKI+ZP/pG0onPTz/kgJkUgJ0dsmm2GCNzLvLmesa0abAQXl70U+QXES+O
	 LaCxtoVKAsEDQ==
Date: Fri, 6 Sep 2024 15:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>, davem@davemloft.net,
 edumazet@google.com, geliang@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Message-ID: <20240906150232.31ba495c@kernel.org>
In-Reply-To: <b2272b72-d207-4393-9245-31ad7628be09@kernel.org>
References: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
	<tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
	<b2272b72-d207-4393-9245-31ad7628be09@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 20:55:20 +0200 Matthieu Baerts wrote:
> > Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> > Cc: stable@vger.kernel.org
> > Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>  
> 
> According to the doc [1], a 'Co-dev' tag is supposed to be added before
> this SoB:
> 
> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> But I'm sure that's fine without it.

To be clear, would you like us to pick this up directly for net?
Or you'll send it back to us with other MPTCP patches?

