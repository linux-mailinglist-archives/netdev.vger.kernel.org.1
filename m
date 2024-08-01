Return-Path: <netdev+bounces-115000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C15944E07
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92ACB2599C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC71A57DD;
	Thu,  1 Aug 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGyqpyqu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0841A57C5;
	Thu,  1 Aug 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522524; cv=none; b=Rw3b9aglAGtADdo2H52BDz07JHMvIQBBGlFw/uomnJ+Y/EuE93V6KbtPSyvsyI/ejS1tQRSqRFrcwIiKFcgMLrBg0iyKTfVcntGaB0D4zzgUbl4YY57wbYgAfoaGOyPr1fxw1a+Q0fmcZMtargrSQ4s9w86zteBZclvn6K4zEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522524; c=relaxed/simple;
	bh=VmS0vG1FU01zfGzjRCSSTdgddRkOi8SO/1hdANb0dgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrOEW7+IgBg+q7NhZuZy0/nOmHNahE6hObFa/OOKLN5XVoGoU6q/f07HyyZwsBsUjt22k+r1/TdgWOh9Z4bakf4nMxi6d0y2Uu7P/ApE5mNsyFF2MpkYg9iAF2FD6C+mbTY4AuO2ORxgCbjG6/T93ABF7RAdQefi2bQzCk9cYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGyqpyqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618DCC32786;
	Thu,  1 Aug 2024 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522523;
	bh=VmS0vG1FU01zfGzjRCSSTdgddRkOi8SO/1hdANb0dgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGyqpyquO5bYvJ/YrRDtJCMu5JuVz28wGpCfx6RRMkWTos8BypU6msEemZHzAMWEH
	 zr1sLyJzCdDx9o7BztRZEydCrj0k6s0RlmO4Hs9ekbnU1pDSwohhL0nodalkuaQ5xw
	 QxhA0peo3DewQiJQQDKiK+vaBgBDBIncV5IYyDjwIRLcWx72gPaXIinRY/I//NPN+m
	 Pdh15oNQaGjM6uEGdYxDel02KWcK9pcUaebtDLAgw6QmnCiLFr1U3c7slipVzP+ux8
	 VRhTpn+PLYL/oLT3X5f3qYYe2nQf45NWFqh5qYKNUXytUJ7GX0+hVcSdPf9XDGve00
	 CD/GrpzcwA2vg==
Date: Thu, 1 Aug 2024 07:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: fix possible deadlock in
 team_port_change_check
Message-ID: <20240801072842.69b0cc57@kernel.org>
In-Reply-To: <20240801111842.50031-1-aha310510@gmail.com>
References: <20240801111842.50031-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 20:18:42 +0900 Jeongjun Park wrote:
>  	struct team *team = port->team;
> +	bool flag = true;
>  
> -	mutex_lock(&team->lock);
> +	if (mutex_is_locked(&team->lock)){
> +		unsigned long owner, curr = (unsigned long)current;
> +		owner = atomic_long_read(&team->lock.owner);
> +		if (owner != curr)
> +			mutex_lock(&team->lock);
> +		else
> +			flag = false;
> +	}
> +	else{
> +		mutex_lock(&team->lock);
> +	}
>  	__team_port_change_check(port, linkup);
> -	mutex_unlock(&team->lock);
> +	if (flag)
> +		mutex_unlock(&team->lock);

You didn't even run this thru checkpatch, let alone the fact that its
reimplementing nested locks (or trying to) :(

Some of the syzbot reports are not fixed because they are either hard
or because there is a long standing disagreement on how to solve them.
Please keep that in mind.
-- 
pw-bot: cr

