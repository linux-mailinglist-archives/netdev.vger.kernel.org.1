Return-Path: <netdev+bounces-244353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09243CB55FF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536EC301226D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4A2F7AA8;
	Thu, 11 Dec 2025 09:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852826463A
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445930; cv=none; b=hnDd91cXCm3tmjtdNsN1sO8VlFe7cg5pZxVpmmJ8Dquuy/NCX0EuJ1o5rEwZOly5NVr17+hQVjOQ7pUKz0Ei8ImwfCWCWZTtnVZn9UVgPNqEqB7aWQbpRHgaCIHNXIssy1TpGrxeHhbrFGKhGmW79s/DB/vZH3WqJaBA7Ev/2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445930; c=relaxed/simple;
	bh=T1ruYTjDIKH4uf4c3OeGjKeFVLGzUkkycJdI+Bs9Ps8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PFsHU/hXDiGMMKCM9zPih7Lrf+F2FCOjBWG+ogLGGX8zXLqpXhdqHDuY/reYqBvadGJ6nT3OxWGhINfvQY2dqXsMFzKYVHSFFYcaTszWKW7OMMuF3is/t629vF8STHv8oEx2OdnvmUeXOqbKrmsa+xHSnCglAwqPC9cEJap/sUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c705ffd76fso766648a34.3
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 01:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765445926; x=1766050726;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+mpfX/GqwM7iMoSZAu/2HhyHi1mmzCzEgV+g1dIe58=;
        b=HCRQBDdXOTV2ubNnpfcSYrH5Q1rZDTRz9HjQffYK6ZlUOz581LUrKog8zv8puYjzS4
         zu9W+tE43Xs0yaMd+zKPbRP4Eiga4kNBvC7/R5cctoMW6qHKnDR7ExvmlXlabpo58Vj8
         Fs4CnjAyCBf892I0wYC/c+IQENasCqEai+i5ulZZkCOwMLGjimNda9Xp27rJqPtMHmIE
         8Cw0qIBCQGa/PtVZUEXU12hHK5jeu+HSlkhEty/3pYipDwb2A6tk5e5fGY7840C4PzF8
         dZCRbDDPoNHmbOYszYoUyyaY7ZAfnQwhLDvRwS2YCfjRgCoJaJ+B62nODCY64oNW/GcB
         kOmw==
X-Forwarded-Encrypted: i=1; AJvYcCVWdis9kugOGizOYC1mWfYyXM5vgmfbFuuRdKWG4y/BqysUqXs8wyz/Im7o2pAtxHUiBjt9Wok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyPO0EYeHJBQH7UII3j6oEK53QUNWLHJRWZfNQybeoz+gY+Xw
	yNaQe5h3ZJuV4Pyfqq1ZX8tu21FjtLv3hiz1Onu2RWuMIxeWwLOMBIBy4rrISt3vvDJfClGF1Ot
	XxW5q6b49tyZWUq/JiiXuKDr4odM+air4nnmsc2zHQJOGKXHdAi7Gjb9uJEw=
X-Google-Smtp-Source: AGHT+IE4v7pI3kh0GcRzOruAMEQD3Q/8X9uHJR1zPeWxkdyQkejtQqO5OeQRJuDIcQLaU+0yfTQzqJLfjV3IwQYHvGMFPJ9aV54e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2207:b0:65b:2869:c616 with SMTP id
 006d021491bc7-65b2ac078bfmr3017349eaf.33.1765445926376; Thu, 11 Dec 2025
 01:38:46 -0800 (PST)
Date: Thu, 11 Dec 2025 01:38:46 -0800
In-Reply-To: <pyaaf6vhfvkab4rpsgkojguixnp5vdxgzle6i6p3shuxgzwwaw@rdwgw47rgvzb>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a9126.a70a0220.33cd7b.002d.GAE@google.com>
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using list_del_init_rcu()
From: syzbot <syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com>
To: jiri@resnulli.us
Cc: dharanitharan725@gmail.com, horms@kernel.org, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Wed, Dec 10, 2025 at 01:51:39PM +0100, horms@kernel.org wrote:
>>On Wed, Dec 10, 2025 at 05:31:05AM +0000, Dharanitharan R wrote:
>>> In __team_queue_override_port_del(), repeated deletion of the same port
>>> using list_del_rcu() could corrupt the RCU-protected qom_list. This
>>> happens if the function is called multiple times on the same port, for
>>> example during port removal or team reconfiguration.
>>> 
>>> This patch replaces list_del_rcu() with list_del_init_rcu() to:
>>> 
>>>   - Ensure safe repeated deletion of the same port
>>>   - Keep the RCU list consistent
>>>   - Avoid potential use-after-free and list corruption issues
>>> 
>>> Testing:
>>>   - Syzbot-reported crash is eliminated in testing.
>>>   - Kernel builds and runs cleanly
>>> 
>>> Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")
>>> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
>>> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
>>
>>Thanks for addressing my review of v1.
>>The commit message looks much better to me.
>>
>>However, I am unable to find the cited commit in net.
>>
>>And I am still curious about the cause: are you sure it is repeated deletion?
>
> It looks like it is. But I believe we need to fix the root cause, why
> the list_del is called twice and don't blindly take AI made fix with AI
> made patch description :O
>
> I actually think that following path might the be problematic one:
> 1) Port is enabled, queue_id != 0, in qom_list
> 2) Port gets disabled
> 	-> team_port_disable()
>         -> team_queue_override_port_del()
>         -> del (removed from list)
> 3) Port is disabled, queue_id != 0, not in any list
> 4) Priority changes
>         -> team_queue_override_port_prio_changed()
> 	-> checks: port disabled && queue_id != 0
>         -> calls del - hits the BUG as it is removed already
>
> Will test the fix and submit shortly.
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 4d5c9ae8f221..c08a5c1bd6e4 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -878,7 +878,7 @@ static void __team_queue_override_enabled_check(struct team *team)
>  static void team_queue_override_port_prio_changed(struct team *team,
>  						  struct team_port *port)
>  {
> -	if (!port->queue_id || team_port_enabled(port))
> +	if (!port->queue_id || !team_port_enabled(port))
>  		return;
>  	__team_queue_override_port_del(team, port);
>  	__team_queue_override_port_add(team, port);

