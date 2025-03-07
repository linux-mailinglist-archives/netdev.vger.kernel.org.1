Return-Path: <netdev+bounces-173009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED151A56D72
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F23718918E3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B923A99D;
	Fri,  7 Mar 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsMgt2cU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B5238D22
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364455; cv=none; b=tobcvHF3tnMFmYSadJbCiPxy5rKrQ/Xvavz6q5KquCgolavgT5vBNQlhYYjj5dTBgRjUZNX4NCbDsmAXWv77z9Q/FjBOW9HCCu3BXBHfOuXe4HNNfhzAKxK2NkIzVrq/0mfMpIcxGKHNwPHEUotEkN53PC7pJwr2FrNhWWGWH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364455; c=relaxed/simple;
	bh=7oJXj1/jPOIuPfxk5QMQaAmd4EOU7Boinrb83twt6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRBFA9+KniKUtS2ZZiogNxMwH1o5iubuFR9EJfYoKdNnUrjOV4yPCeFzCh4MjsdkVVu/Lotg7o4mOy2An5Vs2LR0d/kp6a8Ehi8YsRjpB6MyfI8Ko3PaUXxbpTc+Ip5K20yXteCfe1AwNVLKhfyOLCOf/fzCARJJiRUUHxgIgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsMgt2cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23415C4CEE2;
	Fri,  7 Mar 2025 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741364454;
	bh=7oJXj1/jPOIuPfxk5QMQaAmd4EOU7Boinrb83twt6JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UsMgt2cUKNgzpD3D1y/qs83C+bgDZH8ti45od2NwOYBhGbTSxO5uE9gqw88eYiASV
	 qOXaiaht1YguwRSvvDowadBlK6W8UV37zFy8HWp8MQkFDVYQSuN7AUw6vmjT9TmF0u
	 klVtndC1gLjq8keqIjxZoBw7sq01ePFZpvZI6oGh5aFZP6ZII1qCpwvP36w63b1ymx
	 W11XXerLj8/TGlq1ckppBk22aaSrw72m+36tDsVIIxv68y8sAz26enPB/mjqMnoq9Y
	 uGVO4qF04Qaotete/FVbOebw+R7kOeLWLicucuM2FErncq7VktyHpo2TRPgqVibvGw
	 AEf565Bp4fjCQ==
Date: Fri, 7 Mar 2025 08:20:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250307082053.6bd879c9@kernel.org>
In-Reply-To: <ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
	<20250306114355.6f1c6c51@kernel.org>
	<ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 13:35:28 +0100 Jiri Pirko wrote:
> >nvidia's employees patches should go via your tree, in the first place.  
> 
> Why? I've been in Mellanox/Nvidia for almost 10 years and this is
> actually the first time I hit this. I'm used to send patches directly,
> I've been doing that for almost 15+ years and this was never issue.

You probably mostly change the driver together with core, like devlink.
In those cases you can post outside the main stream.

> Where this rule is written down? What changed?

It was always like this, since before I became a maintainer.
I think what happened is Saeed handed the maintainership over
without "writing down" all the rules that we established over
the years.

Obviously he will now probably disagree with me. Because y'all
apparently have no time to review patches, but playing victim
you have all the time in the world for.

There are only two vendors big enough to warrant a special process
(Intel and nVidia), and we make reasonable accommodations (like
the one above) so it's impractical to write all the rules down.

Not to mention the fact that you should perhaps, in an ideal 
world, just try to be a good community member, instead acting
as if we're signing a business contract.

Have a nice weekend.

