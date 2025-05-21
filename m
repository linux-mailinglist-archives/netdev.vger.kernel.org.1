Return-Path: <netdev+bounces-192410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81584ABFC96
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F588C6031
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B711622CBF8;
	Wed, 21 May 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeSprZcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C7433CB
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850426; cv=none; b=Jh2ceMQi2b2dX5QPRCH1Foyt+o4l0yiBZRIrE6I9nMUIFmJuSg4H4XqTxsYKr7TVbdPPdDnjzezRzvWGvFfO/JE8rD8kY43+rZYGAYuYx16mXT/nseIQV5/pbpgjFmA/14fQP8GnCyibG0sgrzVaTdoaAf5TovKY9NQAWEWcmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850426; c=relaxed/simple;
	bh=YP0Q3qB9OeBt0ANmhPwR5vgTS7qlvWVS+nx/jqgd3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXYrP42JSAoC/MML5mvSdtv4pYMM3gDob2A+pvhaENlzvnuAOCOIwRoLe2KbCi0nDMXKV9xvxbHZ5ooOXhmhy9JJRmXYRgY4HtGdAEPoDCu2ymmkf9NR3QPmAx2wQIehYd3cc6XT/4p6uMUZm9wQ/izvSr9bn4uOI/tt9jf/1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeSprZcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFABC4CEE4;
	Wed, 21 May 2025 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747850426;
	bh=YP0Q3qB9OeBt0ANmhPwR5vgTS7qlvWVS+nx/jqgd3Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UeSprZcwjP08Z1xwI0l1nA1BF2HdvgTv/izLDie3mLy3phcA/hBszYGVprJ5wpz8a
	 7uYUEvgHtCcOLhKNor4SDf37ERIryQ2RzyZJeu5db8BlWCV/Ftyc78uwgQpLcZHZgi
	 WwiJXT2kLWdNZCOp0oaJbRTAquNw5q3+uum160vEDPsSq44cAgLHpDCcRw05RrxA15
	 0zPA9va3ACfjzj747a4ZKlOOFGP+6HK2g6o8p9sKm1A5KXJ4feT4sFWi8d/9zSZbLe
	 QDfKqUy6ArSEI8vKmJRIGt7w1hjGtIWhzp/0zIPK94NmTtVgKFvsVWWZaH7qhmRyTK
	 esVRGiDOUD1Jw==
Date: Wed, 21 May 2025 11:00:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Network Development <netdev@vger.kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Hillf Danton <hdanton@sina.com>, Stanislav Fomichev
 <stfomichev@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
Message-ID: <20250521110024.64f5e422@kernel.org>
In-Reply-To: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
References: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 22:38:55 +0900 Tetsuo Handa wrote:
> syzbot is reporting locking order problem between wiphy and team.
> As per Jiri Pirko's comment, let's check whether all callers are
> already holding rtnl lock. This patch will help simplifying locking
> dependency if all callers are already holding rtnl lock.
> 
> Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
> Suggested-by: Jiri Pirko <jiri@resnulli.us>

I don't think Jiri suggested it, he provided a review and asked
questions. Suggest means he is the proponent of the patch.
And as he pointed out this patch promptly generates all sort 
of locking warnings, please test this properly.

